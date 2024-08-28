*** Settings ***
Resource    ../../Resources/login.resource
Library    RPA.RobotLogListener
Test Setup        Open Connection And Log In
Test Teardown     Close All Connections  
Library    ../TestCases/server.py

*** Variables ***
${pkg}    DC_E_AFG
${sql_query}    select distinct substr(CONFIG,charindex('basetable',CONFIG)+10) test from Transformation where target like 'dc_release' and TRANSFORMERID like '${pkg}:%'
${url}            ${urlNexusConst}/TP_KPI_Script/   
*** Test Cases ***
topology data validation testcase
    open command line and query
*** Keywords *** ***
open command line and query 
    Write    echo - "true"
    Write    echo -e "select distinct substr(CONFIG,charindex('basetable',CONFIG)+10) test from Transformation where target like 'dc_release' and TRANSFORMERID like '${pkg}:%'\\n${run}\\n" | isql -P ${password_db} -U ${username} -S ${database} -b
    ${output1}=    Read    delay=20s
    Log To Console    ${output1}
    ${topotable}=    Filter Topotable Name    ${output1}
    Write    echo -e "select DATANAME from ReferenceColumn where typeid like '%${topotable}' and DATANAME like '%[_]name%'\\n${run}\\n" | isql -P ${password_db} -U ${username} -S ${database} -b
    ${output2}=    Read    delay=30s
    Log To Console    ${output2}
    # ${nodeVersiontable}=    Filter Node Name    ${output2}
    # Write    echo -e "select distinct ${nodeVersiontable} from ${topotable}\\n${run}\\n" | isql -P Dc12# -U dc -S dwhdb -b
    # ${output3}=    Read    delay=3s
    # ${nodename}=    Fetch From Left    ${nodeVersiontable}    _
    # ${nodename}=    Catenate     SEPARATOR=_    ${nodename}    NAME    
    # ${nodeversion}=    Filter Node Name    ${output3}
    # Write    echo -e "select CREATED from ${topotable}\\n${run}\\n" | isql -P Dc12# -U dc -S dwhdb -b
    # ${output3}=    Read    delay=3s
    # ${datetime}=    Filter Date    ${output3}
    # ${date}=    Fetch From Left    ${datetime}    ${SPACE}
    # full package name
    # Open Available Browser    ${url}    headless=true
    # ${latestBt_Ft}    Get Element Attribute    //*[contains(text(),'BT_FT_')]    href
    # ${btftPkgName}=    Fetch From Right    ${latestBt_Ft}    /
    # downloading Btft file on server    ${latestBt_Ft}
    # ${output4}=    Execute Command    cd /eniq/home/dcuser && rm -rf BT-FT_Script && rm -rf BT-FT_Log && unzip ${btftPkgName} && cd BT-FT_Script/ && echo -e "${pkgnamerb} \\n ${datetime} \\n ${nodename} \\n ${nodeversion} \\n ${date} \\ n 2 \\n" | ./BT-FT_script.sh
    
    