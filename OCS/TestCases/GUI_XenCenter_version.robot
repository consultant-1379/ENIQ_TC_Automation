*** Settings ***
Library    SikuliLibrary
Library    Process
Test Setup    Add Needed Image Path
Test Teardown    Close XenCenter

*** Variables ***
${XenCenter_dir}        .\\Resources\\Images

*** Test Cases ***
XenCenter version
    Open XenCenter
    Open XenCenter Help Menu
    Capture Screen
    XenCenter Build Match

*** Keywords ***
Add Needed Image Path
    Add Image Path    ${XenCenter_dir}

Open XenCenter
    Run Process    C:\\Program Files (x86)\\Citrix\\XenCenter\\XenCenter.exe

Open XenCenter Help Menu
    Click    XenCenter_Help.PNG
    Click    XenCenter_About.PNG
    Sleep    5s

XenCenter Build Match
    Wait Until Screen Contain    About_XenCenter_Window.PNG    2
        
Close XenCenter
    Click    XenCenter_File_Menu.PNG
    sleep    5s
    Click    XenCenter_Exit.PNG
