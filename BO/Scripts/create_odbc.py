import datetime
import time
import importlib
import subprocess

def install_library(library_name):
    try:
        importlib.import_module(library_name)
        print(f'{library_name} is already installed' )
    except ImportError:
        print('Installing Library')
        subprocess.call(f'pip install {library_name}')

libraries=['pywinauto','pywinauto-recorder','cachetools']
for i in libraries:
    install_library(i)

from pywinauto import Application
from pywinauto_recorder.player import *
from pywinauto import findwindows

def odbc_start(server_name: str, dsn_name: str, user_id: str, password: str):
    flag_fail=0

    app=Application().start(r'C:\Windows\system32\odbcad32.exe')
    with UIPath(u"ODBC Data Source Administrator (64-bit)||Window"):
        OdbcAdmini=app['ODBC Data Source Administrator (64-bit)']
        find().set_focus()
        click(u"||Tab->System DSN||TabItem")
        click(u"Add...||Button")
        with UIPath(u"Create New Data Source||Window"):
            find().set_focus()
            b=app[u"Create New Data Source"]
            a=b.ListBox.select(4)
            time.sleep(2)
            b.Finish.click()           
        
        with UIPath(u"ODBC Configuration for SAP IQ||Window"):
            find().set_focus()
            c=app[u"ODBC Configuration for SAP IQ"]
            click(u"Data source name:||Edit").type_keys(f"{dsn_name}")
            click(u"||Tab->Login||TabItem")
            click(u"User ID:||Edit").type_keys(user_id)
            click(u"Password:||Edit").type_keys(password)
            click(u"Action:||ComboBox").select("Connect to a running database on another computer")            
            click(u"Host:||Edit").type_keys(f"{server_name}")
            click(u"Port:||Edit").type_keys(2640)
            click(u"Server name:||Edit").type_keys("dwhdb")
            click(u"Database name:||Edit").type_keys("dwhdb")
            click(u"||Tab->ODBC||TabItem")            
            c.Button0.click()
            time.sleep(2)
            note=findwindows.find_windows(title="Note")
            error2=findwindows.find_windows(title="Error")
        if note:   
            p=app[u"Note"]
            #print(p.print_control_identifiers())
            conn=p.child_window(title="Connection successful", class_name="Static").texts()
            if "Connection successful" in conn:
                print("Connection is successful")
                p.OKButton.click()
                c.OKButton.click()
                OdbcAdmini.OKButton.click()
                flag_fail+=1                
                
        if error2:
            pk=app["Error"]
            kk=str(pk.Static2.texts())
            if "Replace" in kk:
                print(f'Connection {dsn_name} already Exists, replacing the connection.')
                pk.Button0.click()
                OdbcAdmini.OKButton.click()

    return flag_fail                    
 
#odbc_start(serv,dsn,user,password)