*** Settings ***

Documentation     Router6k KPI Panel data and Chart Validation 
Library           OperatingSystem
Library           Selenium2Library
Library           Collections
Library           String
Library           DateTime
Library			  Process
Library           ${EXEC_DIR}/ENIQ_TC_Automation/NetAn/Resources/Keywords/Router6k.py
Resource          ${EXEC_DIR}/ENIQ_TC_Automation/NetAn/Resources/Keywords/Variables.robot
Resource          ${EXEC_DIR}/ENIQ_TC_Automation/NetAn/Resources/Keywords/${Router6kFile}

*** Test Cases ***

Verify KPI Panel data and Chart Validation
	${json}=    OperatingSystem.get file    ${EXEC_DIR}/ENIQ_TC_Automation/NetAn/Resources/Data/router6k/NodeLevelKPI_data.json
    &{object}=    Evaluate     json.loads('''${json}''')     json
	Run Keyword And Continue on Failure       Verify KPI Panel data and Charts    ${object}[Full Duplex Utilization (%)]


*** Keywords ***

Verify KPI Panel data and Charts
    [Arguments]        ${json_data}
	open router6k analysis
	
	Nav to page    ${json_data}[pagename]
	Select KPI Category as        ${json_data}[category]
	Select KPI as        ${json_data}[KPIs]
	Select Aggregation level as        ${json_data}[Aggregation Level]
	Select Aggregation function as        ${json_data}[Aggregation Function]
	Select nodenames as        ${json_data}[Node]		${json_data}[pagename]
	${date_range}=    Get StartDate EndDate From Filter		${json_data}[pagename]
	Click Refresh Button
	${kpi_panel_html} =    Get all kpi html content
	${kpi_panel_value} =    Get All Node Kpi Panel Values    ${kpi_panel_html}    ${json_data}
	Log     ${kpi_panel_value}
	${data_compare_status}=		Compare Kpi Ui Value With Query    ${kpi_panel_value}    ${json_data}		${date_range}[0]		${date_range}[1]
    IF      '${data_compare_status}' == 'False'
	    Fail    'Data mismatch with database and UI'
	END
	Check for the error notification is not present
	[Teardown]    Close Browser	

