*** Settings ***
Documentation    Test case to check whether the Audit Logs task created successfully and 
...              feching the task details from Task Scheduler from the ADDS server
Library        WinRMLibrary
Library        Process
Test Setup    Create Session    server    ${ADDSHostname}    Administrator    ${ADDSPassword}
Test Teardown    Delete All Sessions


*** Variables ***
${ADDSHostname}
${ADDSPassword}

*** Test Cases ***
Audit_Logging Task check in ADDS
    ${result}=    Run ps    server    Get-ScheduledTask -TaskName "Audit_logs"
    Log    ${result.status_code}
    Log    ${result.std_out}
    Log    ${result.std_err}
    ${convert_result}=    Convert to String    ${result.std_out}
    Should Contain    ${convert_result}    Audit_logs