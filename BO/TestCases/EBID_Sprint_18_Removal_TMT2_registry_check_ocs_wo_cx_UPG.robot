*** Settings ***
Library    WinRMLibrary
Library    Process
Test Setup    Create Session    server    ${hostname}    Administrator    ${host_pw}
Test Teardown    Delete All Sessions

*** Variables ***
${hostname}
${host_pw}

*** Test Cases ***
Removal of Translation Management Tool2 (desktop app file)
    ${result}=    Run Ps    server    (Test-Path "C:\\Program Files (x86)\\SAP BusinessObjects\\SAP BusinessObjects Enterprise XI 4.0\\win64_x64\\TransMgr.exe")
    Log    ${result.status_code}
    Log    ${result.std_out}
    Log    ${result.std_err}
    ${convert_result}=    Convert To String    ${result.std_out}
    Should Contain    ${convert_result}    False

Removal of Translation Management Tool2 (registry check)
    ${result}=    Run Ps    server    ([bool]((Get-ItemProperty HKLM:\Software\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall\*) | Where-Object {$_.DisplayName -Match "transmgr"}))
    Log    ${result.status_code}
    Log    ${result.std_out}
    Log    ${result.std_err}
    ${convert_result}=    Convert To String    ${result.std_out}
    Should Contain    ${convert_result}    False