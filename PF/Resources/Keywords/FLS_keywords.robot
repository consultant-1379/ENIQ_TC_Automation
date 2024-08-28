

*** Keywords ***
Verify file is present
    [Arguments]    ${file_args}
    Should Not Be Empty    ${file_args}

Getting latest file from the folder
    [Arguments]    ${folder_name}    ${file_name}
    ${getting_latest_file}=    Execute Command    ls ${folder_name}|grep ${file_name}|tail -1
    Log To Console    ${getting_latest_file}
    [Return]    ${getting_latest_file}

Opening the fls latest file and searching for failure
    [Arguments]    ${latest_file}
    ${fls_error_log}    ${rc}=    Execute Command    awk '/FLS is running/ {data = ""} {data = data $0 RS} END {print data}' /eniq/log/sw_log/licensemanager/${latest_file} |grep -i 'FAILED\\|EXCEPTION\\|warning\\|severe\\|not found\\|failed\\|Error\\|not enabled\\|disable'    return_rc=True    
    ${output_length}    Get Length    ${fls_error_log}
    IF   '${rc}' == '1' and '${output_length}' == '0'
         Log To Console    "No Error in log file"
    ELSE
         Fail    ${fls_error_log}
    END
    Log To Console    ${fls_error_log}
    [Return]    ${fls_error_log}

verify logs should not contain faliure
    [Arguments]    ${failure_logs}
    Should Be Empty    ${failure_logs}

Getting the password of truststore file
    Write     cd /eniq/sw/installer; ./getPassword.bsh -u keystore | cut -d ':' -f2 |awk '{print $1}'
    ${path1}    Read    delay=2s
    ${path}    Should Match Regexp    ${path1}    \\b\\w*\\b
    Log To Console    ${path}
    [Return]    ${path}

Verify the validity of fls license in truststore file
    ${password}    Getting the password of truststore file
    Write    /eniq/sw/runtime/jdk/bin/keytool -list -v -keystore /eniq/sw/runtime/jdk/jre/lib/security/truststore.ts -storepass ${password} | grep -i 'valid'| cut -d " " -f 10-
    ${verify}    Read Until prompt    strip_prompt=True
    Should Not Be Empty    ${verify}
    @{dates}    Split To Lines    ${verify}
    FOR    ${element}    IN    @{dates}
        ${converted_date}    Execute Command    date --date="${element}" +"%Y/%m/%d"
        Log To Console    ${converted_date}
        ${current_date}=    Execute Command    date +"%Y/%m/%d"   
        Log To Console    ${current_date}
        IF     '${converted_date}' < '${current_date}'
            Fail   Validity expired    
        ELSE
            Log To Console    Validity is there
        END
    END

Verify if pmdata pmic1 and pmic2 exist under df -hk
    Set Client Configuration    prompt=ieatrcx    timeout=10s
    Write    cat /eniq/installation/config/fls_conf
    ${alias1}    Read Until Prompt    strip_prompt=True
    ${alias_list}    Get Regexp Matches    ${alias1}    \\beniq_oss_[0-9]+\\b
    ${alias}    Get From List    ${alias_list}    0
    ${pm_data}    Set Variable    /eniq/data/pmdata/${alias}
    ${pmic1_data}    Set Variable    /eniq/data/importdata/${alias}/pmic1
    ${pmic2_data}    Set Variable    /eniq/data/importdata/${alias}/pmic2
    Write    df -hk 
    ${data3}    Read    delay=2s
    Should Contain    ${data3}    ${pm_data}
    Should Contain Any    ${data3}    ${pmic1_data}    ${pmic2_data}

Verify if pmdata pmic1 and pmic2 exist under df -hk in MB and MR server
    Open connection as root user 
    Set Client Configuration    prompt=ieatrcx    timeout=10s
    Write    ssh engine
    ${output}=    Read    delay=2s    
    ${Engine_status_output}=    Run Keyword And Return Status    Should Contain    ${output}    Are you sure you want to continue connecting (yes/no)?  
    IF    ${Engine_status_output} == True
        Grant permission    yes
        Write    cat /eniq/installation/config/fls_conf
        ${alias1}    Read Until Prompt    strip_prompt=True
        ${alias_list}    Get Regexp Matches    ${alias1}    \\beniq_oss_[0-9]+\\b
        ${alias}    Get From List    ${alias_list}    0
        ${pm_data}    Set Variable    /eniq/data/pmdata/${alias}
        ${pmic1_data}    Set Variable    /eniq/data/importdata/${alias}/pmic1
        ${pmic2_data}    Set Variable    /eniq/data/importdata/${alias}/pmic2
        Write    df -hk 
        ${data3}    Read    delay=2s
        Should Contain    ${data3}    ${pm_data}
        Should Contain Any    ${data3}    ${pmic1_data}    ${pmic2_data}
    ELSE
        Write    cat /eniq/installation/config/fls_conf
        ${alias1}    Read Until Prompt    strip_prompt=True
        ${alias_list}    Get Regexp Matches    ${alias1}    \\beniq_oss_[0-9]+\\b
        ${alias}    Get From List    ${alias_list}    0
        Set Global Variable    ${alias}
        ${pm_data}    Set Variable    /eniq/data/pmdata/${alias}
        ${pmic1_data}    Set Variable    /eniq/data/importdata/${alias}/pmic1
        ${pmic2_data}    Set Variable    /eniq/data/importdata/${alias}/pmic2
        Write    df -hk 
        ${data3}    Read    delay=2s
        Should Contain    ${data3}    ${pm_data}
        Should Contain Any    ${data3}    ${pmic1_data}    ${pmic2_data}
    END
    
Verify validity of fls license in adminUI Webpage
    @{expiry_date}    Get WebElements   xpath://td[2]//table//td[3]
    FOR    ${element}    IN    @{expiry_date}
        ${value}    Get Text    ${element}
        Log To Console    ${value}
        ${converted_date}    Convert Date    ${value}    date_format=%d/%m/%Y    result_format=%Y/%m/%d
        Log To Console    ${Converted_date}
        ${current_date}=    Get Current Date    result_format=%Y/%m/%d
        Log To Console    ${current_date}
        IF     '${converted_date}' < '${current_date}'
            Fail   Validity expired    
        ELSE
            Log To Console    Validity is there
        END
        
    END

verify the status of fls when engine is stopped
    ${alias2}    Execute command    cat /eniq/installation/config/fls_conf
    Log To Console    ${alias2}
    ${stopping_engine}    Execute Command    /eniq/sw/bin/engine stop   
    Sleep    40s
    ${alias_status2}=    Execute command    /eniq/sw/bin/fls status|grep -i ${alias2} | cut -d '|' -f4 | awk '{print $1}'
    Log To Console    ${alias_status2}
    Should Be Equal    ${alias_status2}    OnHold
    ${fls_status2}=    Execute command    /eniq/sw/bin/fls status| grep -i 'FLS is running'
    Should Be Equal    ${fls_status2}    FLS is running
    ${starting_engine}    Execute Command    /eniq/sw/bin/engine start 
    Sleep    30s 
    ${alias_status}=    Execute command    /eniq/sw/bin/fls status|grep -i ${alias2} | cut -d '|' -f4 | awk '{print $1}'
    Log To Console    ${alias_status}
    Should Be Equal    ${alias_status}    Normal
    ${fls_status3}=    Execute command    /eniq/sw/bin/fls status| grep -i 'FLS is running'
    Should Be Equal    ${fls_status3}    FLS is running      

Verify status when fls is stopped
    ${alias}    Execute command    cat /eniq/installation/config/fls_conf
    Log To Console    ${alias}
    ${making_alias_stop}    Execute Command    /eniq/sw/bin/fls stop
    Sleep    5s 
    ${fls_status}=    Execute command    /eniq/sw/bin/fls status| grep -i 'FLS is not running'
    Should Be Equal    ${fls_status}    FLS is not running  

Verify status when fls is started
    ${alias2}    Execute command    cat /eniq/installation/config/fls_conf
    Log To Console    ${alias2}
    ${making_alias_normal}    Execute Command    /eniq/sw/bin/fls start
    Sleep    5s
    ${alias_status2}=    Execute command    /eniq/sw/bin/fls status|grep -i ${alias2} | cut -d '|' -f4 | awk '{print $1}'
    Log To Console    ${alias_status2}
    Should Be Equal    ${alias_status2}    Normal
    ${fls_status2}=    Execute command    /eniq/sw/bin/fls status| grep -i 'FLS is running'
    Should Be Equal    ${fls_status2}    FLS is running  

Verify status when fls is restarted
    ${alias}    Execute command    cat /eniq/installation/config/fls_conf
    Log To Console    ${alias}
    ${making_alias_restart}    Execute Command    /eniq/sw/bin/fls restart
    Sleep    5s 
    ${alias_status}=    Execute command    /eniq/sw/bin/fls status|grep -i ${alias} | cut -d '|' -f4 | awk '{print $1}'
    Log To Console    ${alias_status}
    Should Be Equal    ${alias_status}    Normal
    ${fls_status}=    Execute command    /eniq/sw/bin/fls status| grep -i 'FLS is running'
    Should Be Equal    ${fls_status}    FLS is running       

Changing fls status as OnHold 
    ${alias}    Execute command    cat /eniq/installation/config/fls_conf
    Log To Console    ${alias}
    ${making_alias_onhold}    Execute Command    /eniq/sw/bin/fls -e changeProfile -o ${alias} -p OnHold
    Sleep    5s 

Verifying fls status changed to OnHold and fls is running
    ${alias}    Execute command    cat /eniq/installation/config/fls_conf
    Log To Console    ${alias}
    ${alias_status}=    Execute command    /eniq/sw/bin/fls status|grep -i ${alias} | cut -d '|' -f4 | awk '{print $1}'
    Log To Console    ${alias_status}
    Should Be Equal    ${alias_status}    OnHold
    ${fls_status}=    Execute command    /eniq/sw/bin/fls status| grep -i 'FLS is running'
    Should Be Equal    ${fls_status}    FLS is running

Changing fls status as Normal 
    ${alias2}    Execute command    cat /eniq/installation/config/fls_conf
    Log To Console    ${alias2}
    ${making_alias_normal}    Execute Command    /eniq/sw/bin/fls -e changeProfile -o ${alias2} -p Normal 
    Sleep    5s

Verifying fls status changed to Normal and fls is running
    ${alias}    Execute command    cat /eniq/installation/config/fls_conf
    Log To Console    ${alias}
    ${alias_status2}=    Execute command    /eniq/sw/bin/fls status|grep -i ${alias} | cut -d '|' -f4 | awk '{print $1}'
    Log To Console    ${alias_status2}
    Should Be Equal    ${alias_status2}    Normal
    ${fls_status2}=    Execute command    /eniq/sw/bin/fls status| grep -i 'FLS is running'
    Should Be Equal    ${fls_status2}    FLS is running   

Validate command output
    [Arguments]    ${output_args}    ${expected_result_args}
    Should Contain    ${output_args}    ${expected_result_args}    ignore_case=True

Validate output regex
    [Arguments]    ${output_regex_args}    ${exp_result_regex_args}
    Should Match Regexp    ${output_regex_args}    ${exp_result_regex_args}    

Vaildate variable contain data and set global
    [Arguments]    ${var_output_args}    
    Should Not Be Empty    ${var_output_args}
    Set Global Variable    ${var_output_args}  

Verify eniq.xml is present in the ENIQ-S
    ${eniq_file}    Execute command    cd /eniq/sw/conf/ && ls -lrth eniq.xml
    ${eniqstatus_dcuser}    Evaluate    '-rwxr-xr-x. 1 dcuser' in '${eniq_file}'
    ${eniqstatus_filename}    Evaluate    'eniq.xml' in '${eniq_file}'
    IF    '${eniqstatus_dcuser}' == 'True' and '${eniqstatus_filename}' == 'True'
        Log To Console   Eniq.xml present in ENIQ-S
    ELSE
        Fail    Eniq.xml not present in ENIQ-S
    END

Verify physical NodeTechnologyMapping file is present in the ENIQ-S
    ${node_file}    Execute command    cd /eniq/sw/conf/ && ls -lrth NodeTechnologyMapping.properties
    ${nodestatus_dcuser}    Evaluate    '-rwxr-xr-x. 1 dcuser' in '${node_file}'
    ${nodestatus_filename}    Evaluate    'NodeTechnologyMapping.properties' in '${node_file}'
    IF    '${nodestatus_dcuser}' == 'True' and '${nodestatus_filename}' == 'True'
        Log To Console   NodeTechnologyMapping file present in ENIQ-S
    ELSE
        Fail    NodeTechnologyMapping file not present in ENIQ-S
    END

Verify physical NodeDataMapping.properties file is present in the ENIQ-S
    ${nodedata_file}    Execute command    cd /eniq/sw/installer/ && ls -lrth NodeDataMapping.properties
    ${nodedatastatus_dcuser}    Evaluate    '-rwxr-xr-x. 1 dcuser' in '${nodedata_file}'
    ${nodedatastatus_filename}    Evaluate    'NodeDataMapping.properties' in '${nodedata_file}'
    IF    '${nodedatastatus_dcuser}' == 'True' and '${nodedatastatus_filename}' == 'True'
        Log To Console   NodeDataMapping properties file present in ENIQ-S
    ELSE
        Fail    NodeDataMapping properties file not present in ENIQ-S
    END

Verify physical NodeTypeDataTypeMapping.properties file is present in the ENIQ-S
    ${nodetypedata_file}    Execute command    cd /eniq/sw/installer/ && ls -lrth NodeTypeDataTypeMapping.properties
    ${nodetypedatastatus_dcuser}    Evaluate    '-rwxr-xr-x. 1 dcuser' in '${nodetypedata_file}'
    ${nodetypedatastatus_filename}    Evaluate    'NodeTypeDataTypeMapping.properties' in '${nodetypedata_file}'
    IF    '${nodetypedatastatus_dcuser}' == 'True' and '${nodetypedatastatus_filename}' == 'True'
        Log To Console   NodeTypeDataTypeMapping properties file present in ENIQ-S
    ELSE
        Fail    NodeTypeDataTypeMapping properties file not present in ENIQ-S
    END

Verify for physical enm_post_integration log file is present in the ENIQ-S 
    ${check_file_present}    ${rc}    Execute Command    ls /eniq/log/sw_log/symboliclinkcreator/enm_post_integration_*.log    return_rc=True   
    ${length_of_file}    Get Length    ${check_file_present}
    IF    '${length_of_file}' == '0' and '${rc}' == '2'
        ${checkfile_archive}    Execute Command    cd /eniq/log/sw_log/symboliclinkcreator/ && for f in *.zip; do unzip -l $f | grep enm_post_integration && echo $f; done
        ${split_checkfile}    Split String From Right    ${checkfile_archive}    \n
        ${cat_archivefile}    ${rc}    Execute Command    cd /eniq/log/sw_log/symboliclinkcreator && unzip -p ${split_checkfile}[-1] enm_post_integration*.log | grep -i 'FAILED\\|EXCEPTION\\|warning\\|severe\\|not found\\|failed\\|Error\\|not enabled\\|disable'    return_rc=True
        ${output_length}    Get length    ${cat_archivefile}
        IF   '${rc}' == '1' and '${output_length}' == '0'
            Log To Console    "No Error in log file"
        ELSE
            Fail    ${cat_archivefile}
        END
    ELSE
        ${cat_filepresent}    ${rc}    Execute Command    cat /eniq/log/sw_log/symboliclinkcreator/enm_post_integration_*.log | grep -i 'FAILED\\|EXCEPTION\\|warning\\|severe\\|not found\\|failed\\|Error\\|not enabled\\|disable'    return_rc=True
        ${output_length}    Get length    ${cat_filepresent}
        IF   '${rc}' == '1' and '${output_length}' == '0'
            Log To Console    "No Error in log file"
        ELSE
            Fail    ${cat_filepresent}
        END
    END

Verify stop_fls log file is present in the ENIQ-S 
    ${stop_fls_log_file}    Execute Command    cd /eniq/log/sw_log/symboliclinkcreator && ls | grep stop_fls | tail -1
    ${fls_error_log}    ${rc}=    Execute Command    awk '/FLS service shutdown is complete/ {data = ""} {data = data $0 RS} END {print data}' /eniq/log/sw_log/symboliclinkcreator/${stop_fls_log_file} | grep -i 'FAILED\\|EXCEPTION\\|warning\\|severe\\|not found\\|failed\\|Error\\|not enabled\\|disable'    return_rc=True    
    ${output_length}    Get Length    ${fls_error_log}
    IF   '${rc}' == '1' and '${output_length}' == '0'
         Log To Console    "No Error in log file"
    ELSE
         Fail    ${fls_error_log}
    END

Verify physical enm_type file is present in the ENIQ-S
    ${enm_file_fls}    Execute Command    cat /eniq/installation/config/fls_conf
    ${enm_file}    Execute command    cd /eniq/connectd/mount_info/ && ls
    ${y}     Split Command Line    ${enm_file}
    ${x}    Split Command Line    ${enm_file_fls}
    Should Not Be Empty    ${enm_file_fls}
    FOR    ${element_x}    IN    @{x}
        ${fls_config}    Run Keyword And Return Status    List Should Contain Value    ${y}    ${element_x}
        IF    ${fls_config}
            FOR    ${element_y}    IN    @{y}
                IF    '${element_x}' == '${element_y}' 
                    ${enm_oss}    Execute Command    cd /eniq/connectd/mount_info/${element_y} && ls
                    ${enm_oss}     Split Command Line    ${enm_oss}
                    FOR    ${element_oss}    IN    @{enm_oss}
                        IF    '${element_oss}' != 'enm_type'
                            Continue For Loop
                        ELSE
                            ${enm}    Execute Command    cat /eniq/connectd/mount_info/${element_y}/${element_oss}
                            ${enm}    Convert To Lower Case    ${enm}
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
    
Open clearcasevobs
    ${chrome_options}=    Evaluate    sys.modules['selenium.webdriver'].ChromeOptions()    sys
    Call Method    ${chrome_options}    add_argument    --ignore-certificate-errors
    Log    ${EXEC_DIR}
    RPA.Browser.Selenium.Create Webdriver    Chrome    executable_path=${EXEC_DIR}/PF/Resources/Drivers/chromedriver.exe    chrome_options=${chrome_options}
    RPA.Browser.Selenium.Go To    ${clearcase_url}eniqdel
    Sleep    5s
    RPA.Browser.Selenium.Maximize Browser Window   
    Click Link    //body//tr[last()-1]//td[2]//a
    Click Link    //body//tr[last()-1]//td[2]//a
    ${loc}    Get Location
    Go To    ${loc}SOLARIS_baseline.html

Getting the latest module and Rstate of fls from clearcase page	
	${temp}=    Get Element Attribute    //table//a[text()='${module}']    href
    Set Global Variable    ${temp}
    ${fls_name}=    Fetch From Right    ${temp}    /
    Log To Console    ${fls_name}
    ${fls_names}    Split String From Right    ${fls_name}    .    
    Log To Console    ${fls_name}
    ${fls_name}    Replace String    ${fls_names}[0]    _R    -R
    Log To Console    ${fls_name}
    Set Global Variable    ${fls_name}
    ${fls_name1}    Replace String    ${fls_names}[0]    _R    =R   
    Set Global Variable    ${fls_name1} 
    Log To Console    ${fls_name1}
    ${rstate}    Get Text    //table//a[text()='${module}']/../following-sibling::td[3]
    Log To Console    ${rstate}
    Set Global Variable    ${rstate}
    ${product_number}    Get Text    //table//a[text()='${module}']/../following-sibling::td[2]
    Log To Console    ${product_number}
    ${prod_label}    Set Variable    ${product_number}-${rstate}
    Log To Console    ${prod_label}
    Set Global Variable    ${prod_label}
	
Getting the latest module and Rstate of fls from Server
	${version_prop}    ${rc}    Execute Command    cat /eniq/sw/platform/${fls_name}/install/version.properties | grep -i '${prod_label}'    return_rc=True
    set global Variable    $rc
	
Verifying if latest fls module is already installed on server
	Skip If    $rc==0    ${\n}Skipping the downloading since latest ${module} is already present in the server.
	
Downloading latest fls module if not installed on server
	Execute Command    cd /eniq/sw/installer ; wget -nc ${temp}
	
Installing latest fls module if not installed on server
	${zip_name}    Split String From Right    ${temp}    /
    Execute Command    cd /eniq/sw/installer ; chmod u+x ${zip_name}[-1] 
    ${output}    Execute Command    cd /eniq/sw/installer ; ./platform_installer ${zip_name}[-1] 
    ${failed}    Evaluate    'failed' in '''${output}'''    
    IF    ${failed}
        Fail    *HTML* <span style="color:red"><b>${module} installation Failed.</b></span>${\n}${output}
    ELSE
        Log    <span style="color:green"><b>${module} installed Successfully.${\n}Proceeding with log verification.</b></span>    html=True
    END
	
Verifying if latest fls module got installed on server
	${out}    Execute Command    cat /eniq/sw/installer/versiondb.properties | grep -i ${module}=
    ${latest}    Evaluate    '${rstate}' in '''${out}'''
    IF    ${latest}
        Log    <span style="color:green"><b>Latest ${module} rstate is present in versiondb.properties file.</b></span>    html=True
    ELSE
        Fail    *HTML* <span style="color:red"><b>${module} latest rstate not matching in versiondb.properties file.</b></span>${\n}${out}
    END
	
Verifying if latest fls module is present on adminUI page.
	Select From List By Label    //select[@name="command"]    Installed modules
    Click Button    Start
    Element should Contain    //input[@value='Start']/following::table[1]//td    ${fls_name1}   

Getting latest fls log file and verifying no error should be there
	${zip_name}    Split String From Right    ${temp}    /
    ${out}    ${rc}    Execute Command   cd /eniq/log/sw_log/platform_installer; filename=$(ls -Art ${zip_name}[-1]*.log | tail -n 1); cat $filename | grep -i "warning\|exception\|severe\|not found\|error"    return_rc=True
    IF    ${rc} == 1
        Log    <span style="color:green"><b>No negative keywords are found in ${zip_name}[-1].log file.</b></span>    html=True
    ELSE
        Fail    *HTML* <span style="color:red"><b>Negative keywords found in ${zip_name}[-1].log file.</b></span>${\n}${out}
    END

Opening the DeleteSymlinkFile latest file and searching for failure
    [Arguments]    ${latest_file}
    ${DeleteSymlinkFile_error_log}=    Execute Command    cat ${symboliclink_folder}${latest_file}|grep -i 'FAILED\\|EXCEPTION\\|warning\\|severe\\|not found\\|failed\\|Error\\|not enabled\\|disable\|'
    Log To Console    ${DeleteSymlinkFile_error_log}
    [Return]    ${DeleteSymlinkFile_error_log}

Verify deleteSymlink file should be present
    ${checking_file}    Execute Command    ls /eniq/log/sw_log/symboliclinkcreator/ | grep -i DeleteSymlinkFile*
    Should Not Be Empty    ${checking_file}

Opening the DeleteSymlinkFile latest file ad checking file is getting deleted
    [Arguments]    ${latest_file}
    ${DeleteSymlinkFile_error_log}=    Execute Command    cat ${symboliclink_folder}${latest_file}
    Log To Console    ${DeleteSymlinkFile_error_log}
    [Return]    ${DeleteSymlinkFile_error_log}	
    
Verifying if delete symlink log file contain zero older file
    ${latest_file}=    Getting latest file from the folder    ${symboliclink_folder}    ${latest_symboliclink_Delete_log_file}
    ${latest_file1}=    Execute Command    cat ${symboliclink_folder}${latest_file} | grep -i Total 
    Should Not Be Empty    ${latest_file1}

	
