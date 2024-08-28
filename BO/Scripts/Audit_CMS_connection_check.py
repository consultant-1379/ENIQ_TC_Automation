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

def odbc_start():
    flag_fail=0
    conn_name=['BI4_Audit_DSN',"BI4_CMS_DSN"]   
    app = Application().start(r"C:\Windows\system32\odbcad32.exe")
    try:    
        for i in conn_name:
            with UIPath("ODBC Data Source Administrator (64-bit)||Window"):
                OdbcAdmini = app["ODBC Data Source Administrator (64-bit)"]
                find().set_focus()
                time.sleep(2)
                click("||Tab->System DSN||TabItem")
                a = OdbcAdmini.List.select(i)
                click("Configure...||Button")
                click("Configure...||Button")
                with UIPath("ODBC Configuration for SQL Anywhere|| Window"):
                    c = app["ODBC Configuration for SQL Anywhere"]
                    c.Button.click()
                    #time.sleep(2)
                    note = findwindows.find_windows(title="Note")
                    error2 = findwindows.find_windows(title="Error")
                if note:
                    p = app["Note"]
                    conn = p.child_window(
                        title="Connection successful", class_name="Static"
                    ).texts()
                    if "Connection successful" in conn:
                        print(f"Connection {i} is successful")
                        p.OKButton.click()
                        #time.sleep(2)
                        c.OKButton.click()
                        #time.sleep(2)
                        # OdbcAdmini.OKButton.click()
                        flag_fail+=1
                if error2:
                    pk = app["Error"]
                    kk = str(pk.Static2.texts())
                    print(f"Connection Failed and message is {kk}")
                    pk.OKButton.click()
                    #time.sleep(2)
                    c.OKButton.click()
                    #time.sleep(2)    
                # OdbcAdmini.OKButton.click()
        OdbcAdmini.OKButton.click()
        return flag_fail
    except Exception as e:
        print('Error is ',e)
        app.kill()

# odbc_start()
