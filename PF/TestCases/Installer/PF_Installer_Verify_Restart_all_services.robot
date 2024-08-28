*** Settings ***
Force Tags    suite
Library    SSHLibrary
Library    String
Library    RPA.Browser.Selenium
Resource    ../../Resources/Keywords/Cli.robot
Resource   ../../Resources/Keywords/Variables.robot
Resource   ../../Resources/Keywords/Installer.robot

*** Test Cases ***
Verify Restarting all the services status
    [Tags]    Installer
    Open connection as root user 
    verification of Restarting all services

*** Keywords ***
Verification of Restarting all services
    Go to the folder    ${bin_folder}
    Execute the Command   ${Restart_command}
    Grant permission    Yes
    ${services_status}=    Read    delay=600s
    Verifying stop all services    ${services_status}    ENIQ services stopped correctly 
    Verifying start all services   ${services_status}    ENIQ services started correctly
    ${service_output}=    Execute the Command    ${system_services}
    verifying the output has value eniq    ${service_output}    eniq
    [Teardown]    Test teardown

Test teardown
    Close All Connections