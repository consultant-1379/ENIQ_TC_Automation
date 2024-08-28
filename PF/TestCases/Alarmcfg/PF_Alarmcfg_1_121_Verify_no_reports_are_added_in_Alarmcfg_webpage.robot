*** Settings ***
Documentation     Testing Alarmcfg Webpage
Library    RPA.Browser.Selenium      
Resource    ../../Resources/Keywords/Alarmcfg_keywords.robot
Resource    ../../Resources/Keywords/Variables.robot
Suite setup       Suite setup steps
Library    DateTime
Library    SSHLibrary
Resource    ../../Resources/Keywords/Engine.robot
Resource    ../../Resources/Keywords/Cli.robot
Library     ../../Scripts/random_password_complaint_generation.py
Test Teardown    Close All Connections

*** Variables ***
${almcfg_sys}    ieatrcx4400:6400
${60min_alm_template_db}    AUTOMATION_ERBSG2_ENODEBFUNCTION_60MIN
${60min_basetable_db}    DC_E_ERBSG2_ENODEBFUNCTION_RAW
${60min_almrpt_name}    AlarmInterface_60min
${reports_alarmname_db}    AUTOMATION_ERBSG2_ENODEBFUNCTION_60MIN


${30min_alm_template_db}    AUTOMATION_ERBSG2_EXTERNALGERANCELL_30MIN
${30min_basetable_db}    DC_E_ERBSG2_EXTERNALGERANCELL_RAW
${30min_almrpt_name}    AlarmInterface_30min
${reports_alarmname_db}    AUTOMATION_ERBSG2_EXTERNALGERANCELL_30MIN

${15min_alm_template_db}    AUTOMATION_ERBSG2_EUTRANCELLTDD_15MINS
${15min_basetable_db}    DC_E_ERBSG2_EUTRANCELLTDD_RAW
${15min_almrpt_name}    AlarmInterface_15min
${reports_alarmname_db}    AUTOMATION_ERBSG2_EUTRANCELLTDD_15MINS


${10min_alm_template_db}    AUTOMATION_ERBSG2_SECTORCARRIER_10MIN
${10min_basetable_db}    DC_E_ERBSG2_SECTORCARRIER_RAW
${10min_almrpt_name}    AlarmInterface_10min
${reports_alarmname_db}    AUTOMATION_ERBSG2_SECTORCARRIER_10MIN


${5min_alm_template_db}    AUTOMATION_ERBSG2_SECURITYHANDLING_5MIN
${5min_basetable_db}    DC_E_ERBSG2_SECURITYHANDLING_RAW
${5min_almrpt_name}    AlarmInterface_5min
${reports_alarmname_db}    AUTOMATION_ERBSG2_SECURITYHANDLING_5MIN


${rd_alm_template_db}    AUTOMATION_ERBSG2_MBMSSERVICE_RD
${rd_basetable_db}    DC_E_ERBSG2_MBMSSERVICE_RAW
${rd_almrpt_name}    AlarmInterface_RD
${reports_alarmname_db}    AUTOMATION_ERBSG2_MBMSSERVICE_RD




*** Test Cases ***
TC 01 Verify launching of Alarmcfg page
    Launch the Alarmcfg webpage in browser
    Verify Alarmcfg webpage is displayed
    [Teardown]    Test teardown
    
TC 02 Verify Home page and links in the home page of Alarmcfg
    Launch the Alarmcfg webpage in browser
    Input Alarmcfg Login Details    ${almcfg_sys}    ${almcfg_user}    ${almcfg_pass}    ${almcfg_auth}
    Wait Until Keyword Succeeds    2x    5s    Verify Alarmcfg webpage logged in successfully
    Verify the All Subcategories links in Alarmcfg Homepage is displayed 
    Logout Alarmcfg webpage
    [Teardown]    Test teardown

TC 03 Verify Alarmcfg login with Incorrect credentials
    Launch the Alarmcfg webpage in browser
    Input Alarmcfg Login Details    ${incorrect_system}    ${incorrect_username}    ${incorrect_password}    ${incorrect_auth}
    Click Login Button
    Verify Homepage is not displayed 
    [Teardown]    Test teardown

TC 04 Verify Alarmcfg login with Incorrect Username
    Launch the Alarmcfg webpage in browser
    Input Alarmcfg Login Details    ${almcfg_sys}    ${incorrect_username}    ${almcfg_pass}    ${almcfg_auth}
    Click Login Button
    Verify Homepage is not displayed
    # mitigation steps for login with incorrect username testcase
    # Input Alarmcfg Login Details    ${almcfg_sys}    ${almcfg_user}    ${almcfg_pass}    ${almcfg_auth}
    # Wait Until Keyword Succeeds    2x    5s    Verify Alarmcfg webpage logged in successfully
    # Logout Alarmcfg webpage 
    [Teardown]    Test teardown

TC 05 Verify Alarmcfg login with Incorrect password
    Launch the Alarmcfg webpage in browser
    Input Alarmcfg Login Details    ${almcfg_sys}    ${almcfg_user}    ${incorrect_password}    ${almcfg_auth}
    Click Login Button
    Verify Homepage is not displayed
    [Teardown]    Test teardown

TC 06 Verify Alarmcfg login with Incorrect system
    Launch the Alarmcfg webpage in browser 
    Input Alarmcfg Login Details    ${incorrect_system}    ${almcfg_user}    ${almcfg_pass}    ${almcfg_auth}  
    Click Login Button
    Verify Homepage is not displayed
    # mitigation steps for login with incorrect system testcase
    # Input Alarmcfg Login Details    ${almcfg_sys}    ${almcfg_user}    ${almcfg_pass}    ${almcfg_auth}
    # Wait Until Keyword Succeeds    2x    5s    Verify Alarmcfg webpage logged in successfully
    # Logout Alarmcfg webpage
    [Teardown]    Test teardown

TC 07 Verify Alarmcfg login with Incorrect Authentication
    Launch the Alarmcfg webpage in browser
    Input Alarmcfg Login Details    ${almcfg_sys}    ${almcfg_user}    ${almcfg_pass}    ${incorrect_auth}
    Click Login Button
    Verify Homepage is not displayed
    [Teardown]    Test teardown

TC 08 Verify Launch of alarmcfg with server ip address with 8443 port
    Launch the Alarmcfg webpage with ip address in browser
    Input Alarmcfg Login Details    ${almcfg_sys}    ${almcfg_user}    ${almcfg_pass}    ${almcfg_auth}
    Wait Until Keyword Succeeds    2x    5s    Verify Alarmcfg webpage logged in successfully
    Logout Alarmcfg webpage
    [Teardown]    Test teardown

TC 09 Verify logout of Alarmcfg webpage
    Launch the Alarmcfg webpage in browser
    Input Alarmcfg Login Details    ${almcfg_sys}    ${almcfg_user}    ${almcfg_pass}    ${almcfg_auth}
    Wait Until Keyword Succeeds    2x    5s    Verify Alarmcfg webpage logged in successfully
    Logout Alarmcfg webpage
    Verify Alarmcfg webpage logged out
    [Teardown]    Test teardown

TC 10 Verify Reduced Delay Alarm Interface link is working
    Launch the Alarmcfg webpage in browser
    Input Alarmcfg Login Details    ${almcfg_sys}    ${almcfg_user}    ${almcfg_pass}    ${almcfg_auth}
    Wait Until Keyword Succeeds    2x    5s    Verify Alarmcfg webpage logged in successfully
    Click Interface link    Reduced Delay
    Verify Interface page is displayed    Reduced Delay

TC 11 Verify Add report button in Reduced Delay Alarm lnterface   
    Verify Add report Button is visible
    Logout Alarmcfg webpage

TC 12 Verify 5min Alarm Interface link is working
    Launch the Alarmcfg webpage in browser
    Input Alarmcfg Login Details    ${almcfg_sys}    ${almcfg_user}    ${almcfg_pass}    ${almcfg_auth}
    Wait Until Keyword Succeeds    2x    5s    Verify Alarmcfg webpage logged in successfully
    Click Interface link    5min
    Verify Interface page is displayed    5min

TC 13 Verify Add report button in 5min Alarm lnterface   
    Verify Add report Button is visible
    Logout Alarmcfg webpage

TC 14 Verify 10min Alarm Interface link is working
    Launch the Alarmcfg webpage in browser
    Input Alarmcfg Login Details    ${almcfg_sys}    ${almcfg_user}    ${almcfg_pass}    ${almcfg_auth}
    Wait Until Keyword Succeeds    2x    5s    Verify Alarmcfg webpage logged in successfully
    Click Interface link    10min
    Verify Interface page is displayed    10min

TC 15 Verify Add report button in 10min Alarm lnterface   
    Verify Add report Button is visible
    Logout Alarmcfg webpage

TC 16 Verify 15min Alarm Interface link is working
    Launch the Alarmcfg webpage in browser
    Input Alarmcfg Login Details    ${almcfg_sys}    ${almcfg_user}    ${almcfg_pass}    ${almcfg_auth}
    Wait Until Keyword Succeeds    2x    5s    Verify Alarmcfg webpage logged in successfully
    Click Interface link    15min
    Verify Interface page is displayed    15min

TC 17 Verify Add report button in 15min Alarm lnterface   
    Verify Add report Button is visible
    Logout Alarmcfg webpage
    
TC 18 Verify 30min Alarm Interface link is working
    Launch the Alarmcfg webpage in browser
    Input Alarmcfg Login Details    ${almcfg_sys}    ${almcfg_user}    ${almcfg_pass}    ${almcfg_auth}
    Wait Until Keyword Succeeds    2x    5s    Verify Alarmcfg webpage logged in successfully
    Click Interface link    30min
    Verify Interface page is displayed    30min

TC 19 Verify Add report button in 30min Alarm lnterface   
    Verify Add report Button is visible
    Logout Alarmcfg webpage

TC 20 Verify 60min Alarm Interface link is working
    Launch the Alarmcfg webpage in browser
    Input Alarmcfg Login Details    ${almcfg_sys}    ${almcfg_user}    ${almcfg_pass}    ${almcfg_auth}
    Wait Until Keyword Succeeds    2x    5s    Verify Alarmcfg webpage logged in successfully
    Click Interface link    60min
    Verify Interface page is displayed    60min

TC 21 Verify Add report button in 60min Alarm lnterface   
    Verify Add report Button is visible
    Logout Alarmcfg webpage

TC 22 Verify 6h Alarm Interface link is working
    Launch the Alarmcfg webpage in browser
    Input Alarmcfg Login Details    ${almcfg_sys}    ${almcfg_user}    ${almcfg_pass}    ${almcfg_auth}
    Wait Until Keyword Succeeds    2x    5s    Verify Alarmcfg webpage logged in successfully
    Click Interface link    6h
    Verify Interface page is displayed    6h

TC 23 Verify Add report button in 6h Alarm lnterface   
    Verify Add report Button is visible
    Logout Alarmcfg webpage

TC 24 Verify 12h Alarm Interface link is working
    Launch the Alarmcfg webpage in browser
    Input Alarmcfg Login Details    ${almcfg_sys}    ${almcfg_user}    ${almcfg_pass}    ${almcfg_auth}
    Wait Until Keyword Succeeds    2x    5s    Verify Alarmcfg webpage logged in successfully
    Click Interface link    12h
    Verify Interface page is displayed    12h

TC 25 Verify Add report button in 12h Alarm lnterface   
    Verify Add report Button is visible
    Logout Alarmcfg webpage
  
TC 26 Verify 24h Alarm Interface link is working
    Launch the Alarmcfg webpage in browser
    Input Alarmcfg Login Details    ${almcfg_sys}    ${almcfg_user}    ${almcfg_pass}    ${almcfg_auth}
    Wait Until Keyword Succeeds    2x    5s    Verify Alarmcfg webpage logged in successfully
    Click Interface link    24h
    Verify Interface page is displayed    24h

TC 27 Verify Add report button in 24h Alarm lnterface   
    Verify Add report Button is visible
    Logout Alarmcfg webpage

TC 28 Verify All Alarm Interface link is working
    Launch the Alarmcfg webpage in browser
    Input Alarmcfg Login Details    ${almcfg_sys}    ${almcfg_user}    ${almcfg_pass}    ${almcfg_auth}
    Wait Until Keyword Succeeds    2x    5s    Verify Alarmcfg webpage logged in successfully
    Click Interface link    All
    Verify All Alarms Interface page is displayed   
    Logout Alarmcfg webpage

TC 29 Verify login of Alarmcfg with all supported browsers
    #Default browser is chrome
    Launch the Alarmcfg webpage in browser
    Input Alarmcfg Login Details    ${almcfg_sys}    ${almcfg_user}    ${almcfg_pass}    ${almcfg_auth}
    Click Login Button
    Verify Login with valid credentials
    Logout Alarmcfg webpage
    Close Browser
      
    # Login with Firefox browser
    Launch the Alarmcfg webpage in Firefox browser    ${login_almcfg_url}   
    Input Alarmcfg Login Details    ${almcfg_sys}    ${almcfg_user}    ${almcfg_pass}    ${almcfg_auth}
    Click Login Button
    Verify Login with valid credentials
    Logout Alarmcfg webpage
    [teardown]    Test teardown

TC 30 Verify changing of password with allowed character 
    Connect to server as a dcuser
    ${output_of_changing_password_script}=    Executing password change script and providing complaint random generated password
    ${check_password_is_complaint}=    Verify password is changed    ${output_of_changing_password_script}
    changing password to old password    ${check_password_is_complaint}

TC 31 Verify changing of password with not allowed character
    Connect to server as a dcuser
    ${output_of_changing_password_scripts}=    Executing change password script and providing noncomplaint random genrated password
    Verify password is not changed    ${output_of_changing_password_scripts}   

TC 32 Verify change alarm password script will not get executed with root user 
    Open connection as root user
    ${cmd_output}=    Execute Command    /eniq/sw/bin/change_alarm_password.bsh
    Verify change alarm password script is not executed    ${cmd_output}    This script must be executed as dcuser
    [Teardown]    Test Teardown 

TC 33 Verify Launch of Alarmcfg url with invalid port
    Launch Alarmcfg url with invalid port
    Verify message is displayed    This site can’t be reached 
    [Teardown]    Test teardown

TC 34 Verify Launch of Alarmcfg ip address with invalid port
    Launch Alarmcfg ip address with invalid port
    Verify message is displayed    This site can’t be reached 
    [Teardown]    Test teardown

TC 35 Verify Reduced delay Interface Alarm report addition
    Launch the Alarmcfg webpage in browser
    Input Alarmcfg Login Details    ${almcfg_sys}    ${almcfg_user}    ${almcfg_pass}    ${almcfg_auth}
    Wait Until Keyword Succeeds    2x    5s    Verify Alarmcfg webpage logged in successfully
    Click Interface link    Reduced Delay
    Verify Interface page is displayed    Reduced Delay
    Verify target reports are not added    ${Reduced_delay_basetable}    ${Reduced_delay_alm_template}    Reduced Delay
    Click Add report button
    Select alarm template from available reports    ${Reduced_delay_alm_template}
    Select basetable from dropdown list    ${Reduced_delay_basetable}
    Click Add alarm report button
    Verify alarm report addition     ${Reduced_delay_basetable}    ${Reduced_delay_alm_template}

TC 36 Verify Reduced delay Interface Alarm report disabled
    Skip if    '${PREV TEST STATUS}'=='FAIL' or '${PREV TEST STATUS}'=='SKIP'
    Disable Alarm report    Reduced Delay    ${Reduced_delay_basetable}    ${Reduced_delay_alm_template}
    Verify message is displayed    successfully disabled

TC 37 Verify Reduced delay Interface Alarm report enabled
    Skip if    '${PREV TEST STATUS}'=='SKIP'
    Enable Alarm report    Reduced Delay    ${Reduced_delay_basetable}    ${Reduced_delay_alm_template}
    Verify message is displayed    successfully enabled

TC 38 Verify Reduced delay Interface Alarm report deletion
    Skip if    '${PREV TEST STATUS}'=='SKIP'
    Delete Alarm report    Reduced Delay    ${Reduced_delay_basetable}    ${Reduced_delay_alm_template}
    Verify message is displayed    successfully removed

TC 39 Verify 5min Interface Alarm report addition
    Launch the Alarmcfg webpage in browser
    Input Alarmcfg Login Details    ${almcfg_sys}    ${almcfg_user}    ${almcfg_pass}    ${almcfg_auth}
    Wait Until Keyword Succeeds    2x    5s    Verify Alarmcfg webpage logged in successfully
    Click Interface link    5min
    Verify Interface page is displayed    5min
    Verify target reports are not added    ${5min_basetable}    ${5min_alm_template}    5min
    Click Add report button
    Select alarm template from available reports    ${5min_alm_template}
    Select basetable from dropdown list    ${5min_basetable}
    Click Add alarm report button
    ${alm_report_status}=    Verify alarm report addition    ${5min_basetable}    ${5min_alm_template} 
    Skip If    ${alm_report_status}==False 

TC 40 Verify 5min Interface Alarm report disabled    
    Skip if    '${PREV TEST STATUS}'=='FAIL' or '${PREV TEST STATUS}'=='SKIP'
    Disable Alarm report    5min    ${5min_basetable}    ${5min_alm_template}
    Verify message is displayed    successfully disabled

TC 41 Verify 5min Interface Alarm report enabled
    Skip if    '${PREV TEST STATUS}'=='SKIP'
    Enable Alarm report    5min    ${5min_basetable}    ${5min_alm_template}
    Verify message is displayed    successfully enabled

TC 42 Verify 5min Interface Alarm report deletion
    Skip if    '${PREV TEST STATUS}'=='SKIP'
    Delete Alarm report    5min    ${5min_basetable}    ${5min_alm_template}
    Verify message is displayed    successfully removed

TC 43 Verify 10min Interface Alarm report addition
    Launch the Alarmcfg webpage in browser
    Input Alarmcfg Login Details    ${almcfg_sys}    ${almcfg_user}    ${almcfg_pass}    ${almcfg_auth}
    Wait Until Keyword Succeeds    2x    5s    Verify Alarmcfg webpage logged in successfully
    Click Interface link    10min
    Verify Interface page is displayed    10min
    Verify target reports are not added    ${10min_basetable}    ${10min_alm_template}    10min
    Click Add report button
    Select alarm template from available reports    ${10min_alm_template}
    Select basetable from dropdown list    ${10min_basetable}
    Click Add alarm report button
    Verify alarm report addition     ${10min_basetable}    ${10min_alm_template}

TC 44 Verify 10min Interface Alarm report disabled
    Skip if    '${PREV TEST STATUS}'=='FAIL' or '${PREV TEST STATUS}'=='SKIP'
    Disable Alarm report    10min    ${10min_basetable}    ${10min_alm_template}
    Verify message is displayed    successfully disabled

TC 45 Verify 10min Interface Alarm report enabled
    Skip if    '${PREV TEST STATUS}'=='SKIP'
    Enable Alarm report    10min    ${10min_basetable}    ${10min_alm_template}
    Verify message is displayed    successfully enabled

TC 46 Verify 10min Interface Alarm report deletion
    Skip if    '${PREV TEST STATUS}'=='SKIP'
    Delete Alarm report    10min    ${10min_basetable}    ${10min_alm_template}
    Verify message is displayed    successfully removed

TC 47 Verify 15min Interface Alarm report addition
    Launch the Alarmcfg webpage in browser
    Input Alarmcfg Login Details    ${almcfg_sys}    ${almcfg_user}    ${almcfg_pass}    ${almcfg_auth}
    Wait Until Keyword Succeeds    2x    5s    Verify Alarmcfg webpage logged in successfully
    Click Interface link    15min
    Verify Interface page is displayed    15min
    Verify target reports are not added    ${15min_basetable}    ${15min_alm_template}    15min
    Click Add report button
    Select alarm template from available reports    ${15min_alm_template}
    Select basetable from dropdown list    ${15min_basetable}
    Click Add alarm report button
    Verify alarm report addition     ${15min_basetable}    ${15min_alm_template}

TC 48 Verify 15min Interface Alarm report disabled
    Skip if    '${PREV TEST STATUS}'=='FAIL' or '${PREV TEST STATUS}'=='SKIP'
    Disable Alarm report    15min    ${15min_basetable}    ${15min_alm_template}
    Verify message is displayed    successfully disabled

TC 49 Verify 15min Interface Alarm report enabled
    Skip if    '${PREV TEST STATUS}'=='SKIP'
    Enable Alarm report    15min    ${15min_basetable}    ${15min_alm_template}
    Verify message is displayed    successfully enabled

TC 50 Verify 15min Interface Alarm report deletion
    Skip if    '${PREV TEST STATUS}'=='SKIP'
    Delete Alarm report    15min    ${15min_basetable}    ${15min_alm_template}
    Verify message is displayed    successfully removed

TC 51 Verify 30min Interface Alarm report addition
    Launch the Alarmcfg webpage in browser
    Input Alarmcfg Login Details    ${almcfg_sys}    ${almcfg_user}    ${almcfg_pass}    ${almcfg_auth}
    Wait Until Keyword Succeeds    2x    5s    Verify Alarmcfg webpage logged in successfully
    Click Interface link    30min
    Verify Interface page is displayed    30min
    Verify target reports are not added    ${30min_basetable}    ${30min_alm_template}    30min
    Click Add report button
    Select alarm template from available reports    ${30min_alm_template}
    Select basetable from dropdown list    ${30min_basetable}
    Click Add alarm report button
    Verify alarm report addition     ${30min_basetable}    ${30min_alm_template}

TC 52 Verify 30min Interface Alarm report disabled
    Skip if    '${PREV TEST STATUS}'=='FAIL' or '${PREV TEST STATUS}'=='SKIP'
    Disable Alarm report    30min    ${30min_basetable}    ${30min_alm_template}
    Verify message is displayed    successfully disabled

TC 53 Verify 30min Interface Alarm report enabled
    Skip if    '${PREV TEST STATUS}'=='SKIP'
    Enable Alarm report    30min    ${30min_basetable}    ${30min_alm_template}
    Verify message is displayed    successfully enabled

TC 54 Verify 30min Interface Alarm report deletion
    Skip if    '${PREV TEST STATUS}'=='SKIP'
    Delete Alarm report    30min    ${30min_basetable}    ${30min_alm_template}
    Verify message is displayed    successfully removed

TC 55 Verify 60min Interface Alarm report addition
    Launch the Alarmcfg webpage in browser
    Input Alarmcfg Login Details    ${almcfg_sys}    ${almcfg_user}    ${almcfg_pass}    ${almcfg_auth}
    Wait Until Keyword Succeeds    2x    5s    Verify Alarmcfg webpage logged in successfully
    Click Interface link    60min
    Verify Interface page is displayed    60min
    Verify target reports are not added    ${60min_basetable}    ${60min_alm_template}    60min
    Click Add report button
    Select alarm template from available reports    ${60min_alm_template}
    Select basetable from dropdown list    ${60min_basetable}
    Click Add alarm report button
    Verify alarm report addition     ${60min_basetable}    ${60min_alm_template}

TC 56 Verify 60min Interface Alarm report disabled
    Skip if    '${PREV TEST STATUS}'=='FAIL' or '${PREV TEST STATUS}'=='SKIP'
    Disable Alarm report    60min    ${60min_basetable}    ${60min_alm_template}
    Verify message is displayed    successfully disabled

TC 57 Verify 60min Interface Alarm report enabled
    Skip if    '${PREV TEST STATUS}'=='SKIP'
    Enable Alarm report    60min    ${60min_basetable}    ${60min_alm_template}
    Verify message is displayed    successfully enabled

TC 58 Verify 60min Interface Alarm report deletion
    Skip if    '${PREV TEST STATUS}'=='SKIP'
    Delete Alarm report    60min    ${60min_basetable}    ${60min_alm_template}
    Verify message is displayed    successfully removed

TC 59 Verify 6h Interface Alarm report addition
    Launch the Alarmcfg webpage in browser
    Input Alarmcfg Login Details    ${almcfg_sys}    ${almcfg_user}    ${almcfg_pass}    ${almcfg_auth}
    Wait Until Keyword Succeeds    2x    5s    Verify Alarmcfg webpage logged in successfully
    Click Interface link    6h
    Verify Interface page is displayed    6h
    Verify target reports are not added    ${6h_basetable}    ${6h_alm_template}    6h
    Click Add report button
    Select alarm template from available reports    ${6h_alm_template}
    Select basetable from dropdown list    ${6h_basetable}
    Click Add alarm report button
    Verify alarm report addition     ${6h_basetable}    ${6h_alm_template}

TC 60 Verify 6h Interface Alarm report disabled
    Skip if    '${PREV TEST STATUS}'=='FAIL' or '${PREV TEST STATUS}'=='SKIP'
    Disable Alarm report    6h    ${6h_basetable}    ${6h_alm_template}
    Verify message is displayed    successfully disabled

TC 61 Verify 6h Interface Alarm report enabled
    Skip if    '${PREV TEST STATUS}'=='SKIP'
    Enable Alarm report    6h    ${6h_basetable}    ${6h_alm_template}
    Verify message is displayed    successfully enabled

TC 62 Verify 6h Interface Alarm report deletion
    Skip if    '${PREV TEST STATUS}'=='SKIP'
    Delete Alarm report    6h    ${6h_basetable}    ${6h_alm_template}
    Verify message is displayed    successfully removed

TC 63 Verify 12h Interface Alarm report addition
    Launch the Alarmcfg webpage in browser
    Input Alarmcfg Login Details    ${almcfg_sys}    ${almcfg_user}    ${almcfg_pass}    ${almcfg_auth}
    Wait Until Keyword Succeeds    2x    5s    Verify Alarmcfg webpage logged in successfully
    Click Interface link    12h
    Verify Interface page is displayed    12h
    Verify target reports are not added    ${12h_basetable}    ${12h_alm_template}    12h
    Click Add report button
    Select alarm template from available reports    ${12h_alm_template}
    Select basetable from dropdown list    ${12h_basetable}
    Click Add alarm report button
    Verify alarm report addition     ${12h_basetable}    ${12h_alm_template}

TC 64 Verify 12h Interface Alarm report disabled
    Skip if    '${PREV TEST STATUS}'=='FAIL' or '${PREV TEST STATUS}'=='SKIP'
    Disable Alarm report    12h    ${12h_basetable}    ${12h_alm_template}
    Verify message is displayed    successfully disabled

TC 65 Verify 12h Interface Alarm report enabled
    Skip if    '${PREV TEST STATUS}'=='SKIP'
    Enable Alarm report    12h    ${12h_basetable}    ${12h_alm_template}
    Verify message is displayed    successfully enabled

TC 66 Verify 12h Interface Alarm report deletion
    Skip if    '${PREV TEST STATUS}'=='SKIP'
    Delete Alarm report    12h    ${12h_basetable}    ${12h_alm_template}
    Verify message is displayed    successfully removed

TC 67 Verify 24h Interface Alarm report addition
    Launch the Alarmcfg webpage in browser
    Input Alarmcfg Login Details    ${almcfg_sys}    ${almcfg_user}    ${almcfg_pass}    ${almcfg_auth}
    Wait Until Keyword Succeeds    2x    5s    Verify Alarmcfg webpage logged in successfully
    Click Interface link    24h
    Verify Interface page is displayed    24h
    Verify target reports are not added    ${24h_basetable}    ${24h_alm_template}    24h
    Click Add report button
    Select alarm template from available reports    ${24h_alm_template}
    Select basetable from dropdown list    ${24h_basetable}
    Click Add alarm report button
    Verify alarm report addition     ${24h_basetable}    ${24h_alm_template}

TC 68 Verify 24h Interface Alarm report disabled
    Skip if    '${PREV TEST STATUS}'=='FAIL' or '${PREV TEST STATUS}'=='SKIP'
    Disable Alarm report    24h    ${24h_basetable}    ${24h_alm_template}
    Verify message is displayed    successfully disabled

TC 69 Verify 24h Interface Alarm report enabled
    Skip if    '${PREV TEST STATUS}'=='SKIP'
    Enable Alarm report    24h    ${24h_basetable}    ${24h_alm_template}
    Verify message is displayed    successfully enabled

TC 70 Verify 24h Interface Alarm report deletion
    Skip if    '${PREV TEST STATUS}'=='SKIP'
    Delete Alarm report    24h    ${24h_basetable}    ${24h_alm_template}
    Verify message is displayed    successfully removed

TC 71 Verify if Alarmcfg log has any error
    Connect to server as a dcuser
    ${latest_file}=    Getting latest file from the folder    ${Alarmcfg_folder}    ${latest_Alarmcfg_file}   
    ${faliure_logs}=   Opening the AlarmCfg latest file and searching for failure    ${latest_file}  
    verify logs should not contain faliure    ${faliure_logs}

TC 72 Verify if common-text jar file exist
    Connect to server as a dcuser
    ${list_of_common_texts_jar_file_in_externalPath}    listing all files in path and search for common text jar    ${external_path}
    Verify if common text file exist in file path    ${list_of_common_texts_jar_file_in_externalPath}   
   
    ${list_of_common_texts_jar_file_in_libPath}    listing all files in path and search for common text jar    ${lib_path}
     Verify if common text file exist in file path    ${list_of_common_texts_jar_file_in_libPath}

TC 74 Verify the Alarm interface INTF_DC_Z_ALARM log any exceptions or errors
    Connect to server as a dcuser
    ${latest_alarm_interface_log}=    Getting latest file from the folder    ${alarm_interface_path}    ${latest_engine_file}
    ${failure_logs}    Opening the AlarmInterface latest file and checking for failure message    ${latest_alarm_interface_log}
    verify logs should not contain faliure    ${failure_logs}  

TC 75 Verify the loader_DC_Z_ALARM log for Failure
    Connect to server as a dcuser
    ${latest_file}=    Getting latest file from the folder    ${DC_Z_Log_path}    ${latest_engine_file}
    ${failure_logs}=    Opening the loader_DC_Z_ALARM latest file and checking for failure message  ${latest_file}
    verify logs should not contain faliure    ${failure_logs}

TC 76 verify AlarmInterfaces log for Success
    Connect to server as a dcuser
    ${latest_file}=    Getting latest file from the folder    ${Alarm_folder}    ${latest_engine_file}
    ${Success_logs}=    Opening the Alarm latest file and checking for Success message  ${latest_file}
    verify logs should contain success message    ${Success_logs}

TC 77 verify AlarmInterfaces log for any failures
    Connect to server as a dcuser
    ${latest_file}=    Getting latest file from the folder    ${Alarm_folder}    ${latest_engine_file}
    ${faliure_logs}=    Opening the AlarmInterface latest file and checking for failure    ${latest_file}
    verify logs should not contain faliure   ${faliure_logs}

TC 79_To_83 Verify 60min alarmreport status is active 
    ${dwhrep_pwd}=    Execute Command    /eniq/sw/installer/getPassword.bsh -u DWHREP | awk '{print $NF}'
    ${dwhrep_pwd_status}=    Run Keyword And Return Status    Should Not Be Empty    ${dwhrep_pwd}
    Write    echo -e "select AlarmReport.INTERFACEID,AlarmReport.REPORTID,AlarmReport.STATUS from AlarmReport INNER JOIN AlarmReportParameter ON AlarmReport.REPORTID=AlarmReportParameter.REPORTID where AlarmReportParameter.VALUE='${60min_basetable_db}'and AlarmReport.INTERFACEID='${60min_almrpt_name}' and AlarmReport.REPORTNAME='${60min_alm_template_db}';\ngo\n" | dbisql -n -c "UID=dwhrep;PWD=${dwhrep_pwd};eng=repdb" -host localhost -port 2641 -nogui | grep -i "Alarm" 
    ${almrpt_db_output}=    Read Until Prompt    strip_prompt=True
    Should Match Regexp    ${almrpt_db_output}    \\bACTIVE\\b
    @{almrpt_id_list}=    Get Regexp Matches     ${almrpt_db_output}    \\b\\S+-\\S+-\\S+-\\S+-\\S+\\b
    Should Not Be Empty    ${almrpt_id_list}
    ${almcfg_60min_almrpt_id}=    Get From List    ${almrpt_id_list}    0
    Log    ${almcfg_60min_almrpt_id} is active
    Set Global Variable    ${almcfg_60min_almrpt_id}

TC 79_To_83 Functional verification 60min alarm type -report parsing verification in file logs
    Skip if    '${PREV TEST STATUS}'=='FAIL' or '${PREV TEST STATUS}'=='SKIP'
    ${almcfg_current_date}=    Execute Command    date +"%Y_%m_%d"
    ${check_Alarminterface_file}=    Execute Command    ls /eniq/log/sw_log/engine/AlarmInterfaces/ | grep -i file-${almcfg_current_date}.log
    Log    ${check_Alarminterface_file}
    Should Not Be Empty    ${check_Alarminterface_file}
    # ${check_data_parsing}=    Execute Command    awk -F' ' '/^[0-9]{2}\.[0-9]{2} [0-9]{2}:[0-9]{2}:[0-9]{2}/ {if ($2 >= "${start_5min_time_parse_logs}") flag=1} flag' /eniq/log/sw_log/engine/AlarmInterfaces/file-${almcfg_current_date}.log | grep -i ${60min_almrpt_name} | grep -i ${60min_alm_template_db}| grep -i parsed | tail -10
    ${check_data_parsing}=    Execute Command    cat /eniq/log/sw_log/engine/AlarmInterfaces/file-${almcfg_current_date}.log | grep -i ${60min_almrpt_name} | grep -i '${60min_alm_template_db}'| grep -i parsed | tail -10
    Log    ${check_data_parsing}
    Should Not Be Empty    ${check_data_parsing}


TC 79_To_83 Functional verification 60min alarm type -report loading verification in DB
    Skip if    '${PREV TEST STATUS}'=='FAIL' or '${PREV TEST STATUS}'=='SKIP'
    ${almcfg_current_date}=    Execute Command    date +"%Y-%m-%d"
    ${dc_pwd}=    Execute Command    /eniq/sw/installer/getPassword.bsh -u DC | awk '{print $NF}'
    ${dc_pwd_status}=    Run Keyword And Return Status    Should Not Be Empty    ${dc_pwd}
    Write   echo -e "Select ROWSTATUS from DC_Z_ALARM_INFO_RAW where ReportTitle='${almcfg_60min_almrpt_id}' and TIMELEVEL='HOUR' and DATE_ID='${almcfg_current_date}';\ngo\n" | dbisql -n -c "UID=dc;PWD=${dc_pwd};eng=dwhdb" -host localhost -port 2640 -nogui
    # Write   echo -e "Select ROWSTATUS from DC_Z_ALARM_INFO_RAW where AlarmName='${reports_alarmname_db}' and TIMELEVEL='10MIN' and DATE_ID='${almcfg_current_date}';\ngo\n" | dbisql -n -c "UID=dc;PWD=${dc_pwd};eng=dwhdb" -host localhost -port 2640 -nogui
    ${almcfg_loading_db}=    Read Until Prompt    strip_prompt=True
    @{almrpt_loaded_list}=    Get Regexp Matches     ${almcfg_loading_db}    \\bLOADED\\b
    Log    ${almrpt_loaded_list}
    Should Not Be Empty    ${almrpt_loaded_list} 


TC 86_To_90 Verify 30min alarmreport status is active 
    ${dwhrep_pwd}=    Execute Command    /eniq/sw/installer/getPassword.bsh -u DWHREP | awk '{print $NF}'
    ${dwhrep_pwd_status}=    Run Keyword And Return Status    Should Not Be Empty    ${dwhrep_pwd}
    Write    echo -e "select AlarmReport.INTERFACEID,AlarmReport.REPORTID,AlarmReport.STATUS from AlarmReport INNER JOIN AlarmReportParameter ON AlarmReport.REPORTID=AlarmReportParameter.REPORTID where AlarmReportParameter.VALUE='${30min_basetable_db}'and AlarmReport.INTERFACEID='${30min_almrpt_name}' and AlarmReport.REPORTNAME='${30min_alm_template_db}';\ngo\n" | dbisql -n -c "UID=dwhrep;PWD=${dwhrep_pwd};eng=repdb" -host localhost -port 2641 -nogui | grep -i "Alarm" 
    ${almrpt_db_output}=    Read Until Prompt    strip_prompt=True
    Should Match Regexp    ${almrpt_db_output}    \\bACTIVE\\b
    @{almrpt_id_list}=    Get Regexp Matches     ${almrpt_db_output}    \\b\\S+-\\S+-\\S+-\\S+-\\S+\\b
    Should Not Be Empty    ${almrpt_id_list}
    ${almcfg_30min_almrpt_id}=    Get From List    ${almrpt_id_list}    0
    Log    ${almcfg_30min_almrpt_id} is active
    Set Global Variable    ${almcfg_30min_almrpt_id}

TC 86_To_90 Functional verification 30min alarm type -report parsing verification in file logs
    Skip if    '${PREV TEST STATUS}'=='FAIL' or '${PREV TEST STATUS}'=='SKIP'
    ${almcfg_current_date}=    Execute Command    date +"%Y_%m_%d"
    ${check_Alarminterface_file}=    Execute Command    ls /eniq/log/sw_log/engine/AlarmInterfaces/ | grep -i file-${almcfg_current_date}.log
    Log    ${check_Alarminterface_file}
    Should Not Be Empty    ${check_Alarminterface_file}
    # ${check_data_parsing}=    Execute Command    awk -F' ' '/^[0-9]{2}\.[0-9]{2} [0-9]{2}:[0-9]{2}:[0-9]{2}/ {if ($2 >= "${start_5min_time_parse_logs}") flag=1} flag' /eniq/log/sw_log/engine/AlarmInterfaces/file-${almcfg_current_date}.log | grep -i ${30min_almrpt_name} | grep -i ${30min_alm_template_db}| grep -i parsed | tail -10
    ${check_data_parsing}=    Execute Command    cat /eniq/log/sw_log/engine/AlarmInterfaces/file-${almcfg_current_date}.log | grep -i ${30min_almrpt_name} | grep -i '${30min_alm_template_db}'| grep -i parsed | tail -10
    Log    ${check_data_parsing}
    Should Not Be Empty    ${check_data_parsing}


TC 86_To_90 Functional verification 30min alarm type -report loading verification in DB
    Skip if    '${PREV TEST STATUS}'=='FAIL' or '${PREV TEST STATUS}'=='SKIP'
    ${almcfg_current_date}=    Execute Command    date +"%Y-%m-%d"
    ${dc_pwd}=    Execute Command    /eniq/sw/installer/getPassword.bsh -u DC | awk '{print $NF}'
    ${dc_pwd_status}=    Run Keyword And Return Status    Should Not Be Empty    ${dc_pwd}
    Write   echo -e "Select ROWSTATUS from DC_Z_ALARM_INFO_RAW where ReportTitle='${almcfg_30min_almrpt_id}' and TIMELEVEL='30MIN' and DATE_ID='${almcfg_current_date}';\ngo\n" | dbisql -n -c "UID=dc;PWD=${dc_pwd};eng=dwhdb" -host localhost -port 2640 -nogui
    # Write   echo -e "Select ROWSTATUS from DC_Z_ALARM_INFO_RAW where AlarmName='${reports_alarmname_db}' and TIMELEVEL='10MIN' and DATE_ID='${almcfg_current_date}';\ngo\n" | dbisql -n -c "UID=dc;PWD=${dc_pwd};eng=dwhdb" -host localhost -port 2640 -nogui
    ${almcfg_loading_db}=    Read Until Prompt    strip_prompt=True
    @{almrpt_loaded_list}=    Get Regexp Matches     ${almcfg_loading_db}    \\bLOADED\\b
    Log    ${almrpt_loaded_list}
    Should Not Be Empty    ${almrpt_loaded_list}   


TC 93_To_97 Verify 15min alarmreport status is active 
    ${dwhrep_pwd}=    Execute Command    /eniq/sw/installer/getPassword.bsh -u DWHREP | awk '{print $NF}'
    ${dwhrep_pwd_status}=    Run Keyword And Return Status    Should Not Be Empty    ${dwhrep_pwd}
    Write    echo -e "select AlarmReport.INTERFACEID,AlarmReport.REPORTID,AlarmReport.STATUS from AlarmReport INNER JOIN AlarmReportParameter ON AlarmReport.REPORTID=AlarmReportParameter.REPORTID where AlarmReportParameter.VALUE='${15min_basetable_db}'and AlarmReport.INTERFACEID='${15min_almrpt_name}' and AlarmReport.REPORTNAME='${15min_alm_template_db}';\ngo\n" | dbisql -n -c "UID=dwhrep;PWD=${dwhrep_pwd};eng=repdb" -host localhost -port 2641 -nogui | grep -i "Alarm" 
    ${almrpt_db_output}=    Read Until Prompt    strip_prompt=True
    Should Match Regexp    ${almrpt_db_output}    \\bACTIVE\\b
    @{almrpt_id_list}=    Get Regexp Matches     ${almrpt_db_output}    \\b\\S+-\\S+-\\S+-\\S+-\\S+\\b
    Should Not Be Empty    ${almrpt_id_list}
    ${almcfg_15min_almrpt_id}=    Get From List    ${almrpt_id_list}    0
    Log    ${almcfg_15min_almrpt_id} is active
    Set Global Variable    ${almcfg_15min_almrpt_id}

TC 93_To_97 Functional verification 15min alarm type -report parsing verification in file logs
    Skip if    '${PREV TEST STATUS}'=='FAIL' or '${PREV TEST STATUS}'=='SKIP'
    ${almcfg_current_date}=    Execute Command    date +"%Y_%m_%d"
    ${check_Alarminterface_file}=    Execute Command    ls /eniq/log/sw_log/engine/AlarmInterfaces/ | grep -i file-${almcfg_current_date}.log
    Log    ${check_Alarminterface_file}
    Should Not Be Empty    ${check_Alarminterface_file}
    # ${check_data_parsing}=    Execute Command    awk -F' ' '/^[0-9]{2}\.[0-9]{2} [0-9]{2}:[0-9]{2}:[0-9]{2}/ {if ($2 >= "${start_5min_time_parse_logs}") flag=1} flag' /eniq/log/sw_log/engine/AlarmInterfaces/file-${almcfg_current_date}.log | grep -i ${15min_almrpt_name} | grep -i ${15min_alm_template_db}| grep -i parsed | tail -10
    ${check_data_parsing}=    Execute Command    cat /eniq/log/sw_log/engine/AlarmInterfaces/file-${almcfg_current_date}.log | grep -i ${15min_almrpt_name} | grep -i '${15min_alm_template_db}'| grep -i parsed | tail -10
    Log    ${check_data_parsing}
    Should Not Be Empty    ${check_data_parsing}


TC 93_To_97 Functional verification 15min alarm type -report loading verification in DB
    Skip if    '${PREV TEST STATUS}'=='FAIL' or '${PREV TEST STATUS}'=='SKIP'
    ${almcfg_current_date}=    Execute Command    date +"%Y-%m-%d"
    ${dc_pwd}=    Execute Command    /eniq/sw/installer/getPassword.bsh -u DC | awk '{print $NF}'
    ${dc_pwd_status}=    Run Keyword And Return Status    Should Not Be Empty    ${dc_pwd}
    Write   echo -e "Select ROWSTATUS from DC_Z_ALARM_INFO_RAW where ReportTitle='${almcfg_15min_almrpt_id}' and TIMELEVEL='15MIN' and DATE_ID='${almcfg_current_date}';\ngo\n" | dbisql -n -c "UID=dc;PWD=${dc_pwd};eng=dwhdb" -host localhost -port 2640 -nogui
    # Write   echo -e "Select ROWSTATUS from DC_Z_ALARM_INFO_RAW where AlarmName='${reports_alarmname_db}' and TIMELEVEL='15MIN' and DATE_ID='${almcfg_current_date}';\ngo\n" | dbisql -n -c "UID=dc;PWD=${dc_pwd};eng=dwhdb" -host localhost -port 2640 -nogui
    ${almcfg_loading_db}=    Read Until Prompt    strip_prompt=True
    @{almrpt_loaded_list}=    Get Regexp Matches     ${almcfg_loading_db}    \\bLOADED\\b
    Log    ${almrpt_loaded_list}
    Should Not Be Empty    ${almrpt_loaded_list}  

TC 100_To_104 Verify 10min alarmreport status is active 
    ${dwhrep_pwd}=    Execute Command    /eniq/sw/installer/getPassword.bsh -u DWHREP | awk '{print $NF}'
    ${dwhrep_pwd_status}=    Run Keyword And Return Status    Should Not Be Empty    ${dwhrep_pwd}
    Write    echo -e "select AlarmReport.INTERFACEID,AlarmReport.REPORTID,AlarmReport.STATUS from AlarmReport INNER JOIN AlarmReportParameter ON AlarmReport.REPORTID=AlarmReportParameter.REPORTID where AlarmReportParameter.VALUE='${10min_basetable_db}'and AlarmReport.INTERFACEID='${10min_almrpt_name}' and AlarmReport.REPORTNAME='${10min_alm_template_db}';\ngo\n" | dbisql -n -c "UID=dwhrep;PWD=${dwhrep_pwd};eng=repdb" -host localhost -port 2641 -nogui | grep -i "Alarm" 
    ${almrpt_db_output}=    Read Until Prompt    strip_prompt=True
    Should Match Regexp    ${almrpt_db_output}    \\bACTIVE\\b
    @{almrpt_id_list}=    Get Regexp Matches     ${almrpt_db_output}    \\b\\S+-\\S+-\\S+-\\S+-\\S+\\b
    Should Not Be Empty    ${almrpt_id_list}
    ${almcfg_10min_almrpt_id}=    Get From List    ${almrpt_id_list}    0
    Log    ${almcfg_10min_almrpt_id} is active
    Set Global Variable    ${almcfg_10min_almrpt_id}

TC 100_To_104 Functional verification 10min alarm type -report parsing verification in file logs
    Skip if    '${PREV TEST STATUS}'=='FAIL' or '${PREV TEST STATUS}'=='SKIP'
    ${almcfg_current_date}=    Execute Command    date +"%Y_%m_%d"
    ${check_Alarminterface_file}=    Execute Command    ls /eniq/log/sw_log/engine/AlarmInterfaces/ | grep -i file-${almcfg_current_date}.log
    Log    ${check_Alarminterface_file}
    Should Not Be Empty    ${check_Alarminterface_file}
    # ${check_data_parsing}=    Execute Command    awk -F' ' '/^[0-9]{2}\.[0-9]{2} [0-9]{2}:[0-9]{2}:[0-9]{2}/ {if ($2 >= "${start_5min_time_parse_logs}") flag=1} flag' /eniq/log/sw_log/engine/AlarmInterfaces/file-${almcfg_current_date}.log | grep -i ${10min_almrpt_name} | grep -i ${10min_alm_template_db}| grep -i parsed | tail -10
    ${check_data_parsing}=    Execute Command    cat /eniq/log/sw_log/engine/AlarmInterfaces/file-${almcfg_current_date}.log | grep -i ${10min_almrpt_name} | grep -i '${10min_alm_template_db}'| grep -i parsed | tail -10
    Log    ${check_data_parsing}
    Should Not Be Empty    ${check_data_parsing}


TC 100_To_104 Functional verification 10min alarm type -report loading verification in DB
    Skip if    '${PREV TEST STATUS}'=='FAIL' or '${PREV TEST STATUS}'=='SKIP'
    ${almcfg_current_date}=    Execute Command    date +"%Y-%m-%d"
    ${dc_pwd}=    Execute Command    /eniq/sw/installer/getPassword.bsh -u DC | awk '{print $NF}'
    ${dc_pwd_status}=    Run Keyword And Return Status    Should Not Be Empty    ${dc_pwd}
    Write   echo -e "Select ROWSTATUS from DC_Z_ALARM_INFO_RAW where ReportTitle='${almcfg_10min_almrpt_id}' and TIMELEVEL='10MIN' and DATE_ID='${almcfg_current_date}';\ngo\n" | dbisql -n -c "UID=dc;PWD=${dc_pwd};eng=dwhdb" -host localhost -port 2640 -nogui
    # Write   echo -e "Select ROWSTATUS from DC_Z_ALARM_INFO_RAW where AlarmName='${reports_alarmname_db}' and TIMELEVEL='10MIN' and DATE_ID='${almcfg_current_date}';\ngo\n" | dbisql -n -c "UID=dc;PWD=${dc_pwd};eng=dwhdb" -host localhost -port 2640 -nogui
    ${almcfg_loading_db}=    Read Until Prompt    strip_prompt=True
    @{almrpt_loaded_list}=    Get Regexp Matches     ${almcfg_loading_db}    \\bLOADED\\b
    Log    ${almrpt_loaded_list}
    Should Not Be Empty    ${almrpt_loaded_list}   

TC 107_To_111 Verify 5min alarmreport status is active 
    ${dwhrep_pwd}=    Execute Command    /eniq/sw/installer/getPassword.bsh -u DWHREP | awk '{print $NF}'
    ${dwhrep_pwd_status}=    Run Keyword And Return Status    Should Not Be Empty    ${dwhrep_pwd}
    Write    echo -e "select AlarmReport.INTERFACEID,AlarmReport.REPORTID,AlarmReport.STATUS from AlarmReport INNER JOIN AlarmReportParameter ON AlarmReport.REPORTID=AlarmReportParameter.REPORTID where AlarmReportParameter.VALUE='${5min_basetable_db}'and AlarmReport.INTERFACEID='${5min_almrpt_name}' and AlarmReport.REPORTNAME='${5min_alm_template_db}';\ngo\n" | dbisql -n -c "UID=dwhrep;PWD=${dwhrep_pwd};eng=repdb" -host localhost -port 2641 -nogui | grep -i "Alarm" 
    ${almrpt_db_output}=    Read Until Prompt    strip_prompt=True
    Should Match Regexp    ${almrpt_db_output}    \\bACTIVE\\b
    @{almrpt_id_list}=    Get Regexp Matches     ${almrpt_db_output}    \\b\\S+-\\S+-\\S+-\\S+-\\S+\\b
    Should Not Be Empty    ${almrpt_id_list}
    ${almcfg_5min_almrpt_id}=    Get From List    ${almrpt_id_list}    0
    Log    ${almcfg_5min_almrpt_id} is active
    Set Global Variable    ${almcfg_5min_almrpt_id}

TC 107_To_111 Functional verification 5min alarm type -report parsing verification in file logs
    Skip if    '${PREV TEST STATUS}'=='FAIL' or '${PREV TEST STATUS}'=='SKIP'
    ${almcfg_current_date}=    Execute Command    date +"%Y_%m_%d"
    ${check_Alarminterface_file}=    Execute Command    ls /eniq/log/sw_log/engine/AlarmInterfaces/ | grep -i file-${almcfg_current_date}.log
    Log    ${check_Alarminterface_file}
    Should Not Be Empty    ${check_Alarminterface_file}
    # ${check_data_parsing}=    Execute Command    awk -F' ' '/^[0-9]{2}\.[0-9]{2} [0-9]{2}:[0-9]{2}:[0-9]{2}/ {if ($2 >= "${start_5min_time_parse_logs}") flag=1} flag' /eniq/log/sw_log/engine/AlarmInterfaces/file-${almcfg_current_date}.log | grep -i ${5min_almrpt_name} | grep -i ${5min_alm_template_db}| grep -i parsed | tail -10
    ${check_data_parsing}=    Execute Command    cat /eniq/log/sw_log/engine/AlarmInterfaces/file-${almcfg_current_date}.log | grep -i ${5min_almrpt_name} | grep -i '${5min_alm_template_db}'| grep -i parsed | tail -10
    Log    ${check_data_parsing}
    Should Not Be Empty    ${check_data_parsing}


TC 107_To_111 Functional verification 5min alarm type -report loading verification in DB
    Skip if    '${PREV TEST STATUS}'=='FAIL' or '${PREV TEST STATUS}'=='SKIP'
    ${almcfg_current_date}=    Execute Command    date +"%Y-%m-%d"
    ${dc_pwd}=    Execute Command    /eniq/sw/installer/getPassword.bsh -u DC | awk '{print $NF}'
    ${dc_pwd_status}=    Run Keyword And Return Status    Should Not Be Empty    ${dc_pwd}
    Write   echo -e "Select ROWSTATUS from DC_Z_ALARM_INFO_RAW where ReportTitle='${almcfg_5min_almrpt_id}' and TIMELEVEL='5MIN' and DATE_ID='${almcfg_current_date}';\ngo\n" | dbisql -n -c "UID=dc;PWD=${dc_pwd};eng=dwhdb" -host localhost -port 2640 -nogui
    # Write   echo -e "Select ROWSTATUS from DC_Z_ALARM_INFO_RAW where AlarmName='${reports_alarmname_db}' and TIMELEVEL='5MIN' and DATE_ID='${almcfg_current_date}';\ngo\n" | dbisql -n -c "UID=dc;PWD=${dc_pwd};eng=dwhdb" -host localhost -port 2640 -nogui
    ${almcfg_loading_db}=    Read Until Prompt    strip_prompt=True
    @{almrpt_loaded_list}=    Get Regexp Matches     ${almcfg_loading_db}    \\bLOADED\\b
    Log    ${almrpt_loaded_list}
    Should Not Be Empty    ${almrpt_loaded_list}   

TC 114_To_118 Verify reduced delay alarmreport status is active 
    ${dwhrep_pwd}=    Execute Command    /eniq/sw/installer/getPassword.bsh -u DWHREP | awk '{print $NF}'
    ${dwhrep_pwd_status}=    Run Keyword And Return Status    Should Not Be Empty    ${dwhrep_pwd}
    Write    echo -e "select AlarmReport.INTERFACEID,AlarmReport.REPORTID,AlarmReport.STATUS from AlarmReport INNER JOIN AlarmReportParameter ON AlarmReport.REPORTID=AlarmReportParameter.REPORTID where AlarmReportParameter.VALUE='${rd_basetable_db}'and AlarmReport.INTERFACEID='${rd_almrpt_name}' and AlarmReport.REPORTNAME='${rd_alm_template_db}';\ngo\n" | dbisql -n -c "UID=dwhrep;PWD=${dwhrep_pwd};eng=repdb" -host localhost -port 2641 -nogui | grep -i "Alarm" 
    ${almrpt_db_output}=    Read Until Prompt    strip_prompt=True
    Should Match Regexp    ${almrpt_db_output}    \\bACTIVE\\b
    @{almrpt_id_list}=    Get Regexp Matches     ${almrpt_db_output}    \\b\\S+-\\S+-\\S+-\\S+-\\S+\\b
    Should Not Be Empty    ${almrpt_id_list}
    ${almcfg_rd_almrpt_id}=    Get From List    ${almrpt_id_list}    0
    Log    ${almcfg_rd_almrpt_id} is active
    Set Global Variable    ${almcfg_rd_almrpt_id}

TC 114_To_118 Functional verification reduced delay alarm type -report parsing verification in file logs
    Skip if    '${PREV TEST STATUS}'=='FAIL' or '${PREV TEST STATUS}'=='SKIP'
    ${almcfg_current_date}=    Execute Command    date +"%Y_%m_%d"
    ${check_Alarminterface_file}=    Execute Command    ls /eniq/log/sw_log/engine/DC_Z_ALARM/ | grep -i file-${almcfg_current_date}.log
    Log    ${check_Alarminterface_file}
    Should Not Be Empty    ${check_Alarminterface_file}
    # ${check_data_parsing}=    Execute Command    awk -F' ' '/^[0-9]{2}\.[0-9]{2} [0-9]{2}:[0-9]{2}:[0-9]{2}/ {if ($2 >= "${start_5min_time_parse_logs}") flag=1} flag' /eniq/log/sw_log/engine/DC_Z_ALARM/file-${almcfg_current_date}.log | grep -i ${rd_almrpt_name} | grep -i ${rd_alm_template_db}| grep -i parsed | tail -10
    ${check_data_parsing}=    Execute Command    cat /eniq/log/sw_log/engine/DC_Z_ALARM/file-${almcfg_current_date}.log | grep -i ${rd_almrpt_name} | grep -i '${rd_alm_template_db}'| grep -i parsed | tail -10
    Log    ${check_data_parsing}
    Should Not Be Empty    ${check_data_parsing}


TC 114_To_118 Functional verification reduced delay alarm type -report loading verification in DB
    Skip if    '${PREV TEST STATUS}'=='FAIL' or '${PREV TEST STATUS}'=='SKIP'
    ${almcfg_current_date}=    Execute Command    date +"%Y-%m-%d"
    ${dc_pwd}=    Execute Command    /eniq/sw/installer/getPassword.bsh -u DC | awk '{print $NF}'
    ${dc_pwd_status}=    Run Keyword And Return Status    Should Not Be Empty    ${dc_pwd}
    Write   echo -e "Select ROWSTATUS from DC_Z_ALARM_INFO_RAW where ReportTitle='${almcfg_rd_almrpt_id}' and TIMELEVEL='15MIN' and DATE_ID='${almcfg_current_date}';\ngo\n" | dbisql -n -c "UID=dc;PWD=${dc_pwd};eng=dwhdb" -host localhost -port 2640 -nogui
    # Write   echo -e "Select ROWSTATUS from DC_Z_ALARM_INFO_RAW where AlarmName='${reports_alarmname_db}' and TIMELEVEL='10MIN' and DATE_ID='${almcfg_current_date}';\ngo\n" | dbisql -n -c "UID=dc;PWD=${dc_pwd};eng=dwhdb" -host localhost -port 2640 -nogui
    ${almcfg_loading_db}=    Read Until Prompt    strip_prompt=True
    @{almrpt_loaded_list}=    Get Regexp Matches     ${almcfg_loading_db}    \\bLOADED\\b
    Log    ${almrpt_loaded_list}
    Should Not Be Empty    ${almrpt_loaded_list} 

TC 121_To_121 Verify no reports are added in Alarmcfg webpage
    Launch the Alarmcfg webpage in browser
    Input Alarmcfg Login Details    ${almcfg_sys}    ${almcfg_user}    ${almcfg_pass}    ${almcfg_auth}
    Click Login Button
    Click Interface link    All
    Verify no reports are added

TC 121_To_121 Verify all alarmreports are deleted from database
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
    Set Screenshot Directory    ./Screenshots  

Test teardown
    Capture Page Screenshot
    Close Browser


Test Teardown
    Close All Connections

Suite setup steps
    Skip If    ${almcfg_config_status}==False
    Set Screenshot Directory    ./Screenshots  

Suite teardown steps
    Capture Page Screenshot
    Close Browser

Suite setup steps
    Connect to server as a dcuser
    Set Client Configuration    30    prompt=REGEXP:${SERVER}\\[\\S+\\]\\s{\\w+}\\s#

Suite teardown steps
    Close All Connections

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





