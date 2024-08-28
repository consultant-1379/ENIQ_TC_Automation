*** Settings ***
Library             SSHLibrary
Library             String
Library             RPA.Archive
Library             Collections
Resource            ../../Resources/Keywords/Cli.robot
Resource            ../../Resources/Keywords/Variables.robot
Resource            ../../Resources/Keywords/FLS_keywords.robot
Resource            ../../Resources/Keywords/symboliclinkcreator_FLS_keywords.robot
Suite Setup         Suite setup steps for cenm
Suite Teardown      Close All Connections
 
 
*** Variables ***
# ${host_123}         ieatrcxb6080.athtem.eei.ericsson.se
# ${port_for_vapp}    22
# ${root_user}    root
# ${root_pwd}    Eniq@6080
${cenm_status}      False
@{filetypes}    xml    xml.gz
# ${SERVER}    ieatrcxb6080
@{count_of_cenm}
${bulkcm_parsing_loading_status}    False
 
*** Test Cases ***
Checking if alias is cENM or Not
    @{mount_path}    Create List
    ${date}    Execute command    date '+%Y_%m_%d'
    Set Global Variable    ${date}    
    ${mount_path_1}    Execute Command    ls /eniq/connectd/mount_info/
    @{spliting_oss_ref_file}    Split To Lines    ${mount_path_1}
    FOR    ${mount_path_1}    IN    @{spliting_oss_ref_file}
        ${enm_type_file}    Execute Command    ls /eniq/connectd/mount_info/${mount_path_1} | grep -i enm_type
        ${get_length}    Get Length    ${enm_type_file}
        IF    ${get_length}!= 0
            ${enm_type}    Execute Command    cat /eniq/connectd/mount_info/${mount_path_1}/${enm_type_file}
            Log    ${mount_path_1}
            IF    '${enm_type}'=='cENM'
                Set Global Variable    ${cenm_status}    True
                Append To List    ${mount_path}    ${mount_path_1}
            END
        END
    END
    Set Global Variable    ${mount_path}
 
 
Verify TC_03 Verify configuration file update
   
    Skip If    '${cenm_status}'=='False'
    Log To Console    \nfls conf data: ${mount_path}
    FOR    ${fls_alias_name}    IN    @{mount_path}
        ${fls_conf_data}=    Execute Command    cat /eniq/installation/config/fls_conf | grep -i "${fls_alias_name}"
        Should Not Be Empty    ${fls_conf_data}
 
        ${oss_ref_file_output}=    Execute Command    cat /eniq/sw/conf/.oss_ref_name_file | grep -i ${fls_alias_name}
        Log To Console     oss ref name file data: ${oss_ref_file_output}
        Validate command output    ${oss_ref_file_output}    ${fls_alias_name}
        ${nas_ip_ref_file}=    Execute Command    cat /eniq/sw/conf/.oss_ref_name_file | grep -i ${fls_alias_name} | awk '{print $2}'
        Vaildate variable contain data and set global    ${nas_ip_ref_file}
 
 
        ${service_names_file_output}=    Execute Command    cat /eniq/sw/conf/service_names | grep -i ${fls_alias_name}
        Log To Console    service names file data: ${service_names_file_output}
        # Validating nas ip and fls alias name
        Validate output regex   ${service_names_file_output}    ${nas_ip_ref_file}::${fls_alias_name}::${fls_alias_name}
 
 
        ${enmserverdetail_file_output}=    Execute Command    cat /eniq/sw/conf/enmserverdetail
        Validate command output    ${enmserverdetail_file_output}    ${nas_ip_ref_file}
        ${fls_enm_hostname}=    Execute Command    cat /eniq/sw/conf/enmserverdetail | grep -i ${nas_ip_ref_file} | awk '{print $2}'
        Vaildate variable contain data and set global    ${fls_enm_hostname}
        ${fls_enm_hostname_ip}=    Execute Command    ping -c 1 ${fls_enm_hostname} | grep -oE '[0-9]+\.[0-9]+\.[0-9]+\.[0-9]+' | awk 'NR==1'        
        Vaildate variable contain data and set global    ${fls_enm_hostname_ip}
 
 
        ${hosts_file_output}=    Execute Command    cat /etc/hosts | grep -i ${fls_alias_name}
        Log To Console    hosts file fls alias data: ${hosts_file_output}
        # Validating nas ip and fls alias name
        Validate output regex    ${hosts_file_output}    ${nas_ip_ref_file}\\s+${fls_alias_name}\\s+${fls_alias_name}
        ${hosts_file_output}=    Execute Command    cat /etc/hosts | grep -i ${fls_enm_hostname}
        Log To Console    hosts file enm data: ${hosts_file_output}
        # Validating enm hostname and enm hostname ip
        Validate output regex     ${hosts_file_output}    ${fls_enm_hostname_ip}\\s+${fls_enm_hostname}
 
       
    END
 
TC_07 Verify the C# file creation
     Skip If    '${cenm_status}'=='False'
     FOR    ${mount}    IN    @{mount_path}                                                                                                                                                                    
            ${log}    Execute Command    ls /eniq/log/sw_log/symboliclinkcreator | grep -i symboliclinkcreator_${mount}-${date}.log
            ${log_output}    Execute Command    cat /eniq/log/sw_log/symboliclinkcreator/${log} | grep -i "Reference file created successfully"
            ${reference}    Run Keyword And Return Status    Should Contain    ${log_output}    Reference file created successfully                
            ${log_output1}    Execute Command    cat /eniq/log/sw_log/symboliclinkcreator/${log} | grep -i "Creating reference file with format: c#"
            ${creating c#}    Run Keyword And Return Status    Should Contain    ${log_output1}     Creating reference file with format: c#  
            ${log_output2}    Execute Command    cat /eniq/log/sw_log/symboliclinkcreator/${log} | grep -i "Reference file was not creating for the file:"
            ${not creating c#}    Run Keyword And Return Status     Should Not Contain    ${log_output2}    Reference file was not creating for the file:
            IF    "${reference}" == "True" and "${creating c#}"=="True" and "${not creating c#}"=="True"
                Pass Execution    c# files got created.
            ELSE  
                Fail    c# files are not created .      
            END
    END
 
 
 
 
 
TC_10 Verify topology file parsing and loading
    Skip If    '${cenm_status}'=='False'
    FOR    ${mount}    IN    @{mount_path}
        ${engine_logs}    Execute Command    ls /eniq/log/sw_log/engine|grep -i ^INTF_DIM_E.*-${mount}$
        ${INTF_status}=    Run Keyword And Return Status    Should Not Be Empty    ${engine_logs}
        Skip If    ${INTF_status} == False    msg=INTF dir not present
        ${interface_list}=    Split To Lines    ${engine_logs}
        FOR    ${element1}    IN    @{interface_list}
            ${file_logs_check}    Execute Command    ls /eniq/log/sw_log/engine/${element1}| grep -i file-${date}.log
            ${file_status}=    Run Keyword And Return Status    Should Not Be Empty    ${file_logs_check}
                IF    ${file_status} == True
                    ${log_check}    Execute Command    cat /eniq/log/sw_log/engine/${element1}/${file_logs_check}|grep -i 'parsed'
                    ${log_check1}    Execute Command    cat /eniq/log/sw_log/engine/${element1}/${file_logs_check}|grep -i 'failed'
                    ${log_check2}    Execute Command    cat /eniq/log/sw_log/engine/${element1}/${file_logs_check}|grep -i 'duplicate'
                    Should Contain      ${log_check}    parsed
                    Should not Contain    ${log_check1}       failed
                    Should not Contain    ${log_check2}       duplicate
                ELSE
                    skip    file log not present
                END
        END
        ${parsed}    Run Keyword And Return Status    Should Not Be Empty    ${log_check}
            IF    '${parsed}' == 'True'
                ${engine_logs}    Execute Command    ls /eniq/log/sw_log/engine|grep -i ^DIM_E
                ${DIR_status}=    Run Keyword And Return Status    Should Not Be Empty    ${engine_logs}
                Skip If    ${DIR_status} == False    msg=dir not present
                ${interface_list}=    Split To Lines    ${engine_logs}
                FOR    ${element2}    IN    @{interface_list}
                    ${engine_logs_check}    Execute Command    ls /eniq/log/sw_log/engine/${element2}| grep -i engine-${date}.log
                    ${log_check}    Execute Command    cat /eniq/log/sw_log/engine/${element2}/${engine_logs_check}|grep -i 'loaded'
                    Should Contain    ${log_check}       loaded
                END
           
            END
    END
 
 
 
TC_12 Verify the file types .xml, .xml.gz for the c# reference file creation
    Skip If    '${cenm_status}'=='False'
    FOR    ${mount}    IN    @{mount_path}
        @{filetype_not_present}    Create List
       ${log}    Execute Command    ls /eniq/log/sw_log/symboliclinkcreator | grep -i symboliclinkcreator_${mount}-${date}.log
            Log    ${log}
            Should Not Be Empty    ${log}    
            ${log_output1}    Execute Command    cat /eniq/log/sw_log/symboliclinkcreator/${log} | grep -i "Creating reference file with format: c#"
            Log    ${log_output1}
            ${c#file}    Run Keyword And Return Status    Should Not Be Empty    ${log_output1}
            IF    '${c#file}' == 'True'
                FOR    ${element}    IN    @{filetypes}
                   ${check}=    Get Lines Matching Regexp     ${log_output1}    .*\\.${element}$
                    Log    ${check}
                    ${filetype}    Run Keyword And Return Status    Should Not Be Empty    ${check}
                    Log    ${element}
                    IF    '${filetype}' == 'False'
                        Append To List    ${filetype_not_present}    ${element}  
                        Log    ${filetype_not_present}
                         
                    END
                END
                ${filetype_should_be_empty}    Get Length    ${filetype_not_present}
                IF    '${filetype_should_be_empty}'=='0'
                    Pass Execution    All file types are present for c#.
                ELSE
                    Fail    ${filetype_not_present} are not present.    
                END
            ELSE
                Fail    ${log} does not contain creating reference file with c#.                                                  
            END
        END
 
   
TC_15 Verify if the FAN interface is unavailable and the functionality
    Skip if    '${cenm_status}'=='False'    Tc 1 got failed so skipping this TC.
    FOR    ${mount}    IN    @{mount_path}
        ${log}    Execute Command
        ...    ls cd /eniq/log/sw_log/symboliclinkcreator/ | grep -i symboliclinkcreator_${mount}-${date}.log;
        ${log_output1}    ${return_code}    Execute Command
        ...    cat /eniq/log/sw_log/symboliclinkcreator/${log} | grep -i "FAN Response" | tail -1
        ...    return_rc=True
 
        IF    ${return_code}==1
            Fail    FAN is available.
        ELSE
            Should Not Contain
            ...    ${log_output1}
            ...    FAN Response is 500.
        END
    END
 
TC_26 Check that when disable_OSS file exists, , FLS to be on HOLD for a particular oss alias
    Skip if    '${cenm_status}'=='False'
    FOR    ${mount}    IN    @{mount_path}
        ${alias2}=    Execute Command    /eniq/sw/bin/fls status|grep -i ${mount} | cut -d '|' -f2 | awk '{print $1}'
        ${result}=    Split To Lines    ${alias2}
            FOR    ${element}    IN    @{result}
                Log    ${element}
                ${output}=    Execute Command    ls /eniq/connectd/mount_info/${element} | grep -i disable_OSS  
                ${file present}=    Run Keyword And Return Status    Should Not Be Empty    ${output}
                IF    '${file present}'=='True'
                    ${alias_status2}=    Execute command    /eniq/sw/bin/fls status|grep -i ${element} | cut -d '|' -f4 | awk '{print $1}'            
                    should Contain    ${alias_status2}    OnHold
                ELSE          
                    ${alias_status2}=    Execute command    /eniq/sw/bin/fls status|grep -i ${element} |cut -d '|' -f4 | awk '{print $1}'          
                    should Contain    ${alias_status2}    Normal          
                END
            END
    END
 
 
Tc _Verify reference file content failure scenario check
    Skip if    '${cenm_status}'=='False'
    FOR    ${mount}    IN    @{mount_path}
        ${log}    Execute Command    ls /eniq/log/sw_log/engine | grep -i ^INTF_DC_E.*-${mount}$                                                                                                                                        
        @{interfaces}    Split To Lines    ${log}
        FOR    ${element}    IN    @{interfaces}
            Log    ${element}
            ${log1}    Execute Command    ls /eniq/log/sw_log/engine/${element}| grep -i engine-${date}.log
            ${log2}    Execute Command    cat /eniq/log/sw_log/engine/${element}/${log1}| grep -i "Exception mp : null"
            Should Not Contain    ${log2}    Exception mp : null                          
        END  
    END  
 
 
TC_04 verify fls status and integration type from the logs.
    Skip If    '${cenm_status}'=='False'
    Write    su - dcuser
    ${var}    Read Until Prompt    strip_prompt=True
    # ${var}    Read    delay=2s
    Write    fls status
    ${output}    Read Until Prompt    strip_prompt=True
    # ${output}    Read    delay=2s
    Should Contain    ${output}    FLS is running  
    FOR    ${mount}    IN    @{mount_path}
        ${fls_log}    Execute Command    cd /eniq/log/sw_log/symboliclinkcreator && ls -Art symboliclinkcreator_${mount}* | tail -n 1
        ${out}    Run Keyword And Return Status    should not be empty    ${fls_log}
         IF    ${out} == ${True}
             ${enm_type}=    Execute Command   cat /eniq/log/sw_log/symboliclinkcreator/${fls_log} | grep -i "ReferenceFile path"
             Should Contain    ${enm_type}    ReferenceFile path      
         END
     END
 
 
TC_08 Interface log validation for c hash file at info log level
    Skip If    '${cenm_status}'=='False'
    FOR    ${mount}    IN    @{mount_path}
        #${engine_logs}    Execute Command    ls /eniq/log/sw_log/engine|grep -i ${mount}
        #cd /eniq/sw/installer/ && ./installed_techpacks | grep -i --color=never BULK_CM
        Write    cd /eniq/sw/installer/ && ./get_active_interfaces | grep -i --color=never ${mount}
        ${engine_logs}    Read Until Prompt   strip_prompt=True  
        ${interface_list}=    Split To Lines    ${engine_logs}
        FOR    ${element1}    IN    @{interface_list}
            ${engine_logs_check}    Execute Command    ls /eniq/log/sw_log/engine/${element1}| grep -i engine-${date}.log
            ${file_status}=    Run Keyword And Return Status    Should Not Be Empty    ${engine_logs_check}
            IF    ${file_status} == True
            ${log_check}    Execute Command    cat /eniq/log/sw_log/engine/${element1}/${engine_logs_check}|grep -i 'INFO'
            Should Not Contain    ${log_check}       c#
            ELSE
                Skip    engine log not present
 
            END
 
        END
    END


TC_09 verify of ENIQS node assignment table entries
        Skip If    '${cenm_status}'=='False'
        FOR    ${mount}    IN    @{mount_path}            
            # Write    su - dcuser
            # ${var}    Read Until Prompt    strip_prompt=True
            ${output}    Execute Command    cat /eniq/sw/conf/.oss_ref_name_file | grep -i ${mount}
            ${output1}    Split String    ${output}
            ${output2}    Get From List    ${output1}    1          
            ${output3}    Execute Command    cat /eniq/sw/conf/enmserverdetail | grep -i ${output2} | awk '{print $2}' | awk '{split($0, a, ".");print a[1]}'
            ${output8}    Execute Command    cd /eniq/sw/installer;./getPassword.bsh -u DWHREP | cut -d ':' -f2
            Write    echo -e "select count(*) from ENIQS_Node_Assignment where enm_hostname like '${output3}'\\ngo\\n" | isql -P ${output8} -U dwhrep -S repdb -w 1000 -b
            ${text1}    Read Until Prompt    strip_prompt=True
            @{count_of_cenm}    Split To Lines    ${text1}
            IF    ${count_of_cenm}[0]>= 1
               Pass Execution    Passing the testcase  
            ELSE
                Fail    Failing the testcase
            END
        END
 
 
TC_13 Verify for the file types .zip or .tar.gz or .tar.gzip or .asn1
    Skip If    '${cenm_status}'=='False'
    FOR    ${mount}    IN    @{mount_path}
        #Write    su - dcuser
        #${var}    Read Until Prompt    strip_prompt=True
        Write    /eniq/sw/installer/installed_techpacks
        ${output1}    Read Until Prompt    strip_prompt=True
        ${bsstechpack}    Run Keyword And Return Status    Should Contain    ${output1}    DC_E_SCEF
        Log    ${output1}
        IF    '${bsstechpack}'== 'True'
            ${log}    Execute Command
            ...    ls cd /eniq/log/sw_log/symboliclinkcreator/ | grep -i symboliclinkcreator_${mount}-${date}.log;
            ${log_output1}    ${return_code}    Execute Command
            ...    cat /eniq/log/sw_log/symboliclinkcreator/${log} | grep -i "ReferenceFile path is:";
            ...    return_rc=True
 
            IF    ${return_code}==1
                Fail    ReferenceFile path is not present.
            ELSE
                ${log_output1}    ${return_code}    Execute Command
                ...    cat /eniq/log/sw_log/symboliclinkcreator/${log} | grep -ie "filePath is :/ericsson/pmic1/pm_storage/.*.zip";
                ...    return_rc=True
                IF    ${return_code}==1
                    Fail    .zip format not present.
                ELSE
                    ${log_output1}    ${return_code}    Execute Command
                    ...    cat /eniq/log/sw_log/symboliclinkcreator/${log} | grep -ie "Initiating the download method for .zip files" && cat /eniq/log/sw_log/symboliclinkcreator/${log} | grep -ie "File format is : .zip" && cat /eniq/log/sw_log/symboliclinkcreator/${log} | grep -ie "File was downloaded from cloud server at";
                    ...    return_rc=True
                    IF    ${return_code}==1
                        Fail    File Downloading fails
                    ELSE
                        ${log_output1}    Execute Command
                        ...    cat /eniq/log/sw_log/engine/INTF_DC_E_SCEF_SYSTEM-${mount}/engine-${date}.log | grep -i "parsed" && cd /eniq/log/sw_log/engine/DC_E_SCEF/ && cat engine-${date}.log | grep -i "Loaded"
                    END
                END
            END
       
        END
    END
 
 
 TC_30 Bulk CM will not query if techpack is not installed
    Skip if    '${cenm_status}'=='False'
    Set Global Variable    ${Bulk_CM_Techpack_installed}    ${False}
    FOR    ${mount}    IN    @{mount_path}
        # Write    su - dcuser
        # ${var}    Read Until Prompt    strip_prompt=True
        Write   cd /eniq/sw/installer/ && ./installed_techpacks | grep -i --color=never BULK_CM
        ${output1}    Read Until Prompt    strip_prompt=True  
        Log    ${output1}
        #Should Contain    ${output1}    BULK_CM    
        ${file present}=    Run Keyword And Return Status    Should Not Be Empty    ${output1}
        IF    '${file present}'=='True'
            ${output2}    Execute Command    ls /eniq/log/sw_log/symboliclinkcreator | grep -i symboliclinkcreator_${mount} | tail -1
            ${output3}    Execute Command    cat /eniq/log/sw_log/symboliclinkcreator/${output2} | grep -i "Scheduling BulkCMTimertask"
            Should Contain    ${output3}    Scheduling BulkCMTimertask    
            Set Global Variable    ${Bulk_CM_Techpack_installed}    True    
        ELSE
            ${output4}    Execute Command    ls /eniq/log/sw_log/symboliclinkcreator | grep -i symboliclinkcreator_${mount} | tail -1
            ${output5}    Execute Command    cat /eniq/log/sw_log/symboliclinkcreator/${output4} | grep -i "Scheduling BulkCMTimertask"
            Should Not Contain    ${output5}    Scheduling BulkCMTimertask
        END
    END
 
 
TC_14 Execute Bulk CM Functionality
    Skip If    '${cenm_status}'=='False'
    Skip If    '${Bulk_CM_Techpack_installed}'=='False'    Skipping TC because Bulk CM data is not received
 
 
    FOR    ${alias}    IN    @{mount_path}  
        Set Global Variable    ${alias}
 
        # Write    su - dcuser
        # ${var}    Read Until Prompt    strip_prompt=True
        ${Bulk_Cm_Interface_is_active}    Set Variable     False    
        Write   cd /eniq/sw/installer && ./get_active_interfaces | grep -i "INTF_DC_E_BULK_CM ${alias}"
        ${get_active_interface}    Read Until Prompt    strip_prompt=True      
        Log    ${get_active_interface}
        Should Contain    ${get_active_interface}    INTF_DC_E_BULK_CM ${alias}
        Set Global Variable    ${Bulk_Cm_Interface_is_active}    True
        Log To Console    Bulk Cm Interface is active: ${Bulk_Cm_Interface_is_active}
 
        Skip If    '${Bulk_Cm_Interface_is_active}'=='False'    Skipping TC because Bulk CM Interface is not active
           
        Log To Console    Executing Bulk CM Functionality for ${alias}
        Verifying Bulk CM file name    
        Verifying Bulk CM file path    
        Verifying Bulk CM file downloading path    
        Verifying Bulk CM file download status    
        Verifying Bulk CM file parsing    
        Verifying Bulk CM file loading
       
    END
    [Teardown]    Run Keyword If    '${TEST STATUS}'=='PASS'    Set Suite Variable    ${bulkcm_parsing_loading_status}    True             


Verify the bulkcm functionality for 0th hour and 0th minute
    Skip If    '${cenm_status}'=='False'
    Skip If    "${bulkcm_parsing_loading_status}"=="False"
    # ${date}    Execute command    date '+%Y_%m_%d'
    ${pf_filename}=    Execute Command    ls -Art /eniq/sw/conf/ | grep -i "\\bsymboliclinkcreator.properties\\b"
    ${file_status}=    Run Keyword And Return Status    Should Not Be Empty    ${pf_filename}
    IF    ${file_status} == True
        ${check_file_logs}    ${stderr}=    Execute Command    cat /eniq/sw/conf/${pf_filename} | grep -i "BULKCM_DEFAULT_START_INTERVAL_HOURS"    return_stderr=True
        Should Be Empty    ${stderr}
        ${bulkcm_hr_status}=    Run Keyword And Return Status    Should Contain     ${check_file_logs}    00
        ${check_file_logs}    ${stderr}=    Execute Command    cat /eniq/sw/conf/${pf_filename} | grep -i "BULKCM_DEFAULT_START_INTERVAL_MINUTES"    return_stderr=True
        Should Be Empty    ${stderr}
        ${bulkcm_min_status}=    Run Keyword And Return Status    Should Contain     ${check_file_logs}    00
        IF    ${bulkcm_hr_status} == True and ${bulkcm_min_status}==True   
            FOR    ${mount}    IN    @{mount_path}
                ${get_smb_file}=    Execute Command    ls -Art /eniq/log/sw_log/symboliclinkcreator/| grep -i "\\bsymboliclinkcreator_${mount}-${date}.log\\b"
                IF    "${get_smb_file}" != "${EMPTY}"
                    ${chek_symb_file}=    Execute Command    cat /eniq/log/sw_log/symboliclinkcreator/${get_smb_file} | grep -i "Bulk CM file name is" | awk '{print $2}' | cut -d ":" -f 1
                    Should Contain    ${chek_symb_file}    00
                ELSE
                    Fail    Symboliclinkcreator file not present for current date
                END  
            END       
        ELSE
            Skip    Bulkcm hours or mins not equal to 00
        END       
        # Execute Command    cat /eniq/log/sw_log/symboliclinkcreator/symboliclinkcreator_eniq_oss_1-2024_03_20.log | grep -i "Bulk CM file name is" | awk '{print $2}' | cut -d ":" -f 1
    ELSE
        Fail   Symboliclinkcreator properties file not present
    END   
 
 
TC_31 Verify the BSS node file parsing and loading functionality
    Skip if    '${cenm_status}'=='False'
    FOR    ${mount}    IN    @{mount_path}
        # Write    su - dcuser
        # ${var}    Read Until Prompt    strip_prompt=True
        Write    /eniq/sw/installer/installed_techpacks                                                                                                                              
        #Write    ./installed_techpacks
        ${output1}    Read Until Prompt    strip_prompt=True
        Log    ${output1}
        ${bsstechpack}    Run Keyword And Return Status    Should Contain    ${output1}    DC_E_BSS        
        IF    '${bsstechpack}'== 'True'  
            ${Interface}    Execute Command    ls /eniq/log/sw_log/engine | grep -i "INTF_DC_E_BSS_APG-${mount}"
            Log    ${Interface}
            ${INTF_status1}=    Run Keyword And Return Status    Should Not Be Empty    ${Interface}
            Skip If    ${INTF_status1} == False    msg=INTF_DC_E_BSS dir not present  
            # Should Not Be Empty    ${Interface}    
            ${filelog}    Execute Command    ls /eniq/log/sw_log/engine/${Interface} | grep -i "file-${date}.log"
            Log    ${filelog}
            Should Not Be Empty    ${filelog}      
            ${log}    Execute Command    cat /eniq/log/sw_log/engine/${Interface}/${filelog} | grep -i "parsed"
            Log    ${log}
            Should Not Be Empty    ${log}
            ${log1}    Execute Command    cat /eniq/log/sw_log/engine/INTF_DC_E_BSS_APG-${mount}/file-${date}.log | grep -i "failed\\|duplicate"
            Should Be Empty    ${log1}  
            ${log_length}    Get Length    ${log}
            IF    '${log_length}'!='0'
                ${log4}    Execute Command    cat /eniq/log/sw_log/engine/INTF_DC_E_BSS_APG-${mount}/file-${date}.log | grep -i "parsed" | awk '{print $7}'
                @{List1}    Split To Lines    ${log4}
                    FOR    ${element}    IN    @{List1}
                        Log    ${element}
                        Should Start With    ${element}    C
                        Should End With    ${element}    .asn1
                    END                                                
            END
            ${parsed}    Run Keyword And Return Status    Should Not Be Empty    ${log}
                IF    '${parsed}' == 'True'    
                    ${loading}    Execute Command    cat /eniq/log/sw_log/engine/DC_E_BSS/engine-${date}.log | grep -i "loaded"
                    Log    ${loading}
                    Should Contain    ${loading}    loaded
                END    
        ELSE
            Skip    skip the testcase  
        END
    END 

TC_Verify ENM fan service is down when no parsing is happening in server
    Skip if    '${cenm_status}'=='False'
    FOR    ${mount}    IN    @{mount_path}
        ${engine_log}    Execute Command    awk -v date="$(date --date='60 minutes ago' +'%H:%M')" '$2 > date' /eniq/log/sw_log/engine/engine-${date}.log | grep -i "${mount}" | grep -i "parsed" | grep -i "INTF_DC_E_*" | grep -v "\\b0 rows\\b"
        Log    ${engine_log}
        ${parsing}    Run Keyword And Return Status    Should Not Be Empty    ${engine_log}
        IF    '${parsing}'=='False'
            ${engine_logs_check}    Execute Command    cat /eniq/log/sw_log/engine/INTF_DC_E*/engine-${date}.log | grep -i "${mount}" | grep -i "500 Internal Server Error"
            ${file_status}=    Run Keyword And Return Status    Should Not Be Empty    ${engine_logs_check}
            IF    ${file_status} == True
                Pass Execution    Since this line is present "500 Internal Server Error"                    
            ELSE
                Skip    Since this is not present "500 Internal Server Error"
            END
        ELSE
            Skip    Skipping the testcase since parsing is happening in server.          
        END
    END      

 
*** Keywords ***    
Verifying Bulk CM file attribute
    [Arguments]    ${attribute}    
    symboliclinkcreator_FLS_keywords.Execute the Command    cd ${symboliclinkcreator}
    ${file_content}=    symboliclinkcreator_FLS_keywords.Display the contents in the file  cat symboliclinkcreator_${alias}-${date}.log | grep -i "${attribute}"
    Should Contain    ${file_content}    ${attribute}
 
Verifying Bulk CM file name
    Verifying Bulk CM file attribute    Bulk CM file name is    
    Verifying Bulk CM file attribute    AOM    
    Verifying Bulk CM file attribute    .xml.gz    
    Log To Console    Verified Bulk CM file name
 
Verifying Bulk CM file path
    Verifying Bulk CM file attribute    Bulk CM path is    
    Log To Console    Verified Bulk CM file path
 
Verifying Bulk CM file downloading path  
    Verifying Bulk CM file attribute    Bulk CM file will be downloading    
    Log To Console    Verified Bulk CM file downloading path
 
Verifying Bulk CM file download status  
    Verifying Bulk CM file attribute    BulkCM file downloaded successfully    
    Log To Console    Verified Bulk CM file download status
 
Verifying Bulk CM file parsing
    Verifying Bulk CM file parsing from Bulk CM Interfaces    parsed    
    Log To Console    Verified Bulk CM file parsing
 
Verifying Bulk CM file loading
    ${Set_Loaded}=    Execute Command    cat /eniq/log/sw_log/engine/DC_E_BULK_CM/engine-${date}.log | grep -i "Set loaded"
        Should Contain    ${Set_Loaded}    Set loaded
    Log To Console    Verified Bulk CM file loading
 
Verifying Bulk CM file parsing from Bulk CM Interfaces
    [Arguments]    ${attribute}  
    ${Checking_Bulk_CM_Interfaces}=    Execute Command    ls /eniq/log/sw_log/engine | grep -i INTF_DC_E_BULK_CM-${alias}
    @{Bulk_CM_Interfaces}=    Split To Lines    ${Checking_Bulk_CM_Interfaces}
    FOR    ${Bulk_CM_Interface}    IN    @{Bulk_CM_Interfaces}
        ${files_parsed}=    Execute Command    cat /eniq/log/sw_log/engine/${Bulk_CM_Interface}/engine-${date}.log | grep -i "${attribute}"
        Should Contain    ${files_parsed}    ${attribute}
    END
Suite setup steps for cenm
    Open connection as root user
    Set Client Configuration    prompt=REGEXP:${SERVER}\\[[^\\]]+\\]\\s\\{dcuser\\}\\s#:
       
 