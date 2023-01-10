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

sql=' insert into  ANT_USERS( ID,FIRSTNAME,LASTNAME,USERNAME,USERPASSWORD,EMAIL ) VALUES ( ?,?,?,?,?,?) '

cursor.execute(sql, (2  , 'Sciant','Nakamoto','SCIANT','jeffrey','sciantman@gmail.com'))

cursor.close()