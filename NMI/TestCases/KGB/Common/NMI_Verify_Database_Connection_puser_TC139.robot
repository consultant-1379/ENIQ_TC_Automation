*** Settings ***
Suite Setup        Open Connection And Log In
Suite Teardown     Close All Connections
Library            SSHLibrary
Library            BuiltIn
Resource           ../../Resources/resource.txt


*** Test Cases ***
Checking if database connection is made
    [Tags]                      II
    Set Client Configuration    timeout=25 seconds          prompt=#:
    ${value}=                   Execute Command             sudo cat /eniq/installation/config/niq.ini | grep DWHREPPassword= | cut -f1 -d'=' --complement| head -1
    ${state}=                   Execute Command             sudo cat /eniq/installation/config/niq.ini | grep DWHREPPassword_Encrypted= | cut -f1 -d'=' --complement| head -1
    ${user}=                    Execute Command             sudo cat /eniq/installation/config/niq.ini | grep DWHREPUsername= | cut -f1 -d'=' --complement| head -1
    ${strong_passphase}=        Execute Command             sudo cat /eniq/sw/conf/strong_passphrase

    IF                          '${state}' == 'N'                          
    ${pwd}=                     Set Variable                ${value} 
    ELSE
    ${pwd}=                     Execute Command             sudo echo '${value}' | openssl enc -aes-256-ctr -md sha512 -a -d -salt -pass pass:${strong_passphase}	
    END
	
    Write                       sudo su - dcuser
    Set Client Configuration    timeout=25 seconds          prompt=#:
    Write                       dbisql -c "UID=${user};PWD=${pwd}" -host localhost -port 2641 -nogui
    ${database}=                Read Until Regexp           >
    Should Contain              ${database}                 dwhrep
    Write                       exit
    ${output}=                  Read                        delay=3s
    Should Contain              ${output}                   } #:
    Write                       exit
    ${output}=                  Read                        delay=3s
    Should Contain              ${output}                   } #:

Checking if database connection is made for dcuser
	[Tags]                      II
	Set Client Configuration    timeout=35 seconds          prompt=#:
	${password}=                Execute Command    		sudo cat /eniq/installation/config/niq.ini | grep ETLREPPassword= | cut -f1 -d'=' --complement| head -1
	${state}=                   Execute Command             sudo cat /eniq/installation/config/niq.ini | grep ETLREPPassword_Encrypted= | cut -f1 -d'=' --complement| head -1
	${user}=                    Execute Command             sudo cat /eniq/installation/config/niq.ini | grep ETLREPUsername= | cut -f1 -d'=' --complement| head -1
	${strong_passphase}=        Execute Command             sudo cat /eniq/sw/conf/strong_passphrase

	IF                          '${state}' == 'N'
	${pwd}=                     Set Variable                ${password}
	ELSE
	${pwd}=                     Execute Command             sudo echo '${password}' | openssl enc -aes-256-ctr -md sha512 -a -d -salt -pass pass:${strong_passphase}
	END
	Write                       sudo su - dcuser -c 'dbisql -c "UID=${user};PWD=${pwd}" -host localhost -port 2641 -nogui'
	${database}=                Read Until Regexp           >
	Should Contain              ${database}                 etlrep
	Write 						select MIN(ENCRYPTION_FLAG), MIN(PASSWORD) from etlrep.meta_databases where USERNAME='dcuser'; Output TO '/tmp/dcuser_password'
	${export}=                	Read Until Regexp           >
	Should Contain				${export}					Exporting data
	Write 						exit
	${output}=					Read 						delay=3s
	Should Contain				${output}					} #:
	${value1}=                  Execute Command             sudo cat /eniq/sw/conf/strong_passphrase
	${encryption_flag}=         Execute Command         	sudo cat "/tmp/dcuser_password" | cut -d "'" -f2
	${output1}= 				Execute Command         	sudo cat "/tmp/dcuser_password" | cut -d "'" -f4
	IF							'${encryption_flag}' == 'Y'
	${db_dcuser_pwd}			Execute Command             sudo echo '${output1}' | openssl base64 -d
	ELSE IF						'${encryption_flag}' == 'YY'
	${db_dcuser_pwd}			Execute Command             sudo echo '${output1}' | openssl enc -aes-256-ctr -md sha512 -a -d -salt -pass pass:${value1}
	END

	${output2}=                 Execute Command         	sudo cat /eniq/sw/conf/dcuser_password_file
	${dcuser_pwd}				Execute Command             sudo echo '${output2}' | openssl enc -aes-256-ctr -md sha512 -a -d -salt -pass pass:${value1}
	Should Contain				${db_dcuser_pwd}			${dcuser_pwd}
	Write						sudo rm -rf /tmp/dcuser_password
	${output3}=					Read 						delay=3s
	Write 						sudo cat /tmp/dcuser_password
	${output4}=					Read 						delay=3s
	Should Contain				${output4}					No such file or directory

Checking the flag of password
	[Tags]                      II
	Set Client Configuration    timeout=25 seconds          prompt=#:    
	FOR    ${user_type}    IN   dba    etlrep    dwhrep
    ${value}=                   Execute Command             sudo cat /eniq/installation/config/niq.ini | grep -i ${user_type}Password= | cut -f1 -d'=' --complement| head -1
    ${state}=                   Execute Command             sudo cat /eniq/installation/config/niq.ini | grep -i ${user_type}Password_Encrypted= | cut -f1 -d'=' --complement| head -1
    ${value1}=                  Execute Command             sudo cat /eniq/sw/conf/strong_passphrase
	IF                                              '${state}' == 'Y'
	${pwd}                        Execute Command             sudo echo '${value}' | openssl base64 -d
	ELSE IF                                         '${state}' == 'YY'
	${pwd}                        Execute Command             sudo echo '${value}' | openssl enc -aes-256-ctr -md sha512 -a -d -salt -pass pass:${value1}
	END
	Write                       sudo su - dcuser -c 'dbisql -nogui -c "eng=repdb;links=tcpip{host=repdb;port=2641};uid=${user_type};pwd=${pwd}"'
	${database}=                Read Until Regexp           >
	Should Contain              ${database}					${user_type}			ignore_case=True
	Write                       exit
	END
	
	FOR    ${user_type}    IN   dc	dcbo	dcpublic	
    ${value}=                   Execute Command             sudo cat /eniq/installation/config/niq.ini | grep -i ${user_type}Password= | cut -f1 -d'=' --complement| head -1
    ${state}=                   Execute Command             sudo cat /eniq/installation/config/niq.ini | grep -i ${user_type}Password_Encrypted= | cut -f1 -d'=' --complement| head -1
    ${value1}=                  Execute Command             sudo cat /eniq/sw/conf/strong_passphrase
	IF                                              '${state}' == 'Y'
	${pwd}                        Execute Command             sudo echo '${value}' | openssl base64 -d
	ELSE IF                                         '${state}' == 'YY'
	${pwd}                        Execute Command             sudo echo '${value}' | openssl enc -aes-256-ctr -md sha512 -a -d -salt -pass pass:${value1}
	END
	Write                       sudo su - dcuser -c 'dbisql -nogui -c "eng=dwhdb;links=tcpip{host=dwhdb;port=2640};uid=${user_type};pwd=${pwd}"'
	${database}=                Read Until Regexp           >
	Should Contain              ${database}					${user_type}			ignore_case=True
	Write                       exit
	END
