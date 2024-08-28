*** Settings ***
Library    WinRMLibrary
Library    Process
Test Setup    Create Session    server    ${hostname}    Administrator    ${host_pw}
Test Teardown    Delete All Sessions

*** Variables ***
${hostname}
${host_pw}
${BO_Log_path}    C:\\ebid\\ebid_automation\\log

*** Test Cases ***
Log_Folder in BO
    ${result}=    Run Ps    server    ((Test-Path -Path ${BO_Log_path}))
    Log    ${result.status_code}
    Log    ${result.std_out}
    Log    ${result.std_err}
    ${convert_result}=    Convert To String    ${result.std_out}
    Should Contain    ${convert_result}    True

Automated Universe Report Promotion Status
    ${result}=    Run Ps    server    ((Get-Content -Path ${BO_Log_path}\\ebid_automation_summary.log| Select-string -pattern "Automated Universe Report Promotion")[1])
    Log    ${result.status_code}
    Log    ${result.std_out}
    Log    ${result.std_err}
    ${convert_result}=    Convert To String    ${result.std_out}
    IF    ${result.status_code} == 0
        Should Contain Any   ${convert_result}    Successful    Completed. No action required  
    ELSE    
        Log To Console    EBID Automation Summary log file not found
        Fail
    END