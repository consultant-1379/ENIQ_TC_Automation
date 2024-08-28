*** Settings ***
Documentation     Report creation with different input for “Get data for” dropdown - 'COLLECTION'
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

Report creation with different input for “Get data for” dropdown - 'COLLECTION'
    [Tags]     PMEX_KGB     Report_Manager
	open pm explorer analysis
    Click on Collection Manager button
    Click on Create Collection button
    ${collectName}=    Enter the Collection name
    Select DataSource as    NetAn_ODBC
    Select System area    Core
    Select Node type    CCDM
    Click on Fetch Nodes
    Select Nodes    CCDM01
    Click on Add >>
    Click on Save button
    Verify that the Collection is created    ${collectName}
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
	${report_name}=    Enter details to save report to library    Report.    Public    test
	Click on Save report to Library button
	Verify saved report available in Report manager GUI     ${report_name}    Public   test
    Verify that the report is saved to the DB     ${report_name}

 