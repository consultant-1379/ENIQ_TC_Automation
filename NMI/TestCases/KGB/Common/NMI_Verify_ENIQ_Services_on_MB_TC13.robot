*** Settings ***
Suite Setup        Open Connection and Log In
Suite Teardown     Close All Connections
Library            SSHLibrary
Resource           ../../../Resources/resource.txt
 
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
    ${output}=                  Execute Command         service ddc status | cut -d "-" -f 1
    Set Global Variable         ${output}
    ${var}=                     Run Keyword And Return Status    Should Contain        ${output}         DDC running
    IF    ${var} == True
        Pass Execution    DDC is running
    ELSE
        ${ddc_restart}=         Execute Command    service ddc restart
        Log To Console    DDC is restarting
    END
    #Should Be Equal             ${output}               active
	
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

Checking if ENIQ sentinel service is running
    [Tags]                      II-Coordinator
    Set Client Configuration    timeout=25 seconds      prompt=#:
    ${output}=                  Execute Command         systemctl show -p ActiveState licensing-sentinel.service | cut -f2 -d'=' | grep active
    Should Be Equal             ${output}               active

Checking if ENIQ sentinel service is enabled
    [Tags]                      II-Coordinator
    Set Client Configuration    timeout=25 seconds      prompt=#:
    ${output}=                  Execute Command         systemctl status licensing-sentinel.service | grep -i enabled
    Should Contain              ${output}               enabled

Open Connection And Log In to engine
    [Tags]                      II-Engine
	Open Connection             ${host1}        port=${PORT1}
	Login                       ${username1}    ${password1}    delay=1
	Log To Console              Connected to server ${host1}:${p1}
	
Checking if ENIQ lwphelper service is running on engine
    [Tags]                      II-Engine
    Set Client Configuration    timeout=25 seconds      prompt=#:
    ${output}=                  Execute Command         systemctl show -p ActiveState eniq-lwphelper | cut -f2 -d'=' | grep active
    Should Be Equal             ${output}               active
	
Checking if ENIQ engine service is running on engine
    [Tags]                      II-Engine
    Set Client Configuration    timeout=25 seconds      prompt=#:
    ${output}=                  Execute Command         systemctl show -p ActiveState eniq-engine | cut -f2 -d'=' | grep active
    Should Be Equal             ${output}               active
	
Checking if ENIQ ddc service is running on engine
    [Tags]                      II-Engine
    Set Client Configuration    timeout=25 seconds      prompt=#:
    ${output}=                  Execute Command         service ddc status | cut -d "-" -f 1
    Set Global Variable         ${output}
    ${var}=                     Run Keyword And Return Status    Should Contain        ${output}         DDC running
    IF    ${var} == True
        Pass Execution    DDC is running
    ELSE
        ${ddc_restart}=         Execute Command    service ddc restart
        Log To Console    DDC is restarting
    END
    #${output}=                  Execute Command         systemctl show -p ActiveState ddc | cut -f2 -d'=' | grep active
    #Should Be Equal             ${output}               active
	
Checking if ENIQ connectd service is running on engine
    [Tags]                      II-Engine
    Set Client Configuration    timeout=25 seconds      prompt=#:
    ${output}=                  Execute Command         systemctl show -p ActiveState eniq-connectd | cut -f2 -d'=' | grep active
    Should Be Equal             ${output}               active
	
Checking if ENIQ rmiregistry service is running on engine
    [Tags]                      II-Engine
    Set Client Configuration    timeout=25 seconds      prompt=#:
    ${output}=                  Execute Command         systemctl show -p ActiveState eniq-rmiregistry | cut -f2 -d'=' | grep active
    Should Be Equal             ${output}               active
	
Checking if ENIQ esm service is running on engine
    [Tags]                      II-Engine
    Set Client Configuration    timeout=25 seconds      prompt=#:
    ${output}=                  Execute Command         systemctl show -p ActiveState eniq-esm | cut -f2 -d'=' | grep active
    Should Be Equal             ${output}               active
	
Open Connection And Log In to reader1
    [Tags]                      II-Reader1
	Open Connection             ${host2}       port=${PORT2}
	Login                       ${username2}   ${password2}    delay=1
	Log To Console              Connected to server ${host2}:${p2}

Checking if ENIQ ddc service is running on reader1
    [Tags]                      II-Reader1
    Set Client Configuration    timeout=25 seconds      prompt=#:
    ${output}=                  Execute Command         service ddc status | cut -d "-" -f 1
    Set Global Variable         ${output}
    ${var}=                     Run Keyword And Return Status    Should Contain        ${output}         DDC running
    IF    ${var} == True
        Pass Execution    DDC is running
    ELSE
        ${ddc_restart}=         Execute Command    service ddc restart
        Log To Console    DDC is restarting
    END
	
Checking if ENIQ esm service is running on reader1
    [Tags]                      II-Reader1
    Set Client Configuration    timeout=25 seconds      prompt=#:
    ${output}=                  Execute Command         systemctl show -p ActiveState eniq-esm | cut -f2 -d'=' | grep active
    Should Be Equal             ${output}               active

Checking dwh_reader_1 service.   
    [Tags]                         DB_service
    Open Connection                ${host2}        port=${PORT2}
    Login                          ${username2}    ${password2}    delay=1
    Log To Console                 Connected to server ${host2}:${p}
    Set Client Configuration       timeout=25 seconds      prompt=#:
    ${output}=                     Execute Command         ps -eaf | grep -i dwh_reader_1
    Should Contain                 ${output}               dwh_reader_1

Checking dwh_reader_1 service is active. 
    [Tags]                         DB_service
    Open Connection                ${host2}        port=${PORT2}
    Login                          ${username2}    ${password2}    delay=1
    Log To Console                 Connected to server ${host2}:${p}
    Set Client Configuration       timeout=25 seconds      prompt=#:
    ${output}=                     Execute Command         systemctl show eniq-dwh_reader -p ActiveState | awk -F= '{print $2}'
    Should Be Equal                ${output}               active
	
Open Connection And Log In to reader2
    [Tags]                      II-Reader2
	Open Connection             ${host3}       port=${PORT3}
	Login                       ${username3}   ${password3}    delay=1
	Log To Console              Connected to server ${host3}:${p3}

Checking if ENIQ ddc service is running on reader2
    [Tags]                      II-Reader2
    Set Client Configuration    timeout=25 seconds      prompt=#:
    ${output}=                  Execute Command         service ddc status | cut -d "-" -f 1
    Set Global Variable         ${output}
    ${var}=                     Run Keyword And Return Status    Should Contain        ${output}         DDC running
    IF    ${var} == True
        Pass Execution    DDC is running
    ELSE
        ${ddc_restart}=         Execute Command    service ddc restart
        Log To Console    DDC is restarting
    END
	
Checking if ENIQ esm service is running on reader2
    [Tags]                      II-Reader2
    Set Client Configuration    timeout=25 seconds      prompt=#:
    ${output}=                  Execute Command         systemctl show -p ActiveState eniq-esm | cut -f2 -d'=' | grep active
    Should Be Equal             ${output}               active

Checking dwh_reader_2 service.
    [Tags]                         DB_service
    Open Connection                ${host3}        port=${PORT3}
    Login                          ${username3}    ${password3}    delay=1
    Log To Console                 Connected to server ${host3}:${p}
    Set Client Configuration       timeout=25 seconds      prompt=#:
    ${output}=                     Execute Command         ps -eaf | grep -i dwh_reader_2
    Should Contain                 ${output}               dwh_reader_2

Checking dwh_reader_2 service is active.  
    [Tags]                         DB_service
    Open Connection                ${host3}        port=${PORT3}
    Login                          ${username3}    ${password3}    delay=1
    Log To Console                 Connected to server ${host3}:${p}
    Set Client Configuration       timeout=25 seconds      prompt=#:
    ${output}=                     Execute Command         systemctl show eniq-dwh_reader -p ActiveState | awk -F= '{print $2}'
    Should Be Equal                ${output}               active
