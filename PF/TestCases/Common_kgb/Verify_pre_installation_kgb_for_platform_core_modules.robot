*** Settings ***
Library    SSHLibrary
Library    RPA.Browser.Selenium
Library    String
Library    Collections
Library    OperatingSystem
Library    OperatingSystem
Library    Collections
Resource    ../../Resources/Keywords/Cli.robot
Resource    ../../Resources/Keywords/Variables.robot
Resource    ../../Resources/Keywords/Parser.robot
Suite Setup    Open connection as root user
Suite Teardown    Close All Connections


*** Variables ***
${Shipment}    
${nexus_shipment}
${latest_sprint_present}    False
@{module_list}
@{sprint_value}
@{latest_module}
${url}    https://arm1s11-eiffel013.eiffel.gic.ericsson.se:8443/nexus/content/repositories/eniq_platform/Packages/         
@{core_module_list}    libs    repository    common    licensing    engine    scheduler    monitoring    export    dwhmanager    alarm    diskmanager    ebsmanager    mediation    statlibs    symboliclinkcreator    uncompress    
    
*** Test Cases ***
Getting the shipment value
    ${contain_EU}    Run Keyword And Return Status    Should Contain     ${Shipment}    EU
    IF    '${contain_EU}' == 'True'
        ${nexus_shipment}    Replace String Using Regexp    ${shipment}    .8.*    _CONSOLIDATION
        Set Global Variable    ${nexus_shipment}
    ELSE
        ${nexus_shipment}=    Set Variable    ${Shipment}
        Set Global Variable    ${nexus_shipment}
        
    END
    Log    ${nexus_shipment}
    Log    ${shipment}

Getting all latest module persent on nexus page
    # ${chrome_options}=    Evaluate    sys.modules['selenium.webdriver'].ChromeOptions()    sys
    # Call Method    ${chrome_options}    add_argument    --ignore-certificate-errors
    # Log    ${EXEC_DIR}
    # RPA.Browser.Selenium.Create Webdriver    Chrome    executable_path=${EXEC_DIR}/PF/Resources/Drivers/chromedriverlatest1.exe    chrome_options=${chrome_options}
    # RPA.Browser.Selenium.Go To    ${url}
    Open Available Browser    ${url}    browser_selection=Chrome
    Sleep    5s
    RPA.Browser.Selenium.Maximize Browser Window  
    ${latest_sprint}    Get WebElements    //table//td[1]
    FOR    ${element}    IN    @{latest_sprint}
        ${latest_sprint_check}    Get Text    ${element}
        Append To List    ${sprint_value}    ${latest_sprint_check}
    END  
    Log To Console    ${sprint_value}   
    ${checkin_status}=    Run Keyword And Return Status     Should Contain Match    ${sprint_value}    regexp=^${nexus_shipment}/
    IF    ${checkin_status} == True
        RPA.Browser.Selenium.Go To    ${url}/${nexus_shipment}
        ${modules1}    Get WebElements    //table//td[1]  
        FOR    ${element}    IN    @{modules1}
            ${modules2}    Get Text    ${element}
            ${server_module}=    Remove String    ${modules2}    .zip
            Append To List    ${module_list}    ${server_module}
        END  
        Remove Values From List    ${module_list}    Parent Directory
        FOR    ${element}    IN    @{module_list}
            Log    ${element}
            ${index}=    Get Index From List    ${module_list}    ${element}
            ${module_check}    Split String    ${element}    _
            ${module_check1}    Set Variable    ${module_check[0]}
            Log To Console    ${index}
            ${final_index}    Evaluate    ${index}+1
           ${status}    Run Keyword And Return Status    Should Contain    ${module_list[${final_index}]}    ${module_check1}_
           IF    ${status} == True
               Continue For Loop
            ELSE 
                Append To List    ${latest_module}    ${element}
                
            END
            
        END
        Set Global Variable    ${latest_module}
        Log To Console    ${latest_module}
        ${latest_sprint_present}    Set Variable    True
        Set Global Variable    ${latest_sprint_present}
        
    END
    
Verify latest core module installed 
    ${pf_modules_path}=    Execute Command    ls /eniq/sw/platform/   
    ${split_module_list}=    Split To Lines    ${pf_modules_path}  
    ${unavailable_modules_list}=    Create List
    ${modules_mismatch_list}=    Create List
    FOR    ${element}    IN    @{core_module_list} 
        Log    ${element}  
        ${check_platform_folder}=    Run Keyword And Return Status     Should Contain Match    ${split_module_list}    regexp=^${element}-
        Log    ${check_platform_folder}
        IF    ${check_platform_folder} == True
            ${pf_mod_with_rstate}=    Execute Command    ls /eniq/sw/platform/ | grep -i "^${element}-"
            Log    ${pf_mod_with_rstate}
            ${pf_mod_rstate_out}=    Replace String    ${pf_mod_with_rstate}    -    _  
            Log To Console    ${module_list}
            Log To Console    ${element}
            IF    ${latest_sprint_present} == True
                ${check_module_on_nexus}=    Run Keyword And Return Status     Should Contain Match   ${module_list}     regexp=^${element}_
                IF    ${check_module_on_nexus} == True
                    ${mws_modules_status}=    Run Keyword And Return Status    Should Contain    ${latest_module}    ${pf_mod_rstate_out}
                    IF    ${mws_modules_status} == False
                        Append To List    ${modules_mismatch_list}    ${pf_mod_rstate_out}
                    END
                ELSE
                    ${check_mws_module}=    Execute Command    ls /net/10.45.192.134/JUMP/ENIQ_STATS/ENIQ_STATS/${shipment}/eniq_base_sw/eniq_sw/ | grep -i ^${pf_mod_rstate_out}
                    Log    ${check_mws_module}
                    ${mws_modules_status}=    Run Keyword And Return Status    Should Not Be Empty    ${check_mws_module}
                    IF    ${mws_modules_status} == False
                        Append To List    ${modules_mismatch_list}    ${pf_mod_rstate_out}
                    END
                END
           ELSE
               ${check_mws_module}=    Execute Command    ls /net/10.45.192.134/JUMP/ENIQ_STATS/ENIQ_STATS/${shipment}/eniq_base_sw/eniq_sw/ | grep -i ^${pf_mod_rstate_out}
                Log    ${check_mws_module}
                ${mws_modules_status}=    Run Keyword And Return Status    Should Not Be Empty    ${check_mws_module}
                IF    ${mws_modules_status} == False
                    Append To List    ${modules_mismatch_list}    ${pf_mod_rstate_out}
                END

            END
        ELSE
           Append To List    ${unavailable_modules_list}    ${element}        
        END
    END
    ${mws_modules_status}=    Run Keyword And Return Status    Should be Empty   ${modules_mismatch_list}
    ${module_status}=    Run Keyword And Return Status    Should Be Empty    ${unavailable_modules_list}
    IF    "${mws_modules_status}" == "True" and "${module_status}"=="True"
        Pass Execution    All modules are available with matching rstates
    ELSE
        Fail    ${unavailable_modules_list} not present in platform folder ${\n}${modules_mismatch_list} not matching in mws modules path
    END


Verify latest core modules updated in versiondb file
    ${vdb_modules_path}=    Execute Command    cat /eniq/sw/installer/versiondb.properties | grep -i "module." | cut -d "." -f2
    ${split_module_list}=    Split To Lines    ${vdb_modules_path}  
    ${unavailable_modules_list}=    Create List
    ${modules_mismatch_list}=    Create List
    FOR    ${element}    IN    @{core_module_list} 
        Log    ${element}  
        ${check_platform_folder}=    Run Keyword And Return Status     Should Contain Match    ${split_module_list}    regexp=^${element}=
        Log    ${check_platform_folder}
        IF    ${check_platform_folder} == True
            ${vdb_mod_with_rstate}=    Execute Command    cat /eniq/sw/installer/versiondb.properties | grep -i "module.${element}=" | cut -d "." -f2
            Log    ${vdb_mod_with_rstate}
            ${vdb_mod_rstate_out}=    Replace String    ${vdb_mod_with_rstate}    =    _  
            IF    ${latest_sprint_present} == True
                ${check_module_on_nexus_for_version}=    Run Keyword And Return Status     Should Contain Match   ${module_list}     regexp=^${element}_
                IF    ${check_module_on_nexus_for_version} == True
                    ${mws_modules_status_for_version}=    Run Keyword And Return Status    Should Contain    ${latest_module}    ${vdb_mod_rstate_out}
                    IF    ${mws_modules_status_for_version} == False
                        Append To List    ${modules_mismatch_list}    ${vdb_mod_rstate_out}
                    END
                ELSE
                    ${check_mws_module_for_version}=    Execute Command    ls /net/10.45.192.134/JUMP/ENIQ_STATS/ENIQ_STATS/${shipment}/eniq_base_sw/eniq_sw/ | grep -i ^${vdb_mod_rstate_out}
                    Log    ${check_mws_module_for_version}
                    ${mws_modules_status_for_version}=    Run Keyword And Return Status    Should Not Be Empty    ${check_mws_module_for_version}
                    IF    ${mws_modules_status_for_version} == False
                    Append To List    ${modules_mismatch_list}    ${vdb_mod_rstate_out}
                    END
                    
                END
            
            ELSE
                   ${check_mws_module_for_version}=    Execute Command    ls /net/10.45.192.134/JUMP/ENIQ_STATS/ENIQ_STATS/${shipment}/eniq_base_sw/eniq_sw/ | grep -i ^${vdb_mod_rstate_out}
                    Log    ${check_mws_module_for_version}
                    ${mws_modules_status_for_version}=    Run Keyword And Return Status    Should Not Be Empty    ${check_mws_module_for_version}
                    IF    ${mws_modules_status_for_version} == False
                    Append To List    ${modules_mismatch_list}    ${vdb_mod_rstate_out}
                    END
                
            END
        ELSE
           Append To List    ${unavailable_modules_list}    ${element}        
        END
    END
    ${mws_modules_status}=    Run Keyword And Return Status    Should be Empty   ${modules_mismatch_list}
    ${module_status}=    Run Keyword And Return Status    Should Be Empty    ${unavailable_modules_list}
    IF    "${mws_modules_status}" == "True" and "${module_status}"=="True"
        Pass Execution    All modules are available with matching rstates
    ELSE
        Fail    ${unavailable_modules_list} not present in version db file ${\n}${modules_mismatch_list} not matching in mws modules path
    END

Verify platform_Installer Logs for core modules
    ${vdb_modules_path}=    Execute Command    cat /eniq/sw/installer/versiondb.properties | grep -i "module." | cut -d "." -f2
    ${split_module_list}=    Split To Lines    ${vdb_modules_path}  
    ${unavailable_modules_list}=    Create List
    ${modules_mismatch_list}=    Create List
    ${module_files_not_present_list}=    Create List
    FOR    ${element}    IN    @{core_module_list} 
        Log    ${element}  
        ${check_platform_folder}=    Run Keyword And Return Status     Should Contain Match    ${split_module_list}    regexp=^${element}=
        Log    ${check_platform_folder}
        IF    ${check_platform_folder} == True
            ${vdb_mod_with_rstate}=    Execute Command    cat /eniq/sw/installer/versiondb.properties | grep -i "module.${element}=" | cut -d "." -f2
            Log    ${vdb_mod_with_rstate}
            ${vdb_mod_rstate_out}=    Replace String    ${vdb_mod_with_rstate}    =    _  
            ${latest_mod_log_file}=    Execute Command    ls -Art /eniq/log/sw_log/platform_installer/ | grep -i ^${vdb_mod_rstate_out} | tail -1
            Log    ${latest_mod_log_file}
            ${check_file_present}=    Run Keyword And Return Status    Should Not Be Empty    ${latest_mod_log_file}
            IF    ${check_file_present} == True
                ${check_log_file} =    Execute Command    cat /eniq/log/sw_log/platform_installer/${latest_mod_log_file} | grep -i 'Installation failed'    
                ${mws_modules_status}=    Run Keyword And Return Status    Should be Empty    ${check_log_file}
                IF   '${mws_modules_status}' == 'True'
                    Continue For Loop
                ELSE
                    Append To List    ${modules_mismatch_list}    ${vdb_mod_rstate_out}
                END
            ELSE
                Append To List    ${module_files_not_present_list}    ${vdb_mod_rstate_out}    
            END
            
        ELSE
           Append To List    ${unavailable_modules_list}    ${element}        
        END
    END
    ${mws_modules_status}=    Run Keyword And Return Status    Should be Empty   ${modules_mismatch_list}
    ${module_status}=    Run Keyword And Return Status    Should Be Empty    ${unavailable_modules_list}
    ${file_in_mws_path_status}=    Run Keyword And Return Status    Should Be Empty    ${module_files_not_present_list}    
    IF    "${mws_modules_status}" == "True" and "${module_status}"=="True" and "${file_in_mws_path_status}"=="True"
        Pass Execution    No errors found in core module logs
    ELSE
        Fail    ${unavailable_modules_list} not present in version db file ${\n}${module_files_not_present_list} module logs not present in platform_installer path ${\n}${modules_mismatch_list} have errors.
    END  




