*** Settings ***
Suite Setup        Open Connection And Log In
Suite Teardown     Close All Connections
Library            SSHLibrary
Library            BuiltIn
Resource           ../../Resources/resource.txt


*** Test Cases ***
Checking if database is up and running
    [Tags]                      Restore
    ${value}=                   Execute Command             cat /eniq/installation/config/niq.ini | grep DBAPassword= | cut -f1 -d'=' --complement| head -1
    ${state}=                   Execute Command             cat /eniq/installation/config/niq.ini | grep DBAPassword_Encrypted= | cut -f1 -d'=' --complement| head -1
    ${user}=                    Execute Command             cat /eniq/installation/config/niq.ini | grep DBAPassword= | cut -f1 -d'P' | head -1
    IF                          '${state}' == 'N'                          
    ${pwd}=                     Set Variable                ${value} 
    ELSE
    ${pwd}=                     Execute Command             echo '${value}' | base64 -d    
    END
    Write                       su - dcuser -c 'dbisql -c "UID=${user};PWD=${pwd}" -host localhost -port 2641 -nogui' 
    ${database}=                Read Until Regexp           >
    Should Contain              ${database}                 DBA
