*** Settings ***

Documentation     EQEV-105271 - Validate That The Lastmodofiedon Column On Collection Manager Page Is Displaying Correct Data for Static and Dynamic Collections
Library           Selenium2Library
Library           OperatingSystem
Library           Selenium2Library
Library           Collections
Library           String
Library           SSHLibrary
Library           DateTime
Library 		  PostgreSQLDB
Library           DatabaseLibrary
Resource          ${EXEC_DIR}/ENIQ_TC_Automation/NetAn/Resources/Keywords/Variables.robot
Resource          ${EXEC_DIR}/ENIQ_TC_Automation/NetAn/Resources/Keywords/${PMalarmingKeywordsFile}

*** Test Cases ***

Validate LastModofiedOn Column On Collection Manager Page
	[Tags]    PMA_CDB    NetAn_UG_PMA_TC50    EQEV-105271
	run keyword and continue on failure    Validate LastModofiedOn Column On Collection Manager Page for Static Collection
	run keyword and continue on failure    Validate LastModofiedOn Column On Collection Manager Page for Dynamic Collection

*** Keywords ***

Validate LastModofiedOn Column On Collection Manager Page for Static Collection
    open pm alarm analysis
	Click on Node Collection manager button
    Click on Create collection button
    ${collection}=     Enter Collection name         Collection_
    Select ENIQ Data Source in collection manager        NetAn_ODBC
    Select System area for collection manager        Radio
    Select Node type for collection manager             NR
    Select Access Type
    Click on fetch nodes button in Node collection manager
    Select Nodes in collection manager       G2RBS01,G2RBS04
    Click on Create button
    ${value1}=    select created collection and read column value    ${collection}    LastModifiedOn
    Click on Edit collection button
    Click on fetch nodes button in Node collection manager
    Select Nodes in collection manager       G2RBS02
    Click on Save button
    ${value2}=    select created collection and read column value    ${collection}    LastModifiedOn
	verify that the LastModifiedOn values do not match    ${value1}    ${value2}
	[Teardown]    Test teardown steps for pmalarm
	
Validate LastModofiedOn Column On Collection Manager Page for Dynamic Collection
    open pm alarm analysis
	Click on Node Collection manager button
    Click on Create collection button
    ${collection}=     Enter Collection name         Collection_
    Select ENIQ Data Source in collection manager        NetAn_ODBC
    Select System area for collection manager        Radio
    Select Node type for collection manager             NR
    Select Access Type
    Check the dynamic collection check-box
    Enter Wildcard Expression    FDN like '%ROOT%'
	Click on preview button
    Click on Create button
    ${value1}=    select created collection and read column value    ${collection}    LastModifiedOn
    Click on Edit collection button
    Enter Wildcard Expression    NodeName like '%G2RBS%'
	Click on preview button
    Click on Save button
    ${value2}=    select created collection and read column value    ${collection}    LastModifiedOn
	verify that the LastModifiedOn values do not match    ${value1}    ${value2}
	[Teardown]    Test teardown steps for pmalarm