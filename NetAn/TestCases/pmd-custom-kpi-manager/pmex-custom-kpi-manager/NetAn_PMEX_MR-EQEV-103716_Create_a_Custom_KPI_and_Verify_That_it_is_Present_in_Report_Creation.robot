*** Settings ***
Documentation          Create a Custom KPI and Verify That it is Present in Report Creation

Library    		  RPA.Windows
Library    		  RPA.Desktop
Library      	  rpaframework
Library			  RPA.Desktop.Windows
Library			  BuiltInLibrary
Library			  AutoItLibrary
Library			  RPA.Desktop.Clipboard
Library           OperatingSystem
Library           Selenium2Library
Library           Collections
Library           String
Library           DateTime
Library 		  PostgreSQLDB
Resource          ${EXEC_DIR}/ENIQ_TC_Automation/NetAn/Resources/Keywords/${PMEXKeywordFile}
Resource          ${EXEC_DIR}/ENIQ_TC_Automation/NetAn/Resources/Keywords/Variables.robot
Resource          ${EXEC_DIR}/ENIQ_TC_Automation/NetAn/Resources/Keywords/PostgresDBConnection.robot
Resource          ${EXEC_DIR}/ENIQ_TC_Automation/NetAn/Resources/Keywords/CustomKPIManagerClientUI.robot
Library    		  ${EXEC_DIR}/ENIQ_TC_Automation/NetAn/Resources/Libraries/KeyboardActions.py

*** Test Cases ***

Create a Custom KPI and Verify That it is Present in Report Creation
    [Tags]     Custom_KPI_ClientUI
	Open the Custom KPI Manager Application
	click on the Custom KPI Manager button
	verify that KPI List Page opened up
	click on Import KPIs button
	go to the CSV file location
	select CSV file with KPI details    1
	verify that the KPI is added
	Close Custom KPI Manager Application
	open pm explorer analysis
	Connect to DB and sync with eniq
	Click on Report manager button
    Click on Create button
    Select ENIQ DataSource    NetAn_ODBC
    Select the System area    Radio
    Select Node type    NR
    Select Get Data For    Node(s)
    Select the measure type    CUSTOM_KPI
    verify that the custom KPI is present
    Capture page screenshot
	