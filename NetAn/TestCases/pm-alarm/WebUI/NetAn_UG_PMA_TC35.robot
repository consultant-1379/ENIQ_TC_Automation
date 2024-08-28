*** Settings ***
Documentation     EQEV-103913 Validate UI shown on checking and unchecking 'Dynamic Collection' checkbox is as per the requirement
Library           DatabaseLibrary
Library           OperatingSystem
Library           Selenium2Library
Library           Collections
Library           String
Library           DateTime
Library 		  PostgreSQLDB
Library           CSVLibrary
Resource          ${EXEC_DIR}/ENIQ_TC_Automation/NetAn/Resources/Keywords/Variables.robot
Resource          ${EXEC_DIR}/ENIQ_TC_Automation/NetAn/Resources/Keywords/${PMalarmingKeywordsFile}
      

*** Test Cases ***

Validate UI Changes When Checking And Unchecking Dynamic Collection Checkbox
    [Tags]     PMA_CDB      EQEV-103913      NetAn_UG_PMA_TC35
	open pm alarm analysis   
    Click on Node Collection manager button
    Click on Create collection button
	${collection}=     Enter Collection name         Collection_
    Select ENIQ Data Source in collection manager        NetAn_ODBC
    Select System area for collection manager        Radio
    Select Node type for collection manager             NR
    Check the dynamic collection check-box
    textfield to enter Wildcard Expression should be visible
	Enter the Wildcard Expression    FDN like '%ROOT%
	Click on preview button
	Validate error message in node collection manager page            Failed to fetch Nodes...Invalid wildcard expression!
	Enter the Wildcard Expression    ${EMPTY}
	Click on preview button
	Validate error message in node collection manager page            ** Add expression to create collection (wildcardexpression Cannot be Blank)
	Enter the Wildcard Expression    FDN like '%ROOT%
	Click on preview button
	Click on Create button
	Validate error message in node collection manager page            Failed to fetch Nodes...Invalid wildcard expression!
    
