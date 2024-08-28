*** Settings ***
Resource    ../../Resources/login.resource
Library    RPA.RobotLogListener
Test Setup        Open Connection And Log In
Test Teardown     Close All Connections  
Library    ../TestCases/server.py
*** Variables ***
${sql_query}    select INTERFACENAME from  InterfaceTechpacks where TECHPACKNAME like( select distinct TECHPACKNAME from  TechPackDependency where VERSIONID LIKE '${pkg}:%'and TECHPACKNAME like 'DIM_%');
${sql_query1}    select distinct substr(CONFIG,charindex('basetable',CONFIG)+10) test from Transformation where target like 'dc_release' and TRANSFORMERID like '${pkg}:%'
${url}            ${urlNexusConst}/TP_KPI_Script/ 
*** Test Cases ***
Matching modified time
    Loading topology files
    open command line and query
*** Keywords *** ***
 Loading topology files
    Write    echo -e "${sql_query}\\n${run}\\n" | isql -P ${password_db} -U ${username} -S ${database} -b
    ${output1}=    Read    delay=3s
    Log To Console    ${output1}
    @{intfDIM}    Filter Interface Name    ${output1}
    FOR    ${currintf}    IN    @{intfDIM}    
       Write    echo -e "select DATAFORMATTYPE from DataInterface where INTERFACENAME LIKE '${currintf}'\\n${run}\\n" | isql -P ${password_db} -U ${username} -S ${database} -b
	    ${par}    Read    delay=3s
	    ${parser_name}    Filter Name    ${par} 
       Write    engine -e startSet '${currintf}-eniq_oss_1' 'Adapter_${currintf}_${parser_name}'
       Read    delay=3s
    END
 open command line and query 
    Write    echo -e "${sql_query1}\\n${run}\\n" | isql -P ${password_db} -U ${username} -S ${database} -b
    ${output1}=    Read    delay=3s
    Log To Console    ${output1}
    ${topotable}=    Filter Topotable Name    ${output1}
    Write     echo -e "select MODIFIED from ${topotable}\\n${run}\\n" | isql -P Dc12# -U dc -S dwhdb -b
    ${output2}=    Read    delay=3s
    Log To Console    ${output2}
    ${datetime}=    Filter Date    ${output2}
    ${timefromdb}=    Fetch From Right    ${datetime}    ${SPACE}
    check the dependent topotp
    ${timefromlog}=    server.Getmodifiedtime    ${deptopopkg}[0]    ${topotable}    ${host}    ${port}    ${uname}    ${pwd}  
    ${res}=    Get Lines Containing String    ${timefromdb}    ${timefromlog}
    IF    '${res}' == ''
        #FAIL
        Log To Console    modified coloumn time is not matching
    ELSE
        Log To Console    modified coloumn time is matching
    END
    