*** Settings ***

Library           OperatingSystem
Library           Selenium2Library
Library           Collections
Library           String
Library           SSHLibrary
Library           DateTime
Library           PostgreSQLDB
Library           SikuliLibrary
Library           DatabaseLibrary
Library			  Process
Resource          ${EXEC_DIR}/ENIQ_TC_Automation/NetAn/Resources/Keywords/${EnergyReportKeywordsFile}
Resource          ${EXEC_DIR}/ENIQ_TC_Automation/NetAn/Resources/Keywords/Variables.robot

*** Test Cases ***

Verify That The Number Of Rows Is More In New Version
	[Tags]     Energy_Report_CDB    ER_KGB
	verify that Energy Report opened without errors
	change the view to    Editing
	change to page navigation to    Titled tabs
	click on the button    Add new page
	click on the button    Start from visualizations
	Change the Visualization type to Table
	Select the data table    2    50    IL_DC_E_TCU_CONSUMEDENERGYMEASUREMENT_NR_DAY
	${value1}=    read the number of rows retrieved
	close browser
	install the energy report analysis    R3B03
	open energy report analysis
	verify that Energy Report opened without errors
	change the view to    Editing
	change to page navigation to    Titled tabs
	click on the button    Add new page
	click on the button    Start from visualizations
	Change the Visualization type to Table
	Select the data table    2    50    IL_DC_E_TCU_CONSUMEDENERGYMEASUREMENT_NR_DAY
	${value2}=    read the number of rows retrieved
	should not be equal    ${value1}    ${value2}