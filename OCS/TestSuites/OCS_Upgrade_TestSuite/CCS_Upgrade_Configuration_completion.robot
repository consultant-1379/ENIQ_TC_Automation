*** Settings ***
Documentation    Test case to check whether the CCS Upgrade Configuration script was executed successfully and 
...              fetching the same information from upgrade configuration logs from the CCS server
Library          WinRMLibrary
Library          Process
Test Setup       Create Session    server    ${CCSHostname}    Administrator    ${CCSPassword}
Test Teardown    Delete All Sessions


*** Variables ***
${CCSHostname}
${CCSPassword}
${CCS_Upg_Logs_Path}        "C:\\OCS\\upgrade_config\\CCS_upgrade_config\\ccs_upgrade_log.log"

*** Test Cases ***
CCS Upgrade Configuration completion    
    ${result}=    Run ps    server    ((Get-Content -Path ${CCS_Upg_Logs_Path}) -like "*CCS Upgrade completed successfully.")
    Log    ${result.status_code}
    Log    ${result.std_out}
    Log    ${result.std_err}
    ${convert_result}=    Convert to String    ${result.std_out}
    Should Contain    ${convert_result}    CCS Upgrade completed successfully.
