*** Settings ***
Documentation    Test case to check and compare the Task Name and State details of Certificate_Expiry_Check and 
...              Certificate_Expiry_Notification tasks from Task Scheduler from the ADDS server
Library          WinRMLibrary
Library          Process
Test Setup       Create Session    server    ${ADDSHostname}    Administrator    ${ADDSPassword}
Test Teardown    Delete All Sessions


*** Variables ***
${ADDSHostname}
${ADDSPassword}


*** Test Cases ***
Certificate_Expiry_Check_Task, Certificate_Expiry_Notification_Task check in ADDS
    ${result}=    Run ps    server    Get-ScheduledTask -TaskName "Certificate_Expiry_Check" | Format-List
    Log    ${result.status_code}
    Log    ${result.std_out}
    Log    ${result.std_err}
    ${convert_result}=    Convert to String    ${result.std_out}
    Should Contain    ${convert_result}    Certificate_Expiry_Check
    Should Contain    ${convert_result}    Ready

#Certificate_Expiry_Notification_Task check in ADDS
    ${result}=    Run ps    server    Get-ScheduledTask -TaskName "Certificate_Expiry_Notification" | Format-List
    Log    ${result.status_code}
    Log    ${result.std_out}
    Log    ${result.std_err}
    ${convert_result}=    Convert to String    ${result.std_out}
    Should Contain    ${convert_result}    Certificate_Expiry_Notification
    Should Contain    ${convert_result}    Ready