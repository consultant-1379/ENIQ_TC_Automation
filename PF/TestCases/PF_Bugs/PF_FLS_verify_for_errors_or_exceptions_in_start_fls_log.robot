*** Settings ***
Library    SSHLibrary
Resource    ../../Resources/Keywords/Cli.robot
Resource    ../../Resources/Keywords/Variables.robot
Suite Setup   Open connection as root user
Suite Teardown   Close All Connections


*** Test Cases ***
Verifying exception or error in start fls log file.
    ${start_fls_log}=    Execute Command    ls /eniq/log/sw_log/symboliclinkcreator | grep -i start_fls | tail -1  
    ${check_error_in_fls_log}    ${stderr}=    Execute Command    cat /eniq/log/sw_log/symboliclinkcreator/${start_fls_log} | grep -i 'FAILED\\|EXCEPTION\\|severe\\|not found\\|failed\\|Error\\|not enabled\\|disable\\|Could not register mbeans java.security.AccessControlException'  return_stderr=True
    Should Be Empty    ${stderr}
    Should Be Empty    ${check_error_in_fls_log}
   