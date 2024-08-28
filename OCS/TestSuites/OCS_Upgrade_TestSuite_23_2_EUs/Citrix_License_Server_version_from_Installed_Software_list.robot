*** Settings ***
Documentation    Test case to fetch the version of Citrix License Server 
...              installed in CCS server and compare with expected version
Library        WinRMLibrary
Library        Process
Test Setup    Create Session    server    ${CCSHostname}    Administrator    ${CCSPassword}
Test Teardown    Delete All Sessions


*** Variables ***
${CCSHostname}
${CCSPassword}

*** Test Cases ***
Citrix LicenseServer version from installed softwares in CCS Server
    ${result}=    Run ps    server    (Get-ItemProperty -Path HKLM:\\Software\\Wow6432Node\\Microsoft\\Windows\\CurrentVersion\\Uninstall\\*).DisplayVersion
    Log    ${result.status_code}
    Log    ${result.std_out}
    Log    ${result.std_err}
    ${convert_result}=    Convert to String    ${result.std_out}
    Should Contain    ${convert_result}    11.17.2.0 build 44000
