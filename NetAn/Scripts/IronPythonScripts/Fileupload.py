import os
import glob
from struct import pack
from typing_extensions import Self
from pywinauto.application import Application
from pywinauto.keyboard import send_keys
from pywinauto import keyboard as kb
from pywinauto.findwindows import find_elements
from pywinauto.application import WindowSpecification
import time
import pywinauto

def winscpFileUpload(fileName, pathInLocal, pathInServer):
    app=Application().start(cmd_line=r"C:\Program Files (x86)\WinSCP\WinSCP.exe")
    app.Login.set_focus()
	time.sleep(10)	  
    win=app.TLoginDialog
    time.sleep(10)
    win.ComboBox3.select("SFTP")
    win.Edit2.type_keys("Dcuser_123")
    win[u'Edit3'].type_keys("dcuser")
    win[u'Edit4'].type_keys("10.44.91.9")
    win[u'Edit1'].type_keys("22")
    win.Login.click()
    time.sleep(2)
    app.Warning.No.click()
    time.sleep(5)
    app.Authentication.Continue.click()
    time.sleep(10)
    win1 = app.TScpCommanderForm
    win1.set_focus()
    send_keys("^O")
    kb.send_keys(pathInLocal)
    send_keys('{ENTER}')
    time.sleep(2)
    send_keys('^%f')
    time.sleep(2)
    kb.send_keys(fileName)
    send_keys('{ENTER}')
    time.sleep(3)
    send_keys('{DOWN}')
    time.sleep(3)
    send_keys('{F5}')
    time.sleep(2)
    kb.send_keys(pathInServer)
    send_keys('{ENTER}')
    time.sleep(10)
    app.Confirm.Yes.click()
    time.sleep(10)
    send_keys('%{F4}')
    time.sleep(5)
    app.Confirm.Yes.click()

def filePasteAndActivateInterface():
    app=Application().start(cmd_line=r"C:\Program Files (x86)\WinSCP\WinSCP.exe")
    app.Login.set_focus()
    win=app.TLoginDialog
    time.sleep(10)
    win.ComboBox3.select("SFTP")
    win.Edit2.type_keys("Dcuser_123")
    win[u'Edit3'].type_keys("dcuser")
    win[u'Edit4'].type_keys("10.44.91.9")
    win[u'Edit1'].type_keys("22")
    win.Login.click()
    time.sleep(2)
    app.Warning.No.click()
    time.sleep(10)
	app.Authentication.Continue.click()					   
    win1 = app.TScpCommanderForm
    win1.set_focus()
    # send_keys("^O")
    # kb.send_keys(pathInLocal)
    # send_keys('{ENTER}')
    # time.sleep(2)
    # send_keys('^%f')
    # time.sleep(2)
    # kb.send_keys(fileName)
    # send_keys('{ENTER}')
    # time.sleep(3)
    # send_keys('{DOWN}')
    # time.sleep(3)
    # send_keys('{F5}')
    # time.sleep(2)
    # kb.send_keys(pathInServer)
    send_keys('{ENTER}')
    time.sleep(10)
    send_keys('^P')
    time.sleep(3)
    kb.send_keys('Dcuser_123')
    send_keys('{ENTER}')
    time.sleep(2)
    kb.send_keys('cd{SPACE}/eniq/sw/installer/')
    send_keys('{ENTER}')
    time.sleep(2)
    kb.send_keys('./activate_interface{SPACE}-o{SPACE}eniq_oss_1{SPACE}-t{SPACE}CV_INFORMATION_STORE')
    send_keys('{ENTER}')
    #time.sleep(2)
    #send_keys('exit') 
    
def tpi_file_loc():
    myhost = os.getenv('username')
    downloadspath= r'C:\Users\Administrator\Downloads'
    print(downloadspath)
    list_of_files = glob.glob(downloadspath+"\*.tpi") 
    latest_file = max(list_of_files, key=os.path.getctime)
    q= latest_file.split('\\')[-1]
    return q

def login_to_putty():
   app=Application().start(cmd_line=r"C:\Program Files (x86)\WinSCP\WinSCP.exe")
   app.Login.set_focus()
   win=app.TLoginDialog
   time.sleep(10)
   win.ComboBox3.select("SFTP")
   win.Edit2.type_keys("Dcuser_123")
   win[u'Edit3'].type_keys("dcuser")
   win[u'Edit4'].type_keys("10.44.91.9")
   win[u'Edit1'].type_keys("22")
   win.Login.click()
   time.sleep(2)
   #app.Warning.No.click()
   time.sleep(10)
   win1 = app.TScpCommanderForm
   win1.set_focus()
   send_keys('{ENTER}')
   time.sleep(10)
   send_keys('^P')
   time.sleep(3)
   kb.send_keys('Dcuser_123')
   send_keys('{ENTER}')
   time.sleep(2)
   kb.send_keys('cd{SPACE}/eniq/data/pmdata/')
   send_keys('{ENTER}')