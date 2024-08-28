*** Settings ***
Resource          ../Resources/login.resource
Library           ./server.py
Test Setup        Open Connection And Log In
Test Teardown     Close All Connections

*** Variables ***
${sql_query}    select INTERFACENAME from  InterfaceTechpacks where TECHPACKNAME like( select distinct TECHPACKNAME from  TechPackDependency where VERSIONID LIKE '${pkg}:%'and TECHPACKNAME like 'DIM_%');

*** Tasks ***
Check the adapter logs in sw_logs/engine
    checking adapter logs

*** Keywords ***
checking adapter logs
    check the dependent topotp
    Write    echo -e "${sql_query}\\n${run}\\n" | isql -P ${password_db} -U ${username} -S ${database} -b
    ${output1}=    Read    delay=3s
    Log To Console    ${output1} 
    @{checkForDir}=    Int And Dim Name    ${deptopopkg}    ${output1}
    FOR    ${element}    IN    @{checkForDir}
        Checking Log Of Dim Intf    ${element}    ${host}    ${port}    ${uname}    ${pwd} 
    END