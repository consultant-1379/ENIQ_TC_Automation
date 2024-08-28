*** Settings ***
Documentation     Validate Information Link creation after Ignoring Null Values
Library           DatabaseLibrary
Library           OperatingSystem
Library           Selenium2Library
Library           Collections
Library           String
Library           DateTime
Library 		  PostgreSQLDB
Resource          ${EXEC_DIR}/ENIQ_TC_Automation/NetAn/Resources/Keywords/Variables.robot
Resource          ${EXEC_DIR}/ENIQ_TC_Automation/NetAn/Resources/Keywords/${PMEXKeywordFile}
Resource          ${EXEC_DIR}/ENIQ_TC_Automation/NetAn/Resources/Keywords/PostgresDBConnection.robot


*** Test Cases ***

Validate Information Link creation after Ignoring Null Values
    [Tags]       PMEX_CDB       EQEV-125672
	open pm explorer analysis
    Click on Report manager button
    Click on Create button
    Select ENIQ DataSource    NetAn_ODBC
    Select the System area    Radio
    Select Node type    ERBS
    Select Get Data For    Node(s)
    Click on Refresh nodes button
    Select Nodes    ERBSG201
    Select the Aggregation    No Aggregation
    Select the measure type    PDF_COUNTER   
    Select KPIs    pmDrxSwitchPftDistr.DC_E_ERBS_EUTRANCELLFDD_V_RAW
	Set PDFbinValues to       Custom
	Search for bin_value in index text box       15,16
    Select time drop down to      Last 30 Days
    Select Aggregation in select time as     Day
    Click on fetch pmdata button
    click on button    Create Information Link(s)
	${InformationLink}=    enter the information link name    InfoLink_Null_value
	select a Information Link Storage Location and Save it     PMEX Reports
	open browser with home page
	Open the information link         ${InformationLink}       DC_E_ERBS_EUTRANCELLFDD_V_DAY
	Verify given column is not available      PMDRXSWITCHPFTDISTR[16]           
	Capture page screenshot
	
