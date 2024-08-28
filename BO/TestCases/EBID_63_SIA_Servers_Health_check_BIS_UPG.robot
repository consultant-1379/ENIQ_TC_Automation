*** Settings ***
Library    WinRMLibrary
Library    Process
Test Setup    Create Session    server    ${hostname}    Administrator    ${host_pw}
Test Teardown    Delete All Sessions

*** Variables ***
${hostname}
${host_pw}
${script_path}    
${log_path}    c:\\ebid\\server_health_check.log

*** Test Cases ***
SIA Servers Health Check
    ${ps_check}=    Run Ps    server    ${script_path}
    Log    ${ps_check.status_code}    
    ${result}=    Run Ps    server    ((Get-Content -Path ${log_path} | Select-string -pattern "All servers are running and enabled."))
    Log    ${result.status_code}
    Log    ${result.std_out}
    Log    ${result.std_err}
    ${convert_result}=    Convert To String    ${result.std_out}
    Should Contain    ${convert_result}    All servers are running and enabled.