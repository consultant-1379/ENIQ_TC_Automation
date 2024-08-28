*** Settings ***
Library    SSHLibrary
Resource     ../../Resources/Keywords/Engine.robot
Resource     ../../Resources/Keywords/Variables.robot
Resource     ../../Resources/Keywords/Cli.robot


*** Test Cases ***
Verify the engine services for active and Loader
    Open connection as root user 
    Write    ssh engine
    ${output}=    Read    delay=2s    
    ${Engine_status_output}=    Run Keyword And Return Status    Should Contain    ${output}    Are you sure you want to continue connecting (yes/no)?  
    IF    ${Engine_status_output} == True
        Grant permission    yes
        Write    systemctl status eniq-engine.service
        ${output_1}=    Read    delay=4s
        Should Contain    ${output_1}    Loaded: loaded
        Should Contain    ${output_1}    active (running)
    ELSE
        Write    systemctl status eniq-engine.service
        ${output_1}=    Read    delay=4s
        Should Contain    ${output_1}    Loaded: loaded
        Should Contain    ${output_1}    active (running)
    END

*** Keywords ***
Test Teardown
    Close All Connections
