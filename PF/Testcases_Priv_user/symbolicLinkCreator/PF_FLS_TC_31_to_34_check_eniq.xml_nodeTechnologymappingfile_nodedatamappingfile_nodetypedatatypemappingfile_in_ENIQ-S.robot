*** Settings ***
Documentation     Testing Symboliclinkcreator
Library           SSHLibrary
Library        Process
Resource    ../../Resources/Keywords/Variables.robot
Resource    ../../Resources/Keywords/Cli.robot
Resource    ../../Resources/Keywords/FLS_keywords.robot
Suite Setup    Open connection as root user
Suite Teardown    Close All Connections

*** Test Cases ***
Check physical eniq.xml is present in the ENIQ-S
    Verify eniq.xml is present in the ENIQ-S

Check physical NodeTechnologyMapping file is present in the ENIQ-S
    Verify physical NodeTechnologyMapping file is present in the ENIQ-S

Check physical NodeDataMapping.properties file is present in the ENIQ-S
    Verify physical NodeDataMapping.properties file is present in the ENIQ-S

Check physical NodeTypeDataTypeMapping.properties file is present in the ENIQ-S
    Verify physical NodeTypeDataTypeMapping.properties file is present in the ENIQ-S

*** Keywords ***
Test teardown
    Close All Connections

