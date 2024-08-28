*** Settings ***
Library    CryptoLibrary    variable_decryption=True
Library    SSHLibrary
Variables    ../Resources/Variables/Variables.py

Test Setup    Login to mws
Test Teardown    Close All Connections

*** Keywords ***
Login to mws
    Open Connection    ${mwshost}
    Login    ${mwsuser}    ${mwspwd}    delay=1

*** Test Cases ***
Verify if Deployment Tool file system createdn on MWS UG server on MWS UG server

    ${output1}=    Execute Command    df -h | grep /Deployment_Tool
    Should Not Be Empty     ${output1}
	
    ${output2}=    Execute Command    lvs | grep Deployment_Tool
    Should Not Be Empty     ${output2}
