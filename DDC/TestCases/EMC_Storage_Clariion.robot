*** Settings ***
Suite Setup        Open Connection And Log In
Suite Teardown     Close All Connections
Library            SSHLibrary
Library            DateTime
Library            DependencyLibrary
Resource           ../Resources/Resource.resource


*** Test Cases ***
Checking for san_details file in clariion TC01
    [Documentation]        Checking for san_details file in /eniq/installation/config directory
    [Tags]                 EMC_Storage_Clariion
    Check File Exists      /eniq/installation/config/san_details

Checking for san_details file size in clariion TC02
    Depends on test        Checking for san_details file in clariion TC01
    [Documentation]        Checking for non empty san_details file in /eniq/installation/config directory
    [Tags]                 EMC_Storage_Clariion
    Check File Size        /eniq/installation/config/san_details

Checking for san device in clariion san_details file TC03
    Depends on test        Checking for san_details file size in clariion TC02
    [Documentation]        Checking for san_details file in /eniq/installation/config directory
    [Tags]                 EMC_Storage_Clariion
    ${san_device}=         Execute Command    cat /eniq/installation/config/san_details | grep "^SAN_DEVICE=" | awk -F\= '{print $2}'
    IF    "${san_device}" == "vnx" or "clariion"
        Log To Console    san_device is found.
    ELSE
        Log To Console    san_device is not found.
    END

Checking for splist file in clariion TC04
    Depends on test        Checking for san device in clariion san_details file TC03
    [Documentation]        Checking for splist.txt file in /eniq/log/ddc_data/${hostname}/${date_dmy}/clariion directory
    [Tags]                 EMC_Storage_Clariion
    Check File Exists      /eniq/log/ddc_data/${hostname}/${date_dmy}/clariion/splist.txt

Checking for splist file size in clariion TC05
    Depends on test        Checking for splist file in clariion TC04
    [Documentation]        Checking for non empty splist.txt file in /eniq/log/ddc_data/${hostname}/${date_dmy}/clariion directory
    [Tags]                 EMC_Storage_Clariion
    Check File Size        /eniq/log/ddc_data/${hostname}/${date_dmy}/clariion/splist.txt

Checking for data in splist file in clariion TC06
    Depends on test        Checking for splist file size in clariion TC05
    [Documentation]        Checking for splist.txt file in /eniq/log/ddc_data/${hostname}/${date_dmy}/clariion directory
    [Tags]                 EMC_Storage_Clariion
    ${output}=             Execute Command    cat /eniq/log/ddc_data/${hostname}/${date_dmy}/clariion/splist.txt  | cut -d "@" -f 3,4
    Should Contain     ${output}   1@1

Checking for MONITOR_CLARIION file in clariion config TC07
    Depends on test        Checking for data in splist file in clariion TC06
    [Documentation]        Checking for MONITOR_CLARIION file in /eniq/log/ddc_data/config directory
    [Tags]                 EMC_Storage_Clariion
    Check File Exists      /eniq/log/ddc_data/config/MONITOR_CLARIION

Checking for xml file in clariion TC08
    Depends on test        Checking for MONITOR_CLARIION file in clariion config TC07
    [Documentation]        Checking for ${xml_file} file in /eniq/log/ddc_data/${hostname}/${date_dmy}/clariion directory
    [Tags]                 EMC_Storage_Clariion
    ${xml_file}=           Execute Command     find /eniq/log/ddc_data/${hostname}/${date_dmy}/clariion -name "*xml" -printf "%T@ %p\n" -ls | sort -n | cut -d'/' -f 8- | tail -n 1
    Set Global Variable    ${xml_file}
    Check File Exists      /eniq/log/ddc_data/${hostname}/${date_dmy}/clariion/${xml_file}

Checking for nar file in clariion TC09
    Depends on test        Checking for xml file in clariion TC08
    [Documentation]        Checking for ${nar_file} file in /eniq/log/ddc_data/${hostname}/${date_dmy}/clariion directory
    [Tags]                 EMC_Storage_Clariion
    ${nar_file}=           Execute Command    find /eniq/log/ddc_data/${hostname}/${date_dmy}/clariion -name "*nar" -printf "%T@ %p\n" -ls | sort -n | cut -d'/' -f 8- | tail -n 1
    Set Global Variable    ${nar_file}
    Check File Exists      /eniq/log/ddc_data/${hostname}/${date_dmy}/clariion/${nar_file}

