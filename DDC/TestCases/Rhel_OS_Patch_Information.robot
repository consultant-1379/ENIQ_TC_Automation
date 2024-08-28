*** Settings ***
Suite Setup        Open Connection And Log In
Suite Teardown     Close All Connections
Library           SSHLibrary
Library           DateTime
Library           DependencyLibrary
Resource          ../Resources/Resource.resource


*** Test Cases ***
Checking for redhat-release file in Rhel_OS source TC01
    [Documentation]          Checking for redhat-release log file in /etc directory
    [Tags]                   Rhel_OS_Patch_Information
    ${rhel_version_file}=    Execute Command    ls /etc/redhat-release
    Set Global Variable      ${rhel_version_file}
    Check File Exists        ${rhel_version_file}

Checking for redhat-release file size in Rhel_OS source TC02
    Depends on test      Checking for redhat-release file in Rhel_OS source TC01
    [Documentation]      Checking for non empty redhat-release log file in /etc directory
    [Tags]               Rhel_OS_Patch_Information
    Check File Size      ${rhel_version_file}

Checking for redhat-release file in Rhel_OS destination TC03
    Depends on test      Checking for redhat-release file size in Rhel_OS source TC02
    [Documentation]      Checking for redhat-release log file in /eniq/log/ddc_data/${hostname}/${date_dmy}/plugin_data/rhel_patch_version directory
    [Tags]               Rhel_OS_Patch_Information
    Check File Exists    /eniq/log/ddc_data/${hostname}/${date_dmy}/plugin_data/rhel_patch_version/redhat-release

Checking for redhat-release file size in Rhel_OS destination TC04
    Depends on test      Checking for redhat-release file in Rhel_OS destination TC03
    [Documentation]      Checking for non empty redhat-release log file in /eniq/log/ddc_data/${hostname}/${date_dmy}/plugin_data/rhel_patch_version directory
    [Tags]               Rhel_OS_Patch_Information
    Check File Size      /eniq/log/ddc_data/${hostname}/${date_dmy}/plugin_data/rhel_patch_version/redhat-release

Checking for pre_upgrade_patchrhel file in Rhel_OS source TC05
    [Documentation]            Checking for pre_upgrade_patchrhel.bsh log file in /var/ericsson/log/patch directory
    [Tags]                     Rhel_OS_Patch_Information
    ${patch_version_file} =    Execute Command    find /var/ericsson/log/patch -name "pre_upgrade_patchrhel.bsh_??-??-????_??-??-??.log" -printf "%T@ %p\n" -ls | sort -n | cut -d'/' -f 6- | tail -n 1
    Set Global Variable        ${patch_version_file}
    Check File Exists          /var/ericsson/log/patch/${patch_version_file}

Checking for pre_upgrade_patchrhel file size in Rhel_OS source TC06
    Depends on test      Checking for pre_upgrade_patchrhel file in Rhel_OS source TC05
    [Documentation]      Checking for non empty pre_upgrade_patchrhel.bsh log file in /var/ericsson/log/patch directory
    [Tags]               Rhel_OS_Patch_Information
    Check File Size      ${rhel_version_file}

Checking for pre_upgrade_patchrhel file in Rhel_OS destination TC07
    Depends on test      Checking for pre_upgrade_patchrhel file size in Rhel_OS source TC06
    [Documentation]      Checking for pre_upgrade_patchrhel.bsh log file in /eniq/log/ddc_data/${hostname}/${date_dmy}/plugin_data/rhel_patch_version directory
    [Tags]               Rhel_OS_Patch_Information
    Check File Exists    /eniq/log/ddc_data/${hostname}/${date_dmy}/plugin_data/rhel_patch_version/${patch_version_file}

Checking for pre_upgrade_patchrhel file size in Rhel_OS destination TC08
    Depends on test      Checking for pre_upgrade_patchrhel file in Rhel_OS destination TC07
    [Documentation]      Checking for non empty pre_upgrade_patchrhel.bsh log file in /eniq/log/ddc_data/${hostname}/${date_dmy}/plugin_data/rhel_patch_version directory
    [Tags]               Rhel_OS_Patch_Information
    Check File Size      /eniq/log/ddc_data/${hostname}/${date_dmy}/plugin_data/rhel_patch_version/${patch_version_file}
