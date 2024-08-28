*** Settings ***
Documentation     Verify While Saving Reports Access Dropdown Displays Warning Message If Private Collection Is Selected
Library           Selenium2Library
Library           OperatingSystem
Library           Selenium2Library
Library           Collections
Library           String
Library           SSHLibrary
Library           DateTime
Library           PostgreSQLDB
Resource          ${EXEC_DIR}/ENIQ_TC_Automation/NetAn/Resources/Keywords/${PMEXKeywordFile}
Resource          ${EXEC_DIR}/ENIQ_TC_Automation/NetAn/Resources/Keywords/Variables.robot
Resource          ${EXEC_DIR}/ENIQ_TC_Automation/NetAn/Resources/Keywords/PostgresDBConnection.robot


*** Test Cases ***

Verify While Saving Reports Access Dropdown Displays Warning Message If Private Collection Is Selected
    [Tags]    Collection_Manager   Report_Manager     PMEX_CDB
	open pm explorer analysis
	Click on Collection Manager button 
	validate the page title    Manage Collection
	Click on Create Collection button
	validate the page title    Create Collection
    ${collectName}=    Enter the Collection name
    Select DataSource as    NetAn_ODBC
    Select System area    Core
    Select Node type    CCDM
    click on scroll down button    6    20
    Click on Fetch Nodes
    Select Access Type
    Select Nodes    CCDM01
    Click on Add >>
    Click on Save button
    Click on Report manager button
    Click on Create button
	Select ENIQ DataSource    NetAn_ODBC
    Select the System area    Core
    Select Node type    CCDM
    Select Get Data For    Collection
    Select Collection    ${collectName}
	Select Aggregation as    No Aggregation
    Select the measure type    COUNTER   
    Select KPIs    eric-act-ldap-prov-requests-sent.DC_E_CCDM_ACT_LDAP_PROV_RAW
    Select time drop down to      Last 30 Days  
    Select Aggregation in select time as     Day  
    Click on fetch pmdata button
	Click on Save Report
    click on scroll down button    3    5
    Verify the Warning message Is Visible on Save Report Page
   
 