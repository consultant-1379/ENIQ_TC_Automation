*** Settings ***
Documentation    Test case to check the Certificate Expiry logs were generated successfully in system_logs and 
...              certificate_logs folders under DDC_logs folder from the ADDS server
Library          WinRMLibrary
Library          Process
Test Setup       Create Session    server    ${ADDSHostname}    Administrator    ${ADDSPassword}
Test Teardown    Delete All Sessions


*** Variables ***
${ADDSHostname}
${ADDSPassword}
${ADDS_System_Log_Path}            C:\\OCS\\DDC_logs\\system_logs
${ADDS_Certificate_Log_Path}       C:\\OCS\\DDC_logs\\certificate_logs  

*** Test Cases ***
System_Logs, Certificate_Logs check in ADDS    
    ${result}=    Run ps    server    ((Test-Path -Path ${ADDS_System_Log_Path}))
    Log    ${result.status_code}
    Log    ${result.std_out}
    Log    ${result.std_err}
    ${convert_result}=    Convert to String    ${result.std_out}
    Should Contain    ${convert_result}    True

#Certificate_Logs check in ADDS
    ${result}=    Run ps    server    ((Test-Path -Path ${ADDS_Certificate_Log_Path}))
    Log    ${result.status_code}
    Log    ${result.std_out}
    Log    ${result.std_err}
    ${convert_result}=    Convert to String    ${result.std_out}
    Should Contain    ${convert_result}    True


#System_Certificate_Expiry Logs check in system_logs in ADDS
    ${result}=    Run ps    server    ((Test-Path -Path ${ADDS_System_Log_Path}\\System_Certificate_Expiry*.tsv))
    Log    ${result.status_code}
    Log    ${result.std_out}
    Log    ${result.std_err}
    ${convert_result}=    Convert to String    ${result.std_out}
    Should Contain    ${convert_result}    True


#System_Certificate_Expiry Logs check in certificate_logs in ADDS
    ${result}=    Run ps    server    ((Test-Path -Path ${ADDS_Certificate_Log_Path}\\System_Certificate_Expiry*.tsv))
    Log    ${result.status_code}
    Log    ${result.std_out}
    Log    ${result.std_err}
    ${convert_result}=    Convert to String    ${result.std_out}
    Should Contain    ${convert_result}    True