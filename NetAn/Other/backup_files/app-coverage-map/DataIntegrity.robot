*** Settings ***
Documentation     App_Coverage_Map DataIntegrity
Documentation     DB connection
Test Setup       Open Connection And Log In     ${host}     ${username}    ${password}    ${PORT}
Test Teardown    Close All Connections
Suite setup      Set Screenshot Directory   ./Screenshots
Library           AutoItLibrary
Library           SikuliLibrary
Library           OperatingSystem
Library           CustomFunctions
Library           Selenium2Library
Library           Collections
Library           String
Library          SSHLibrary
Library          DateTime
Resource          ./Resources/Keywords/App_Coverage_Map_WebUI.robot
Resource          ./Resources/Keywords/DataIntegrity_Keywords.robot
Resource          ./Resources/Keywords/Variables.robot
Library           ./Resources/Libraries/DynamicTestcases.py

*** Variables ***
${base_url}=       https://localhost/
${uplink_url}=        spotfire/wp/analysis?file=/Ericsson Library/LTE/App-Coverage-Map/Ericsson-App-Coverage-Map/Analyses/App Coverage Map
{browser_name}=   chrome
${IMAGE_DIR}        ${EXECDIR}/Other/sikuli-images

*** Test Cases ***
#TMS_TC_Id:NetAnServer18.2_18.2.8_0032
Verify data integrity for Cell Failure of Uplink_TC_01
    [Tags]  dataIntegrity
    ${json}=    OperatingSystem.get file    ./Resources/Data/app-coverage-map/DataIntegrityforUplink.json
    &{object}=    Evaluate     json.loads('''${json}''')     json
    FOR   ${key}   IN  @{object.keys()}
        Add Test Case    ${key}   Verify failure rate for Uplink    ${object}[${key}]
    END
       
*** Keywords ***
Verify failure rate for Uplink 
	[Arguments]      ${data}
    open app coverage map analysis
    verify app coverage map analysis page opened
	click on cell performance button
	verify Cell Performance Ranking Page opens on App Coverage Map Analysis
	Select from Uplink/Downlink dropdown	Uplink
	select performance target as 	UL Throughput >=0.15 Mbps
	mark on the "Worst Performing Cells (Ranked by Avg Failed User Sessions)" chart
	record the tooltip values
	place mouse cursor on Cell Failure Rate over Time chart
	${DB_Value}=     Query ENIQ database for for cell failure rate  ${data}[SQL]    ${DATETIME_VALUE}    ${UNIQUE_ID_VALUE}		${NODE_NAME_VALUE}
	${CellFailure_Rate}=		Remove zeros after decimal point from measure value     ${MEASURE_Value}
    Verify UI value is matching with DB value    ${CellFailure_Rate}     ${DB_Value}
     

   