*** Settings ***
Library    WinRMLibrary
Test Setup    Create Session    server    ${hostname}    Administrator    ${host_pw}
Test Teardown    Delete All Sessions

*** Variables ***
${hostname}
${host_pw}

*** Test Cases ***
Automated BusinessObjects Install status_check
    ${result}=    Run Ps    server    Get-WindowsFeature RDS-Connection-Broker
    Log    ${result.status_code}
    Log    ${result.std_out}
    Log    ${result.std_err}
    ${convert_result}=    Convert To String    ${result.std_out}
    Should Contain    ${convert_result}    Installed