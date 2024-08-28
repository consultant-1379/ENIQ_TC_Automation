*** Settings ***
Library    SSHLibrary
Resource     ../../Resources/Keywords/Variables.robot
Resource     ../../Resources/Keywords/Cli.robot
Resource    ../../Resources/Keywords/Engine.robot
Resource    ../../Resources/Keywords/repdb_connection.robot


*** Test Cases ***
Verify the Check if there are any partition in an inactive state in the CLI
    Open connection as root user
    Write    sudo su - dcuser
    ${output}=    Read    delay=1s
    Write    /eniq/sw/installer/getPassword.bsh -u DWHREP | awk '{print $NF}'
    ${dwhrep_pwd}=    Read    delay=1s
    Write    dbisql -c "UID=dwhrep" -host localhost -port 2641 -nogui
    Write    ${dwhrep_pwd}
    ${output_1}=    Read    delay=1s
    ${DWH_partition}=    Execute the Command    Select TABLENAME From DWHPartition Where STATUS != 'ACTIVE'
    Verify the zero rows in CLI    ${DWH_partition}    (0 rows)
    [Teardown]    Test Teardown
    

*** Keywords ***
Test Teardown
    Close All Connections