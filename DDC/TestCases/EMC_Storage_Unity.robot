*** Settings ***
Suite Setup        Open Connection And Log In
Suite Teardown     Close All Connections
Library            SSHLibrary
Library            DateTime
Library            DependencyLibrary
Resource           ../Resources/Resource.resource


*** Test Cases ***
Checking for san_details file in unity TC01
    [Documentation]        Checking for san_details file in /eniq/installation/config directory
    [Tags]                 EMC_Storage_Unity
    Check File Exists      /eniq/installation/config/san_details

Checking for san_details file size in unity TC02
    Depends on test        Checking for san_details file in unity TC01
    [Documentation]        Checking for non empty san_details file in /eniq/installation/config directory
    [Tags]                 EMC_Storage_Unity
    Check File Size        /eniq/installation/config/san_details

Checking for san device in unity san_details file TC03
    Depends on test        Checking for san_details file size in unity TC02
    [Tags]                 EMC_Storage_Unity
    ${san_device}=         Execute Command    cat /eniq/installation/config/san_details | grep "^SAN_DEVICE=" | awk -F\= '{print $2}'
    IF    "${san_device}" == "unityXT" or "unity"
        Log To Console    san_device is found.
    ELSE
        Log To Console    san_device is not found.
    END

Checking for san.cfg file in unity TC04
    Depends on test        Checking for san device in unity san_details file TC03
    [Documentation]        Checking for san.cfg file in /eniq/log/ddc_data/${hostname}/${date_dmy}/unity directory
    [Tags]                 EMC_Storage_Unity
    Check File Exists      /eniq/log/ddc_data/${hostname}/${date_dmy}/unity/san.cfg

Checking for san.cfg file size in unity TC05
    Depends on test        Checking for san.cfg file in unity TC04
    [Documentation]        Checking for non empty san.cfg file in /eniq/log/ddc_data/${hostname}/${date_dmy}/unity directory
    [Tags]                 EMC_Storage_Unity
    Check File Size        /eniq/log/ddc_data/${hostname}/${date_dmy}/unity/san.cfg

Checking for MONITOR_UNITY file in unity config TC06
    Depends on test        Checking for san.cfg file size in unity TC05
    [Documentation]        Checking for MONITOR_UNITY file in /eniq/log/ddc_data/config directory
    [Tags]                 EMC_Storage_Unity
    Check File Exists      /eniq/log/ddc_data/config/MONITOR_UNITY

Checking for json file in unity config TC07
    Depends on test        Checking for MONITOR_UNITY file in unity config TC06
    [Documentation]        Checking for non empty ${json_file} file in /eniq/log/ddc_data/${hostname}/${date_dmy}/unity directory
    [Tags]                 EMC_Storage_Unity
    ${json_file}=          Execute Command     find /eniq/log/ddc_data/${hostname}/${date_dmy}/unity -name "*json" -printf "%T@ %p\n" -ls | sort -n | cut -d'/' -f 8- | tail -n 1
    Set Global Variable    ${json_file}
    Check File Exists      /eniq/log/ddc_data/${hostname}/${date_dmy}/unity/${json_file}

Checking for zip file in unity config TC08
    Depends on test        Checking for json file in unity config TC07
    [Documentation]        Checking for ${zip_file} file in /eniq/log/ddc_data/${hostname}/${date_dmy}/unity directory
    [Tags]                 EMC_Storage_Unity
    ${zip_file}=           Execute Command    find /eniq/log/ddc_data/${hostname}/${date_dmy}/unity -name "*zip" -printf "%T@ %p\n" -ls | sort -n | cut -d'/' -f 8- | tail -n 1
    Set Global Variable    ${zip_file}
    Check File Exists      /eniq/log/ddc_data/${hostname}/${date_dmy}/unity/${zip_file}

