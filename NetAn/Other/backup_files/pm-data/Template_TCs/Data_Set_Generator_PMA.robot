*** Settings ***

Documentation     Data Set Generator PMA
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
    ${formula}    ${table}=    get counter and table from fetched data    ${data}    CCSM    Ranga'sJson
    
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
	[Arguments]    ${data}    ${nodeType}    ${jsonFileName}
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
		Append to file    ${EXEC_DIR}\\ENIQ_TC_Automation\\NetAn\\Resources\\Data\\pm-data\\${jsonFileName}.json    ${8spaces}"Alarm_name"${SPACE}:${SPACE}"Alarm",\n
		Append to file    ${EXEC_DIR}\\ENIQ_TC_Automation\\NetAn\\Resources\\Data\\pm-data\\${jsonFileName}.json    ${8spaces}"Alarm_Type"${SPACE}:${SPACE}"Threshold",\n
		Append to file    ${EXEC_DIR}\\ENIQ_TC_Automation\\NetAn\\Resources\\Data\\pm-data\\${jsonFileName}.json    ${8spaces}"ENIQ_data_source"${SPACE}:${SPACE}"NetAn_ODBC",\n
		Append to file    ${EXEC_DIR}\\ENIQ_TC_Automation\\NetAn\\Resources\\Data\\pm-data\\${jsonFileName}.json    ${8spaces}"Single_node_or_collection_or_network"${SPACE}:${SPACE}"Single Node",\n
		Append to file    ${EXEC_DIR}\\ENIQ_TC_Automation\\NetAn\\Resources\\Data\\pm-data\\${jsonFileName}.json    ${8spaces}"System_area"${SPACE}:${SPACE}"Core",\n
		Append to file    ${EXEC_DIR}\\ENIQ_TC_Automation\\NetAn\\Resources\\Data\\pm-data\\${jsonFileName}.json    ${8spaces}"Node_type"${SPACE}:${SPACE}"${nodeType}",\n
		Append to file    ${EXEC_DIR}\\ENIQ_TC_Automation\\NetAn\\Resources\\Data\\pm-data\\${jsonFileName}.json    ${8spaces}"Node"${SPACE}:${SPACE}"${nodeType}0${count}",\n
		Append to file    ${EXEC_DIR}\\ENIQ_TC_Automation\\NetAn\\Resources\\Data\\pm-data\\${jsonFileName}.json    ${8spaces}"Measure_type"${SPACE}:${SPACE}"COUNTER",\n
		Append to file    ${EXEC_DIR}\\ENIQ_TC_Automation\\NetAn\\Resources\\Data\\pm-data\\${jsonFileName}.json    ${8spaces}"Measure"${SPACE}:${SPACE}\"${counter}.${table}\",\n
    	Append to file    ${EXEC_DIR}\\ENIQ_TC_Automation\\NetAn\\Resources\\Data\\pm-data\\${jsonFileName}.json    ${8spaces}"SQL1"${SPACE}:${SPACE}"DECLARE @DATETIME_ID varchar(50)=DATETIME_VALUE , @UNIQUE_ID varchar(500)=UNIQUE_ID_VALUE select cast(ROUND(SUM(${counter}),2) as numeric(36,2)) as MeasureValue from ${table} where DATE_ID=@DATETIME_ID and MOID=@UNIQUE_ID",\n
		Append to file    ${EXEC_DIR}\\ENIQ_TC_Automation\\NetAn\\Resources\\Data\\pm-data\\${jsonFileName}.json    ${8spaces}"SQL2"${SPACE}:${SPACE}"",\n
		Append to file    ${EXEC_DIR}\\ENIQ_TC_Automation\\NetAn\\Resources\\Data\\pm-data\\${jsonFileName}.json    ${8spaces}"SQL3"${SPACE}:${SPACE}"",\n
		Append to file    ${EXEC_DIR}\\ENIQ_TC_Automation\\NetAn\\Resources\\Data\\pm-data\\${jsonFileName}.json    ${8spaces}"SQL4"${SPACE}:${SPACE}"",\n
		Append to file    ${EXEC_DIR}\\ENIQ_TC_Automation\\NetAn\\Resources\\Data\\pm-data\\${jsonFileName}.json    ${8spaces}"Alarm_severity"${SPACE}:${SPACE}"Minor",\n
		Append to file    ${EXEC_DIR}\\ENIQ_TC_Automation\\NetAn\\Resources\\Data\\pm-data\\${jsonFileName}.json    ${8spaces}"Aggregation"${SPACE}:${SPACE}"1 Day",\n
		Append to file    ${EXEC_DIR}\\ENIQ_TC_Automation\\NetAn\\Resources\\Data\\pm-data\\${jsonFileName}.json    ${8spaces}"Probable_cause"${SPACE}:${SPACE}"Reduced alarm reporting",\n
		Append to file    ${EXEC_DIR}\\ENIQ_TC_Automation\\NetAn\\Resources\\Data\\pm-data\\${jsonFileName}.json    ${8spaces}"Specific_problem"${SPACE}:${SPACE}"NA",\n
		Append to file    ${EXEC_DIR}\\ENIQ_TC_Automation\\NetAn\\Resources\\Data\\pm-data\\${jsonFileName}.json    ${8spaces}"Date_range_val"${SPACE}:${SPACE}"2",\n
		Append to file    ${EXEC_DIR}\\ENIQ_TC_Automation\\NetAn\\Resources\\Data\\pm-data\\${jsonFileName}.json    ${8spaces}"Date_range_unit"${SPACE}:${SPACE}"Hour(s)",\n
		Append to file    ${EXEC_DIR}\\ENIQ_TC_Automation\\NetAn\\Resources\\Data\\pm-data\\${jsonFileName}.json    ${8spaces}"LookBack_Period_val"${SPACE}:${SPACE}"2",\n
		Append to file    ${EXEC_DIR}\\ENIQ_TC_Automation\\NetAn\\Resources\\Data\\pm-data\\${jsonFileName}.json    ${8spaces}"LookBack_Period_unit"${SPACE}:${SPACE}"Day(s)",\n
		Append to file    ${EXEC_DIR}\\ENIQ_TC_Automation\\NetAn\\Resources\\Data\\pm-data\\${jsonFileName}.json    ${8spaces}"Columns_diplayed"${SPACE}:${SPACE}"DATE_ID"\n
		Append to file    ${EXEC_DIR}\\ENIQ_TC_Automation\\NetAn\\Resources\\Data\\pm-data\\${jsonFileName}.json    ${4spaces}},${\n}
    	${flag}=    evaluate    ${flag}+1
    	${count}=    evaluate    ${count}+1
    	IF    ${count}==4
    		${count}=    set variable    1
    	END
	END
	Append to file    ${EXEC_DIR}\\ENIQ_TC_Automation\\NetAn\\Resources\\Data\\pm-data\\${jsonFileName}.json    }