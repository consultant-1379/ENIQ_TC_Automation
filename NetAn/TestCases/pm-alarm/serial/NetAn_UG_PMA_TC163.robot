*** Settings ***

Documentation     Verify << Remove button in Create page For Static COllection
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

Verify << Remove button in Create page For Static COllection
	[Tags]      PMA_CDB     NetAn_UG_PMA_TC163
    open pm alarm analysis
	Click on Node Collection manager button
    Click on Create collection button
    ${collection}=     Enter Collection name         Collection_
    Select ENIQ Data Source in collection manager        NetAn_ODBC
    Select System area for collection manager        Radio
    Select Node type for collection manager             NR
    Select Access Type
    Click on fetch nodes button in Node collection manager
    Select Nodes in collection manager       G2RBS01,G2RBS02,G2RBS03,G2RBS04,G2RBS05
    remove all selected nodes from the Selected Nodes panel
	Verify Node panel is not empty for selected nodes
	Select Nodes in collection manager       G2RBS01,G2RBS02
	remove nodes from selected nodes panel    G2RBS02
	verify that the removed node is not present in selected nodes panel    G2RBS02
	[Teardown]    Test teardown steps for pmalarm