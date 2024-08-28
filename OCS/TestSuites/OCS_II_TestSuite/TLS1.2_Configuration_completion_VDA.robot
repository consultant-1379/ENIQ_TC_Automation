*** Settings ***
Documentation    Test case to check whether the TLS1.2 Configuration script was executed successfully and 
...              fetching the same information from TLS configuration logs from the VDA server
Library          WinRMLibrary
Library          Process
Test Setup       Create Session    server    ${VDAHostname}    Administrator    ${VDAPassword}
Test Teardown    Delete All Sessions


*** Variables ***
${VDAHostname}
${VDAPassword}
${VDA_TLS_Log_Path}        "C:\\OCS\\install_config\\TLS1.2_VDA_config\\TLS1.2_VDA_config_log.log"

*** Test Cases ***
TLS1.2 Configuration completion in VDA    
    ${result}=    Run ps    server    ((Get-Content -Path ${VDA_TLS_Log_Path}) -like "*SSL to VDA enabled.")
    Log    ${result.status_code}
    Log    ${result.std_out}
    Log    ${result.std_err}
    ${convert_result}=    Convert to String    ${result.std_out}
    Should Contain    ${convert_result}    SSL to VDA enabled.
