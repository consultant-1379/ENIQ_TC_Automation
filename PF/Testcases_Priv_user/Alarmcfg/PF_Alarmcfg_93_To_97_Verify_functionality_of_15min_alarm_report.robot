*** Settings ***
Documentation     Testing Alarmcfg Webpage
Library    RPA.Browser.Selenium     
Library    DateTime
Resource    ../../Resources/Keywords/Alarmcfg_keywords.robot
Resource    ../../Resources/Keywords/Variables.robot
Resource    ../../Resources/Keywords/Cli.robot
Suite setup       Suite setup steps
Suite Teardown    Suite teardown steps 

*** Variables ***
${almcfg_sys}    atclvm858:6400
${15min_alm_template_db}    AUTOMATION_ERBSG2_EUTRANCELLTDD_15MINS
${15min_basetable_db}    DC_E_ERBSG2_EUTRANCELLTDD_RAW
${15min_almrpt_name}    AlarmInterface_15min
${reports_alarmname_db}    AUTOMATION_ERBSG2_EUTRANCELLTDD_15MINS

*** Test Cases ***
Verify 15min alarmreport status is active 
    ${dwhrep_pwd}=    Execute Command    sudo su - dcuser -c "/eniq/sw/installer/getPassword.bsh -u DWHREP" | awk '{print $NF}'
    ${dwhrep_pwd_status}=    Run Keyword And Return Status    Should Not Be Empty    ${dwhrep_pwd}
    Write    sudo su - dcuser 
    ${output}=    Read Until Prompt    strip_prompt=True
    Write    echo -e "select AlarmReport.INTERFACEID,AlarmReport.REPORTID,AlarmReport.STATUS from AlarmReport INNER JOIN AlarmReportParameter ON AlarmReport.REPORTID=AlarmReportParameter.REPORTID where AlarmReportParameter.VALUE='${15min_basetable_db}'and AlarmReport.INTERFACEID='${15min_almrpt_name}' and AlarmReport.REPORTNAME='${15min_alm_template_db}';\ngo\n" | dbisql -n -c "UID=dwhrep;PWD=${dwhrep_pwd};eng=repdb" -host localhost -port 2641 -nogui | grep -i "Alarm" 
    ${almrpt_db_output}=    Read Until Prompt    strip_prompt=True
    Should Match Regexp    ${almrpt_db_output}    \\bACTIVE\\b
    @{almrpt_id_list}=    Get Regexp Matches     ${almrpt_db_output}    \\b\\S+-\\S+-\\S+-\\S+-\\S+\\b
    Should Not Be Empty    ${almrpt_id_list}
    ${almcfg_15min_almrpt_id}=    Get From List    ${almrpt_id_list}    0
    Log    ${almcfg_15min_almrpt_id} is active
    Set Global Variable    ${almcfg_15min_almrpt_id}

Functional verification 15min alarm type -report parsing verification in file logs
    Skip if    '${PREV TEST STATUS}'=='FAIL' or '${PREV TEST STATUS}'=='SKIP'
    ${almcfg_current_date}=    Execute Command    date +"%Y_%m_%d"
    ${check_Alarminterface_file}=    Execute Command    ls /eniq/log/sw_log/engine/AlarmInterfaces/ | grep -i file-${almcfg_current_date}.log
    Log    ${check_Alarminterface_file}
    Should Not Be Empty    ${check_Alarminterface_file}
    # ${check_data_parsing}=    Execute Command    awk -F' ' '/^[0-9]{2}\.[0-9]{2} [0-9]{2}:[0-9]{2}:[0-9]{2}/ {if ($2 >= "${start_5min_time_parse_logs}") flag=1} flag' /eniq/log/sw_log/engine/AlarmInterfaces/file-${almcfg_current_date}.log | grep -i ${15min_almrpt_name} | grep -i ${15min_alm_template_db}| grep -i parsed | tail -10
    ${check_data_parsing}=    Execute Command    cat /eniq/log/sw_log/engine/AlarmInterfaces/file-${almcfg_current_date}.log | grep -i ${15min_almrpt_name} | grep -i '${15min_alm_template_db}'| grep -i parsed | tail -10
    Log    ${check_data_parsing}
    Should Not Be Empty    ${check_data_parsing}


Functional verification 15min alarm type -report loading verification in DB
    Skip if    '${PREV TEST STATUS}'=='FAIL' or '${PREV TEST STATUS}'=='SKIP'
    ${almcfg_current_date}=    Execute Command    date +"%Y-%m-%d"
    ${dc_pwd}=    Execute Command    sudo su - dcuser -c "/eniq/sw/installer/getPassword.bsh -u DC" | awk '{print $NF}'
    ${dc_pwd_status}=    Run Keyword And Return Status    Should Not Be Empty    ${dc_pwd}
    Write   echo -e "Select ROWSTATUS from DC_Z_ALARM_INFO_RAW where ReportTitle='${almcfg_15min_almrpt_id}' and TIMELEVEL='15MIN' and DATE_ID='${almcfg_current_date}';\ngo\n" | dbisql -n -c "UID=dc;PWD=${dc_pwd};eng=dwhdb" -host localhost -port 2640 -nogui
    # Write   echo -e "Select ROWSTATUS from DC_Z_ALARM_INFO_RAW where AlarmName='${reports_alarmname_db}' and TIMELEVEL='15MIN' and DATE_ID='${almcfg_current_date}';\ngo\n" | dbisql -n -c "UID=dc;PWD=${dc_pwd};eng=dwhdb" -host localhost -port 2640 -nogui
    ${almcfg_loading_db}=    Read Until Prompt    strip_prompt=True
    @{almrpt_loaded_list}=    Get Regexp Matches     ${almcfg_loading_db}    \\bLOADED\\b
    Log    ${almrpt_loaded_list}
    Should Not Be Empty    ${almrpt_loaded_list}    


*** Keywords ***
Suite setup steps
    Open connection as root user
    Set Client Configuration    30    prompt=REGEXP:${SERVER}\\[\\S+\\]\\s{\\w+}\\s#

Suite teardown steps
    Close All Connections



