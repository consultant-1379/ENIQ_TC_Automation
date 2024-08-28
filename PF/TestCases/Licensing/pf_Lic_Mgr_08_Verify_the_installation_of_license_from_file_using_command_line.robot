*** Settings ***
Library    SSHLibrary
Resource    ../../Resources/Keywords/Engine.robot
Resource    ../../Resources/Keywords/Cli.robot
Resource    ../../Resources/Keywords/Variables.robot
Resource    ../../Resources/Keywords/Licensing_keywords.robot
Test Teardown    Close All Connections


*** Test Cases ***
Verify the installation of license from file using command line
    Connect to server as a dcuser
    #Copying latest release from MWS path to server and doing license installation
    Verify license got installed
