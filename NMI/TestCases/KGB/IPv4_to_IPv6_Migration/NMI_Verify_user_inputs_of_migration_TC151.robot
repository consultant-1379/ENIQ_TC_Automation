*** Settings ***
Suite Setup        Open Connection And Log In
Suite Teardown     Close All Connections
Library            SSHLibrary
Resource           ../Resources/resource.txt

*** Variables ***

*** Test Cases ***
Checking the migration_user_inputs
        [Tags]                      user inputs                         
        Set Client Configuration    timeout=25 seconds                  prompt=#:
        ${output}=                  Execute Command                     ls -lart /eniq/sw/conf/migration_user_inputs.txt
	Should Contain              ${output}                           /eniq/sw/conf/migration_user_inputs.txt
