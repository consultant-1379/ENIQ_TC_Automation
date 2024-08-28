*** Settings ***
Documentation    Test case to check whether the TLS1.2 Configuration script was executed successfully and 
...              fetching the same information from TLS configuration logs from the CCS server
Library          WinRMLibrary
Library          Process
Test Setup       Create Session    server    ${CCSHostname}    Administrator    ${CCSPassword}
Test Teardown    Delete All Sessions


*** Variables ***
${CCSHostname}
${CCSPassword}
${CCS_TLS_Log_Path}        "C:\\OCS\\install_config\\TLS1.2_CCS_config\\tls_log.txt"

*** Test Cases ***
TLS1.2 Configuration completion in CCS    
    ${result}=    Run ps    server    ((Get-Content -Path ${CCS_TLS_Log_Path}) -like "*TLS1.2_CCS_configuration script executed successfully*").Split(":")[1].Trim()
    Log    ${result.status_code}
    Log    ${result.std_out}
    Log    ${result.std_err}
    ${convert_result}=    Convert to String    ${result.std_out}
    Should Contain    ${convert_result}    TLS1.2_CCS_configuration script executed successfully.System will restart now.
