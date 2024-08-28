*** Settings ***
Suite Setup        Open Connection And Log In
Suite Teardown     Close All Connections
Library            SSHLibrary
Library            DateTime
Library            DependencyLibrary
Resource           ../Resources/Resource.resource


*** Test Cases ***
Checking for sim file in SIM source
    [Documentation]       Checking for sim.log file in /eniq/log/sw_log/sim directory
    [Tags]                SIM
    Check File Exists     /eniq/log/sw_log/sim/sim.log

Checking for sim file size in SIM source
    Depends on test       Checking for sim file in SIM source
    [Documentation]       Checking for non empty sim.log file in/eniq/log/assureddc/sim directory
    [Tags]                SIM
    Check File Size       /eniq/log/sw_log/sim/sim.log

Checking for sim file in SIM destination
    Depends on test       Checking for sim file size in SIM source
    [Documentation]       Checking for sim.log file in /eniq/log/ddc_data/${hostname}/${date_dmy}/plugin_data/sim directory
    [Tags]                SIM
    Check File Exists     /eniq/log/ddc_data/${hostname}/${date_dmy}/plugin_data/sim/sim.log

Checking for sim file size in SIM destination
    Depends on test       Checking for sim file in SIM destination
    [Documentation]       Checking for non empty sim.log file in /eniq/log/ddc_data/${hostname}/${date_dmy}/plugin_data/sim directory
    [Tags]                SIM
    Check File Size       /eniq/log/ddc_data/${hostname}/${date_dmy}/plugin_data/sim/sim.log
