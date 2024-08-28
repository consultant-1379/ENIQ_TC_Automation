*** Settings ***
Suite Setup        Open Connection And Log In
Suite Teardown     Close All Connections
Library            SSHLibrary
Library            BuiltIn
Resource           ../../Resources/resource.txt


*** Test Cases ***
Checking if DBA Password is encrypted niq.ini file
    [Tags]                      SB-To-MB
    Set Client Configuration    timeout=25 seconds          prompt=#:
    ${state}=                   Execute Command             cat /eniq/installation/config/niq.ini | grep DBAPassword_Encrypted= | cut -f2 -d'=' | head -1
	Should Contain				${state}					Y
	
Checking if DC Password is encrypted niq.ini file
    [Tags]                      SB-To-MB
    Set Client Configuration    timeout=25 seconds          prompt=#:
    ${state}=                   Execute Command             cat /eniq/installation/config/niq.ini | grep DCPassword_Encrypted= | cut -f2 -d'=' | head -1
	Should Contain				${state}					Y
	
Checking if DCBO Password is encrypted niq.ini file
    [Tags]                      SB-To-MB
    Set Client Configuration    timeout=25 seconds          prompt=#:
    ${state}=                   Execute Command             cat /eniq/installation/config/niq.ini | grep DCBOPassword_Encrypted= | cut -f2 -d'=' | head -1
	Should Contain				${state}					Y
	
Checking if DCPUBLIC Password is encrypted niq.ini file
    [Tags]                      SB-To-MB
    Set Client Configuration    timeout=25 seconds          prompt=#:
    ${state}=                   Execute Command             cat /eniq/installation/config/niq.ini | grep DCPUBLICPassword_Encrypted= | cut -f2 -d'=' | head -1
	Should Contain				${state}					Y
	
Checking if DWHREP Password is encrypted niq.ini file
    [Tags]                      SB-To-MB
    Set Client Configuration    timeout=25 seconds          prompt=#:
    ${state}=                   Execute Command             cat /eniq/installation/config/niq.ini | grep ETLREPPassword_Encrypted= | cut -f2 -d'=' | head -1
	Should Contain				${state}					Y
	
Checking if ETLREP Password is encrypted niq.ini file
    [Tags]                      SB-To-MB
    Set Client Configuration    timeout=25 seconds          prompt=#:
    ${state}=                   Execute Command             cat /eniq/installation/config/niq.ini | grep DWHREPPassword_Encrypted= | cut -f2 -d'=' | head -1
	Should Contain				${state}					Y
