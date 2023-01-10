#######
#Auth: Anan P.
#Email : hs1gab@gmail.com
######
from hdbcli import dbapi
conn = dbapi.connect(
    address="<host>",
    port=<port>,
    user="<user>",
    password="<password>"
)
sql = 'INSERT INTO USERS (ID, USERNAME  , USERPASSWORD , FIRSTNAME , LASTNAME,EMAIL) VALUES (?,?,?,?,?,?)' 
cursor = conn.cursor()
cursor.execute(sql, ( 2, 'sciant','Passw0rd123','Sciant','A.','sciantman@gmail.com'))
cursor.close() 
