*** Settings ***
Documentation     Dataintegrity testcase

Library           SikuliLibrary
Library           OperatingSystem
Library           Selenium2Library
Library           Collections
Library           String
Library           SSHLibrary
Library           DateTime
Library           SwingLibrary
Resource          ./Resources/Keywords/DataIntegrity_Keywords.robot
Resource	      ./Resources/Keywords/VoLTEWebUI.robot
Library           ./Resources/Libraries/DynamicTestcases.py
Test Setup        Open Connection And Log In     ${host}     ${username}    ${password}     ${PORT}
Test Teardown     Close All Connections
Suite setup       Set Screenshot Directory    ./Screenshots

*** Variables ***
#${base_url}=        https://atvts4134.athtem.eei.ericsson.se/
${base_url}=        https://localhost/
${volte_url}=       spotfire/wp/analysis?file=/Ericsson%20Library/LTE/VoLTE/Ericsson-VoLTE-Report/Analyses/Volte_Guided_Analysis&waid=dzVcvNCdUkmOmgpPZOg1x-300543061eBwfK&wavid=0
${browser_name}=    chrome
${IMAGE_DIR}        ${EXECDIR}/Other/sikuli-images
${host}             localhost
${username}         Administrator
${password}         teamci@2017
${PORT}             2640

***Test Cases***

Test Case: Volte SBG data integrity
	open volte analysis
	click on Home button if not in volte home page
	click on VoLTE Reset button
	Click on scroll down button on the current page    20    0
	click on button title    VoLTE Monitor
	validate page title as    VoLTE Monitor
	click on    SBG
	click on button value    Node Troubleshooting >>
	validate page title as    Node Troubleshooting
	Make selections in KPI    SBG
	click on button value    Daily Breakdown >>
	select days to compare    SBG
	click on button value    Filtered Data >>
	Enable the columns    MEASURED_OBJECT    NodeName
	${nodeName}    ${measureName}    ${measureObject}    ${dateTime}    ${measureValue}=    recording nodeName, measureName, measureObject, dateTime and measureValue
	${sql_query}=      get sql query from json file    ./Resources/Data/volte/VoLTE_dataIntegrity.json     SBG
	${DB_Value}=    query the eniq database for VoLTE    ${sql_query}    ${nodeName}    ${measureName}    ${measureObject}    ${dateTime}
	Match UI with DB VoLTE Value    ${measureValue}     ${DB_Value}
	Capture page screenshot
    [Teardown]    Close Browser
	
Test Case: Volte MTAS data integrity
	open volte analysis
	click on Home button if not in volte home page
	click on VoLTE Reset button
	Click on scroll down button on the current page    20    0
	click on button title    VoLTE Monitor
	validate page title as    VoLTE Monitor
	click on    MTAS
	click on button value    Node Troubleshooting >>
	validate page title as    Node Troubleshooting
	Make selections in KPI    MTAS
	click on button value    Daily Breakdown >>
	select days to compare    MTAS
	click on button value    Filtered Data >>
	Enable the columns    MEASURED_OBJECT    NodeName
	${nodeName}    ${measureName}    ${measureObject}    ${dateTime}    ${measureValue}=    recording nodeName, measureName, measureObject, dateTime and measureValue
	${sql_query}=      get sql query from json file    ./Resources/Data/volte/VoLTE_dataIntegrity.json     MTAS
	${DB_Value}=    query the eniq database for VoLTE    ${sql_query}    ${nodeName}    ${measureName}    ${measureObject}    ${dateTime}
	Match UI with DB VoLTE Value    ${measureValue}     ${DB_Value}
	Capture page screenshot
    [Teardown]    Close Browser
	
Test Case: Volte GGSN data integrity
	open volte analysis
	click on Home button if not in volte home page
	click on VoLTE Reset button
	Click on scroll down button on the current page    20    0
	click on button title    VoLTE Monitor
	validate page title as    VoLTE Monitor
	click on    GGSN
	click on button value    Node Troubleshooting >>
	validate page title as    Node Troubleshooting
	Make selections in KPI    GGSN
	click on button value    Daily Breakdown >>
	select days to compare    GGSN
	click on button value    Filtered Data >>
	Enable the columns    MEASURED_OBJECT    NodeName
	${nodeName}    ${measureName}    ${measureObject}    ${dateTime}    ${measureValue}=    recording nodeName, measureName, measureObject, dateTime and measureValue
	${sql_query}=      get sql query from json file    ./Resources/Data/volte/VoLTE_dataIntegrity.json     GGSN
	${DB_Value}=    query the eniq database for VoLTE    ${sql_query}    ${nodeName}    ${measureName}    ${measureObject}    ${dateTime}
	Match UI with DB VoLTE Value    ${measureValue}     ${DB_Value}
	Capture page screenshot
    [Teardown]    Close Browser
	
Test Case: Volte ERBS data integrity
	open volte analysis
	click on Home button if not in volte home page
	click on VoLTE Reset button
	Click on scroll down button on the current page    20    0
	click on button title    VoLTE Monitor
	validate page title as    VoLTE Monitor
	click on    ERBS
	click on button value    Node Troubleshooting >>
	validate page title as    Node Troubleshooting
	Make selections in KPI    ERBS
	click on button value    Daily Breakdown >>
	select days to compare    ERBS
	click on button value    Filtered Data >>
	Enable the columns    MEASURED_OBJECT    NodeName
	${nodeName}    ${measureName}    ${cellFDN}    ${dateTime}    ${measureValue}=    recording nodeName, measureName, measureObject, dateTime and measureValue for erbs
	${sql_query}=      get sql query from json file    ./Resources/Data/volte/VoLTE_dataIntegrity.json     ERBS
	${DB_Value}=    query the eniq database for VoLTE ERBS    ${sql_query}    ${nodeName}    ${measureName}    ${cellFDN}    ${dateTime}
	Match UI with DB VoLTE Value    ${measureValue}     ${DB_Value}
	Capture page screenshot
    [Teardown]    Close Browser
	
Test Case: Volte MSC data integrity
	open volte analysis
	click on Home button if not in volte home page
	click on VoLTE Reset button
	Click on scroll down button on the current page    20    0
	click on button title    VoLTE Monitor
	validate page title as    VoLTE Monitor
	click on    MSC
	click on button value    Node Troubleshooting >>
	validate page title as    Node Troubleshooting
	Make selections in KPI    MSC
	click on button value    Daily Breakdown >>
	select days to compare    MSC
	click on button value    Filtered Data >>
	Enable the columns    MEASURED_OBJECT    NodeName
	${nodeName}    ${measureName}    ${cellFDN}    ${dateTime}    ${measureValue}=    recording nodeName, measureName, measureObject, dateTime and measureValue
	${sql_query}=      get sql query from json file    ./Resources/Data/volte/VoLTE_dataIntegrity.json     MSC
	${DB_Value}=    query the eniq database for VoLTE    ${sql_query}    ${nodeName}    ${measureName}    ${cellFDN}    ${dateTime}
	Match UI with DB VoLTE Value    ${measureValue}     ${DB_Value}
	Capture page screenshot
    [Teardown]    Close Browser
	
Test Case: Volte SGSN data integrity
	open volte analysis
	click on Home button if not in volte home page
	click on VoLTE Reset button
	Click on scroll down button on the current page    20    0
	click on button title    VoLTE Monitor
	validate page title as    VoLTE Monitor
	click on    SGSN
	click on button value    Node Troubleshooting >>
	validate page title as    Node Troubleshooting
	Make selections in KPI    SGSN
	click on button value    Daily Breakdown >>
	select days to compare    SGSN
	click on button value    Filtered Data >>
	Enable the columns    MEASURED_OBJECT    NodeName
	${nodeName}    ${measureName}    ${cellFDN}    ${dateTime}    ${measureValue}=    recording nodeName, measureName, measureObject, dateTime and measureValue
	${sql_query}=      get sql query from json file    ./Resources/Data/volte/VoLTE_dataIntegrity.json     SGSN
	${DB_Value}=    query the eniq database for VoLTE    ${sql_query}    ${nodeName}    ${measureName}    ${cellFDN}    ${dateTime}
	Match UI with DB VoLTE Value    ${measureValue}     ${DB_Value}
	Capture page screenshot
    [Teardown]    Close Browser
	
Test Case: Volte CSCF data integrity
	open volte analysis
	click on Home button if not in volte home page
	click on VoLTE Reset button
	Click on scroll down button on the current page    20    0
	click on button title    VoLTE Monitor
	validate page title as    VoLTE Monitor
	click on    CSCF
	click on button value    Node Troubleshooting >>
	validate page title as    Node Troubleshooting
	Make selections in KPI    CSCF
	click on button value    Daily Breakdown >>
	select days to compare    CSCF
	click on button value    Filtered Data >>
	Enable the columns    MEASURED_OBJECT    NodeName
	${nodeName}    ${measureName}    ${measureObject}    ${dateTime}    ${measureValue}=    recording nodeName, measureName, measureObject, dateTime and measureValue
	${sql_query}=      get sql query from json file    ./Resources/Data/volte/VoLTE_dataIntegrity.json     CSCF
	${DB_Value}=    query the eniq database for VoLTE    ${sql_query}    ${nodeName}    ${measureName}    ${measureObject}    ${dateTime}
	Match UI with DB VoLTE Value    ${measureValue}     ${DB_Value}
	Capture page screenshot
    [Teardown]    Close Browser