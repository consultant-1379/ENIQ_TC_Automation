*** Settings ***
Library    WinRMLibrary
Library    Process
Library    String
Test Setup    Create Session    server    ${hostname}    Administrator    ${host_pw}
Test Teardown    Delete All Sessions

*** Variables ***
${hostname}
${host_pw}

*** Test Cases ***
Verify presence of password Jar file 
    ${result}=    Run Ps    server    (Test-Path -Path (((Get-ItemProperty -Path 'HKLM:\\SOFTWARE\\SAP BusinessObjects\\Suite XI 4.0\\Installer\\Aurora' -Name Path).Path)+'tomcat\\lib\\PasswordEncryptionDecryption.jar'))
    Log    ${result.status_code}
    Log    ${result.std_out}
    Log    ${result.std_err}
    ${convert_result}=    Convert to String    ${result.std_out}
    Should Contain    ${convert_result}    True

Verify password protocol
    ${result}=    Run Ps    server    (Get-Content -Path (((Get-ItemProperty -Path 'HKLM:\\SOFTWARE\\SAP BusinessObjects\\Suite XI 4.0\\Installer\\Aurora' -Name Path).Path)+'tomcat\\conf\\server.xml'))
    Log    ${result.status_code}
    Log    ${result.std_out}
    Log    ${result.std_err}
    ${convert_result}=    Convert To String    ${result.std_out}
    Should Contain    ${convert_result}    protocol="com.password.creation.CustomHttp11NioProtocol"