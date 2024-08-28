import zipfile

p=r'H:\Downloads\bo_pkgs\ENIQ_Feature_Files_R36A231.zip'
with zipfile.ZipFile(p,'r') as a:
    # with a.open('feature_descriptions') as b:
    a.extractall(r'H:\Downloads\bo_pkgs')
        # print(b.readlines())
# ssh_client = paramiko.SSHClient()
# server = '10.45.206.250'
# user = 'eniq3'
# password = 'Eniq@123'
# ssh_client.set_missing_host_key_policy(paramiko.AutoAddPolicy())
# ssh_client.connect(hostname=server, username=user,password= password)
# print('Connection established successfully')





















# import pyodbc

# serv = "atvts4078.athtem.eei.ericsson.se"

# usr = "dc" 

# passwd = "Dc12#"

# db = "dwhdb"

# prt = "2640"

# drver="SQL Server"

# drivers=['SQL Server', 'MySQL ODBC 5.1 Driver', 'SQL Server Native Client 11.0', 'ODBC Driver 17 for SQL Server', 'PostgreSQL ANSI(x64)', 'PostgreSQL Unicode(x64)', 'PostgreSQL ANSI', 'PostgreSQL Unicode']

# # drver="FreeTDS"
# query="select * from DIM_E_CN"
# # print (datetime.datetime.now())
# # pyodbc.connect
# for d in drivers:
#     try:
#         conn = pyodbc.connect(driver=d, server=serv, database=db,port = prt,uid=usr, pwd=passwd)
#         print(conn)
#     except Exception:
#         print(f'Driver-> {d} is not working\n')
#         continue

# print(conn)

# cursor = conn.cursor()

# cursor.execute(query)

# row = cursor.fetchall()

# print(row)

# conn.close()

# import pymssql as ps

# serv = "atvts4078.athtem.eei.ericsson.se"
# usr = "dc" 
# passwd = "Dc12#"
# db = "dwhdb"
# prt = "2640"
# drver="ODBC Driver 17 for SQL Server"

# drivers=['SQL Server', 'MySQL ODBC 5.1 Driver', 'SQL Server Native Client 11.0', 'ODBC Driver 17 for SQL Server', 'PostgreSQL ANSI(x64)', 'PostgreSQL Unicode(x64)', 'PostgreSQL ANSI', 'PostgreSQL Unicode']

# # drver="FreeTDS"

# query="select * from DIM_E_CN"
# # print (datetime.datetime.now())
# # conn = ps.connect( server=serv,usr, database=db,port = prt, pwd=passwd)
# conn = ps.connect( serv,usr,passwd,db )
# print(conn)
# cursor = conn.cursor()
# cursor.execute(query)
# row = cursor.fetchall()
# print(row)
# conn.close()