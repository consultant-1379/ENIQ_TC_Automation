*** Settings ***

Documentation     Validate That The Selected Nodes Panel Is Empty If We Uncheck Dynamic Collection Check-Box After Filling In All Details
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

Validate That The Selected Nodes Panel Is Empty If We Uncheck Dynamic Collection Check-Box After Filling In All Details
	[Tags]      PMA_CDB     NetAn_UG_PMA_TC159
    open pm alarm analysis
	Click on Node Collection manager button
    Click on Create collection button
    ${collection}=     Enter Collection name         Collection_
    Select ENIQ Data Source in collection manager        NetAn_ODBC
    Select System area for collection manager        Radio
    Select Node type for collection manager             NR
    Select Access Type
	Check the dynamic collection check-box
    Enter Wildcard Expression    NodeName like %G2RBS%
	Click on preview button
	un-check the Dynamic Collection check-box
	Verify Node panel is empty for selected nodes
	[Teardown]    Test teardown steps for pmalarm