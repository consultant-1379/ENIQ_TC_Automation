*** Settings ***

Documentation     Verify That The KPI Formula Is Written Properly
Library           Selenium2Library
Library           OperatingSystem
Library           Collections
Library           String
Library           DateTime
Library           PostgreSQLDB
Library			  DatabaseLibrary
Library			  Process
Library			  CSVLibrary
Resource          ${EXEC_DIR}/ENIQ_TC_Automation/NetAn/Resources/Keywords/Variables.robot
Resource          ${EXEC_DIR}/ENIQ_TC_Automation/NetAn/Resources/Keywords/${PMDataKeywordFile}
Resource          ${EXEC_DIR}/ENIQ_TC_Automation/NetAn/Resources/Keywords/SybaseDBConnection.robot

*** Test Cases ***

Verify That The KPI Formula Is Written Properly
    ${data}=    get data from CSV file for the KPI    Measures.csv    E-RAB Retainability - Percentage Lost for Emergency Calls
    ${formula}    ${table}=    get KPI formula and Table Information from CSV file    ${data}
    verify that the columns used in KPI formula are present in Counters column and in DB    ${formula}    ${table}
    
*** Keywords ***
    
get data from CSV file for the KPI
	[Arguments]     ${fileName}    ${KPIName}
    ${csvFile}=    Get File    ${EXEC_DIR}\\ENIQ_TC_Automation\\NetAn\\Resources\\Data\\pm-data\\${fileName}
    @{read}=    Create List    ${csvFile}
    @{lines}=    Split To Lines    @{read}    1
    FOR    ${line_csv}    IN    @{lines}
    	Log    ${line_csv}
    	${status}=    run keyword and return status    should contain    ${line_csv}    ${KPIName}    ignore_case=true
    	set global variable    ${line_csv}
    	run keyword if    "${status}"=="True"    Exit For Loop
    END
    [Return]    ${line_csv}
    
get KPI formula and Table Information from CSV file   
	[Arguments]    ${data}
    @{kpiDetails}=    split string    ${data}    ,    max_split=2
    ${flag}    set variable    0
    FOR    ${i}    IN    @{kpiDetails}
    	Log    ${i}
    	${flag}=    evaluate    ${flag}+1
    	Log    ${flag}
    	run keyword if    ${flag}==3    set global variable    ${i}
    END
    ${kpiFormula}=    get from list    ${kpiDetails}    1
    Log    ${i}
    @{infoList}=    split string    ${i}    "
    FOR    ${j}    IN    @{infoList}
    	Log    ${j}
    END
    ${infoItem}=    get from List    ${infoList}      1
    Log    ${infoItem}
    Log    ${kpiFormula}
    [Return]    ${kpiFormula}    ${infoItem}

verify that the columns used in KPI formula are present in Counters column and in DB
	[Arguments]    ${formula}    ${table}
	Log    ${table}
	${formula}=    convert to string    ${formula}
	@{counterList}=    split string    ${table}    ,
	FOR    ${counter}    IN    @{counterList}
		${counter}=    convert to string    ${counter}
		should contain    ${formula}    ${counter}    ignore_case=true
		@{query}=    split string    ${counter}    .
		${tableName}=    get from list    ${query}    0
		${columnName}=    get from list    ${query}    1
		${dbResult}=    query sybase database    sp_columns ${tableName}
		Log    ${dbResult} 
		${dbResult}=    convert to string    ${dbResult}
		should contain    ${dbResult}    ${columnName}    ignore_case=true
	END