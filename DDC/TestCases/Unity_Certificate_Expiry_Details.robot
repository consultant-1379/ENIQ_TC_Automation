*** Settings ***
Suite Setup        Open Connection And Log In
Suite Teardown     Close All Connections
Library            SSHLibrary
Library            DateTime
Library            DependencyLibrary
Resource           ../Resources/Resource.resource


*** Test Cases ***
Checking for unity expiry details file in Unity destination TC01
    [Documentation]      Checking for unityCertificateExpiry.txt file in /eniq/log/ddc_data/${hostname}/${date_dmy}/unity directory
    [Tags]               Unity
    Log To Console       Source file location is /var/tmp/unityCertificateExpiry.txt
    ${output}=           Run Keyword And Return Status     Check File Exists    /eniq/log/ddc_data/${hostname}/${date_dmy}/unity/unityCertificateExpiryDetails.txt
    Set Global Variable      ${output}
    Run Keyword If           ${output} == False    Skip    unityCertificateExpiry.txt file is not there in the source path

Checking for unity expiry details file size in Unity destination TC02
    Skip If    ${output} == False
    Depends on test      Checking for unity expiry details file in Unity destination TC01
    [Documentation]      Checking for non empty unityCertificateExpiry.txt file in /eniq/log/ddc_data/${hostname}/${date_dmy}/unity directory
    [Tags]               Unity
    Log To Console       Source file location is /var/tmp/unityCertificateExpiry.txt
    Check File Size      /eniq/log/ddc_data/${hostname}/${date_dmy}/unity/unityCertificateExpiryDetails.txt

Checking for hostname file in Unity destination TC03
    [Documentation]      Checking for hostname.txt file in /eniq/log/ddc_data/${hostname}/${date_dmy}/unity directory
    [Tags]               Unity
    ${output}=           Run Keyword And Return Status     Check File Exists    /eniq/log/ddc_data/${hostname}/${date_dmy}/unity/hostname.txt
    Set Global Variable      ${output}
    Run Keyword If           ${output} == False    Skip    hostname.txt file is not there in the source path

Checking for hostname file size in Unity destination TC04
    Skip If    ${output} == False
    Depends on test      Checking for hostname file in Unity destination TC03
    [Documentation]      Checking for non empty unityCertificateExpiry.txt file in /eniq/log/ddc_data/${hostname}/${date_dmy}/unity directory
    [Tags]               Unity
    Log To Console       Source file location is /var/tmp/hostname.txt
    Check File Size      /eniq/log/ddc_data/${hostname}/${date_dmy}/unity/hostname.txt
