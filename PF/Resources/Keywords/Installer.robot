*** Keywords ***

Execute the Command
    [Arguments]    ${command}
    Write    ${command}
    ${output}=    Read    delay=2s
    Log     ${output}
    # Log To Console     ${output}
    [Return]    ${output}

Executing the command
    [Arguments]    ${command}
    Write    ${command}
    ${output}=    Read Until Prompt
    Log     ${output}
    [Return]    ${output}

Verifying start all services
    [Arguments]    ${output}    ${value_to_search}
    Log To Console    ${output}
    Log    ${output}
    Should Contain    ${output}    ${value_to_search}

Verifying stop all services
    [Arguments]    ${output}    ${value_to_search}
    Log To Console    ${output}
    Log    ${output}
    Should Contain    ${output}    ${value_to_search}

Go to the folder
    [Arguments]    ${command}
    Write    ${command}
    ${output}=    Read    delay=2s
    Log     ${output}
    # Log To Console     ${output}
    [Return]    ${output}

verifyng the services status
    [Arguments]    ${output}    ${value_to_search}
    Log To Console    ${output}
    Log    ${output}
    Should Contain    ${output}    ${value_to_search}

verify activation status of techpack
    [Arguments]    ${output}    ${value_to_search}    
    Log To Console    ${output}
    Log    ${output}
    Should Contain    ${output}    ${value_to_search}

verifying installation status
   [Arguments]    ${output}    ${value_to_search}
    Log To Console    ${output}
    Log    ${output}
    Should Contain    ${output}    ${value_to_search}

verifying services status
   [Arguments]    ${output}    ${value_to_search}
    Log To Console    ${output}
    Log    ${output}
    Should Contain    ${output}    ${value_to_search}

verifying node hardening status
   [Arguments]    ${output}    ${value_to_search}
    Log To Console    ${output}
    Log    ${output}
    Should Contain    ${output}    ${value_to_search}
    Sleep    10s

verify run time installed successfully
   [Arguments]    ${output}    ${value_to_search}
    Log To Console    ${output}
    Log    ${output}
    Should Contain    ${output}    ${value_to_search}

replacing the runtime folder
    FOR    ${counter}    IN RANGE    20
        Write    n
        
    END

Grant permission
    [Arguments]    ${yes_or_no}
    Write    ${yes_or_no}

switch user
    [Arguments]    ${command}
    Write    ${command}
    ${output}=    Read    delay=2s
    Log     ${output}
    # Log To Console     ${output}
    [Return]    ${output}
    
verifying the output has value eniq
    [Arguments]    ${output}    ${value_to_search}
    Log To Console    ${output}
    Log    ${output}
    Should Contain    ${output}    ${value_to_search}

verify the Techpack installation
    [Arguments]    ${output}    ${value_to_search1}    ${value_to_search2}
    Log To Console    ${output}
    Log    ${output}
    Should Contain Any    ${output}    ${value_to_search1}    ${value_to_search2}

verify the interface activation with eniq_oss_n
    [Arguments]    ${output}    ${value_to_search1}    
    Log To Console    ${output}
    Log    ${output}
    Should Contain    ${output}    ${value_to_search1}

Verifying the services list
    [Arguments]     ${services_status} 
    FOR    ${service}    IN    @{eniq_services_list}
        Should Contain    ${services_status}    Stopping ENIQ service ${service}
        Should Contain    ${services_status}    Starting ENIQ service  ${service}
        
    END

Remove log file
    Execute the Command    rm install_lockfile

Adding Installer script files in SERVER
    Put File    ${EXEC_DIR}//PF//Scripts//Automation_installer_scripts.txt    /eniq/sw/installer

Adding bin script files in server
    Put File    ${EXEC_DIR}//PF//Scripts//Automation_bin_scripts.txt    /eniq/sw/bin

Removing Automation_installer text file
    Execute the Command    rm -rf /eniq/sw/installer/Automation_installer_scripts.txt

Removing Automation_bin text file
    Execute the Command    rm -rf /eniq/sw/bin/Automation_bin_scripts.txt      


 
