*** Settings ***
Documentation    Testing symboliclinkcreator
Library           SSHLibrary
Library        String
Library        Collections
Resource    ../../Resources/Keywords/Engine.robot
Resource    ../../Resources/Keywords/Variables.robot
Resource    ../../Resources/Keywords/Cli.robot
Suite Setup    Open connection as root user
Suite Teardown    Close All Connections


*** Test Cases ***
Check for physical Symboliclinkcreator_eniq_oss common file is presence in the EINQ-S and Check for error or exception in Symboliclinkcreator common file
    ${current_date}=    Execute Command    date +"%Y-%m-%d"
    Log To Console    ${current_date}
    #skip if full upgrade log is not present
    ${check_fullupgfile}=    Execute Command    ls -Art /eniq/local_logs/upgrade/ | grep -i "\\bfullupgrade.txt\\b" | tail -1
    IF    "${check_fullupgfile}" != "${EMPTY}"
        ${get_upgtime}=    Execute Command    cat /eniq/local_logs/upgrade/${check_fullupgfile} | grep -i "${current_date}.*Starting upgrade" | head -1 | grep -oP "\\d{4}-\\d{2}-\\d{2}_\\d{2}.\\d{2}.\\d{2}"
        Log To Console    ${get_upgtime}
        IF    "${get_upgtime}" == "${EMPTY}"
            # ${get_upgtime}=    Get Current Date    result_format=%d.%m %H.%M.%S
            ${upg_start_time}=    Execute Command    date +"%d.%m 23:59:59"
        ELSE    
            ${upg_start_time}=    Convert Date    ${get_upgtime}    date_format=%Y-%m-%d_%H.%M.%S    result_format=%d.%m %H:%M:%S
            Log To Console    ${upg_start_time}
        END
    ELSE
        Skip    full upgrade log not found
    END
    

    ${current_nhlog_date_format}=    Convert Date    ${current_date}    result_format=%Y%m%d
    ${get_latest_nh_file}=    Execute Command    sudo ls /ericsson/security/log/Apply_NH_Logs/ | grep -i "${current_nhlog_date_format}.*Apply_Node_Hardening.log" | tail -1
    # ${get_latest_nh_file}=    Execute Command    sudo ls -Art /ericsson/security/log/Apply_NH_Logs/ | grep -iE "\\d+*.*_Apply_Node_Hardening.log" | tail -1
    IF    "${get_latest_nh_file}" != "${EMPTY}"
        ${get_nh_time}=    Execute Command    sudo cat /ericsson/security/log/Apply_NH_Logs/${get_latest_nh_file} | grep -i "rebooting now" | tail -1 | grep -oP "\\d{4}-\\d{2}-\\d{2} \\d{2}:\\d{2}:\\d{2}"
        Log To Console    ${get_nh_time}
        IF    "${get_nh_time}" == "${EMPTY}"
            ${upg_endtime}=    Execute Command    date +"%d.%m 00:00:00"
        ELSE
            ${get_nh_time_new}=    Execute Command    date -d "${get_nh_time} 60 minutes" "+%Y-%m-%d %H:%M:%S"
            Log To Console    ${get_nh_time_new}
            ${upg_endtime}=    Convert Date    ${get_nh_time_new}    date_format=%Y-%m-%d %H:%M:%S    result_format=%d.%m %H:%M:%S
            Log To Console    ${upg_endtime}
        END
    ELSE
        ${upg_endtime}=    Execute Command    date +"%d.%m 00:00:00"    
    END
    
    
    ${fls_conf_data}=    Execute Command    cat /eniq/installation/config/fls_conf
    @{alias_names}=    Split To Lines    ${fls_conf_data}
    ${check_fls_conf_list}=    Run Keyword And Return Status    Should Not Be Empty    ${alias_names}
    Set Global Variable    ${alias_names}
    Log To Console    fls conf data: ${alias_names}
    IF    ${check_fls_conf_list} == True
        FOR    ${fls_alias_name}    IN    @{alias_names}
        ${smb_current_date}=    Convert Date    ${current_date}    result_format=%Y_%m_%d
        ${check_symbolic}=    Execute Command    ls -Arth /eniq/log/sw_log/symboliclinkcreator | grep -i "symboliclinkcreator_${fls_alias_name}-${smb_current_date}" | tail -1
        IF    "${check_symbolic}" != "${EMPTY}"
            ${check_log}    ${stderr}=    Execute Command    cat /eniq/log/sw_log/symboliclinkcreator/${check_symbolic} | awk '$1" "$2 < "${upg_start_time}" || $1" "$2 > "${upg_endtime}"' | grep -i "CertPathValidatorException\\|SunCertPathBuilderException\\|\\bsevere\\b"    return_stderr=True
            Should Be Empty    ${stderr}
            Should Be Empty    ${check_log}


            ${check_repdb_error_log}=    Execute Command    cat /eniq/log/sw_log/symboliclinkcreator/${check_symbolic} | awk '$1" "$2 < "${upg_start_time}" || $1" "$2 > "${upg_endtime}"' | grep -i "Exception in getNodeList methodnull"
            ${repdb_error_status}=    Run Keyword And Return Status    Should Be Empty    ${check_repdb_error_log}
            IF    ${repdb_error_status} == False
                # ${get_repdb_errors}=    Execute Command    cat /eniq/log/sw_log/symboliclinkcreator/demofls.log | grep -i "Exception in getNodeList methodnull"
                ${repdb_errors_list}=    Split To Lines    ${check_repdb_error_log}
                ${list_length}=    Get Length    ${repdb_errors_list}
                IF    ${list_length} >= 5
                    FOR    ${repdb_element}    IN    @{repdb_errors_list}

                        ${repdb_exception_time}=    Execute command    echo "${repdb_element}" | awk '{print $2}'
                        ${repdbexp_hour}=    Execute command    echo ${repdb_exception_time} | cut -d':' -f1
                        ${repdbexp_minute}=    Execute command    echo ${repdb_exception_time} | cut -d':' -f2
                        ${rounded_minute}=    Execute command    echo "$((${repdbexp_minute} / 15 * 15))"
                        ${repdb_exp_start_time}=    Execute command    date -d "${repdbexp_hour}:${rounded_minute}:00" +"%H:%M:%S"
                        ${repdb_exp_end_time}=    Execute command    date -d "${repdb_exp_start_time} 15 minutes" +"%H:%M:%S"
                        #${repdb_exception_count}=    Execute command    cat /eniq/log/sw_log/symboliclinkcreator/${check_symbolic} | awk '$2 >= "${repdb_exp_start_time}" && $2 <= "${repdb_exp_end_time}"' | grep -i "Exception in getNodeList methodnull" | wc -l
                        ${repdb_exception_count}=    Execute command    cat /eniq/log/sw_log/symboliclinkcreator/${check_symbolic} | awk '$2 >= "${repdb_exp_start_time}" && $2 < "${repdb_exp_end_time}"' | grep -i "Exception in getNodeList methodnull" | wc -l
                        IF    ${repdb_exception_count} < 5 
                            Log   Testcase passed
                        ELSE
                            Fail    repdb exception counts are more than 4 in 15 min interval
                        END    
        
                    END
                ELSE
                    Log    Testcase passed
                END    
            END
        ELSE
            Skip    ${check_symbolic} file not found for ${current_date}
        END
        END  
    ELSE
        Skip    fls conf data not present
    END
    