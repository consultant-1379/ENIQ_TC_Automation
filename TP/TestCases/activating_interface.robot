*** Settings ***
Resource    ../Resources/login.resource

Test Setup        Open Connection And Log In
Test Teardown     Close All Connections  
Library    ./server.py

*** Test Cases ***
Task To Perform Activating Interface
    Activating Interface    ${pkg}
    

*** Keywords ***
Activating Interface
    [Arguments]    ${pkgName}
    Write    cd /eniq/sw/installer ; ./activate_interface -o eniq_oss_1 -t ${pkgName}
    Read       delay=300s
    
    