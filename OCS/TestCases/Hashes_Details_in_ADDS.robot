*** Settings ***
Documentation    Test case to check the list of Hashes in the ADDS server and comparing with the expected output
Library          WinRMLibrary
Library          Process
Test Setup       Create Session    server    ${ADDSHostname}    Administrator    ${ADDSPassword}
Test Teardown    Delete All Sessions


*** Variables ***
${ADDSHostname}
${ADDSPassword}

*** Test Cases ***
Hashes Details in ADDS
    ${result}=    Run ps    server    Get-ItemProperty -Path "Registry::HKEY_LOCAL_MACHINE\\SYSTEM\\CurrentControlSet\\Control\\SecurityProviders\\SCHANNEL\\Hashes\\MD2" | Select-Object -Property Enabled
    Log    ${result.status_code}
    Log    ${result.std_out}
    Log    ${result.std_err}
    ${convert_result}=    Convert to String    ${result.std_out}
    Should Contain    ${convert_result}    0

    ${result}=    Run ps    server    Get-ItemProperty -Path "Registry::HKEY_LOCAL_MACHINE\\SYSTEM\\CurrentControlSet\\Control\\SecurityProviders\\SCHANNEL\\Hashes\\MD4" | Select-Object -Property Enabled
    Log    ${result.status_code}
    Log    ${result.std_out}
    Log    ${result.std_err}
    ${convert_result}=    Convert to String    ${result.std_out}
    Should Contain    ${convert_result}    0

    ${result}=    Run ps    server    Get-ItemProperty -Path "Registry::HKEY_LOCAL_MACHINE\\SYSTEM\\CurrentControlSet\\Control\\SecurityProviders\\SCHANNEL\\Hashes\\MD5" | Select-Object -Property Enabled
    Log    ${result.status_code}
    Log    ${result.std_out}
    Log    ${result.std_err}
    ${convert_result}=    Convert to String    ${result.std_out}
    Should Contain    ${convert_result}    0

    ${result}=    Run ps    server    Get-ItemProperty -Path "Registry::HKEY_LOCAL_MACHINE\\SYSTEM\\CurrentControlSet\\Control\\SecurityProviders\\SCHANNEL\\Hashes\\SHA1" | Select-Object -Property Enabled
    Log    ${result.status_code}
    Log    ${result.std_out}
    Log    ${result.std_err}
    ${convert_result}=    Convert to String    ${result.std_out}
    Should Contain    ${convert_result}    0

    