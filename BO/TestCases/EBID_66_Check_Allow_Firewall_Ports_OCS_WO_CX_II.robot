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
Check Firewall ports
    ${result2} =    Run ps    server      Get-NetFirewallRule -Direction Inbound | Where-Object {$_.DisplayName -eq "Allow the Required Ports"} | Get-NetFirewallPortFilter | Select-Object -Property LocalPort | Export-Csv -Path "C:\\ebid\\firewallport.csv" -Force
    
    ${result}=    Run Ps    server    (Get-Content -Path "C:\\ebid\\firewallport.csv" | Select-string -pattern "2049 3389 1556 13724 13782")
    Log    ${result.status_code}
    Log    ${result.std_out}
    Log    ${result.std_err}
    ${convert_result}=    Convert to String    ${result.std_out}
    Should Contain  ${convert_result}    "2049 3389 1556 13724 13782"