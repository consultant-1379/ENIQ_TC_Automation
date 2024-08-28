*** Settings ***
Library    SSHLibrary
Library    RPA.Browser.Selenium
Library    String
Library    Collections
Library    OperatingSystem
Resource    ../../Resources/Keywords/Cli.robot
Resource    ../../Resources/Keywords/Variables.robot
Suite Setup    Open connection as root user
Suite Teardown    Close All Connections


*** Variables ***
${CI_MWS_ISO_MEDIA}
${Shipment}    
@{exception_modules}    runtime    installer    AdminUI    BusyHour    alarmcfg    helpset_stats
    
*** Test Cases ***
Verify latest module updated in versiondb file
    ${vdb_modules_path}=    Execute Command    cat /eniq/sw/installer/versiondb.properties | grep -i "module." | cut -d "." -f2
    ${split_module_list}=    Split To Lines    ${vdb_modules_path}  
    ${unavailable_modules_list}=    Create List
    ${modules_mismatch_list}=    Create List
    FOR    ${element}    IN    @{exception_modules} 
        Log    ${element}  
        ${check_platform_folder}=    Run Keyword And Return Status     Should Contain Match    ${split_module_list}    regexp=^${element}=
        Log    ${check_platform_folder}
        IF    ${check_platform_folder} == True
            ${vdb_mod_with_rstate}=    Execute Command    cat /eniq/sw/installer/versiondb.properties | grep -i "module.${element}=" | cut -d "." -f2
            Log    ${vdb_mod_with_rstate}
            ${vdb_mod_rstate_out}=    Replace String    ${vdb_mod_with_rstate}    =    _  
            ${check_mws_module}=    Execute Command    ls /net/${CI_MWS_ISO_MEDIA}/JUMP/ENIQ_STATS/ENIQ_STATS/${Shipment}/eniq_base_sw/eniq_sw/ | grep -i ${vdb_mod_rstate_out}
            ${mws_modules_status}=    Run Keyword And Return Status    Should Not Be Empty    ${check_mws_module}
            IF    ${mws_modules_status} == False
                Append To List    ${modules_mismatch_list}    ${vdb_mod_rstate_out}
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


Verify platform_Installer Logs for exception modules
    ${vdb_modules_path}=    Execute Command    cat /eniq/sw/installer/versiondb.properties | grep -i "module." | cut -d "." -f2
    ${split_module_list}=    Split To Lines    ${vdb_modules_path}  
    ${unavailable_modules_list}=    Create List
    ${modules_mismatch_list}=    Create List
    ${module_files_not_present_list}=    Create List
    FOR    ${element}    IN    @{exception_modules} 
        Log    ${element}  
        ${check_platform_folder}=    Run Keyword And Return Status     Should Contain Match    ${split_module_list}    regexp=^${element}=
        Log    ${check_platform_folder}

        
        IF    ${check_platform_folder} == True
            IF    "${element}" == "runtime" or "${element}" == "installer"
                ${latest_mod_log_file}=    Execute Command    ls -Art /eniq/log/sw_log/platform_installer/ | grep -i ${element}_[0-9] | tail -1
                Log    ${latest_mod_log_file}
                ${check_file_present}=    Run Keyword And Return Status    Should Not Be Empty    ${latest_mod_log_file}
                IF    ${check_file_present} == True
                    ${check_log_file} =    Execute Command    cat /eniq/log/sw_log/platform_installer/${latest_mod_log_file} | grep -i 'severe\\|failed'  
                    ${mws_modules_status}=    Run Keyword And Return Status    Should be Empty    ${check_log_file}
                    IF   '${mws_modules_status}' == 'True'
                        CONTINUE
                    ELSE
                        Append To List    ${modules_mismatch_list}    ${element}
                    END
                ELSE
                    Append To List    ${module_files_not_present_list}    ${element}    
                END
            ELSE
                ${vdb_mod_with_rstate}=    Execute Command    cat /eniq/sw/installer/versiondb.properties | grep -i "module.${element}=" | cut -d "." -f2
                Log    ${vdb_mod_with_rstate}
                ${vdb_mod_rstate_out}=    Replace String    ${vdb_mod_with_rstate}    =    _  
                ${latest_mod_log_file}=    Execute Command    ls -Art /eniq/log/sw_log/platform_installer/ | grep -i ${vdb_mod_rstate_out} | tail -1
                Log    ${latest_mod_log_file}
                ${check_file_present}=    Run Keyword And Return Status    Should Not Be Empty    ${latest_mod_log_file}
                IF    ${check_file_present} == True
                    ${check_log_file} =    Execute Command    cat /eniq/log/sw_log/platform_installer/${latest_mod_log_file} | grep -i 'severe\\|failed'
                    ${mws_modules_status}=    Run Keyword And Return Status    Should be Empty    ${check_log_file}
                    IF   '${mws_modules_status}' == 'True'
                        CONTINUE
                    ELSE
                        Append To List    ${modules_mismatch_list}    ${vdb_mod_rstate_out}
                    END
                ELSE
                    Append To List    ${module_files_not_present_list}    ${vdb_mod_rstate_out}    
                END
            END    
        ELSE
           Append To List    ${unavailable_modules_list}    ${element}        
        END
    END
    ${mws_modules_status}=    Run Keyword And Return Status    Should be Empty   ${modules_mismatch_list}
    ${module_status}=    Run Keyword And Return Status    Should Be Empty    ${unavailable_modules_list}
    ${file_in_mws_path_status}=    Run Keyword And Return Status    Should Be Empty    ${module_files_not_present_list}    
    IF    "${mws_modules_status}" == "True" and "${module_status}"=="True" and "${file_in_mws_path_status}"=="True"
        Pass Execution    No errors found in module log files
    ELSE
        Fail    ${unavailable_modules_list} not present in version db file ${\n}${module_files_not_present_list} module logs not present in platform_installer path ${\n}${modules_mismatch_list} have errors.
    END  



