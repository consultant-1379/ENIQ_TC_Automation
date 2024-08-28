*** Settings ***
Documentation    Test case to check whether the DDC Configuration script was executed successfully and 
...              fetching the logs information from DDC logs folder from the VDA server
Library          WinRMLibrary
Library          Process
Test Setup       Create Session    server    ${VDAHostname}    Administrator    ${VDAPassword}
Test Teardown    Delete All Sessions


*** Variables ***
${VDAHostname}
${VDAPassword}
${VDA_DDC_Log_Path}        C:\\OCS\\DDC_logs\\system_logs

*** Test Cases ***
DDC_DDP Configuration in VDA    
    ${result}=    Run ps    server    ((Test-Path -Path ${VDA_DDC_Log_Path}))
    Log    ${result.status_code}
    Log    ${result.std_out}
    Log    ${result.std_err}
    ${convert_result}=    Convert to String    ${result.std_out}
    Should Contain    ${convert_result}    True


    ${result}=    Run ps    server    ((Test-Path -Path ${VDA_DDC_Log_Path}\\Drive_Info*.tsv))
    Log    ${result.status_code}
    Log    ${result.std_out}
    Log    ${result.std_err}
    ${convert_result}=    Convert to String    ${result.std_out}
    Should Contain    ${convert_result}    True


   ${result}=    Run ps    server    ((Test-Path -Path ${VDA_DDC_Log_Path}\\Hardware_Details*.tsv))
    Log    ${result.status_code}
    Log    ${result.std_out}
    Log    ${result.std_err}
    ${convert_result}=    Convert to String    ${result.std_out}
    Should Contain    ${convert_result}    True 


    ${result}=    Run ps    server    ((Test-Path -Path ${VDA_DDC_Log_Path}\\hostname.tsv))
    Log    ${result.status_code}
    Log    ${result.std_out}
    Log    ${result.std_err}
    ${convert_result}=    Convert to String    ${result.std_out}
    Should Contain    ${convert_result}    True


    ${result}=    Run ps    server    ((Test-Path -Path ${VDA_DDC_Log_Path}\\Logical_Disk*.tsv))
    Log    ${result.status_code}
    Log    ${result.std_out}
    Log    ${result.std_err}
    ${convert_result}=    Convert to String    ${result.std_out}
    Should Contain    ${convert_result}    True


    ${result}=    Run ps    server    ((Test-Path -Path ${VDA_DDC_Log_Path}\\Memory*.tsv))
    Log    ${result.status_code}
    Log    ${result.std_out}
    Log    ${result.std_err}
    ${convert_result}=    Convert to String    ${result.std_out}
    Should Contain    ${convert_result}    True


    ${result}=    Run ps    server    ((Test-Path -Path ${VDA_DDC_Log_Path}\\Memory_Related_Counters*.tsv))
    Log    ${result.status_code}
    Log    ${result.std_out}
    Log    ${result.std_err}
    ${convert_result}=    Convert to String    ${result.std_out}
    Should Contain    ${convert_result}    True


    ${result}=    Run ps    server    ((Test-Path -Path ${VDA_DDC_Log_Path}\\NBT_Connections*.tsv))
    Log    ${result.status_code}
    Log    ${result.std_out}
    Log    ${result.std_err}
    ${convert_result}=    Convert to String    ${result.std_out}
    Should Contain    ${convert_result}    True


    ${result}=    Run ps    server    ((Test-Path -Path ${VDA_DDC_Log_Path}\\Network_Interface*.tsv))
    Log    ${result.status_code}
    Log    ${result.std_out}
    Log    ${result.std_err}
    ${convert_result}=    Convert to String    ${result.std_out}
    Should Contain    ${convert_result}    True


    ${result}=    Run ps    server    ((Test-Path -Path ${VDA_DDC_Log_Path}\\OCSVersion*.tsv))
    Log    ${result.status_code}
    Log    ${result.std_out}
    Log    ${result.std_err}
    ${convert_result}=    Convert to String    ${result.std_out}
    Should Contain    ${convert_result}    True


    ${result}=    Run ps    server    ((Test-Path -Path ${VDA_DDC_Log_Path}\\Physical_Disk*.tsv))
    Log    ${result.status_code}
    Log    ${result.std_out}
    Log    ${result.std_err}
    ${convert_result}=    Convert to String    ${result.std_out}
    Should Contain    ${convert_result}    True


    ${result}=    Run ps    server    ((Test-Path -Path ${VDA_DDC_Log_Path}\\Processor*.tsv))
    Log    ${result.status_code}
    Log    ${result.std_out}
    Log    ${result.std_err}
    ${convert_result}=    Convert to String    ${result.std_out}
    Should Contain    ${convert_result}    True


    ${result}=    Run ps    server    ((Test-Path -Path ${VDA_DDC_Log_Path}\\Redirector*.tsv))
    Log    ${result.status_code}
    Log    ${result.std_out}
    Log    ${result.std_err}
    ${convert_result}=    Convert to String    ${result.std_out}
    Should Contain    ${convert_result}    True


    ${result}=    Run ps    server    ((Test-Path -Path ${VDA_DDC_Log_Path}\\Server*.tsv))
    Log    ${result.status_code}
    Log    ${result.std_out}
    Log    ${result.std_err}
    ${convert_result}=    Convert to String    ${result.std_out}
    Should Contain    ${convert_result}    True


    ${result}=    Run ps    server    ((Test-Path -Path ${VDA_DDC_Log_Path}\\Server_Work_Queues*.tsv))
    Log    ${result.status_code}
    Log    ${result.std_out}
    Log    ${result.std_err}
    ${convert_result}=    Convert to String    ${result.std_out}
    Should Contain    ${convert_result}    True


    ${result}=    Run ps    server    ((Test-Path -Path ${VDA_DDC_Log_Path}\\System*.tsv))
    Log    ${result.status_code}
    Log    ${result.std_out}
    Log    ${result.std_err}
    ${convert_result}=    Convert to String    ${result.std_out}
    Should Contain    ${convert_result}    True


    ${result}=    Run ps    server    ((Test-Path -Path ${VDA_DDC_Log_Path}\\System_All*.tsv))
    Log    ${result.status_code}
    Log    ${result.std_out}
    Log    ${result.std_err}
    ${convert_result}=    Convert to String    ${result.std_out}
    Should Contain    ${convert_result}    True


    ${result}=    Run ps    server    ((Test-Path -Path ${VDA_DDC_Log_Path}\\System_BO*.tsv))
    Log    ${result.status_code}
    Log    ${result.std_out}
    Log    ${result.std_err}
    ${convert_result}=    Convert to String    ${result.std_out}
    Should Contain    ${convert_result}    True
