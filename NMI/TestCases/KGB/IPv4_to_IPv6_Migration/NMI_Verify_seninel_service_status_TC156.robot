*** Settings ***
Suite Setup        Open Connection And Log In
Suite Teardown     Close All Connections
Library            SSHLibrary
Resource           ../Resources/resource.txt

*** Variables ***

*** Test Cases ***
Checking if the sentinel service is enabled
        [Tags]                      sentinel service                        
        Set Client Configuration    timeout=25 seconds                  prompt=#:
        ${output}=                  Execute Command                     systemctl status licensing-sentinel | grep "loaded" | awk -F";" '{print $2}'
	Should Contain              ${output}                           enabled
