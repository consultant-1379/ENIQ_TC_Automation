*** Settings ***
Suite Setup            Open Connection And Log In
Suite Teardown         Close All Connections
Library                SSHLibrary
Library                BuiltIn
Library                String
Resource               ../../Resources/resource.txt

*** Test Cases ***
Checking default entry of table types present in the configuration file
    [Tags]                           Coordinator
    Set Client Configuration         timeout=25 seconds                    prompt=#:
    ${output}=                       Execute Command                       cat /eniq/log/sw_log/iq/CounterTool/tables_to_be_considered.txt  
    Should Contain                   ${output}                             dc_
    Should Contain                   ${output}                             pm_
