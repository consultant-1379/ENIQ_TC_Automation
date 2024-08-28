*** Settings ***
Documentation     EQEV-103914 Validate ENIQ DataSource Is Connected In PM Alarming Administration Page
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

Verify ENIQ DataSource Is Connected In Administration Page
    [Tags]      PMA_CDB           EQEV-103914      NetAn_UG_PMA_TC39
    open pm alarm analysis   
	Click on Administration button
    verify that the connection to NetAn and ENIQ is made
    verify that the ENIQ DataSource is Present in Connected ENIQs    NetAn_ODBC