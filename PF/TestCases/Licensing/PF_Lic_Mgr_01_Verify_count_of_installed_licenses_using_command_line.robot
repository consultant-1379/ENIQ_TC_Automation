*** Settings ***
Library    SSHLibrary
Resource    ../../Resources/Keywords/Engine.robot
Resource    ../../Resources/Keywords/Cli.robot
Resource    ../../Resources/Keywords/Variables.robot
Resource    ../../Resources/Keywords/Licensing_keywords.robot
Suite Setup    Open connection as root user
Suite Teardown    Close All Connections


*** Test Cases ***
Verify installed licenses with mws using command line
    @{lic_notinmws}    Create List 
    @{lic_notinlicmgr}    Create List

    ${getting_latest_release_value}    Execute Command    ls /net/ieatrcx8190/JUMP/|grep -i -o 'ENIQ_S[0-9][0-9].[0-9]'| tail -1
    Should Not Be Empty    ${getting_latest_release_value}
    Log    ENIQ_Latest_version: ${getting_latest_release_value}

    ${license_count_from_mws_path}    Execute Command    cat /net/ieatrcx8190/JUMP/${getting_latest_release_value} | grep -iE -o '\\"CXC[0-9]{7}\\"' | sed 's/"//g' | sort
    @{list_mwslicense}=    Split To Lines    ${license_count_from_mws_path}    
    Should Not Be Empty    ${list_mwslicense}
    Log    License list in mws: ${list_mwslicense}
    ${count_mwslicense}=    Get Length    ${list_mwslicense}

    ${license_count_installed}    Execute Command    su - dcuser -c "/eniq/sw/bin/licmgr -getlicinfo | grep -o -iE 'CXC[0-9]{7}' | sort"
    @{list_licmgrlicense}=    Split To Lines    ${license_count_installed}
    Should Not Be Empty    ${list_licmgrlicense}
    Log    Installed licenses list: ${list_licmgrlicense}
    ${count_licmgrlicense}=    Get Length    ${list_licmgrlicense}

    ${check_lists_equal}=    Run Keyword And Return Status    Lists Should Be Equal    ${list_licmgrlicense}    ${list_mwslicense}    ignore_order=True
    IF    ${check_lists_equal} == True
        Log    MWS licenses list count: ${count_mwslicense} and Installed licenses list count: ${count_licmgrlicense}
        Log    All installed licenses are matching wih mws license list
    ELSE
        FOR    ${element}    IN    @{list_licmgrlicense}
        ${checklic}=    Run Keyword And Return Status    Should Contain Match    ${list_mwslicense}    ${element}
        Run Keyword If    ${checklic}==False    Append To List    ${lic_notinmws}    ${element}
        END 

        FOR    ${element}    IN    @{list_mwslicense}
        ${checklic}=    Run Keyword And Return Status    Should Contain Match    ${list_licmgrlicense}    ${element}
        Run Keyword If    ${checklic}==False    Append To List    ${lic_notinlicmgr}    ${element}
        END 

        ${notinmws_status}=    Run Keyword And Return Status    Should Be Empty    ${lic_notinmws}
        ${notinlicmger_status}=    Run Keyword And Return Status    Should Be Empty    ${lic_notinlicmgr} 
        IF    ${notinmws_status}==True and ${notinlicmger_status}==True 
            Log    All installed licenses are matching wih mws license list
        ELSE IF    ${notinmws_status}==False and ${notinlicmger_status}== False
            Log    MWS licenses list count: ${count_mwslicense} and Installed licenses list count: ${count_licmgrlicense}
            Fail   Installed Licenses not matching with mws license list: ${lic_notinmws} \nMWS licenses not matching with Installed license list: ${lic_notinlicmgr}
        ELSE IF    ${notinmws_status}==False
            Log    MWS licenses list count: ${count_mwslicense} and Installed licenses list count: ${count_licmgrlicense}    
            Fail    Installed Licenses not matching with mws license list: ${lic_notinmws}
        ELSE IF    ${notinlicmger_status}== False
            Log    MWS licenses list count: ${count_mwslicense} and Installed licenses list count: ${count_licmgrlicense}
            Fail    MWS licenses not matching with Installed license list: ${lic_notinlicmgr}
        END
    END
    