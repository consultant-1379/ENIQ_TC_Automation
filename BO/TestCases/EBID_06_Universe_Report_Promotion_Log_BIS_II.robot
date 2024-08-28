*** Settings ***
Library    WinRMLibrary
Library    Process
Test Setup    Create Session    server    ${hostname}    Administrator    ${host_pw}
Test Teardown    Delete All Sessions

*** Variables ***
${hostname}
${host_pw}

*** Test Cases ***
Universe_Report_Promotion_log folder check
    ${result}=    Run Ps    server    (Test-Path -Path "C:\\ebid\\universe_report_promotion\\Universe_Report_Promotion_log*.log")
    Log    ${result.status_code}
    Log    ${result.std_out}
    Log    ${result.std_err}
    ${convert_result}=    Convert To String    ${result.std_out}
    Should Contain    ${convert_result}    True

Promotion Management log
    ${result}=    Run Ps    server    (Get-Content -Path "C:\\ebid\\universe_report_promotion\\Universe_Report_Promotion_log*.log")
    Log    ${result.status_code}
    Log    ${result.std_out}
    Log    ${result.std_err}
    ${convert_result}=    Convert To String    ${result.std_out}
    Should Contain    ${convert_result}    Promotion Management successfully ended