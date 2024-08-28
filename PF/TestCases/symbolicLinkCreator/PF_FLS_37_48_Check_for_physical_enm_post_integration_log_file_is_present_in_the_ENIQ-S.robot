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
Check for physical enm_post_integration log file is present in the ENIQ-S 
    Verify for physical enm_post_integration log file is present in the ENIQ-S 