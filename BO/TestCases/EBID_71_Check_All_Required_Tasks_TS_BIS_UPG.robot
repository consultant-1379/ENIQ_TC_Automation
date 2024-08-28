*** Settings ***
Library    WinRMLibrary
Test Setup    Create Session    server    ${hostname}    Administrator    ${host_pw}
Test Teardown    Delete All Sessions

*** Variables ***
${hostname}
${host_pw}

*** Test Cases ***
Verifying Audit_logs task
    ${result} =    Run ps    server      ([bool](Get-ScheduledTask | Where-Object {$_.TaskName -like "Audit_logs"}))
    Log    ${result.status_code}
    Log    ${result.std_out}
    Log    ${result.std_err}
    ${convert_result}=    Convert to String    ${result.std_out}
    Should Contain    ${convert_result}    True

Verifying Certificate_Expiry_Check task
    ${result} =    Run ps    server      ([bool](Get-ScheduledTask | Where-Object {$_.TaskName -like "Certificate_Expiry_Check"}))
    Log    ${result.status_code}
    Log    ${result.std_out}
    Log    ${result.std_err}
    ${convert_result}=    Convert to String    ${result.std_out}
    Should Contain    ${convert_result}    True

Verifying Certificate_Expiry_Notification task
    ${result} =    Run ps    server      ([bool](Get-ScheduledTask | Where-Object {$_.TaskName -like "Certificate_Expiry_Notification"}))
    Log    ${result.status_code}
    Log    ${result.std_out}
    Log    ${result.std_err}
    ${convert_result}=    Convert to String    ${result.std_out}
    Should Contain    ${convert_result}    True
Verifying EBID Housekeeping task
    ${result} =    Run ps    server      ([bool](Get-ScheduledTask | Where-Object {$_.TaskName -like "EBID Housekeeping"}))
    Log    ${result.status_code}
    Log    ${result.std_out}
    Log    ${result.std_err}
    ${convert_result}=    Convert to String    ${result.std_out}
    Should Contain    ${convert_result}    True

Verifying EBID_CopySystemLogsBO task
    ${result} =    Run ps    server      ([bool](Get-ScheduledTask | Where-Object {$_.TaskName -like "EBID_CopySystemLogsBO"}))
    Log    ${result.status_code}
    Log    ${result.std_out}
    Log    ${result.std_err}
    ${convert_result}=    Convert to String    ${result.std_out}
    Should Contain    ${convert_result}    True

Verifying EBID_Data_Collector_Daily_Start_Up task
    ${result} =    Run ps    server      ([bool](Get-ScheduledTask | Where-Object {$_.TaskName -like "EBID_Data_Collector_Daily_Start_Up"}))
    Log    ${result.status_code}
    Log    ${result.std_out}
    Log    ${result.std_err}
    ${convert_result}=    Convert to String    ${result.std_out}
    Should Contain    ${convert_result}    True

Verifying EBID_Data_Collector_set task
    ${result} =    Run ps    server      ([bool](Get-ScheduledTask | Where-Object {$_.TaskName -like "EBID_Data_Collector_set"}))
    Log    ${result.status_code}
    Log    ${result.std_out}
    Log    ${result.std_err}
    ${convert_result}=    Convert to String    ${result.std_out}
    Should Contain    ${convert_result}    True

Verifying EBID_GenerateApplicationLogs task
    ${result} =    Run ps    server     ([bool](Get-ScheduledTask | Where-Object {$_.TaskName -like "EBID_GenerateApplicationLogs"}))
    Log    ${result.std_out}
    Log    ${result.std_err}
    ${convert_result}=    Convert to String    ${result.std_out}
    Should Contain    ${convert_result}    True

Verifying EBID_GenerateSystemLogsAll task
    ${result} =    Run ps    server     ([bool](Get-ScheduledTask | Where-Object {$_.TaskName -like "EBID_GenerateSystemLogsAll"}))
    Log    ${result.std_out}
    Log    ${result.std_err}
    ${convert_result}=    Convert to String    ${result.std_out}
    Should Contain    ${convert_result}    True

Verifying EBID_GenerateSystemLogsBO task
    ${result} =    Run ps    server     ([bool](Get-ScheduledTask | Where-Object {$_.TaskName -like "EBID_GenerateSystemLogsBO"}))
    Log    ${result.std_out}
    Log    ${result.std_err}
    ${convert_result}=    Convert to String    ${result.std_out}
    Should Contain    ${convert_result}    True

Verifying Windows Legal Notice task
    ${result} =    Run ps    server     ([bool](Get-ScheduledTask | Where-Object {$_.TaskName -like "Windows Legal Notice"}))
    Log    ${result.std_out}
    Log    ${result.std_err}
    ${convert_result}=    Convert to String    ${result.std_out}
    Should Contain    ${convert_result}    True

    