*** Settings ***
Library    RPA.Browser.Selenium    
Library    SSHLibrary
Library    String
Library    Collections
Resource            ../../../Resources/login.resource
Test Setup        Open Connection And Log In
Test Teardown     Close All Connections
*** Variables ***
${host}    atvts4110.athtem.eei.ericsson.se
${port}    2251
${uname}     dcuser
${pwd}       Dcuser%12
${password_repdb}      Dwhrep12#
${username_repdb}      dwhrep
${database_repdb}      repdb
${clearcase}    https://clearcase-eniq.seli.wh.rnd.internal.ericsson.com/eniqdel
${password_dwhdb}      Dc12#
${username_dwhdb}      dc
${database_dwhdb}      dwhdb
${run}		go

*** Test Cases ***
TC 24 Verify Raw Table Loading 
    Write    cd /eniq/home/dcuser
	Read    delay=3s
	Set Client Configuration    prompt=eniqs[eniq_stats] {dcuser} #:    timeout=500
    Open clearcasevobs
    ${buildno}    Get Element Attribute    //table//a[text()='${package}']    href
    ${buildno}    Fetch From Right    ${buildno}    _b
    ${buildno}    Split String From Right    ${buildno}    .
    Write    echo -e "select basetablename from MeasurementTable where MTABLEID LIKE '%${package}:((${buildno}))%' and TABLELEVEL LIKE 'RAW';\\n${run}\\n" | isql -P ${password_repdb} -U ${username_repdb} -S ${database_repdb} -b
    ${table_names}    Read Until Prompt
    ${table_names}    Split String    ${table_names}    
    ${length}    Get Length    ${table_names}
    ${total_tables}    Evaluate    ${length}-3 
    FOR    ${i}    IN RANGE   0    ${total_tables}
        Write    echo -e "select rowstatus from ${table_names}[${i}] where datetime_id= '2023-03-14 10:15:00';\\n${run}\\n" | isql -P ${password_dwhdb} -U ${username_dwhdb} -S ${database_dwhdb} -b
        ${status}    Read Until Prompt
        ${status}    Split String    ${status}
        ${length}    Get Length    ${status}
        IF    ${length}<7
            Log To Console    ${\n}${table_names}[${i}] <--Table Data Showing Empty in Database.
        ELSE
            Log to console    ${\n}All Tables Data is loaded correctly.
        END
    END
BTFT Verifying Tables data Loading
    Write    cd /eniq/home/dcuser
	Read    delay=2s
	Set Client Configuration    prompt=eniqs[eniq_stats] {dcuser} #:    timeout=500
    Write    echo -e "Select Top 1 dataname from Measurementkey where typeid like '${package}:%' and iselement like'1' and uniquekey like '1'\\n${run}\\n" | isql -P ${password_db} -U ${username} -S ${database} -b
	${nodename}=    Read Until Prompt
    ${nodename}    Split String    ${nodename}
    # ${output4}=    Execute Command    cd /eniq/home/dcuser && rm -rf BT-FT_Script && rm -rf BT-FT_Log && unzip ${btftPkgName} && cd BT-FT_Script/ && echo -e "${pkgnamerb} \\n ${datetime} \\n ${nodename}[0] \\n ${nodeversion} \\n ${date} \\ n 2 \\n" | ./BT-FT_script.sh
