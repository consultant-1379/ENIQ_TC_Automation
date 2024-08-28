*** Settings ***
Documentation    Test case to fetch the version of Citrix Virtual Apps installed
...              in the CCS server and compare it with the expected output
Library        WinRMLibrary
Library        Process
Test Setup    Create Session    server    ${CCSHostname}    Administrator    ${CCSPassword}
Test Teardown    Delete All Sessions

*** Variables ***
${CCSHostname}
${CCSPassword}


*** Test Cases ***
Citrix Virtual Apps version in CCS Server
    ${result}=    Run ps    server    (Get-ItemProperty -Path "HKLM:\\Software\\Microsoft\\Windows\\CurrentVersion\\Uninstall\\Citrix Desktop Delivery Controller").DisplayVersion
    Log    ${result.status_code}
    Log    ${result.std_out}
    Log    ${result.std_err}
    ${convert_result}=    Convert to String    ${result.std_out}
    Should Contain    ${convert_result}    1912.0.4000.4227
