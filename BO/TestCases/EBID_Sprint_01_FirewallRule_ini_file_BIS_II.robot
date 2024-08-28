*** Settings ***
Library    WinRMLibrary
Library    Process

Test Setup    Create Session    server    ${hostname}    Administrator    ${host_pw}
Test Teardown    Delete All Sessions

*** Variables ***
${hostname}
${host_pw}
${file_path}    C:\\firewall

*** Test Cases ***
FirewallRule_Values ini file check
    ${result}=    Run Ps    server    ((Test-Path -Path ${file_path}\\FirewallRule_Values.ini))
    Log    ${result.status_code}
    Log    ${result.std_out}
    Log    ${result.std_err}
    ${convert_result}=    Convert To String    ${result.std_out}
    Should Contain    ${convert_result}    True