*** Settings ***
Documentation    Test case to check whether the AD Domain Services roles are installed in the ADDS server
Library        WinRMLibrary
Library        Process
Test Setup    Create Session    server    ${ADDSHostname}    Administrator    ${ADDSPassword}
Test Teardown    Delete All Sessions


*** Variables ***
${ADDSHostname}
${ADDSPassword}

*** Test Cases ***
AD Domain Services roles in ADDS
    ${result}=    Run ps    server    Get-WindowsFeature AD-Domain-Services | Select-Object InstallState
    Log    ${result.status_code}
    Log    ${result.std_out}
    Log    ${result.std_err}
    ${convert_result}=    Convert to String    ${result.std_out}
    Should Contain    ${convert_result}    Installed
