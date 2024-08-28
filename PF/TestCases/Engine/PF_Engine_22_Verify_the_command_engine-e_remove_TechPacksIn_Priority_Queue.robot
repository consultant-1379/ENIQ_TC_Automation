*** Settings ***
Library    SSHLibrary
Library    RPA.Browser.Selenium
Library    Collections
Resource    ../../Resources/Keywords/Engine.robot
Resource    ../../Resources/Keywords/Cli.robot
Resource    ../../Resources/Keywords/Variables.robot


*** Test Cases ***
Verify the command engine -e removeTechPacksInPriorityQueue
    Connect to server as a dcuser
    Go to the folder    ${installer_path}
    ${getting_activing_interfaces}=    Go to the folder    ./get_active_interfaces | grep -i eniq_oss_1
    @{spilting_interfaces}=    Split To Lines    ${getting_activing_interfaces}
    ${Techpack_list}=    Get From List    ${spilting_interfaces}    0
    ${remove_techpack}=    Execute the command    engine -e removeTechPacksInPriorityQueue${Techpack_list}
    Verify the error msg    ${remove_techpack}    Removed tech pack sets from queue
    Launch the AdminUI page in browser
    Login to Adminui
    Click Button    System Status
    Verify the System Status page displayed
    Click on link    ETLC Monitoring
    Verify the ETLC Monitoring page displayed    
    Verify the remove techpack in adminui page    ${Techpack_list}
    Logout from Adminui

*** Keywords ***
Suite setup steps
    Set Screenshot Directory    ./Screenshots

Test teardown
    Capture Page Screenshot
    Close Browser
    Close All Connections

