*** Settings ***
Documentation     Validate That If The SubNetwork Table Is Empty The NodeName Column Is Also Empty
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

Validate That If The SubNetwork Table Is Empty The NodeName Column Is Also Empty
    [Tags]      PMEX_CDB        Collection_Manager    NetAn_UG_PMEX_TC21
	open pm explorer analysis
	Click on Collection Manager button
	validate the page title    Manage Collection
    ${flag}=    verify that the SubNetwork table is empty
	IF    ${flag}==True
	    verify that the NodeName column is also empty
	ELSE
	    verify that the NodeName column is not empty
    END
	Capture page screenshot
	