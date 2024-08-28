*** Settings ***
Documentation    Test case to fetch the version of Citrix Workspaceapp installed
...              in the CCS server and compare it with the expected output
Library        WinRMLibrary
Library        Process
Test Setup    Create Session    server    ${CCSHostname}    Administrator    ${CCSPassword}
Test Teardown    Delete All Sessions


*** Variables ***
${CCSHostname}
${CCSPassword}

*** Test Cases ***
Citrix Workspaceapp version in CCS server
    ${result}=    Run ps    server    (Get-ItemProperty -Path HKLM:\\Software\\Wow6432Node\\Microsoft\\Windows\\CurrentVersion\\Uninstall\\CitrixOnlinePluginPackWeb*).DisplayVersion
    Log    ${result.status_code}
    Log    ${result.std_out}
    Log    ${result.std_err}
    ${convert_result}=    Convert to String    ${result.std_out}
    Should Contain    ${convert_result}    22.3.2000.2105
