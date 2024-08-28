*** Settings ***
Documentation    Test case to check the Certificate Expiry logs were generated successfully in system_logs and 
...              certificate_logs folders under DDC_logs folder from the VDA server
Library          WinRMLibrary
Library          Process
Test Setup       Create Session    server    ${VDAHostname}    Administrator    ${VDAPassword}
Test Teardown    Delete All Sessions


*** Variables ***
${VDAHostname}
${VDAPassword}
${VDA_System_Log_Path}            C:\\OCS\\DDC_logs\\system_logs
${VDA_Certificate_Log_Path}       C:\\OCS\\DDC_logs\\certificate_logs  

*** Test Cases ***
System_Logs, Certificate_Logs check in VDA    
    ${result}=    Run ps    server    ((Test-Path -Path ${VDA_System_Log_Path}))
    Log    ${result.status_code}
    Log    ${result.std_out}
    Log    ${result.std_err}
    ${convert_result}=    Convert to String    ${result.std_out}
    Should Contain    ${convert_result}    True

#Certificate_Logs check in VDA
    ${result}=    Run ps    server    ((Test-Path -Path ${VDA_Certificate_Log_Path}))
    Log    ${result.status_code}
    Log    ${result.std_out}
    Log    ${result.std_err}
    ${convert_result}=    Convert to String    ${result.std_out}
    Should Contain    ${convert_result}    True


#System_Certificate_Expiry Logs check in system_logs in VDA
    ${result}=    Run ps    server    ((Test-Path -Path ${VDA_System_Log_Path}\\System_Certificate_Expiry*.tsv))
    Log    ${result.status_code}
    Log    ${result.std_out}
    Log    ${result.std_err}
    ${convert_result}=    Convert to String    ${result.std_out}
    Should Contain    ${convert_result}    True


#System_Certificate_Expiry Logs check in certificate_logs in VDA
    ${result}=    Run ps    server    ((Test-Path -Path ${VDA_Certificate_Log_Path}\\System_Certificate_Expiry*.tsv))
    Log    ${result.status_code}
    Log    ${result.std_out}
    Log    ${result.std_err}
    ${convert_result}=    Convert to String    ${result.std_out}
    Should Contain    ${convert_result}    True