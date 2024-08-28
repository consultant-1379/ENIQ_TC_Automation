*** Settings ***
Library    WinRMLibrary
Library    Process
Test Setup    Create Session    server    ${hostname}    Administrator    ${host_pw}
Test Teardown    Delete All Sessions

*** Variables ***
${hostname}
${host_pw}
${BO_Log_path}    C:\\ebid\\ebid_automation\\log

*** Test Cases ***
Log folder check
    ${result}=    Run Ps    server    ((Test-Path -Path ${BO_Log_path}))
    Log    ${result.status_code}
    Log    ${result.std_out}
    Log    ${result.std_err}
    ${convert_result}=    Convert To String    ${result.std_out}
    Should Contain    ${convert_result}    True

WNH status check from automation summary log
    ${result}=    Run Ps    server    ((Get-Content -Path ${BO_Log_path}\\ebid_automation_summary.log | Select-string -pattern "Automated Windows Node Hardening")[1])
    Log    ${result.status_code}
    Log    ${result.std_out}
    Log    ${result.std_err}
    ${convert_result}=    Convert To String    ${result.std_out}
    Should Contain Any    ${convert_result}    Successful    Completed. No Action Required