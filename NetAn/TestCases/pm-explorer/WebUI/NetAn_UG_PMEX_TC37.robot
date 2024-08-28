*** Settings ***

Documentation     Verify If Report Used Delete Collection Button Will Notify
Library           Selenium2Library
Library           OperatingSystem
Library           Collections
Library           String
Library           SSHLibrary
Library           DateTime
Library           PostgreSQLDB
Resource          ${EXEC_DIR}/ENIQ_TC_Automation/NetAn/Resources/Keywords/${PMEXKeywordFile}
Resource          ${EXEC_DIR}/ENIQ_TC_Automation/NetAn/Resources/Keywords/Variables.robot

*** Test Cases ***

Verify If Report Used Delete Collection Button Will Notify
    [Tags]     Collection_Manager          PMEX_CDB         NetAn_UG_PMEX_TC37
	open pm explorer analysis
	Click on Collection Manager button 
	validate the page title    Manage Collection
	Click on Create Collection button
	validate the page title    Create Collection
	${collectionName}=    enter the Collection name
	verify that the DataSource is present and select it    NetAn_ODBC
	select the System area as    Core
	select the Node type    CCES
	Click on Scroll down button      6       15
	click on button    Fetch nodes
	select the Nodes    CCES01
	click on button    Add >>
	click on button    Save
	validate the page title    Manage Collection    
	Click on Report manager button
    Click on Create button
    Select ENIQ DataSource    NetAn_ODBC
    Select the System area    Core
    Select Node type    CCES
    Click on scroll down button     6    10
    Select Get Data For    Collection
    Click on scroll down button     6    20
    Select Collections     ${collectionName}
    Select the Aggregation    No Aggregation
    Select the measure type    ERICSSON_KPI
    Select the KPIs    TPS KPI for Traffic Influence Service
    Select time drop down to      Last 30 Days    
    Select Aggregation in select time as     Day
    click on button    Fetch PM Data
    Capture page screenshot
    Verify the page title    No Aggregation      NetAn_ODBC     Day
	Click on Save Report
	${report_name}=    Enter details to save report to library     Report_name_      Public     Automation Test
	Click on Save report to Library button
	Click on Collection Manager button from Report Manager page
	select the created collection and click on delete    ${collectionName}
	Verify the pop is coming as delete cannot be completed
	Capture page screenshot