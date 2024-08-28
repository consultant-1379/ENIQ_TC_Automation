*** Settings ***
Library    SSHLibrary
Resource    ../../Resources/Keywords/Cli.robot
Resource    ../../Resources/Keywords/Variables.robot
Resource    ../../Resources/Keywords/Licensing_keywords.robot
Suite Setup    Open connection as root user
Suite Teardown    Close All Connections

*** Test Cases ***
Verify whether rmiregistry and nas services are up and running
    ${nas_service_available}=    Verify nas service is present in server
    IF    ${nas_service_available} == True
        Verify eniq service is loaded active and running    rmiregistry    
        Verify eniq service is loaded active and running    nasd 
        Verify eniq service is loaded active and running    nas-online
    ELSE
        Verify eniq service is loaded active and running    rmiregistry   
    END

