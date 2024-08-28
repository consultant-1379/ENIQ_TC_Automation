*** Settings ***
Library    WinRMLibrary
Library    Process
Test Setup    Create Session    server    ${hostname}    Administrator    ${host_pw}
Test Teardown    Delete All Sessions

*** Variables ***
${hostname}
${host_pw}
${client_post_install_log}     c:\\ebid\\install_config\\log

*** Test Cases ***
Removal of Translation Management Tool (Checking install config log)
    ${result}=    Run Ps    server    cd ${client_post_install_log}; ($latestfile = (Get-ChildItem -Attributes !Directory C:\\ebid\\install_config\\log\\ebid_install_config_log*.log) | Sort-Object -Descending -Property LastWriteTime | select -First 1) ; Get-Content $latestfile.name
    Log    ${result.status_code}
    Log    ${result.std_out}
    Log    ${result.std_err}
    ${convert_result}=    Convert To String    ${result.std_out}
    Should Contain Any   ${convert_result}    Translation Management Tool is removed successfully	Translation Management Tool was already removed