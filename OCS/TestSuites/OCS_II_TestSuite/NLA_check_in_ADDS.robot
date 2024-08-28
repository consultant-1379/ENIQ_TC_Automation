*** Settings ***
Documentation    Test case to check Network Level Authentication (NLA) status for  
...              Remote Desktop Connections in the ADDS server
Library        WinRMLibrary
Library        Process
Test Setup    Create Session    server    ${ADDSHostname}    Administrator    ${ADDSPassword}
Test Teardown    Delete All Sessions


*** Variables ***
${ADDSHostname}
${ADDSPassword}

*** Test Cases ***
NLA status check in ADDS
    ${result}=    Run ps    server    (Get-WmiObject -class "Win32_TSGeneralSetting" -Namespace root\\cimv2\\terminalservices -ComputerName $env:ComputerName -Filter "TerminalName='RDP-tcp'").UserAuthenticationRequired
    Log    ${result.status_code}
    Log    ${result.std_out}
    Log    ${result.std_err}
    ${convert_result}=    Convert to String    ${result.std_out}
    Should Contain    ${convert_result}    1