*** Settings ***
Documentation     EQEV-110751_Verify That If A Connection Cannot Be Deleted Clicking On OK Closes The Popup
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

Verify That If A Connection Cannot Be Deleted Clicking On OK Closes The Popup
    [Tags]     PMA_CDB    	EQEV-11075    NetAn_UG_PMA_TC85				
    open pm alarm analysis
    Click on Administration button
    validate the page title    Administration
    Runkeyword and ignore error      Click on minimise window button    0
    validate the page title    Administration
    Click on maximise window button    1
    click on the connected ENIQ and click on delete    NetAn_ODBC
    verify that the DataSource cant be deleted 
    click on the OK button after Deletion message
    verify that Deletion POPUP is closed After clicking OK