*** Settings ***
Resource    ../../Resources/login.resource
Library    RPA.RobotLogListener
Test Setup        Open Connection And Log In
Test Teardown     Close All Connections  
Library    ../TestCases/server.py

*** Variables ***

*** Test Cases ***
checking system status
    checking services
*** Keywords ***
checking services
    Set Client Configuration    prompt=eniqs[eniq_stats] {dcuser} #:    timeout=3600
    Write    services -s eniq
    ${output}=    Read Until Prompt