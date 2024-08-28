*** Settings ***
Library           WinRMLibrary


*** Variables ***
${username}         Administrator
${password}         ${EMPTY}
${host_name}        ${EMPTY}


*** Test Cases ***
Citrix Workspaceapp version in remote Windows Server
    Create Session    server    ${host_name}    ${username}    ${password}
    ${result}=    Run ps    server    (Get-ItemProperty -Path HKLM:\\Software\\Wow6432Node\\Microsoft\\Windows\\CurrentVersion\\Uninstall\\CitrixOnlinePluginPackWeb*).DisplayVersion
    Log    ${result.status_code}
    Log    ${result.std_out}
    Log    ${result.std_err}
    ${convert_result}=    Convert to String    ${result.std_out}
    Should Contain    ${convert_result}    19.12.6000.9
