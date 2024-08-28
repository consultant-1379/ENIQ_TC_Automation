*** Settings ***
Documentation    Test case to check whether the VDA Configuration script was executed successfully and 
...              fetching the same information from configuration logs from the VDA server
Library          WinRMLibrary
Library          Process
Test Setup       Create Session    server    ${VDAHostname}    Administrator    ${VDAPassword}
Test Teardown    Delete All Sessions


*** Variables ***
${VDAHostname}
${VDAPassword}
${VDA_II_Logs_Path}        "C:\\OCS\\install_config\\VDA_config\\vda_config_log.log"

*** Test Cases ***
VDA Configuration completion during Initial Installation    
    ${result}=    Run ps    server    ((Get-Content -Path ${VDA_II_Logs_Path}) -like "*VDA Configuration completed successfully.").Split(":")[1].Trim()
    Log    ${result.status_code}
    Log    ${result.std_out}
    Log    ${result.std_err}
    ${convert_result}=    Convert to String    ${result.std_out}
    Should Contain    ${convert_result}    VDA Configuration completed successfully.
