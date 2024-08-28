*** Settings ***
Documentation    Testing symboliclinkcreator
Library           SSHLibrary
Library        String
Library        Collections
Resource    ../../Resources/Keywords/Engine.robot
Resource    ../../Resources/Keywords/Variables.robot
Resource    ../../Resources/Keywords/Cli.robot
Test Setup    Settting up suite for testcase
Test Teardown    Close All Connections

*** Variables ***
${new_password_dcbo}    Dcbo1234#



*** Test Cases ***
 Verify the dbuser password change of dcbo user
    ${delete}    Execute Command     rm -rf /eniq/sw/installer/.dbpasslock.tmp
    ${db_pwd}=    Execute Command    /eniq/sw/installer/getPassword.bsh -u dcbo|cut -d ":" -f 2-| cut -d " " -f 2-
    Write    bash /eniq/admin/bin/manage_deployment_services.bsh -a stop -s ALL
    ${stopping_all_services}    Read    delay=5s
    Write    Yes
    ${confirm_stop_service}    Read Until Prompt    strip_prompt=True
    #Sleep    5m 
    Write    bash /eniq/admin/bin/manage_eniq_services.bsh -a start -s dwhdb,repdb
    ${starting_dwhdb_repdb}    Read    delay=5s
    Write    Yes
    ${confirm_start_dwhdp_service}    Read Until Prompt    strip_prompt=True
    #Sleep    5m
    Write    bash /eniq/admin/bin/change_db_password.bsh -u dcbo
    ${change_password}    Read    delay=5s  
    Write    ${db_pwd}
    ${password_change}    Read    delay=5s
    Write    ${new_password_dcbo}
    ${new_dc_passwords}    Read    delay=5s
    Write    ${new_password_dcbo}
    ${new_dc_passwors}    Read    delay=5s
    Write    Yes
    ${confirm_change_password}    Read    delay=7s
    Write    bash /eniq/admin/bin/manage_deployment_services.bsh -a start -s ALL
    ${starting_all_services}    Read    delay=5s  
    Write    Yes
    ${confirm_change_password}    Read Until Prompt    strip_prompt=True
    #Sleep    5m
    ${db_new_pwd}=    Execute Command    /eniq/sw/installer/getPassword.bsh -u dcbo|cut -d ":" -f 2-| cut -d " " -f 2-
    Should Be Equal    ${new_password_dcbo}    ${db_new_pwd}






*** Keywords ***

Settting up suite for testcase
    Open connection as root user
    Set Client Configuration    prompt=REGEXP:#     timeout=300s






   