*** Settings ***
Library    PyWindowsGuiLibrary
Library    RPA.Desktop.Windows
Library    H:\\Desktop\\robo\\testcases\\tp.py
*** Variables ***
${winscp} =    C:\\Program Files (x86)\\WinSCP\\WinSCP.exe
*** Tasks ***
opening winscp
    open winscp    4116
    # Open From Search    winscp    WinSCP
    # Wait Until Window Present    title:Login    
    # Focus Application Window    title:Login