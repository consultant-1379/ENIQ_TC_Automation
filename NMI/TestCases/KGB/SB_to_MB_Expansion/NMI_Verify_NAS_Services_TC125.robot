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

Checking if NASd service is running on coordinator after SB to MB expansion
    [Tags]                      SB-to-MB
    Set Client Configuration    timeout=25 seconds      prompt=#:
    ${Output}=                    Execute Command         systemctl show -p ActiveState NASd.service | cut -f2 -d'=' | grep active
    Should Contain              ${Output}               active
    
Checking if NAS-online service is running on coordinator after SB to MB expansion
    [Tags]                      SB-to-MB
    Set Client Configuration    timeout=25 seconds      prompt=#:
    ${Output}=                    Execute Command         systemctl show -p ActiveState NAS-online.service | cut -f2 -d'=' | grep active
    Should Contain              ${Output}               active

Open Connection And Log In to engine
    [Tags]                      SB-to-MB
    Open Connection             ${host1}        port=${PORT1}
    Login                       ${username1}    ${password1}    delay=1
    Log To Console              Connected to server ${host1}:${p1}

Checking if NASd service is running on engine after SB to MB expansion
    [Tags]                      SB-to-MB
    Set Client Configuration    timeout=25 seconds      prompt=#:
    ${Output}=                    Execute Command         systemctl show -p ActiveState NASd.service | cut -f2 -d'=' | grep active
    Should Contain              ${Output}               active
    
Checking if NAS-online service is running on engine after SB to MB expansion
    [Tags]                      SB-to-MB
    Set Client Configuration    timeout=25 seconds      prompt=#:
    ${Output}=                    Execute Command         systemctl show -p ActiveState NAS-online.service | cut -f2 -d'=' | grep active
    Should Contain              ${Output}               active
    
Open Connection And Log In to Reader1
    [Tags]                      SB-to-MB
    Open Connection             ${host2}       port=${PORT2}
    Login                       ${username2}   ${password2}    delay=1
    Log To Console              Connected to server ${host2}:${p2}

Checking if NASd service is running on Reader1 after SB to MB expansion
    [Tags]                      SB-to-MB
    Set Client Configuration    timeout=25 seconds      prompt=#:
    ${Output}=                    Execute Command         systemctl show -p ActiveState NASd.service | cut -f2 -d'=' | grep active
    Should Contain              ${Output}               active
    
Checking if NAS-online service is running on Reader1 after SB to MB expansion
    [Tags]                      SB-to-MB
    Set Client Configuration    timeout=25 seconds      prompt=#:
    ${Output}=                    Execute Command         systemctl show -p ActiveState NAS-online.service | cut -f2 -d'=' | grep active
    Should Contain              ${Output}               active

Open Connection And Log In to Reader2
    [Tags]                      SB-to-MB
    Open Connection             ${host3}       port=${PORT3}
    Login                       ${username3}   ${password3}    delay=1
    Log To Console              Connected to server ${host3}:${p3}

Checking if NASd service is running on Reader2 after SB to MB expansion
    [Tags]                      SB-to-MB
    Set Client Configuration    timeout=25 seconds      prompt=#:
    ${Output}=                    Execute Command         systemctl show -p ActiveState NASd.service | cut -f2 -d'=' | grep active
    Should Contain              ${Output}               active
    
Checking if NAS-online service is running on Reader2 after SB to MB expansion
    [Tags]                      SB-to-MB
    Set Client Configuration    timeout=25 seconds      prompt=#:
    ${Output}=                    Execute Command         systemctl show -p ActiveState NAS-online.service | cut -f2 -d'=' | grep active
    Should Contain              ${Output}               active
