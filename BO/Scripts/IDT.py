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

flag='true'

def IDT():
    try:
        app=Application(backend='win32').start(r'C:\Program Files (x86)\SAP BusinessObjects\SAP BusinessObjects Enterprise XI 4.0\win64_x64\InformationDesignTool.exe')
        app.connect(title='Information Design Tool',timeout=20)
        print('Started Successfully')
        flag='true1'
        #time.sleep(5)
        app.kill()
        

    except:
        print('Unable to launch IDT')
        flag='false'
        app.kill()

    return flag
#IDT()