*** Settings ***
Documentation    Test case for verifying the Citrix XenCenter version installed in remote Windows server
Library        WinRMLibrary
Library        Process
Test Setup    Create Session    server    ${XC_Hostname}    Administrator    ${XC_Password}
Test Teardown    Delete All Sessions


*** Variables ***
${XC_Hostname}
${XC_Password}

*** Test Cases ***
Citrix XenCenter version in remote Windows Server
    ${result}=    Run ps    server    (Get-ItemProperty -Path HKLM:\\Software\\Wow6432Node\\Microsoft\\Windows\\CurrentVersion\\Uninstall\\*).DisplayVersion -match "8.2.4"
    Log    ${result.status_code}
    Log    ${result.std_out}
    Log    ${result.std_err}
    ${convert_result}=    Convert to String    ${result.std_out}
    Should Contain    ${convert_result}    8.2.4
