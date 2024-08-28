*** Settings ***
Library    SeleniumLibrary
Library    SikuliLibrary
Test Setup    Add Needed Image Path
Resource    ../Resources/Variables/OCS_Variables.robot


*** Variables ***
${Img_DIR}       C:\\Users\\Administrator\\PycharmProjects\\OCS\\Images


*** Test Cases ***
Launching client applications from Citrix StoreFront URL
    Launch Citrix StoreFront webpage
    


*** Keywords ***
Add Needed Image Path
    Add Image Path    ${Img_DIR}

Launch Citrix StoreFront webpage
    Open Browser    https://${CCSFQHN}/Citrix/StoreNameWeb   chrome
    Maximize Browser Window
    Sleep    3s
    Click Button    xpath://*[@id="details-button"]
    Click Link    xpath://*[@id="proceed-link"]
    Sleep    3s
    #Click Link    xpath://*[@id="protocolhandler-welcome-installButton"]
    Click    Detect_Citrix_Workspace_App.PNG
    Sleep    3s
    Click    Citrix_Workspace_App_Open_Launcher_PopUp.PNG
    #Click Link    xpath://*[@id="protocolhandler-detect-alreadyInstalledLink"]
    #Mouse Move    Citrix_Workspace_App_Move_Mouse_Cursor.PNG
    Sleep    3s
    Click    Citrix_Workspace_App_Already_Installed.PNG
    Sleep    3s
    SeleniumLibrary.Input Text    id:username    ATHTEM24\\Administrator
    SeleniumLibrary.Input Text    id:password    shroot@123
    Sleep    3s

Enter Username and Password
    SikuliLibrary.Input Text    Ctx_Lic_Mgr_Username_Input.PNG    Administrator
    SikuliLibrary.Input Text    Ctx_Lic_Mgr_Password_Input.PNG    ${CCSPassword}
    sleep    1s

Signin to the console
    Click    Ctx_Lic_Mgr_Signin_Button.PNG
    Sleep    30s

Close the popup Window
    Click    Ctx_Lic_Mgr_Close_Popup_Button.PNG
    sleep    5s

Verification of License Server version
    Screen Should Contain    Ctx_Lic_Mgr_Version_11_17_2_0_BUILD_37000.PNG