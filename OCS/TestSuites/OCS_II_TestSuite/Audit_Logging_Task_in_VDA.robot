*** Settings ***
Library        WinRMLibrary
Library        Process
Test Setup    Create Session    server    ${VDAHostname}    Administrator    ${VDAPassword}
Test Teardown    Delete All Sessions


*** Variables ***
${VDAHostname}
${VDAPassword}

*** Test Cases ***
Audit_Logging Task check in VDA
    ${result}=    Run ps    server    Get-ScheduledTask -TaskName "Audit_logs"
    Log    ${result.status_code}
    Log    ${result.std_out}
    Log    ${result.std_err}
    ${convert_result}=    Convert to String    ${result.std_out}
    Should Contain    ${convert_result}    Audit_logs