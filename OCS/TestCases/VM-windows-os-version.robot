*** Settings ***
Library           WinRMLibrary

*** Variables ***
${username}         Administrator
${password}         ${EMPTY}
${host_name}        ${EMPTY}

*** Test Cases ***
Windows OS version in ADDS
    Create Session    server    ${host_name}    ${username}    ${password}
    ${result}=    Run ps    server    (Get-ItemProperty 'HKLM:\\Software\\Microsoft\\Windows NT\\CurrentVersion').ProductName
    Log    ${result.status_code}
    Log    ${result.std_out}
    Log    ${result.std_err}
    ${convert_result}=    Convert to String    ${result.std_out}
    Should Contain    ${convert_result}    Windows Server 2016 Standard
