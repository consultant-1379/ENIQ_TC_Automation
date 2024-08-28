*** Settings ***
Library        WinRMLibrary
Library        Process
Test Setup    Create Session    server    ${CCSHostname}    Administrator    ${CCSPassword}
Test Teardown    Delete All Sessions


*** Variables ***
${CCSHostname}
${CCSPassword}

*** Test Cases ***
Windows OS version in CCS
    
    ${result}=    Run ps    server    (Get-ItemProperty 'HKLM:\\Software\\Microsoft\\Windows NT\\CurrentVersion').ProductName
    Log    ${result.status_code}
    Log    ${result.std_out}
    Log    ${result.std_err}
    ${convert_result}=    Convert to String    ${result.std_out}
    Should Contain    ${convert_result}    Windows Server 2016 Standard
