*** Settings ***
Documentation    Test case to fetch the version of Citrix VMTools installed
...              in the ADDS server and compare it with the expected output
Library        WinRMLibrary
Library        Process
Test Setup    Create Session    server    ${ADDSHostname}    Administrator    ${ADDSPassword}
Test Teardown    Delete All Sessions


*** Variables ***
${ADDSHostname}
${ADDSPassword}


*** Test Cases ***
Citrix VM Tools version in ADDS
    ${result}=    Run ps    server    (Get-ItemProperty -Path HKLM:\\Software\\Microsoft\\Windows\\CurrentVersion\\Uninstall\\*).DisplayVersion -match "9.2.3"
    Log    ${result.status_code}
    Log    ${result.std_out}
    Log    ${result.std_err}
    ${convert_result}=    Convert to String    ${result.std_out}
    Should Contain    ${convert_result}    9.2.3
