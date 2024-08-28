*** Settings ***
Library    WinRMLibrary
#Library    Process
Test Setup    Create Session    server    ${hostname}    Administrator    ${host_pw}
Test Teardown    Delete All Sessions

*** Variables ***
${hostname}
${host_pw}

*** Test Cases ***
Log_Folder in BO
    ${result}=    Run Ps    server    (Get-Content -Path "c:\\ebid\\ebid_automation\\ebid_automation.ini" | Select-string -pattern "eniq_server_ip")
    Log    ${result.status_code}
    Log    ${result.std_out}
    Log    ${result.std_err}
    ${convert_result}=    Convert To String    ${result.std_out}

    ${result2}=    Run Ps    server    ((Get-NfsSharePermission -Name "DDC_LOGS").ClientName[0])
    Log    ${result2.status_code}
    Log    ${result2.std_out}
    Log    ${result2.std_err}
    ${convert_result2}=    Convert To String    ${result2.std_out}
    Should Contain    ${convert_result}    ${convert_result2}