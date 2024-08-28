*** Settings ***
Library    SeleniumLibrary
Library    SikuliLibrary
Test Setup    Add Needed Image Path
Resource    ../Resources/Variables/OCS_Variables.robot


*** Variables ***
${Image_DIR}        .\\Resources\\Images


*** Test Cases ***
Citrix License server version from Licensing Manager
    Launch Citrix Licensing Manager console
    Enter Username and Password
    Signin to the console    
    Close the popup Window
    Verification of License Server version
    Capture Page Screenshot


*** Keywords ***
Add Needed Image Path
    Add Image Path    ${Image_DIR}

Launch Citrix Licensing Manager console
    Open Browser    https://${CCSFQHN}:8083    chrome
    Maximize Browser Window
    Sleep    2s
    Click Button    xpath://*[@id="details-button"]
    Click Link    xpath://*[@id="proceed-link"]

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