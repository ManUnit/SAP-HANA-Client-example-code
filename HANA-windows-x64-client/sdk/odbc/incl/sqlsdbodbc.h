
/*!
  @file           sqlsdbodbc.h
  @ingroup        ODBC
  @brief          extra attributes (SAP HANA ODBC driver specific)

  \if EMIT_LICENCE

  ========== licence begin  SAP

  Copyright (c) 2001-2017 SAP AG

  All rights reserved.

  ========== licence end

  \endif
  */
#ifndef ODBC_SBDOCBC_H
#define ODBC_SBDOCBC_H

/* enumerations for attribute values */

/* attributes for SQL_COMPONENT */
enum sql_sdb_component {
    SQL_COMPONENT_CAL = 0,
    SQL_COMPONENT_CPC,
    SQL_COMPONENT_CON,
    SQL_COMPONENT_DOM,
    SQL_COMPONENT_LOA,
    SQL_COMPONENT_ODB,
    SQL_COMPONENT_QUE,
    SQL_COMPONENT_SQL,
    SQL_COMPONENT_TPL,
    SQL_COMPONENT_UTI,
    SQL_COMPONENT_XCI
};

/* attributes for SQL_MODE */
enum sql_sdb_sqlmode {
    SQL_SQLMODE_EMPTY = 0,
    SQL_SQLMODE_INTERNAL,
    SQL_SQLMODE_DB2,
    SQL_SQLMODE_ANSI,
    SQL_SQLMODE_ORACLE,
    SQL_SQLMODE_SAPR3};

/* attributes for SQL_ATTR_AGGREGATE_TYPES (data types for expressions like SUM, AVG, etc.) */
enum sql_sdb_aggregatetypes {
    SQL_AGGREGATETYPES_FLOAT = 0,   /* always float numbers */
    SQL_AGGREGATETYPES_ORIGIN };    /* data type matching to the original column (MS-SQL like) */

/* attributes for SQL_ATTR_CONNECTTYPES (cmp. connect property CONNECTTYPE of SQLDBC) */
/* Reserved for internal use only */
enum sql_sdb_connecttypes {
    SQL_CONNECTTYPES_OLTP = 0,   /* OLTP - The connection is an OLTP connection. (default) */
    SQL_CONNECTTYPES_LVC,        /* LVC  - The connection is used for liveCache procedure calls. */
    SQL_CONNECTTYPES_DBANA };    /* DBAnalyzer - connect to a particular task */

/* trace callback support (for internal use only) */

/* Constants for the level passed to the trace callback (matches list in SQLDBC_Types.h) */
enum ODBC_TraceLevel {
    ODBC_TRACE_LEVEL_NONE    = 0x0,      /* alias for OFF */
    ODBC_TRACE_LEVEL_FATAL   = 0x1,
    ODBC_TRACE_LEVEL_ERROR   = 0x2,
    ODBC_TRACE_LEVEL_WARNING = 0x3,
    ODBC_TRACE_LEVEL_INFO    = 0x4,
    ODBC_TRACE_LEVEL_DEBUG   = 0xF       /* highest trace level, alias for ON */
};

typedef void (*ODBC_TraceCallback) (const char *category, int level, const char *message, size_t size, void *context);

/* **************************************** */

#define SQL_CONNECT_OPT_DRVR_START 1000

/* driver defined connect options.
*/

/* Reserved for internal use only */
#define SQL_ATTR_SQLMODE         SQL_CONNECT_OPT_DRVR_START+2

/* Reserved for internal use only */
#define SQL_ATTR_COMPONENT       SQL_CONNECT_OPT_DRVR_START+3

/* Read only connect attribute to check for NI connections */
#define SQL_IS_NI_CONNECTION SQL_CONNECT_OPT_DRVR_START+9

/* Reserved for internal use only */
#define SQL_CANCEL_ROUTER_STRING SQL_CONNECT_OPT_DRVR_START+10

/* Reserved for internal use only */
#define SQL_ATTR_SESSION_TIMEOUT SQL_CONNECT_OPT_DRVR_START+11

/* Reserved for internal use only */
#define SQL_ATTR_PRODUCER        SQL_CONNECT_OPT_DRVR_START+12

/* Codepage used for UCS2<->ASCII conversion. Codepage is selected from the DB.
   In Windows: default codepage is active codepage of the client.
   In non-Windows: default codepage is WINDOWS-1252 (contains Euro-symbol). */
/* a codepage is valid for all(!) connections of the affected driver. If
   SQLSetConnectAttr is called a second time with a different codepage,
   the driver could crash, if a conversion is simultaneously running. */
#define SQL_ATTR_CODEPAGE   SQL_CONNECT_OPT_DRVR_START+13

/* for this attribute SQL_TRUE is returned, if the DB supports Unicode,
   otherwise SQL_FALSE */
#define SQL_ATTR_UNICODEDB   SQL_CONNECT_OPT_DRVR_START+14

/* encryption for the connection. 0 means no encryption. */
#define SQL_ATTR_ENCRYPT   SQL_CONNECT_OPT_DRVR_START+15

/* Aggregate types for expressions (AVG, SUM, etc.). 1 means like MS-SQL
   i.e. SUM(INTEGER) is of type INTEGER (otherwise it would be FLOAT)
   */
#define SQL_ATTR_AGGREGATE_TYPES   SQL_CONNECT_OPT_DRVR_START+16

/* The character representing non-convertible UCS2 characters in ASCII strings.
   This property only works if property CODEPAGENAME is set.
   If this property is not set, a non-convertible UCS2 character causes an conversion error
   when converting to ASCII.
   Setting this character to '\0' disables this feature (default setting is '?'). */
#define SQL_ATTR_DEFAULTMAPCHAR    SQL_CONNECT_OPT_DRVR_START+17

/* Reserved for internal use only */
#define SQL_ATTR_CONNECTTYPES   SQL_CONNECT_OPT_DRVR_START+18

#define SQL_ATTR_ENCRYPTION_OFF   0    /* no encryption */
#define SQL_ATTR_ENCRYPTION_SSL   1    /* SSL */

/* Reserved for internal use only */
#define SQL_DEFAULT_SESSION_TIMEOUT  ((UDWORD) (1 << 30))

/* Check if servernode of previous SQLDriverConnect is a SAP router string */
#define SQL_DIAG_IS_NI_CONNECTION  (1002)

/* **************************************** */

/* new extensions of SQLDBC based ODBC */

/* Reserved for internal use only */
#define SQL_SQLDBC_CONNECTION_HANDLE   (SQL_CONNECT_OPT_DRVR_START+10000)

/* Reserved for internal use only */
#define SQL_SQLDBC_ENVIRONMENT_HANDLE  (SQL_CONNECT_OPT_DRVR_START+10001)

/* input parameters with SQL_C_CHAR are handled as UTF8 */
#define SQL_SQLDBC_CHAR_AS_UTF8        (SQL_CONNECT_OPT_DRVR_START+10002)

/* client info (sent via SQLDBC to the kernel) */
#define SQL_SQLDBC_SET_CLIENTINFO_KEY        (SQL_CONNECT_OPT_DRVR_START+10003)
#define SQL_SQLDBC_SET_CLIENTINFO_VALUE      (SQL_CONNECT_OPT_DRVR_START+10004)
#define SQL_SQLDBC_GET_CLIENTINFO_VALUE      (SQL_CONNECT_OPT_DRVR_START+10005)

/* boolean parameter to tell the ODBC driver whether SQL catalogs are
   visible or not. The default is TRUE what means that the catalog is visible. */
#define SQL_SQLDBC_SHOW_CATALOGS        (SQL_CONNECT_OPT_DRVR_START+10006)

/* boolean parameter to tell the ODBC driver to report BINTEXT fields
   as either NCLOB (default, TRUE) or LONG VARBINARY (FALSE) */
#define SQL_SQLDBC_BINTEXT_IS_NCLOB       (SQL_CONNECT_OPT_DRVR_START+10007)

/* Encoding of SQL_C_CHAR data */
#define SQL_SQLDBC_CHAR_AS_CESU8          (SQL_CONNECT_OPT_DRVR_START+10008)

/* switch for the spatial type returned for ST_POINT / GT_GEOMETRY columns
 *   2 = SQL_TYPE_DST_GEOMETRY (0x7474)                     [ODBC DEFAULT]
 *   1 = SQL_TYPE_ST_POINT (75) / SQL_TYPE_ST_GEOMETRY (74)
 *   0 = SQL_VARBINARY (-3)                                 [SQLDBC DEFAULT]
 */
#define SQL_SQLDBC_SPATIALTYPES         (SQL_CONNECT_OPT_DRVR_START+10009)

/* GIS types */
#define SQL_TYPE_ST_POINT     75
#define SQL_TYPE_ST_GEOMETRY  74
#define SQL_TYPE_DST_GEOMETRY 0x7474   /* Default type for ST_POINT and ST_GEOMETRY */

#define SQL_SQLDBC_PROXY_HOST           (SQL_CONNECT_OPT_DRVR_START+10010)
#define SQL_SQLDBC_PROXY_PORT           (SQL_CONNECT_OPT_DRVR_START+10011)
#define SQL_SQLDBC_PROXY_USERID         (SQL_CONNECT_OPT_DRVR_START+10012)
#define SQL_SQLDBC_PROXY_PASSWORD       (SQL_CONNECT_OPT_DRVR_START+10013)

#define SQL_SQLDBC_PROXY_SCP_ACCOUNT    (SQL_CONNECT_OPT_DRVR_START+10015)

/* Define a WebSocket URL and use the WebSocket protocol */
#define SQL_SQLDBC_WEBSOCKETURL         (SQL_CONNECT_OPT_DRVR_START+10017)

/*
 * SQL_ATTR_TRACE_CALLBACK           // Callback method to receive trace messages
 * SQL_ATTR_TRACE_CALLBACK_CONTEXT   // A context passed to the callback each time (optional)
 * SQL_ATTR_TRACE_CALLBACK_OPTIONS   // A string describing the trace configuration options
 */
#define SQL_ATTR_TRACE_CALLBACK             (SQL_CONNECT_OPT_DRVR_START+10018)
#define SQL_ATTR_TRACE_CALLBACK_CONTEXT     (SQL_CONNECT_OPT_DRVR_START+10019)
#define SQL_ATTR_TRACE_CALLBACK_OPTIONS     (SQL_CONNECT_OPT_DRVR_START+10020)

/*
 * Driver defined statement attributes.
 */

/*
 * Retreive the next print line from the SQLSCRIPT_PRINT library.
 *
 * SQLGetStmtAttr(W) will return SQL_NO_DATA when no lines remain.
 *
 * If the provided buffer is not large enough to store the line, it will be
 * truncated in the usual manner. It is not possible to repeat the call to
 * retrieve the untruncated line. To avoid truncation, provide a buffer with
 * sufficient space to store 32767 characters.
 */
#define SQL_ATTR_PRINTLINE              (SQL_CONNECT_OPT_DRVR_START+11000)

/*
 * Retrieves cpu-time, memory-usage and processing time on the server side
 * for each stages like Prepare(), Execute() and Fetch() separately
 *
 * SQL_ATTR_SERVER_CPU_TIME          // total CPU processing time in
 *                                   // microseconds on the server side not
 *                                   // including network communication
 *
 * SQL_ATTR_SERVER_MEMORY_USAGE      // memory usage on the server side in bytes
 *
 * SQL_ATTR_SERVER_PROCESSING_TIME   // elapsed processing time in microseconds
 *                                   // on the server side not including network
 *                                   // communication
 *
 * If the Statement has been prepared with SQLPrepare but not executed, these
 * values are for the prepare.
 *
 * If the Statement has been executed with SQLExecute but not fetched, these
 * values are only for the most recent execute
 *
 * If the Statement has been executed with SQLExecDirect but not fetched,
 * these values are for the ExecDirect only
 *
 * If the Statement has been fetched, these values are for the fetches since
 * the beginning of the current result set.
 *
 * Note that the execute includes fetch time for the first few rows, but if
 * fetch requests to the server are required when fetching more rows requires
 * additional server requests
 *
 * If SQLMoreResults is called, these values are reset for the new result set
 *
 */
#define SQL_ATTR_SERVER_CPU_TIME        (SQL_CONNECT_OPT_DRVR_START+11001)

#define SQL_ATTR_SERVER_MEMORY_USAGE    (SQL_CONNECT_OPT_DRVR_START+11002)

#define SQL_ATTR_SERVER_PROCESSING_TIME (SQL_CONNECT_OPT_DRVR_START+11003)

/*
 * SQL_ATTR_BYTES_SENT               // The total number of bytes (after compression,
 *                                   // if COMPRESS is on) sent to the server
 * SQL_ATTR_BYTES_RECEIVED           // The total number of bytes (after compression,
 *                                   // if COMPRESS is on) received from the server
 */
#define SQL_ATTR_BYTES_SENT             (SQL_CONNECT_OPT_DRVR_START+11004)

#define SQL_ATTR_BYTES_RECEIVED         (SQL_CONNECT_OPT_DRVR_START+11005)

/*
 * SQL_ATTR_STMT_PACKET_SIZE         // A statement attribute used to set the network
 *                                   // packet size for the statement
 */
#define SQL_ATTR_STMT_PACKET_SIZE       (SQL_CONNECT_OPT_DRVR_START+11006)

/*
 * SQL_ATTR_STMT_HASH                // An MD5 hash of the last prepared or executed statement
 *                                   // Matches STATEMENT_HASH value in M_SQL_PLAN_CACHE
 *
 */

#define SQL_ATTR_STMT_HASH              (SQL_CONNECT_OPT_DRVR_START+11007)

#endif /* of ODBC_SBDOCBC_H */
