*** Settings ***
Suite Setup            Open Connection And Log In
Suite Teardown         Close All Connections
Library                SSHLibrary
Library                BuiltIn
Library                String
Resource               ../../Resources/resource.txt


*** Test Cases ***
Open Connection And Log In to Reader II
         [Tags]                            Collection of Statistics
         Open Connection                   ${host3}                 port=${PORT3}
         Login                             ${username3}             ${password3}    delay=1
         Log To Console                    Connected to server      ${host}:${p}

Checking if statistics are collected
    [Tags]                            Collection of Statistics
    Set Client Configuration    timeout=25 seconds          prompt=#:
    ${value}=                   Execute Command             cat /eniq/installation/config/niq.ini | grep DWHREPPassword= | cut -f1 -d'=' --complement| head -1
    ${state}=                   Execute Command             cat /eniq/installation/config/niq.ini | grep DWHREPPassword_Encrypted= | cut -f1 -d'=' --complement| head -1
    ${user}=                    Execute Command             cat /eniq/installation/config/niq.ini | grep DWHREPUsername= | cut -f1 -d'=' --complement| head -1
    ${strong_passphase}=        Execute Command             cat /eniq/sw/conf/strong_passphrase

    IF                          '${state}' == 'N'                          
    ${pwd}=                     Set Variable                ${value} 
    ELSE
    ${pwd}=                     Execute Command             echo '${value}' | openssl enc -aes-256-ctr -md sha512 -a -d -salt -pass pass:${strong_passphase}	
    END 
    
    Write                             su - dcuser  
    Write                             dbisql -nogui -c "eng=dwhdb;links=tcpip{host=dwhdb;port=2640};uid=dba;pwd=${pwd}"    
    Write                             select * from dba.Aggregation_Count_History 
    ${output}=                        Read
    Should not Contain                ${output}  not found
