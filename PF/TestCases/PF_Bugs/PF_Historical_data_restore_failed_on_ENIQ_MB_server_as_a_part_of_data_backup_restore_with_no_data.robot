*** Settings ***
Library    SSHLibrary
Resource    ../../Resources/Keywords/Cli.robot
Resource    ../../Resources/Keywords/Variables.robot
Suite Setup   Open connection as root user
Suite Teardown   Close All Connections


*** Test Cases ***
Historical data restore failed on ENIQ MB server as a part of data backup restore with no data
    ${dwhdatabase_log}=    Execute Command    cat /eniq/sw/installer/restore_dwhdb_database | grep -i -- "-o ServerAliveInterval=60" 
    Should Not Be Empty    ${dwhdatabase_log}
   