*** Settings ***
Documentation    Test case to check whether the VDA Upgrade Configuration script was executed successfully and 
...              fetching the same information from upgrade configuration logs from the VDA server
Library          WinRMLibrary
Library          Process
Test Setup       Create Session    server    ${VDAHostname}    Administrator    ${VDAPassword}
Test Teardown    Delete All Sessions


*** Variables ***
${VDAHostname}
${VDAPassword}
${VDA_Upg_Logs_Path}        "C:\\OCS\\upgrade_config\\VDA_upgrade_config\\vda_upgrade_log.log"

*** Test Cases ***
CCS Upgrade Configuration completion    
    ${result}=    Run ps    server    ((Get-Content -Path ${VDA_Upg_Logs_Path}) -like "*VDA Upgrade completed successfully.")
    Log    ${result.status_code}
    Log    ${result.std_out}
    Log    ${result.std_err}
    ${convert_result}=    Convert to String    ${result.std_out}
    Should Contain    ${convert_result}    VDA Upgrade completed successfully.
