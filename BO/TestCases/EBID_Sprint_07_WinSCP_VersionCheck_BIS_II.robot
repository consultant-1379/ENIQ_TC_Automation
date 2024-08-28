*** Settings ***
Library    WinRMLibrary
Library    Process
Test Setup    Create Session    server    ${hostname}    Administrator    ${host_pw}
Test Teardown    Delete All Sessions

*** Variables ***
${hostname}
${host_pw}
${WinSCP_path}    C:\\ebid\\universe_report_promotion
${WinSCP_version}    6.1.1.13736

*** Test Cases ***
Check universe_report_promotion folder
    ${result}=    Run Ps    server    ((Test-Path -Path ${WinSCP_path}))
    Log    ${result.status_code}
    Log    ${result.std_out}
    Log    ${result.std_err}
    ${convert_result}=    Convert To String    ${result.std_out}
    Should Contain    ${convert_result}    True
WinSCP Version check
    ${result}=    Run Ps    server    (Get-Command ${WinSCP_path}\\WinSCP.exe).FileVersionInfo.FileVersion
    Log    ${result.status_code}
    Log    ${result.std_out}
    Log    ${result.std_err}
    ${convert_result}=    Convert To String    ${result.std_out}
    Should Contain    ${convert_result}    ${WinSCP_version}   