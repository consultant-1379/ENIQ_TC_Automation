*** Settings ***
Suite Setup        Open Connection And Log In
Suite Teardown     Close All Connections
Library            SSHLibrary
Resource           ../Resources/resource.txt

*** Variables ***

*** Test Cases ***
Checking the conf file for deployment type
        [Tags]                      deployment_type                         
        Set Client Configuration    timeout=25 seconds                  prompt=#:
        ${output}=                  Execute Command                     ls -lart /eniq/sw/conf/mws_password_file
	Should Contain              ${output}                           /eniq/sw/conf/mws_password_file
		
		
Checking the config file for deployment type
        [Tags]                      deployment_type                         
        Set Client Configuration    timeout=25 seconds                  prompt=#:
        ${output}=                  Execute Command                     ls -lart /eniq/installation/config/mws_password_file
	Should Contain              ${output}                           /eniq/installation/config/mws_password_file
