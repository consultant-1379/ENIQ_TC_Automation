*** Settings ***
Documentation    Test case to fetch the version of Citrix StoreFront installed
...              in the CCS server and compare it with the expected output
Library        WinRMLibrary
Library        Process
Test Setup    Create Session    server    ${CCSHostname}    Administrator    ${CCSPassword}
Test Teardown    Delete All Sessions

*** Variables ***
${CCSHostname}
${CCSPassword}

*** Test Cases ***
Citrix StoreFront version in CCS Server
    ${result}=    Run ps    server    (Get-ItemProperty -Path HKLM:\\Software\\Microsoft\\Windows\\CurrentVersion\\Uninstall\\*).DisplayVersion -match "1912.0.4000.6"
    Log    ${result.status_code}
    Log    ${result.std_out}
    Log    ${result.std_err}
    ${convert_result}=    Convert to String    ${result.std_out}
    Should Contain    ${convert_result}    1912.0.4000.6
