*** Settings ***
Documentation     Testing AdminUI web
Library    RPA.Browser.Selenium
Library    SSHLibrary
Resource    ../../Resources/Keywords/AdminUIWebUI.robot
Resource    ../../Resources/Keywords/Variables.robot
Resource    ../../Resources/Keywords/Cli.robot
Suite setup       Suite setup steps
Test Teardown    Close All Connections


*** Test Cases ***
Verify the edit functionality of Legal notice message in AdminUI as default user
    [Tags]    Adminui
    Launch the AdminUI page in browser
    ${Legal Notice Message}=	Get the Legal Notice msg	${Legal_message_xpath}
    Login to Adminui
    Click on scroll down button
    Click on link    Legal Notice Message
    Wait for Legal notice page input text box
    Editing the Legal notice msg    ${New_legal_notice}
    Sleep    2s
    Click Button    Save
    Validate the update message    ${Legal_sucessfully_msg}
    Verify the Adminui Legal Notice message    ${New_legal_notice}
    Logout from Adminui
    Connect to server as a dcuser
    Execute the command    cd ${Webapps_path}
    ${Update_msg}=    Execute the command    cat ${Message_properties}
    Validating the file    ${Update_msg}    ${New_legal_notice}
    Launch the AdminUI page in browser
    Validate the update message    ${New_legal_notice}
    #Reverting the legal notice message
    Launch the AdminUI page in browser
    Login to Adminui
    Click on scroll down button
    Click on link    Legal Notice Message
    Wait for Legal notice page input text box
    Editing the Legal notice msg    ${Legal Notice Message}
    Sleep    2s
    Click Button    Save
    Verify the Adminui Legal Notice message	${Legal Notice Message}    
    Logout from Adminui
    [Teardown]    Test teardown

*** Keywords ***
Suite setup steps
    Set Screenshot Directory    ./Screenshots
    
Test teardown
    Capture Page Screenshot
    Close Browser
    Close All Connections