*** Settings ***
Library        WinRMLibrary
Library        Process
Test Setup    Create Session    server    ${hostname}    Administrator    ${host_pw}
Test Teardown    Delete All Sessions


*** Variables ***
${hostname}
${host_pw}
${BO_DDC_App_Log_Path}        C:\\ebid\\DDC_logs\\application_logs

*** Test Cases ***
DDC_DDP Application Configuration in BO    
    ${result}=    Run ps    server    ((Test-Path -Path ${BO_DDC_App_Log_Path}))
    Log    ${result.status_code}
    Log    ${result.std_out}
    Log    ${result.std_err}
    ${convert_result}=    Convert to String    ${result.std_out}
    Should Contain    ${convert_result}    True

Active Users File check
    ${result}=    Run ps    server    ((Test-Path -Path ${BO_DDC_App_Log_Path}\\ActiveUsers*.txt))
    Log    ${result.status_code}
    Log    ${result.std_out}
    Log    ${result.std_err}
    ${convert_result}=    Convert to String    ${result.std_out}
    Should Contain    ${convert_result}    True

Prompt Info File check
   ${result}=    Run ps    server    ((Test-Path -Path ${BO_DDC_App_Log_Path}\\PromptInfo*.txt))
    Log    ${result.status_code}
    Log    ${result.std_out}
    Log    ${result.std_err}
    ${convert_result}=    Convert to String    ${result.std_out}
    Should Contain    ${convert_result}    True 


Report Instances File check
    ${result}=    Run ps    server    ((Test-Path -Path ${BO_DDC_App_Log_Path}\\ReportInstances*.txt))
    Log    ${result.status_code}
    Log    ${result.std_out}
    Log    ${result.std_err}
    ${convert_result}=    Convert to String    ${result.std_out}
    Should Contain    ${convert_result}    True


Report List File check
    ${result}=    Run ps    server    ((Test-Path -Path ${BO_DDC_App_Log_Path}\\ReportList*.txt))
    Log    ${result.status_code}
    Log    ${result.std_out}
    Log    ${result.std_err}
    ${convert_result}=    Convert to String    ${result.std_out}
    Should Contain    ${convert_result}    True

Report Refresh Time File check
    ${result}=    Run ps    server    ((Test-Path -Path ${BO_DDC_App_Log_Path}\\ReportRefreshTime*.txt))
    Log    ${result.status_code}
    Log    ${result.std_out}
    Log    ${result.std_err}
    ${convert_result}=    Convert to String    ${result.std_out}
    Should Contain    ${convert_result}    True

Scheduling Info File check
    ${result}=    Run ps    server    ((Test-Path -Path ${BO_DDC_App_Log_Path}\\SchedulingInfo*.txt))
    Log    ${result.status_code}
    Log    ${result.std_out}
    Log    ${result.std_err}
    ${convert_result}=    Convert to String    ${result.std_out}
    Should Contain    ${convert_result}    True

User List File check
    ${result}=    Run ps    server    ((Test-Path -Path ${BO_DDC_App_Log_Path}\\UserList*.txt))
    Log    ${result.status_code}
    Log    ${result.std_out}
    Log    ${result.std_err}
    ${convert_result}=    Convert to String    ${result.std_out}
    Should Contain    ${convert_result}    True
