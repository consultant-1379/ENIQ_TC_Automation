*** Keywords ***
Execute the command
    [Arguments]    ${command}
    Write    ${command}
    ${output}=    Read    delay=2s
    Log     ${output}
    # Log To Console     ${output}
    [Return]    ${output}

Get latest file from directory
    [Arguments]    ${latestfile}
    Write    ls -Art ${latestfile} | tail -n 1
    ${output}=    Read    delay=2s
    Log    ${output}
    [Return]    ${output}

Validate the log file for
    [Arguments]   ${msg_to_grep}    ${user_file}    ${flag}
    ${msg_count}=    Write    grep -irc '${msg_to_grep}' ${user_file}
    Log    ${msg_count}
    ${output}=    Read    delay=1s
    Log    ${output}
    Should Contain    ${output}    ${flag}
    IF    ${flag} == 0
        Should Contain    ${output}    0
    ELSE        
        Write    grep -ir '${msg_to_grep}' ${user_file}
        ${output}=    Read    delay=2s
        Log    ${output}
    END
    [Return]    ${output}

Verify the msg  
    [Arguments]    ${output}    ${msg}    
    Log    ${output}
    Should Contain    ${output}   ${msg}

Get the current feature
    [Arguments]    ${feature}
    Log    ${feature}
    ${number}=    Split String    ${feature}    
    Log    ${number}
    ${num1}=    Get From List     ${number}    -1
    ${num_2}=    Strip String    ${num1}                
    Log    ${num_2}
    ${num2}=    Get From List    ${number}    1
    ${num_3}=    Strip String    ${num2}
    Log    ${num_3}     
    [Return]    ${num_3}

Get latest file
    [Arguments]    ${Features}
    Write    ls -Art ${Features} | tail -n 1
    ${output}=    Read    delay=2s
    Log    ${output}
    [Return]    ${output}

Verify the success or skipped msg
    [Arguments]    ${log_file}    ${output_1}    ${output_2}
    Should Contain Any    ${log_file}    ${output_1}    ${output_2}

Verify the R Version db properties in platform path
    [Arguments]    ${Version}    ${platform}
    Should Be Equal    ${Version}    ${platform}

Verify the R Version db properties in MWS path
    [Arguments]    ${Version}    ${mws_path}
    Should Be Equal    ${Version}    ${mws_path}

Open clearcasevobs
    Open Available Browser    ${clearcase_url}eniqdel    headless=True 
    Click Link    //body//tr[last()-1]//td[2]//a
    ${fdm}    Get Element Attribute   //body//tr[last()-1]//td[2]//a    href
    IF    'FDM' in '${fdm}'
        Go To    ${fdm}
    ELSE
        Click Link    //body//tr[3]//td[2]//a
        Click Link    //body//tr[last()-2]//td[2]//a
        Click Link    //body//tr[last()-1]//td[2]//a
    END
    ${loc}    Get Location
    ${solarisLink}    Set Variable      ${loc}SOLARIS_baseline.html
    Set Global Variable    ${solarisLink}
    Go To    ${loc}SOLARIS_baseline.html    
    