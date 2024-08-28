*** Settings ***

Library    SSHLibrary
Library    Process
Library    String
#Resource    ../../../TP/TestCases/common_techpack.robot
Library    RPA.Browser.Selenium
Library    nr.py  
Library    Collections
Test Teardown    Close Connection

*** Variables ***
${sql_query}    select MCC,MNC from DIM_E_LTE_NR_NRCELLCU_PLMN
${host}    atvts4134.athtem.eei.ericsson.se
${port}    2251
${uname}    dc
${pwd}    Dc12#
${run}		go
${database}      dwhdb
${path}    H:

*** Test Cases ***
Test1
    Creating Connection
    Get mcc and mnc values from DB
    Get mcc and mnc values from xml file
    Comparsion

*** Keywords *** ***
Creating Connection
    ${index}    Open Connection    ${host}    port=${port}    timeout=10    
    Set Global Variable    ${index}
    Login    dcuser     Dcuser%12
Get mcc and mnc values from DB
...    Write    echo -e "${sql_query}\\n${run}\\n" | isql -P ${pwd} -U ${uname} -S ${database} -b
       ${output1}=    Read    delay=7s
       Set Global Variable    ${output1}
       Log To Console    ${\n}${output1}
       
Get mcc and mnc values from xml file
    Execute Command    cd /eniq/home/ && mkdir nr
    Put File    ${path}/ENIQ_TC_Automation/TP/Resources/TopologyFiles/NR/*.xml    /eniq/home/nr
    ${output2}=    Read    delay=7s
    ${engine_nr_file_name}    Execute Command     cd /eniq/home/nr && ls -Art *.xml
    ${y}    Split Command Line    ${engine_nr_file_name}
    @{getmccmnc}    Create List
    FOR    ${intf_name}    IN    @{y}
        ${getmcc}    Execute Command    awk -F "[><]" '/mcc/{print $3}' /eniq/home/${intf_name}
        ${getmnc}    Execute Command    awk -F "[><]" '/mnc/{print $3}' /eniq/home/${intf_name}
        ${getmcc} =	Split String	${getmcc}    \n	
        ${getmnc}=  Split String    ${getmnc}    \n  
        Log To Console      ${\n}getmcc ${getmcc} ${\n}getmnc ${getmnc}
        Append To List    ${getmccmnc}     ${getmcc}
        Append To List    ${getmccmnc}     ${getmnc}
        Log To Console    ${\n}getmccmnc ${getmccmnc}
        Set Global Variable    ${getmccmnc}
    END
Comparsion
    ${output2}    nr.Fromdb    ${output1}    ${getmccmnc}
    ${del_dir}    Execute Command    cd /eniq/home/ && rm -rf nr

    
    
    


   
