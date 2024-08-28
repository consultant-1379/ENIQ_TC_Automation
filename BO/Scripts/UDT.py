import subprocess
import importlib
import time

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

from pywinauto import Application, findwindows
from pywinauto_recorder.player import *

def udt(server_name: str, password: str):
        try:
                app=Application(backend='win32').start(r'C:\Program Files (x86)\SAP BusinessObjects\SAP BusinessObjects Enterprise XI 4.0\win64_x64\designer.exe').connect(title="User Identification", class_name="#32770",timeout=15)
                app.UserIdentification.Edit0.set_edit_text(u'')
                app.UserIdentification.Edit0.type_keys(f"{server_name}:6400")
                app.UserIdentification.Edit2.set_edit_text(u'')
                app.UserIdentification.Edit2.type_keys('Administrator')
                app.UserIdentification.Edit3.type_keys(f"{password}")
                time.sleep(2)
                app.UserIdentification.Button1.click()
                server=(f"@{server_name}:6400")
                with UIPath(f"Universe Design Tool - [Administrator - {server}]||Window"):
                        time.sleep(2)
                        popup1=findwindows.find_windows(title="Important Announcement")
                        if popup1:
                                a=app[u"Important Announcement"]
                                find().set_focus()
                                a.CheckBox.check()
                                a.OKButton.click()
                        time.sleep(2)        
                        popup2=findwindows.find_windows(title="Data Protection")
                        if popup2:
                                a=app[u"Data Protection"]
                                find().set_focus()
                                a.CheckBox.check()
                                a.OKButton.click()   
                        time.sleep(2)        
                        popup3=findwindows.find_windows(title="Quick Design Wizard - Welcome Screen")
                        if popup3:
                                a=app[u"Quick Design Wizard - Welcome Screen"]
                                find().set_focus()
                                a.CheckBox.uncheck()
                                a.Button2.click()             
                                #print(a.print_control_identifiers())
                        with UIPath(u'Menu Bar||ToolBar'):
                                time.sleep(2)
                                click(u"Help||MenuItem")
                                
                with UIPath(u"Context||Menu"):
                        click(u"||MenuItem#[2,0]",click_count=2,wait_ready=True) 
                                                
                with UIPath(u"About Universe Design Tool||Window"):
                        b=app[u"About Universe Design Tool"]
                        tool_ver=b.Static.texts()
                        if 'Universe Design Tool 4.3' in tool_ver:
                                print(tool_ver)
                                b.OKButton.click()
                                app.kill()
                        else:
                                print(f'4.3 version not found, installed version is {tool_ver}')
                                b.OKButton.click()
                                app.kill()
                                   
                        return tool_ver      
        except Exception as e:
                print('Error is ',e)
                app.kill()

#udt(server_name,password)