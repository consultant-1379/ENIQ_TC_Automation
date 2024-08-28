*** Settings ***
Documentation     Testing Alarmcfg Webpage
Library    RPA.Browser.Selenium     
Resource    ../../Resources/Keywords/Alarmcfg_keywords.robot
Resource    ../../Resources/Keywords/Variables.robot
Resource    ../../Resources/Keywords/Cli.robot
Suite setup       Suite setup steps
Suite Teardown    Suite teardown steps  
Library    DateTime

*** Variables ***
${almcfg_sys}    ieatrcx4400:6400
${10min_alm_template_db}    AM_Static_Threshold_Template_AUTOMATION-MTAS-1
${10min_basetable_db}    DC_E_MTAS_MTASLICENSES_RAW
${10min_almrpt_name}    AlarmInterface_10min
${reports_alarmname_db}    Alarm Static Threshold Template AUTO MTAS COMMON

*** Test Cases ***
Verify 10min Interface Alarm report addition
    Launch the Alarmcfg webpage in browser
    Input Alarmcfg Login Details    ${almcfg_sys}    ${almcfg_user}    ${almcfg_pass}    ${almcfg_auth}
    Click Login Button
    Click Interface link    10min
    Verify no reports are added
    Click Add report button
    Select alarm template from available reports    ${10min_alm_template_db}
    Select basetable from dropdown list    ${10min_basetable_db}
    Click Add alarm report button
    Verify alarm report addition     ${10min_basetable_db}    ${10min_alm_template_db}
    [Teardown]    Test teardown steps

*** Keywords ***
Suite setup steps
    Skip If    ${almcfg_config_status}==False
    Set Screenshot Directory    ./Screenshots
    

Suite teardown steps
    Capture Page Screenshot
    Close Browser

Verify no reports are added
    ${check_interface_empty}=    Run Keyword And Return Status    Element Should Contain    id:action_title    No reports
    IF    ${check_interface_empty} == True
        Log    No reports are present
    ELSE
        ${count_added_reports}=    Get Element Count    //img[@alt='Remove']
        Log To Console    Total Alarmcfg reports: ${count_added_reports}
        FOR    ${counter}    IN RANGE    0    ${count_added_reports}    
            Click Element    xpath://img[@alt="Remove"]
            Handle Alert    timeout=10s  
            Verify message is displayed    successfully removed     
            Sleep    2s
        END   
        Click Interface link    10min
        Element Should Contain    id:action_title    No reports  
    END

Check alarmcfg reports added status
    Execute Command    date '+%Y-%m-%d %H:%M:%S' > /var/tmp/10min_almreport_db_add_time.txt
    Run Keyword If    '${TEST STATUS}'=='PASS'    Execute Command    echo 'True' > /var/tmp/10min_almreport_add_status.txt   ELSE    Execute Command    echo 'False' > /tmp/10min_almreport_add_status.txt  
   
Test teardown steps
    Connect to server as a dcuser
    Check alarmcfg reports added status
    Close All Connections