*** Settings ***
Documentation    Test case to check whether the Remote Desktop Session Host roles are installed in the ADDS server
Library        WinRMLibrary
Library        Process
Test Setup    Create Session    server    ${ADDSHostname}    Administrator    ${ADDSPassword}
Test Teardown    Delete All Sessions


*** Variables ***
${ADDSHostname}
${ADDSPassword}


*** Test Cases ***
Remote Desktop Session Host roles in ADDS
    ${result}=    Run ps    server    Get-WindowsFeature RDS-RD-Server | Select-Object InstallState
    Log    ${result.status_code}
    Log    ${result.std_out}
    Log    ${result.std_err}
    ${convert_result}=    Convert to String    ${result.std_out}
    Should Contain    ${convert_result}    Installed