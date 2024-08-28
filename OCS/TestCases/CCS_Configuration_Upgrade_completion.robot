*** Settings ***
Library        WinRMLibrary
Library        Process
Resource        ../Resources/Variables/OCS_Variables.robot
Test Setup    Create Session    server    ${CCSHostname}    Administrator    ${CCSPassword}
Test Teardown    Delete All Sessions

*** Test Cases ***
CCS Configuration completion in Upgrade    
    ${result}=    Run ps    server    ((Get-Content -Path ${CCS_Upg_Path}) -like "*CCS Upgrade completed successfully.").Split(":")[1].Trim()
    Log    ${result.status_code}
    Log    ${result.std_out}
    Log    ${result.std_err}
    ${convert_result}=    Convert to String    ${result.std_out}
    Should Contain    ${convert_result}    CCS Upgrade completed successfully.
