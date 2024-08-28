*** Settings ***
Suite Setup        Open Connection And Log In
Suite Teardown     Close All Connections
Library            SSHLibrary
Resource           ../../Resources/resource.txt

*** Test Cases ***
Open Connection And Log In to coordinator
    [Tags]                      SB-to-MB
    Open Connection             ${host}        port=${PORT}
    Login                       ${username}    ${password}    delay=1
    Log To Console              Connected to server ${host}:${p}

Checking if ENIQ dwhdb service is running on coordinator after SB to MB expansion
    [Tags]                      SB-to-MB
    Set Client Configuration    timeout=25 seconds      prompt=#:
    ${output}=                  Execute Command         systemctl show -p ActiveState eniq-dwhdb | cut -f2 -d'=' | grep active
    Should Be Equal             ${output}               active

Checking if ENIQ repdb service is running on coordinator after SB to MB expansion
    [Tags]                      SB-to-MB
    Set Client Configuration    timeout=25 seconds      prompt=#:
    ${output}=                  Execute Command         systemctl show -p ActiveState eniq-repdb | cut -f2 -d'=' | grep active
    Should Be Equal             ${output}               active
    
Checking if ENIQ webserver service is running on coordinator after SB to MB expansion
    [Tags]                      SB-to-MB
    Set Client Configuration    timeout=25 seconds      prompt=#:
    ${output}=                  Execute Command         systemctl show -p ActiveState eniq-webserver | cut -f2 -d'=' | grep active
    Should Be Equal             ${output}               active
    
Checking if ENIQ lwphelper service is running on coordinator after SB to MB expansion
    [Tags]                      SB-to-MB
    Set Client Configuration    timeout=25 seconds      prompt=#:
    ${output}=                  Execute Command         systemctl show -p ActiveState eniq-lwphelper | cut -f2 -d'=' | grep active
    Should Be Equal             ${output}               active
    
Checking if ENIQ engine service is running on coordinator after SB to MB expansion
    [Tags]                      SB-to-MB
    Set Client Configuration    timeout=25 seconds      prompt=#:
    ${output}=                  Execute Command         systemctl show -p ActiveState eniq-engine | cut -f2 -d'=' | grep active
    Should Be Equal             ${output}               active
    
Checking if ENIQ scheduler service is running on coordinator after SB to MB expansion
    [Tags]                      SB-to-MB
    Set Client Configuration    timeout=25 seconds      prompt=#:
    ${output}=                  Execute Command         systemctl show -p ActiveState eniq-scheduler | cut -f2 -d'=' | grep active
    Should Be Equal             ${output}               active
    
Checking if ENIQ ddc service is running on coordinator after SB to MB expansion
    [Tags]                      SB-to-MB
    Set Client Configuration    timeout=25 seconds      prompt=#:
    ${output}=                  Execute Command         systemctl show -p ActiveState ddc | cut -f2 -d'=' | grep active
    Should Be Equal             ${output}               active
    
Checking if ENIQ connectd service is running on coordinator after SB to MB expansion
    [Tags]                      SB-to-MB
    Set Client Configuration    timeout=25 seconds      prompt=#:
    ${output}=                  Execute Command         systemctl show -p ActiveState eniq-connectd | cut -f2 -d'=' | grep active
    Should Be Equal             ${output}               active
    
Checking if ENIQ licmgr service is running on coordinator after SB to MB expansion
    [Tags]                      SB-to-MB
    Set Client Configuration    timeout=25 seconds      prompt=#:
    ${output}=                  Execute Command         systemctl show -p ActiveState eniq-licmgr | cut -f2 -d'=' | grep active
    Should Be Equal             ${output}               active
    
Checking if ENIQ rmiregistry service is running on coordinator after SB to MB expansion
    [Tags]                      SB-to-MB
    Set Client Configuration    timeout=25 seconds      prompt=#:
    ${output}=                  Execute Command         systemctl show -p ActiveState eniq-rmiregistry | cut -f2 -d'=' | grep active
    Should Be Equal             ${output}               active
    
Checking if ENIQ esm service is running on coordinator after SB to MB expansion
    [Tags]                      SB-to-MB
    Set Client Configuration    timeout=25 seconds      prompt=#:
    ${output}=                  Execute Command         systemctl show -p ActiveState eniq-esm | cut -f2 -d'=' | grep active
    Should Be Equal             ${output}               active
    
Open Connection And Log In to engine
    [Tags]                      SB-to-MB
    Open Connection             ${host1}        port=${PORT1}
    Login                       ${username1}    ${password1}    delay=1
    Log To Console              Connected to server ${host1}:${p1}
    
Checking if ENIQ webserver service is running on engine after SB to MB expansion
    [Tags]                      SB-to-MB
    Set Client Configuration    timeout=25 seconds      prompt=#:
    ${output}=                  Execute Command         systemctl show -p ActiveState eniq-webserver | cut -f2 -d'=' | grep active
    Should Be Equal             ${output}               active
    
Checking if ENIQ lwphelper service is running on engine after SB to MB expansion
    [Tags]                      SB-to-MB
    Set Client Configuration    timeout=25 seconds      prompt=#:
    ${output}=                  Execute Command         systemctl show -p ActiveState eniq-lwphelper | cut -f2 -d'=' | grep active
    Should Be Equal             ${output}               active
    
Checking if ENIQ engine service is running on engine after SB to MB expansion
    [Tags]                      SB-to-MB
    Set Client Configuration    timeout=25 seconds      prompt=#:
    ${output}=                  Execute Command         systemctl show -p ActiveState eniq-engine | cut -f2 -d'=' | grep active
    Should Be Equal             ${output}               active
    
Checking if ENIQ scheduler service is running on engine after SB to MB expansion
    [Tags]                      SB-to-MB
    Set Client Configuration    timeout=25 seconds      prompt=#:
    ${output}=                  Execute Command         systemctl show -p ActiveState eniq-scheduler | cut -f2 -d'=' | grep active
    Should Be Equal             ${output}               active
    
Checking if ENIQ ddc service is running on engine after SB to MB expansion
    [Tags]                      SB-to-MB
    Set Client Configuration    timeout=25 seconds      prompt=#:
    ${output}=                  Execute Command         systemctl show -p ActiveState ddc | cut -f2 -d'=' | grep active
    Should Be Equal             ${output}               active
    
Checking if ENIQ connectd service is running on engine after SB to MB expansion
    [Tags]                      SB-to-MB
    Set Client Configuration    timeout=25 seconds      prompt=#:
    ${output}=                  Execute Command         systemctl show -p ActiveState eniq-connectd | cut -f2 -d'=' | grep active
    Should Be Equal             ${output}               active
    
Checking if ENIQ licmgr service is running on engine after SB to MB expansion
    [Tags]                      SB-to-MB
    Set Client Configuration    timeout=25 seconds      prompt=#:
    ${output}=                  Execute Command         systemctl show -p ActiveState eniq-licmgr | cut -f2 -d'=' | grep active
    Should Be Equal             ${output}               active
    
Checking if ENIQ rmiregistry service is running on engine after SB to MB expansion
    [Tags]                      SB-to-MB
    Set Client Configuration    timeout=25 seconds      prompt=#:
    ${output}=                  Execute Command         systemctl show -p ActiveState eniq-rmiregistry | cut -f2 -d'=' | grep active
    Should Be Equal             ${output}               active
    
Checking if ENIQ esm service is running on engine after SB to MB expansion
    [Tags]                      SB-to-MB
    Set Client Configuration    timeout=25 seconds      prompt=#:
    ${output}=                  Execute Command         systemctl show -p ActiveState eniq-esm | cut -f2 -d'=' | grep active
    Should Be Equal             ${output}               active
    
Open Connection And Log In to Reader1
    [Tags]                      SB-to-MB
    Open Connection             ${host2}       port=${PORT2}
    Login                       ${username2}   ${password2}    delay=1
    Log To Console              Connected to server ${host2}:${p2}

Checking if ENIQ dwhdb service is running on Reader1 after SB to MB expansion
    [Tags]                      SB-to-MB
    Set Client Configuration    timeout=25 seconds      prompt=#:
    ${output}=                  Execute Command         systemctl show -p ActiveState eniq-dwhdb | cut -f2 -d'=' | grep active
    Should Be Equal             ${output}               active

Checking if ENIQ repdb service is running on Reader1 after SB to MB expansion
    [Tags]                      SB-to-MB
    Set Client Configuration    timeout=25 seconds      prompt=#:
    ${output}=                  Execute Command         systemctl show -p ActiveState eniq-repdb | cut -f2 -d'=' | grep active
    Should Be Equal             ${output}               active
    
Checking if ENIQ webserver service is running on Reader1 after SB to MB expansion
    [Tags]                      SB-to-MB
    Set Client Configuration    timeout=25 seconds      prompt=#:
    ${output}=                  Execute Command         systemctl show -p ActiveState eniq-webserver | cut -f2 -d'=' | grep active
    Should Be Equal             ${output}               active
    
Checking if ENIQ lwphelper service is running on Reader1 after SB to MB expansion
    [Tags]                      SB-to-MB
    Set Client Configuration    timeout=25 seconds      prompt=#:
    ${output}=                  Execute Command         systemctl show -p ActiveState eniq-lwphelper | cut -f2 -d'=' | grep active
    Should Be Equal             ${output}               active
    
Checking if ENIQ engine service is running on Reader1 after SB to MB expansion
    [Tags]                      SB-to-MB
    Set Client Configuration    timeout=25 seconds      prompt=#:
    ${output}=                  Execute Command         systemctl show -p ActiveState eniq-engine | cut -f2 -d'=' | grep active
    Should Be Equal             ${output}               active
    
Checking if ENIQ scheduler service is running on Reader1 after SB to MB expansion
    [Tags]                      SB-to-MB
    Set Client Configuration    timeout=25 seconds      prompt=#:
    ${output}=                  Execute Command         systemctl show -p ActiveState eniq-scheduler | cut -f2 -d'=' | grep active
    Should Be Equal             ${output}               active
    
Checking if ENIQ ddc service is running on Reader1 after SB to MB expansion
    [Tags]                      SB-to-MB
    Set Client Configuration    timeout=25 seconds      prompt=#:
    ${output}=                  Execute Command         systemctl show -p ActiveState ddc | cut -f2 -d'=' | grep active
    Should Be Equal             ${output}               active
    
Checking if ENIQ connectd service is running on Reader1 after SB to MB expansion
    [Tags]                      SB-to-MB
    Set Client Configuration    timeout=25 seconds      prompt=#:
    ${output}=                  Execute Command         systemctl show -p ActiveState eniq-connectd | cut -f2 -d'=' | grep active
    Should Be Equal             ${output}               active
    
Checking if ENIQ licmgr service is running on Reader1 after SB to MB expansion
    [Tags]                      SB-to-MB
    Set Client Configuration    timeout=25 seconds      prompt=#:
    ${output}=                  Execute Command         systemctl show -p ActiveState eniq-licmgr | cut -f2 -d'=' | grep active
    Should Be Equal             ${output}               active
    
Checking if ENIQ rmiregistry service is running on Reader1 after SB to MB expansion
    [Tags]                      SB-to-MB
    Set Client Configuration    timeout=25 seconds      prompt=#:
    ${output}=                  Execute Command         systemctl show -p ActiveState eniq-rmiregistry | cut -f2 -d'=' | grep active
    Should Be Equal             ${output}               active
    
Checking if ENIQ esm service is running on Reader1 after SB to MB expansion
    [Tags]                      SB-to-MB
    Set Client Configuration    timeout=25 seconds      prompt=#:
    ${output}=                  Execute Command         systemctl show -p ActiveState eniq-esm | cut -f2 -d'=' | grep active
    Should Be Equal             ${output}               active
    
Open Connection And Log In to Reader2
    [Tags]                      SB-to-MB
    Open Connection             ${host3}       port=${PORT3}
    Login                       ${username3}   ${password3}    delay=1
    Log To Console              Connected to server ${host3}:${p3}

Checking if ENIQ dwhdb service is running on Reader2 after SB to MB expansion
    [Tags]                      SB-to-MB
    Set Client Configuration    timeout=25 seconds      prompt=#:
    ${output}=                  Execute Command         systemctl show -p ActiveState eniq-dwhdb | cut -f2 -d'=' | grep active
    Should Be Equal             ${output}               active

Checking if ENIQ repdb service is running on Reader2 after SB to MB expansion
    [Tags]                      SB-to-MB
    Set Client Configuration    timeout=25 seconds      prompt=#:
    ${output}=                  Execute Command         systemctl show -p ActiveState eniq-repdb | cut -f2 -d'=' | grep active
    Should Be Equal             ${output}               active
    
Checking if ENIQ webserver service is running on Reader2 after SB to MB expansion
    [Tags]                      SB-to-MB
    Set Client Configuration    timeout=25 seconds      prompt=#:
    ${output}=                  Execute Command         systemctl show -p ActiveState eniq-webserver | cut -f2 -d'=' | grep active
    Should Be Equal             ${output}               active
    
Checking if ENIQ lwphelper service is running on Reader2 after SB to MB expansion
    [Tags]                      SB-to-MB
    Set Client Configuration    timeout=25 seconds      prompt=#:
    ${output}=                  Execute Command         systemctl show -p ActiveState eniq-lwphelper | cut -f2 -d'=' | grep active
    Should Be Equal             ${output}               active
    
Checking if ENIQ engine service is running on Reader2 after SB to MB expansion
    [Tags]                      SB-to-MB
    Set Client Configuration    timeout=25 seconds      prompt=#:
    ${output}=                  Execute Command         systemctl show -p ActiveState eniq-engine | cut -f2 -d'=' | grep active
    Should Be Equal             ${output}               active
    
Checking if ENIQ scheduler service is running on Reader2 after SB to MB expansion
    [Tags]                      SB-to-MB
    Set Client Configuration    timeout=25 seconds      prompt=#:
    ${output}=                  Execute Command         systemctl show -p ActiveState eniq-scheduler | cut -f2 -d'=' | grep active
    Should Be Equal             ${output}               active
    
Checking if ENIQ ddc service is running on Reader2 after SB to MB expansion
    [Tags]                      SB-to-MB
    Set Client Configuration    timeout=25 seconds      prompt=#:
    ${output}=                  Execute Command         systemctl show -p ActiveState ddc | cut -f2 -d'=' | grep active
    Should Be Equal             ${output}               active
    
Checking if ENIQ connectd service is running on Reader2 after SB to MB expansion
    [Tags]                      SB-to-MB
    Set Client Configuration    timeout=25 seconds      prompt=#:
    ${output}=                  Execute Command         systemctl show -p ActiveState eniq-connectd | cut -f2 -d'=' | grep active
    Should Be Equal             ${output}               active
    
Checking if ENIQ licmgr service is running on Reader2 after SB to MB expansion
    [Tags]                      SB-to-MB
    Set Client Configuration    timeout=25 seconds      prompt=#:
    ${output}=                  Execute Command         systemctl show -p ActiveState eniq-licmgr | cut -f2 -d'=' | grep active
    Should Be Equal             ${output}               active
    
Checking if ENIQ rmiregistry service is running on Reader2 after SB to MB expansion
    [Tags]                      SB-to-MB
    Set Client Configuration    timeout=25 seconds      prompt=#:
    ${output}=                  Execute Command         systemctl show -p ActiveState eniq-rmiregistry | cut -f2 -d'=' | grep active
    Should Be Equal             ${output}               active
    
Checking if ENIQ esm service is running on Reader2 after SB to MB expansion
    [Tags]                      SB-to-MB
    Set Client Configuration    timeout=25 seconds      prompt=#:
    ${output}=                  Execute Command         systemctl show -p ActiveState eniq-esm | cut -f2 -d'=' | grep active
    Should Be Equal             ${output}               active
