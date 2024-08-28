*** Settings ***
Library    WinRMLibrary
Library    Process
Library    Collections
Test Setup    Create Session    server    ${hostname}    Administrator    ${host_pw}
Test Teardown    Delete All Sessions


*** Variables ***
${hostname}
${host_pw}

*** Test Cases ***
Creating CSV with Firewall Ports details
    ${result} =    Run ps    server      Get-NetFirewallRule -Direction Inbound | Where-Object {$_.DisplayName -eq "Allow the Required Ports"} | Get-NetFirewallPortFilter | Select-Object -Property LocalPort | Export-Csv -Path "C:\\ebid\\firewallport.csv" -Force

    ${result2}=    Run ps    server    (Test-Path -Path "C:\\ebid\\firewallport.csv")
    Log    ${result2.status_code}
    Log    ${result2.std_out}
    Log    ${result2.std_err}
    ${convert_result2}=    Convert to String    ${result2.std_out}
    Should Contain    ${convert_result2}    True
    
Checking firewall ports
    ${result3}=    Run Ps    server    (Get-Content -Path "C:\\ebid\\firewallport.csv" | Select-string -pattern "2049 2638 3389 8080 8443 6400-6403 6405-6407 6410-6420 1556 13724 13782")
    Log    ${result3.status_code}
    Log    ${result3.std_out}
    Log    ${result3.std_err}
    ${convert_result3}=    Convert to String    ${result3.std_out}
    Should Contain  ${convert_result3}    "2049 2638 3389 8080 8443 6400-6403 6405-6407 6410-6420 1556 13724 13782"