*** Settings ***
Suite Setup        Open Connection And Log In
Suite Teardown     Close All Connections
Library            SSHLibrary
Library            BuiltIn
Library            String
Resource           ../../Resources/resource.txt


*** Test Cases ***
Checking the count of symlinks
    [Tags]                      Symlink
    Set Client Configuration    timeout=25 seconds          prompt=#:
    ${path}=                    Execute Command             cat /eniq/installation/config/sym_links.ini | grep -c Path= | cut -f2 -d'='
    ${link}=                    Execute Command                cat /eniq/installation/config/sym_links.ini | grep -c Link=/dev/raw/raw
    Should Contain                ${path}                     ${link}
    ${output}=                    Execute Command                cat /eniq/installation/config/sym_links.ini | grep Link=/dev/raw/raw
    Should Contain                ${output}                    Link=/dev/raw/raw${link}
    
Checking if symlinks are created correctly
    [Tags]                      Symlink
    Set Client Configuration    timeout=25 seconds          prompt=#:
    ${value}=                   Execute Command             cat /eniq/installation/config/niq.ini | grep DBAPassword= | cut -f1 -d'=' --complement | head -1
    ${state}=                   Execute Command             cat /eniq/installation/config/niq.ini | grep DBAPassword_Encrypted= | cut -f1 -d'=' --complement | head -1
    ${value1}=                  Execute Command             cat /eniq/sw/conf/strong_passphrase
    IF                          '${state}' == 'Y'
    ${pwd}=                     Execute Command             echo '${value}' | openssl base64 -d
    ELSE IF                     '${state}' == 'YY'
    ${pwd}=                     Execute Command             echo '${value}' | openssl enc -aes-256-ctr -md sha512 -a -d -salt -pass pass:${value1}
    ELSE
    ${pwd}=                     Set Variable                ${value}
    END

    Set Client Configuration    timeout=40 seconds          prompt=#:
    Write                       su - dcuser
    Set Client Configuration    timeout=50 seconds          prompt=#:
    Write                       dbisql -nogui -onerror exit -c "eng=dwhdb;links=tcpip(host=localhost;port=2640);uid=DBA;pwd=${pwd}"
    ${database}=                Read Until Regexp           >
    Should Contain              ${database}                 DBA
    Write                       Select Path from sp_iqfile()
    ${spiqfile}=                Read                        delay=5s                   
    ${output}=                  Execute Command             cat /eniq/installation/config/sym_links.ini | grep Path= | cut -f2 -d'='
    ${linecount}=               Get Line Count              ${output}
    FOR    ${index}    IN RANGE    0    ${linecount}
    ${Line}=                    Get Line                    ${output}                ${index}
    Should Contain              ${spiqfile}                 ${Line}
    END
