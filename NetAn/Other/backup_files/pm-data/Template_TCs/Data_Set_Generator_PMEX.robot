*** Settings ***

Documentation     Data Set Generator PMEX
Library           Selenium2Library
Library           OperatingSystem
Library           Collections
Library           String
Library           DateTime
Library           PostgreSQLDB
Library			  Process
Library           SSHLibrary
Resource          ${EXEC_DIR}/ENIQ_TC_Automation/NetAn/Resources/Keywords/Variables.robot
Resource          ${EXEC_DIR}/ENIQ_TC_Automation/NetAn/Resources/Keywords/${PMDataKeywordFile}

*** Test Cases ***

Data Set Generator
    ${data}=    get data from CSV file for the release    5G_CCSM_Delta_Statistics_PM1_updated.csv    24.1
    ${formula}    ${table}=    get counter and table from fetched data    ${data}    CCSM    24.1_PMEx_NewMeasures    Core
    
*** Keywords ***
    
get data from CSV file for the release
	[Arguments]     ${fileName}    ${KPIName}
    ${csvFile}=    OperatingSystem.Get File    ${EXEC_DIR}\\ENIQ_TC_Automation\\NetAn\\Resources\\Data\\pm-data\\${fileName}
    @{read}=    Create List    ${csvFile}
    @{lines}=    Split To Lines    @{read}    1
    @{lineList}=    Create list    	
    FOR    ${line_csv}    IN    @{lines}
    	Log    ${line_csv}
    	${status}=    run keyword and return status    should contain    ${line_csv}    ${KPIName}
    	IF    "${status}"=="True"    		
    		append to list      ${lineList}    ${line_csv}
    	END
    END
    Log    ${lineList}
    [Return]    @{lineList}
    
get counter and table from fetched data  
	[Arguments]    ${data}    ${nodeType}    ${jsonFileName}    ${systemArea}
	Remove file    ${EXEC_DIR}\\ENIQ_TC_Automation\\NetAn\\Resources\\Data\\pm-data\\${jsonFileName}.json
	Append to file    ${EXEC_DIR}\\ENIQ_TC_Automation\\NetAn\\Resources\\Data\\pm-data\\${jsonFileName}.json    {
	Append to file    ${EXEC_DIR}\\ENIQ_TC_Automation\\NetAn\\Resources\\Data\\pm-data\\${jsonFileName}.json    ${\n}
	${flag}=    set variable     1
	${count}=    set variable    1
	${4spaces}=    set variable    ${SPACE}${SPACE}${SPACE}${SPACE}
	${8spaces}=    set variable    ${SPACE}${SPACE}${SPACE}${SPACE}${SPACE}${SPACE}${SPACE}${SPACE}
	FOR    ${item}    IN    @{data}
		Log    ${item}
		@{singleLine}=    split string    ${item}    ,    max_split=6
		Log    ${singleLine}
		${counter}=    get from list    ${singleLine}    4
		${table}=    get from list    ${singleLine}    3
		Log    ${counter}
		Log    ${table}
		Append to file    ${EXEC_DIR}\\ENIQ_TC_Automation\\NetAn\\Resources\\Data\\pm-data\\${jsonFileName}.json    ${4spaces}\"${nodeType}${flag}\":${SPACE}{\n
		Append to file    ${EXEC_DIR}\\ENIQ_TC_Automation\\NetAn\\Resources\\Data\\pm-data\\${jsonFileName}.json    ${8spaces}"System_area"${SPACE}:${SPACE}"${systemArea}",\n
		Append to file    ${EXEC_DIR}\\ENIQ_TC_Automation\\NetAn\\Resources\\Data\\pm-data\\${jsonFileName}.json    ${8spaces}"Node_type"${SPACE}:${SPACE}"${nodeType}",\n
		Append to file    ${EXEC_DIR}\\ENIQ_TC_Automation\\NetAn\\Resources\\Data\\pm-data\\${jsonFileName}.json    ${8spaces}"Data_source"${SPACE}:${SPACE}"NetAn_ODBC",\n
		Append to file    ${EXEC_DIR}\\ENIQ_TC_Automation\\NetAn\\Resources\\Data\\pm-data\\${jsonFileName}.json    ${8spaces}"Get_Data_for"${SPACE}:${SPACE}"Node(s)",\n
		Append to file    ${EXEC_DIR}\\ENIQ_TC_Automation\\NetAn\\Resources\\Data\\pm-data\\${jsonFileName}.json    ${8spaces}"Aggregation"${SPACE}:${SPACE}"Node",\n
		Append to file    ${EXEC_DIR}\\ENIQ_TC_Automation\\NetAn\\Resources\\Data\\pm-data\\${jsonFileName}.json    ${8spaces}"Node"${SPACE}:${SPACE}"${nodeType}0${count}",\n
		Append to file    ${EXEC_DIR}\\ENIQ_TC_Automation\\NetAn\\Resources\\Data\\pm-data\\${jsonFileName}.json    ${8spaces}"Measure_type"${SPACE}:${SPACE}"COUNTER,PDF_COUNTER,DYNCOUNTER,ERICSSON_KPI,RI",\n
		Append to file    ${EXEC_DIR}\\ENIQ_TC_Automation\\NetAn\\Resources\\Data\\pm-data\\${jsonFileName}.json    ${8spaces}"Measure"${SPACE}:${SPACE}\"${counter}.${table}\",\n
    	Append to file    ${EXEC_DIR}\\ENIQ_TC_Automation\\NetAn\\Resources\\Data\\pm-data\\${jsonFileName}.json    ${8spaces}"Time_selector"${SPACE}:${SPACE}"Last 30 Days",\n
		Append to file    ${EXEC_DIR}\\ENIQ_TC_Automation\\NetAn\\Resources\\Data\\pm-data\\${jsonFileName}.json    ${8spaces}"Aggregation_in_select_time"${SPACE}:${SPACE}"Day",\n
		Append to file    ${EXEC_DIR}\\ENIQ_TC_Automation\\NetAn\\Resources\\Data\\pm-data\\${jsonFileName}.json    ${8spaces}"get_data_for_Columns"${SPACE}:${SPACE}"${counter}",\n
		Append to file    ${EXEC_DIR}\\ENIQ_TC_Automation\\NetAn\\Resources\\Data\\pm-data\\${jsonFileName}.json    ${8spaces}"Columns_displayed"${SPACE}:${SPACE}"DATE_ID",\n
		Append to file    ${EXEC_DIR}\\ENIQ_TC_Automation\\NetAn\\Resources\\Data\\pm-data\\${jsonFileName}.json    ${8spaces}"Report_name"${SPACE}:${SPACE}"${nodeType}_",\n
		Append to file    ${EXEC_DIR}\\ENIQ_TC_Automation\\NetAn\\Resources\\Data\\pm-data\\${jsonFileName}.json    ${8spaces}"Report_AccessType"${SPACE}:${SPACE}"Public",\n
		Append to file    ${EXEC_DIR}\\ENIQ_TC_Automation\\NetAn\\Resources\\Data\\pm-data\\${jsonFileName}.json    ${8spaces}"Report_Description"${SPACE}:${SPACE}"NA",\n
		Append to file    ${EXEC_DIR}\\ENIQ_TC_Automation\\NetAn\\Resources\\Data\\pm-data\\${jsonFileName}.json    ${8spaces}"Formula"${SPACE}:${SPACE}"${counter}.${table}"\n
		Append to file    ${EXEC_DIR}\\ENIQ_TC_Automation\\NetAn\\Resources\\Data\\pm-data\\${jsonFileName}.json    ${4spaces}},${\n}
    	${flag}=    evaluate    ${flag}+1
    	${count}=    evaluate    ${count}+1
    	IF    ${count}==4
    		${count}=    set variable    1
    	END
	END
	Append to file    ${EXEC_DIR}\\ENIQ_TC_Automation\\NetAn\\Resources\\Data\\pm-data\\${jsonFileName}.json    }