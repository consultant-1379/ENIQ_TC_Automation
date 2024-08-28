*** Settings ***
Suite Setup        Open Connection And Log In
Suite Teardown     Close All Connections
Library            SSHLibrary
Library            DateTime
Library            DependencyLibrary
Resource           ../Resources/Resource.resource


*** Test Cases ***
Checking for ddc_status TC01
    [Documentation]       Checking the status of the DDC Service
    [Tags]                DDC_STATUS
    ${Content}=           Execute Command    service ddc status | cut -d "-" -f 1
    Set Global Variable   ${Content}
    Should Contain        ${Content}         DDC running
