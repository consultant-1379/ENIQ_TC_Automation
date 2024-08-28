*** Settings ***
Documentation    Test case to fetch the details of Citrix Delivery Controller updated
...              in the VDA server and compare it with the expected output
Library        WinRMLibrary
Library        String
Library        Process
Test Setup    Create Session    server    ${VDAHostname}    Administrator    ${VDAPassword}
Test Teardown    Delete All Sessions


*** Variables ***
${VDAHostname}
${VDAPassword}
${CCS_FQHN}


*** Test Cases ***
Citrix Delivery Controller ListOfDDCs registry
    ${result}=    Run ps    server    (Get-ItemProperty -Path HKLM:\\Software\\Citrix\\VirtualDesktopAgent).ListOfDDCs
    Log    ${result.status_code}
    Log    ${result.std_out}
    Log    ${result.std_err}
    ${convert_result}=    Convert to String    ${result.std_out}
    ${convert_lower_case}=    Convert To Lower Case        ${convert_result}
    Should Contain    ${convert_lower_case}    ${CCS_FQHN}