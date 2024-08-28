*** Settings ***
Documentation     Testing Monitoring
Library    SSHLibrary
Resource    ../../Resources/Keywords/Monitoring.robot
Resource     ../../Resources/Keywords/Variables.robot
Resource     ../../Resources/Keywords/Cli.robot



*** Test Cases ***
Verify monitor_heap.bsh and monitor_cache_usage.bsh scripts using CLI
    Connect to server as a dcuser
    ${monitor_heap}=    Execute Command    cd /eniq/sw/bin ; ./monitor_heap.bsh
    Verify the msg    ${monitor_heap}    Sourcing SYBASE.sh
    ${monitor_cache}=    Execute Command    cd /eniq/sw/bin ; ./monitor_cache_usage.bsh
    Verify the msg    ${monitor_cache}    SQL Anywhere Command File Hiding Utility Version

*** Keywords ***
Test Teardown
    Close All Connections    