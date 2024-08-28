*** Settings ***
Library        WinRMLibrary
Library        Process
Test Setup    Create Session    server    ${hostname}    Administrator    ${host_pw}
Test Teardown    Delete All Sessions


*** Variables ***
${hostname}
${host_pw}
${BO_DDC_Cert_Log_Path}        C:\\ebid\\DDC_logs\\certificate_logs

*** Test Cases ***
DDC_DDP Configuration in BO    
    ${result}=    Run ps    server    ((Test-Path -Path ${BO_DDC_Cert_Log_Path}))
    Log    ${result.status_code}
    Log    ${result.std_out}
    Log    ${result.std_err}
    ${convert_result}=    Convert to String    ${result.std_out}
    Should Contain    ${convert_result}    True
	
System Certificate Expiry File check
    ${result}=    Run ps    server    ((Test-Path -Path ${BO_DDC_Cert_Log_Path}\\System_Certificate_Expiry*.tsv))
    Log    ${result.status_code}
    Log    ${result.std_out}
    Log    ${result.std_err}
    ${convert_result}=    Convert to String    ${result.std_out}
    Should Contain    ${convert_result}    True