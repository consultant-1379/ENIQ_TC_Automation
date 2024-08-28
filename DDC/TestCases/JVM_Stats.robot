*** Settings ***
Test Setup        Open Connection And Log In
Test Teardown     Close All Connections
Library           SSHLibrary
Library           DateTime
Library           DependencyLibrary
Resource          ../Resources/Resource.resource


*** Test Cases ***
Checking for SIM service installation
    [Documentation]        Checking for SIM Service installed or not
    [Tags]                 JVM_Stats
    ${sim_file}=           Execute Command    ps -eaf | grep -w "ESM" | grep -v grep | wc -l
    Set Global Variable    ${sim_file}
    Should Be Equal        ${sim_file}    1

Checking for SIM file in ENIQ
    Depends on test        Checking for SIM service installation
    [Documentation]        Checking for sim.xml file in /opt/ericsson/ERICddc/monitor/appl/ENIQ directory
    [Tags]                 JVM_Stats
    Check File Exists      /opt/ericsson/ERICddc/monitor/appl/ENIQ/sim.xml

Checking for SIM file size in ENIQ
    Depends on test        Checking for SIM file in ENIQ
    [Documentation]        Checking for non empty sim.xml file in /opt/ericsson/ERICddc/monitor/appl/ENIQ directory
    [Tags]                 JVM_Stats
    Check File Size        /opt/ericsson/ERICddc/monitor/appl/ENIQ/sim.xml

Checking for instr file
    Depends on test        Checking for SIM file size in ENIQ
    [Documentation]        Checking for instr.txt is present in /eniq/log/ddc_data/${hostname}/${date_dmy} directory
    [Tags]                 JVM_Stats
    Check File Exists      /eniq/log/ddc_data/${hostname}/${date_dmy}/instr.txt

Checking for size of the instr file
    Depends on test        Checking for instr file
    [Documentation]        Checking for non empty instr.txt file in /eniq/log/ddc_data/${hostname}/${date_dmy} directory
    [Tags]                 JVM_Stats
    Check File Size        /eniq/log/ddc_data/${hostname}/${date_dmy}/instr.txt

Checking for sim file in instr
    Depends on test        Checking for size of the instr file
    [Documentation]        Checking for sim.xml file in /eniq/log/ddc_data/${hostname}/${date_dmy}/instr directory
    [Tags]                 JVM_Stats
    Check File Exists      /eniq/log/ddc_data/${hostname}/${date_dmy}/instr/sim.xml

Checking for sim file size in instr
    Depends on test        Checking for sim file in instr
    [Documentation]        Checking for non empty sim.xml file in /eniq/log/ddc_data/${hostname}/${date_dmy}/instr directory
    [Tags]                 JVM_Stats
    Check File Size        /eniq/log/ddc_data/${hostname}/${date_dmy}/instr/sim.xml
