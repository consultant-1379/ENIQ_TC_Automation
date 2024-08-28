*** Settings ***
Suite Setup        Open Connection and Log In
Suite Teardown     Close All Connections
Library            SSHLibrary
Resource           ../../Resources/resource.txt
 
*** Variables ***

*** Test Cases ***
Open Connection And Log In to coordinator
    [Tags]                      II-Coordinator
	Open Connection             ${host}        port=${PORT}
	Login                       ${username}    ${password}    delay=1
	Log To Console              Connected to server ${host}:${p}

Checking if ENIQ dwhdb service is running on coordinator
    [Tags]                      II-Coordinator
    Set Client Configuration    timeout=25 seconds      prompt=#:
    ${output}=                  Execute Command         systemctl show -p ActiveState eniq-dwhdb | cut -f2 -d'=' | grep active
    Should Be Equal             ${output}               active

Checking if ENIQ repdb service is running on coordinator
    [Tags]                      II-Coordinator
    Set Client Configuration    timeout=25 seconds      prompt=#:
    ${output}=                  Execute Command         systemctl show -p ActiveState eniq-repdb | cut -f2 -d'=' | grep active
    Should Be Equal             ${output}               active
	
Checking if ENIQ webserver service is running on coordinator
    [Tags]                      II-Coordinator
    Set Client Configuration    timeout=25 seconds      prompt=#:
    ${output}=                  Execute Command         systemctl show -p ActiveState eniq-webserver | cut -f2 -d'=' | grep active
    Should Be Equal             ${output}               active
	
Checking if ENIQ scheduler service is running on coordinator
    [Tags]                      II-Coordinator
    Set Client Configuration    timeout=25 seconds      prompt=#:
    ${output}=                  Execute Command         systemctl show -p ActiveState eniq-scheduler | cut -f2 -d'=' | grep active
    Should Be Equal             ${output}               active
	
Checking if ENIQ ddc service is running on coordinator
    [Tags]                      II-Coordinator
    Set Client Configuration    timeout=25 seconds      prompt=#:
    ${output}=                  Execute Command         systemctl show -p ActiveState ddc | cut -f2 -d'=' | grep active
    Should Be Equal             ${output}               active
	
Checking if ENIQ connectd service is running on coordinator
    [Tags]                      II-Coordinator
    Set Client Configuration    timeout=25 seconds      prompt=#:
    ${output}=                  Execute Command         systemctl show -p ActiveState eniq-connectd | cut -f2 -d'=' | grep active
    Should Be Equal             ${output}               active
	
Checking if ENIQ licmgr service is running on coordinator
    [Tags]                      II-Coordinator
    Set Client Configuration    timeout=25 seconds      prompt=#:
    ${output}=                  Execute Command         systemctl show -p ActiveState eniq-licmgr | cut -f2 -d'=' | grep active
    Should Be Equal             ${output}               active
	
Checking if ENIQ rmiregistry service is running on coordinator
    [Tags]                      II-Coordinator
    Set Client Configuration    timeout=25 seconds      prompt=#:
    ${output}=                  Execute Command         systemctl show -p ActiveState eniq-rmiregistry | cut -f2 -d'=' | grep active
    Should Be Equal             ${output}               active
	
Checking if ENIQ esm service is running on coordinator
    [Tags]                      II-Coordinator
    Set Client Configuration    timeout=25 seconds      prompt=#:
    ${output}=                  Execute Command         systemctl show -p ActiveState eniq-esm | cut -f2 -d'=' | grep active
    Should Be Equal             ${output}               active
	
Open Connection And Log In to reader2
    [Tags]                      II-Reader2
	Open Connection             ${host3}       port=${PORT3}
	Login                       ${username3}   ${password3}    delay=1
	Log To Console              Connected to server ${host3}:${p3}

Checking if ENIQ ddc service is running on reader2
    [Tags]                      II-Reader2
    Set Client Configuration    timeout=25 seconds      prompt=#:
    ${output}=                  Execute Command         systemctl show -p ActiveState ddc | cut -f2 -d'=' | grep active
    Should Be Equal             ${output}               active
	
Checking if ENIQ esm service is running on reader2
    [Tags]                      II-Reader2
    Set Client Configuration    timeout=25 seconds      prompt=#:
    ${output}=                  Execute Command         systemctl show -p ActiveState eniq-esm | cut -f2 -d'=' | grep active
    Should Be Equal             ${output}               active
