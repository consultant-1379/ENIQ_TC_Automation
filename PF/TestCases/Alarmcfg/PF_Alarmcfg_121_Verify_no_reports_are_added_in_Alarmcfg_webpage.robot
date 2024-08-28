*** Settings ***
Documentation     Testing Alarmcfg Webpage
Library    RPA.Browser.Selenium     
Resource    ../../Resources/Keywords/Alarmcfg_keywords.robot
Resource    ../../Resources/Keywords/Variables.robot
Resource    ../../Resources/Keywords/Cli.robot
Suite setup       Suite setup steps
Suite Teardown    Suite teardown steps 

*** Variables ***
${almcfg_sys}    ieatrcx4400:6400

*** Test Cases ***
Verify no reports are added in Alarmcfg webpage
    Launch the Alarmcfg webpage in browser
    Input Alarmcfg Login Details    ${almcfg_sys}    ${almcfg_user}    ${almcfg_pass}    ${almcfg_auth}
    Click Login Button
    Click Interface link    All
    Verify no reports are added

Verify all alarmreports are deleted from database
    Skip if    '${PREV TEST STATUS}'=='FAIL' or '${PREV TEST STATUS}'=='SKIP'   
    ${dwhrep_pwd}=    Execute Command    ./test.bsh REP DWHREP | grep -i Password | cut -d ':' -f 2
    Set Client Configuration    30    prompt=REGEXP:${SERVER}\\[[^\\]]+\\]\\s\\{dcuser\\}\\s#:
    Write    echo -e "select * from AlarmReport;\ngo\n" | dbisql -n -c "UID=dwhrep;PWD=${dwhrep_pwd};eng=repdb" -host localhost -port 2641 -nogui
    ${check_almrpt_deleted}=    Read Until Prompt    strip_prompt=True
    Should Contain    ${check_almrpt_deleted}    0 rows
    Write    echo -e "select * from AlarmReportParameter;\ngo\n" | dbisql -n -c "UID=dwhrep;PWD=${dwhrep_pwd};eng=repdb" -host localhost -port 2641 -nogui
    ${check_almrpt_prm_deleted}=    Read Until Prompt    strip_prompt=True
    Should Contain    ${check_almrpt_prm_deleted}    0 rows

*** Keywords ***
Suite setup steps
    Connect to server as a dcuser
    Skip If    ${almcfg_config_status}==False
    Set Screenshot Directory    ./Screenshots

Suite teardown steps
    Capture Page Screenshot
    Close Browser
    Close All Connections

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
        Click Interface link    All
        Element Should Contain    id:action_title    No reports  
    END
    Sleep    2s
