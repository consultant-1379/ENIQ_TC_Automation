*** Settings ***
Suite Setup        Open Connection And Log In
Suite Teardown     Close All Connections
Library            SSHLibrary
Library            DateTime
Library            DependencyLibrary
Resource           ../Resources/Resource.resource


*** Test Cases ***
Checking for os_rhel_memory_profile file in OS source
    [Documentation]       Checking for os_rhel_memory_profile_${date_Y-m-d}.txt file in /tmp directory
    [Tags]                os_Memory_Profile
    Check File Exists     /tmp/os_rhel_memory_profile_${date_Y-m-d}.txt

Checking for os_rhel_memory_profile file size in OS source
    Depends on test       Checking for os_rhel_memory_profile file in OS source
    [Documentation]       Checking for non empty os_rhel_memory_profile_${date_Y-m-d}.txt file in /tmp directory
    [Tags]                os_Memory_Profile
    Check File Size       /tmp/os_rhel_memory_profile_${date_Y-m-d}.txt

Checking for os_rhel_memory_profile file in OS destination
    Depends on test       Checking for os_rhel_memory_profile file size in OS source
    [Documentation]       Checking for os_rhel_memory_profile_${date_Y-m-d}.txt file in /eniq/log/ddc_data/${hostname}/${date_dmy}/plugin_data/osMemoryProfile directory
    [Tags]                os_Memory_Profile
    Check File Exists     /eniq/log/ddc_data/${hostname}/${date_dmy}/plugin_data/osMemoryProfile/os_rhel_memory_profile_${date_Y-m-d}.txt

Checking for os_rhel_memory_profile file size in OS destination
    Depends on test       Checking for os_rhel_memory_profile file in OS destination
    [Documentation]       Checking for non empty os_rhel_memory_profile_${date_Y-m-d}.txt file in /eniq/log/ddc_data/${hostname}/${date_dmy}/plugin_data/osMemoryProfile directory
    [Tags]                os_Memory_Profile
    Check File Size       /eniq/log/ddc_data/${hostname}/${date_dmy}/plugin_data/osMemoryProfile/os_rhel_memory_profile_${date_Y-m-d}.txt

Checking for os_rhel_memory_profile file in OS engine destination
    Depends on test       Checking for os_rhel_memory_profile file size in OS destination
    [Documentation]       Checking for os_rhel_memory_profile_${date_Y-m-d}.txt file in /eniq/log/ddc_data/${hostname_engine}/${date_dmy}/plugin_data/osMemoryProfile directory from from Engine Blade
    [Tags]                os_Memory_Profile
    Check File Exists     /eniq/log/ddc_data/${hostname_engine}/${date_dmy}/plugin_data/osMemoryProfile/os_rhel_memory_profile_${date_Y-m-d}.txt

Checking for os_rhel_memory_profile file size in OS engine destination
    Depends on test       Checking for os_rhel_memory_profile file in OS engine destination
    [Documentation]       Checking for non empty os_rhel_memory_profile_${date_Y-m-d}.txt file in /eniq/log/ddc_data/${hostname_engine}/${date_dmy}/plugin_data/osMemoryProfile directory from Engine Blade
    [Tags]                os_Memory_Profile
    Check File Size       /eniq/log/ddc_data/${hostname_engine}/${date_dmy}/plugin_data/osMemoryProfile/os_rhel_memory_profile_${date_Y-m-d}.txt

Checking for os_rhel_memory_profile file in OS reader_1 destination
    Depends on test       Checking for os_rhel_memory_profile file size in OS engine destination
    [Documentation]       Checking for os_rhel_memory_profile_${date_Y-m-d}.txt file in /eniq/log/ddc_data/${hostname_reader_1}/${date_dmy}/plugin_data/osMemoryProfile directory from dwh_reader_1 Blade
    [Tags]                os_Memory_Profile
    Check File Exists     /eniq/log/ddc_data/${hostname_reader_1}/${date_dmy}/plugin_data/osMemoryProfile/os_rhel_memory_profile_${date_Y-m-d}.txt

Checking for os_rhel_memory_profile file size in OS reader_1 destination
    Depends on test       Checking for os_rhel_memory_profile file in OS reader_1 destination
    [Documentation]       Checking for non empty os_rhel_memory_profile_${date_Y-m-d}.txt file in /eniq/log/ddc_data/${hostname_reader_1}/${date_dmy}/plugin_data/osMemoryProfile directory from dwh_reader_1 Blade
    [Tags]                os_Memory_Profile
    Check File Size       /eniq/log/ddc_data/${hostname_reader_1}/${date_dmy}/plugin_data/osMemoryProfile/os_rhel_memory_profile_${date_Y-m-d}.txt

Checking for os_rhel_memory_profile file in OS reader_2 destination
    Depends on test       Checking for os_rhel_memory_profile file size in OS reader_1 destination
    [Documentation]       Checking for os_rhel_memory_profile_${date_Y-m-d}.txt file in /eniq/log/ddc_data/${hostname_reader_2}/${date_dmy}/plugin_data/osMemoryProfile directory from dwh_hostname_reader_2 Blade
    [Tags]                os_Memory_Profile
    Check File Exists     /eniq/log/ddc_data/${hostname_reader_2}/${date_dmy}/plugin_data/osMemoryProfile/os_rhel_memory_profile_${date_Y-m-d}.txt

Checking for os_rhel_memory_profile file size in OS reader_2 destination
    Depends on test       Checking for os_rhel_memory_profile file in OS reader_2 destination
    [Documentation]       Checking for non empty os_rhel_memory_profile_${date_Y-m-d}.txt file in /eniq/log/ddc_data/${hostname_reader_2}/${date_dmy}/plugin_data/osMemoryProfile directory from dwh_hostname_reader_2 Blade
    [Tags]                os_Memory_Profile
    Check File Size       /eniq/log/ddc_data/${hostname_reader_2}/${date_dmy}/plugin_data/osMemoryProfile/os_rhel_memory_profile_${date_Y-m-d}.txt
