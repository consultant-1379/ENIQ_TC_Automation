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

Verifying OCS_CopyLogs task
    ${result} =    Run ps    server      ([bool](Get-ScheduledTask | Where-Object {$_.TaskName -like "OCS_CopyLogs"}))
    Log    ${result.status_code}
    Log    ${result.std_out}
    Log    ${result.std_err}
    ${convert_result}=    Convert to String    ${result.std_out}
    Should Contain    ${convert_result}    True

Verifying OCS_CopySystemLogs task
    ${result} =    Run ps    server      ([bool](Get-ScheduledTask | Where-Object {$_.TaskName -like "OCS_CopySystemLogs"}))
    Log    ${result.status_code}
    Log    ${result.std_out}
    Log    ${result.std_err}
    ${convert_result}=    Convert to String    ${result.std_out}
    Should Contain    ${convert_result}    True

Verifying OCS_Data_Collector_Daily_Start_Up task
    ${result} =    Run ps    server      ([bool](Get-ScheduledTask | Where-Object {$_.TaskName -like "OCS_Data_Collector_Daily_Start_Up"}))
    Log    ${result.status_code}
    Log    ${result.std_out}
    Log    ${result.std_err}
    ${convert_result}=    Convert to String    ${result.std_out}
    Should Contain    ${convert_result}    True

Verifying OCS_Data_Collector_sets task
    ${result} =    Run ps    server      ([bool](Get-ScheduledTask | Where-Object {$_.TaskName -like "OCS_Data_Collector_sets"}))
    Log    ${result.status_code}
    Log    ${result.std_out}
    Log    ${result.std_err}
    ${convert_result}=    Convert to String    ${result.std_out}
    Should Contain    ${convert_result}    True

Verifying OCS_GenerateBOClientSystemAllLogs task
    ${result} =    Run ps    server     ([bool](Get-ScheduledTask | Where-Object {$_.TaskName -like "OCS_GenerateBOClientSystemAllLogs"}))
    Log    ${result.std_out}
    Log    ${result.std_err}
    ${convert_result}=    Convert to String    ${result.std_out}
    Should Contain    ${convert_result}    True

Verifying OCS_GenerateBOClientSystemLogs task
    ${result} =    Run ps    server     ([bool](Get-ScheduledTask | Where-Object {$_.TaskName -like "OCS_GenerateBOClientSystemLogs"}))
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