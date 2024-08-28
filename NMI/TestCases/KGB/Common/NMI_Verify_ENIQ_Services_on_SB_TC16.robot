*** Settings ***
Suite Setup        Open Connection And Log In
Suite Teardown     Close All Connections
Library            SSHLibrary
Resource           ../../../Resources/resource.txt
 
*** Variables ***

*** Test Cases ***
Checking if ENIQ dwhdb service is running
    [Tags]                      II
    Set Client Configuration    timeout=25 seconds      prompt=#:
    ${output}=                  Execute Command         systemctl show -p ActiveState eniq-dwhdb | cut -f2 -d'=' | grep active
    Should Be Equal             ${output}               active

Checking if ENIQ repdb service is running
    [Tags]                      II
    Set Client Configuration    timeout=25 seconds      prompt=#:
    ${output}=                  Execute Command         systemctl show -p ActiveState eniq-repdb | cut -f2 -d'=' | grep active
    Should Be Equal             ${output}               active
	
Checking if ENIQ webserver service is running
    [Tags]                      II
    Set Client Configuration    timeout=25 seconds      prompt=#:
    ${output}=                  Execute Command         systemctl show -p ActiveState eniq-webserver | cut -f2 -d'=' | grep active
    Should Be Equal             ${output}               active
	
Checking if ENIQ lwphelper service is running
    [Tags]                      II
    Set Client Configuration    timeout=25 seconds      prompt=#:
    ${output}=                  Execute Command         systemctl show -p ActiveState eniq-lwphelper | cut -f2 -d'=' | grep active
    Should Be Equal             ${output}               active
	
Checking if ENIQ engine service is running
    [Tags]                      II
    Set Client Configuration    timeout=25 seconds      prompt=#:
    ${output}=                  Execute Command         systemctl show -p ActiveState eniq-engine | cut -f2 -d'=' | grep active
    Should Be Equal             ${output}               active
	
Checking if ENIQ scheduler service is running
    [Tags]                      II
    Set Client Configuration    timeout=25 seconds      prompt=#:
    ${output}=                  Execute Command         systemctl show -p ActiveState eniq-scheduler | cut -f2 -d'=' | grep active
    Should Be Equal             ${output}               active
	
Checking if ENIQ ddc service is running
    [Tags]                      II
    Set Client Configuration    timeout=25 seconds      prompt=#:
    ${output}=                  Execute Command         systemctl show -p ActiveState ddc | cut -f2 -d'=' | grep active
    Should Be Equal             ${output}               active
	
Checking if ENIQ connectd service is running
    [Tags]                      II
    Set Client Configuration    timeout=25 seconds      prompt=#:
    ${output}=                  Execute Command         systemctl show -p ActiveState eniq-connectd | cut -f2 -d'=' | grep active
    Should Be Equal             ${output}               active
	
Checking if ENIQ licmgr service is running
    [Tags]                      II
    Set Client Configuration    timeout=25 seconds      prompt=#:
    ${output}=                  Execute Command         systemctl show -p ActiveState eniq-licmgr | cut -f2 -d'=' | grep active
    Should Be Equal             ${output}               active
	
Checking if ENIQ rmiregistry service is running
    [Tags]                      II
    Set Client Configuration    timeout=25 seconds      prompt=#:
    ${output}=                  Execute Command         systemctl show -p ActiveState eniq-rmiregistry | cut -f2 -d'=' | grep active
    Should Be Equal             ${output}               active
	
Checking if ENIQ esm service is running
    [Tags]                      II
    Set Client Configuration    timeout=25 seconds      prompt=#:
    ${output}=                  Execute Command         systemctl show -p ActiveState eniq-esm | cut -f2 -d'=' | grep active
    Should Be Equal             ${output}               active

Checking if ENIQ sentinel service is running
    [Tags]                      Service
    Set Client Configuration    timeout=25 seconds      prompt=#:
    ${output}=                  Execute Command         systemctl show -p ActiveState licensing-sentinel.service | cut -f2 -d'=' | grep active
    Should Be Equal             ${output}               active

Checking if ENIQ sentinel service is enabled
    [Tags]                      Service
    Set Client Configuration    timeout=25 seconds      prompt=#:
    ${output}=                  Execute Command         systemctl status licensing-sentinel.service | grep -i enabled
    Should Contain              ${output}               enabled

Checking dwhdb service.
    [Tags]                         DB_service
    Open Connection                ${host}        port=${PORT}
    Login                          ${username}    ${password}    delay=1
    Log To Console                 Connected to server ${host}:${p}
    Set Client Configuration       timeout=25 seconds      prompt=#:
    ${output}=                     Execute Command         ps -eaf | grep -i dwhdb
    Should Contain                 ${output}               dwhdb

Checking dwhdb service is active. 
    [Tags]                         DB_service
    Open Connection                ${host}        port=${PORT}
    Login                          ${username}    ${password}    delay=1
    Log To Console                 Connected to server ${host}:${p}
    Set Client Configuration       timeout=25 seconds      prompt=#:
    ${output}=                     Execute Command         systemctl show eniq-dwhdb -p ActiveState | awk -F= '{print $2}'
    Should Be Equal                ${output}               active
