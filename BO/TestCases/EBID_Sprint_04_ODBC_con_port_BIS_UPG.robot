*** Settings ***
Library    WinRMLibrary
Library    Process
Test Setup    Create Session    server    ${hostname}    Administrator    ${host_pw}
Test Teardown    Delete All Sessions


*** Variables ***
${hostname}
${host_pw}
${firewall_path}    C:\\Firewall\\log

*** Test Cases ***
Check port value 2638
    ${result}=    Run Ps    server    cd ${firewall_path} ; $latestfile = Get-ChildItem -Attributes !Directory Firewall_Settings_EnableFirewall*.txt | Sort-Object -Descending -Property LastWriteTime | select -First 1 ; get-content $latestfile.name | Select-string -pattern "2638 is a Valid Port"
    Log    ${result.status_code}
    Log    ${result.std_out}
    Log    ${result.std_err}
    ${convert_result}=    Convert To String    ${result.std_out}
    IF    ${result.status_code} == 0
        Should Contain    ${convert_result}    2638 is a Valid Port
    ELSE    
        Log To Console    Firewall log file not found
        Fail
    END
    

