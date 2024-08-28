*** Settings ***
Documentation     Testing Symboliclinkcreator
Library           SSHLibrary
Library    String
Library    Process
Library    Collections
Resource    ../../Resources/Keywords/Cli.robot
Resource    ../../Resources/Keywords/Variables.robot
Suite Setup    Connect to physical server as root user with prompt
Suite Teardown    Close All Connections

*** Test Cases ***
Check physical enm_type file is present in the ENIQ-S
    Verify physical enm_type files is present in the ENIQ-S

# Check for physical enm_post_integration log file is present in the ENIQ-S 
#     Verify for physical enm_post_integration log file is present in the ENIQ-S 

Check for stop_fls log file is present in the ENIQ-S 
    Verify stop_fls log files is present in the ENIQ-S 

*** Keywords ***
Verify physical enm_type files is present in the ENIQ-S
    ${enm_file_fls}    Execute Command    cat /eniq/installation/config/fls_conf
    Write    ssh engine
    Read    delay=2s
    Write    cd /eniq/connectd/mount_info/ && ls
    ${enm_file}    Read    delay=2s
    ${y}    Get Regexp Matches    ${enm_file}    eniq_oss_\\d+   
    #${y}     Split Command Line    ${enm_file}
    ${x}    Split Command Line    ${enm_file_fls}
    Should Not Be Empty    ${enm_file_fls}
    FOR    ${element_x}    IN    @{x}
        ${fls_config}    Run Keyword And Return Status    List Should Contain Value    ${y}    ${element_x}
        IF    ${fls_config}
            Set Client Configuration    prompt=REGEXP:\\bieatrcx\\S+\\[\\S+\\]\\s{\\w+}\\s#

            FOR    ${element_y}    IN    @{y}
                IF    '${element_x}' == '${element_y}' 
                    Write    cd /eniq/connectd/mount_info/${element_y} && ls
                    ${enm_oss}    Read Until Prompt    strip_prompt=True
                    ${enm_oss}     Split Command Line    ${enm_oss}
                    FOR    ${element_oss}    IN    @{enm_oss}
                        IF    '${element_oss}' != 'enm_type'
                            Continue For Loop
                        ELSE
                                
                            Write    cat /eniq/connectd/mount_info/${element_y}/${element_oss}
                            ${enm}    Read Until Prompt    strip_prompt=True
                            
                            ${enm}    Convert To Lower Case    ${enm}
                            ${enm}    Strip String    ${enm}
                            ${enm_length}    Get Length    ${enm}
                            IF    '${enm}' == 'penm' or '${enm}' == 'cenm' or '${enm}' == 'venm'
                                Log    <span style="color:green"><b> ENM is integrated.</b></span>    html=True
                            ELSE
                                Run Keyword And Continue On Failure    Fail    Enm is not integrated for ${element_y}.   
                            END
                        END
                
                    END
                
                END
            END
        ELSE
            Fail    FLS conf is not present in mount fls
        END    
        END   

Verify stop_fls log files is present in the ENIQ-S 
    ${stop_fls_log_file}    Execute Command    cd /eniq/log/sw_log/symboliclinkcreator && ls | grep stop_fls | tail -1
    ${fls_error_log}    ${rc}=    Execute Command    awk '/FLS service shutdown is complete/ {data = ""} {data = data $0 RS} END {print data}' /eniq/log/sw_log/symboliclinkcreator/${stop_fls_log_file} | grep -i 'FAILED\\|EXCEPTION\\|warning\\|severe\\|not found\\|failed\\|Error\\|not enabled\\|disable'    return_rc=True    
    ${output_length}    Get Length    ${fls_error_log}
    IF   '${rc}' == '1' and '${output_length}' == '0'
         Log To Console    "No Error in log file"
    ELSE
         Fail    ${fls_error_log}
    END   
Test teardown
    Close All Connections