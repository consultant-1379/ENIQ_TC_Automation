*** Settings ***
Library    WinRMLibrary
Library    Process
Test Setup    Create Session    server    ${hostname}    Administrator    ${host_pw}
Test Teardown    Delete All Sessions

*** Variables ***
${hostname}
${host_pw}
${log_path}    C:\\Windows_Hardening\\log

*** Test Cases ***
Verifying Windows Legal Notice task
    ${result} =    Run ps    server     ([bool](Get-ScheduledTask | Where-Object {$_.TaskName -like "Windows Legal Notice"}))
    Log    ${result.std_out}
    Log    ${result.std_err}
    ${convert_result}=    Convert to String    ${result.std_out}
    Should Contain    ${convert_result}    True
    
Windows hardening enable actions check
    ${result}=    Run Ps    server    cd ${log_path} ; $latestfile = Get-ChildItem -Attributes !Directory Windows_Hardening-Enable*.txt | Sort-Object -Descending -Property LastWriteTime | select -First 1 ; get-content $latestfile.name | Select-string -pattern "Create the Prototype Security Policy"
    Log    ${result.status_code}
    Log    ${result.std_out}
    Log    ${result.std_err}
    ${convert_result}=    Convert To String    ${result.std_out}
    Should Contain Any    ${convert_result}    Successful    Completed. No Action Required

    ${result}=    Run Ps    server    cd ${log_path} ; $latestfile = Get-ChildItem -Attributes !Directory Windows_Hardening-Enable*.txt | Sort-Object -Descending -Property LastWriteTime | select -First 1 ; get-content $latestfile.name | Select-string -pattern "Enable Firewall and Ports"
    Log    ${result.status_code}
    Log    ${result.std_out}
    Log    ${result.std_err}
    ${convert_result}=    Convert To String    ${result.std_out}
    Should Contain Any    ${convert_result}    Successful    Completed. No Action Required
	
	${result}=    Run Ps    server    cd ${log_path} ; $latestfile = Get-ChildItem -Attributes !Directory Windows_Hardening-Enable*.txt | Sort-Object -Descending -Property LastWriteTime | select -First 1 ; get-content $latestfile.name | Select-string -pattern "Enable Certificate-expiry"
    Log    ${result.status_code}
    Log    ${result.std_out}
    Log    ${result.std_err}
    ${convert_result}=    Convert To String    ${result.std_out}
    Should Contain Any    ${convert_result}    Successful    Completed. No Action Required

    ${result}=    Run Ps    server    cd ${log_path} ; $latestfile = Get-ChildItem -Attributes !Directory Windows_Hardening-Enable*.txt | Sort-Object -Descending -Property LastWriteTime | select -First 1 ; get-content $latestfile.name | Select-string -pattern "Block ICMP Vulnerabilities"
    Log    ${result.status_code}
    Log    ${result.std_out}
    Log    ${result.std_err}
    ${convert_result}=    Convert To String    ${result.std_out}
    Should Contain Any    ${convert_result}    Successful    Completed. No Action Required

    ${result}=    Run Ps    server    cd ${log_path} ; $latestfile = Get-ChildItem -Attributes !Directory Windows_Hardening-Enable*.txt | Sort-Object -Descending -Property LastWriteTime | select -First 1 ; get-content $latestfile.name | Select-string -pattern "Disabling AutoRun"
    Log    ${result.status_code}
    Log    ${result.std_out}
    Log    ${result.std_err}
    ${convert_result}=    Convert To String    ${result.std_out}
    Should Contain Any    ${convert_result}    Successful    Completed. No Action Required

    ${result}=    Run Ps    server    cd ${log_path} ; $latestfile = Get-ChildItem -Attributes !Directory Windows_Hardening-Enable*.txt | Sort-Object -Descending -Property LastWriteTime | select -First 1 ; get-content $latestfile.name | Select-string -pattern "Disabling AutoPlay"
    Log    ${result.status_code}
    Log    ${result.std_out}
    Log    ${result.std_err}
    ${convert_result}=    Convert To String    ${result.std_out}
    Should Contain Any    ${convert_result}    Successful    Completed. No Action Required

    ${result}=    Run Ps    server    cd ${log_path} ; $latestfile = Get-ChildItem -Attributes !Directory Windows_Hardening-Enable*.txt | Sort-Object -Descending -Property LastWriteTime | select -First 1 ; get-content $latestfile.name | Select-string -pattern "Enabling Remote Desktop Max Idle Time"
    Log    ${result.status_code}
    Log    ${result.std_out}
    Log    ${result.std_err}
    ${convert_result}=    Convert To String    ${result.std_out}
    Should Contain Any    ${convert_result}    Successful    Completed. No Action Required

    ${result}=    Run Ps    server    cd ${log_path} ; $latestfile = Get-ChildItem -Attributes !Directory Windows_Hardening-Enable*.txt | Sort-Object -Descending -Property LastWriteTime | select -First 1 ; get-content $latestfile.name | Select-string -pattern "Enabling Remote Desktop Session Timeout"
    Log    ${result.status_code}
    Log    ${result.std_out}
    Log    ${result.std_err}
    ${convert_result}=    Convert To String    ${result.std_out}
    Should Contain Any    ${convert_result}    Successful    Completed. No Action Required

    ${result}=    Run Ps    server    cd ${log_path} ; $latestfile = Get-ChildItem -Attributes !Directory Windows_Hardening-Enable*.txt | Sort-Object -Descending -Property LastWriteTime | select -First 1 ; get-content $latestfile.name | Select-string -pattern "Disable Weak Ciphers, Protocols, and Hashes"
    Log    ${result.status_code}
    Log    ${result.std_out}
    Log    ${result.std_err}
    ${convert_result}=    Convert To String    ${result.std_out}
    Should Contain Any    ${convert_result}    Successful    Completed. No Action Required

    ${result}=    Run Ps    server    cd ${log_path} ; $latestfile = Get-ChildItem -Attributes !Directory Windows_Hardening-Enable*.txt | Sort-Object -Descending -Property LastWriteTime | select -First 1 ; get-content $latestfile.name | Select-string -pattern "Updating Legal Notice"
    Log    ${result.status_code}
    Log    ${result.std_out}
    Log    ${result.std_err}
    ${convert_result}=    Convert To String    ${result.std_out}
    Should Contain Any    ${convert_result}    Successful    Completed. No Action Required

    ${result}=    Run Ps    server    cd ${log_path} ; $latestfile = Get-ChildItem -Attributes !Directory Windows_Hardening-Enable*.txt | Sort-Object -Descending -Property LastWriteTime | select -First 1 ; get-content $latestfile.name | Select-string -pattern "Enable Password Policies"
    Log    ${result.status_code}
    Log    ${result.std_out}
    Log    ${result.std_err}
    ${convert_result}=    Convert To String    ${result.std_out}
    Should Contain Any    ${convert_result}    Successful    Completed. No Action Required

    ${result}=    Run Ps    server    cd ${log_path} ; $latestfile = Get-ChildItem -Attributes !Directory Windows_Hardening-Enable*.txt | Sort-Object -Descending -Property LastWriteTime | select -First 1 ; get-content $latestfile.name | Select-string -pattern "Enabling SMB Protocols"
    Log    ${result.status_code}
    Log    ${result.std_out}
    Log    ${result.std_err}
    ${convert_result}=    Convert To String    ${result.std_out}
    Should Contain Any    ${convert_result}    Successful    Completed. No Action Required

    ${result}=    Run Ps    server    cd ${log_path} ; $latestfile = Get-ChildItem -Attributes !Directory Windows_Hardening-Enable*.txt | Sort-Object -Descending -Property LastWriteTime | select -First 1 ; get-content $latestfile.name | Select-string -pattern "Enable NLA"
    Log    ${result.status_code}
    Log    ${result.std_out}
    Log    ${result.std_err}
    ${convert_result}=    Convert To String    ${result.std_out}
    Should Contain Any    ${convert_result}    Successful    Completed. No Action Required

