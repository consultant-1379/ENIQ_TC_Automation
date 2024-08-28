*** Settings ***
Library    RPA.Browser.Selenium
Library    OperatingSystem
Library		SSHLibrary
Library    Collections
Library    RPA.Tables
Library    String
# Test Setup    Open Connection And Log In
Test Teardown     Close All Connections
Library        ./tp.py
Library        list_of_aggregated_failed_and_not_loaded_tables.py
*** Variables ***
${host}                    atvts4031.athtem.eei.ericsson.se
${port}                    2251
${uname}                   dcuser
${pwd}                     Dcuser%12
${password_dwhdb}          Dc12# 
${username_dwhdb}          dc
${database_dwhdb}          dwhdb
${package}                 DC_E_UPG
${password_db}             Dwhrep12#
${username}                dwhrep
${database}                repdb
${run}		               go
${path}                    H://
***Tasks***
Open Connection And Log In
    ${index}    Open Connection    ${host}      port=${port}    timeout=10
    Set Global Variable    ${index}
    Login    ${uname}    ${pwd}  
Test
    Write    cd /eniq/home/dcuser
    ${tt}    Read    delay=15s
TC 35 Verify Aggregating RAW tables 
    ${date}=    Execute Command    date -d '-1 day' '+%Y-%m-%d'
	Set Global Variable    ${date}
    Set Client Configuration    prompt=eniqs[eniq_stats] {dcuser} #:    timeout=300
    # Test
    Write    echo -e "select distinct basetablename,* from measurementtable WHERE MTABLEID like '%${package}%' and TABLELEVEL like '%RAW%'\\n${run}\\n" | isql -P ${password_db} -U ${username} -S ${database} -b
    ${Get_all_raw_tables}    Read Until Prompt   
    Log    ${Get_all_raw_tables}
    ${length_of_all_raw_tables}    Get Length    ${Get_all_raw_tables}
    Log    ${length_of_all_raw_tables}
    Write    echo -e "select basetablename from MeasurementTable where MTABLEID LIKE '${package}:%' and TABLELEVEL in('DAY','COUNT')\\n${run}\\n" | isql -P ${password_db} -U ${username} -S ${database} -b
    ${out}    Read Until Prompt
	${table_name}    Get Table Names    ${package}    ${out}
	FOR    ${table}    IN    @{table_name}
		Write     engine -e startSet '${package}' '${table}' 
		${out}    Read Until Prompt   
		Should Contain    ${out}    Start set requested successfully    Failed Aggregation for ${table}
	END
    Write    echo -e "/eniq/sw/bin/engine -e startSet DWH_MONITOR UpdateFirstLoadings\\n" | isql -P ${password_db} -U ${username} -S ${database} -b
    ${Firstloading}    Read Until Prompt    
    Write    echo -e "/eniq/sw/bin/engine -e startSet DWH_MONITOR AutomaticREAggregation\\n" | isql -P ${password_db} -U ${username} -S ${database} -b
    ${Aggregation}    Read Until Prompt 
TC 36 Show Aggregation
    ${date}=    Execute Command    date -d '-1 day' '+%Y-%m-%d'
	Set Global Variable    ${date}
    Set Client Configuration    prompt=eniqs[eniq_stats] {dcuser} #:    timeout=3600
    # Test
    Write     echo -e " Select AGGREGATION,DATE_ID,STATUS,AGGREGATIONSCOPE from LOG_AggregationStatus where DATE_ID = '${date}' and AGGREGATION like '%${package}%' and AGGREGATIONSCOPE like '%DAY%'\\n${Run}\\n"| isql -P ${password_dwhdb} -U ${username_dwhdb} -S ${database_dwhdb} -b
    ${SQLquery}      Read Until Prompt  
    ${flag}     ${message}=  Sql Output To Remove Spaces    ${SQLquery}
    IF  ${flag} 
        Log To Console    ${\n}${message}
    ELSE
        Log     ${\n}${message}
        Fail    Testcase got failed because there are some tables which are either in failed state or not loaded state!
    END 
TC 41 RANKBHCP0 View
    Write     echo -e " Select AGGREGATION,DATE_ID,STATUS,AGGREGATIONSCOPE from LOG_AggregationStatus where DATE_ID = '${date}' and AGGREGATION like '%${package}%' and AGGREGATIONSCOPE like '%DAY%'\\n${Run}\\n"| isql -P ${password_dwhdb} -U ${username_dwhdb} -S ${database_dwhdb} -b
    ${SQLquery}      Read Until Prompt 
    ${show_table_names}    Values    ${SQLquery}
    Log    ${show_table_names}
    Write     echo -e "Select bhobject from Busyhour where BHCRITERIA NOT like '' and BHLEVEL like '%${package}%' and BHTYPE like '%CP%'and ENABLE = 1\\n${Run}\\n"| isql -P ${password_db} -U ${username} -S ${database} -b
    ${bhobject}       Read Until Prompt   
    ${bhobject2}     values    ${bhobject} 
    Log     ${bhobject2}
    ${bhobject3}    Split String    ${bhobject2}
    Log    ${bhobject3}
    Write     echo -e "Select bhtype from Busyhour where BHCRITERIA NOT like '' and BHLEVEL like '%${package}%' and BHTYPE like '%CP%'and ENABLE = 1\\n${Run}\\n"| isql -P ${password_db} -U ${username} -S ${database} -b
    ${bhtype}       Read Until Prompt   
    ${bhtype2}     values    ${bhtype} 
    Log     ${bhtype2}
    ${bhtype3}    Split String    ${bhtype2}
    Log    ${bhtype3}
    ${bhobject_and_bhtype}    combining_bhobject_and_bhtype    ${bhobject3}    ${bhtype3}
    Log    ${bhobject_and_bhtype}
    Log    ${package}_${bhobject2}BH_RANKBH_${bhobject_and_bhtype}    
    ${failed_tables}=  list_of_failed_dependency_tables    ${show_table_names}
    Log    ${failed_tables}
    ${abc}    failed_tables_str_conversion   ${failed_tables}
    Log    ${abc}
    ${contains}=    Run Ke yword And Return Status    Should Contain Any      ${abc}    ${package}_${bhobject2}BH_RANKBH_${bhobject_and_bhtype}    
    IF    '${contains}' == 'True'
        Fail    Testcase is Failed as ${package}_${bhobject2}BH_RANKBH_${bhobject_and_bhtype} table is in FAILED STATE.
    ELSE
        ${not_loaded}=   list_of_not_loaded_tables       ${show_table_names}
        Log    ${not_loaded}
        ${pqr}    Not Loaded Tables    ${not_loaded}
        ${contains}=    Run Keyword And Return Status    Should Contain   ${pqr}    ${package}_${bhobject2}BH_RANKBH_${bhobject_and_bhtype}
        IF    '${contains}' == 'True'
            Log    ${package}_${bhobject2}BH_RANKBH_${bhobject_and_bhtype} is present in NOT LOADED STATE! 
            Fail    Testcase is Failed as ${package}_${bhobject2}BH_RANKBH_${bhobject_and_bhtype} is in NOTLOADED STATE.    
        ELSE 
            ${aggregated_tables}    list_of_aggregated_tables    ${show_table_names}
            Log    ${aggregated_tables}
            ${x2y2}    Aggregated Tables    ${aggregated_tables}
            ${contains}=    Run Keyword And Return Status    Should Contain Any  ${x2y2}    ${package}_${bhobject2}BH_RANKBH_${bhobject_and_bhtype}
            IF    '${contains}' == 'True'
                Write     echo -e "Select * from ${package}_${bhobject2}BH_RANKBH_${bhobject_and_bhtype}\\n${Run}\\n"| isql -P ${password_dwhdb} -U ${username_dwhdb} -S ${database_dwhdb} -b
                ${rankbh_cp0_table_name}    Read Until Prompt
                Log    ${rankbh_cp0_table_name}
                Write     echo -e "Select bhlevel,bhobject,bhtype from busyhour where versionid like '%${package}%' and bhtype like '%CP0%' and BHCRITERIA NOT like ''\\n${Run}\\n"| isql -P ${password_db} -U ${username} -S ${database} -b
                ${get_rankbh_level}    Read Until Prompt
                ${x2}    Strip String    ${get_rankbh_level} 
                Log    ${x2}  
                ${y2}     Values    ${x2}
                Log    ${y2}
                ${z3}     Split String    ${y2}
                Log    ${z3}
                Log    ${z3}[0]
                Log    ${z3}[1]
                Log    ${z3}[2]
                Write  echo -e "Select HOUR_ID,BHTYPE from ${z3}[0]_RANKBH_${z3}[1]_${z3}[2] where DATE_ID='${date}'\\n${Run}\\n"| isql -P ${password_dwhdb} -U ${username_dwhdb} -S ${database_dwhdb} -b
                ${RANKBHCP0_SQL_query}      Read Until Prompt
                ${RANKBHCP0_SQL_query_output}    Split String    ${RANKBHCP0_SQL_query}   
                Log    ${RANKBHCP0_SQL_query_output}
                Write     echo -e "Select basetablename from measurementtable where mtableid like '%${package}%' and tablelevel like '%daybh%' order by basetablename asc\\n${Run}\\n"| isql -P ${password_db} -U ${username} -S ${database} -b
                ${DAYBH2}      Read Until Prompt
                Log To Console  ${\n}    ${DAYBH2} 
                ${xyz2}    Strip String    ${DAYBH2}
                Log    ${xyz2}
                ${xyz3}    Values    ${xyz2}
                Log    ${xyz3}
                ${xyz4}    Split String    ${xyz3}
                Log    ${xyz4}
                Log    ${xyz4}[0]
                Write  echo -e "Select busyhour,bhtype from ${xyz4}[0] where DATE_ID= '${date}'\\n${Run}\\n"| isql -P ${password_dwhdb} -U ${username_dwhdb} -S ${database_dwhdb} -b
                ${daybhout}      Read Until Prompt    
                ${daybh_output}    Split String    ${daybhout}   
                Log    ${daybh_output}
                Write  echo -e "Select HOUR_ID,BHTYPE from ${z3}[0]_RANKBH_${z3}[1]_${z3}[2] where bhvalue=(Select max(bhvalue) from ${z3}[0]_RANKBH_${z3}[1]_${z3}[2] where DATE_ID='${date}')\\n${Run}\\n"| isql -P ${password_dwhdb} -U ${username_dwhdb} -S ${database_dwhdb} -b
                ${maxhourid}      Read Until Prompt
                ${maxhourid_output}    Split String    ${maxhourid}  
                Log    ${maxhourid_output}
                Write     echo -e "Select BHCRITERIA,VERSIONID from Busyhour WHERE VERSIONID like '%${package}%' and BHTYPE like '%CP0%' and bhcriteria not like ''//DESCRIPTION like '%test%'\\n${Run}\\n"| isql -P ${password_db} -U ${username} -S ${database} -b
                ${busyhour_query}      Read Until Prompt
                Log    ${busyhour_query}
                ${busyhour_query_output}    Split String    ${busyhour_query}    \r\n
                Log    ${busyhour_query_output}
                ${a}    Strip String    ${busyhour_query_output}[0]
                Log     ${busyhour_query_output}[0]
                ${b}    Split String From Right   ${busyhour_query_output}[0]    (    
                ${x2}    Strip String    ${b}[0]
                ${z}    Strip String     ${x2} 
                ${c}    Strip String    ${b}[1]
                ${d}    Remove String    ${b}[1]   )
                ${e}    Strip String    ${d}
                Log     ${e}
                Log    ${busyhour_query_output}[1]
                ${abc}    Strip String    ${busyhour_query_output}[1]
                Log    ${abc}
                Write        echo -e "select * from Measurementcounter where DATANAME like '%${e}%' and TYPEID like '%${abc}%'\\n${Run}\\n"| isql -P ${password_db} -U ${username} -S ${database} -b
                ${query_measurement_counter}      Read Until Prompt  
                ${query_measurement_counter_output}    Split String    ${query_measurement_counter}   
                Log    ${query_measurement_counter_output}[0]
                ${f}    Split String From Right   ${query_measurement_counter_output}[0]    :
                Log    ${f}[2]
                Switch Connection    ${index}
                Write     echo -e "Select HOUR_ID,BHTYPE from ${z3}[0]_RANKBH_${z3}[1]_${z3}[2] where bhvalue=(Select max(bhvalue) from ${z3}[0]_RANKBH_${z3}[1]_${z3}[2] where DATE_ID='${date}') \\n${Run}\\n"| isql -P ${password_dwhdb} -U ${username_dwhdb} -S ${database_dwhdb} -b
                ${maxbhvalue}    Read Until Prompt     
                Log     ${maxbhvalue}
                ${maxbhvalueone}    Strip String    ${maxbhvalue}
                ${mm}     Split String    ${maxbhvalueone}
                Log    ${mm}[0]
                Write     echo -e "Select sum(${e}) from ${f}[2]_RAW where DATE_ID = '${date}' and HOUR_ID = ${mm}[0]\\n${Run}\\n"| isql -P ${password_dwhdb} -U ${username_dwhdb} -S ${database_dwhdb} -b
                ${counter}    Read Until Prompt   
                Log    ${counter}
                ${sum_of_counter_output}    Values   ${counter}
                Write     echo -e "Select sum(BHVALUE) from ${z3}[0]_RANKBH_${z3}[1]_${z3}[2] where bhvalue=(Select max(bhvalue) from ${z3}[0]_RANKBH_${z3}[1]_${z3}[2] where DATE_ID ='${date}')\\n${Run}\\n"| isql -P ${password_dwhdb} -U ${username_dwhdb} -S ${database_dwhdb} -b
                ${Bhvalue}    Read Until Prompt   
                ${sum_of_Bhvalue_output}    Values    ${Bhvalue}
                Log    ${sum_of_Bhvalue_output}
                ${bhvalue_out}    Valueone    ${sum_of_Bhvalue_output}
                Log    ${bhvalue_out}            
                IF    ${sum_of_counter_output} == ${bhvalue_out}
                    Log To Console    RANKBH CP0 Testcase is Passed!
                ELSE
                    Fail    CP0 Values mismatch! Hence, Testcase Failed!
                END     

                ELSE
                    Fail    
                END                    
            END    
    END
