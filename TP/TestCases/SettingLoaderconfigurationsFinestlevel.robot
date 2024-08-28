*** Settings ***
Resource          ../Resources/login.resource
Library           ./server.py
Library    RPA.RobotLogListener
Test Setup        Open Connection And Log In
Test Teardown     Close All Connections
*** Variables ***
${sql_query}    select INTERFACENAME from  InterfaceTechpacks where TECHPACKNAME like( select distinct TECHPACKNAME from  TechPackDependency where VERSIONID LIKE '${pkg}:%'and TECHPACKNAME like 'DIM_%');
*** Test Cases ***
setting loader configuration to finest
    set to finest
*** Keywords *** ***
 set to finest
    check the dependent topotp
    Write    echo -e "${sql_query}\\n${run}\\n" | isql -P ${password_db} -U ${username} -S ${database} -b
    ${output1}=    Read    delay=3s
    Log To Console    ${output1}
    Filter Intf Name    ${deptopopkg}     ${output1}    ${host}    ${uname}    ${pwd}
    
    