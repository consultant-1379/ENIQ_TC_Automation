*** Settings ***
Library    WinRMLibrary
Library    Process
Library    String
Test Setup    Create Session    server    ${hostname}    Administrator    ${host_pw}
Test Teardown    Delete All Sessions

*** Variables ***
${hostname}
${host_pw}
${bi_version}
${BO_Log_path}    C:\\ebid\\ebid_automation\\log

*** Test Cases ***
Automated BI Client upgrade status from automation summary log
    ${result}=    Run Ps    server    ((Get-Content -Path ${BO_Log_path}\\ebid_automation_summary.log | Select-string -pattern "Automated BusinessObjects Upgrade"))
    Log    ${result.status_code}
    Log    ${result.std_out}
    Log    ${result.std_err}
    ${convert_result}=    Convert To String    ${result.std_out}
    Should Contain Any    ${convert_result}    Successful    Completed. No Action Required

BI Client Version Check from registry
    ${result}=    Run ps    server      ([bool](Get-ItemProperty HKLM:\\Software\\Wow6432Node\\Microsoft\\Windows\\CurrentVersion\\Uninstall\\* | Where-Object {$_.DisplayName -like "${bi_version}"} ))
    Log    ${result.status_code}
    Log    ${result.std_out}
    Log    ${result.std_err}
    ${convert_result}=    Convert to String    ${result.std_out}
    Should Contain    ${convert_result}    True