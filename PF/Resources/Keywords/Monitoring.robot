
*** Keywords ***
Get the element of Monitoring attribute from clearcase
    Open Available Browser    ${clearcase_url}     headless=false
    Maximize Browser Window
    click link    //body//tr[last()-2]//td[2]//a
    ${Monitoring_file}=    Get Element Attribute    //a[contains(text(),'monitoring')]    href
    Go To    ${Monitoring_file}
    RETURN    ${Monitoring_file}

Get Monitoring Rstate from clearcase
    [Arguments]    ${Monitoring_file}
    ${Monitoring_zip_file}=    Fetch From Right    ${Monitoring_file}    _
    ${Monitoring_rstate_buildno_clearcase}=    Fetch From Left    ${Monitoring_zip_file}    .
    RETURN    ${Monitoring_rstate_buildno_clearcase}

Get Monitoring version from server
    ${rstate_8399}    Execute Command    cd /eniq/sw/installer && cat versiondb.properties | grep -i monitoring
    ${Monitoring_rstate}    Split String    ${rstate_8399}    monitoring=
    ${Monitoring_rstate_buildno_server}=    Get From List    ${Monitoring_rstate}    -1
    ${output}    Remove String Using Regexp    ${Monitoring_rstate_buildno_server}    .*monitoring\\S
    RETURN    ${output}

Verify the latest monitoring version is updated in versiondb.properties file
    [Arguments]    ${rstate_clearcase}    ${Monitoring_rstate_8399}
    IF    '${rstate_clearcase}' == '${Monitoring_rstate_8399}'
        RETURN    True
    ELSE
        RETURN    False
    END

Install latest monitoring package
    [Arguments]    ${Monitoring_file}
    Execute Command     cd /eniq/sw/installer/ && rm -rf monitoring_*
    ${Monitoring_zip_file}=    Fetch from Right    ${Monitoring_file}    /
    Execute Command    cd /eniq/sw/installer/ && wget ${Monitoring_file}
    Execute Command    cd /eniq/sw/installer/ && chmod u+x ${Monitoring_zip_file}
    Write    cd /eniq/sw/installer/ ; ./platform_installer ${Monitoring_zip_file}
    ${staus_Monitoring}=    Read Until Prompt
    RETURN    ${staus_Monitoring}

Verify installation of Monitoring package is Successful
    [Arguments]    ${staus_Monitoring}
    Should Contain    ${staus_Monitoring}    Successfully installed    Same version is already installed. Skipped monitoring installation.

Verify the installation of latest Monitoring package
    IF    '${rstate_status}' == 'True'
        Skip   Monitoring version from clearcase and server is same hence skipping the installation of scheduler package of TC-1
    ELSE
        ${Monitoring_file}    Get the element of Monitoring attribute from clearcase
        ${staus_Monitoring}    Install latest Monitoring package     ${Monitoring_file}
        Verify installation of Monitoring package is Successful    ${staus_Monitoring}
    END

Connection to physical server
    ${prompt_pysical_server}    Set Variable    ${SERVER}${prompt}
    ${dcuser}    Open Connection    ${host_123}    port=${port_for_vapp}    timeout=100s    prompt=${prompt_pysical_server}
    Login    ${user_for_vapp}    ${pass_for_vapp}
    Set Global Variable    ${dcuser}
Go to system monitoring and select installed modules
    Click Element    //a[text()='Monitoring Commands']
    Select From List By Label    name:command    Installed modules
    Click Button    //input[@type='submit']

Click on ETLC set History link
    Click Element    //a[text()='ETLC Set History']
    Set Selenium Speed    2s
 
Select package name as DWH_MONITOR
    Select From List By Label    name:selectedpack    DWH_MONITOR
    #Click Element When Clickable    //input[@type='submit']
    Select From List By Value    name:selectedsettype    ALL
    Click Button    Search
    Sleep    5s
    Click link    //a[text()='UpdateMonitoring']
    Sleep    3s

Select yesterday date and package name as DWH_MONITOR
    ${current_date}    Get Current Date    result_format=%Y-%m-%d
    ${yesterday_date}    Add Time To Date    ${current_date}    -1 day    result_format=%Y-%m-%d 
    ${date_string}    Split String    ${yesterday_date}    -
    Set Global Variable    ${date_string}
    Select From List By Label    name:selectedpack    DWH_MONITOR
    Select From List By Value    name:selectedsettype    ALL

Select name filter as SessionLoader_Starter and click on search
    Input Text    //input[@name='searchstring']    SessionLoader_Starter
    Sleep    2s
    Execute Javascript    document.getElementById('year_1').value='${date_string}[0]';document.getElementById('month_1').value='${date_string}[1]';document.getElementById('day_1').value='${date_string}[2]';document.querySelector("input[type='submit']").click()
    Sleep    5s

Verify 96 rops for SessionLoader_Starter
    ${rops_count}    Get Element Count    (//table)[4]//tr
    Sleep    2s
    Set Global Variable    ${rops_count}
    IF    ${rops_count} == 97
        Pass Execution    Got 96 rops for SessionLoader_Starter
    ELSE
        Fail    Failed to get 96 rops hence yesterday server has broken. Check the server.
    END

Verify the msg
    [Arguments]    ${Engine_output}    ${success_msg}
    Log    ${Engine_output}

Get current date in yyyy.mm.dd result_format
    ${currentdatefmt} =    Get Current Date    result_format=%Y %b %d,
    Log    ${currentdatefmt}
    [Return]    ${currentdatefmt}

Execute the Command
    [Arguments]    ${command}
    Set Client Configuration    prompt=REGEXP:${SERVER}\\[[^\\]]+\\]\\s\\{.*}\\s#:    timeout=10s
    Write    ${command}
    ${output}=    Read Until Prompt    strip_prompt=True    
    Log     ${output}
    [Return]    ${output}

Verify the AGGREGATED status
    [Arguments]    ${aggregate}    ${aggregate_output}
    Should Contain   ${aggregate}    ${aggregate_output}

Verify the AGGREGATED and LATE DATA status
    [Arguments]    ${aggregate}    ${aggregate_output}    ${agg_late_data_output}
    Should Contain Any  ${aggregate}    ${aggregate_output}    ${agg_late_data_output}    

Verify the Loaded status
    [Arguments]    ${loaded}    ${loaded_output}
    Should Contain   ${loaded}    ${loaded_output}    

