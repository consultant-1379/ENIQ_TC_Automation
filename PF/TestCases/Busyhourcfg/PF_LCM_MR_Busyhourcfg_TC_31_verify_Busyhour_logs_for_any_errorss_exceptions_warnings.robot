*** Settings ***
Library    SSHLibrary
Resource    ../../Resources/Keywords/Cli.robot
Resource    ../../Resources/Keywords/Variables.robot
Suite Setup    Open connection as root user
Test Teardown    Close All Connections
 
 
*** Test Cases ***
 verify Bushourcfg logs for any errors  
    ${output}    Execute Command    ls /eniq/log/sw_log/busyhourcfg | grep -i busyhourcfg
    ${latest_file}=    Execute Command    ls /eniq/log/sw_log/busyhourcfg/busyhourcfg* | tail -1
    ${output1}    Execute Command    cat ${latest_file} | grep -i "Exception\\|Warning\\|Error"
    Should Be Empty    ${output1}
 
    
 
    
    
    
    