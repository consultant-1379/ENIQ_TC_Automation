*** Settings ***
Suite Setup        Open Connection And Log In
Suite Teardown     Close All Connections
Library            SSHLibrary
Library            BuiltIn
Library            String
Resource           ../../Resources/resource.txt


*** Test Cases ***
Checking if symlinks are created correctly on coordinator
    [Tags]                      symlinks					SB-to-MB
    Set Client Configuration    timeout=25 seconds          prompt=#:
    ${output}=                  Execute Command             cat /eniq/installation/config/sym_links.ini | grep Path= | cut -f2 -d'='
	${Line}=					Get Line					${output}				0
	Write 						ls -lrt ${Line}
	${output1}=					Read 						delay=5s
	Should Contain				${output1}					->
	${Line}=					Get Line					${output}				1
	Write 						ls -lrt ${Line}
	${output2}=					Read 						delay=5s
	Should Contain				${output2}					->
	${Line}=					Get Line					${output}				-1
	Write 						ls -lrt ${Line}
	${output3}=					Read 						delay=5s
	Should Contain				${output3}					->
	${Line}=					Get Line					${output}				-2
	Write 						ls -lrt ${Line}
	${output4}=					Read 						delay=5s
	Should Contain				${output4}					->
	
Checking if database is up and running
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
