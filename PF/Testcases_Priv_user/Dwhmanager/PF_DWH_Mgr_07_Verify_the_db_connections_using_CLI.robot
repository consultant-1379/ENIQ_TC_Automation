*** Settings ***
Library    SSHLibrary
Library    String
Resource    ../../Resources/Keywords/Engine.robot
Resource    ../../Resources/Keywords/Cli.robot
Resource    ../../Resources/Keywords/Variables.robot
Resource    ../../Resources/Keywords/repdb_connection.robot
    

*** Test Cases ***
Verify the db connections using CLI
    Open connection as root user
    Put File    ${EXEC_DIR}//PF//Scripts//test.bsh    /home/DMCI
    Execute the Command    dos2unix test.bsh
    ${output_02}=    Read    delay=1s
    ${etrlep_pwd}=    Execute Command    sudo ./test.bsh REP ETLREP | grep -i Password | cut -d ':' -f 2
    ${dwhrep_pwd}=    Execute Command     sudo ./test.bsh REP DWHREP | grep -i Password | cut -d ':' -f 2
    ${dc_pwd}=    Execute Command    sudo ./test.bsh DWH DC | grep -i Password | cut -d ':' -f 2
    Write    sudo su - dcuser
    ${output_01}=    Read    delay=1s
    #Put File    ${EXEC_DIR}//PF//Scripts//test.bsh    /var/tmp
    #Execute the Command    dos2unix test.bsh
    Write    dbisql -c "UID=dwhrep" -host localhost -port 2641 -nogui
    Write    ${dwhrep_pwd}
    ${Dwhrep_output}=    Read    delay=2s
    Verify the msg    ${Dwhrep_output}    (dwhrep) 
    Execute the Command    Exit
    Write    dbisql -c "UID=dc" -host localhost -port 2640 -nogui
    Write    ${dc_pwd}    
    ${dc_output}=    Read    delay=2s  
    Verify the msg    ${dc_output}    (dc)
    Execute the Command    Exit
    Write    dbisql -c "UID=etlrep" -host localhost -port 2641 -nogui
    Write    ${etrlep_pwd}    
    ${etlrep_output}=    Read    delay=2s     
    Verify the msg    ${etlrep_output}    (etlrep)
    Execute the Command    Exit

*** Keywords ***
Test Teardown
    Close All Connections