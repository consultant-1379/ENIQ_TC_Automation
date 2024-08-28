*** Keywords ***
Execute the Command
    [Arguments]    ${command}
    Write    ${command}
    ${output}=    Read    delay=2s
    Log     ${output}
    # Log To Console     ${output}
    [Return]    ${output}

Go to the folder mount_info
     [Arguments]    ${command}
    Write    ${command}
    ${output}=    Read    delay=2s
    Log     ${output}
    # Log To Console     ${output}
    [Return]    ${output}

 Go to the installer folder
    [Arguments]    ${command}
    Write    ${command}
    ${output}=    Read    delay=2s
    Log     ${output}
    # Log To Console     ${output}
    [Return]    ${output}

Go to the folder
    [Arguments]    ${command}
    Write    ${command}
    ${output}=    Read    delay=2s
    Log     ${output}
    # Log To Console     ${output}
    [Return]    ${output}

run the sql query
     [Arguments]    ${command}
    Write    ${command}
    ${output}=    Read    delay=2s
    Log     ${output}
    # Log To Console     ${output}
    [Return]    ${output}

checking fls status
    [Arguments]    ${command}
    Write    ${command}
    ${output}=    Read    delay=2s
    Log     ${output}
    # Log To Console     ${output}
    [Return]    ${output}

checking the services status
    [Arguments]    ${command}
    Write    ${command}
    ${output}=    Read    delay=2s
    Log     ${output}
    # Log To Console     ${output}
    [Return]    ${output}

restart the fls
    [Arguments]    ${command}
    Write    ${command}
    ${output}=    Read    delay=2s
    Log     ${output}
    # Log To Console     ${output}
    [Return]    ${output}
    
List the files in the folder
    [Arguments]    ${command}
    Write    ${command}
    ${output}=    Read    delay=2s
    Log     ${output}
    # Log To Console     ${output}
    [Return]    ${output}
List the properties of the file
      [Arguments]    ${command}
    Write    ${command}
    ${output}=    Read    delay=2s
    Log     ${output}
    # Log To Console     ${output}
    [Return]    ${output}

verify the CENM is present in the file
   [Arguments]    ${output}    ${value_to_search}
    Log To Console    ${output}
    Log    ${output}
    Should Contain    ${output}    ${value_to_search}

Display the contents in the file
    [Arguments]    ${command}
    Write    ${command}
    ${output}=    Read    delay=2s
    Log     ${output}
    # Log To Console     ${output}
    [Return]    ${output}

print the output
    [Arguments]    ${output}
    Log To Console    ${output}

verify the file is present in the file list
    [Arguments]    ${output}    ${value_to_search}
    Log To Console    ${output}
    Log    ${output}
    Should Contain    ${output}    ${value_to_search}
verifying the fls status
    [Arguments]    ${output}    ${value_to_search}
    Log To Console    ${output}
    Log    ${output}
    Should Contain    ${output}    ${value_to_search}

verifying NAT table should be empty
    [Arguments]    ${output}    ${value_to_search}
    Log To Console    ${output}
    Log    ${output}
    Should Contain    ${output}    ${value_to_search}

verify the output doesn't have value
    [Arguments]    ${output}    ${value_to_search}
    Log To Console    ${output}
    Log    ${output}
    Should Not Contain    ${output}    ${value_to_search}

verify the file is not empty
    [Arguments]    ${output}
    Should Not Be Empty    ${output}

verify the file is empty
    [Arguments]    ${output}
    Should Be Empty    ${output}

Get the previous Date  
    ${curr_date_Y_m_d} =    Get Current Date    result_format=%Y_%m_%d
    ${output}=    Subtract Time From Date    ${curr_date_Y_m_d}    1day    result_format=%Y_%m_%d
    Log To Console    ${output}
    Log    ${output}
    [Return]    ${output}

verify the active and inactive services
    [Arguments]    ${output}    ${list_of_active_services_fls}    ${list_of_inactive_services_fls}
    @{list1}=    Split To Lines    ${output}
    Log To Console    ${list1}
    FOR    ${element}    IN    @{list1}
        @{list2}=    Split String    ${element}
        IF    "${list2}[0]" in ${list_of_active_services_fls}
            IF    "${list2}[1]" != "active"
                Fail
                Exit For Loop
            END
        END

        IF    "${list2}[0]" in ${list_of_inactive_services_fls}
            IF    "${list2}[1]" != "inactive"
                Fail
                Exit For Loop
            END
            
        END
        
        
    END

verify the output contains .oss_ref_name_file with IP address
    [Arguments]    ${output}
    Should Match Regexp    ${output}    eniq_oss_1 \\d{1,3}\.\\d{1,3}\.\\d{1,3}\.\\d{1,3}
    Should Match Regexp    ${output}    eniq_oss_2 \\d{1,3}\.\\d{1,3}\.\\d{1,3}\.\\d{1,3}
    Should Match Regexp    ${output}    eniq_oss_3 \\d{1,3}\.\\d{1,3}\.\\d{1,3}\.\\d{1,3}
    Should Match Regexp    ${output}    eniq_oss_4 \\d{1,3}\.\\d{1,3}\.\\d{1,3}\.\\d{1,3}
    Should Match Regexp    ${output}    eniq_oss_5 \\d{1,3}\.\\d{1,3}\.\\d{1,3}\.\\d{1,3}
   
verify the output contains CENM INGRESS IP
    [Arguments]    ${output}
    Should Contain    ${output}    10.144.48.30 ieatenm5300-9.athtem.eei.ericsson.se ENM cenm6080 Q2VubUA2MDgwCg== ieatrcxb6080

verifying the fls_conf file has enm file  
    [Arguments]    ${output}
    Should Contain    ${output}    eniq_oss_6

verify the output contains CENM INGRESS IP and ENM hostname
    [Arguments]    ${output}
    Should Match Regexp    ${output}    \\d{1,3}\.\\d{1,3}\.\\d{1,3}\.\\d{1,3}  ieatrcxb6080  dwhdb
    Should Match Regexp    ${output}    \\d{1,3}\.\\d{1,3}\.\\d{1,3}\.\\d{1,3}  ieatrcxb6080  dwh_reader_1
    Should Match Regexp    ${output}    \\d{1,3}\.\\d{1,3}\.\\d{1,3}\.\\d{1,3}  ieatrcxb6080  engine
    Should Match Regexp    ${output}    \\d{1,3}\.\\d{1,3}\.\\d{1,3}\.\\d{1,3}  ieatrcxb6080  fls
    Should Match Regexp    ${output}    \\d{1,3}\.\\d{1,3}\.\\d{1,3}\.\\d{1,3}  ieatrcxb6080  licenceservice
    Should Match Regexp    ${output}    \\d{1,3}\.\\d{1,3}\.\\d{1,3}\.\\d{1,3}  ieatrcxb6080  lwphelper
    Should Match Regexp    ${output}    \\d{1,3}\.\\d{1,3}\.\\d{1,3}\.\\d{1,3}  ieatrcxb6080  repdb
    Should Match Regexp    ${output}    \\d{1,3}\.\\d{1,3}\.\\d{1,3}\.\\d{1,3}  ieatrcxb6080  scheduler

verify the output contains CENM INGRESS IP address
    [Arguments]    ${serviceNames}    ${aliasNames}
    Log    ${serviceNames}
    Log    ${aliasNames}
    FOR    ${j}    IN    @{aliasNames}
         ${contains}=  Evaluate   "${j}" in """${serviceNames}"""
         IF    ${contains}
             Should Match Regexp    ${serviceNames}    \\d{1,3}\.\\d{1,3}\.\\d{1,3}\.\\d{1,3}::${j}::${j}
         END
        
    END
    
    
verify the file size is not zero
    [Arguments]    ${output}
    @{list1}=    Split To Lines    ${output}
    @{list2}=    Split String    ${list1}[0]
    Should Not Be Equal    ${list2}[4]    0

verify the .ser file size is not zero
    [Arguments]    ${output}
    @{list1}=    Split To Lines    ${output}
    @{list2}=    Split String    ${list1}[0]
    Should Not Be Equal    ${list2}[4]    0

verify the truststore.ts file size is not zero
    [Arguments]    ${output}
    @{list1}=    Split To Lines    ${output}
    @{list2}=    Split String    ${list1}[0]
    Should Not Be Equal    ${list2}[4]    0

verify indirs are created
    [Arguments]    ${output}
    @{list1}=    Split To Lines    ${output}
    ${cnt}=    Get length    ${list1}
    Should Not Be Equal As Integers    ${cnt}    1

Verifying of FLS status to be ONHold when disable_OSS file Exists
    [Arguments]    ${output}
    @{list_of_files}=    Split String    ${output}
    ${fls_output}=    Execute the Command    ${status}
    @{fls_status_lines}=    Split To Lines    ${fls_output}
    IF    "disable_OSS" in ${list_of_files}
        FOR    ${element}    IN    @{fls_status_lines}
            IF    "eniq_oss_4" in "${element}"
                Should Contain    ${element}    OnHold
                Exit For Loop
            END
            
        END
    ELSE
        FOR    ${element}    IN    @{fls_status_lines}
            IF    "eniq_oss_4" in "${element}"
                Should Contain    ${element}    Normal
                Exit For Loop
            END
            
        END
    END
    
verifying PM query is happening in every 3 min
    [Arguments]    ${file_content}
    @{log_file_content}=    Split To Lines    ${file_content}
    @{timestamp1}=    Split String    ${log_file_content}[2]
    @{timestamp2}=    Split String    ${log_file_content}[3]
    IF    "${timestamp1}[0]" == "${timestamp2}[0]"
        ${timestamp1_time_list}=    Split String    ${timestamp1}[1]    separator=:
        ${timestamp2_time_list}=    Split String    ${timestamp2}[1]    separator=:
        ${timestamp1_timeframe}=    Convert To String    ${timestamp1_time_list}[0] hours ${timestamp1_time_list}[1] minutes 
        ${timestamp2_timeframe}=    Convert To String    ${timestamp2_time_list}[0] hours ${timestamp2_time_list}[1] minutes 
        ${timestamp1_in_seconds}=    Convert Time    ${timestamp1_timeframe}
        ${timestamp2_in_seconds}=    Convert Time    ${timestamp2_timeframe}
        ${timestamp_of_3minutes}=    Convert Time    3 minutes
        ${condition_check_of_lessThan_3minutes}=    Evaluate    ${timestamp2_in_seconds} - ${timestamp1_in_seconds} == ${timestamp_of_3minutes}
        ${final_value_in_string}=    Convert To String    ${condition_check_of_lessThan_3minutes}
        Should Be Equal     ${final_value_in_string}   True
    ELSE
        Fail
    END

verifying topology query is happening every 15 min
    [Arguments]    ${file_content}
    @{log_file_content}=    Split To Lines    ${file_content}
    @{timestamp1}=    Split String    ${log_file_content}[2]
    @{timestamp2}=    Split String    ${log_file_content}[3]
    IF    "${timestamp1}[0]" == "${timestamp2}[0]"
        ${timestamp1_time_list}=    Split String    ${timestamp1}[1]    separator=:
        ${timestamp2_time_list}=    Split String    ${timestamp2}[1]    separator=:
        ${timestamp1_timeframe}=    Convert To String    ${timestamp1_time_list}[0] hours ${timestamp1_time_list}[1] minutes
        ${timestamp2_timeframe}=    Convert To String    ${timestamp2_time_list}[0] hours ${timestamp2_time_list}[1] minutes
        ${timestamp1_in_seconds}=    Convert Time    ${timestamp1_timeframe}
        ${timestamp2_in_seconds}=    Convert Time    ${timestamp2_timeframe}
        ${timestamp_of_15minutes}=    Convert Time    15 minutes
        ${condition_check_of_lessThan_15minutes}=    Evaluate    ${timestamp2_in_seconds} - ${timestamp1_in_seconds} == ${timestamp_of_15minutes}
        ${final_value_in_string}=    Convert To String    ${condition_check_of_lessThan_15minutes}
        Should Be Equal     ${final_value_in_string}   True
    ELSE
        Fail
    END

clicking the Granularity configuration from menu bar
    RPA.Browser.Selenium.Click Element    //a[text()='Granularity Configuration' and @class='menulink']
    RPA.Browser.Selenium.Wait Until Page Contains Element    //form//a[text()='Granularity Configuration']
    ${minute_value}=    RPA.Browser.Selenium.Get Value    //td[contains(text(),'CCDM')]/following-sibling::td//select//option[@selected]
    IF    "${minute_value}" == "${one_minute}"
        RPA.Browser.Selenium.Select From List By Value    //td[contains(text(),'CCDM')]/following-sibling::td//select    5MIN
    ELSE
        RPA.Browser.Selenium.Select From List By Value    //td[contains(text(),'CCDM')]/following-sibling::td//select    1MIN
    END
    RPA.Browser.Selenium.Click Element    //input[@value='Continue']
    RPA.Browser.Selenium.Wait Until Page Contains Element    //input[@value='Submit']
    RPA.Browser.Selenium.Click Element    //input[@value='Submit']
    RPA.Browser.Selenium.Wait Until Page Contains Element    //h3[text()='Granularity configuration changed successfully.']


Verify the enm alias name in server
    [Arguments]    ${oss_file}    ${file_2}
    Should Match Regexp    ${oss_file}    ${file_2}    

Verify the msg
    [Arguments]    ${output_1}    ${output_2}
    Should Contain    ${output_1}    ${output_2}

 get the enm alias names
     [Arguments]    ${oss_ref_file_contents}
    @{op1}=    Split To Lines    ${oss_ref_file_contents}
    @{file_contents}=     Split String    ${oss_ref_file_contents}    \n
    Log    ${file_contents}
    ${n}=    Get Length	    ${op1}
    Log    ${n}
    @{eniq_alias_names}=    Create List
    FOR    ${i}    IN RANGE    0    ${n}-1
    Log    ${file_contents}[${i}]
        ${contains}=  Evaluate   "eniq_oss" in """${file_contents}${i}""" 
        IF    ${contains}
           @{words}=    Split String     ${file_contents}[${i}]
           ${eniqName}=      get from list    ${words}    0
           Append To List    ${eniq_alias_names}    ${eniqName}
           Log    ${eniq_alias_names}
        END
        
    END
    Log    ${eniq_alias_names}
    [Return]    ${eniq_alias_names}

Get the number of lines in log results
    [Arguments]    ${log_results}
    @{log_file_content}=    Split To Lines    ${log_results}
    ${noOfLines}=    Get Length	    ${log_file_content}
    [Return]    ${noOfLines}

Verify the PENM and CENM
    [Arguments]    ${output_1}    ${output_2}    ${output_3}
    Should Contain Any    ${output_1}    ${output_2}    ${output_3}        