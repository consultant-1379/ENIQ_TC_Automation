
*** Keywords ***

##########################Common#################################################

Get iron_python script for PMA Alarm verification
    [Arguments]    ${Filepath}    ${data}
    ${TextFileContent}=     OperatingSystem.Get File    ${Filepath}
    ${str} =	Replace String	    ${TextFileContent}	   SYS_AREA   	${data}[System_area]
    ${str1} =	Replace String	    ${str}	   NODE_TYPE   	${data}[Node_type]
    ${str2} =	Replace String	    ${str1}	   MEASURE_1   	${data}[Measure_1]
    ${str3} =	Replace String	    ${str2}	   NODE_USED   	${data}[Node]
    ${str4} =	Replace String	    ${str3}	   ALARM_NAME_VALUE   	${data}[Alarm_name]
    ${str5} =	Replace String	    ${str4}	   SINGLE_COLLECTION   	${data}[Single_node_or_collection]
    ${str6} =	Replace String	    ${str5}	   AGGREGATION_VALUE   	${data}[Aggregation]
    ${str7} =	Replace String	    ${str6}	   PROBABLE_CAUSE   	${data}[Probable_cause]
    ${str8} =	Replace String	    ${str7}	   SPECIFIC_PROBLEM   	${data}[Specific_problem]
    ${str9} =	Replace String	    ${str8}	   ALARM_TYPE   	${data}[Alarm_Type]
    ${str10} =	Replace String	    ${str9}	   MEASURE_TYPE   	${data}[Measure_type]
    ${str11} =	Replace String	    ${str10}	   ALARM_SEVERITY   	${data}[Alarm_severity]
    ${str12} =	Replace String	    ${str11}	   DATE_RANGE_VALUE   	${data}[Date_range_val]
    ${str13} =	Replace String	    ${str12}	   LOOK_BACK_PERIOD_VALUE   	${data}[LookBack_Period_val]
    ${str14} =	Replace String	    ${str13}	   ENIQ_DATASOURCE   	${data}[ENIQ_data_source]
    ${str15} =	Replace String	    ${str14}	   DATE_RANGE_UNIT   	${data}[Date_range_unit]
    ${str16} =	Replace String	    ${str15}	   LOOK_BACK_PERIOD_UNIT   	${data}[LookBack_Period_unit]
    ${str17} =	Replace String	    ${str16}	   MEASURE_2   	${data}[Measure_2]
    ${str18} =	Replace String	    ${str17}	   MEASURE_3   	${data}[Measure_3]
    ${str19} =	Replace String	    ${str18}	   MEASURE_4   	${data}[Measure_4]
    ${file_loc}=    Set variable    ${EXECDIR}\\Other\\Files
    Log    ${file_loc}
    ${loc}=		Replace String    ${file_loc}    \\    \\\\
    ${str20} =	Replace String	    ${str19}	   PROJ_LOC   	${loc}
    ${str21} =	Replace String	    ${str20}	   DELETE_ALARM   	${data}[Delete_alarm]
    Log     ${str21}
    [Return]     ${str21}

Get iron_python script for PMA DataIntegrity
    [Arguments]    ${Filepath}    ${data}    ${projLoc}		${uniqueIDCol}
    ${TextFileContent}=     OperatingSystem.Get File    ${Filepath}
    ${str} =	Replace String	    ${TextFileContent}	   SYS_AREA   	${data}[System_area]
    ${str1} =	Replace String	    ${str}	   NODE_TYPE   	${data}[Node_type]
    ${str2} =	Replace String	    ${str1}	   KPI_USED   	${data}[Measure]
    ${str3} =	Replace String	    ${str2}	   NODE_USED   	${data}[Node]
    ${str4} =	Replace String	    ${str3}	   PROJ_LOC   	${projLoc}
    ${str5} =	Replace String	    ${str4}	   SINGLE_COLLECTION   	${data}[Single_node_or_collection]
    ${str6} =	Replace String	    ${str5}	   AGGREGATION_VALUE   	${data}[Aggregation]
    ${str7} =	Replace String	    ${str6}	   PROBABLE_CAUSE   	${data}[Probable_cause]
    ${str8} =	Replace String	    ${str7}	   SPECIFIC_PROBLEM   	${data}[Specific_problem]
    ${str9} =	Replace String	    ${str8}	   ALARM_TYPE   	${data}[Alarm_Type]
    ${str10} =	Replace String	    ${str9}	   MEASURE_TYPE   	${data}[Measure_type]
    ${str11} =	Replace String	    ${str10}	   ALARM_SEVERITY   	${data}[Alarm_severity]
    ${str12} =	Replace String	    ${str11}	   DATE_RANGE_VALUE   	${data}[Date_range_val]
    ${str13} =	Replace String	    ${str12}	   LOOK_BACK_PERIOD_VALUE   	${data}[LookBack_Period_val]
    ${str14} =	Replace String	    ${str13}	   ENIQ_DATASOURCE   	${data}[ENIQ_data_source]
    ${str15} =	Replace String	    ${str14}	   DATE_RANGE_UNIT   	${data}[Date_range_unit]
    ${str16} =	Replace String	    ${str15}	   LOOK_BACK_PERIOD_UNIT   	${data}[LookBack_Period_unit]
    ${str17} =	Replace String	    ${str16}	   UNIQUE_COL   	${uniqueIDCol}
    Log       ${str17} 
    [Return]     ${str17}

Get iron_python script by passing project location
    [Arguments]    ${Filepath}    ${data}    ${projLoc}		${uniqueIDCol}
    ${TextFileContent}=     OperatingSystem.Get File    ${Filepath}
    ${str} =	Replace String	    ${TextFileContent}	   SYS_AREA   	${data}[System_area]
    ${str1} =	Replace String	    ${str}	   NODE_TYPE   	${data}[Node_type]
    ${str2} =	Replace String	    ${str1}	   KPI_USED   	${data}[Measure]
    ${str3} =	Replace String	    ${str2}	   NODE_USED   	${data}[Node]
    ${str4} =	Replace String	    ${str3}	   PROJ_LOC   	${projLoc}
    ${str5} =	Replace String	    ${str4}	   UNIQUE_COL   	${uniqueIDCol}
    ${str6} =	Replace String	    ${str5}	   NODE_COLLECTION   	${data}[Node_Collection]
    ${str7} =	Replace String	    ${str6}	   OBJECT_AGGREGATION   	${data}[Object_Aggregation]
    ${str8} =	Replace String	    ${str7}	   PRECEDINGPERIODS   	${data}[Preceding_period]
    ${str9} =	Replace String	    ${str8}	   PRECEDING_PERIODS_UNITS   	${data}[Preceding_period_unit]
    ${str10} =	Replace String	    ${str9}	   AGGREGATION_SELECTION   	${data}[Aggregation]
    ${str11} =	Replace String	    ${str10}	   TIME_SELECTOR     	${data}[Time_selector]
    ${str12} =	Replace String	    ${str11}	   START_DATE   	${data}[start_date]
    ${str13} =	Replace String	    ${str12}	   START_TIME   	${data}[start_time]
    ${str14} =	Replace String	    ${str13}	   END_DATE   	${data}[end_date]
    ${str15} =	Replace String	    ${str14}	   END_TIME   	${data}[end_time]
    Log       ${str15} 
    [Return]     ${str15}
    
Get iron_python script by passing project location for three param
    [Arguments]    ${Filepath}    ${data}    ${projLoc}		${uniqueIDCol}		${uniqueIDCol2}
    ${TextFileContent}=     OperatingSystem.Get File    ${Filepath}
    ${str} =	Replace String	    ${TextFileContent}	   SYS_AREA   	${data}[System_area]
    ${str1} =	Replace String	    ${str}	   NODE_TYPE   	${data}[Node_type]
    ${str2} =	Replace String	    ${str1}	   KPI_USED   	${data}[Measure]
    ${str3} =	Replace String	    ${str2}	   NODE_USED   	${data}[Node]
    ${str4} =	Replace String	    ${str3}	   PROJ_LOC   	${projLoc}
    ${str5} =	Replace String	    ${str4}	   UNIQUE_COL   	${uniqueIDCol}
    ${str6} =	Replace String	    ${str5}	   NODE_NAME   	${uniqueIDCol2}
    ${str7} =	Replace String	    ${str6}	   OBJECT_AGGREGATION   	${data}[Object_Aggregation]
    ${str8} =	Replace String	    ${str7}	   PRECEDINGPERIODS   	${data}[Preceding_period]
    ${str9} =	Replace String	    ${str8}	   PRECEDING_PERIODS_UNITS   	${data}[Preceding_period_unit]
    ${str10} =	Replace String	    ${str9}	   AGGREGATION_SELECTION   	${data}[Aggregation]
    ${str11} =	Replace String	    ${str10}	   NODE_COLLECTION   	${data}[Node_Collection]
    ${str12} =	Replace String	    ${str11}	   START_DATE   	${data}[start_date]
    ${str13} =	Replace String	    ${str12}	   START_TIME   	${data}[start_time]
    ${str14} =	Replace String	    ${str13}	   END_DATE   	${data}[end_date]
    ${str15} =	Replace String	    ${str14}	   END_TIME   	${data}[end_time]
    ${str16} =	Replace String	    ${str15}	   TIME_SELECTOR     	${data}[Time_selector]
    Log     ${str16}
    [Return]     ${str16}
    
Get iron_python script by passing project location for multi eniq
	[Arguments]    ${filePath}    ${data}    ${projLoc}		${uniqueIDCol}
	${textFileContent}=    OperatingSystem.Get File    ${filePath}
	${str} =	Replace String	    ${TextFileContent}	   SYS_AREA   	${data}[System_area]
    ${str1} =	Replace String	    ${str}	   NODE_TYPE   	${data}[Node_type]UNIQUE_COL
    ${str2} =	Replace String	    ${str1}	   KPI_USED   	${data}[Measure]
    ${str3} =	Replace String	    ${str2}	   NODE_USED   	${data}[Node]
    ${str4} =	Replace String	    ${str3}	   PROJ_LOC   	${projLoc}
    ${str5} =	Replace String	    ${str4}	      	${uniqueIDCol}
    ${str6} =	Replace String	    ${str5}	   NODE_COLLECTION   	${data}[Node_Collection]
    ${str7} =	Replace String	    ${str6}	   OBJECT_AGGREGATION   	${data}[Object_Aggregation]
    ${str8} =	Replace String	    ${str7}	   PRECEDINGPERIODS   	${data}[Preceding_period]
    ${str9} =	Replace String	    ${str8}	   PRECEDING_PERIODS_UNITS   	${data}[Preceding_period_unit]
    ${str10} =	Replace String	    ${str9}	   AGGREGATION_SELECTION   	${data}[Aggregation]
    ${str11} =	Replace String	    ${str10}	   TIME_SELECTOR     	${data}[Time_selector]
    ${str12} =	Replace String	    ${str11}	   START_DATE   	${data}[start_date]
    ${str13} =	Replace String	    ${str12}	   START_TIME   	${data}[start_time]
    ${str14} =	Replace String	    ${str13}	   END_DATE   	${data}[end_date]
    ${str15} =	Replace String	    ${str14}	   END_TIME   	${data}[end_time]
    Log       ${str15} 
    [Return]     ${str15}
    
    
Get iron python script by passing project location for multi eniq for collection manager
	[Arguments]    ${filePath}    ${data}
	${textFileContent}=    OperatingSystem.Get File    ${filePath}
	${str} =	Replace String	    ${TextFileContent}	   SYS_AREA   	${data}[System_Area]
    ${str1} =	Replace String	    ${str}	   NODE_TYPE   	${data}[Node_Type]
    ${str2} =	Replace String	    ${str1}    Collection_Name   	${data}[Collection_Name]
    ${str3} =   Replace String    ${str2}    NODE_USED    ${data}[Node]
    Log       ${str3} 
    [Return]     ${str3}
    

    
Get the iron_python script by passing project location for multi eniq
	[Arguments]    ${filePath}
	${textFileContent}=    OperatingSystem.Get File    ${filePath}
    Log       ${textFileContent} 
    [Return]     ${textFileContent}
    
Run the test case with values from json file for collection manager
    [Arguments]      ${data}
    Launch the Tibco spotfire PMEx Application
	#${loc}=		Replace String 		${file_loc}	 \\		\\\\
	#${test_script}=    Get iron python script by passing project location for multi eniq for collection manager    ${scripts}\\pmexMultiEniqCollectionManager.py     ${data}
    #Execute the iron python script     ${test_script}     False
    Open Collection Manager
    Click on create and verify that Select ENIQ Datasource is a dropdown
    Select a Report and Click on edit in collection manager
    Verify that Collection Name, System Area, Node Type will be uneditable" is visible in the page
    #[Teardown]     Close Tibco spotfire PMEX Application
    
Run the test case with values from json file
    [Arguments]      ${data}
	${loc}=		Replace String 		${file_loc}	 \\		\\\\
	${test_script}=    Get iron_python script by passing project location for multi eniq    ${scripts}\\pmexMultiEniqReportManager.py     ${data}     ${loc}		MOID
    Execute the iron python script for multi eniq     ${test_script}     False 
    Open Report Manager
	Verify that Select ENIQ DataSource is added as a drop down    0
    Select a report and click on edit
    ENIQ DataSource drop down should be present
    Capture Page screenshot
    [Teardown]     Close Tibco spotfire PMEX Application
    
Run the test case with values from input json file
    [Arguments]      ${data}
    Launch the Tibco spotfire PMEx Application
   	${loc}=		Replace String 		${file_loc}	 \\		\\\\
   	sleep    40
	${test_script}=    Get iron_python script by passing project location for multi eniq    ${scripts}\\pmexMultiEniqReportManager2.py     ${data}     ${loc}		MOID
    sleep    40
    Execute the iron python script for multi eniq     ${test_script}     False 
	Open Data tab and verify the connection string
    Save the Report and verify the data source in page title
    close the report
    Verify that ENIQName is added as a column in the Reports Table
	Verify that Select ENIQ DataSource is added as a drop down    1
    [Teardown]     Close Tibco spotfire PMEX Application
	
Query ENIQ database IMS CSCF
    [Arguments]       ${sql_query}    ${Date_Val}    ${unique_id}
    
    ${AmPm}    ${DateTime}=    Get AMPM and DateTime from DateTime Stamp    ${Date_Val}    
    ${dateTime}=    Remove AMPM from dateTime    ${Date_Val}
    ${Date_Val}    Convert Date    ${dateTime}    result_format=%Y-%m-%d %H:%M   date_format=%m/%d/%Y %H:%M
    ${Date_Val}=    Add AMPM to DateTime Stamp    ${AmPm}    ${Date_Val}
    ${sql_query}=     Replace String    ${sql_query}    @time      \'${Date_Val}\'
    ${sql_query}=     Replace String    ${sql_query}    @node      \'${unique_id}\'
    log    ${sql_query}
    ${value}=     Query Sybase database     ${sql_query}
    log    ${value}
    ${string_value}=      Convert to string      ${value}[0]
    ${value}=         Remove string      ${string_value}     Decimal      (     )     '   ,
    [Return]     ${value}

Query ENIQ database IMS
    [Arguments]       ${sql_query}    ${Date_Val}    ${unique_id}
    ${AmPm}    ${DateTime}=    Get AMPM and DateTime from DateTime Stamp    ${Date_Val}    
    ${dateTime}=    Remove AMPM from dateTime    ${Date_Val}
    ${Date_Val}    Convert Date    ${dateTime}    result_format=%Y-%m-%d %H:%M   date_format=%m/%d/%Y %H:%M:%S
    ${Date_Val}=    Add AMPM to DateTime Stamp    ${AmPm}    ${Date_Val}
    ${sql_query}=     Replace String    ${sql_query}    @time      \'${Date_Val}\'
    ${sql_query}=     Replace String    ${sql_query}    @node      \'${unique_id}\'
    log    ${sql_query}
    ${value}=     Query Sybase database     ${sql_query}
    log    ${value}
    ${string_value}=      Convert to string      ${value}[0]
    ${value}=         Remove string      ${string_value}     Decimal      (     )     '   ,
    [Return]     ${value}
				   
Read parameters from the text file    
	[Arguments]    ${Filepath}    
    ${str}=     OperatingSystem.Get File    ${Filepath}
    Log     ${str}
    [Return]     ${str}
    
Remove zeros after decimal point from measure value
	[Arguments]    ${value}
	${words}=    Split String	${value}   .00
	Log 	${words}
	${formattedValue}=     Get From List    ${words}    0
	${formattedValue}=    Strip String    ${formattedValue}
	[Return] 	${formattedValue}
	Log 	${formattedValue}	
    
    
Read parameters from Report in client
    [Arguments]   ${parameter}
    Set ocr text read    True
    ${text}=    SikuliLibrary.Get text
    Log    ${text}
    # Should not Contain    ${text}    0 of O rows
    @{lines} =	Split To Lines	${text}
    Log    ${lines}
    ${line} =	Get Lines Containing String	  ${text}  	${parameter}
    ${index} =	Get Index From List	   ${lines}	  ${line}
    ${val_index}=   Evaluate   ${index}+1
    ${value_line} =	Get From List	${lines}	${val_index}
    @{heading} =	Split String	${line}	
    @{values} =	Split String	${value_line}
    ${head_index} =	Get Index From List	   ${heading}	  ${parameter}
    ${value} =	Get From List	${values}	${head_index}
    Log    ${value}    
    
    
 ####copy   
Read the parameters from Report in client
    [Arguments]   ${parameter}
    Set ocr text read    True
    ${text}=    SikuliLibrary.Get text
    Log    ${text}
    # Should not Contain    ${text}    0 of O rows
    @{lines} =	Split To Lines	${text}
    Log    ${lines}
    ${line} =	Get Lines Containing String	  ${text}  	${parameter}
    ${index} =	Get Index From List	   ${lines}	  ${line}
    ${val_index}=   Evaluate   ${index}+1
    ${value_line} =	Get From List	${lines}	${val_index}
    @{heading} =	Split String	${line}	
    @{values} =	Split String	${value_line}
    ${head_index} =	Get Index From List	   ${heading}	  ${parameter}
    ${value} =	Get From List	${values}	${head_index}
    Log    ${value} 
    [Return]    ${value}
   

    
Close Tibco spotfire PMEX Application
    Capture page screenshot
    AutoItLibrary.ProcessClose      PM_Explorer.Dxp.exe
    AutoItLibrary.ProcessClose      Spotfire.Dxp.exe 
    OperatingSystem.Run    taskkill /f /im Spotfire.dxp.exe
    Sleep    120s
    
Close the Tibco spotfire PMEX Application
    Capture page screenshot
    AutoItLibrary.ProcessClose      PM_Explorer.Dxp.exe
    AutoItLibrary.ProcessClose      Spotfire.Dxp.exe 
    OperatingSystem.Run    taskkill /f /im Spotfire.dxp.exe
    Sleep    10s

Close Tibco spotfire PMA Application
    Capture page screenshot
    AutoItLibrary.ProcessClose      PM_Alarming.Dxp.exe
    AutoItLibrary.ProcessClose      Spotfire.Dxp.exe 
    OperatingSystem.Run    taskkill /f /im Spotfire.dxp.exe
    Sleep    120s

Connect to NetAn ODBC and Sync with ENIQ
    Execute iron python script    ${scripts}\\DBConnection.py     False
    Sleep    10s
    # Click    ${IMAGE_DIR}\\SyncwithEniqButton.PNG
    # Sleep    60s
    
Click on element
    [Arguments]    ${ele}     ${exp_ele}        ${retries}   ${sleep_time}=5
    Click    ${ele}
    FOR    ${i}    IN RANGE    0    ${retries} 
           Sleep    ${sleep_time}s
           ${is_exists}=    Exists    ${exp_ele}   2
           Exit For Loop If    ${is_exists} == True
           Click    ${ele}
    END
    
    

Execute iron python script  
    [Arguments]    ${TextFileContent}     ${ExecuteInTransaction}
    Click on element    ${IMAGE_DIR}\\FileMenu.PNG      ${IMAGE_DIR}\\DocumentProperties.PNG     3
    Click on element    ${IMAGE_DIR}\\DocumentProperties.PNG      ${IMAGE_DIR}\\PropertiesButton.PNG     3
    Click on element    ${IMAGE_DIR}\\PropertiesButton.PNG      ${IMAGE_DIR}\\ScriptButton.PNG     3
    Click on element    ${IMAGE_DIR}\\ScriptButton.PNG      ${IMAGE_DIR}\\checkbox.PNG     3
    Click on element    ${IMAGE_DIR}\\checkbox.PNG      ${IMAGE_DIR}\\newButton.PNG     3
    Click on element    ${IMAGE_DIR}\\newButton.PNG      ${IMAGE_DIR}\\scriptTextArea.PNG     3
    #${TextFileContent}=     Get File    ${Filepath} 
    Run Keyword If    ${ExecuteInTransaction}==False    Click    ${IMAGE_DIR}\\ExecuteInTransaction.PNG
    Sleep    2s
    Click    ${IMAGE_DIR}\\scriptTextArea.PNG
    Paste text    ${IMAGE_DIR}\\scriptTextArea1.PNG    ${TextFileContent}
    Click on element    ${IMAGE_DIR}\\runScriptButton.PNG      ${IMAGE_DIR}\\scriptTextArea.PNG     3     180
	  
    Wait until screen contain     ${IMAGE_DIR}\\OutputOK.PNG    1310
    Capture Screen
    Sleep    30s
    Click    ${IMAGE_DIR}\\CancelButton.PNG
    Sleep    5s
    Click    ${IMAGE_DIR}\\OKButton.PNG
    Sleep    20s
    Click    ${IMAGE_DIR}\\GeneralTab.PNG
    Sleep    2s
    Click    ${IMAGE_DIR}\\OKButton.PNG
    Sleep    8s
    Capture Screen
    
Execute the iron python script  
    [Arguments]    ${TextFileContent}     ${ExecuteInTransaction}
    Click on element    ${IMAGE_DIR}\\FileMenu.PNG      ${IMAGE_DIR}\\DocumentProperties.PNG     3
    Click on element    ${IMAGE_DIR}\\DocumentProperties.PNG      ${IMAGE_DIR}\\PropertiesButton.PNG     3
    Click on element    ${IMAGE_DIR}\\PropertiesButton.PNG      ${IMAGE_DIR}\\ScriptButton.PNG     3
    Click on element    ${IMAGE_DIR}\\ScriptButton.PNG      ${IMAGE_DIR}\\checkbox.PNG     3
    Click on element    ${IMAGE_DIR}\\checkbox.PNG      ${IMAGE_DIR}\\newButton.PNG     3
    Click on element    ${IMAGE_DIR}\\newButton.PNG      ${IMAGE_DIR}\\scriptTextArea.PNG     3
    Run Keyword If    ${ExecuteInTransaction}==False    Click    ${IMAGE_DIR}\\ExecuteInTransaction.PNG
    Sleep    2s
    Click    ${IMAGE_DIR}\\scriptTextArea.PNG
    Paste text    ${IMAGE_DIR}\\scriptTextArea1.PNG    ${TextFileContent}
    Click on element    ${IMAGE_DIR}\\runScriptButton.PNG      ${IMAGE_DIR}\\scriptTextArea.PNG     3     180
    Wait until screen contain     ${IMAGE_DIR}\\OutputOK.PNG    2040
    Capture Screen
    Sleep    30s
    Wait until screen contain     ${IMAGE_DIR}\\CancelButton.PNG    300
    Click    ${IMAGE_DIR}\\CancelButton.PNG
    Sleep    5s
    Wait until screen contain     ${IMAGE_DIR}\\noActionRadio.PNG    300
    Click    ${IMAGE_DIR}\\noActionRadio.PNG
    Sleep    5s
    Wait until screen contain     ${IMAGE_DIR}\\OKButton.PNG    300
    Click    ${IMAGE_DIR}\\OKButton.PNG
    Sleep    20s
    Wait until screen contain     ${IMAGE_DIR}\\GeneralTab.PNG    300
    Click    ${IMAGE_DIR}\\GeneralTab.PNG
    Sleep    2s
    Wait until screen contain     ${IMAGE_DIR}\\OKButton.PNG    300
    Click    ${IMAGE_DIR}\\OKButton.PNG
    Sleep    8s
    Capture Screen
    
    
Execute the iron python script for multi eniq
    [Arguments]    ${TextFileContent}     ${ExecuteInTransaction}
    Click on element    ${IMAGE_DIR}\\FileMenu.PNG      ${IMAGE_DIR}\\DocumentProperties.PNG     3
    Click on element    ${IMAGE_DIR}\\DocumentProperties.PNG      ${IMAGE_DIR}\\PropertiesButton.PNG     3
    Click on element    ${IMAGE_DIR}\\PropertiesButton.PNG      ${IMAGE_DIR}\\ScriptButton.PNG     3
    Click on element    ${IMAGE_DIR}\\ScriptButton.PNG      ${IMAGE_DIR}\\checkbox.PNG     3
    Click on element    ${IMAGE_DIR}\\checkbox.PNG      ${IMAGE_DIR}\\newButton.PNG     3
    Click on element    ${IMAGE_DIR}\\newButton.PNG      ${IMAGE_DIR}\\scriptTextArea.PNG     3
    Run Keyword If    ${ExecuteInTransaction}==False    Click    ${IMAGE_DIR}\\ExecuteInTransaction.PNG
    Sleep    2s
    Click    ${IMAGE_DIR}\\scriptTextArea.PNG
    Paste text    ${IMAGE_DIR}\\scriptTextArea1.PNG    ${TextFileContent}
    sleep    10
    Click on element    ${IMAGE_DIR}\\runScriptButton.PNG      ${IMAGE_DIR}\\scriptTextArea.PNG     1     10
    Capture Screen
    Sleep    100s
    Wait until screen contain     ${IMAGE_DIR}\\CancelButton.PNG    300
    Click    ${IMAGE_DIR}\\CancelButton.PNG
    Sleep    5s
    Wait until screen contain     ${IMAGE_DIR}\\noActionRadio.PNG    300
    Click    ${IMAGE_DIR}\\noActionRadio.PNG
    Sleep    5s
    Wait until screen contain     ${IMAGE_DIR}\\OKButton.PNG    300
    Click    ${IMAGE_DIR}\\OKButton.PNG
    Sleep    20s
    Wait until screen contain     ${IMAGE_DIR}\\GeneralTab.PNG    300
    Click    ${IMAGE_DIR}\\GeneralTab.PNG
    Sleep    2s
    Wait until screen contain     ${IMAGE_DIR}\\OKButton.PNG    300
    Click    ${IMAGE_DIR}\\OKButton.PNG
    Sleep    8s
    Capture Screen
    
    
Verify UI value is matching with DB value
    [Arguments]       ${UI}     ${DB}
    Log    ${UI}
    Log    ${DB}
    Should Be Equal    ${UI}    ${DB}
    

        
#################################### Database ##################################################    
Execute Query and return output
    [Arguments]     ${query}
    Set Client Configuration	  prompt=dc)>
    Write               dbisql -c "UID=dc;PWD=Eniq@1234" -host ieatrcxb3720.athtem.eei.ericsson.se -port 2640 -nogui
    Sleep    30s
    ${op1} =                        Read Until Regexp    dc
    log    ${op1}
    Write               ${query}
    Sleep    60s
    ${op2} =                        Read 
    log    ${op2}  
    [Return]      ${op2}
      
Query ENIQ database Uplink Interference
    [Arguments]       ${sql_query}    ${cellValue}
    Write               dbisql -c "UID=dc;PWD=Eniq@1234" -host ieatrcxb3720.athtem.eei.ericsson.se -port 2640 -nogui
    ${op1} =                        Read Until Regexp    dc
    log    ${op1}
    ${sql_query}=     Replace String    ${sql_query}    @cell      ${cellValue}
    ${sql_query}=     Catenate    DECLARE @limitingValue INT = 500 DECLARE @cell    ${sql_query}
    log    ${sql_query}
    Write               ${sql_query}
    Sleep    30s
    ${op2} =                        Read      
    log          ${op2}    
    ${words}=    Split String from Right    ${op2}    -    1
    log          ${words}
    ${value}=    Get From List    ${words}    -1
    ${value}=    Split String    ${value}    1H
	${value}=    Get From List    ${value}    1
	${value}=    Split String    ${value}
	${value}=    Get From List    ${value}    0
	${value}=    Strip String    ${value}
	log          ${value}
    [Return]     ${value}

Query ENIQ database Uplink Interference for the table
    [Arguments]       ${tableName}    ${sql_query}
    Write               dbisql -c "UID=dc;PWD=Eniq@1234" -host ieatrcxb3720.athtem.eei.ericsson.se -port 2640 -nogui
    ${op1} =                        Read Until Regexp    dc
    log    ${sql_query}
    Write               ${sql_query}
    Sleep    5s
    ${op2} =                        Read      
    log          ${op2}    
    ${op2}=    Split String    ${op2}    1H    1
    log    ${op2}
    ${op2}=    Get from List    ${op2}    1
    log    ${op2}
    ${op2}=    Split String     ${op2}    -    1
    #${op2}=    Split String from Right    ${op2}    -    1
    log    ${op2}
    ${op2}=    Get from List    ${op2}    1
    log    ${op2}
    ${op2}=    Split String    ${op2}    1H
    log    ${op2}
    ${value}=    Get From List    ${op2}    1
    log    ${value}
    ${value1}=    Get From List    ${op2}    2
    log    ${value1}
    ${value2}=    Get From List    ${op2}    3
    log    ${value2}
    ${value3}=    Get From List    ${op2}    4
    log    ${value3}
    ${kpiList}=    Create List    ${value}    ${value1}    ${value2}      ${value3}
    log    ${kpiList}
    Length Should be    ${kpiList}    4
	
getYesterdaysDate
	${date} =    Get Current Date    result_format=%Y-%m-%d    increment=-1 day
    Log    ${date}
    [Return]    ${date}
	
Query the ENIQ database Uplink Interference for source and target table of
    [Arguments]        ${kpiName}    ${sql_query}    ${date}
    IF    "${kpiName}" == "Avg_Int_PUSCH_Prb1" or "${kpiName}" == "Avg_Int_PUCCH1" or "${kpiName}" == "Avg_Int_PUSCH_BrPrb1" or "" == "Avg_Int_PUSCH1"
    	${sql_query}=    catenate     DECLARE @datetime DATETIME SET @datetime = '${date}'    ${sql_query}
    	log    ${sql_query}
    	Write               ${sql_query}
    	Sleep    30s
    	${DB1} =                        Read      
    	log          ${DB1} 
    	${DB1}=    Split String from Right    ${DB1}    --    1
    	${DB1}=    Get from List    ${DB1}    1
    	log    ${DB1}   
    ELSE IF    "${kpiName}" == "Avg_Int_PUSCH_Prb2" or "${kpiName}" == "Avg_Int_PUCCH2" or "${kpiName}" == "Avg_Int_PUSCH_BrPrb2" or "" == "Avg_Int_PUSCH2"
    	${sql_query}=    catenate     DECLARE @datetime DATETIME SET @datetime = '${date}'    ${sql_query}
    	log    ${sql_query}
    	Write               ${sql_query}
    	Sleep    30s
    	${DB2} =                        Read      
    	log          ${DB2} 
    	${DB2}=    Split String from Right    ${DB2}    --    1
    	${DB2}=    Get from List    ${DB2}    1
    	log    ${DB2}
    END
	
Compare the two outputs
	[Arguments]    ${DB1}    ${DB2}
	log    ${DB1}
	log    ${DB2}
	Should be equal    ${DB1}    ${DB2}
	
Remove everything after decimal point from measure value
	[Arguments]    ${value}
	${words}=    Split String	${value}    .
	Log 	${words}
	${formattedValue}=     Get From List    ${words}    0
	${formattedValue}=    Strip String    ${formattedValue}
	[Return] 	${formattedValue}
	Log 	${formattedValue}	 
	
Get AMPM and DateTime from DateTime Stamp
    [Arguments]    ${dateTime}
	${dateTime}=    Split String from Right    ${dateTime}    ${EMPTY}    1
	${ampm}=    Get From List    ${dateTime}    1
	${dateTime}=    Get From List    ${dateTime}    0	
	Log    ${ampm}
	Log    ${dateTime}
	[Return]    ${ampm}    ${dateTime}
	
Remove AMPM from dateTime
	[Arguments]    ${dateTime}
	${dateTime}=    Split String from Right    ${dateTime}    ${EMPTY}    1
    ${dateTime}=    Get From List    ${dateTime}    0	
    Log    ${dateTime}
	[Return]    ${dateTime}
	
Add AMPM to DateTime Stamp
	[Arguments]    ${ampm}    ${dateTime}
	${DateTime}=    Catenate    ${dateTime}    ${ampm}
	[Return]    ${DateTime}

query the eniq database for VoLTE 
	[Arguments]       ${sql_query}    ${nodeName}    ${measureName}    ${measureObject}    ${date_Val}
	Write               dbisql -c "UID=dc;PWD=Eniq@1234" -host ieatrcxb3720.athtem.eei.ericsson.se -port 2640 -nogui
    ${op1} =                        Read Until Regexp    dc
    log    ${op1}
    ${AmPm}    ${DateTime}=    Get AMPM and DateTime from DateTime Stamp    ${date_Val}    
    ${dateTime}=    Remove AMPM from dateTime    ${Date_Val}
    ${Date_Val}    Convert Date    ${dateTime}    result_format=%Y-%m-%d %H:%M:%S   date_format=%m/%d/%Y %H:%M:%S
    ${Date_Val}=    Add AMPM to DateTime Stamp    ${AmPm}    ${Date_Val}
    ${sql_query}=     Replace String    ${sql_query}    @time      \'${Date_Val}\'
    ${sql_query}=     Replace String    ${sql_query}    @node      \'${nodeName}\'
    ${sql_query}=     Replace String    ${sql_query}    @name      \'${measureName}\'
    ${sql_query}=     Replace String    ${sql_query}    @measuredObject      \'${measureObject}\'
    log    ${sql_query}
    Write               ${sql_query}
    Sleep    30s
    ${op2} =                        Read      
    log    ${op2}    
    ${words}=    Split String from Right    ${op2}    -    1
    log    ${words}
    ${value}=    Get From List    ${words}    -1
    ${value}=    Split String    ${value}    1H
	${value}=    Get From List    ${value}    1
	${value}=    Split String    ${value}
	${value}=    Get From List    ${value}    0
	${value}=    Strip String    ${value}
	log    ${value}
    [Return]    ${value}

query the eniq database for VoLTE ERBS
	[Arguments]       ${sql_query}    ${nodeName}    ${measureName}    ${cellFDN}    ${date_Val}
	Write               dbisql -c "UID=dc;PWD=Eniq@1234" -host ieatrcxb3720.athtem.eei.ericsson.se -port 2640 -nogui
    ${op1} =                        Read Until Regexp    dc
    log    ${op1}
    ${AmPm}    ${DateTime}=    Get AMPM and DateTime from DateTime Stamp    ${date_Val}    
    ${dateTime}=    Remove AMPM from dateTime    ${Date_Val}
    ${Date_Val}    Convert Date    ${dateTime}    result_format=%Y-%m-%d %H:%M:%S   date_format=%m/%d/%Y %H:%M:%S
    ${Date_Val}=    Add AMPM to DateTime Stamp    ${AmPm}    ${Date_Val}
    ${sql_query}=     Replace String    ${sql_query}    @time      \'${Date_Val}\'
    ${sql_query}=     Replace String    ${sql_query}    @node      \'${nodeName}\'
    ${sql_query}=     Replace String    $Verify UI value is matching with DB value{sql_query}    @name      \'${measureName}\'
    ${sql_query}=     Replace String    ${sql_query}    @cell_fdn      \'${cellFDN}\'
    log    ${sql_query}
    Write               ${sql_query}
    Sleep    30s
    ${op2} =                        Read      
    log    ${op2}    
    ${words}=    Split String from Right    ${op2}    -    1
    log    ${words}
    ${value}=    Get From List    ${words}    -1
    ${value}=    Split String    ${value}    1H
	${value}=    Get From List    ${value}    1
	${value}=    Split String    ${value}
	${value}=    Get From List    ${value}    0
	${value}=    Strip String    ${value}
	log    ${value}
    [Return]    ${value}
    
Query ENIQ database
    [Arguments]       ${sql_query}    ${Date_Val}    ${unique_id}
    Write               dbisql -c "UID=dc;PWD=Eniq@1234" -host ieatrcxb3720.athtem.eei.ericsson.se -port 2640 -nogui
    Sleep    30s
    ${op1} =                        Read Until Regexp    dc
    log    ${op1}
    ${Date_Val}    Convert Date    ${Date_Val}    result_format=%Y-%m-%d    date_format=%d/%m/%Y
    ${sql_query}=     Replace String    ${sql_query}    DATETIME_VALUE     \'${Date_Val}\'
    ${sql_query}=     Replace String    ${sql_query}    UNIQUE_ID_VALUE      \'${unique_id}\'
    log    ${sql_query}
    Write               ${sql_query}
    Sleep    30s
    ${op2} =                        Read Until Regexp    dc  
    log    ${op2}  
    ${words} =	Split String	${op2}   MeasureValue 
    log   ${words} 
    ${value}=     Get From List    ${words}    -1
    ${value}=    Split String	${value}   1H 
    ${value}=    Get From List    ${value}    2
    ${value}=    Split String	${value}   
    ${value}=    Get From List    ${value}    0
    ${value}=    Strip String    ${value}
    log    ${value}
    [Return]     ${value}
    
Query ENIQ database for kpiValue
    [Arguments]       ${sql_query}    ${Date_Val}    ${unique_id}
	
    ${Date_Val}    Convert Date    ${Date_Val}    result_format=%Y-%m-%d    date_format=%m/%d/%Y
    ${sql_query}=     Replace String    ${sql_query}    DATETIME_VALUE     \'${Date_Val}\'
    ${sql_query}=     Replace String    ${sql_query}    UNIQUE_ID_VALUE      \'${unique_id}\'
    log    ${sql_query}
    ${value}=     Query Sybase database     ${sql_query}
    log    ${value}
    ${string_value}=      Convert to string      ${value}[0]
    [Return]     ${string_value}

Query ENIQ database for kpiValue for three param
	[Arguments]    ${sql_query}    ${Date_Val}    ${unique_id}    ${node_name}
	Write dbisql -c "UID=dc;PWD=Eniq@1234" -host ieatrcxb3720.athtem.eei.ericsson.se -port 2640 -nogui
	Sleep     30s
	${op1} =    Read Until Regexp dc
	log      ${op1}
	${Date_Val} Convert Date ${Date_Val} result_format=%Y-%m-%d date_format=%d/%m/%Y
	${sql_query}=    Replace String    ${sql_query}    DATETIME_VALUE      \'${Date_Val}\'
	${sql_query}=    Replace String    ${sql_query}    UNIQUE_ID_VALUE     \'${unique_id}\'
	${sql_query}=    Replace String    ${sql_query}    NODE_NAME_VALUE     \'${node_name}\'
	log     ${sql_query}
	Write     ${sql_query}
	Sleep     60s
	${op2} =     Read
	log       ${op2}
	${words}=    Split String from Right     ${op2}     -   1
	log    ${words}
	${value}=    Get From List    ${words}     -1
	${value}=    Split String     ${value}     1H
	${value}=    Get From List    ${value}      1
	${value}=    Split String     ${value}
	${value}=    Get From List    ${value}      0
	${value}=    Strip String     ${value}
	log     ${value}
	[Return]    ${value}
	
Query ENIQ database for multi eniq
    [Arguments]       ${sql_query}
    Write               dbisql -c "UID=dwhrep;PWD=dwhrep" -host ieatrcxb3720.athtem.eei.ericsson.se -port 2641 -nogui
    Sleep    30
    ${op1} =       Read Until Regexp     dwhrep
    log    ${op1}
    log    ${sql_query}
    Write               ${sql_query}
    Sleep    30s
    ${op2} =        Read   
    log    ${op2}  
    ${words} =	Split String from right  	${op2}    -------- 
    #log   ${words} 
    #${value}=     Get From List    ${words}    -1
    #${value}=    Split String	${value}   1H 
    #${value}=    Get From List    ${value}    1
    #${value}=    Split String	${value}   
    #${value}=    Get From List    ${value}    0
    #${value}=    Strip String    ${value}
    log    ${words}
    [Return]     ${words}

# copy    
Read parameters from the Report in client
    [Arguments]   ${parameter}
    Set ocr text read    True
    ${text}=    SikuliLibrary.Get text
    Log    ${text}
    # Should not Contain    ${text}    0 of O rows
    @{lines} =	Split To Lines	${text}
    ${line} =	Get Lines Containing String	  ${text}  	${parameter}
    ${index} =	Get Index From List	   ${lines}	  ${line}
    ${val_index}=   Evaluate   ${index}+1
    ${value_line} =	Get From List	${lines}	${val_index}
    @{heading} =	Split String	${line}	
    ${value_linee} =	Remove string   ${value_line}    00... 
    Log    ${value_linee}
    @{values} =	Split String	${value_linee}    
    ${head_index} =	Get Index From List	   ${heading}	  ${parameter}
    ${value} =	Get From List	${values}	${head_index}
    Log    ${value}         
    [Return]    ${value}
    

    

Open Connection And Log In
    [Arguments]  ${host}    ${username}   ${password}    ${PORT}
    SSHLibrary.Open Connection    ${host}
    SSHLibrary.Login    ${username}    ${password}    delay=1    
    
    
    
###########################################PM Alarm######################################

Launch Tibco spotfire PMA Application
    AutoItLibrary.Run    C:\\Program Files (x86)\\TIBCO\\Spotfire\\11.4.2\\Spotfire.Dxp /server:"https://localhost/" /username:Administrator /password:Ericsson01 /file:${dxp_file_loc}/PM_Alarming_S11_2.dxp
    sleep    15																				 
	Wait until screen contain     ${IMAGE_DIR}\\certificate.PNG    300
    Click    ${IMAGE_DIR}\\certificateYes.PNG																				
    Sleep    90
    Capture Screen
    
Get Alarm name
    Set ocr text read    True
    ${text}=    SikuliLibrary.Get text
    Log    ${text}
    @{lines} =	Split To Lines	${text}
    FOR    ${ele}    IN    @{lines}
        Log    ${ele}
    END
    ${l}=     Set variable    * To Edit, Activate, Deactivate Export or Delete, select an Alarm Rule
    ${index} =	Get Index From List	   ${lines}	  ${l} 
    ${alarm_index}=   Evaluate    ${index}-1
    ${value_line} =	Get From List	${lines}	${alarm_index}
    @{words} =	Split String	${value_line}
    ${alarm_name}=   Get From List	${words}	0
    Log     ${alarm_name}
    [Return]    ${alarm_name}
    
###########################################PM Explorer######################################

Launch the Tibco spotfire PMEx Application
    AutoItLibrary.Run    C:\\Program Files (x86)\\TIBCO\\Spotfire\\11.4.2\\Spotfire.Dxp /server:"https://localhost/" /username:Administrator /password:Ericsson01 /file:${dxp_file_loc}/PM_Explorer.dxp
    Wait until screen contain     ${IMAGE_DIR}\\certificate.PNG    300
    Click    ${IMAGE_DIR}\\certificateYes.PNG
    Sleep    10s
    #Wait until screen contain     ${IMAGE_DIR}\\dontInstall.PNG    300
    #Click    ${IMAGE_DIR}\\dontInstall.PNG
    #Control Click    Security Alert    ${EMPTY}    Button4    left    1    0    0
    #Wait until screen contain     ${IMAGE_DIR}\\MissingDataScreen.PNG    300
																		 
    #Click    ${IMAGE_DIR}\\MissingDatacheckbox.PNG
    #Click    ${IMAGE_DIR}\\OKButton.PNG
    #Sleep    10
    Wait until screen contain     ${IMAGE_DIR}\\PMExS11Page.PNG    300
    Sleep    15
    Capture Screen
    

Click on Report Manager button
    Click    ${IMAGE_DIR}\\ReportManagerButton.PNG
    Sleep    5s
    Wait until screen contain     ${IMAGE_DIR}\\RMCreateButton.PNG    300
    Capture Screen
    
########BUSY HOUR########
    
Click on Create
	sleep    3
	Wait until screen contain     ${IMAGE_DIR}\\createButton.PNG    300
    Click    ${IMAGE_DIR}\\createButton.PNG
    
Verify that Busy Hour is visible in Aggregation
	[Arguments]    ${case}
	sleep    3
	Wait until screen contain     ${IMAGE_DIR}\\busyHourDropDown.PNG    300
    Click    ${IMAGE_DIR}\\busyHourDropDown.PNG
    IF    "${case}" == "TRUE"
        Screen should contain     ${IMAGE_DIR}\\busyHourText.PNG
    ELSE IF    "${case}" == "FALSE"
    	Screen should not contain     ${IMAGE_DIR}\\busyHourText.PNG
    END
    
Select Node in Object Aggregation
	sleep    3
	Wait until screen contain     ${IMAGE_DIR}\\objectAggregation.PNG    300
    Click    ${IMAGE_DIR}\\objectAggregation.PNG
    sleep    3
    Wait until screen contain     ${IMAGE_DIR}\\nodeObjectAggregation.PNG    300
    Click    ${IMAGE_DIR}\\nodeObjectAggregation.PNG
    
Open Data tab and verify the data table
	sleep    3
	Click on element    ${IMAGE_DIR}\\dataButton.PNG      ${IMAGE_DIR}\\dataTableProperties.PNG     3
	CLick on element    ${IMAGE_DIR}\\dataTableProperties.PNG    ${IMAGE_DIR}\\sourceVerificationTable1.PNG    3
	CLick     ${IMAGE_DIR}\\sourceVerificationTable1.PNG
	Wait until screen contain    ${IMAGE_DIR}\\sourceInformationTab.PNG    300
	Click    ${IMAGE_DIR}\\sourceInformationTab.PNG
	sleep    15
	screen should contain    ${IMAGE_DIR}\\busyHourTableVerification.PNG
	sleep    10
	Wait until screen contain    ${IMAGE_DIR}\\OKButton.PNG    300
	Click    ${IMAGE_DIR}\\OKButton.PNG
	
Verify that the Aggregation is present in the Report title
	sleep    10
	screen should contain    ${IMAGE_DIR}\\busyHourAggregation.PNG
	
Make changes to report
	sleep    5
	wait until screen contain    ${IMAGE_DIR}\\objectAggregation1.PNG    300
	Click    ${IMAGE_DIR}\\objectAggregation1.PNG
	sleep    3
	wait until screen contain    ${IMAGE_DIR}\\noAggregation.PNG    300
	Click    ${IMAGE_DIR}\\noAggregation.PNG
	sleep    3
	wait until screen contain    ${IMAGE_DIR}\\preceedingPeriod.PNG    300
	Click    ${IMAGE_DIR}\\preceedingPeriod.PNG
	sleep    3
	wait until screen contain    ${IMAGE_DIR}\\last30Days.PNG    300
	Click    ${IMAGE_DIR}\\last30Days.PNG
	sleep    3
	wait until screen contain    ${IMAGE_DIR}\\blueFetchPMInfo.PNG    300
	Click    ${IMAGE_DIR}\\blueFetchPMInfo.PNG
	sleep    15
	
Verify that the user can View a report
	sleep    3
	Wait until screen contain    ${IMAGE_DIR}\\publicAccess.PNG    300
	Click    ${IMAGE_DIR}\\publicAccess.PNG
	sleep    3
	Wait until screen contain    ${IMAGE_DIR}\\viewButton.PNG    300
	Click    ${IMAGE_DIR}\\viewButton.PNG
	sleep    60
	Wait until screen contain    ${IMAGE_DIR}\\closeReport2.PNG    300
	Click    ${IMAGE_DIR}\\closeReport2.PNG
	sleep    3
	wait until screen contain    ${IMAGE_DIR}\\OKButton2.PNG    300
	Click    ${IMAGE_DIR}\\OKButton2.PNG
	
Verify that the user can delete a report
	sleep    3
	wait until screen contain    ${IMAGE_DIR}\\deleteButton1.PNG    300
	Click    ${IMAGE_DIR}\\deleteButton1.PNG
	sleep    5
	wait until screen contain    ${IMAGE_DIR}\\deleteButton2.PNG    300
	Click    ${IMAGE_DIR}\\deleteButton2.PNG
	screen should not contain    ${IMAGE_DIR}\\publicAccess.PNG
	
Execute the received iron python script  
    [Arguments]    ${TextFileContent}     ${ExecuteInTransaction}
    Click on element    ${IMAGE_DIR}\\FileMenu.PNG      ${IMAGE_DIR}\\DocumentProperties.PNG     3
    Click on element    ${IMAGE_DIR}\\DocumentProperties.PNG      ${IMAGE_DIR}\\PropertiesButton.PNG     3
    Click on element    ${IMAGE_DIR}\\PropertiesButton.PNG      ${IMAGE_DIR}\\ScriptButton.PNG     3
    Click on element    ${IMAGE_DIR}\\ScriptButton.PNG      ${IMAGE_DIR}\\checkbox.PNG     3
    Click on element    ${IMAGE_DIR}\\checkbox.PNG      ${IMAGE_DIR}\\newButton.PNG     3
    Click on element    ${IMAGE_DIR}\\newButton.PNG      ${IMAGE_DIR}\\scriptTextArea.PNG     3
    Run Keyword If    ${ExecuteInTransaction}==False    Click    ${IMAGE_DIR}\\ExecuteInTransaction.PNG
    Sleep    2s
    Click    ${IMAGE_DIR}\\scriptTextArea.PNG
    Paste text    ${IMAGE_DIR}\\scriptTextArea1.PNG    ${TextFileContent}
    sleep    5
    Click    ${IMAGE_DIR}\\runScriptButton.PNG
    Sleep    180
    Capture Screen
    Sleep    10
    Wait until screen contain     ${IMAGE_DIR}\\CancelButton.PNG    300
    Click    ${IMAGE_DIR}\\CancelButton.PNG
    Sleep    5s
    Wait until screen contain     ${IMAGE_DIR}\\noActionRadio.PNG    300
    Click    ${IMAGE_DIR}\\noActionRadio.PNG
    Sleep    5s
    Wait until screen contain     ${IMAGE_DIR}\\OKButton.PNG    300
    Click    ${IMAGE_DIR}\\OKButton.PNG
    Sleep    20s
    Wait until screen contain     ${IMAGE_DIR}\\GeneralTab.PNG    300
    Click    ${IMAGE_DIR}\\GeneralTab.PNG
    Sleep    2s
    Wait until screen contain     ${IMAGE_DIR}\\OKButton.PNG    300
    Click    ${IMAGE_DIR}\\OKButton.PNG
    Sleep    8s
    Capture Screen
	
Verify that BusyHour is only visible for No aggregation
	sleep    2
	Wait until screen contain     ${IMAGE_DIR}\\busyHourDropDown.PNG    300
    Click    ${IMAGE_DIR}\\busyHourDropDown.PNG
    sleep    2
    Screen should contain     ${IMAGE_DIR}\\busyHourText.PNG
    sleep    2
    Wait until screen contain     ${IMAGE_DIR}\\objectAggregation.PNG    300
    Click    ${IMAGE_DIR}\\objectAggregation.PNG
    sleep    2
    Wait until screen contain     ${IMAGE_DIR}\\nodeObjectAggregation.PNG    300
    Click    ${IMAGE_DIR}\\nodeObjectAggregation.PNG
    sleep    2
	Wait until screen contain     ${IMAGE_DIR}\\busyHourDropDown.PNG    300
    Click    ${IMAGE_DIR}\\busyHourDropDown.PNG
    sleep    2
    Screen should not contain     ${IMAGE_DIR}\\busyHourText.PNG
    sleep    2
    Wait until screen contain     ${IMAGE_DIR}\\nodeSelectedOA.PNG    300
    Click    ${IMAGE_DIR}\\nodeSelectedOA.PNG
    sleep    2
    Wait until screen contain     ${IMAGE_DIR}\\allSelectedAggregation.PNG    300
    Click    ${IMAGE_DIR}\\allSelectedAggregation.PNG
    sleep    2
    Wait until screen contain     ${IMAGE_DIR}\\busyHourDropDown.PNG    300
    Click    ${IMAGE_DIR}\\busyHourDropDown.PNG
    sleep    2
    Screen should not contain     ${IMAGE_DIR}\\busyHourText.PNG
    
Verify that Preceding Period is selected in Time Period
	sleep    3
	screen should contain    ${IMAGE_DIR}\\preceedingPeriod1.PNG
	
Make selection in Aggregation
	[Arguments]    ${aggregation}
	sleep    2   
	IF    "${aggregation}" == "BusyHour"
		Wait until screen contain     ${IMAGE_DIR}\\busyHourDropDown.PNG    300
    	Click    ${IMAGE_DIR}\\busyHourDropDown.PNG
    	sleep    2
    	Click    ${IMAGE_DIR}\\busyHourText.PNG
    ELSE IF    "${aggregation}" == "Day"
    	Wait until screen contain     ${IMAGE_DIR}\\dayDropDown.PNG    300
    	Click    ${IMAGE_DIR}\\dayDropDown.PNG
    	sleep    2
    	Click    ${IMAGE_DIR}\\dayText.PNG
    ELSE IF    "${aggregation}" == "Hour"
    	Wait until screen contain     ${IMAGE_DIR}\\hourDropDown.PNG    300
    	Click    ${IMAGE_DIR}\\hourDropDown.PNG
    	sleep    2
    	Click    ${IMAGE_DIR}\\hourText.PNG
    ELSE IF    "${aggregation}" == "Month"
    	Wait until screen contain     ${IMAGE_DIR}\\monthDropDown.PNG    300
    	Click    ${IMAGE_DIR}\\monthDropDown.PNG
    	sleep    2
    	Click    ${IMAGE_DIR}\\monthText.PNG
    ELSE IF    "${aggregation}" == "ROP"
    	Wait until screen contain     ${IMAGE_DIR}\\ropDropDown.PNG    300
    	Click    ${IMAGE_DIR}\\ropDropDown.PNG
    	sleep    2
    	Click    ${IMAGE_DIR}\\ropText.PNG
    ELSE IF    "${aggregation}" == "Week"
    	Wait until screen contain     ${IMAGE_DIR}\\weekDropDown.PNG    300
    	Click    ${IMAGE_DIR}\\weekDropDown.PNG
    	sleep    2
    	Click    ${IMAGE_DIR}\\weekText.PNG
    END
    
Verify the range for
	[Arguments]    ${aggregate}
	sleep    2
	IF    "${aggregate}" == "BusyHour"
    	Wait until screen contain     ${IMAGE_DIR}\\timeRange.PNG    300
    	Click    ${IMAGE_DIR}\\timeRange.PNG
    	sleep    1
    	screen should contain     ${IMAGE_DIR}\\timeRangeVerify.PNG
    ELSE IF    "${aggregate}" == "Day"
    	Wait until screen contain     ${IMAGE_DIR}\\timeRange.PNG    300
    	Click    ${IMAGE_DIR}\\timeRange.PNG
    	sleep    1
    	screen should contain     ${IMAGE_DIR}\\timeRangeVerify1.PNG   
    ELSE IF    "${aggregate}" == "Hour" or "${aggregate}" == "ROP"	
    	Wait until screen contain     ${IMAGE_DIR}\\timeRange1.PNG    300
    	Click    ${IMAGE_DIR}\\timeRange1.PNG
    	sleep    1
    	screen should contain     ${IMAGE_DIR}\\timeRangeVerify2.PNG
    ELSE IF    "${aggregate}" == "Week"
    	Wait until screen contain     ${IMAGE_DIR}\\timeRange.PNG    300
    	Click    ${IMAGE_DIR}\\timeRange.PNG
    	sleep    1
    	screen should contain     ${IMAGE_DIR}\\timeRangeVerify4.PNG 
    END

########BUSY HOUR ENDS########


Go to Administration Page
	sleep    3
	Wait until screen contain     ${IMAGE_DIR}\\settingsButton.PNG    300
    Click    ${IMAGE_DIR}\\settingsButton.PNG
    
Verify that the following text is visible
	[Arguments]    ${text}
	sleep    10
	${verifyText}=    SikuliLibrary.Get Text    ${IMAGE_DIR}\\multiEniqVerification.PNG
	log    ${verifyText}
	[Return]    ${verifyText}
	should be equal    ${text}    ${verifyText}
	
Verify that the connection is successful
	sleep    3
	Screen should contain    ${IMAGE_DIR}\\connectionSuccessful.PNG
	
Verify that new data sources are visible in ENIQ DataSources table
	sleep    3
	Screen should contain    ${IMAGE_DIR}\\connectionVerification.PNG
	
Delete button should be visible
	sleep    3	
	Screen should contain    ${IMAGE_DIR}\\deleteButton.PNG
	
Select a data source from ENIQ DataSources table
	sleep    3
	Wait until screen contain     ${IMAGE_DIR}\\dataSrc.PNG    300
    Click    ${IMAGE_DIR}\\dataSrc.PNG
    
Verify that the selected data source has been deleted
	sleep    3
	Screen should contain    ${IMAGE_DIR}\\deletedSuccessfully.PNG
	
Open the table
	[Arguments]    ${tableName}    ${n}
	sleep    3
	Wait until screen contain    ${IMAGE_DIR}\\openNewPage.PNG    60
	click    ${IMAGE_DIR}\\openNewPage.PNG
	sleep    3
	Screen should contain    ${IMAGE_DIR}\\newPageVerification.PNG
	Wait until screen contain    ${IMAGE_DIR}\\startfromData.PNG    60
	Click    ${IMAGE_DIR}\\startFromData.PNG
	sleep    3
	screen should contain    ${IMAGE_DIR}\\dataInAnalysis.PNG
	sleep    3
	Click    ${IMAGE_DIR}\\tableDropDown.PNG
	FOR    ${i}    IN RANGE    0    ${n}
		Click    ${IMAGE_DIR}\\scrollDown.PNG
    END
    sleep    3		
	IF    "${tableName}" == "Modified Topology Data"
		Click    ${IMAGE_DIR}\\modifiedTopologyTable.PNG
	ELSE IF    "${tableName}" == "FDNSubnetworkList from ENIQ"
		Click    ${IMAGE_DIR}\\FDNSubnetworkListFromEniq.PNG
	END
	Click    ${IMAGE_DIR}\\startFromVisualizations.PNG
	sleep    2
	wait until screen contain    ${IMAGE_DIR}\\visualizations.PNG    10
	sleep    2
	Click    ${IMAGE_DIR}\\tableVisualization.PNG
	sleep    8
	IF    "${tableName}" == "Modified Topology Data"
		screen should contain    ${IMAGE_DIR}\\MDTVerification.PNG
	ELSE IF    "${tableName}" == "FDNSubnetworkList from ENIQ"
		screen should contain    ${IMAGE_DIR}\\FDNSubnetworkListVerification.PNG
	END
	
Verify that the new data sources are present in the table
	sleep    3
	Set ocr text read    True
    ${text}=    SikuliLibrary.Get text
    Log    ${text}
    [Return]    ${text}
    Should contain    ${text}     4068_ODBC
    
Verify that Select ENIQ DataSource is added as a drop down
    [Arguments]    ${status}
	sleep    3
	Wait until screen contain    ${IMAGE_DIR}\\createButton.PNG    300
	Click    ${IMAGE_DIR}\\createButton.PNG
	sleep    10
	screen should contain    ${IMAGE_DIR}\\eniqDSDropdown.PNG
	sleep    2
	IF    "${status}" == "0"
	    Click    ${IMAGE_DIR}\\reportManagerTab.PNG
	END
	
Select a report and click on edit
	sleep    3
	Wait until screen contain    ${IMAGE_DIR}\\publicAccess.PNG    300
	Click    ${IMAGE_DIR}\\publicAccess.PNG
	wait until screen contain    ${IMAGE_DIR}\\editButton.PNG    300
	Click    ${IMAGE_DIR}\\editButton.PNG
	wait until screen contain    ${IMAGE_DIR}\\editPage.PNG    300
	sleep    30

ENIQ DataSource drop down should be present
	sleep    10
	screen should contain    ${IMAGE_DIR}\\selectENIQDS.PNG
	
Open Report Manager
	sleep    3
	Wait until screen contain    ${IMAGE_DIR}\\ReportManagerButton.PNG    300
	Click    ${IMAGE_DIR}\\ReportManagerButton.PNG
	
Verify that ENIQName is added as a column in the Reports Table
	sleep    10
	screen should contain    ${IMAGE_DIR}\\eniqNameColumn.PNG
	
Open Data tab and verify the connection string
	sleep    3
	Click on element    ${IMAGE_DIR}\\dataButton.PNG      ${IMAGE_DIR}\\dataTableProperties.PNG     3
	CLick on element    ${IMAGE_DIR}\\dataTableProperties.PNG    ${IMAGE_DIR}\\sourceVerificationTable.PNG    3
	CLick     ${IMAGE_DIR}\\sourceVerificationTable.PNG
	Wait until screen contain    ${IMAGE_DIR}\\sourceInformationTab.PNG    300
	Click    ${IMAGE_DIR}\\sourceInformationTab.PNG
	sleep    15
	screen should contain    ${IMAGE_DIR}\\sourceVerification.PNG
	sleep    10
	Wait until screen contain    ${IMAGE_DIR}\\OKButton.PNG    300
	Click    ${IMAGE_DIR}\\OKButton.PNG
	
Save the Report and verify the data source in page title
	sleep    3
	wait until screen contain     ${IMAGE_DIR}\\FileMenu.PNG    300
	Click    ${IMAGE_DIR}\\FileMenu.PNG
	sleep    3
	wait until screen contain     ${IMAGE_DIR}\\saveButton.PNG    300
	Click      ${IMAGE_DIR}\\saveButton.PNG
	sleep    20
	wait until screen contain    ${IMAGE_DIR}\\FileMenu.PNG    300
	Click    ${IMAGE_DIR}\\FileMenu.PNG
	sleep    5
	wait until screen contain    ${IMAGE_DIR}\\openButton.PNG    300
	Click    ${IMAGE_DIR}\\openButton.PNG
	sleep    3
	wait until screen contain    ${IMAGE_DIR}\\analysisOpen.PNG    300
	Click     ${IMAGE_DIR}\\analysisOpen.PNG
	sleep    3
	wait until screen contain    ${IMAGE_DIR}\\dataSource.PNG    300
	sleep    10
	
Close the report
	sleep    10
	wait until screen contain    ${IMAGE_DIR}\\closeButton.PNG    300
	Click    ${IMAGE_DIR}\\closeButton.PNG
	wait until screen contain    ${IMAGE_DIR}\\OKButton2.PNG    300
	Click    ${IMAGE_DIR}\\OKButton2.PNG
	
Open Collection Manager
	sleep    3
	wait until screen contain    ${IMAGE_DIR}\\collectionManager.PNG    300
	Click    ${IMAGE_DIR}\\collectionManager.PNG
	sleep    5
	screen should contain    ${IMAGE_DIR}\\createButton
	
Click on create and verify that Select ENIQ Datasource is a dropdown
	sleep    3
	Click    ${IMAGE_DIR}\\createButton
	sleep    5
	wait until screen contain    ${IMAGE_DIR}\\selectENIQDSCollectionManager.PNG    300
	Click    ${IMAGE_DIR}\\selectENIQDSCollectionManager.PNG
	sleep    3
	screen should contain    ${IMAGE_DIR}\\DSVerification.PNG
	sleep    3
	Click    ${IMAGE_DIR}\\cancelButton2.PNG
	
Select a Report and Click on edit in collection manager
	sleep    3
	Click    ${IMAGE_DIR}\\savedReport.PNG
	sleep    3
	wait until screen contain    ${IMAGE_DIR}\\editButton.PNG    300
	Click    ${IMAGE_DIR}\\editButton.PNG
	
Verify that Collection Name, System Area, Node Type will be uneditable" is visible in the page
    sleep    3
	screen should contain    ${IMAGE_DIR}\\constantWarning.PNG
	
Verify that the deactivated table is not present in the Modified Topology Data Table
	sleep    3
	screen should not contain    ${IMAGE_DIR}\\DC_E_IPTRANSPORT.PNG

Get iron_python script for import file
    [Arguments]    ${Filepath}    ${data}
    ${TextFileContent}=     OperatingSystem.Get File    ${Filepath}
    ${str1} =	Replace String	    ${TextFileContent}	   SYS_AREA   	${data}[System_Area]
    ${str2} =	Replace String	    ${str1}    Collection_Name   	${data}[Collection_Name]
    ${str3} =	Replace String	    ${str2}	   ENIQ_DB   	${data}[ENIQ_DB]
    ${str4} =	Replace String	    ${str3}	   NODE_TYPE   	${data}[Node_type]
    Log       ${str4} 
    [Return]     ${str4}
    
Execute iron python script for import file 
    [Arguments]    ${TextFileContent}     ${ExecuteInTransaction}
    Click on element    ${IMAGE_DIR}\\FileMenu.PNG      ${IMAGE_DIR}\\DocumentProperties.PNG     3
    Click on element    ${IMAGE_DIR}\\DocumentProperties.PNG      ${IMAGE_DIR}\\PropertiesButton.PNG     3
    Click on element    ${IMAGE_DIR}\\PropertiesButton.PNG      ${IMAGE_DIR}\\ScriptButton.PNG     3
    Click on element    ${IMAGE_DIR}\\ScriptButton.PNG      ${IMAGE_DIR}\\checkbox.PNG     3
    Click on element    ${IMAGE_DIR}\\checkbox.PNG      ${IMAGE_DIR}\\newButton.PNG     3
    #Click	${IMAGE_DIR}\\selectscript.PNG
    #Sleep	10s
    #Click on element    ${IMAGE_DIR}\\editButton.PNG      ${IMAGE_DIR}\\scriptTextArea.PNG     3
    Click on element    ${IMAGE_DIR}\\newButton.PNG      ${IMAGE_DIR}\\scriptTextArea.PNG     3
    #${TextFileContent}=     Get File    ${Filepath} 
    Run Keyword If    ${ExecuteInTransaction}==False    Click    ${IMAGE_DIR}\\ExecuteInTransaction.PNG
    Sleep    2s
    Click    ${IMAGE_DIR}\\scriptTextArea.PNG
    Paste text    ${IMAGE_DIR}\\scriptTextArea1.PNG    ${TextFileContent}
    Click    ${IMAGE_DIR}\\runScriptButton.PNG 
    Sleep    180s
    #Click    ${IMAGE_DIR}\\ImportFile.PNG
    #Sleep    10s
    #Click    ${IMAGE_DIR}\\Open.PNG
    Wait until screen contain     ${IMAGE_DIR}\\OutputOK1.PNG    1310
    Sleep    30s
    Click    ${IMAGE_DIR}\\CancelButton.PNG
    Sleep    20s
    Click    ${IMAGE_DIR}\\NOActionButton.PNG
    Sleep    20s
    Click    ${IMAGE_DIR}\\OKButton.PNG
    Sleep    20s
    Click    ${IMAGE_DIR}\\GeneralTab.PNG
    Sleep    10s
    Click    ${IMAGE_DIR}\\OKButton.PNG
    Sleep    10s
    Capture Screen
    
Click on Collection Manager
    Click    ${IMAGE_DIR}\\CollectionManager1.PNG
    Sleep    5s
    Wait until screen contain     ${IMAGE_DIR}\\CreateButton.PNG    300
    Sleep    5s
    Click    ${IMAGE_DIR}\\CreateButton2.PNG
    Capture Screen
    Wait until screen contain     ${IMAGE_DIR}\\NodeSelectionManager.PNG    300
    Sleep    5s
    
Click on Node Collection Manager
    Click    ${IMAGE_DIR}\\NodeCollectionManager.PNG
    Sleep    5s
    Wait until screen contain     ${IMAGE_DIR}\\CreateButton2.PNG    300
    Sleep    5s
    Click    ${IMAGE_DIR}\\CreateButton2.PNG
    Capture Screen
    Wait until screen contain     ${IMAGE_DIR}\\NodeSelectionManager.PNG    300
    Sleep    5s
    
Click on Save Button
    Click    ${IMAGE_DIR}\\SaveButton1.PNG
    Sleep    5s
    
Click on Create Button   
    Click    ${IMAGE_DIR}\\CreateButton1.PNG
    Sleep    5s
	
###################PMEXUSE case####################
	 
Verify the report is saved to the DB
    [Arguments]       ${dbReportName}     ${clientReportName}
    Log    ${dbReportName}
    Log    ${clientReportName}
    Should Be Equal    ${dbReportName}    ${clientReportName} 

Execute iron python script for pmexusecase 
    [Arguments]    ${TextFileContent}     ${ExecuteInTransaction}
    Click on element    ${IMAGE_DIR}\\FileMenu.PNG      ${IMAGE_DIR}\\DocumentProperties.PNG     3
    Click on element    ${IMAGE_DIR}\\DocumentProperties.PNG      ${IMAGE_DIR}\\PropertiesButton.PNG     3
    Click on element    ${IMAGE_DIR}\\PropertiesButton.PNG      ${IMAGE_DIR}\\ScriptButton.PNG     3
    Click on element    ${IMAGE_DIR}\\ScriptButton.PNG      ${IMAGE_DIR}\\checkbox.PNG     3
    Click on element    ${IMAGE_DIR}\\checkbox.PNG      ${IMAGE_DIR}\\newButton.PNG     3
    Click on element    ${IMAGE_DIR}\\newButton.PNG      ${IMAGE_DIR}\\scriptTextArea.PNG     3
    #${TextFileContent}=     Get File    ${Filepath} 
    Run Keyword If    ${ExecuteInTransaction}==False    Click    ${IMAGE_DIR}\\ExecuteInTransaction.PNG
    Sleep    2s
    Click    ${IMAGE_DIR}\\scriptTextArea.PNG
    Paste text    ${IMAGE_DIR}\\scriptTextArea1.PNG    ${TextFileContent}
    Click on element    ${IMAGE_DIR}\\runScriptButton.PNG      ${IMAGE_DIR}\\scriptTextArea.PNG     3     160
    Sleep    50s
    Wait until screen contain     ${IMAGE_DIR}\\OutputOkNew.PNG    1910
    Capture Screen
    Sleep    50s
    Click    ${IMAGE_DIR}\\CancelButton.PNG
    Sleep    30s
    Click    ${IMAGE_DIR}\\CancelButton.PNG
    Sleep    10s
    #Click    ${IMAGE_DIR}\\OKButton.PNG
    #Sleep    25s
    Click    ${IMAGE_DIR}\\GeneralTab.PNG
    Sleep    2s
    Click    ${IMAGE_DIR}\\OKButton.PNG
    Sleep    8s
    Capture Screen		   

Execute iron python script for pmex
    [Arguments]    ${TextFileContent}     ${ExecuteInTransaction}
    Click on element    ${IMAGE_DIR}\\FileMenu.PNG      ${IMAGE_DIR}\\DocumentProperties.PNG     3
    Click on element    ${IMAGE_DIR}\\DocumentProperties.PNG      ${IMAGE_DIR}\\PropertiesButton.PNG     3
    Click on element    ${IMAGE_DIR}\\PropertiesButton.PNG      ${IMAGE_DIR}\\ScriptButton.PNG     3
    Click on element    ${IMAGE_DIR}\\ScriptButton.PNG      ${IMAGE_DIR}\\checkbox.PNG     3
    Click on element    ${IMAGE_DIR}\\checkbox.PNG      ${IMAGE_DIR}\\newButton.PNG     3
    Click on element    ${IMAGE_DIR}\\newButton.PNG      ${IMAGE_DIR}\\scriptTextArea.PNG     3
    #${TextFileContent}=     Get File    ${Filepath} 
    Run Keyword If    ${ExecuteInTransaction}==False    Click    ${IMAGE_DIR}\\ExecuteInTransaction.PNG
    Sleep    2s
    Click    ${IMAGE_DIR}\\scriptTextArea.PNG
    Paste text    ${IMAGE_DIR}\\scriptTextArea1.PNG    ${TextFileContent}
    Click    ${IMAGE_DIR}\\runScriptButton.PNG      
    Sleep    50s
    Wait until screen contain     ${IMAGE_DIR}\\OutputOkNew.PNG    1910
    Capture Screen
    Sleep    50s
    Click    ${IMAGE_DIR}\\CancelButton.PNG
    Sleep    30s
    Click    ${IMAGE_DIR}\\CancelButton.PNG
    Sleep    10s
    #Click    ${IMAGE_DIR}\\OKButton.PNG
    #Sleep    25s
    Click    ${IMAGE_DIR}\\GeneralTab.PNG
    Sleep    2s
    Click    ${IMAGE_DIR}\\OKButton.PNG
    Sleep    8s
    Capture Screen
	
Get iron_python script by passing project location for pmex usecase						  
    [Arguments]    ${Filepath}    ${data}    ${projLoc}		${uniqueIDCol}
    ${TextFileContent}=     OperatingSystem.Get File    ${Filepath}
    ${str} =	Replace String	    ${TextFileContent}	   SYS_AREA   	${data}[System_area]
    ${str1} =	Replace String	    ${str}	   NODE_TYPE   	${data}[Node_type]
    ${str2} =	Replace String	    ${str1}	   KPI_USED   	${data}[Measure]
    ${str3} =	Replace String	    ${str2}	   NODE_USED   	${data}[Node]
    ${str4} =	Replace String	    ${str3}	   PROJ_LOC   	${projLoc}
    ${str5} =	Replace String	    ${str4}	   UNIQUE_COL   	${uniqueIDCol}
    ${str6} =	Replace String	    ${str5}	   NODE_COLLECTION   	${data}[Node_Collection]
    ${str7} =	Replace String	    ${str6}	   OBJECT_AGGREGATION   	${data}[Object_Aggregation]
    ${str8} =	Replace String	    ${str7}	   PRECEDINGPERIODS   	${data}[Preceding_period]
    ${str9} =	Replace String	    ${str8}	   PRECEDING_PERIODS_UNITS   	${data}[Preceding_period_unit]
    ${str10} =	Replace String	    ${str9}	   AGGREGATION_SELECTION   	${data}[Aggregation]
    ${str11} =	Replace String	    ${str10}	   TIME_SELECTOR     	${data}[Time_selector]
    ${str12} =	Replace String	    ${str11}	   START_DATE   	${data}[start_date]
    ${str13} =	Replace String	    ${str12}	   START_TIME   	${data}[start_time]
    ${str14} =	Replace String	    ${str13}	   END_DATE   	${data}[end_date]
    ${str15} =	Replace String	    ${str14}	   END_TIME   	${data}[end_time]
    ${str16} =	Replace String	    ${str15}	   REPORT_ACCESSTYPE   	${data}[Report_AccessType]
    ${str17} =	Replace String	    ${str16}	   REPORT_DESCRIPTION   	${data}[Report_Description]
    Log       ${str17}
    [Return]     ${str17}
    
Get iron_python script by passing project location for pmex usecase2						  
    [Arguments]    ${Filepath}    ${data}    ${projLoc}		${uniqueIDCol}
    ${TextFileContent}=     OperatingSystem.Get File    ${Filepath}
    ${str} =	Replace String	    ${TextFileContent}	   SYS_AREA   	${data}[System_area]
    ${str1} =	Replace String	    ${str}	   NODE_TYPE   	${data}[Node_type]
    ${str2} =	Replace String	    ${str1}	   KPI_USED   	${data}[Measure]
    ${str3} =	Replace String	    ${str2}	   NODE_USED   	${data}[Node]
    ${str4} =	Replace String	    ${str3}	   PROJ_LOC   	${projLoc}
    ${str5} =	Replace String	    ${str4}	   DATA_OF_COL1   	${data}[Data_Of_Col1]
    ${str6} =	Replace String	    ${str5}	   NODE_COLLECTION   	${data}[GetDataFor]
    ${str7} =	Replace String	    ${str6}	   OBJECT_AGGREGATION   	${data}[Object_Aggregation]
    ${str8} =	Replace String	    ${str7}	   PRECEDINGPERIODS   	${data}[Preceding_period]
    ${str9} =	Replace String	    ${str8}	   PRECEDING_PERIODS_UNITS   	${data}[Preceding_period_unit]
    ${str10} =	Replace String	    ${str9}	   AGGREGATION_SELECTION   	${data}[Aggregation]
    ${str11} =	Replace String	    ${str10}	   TIME_SELECTOR     	${data}[Time_selector]
    ${str12} =	Replace String	    ${str11}	   START_DATE   	${data}[start_date]
    ${str13} =	Replace String	    ${str12}	   START_TIME   	${data}[start_time]
    ${str14} =	Replace String	    ${str13}	   END_DATE   	${data}[end_date]
    ${str15} =	Replace String	    ${str14}	   END_TIME   	${data}[end_time]
    ${str16} =	Replace String	    ${str15}	   REPORT_ACCESSTYPE   	${data}[Report_AccessType]
    ${str17} =	Replace String	    ${str16}	   REPORT_DESCRIPTION   	${data}[Report_Description]
    ${str18} =	Replace String	    ${str17}	   DATA_OF_COL2   	${data}[Data_Of_Col2]
    ${str19} =	Replace String	    ${str18}	   ENIQ_DATASOURCE   	${data}[Data_source]
    ${str20} =	Replace String	    ${str19}	   TIMESELECTOR2   	${data}[Time_selector2]
    ${str21} =	Replace String	    ${str20}	   CHECK_BOX   	${data}[Check_Box]
    ${str22} =	Replace String	    ${str21}	   SUB_NETWORK   	${data}[SubNetwork] 
    ${str23} =	Replace String	    ${str22}	   WEEK_DAYS   	${data}[Days] 
    ${str24} =	Replace String	    ${str23}	   MEASURE_TYPE   	${data}[Measure_type]
    Log       ${str24}
    [Return]     ${str24}

Get iron_python script by passing project location for pmex report creation collection						  
    [Arguments]    ${Filepath}    ${data}    ${projLoc}		${uniqueIDCol}
    ${TextFileContent}=     OperatingSystem.Get File    ${Filepath}
    ${str} =	Replace String	    ${TextFileContent}	   SYS_AREA   	${data}[System_area]
    ${str1} =	Replace String	    ${str}	   NODE_TYPE   	${data}[Node_type]
    ${str2} =	Replace String	    ${str1}	   KPI_USED   	${data}[Measure]
    ${str3} =	Replace String	    ${str2}	   NODE_USED   	${data}[Node]
    ${str4} =	Replace String	    ${str3}	   PROJ_LOC   	${projLoc}
    ${str5} =	Replace String	    ${str4}	   DATA_OF_COL1   	${data}[Data_Of_Col1]
    ${str6} =	Replace String	    ${str5}	   NODE_COLLECTION   	${data}[GetDataFor]
    ${str7} =	Replace String	    ${str6}	   OBJECT_AGGREGATION   	${data}[Object_Aggregation]
    ${str8} =	Replace String	    ${str7}	   PRECEDINGPERIODS   	${data}[Preceding_period]
    ${str9} =	Replace String	    ${str8}	   PRECEDING_PERIODS_UNITS   	${data}[Preceding_period_unit]
    ${str10} =	Replace String	    ${str9}	   AGGREGATION_SELECTION   	${data}[Aggregation]
    ${str11} =	Replace String	    ${str10}	   TIME_SELECTOR     	${data}[Time_selector]
    ${str12} =	Replace String	    ${str11}	   START_DATE   	${data}[start_date]
    ${str13} =	Replace String	    ${str12}	   START_TIME   	${data}[start_time]
    ${str14} =	Replace String	    ${str13}	   END_DATE   	${data}[end_date]
    ${str15} =	Replace String	    ${str14}	   END_TIME   	${data}[end_time]
    ${str16} =	Replace String	    ${str15}	   REPORT_ACCESSTYPE   	${data}[Report_AccessType]
    ${str17} =	Replace String	    ${str16}	   REPORT_DESCRIPTION   	${data}[Report_Description]
    ${str18} =	Replace String	    ${str17}	   DATA_OF_COL2   	${data}[Data_Of_Col2]
    ${str19} =	Replace String	    ${str18}	   ENIQ_DATASOURCE   	${data}[Data_source]
    ${str20} =	Replace String	    ${str19}	   TIME_SELECTOR2   	${data}[Time_selector2]
    ${str21} =	Replace String	    ${str20}	   CHECK_BOX   	${data}[Check_Box]
    ${str22} =	Replace String	    ${str21}	   SUB_NETWORK   	${data}[SubNetwork]
    ${str23} =	Replace String	    ${str22}	   SINGLEORCOLLECTION      	${data}[Single_node_or_collection]
    ${str24} =	Replace String	    ${str23}	   COLLECTION_NAME   	${data}[CollectionName]
    ${str25} =	Replace String	    ${str24}	   WILD_CARD   	   ${data}[Wild_card]  
    Log       ${str25}
    [Return]     ${str25}
    
	
Verify the selected node,node type and measure or kpi are displayed in the data from ENIQ
    [Arguments]      ${data}    ${dataFromPMdataFetch}		
    ${columnValues}=    Split String     ${dataFromPMdataFetch}     Column:
	FOR    ${ele}    IN    @{columnValues}
		${nodetypePresent}  ${value}=  Run Keyword And Ignore Error  Should Contain   ${ele}      ${data}[Node_type] 
		IF  	'${nodetypePresent}'=='PASS'
			${nodePresent}  ${value2}=  Run Keyword And Ignore Error  Should Contain   ${ele}      ${data}[Node] 		
			BREAK 
		END	 
    END	
    Should contain    ${nodetypePresent}	   PASS
    Should contain    ${nodePresent}	   PASS		
    ${measurePresent}=   Evaluate             "".join(${columnValues})
    Should contain  ${measurePresent}   ${data}[Measure]   
				  
    
Verify the title with respect to the aggregation inputs   
	[Arguments]     ${data}     ${data_source}    ${title}  
    Should contain    ${title}    ${data_source}
    IF    "${data}[Aggregation]"=="ROP"
        Should contain    ${title}    RAW
    ELSE IF   "${data}[Aggregation]"=="DAY"
        Should contain    ${title}    DAY
    ELSE IF   "${data}[Aggregation]"=="HOUR"
        Should contain    ${title}    HOUR
    END
    
Verify report name, access type, description, reportTableList, ENIQName, tables added to report are displayed in Report Manager GUI 
    [Arguments]      ${data}    ${reportDetailsfromClient}	  ${reportName}   ${reportdesc}		${title}
    ${reportDetails}=    Split String     ${reportDetailsfromClient}     Column:
    ${reportAccessPresent}=    set variable     FAIL
    ${reportNamePresent}=    set variable     FAIL
    ${reportDescPresent}=    set variable     FAIL
    ${reportTableListPresent}=    set variable     FAIL
    ${ENIQNamePresent}=    set variable     FAIL
    FOR    ${ele}    IN    @{reportDetails}	
    	${accessTypeColumn}  ${value}=  Run Keyword And Ignore Error  Should Contain   ${ele}      ReportAccess
    	IF 		'${accessTypeColumn}' =='PASS'
    		${reportAccessPresent}  ${value1}=  Run Keyword And Ignore Error  Should contain    ${ele}	   ${data}[Report_AccessType] 
			Continue For Loop
		END
		${reportNameColumn}  ${value}=  Run Keyword And Ignore Error  Should Contain   ${ele}      ReportName
    	IF 		'${reportNameColumn}' =='PASS'
    		${reportNamePresent}  ${value2}=  Run Keyword And Ignore Error  Should contain    ${ele}	   ${reportName}
			Continue For Loop
		END
		${reportDescColumn}  ${value}=  Run Keyword And Ignore Error  Should Contain   ${ele}      ReportDescription
    	IF 		'${reportDescColumn}' =='PASS'
    		${reportDescPresent}  ${value2}=  Run Keyword And Ignore Error  Should contain    ${ele}	   ${reportdesc}
			Continue For Loop
		END
		${reportTableListColumn}  ${value}=  Run Keyword And Ignore Error  Should Contain   ${ele}     ReportTableList
    	IF 		'${reportTableListColumn}' =='PASS'
    		${reportTableListPresent}  ${value2}=  Run Keyword And Ignore Error  Should contain    ${ele}	   ${title}
			Continue For Loop
		END
		${ENIQNameColumn}  ${value}=  Run Keyword And Ignore Error  Should Contain   ${ele}      ENIQName
    	IF 		'${ENIQNameColumn}' =='PASS'
    		${ENIQNamePresent}  ${value2}=  Run Keyword And Ignore Error  Should contain    ${ele}	   NetAn_ODBC
			Continue For Loop
		END
	END
	Should contain    ${reportAccessPresent}	   PASS
	Should contain    ${reportNamePresent}	   PASS
	Should contain    ${reportDescPresent}	   PASS
	Should contain    ${reportTableListPresent}	   PASS
	Should contain    ${ENIQNamePresent}	   PASS

get the user inputs report name and description
	[Arguments]      ${reportNameDesc}   
	${nameAndDesc}=    Split String     ${reportNameDesc} 
	${name}=    Get From List    ${nameAndDesc}    0  
	${desc}=    Get From List    ${nameAndDesc}    1
    [Return]     ${name}	${desc}
	
Verify Dataintegrity of the Measure from client
      [Arguments]      ${data}      ${colValue1}     ${colValue2}     ${formula}     ${measure_value}
      ${val}=     set variable    ${formula}
      ${str} =	Replace String	    ${val}	   ${data}[Data_Of_Col1]   	${colValue1} 
      ${str2} =	Replace String	    ${str}	   ${data}[Data_Of_Col2]   	${colValue2}         
      ${val}=     set variable    ${str2}
      Log     ${val}
      ${value}=     Evaluate    ${val}
      ${num}=    Convert To Number	    ${value}    2
      ${string_value}=      Convert To String      ${num}
      Should contain     ${string_value}      ${measure_value}

#################PMA Client USe case########################
	
    
Verify alarm state in DB
	 [Arguments]     ${alarm_name}    ${alarm_state}
     ${sql}=    set variable    select "AlarmState" from "tblAlarmDefinitions" where "AlarmName"='${alarm_name}'
     ${results}=  Query Postgre database and return output     ${sql}
     ${value}=    Get From List    ${results}     0
     Should contain    ${value}      ${alarm_state}    

Get iron_python script for PMA Alarm verification for usecase
    [Arguments]    ${Filepath}    ${data}	${projLoc}
    ${TextFileContent}=     OperatingSystem.Get File    ${Filepath}
    ${str} =	Replace String	    ${TextFileContent}	   SYS_AREA   	${data}[System_area]
    ${str1} =	Replace String	    ${str}	   NODE_TYPE   	${data}[Node_type]
    ${str2} =	Replace String	    ${str1}	   MEASURE_1   	${data}[Measure_1]
    ${str3} =	Replace String	    ${str2}	   NODE_USED   	${data}[Node]
    ${str4} =	Replace String	    ${str3}	   ALARM_NAME_VALUE   	${data}[Alarm_name]
    ${str5} =	Replace String	    ${str4}	   SINGLE_COLLECTION   	${data}[Single_node_or_collection]
    ${str6} =	Replace String	    ${str5}	   AGGREGATION_VALUE   	${data}[Aggregation]
    ${str7} =	Replace String	    ${str6}	   PROBABLE_CAUSE   	${data}[Probable_cause]
    ${str8} =	Replace String	    ${str7}	   SPECIFIC_PROBLEM   	${data}[Specific_problem]
    ${str9} =	Replace String	    ${str8}	   ALARM_TYPE   	${data}[Alarm_Type]
    ${str10} =	Replace String	    ${str9}	   MEASURE_TYPE   	${data}[Measure_type]
    ${str11} =	Replace String	    ${str10}	   ALARM_SEVERITY   	${data}[Alarm_severity]
    ${str12} =	Replace String	    ${str11}	   DATE_RANGE_VALUE   	${data}[Date_range_val]
    ${str13} =	Replace String	    ${str12}	   LOOK_BACK_PERIOD_VALUE   	${data}[LookBack_Period_val]
    ${str14} =	Replace String	    ${str13}	   ENIQ_DATASOURCE   	${data}[ENIQ_data_source]
    ${str15} =	Replace String	    ${str14}	   DATE_RANGE_UNIT   	${data}[Date_range_unit]
    ${str16} =	Replace String	    ${str15}	   LOOK_BACK_PERIOD_UNIT   	${data}[LookBack_Period_unit]
    ${str17} =	Replace String	    ${str16}	   MEASURE_2   	${data}[Measure_2]
    ${str18} =	Replace String	    ${str17}	   MEASURE_3   	${data}[Measure_3]
    ${str19} =	Replace String	    ${str18}	   MEASURE_4   	${data}[Measure_4]
    ${str20} =	Replace String	    ${str19}	   PROJ_LOC   	${projLoc}
    ${str21} =	Replace String	    ${str20}	   DELETE_ALARM   	${data}[Delete_alarm]
    ${str22} =	Replace String	    ${str21}	   UNIQUE_COL   	${data}[uniqueIDCol]
    ${str23} =	Replace String	    ${str22}	   NODE_COLLECTION   	${data}[Node_Collection]
    ${str24} =	Replace String	    ${str23}	   SUB_NETWORK   	${data}[Subnetwork]
    ${str25} =	Replace String	    ${str24}	   MEASURETYPE2   	${data}[Measure_type2]
    ${str26} =	Replace String	    ${str25}	   COUNTER_1   	${data}[Counter_1]
    Log     ${str26}
    [Return]     ${str26}
    
Verify alarm title 
	[Arguments]     ${alarmNameInput}    ${alarmTitle}
    Should contain    ${alarmNameInput}      ${alarmTitle}
     
Verify alarm type 
	[Arguments]     ${alarmTypeConfig}    ${alarmType}
    Should contain    ${alarmTypeConfig}      ${alarmType}         
    
Verify columns displayed in spotfire
	[Arguments]     ${columnsConfig}    ${columnsDisplayed} 
	${columnsConfig}=    Split String     ${columnsConfig}    , 
	Log   ${columnsConfig}
	#${columnsDisplayed}=    Split String     ${columnsDisplayed}     Column:
	Log 	${columnsDisplayed}
	FOR    ${ele}    IN    @{columnsConfig}
		${columnPresent}=   set variable  FAIL
		${columnPresent}  ${value}=  Run Keyword And Ignore Error  Should Contain   ${columnsDisplayed}      ${ele} 
		END	
    Should contain     	${columnPresent}   PASS	 
		

Verify alarm state in spotfire
   [Arguments]     ${columnValues}    ${expectedState}
   ${rowValuesOfReport}=    Split String     ${columnValues}     Column:
   FOR    ${ele}    IN    @{rowValuesOfReport}
		${nodetypePresent}  ${value}=  Run Keyword And Ignore Error  Should Contain   ${ele}      AlarmState 
		IF  	'${nodetypePresent}'=='PASS'
			${InactiveStatePresent}  ${value2}=  Run Keyword And Ignore Error  Should Contain   ${ele}      Inactive 		
			BREAK 
		END	 
    END	
   	Should contain    ${InactiveStatePresent}	   PASS
   
Verify alarm state in spotfire after activating the alarm 
	[Arguments]     ${alarmState}    ${expectedStateAfterActivatingAlarm}
    Should Be Equal    ${alarmState}      ${expectedStateAfterActivatingAlarm} 

Execute iron python script for pma use case
    [Arguments]    ${TextFileContent}     ${ExecuteInTransaction}
    Click on element    ${IMAGE_DIR}\\FileMenu.PNG      ${IMAGE_DIR}\\DocumentProperties.PNG     3
    Click on element    ${IMAGE_DIR}\\DocumentProperties.PNG      ${IMAGE_DIR}\\PropertiesButton.PNG     3
    Click on element    ${IMAGE_DIR}\\PropertiesButton.PNG      ${IMAGE_DIR}\\ScriptButton.PNG     3
    Click on element    ${IMAGE_DIR}\\ScriptButton.PNG      ${IMAGE_DIR}\\checkbox.PNG     3
    Click on element    ${IMAGE_DIR}\\checkbox.PNG      ${IMAGE_DIR}\\newButton.PNG     3
    Click on element    ${IMAGE_DIR}\\newButton.PNG      ${IMAGE_DIR}\\scriptTextArea.PNG     3
    #${TextFileContent}=     Get File    ${Filepath} 
    Sleep    2s
    Run Keyword If    ${ExecuteInTransaction}==False    Click    ${IMAGE_DIR}\\ExecuteInTransaction.PNG
    Sleep    7s
    Click    ${IMAGE_DIR}\\scriptTextArea.PNG
    Paste text    ${IMAGE_DIR}\\scriptTextArea1.PNG    ${TextFileContent}
    Click on element    ${IMAGE_DIR}\\runScriptButton.PNG      ${IMAGE_DIR}\\scriptTextArea.PNG     3     180
    Wait until screen contain     ${IMAGE_DIR}\\OutputOK.PNG     2040
    Capture Screen
    Sleep    300s
    Click    ${IMAGE_DIR}\\CancelButton.PNG
    Sleep    20s
    Click    ${IMAGE_DIR}\\CancelButton.PNG
    Sleep    10s
    #Click    ${IMAGE_DIR}\\OKButton.PNG
    Sleep    20s
    Click    ${IMAGE_DIR}\\GeneralTab.PNG
    Sleep    20s
    Click    ${IMAGE_DIR}\\OKButton.PNG
    Sleep    8s
    Capture Screen		

#### Flex+Vector ####

Open Custom KPI Manager
	AutoItLibrary.Run    C:\\Program Files (x86)\\TIBCO\\Spotfire\\10.10.1\\Spotfire.Dxp /server:"https://localhost/" /username:Administrator /password:Ericsson\\"01 /file:${dxp_file_loc}/Custom_KPI_Manager.dxp
    Wait until screen contain     ${IMAGE_DIR}\\certificate.PNG    300
    Click    ${IMAGE_DIR}\\certificateYes.PNG
    Sleep    5s
    Wait until screen contain     ${IMAGE_DIR}\\dontInstall.PNG    300
    Click    ${IMAGE_DIR}\\dontInstall.PNG
    Control Click    Security Alert    ${EMPTY}    Button4    left    1    0    0
    sleep    15
    Wait until screen contain     ${IMAGE_DIR}\\customKPIManager.PNG    300
    Sleep    3
    Capture Screen
    
Click on Load KPIs Button
	sleep    3
	Wait until screen contain     ${IMAGE_DIR}\\loadKPIs.PNG    300
    Click    ${IMAGE_DIR}\\loadKPIs.PNG
    sleep    3
    
Select the CSV file with KPI Details 
	sleep    3
	[Arguments]    ${file}
	IF    "${file}" == "1"
		Wait until screen contain     ${IMAGE_DIR}\\testingCSV_1.PNG    300
    	Click    ${IMAGE_DIR}\\testingCSV_1.PNG
    	sleep    2
    	Wait until screen contain     ${IMAGE_DIR}\\openButton1.PNG    300
    	Click    ${IMAGE_DIR}\\openButton1.PNG
    ELSE IF    "${file}" == "2"
		Wait until screen contain     ${IMAGE_DIR}\\testingCSV_2.PNG    300
    	Click    ${IMAGE_DIR}\\testingCSV_2.PNG
    	sleep    2
    	Wait until screen contain     ${IMAGE_DIR}\\openButton1.PNG    300
    	Click    ${IMAGE_DIR}\\openButton1.PNG
    END
    sleep    3
    
Verify that FlexFilterValues is added as a column in KPI List page
	sleep    3
	Wait until screen contain     ${IMAGE_DIR}\\kpiYes.PNG    300
    Click    ${IMAGE_DIR}\\kpiYes.PNG
    sleep    3
    Wait until screen contain     ${IMAGE_DIR}\\kpiOK.PNG    300
    Click    ${IMAGE_DIR}\\kpiOK.PNG
    sleep    5
	Wait until screen contain     ${IMAGE_DIR}\\KPIList.PNG    300
	sleep    2
	screen should contain    ${IMAGE_DIR}\\flexFilterValueVerification.PNG
	
Verify that KPI is not generated and has errors in Error logs
	sleep    3
	Wait until screen contain     ${IMAGE_DIR}\\KPIList.PNG    300
	sleep    2
	screen should contain    ${IMAGE_DIR}\\ErrorLog.PNG
	
Verify that KPI is generated and has no errors in Error logs
	sleep    3
	Wait until screen contain     ${IMAGE_DIR}\\KPIList.PNG    300
	sleep    2
	screen should not contain    ${IMAGE_DIR}\\ErrorLog.PNG


Close the Custom KPI Manager Application
    Capture page screenshot
    AutoItLibrary.ProcessClose      Custom_KPI_Manager.Dxp.exe
    AutoItLibrary.ProcessClose      Spotfire.Dxp.exe 
    OperatingSystem.Run    taskkill /f /im Spotfire.dxp.exe
    Sleep    10s
 

    
Execute iron python script for flex+vector counter 
    [Arguments]    ${TextFileContent}     ${ExecuteInTransaction}
    Click on element    ${IMAGE_DIR}\\FileMenu.PNG      ${IMAGE_DIR}\\DocumentProperties.PNG     3
    Click on element    ${IMAGE_DIR}\\DocumentProperties.PNG      ${IMAGE_DIR}\\PropertiesButton.PNG     3
    Click on element    ${IMAGE_DIR}\\PropertiesButton.PNG      ${IMAGE_DIR}\\ScriptButton.PNG     3
    Click on element    ${IMAGE_DIR}\\ScriptButton.PNG      ${IMAGE_DIR}\\checkbox.PNG     3
    Click on element    ${IMAGE_DIR}\\checkbox.PNG      ${IMAGE_DIR}\\newButton.PNG     3
    Click on element    ${IMAGE_DIR}\\newButton.PNG      ${IMAGE_DIR}\\scriptTextArea.PNG     3
    Run Keyword If    ${ExecuteInTransaction}==False    Click    ${IMAGE_DIR}\\ExecuteInTransaction.PNG
    Sleep    2s
    Click    ${IMAGE_DIR}\\scriptTextArea.PNG
    Paste text    ${IMAGE_DIR}\\scriptTextArea1.PNG    ${TextFileContent}
    Click    ${IMAGE_DIR}\\runScriptButton.PNG 
    Sleep    180s
    Wait until screen contain     ${IMAGE_DIR}\\OutputOK.PNG    1310
    Sleep    30s
    Click    ${IMAGE_DIR}\\CancelButton.PNG
    Sleep    20s
    Click    ${IMAGE_DIR}\\NOActionButton.PNG
    Sleep    20s
    Click    ${IMAGE_DIR}\\OKButton.PNG
    Sleep    20s
    Click    ${IMAGE_DIR}\\GeneralTab.PNG
    Sleep    10s
    Click    ${IMAGE_DIR}\\OKButton.PNG
    Sleep    10s
    Capture Screen
    						
										 
    
Get the alarm criteria
	[Arguments]    ${alarmCriterias}  
	 ${alarmCriteriaList}=      Split String    ${alarmCriterias}     ,
     ${criteria}=     set variable     0
     FOR     ${ele}    IN    @{alarmCriteriaList}
	         IF     '${ele}'=='1'
			      ${criteria}=     set variable     1
	              Exit for loop
	         ELSE 
	              ${criteria}=     set variable     0     
	         END       
	 END     
	 [Return]      ${criteria}
	 
Verify data integrity of measures from client
	[Arguments]    ${measure_list}     ${date_value}      ${moid}     ${sql1}     ${sql2}     ${sql3}     ${sql4} 
    @{list}=      Split string      ${measure_list}    ,
    ${count}=     set variable    1
    FOR    ${measure}    IN    @{list}
        #${measure_value}=		Remove zeros after decimal point from measure value     ${measure}
        Log       ${measure}
        ${db_value}=      Query ENIQ database for kpiValue     ${sql${count}}      ${date_value}       ${moid}  
        ${count}=   Evaluate   ${count}+1  
        Log        ${db_value}
        Should contain        ${db_value}      ${measure}    
    END 
    
############PMA Retention Period  Scenario###########   
Get iron_python script for PMA Retention period scenario	 
   	 [Arguments]    ${Filepath}    ${retentionPeriod}	${projLoc}
    ${TextFileContent}=     OperatingSystem.Get File    ${Filepath}
    ${str} =	Replace String	    ${TextFileContent}	   RETENTION_PERIOD   	${retentionPeriod}
   	${str1} =	Replace String	    ${str}	   PROJ_LOC   	${projLoc}
    Log     ${str1}
    [Return]     ${str1}
   	 
Validate the alarm deletion date is per the retention period
	  [Arguments]    ${alarmName}     ${deletionDate}		${retentionPeriod}	  	
     ${ui_date_value}=       Convert date       ${deletionDate}        date_format=%d/%m/%Y       result_format=%m/%d/%Y
     Log     ${deletionDate} 
     ${curr_date}=      Get Current Date
     ${del_date}=      Add Time To Date	      ${curr_date}       ${retentionPeriod}
     Log     ${del_date}
     ${del_date_value}=      Convert date       ${del_date}        date_format=%Y-%m-%d %H:%M:%S.%f     result_format=%m/%d/%Y
     Log     ${del_date_value}
     Should Match      ${del_date_value}        ${ui_date_value} 
     
Execute iron python script for pma retention period
    [Arguments]    ${TextFileContent}     ${ExecuteInTransaction}
    Click on element    ${IMAGE_DIR}\\FileMenu.PNG      ${IMAGE_DIR}\\DocumentProperties.PNG     3
    Click on element    ${IMAGE_DIR}\\DocumentProperties.PNG      ${IMAGE_DIR}\\PropertiesButton.PNG     3
    Click on element    ${IMAGE_DIR}\\PropertiesButton.PNG      ${IMAGE_DIR}\\ScriptButton.PNG     3
    Click on element    ${IMAGE_DIR}\\ScriptButton.PNG      ${IMAGE_DIR}\\checkbox.PNG     3
    Click on element    ${IMAGE_DIR}\\checkbox.PNG      ${IMAGE_DIR}\\newButton.PNG     3
    Click on element    ${IMAGE_DIR}\\newButton.PNG      ${IMAGE_DIR}\\scriptTextArea.PNG     3
    #${TextFileContent}=     Get File    ${Filepath} 
    Run Keyword If    ${ExecuteInTransaction}==False    Click    ${IMAGE_DIR}\\ExecuteInTransaction.PNG
    Sleep    5s
    Click    ${IMAGE_DIR}\\scriptTextArea.PNG
    Paste text    ${IMAGE_DIR}\\scriptTextArea1.PNG    ${TextFileContent}
    Click on element    ${IMAGE_DIR}\\runScriptButton.PNG      ${IMAGE_DIR}\\scriptTextArea.PNG     2     30
    Wait until screen contain     ${IMAGE_DIR}\\OutputOK.PNG     2040
    Capture Screen
    Sleep    30s
    Click    ${IMAGE_DIR}\\CancelButton.PNG
    Sleep    10s
    Click    ${IMAGE_DIR}\\CancelButton.PNG
    Sleep    10s
    #Click    ${IMAGE_DIR}\\OKButton.PNG
    #Sleep    20s
    Click    ${IMAGE_DIR}\\GeneralTab.PNG
    Sleep    2s
    Click    ${IMAGE_DIR}\\OKButton.PNG
    Sleep    8s
    Capture Screen	   	 

Execute iron python script for pma
    [Arguments]    ${TextFileContent}     ${ExecuteInTransaction}
    Click on element    ${IMAGE_DIR}\\FileMenu.PNG      ${IMAGE_DIR}\\DocumentProperties.PNG     3
    Click on element    ${IMAGE_DIR}\\DocumentProperties.PNG      ${IMAGE_DIR}\\PropertiesButton.PNG     3
    Click on element    ${IMAGE_DIR}\\PropertiesButton.PNG      ${IMAGE_DIR}\\ScriptButton.PNG     3
    Click on element    ${IMAGE_DIR}\\ScriptButton.PNG      ${IMAGE_DIR}\\checkbox.PNG     3
    Click on element    ${IMAGE_DIR}\\checkbox.PNG      ${IMAGE_DIR}\\newButton.PNG     3
    Click on element    ${IMAGE_DIR}\\newButton.PNG      ${IMAGE_DIR}\\scriptTextArea.PNG     3
    #${TextFileContent}=     Get File    ${Filepath} 
    Run Keyword If    ${ExecuteInTransaction}==False    Click    ${IMAGE_DIR}\\ExecuteInTransaction.PNG
    Sleep    5s
    Click    ${IMAGE_DIR}\\scriptTextArea.PNG
    Paste text    ${IMAGE_DIR}\\scriptTextArea1.PNG    ${TextFileContent}
    Sleep    5s
    Click    ${IMAGE_DIR}\\runScriptButton.PNG          
    Wait until screen contain     ${IMAGE_DIR}\\OutputOK.PNG     2040
    Capture Screen
    Sleep    30s
    Click    ${IMAGE_DIR}\\CancelButton.PNG
    Sleep    10s
    Click    ${IMAGE_DIR}\\CancelButton.PNG
    Sleep    10s
    #Click    ${IMAGE_DIR}\\OKButton.PNG
    #Sleep    20s
    Click    ${IMAGE_DIR}\\GeneralTab.PNG
    Sleep    2s
    Click    ${IMAGE_DIR}\\OKButton.PNG
    Sleep    8s
    Capture Screen	
    
##########PMADeleteButton################
Get iron_python script for PMA eniq delete button scenario	 
   	 [Arguments]    ${Filepath}    ${dataSource}	${projLoc}
    ${TextFileContent}=     OperatingSystem.Get File    ${Filepath}
    ${str} =	Replace String	    ${TextFileContent}	   DATASOURCE   	${dataSource}
   	${str1} =	Replace String	    ${str}	   PROJ_LOC   	${projLoc}
    Log     ${str1}
    [Return]     ${str1}
    
Get iron_python script for PMA enm delete button scenario	 
   	 [Arguments]    ${Filepath}    ${enmurl}	${projLoc}
    ${TextFileContent}=     OperatingSystem.Get File    ${Filepath}
    ${str} =	Replace String	    ${TextFileContent}	   ENM_CONNECTIONURL   	${enmurl}
   	${str1} =	Replace String	    ${str}	   PROJ_LOC   	${projLoc}
    Log     ${str1}
    [Return]     ${str1}
    
Get iron_python script for PMA export button 
    [Arguments]    ${Filepath}   	${projLoc}
    ${TextFileContent}=     OperatingSystem.Get File    ${Filepath}
    ${str} =	Replace String	    ${TextFileContent}	    PROJ_LOC   	${projLoc}
    Log     ${str}
    [Return]     ${str}
    
Verify datasource is deleted from the connected datasource list   
	 [Arguments]     ${dataSources}			${deletedDataSource}
	 Log 		${dataSources}
	 Log 		${deletedDataSource}
	Should Not contain     	${dataSources}    ${deletedDataSource}     
	
######################PMANodeCollectionManager####################
Get iron_python script for PMA node collection manager
    [Arguments]    ${Filepath}    ${data}	 ${projLoc}
    ${TextFileContent}=     OperatingSystem.Get File    ${Filepath}
    ${str} =	Replace String	    ${TextFileContent}	   SYS_AREA   	${data}[System_area]
    ${str1} =	Replace String	    ${str}	   NODE_TYPE   	${data}[Node_type]
    ${str2} =	Replace String	    ${str1}	   SINGLEORCOLLECTION   	${data}[Single_node_or_collection]
    ${str3} =	Replace String	    ${str2}	   NODE_USED   	${data}[Node]
    ${str4} =	Replace String	    ${str3}	   COLLECTION_NAME   	${data}[CollectionName]
    ${str5} =	Replace String	    ${str4}	   PROJ_LOC   	${projLoc}
    Log     ${str5}
    [Return]     ${str5}
    	
Get iron_python script for PMA dynamic node collection manager
	[Arguments]    ${Filepath}    ${data}	 ${projLoc}
    ${TextFileContent}=     OperatingSystem.Get File    ${Filepath}
    ${str} =	Replace String	    ${TextFileContent}	   SYS_AREA   	${data}[System_area]
    ${str1} =	Replace String	    ${str}	   NODE_TYPE   	${data}[Node_type]
    ${str2} =	Replace String	    ${str1}	   SINGLEORCOLLECTION   	${data}[Single_node_or_collection]
    ${str3} =	Replace String	    ${str2}	   NODE_USED   	${data}[Node]
    ${str4} =	Replace String	    ${str3}	   COLLECTION_NAME   	${data}[CollectionName]
    ${str5} =	Replace String	    ${str4}	   PROJ_LOC   	${projLoc}
    ${str6} =	Replace String	    ${str5}	   WILD_CARD   	${data}[Wild_card]
    Log     ${str6}
    [Return]     ${str6}
    
Get iron_python script for PMA node edit collection manager 
	[Arguments]    ${Filepath}    ${data}	 ${projLoc}
    ${TextFileContent}=     OperatingSystem.Get File    ${Filepath}
    ${str} =	Replace String	    ${TextFileContent}	   SYS_AREA   	${data}[System_area]
    ${str1} =	Replace String	    ${str}	   NODE_TYPE   	${data}[Node_type]
    ${str2} =	Replace String	    ${str1}	   SINGLEORCOLLECTION   	${data}[Single_node_or_collection]
    ${str3} =	Replace String	    ${str2}	   NODE_1   	${data}[Node1]
    ${str4} =	Replace String	    ${str3}	   NODE_2   	${data}[Node2]
    ${str5} =	Replace String	    ${str4}	   NODE_EDIT   	${data}[EditNode]
    ${str6} =	Replace String	    ${str5}	   COLLECTION_NAME   	${data}[CollectionName]
    ${str7} =	Replace String	    ${str6}	   PROJ_LOC   	${projLoc}
    Log     ${str7}
    [Return]     ${str7}
    
Get iron_python script for PMEx node edit collection manager 
	[Arguments]    ${Filepath}    ${data}	 ${projLoc}
    ${TextFileContent}=     OperatingSystem.Get File    ${Filepath}
    ${str} =	Replace String	    ${TextFileContent}	   SYS_AREA   	${data}[System_area]
    ${str1} =	Replace String	    ${str}	   NODE_TYPE   	${data}[Node_type]
    ${str2} =	Replace String	    ${str1}	   SINGLEORCOLLECTION   	${data}[Single_node_or_collection]
    ${str3} =	Replace String	    ${str2}	   NODE_1   	${data}[Node1]
    ${str4} =	Replace String	    ${str3}	   NODE_2   	${data}[Node2]
    ${str5} =	Replace String	    ${str4}	   NODE_EDIT   	${data}[EditNode]
    ${str6} =	Replace String	    ${str5}	   COLLECTION_NAME   	${data}[CollectionName]
    ${str7} =	Replace String	    ${str6}	   PROJ_LOC   	${projLoc}
    Log     ${str7}
    [Return]     ${str7}
    
Get iron_python script for PMA collection delete scenario
	[Arguments]    ${Filepath} 	 ${projLoc}
    ${TextFileContent}=     OperatingSystem.Get File    ${Filepath}
    ${str} =	Replace String	    ${TextFileContent}	   PROJ_LOC   	${projLoc}
    Log     ${str}
    [Return]     ${str}
    
Validate the collection name in collection list  
	[Arguments]     ${collectionInList}			${collectionNameInput}
	Should Be Equal     	${collectionInList}    ${collectionNameInput}   
	
Verify collection is deleted	 
	[Arguments]     ${collectionList}			${deletedCollection}
	Should Not contain       	${collectionList}    ${deletedCollection} 
	
Verify edited nodes displayed for collection
	[Arguments]     ${NodesList}			${EditNode}
	Should Be Equal     	${NodesList}    ${EditNode}	
	
Verify the export message for successful export	
    [Arguments]     ${ExportMessage}	
    ${expectedExportMsg}=     Set variable    Rules exported to		
	Should contain     ${ExportMessage}    ${expectedExportMsg}	
	
Verify alarm is not present in list	 
	[Arguments]     ${alarmList}			${alarmName}
	Should Not contain       	${alarmList}    ${alarmName} 	

Verify report is created
	[Arguments]     ${reportNamesList}			${reportName}
	Should contain     	${reportNamesList}    ${reportName}
	 
Verify that Edit page is visible		
	[Arguments]     ${actualPageName}			${expectedPageName}
	Should Be Equal       	${actualPageName}    ${expectedPageName}

Verify that View page is visible		
	[Arguments]     ${actualPageName}			${expectedPageName}
	Should Be Equal      	${actualPageName}    ${expectedPageName}
		
Validate multi ENIQ connections are displayed	
	[Arguments]     ${expectedEniqConnections}			${actualEniqConnectionsList}
	Should contain     	${actualEniqConnectionsList}    ${expectedEniqConnections} 	
	
Validate alarm rule imported is displayed in import result	
	[Arguments]     ${actualMsg}			${ExpectedMsg}
	Should Be Equal     	${actualMsg}    ${ExpectedMsg}	

Verify the report has data
	[Arguments]     ${dataFromFetchPmData}			
	Should contain		${dataFromFetchPmData}		File Availability
	Should contain		${dataFromFetchPmData}		Counter Availability
	
Get iron_python script for PMA Import	
	 [Arguments]    ${Filepath}    ${alarmRule}	${projLoc}
    ${TextFileContent}=     OperatingSystem.Get File    ${Filepath}
    ${str} =	Replace String	    ${TextFileContent}	   ALARMRULE_FILE   	${alarmRule}
   	${str1} =	Replace String	    ${str}	   PROJ_LOC   	${projLoc}
    Log     ${str1}
    [Return]     ${str1}
    
Verify specific problem of alarm is changed
   [Arguments]     ${columnValues}    ${editedValue}
   ${rowValuesOfReport}=    Split String     ${columnValues}     Column:
   FOR    ${ele}    IN    @{rowValuesOfReport}
		${nodetypePresent}  ${value}=  Run Keyword And Ignore Error  Should Contain   ${ele}      SpecificProblem 
		IF  	'${nodetypePresent}'=='PASS'
			${specificPrblmEdit}  ${value2}=  Run Keyword And Ignore Error  Should Contain   ${ele}      ${editedValue} 		
			BREAK 
		END	 
    END	
   	Should contain    ${specificPrblmEdit}	   PASS    

Get iron_python script for pmex dynamic node collection manager
	[Arguments]    ${Filepath}    ${data}	 ${projLoc}
    ${TextFileContent}=     OperatingSystem.Get File    ${Filepath}
    ${str} =	Replace String	    ${TextFileContent}	   SYS_AREA   	${data}[System_area]
    ${str1} =	Replace String	    ${str}	   NODE_TYPE   	${data}[Node_type]
    ${str2} =	Replace String	    ${str1}	   SINGLEORCOLLECTION   	${data}[Single_node_or_collection]
    ${str3} =	Replace String	    ${str2}	   NODE_USED   	${data}[Node]
    ${str4} =	Replace String	    ${str3}	   COLLECTION_NAME   	${data}[CollectionName]
    ${str5} =	Replace String	    ${str4}	   PROJ_LOC   	${projLoc}
    ${str6} =	Replace String	    ${str5}	   WILD_CARD   	${data}[Wild_card]
    Log     ${str6}
    [Return]     ${str6}
    
Verify the report description is edited	  
	[Arguments]     ${reportDesc}			${ExpectedDesc}
	Should Be Equal     	${reportDesc}    ${ExpectedDesc}	  
	
Verify the interval is created	
	[Arguments]     ${ActualName}			${ExpectedIntervalName}
	Should Be Equal     	${ActualName}    ${ExpectedIntervalName}
	
Verify that Edit page of report is visible	
	[Arguments]     ${editPageName}			${reportNameTableName}
	${words}=    Split String	${reportNameTableName}   ,
	Log 	${words}
	${reportName}=     Get From List    ${words}    0
	${reportName}=    Strip String    ${reportName}
	${tableName}=     Get From List    ${words}    1
	${tableName}=    Strip String    ${tableName}
    ${expectedEditPageName} = 	 Catenate 	 SEPARATOR=:		${reportName}	  ${tableName}
    Log 		${expectedEditPageName}
	#Screen should contain		${IMAGE_DIR}\\editIcon.PNG
	Should Be Equal     	${editPageName}    ${expectedEditPageName}
	
Verify that View page of report is visible	
	[Arguments]     ${viewPageName}			${reportNameTableName}
	${words}=    Split String	${reportNameTableName}   ,
	Log 	${words}
	${reportName}=     Get From List    ${words}    0
	${reportName}=    Strip String    ${reportName}
	${tableName}=     Get From List    ${words}    1
	${tableName}=    Strip String    ${tableName}
	${expectedViewPageName} = Catenate 		SEPARATOR=:		${reportName}	  ${tableName}
	Log 		${expectedViewPageName}
	Should Be Equal     	${viewPageName}    ${expectedViewPageName}	
	
Verify graph is added 	
	[Arguments]     ${reportDetails}			${graphName}
	Should contain		${reportDetails}		${graphName}
	
#########DatIntegrity for AppCoverage Map######################
Query ENIQ database for Avg failed User Session	
	[Arguments]       ${sql_query}    ${nodeVal}    ${cellVal}
    ${sql_query}=     Replace String    ${sql_query}    ERBS_NODE     \'${nodeVal}\'
    ${sql_query}=     Replace String    ${sql_query}    CELL_NAME      \'${cellVal}\'
    log    ${sql_query}
    ${value}=     Query Sybase database     ${sql_query}
    log    ${value}
    ${string_value}=      Convert to string      ${value}[0]
    [Return]     ${string_value}

Format the DB Value
	[Arguments]       ${DB_Value}
	Log    ${DB_Value}
	${dbValue1}=    convert to string    ${dbValue}
	${dbValue1}=    split string    ${dbValue1}    '
	${dbValue1}=    get from list    ${dbValue1}    1
	${dbValue1}=    Remove everything after decimal point from measure value    ${dbValue1}
	Log    ${dbValue1.strip()}
	[Return]	${dbValue1.strip()}
	
Format DB Value of Cell Failure Rate
	[Arguments]       ${DB_Value}
	Log    ${DB_Value}
	${dbValue1}=    convert to string    ${dbValue}
	${dbValue1}=    split string    ${dbValue1}    '
	${dbValue1}=    get from list    ${dbValue1}    3
	${dbValue1}=    Remove everything after decimal point from measure value    ${dbValue1}
	Log    ${dbValue1.strip()}
	[Return]	${dbValue1.strip()}
	
Query ENIQ database for Cell Failure Rate 
	[Arguments]       ${sql_query}    ${nodeVal}    ${cellVal}		${dateId}		${hourId}
	${Date_Val}    Convert Date    ${dateId}    result_format=%Y-%m-%d    date_format=%m/%d/%Y
	Log		${Date_Val}
    ${sql_query}=     Replace String    ${sql_query}    ERBS_NODE     \'${nodeVal}\'
    ${sql_query}=     Replace String    ${sql_query}    CELL_NAME      \'${cellVal}\'
    ${sql_query}=     Replace String    ${sql_query}    DATEID      \'${Date_Val}\'
    ${sql_query}=     Replace String    ${sql_query}    HOURID 		 \'${hourId}\'
    log    ${sql_query}
    ${value}=     Query Sybase database     ${sql_query}
    log    ${value}
    ${string_value}=      Convert to string      ${value}[0]
    [Return]     ${string_value}
	
############### TR-IA11419 TCs ###############

Launch the Tibco spotfire PMEx Application as Business Analyst
    AutoItLibrary.Run    C:\\Program Files (x86)\\TIBCO\\Spotfire\\11.4.2\\Spotfire.Dxp /server:"https://atvts4133.athtem.eei.ericsson.se/" /username:BAnalyst /password:Ericsson02 /file:${dxp_file_loc}/PM_Explorer_S11_4.dxp
    Sleep    10
    Wait until screen contain     ${IMAGE_DIR}\\PMEx_DXP4_Verification.PNG    300
    Sleep    15
    Capture Screen
    
Launch the Tibco spotfire PMEx Application as Administrator
    AutoItLibrary.Run    C:\\Program Files (x86)\\TIBCO\\Spotfire\\11.4.2\\Spotfire.Dxp /server:"https://atvts4133.athtem.eei.ericsson.se/" /username:Administrator /password:Ericsson01 /file:${dxp_file_loc}/PM_Explorer_S11_4.dxp
    Sleep    10
    Wait until screen contain     ${IMAGE_DIR}\\PMEx_DXP4_Verification.PNG    300
    Sleep    15
    Capture Screen
    
Verify the data file in Custom Library
	[Arguments]    ${name}
	Click    ${IMAGE_DIR}\\PMD_File_Button.PNG
	sleep    3     
	click    ${IMAGE_DIR}\\PMD_File_Open_Button.PNG
	sleep    3
	Click    ${IMAGE_DIR}\\PMD_Spotfire_Library_button.PNG
	sleep    3
	Double Click    ${IMAGE_DIR}\\PMEx_Custom_Library.PNG
	sleep    3
	Double Click    ${IMAGE_DIR}\\PMEx_PMEX_Reports.PNG
	sleep    5
	Set ocr text read    True
    ${text}=    SikuliLibrary.Get text
    Log    ${text}
    [Return]    ${text}
    should contain    ${text}    ${name}
    
Execute iron python script for Business Analyst
    [Arguments]    ${TextFileContent}     ${ExecuteInTransaction}
    Click on element    ${IMAGE_DIR}\\FileMenu.PNG      ${IMAGE_DIR}\\DocumentProperties.PNG     3
    Click on element    ${IMAGE_DIR}\\DocumentProperties.PNG      ${IMAGE_DIR}\\PropertiesButton.PNG     3
    Click on element    ${IMAGE_DIR}\\PropertiesButton.PNG      ${IMAGE_DIR}\\ScriptButton.PNG     3
    Click on element    ${IMAGE_DIR}\\ScriptButton.PNG      ${IMAGE_DIR}\\checkbox.PNG     3
    Click on element    ${IMAGE_DIR}\\checkbox.PNG      ${IMAGE_DIR}\\newButton.PNG     3
    Click on element    ${IMAGE_DIR}\\newButton.PNG      ${IMAGE_DIR}\\scriptTextArea.PNG     3
    Run Keyword If    ${ExecuteInTransaction}==False    Click    ${IMAGE_DIR}\\ExecuteInTransaction.PNG
    Sleep    2s
    Click    ${IMAGE_DIR}\\scriptTextArea.PNG
    Paste text    ${IMAGE_DIR}\\scriptTextArea1.PNG    ${TextFileContent}
    sleep    5
    Click    ${IMAGE_DIR}\\runScriptButton.PNG
    Sleep    180
    Wait until screen contain     ${IMAGE_DIR}\\OutputOkNew.PNG    1910
    Capture Screen
    Sleep    50s
    Click    ${IMAGE_DIR}\\CancelButton.PNG
    Sleep    50
    Click    ${IMAGE_DIR}\\noActionRadio.PNG
    Sleep    10
    Click    ${IMAGE_DIR}\\OKButton.PNG
    sleep    10
    Click    ${IMAGE_DIR}\\GeneralTab.PNG
    Sleep    2s
    Click    ${IMAGE_DIR}\\OKButton.PNG
    Sleep    8s
    Capture Screen
    
Execute iron python script for Administrator
	[Arguments]    ${TextFileContent}     ${ExecuteInTransaction}
    Click on element    ${IMAGE_DIR}\\FileMenu.PNG      ${IMAGE_DIR}\\DocumentProperties.PNG     3
    Click on element    ${IMAGE_DIR}\\DocumentProperties.PNG      ${IMAGE_DIR}\\PropertiesButton.PNG     3
    Click on element    ${IMAGE_DIR}\\PropertiesButton.PNG      ${IMAGE_DIR}\\ScriptButton.PNG     3
    Click on element    ${IMAGE_DIR}\\ScriptButton.PNG      ${IMAGE_DIR}\\checkbox.PNG     3
    Click on element    ${IMAGE_DIR}\\checkbox.PNG      ${IMAGE_DIR}\\newButton.PNG     3
    Click on element    ${IMAGE_DIR}\\newButton.PNG      ${IMAGE_DIR}\\scriptTextArea.PNG     3
    Run Keyword If    ${ExecuteInTransaction}==False    Click    ${IMAGE_DIR}\\ExecuteInTransaction.PNG
    Sleep    2s
    Click    ${IMAGE_DIR}\\scriptTextArea.PNG
    Paste text    ${IMAGE_DIR}\\scriptTextArea1.PNG    ${TextFileContent}
    sleep    5
    Click    ${IMAGE_DIR}\\runScriptButton.PNG
    Sleep    180
    Wait until screen contain     ${IMAGE_DIR}\\OutputOkNew.PNG    1910
    Capture Screen
    Sleep    50s
    Click    ${IMAGE_DIR}\\CancelButton.PNG
    Sleep    50
    Click    ${IMAGE_DIR}\\noActionRadio.PNG
    Sleep    10
    Click    ${IMAGE_DIR}\\OKButton.PNG
    sleep    10
    Click    ${IMAGE_DIR}\\GeneralTab.PNG
    Sleep    2s
    Click    ${IMAGE_DIR}\\OKButton.PNG
    Sleep    8s
    Capture Screen	   
    
Delete the selected report
	Wait until screen contain     ${IMAGE_DIR}\\PMD_Delete_Button.PNG    300
    Click    ${IMAGE_DIR}\\PMD_Delete_Button.PNG	
	sleep    5
	Wait until screen contain     ${IMAGE_DIR}\\deleteButton2.PNG    300
    Click    ${IMAGE_DIR}\\deleteButton2.PNG 
    
Verify that the deleted report is not present in Report Manager page
	[Arguments]    ${name}
	Set ocr text read    True
    ${text}=    SikuliLibrary.Get text
    Log    ${text}
    [Return]    ${text}
    should contain    ${text}    ${name}   
    
############### TR-IA11419 TCs END ###############

Launch the Tibco spotfire PM Explorer Application
	AutoItLibrary.Run    C:\\Program Files (x86)\\TIBCO\\Spotfire\\11.4.2\\Spotfire.Dxp /server:"https://localhost/" /username:Administrator /password:Ericsson01 /file:${dxp_file_loc}/PM_Explorer_S11_7.dxp
	sleep    15
	Wait until screen contain     ${IMAGE_DIR}\\certificate.PNG    300
    Click    ${IMAGE_DIR}\\certificateYes.PNG
    Sleep    90
    Capture Screen
   
Execute iron python script for PM Explorer
	[Arguments]    ${TextFileContent}     ${ExecuteInTransaction}
    Click on element    ${IMAGE_DIR}\\FileMenu.PNG      ${IMAGE_DIR}\\DocumentProperties.PNG     6
    Click on element    ${IMAGE_DIR}\\DocumentProperties.PNG      ${IMAGE_DIR}\\PropertiesButton.PNG     6
    Click on element    ${IMAGE_DIR}\\PropertiesButton.PNG      ${IMAGE_DIR}\\ScriptButton.PNG     6
    Click on element    ${IMAGE_DIR}\\ScriptButton.PNG      ${IMAGE_DIR}\\checkbox.PNG     6
    Click on element    ${IMAGE_DIR}\\checkbox.PNG      ${IMAGE_DIR}\\newButton.PNG     6
    Click on element    ${IMAGE_DIR}\\newButton.PNG      ${IMAGE_DIR}\\scriptTextArea.PNG     6
    Run Keyword If    ${ExecuteInTransaction}==False    Click    ${IMAGE_DIR}\\ExecuteInTransaction.PNG
    Sleep    2s
    Click    ${IMAGE_DIR}\\scriptTextArea.PNG
    Paste text    ${IMAGE_DIR}\\scriptTextArea1.PNG    ${TextFileContent}
    sleep    3
    Click    ${IMAGE_DIR}\\runScriptButton.PNG
    Sleep    70s
    Wait until screen contain     ${IMAGE_DIR}\\OutputOkNew.PNG    3000
    Capture Screen
    Sleep    10s
    Click    ${IMAGE_DIR}\\CancelButton.PNG
    Sleep    5
    Click    ${IMAGE_DIR}\\NOActionButton.PNG
    Sleep    10s
    Click    ${IMAGE_DIR}\\OKButton.PNG
    Sleep    25s
    Click    ${IMAGE_DIR}\\GeneralTab.PNG
    Sleep    2s
    Click    ${IMAGE_DIR}\\OKButton.PNG
    Sleep    8s
    Capture Screen
	
Execute iron python script for PM Alarming
	[Arguments]    ${TextFileContent}     ${ExecuteInTransaction}
    Click on element    ${IMAGE_DIR}\\FileMenu.PNG      ${IMAGE_DIR}\\DocumentProperties.PNG     6
    Click on element    ${IMAGE_DIR}\\DocumentProperties.PNG      ${IMAGE_DIR}\\PropertiesButton.PNG     6
    Click on element    ${IMAGE_DIR}\\PropertiesButton.PNG      ${IMAGE_DIR}\\ScriptButton.PNG     6
    Click on element    ${IMAGE_DIR}\\ScriptButton.PNG      ${IMAGE_DIR}\\checkbox.PNG     6
    Click on element    ${IMAGE_DIR}\\checkbox.PNG      ${IMAGE_DIR}\\newButton.PNG     6
    Click on element    ${IMAGE_DIR}\\newButton.PNG      ${IMAGE_DIR}\\scriptTextArea.PNG     6
    Run Keyword If    ${ExecuteInTransaction}==False    Click    ${IMAGE_DIR}\\ExecuteInTransaction.PNG
    Sleep    2s
    Click    ${IMAGE_DIR}\\scriptTextArea.PNG
    Paste text    ${IMAGE_DIR}\\scriptTextArea1.PNG    ${TextFileContent}
    sleep    3
    Click    ${IMAGE_DIR}\\runScriptButton.PNG
    Sleep    70s
    Wait until screen contain     ${IMAGE_DIR}\\OutputOkNew.PNG    3000
    Capture Screen
    Sleep    10s
    Click    ${IMAGE_DIR}\\CancelButton.PNG
    Sleep    5
    Click    ${IMAGE_DIR}\\NOActionButton.PNG
    Sleep    10s
    Click    ${IMAGE_DIR}\\OKButton.PNG
    Sleep    25s
    Click    ${IMAGE_DIR}\\GeneralTab.PNG
    Sleep    2s
    Click    ${IMAGE_DIR}\\OKButton.PNG
    Sleep    8s
    Capture Screen