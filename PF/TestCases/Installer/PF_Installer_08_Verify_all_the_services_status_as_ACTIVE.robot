*** Settings ***
Force Tags    suite
Library    SSHLibrary
Library    Collections
Library    String
Resource    ../../Resources/Keywords/Cli.robot
Resource    ../../Resources/Keywords/Installer.robot
Resource    ../../Resources/Keywords/Variables.robot
Suite Teardown    Sleeping for 30m and close connection

*** Test Cases ***
verify all the services up and running
    Open connection as root user
    ${STATE}    Execute Command    bash /eniq/admin/bin/manage_deployment_services.bsh -a list -s ALL | awk '/SERVICE/ { flag=1; next } /LOGFILE/ { flag=0 } flag && NF { print $2}'
    @{STATE_VALUE}    Split To Lines    ${STATE}
    FOR    ${element}    IN    @{STATE_VALUE}
        Log To Console    ${element}
        Should Match Regexp    ${element}    \\bactive\\b
    END
    


*** Keywords ***
Sleeping for 30m and close connection
    Close All Connections
    sleep    1800s
    

    