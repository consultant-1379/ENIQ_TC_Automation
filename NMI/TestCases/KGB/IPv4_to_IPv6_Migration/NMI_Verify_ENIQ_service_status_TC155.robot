*** Settings ***
Suite Setup        Open Connection And Log In
Suite Teardown     Close All Connections
Library            SSHLibrary
Resource           ../Resources/resource.txt

*** Variables ***

*** Test Cases ***
Checking the status of ENIQ services
        [Tags]                      ENIQ services                        
        Set Client Configuration    timeout=25 seconds                  prompt=#:
        ${output}=                  Execute Command                     bash /eniq/admin/bin/manage_deployment_services.bsh -a list -s ALL | grep "ENABLED"
	Should Not Contain          ${output}                           ENABLED
