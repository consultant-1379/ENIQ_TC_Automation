*** Settings ***

Documentation     Router6k Chart validation on InterfaceLevel Page
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

Verify InterfaceLevel Charts
	${json}=    OperatingSystem.get file    ${EXEC_DIR}/ENIQ_TC_Automation/NetAn/Resources/Data/router6k/KPIChartValidation_newdataset.json
    &{object}=    Evaluate     json.loads('''${json}''')     json
    Run keyword       Chart validation on InterfaceLevel Page    ${object}[Physical ports Charts]
    Run keyword       Chart validation on InterfaceLevel Page    ${object}[VLAN Based Port Charts]
    Run keyword       Chart validation on InterfaceLevel Page    ${object}[PDH Port Charts]
    Run keyword       Chart validation on InterfaceLevel Page    ${object}[Optical Charts]


*** Keywords ***

Chart validation on InterfaceLevel Page
    [Arguments]        ${json_data}
	open router6k analysis
	
	Nav to page    ${json_data}[pagename]
	Select KPI Category as        ${json_data}[category]
	Select KPI as        ${json_data}[KPIs]
	Select Aggregation level as        ${json_data}[Aggregation Level]
	Select Aggregation function as        ${json_data}[Aggregation Function]
	Select nodenames as        ${json_data}[Node]		${json_data}[pagename]
	Click Refresh Button
    
	make selection on the chart        xpath: (//div[@class="sf-element-canvas-image sfc-transition-background"])[1]
	make selection on the chart        xpath: (//div[@class="sf-element-canvas-image sfc-transition-background"])[2]

	Nav to page    Interface Details >>
	make selection on the chart        xpath: (//div[@class="sf-element-canvas-image sfc-transition-background"])[1]
	make selection on the chart        xpath: (//div[@class="sf-element-canvas-image sfc-transition-background"])[2]
	Check for the error notification is not present

	



