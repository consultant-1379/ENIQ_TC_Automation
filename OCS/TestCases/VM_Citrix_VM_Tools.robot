*** Settings ***
Library           WinRMLibrary


*** Variables ***
${username}         Administrator
${password}         ${EMPTY}
${host_name}        ${EMPTY}


*** Test Cases ***
Citrix VM Tools version
    Create Session    server    ${host_name}    ${username}    ${password}
    ${result}=    Run ps    server    (Get-ItemProperty -Path HKLM:\\Software\\Microsoft\\Windows\\CurrentVersion\\Uninstall\\*).DisplayVersion -match "9.2.2"
    Log    ${result.status_code}
    Log    ${result.std_out}
    Log    ${result.std_err}
    ${convert_result}=    Convert to String    ${result.std_out}
    Should Contain    ${convert_result}    9.2.2
