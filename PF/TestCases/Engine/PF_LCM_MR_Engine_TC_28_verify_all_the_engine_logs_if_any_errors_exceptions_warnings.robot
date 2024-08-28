*** Settings ***
Library    SSHLibrary
Resource    ../../Resources/Keywords/Cli.robot
Resource    ../../Resources/Keywords/Variables.robot
Suite Setup    Open connection as root user
Test Teardown    Close All Connections
 
 
 
*** Test Cases ***
verify all engine logs for any error
    ${output}    Execute Command    ls /eniq/log/sw_log/engine | grep -i engine
    ${date}    Execute command     date '+%Y_%m_%d'   
    ${output1}    Execute Command    ls /eniq/log/sw_log/engine | grep -i engine-${date}.log 
    ${output2}    Execute Command    cat /eniq/log/sw_log/engine/${output1} | grep -i "Exception\\|Warning\\|^Error$"
    Should Be Empty    ${output2}