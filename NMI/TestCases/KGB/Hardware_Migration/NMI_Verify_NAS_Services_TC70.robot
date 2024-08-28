*** Settings ***
Suite Setup        Open Connection And Log In
Suite Teardown     Close All Connections
Library            SSHLibrary
Resource           ../../Resources/resource.txt

*** Test Cases ***
Checking NAS Service Status
    [Tags]                      Migration
    Set Client Configuration    timeout=25 seconds      prompt=#:
    ${output}=                  Execute Command         systemctl start NAS-online.service;systemctl status NAS-online.service | grep "Active: active (running)"
    Should Contain              ${output}               Active: active (running)
