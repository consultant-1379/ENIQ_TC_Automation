*** Settings ***
Documentation    Testing symboliclinkcreator
Library           SSHLibrary
Library        String
Library        Collections
Resource    ../../Resources/Keywords/Engine.robot
Resource    ../../Resources/Keywords/Variables.robot
Resource    ../../Resources/Keywords/Cli.robot
Suite Setup    Settting up suite for testcase
Suite Teardown    Close All Connections

*** Variables ***
${new_password_dc}    Dc1234#
${new_password_dcbo}    Dcbo1234#
${new_password_etlrep}    Etlrep1234#
${new_password_dwhrep}    Dwhrep1234#
${new_password_dba}    Dba1234#
${new_password_dcpublic}    Dcpublic1234#


*** Test Cases ***
Verify the dbuser password change of dc user
    ${db_pwd}=    Execute Command    /eniq/sw/installer/getPassword.bsh -u dc|cut -d ":" -f 2-| cut -d " " -f 2-
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
    Write    bash /eniq/admin/bin/change_db_password.bsh -u dc
    ${change_password}    Read    delay=5s  
    Write    ${db_pwd}
    ${password_change}    Read    delay=5s
    Write    ${new_password_dc}
    ${new_dc_passwords}    Read    delay=5s
    Write    ${new_password_dc}
    ${new_dc_passwors}    Read    delay=5s
    Write    Yes
    ${confirm_change_password}    Read    delay=7s
    Write    bash /eniq/admin/bin/manage_deployment_services.bsh -a start -s ALL
    ${starting_all_services}    Read    delay=5s  
    Write    Yes
    ${confirm_change_password}    Read Until Prompt    strip_prompt=True
    #Sleep    5m
    ${db_new_pwd}=    Execute Command    /eniq/sw/installer/getPassword.bsh -u dc|cut -d ":" -f 2-| cut -d " " -f 2-
    Should Be Equal    ${new_password_dc}    ${db_new_pwd}

Verify the dbuser password change of dcbo user
    Skip if    '${PREV TEST STATUS}'=='FAIL' or '${PREV TEST STATUS}'=='SKIP'
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

Verify the dbuser password change of etlrep user
    Skip if    '${PREV TEST STATUS}'=='FAIL' or '${PREV TEST STATUS}'=='SKIP'
    ${delete}    Execute Command     rm -rf /eniq/sw/installer/.dbpasslock.tmp
    ${db_pwd}=    Execute Command    /eniq/sw/installer/getPassword.bsh -u etlrep|cut -d ":" -f 2-| cut -d " " -f 2-
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
    Write    bash /eniq/admin/bin/change_db_password.bsh -u etlrep
    ${change_password}    Read    delay=5s  
    Write    ${db_pwd}
    ${password_change}    Read    delay=5s
    Write    ${new_password_etlrep}
    ${new_dc_passwords}    Read    delay=5s
    Write    ${new_password_etlrep}
    ${new_dc_passwors}    Read    delay=5s
    Write    Yes
    ${confirm_change_password}    Read    delay=7s
    Write    bash /eniq/admin/bin/manage_deployment_services.bsh -a start -s ALL
    ${starting_all_services}    Read    delay=5s  
    Write    Yes
    ${confirm_change_password}    Read Until Prompt    strip_prompt=True
    #Sleep    5m
    ${db_new_pwd}=    Execute Command    /eniq/sw/installer/getPassword.bsh -u etlrep|cut -d ":" -f 2-| cut -d " " -f 2-
    Should Be Equal    ${new_password_etlrep}    ${db_new_pwd}

Verify the dbuser password change of dwhrep user
    Skip if    '${PREV TEST STATUS}'=='FAIL' or '${PREV TEST STATUS}'=='SKIP'
    ${delete}    Execute Command     rm -rf /eniq/sw/installer/.dbpasslock.tmp
    ${db_pwd}=    Execute Command    /eniq/sw/installer/getPassword.bsh -u dwhrep|cut -d ":" -f 2-| cut -d " " -f 2-
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
    Write    bash /eniq/admin/bin/change_db_password.bsh -u dwhrep
    ${change_password}    Read    delay=5s  
    Write    ${db_pwd}
    ${password_change}    Read    delay=5s
    Write    ${new_password_dwhrep}
    ${new_dc_passwords}    Read    delay=5s
    Write    ${new_password_dwhrep}
    ${new_dc_passwors}    Read    delay=5s
    Write    Yes
    ${confirm_change_password}    Read    delay=7s
    Write    bash /eniq/admin/bin/manage_deployment_services.bsh -a start -s ALL
    ${starting_all_services}    Read    delay=5s  
    Write    Yes
    ${confirm_change_password}    Read Until Prompt    strip_prompt=True
    #Sleep    5m
    ${db_new_pwd}=    Execute Command    /eniq/sw/installer/getPassword.bsh -u dwhrep|cut -d ":" -f 2-| cut -d " " -f 2-
    Should Be Equal    ${new_password_dwhrep}    ${db_new_pwd}

Verify the dbuser password change of dba user
    Skip if    '${PREV TEST STATUS}'=='FAIL' or '${PREV TEST STATUS}'=='SKIP'
    ${delete}    Execute Command     rm -rf /eniq/sw/installer/.dbpasslock.tmp
    ${db_pwd}=    Execute Command    /eniq/sw/installer/getPassword.bsh -u dba|cut -d ":" -f 2-| cut -d " " -f 2-
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
    Write    bash /eniq/admin/bin/change_db_password.bsh -u dba
    ${change_password}    Read    delay=5s  
    Write    ${db_pwd}
    ${password_change}    Read    delay=5s
    Write    ${new_password_dba}
    ${new_dc_passwords}    Read    delay=5s
    Write    ${new_password_dba}
    ${new_dc_passwors}    Read    delay=5s
    Write    Yes
    ${confirm_change_password}    Read    delay=7s
    Write    bash /eniq/admin/bin/manage_deployment_services.bsh -a start -s ALL
    ${starting_all_services}    Read    delay=5s  
    Write    Yes
    ${confirm_change_password}    Read Until Prompt    strip_prompt=True
    #Sleep    5m
    ${db_new_pwd}=    Execute Command    /eniq/sw/installer/getPassword.bsh -u dba|cut -d ":" -f 2-| cut -d " " -f 2-
    Should Be Equal    ${new_password_dba}    ${db_new_pwd}

Verify the dbuser password change of dcpublic user
    Skip if    '${PREV TEST STATUS}'=='FAIL' or '${PREV TEST STATUS}'=='SKIP'
    ${delete}    Execute Command     rm -rf /eniq/sw/installer/.dbpasslock.tmp
    ${db_pwd}=    Execute Command    /eniq/sw/installer/getPassword.bsh -u dcpublic|cut -d ":" -f 2-| cut -d " " -f 2-
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
    Write    bash /eniq/admin/bin/change_db_password.bsh -u dcpublic
    ${change_password}    Read    delay=5s  
    Write    ${db_pwd}
    ${password_change}    Read    delay=5s
    Write    ${new_password_dcpublic}
    ${new_dc_passwords}    Read    delay=5s
    Write    ${new_password_dcpublic}
    ${new_dc_passwors}    Read    delay=5s
    Write    Yes
    ${confirm_change_password}    Read    delay=7s
    Write    bash /eniq/admin/bin/manage_deployment_services.bsh -a start -s ALL
    ${starting_all_services}    Read    delay=5s  
    Write    Yes
    ${confirm_change_password}    Read Until Prompt    strip_prompt=True
    #Sleep    5m
    ${db_new_pwd}=    Execute Command    /eniq/sw/installer/getPassword.bsh -u dcpublic|cut -d ":" -f 2-| cut -d " " -f 2-
    Should Be Equal    ${new_password_dcpublic}    ${db_new_pwd}




*** Keywords ***

Settting up suite for testcase
    Open connection as root user
    Set Client Configuration    prompt=REGEXP:#     timeout=300s






   