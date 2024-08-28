*** Settings ***
Library    SSHLibrary
Resource    ../../Resources/Keywords/Cli.robot
#Resource    ../../Resources/Keywords/Variables.robot
Resource    ../../Resources/Keywords/Engine.robot

#Suite Setup    Connect to server as a dcuser
Suite Teardown    Close All Connections

*** Variables ***
${Host_name}    ieatrcx6577-1.athtem.eei.ericsson.se
${port_number}    22
${username}    dcuser
${password}    Eniq*1234



*** Test Cases ***
connect the ENIQ server and then will access the file
    
    
    Open Connection    ${Host_name}    ${port_number}    timeout=10
    Login    ${username}    ${password}
    #Write    cd /eniq/sw/conf
    #Write    ls
    #${output_1}    Read    delay=1s
    #Should Contain      ${output_1}     enmserverdetail    
    #Write    cat enmserverdetail 
    #${output_2}    Read    delay=1s
    #Should Contain    ${output_2}    10.149.33.203
    #Get latest file from directory    engine*
    Write    cd /eniq/log/sw_log/engine
    Write    ls -Art engine* | tail -n 1   
    ${output_1}    Read    delay=1s
    Write    cat engineHeap-2023-11-24.log 
    ${output_2}    Read    delay=1s

    #Should Contain     ${output_2}    Heap usage for 00:00 :380.631

    Log To Console    ${output_2}
    
    