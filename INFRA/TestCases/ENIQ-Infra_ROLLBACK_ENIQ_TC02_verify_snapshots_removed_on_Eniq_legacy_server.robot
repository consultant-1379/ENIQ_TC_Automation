*** Settings ***
Variables    ../Resources/Variables/Variables.py
Library    SSHLibrary

Test Setup    Login to eniq
Test Teardown    Close All Connections

*** Keywords ***
Login to eniq
    Open Connection    ${eniq_upg_hostname}
    Login    ${eniq_upg_username}    ${eniq_upg_password}    delay=1

*** Test Cases ***
verify snapshot removal on legacy servers
    ${output}=    Execute Command    dmidecode -t system | grep -w 'Product Name' | cut -d ':' -f2 | cut -d ' ' -f4,5
    Log To Console    ${output}
    IF    "${output}"!="Gen10 Plus"
        ${op1}=    Execute Command   lvs | grep -i rootsnap
        Should Be Empty     ${op1}

        ${op2}=    Execute Command   lvs | grep -i varsnap
        Should Be Empty     ${op2}
    END