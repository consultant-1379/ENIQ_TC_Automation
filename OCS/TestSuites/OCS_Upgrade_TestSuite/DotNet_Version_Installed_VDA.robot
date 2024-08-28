*** Settings ***
Documentation    Test case to fetch the value of the .NET Framework installed in the VDA server
...              and compare/check the value/output is greater than the expected value or not
Library        WinRMLibrary
Library        Process
Test Setup    Create Session    server    ${VDAHostname}    Administrator    ${VDAPassword}
Test Teardown    Delete All Sessions

*** Variables ***
${VDAHostname}
${VDAPassword}

*** Test Cases ***
.NET version installed in VDA Server

    ${result}=    Run ps    server    (Get-ItemProperty "HKLM:\\SOFTWARE\\Microsoft\\NET Framework Setup\\NDP\\v4\\Full").Release -gt 528040
    Log    ${result.status_code}
    Log    ${result.std_out}
    Log    ${result.std_err}
    ${convert_result}=    Convert to String    ${result.std_out}
    Should Contain    ${convert_result}    True
