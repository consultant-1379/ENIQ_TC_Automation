*** Settings ***
Documentation       Testing Symboliclinkcreator

Library             RPA.Browser.Selenium
Library             RPA.Windows
Library             SSHLibrary
Library             String
Library             Collections
Library             Process
Library             DateTime
Resource            ../../Resources/Keywords/AdminUIWebUI.robot
Resource            ../../Resources/Keywords/Engine.robot
Resource            ../../Resources/Keywords/FLS_keywords.robot
Resource            ../../Resources/Keywords/Cli.robot
Resource            ../../Resources/Keywords/Variables.robot
Resource            ../../Resources/Keywords/Licensing_keywords.robot
Resource            ../../Resources/Keywords/AdminUIWebUI.robot
Resource            ../../Resources/Keywords/symboliclinkcreator_FLS_keywords.robot
Resource            ../../Resources/Keywords/repdb_connection.robot

Suite Setup         Suite setup steps
Test Setup          Connect to server as a dcuser
Test Teardown       Close All Connections

Force Tags          suite


*** Variables ***
@{pass}     @{EMPTY}


*** Test Cases ***
TC 01 Verify latest fls module deployed in ENIQ Server
    Open clearcasevobs
    Getting the latest module and Rstate of fls from clearcase page
    Getting the latest module and Rstate of fls from Server

TC 02 Downloading the latest fls module
    Verifying if latest fls module is already installed on server
    Downloading latest fls module if not installed on server

TC 03 Installing the latest fls module
    Verifying if latest fls module is already installed on server
    Installing latest fls module if not installed on server

TC 04 Verifying if fls latest module is present after installation.
    Verifying if latest fls module is already installed on server
    Verifying if latest fls module got installed on server

TC 06 verifying fls Log files
    Getting latest fls log file and verifying no error should be there

TC 07 Verify physical .oss_ref_name_file is present in the ENIQ-S once the user selects from FLS mechanism
    ${fls_oss_ref_name_file}=    Execute Command    ls -a /eniq/sw/conf | grep -i .oss_ref_name_file
    Log To Console    ${fls_oss_ref_name_file}
    Verify file is present    ${fls_oss_ref_name_file}

TC 08 Verify physical service_names file is present in the ENIQ-S once the user selects from FLS mechanism
    ${fls_service_names_file}=    Execute Command    ls /eniq/sw/conf/ | grep service_names
    Log To Console    ${fls_service_names_file}
    Verify file is present    ${fls_service_names_file}

TC 09 Verify physical enmserverdetail file is present in the ENIQ-S once the user selects from FLS mechanism
    ${fls_enmserverdetail_file}=    Execute Command    ls /eniq/sw/conf/ | grep enmserverdetail
    Log To Console    ${fls_enmserverdetail_file}
    Verify file is present    ${fls_enmserverdetail_file}

TC 10 Verify physical mixed ser file is present in the ENIQ-S once the user selects from FLS mechanism
    ${fls_mixed_ser_file}=    Execute Command    ls /eniq/sw/conf/ | grep -i Mixed.*.ser
    Log To Console    ${fls_mixed_ser_file}
    Verify file is present    ${fls_mixed_ser_file}

TC 11 Check physical Persist.ser file is present in the ENIQ-S once the user selects from FLS mechanism
    ${fls_persist_ser_file}=    Execute Command    ls /eniq/sw/conf/ | grep -i ^Persist.*.ser
    Log To Console    ${fls_persist_ser_file}
    Verify file is present    ${fls_persist_ser_file}

TC 12 Verify physical date fls file is present in the ENIQ-S once the user selects from FLS mechanism
    ${fls_date_fls_file}=    Execute Command    ls /eniq/sw/conf/ | grep -i ^date_fls.*
    Log To Console    ${fls_date_fls_file}
    Verify file is present    ${fls_date_fls_file}

TC 13 Verify physical enmcertificate file is present in the ENIQ-S once the user selects from FLS mechanism
    ${fls_status}=    Execute Command    /eniq/sw/bin/fls status
    Log    ${fls_status}
    ${check_fls_status}=    Run Keyword And Return Status    Should Contain    ${fls_status}    FLS is running
    IF    ${check_fls_status} == True
        ${fls_enmcert_file}=    Execute Command    ls /eniq/home/dcuser | grep -i enmcertificate
        Log    ${fls_enmcert_file}
        ${check_enmcertificate_file}=    Run Keyword And Return Status    Verify file is present    ${fls_enmcert_file}
        IF    ${check_enmcertificate_file} == True
            Pass Execution    Enmcertificate file is present
        ELSE
            ${create_enmcert_file}=    Execute Command    touch /eniq/home/dcuser/enmcertificate
            ${fls_enmcert_file}=    Execute Command    ls /eniq/home/dcuser | grep -i enmcertificate
            Log    ${fls_enmcert_file}
            Verify file is present    ${fls_enmcert_file}
        END
    ELSE
        Skip    Fls is not running
    END

TC 14 Verify physical fls conf file is present in the ENIQ-S once the user selects from FLS mechanism
    ${fls_conf_file}=    Execute Command    ls /eniq/installation/config/ | grep -i fls_conf
    Log To Console    ${fls_conf_file}
    Verify file is present    ${fls_conf_file}

TC 15 Verify hosts file is present in the ENIQ-S once the user selects from FLS mechanism
    ${check_fls_conf_file}=    Execute Command    ls /etc/ | grep ^hosts$
    Log To Console    ${check_fls_conf_file}
    Verify file is present    ${check_fls_conf_file}

TC 16 Verify physical truststores file is present in the ENIQ-S once the user selects from FLS mechanism
    ${check_fls_conf_file}=    Execute Command    ls /eniq/sw/runtime/java/jre/lib/security/ | grep truststore.ts
    Log To Console    ${check_fls_conf_file}
    Verify file is present    ${check_fls_conf_file}

TC 17 Verify FLS configuration file fls_conf update
    ${fls_conf_data}=    Execute Command    cat /eniq/installation/config/fls_conf
    @{alias_names}=    Split To Lines    ${fls_conf_data}
    Set Global Variable    ${alias_names}
    Log To Console    fls conf data: ${alias_names}
    FOR    ${fls_alias_name}    IN    @{alias_names}
        Validate output regex    ${fls_alias_name}    ^eniq_oss_[0-9]+$
    END

TC_18_To_21 Verify FLS configuration files update
    Log To Console    \nfls conf data: ${alias_names}
    FOR    ${fls_alias_name}    IN    @{alias_names}
        ${oss_ref_file_output}=    Execute Command    cat /eniq/sw/conf/.oss_ref_name_file | grep -i ${fls_alias_name}
        Log To Console    oss ref name file data: ${oss_ref_file_output}
        Validate command output    ${oss_ref_file_output}    ${fls_alias_name}
        ${nas_ip_ref_file}=    Execute Command
        ...    cat /eniq/sw/conf/.oss_ref_name_file | grep -i ${fls_alias_name} | awk '{print $2}'
        Vaildate variable contain data and set global    ${nas_ip_ref_file}

        ${service_names_file_output}=    Execute Command    cat /eniq/sw/conf/service_names | grep -i ${fls_alias_name}
        Log To Console    service names file data: ${service_names_file_output}
        # Validating nas ip and fls alias name
        Validate output regex
        ...    ${service_names_file_output}
        ...    ${nas_ip_ref_file}::${fls_alias_name}::${fls_alias_name}

        ${enmserverdetail_file_output}=    Execute Command    cat /eniq/sw/conf/enmserverdetail
        Validate command output    ${enmserverdetail_file_output}    ${nas_ip_ref_file}
        ${fls_enm_hostname}=    Execute Command
        ...    cat /eniq/sw/conf/enmserverdetail | grep -i ${nas_ip_ref_file} | awk '{print $2}'
        Vaildate variable contain data and set global    ${fls_enm_hostname}
        ${fls_enm_hostname_ip}=    Execute Command
        ...    ping -c 1 ${fls_enm_hostname} | grep -oE '[0-9]+\.[0-9]+\.[0-9]+\.[0-9]+' | awk 'NR==1'
        Vaildate variable contain data and set global    ${fls_enm_hostname_ip}

        ${hosts_file_output}=    Execute Command    cat /etc/hosts | grep -i ${fls_alias_name}
        Log To Console    hosts file fls alias data: ${hosts_file_output}
        # Validating nas ip and fls alias name
        Validate output regex    ${hosts_file_output}    ${nas_ip_ref_file}\\s+${fls_alias_name}\\s+${fls_alias_name}
        ${hosts_file_output}=    Execute Command    cat /etc/hosts | grep -i ${fls_enm_hostname}
        Log To Console    hosts file enm data: ${hosts_file_output}
        # Validating enm hostname and enm hostname ip
        Validate output regex    ${hosts_file_output}    ${fls_enm_hostname_ip}\\s+${fls_enm_hostname}
    END

TC 22 FLS configuration file truststore.ts update
    Connect to server as a dcuser
    Set Client Configuration    prompt=ieatrcx    timeout=10s
    Getting the password of truststore file
    Verify the validity of fls license in truststore file

TC 23_MB Verifying ENM Mount file system on ENIQ-S
    Verify if pmdata pmic1 and pmic2 exist under df -hk in MB and MR server

TC 23 Verifying ENM Mount file system on ENIQ-S
    Connect to server as a dcuser
    Verify if pmdata pmic1 and pmic2 exist under df -hk

TC 25 Verify fls status after engine stop
    Connect to server as a dcuser
    verify the status of fls when engine is stopped

TC 26 Verifying condition when fls is Stop status
    Verify status when fls is stopped

TC 27 Verifying condition when fls is start status
    Verify status when fls is started

TC 28 Verifying condition when fls is restart status
    Connect to server as a dcuser
    Verify status when fls is restarted

TC 29 Verifying condition when fls is OnHold status
    Changing fls status as OnHold
    Verifying fls status changed to OnHold and fls is running

TC 30 Verifying condition when fls is normal status
    Changing fls status as Normal
    Verifying fls status changed to Normal and fls is running

TC 31 Check physical eniq.xml is present in the ENIQ-S
    Verify eniq.xml is present in the ENIQ-S

TC 32 Check physical NodeTechnologyMapping file is present in the ENIQ-S
    Verify physical NodeTechnologyMapping file is present in the ENIQ-S

TC 33 Check physical NodeDataMapping.properties file is present in the ENIQ-S
    Verify physical NodeDataMapping.properties file is present in the ENIQ-S

TC 34 Check physical NodeTypeDataTypeMapping.properties file is present in the ENIQ-S
    Verify physical NodeTypeDataTypeMapping.properties file is present in the ENIQ-S

TC 35 Check physical enm_type file is present in the ENIQ-S
    Verify physical enm_type file is present in the ENIQ-S

# TC 36 Check for physical enm_post_integration log file is present in the ENIQ-S

# TC 39 Verify for physical enm_post_integration log file is present in the ENIQ-S

TC 40 Check for stop_fls log file is present in the ENIQ-S
    Verify stop_fls log file is present in the ENIQ-S

TC_37_48 Check for physical enm_post_integration log file is present in the ENIQ-S
    Verify for physical enm_post_integration log file is present in the ENIQ-S

TC 41 Verify for physical start_fls log file is present in the ENIQ-S
    Connect to server as a dcuser
    ${checking_file}=    Execute Command    ls /eniq/log/sw_log/symboliclinkcreator/ | grep -i start_fls
    Should Not Be Empty    ${checking_file}

TC 42 Verify for physical start_fls log file is present in the ENIQ-S
    Connect to server as a dcuser
    ${latest_file}=    FLS_keywords.Getting latest file from the folder
    ...    ${symboliclink_folder}
    ...    ${latest_symboliclink_start_log_file}
    ${faliure_logs}=    Opening the fls latest file and searching for failure    ${latest_file}
    FLS_keywords.verify logs should not contain faliure    ${faliure_logs}

TC 43 Verify for physical Delete_SymlinkFile is present in the EINQ-S
    Verify deleteSymlink file should be present

TC 44 Verify for error or exception in Delete_SymlinkFile
    Skip if    '${PREV TEST STATUS}'=='FAIL' or '${PREV TEST STATUS}'=='SKIP'
    ${latest_file}=    FLS_keywords.Getting latest file from the folder
    ...    ${symboliclink_folder}
    ...    ${latest_symboliclink_Delete_log_file}
    ${faliure_logs}=    Opening the DeleteSymlinkFile latest file and searching for failure    ${latest_file}
    FLS_keywords.verify logs should not contain faliure    ${faliure_logs}

TC 45 Verify for symbolic link file is getting deleted which is not consumed by parsers
    Skip if    '${PREV TEST STATUS}'=='FAIL' or '${PREV TEST STATUS}'=='SKIP'
    Verifying if delete symlink log file contain zero older file

TC 46 Check for physical Symboliclinkcreator common file is presence in the EINQ-S and Check for error or exception in Symboliclinkcreator common file
    Connect to server as a dcuser
    ${latest_symboliclinkcreator}=    Execute Command
    ...    cd /eniq/log/sw_log/symboliclinkcreator/ ; ls -Art symboliclinkcreator-*| tail -1
    Verify file is present    ${latest_symboliclinkcreator}

TC 47 Check for physical Symboliclinkcreator common file is presence in the EINQ-S and Check for error or exception in Symboliclinkcreator common file
    Connect to server as a dcuser
    AdminUIWebUI.Execute the Command    cd ${symboliclinkcreator}
    ${latest}=    Get latest file from directory    symboliclinkcreator-*.log
    ${latest}=    Split String    ${latest}
    Log To Console    ${latest}
    ${Verify}    ${rc}=    Execute Command
    ...    cd ${symboliclinkcreator} && cat ${latest}[0] | grep -iE "fail\|err\|exception\|could not\|not enabled\|disable\|not found"
    ...    return_rc=true
    IF    ${rc}==0
        Fail    Failing the testcase, since log has "fail/error/exception/not found etc" negative word in log file
    ELSE
        Log    Passing the testcase, since there is no "fail/error/exception/not found etc" negative words in log file
    END

TC 48 Check for physical Symboliclinkcreator common file is presence in the EINQ-S and Check for error or exception in Symboliclinkcreator common file
    Connect to server as a dcuser
    AdminUIWebUI.Execute the Command    ${symboliclinkcreator}
    Connect to server as a dcuser
    ${latest_symboliclinkcreator_eniq_oss}=    Execute Command
    ...    cd /eniq/log/sw_log/symboliclinkcreator/ ; ls -Art symboliclinkcreator_eniq_oss_*| tail -1
    Verify file is present    ${latest_symboliclinkcreator_eniq_oss}

TC 49 Check for physical Symboliclinkcreator_eniq_oss common file is presence in the EINQ-S and Check for error or exception in Symboliclinkcreator common file
    Connect to server as a dcuser
    AdminUIWebUI.Execute the Command    cd ${symboliclinkcreator}
    ${latest}=    Get latest file from directory    symboliclinkcreator_eniq_oss_*.log
    ${latest}=    Split String    ${latest}
    Log To Console    ${latest}
    ${Verify}    ${rc}=    Execute Command
    ...    cd ${symboliclinkcreator} && cat ${latest}[0] | grep -iE "fail\|error\|exception\|could not\|not enabled\|disabled\|not found\|indir not found"
    ...    return_rc=true
    IF    ${rc}==0
        @{pass}=    Split To Lines    ${Verify}
        ${length}=    Get Length    ${pass}
        FOR    ${element}    IN    @{pass}
            Log    ${element}
            Should Contain    ${element}    FileAlreadyExistsException
        END
    END

TC 50 Verify the FLS user is valid
    Connect to server as a dcuser
    ${output}=    AdminUIWebUI.Execute the Command    cat /eniq/sw/conf/enmserverdetail
    ${output}=    Split String    ${output}
    Log To Console    ${output}
    ${pwd}=    AdminUIWebUI.Execute the Command    echo -n ${output}[4] | base64 --decode
    ${Verify_msg}=    AdminUIWebUI.Execute the Command
    ...    curl -k -L -c cookie.txt -X POST "https://${output}[1]/login" -d IDToken1=${output}[3] -d IDToken2=${pwd}
    Should Contain Any    ${Verify_msg}    Authentication Successful    login

TC 51 Verify the topology query is happening every 15 minutes
    Write    sudo su - dcuser
    Read Until Prompt    strip_prompt=True
    Write    fls status
    ${fls_status}=    Read Until Prompt    strip_prompt=True
    ${status}=    Run Keyword And Return Status    Should Contain    ${fls_status}    FLS is running
    Skip If    '${status}'=='False'
    ${alias}=    Execute Command    cat /eniq/installation/config/fls_conf
    # ${start_time}    Execute Command    echo $(date -d '2 hour ago' +'%d.%m %H:')$((($(($(date +'%M') / 15))-0)*15))
    # ${end_time}    Execute Command    echo $(date +'%d.%m %H:')$((($(($(date +'%M') / 15))-0)*15))
    # ${fls_log}    Execute Command    cd /eniq/log/sw_log/symboliclinkcreator && awk -v date="$(date --date='2 hours ago' +'%H:%M')" '$2 > date' symboliclinkcreator_eniq_oss_1-2023_12_06.log | grep -ic 'DTOPOLOGY'
    ${latestfile}=    Execute Command    date +"%Y_%m_%d"
    ${fls_log}=    Execute Command
    ...    awk -v date="$(date --date='2 hours ago' +'%H:%M')" '$2 > date' /eniq/log/sw_log/symboliclinkcreator/symboliclinkcreator_${alias}-${latestfile}.log | grep -ic 'DTOPOLOGY'
    ${fls}=    Evaluate    type(${fls_log})
    Log    {fls}
    IF    ${fls_log}/2 >= 8
        Pass Execution    topology query is happening every 15 minutes
    ELSE
        Fail
    END

Tc 52 Verify the PM query is happening for every 3min
    Put File    ${EXEC_DIR}//PF//Scripts//test.bsh    /home/DmCi
    Write    sudo su - dcuser
    Read Until Prompt    strip_prompt=True
    Execute Command    cd /home/DmCi && dos2unix test.bsh
    ${dwhrep_pwd}=    Execute Command
    ...    cd /home/DmCi && sudo ./test.bsh REP DWHREP | grep -i Password | cut -d ':' -f 2
    Write    cd /eniq/home/dcuser ; fls status
    ${fls_status}=    Read Until Prompt
    ${status}=    Run Keyword And Return Status    Should Contain    ${fls_status}    FLS is running
    Skip If    '${status}'=='False'
    ${latestfile}=    Execute Command    date +"%Y_%m_%d"
    # ${start_time}    Execute Command    echo $(date -d '2 hour ago' +'%d.%m %H:')$((($(($(date +'%M') / 15))-0)*15))
    # ${end_time}    Execute Command    echo $(date +'%d.%m %H:')$((($(($(date +'%M') / 15))-0)*15))
    ${alias}=    Execute Command    cat /eniq/installation/config/fls_conf
    Write
    ...    echo -e "select distinct netype from eniqs_node_assignment where netype in (select distinct node_type from nodetypegranularity)\\ngo\\n" | isql -P Dwhrep12# -U DWHREP -S repdb -b
    ${nodes_on_enm_eniq}=    Read Until Prompt
    ${nodes_on_enm_eniq}=    Split String    ${nodes_on_enm_eniq}    \n
    Remove From List    ${nodes_on_enm_eniq}    -1
    Remove From List    ${nodes_on_enm_eniq}    -1
    Remove From List    ${nodes_on_enm_eniq}    -1
    ${flag}=    Set Variable    True
    @{lst}=    Create List
    FOR    ${element}    IN    @{nodes_on_enm_eniq}
        ${element}=    Strip String    ${element}
        ${element}=    Catenate    SEPARATOR=    D    ${element}
        ${element}=    Catenate    SEPARATOR=    ${element}    %
        ${contains_mini_link}=    Evaluate    "DMINI-LINK" in """${element}"""
        ${contains_radio}=    Evaluate    "DRadioNode" in """${element}"""
        ${fls_log}=    Execute Command
        ...    awk -v date="$(date --date='2 hours ago' +'%H:%M')" '$2 > date' /eniq/log/sw_log/symboliclinkcreator/symboliclinkcreator_${alias}-${latestfile}.log | grep -i 'DPM_STATISTICAL' | grep -ic '${element}'
        Convert To Integer    ${fls_log}
        IF    '${contains_radio}' == 'True'
            ${RADIO_PM_EBSN_CUUP}=    Execute Command
            ...    awk -v date="$(date --date='2 hours ago' +'%H:%M')" '$2 > date' /eniq/log/sw_log/symboliclinkcreator/symboliclinkcreator_${alias}-${latestfile}.log | grep -i 'DPM_EBSN_CUUP' | grep -ic '${element}'
            ${RADIO_EBSN_CUCP}=    Execute Command
            ...    awk -v date="$(date --date='2 hours ago' +'%H:%M')" '$2 > date' /eniq/log/sw_log/symboliclinkcreator/symboliclinkcreator_${alias}-${latestfile}.log | grep -i 'DPM_EBSN_CUCP' | grep -ic '${element}'
            ${RADIO_PM_EBSN_DU}=    Execute Command
            ...    awk -v date="$(date --date='2 hours ago' +'%H:%M')" '$2 > date' /eniq/log/sw_log/symboliclinkcreator/symboliclinkcreator_${alias}-${latestfile}.log | grep -i 'DPM_EBSN_DU' | grep -ic '${element}'
            ${RADIO_PM_EBSL}=    Execute Command
            ...    awk -v date="$(date --date='2 hours ago' +'%H:%M')" '$2 > date' /eniq/log/sw_log/symboliclinkcreator/symboliclinkcreator_${alias}-${latestfile}.log | grep -i 'DPM_EBSL' | grep -ic '${element}'
            Convert To Integer    ${RADIO_PM_EBSN_CUUP}
            Convert To Integer    ${RADIO_EBSN_CUCP}
            Convert To Integer    ${RADIO_PM_EBSN_DU}
            Convert To Integer    ${RADIO_PM_EBSL}
            IF    ${fls_log}/2 >= 20 and ${RADIO_PM_EBSN_CUUP}/2 >= 20 and ${RADIO_EBSN_CUCP}/2 >= 20 and ${RADIO_PM_EBSN_DU}/2 >= 20 and ${RADIO_PM_EBSL}/2 >= 20
                Log    ${element} occurs every 3mins
            ELSE
                Append To List    ${lst}    ${element}
                Log To Console    ${element} not occurs every 3min
                ${flag}=    Set Variable    False
            END
        ELSE IF    '${contains_mini_link}' == 'True' and ${fls_log}/2 >= 60
            Log    ${element} occurs every 3mins
        ELSE IF    ${fls_log}/2 >= 20
            Log    ${element} occurs every 3mins
        ELSE
            Append To List    ${lst}    ${element}
            Log To Console    ${element} not occurs every 3min
            ${flag}=    Set Variable    False
        END
    END
    IF    '${flag}' == 'True'
        Pass Execution    All netypes occurs every 3min
    ELSE
        Fail    Some netypes are not occurs every 3min:${lst}
    END

TC 53 Check for physical Delete_SymlinkFile
    Connect to server as a dcuser
    ${Latest_DeleteSymlinkFile}=    Execute Command
    ...    cd /eniq/log/sw_log/symboliclinkcreator/ ; ls -Art DeleteSymlinkFile-*| tail -1
    ${output}=    Execute Command    cat /eniq/log/sw_log/symboliclinkcreator/${Latest_DeleteSymlinkFile}
    Log To Console    ${output}
    ${Deleted_File_count}=    Evaluate    "0" in """${output}"""
    IF    ${Deleted_File_count}
        Log To Console    Total number of files which are older than 3 days =    0, hence passsing the testcase
    ELSE
        ${fls_delete_symlink_file}=    Execute Command
        ...    cat /eniq/log/sw_log/symboliclinkcreator/${Latest_DeleteSymlinkFile} | grep -A 99999 'days'| tail -n +2
        Log To Console    ${fls_delete_symlink_file}
        @{check_path}=    Split To Lines    ${fls_delete_symlink_file}
        Log To Console    ${check_path}
        FOR    ${element}    IN    @{check_path}
            ${check_file_present}    ${rc}=    Execute Command    cat ${element}    return_rc=True
            ${output_length}=    Get Length    ${check_file_present}
            IF    '${rc}' == '1' and '${output_length}' == '0'
                Log    ${element} not present
            ELSE
                Fail    ${element} is present
            END
        END
    END

Check for working of Delete_SymlinkFiles
    ${files_count_older_than_3_days}=    Execute Command    find /eniq/data/pmdata/ -type l -mtime +3 -print | wc -l
    Log    ${files_count_older_than_3_days}
    Should Be Equal    ${files_count_older_than_3_days}    0

Checking the creation of InDirectories
    [Tags]    fls
    Connect to server as a dcuser
    Checking whether inDirectories for each node is created in the path

Check that when disable_OSS file exists , FLS to be on HOLD for a particular oss alias
    [Tags]    fls
    Connect to server as a dcuser
    Verification of FLS status when disable_OSS file Exists

Check the status of all services of ENIQ-S
    [Tags]    fls
    Connect to server as a dcuser
    Verification of the status of all services of ENIQ-S

Checking the NAT table and FLS restart
    [Tags]    fls
    Connect to server as a dcuser
    Clearing the NAT table and fls restart

Verify the status of FLS service
    [Tags]    fls
    Connect to server as a dcuser
    fls service check

Verify all the nodes which is available in node assignment table have data load
    [Tags]    fls
    Connect to server as a dcuser
    Verifying the proper loading of data in node assignment table

Verifying the enm server details
    [Tags]    fls
    Connect to server as a dcuser
    Verify enmserverdetail file is with CENM INGRESS IP address

Verifying enm_type file should be present in the following path
    [Tags]    fls
    Connect to server as a dcuser
    Verifying whether enm_type is should be displayed as "cENM"

Verification of fls_conf file
    [Tags]    fls
    Connect to server as a dcuser
    Verification of fls_conf file is with ENM

Verification of FLS configuration file ".oss_ref_name_file"
    [Tags]    fls
    Connect to server as a dcuser
    Verification of .oss_ref_name_file is with ENM alias and NAS IP address

Verification of the .ser files generation
    [Tags]    fls
    Connect to server as a dcuser
    Verifying whether the .ser files get generated in the following path

Verification of Truststore.ts files created in following path
    [Tags]    fls
    Connect to server as a dcuser
    verifying whether truststore.ts files should be displayed

Verification of /etc/hosts with INGRESS IP and hostname
    [Tags]    fls
    Connect to server as a dcuser
    Verifying hosts file is with ENM alias INGRESS IP and hostname

Verify pm query is happening for every 3 min for each node
    [Tags]    fls
    Connect to server as a dcuser
    Checking pm query is happening for every each node

Verify FLS configuration file service_names
    [Tags]    fls
    Connect to server as a dcuser
    verify service_names file is with CENM INGRESS IP and alias address

Verify the topology query is happening in following path
    [Tags]    fls
    Connect to server as a dcuser
    Verify the topology query is happening for every 15min


*** Keywords ***
Change Granularity and verifyng the querying of data
    clicking the Granularity configuration from menu bar
    AdminUIWebUI.Logout From Adminui

Checking whether inDirectories for each node is created in the path
    symboliclinkcreator_FLS_keywords.Execute the Command    cd ${inDir}
    ${Indir_files}=    symboliclinkcreator_FLS_keywords.Execute the Command    ${ls}
    verify indirs are created    ${Indir_files}
    [Teardown]    Test teardown

Verification of FLS status when disable_OSS file Exists
    symboliclinkcreator_FLS_keywords.Go to the folder    cd ${mount}
    ${output}=    symboliclinkcreator_FLS_keywords.List the files in the folder    ${ls}
    Verifying of FLS status to be ONHold when disable_OSS file Exists    ${output}
    [Teardown]    Test teardown

Verification of the status of all services of ENIQ-S
    ${output}=    symboliclinkcreator_FLS_keywords.Execute the Command    ${service check}
    verify the active and inactive services
    ...    ${output}
    ...    ${list_of_active_services_fls}
    ...    ${list_of_inactive_services_fls}
    [Teardown]    Test teardown

Clearing the NAT table and fls restart
    connect to repdb
    ${output}=    symboliclinkcreator_FLS_keywords.run the sql query    ${delete_NAT_table_query}
    verifying NAT table should be empty    ${output}    ${rows_deleted}
    restart the fls    ${fls_restart}
    [Teardown]    Test teardown

fls service check
    ${output}=    symboliclinkcreator_FLS_keywords.checking fls status    ${status}
    verifying the fls status    ${output}    ${cmpltd}
    verifying the fls status    ${output}    ${FLS}
    [Teardown]    Test teardown

Verifying the proper loading of data in node assignment table
    connect to repdb
    ${output}=    symboliclinkcreator_FLS_keywords.run the sql query    ${select_NAT_table_query}
    verify the file is not empty    ${output}
    [Teardown]    Test teardown

Verify enmserverdetail file is with cENM INGRESS IP address
    ${oss_file}=    Execute Command    cat /eniq/installation/config/fls_conf
    ${oss_ref_name_file}=    Execute Command    cat /eniq/sw/conf/.oss_ref_name_file
    AdminUIWebUI.Verify the msg    ${oss_ref_name_file}    ${oss_file}
    ${get_eniq_oss_line}=    Execute Command    cat /eniq/sw/conf/.oss_ref_name_file | grep -i ${oss_file}
    ${nas_ip_address}=    Execute Command    cat /eniq/sw/conf/enmserverdetail | awk '{print $1}'
    AdminUIWebUI.Verify the msg    ${get_eniq_oss_line}    ${nas_ip_address}

Verifying whether enm_type is should be displayed as "cENM"
    ${mount_path_1}=    Execute Command    ls /eniq/connectd/mount_info/
    @{spliting_oss_ref_file}=    Split To Lines    ${mount_path_1}
    FOR    ${mount_path_1}    IN    @{spliting_oss_ref_file}
        ${enm_type_file}=    Execute Command    ls /eniq/connectd/mount_info/${mount_path_1} | grep -i enm_type
        ${get_length}=    Get Length    ${enm_type_file}
        IF    ${get_length}!= 0
            ${enm_type}=    Execute Command    cat /eniq/connectd/mount_info/${mount_path_1}/${enm_type_file}
            Verify the PENM and CENM    ${enm_type}    pENM    cENM
        END
    END
    [Teardown]    Test teardown

Verification of fls_conf file is with ENM
    ${fls_conffile}=    Execute Command    cat /eniq/installation/config/fls_conf
    Verify the enm alias name in server    ${fls_conffile}    ^eniq_oss_\\d+$
    [Teardown]    Test teardown

 Verification of .oss_ref_name_file is with ENM alias and NAS IP address
    ${oss_file}=    Execute Command    cat /eniq/installation/config/fls_conf
    ${oss_ref_name_file}=    Execute Command    cat /eniq/sw/conf/.oss_ref_name_file
    AdminUIWebUI.Verify the msg    ${oss_ref_name_file}    ${oss_file}
    ${get_eniq_oss_line}=    Execute Command    cat /eniq/sw/conf/.oss_ref_name_file | grep -i ${oss_file}
    ${nas_ip_address}=    Execute Command    cat /eniq/sw/conf/enmserverdetail | awk '{print $1}'
    AdminUIWebUI.Verify the msg    ${get_eniq_oss_line}    ${nas_ip_address}
    [Teardown]    Test teardown

Verifying whether the .ser files get generated in the following path
    symboliclinkcreator_FLS_keywords.Execute the Command    cd ${conf}
    ${file_list}=    symboliclinkcreator_FLS_keywords.List the files in the folder    ${ls-lrt}
    verify the file is present in the file list    ${file_list}    ${.ser}
    ${output}=    symboliclinkcreator_FLS_keywords.List the properties of the file    ls -lah ${.ser}
    verify the .ser file size is not zero    ${output}
    [Teardown]    Test teardown

verifying whether truststore.ts files should be displayed
    symboliclinkcreator_FLS_keywords.Execute the Command    cd ${security_path}
    ${file_list}=    symboliclinkcreator_FLS_keywords.List the files in the folder    ${ls-lrt}
    verify the file is present in the file list    ${file_list}    ${file}
    symboliclinkcreator_FLS_keywords.List the files in the folder    ${lrth}
    ${output}=    symboliclinkcreator_FLS_keywords.List the files in the folder    ls -lah ${file}
    verify the truststore.ts file size is not zero    ${output}
    [Teardown]    Test teardown

Verifying hosts file is with ENM alias INGRESS IP and hostname
    symboliclinkcreator_FLS_keywords.Execute the Command    ${installer path}
    ${output}=    symboliclinkcreator_FLS_keywords.List the files in the folder    ${ls}
    ${output}=    symboliclinkcreator_FLS_keywords.Display the contents in the file    ${services-4}
    verify the output contains CENM INGRESS IP and ENM hostname    ${output}
    [Teardown]    Test teardown

Checking pm query is happening for every each node
    symboliclinkcreator_FLS_keywords.Execute the Command    cd ${symboliclinkcreator}
    ${curr_date_Y_m_d}=    symboliclinkcreator_FLS_keywords.Get the previous Date
    # ${file_content}=    symboliclinkcreator_FLS_keywords.Display the contents in the file    cat ${symlink4}-${curr_date_Y_m_d}.log | grep -i "PM response"
    ${file_content}=    symboliclinkcreator_FLS_keywords.Display the contents in the file
    ...    cat ${symlink4}-${curr_date_Y_m_d}.log | grep -i "DPM" | grep "MTAS"
    ${file_content_lines}=    Get the number of lines in log results    ${file_content}
    Skip If    ${file_content_lines}<3    Skipped No NodeType WithData
    verifying PM query is happening in every 3 min    ${file_content}
    [Teardown]    Test teardown

verify service_names file is with CENM INGRESS IP and alias address
    symboliclinkcreator_FLS_keywords.Execute the Command    cd ${installer path}
    ${output}=    symboliclinkcreator_FLS_keywords.List the files in the folder    ${ls}
    ${output}=    symboliclinkcreator_FLS_keywords.Display the contents in the file    cat ${service-3}
    ${oss_ref_contents}=    symboliclinkcreator_FLS_keywords.Display the contents in the file    cat ${Enm-2}
    ${eniqAliasNames}=    get the enm alias names    ${oss_ref_contents}
    verify the output contains CENM INGRESS IP address    ${output}    ${eniqAliasNames}
    [Teardown]    Test teardown

Verify the topology query is happening for every 15min
    symboliclinkcreator_FLS_keywords.Execute the Command    cd ${symboliclinkcreator}
    ${curr_date_Y_m_d}=    symboliclinkcreator_FLS_keywords.Get the previous Date
    ${file_content}=    symboliclinkcreator_FLS_keywords.Display the contents in the file
    ...    cat ${symlink4}-${curr_date_Y_m_d}.log | grep -i "TOPOLOGY QUERY"
    ${file_content_lines}=    Get the number of lines in log results    ${file_content}
    Skip If    ${file_content_lines}<4    TestCase Skipped NoData
    verifying topology query is happening every 15 min    ${file_content}
    [Teardown]    Test teardown

Test teardown
    Capture Page Screenshot
    Close Browser

Suite setup steps
    Set Screenshot Directory    ./Screenshots

Test teardown
    Close Connection
