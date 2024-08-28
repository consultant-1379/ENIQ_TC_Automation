*** Settings ***
Library        WinRMLibrary
Library        Process
Test Setup    Create Session    server    ${VDAHostname}    Administrator    ${VDAPassword}
Test Teardown    Delete All Sessions


*** Variables ***
${VDAHostname}
${VDAPassword}

*** Test Cases ***
Citrix Virtual Delivery Agent version in VDA Server
    ${result}=    Run ps    server    (Get-ItemProperty -Path "HKLM:\\Software\\Microsoft\\Windows\\CurrentVersion\\Uninstall\\Citrix Virtual Desktop Agent").DisplayVersion
    Log    ${result.status_code}
    Log    ${result.std_out}
    Log    ${result.std_err}
    ${convert_result}=    Convert to String    ${result.std_out}
    Should Contain    ${convert_result}    1912.0.5000.5174
