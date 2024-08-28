*** Settings ***
Documentation     Testing DWH_Mgr web
Library    RPA.Browser.Selenium
Library    SSHLibrary
Resource    ../../Resources/Keywords/Cli.robot
Resource    ../../Resources/Keywords/AdminUIWebUI.robot
Resource    ../../Resources/Keywords/Variables.robot
Resource    ../../Resources/Keywords/Dwhmanager.robot
Suite Teardown    Test teardown

*** Test Cases ***
Check IQ Multiplex status details for ENIQ DWH database using adminui
    Open connection as root user
    ${deployement_type}=    Execute Command    cat /eniq/installation/config/extra_params/deployment
    Log To Console    ${deployement_type}
    IF    "${deployement_type}" == "large" or "${deployement_type}" == "extra large"
        Launch the AdminUI page in browser
        Login To Adminui
        Verify Home Page Is Displayed
        Click Button    System Status
        Click on IQ Multiplex status details in ENIQ DWH
        navigate to IQ Multiplex status details window
        ${count}    Get Element Count    //table[@border="1"]//tr
        Should Be True    ${count}>1
        Navigate to main page
        Logout from Adminui     
    ELSE
        Log To Console    Its a Single blade server ,hence Multiplex status details will not be present 
    END
    

*** Keywords ***
Suite setup steps
    Set Screenshot Directory    ./Screenshots 
Test teardown
    Capture Page Screenshot
    Close Browser