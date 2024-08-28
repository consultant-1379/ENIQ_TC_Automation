*** Settings ***
Library    WinRMLibrary
Library    Process
Test Setup    Create Session    server    ${hostname}    Administrator    ${host_pw}
Test Teardown    Delete All Sessions

*** Variables ***
${hostname}
${host_pw} 
${install_config_folder}    C:\\ebid\\install_config\\log 

*** Test Cases ***
Check Update CMC and BILP URLs
    ${result}=    Run Ps    server    cd ${install_config_folder} ; $latestfile = Get-ChildItem -Attributes !Directory ebid_install_config_log*.log | Sort-Object -Descending -Property LastWriteTime | select -First 1 ; get-content $latestfile.name | Select-string -pattern "Update Central Management Console and BI Launch Pad URLs"
    Log    ${result.status_code}
    Log    ${result.std_out}
    Log    ${result.std_err}
    ${convert_result}=    Convert To String    ${result.std_out}
    IF    ${result.status_code} == 0
        Should Contain Any   ${convert_result}    Successful    Completed. No action required  
    ELSE    
        Log To Console    install config log file not found
        Fail
    END
    