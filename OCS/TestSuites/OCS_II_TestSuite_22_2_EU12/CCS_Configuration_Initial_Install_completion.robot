*** Settings ***
Documentation    Test case to check whether the CCS Configuration script was executed successfully and 
...              fetching the same information from configuration logs from the CCS server
Library          WinRMLibrary
Library          Process
Test Setup       Create Session    server    ${CCSHostname}    Administrator    ${CCSPassword}
Test Teardown    Delete All Sessions


*** Variables ***
${CCSHostname}
${CCSPassword}
${CCS_II_Logs_Path}        "C:\\OCS\\install_config\\CCS_config\\CCS_config_log.log"

*** Test Cases ***
CCS Configuration completion during Initial Installation    
    ${result}=    Run ps    server    ((Get-Content -Path ${CCS_II_Logs_Path}) -like "*CCS Configuration completed successfully.").Split(":")[1].Trim()
    Log    ${result.status_code}
    Log    ${result.std_out}
    Log    ${result.std_err}
    ${convert_result}=    Convert to String    ${result.std_out}
    Should Contain    ${convert_result}    CCS Configuration completed successfully.
