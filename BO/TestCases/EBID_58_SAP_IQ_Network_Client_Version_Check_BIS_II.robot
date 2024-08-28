*** Settings ***
Library    WinRMLibrary
Library    Process
Library    String
Test Setup    Create Session    server    ${hostname}    Administrator    ${host_pw}
Test Teardown    Delete All Sessions

*** Variables ***
${hostname}
${host_pw}
${BO_Log_path}    C:\\ebid\\ebid_automation\\log
${SAP_ver}

*** Test Cases ***
Automated BusinessObjects Install status_check
    ${result}=    Run Ps    server    ((Get-Content -Path ${BO_Log_path}\\ebid_automation_summary.log | Select-string -pattern "Automated Network Client Install/Upgrade"))
    Log    ${result.status_code}
    Log    ${result.std_out}
    Log    ${result.std_err}
    ${convert_result}=    Convert To String    ${result.std_out}
    Should Contain Any    ${convert_result}    Successful    Completed. No Action Required

SAP IQ Client Suite 16.1 SP05 Check
    ${result}=    Run ps    server      ([bool](Get-ItemProperty HKLM:\\Software\\Microsoft\\Windows\\CurrentVersion\\Uninstall\\* |Where-Object {$_.DisplayName -like "SAP IQ Client Suite 16.1 ${SAP_ver} (64-bit) "}))
    Log    ${result.status_code}
    Log    ${result.std_out}
    Log    ${result.std_err}
    ${convert_result}=    Convert to String    ${result.std_out}
    Should Contain    ${convert_result}    True