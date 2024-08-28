*** Settings ***
Resource          ../Resources/login.resource
Library           ./server.py
Library    RPA.RobotLogListener
Test Setup        Open Connection And Log In
Test Teardown     Close All Connections
*** Variables ***
${sql_query}    select INTERFACENAME from  InterfaceTechpacks where TECHPACKNAME like( select distinct TECHPACKNAME from  TechPackDependency where VERSIONID LIKE '${pkg}:%'and TECHPACKNAME like 'DIM_%');
*** Test Cases ***
Loading Topo Files
    Loading topology files
*** Keywords *** ***
 Loading topology files
    Write    echo -e "${sql_query}\\n${run}\\n" | isql -P ${password_db} -U ${username} -S ${database} -b
    ${output1}=    Read    delay=3s
    Log To Console    ${output1}
    @{intfDIM}    Filter Interfaces    ${output1}
    FOR    ${currintf}    IN    @{intfDIM}
       Write    echo -e "select DATAFORMATTYPE from DataInterface where INTERFACENAME LIKE '${currintf}'\\n${run}\\n" | isql -P ${password_db} -U ${username} -S ${database} -b
	    ${par}    Read    delay=3s
	    ${parser_name}    Filter Name    ${par} 
       Write    engine -e startSet '${currintf}-eniq_oss_1' 'Adapter_${currintf}_${parser_name}'
       Read    delay=3s
    END
    
    