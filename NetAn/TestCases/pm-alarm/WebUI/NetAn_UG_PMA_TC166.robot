*** Settings ***

Documentation     Verify That The Data Source, System Area And Nodetype Dropdowns Are Disabled On Edit Collection Page For Dynamic Collection
Library           Selenium2Library
Library           OperatingSystem
Library           Collections
Library           String
Library           SSHLibrary
Library           DateTime
Library 		  PostgreSQLDB
Library           DatabaseLibrary
Resource          ${EXEC_DIR}/ENIQ_TC_Automation/NetAn/Resources/Keywords/Variables.robot
Resource          ${EXEC_DIR}/ENIQ_TC_Automation/NetAn/Resources/Keywords/${PMalarmingKeywordsFile}

*** Test Cases ***

Verify That The Data Source, System Area And Nodetype Dropdowns Are Disabled On Edit Collection Page For Dynamic Collection
	[Tags]      PMA_CDB     NetAn_UG_PMA_TC166
    open pm alarm analysis
	Click on Node Collection manager button
    Click on Create collection button
    ${collection}=     Enter Collection name         Collection_
    Select ENIQ Data Source in collection manager        NetAn_ODBC
    Select System area for collection manager        Radio
    Select Node type for collection manager             NR
    Select Access Type
    Check the dynamic collection check-box
    Enter Wildcard Expression    NodeName like '%G2RBS%'
	Click on preview button
    Click on Create button
	Validate that the collection is present in GUI    ${collection}
	select the created collection    ${collection}
	Click on Edit collection button
	Verify Select Eniq data source, system area and node type is disabled in edit collection
	[Teardown]    Test teardown steps for pmalarm