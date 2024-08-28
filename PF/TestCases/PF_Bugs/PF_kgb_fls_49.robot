*** Settings ***
Documentation    Testing symboliclinkcreator
Library           SSHLibrary
Library        String
Library        Collections
Resource    ../../Resources/Keywords/Engine.robot
Resource    ../../Resources/Keywords/Variables.robot
Resource    ../../Resources/Keywords/Cli.robot
Test Teardown    Close All Connections
Suite Setup    Suite setup steps

*** Variables ***
@{pass}
${host_123}    ieatrcxb8506.athtem.eei.ericsson.se
${root_user}    DmCi
${root_pwd}    ENIQst%123
${port_for_vapp}    22
${user_for_vapp}    dcuser    
${pass_for_vapp}    Dcuser%12
${USERNAME}    pftest
${PASSWORD}    Pftest12
${SERVER}    ieatrcxb8506

*** Test Cases ***
Check for physical Symboliclinkcreator_eniq_oss common file is presence in the EINQ-S and Check for error or exception in Symboliclinkcreator common file
    ${current_date}=    Execute Command    date -d "0 day ago" +"%Y-%m-%d"
    #skip if full upgrade log is not present
    ${check_fullupgfile}=    Execute Command    ls -Art /eniq/local_logs/upgrade/ | grep -i "\\bfullupgrade.txt\\b" | tail -1
    IF    "${check_fullupgfile}" != "${EMPTY}"
        ${get_upgtime}=    Execute Command    cat /eniq/local_logs/upgrade/${check_fullupgfile} | grep -i "${current_date}.*Starting upgrade" | head -1 | grep -oP "\\d{4}-\\d{2}-\\d{2}_\\d{2}.\\d{2}.\\d{2}"
        Log To Console    ${get_upgtime}
        IF    "${get_upgtime}" == "${EMPTY}"
            # ${get_upgtime}=    Get Current Date    result_format=%d.%m %H.%M.%S
            ${upg_start_time}=    Execute Command    date +"%d.%m 00:00:00"
        ELSE    
            ${upg_start_time}=    Convert Date    ${get_upgtime}    date_format=%Y-%m-%d_%H.%M.%S    result_format=%d.%m %H:%M:%S
            Log To Console    ${upg_start_time}
        END
    ELSE
        Skip    full upgrade log not found
    END
    

    ${current_nhlog_date_format}=    Convert Date    ${current_date}    result_format=%Y%m%d
    #nh logs for current date fail the testcase
    # ${get_latest_nh_file}=    Execute Command    sudo ls /ericsson/security/log/Apply_NH_Logs/ | grep -i "${current_nhlog_date_format}.*Apply_Node_Hardening.log"
    ${get_latest_nh_file}=    Execute Command    sudo ls -Art /ericsson/security/log/Apply_NH_Logs/ | grep -iE "\\d+*.*_Apply_Node_Hardening.log" | tail -1
    IF    "${get_latest_nh_file}" != "${EMPTY}"
        ${get_nh_time}=    Execute Command    sudo cat /ericsson/security/log/Apply_NH_Logs/${get_latest_nh_file} | grep -i "rebooting now" | grep -oP "\\d{4}-\\d{2}-\\d{2} \\d{2}:\\d{2}:\\d{2}"
        Log To Console    ${get_nh_time}
        IF    "${get_nh_time}" == "${EMPTY}"
            ${upg_endtime}=    Execute Command    date +"%d.%m 23:59:59"
        ELSE
            ${get_nh_time_new}=    Execute Command    date -d "${get_nh_time} 15 minutes" "+%Y-%m-%d %H:%M:%S"
            Log To Console    ${get_nh_time_new}
            ${upg_endtime}=    Convert Date    ${get_nh_time_new}    date_format=%Y-%m-%d %H:%M:%S    result_format=%d.%m %H:%M:%S
            Log To Console    ${upg_endtime}
        END
    ELSE
        Fail    Apply Nodehardening log not found
        
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
            ${check_log}    ${stderr}=    Execute Command    cat /eniq/log/sw_log/symboliclinkcreator/${check_symbolic} | awk '$1" "$2 < "${upg_start_time}" || $1" "$2 > "${upg_endtime}"' | grep -i "\\bfail\\b\\|\\berror\\b\\|\\bexception\\b\\|\\bcould not\\b\\|\\bnot enabled\\b\\|\\bdisabled\\b\\|\\bnot found\\b\\|\\bindir not found\\b"    return_stderr=True
            Should Be Empty    ${stderr}
            Log To Console    ${check_log}
            ${flserror_log}=    Run Keyword And Return Status    Should Be Empty    ${check_log}
            IF    ${flserror_log} == False
                @{flserror_list}=    Split To Lines    ${check_log}  
                FOR    ${element}    IN    @{flserror_list}
                    Should Contain    ${element}    FileAlreadyExistsException        
                END 
            END
        ELSE
            Skip    ${check_symbolic} file not found for ${current_date}
        END
        END  
    ELSE
        Skip    fls conf data not present
    END
    


    # ${current_nhlog_date_format}=    Convert Date    ${current_date}    result_format=%Y%m%d 
    # ${getlatest_upgdate}=    Execute Command    cat /eniq/local_logs/upgrade/fullupgrade.txt | grep -i "Starting upgrade" | tail -1 | grep -oP "\\d+-\\d+-\\d+"
    # ${get_upgtime}=    Execute Command    cat /eniq/local_logs/upgrade/fullupgrade.txt | grep -i "${getlatest_upgdate}.*Starting upgrade" | head -1 | grep -oP "\\d{4}-\\d{2}-\\d{2}_\\d{2}.\\d{2}.\\d{2}"
    # Log To Console    ${get_upgtime}
    # ${upg_start_time}=    Convert Date    ${get_upgtime}    result_format=%d.%m %H.%M.%S   
    # Log To Console    ${upg_start_time}
    
    # ${get_latest_nh_file}=    Execute Command    sudo ls /ericsson/security/log/Apply_NH_Logs/ | grep -i "${current_nhlog_date_format}.*Apply_Node_Hardening.log"
    # ${get_nh_time}=    Execute Command    sudo cat /ericsson/security/log/Apply_NH_Logs/${get_latest_nh_file} | grep -i "rebooting now" | grep -oP "\\d{4}-\\d{2}-\\d{2} \\d{2}:\\d{2}:\\d{2}"
    # Log To Console    ${get_nh_time}
    # ${nh_end_time}=    Convert Date    ${get_nh_time}    result_format=%d.%m %H.%M.%S  
    # Log To Console    ${nh_end_time}
    # ${nhrestart_end_time}=    Add Time To Date    ${nh_end_time}    15min    date_format=%d.%m %H.%M.%S    result_format=%d.%m %H.%M.%S
    # Log To Console    ${nhrestart_end_time}



 
    # Log To Console    ${current_date}
    # ${fls_conf_data}=    Execute Command    cat /eniq/installation/config/fls_conf
    # @{alias_names}=    Split To Lines    ${fls_conf_data}
    # Set Global Variable    ${alias_names}
    # Log To Console    fls conf data: ${alias_names}
    # FOR    ${fls_alias_name}    IN    @{alias_names}
    #     ${check_symbolic}=    Execute Command    ls -Arth /eniq/log/sw_log/symboliclinkcreator | grep -i "symboliclinkcreator_${fls_alias_name}-${current_date}" | tail -1
    #     IF    "${check_symbolic}" != "${EMPTY}"
    #         Execute Command    command
    #     ELSE
    #         Skip    File not found
    #     END
    # END  
   
   
    # Execute the Command    cd ${symboliclinkcreator}
    # ${latest}=    Get latest file from directory     symboliclinkcreator_eniq_oss_*.log
    # ${latest}    Split String    ${latest}
    # Log To Console    ${latest}
    # ${Verify}    ${rc}    Execute Command    cd ${symboliclinkcreator} && cat ${latest}[0] | grep -iE "fail\|error\|exception\|could not\|not enabled\|disabled\|not found\|indir not found"    return_rc=true
    # IF    ${rc}==0
    #     @{pass}    Split To Lines    ${Verify}  
    #     ${length}    Get Length    ${pass}
    #     FOR    ${element}    IN    @{pass}
    #         Log    ${element}
    #         Should Contain    ${element}    FileAlreadyExistsException
    
    #     END

    # END 

*** Keywords ***
Suite setup steps
    Open connection as root user