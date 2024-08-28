import datetime
import time
import re
from pywinauto import Application
from pywinauto_recorder.player import *
from pywinauto import findwindows



def odbc_start():
    
    server_name='atvts4134.athtem.eei.ericsson.se'
    dsn_name="atvts4134_dwhdb1"
    #dsn_name=server_name.split('.')[0]+f'{str(datetime.datetime.now()).replace(" ", "").replace(":","")}'
    app=Application().start(r'C:\Windows\system32\odbcad32.exe')
    #main_dlg=app['ODBC Data Source Administrator (64-bit)']
    with UIPath(u"ODBC Data Source Administrator (64-bit)||Window"):
        OdbcAdmini=app[u"ODBC Data Source Administrator (64-bit)"]
        find().set_focus()
        click(u"||Tab->System DSN||TabItem")
        click(u"Add...||Button")
        with UIPath(u"Create New Data Source||Window"):
            find().set_focus()
            b=app[u"Create New Data Source"]
            a=b.ListBox.select(8)
            b.Finish.click()
        
        with UIPath(u"ODBC Configuration for SAP IQ||Window"):
            find().set_focus()
            c=app[u"ODBC Configuration for SAP IQ"]
            #print(c.print_control_identifiers())
            click(u"Data source name:||Edit").type_keys(f"{dsn_name}")
            click(u"||Tab->Login||TabItem")
            click(u"User ID:||Edit").type_keys("dcbo")
            click(u"Password:||Edit").type_keys("Dcbo12#")
            click(u"Action:||ComboBox").select("Connect to a running database on another computer")
            
            click(u"Host:||Edit").type_keys(f"{server_name}")
            click(u"Port:||Edit").type_keys(2640)
            click(u"Server name:||Edit").type_keys("dwhdb")
            click(u"Database name:||Edit").type_keys("dwhdb")
            click(u"||Tab->ODBC||TabItem")
            c.Button0.click()
            
    note=findwindows.find_windows(title="Note")
    if note:
            p=app[u"Note"]
            conn=p.child_window(title="Connection successful", class_name="Static").Texts()
            if "Connection successful" in conn:
                p.OKButton.click()
                print("Connection is successful")
                c.OKButton.click()
                #error2=UIPath(u"Error||Window")
                error2=findwindows.find_windows(title="Error")
                if error2:
                    pk=app["Error"]
                    kk=str(pk.Static2.texts())
                    if "Replace" in kk:
                        print(f'Connection {dsn_name} already Exists, replacing the connection.')
                        pk.Button0.click()
                        OdbcAdmini.OKButton.click()
                    else:
                        print('not exists')
                else:
                    print("New Connection created")
                    OdbcAdmini.OKButton.click()    
            else:
                print("Connection not created") 
    else:
        print("Connection failed")
                #  with UIPath(u"Error||Window"):
                #    klm=app[u"Error"]   
                #    connfailed=klm.child_window(title="Connection failed: Specified database not found", class_name="Static").Texts()
                #    if "Connection failed: Specified database not found" in connfailed:
                #         print("connection failed")
                #         klm.OKButton.click()
                #    else:
                #         print("connection passed")
            
   
            
            
    
odbc_start()