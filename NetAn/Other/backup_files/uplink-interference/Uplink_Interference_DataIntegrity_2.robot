*** Settings ***
Documentation     PMA Dataintegrity testcase for Radio nodes

Library           SikuliLibrary
Library           OperatingSystem
Library           Selenium2Library
Library           Collections
Library           String
Library           SSHLibrary
Library           DateTime
Library           SwingLibrary
Resource          ./Resources/Keywords/DataIntegrity_Keywords.robot
Resource	      ./Resources/Keywords/UplinkInterferenceWebUI.robot
Library           ./Resources/Libraries/DynamicTestcases.py
Test Setup        Open Connection And Log In     ${host}     ${username}    ${password}     ${PORT}
Test Teardown     Close All Connections
Suite setup       Set Screenshot Directory    ./Screenshots



*** Variables ***
${base_url}=        https://localhost/
${uplink_url}=      spotfire/wp/analysis?file=/Ericsson%20Library/Radio-Common/RAN%20Uplink%20Interference/Ericsson-RAN-Uplink-Interference/Analyses/RAN_Uplink_Interference&waid=fXeGjGW6CEyHAqOPjYvbN-180446061e1ht_&wavid=0 
${browser_name}=    chrome
${IMAGE_DIR}        ${EXECDIR}/Other/sikuli-images
${host}             localhost
${username}         Administrator
${password}         teamci@2017
${PORT}             2640


***Test Cases***

Test Case ID: PUCCH Analysis - "Interference Power - Average"
	open uplink interference analysis
	validate page title as    Home
	Click on scroll down button on the current page    20    0
	click on button title    Reset Filters & Markings
	click on button value    Health Check
	adjust the slider to 500 cells
	select Interference Measure and Aggregation as    Interference Power    Average
	${uiValue}    ${cellValue}=    reading values from the tooltip in chart    PUCCH Analysis
	${sql_query}=      get sql query from json file    ./Resources/Data/uplink-interference/Uplink-Interference-dataIntegrity-SQLs.json     pucchInterferenceAverage
	${DB_Value}=    query the eniq database for uplink interference    ${sql_query}    ${cellValue}
	Match UI with DB Value    ${uiValue}     ${DB_Value}
	Capture page screenshot
    [Teardown]    Close Browser

Test Case ID: PUCCH Analysis - "Noise Rise - Maximum"
	open uplink interference analysis
	validate page title as    Home
	Click on scroll down button on the current page    20    0
	click on button title    Reset Filters & Markings
	click on button value    Health Check
	adjust the slider to 500 cells
	select Interference Measure and Aggregation as    Noise Rise    Maximum
	${uiValue}    ${cellValue}=    reading values from the tooltip in chart    PUCCH Analysis
	${sql_query}=      get sql query from json file    ./Resources/Data/uplink-interference/Uplink-Interference-dataIntegrity-SQLs.json     pucchNoiseRiseMaximum
	${DB_Value}=    query the eniq database for uplink interference    ${sql_query}    ${cellValue}
	Match UI with DB Value    ${uiValue}     ${DB_Value}
	Capture page screenshot
    [Teardown]    Close Browser

Test Case ID: PUSCH Analysis - "Interference Power - Maximum"
	open uplink interference analysis
	validate page title as    Home
	Click on scroll down button on the current page    20    0
	click on button title    Reset Filters & Markings
	click on button value    Health Check
	adjust the slider to 500 cells
	select Interference Measure and Aggregation as    Interference Power    Maximum
	${uiValue}    ${cellValue}=    reading values from the tooltip in chart    PUSCH Analysis
	${sql_query}=      get sql query from json file    ./Resources/Data/uplink-interference/Uplink-Interference-dataIntegrity-SQLs.json     puschInterferencePowerMaximum
	${DB_Value}=    query the eniq database for uplink interference    ${sql_query}    ${cellValue}
	Match UI with DB Value    ${uiValue}     ${DB_Value}
	Capture page screenshot
    [Teardown]    Close Browser

Test Case ID: PUSCH Analysis - "Noise Rise - Average"
	open uplink interference analysis
	validate page title as    Home
	Click on scroll down button on the current page    20    0
	click on button title    Reset Filters & Markings
	click on button value    Health Check
	adjust the slider to 500 cells
	select Interference Measure and Aggregation as    Noise Rise    Average
	${uiValue}    ${cellValue}=    reading values from the tooltip in chart    PUSCH Analysis
	${sql_query}=      get sql query from json file    ./Resources/Data/uplink-interference/Uplink-Interference-dataIntegrity-SQLs.json     puschNoiseRiseMaximum
	${DB_Value}=    query the eniq database for uplink interference    ${sql_query}    ${cellValue}
	Match UI with DB Value    ${uiValue}     ${DB_Value}
	Capture page screenshot
    [Teardown]    Close Browser

Test Case ID: PUSCH Analysis - "Interference Power - Average"
	open uplink interference analysis
	validate page title as    Home
	Click on scroll down button on the current page    20    0
	click on button title    Reset Filters & Markings
	click on button value    Health Check
	adjust the slider to 500 cells
	select Interference Measure and Aggregation as    Interference Power    Average
	${uiValue}    ${cellValue}=    reading values from the tooltip in chart    PUSCH Analysis
	${sql_query}=      get sql query from json file    ./Resources/Data/uplink-interference/Uplink-Interference-dataIntegrity-SQLs.json     puschInterferencePowerAverage
	${DB_Value}=    query the eniq database for uplink interference    ${sql_query}    ${cellValue}
	Match UI with DB Value    ${uiValue}     ${DB_Value}
	Capture page screenshot
    [Teardown]    Close Browser























