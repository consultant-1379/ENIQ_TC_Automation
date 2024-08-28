*** Settings ***
Suite Setup        Open Connection And Log In
Suite Teardown     Close All Connections
Library           SSHLibrary
Library           DateTime
Library           DependencyLibrary
Resource          ../Resources/Resource.resource


*** Test Cases ***
Checking eniq_patch_history file in source TC01
    [Documentation]      Checking for eniq_patch_history file in /eniq/installation/config directory
    [Tags]               ENIQ_History
    ${patch_grep_word}    Set Variable    No packages to update
    Set Global Variable    ${patch_grep_word}
    ${patch_output_var}=       Execute Command     ls -lrt /var/ericsson/log/patch/ | grep -v "pre_upgrade_patchrhel.bsh_YUM_*" | grep -i "pre_upgrade_patchrhel.bsh_*" | tail -1 | awk '{print $NF}'
    Set Global Variable    ${patch_output_var}
    ${patch_var}=      Execute Command    cat /var/ericsson/log/patch/${patch_output_var} | grep 'No packages to update'
    Set Global Variable    ${patch_var}
    IF    '${patch_var}' == '${patch_grep_word}'
        Skip     Upgrade not happened or it is skipped.
    ELSE
        Check File Exists    /eniq/installation/config/eniq_patch_history
    END

Checking eniq_patch_history file size in source TC02
    Depends on test      Checking eniq_patch_history file in source TC01
    [Documentation]      Checking for non empty eniq_patch_history file in /eniq/installation/config directory
    [Tags]               ENIQ_History
    Check File Size      /eniq/installation/config/eniq_patch_history

Checking eniq_patch_history file in destination TC03
    Depends on test      Checking eniq_patch_history file size in source TC02
    [Documentation]      Checking for eniq_patch_history file in /eniq/log/ddc_data/${hostname}/${date_dmy}/plugin_data/om_patch_media_info directory
    [Tags]               ENIQ_History
    Check File Exists    /eniq/log/ddc_data/${hostname}/${date_dmy}/plugin_data/om_patch_media_info/eniq_patch_history

Checking eniq_patch_history file size in destination TC04
    Depends on test      Checking eniq_patch_history file in destination TC03
    [Documentation]      Checking for non empty eniq_patch_history file in /eniq/log/ddc_data/${hostname}/${date_dmy}/plugin_data/om_patch_media_info directory
    [Tags]               ENIQ_History
    Check File Size      /eniq/log/ddc_data/${hostname}/${date_dmy}/plugin_data/om_patch_media_info/eniq_patch_history

Checking eniq_om_history file in source TC05
    [Documentation]      Checking for eniq_om_history file in /eniq/installation/config directory
    [Tags]               ENIQ_History
    Check File Exists    /eniq/installation/config/eniq_om_history

Checking eniq_om_history file size in source TC06
    Depends on test      Checking eniq_om_history file in source TC05
    [Documentation]      Checking for non empty eniq_om_history file in /eniq/installation/config directory
    [Tags]               ENIQ_History
    Check File Size      /eniq/installation/config/eniq_om_history

Checking eniq_om_history file in destination TC07
    Depends on test      Checking eniq_om_history file size in source TC06
    [Documentation]      Checking for eniq_om_history file in /eniq/log/ddc_data/${hostname}/${date_dmy}/plugin_data/om_patch_media_info directory
    [Tags]               ENIQ_History
    Check File Exists    /eniq/log/ddc_data/${hostname}/${date_dmy}/plugin_data/om_patch_media_info/eniq_om_history

Checking eniq_om_history file size in destination TC08
    Depends on test      Checking eniq_om_history file in destination TC07
    [Documentation]      Checking for non empty eniq_om_history file in /eniq/log/ddc_data/${hostname}/${date_dmy}/plugin_data/om_patch_media_info directory
    [Tags]               ENIQ_History
    Check File Size      /eniq/log/ddc_data/${hostname}/${date_dmy}/plugin_data/om_patch_media_info/eniq_om_history

Checking eniq_patch_status file in source TC09
    [Documentation]              Checking for eniq_patch_status file in /eniq/installation/config directory
    [Tags]                       ENIQ_History
    ${patch_status_grep_word}    Set Variable    No packages to update
    Set Global Variable    ${patch_status_grep_word}
    ${patch_status_output_var}=       Execute Command     ls -lrt /var/ericsson/log/patch/ | grep -v "pre_upgrade_patchrhel.bsh_YUM_*" | grep -i "pre_upgrade_patchrhel.bsh_*" | tail -1 | awk '{print $NF}'
    Set Global Variable    ${patch_status_output_var}
    ${patch_status_var}=      Execute Command    cat /var/ericsson/log/patch/${patch_status_output_var} | grep 'No packages to update'
    Set Global Variable    ${patch_status_var}
    IF    '${patch_status_var}' == '${patch_status_grep_word}'
        Skip     Upgrade not happened or it is skipped.
    ELSE
        Check File Exists    /eniq/installation/config/eniq_patch_status
    END

Checking eniq_patch_status file size in source TC10
    Depends on test      Checking eniq_patch_status file in source TC09
    [Documentation]      Checking for non empty eniq_patch_status file in /eniq/installation/config directory
    [Tags]               ENIQ_History
    Check File Size      /eniq/installation/config/eniq_patch_status

Checking eniq_patch_status file in destination TC11
    Depends on test      Checking eniq_patch_status file size in source TC10
    [Documentation]      Checking for eniq_patch_status file in /eniq/log/ddc_data/${hostname}/${date_dmy}/plugin_data/om_patch_media_info directory
    [Tags]               ENIQ_History
    Check File Exists    /eniq/log/ddc_data/${hostname}/${date_dmy}/plugin_data/om_patch_media_info/eniq_patch_status

Checking eniq_patch_status file size in destination TC12
    Depends on test      Checking eniq_patch_status file in destination TC11
    [Documentation]      Checking for non empty eniq_patch_status file in /eniq/log/ddc_data/${hostname}/${date_dmy}/plugin_data/om_patch_media_info directory
    [Tags]               ENIQ_History
    Check File Size      /eniq/log/ddc_data/${hostname}/${date_dmy}/plugin_data/om_patch_media_info/eniq_patch_status

Checking eniq_om_status file in source TC13
    [Documentation]      Checking for eniq_om_status file in /eniq/installation/config directory
    [Tags]               ENIQ_History
    Check File Exists    /eniq/installation/config/eniq_om_status

Checking eniq_om_status file size in source TC14
    Depends on test      Checking eniq_om_status file in source TC13
    [Documentation]      Checking for non empty eniq_om_status file in /eniq/installation/config directory
    [Tags]               ENIQ_History
    Check File Size      /eniq/installation/config/eniq_om_status

Checking eniq_om_status file in destination TC15
    Depends on test      Checking eniq_om_status file size in source TC14
    [Documentation]      Checking for eniq_om_status file in /eniq/log/ddc_data/${hostname}/${date_dmy}/plugin_data/om_patch_media_info directory
    [Tags]               ENIQ_History
    Check File Exists    /eniq/log/ddc_data/${hostname}/${date_dmy}/plugin_data/om_patch_media_info/eniq_om_status

Checking eniq_om_status file size in destination TC16
    Depends on test      Checking eniq_om_status file in destination TC15
    [Documentation]      Checking for non empty eniq_om_status file in /eniq/log/ddc_data/${hostname}/${date_dmy}/plugin_data/om_patch_media_info directory
    [Tags]               ENIQ_History
    Check File Size      /eniq/log/ddc_data/${hostname}/${date_dmy}/plugin_data/om_patch_media_info/eniq_om_status
