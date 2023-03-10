'use strict';

var fs = require('fs');
var path = require('path');
var os = require('os');
var net = require('net');

const debug = require('debug')('@sap/hana-client:index');
debug.log = console.info.bind(console);

const name = 'index.js';
var majorVersion = process.versions.node.split('.')[0];

debug('Starting %s', name);

var extensions = {
    'darwin': '.dylib',
    'linux': '.so',
    'win32': '.dll'
};

var db = null;

function isMusl() {
    const output = require('child_process').spawnSync('ldd',['--version']).stderr
    if(output && output.toString('utf8').indexOf('musl') > -1) {
        return true;
    }
    return false;
}

var readPipe = null;

function refPipe() {
    readPipe.ref();
}

function unrefPipe() {
    readPipe.unref();
}

function setupPipe(pipeInfo) {
    if (!db) return;
    var ldb = db;
    if (process.platform === 'win32') {
        readPipe = net.createConnection(pipeInfo["IPCEndpoint"]);
    } else {
        readPipe = net.Socket({fd       : pipeInfo["fd"],
                               readable : true});
    }
    readPipe.unref();
    readPipe.on('data', function(data) {
        ldb.__runCallbacks();
    });
    ldb.__setRefFunctions(refPipe, unrefPipe);
}

/* Parse internal binary result set format created by N-API execute method.
 * Done this way since the performance of creating N-API objects for the result set
 * is very poor due to the N-API interaface itself.
 * See InternalResultSetBuilder comment in internal code for description of
 * the binary format.
 *
 * Usage:
 *   var rs_parser = new InternalResultSetParser(rs_bin);
 *   // at this point rs_parser.numberOfRows, rs_parser.numberOfColumns,
 *   // rs_parser.columnNames and rs_parser.columnTableNames are all available
 *   rows = [];
 *   for(var i = 0; i < rs_parser.numberOfRows; i++) {
 *      rows[i] = [];
 *      for(var j = 0; j < rs_parser.numberOfColumns; j++) {
 *          rows[i][j] = rs_parser.readValue();
 *      }
 *   }
 *   rs_parser.verifyAtEnd();
 */
class InternalResultSetParser {

    // initialize and read header
    constructor(rs_bin) {
        if(!Buffer.isBuffer(rs_bin)) {
            this.throwError("rs_bin is not a Buffer in InternalResultSetParser constructor");
        } else if(rs_bin.length < 16) {
            this.throwError("rs_bin length of "+rs_bin.length+ " is too small in InternalResultSetParser constructor");
        }
        this.m_buffer = rs_bin;
        this.m_curr_offset = 0;
        var length_in_buffer = this.privateReadUInt64();
        //debug("length_in_buffer: " + (Number(length_in_buffer)/1024/1024) + "MB");
        if(this.m_buffer.length != length_in_buffer) {
            this.throwError("rs_bin length of "+this.m_buffer.length+" does not match internal length of "+length_in_buffer+" in InternalResultSetParser constructor");
        }
        this.numberOfRows = this.privateReadUInt32();
        this.numberOfColumns = this.privateReadUInt32();
        if(this.numberOfColumns < 1 || this.numberOfColumns > 65535) {
            this.throwError("Invalid numberOfColumns of "+this.numberOfColumns+" in InternalResultSetParser constructor");
        }

        // read column names
        this.columnNames = [];
        for(var i = 0; i < this.numberOfColumns; i++) {
            var col_name = this.readValue();
            if(typeof col_name !== 'string') {
                this.throwError("Invalid column name type of " + typeof col_name + " in InternalResultSetParser constructor");
            }
            this.columnNames.push(col_name);
        }

        // read column table names
        this.columnTableNames = [];
        for(var i = 0; i < this.numberOfColumns; i++) {
            var col_table_name = this.readValue();
            if(col_table_name !== null && typeof col_table_name !== 'string') {
                this.throwError("Invalid read column table name type of " + typeof col_table_name + " in InternalResultSetParser constructor");
            }
            this.columnTableNames.push(col_table_name);
        }
    };

    throwError(msg) {
        var err = new Error("Error making result set Object: " + msg);
        err.code = -20009;
        err.sqlState = 'HY000';
        throw(err);
    }

    // read the next value
    readValue() {
        const I_RS_NULL    = 1;
        const I_RS_BOOLEAN = 2;
        const I_RS_INT32   = 3;
        const I_RS_DOUBLE  = 4;
        const I_RS_STRING  = 5;
        const I_RS_BINARY  = 6;

        if(this.m_curr_offset >= this.m_buffer_length) {
            this.throwError("InternalResultSetParser.readValue already at end of buffer");
        }
        var type = this.m_buffer.readInt8(this.m_curr_offset++);
        switch(type) {
            case I_RS_NULL:
                return null;
            case I_RS_BOOLEAN:
                var val = this.m_buffer.readInt8(this.m_curr_offset++);
                return val ? true : false;
            case I_RS_INT32:
                var num = this.m_buffer.readInt32LE(this.m_curr_offset);
                this.m_curr_offset += 4;
                return num;
            case I_RS_DOUBLE:
                var num = this.m_buffer.readDoubleLE(this.m_curr_offset);
                this.m_curr_offset += 8;
                return num;
            case I_RS_STRING:
                var len = this.privateReadUInt32();
                var str = this.m_buffer.toString('utf8', this.m_curr_offset, this.m_curr_offset + len);
                this.m_curr_offset += len;
                return str;
            case I_RS_BINARY:
                var len = this.privateReadUInt32();
                var bin = this.m_buffer.subarray(this.m_curr_offset, this.m_curr_offset + len);
                this.m_curr_offset += len;
                return bin;
        };
        this.throwError("InternalResultSetParser.readValue unexpected value type code of "+type);
    }

    // confirm that all data in the binary buffer was read
    verifyAtEnd() {
        if(this.m_curr_offset != this.m_buffer.length) {
            this.throwError("Verify at end failed.  m_curr_offset:" + this.m_curr_offset + " m_buffer.length:" + this.m_buffer.length);
        }
    }

    // internal method used to implement InternalResultSetParser itself
    privateReadUInt32() {
        var val = this.m_buffer.readInt32LE(this.m_curr_offset);
        this.m_curr_offset += 4;
        return val;
    }

    privateReadUInt64() {
        var val;
        if(majorVersion >= 12) {
            val = this.m_buffer.readBigUInt64LE(this.m_curr_offset);
            this.m_curr_offset += 8;
        } else {
            // node 11 and below don't support Buffer.readBigUInt64LE
            // (although some versions of node 10 do support it).
            var low_val = this.privateReadUInt32();
            var high_val = this.privateReadUInt32();
            val = low_val + high_val * 0x100000000;
        }
        return val;
    }

    /* member data:
     *   numberOfRows: number of rows in result set
     *   numberOfColumns: number of columns in result set
     *   columnNames: array of strings of column names
     *   columnTableNames: array of (strings or NULL) of column table names
     * member data that should be considered private:
     *   m_buffer: the entire binary buffer we are parsing
     *   m_curr_offset: current offset of m_buffer for next read
     */
};


// convert rs_bin in InternalResultSet binary format to row array object
// returned by Statement::execute and Connection::execute
function translateFromInternalResultSet(options, rs_bin) {
    var rowsAsArray = false;
    var nestTables = false;
    if(options !== null) {
        if(options.rowsAsArray) {
            rowsAsArray = true;
        }
        if(options.nestTables) {
            nestTables = true;
        }
    }
    var rs_parser = new InternalResultSetParser(rs_bin);
    var column_names = rs_parser.columnNames;
    var column_table_names = rs_parser.columnTableNames;
    var rows = []; // array of all rows
    var number_of_rows = rs_parser.numberOfRows;
    var number_of_columns = rs_parser.numberOfColumns;
    for(var i = 0; i < number_of_rows; i++) {
        var row;
        if(rowsAsArray) {
            row = []; // array of column values
            for(var j = 0; j < number_of_columns; j++) {
                row.push(rs_parser.readValue());
            }
        } else {
            row = {};
            for(var j = 0; j < number_of_columns; j++) {
                if(nestTables && column_table_names[j]) {
                    // there is a key for each table name and the value is
                    // an object with keys column name and values column value
                    if(row[column_table_names[j]] === undefined) {
                        row[column_table_names[j]] = {};
                    }
                    row[column_table_names[j]][column_names[j]] = rs_parser.readValue();
                } else {
                    // each column value has key column name and value column value
                    row[column_names[j]] = rs_parser.readValue();
                }
            }
        }
        rows.push(row);
    }
    rs_parser.verifyAtEnd();
    return rows;
}

// helper for StatementExec and ConnectionExec.
class ArgParser {
    constructor(argv) {
        this.argv = argv;
        this.next_idx = 0;
    }

    // Return the next arg, skipping args that are null or undefined,
    // return null if there is no more args
    getNext() {
        while(this.next_idx < this.argv.length) {
            var next_arg = this.argv[this.next_idx++];
            if(next_arg !== null && next_arg !== undefined) {
                return next_arg;
            }
        }
        return null;
    }

    // return what the next arg will be, but do NOT advance next_idx
    peekNext() {
        var save_next_idx = this.next_idx;
        var peek_arg = this.getNext();
        this.next_idx = save_next_idx;
        return peek_arg;
    }


    // Helper for parseExecuteArgs to resolve ambiguity of first parameter being an
    // object, which could be named bind parameters or could be options (yuck!)
    // Return true if arg is bind parameters, false otherwise
    isBindParameter(arg) {
        if(arg === null) return false;
        if(Array.isArray(arg)) {
            // array can only be bind parameter
            return true;
        }
        if(typeof(arg) !== 'object') {
            // not array or object, cannot be either bind parameter or options
            // (could be a function if it is a valid arg)
            return false;
        }

        // the first arg is of type object, and could be either named bind parameters
        // or options
        var peek_arg = this.peekNext();
        if(peek_arg !== null && typeof(peek_arg) === 'object') {
            // arg after this must be options, so this must be named bind parameters
            return true;
        }
        // still ambiguous, check if it seems to be an options object
        if(arg.nestTables !== undefined ||
           arg.rowsAsArray !== undefined ||
           arg.fastInternalRows !== undefined) {
           // has a valid option key, so assume options
           return false;
        }
        // didn't have any valid option keys, assume named bind parameters
        return true;
    }

    // parse params, options and cbfunc args common to
    // Statement.execute and Connection.execute
    parseExecuteArgs() {
        this.params = null;
        this.options = null;
        this.cbfunc = null;

        var arg = this.getNext();

        // params arg must be first if specified
        if(this.isBindParameter(arg)) {
            this.params = arg;
            arg = this.getNext();
        }

        // options arg must be next if specified
        if(arg !== null && typeof(arg) === 'object' && !Array.isArray(arg)) {
            this.options = arg;
            arg = this.getNext();
        }

        // callback arg must be last if specified
        if(arg !== null && typeof(arg) === 'function') {
            this.cbfunc = arg;
            arg = this.getNext();
        }

        if(arg !== null) {
            // The user passed arguments in the wrong order or the wrong types of args
            // Even on invalid args, it is important to set cbfunc if one is
            // provided so that the cbfunc is called with the error.
            // Otherwise what was intended to be an async method will throw
            // an error that the app probably won't expect, crashing the app.
            while(arg !== null) {
                if(typeof(arg) === 'function') {
                    this.cbfunc = arg;
                    break;
                }
                arg = this.getNext();
            }
            throw(new Error());
        }
    }
}

// A pure JavaScript shim that the user calls instead of an N-API Statement.exec[ute]
// (see dynamicallyAddStmtExecMethod).
// This calls Statement.execInternal and then can use pure JavaScript
// conversion of an intermediate result set to the JavaScript objects returned.
// This eliminates the need to create the result set JavaScript objects inside
// N-API (which can be very expensive).
// see also ConnectionExec which has very similar code.
function StatementExec(stmt, p1, p2, p3) {
    var args = new ArgParser([p1, p2, p3]);
    var parseError;
    try {
        args.parseExecuteArgs();
    } catch(e) {
        parseError = new Error("Invalid parameter for function 'exec[ute]([params][, options][, callback])'");
        parseError.code = -20002;
        parseError.sqlState = 'HY000';
    }

    if(args.cbfunc) {
        // async call, do result set conversion work after Statement.execInternal
        // but before calling the callback function passed in.
        if(parseError) {
            args.cbfunc(parseError);
            return;
        }
        stmt.execInternal(args.params,
                          args.options,
                          function StatementExecCallback(e, rows) {
            if(!e) {
                // convert rows from InternalResultSet format
                // (Note rows can be a Number if stmt does not return a result set)
                if(Buffer.isBuffer(rows)) {
                    try {
                        rows = translateFromInternalResultSet(args.options, rows);
                    } catch(err) {
                        // The intermediate format of the result set could not
                        // be converted to the JavaScript result set.
                        e = err;
                        rows = null;
                    }
                }
            }
            // call callback function passed in
            if(arguments.length == 2) {
                args.cbfunc(e, rows);
            } else {
                // execInternal only provided one parameter to this callback.
                // For example, when there are no results due to DDL statement.
                args.cbfunc(e);
            }
        });
    } else {
        // sync call, just call directly...
        if(parseError) {
            throw parseError;
        }
        var rows = stmt.execInternal(args.params, args.options, null);
        // convert rows from InternalResultSet format
        // (Note rows can be a Number if stmt does not return a result set)
        if(Buffer.isBuffer(rows)) {
            rows = translateFromInternalResultSet(args.options, rows);
        }
        return rows;
    }
}

// Add the exec pure JavaScript method into the stmt object.
// This is called by the N-API portion of the driver
// when creating each Statement object.
function dynamicallyAddStmtExecMethod(stmt) {
    if(stmt.exec == null) {
        stmt.exec = function(p1 = null, p2 = null, p3 = null) {
            return StatementExec(this, p1, p2, p3);
        }
    } // else case should never happen
    if(stmt.execute == null) {
        stmt.execute = function(p1 = null, p2 = null, p3 = null) {
            return StatementExec(this, p1, p2, p3);
        }
    } // else case should never happen
}

// Similar to StatementExec except that this is for Connection.exec
// and there is an extra sql parameter
// When the user calls Connection.exec[ute], this is called.
function ConnectionExec(conn, sql, p2, p3, p4) {
    var args = new ArgParser([p2, p3, p4]);
    var parseError;
    try {
        args.parseExecuteArgs();
    } catch(e) {
        parseError = new Error("Invalid parameter for function 'exec[ute](sql[, params][, options][, callback])'");
        parseError.code = -20002;
        parseError.sqlState = 'HY000';
    }
    if(args.cbfunc) {
        // async call, do result set conversion work after Statement.execInternal
        // but before calling the callback function passed in.
        if(parseError) {
            args.cbfunc(parseError);
            return;
        }
        conn.execInternal(sql,
                          args.params,
                          args.options,
                          function ConnectionExecCallback(e, rows) {
            if(!e) {
                // convert rows from InternalResultSet format
                // (Note rows can be a Number if sql does not return a result set)
                if(Buffer.isBuffer(rows)) {
                    try {
                        rows = translateFromInternalResultSet(args.options, rows);
                    } catch(err) {
                        // The intermediate format of the result set could not
                        // be converted to the JavaScript result set.
                        e = err;
                        rows = null;
                    }
                }
            }
            // call callback function passed in
            if(arguments.length == 2) {
                args.cbfunc(e, rows);
            } else {
                // execInternal only provided one parameter to this callback.
                // For example, when there are no results due to DDL statement.
                args.cbfunc(e);
            }
        });
    } else {
        // sync call, just call directly...
        if(parseError) {
            throw parseError;
        }
        var rows = conn.execInternal(sql, args.params, args.options, null);
        // convert rows from InternalResultSet format
        // (Note rows can be a Number if sql does not return a result set)
        if(Buffer.isBuffer(rows)) {
            rows = translateFromInternalResultSet(args.options, rows);
        }
        return rows;
    }
}

// Add the exec pure JavaScript method into the conn object.
// This is called by the N-API portion of the driver
// when creating each Connection object.
function dynamicallyAddConnExecMethod(conn) {
    if(conn.exec == null) {
        conn.exec = function(sql, p2 = null, p3 = null, p4 = null) {
            return ConnectionExec(this, sql, p2, p3, p4);
        }
    } // else case should never happen
    if(conn.execute == null) {
        conn.execute = function(sql, p2 = null, p3 = null, p4 = null) {
            return ConnectionExec(this, sql, p2, p3, p4);
        }
    } // else case should never happen
}


process.on('exit', function() {
    db.__stopAllWork();
});

debug('Detected os.arch=' + os.arch() + ', '
        + 'process.platform=' + process.platform + ', '
        + 'process.arch=' + process.arch + ', '
        + 'process.version=' + process.version );

if (process.platform === 'win32' && process.arch != 'x64') {
    debug('ERROR: On Windows, this driver only supports the x64 architecture. ' +
        'Your node process is: ' + process.arch );
    throw new Error('On Windows, this driver only supports the x64 architecture. ' +
        'Your node process is: ' + process.arch );
}

if (majorVersion < 8) {
    throw new Error("Node version " + process.version + " is unsupported by @sap/hana-client. Only versions >=8 are supported");
}

// Look for prebuilt binary and DBCAPI based on platform
var pb_subdir = null;
var dbcapi_name = 'libdbcapiHDB';
if (process.platform === 'linux') {
    if ( isMusl() ) {
        pb_subdir = 'linuxx86_64_alpine-gcc6';
    } else if (process.arch === 'x64') {
        pb_subdir = 'linuxx86_64-gcc48';
    } else if (process.arch.toLowerCase().indexOf('ppc') != -1 && os.endianness() === 'LE') {
        pb_subdir = 'linuxppc64le-gcc48';
    } else {
        pb_subdir = 'linuxppc64-gcc48';
    }

} else if (process.platform === 'win32') {
    pb_subdir = 'ntamd64-msvc2010';
} else if (process.platform === 'darwin') {
    pb_subdir = 'darwinintel64-xcode7';
}
var dbcapi_env = 'DBCAPI_API_DLL';

var modpath = path.dirname(__dirname);
var pb_path = path.join(modpath, 'prebuilt', pb_subdir);
var dbcapi = path.join(pb_path, dbcapi_name + extensions[process.platform]);
try {
    fs.statSync(dbcapi);
} catch (ex) {
    // No binary!
    debug(ex.message);
    debug("No DBCAPI interface driver found for platform: '" +
        process.platform + "', arch: '" + process.arch +
        "', endianness: '" + os.endianness() + "' for Node version: '" +
        process.version + "'");
    debug("You need to set the " + dbcapi_env + " environment variable to point to " +
        dbcapi_name + extensions[process.platform] + " for this platform.");
    throw new Error('`' + dbcapi + '` is missing.');
}

// Remove unrelated native platform libraries
const removeDirectory = function (dir) {
    if (fs.existsSync(dir)) {
        fs.readdirSync(dir).forEach((file, index) => {
            const curPath = path.join(dir, file);
            if (fs.lstatSync(curPath).isDirectory()) { // recurse
                removeDirectory(curPath);
            } else { // delete file
                fs.unlinkSync(curPath);
            }
        });
        fs.rmdirSync(dir);
    }
};
const getSubDirs = function (dir) {
    const isDirectory = source => fs.lstatSync(source).isDirectory();
    const getDirectories = source =>
        fs.readdirSync(source).map(name => path.join(source, name)).filter(isDirectory);
    return getDirectories(dir);
};
if (process.env['HDB_NODE_PLATFORM_CLEAN'] === '1') {
    var pb_path_all = getSubDirs(path.join(modpath, 'prebuilt'));
    pb_path_all.forEach((pbPath) => {
        if (pbPath !== pb_path) {
            try {
                removeDirectory(pbPath);
            } catch (ex) {
                debug(ex.message);
                debug("Failed to remove unrelated native platform libraries in '" + pbPath + "'.");
            }
        }
    });
} else if (process.env['HDB_NODEJS_INSTALL_PLATFORMS']) {
    var keep = process.env['HDB_NODEJS_INSTALL_PLATFORMS'].split(',').map(name => path.join(modpath, 'prebuilt', name));
    var pb_path_all = getSubDirs(path.join(modpath, 'prebuilt'))
    var pb_count = pb_path_all.length;
    pb_path_all.forEach((pbPath) => {
        if (keep.indexOf(pbPath) < 0) {
            try {
                removeDirectory(pbPath);
                pb_count -= 1;
            } catch (ex) {
                debug(ex.message);
                debug("Failed to remove unrelated native platform libraries in '" + pbPath + "'.");
            }
        }
    });
    if (pb_count <= 0) {
        debug("WARNING: Environment variable HDB_NODEJS_INSTALL_PLATFORMS did not name any valid platforms. All native platform libraries have been removed.");
    }
}

// Found dbcapi
process.env[dbcapi_env] = dbcapi;

// Now find driver
var default_driver_file = 'hana-client';
var driver_file = default_driver_file;

if (process.env['HDB_NODE_NO_NAPI_DRIVER'] === '1') {
    // Check if there is a node-version-specific driver
    // Fall back on hana-client.node
    var v = process.version;
    var match = v.match(/v([0-9]+)\.([0-9]+)\.[0-9]+/);
    driver_file += '_v' + match[1];
    if (match[1] + 0 == 0) {
        driver_file += '_' + match[2];
    }
}
var driver_path = path.join(pb_path, driver_file + '.node');

try {
    debug("Checking for existence of "+driver_path);
    fs.statSync(driver_path);
} catch (ex) {
    debug("Did not find "+driver_path);
    driver_path = path.join(pb_path, default_driver_file + '.node');
    try {
        debug("Checking for existence of "+driver_path);
        fs.statSync(driver_path);
    } catch (ex) {
        debug("No prebuilt node driver found for platform: '" +
            process.platform + "', arch: '" + process.arch +
            "', endianness: '" + os.endianness() + "' for Node version: '" +
            process.version + "'");
    }
}

// Try loading
// 1. User's build
// 2. Prebuilt

debug('Attempting to load Hana node-hdbcapi driver');

var userbld_driver_path = path.join(modpath, 'build', 'Release', 'hana-client.node');
debug('... Trying user-built copy...');
try {
    debug('... Looking for user-built copy in ' + userbld_driver_path + ' ... ');
    fs.statSync(userbld_driver_path);
    debug('Found.');
    try {
        debug('... Attempting to load user-built copy... ');
        db = require(userbld_driver_path);
        debug('Loaded.');
    } catch (ex) {
        debug(ex.message);
        debug('Could not load: User-built copy did not satisfy requirements.');
        throw ex;
    }
} catch (ex) {
    debug('Not found.');
}

if (db === null) {
    debug('... Trying prebuilt copy...');
    try {
        debug('... Looking for prebuilt copy in ' + driver_path + ' ... ');
        db = require(driver_path);
        debug('Loaded.');
    } catch (ex) {
        debug(ex.message);
        debug('Could not load: Prebuilt copy did not satisfy requirements.');
        debug("Could not load modules for Platform: '" +
            process.platform + "', Process Arch: '" + process.arch +
            "', and Version: '" + process.version + "'");
        throw ex;
    }
}

db.__loadDbcapi(dbcapi);
var pipeInfo = db.__getPipe();
setupPipe(pipeInfo);
db.__setAddFnsThatAddMethodsToObjects(dynamicallyAddConnExecMethod,
                                      dynamicallyAddStmtExecMethod);
if (db !== null) {
    debug('Success.');
}
module.exports = db;
