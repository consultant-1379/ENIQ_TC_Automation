*** Settings ***
Suite Setup        Open Connection And Log In
Suite Teardown     Close All Connections
Library            SSHLibrary
Library			   BuiltIn	
Resource           ../../Resources/resource.txt

*** Variables ***
   
*** Test Cases ***

Checking the deployment type after expansion
	[Tags]                      Server_type				SB-to-MB
    Set Client Configuration    timeout=25 seconds  	prompt=#:
	${value}=                   Execute Command         cat /eniq/installation/config/installed_server_type
	Should Contain 				${value}				stats_coordinator
	
Checking the deployment size after expansion
	[Tags]                      Server_type				SB-to-MB
    Set Client Configuration    timeout=25 seconds  	prompt=#:
	${value1}=                  Execute Command			cat /eniq/installation/config/lun_map.ini | grep -c maindb_
	${output}=					Execute Command			cat /eniq/installation/config/extra_params/deployment
	IF							${value1} >= 13
	Should Contain 				${output}				large
	ELSEIF 						${value1} >= 33
	Should Contain				${output}				extralarge
	ELSE
	Should Contain				${output}				ft
	END	
