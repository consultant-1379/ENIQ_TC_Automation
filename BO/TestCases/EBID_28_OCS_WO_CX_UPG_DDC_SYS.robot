*** Settings ***
Library        WinRMLibrary
Library        Process
Test Setup    Create Session    server    ${hostname}    Administrator    ${host_pw}
Test Teardown    Delete All Sessions


*** Variables ***
${hostname}
${host_pw}
${OCS_WO_CX_DDC_Sys_Log_Path}        C:\\OCS-without-Citrix\\DDC_logs\\system_logs

*** Test Cases ***
DDC_DDP Configuration in OCS-without-Citrix   
    ${result}=    Run ps    server    ((Test-Path -Path ${OCS_WO_CX_DDC_Sys_Log_Path}))
    Log    ${result.status_code}
    Log    ${result.std_out}
    Log    ${result.std_err}
    ${convert_result}=    Convert to String    ${result.std_out}
    Should Contain    ${convert_result}    True

Drive_Info File check
    ${result}=    Run ps    server    ((Test-Path -Path ${OCS_WO_CX_DDC_Sys_Log_Path}\\Drive_Info*.tsv))
    Log    ${result.status_code}
    Log    ${result.std_out}
    Log    ${result.std_err}
    ${convert_result}=    Convert to String    ${result.std_out}
    Should Contain    ${convert_result}    True

Hardware_Details File check
   ${result}=    Run ps    server    ((Test-Path -Path ${OCS_WO_CX_DDC_Sys_Log_Path}\\Hardware_Details*.tsv))
    Log    ${result.status_code}
    Log    ${result.std_out}
    Log    ${result.std_err}
    ${convert_result}=    Convert to String    ${result.std_out}
    Should Contain    ${convert_result}    True 


hostname File check
    ${result}=    Run ps    server    ((Test-Path -Path ${OCS_WO_CX_DDC_Sys_Log_Path}\\hostname.tsv))
    Log    ${result.status_code}
    Log    ${result.std_out}
    Log    ${result.std_err}
    ${convert_result}=    Convert to String    ${result.std_out}
    Should Contain    ${convert_result}    True


Logical_Disk File check
    ${result}=    Run ps    server    ((Test-Path -Path ${OCS_WO_CX_DDC_Sys_Log_Path}\\Logical_Disk*.tsv))
    Log    ${result.status_code}
    Log    ${result.std_out}
    Log    ${result.std_err}
    ${convert_result}=    Convert to String    ${result.std_out}
    Should Contain    ${convert_result}    True

Memory File check
    ${result}=    Run ps    server    ((Test-Path -Path ${OCS_WO_CX_DDC_Sys_Log_Path}\\Memory*.tsv))
    Log    ${result.status_code}
    Log    ${result.std_out}
    Log    ${result.std_err}
    ${convert_result}=    Convert to String    ${result.std_out}
    Should Contain    ${convert_result}    True

Memory_Related_Counters File check
    ${result}=    Run ps    server    ((Test-Path -Path ${OCS_WO_CX_DDC_Sys_Log_Path}\\Memory_Related_Counters*.tsv))
    Log    ${result.status_code}
    Log    ${result.std_out}
    Log    ${result.std_err}
    ${convert_result}=    Convert to String    ${result.std_out}
    Should Contain    ${convert_result}    True

NBT_Connections File check
    ${result}=    Run ps    server    ((Test-Path -Path ${OCS_WO_CX_DDC_Sys_Log_Path}\\NBT_Connections*.tsv))
    Log    ${result.status_code}
    Log    ${result.std_out}
    Log    ${result.std_err}
    ${convert_result}=    Convert to String    ${result.std_out}
    Should Contain    ${convert_result}    True

Network_Interface File check
    ${result}=    Run ps    server    ((Test-Path -Path ${OCS_WO_CX_DDC_Sys_Log_Path}\\Network_Interface*.tsv))
    Log    ${result.status_code}
    Log    ${result.std_out}
    Log    ${result.std_err}
    ${convert_result}=    Convert to String    ${result.std_out}
    Should Contain    ${convert_result}    True

Physical_Disk File check
    ${result}=    Run ps    server    ((Test-Path -Path ${OCS_WO_CX_DDC_Sys_Log_Path}\\Physical_Disk*.tsv))
    Log    ${result.status_code}
    Log    ${result.std_out}
    Log    ${result.std_err}
    ${convert_result}=    Convert to String    ${result.std_out}
    Should Contain    ${convert_result}    True

Processor File check
    ${result}=    Run ps    server    ((Test-Path -Path ${OCS_WO_CX_DDC_Sys_Log_Path}\\Processor*.tsv))
    Log    ${result.status_code}
    Log    ${result.std_out}
    Log    ${result.std_err}
    ${convert_result}=    Convert to String    ${result.std_out}
    Should Contain    ${convert_result}    True

Redirector File check
    ${result}=    Run ps    server    ((Test-Path -Path ${OCS_WO_CX_DDC_Sys_Log_Path}\\Redirector*.tsv))
    Log    ${result.status_code}
    Log    ${result.std_out}
    Log    ${result.std_err}
    ${convert_result}=    Convert to String    ${result.std_out}
    Should Contain    ${convert_result}    True

Server File check
    ${result}=    Run ps    server    ((Test-Path -Path ${OCS_WO_CX_DDC_Sys_Log_Path}\\Server*.tsv))
    Log    ${result.status_code}
    Log    ${result.std_out}
    Log    ${result.std_err}
    ${convert_result}=    Convert to String    ${result.std_out}
    Should Contain    ${convert_result}    True

Server_Work_Queues File check
    ${result}=    Run ps    server    ((Test-Path -Path ${OCS_WO_CX_DDC_Sys_Log_Path}\\Server_Work_Queues*.tsv))
    Log    ${result.status_code}
    Log    ${result.std_out}
    Log    ${result.std_err}
    ${convert_result}=    Convert to String    ${result.std_out}
    Should Contain    ${convert_result}    True

System File check
    ${result}=    Run ps    server    ((Test-Path -Path ${OCS_WO_CX_DDC_Sys_Log_Path}\\System*.tsv))
    Log    ${result.status_code}
    Log    ${result.std_out}
    Log    ${result.std_err}
    ${convert_result}=    Convert to String    ${result.std_out}
    Should Contain    ${convert_result}    True
	
System All File check
    ${result}=    Run ps    server    ((Test-Path -Path ${OCS_WO_CX_DDC_Sys_Log_Path}\\System_All*.tsv))
    Log    ${result.status_code}
    Log    ${result.std_out}
    Log    ${result.std_err}
    ${convert_result}=    Convert to String    ${result.std_out}
    Should Contain    ${convert_result}    True
	
System BO File check
    ${result}=    Run ps    server    ((Test-Path -Path ${OCS_WO_CX_DDC_Sys_Log_Path}\\System_BO*.tsv))
    Log    ${result.status_code}
    Log    ${result.std_out}
    Log    ${result.std_err}
    ${convert_result}=    Convert to String    ${result.std_out}
    Should Contain    ${convert_result}    True