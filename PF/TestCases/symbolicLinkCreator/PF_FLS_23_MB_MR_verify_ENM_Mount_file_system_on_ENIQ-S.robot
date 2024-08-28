*** Settings ***
Documentation     Testing Symboliclinkcreator
Library    SSHLibrary
Resource    ../../Resources/Keywords/Engine.robot
Resource    ../../Resources/Keywords/Cli.robot
Resource    ../../Resources/Keywords/Variables.robot
Resource    ../../Resources/Keywords/FLS_keywords.robot
Test Teardown    Close All Connections


*** Test Cases ***
Verifying ENM Mount file system on ENIQ-S
    Verify if pmdata pmic1 and pmic2 exist under df -hk in MB and MR server