*** Settings ***
Library        WinRMLibrary
Library        Process
#Resource   C:\\Users\\Administrator\\Desktop\\Test_automation\\input_file.resource
Test Setup     Create Session    server    ${hostname}    Administrator    ${host_pw}
Test Teardown    Delete All Sessions

*** Variables ***
${hostname}
${host_pw}

*** Test Cases ***
Tomcat Service status
    ${result1}=    Run ps    server      ((Get-Service -Name "*BOEXI40Tomcat*").status)
    Log    ${result1.status_code}
    Log    ${result1.std_out}
    Log    ${result1.std_err}
    ${convert_result1}=    Convert to String    ${result1.std_out}
    Should Contain    ${convert_result1}    Running

SIA service status
    ${result2}=    Run ps    server      ((Get-Service -Name "*BOEXI40SIA*").status)
    Log    ${result2.status_code}
    Log    ${result2.std_out}
    Log    ${result2.std_err}
    ${convert_result2}=    Convert to String    ${result2.std_out}
    Should Contain    ${convert_result2}    Running

SVNSubversion service status
    ${result3}=    Run ps    server      ((Get-Service -Name "*SVNSubversion*").status)
    Log    ${result3.status_code}
    Log    ${result3.std_out}
    Log    ${result3.std_err}
    ${convert_result3}=    Convert to String    ${result3.std_out}
    Should Contain    ${convert_result3}    Running

SQLAnywhereForBI service status
    ${result4}=    Run ps    server      ((Get-Service -Name "*SQLANYs_SQLAnywhereForBI*").status)
    Log    ${result4.status_code}
    Log    ${result4.std_out}
    Log    ${result4.std_err}
    ${convert_result4}=    Convert to String    ${result4.std_out}
    Should Contain    ${convert_result4}    Running

