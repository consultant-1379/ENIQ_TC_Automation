*** Settings ***
Suite Setup        Open Connection And Log In
Suite Teardown     Close All Connections
Library            SSHLibrary
Library			   BuiltIn	
Library            String
Resource           ../../Resources/resource.txt

*** Variables ***
   
*** Test Cases ***	
	
Checking SSH connection from Coordinator to Engine after SB to MB expansion
    [Tags]                      SSH 					SB-to-MB
    Set Client Configuration    timeout=25 seconds  	prompt=#: 	
    Write 						ssh ${host1}
	${output}=					Read 					delay=3s
	Should Contain				${output}				login:
	Write 						exit
	Should Contain				${output}				{root} #:
	
Checking SSH connection from Coordinator to Reader1 after SB to MB expansion
    [Tags]                      SSH 					SB-to-MB
    Set Client Configuration    timeout=25 seconds  	prompt=#: 	
    Write 						ssh ${host2}
	${output}=					Read 					delay=3s
	Should Contain				${output}				login:
	Write 						exit
	Should Contain				${output}				{root} #:
	
Checking SSH connection from Coordinator to Reader2 after SB to MB expansion
    [Tags]                      SSH 					SB-to-MB
    Set Client Configuration    timeout=25 seconds  	prompt=#: 	
    Write 						ssh ${host3}
	${output}=					Read 					delay=3s
	Should Contain				${output}				login:
	Write 						exit
	Should Contain				${output}				{root} #:
