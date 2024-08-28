*** Settings ***
Documentation     Check the output is displayed only for the selected filter values
Library           Selenium2Library
Library           OperatingSystem
Library           Selenium2Library
Library           Collections
Library           String

Resource          ${EXEC_DIR}/ENIQ_TC_Automation/NetAn/Resources/Keywords/${PMEXKeywordFile}
Resource          ${EXEC_DIR}/ENIQ_TC_Automation/NetAn/Resources/Keywords/${PMEXKeywordFile}
Resource          ${EXEC_DIR}/ENIQ_TC_Automation/NetAn/Resources/Keywords/Variables.robot
Resource          ${EXEC_DIR}/ENIQ_TC_Automation/NetAn/Resources/Keywords/PostgresDBConnection.robot



*** Test Cases ***

Check the output is displayed only for the selected filter values
    [Tags]    PMEX_CDB           Report_Manager
    Open PM Explorer analysis
    Click on Report manager button							  
    Click on Create button
    Select ENIQ DataSource as     NetAn_ODBC
    Select System area as    Radio
    Select Node type as    ERBS
    Select Get Data For    Node(s)
    Click on Refresh nodes button
    Select Nodes as    ERBS1
    Select Aggregation as    No Aggregation
    Select the measure type    FLEX_COUNTER
    Select KPIs    PMFLEXZTEMPORARY5.DC_E_ERBS_EUTRANCELLFDD_FLEX_RAW
    Set FlexFilterValues to     Custom
    Fetch Flex filter values															  
	${present}     @{list_value}=     Select Flex filter value as    LCG0To4
	IF         ${present}!= 0 
		Click on button value to add flex filter
	END
	Select time drop down to      Calendar Interval
	Select Aggregation in select time as     ROP
    Enter the Calendar Interval    01/02/2024    20/12
    Click on fetch pmdata button   
    Verify that the results are displayed for selected filter values    LCG0To4
    Capture page screenshot
   
	
       