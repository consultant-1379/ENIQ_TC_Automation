*** Settings ***
Library    WinRMLibrary
Library    Process
Library    String
Test Setup    Create Session    server    ${hostname}    Administrator    ${host_pw}
Test Teardown    Delete All Sessions

*** Variables ***
${hostname}
${host_pw}
${bi_version}

*** Test Cases ***
Microsoft Defender Status check1
    ${result}=    Run ps    server      (Get-MpComputerStatus).BehaviorMonitorEnabled
    Log    ${result.status_code}
    Log    ${result.std_out}
    Log    ${result.std_err}
    ${convert_result}=    Convert to String    ${result.std_out}
    Should Contain    ${convert_result}    True

Microsoft Defender Status check2
    ${result}=    Run ps    server      (Get-MpComputerStatus).IoavProtectionEnabled
    Log    ${result.status_code}
    Log    ${result.std_out}
    Log    ${result.std_err}
    ${convert_result}=    Convert to String    ${result.std_out}
    Should Contain    ${convert_result}    True

Microsoft Defender Status check3
    ${result}=    Run ps    server      (Get-MpComputerStatus).NISEnabled
    Log    ${result.status_code}
    Log    ${result.std_out}
    Log    ${result.std_err}
    ${convert_result}=    Convert to String    ${result.std_out}
    Should Contain    ${convert_result}    True

Microsoft Defender Status check4
    ${result}=    Run ps    server      (Get-MpComputerStatus).OnAccessProtectionEnabled
    Log    ${result.status_code}
    Log    ${result.std_out}
    Log    ${result.std_err}
    ${convert_result}=    Convert to String    ${result.std_out}
    Should Contain    ${convert_result}    True

Microsoft Defender Status check5
    ${result}=    Run ps    server      (Get-MpComputerStatus).RealTimeProtectionEnabled
    Log    ${result.status_code}
    Log    ${result.std_out}
    Log    ${result.std_err}
    ${convert_result}=    Convert to String    ${result.std_out}
    Should Contain    ${convert_result}    True