*** Settings ***
Documentation    Test case to check the Certificate Expiry logs were generated successfully in system_logs and 
...              certificate_logs folders under DDC_logs folder from the CCS server
Library          WinRMLibrary
Library          Process
Test Setup       Create Session    server    ${CCSHostname}    Administrator    ${CCSPassword}
Test Teardown    Delete All Sessions


*** Variables ***
${CCSHostname}
${CCSPassword}
${CCS_System_Log_Path}            C:\\OCS\\DDC_logs\\system_logs
${CCS_Certificate_Log_Path}       C:\\OCS\\DDC_logs\\certificate_logs  

*** Test Cases ***
System_Logs, Certificate_Logs check in CCS    
    ${result}=    Run ps    server    ((Test-Path -Path ${CCS_System_Log_Path}))
    Log    ${result.status_code}
    Log    ${result.std_out}
    Log    ${result.std_err}
    ${convert_result}=    Convert to String    ${result.std_out}
    Should Contain    ${convert_result}    True

#Certificate_Logs check in CCS
    ${result}=    Run ps    server    ((Test-Path -Path ${CCS_Certificate_Log_Path}))
    Log    ${result.status_code}
    Log    ${result.std_out}
    Log    ${result.std_err}
    ${convert_result}=    Convert to String    ${result.std_out}
    Should Contain    ${convert_result}    True


#System_Certificate_Expiry Logs check in system_logs in CCS
    ${result}=    Run ps    server    ((Test-Path -Path ${CCS_System_Log_Path}\\System_Certificate_Expiry*.tsv))
    Log    ${result.status_code}
    Log    ${result.std_out}
    Log    ${result.std_err}
    ${convert_result}=    Convert to String    ${result.std_out}
    Should Contain    ${convert_result}    True


#System_Certificate_Expiry Logs check in certificate_logs in CCS
    ${result}=    Run ps    server    ((Test-Path -Path ${CCS_Certificate_Log_Path}\\System_Certificate_Expiry*.tsv))
    Log    ${result.status_code}
    Log    ${result.std_out}
    Log    ${result.std_err}
    ${convert_result}=    Convert to String    ${result.std_out}
    Should Contain    ${convert_result}    True