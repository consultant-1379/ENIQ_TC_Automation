*** Settings ***
Library    SSHLibrary
Variables    ../Resources/Variables/Variables.py
Test Setup    Login to mws
Test Teardown    Close All Connections
*** Keywords ***
Login to mws
    Open Connection    ${mwshost}
    Login    ${mwsuser}    ${mwspwd}    delay=1
*** Test Cases ***
Verify if Deployment_Tool file system is created

    ${output}=    Execute Command    lvs --noheadings -o lv_name,vg_name | grep -w 'root'|awk '{print $2}'
    ${output1}=    Execute Command    df -h |grep "/dev/mapper/${output}-Deployment_Tool"
    Log to console    ${output1}
    ${output2}=    Execute Command    lvs |grep "Deployment_Tool ${output}"
    Log to console    ${output2}
    Should Not Be Empty    ${output1}
    Should Not Be Empty    ${output2}
