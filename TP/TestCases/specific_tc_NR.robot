*** Settings ***
Resource    ../Resources/login.resource
Library    ../TestCases/server.py
Test Setup        Open Connection And Log In
Test Teardown     Close All Connections   

*** Tasks ***
Specific Nr TC
    Verifying plmn tables

*** Keywords ***
Verifying plmn tables
    Set Client Configuration    prompt=Password: EPFG properties file is Successfully updated!!!    timeout=20s
    Write    cd /eniq/home/dcuser/epfg ; ./epfg_preconfig_for_ft.sh
    ${out}=    Read Until Prompt    
    ${output}=    Execute Command    date
    ${dateonserver}=    filter name    ${output}
    Log To Console    ${dateonserver}
    ${time}=    editing datetime in epfg for nr    ${output}


