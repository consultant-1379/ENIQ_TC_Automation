*** Settings ***
Documentation    Test case to check and compare the Task Name and State details of Audit Logs task from Task Scheduler from the CCS server
Library          WinRMLibrary
Library          Process
Test Setup       Create Session    server    ${CCSHostname}    Administrator    ${CCSPassword}
Test Teardown    Delete All Sessions


*** Variables ***
${CCSHostname}
${CCSPassword}

*** Test Cases ***
Audit_Logging Task Details in CCS
    ${result}=    Run ps    server    Get-ScheduledTask -TaskName "Audit_logs" | Format-List
    Log    ${result.status_code}
    Log    ${result.std_out}
    Log    ${result.std_err}
    ${convert_result}=    Convert to String    ${result.std_out}
    Should Contain    ${convert_result}    Audit_logs
    Should Contain    ${convert_result}    Ready