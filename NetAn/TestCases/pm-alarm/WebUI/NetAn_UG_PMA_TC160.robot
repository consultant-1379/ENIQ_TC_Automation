*** Settings ***

Documentation     Validate That The Preview Panel Is Empty If We Check Dynamic Collection Check-Box After Filling In All Details For a Static Collection
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

Validate That The Preview Panel Is Empty If We Check Dynamic Collection Check-Box After Filling In All Details For a Static Collection
	[Tags]      PMA_CDB     NetAn_UG_PMA_TC160
    open pm alarm analysis
	Click on Node Collection manager button
    Click on Create collection button
    ${collection}=     Enter Collection name         Collection_
    Select ENIQ Data Source in collection manager        NetAn_ODBC
    Select System area for collection manager        Radio
    Select Node type for collection manager             NR
    Select Access Type
	Click on fetch nodes button in Node collection manager
	Check the dynamic collection check-box
    verify that Preview section is empty
	[Teardown]    Test teardown steps for pmalarm