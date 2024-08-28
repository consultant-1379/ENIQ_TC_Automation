*** Settings ***
Library    WinRMLibrary
Library    Process
Test Setup    Create Session    server    ${hostname}    Administrator    ${host_pw}
Test Teardown    Delete All Sessions


*** Variables ***
${hostname}
${host_pw}
${Log_path}    C:\\ebid\\ebid_automation\\log


*** Test Cases ***
EBID_prerequisite User Account Control settings Check
    ${result}=    Run Ps    server    cd ${Log_path} ; $latestfile = Get-ChildItem -Attributes !Directory ebid_prerequisite*.log | Sort-Object -Descending -Property LastWriteTime | select -First 1 ; get-content $latestfile.name | Select-string -pattern "Turn On User Account Control settings "
    Log    ${result.status_code}
    Log    ${result.std_out}
    Log    ${result.std_err}
    ${convert_result}=    Convert To String    ${result.std_out}
    Should Contain Any    ${convert_result}    Successful    Completed. No Action Required
EBID_prerequisite Data Execution Prevention Check
    ${result}=    Run Ps    server    cd ${Log_path} ; $latestfile = Get-ChildItem -Attributes !Directory ebid_prerequisite*.log | Sort-Object -Descending -Property LastWriteTime | select -First 1 ; get-content $latestfile.name | Select-string -pattern "Turn off Data Execution Prevention "
    Log    ${result.status_code}
    Log    ${result.std_out}
    Log    ${result.std_err}
    ${convert_result}=    Convert To String    ${result.std_out}
    Should Contain Any    ${convert_result}    Successful    Completed. No Action Required

EBID_prerequisite Rollback Volume Shadow Copy Check
    ${result}=    Run Ps    server    cd ${Log_path} ; $latestfile = Get-ChildItem -Attributes !Directory ebid_prerequisite*.log | Sort-Object -Descending -Property LastWriteTime | select -First 1 ; get-content $latestfile.name | Select-string -pattern "Rollback Volume Shadow Copy "
    Log    ${result.status_code}
    Log    ${result.std_out}
    Log    ${result.std_err}
    ${convert_result}=    Convert To String    ${result.std_out}
    Should Contain Any    ${convert_result}    Successful    Completed. No Action Required

EBID_prerequisite Enabling Windows Update Check
    ${result}=    Run Ps    server    cd ${Log_path} ; $latestfile = Get-ChildItem -Attributes !Directory ebid_prerequisite*.log | Sort-Object -Descending -Property LastWriteTime | select -First 1 ; get-content $latestfile.name | Select-string -pattern "Enabling Windows Update "
    Log    ${result.status_code}
    Log    ${result.std_out}
    Log    ${result.std_err}
    ${convert_result}=    Convert To String    ${result.std_out}
    Should Contain Any    ${convert_result}    Successful    Completed. No Action Required