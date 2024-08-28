*** Settings ***
Library    SSHLibrary
Resource    ../../Resources/Keywords/Cli.robot
Resource    ../../Resources/Keywords/Variables.robot
Suite Setup    Open connection as root user
Suite Teardown    Close All Connections
 
*** Test Cases ***
verify adminui.log in adminui logs for any errors
    ${output}    Execute Command    ls /eniq/log/sw_log/adminui | grep -i adminui.log
    ${latest_file}    Execute Command    ls /eniq/log/sw_log/adminui/adminui.log* | tail -1 
    ${output1}    Execute Command    cat ${latest_file} | grep -i "Exception\\|Warning\\|Error"
    Should Be Empty    ${output1}
 
verify catalina.out in adminui logs for any errors
    ${output}    Execute Command    ls /eniq/log/sw_log/adminui | grep -i catalina.out
    ${output1}    Execute Command    cat /eniq/log/sw_log/adminui/${output} | grep -i "Exception\\|Warning\\|Error"
    Should Be Empty    ${output1}    
 
verify localhost_access_log in adminui logs for any errors
    ${output}    Execute Command    ls /eniq/log/sw_log/adminui | grep -i localhost_access_log
    ${latest_file}    Execute Command    ls /eniq/log/sw_log/adminui/localhost_access_log* | tail -1
    ${output1}    Execute Command    cat ${latest_file} | grep -i "Exception\\|Warning\\|Error"
    Should Be Empty    ${output1}    
 
verify user_management in adminui logs for any errors
    ${output}    Execute Command    ls /eniq/log/sw_log/adminui | grep -i user_management
    ${latest_file}    Execute Command     ls /eniq/log/sw_log/adminui/user_management* | tail -1
    ${output1}    Execute Command    cat ${latest_file} | grep -i "Exception\\|Warning\\|Error"
    Should Be Empty    ${output1}
 
verify ffu_logs in adminui logs for any errors
    ${output}    Execute Command    ls /eniq/log/sw_log/adminui | grep -i ffu_logs
    ${latest_file}=    Execute Command    ls /eniq/log/sw_log/adminui/ffu_logs | tail -1
    ${output1}    Execute Command    cat /eniq/log/sw_log/adminui/ffu_logs/${latest_file} | grep -i "Exception\\|Warning\\|Error"
    Should Be Empty    ${output1}