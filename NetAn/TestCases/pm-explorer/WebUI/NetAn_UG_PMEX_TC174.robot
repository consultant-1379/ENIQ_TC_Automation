*** Settings ***

Documentation     Check if the flex-filter values are added properly in flex-filter values column in 'Measure mapping (selected)' table
Library           OperatingSystem
Library           Selenium2Library
Library           Collections
Library           String
Library           SSHLibrary
Library           DateTime
Resource          ${EXEC_DIR}/ENIQ_TC_Automation/NetAn/Resources/Keywords/Variables.robot
Resource          ${EXEC_DIR}/ENIQ_TC_Automation/NetAn/Resources/Keywords/${PMEXKeywordFile}
Library           ${EXEC_DIR}/ENIQ_TC_Automation/NetAn/Resources/Libraries/DynamicTestcases.py
																								   
										


*** Test Cases ***

Check if the flex-filter values are added properly in flex-filter values column in 'Measure mapping (selected)' table
    [Tags]      PMEX_CDB         Report_Manager
    Open PM Explorer analysis
    Click on Report manager button
    Click on Create button
    Select ENIQ DataSource as     NetAn_ODBC
    Select System area as    Radio
    Select Node type as    ERBS 
    Select Get Data For    Node(s)
    Click on Refresh nodes button  
    Select Nodes as    ERBSG201
    Select Aggregation as    No Aggregation        
    Select the measure type    FLEX_COUNTER
    Select KPIs    PMFLEXZTEMPORARY5.DC_E_ERBS_EUTRANCELLFDD_FLEX_RAW
    Set FlexFilterValues to     Custom
    Fetch Flex filter values
	${present}     @{list_value}=     Select Flex filter value as    LCG0To9
	IF         ${present}!= 0 
		Click on button value to add flex filter   
		Verify that Flex Filter is added to selected measure        ['LCG0To9']

	END	   
    Capture page screenshot
   
	

