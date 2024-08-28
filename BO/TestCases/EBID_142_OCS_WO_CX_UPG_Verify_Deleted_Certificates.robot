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
Verify deleted unused certificates

    ${result}=    Run Ps    server    (Test-Path (((Get-ItemProperty -Path 'HKLM:\\SOFTWARE\\SAP BusinessObjects\\Suite XI 4.0\\Installer\\Aurora' -Name Path).Path)+'AdminConsole\\MessagingQueueBroker\\etc\\ssl\\activemq.server.keystore'))
    Log    ${result.status_code}
    Log    ${result.std_out}
    ${convert_result}=    Convert to String    ${result.std_out}
    Should Contain    ${convert_result}    False       
    
    ${result}=    Run Ps    server    (Test-Path (((Get-ItemProperty -Path 'HKLM:\\SOFTWARE\\SAP BusinessObjects\\Suite XI 4.0\\Installer\\Aurora' -Name Path).Path)+'AdminConsole\\MessagingQueueBroker\\etc\\ssl\\activemq.client.truststore'))
    Log    ${result.status_code}
    Log    ${result.std_out}
    ${convert_result}=    Convert to String    ${result.std_out}
    Should Contain    ${convert_result}    False 

    ${result}=    Run Ps    server    (Test-Path (((Get-ItemProperty -Path 'HKLM:\\SOFTWARE\\SAP BusinessObjects\\Suite XI 4.0\\Installer\\Aurora' -Name Path).Path)+'AdminConsole\\MessagingQueueBroker\\etc\\ssl\\client.cer'))
    Log    ${result.status_code}
    Log    ${result.std_out}
    ${convert_result}=    Convert to String    ${result.std_out}
    Should Contain    ${convert_result}    False 

    ${result}=    Run Ps    server    (Test-Path (((Get-ItemProperty -Path 'HKLM:\\SOFTWARE\\SAP BusinessObjects\\Suite XI 4.0\\Installer\\Aurora' -Name Path).Path)+'SAP BusinessObjects Enterprise XI 4.0\\warfiles\\webapps\\biprws\\WEB-INF\\sampletestKeystore.jks'))
    Log    ${result.status_code}
    Log    ${result.std_out}
    ${convert_result}=    Convert to String    ${result.std_out}
    Should Contain    ${convert_result}    False 

    ${result}=    Run Ps    server    (Test-Path (((Get-ItemProperty -Path 'HKLM:\\SOFTWARE\\SAP BusinessObjects\\Suite XI 4.0\\Installer\\Aurora' -Name Path).Path)+'tomcat\\webapps\\biprws\\WEB-INF\\sampletestKeystore.jks'))
    Log    ${result.status_code}
    Log    ${result.std_out}
    ${convert_result}=    Convert to String    ${result.std_out}
    Should Contain    ${convert_result}    False 

    ${result}=    Run Ps    server    (Test-Path (((Get-ItemProperty -Path 'HKLM:\\SOFTWARE\\SAP BusinessObjects\\Suite XI 4.0\\Installer\\Aurora' -Name Path).Path)+'SAP BusinessObjects Enterprise XI 4.0\\warfiles\\webapps\\MobileBIService\\WEB-INF\\apnscert\\20171003_BOBJ Mobile.p12'))
    Log    ${result.status_code}
    Log    ${result.std_out}
    ${convert_result}=    Convert to String    ${result.std_out}
    Should Contain    ${convert_result}    False 

    ${result}=    Run Ps    server    (Test-Path (((Get-ItemProperty -Path 'HKLM:\\SOFTWARE\\SAP BusinessObjects\\Suite XI 4.0\\Installer\\Aurora' -Name Path).Path)+'tomcat\\webapps\\MobileBIService\\WEB-INF\\apnscert\\20171003_BOBJ Mobile.p12'))
    Log    ${result.status_code}
    Log    ${result.std_out}
    ${convert_result}=    Convert to String    ${result.std_out}
    Should Contain    ${convert_result}    False 

    ${result}=    Run Ps    server    (Test-Path (((Get-ItemProperty -Path 'HKLM:\\SOFTWARE\\SAP BusinessObjects\\Suite XI 4.0\\Installer\\Aurora' -Name Path).Path)+'SAP BusinessObjects Enterprise XI 4.0\\win32_x86\\odbc\\simbasalesforce\\2.0\\lib\\cacerts.pem'))
    Log    ${result.status_code}
    Log    ${result.std_out}
    ${convert_result}=    Convert to String    ${result.std_out}
    Should Contain    ${convert_result}    False 

    ${result}=    Run Ps    server    (Test-Path (((Get-ItemProperty -Path 'HKLM:\\SOFTWARE\\SAP BusinessObjects\\Suite XI 4.0\\Installer\\Aurora' -Name Path).Path)+'SAP BusinessObjects Enterprise XI 4.0\\win64_x64\\odbc\\simbahive\\2.0\\lib\\cacerts.pem'))
    Log    ${result.status_code}
    Log    ${result.std_out}
    ${convert_result}=    Convert to String    ${result.std_out}
    Should Contain    ${convert_result}    False 

    ${result}=    Run Ps    server    (Test-Path (((Get-ItemProperty -Path 'HKLM:\\SOFTWARE\\SAP BusinessObjects\\Suite XI 4.0\\Installer\\Aurora' -Name Path).Path)+'SAP BusinessObjects Enterprise XI 4.0\\win64_x64\\odbc\\simbaimpala\\1.0\\lib\\cacerts.pem'))
    Log    ${result.status_code}
    Log    ${result.std_out}
    ${convert_result}=    Convert to String    ${result.std_out}
    Should Contain    ${convert_result}    False 

    ${result}=    Run Ps    server    (Test-Path (((Get-ItemProperty -Path 'HKLM:\\SOFTWARE\\SAP BusinessObjects\\Suite XI 4.0\\Installer\\Aurora' -Name Path).Path)+'SAP BusinessObjects Enterprise XI 4.0\\win64_x64\\odbc\\simbasalesforce\\2.0\\lib\\cacerts.pem'))
    Log    ${result.status_code}
    Log    ${result.std_out}
    ${convert_result}=    Convert to String    ${result.std_out}
    Should Contain    ${convert_result}    False 

    ${result}=    Run Ps    server    (Test-Path (((Get-ItemProperty -Path 'HKLM:\\SOFTWARE\\SAP BusinessObjects\\Suite XI 4.0\\Installer\\Aurora' -Name Path).Path)+'SAP BusinessObjects Enterprise XI 4.0\\win64_x64\\odbc\\simbaspark\\1.0\\lib\\cacerts.pem'))
    Log    ${result.status_code}
    Log    ${result.std_out}
    ${convert_result}=    Convert to String    ${result.std_out}
    Should Contain    ${convert_result}    False 

    ${result}=    Run Ps    server    (Test-Path (((Get-ItemProperty -Path 'HKLM:\\SOFTWARE\\SAP BusinessObjects\\Suite XI 4.0\\Installer\\Aurora' -Name Path).Path)+'SAP BusinessObjects Enterprise XI 4.0\\win64_x64\\odbc\\simbaspark\\2.0\\lib\\cacerts.pem'))
    Log    ${result.status_code}
    Log    ${result.std_out}
    ${convert_result}=    Convert to String    ${result.std_out}
    Should Contain    ${convert_result}    False