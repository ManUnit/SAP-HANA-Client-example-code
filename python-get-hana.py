#=======================
#Author : Anan P.
#Email : hs1gab@gmail.com
#========================
from hdbcli import dbapi
conn = dbapi.connect(
       address="<host>",
       port=<port>,
       user="<user>",
       password="<password>"
  )
cursor = conn.cursor()
sql = "select * from USERS"
cursor.execute(sql)
for row in cursor:
     print(row)
cursor.close()

