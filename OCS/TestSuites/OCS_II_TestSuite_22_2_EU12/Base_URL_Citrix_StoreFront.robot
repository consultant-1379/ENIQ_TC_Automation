*** Settings ***
Documentation    Test case to verify the Citrix StoreFront Base URL configured with https
Library        WinRMLibrary
Library        Process
Test Setup    Create Session    server    ${CCSHostname}    Administrator    ${CCSPassword}
Test Teardown    Delete All Sessions

*** Variables ***
${CCSHostname}
${CCSPassword}

*** Test Cases ***
Base URL verification for Citrix StoreFront in CCS server
    Run ps      server      aspn citrix.*
    sleep       15s
    ${result}=    Run ps    server      Get-STFDeployment | Select-Object HostbaseUrl
    Log    ${result.status_code}
    Log    ${result.std_out}
    Log    ${result.std_err}
    ${convert_result}=    Convert to String    ${result.std_out}
    Should Contain    ${convert_result}    https
