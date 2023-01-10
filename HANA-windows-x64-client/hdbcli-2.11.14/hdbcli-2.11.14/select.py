from hdbcli import dbapi
conn = dbapi.connect(
    address="hxehost",
    #port=39015,  ## SYSTEMDB
    port=39044,   ## ANT 
    user="SYSTEM",
    password="TBP@dmin8888"
)
cursor = conn.cursor() 

#  select * from public.tables 

cursor.execute("select * from ANT_USERS")
for row in cursor:
        print(row)
cursor.close()