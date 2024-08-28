*** Settings ***
Library    SeleniumLibrary
Library    SikuliLibrary
Test Setup    Add Needed Image Path
Resource    ../Resources/Variables/OCS_Variables.robot

*** Variables ***
${Image_DIR}        .\\Resources\\Images

*** Test Cases ***
Launching BO Client Designer applications from Citrix StoreFront webpage
    Launch Citrix StoreFront webpage
    Enter Username and Password
    Signin to the Citrix StoreFront webpage
    Go to Apps tab
    Launch BO Designer App
    Close BO Designer App
    Logout from Citrix StoreFront webpage

*** Keywords ***
Add Needed Image Path
    Add Image Path    ${Image_DIR}

Launch Citrix StoreFront webpage
    Open Browser    https://${CCSFQHN}/Citrix/StoreNameWeb   chrome
    Maximize Browser Window
    Sleep    3
    Click Button    xpath://*[@id="details-button"]
    Click Link    xpath://*[@id="proceed-link"]
    Sleep    3
    Click    Detect_Citrix_Workspace_App.PNG
    Sleep    3
    Click    Citrix_Workspace_App_Open_Launcher_PopUp.PNG
    Sleep    3
    Click    Citrix_Workspace_App_Already_Installed.PNG
    Sleep    3
    

Enter Username and Password
    SeleniumLibrary.Input Text    id:username    ${NetBIOS}\\${CTX_Username}
    SeleniumLibrary.Input Text    id:password    ${CTX_Password}
    Sleep    3
    
Signin to the Citrix StoreFront webpage
    Click Element    id:loginBtn
    Sleep    3
    
Go to Apps tab
    Click Element    id:allAppsBtn
    Sleep    3
    
Launch BO Designer App
    Click    BO_Client_Designer_Icon_from_Ctx_StoreFront_webpage.PNG
    Sleep    10
    Click    ICA_Icon_Button_Downloaded.PNG
    Sleep    10
    Wait Until Screen Contain    BO_Client_Designer_App_from_Ctx_StoreFront_webpage.PNG    40
    #Capture Page Screenshot

Close BO Designer App
    Click    BO_Client_Designer_App_Cancel_Button.PNG
    Sleep    3

Logout from Citrix StoreFront webpage    
    Click Link    id:userMenuBtn
    Sleep    3
    Click Link    id:dropdownLogOffBtn