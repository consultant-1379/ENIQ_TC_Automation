*** Settings ***

Documentation     Router6k KPI Data Validation
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

Verify KPI calculation data 
	${json}=    OperatingSystem.get file    ${EXEC_DIR}/ENIQ_TC_Automation/NetAn/Resources/Data/router6k/KPI_SQL.json
    &{object}=    Evaluate     json.loads('''${json}''')     json
	FOR   ${key}   IN  @{object.keys()}
        Run Keyword And Continue on Failure       KPI Data Validation    ${object}[${key}]
		# Run Keyword And Continue on Failure       KPI Data Validation    ${object}[DL Throughput (Mbps)]
		# BREAK
	END



*** Keywords ***

KPI Data Validation
    [Arguments]        ${json_data}
	open router6k analysis
	
	Nav to page    ${json_data}[pagename]
	Select KPI Category as        ${json_data}[category]
	Select KPI as        ${json_data}[KPIs]
	Select Aggregation level as        ${json_data}[Aggregation Level]
	Select Aggregation function as        ${json_data}[Aggregation Function]
	Select nodenames as        ${json_data}[Node]		${json_data}[pagename]
	Click Refresh Button
	make chart select after refresh nodes
	capture page screenshot
	${ui_args}=    Get First Row Data from Filtered Data
    capture page screenshot
	${ui_row_data}=    Get First Row Data From Data Table    ${ui_args}[0]    ${ui_args}[1]    ${ui_args}[2]
	${status}=    Verify Ui Data With Sql    ${ui_row_data}    ${json_data}
	IF  ${status}==False
	    Fail    'UI KPI value is mismatch with database'
	END
    Check for the error notification is not present
	[Teardown]    Close Browser


