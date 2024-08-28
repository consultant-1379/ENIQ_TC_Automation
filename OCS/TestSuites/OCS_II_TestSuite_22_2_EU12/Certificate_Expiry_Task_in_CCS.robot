*** Settings ***
Documentation    Test case to check whether the Certificate Expiry Configuration script was executed successfully and 
...              fetching the Certificate Expiry task details from Task Scheduler from the CCS server
Library          WinRMLibrary
Library          Process
Test Setup       Create Session    server    ${CCSHostname}    Administrator    ${CCSPassword}
Test Teardown    Delete All Sessions


*** Variables ***
${CCSHostname}
${CCSPassword}


*** Test Cases ***
Certificate_Expiry_Check, Certificate_Expiry_Notification Task check in CCS
    ${result}=    Run ps    server    Get-ScheduledTask -TaskName "Certificate_Expiry_Check"
    Log    ${result.status_code}
    Log    ${result.std_out}
    Log    ${result.std_err}
    ${convert_result}=    Convert to String    ${result.std_out}
    Should Contain    ${convert_result}    Certificate_Expiry_Check


#Certificate_Expiry_Notification Task check in CCS
    ${result}=    Run ps    server    Get-ScheduledTask -TaskName "Certificate_Expiry_Notification"
    Log    ${result.status_code}
    Log    ${result.std_out}
    Log    ${result.std_err}
    ${convert_result}=    Convert to String    ${result.std_out}
    Should Contain    ${convert_result}    Certificate_Expiry_Notification