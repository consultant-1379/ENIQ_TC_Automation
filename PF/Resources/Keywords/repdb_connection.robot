

*** Keywords ***

connect to rep db
    Adding datebase file in SERVER
    Execute the Command    dos2unix test.bsh
    ${dwhrep_pwd}=    Execute Command    ./test.bsh REP DWHREP | grep -i Password | cut -d ':' -f 2
    Write    dbisql -c "UID=dwhrep;PWD=${dwhrep_pwd};eng=repdb" -host localhost -port 2641 -nogui
    ${output}=    Read    delay=2s
    Log     ${output}
    [Return]    ${output}

Connect to dwhrep in CLi
    Write    dbisql -c "UID=dwhrep" -host localhost -port 2641 -nogui
    ${dwhrep_pwd}=    Execute Command    ./test.bsh REP DWHREP | grep -i Password | cut -d ':' -f 2
    Write    ${dwhrep_pwd}
    ${output}=    Read    delay=2s
    Log     ${output}
    [Return]    ${output}

Connect to repdb in CLI
    ${dc_pwd}=    Execute Command    ./test.bsh DWH DC | grep -i Password | cut -d ':' -f 2
    Write    dbisql -c "UID=dc" -host localhost -port 2640 -nogui
    Write    ${dc_pwd}
    ${output}=    Read    delay=2s
    Log     ${output}
    [Return]    ${output}

Connect to dc username in CLI
    ${dc_pwd}=    Execute Command    ./test.bsh DWH DC | grep -i Password | cut -d ':' -f 2
    Write    dbisql -c "UID=dc" -host localhost -port 2640 -nogui
    Write    ${dc_pwd}
    ${output}=    Read    delay=2s
    Log     ${output}
    [Return]    ${output}

Adding datebase file in SERVER
    Put File    ${EXEC_DIR}//PF//Scripts//test.bsh    /eniq/home/dcuser

Connect to etlrep connection in CLI
    ${etlrep_pwd}=    Execute Command     ./test.bsh REP ETLREP | grep -i Password | cut -d ':' -f 2
    Write    dbisql -c "UID=etlrep" -host localhost -port 2641 -nogui
    Write    ${etlrep_pwd}
    ${output}=    Read    delay=2s
    Log     ${output}
    [Return]    ${output}
    
    



    

    