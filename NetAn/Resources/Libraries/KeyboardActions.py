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
import pyautogui
import pyperclip

def pressKeyboardButton(button):
    #send_keys(button)
    kb.send_keys(button)
    
def openSearchPrompt():
    pyautogui.hotkey('ctrl','f')
    
def enterText(text):
    kb.send_keys(text)
    
def clickbuttonMultipleTimes(button,n):
    ran = int(n)
    for i in range(ran):
        send_keys(button)
        time.sleep(2)
        
def pasteTheText(text):
    pyperclip.copy(text)
    time.sleep(5)
    pyautogui.hotkey('ctrl','v')
    time.sleep(2)
    
def copyAndPasteOutput():
    pyautogui.hotkey('ctrl','a','c')
    f = open("SpotfireOutput.txt","w+")
    f.write(pyperclip.paste())
    f.close()
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    