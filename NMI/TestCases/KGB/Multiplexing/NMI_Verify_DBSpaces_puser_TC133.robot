*** Settings ***
Suite Setup        Open Connection And Log In
Suite Teardown     Close All Connections
Library            SSHLibrary
Library            BuiltIn
Library            String
Resource           ../../Resources/resource.txt


*** Test Cases ***
Verifying Main and Sysmain dbspaces
    [Tags]                      DBSpace
    Set Client Configuration    timeout=25 seconds          prompt=#:
    ${value}=                   Execute Command             sudo cat /eniq/installation/config/niq.ini | grep DBAPassword= | cut -f1 -d'=' --complement | head -1
    ${state}=                   Execute Command             sudo cat /eniq/installation/config/niq.ini | grep DBAPassword_Encrypted= | cut -f1 -d'=' --complement | head -1
    ${value1}=                  Execute Command             sudo cat /eniq/sw/conf/strong_passphrase
    IF                          '${state}' == 'Y'
    ${pwd}=                      Execute Command             sudo echo '${value}' | openssl base64 -d
    ELSE IF                     '${state}' == 'YY'
    ${pwd}=                     Execute Command             sudo echo '${value}' | openssl enc -aes-256-ctr -md sha512 -a -d -salt -pass pass:${value1}
    ELSE
    ${pwd}=                     Set Variable                ${value}   
    END

    Set Client Configuration    timeout=25 seconds          prompt=#:
    Write                       sudo su - dcuser
    Set Client Configuration    timeout=25 seconds          prompt=#:
    Write                       dbisql -nogui -onerror exit -c "eng=dwhdb;links=tcpip(host=localhost;port=2640);UID=DBA;PWD=${pwd}"
    ${database}=                Read Until Regexp           >
    Write                       Select Path from sp_iqfile()
    ${sapiqfile}=               Read                      delay=5s                   
    ${output}=                  Execute Command             sudo cat /eniq/installation/config/sym_links.ini | grep Path= | cut -f2 -d'='
    ${linecount}=               Get Line Count              ${output}
    FOR    ${index}    IN RANGE    0    ${linecount}
    ${Line}=                    Get Line                    ${output}                ${index}
    Should Contain              ${sapiqfile}                ${Line}
    END
