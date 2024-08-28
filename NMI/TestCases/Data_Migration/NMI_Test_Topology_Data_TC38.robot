*** Settings ***
Library           OperatingSystem

*** Variables ***

*** Test Cases ***
Checking if tables are successfully appended     
    [Tags]                Disabling
    ${Content}=           Get File                   Topology.log
    Set Global Variable   ${Content}
    Should Contain        ${Content}                 Successfully appended
