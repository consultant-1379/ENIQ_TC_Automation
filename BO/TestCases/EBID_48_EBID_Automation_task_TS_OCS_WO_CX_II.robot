*** Settings ***
Library    WinRMLibrary
Library    Process
Library    String
Test Setup    Create Session    server    ${hostname}    Administrator    ${host_pw}
Test Teardown    Delete All Sessions

*** Variables ***
${hostname}
${host_pw}

*** Test Cases ***
Verifying EBID Automation task
#After initial installation EBID Automation task should not present in Task Scheduler
    ${result} =    Run ps    server      ([bool](Get-ScheduledTask | Where-Object {$_.TaskName -like "EBID Automation"}))
    Log    ${result.status_code}
    Log    ${result.std_out}
    Log    ${result.std_err}
    ${convert_result}=    Convert to String    ${result.std_out}
    Should Contain    ${convert_result}    False