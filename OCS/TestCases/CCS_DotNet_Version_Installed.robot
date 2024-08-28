*** Settings ***
Library        WinRMLibrary
Library        Process
Resource        ../Resources/Variables/OCS_Variables.robot
Test Setup    Create Session    server    ${CCSHostname}    Administrator    ${CCSPassword}
Test Teardown    Delete All Sessions


*** Test Cases ***
.NET version installed in CCS Server
    ${result}=    Run ps    server    (Get-ItemProperty "HKLM:\\SOFTWARE\\Microsoft\\NET Framework Setup\\NDP\\v4\\Full").Release -gt 528040
    Log    ${result.status_code}
    Log    ${result.std_out}
    Log    ${result.std_err}
    ${convert_result}=    Convert to String    ${result.std_out}
    Should Contain    ${convert_result}    True
