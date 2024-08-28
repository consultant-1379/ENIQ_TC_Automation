*** Settings ***
Library        WinRMLibrary
Library        .\\Scripts\\Housekeeping_report_verify.py
Test Setup    Create Session    server    ${hostname}    Administrator    ${host_pw}
Test Teardown    Delete All Sessions       


*** Variables ***
${Report_Location}    C://Users//Administrator//Desktop
${hostname}        
${host_pw}         

*** Test Cases ***
EBID Houskeeping Report Presence
    ${result}=    Run ps    server    ((Test-Path -Path ${Report_Location}\\ebid_housekeeping_report-*.html))
    Log    ${result.status_code}
    Log    ${result.std_out}
    Log    ${result.std_err}
    ${convert_result}=    Convert to String    ${result.std_out}
    Should Contain    ${convert_result}    True

Verifying EBID Housekeeping task
    ${result} =    Run ps    server      ([bool](Get-ScheduledTask | Where-Object {$_.TaskName -like "EBID Housekeeping"}))
    Log    ${result.status_code}
    Log    ${result.std_out}
    Log    ${result.std_err}
    ${convert_result}=    Convert to String    ${result.std_out}
    Should Contain    ${convert_result}    True

Key.txt file Presence
    ${result}=    Run ps    server    ((Test-Path -Path "c:\\ebid\\Housekeeping\\key.txt"))
    Log    ${result.status_code}
    Log    ${result.std_out}
    Log    ${result.std_err}
    ${convert_result}=    Convert to String    ${result.std_out}
    Should Contain    ${convert_result}    True

HK Report VERIFY
    ${out}    HK_report
    Should Contain  ${out}    True

