*** Settings ***
Documentation     Testing Symboliclinkcreator
Library    SSHLibrary
Library    String
Library    Collections
Resource    ../../Resources/Keywords/Cli.robot
Resource    ../../Resources/Keywords/Variables.robot
Test Setup    Connect to physical server as root user with prompt
Test Teardown    Close All Connections

*** Test Cases ***
Verify the topology query is happening every 15 minutes
    Write    sudo su - dcuser
    Read Until Prompt    strip_prompt=True
    Write     fls status
    ${fls_status}    Read Until Prompt    strip_prompt=True
    ${status}    Run Keyword And Return Status    Should Contain    ${fls_status}    FLS is running
    Skip If    '${status}'=='False'
    ${alias}    Execute Command    cat /eniq/installation/config/fls_conf
    #${start_time}    Execute Command    echo $(date -d '2 hour ago' +'%d.%m %H:')$((($(($(date +'%M') / 15))-0)*15))
    #${end_time}    Execute Command    echo $(date +'%d.%m %H:')$((($(($(date +'%M') / 15))-0)*15))
    #${fls_log}    Execute Command    cd /eniq/log/sw_log/symboliclinkcreator && awk -v date="$(date --date='2 hours ago' +'%H:%M')" '$2 > date' symboliclinkcreator_eniq_oss_1-2023_12_06.log | grep -ic 'DTOPOLOGY'
    ${latestfile}=    Execute Command    date +"%Y_%m_%d"
    ${fls_log}    Execute Command    awk -v date="$(date --date='2 hours ago' +'%H:%M')" '$2 > date' /eniq/log/sw_log/symboliclinkcreator/symboliclinkcreator_${alias}-${latestfile}.log | grep -ic 'DTOPOLOGY'
    Convert to integer       ${fls_log}
    IF    ${fls_log}/2 >= 8
        Pass Execution    topology query is happening every 15 minutes
    ELSE
        Fail
    END

Verify the PM query is happening for every 3min
    #Put File    ${EXEC_DIR}//PF//Scripts//test.bsh    /home/DmCi
    Write    sudo su - dcuser
    Read Until Prompt    strip_prompt=True
    Execute Command    cd /home/DmCi && dos2unix test.bsh 
    ${dwhrep_pwd}=    Execute Command    cd /home/DmCi && sudo ./test.bsh REP DWHREP | grep -i Password | cut -d ':' -f 2
    Write    cd /eniq/home/dcuser ; fls status
    ${fls_status}    Read Until Prompt
    ${status}    Run Keyword And Return Status    Should Contain    ${fls_status}    FLS is running
    Skip If    '${status}'=='False'
    ${latestfile}=    Execute Command    date +"%Y_%m_%d"
    #${start_time}    Execute Command    echo $(date -d '2 hour ago' +'%d.%m %H:')$((($(($(date +'%M') / 15))-0)*15))
    #${end_time}    Execute Command    echo $(date +'%d.%m %H:')$((($(($(date +'%M') / 15))-0)*15))
    ${alias}    Execute Command    cat /eniq/installation/config/fls_conf
    Write    echo -e "select distinct netype from eniqs_node_assignment where netype in (select distinct node_type from nodetypegranularity)\\ngo\\n" | isql -P Dwhrep12# -U DWHREP -S repdb -b
    ${nodes_on_enm_eniq}=   Read Until Prompt
    ${nodes_on_enm_eniq}    Split String    ${nodes_on_enm_eniq}    \n
    Remove From List    ${nodes_on_enm_eniq}    -1
    Remove From List    ${nodes_on_enm_eniq}    -1
    Remove From List    ${nodes_on_enm_eniq}    -1
    ${flag}    Set Variable    True
    @{lst}=    Create List
    FOR    ${element}    IN    @{nodes_on_enm_eniq}
        ${element}    Strip String    ${element}
        ${element}    Catenate    SEPARATOR=    D    ${element}
        ${element}    Catenate    SEPARATOR=    ${element}    %
        ${contains_mini_link}=  Evaluate   "DMINI-LINK" in """${element}"""
        ${contains_radio}=  Evaluate   "DRadioNode" in """${element}"""
        ${fls_log}    Execute Command    awk -v date="$(date --date='2 hours ago' +'%H:%M')" '$2 > date' /eniq/log/sw_log/symboliclinkcreator/symboliclinkcreator_${alias}-${latestfile}.log | grep -i 'DPM_STATISTICAL' | grep -ic '${element}'
        Convert To Integer    ${fls_log}
        IF    '${contains_radio}' == 'True'
            ${RADIO_PM_EBSN_CUUP}    Execute Command    awk -v date="$(date --date='2 hours ago' +'%H:%M')" '$2 > date' /eniq/log/sw_log/symboliclinkcreator/symboliclinkcreator_${alias}-${latestfile}.log | grep -i 'DPM_EBSN_CUUP' | grep -ic '${element}'
            ${RADIO_EBSN_CUCP}    Execute Command    awk -v date="$(date --date='2 hours ago' +'%H:%M')" '$2 > date' /eniq/log/sw_log/symboliclinkcreator/symboliclinkcreator_${alias}-${latestfile}.log | grep -i 'DPM_EBSN_CUCP' | grep -ic '${element}'
            ${RADIO_PM_EBSN_DU}    Execute Command    awk -v date="$(date --date='2 hours ago' +'%H:%M')" '$2 > date' /eniq/log/sw_log/symboliclinkcreator/symboliclinkcreator_${alias}-${latestfile}.log | grep -i 'DPM_EBSN_DU' | grep -ic '${element}'
            ${RADIO_PM_EBSL}    Execute Command    awk -v date="$(date --date='2 hours ago' +'%H:%M')" '$2 > date' /eniq/log/sw_log/symboliclinkcreator/symboliclinkcreator_${alias}-${latestfile}.log | grep -i 'DPM_EBSL' | grep -ic '${element}'
            Convert To Integer    ${RADIO_PM_EBSN_CUUP}    
            Convert To Integer    ${RADIO_EBSN_CUCP}   
            Convert To Integer    ${RADIO_PM_EBSN_DU} 
            Convert To Integer    ${RADIO_PM_EBSL}     
            IF    ${fls_log}/2 >= 20 and ${RADIO_PM_EBSN_CUUP}/2 >= 20 and ${RADIO_EBSN_CUCP}/2 >= 20 and ${RADIO_PM_EBSN_DU}/2 >= 20 and ${RADIO_PM_EBSL}/2 >= 20
                Log    ${element} occurs every 3mins
            ELSE
                Append To List    ${lst}    ${element}    
                Log To Console    ${element} not occurs every 3min
                ${flag}    Set Variable    False
            END
        ELSE IF   '${contains_mini_link}' == 'True' and ${fls_log}/2 >= 60
            Log    ${element} occurs every 3mins
        ELSE IF    ${fls_log}/2 >= 20
            Log    ${element} occurs every 3mins
        ELSE
            Append To List    ${lst}    ${element}    
            Log To Console    ${element} not occurs every 3min
            ${flag}    Set Variable    False
        END
    END
    IF    '${flag}' == 'True'
        Pass Execution    All netypes occurs every 3min 
    ELSE
        Fail    Some netypes are not occurs every 3min:${lst}
    END

