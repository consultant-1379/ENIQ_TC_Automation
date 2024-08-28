*** Settings ***
Library    SSHLibrary
Resource     ../../Resources/Keywords/Engine.robot
Resource     ../../Resources/Keywords/Variables.robot
Resource     ../../Resources/Keywords/Cli.robot
Test Setup    Connect to server as a dcuser
Test Teardown    Close All Connections

*** Test Cases ***
Verify the all Engine commands in command line
    Verify the command engine -e status
    Verify the incorrect command for engine -e restart
    Verify the command engine -e stop
    Verify the command engine -e start

*** Keywords ***
Verify the command engine -e status
    ${engine_status}=    Execute the command    ${engine_status_command}
    Sleep    2s
    Verify the error msg    ${engine_status}    Execution Profile
    Verify the msg    ${engine_status}    Completed successfully  
Verify the incorrect command for engine -e restart
    ${engine_restart_status}=    Execute the command    ${engine_restart}
    Sleep    25s  
    Verify the error msg    ${engine_restart_status}    Invalid command entered: restart
    Verify the error msg    ${engine_restart_status}    Execute failed 
Verify the command engine -e stop
    ${engine_stop_status}=    Execute the command    ${engine_stop}
    Sleep    15s
    Verify the error msg    ${engine_stop_status}    Execute failed
    Execute the command    ${Engine_logs_path}
    ${engine_stop_log_01}=    Grep message from file    error    stop_engine_*.log
    ${engine_stop_log_02}=    Grep message from file    execption    stop_engine_*.log
    verify for no errors in logs    ${engine_stop_log_01}
    verify for no errors in logs    ${engine_stop_log_02}
Verify the command engine -e start
    ${enginestart_status}=    Execute the command    ${engine_start}
    Sleep    15s   
    Verify the error msg    ${enginestart_status}    Invalid command entered: start
    Verify the error msg    ${enginestart_status}    Execute failed
    Execute the command    ${Engine_logs_path}
    ${engine_start_log_01}=    Grep message from file    error    stop_engine_*.log
    ${engine_start_log_02}=    Grep message from file    execption    stop_engine_*.log
    verify for no errors in logs    ${engine_start_log_01}
    verify for no errors in logs    ${engine_start_log_02}