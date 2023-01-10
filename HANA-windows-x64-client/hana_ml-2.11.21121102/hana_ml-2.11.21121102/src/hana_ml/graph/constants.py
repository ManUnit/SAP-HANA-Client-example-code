"""
This module contains the HANA Graph variables and reserved words
"""

EDGE_ID = "EDGE_ID"
G_SCHEMA = "SCHEMA_NAME"
GWS_NAME = "WORKSPACE_NAME"
V_SCHEMA = "VERTEX_SCHEMA_NAME"
V_TABLE = "VERTEX_TABLE_NAME"
E_SCHEMA = "EDGE_SCHEMA_NAME"
E_TABLE = "EDGE_TABLE_NAME"
EDGE_SOURCE = "EDGE_SOURCE_COLUMN_NAME"
EDGE_TARGET = "EDGE_TARGET_COLUMN"
EDGE_KEY = "EDGE_KEY_COLUMN_NAME"
VERTEX_KEY = "VERTEX_KEY_COLUMN_NAME"
CREATE_TIME_STAMP = "CREATE_TIMESTAMP"
USER_NAME = "USER_NAME"
IS_VALID = "IS_VALID"
COLUMN_NAME = "COLUMN_NAME"

# Directions
DIRECTION_INCOMING = "INCOMING"
DIRECTION_OUTGOING = "OUTGOING"
DIRECTION_ANY = "ANY"
DIRECTIONS = [DIRECTION_INCOMING, DIRECTION_OUTGOING, DIRECTION_ANY]
DEFAULT_DIRECTION = DIRECTION_OUTGOING
