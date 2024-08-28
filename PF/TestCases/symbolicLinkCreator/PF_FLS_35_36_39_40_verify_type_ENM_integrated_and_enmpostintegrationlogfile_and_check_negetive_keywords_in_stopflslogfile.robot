*** Settings ***
Documentation     Testing Symboliclinkcreator
Library           SSHLibrary
Library    String
Library    Process
Library    Collections
Resource    ../../Resources/Keywords/Cli.robot
Resource    ../../Resources/Keywords/Variables.robot
Resource    ../../Resources/Keywords/FLS_keywords.robot
Suite Setup    Connect to server as a dcuser
Suite Teardown    Close All Connections

*** Test Cases ***
Check physical enm_type file is present in the ENIQ-S
    Verify physical enm_type file is present in the ENIQ-S

# Check for physical enm_post_integration log file is present in the ENIQ-S 
#     Verify for physical enm_post_integration log file is present in the ENIQ-S 

Check for stop_fls log file is present in the ENIQ-S 
    Verify stop_fls log file is present in the ENIQ-S 

*** Keywords ***
Test teardown
    Close All Connections