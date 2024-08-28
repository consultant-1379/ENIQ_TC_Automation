*** Settings ***
Suite Setup        Open Connection And Log In
Suite Teardown     Close All Connections
Library            SSHLibrary
Resource           ../Resources/resource.txt

*** Variables ***

*** Test Cases ***
Checking the status of licensing service
        [Tags]                      licensing service                         
        Set Client Configuration    timeout=25 seconds                  prompt=#:
        ${output}=                  Execute Command                     systemctl status licensing-sentinel | grep "Active:"
	Should Contain              ${output}                           active
