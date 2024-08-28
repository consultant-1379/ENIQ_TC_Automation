*** Settings ***
Library    WinRMLibrary
Library    Process
Test Setup    Create Session    server    ${hostname}    Administrator    ${host_pw}
Test Teardown    Delete All Sessions

*** Variables ***
${hostname}
${host_pw}
${legal_notice_log}     c:\\ebid\\install_config\\log

*** Test Cases ***
Legal Notice CMC check
    ${result}=    Run Ps    server    cd ${legal_notice_log}; ($latestfile = (Get-ChildItem -Attributes !Directory C:\\ebid\\install_config\\log\\ebid_legal_notice*.log) | Sort-Object -Descending -Property LastWriteTime | select -First 1) ; Get-Content $latestfile.name
    Log    ${result.status_code}
    Log    ${result.std_out}
    Log    ${result.std_err}
    ${convert_result}=    Convert To String    ${result.std_out}
    IF    ${result.status_code} == 0
        Should Contain Any   ${convert_result}    Legal Notice Message update is successful    Legal Warning Message is already updated for CMC and Fiori BI
    ELSE    
        Log To Console    Legal Warning message is not updated.
        Fail
    END