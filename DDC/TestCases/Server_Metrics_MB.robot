*** Settings ***
Suite Setup        Open Connection And Log In
Suite Teardown     Close All Connections
Library            Collections
Library            SSHLibrary
Library            DateTime
Library            DependencyLibrary
Library            RPA.FileSystem
Resource           ../Resources/Resource.resource


*** Test Cases ***
Checking for eniq_history file in source
    [Documentation]       Checking for eniq_history file in /eniq/admin/version directory
    [Tags]                Server_Metrics
    Check File Exists     /eniq/admin/version/eniq_history

Checking for eniq_history file size in source
    Depends on test       Checking for eniq_history file in source
    [Documentation]       Checking for non empty eniq_history file in /eniq/admin/version directory
    [Tags]                Server_Metrics
    Check File Size       /eniq/admin/version/eniq_history

Checking for eniq_history file in destination
    Depends on test       Checking for eniq_history file size in source
    [Documentation]       Checking for eniq_history file in /eniq/log/ddc_data/${hostname}/${date_dmy}/ENIQ directory
    [Tags]                Server_Metrics
    Check File Exists     /eniq/log/ddc_data/${hostname}/${date_dmy}/ENIQ/eniq_history

Checking for eniq_history file size in destination
    Depends on test       Checking for eniq_history file in destination
    [Documentation]       Checking for non empty eniq_history file in /eniq/log/ddc_data/${hostname}/${date_dmy}/ENIQ directory
    [Tags]                Server_Metrics
    Check File Size       /eniq/log/ddc_data/${hostname}/${date_dmy}/ENIQ/eniq_history

Checking for eniq_status file in source
    [Documentation]       Checking for eniq_status file in /eniq/admin/version directory
    [Tags]                Server_Metrics
    Check File Exists     /eniq/admin/version/eniq_status

Checking for eniq_status file size in source
    Depends on test       Checking for eniq_status file in source
    [Documentation]       Checking for non empty eniq_status file in /eniq/admin/version directory
    [Tags]                Server_Metrics
    Check File Size       /eniq/admin/version/eniq_status

Checking for eniq_status file in destination
    Depends on test       Checking for eniq_status file size in source
    [Documentation]       Checking for eniq_status file in /eniq/log/ddc_data/${hostname}/${date_dmy}/ENIQ directory
    [Tags]                Server_Metrics
    Check File Exists     /eniq/log/ddc_data/${hostname}/${date_dmy}/ENIQ/eniq_status

Checking for eniq_status file size in destination
    Depends on test       Checking for eniq_status file in destination
    [Documentation]       Checking for non empty eniq_status file in /eniq/log/ddc_data/${hostname}/${date_dmy}/ENIQ directory
    [Tags]                Server_Metrics
    Check File Size       /eniq/log/ddc_data/${hostname}/${date_dmy}/ENIQ/eniq_status

# Checking for btmp file in server directory
#     [Documentation]       Checking for btmp file and its size in /eniq/log/ddc_data/${hostname}/${date_dmy}/server directory
#     [Tags]                Server_Metrics
#     FOR    ${element}    IN    @{blade}
#         ${output}=    Execute Command   test -f /eniq/log/ddc_data/${element}/${date_dmy}/server/btmp && echo "true"
#         Log To Console    ${output}
#         IF    '${output}' == 'true'
#             ${output}=     Execute Command   ls -lh /eniq/log/ddc_data/${element}/${date_dmy}/server/btmp | awk '{print $5}' | cut -d "K" -f 1 | cut -d "M" -f 1
#             Log To Console    ${output}
#             IF    ${output}==0
#                 ${count_filesize}=     Evaluate     ${count_filesize}+1
#                 Log To Console    ${count_filesize}
#             END
#         ELSE
#             ${count}=     Evaluate     ${count}+1
#             Continue For Loop
#     END
#     END
#     Log To Console    ${count}
#     Log To Console    ${count_filesize}
#     IF    ${count} > 0
#         Fail    file not found
#     ELSE IF     ${count_filesize}>0
#         Fail    file not found
#     ELSE
#         Pass Execution    file found
#     END

# Checking for boot.log file in server directory
#     [Documentation]       Checking for boot.log file and its size in /eniq/log/ddc_data/${hostname}/${date_dmy}/server directory
#     [Tags]                Server_Metrics
#     FOR    ${element}    IN    @{blade}
#         ${output}=    Execute Command   test -f /eniq/log/ddc_data/${element}/${date_dmy}/server/boot.log && echo "true"
#         Log To Console    ${output}
#         IF    '${output}' == 'true'
#             ${output}=     Execute Command   ls -lh /eniq/log/ddc_data/${element}/${date_dmy}/server/boot.log | awk '{print $5}' | cut -d "K" -f 1 | cut -d "M" -f 1
#             Log To Console    ${output}
#             IF    ${output}==0
#                 ${count_filesize}=     Evaluate     ${count_filesize}+1
#                 Log To Console    ${count_filesize}
#             END
#         ELSE
#             ${count}=     Evaluate     ${count}+1
#             Continue For Loop
#     END
#     END
#     Log To Console    ${count}
#     Log To Console    ${count_filesize}
#     IF    ${count} > 0
#         Fail    file not found
#     ELSE IF     ${count_filesize}>0
#         Fail    file not found
#     ELSE
#         Pass Execution    file found
#     END

# Checking for cpuinfo file in server directory
#     [Documentation]       Checking for cpuinfo file and its size in /eniq/log/ddc_data/${hostname}/${date_dmy}/server directory
#     [Tags]                Server_Metrics
#     FOR    ${element}    IN    @{blade}
#         ${output}=    Execute Command   test -f /eniq/log/ddc_data/${element}/${date_dmy}/server/cpuinfo && echo "true"
#         Log To Console    ${output}
#         IF    '${output}' == 'true'
#             ${output}=     Execute Command   ls -lh /eniq/log/ddc_data/${element}/${date_dmy}/server/cpuinfo | awk '{print $5}' | cut -d "K" -f 1 | cut -d "M" -f 1
#             Log To Console    ${output}
#             IF    ${output}==0
#                 ${count_filesize}=     Evaluate     ${count_filesize}+1
#                 Log To Console    ${count_filesize}
#             END
#         ELSE
#             ${count}=     Evaluate     ${count}+1
#             Continue For Loop
#     END
#     END
#     Log To Console    ${count}
#     Log To Console    ${count_filesize}
#     IF    ${count} > 0
#         Fail    file not found
#     ELSE IF     ${count_filesize}>0
#         Fail    file not found
#     ELSE
#         Pass Execution    file found
#     END

Checking for cron.log file in server directory
    [Documentation]       Checking for cron.log file and its size in /eniq/log/ddc_data/${hostname}/${date_dmy}/server directory
    [Tags]                Server_Metrics
    FOR    ${element}    IN    @{blade}
        ${output}=    Execute Command   test -f /eniq/log/ddc_data/${element}/${date_dmy}/server/cron.log && echo "true"
        Log To Console    ${output}
        IF    '${output}' == 'true'
            ${output}=     Execute Command   ls -lh /eniq/log/ddc_data/${element}/${date_dmy}/server/cron.log | awk '{print $5}' | cut -d "K" -f 1 | cut -d "M" -f 1
            Log To Console    ${output}
            IF    ${output}==0
                ${count_filesize}=     Evaluate     ${count_filesize}+1
                Log To Console    ${count_filesize}
            END
        ELSE
            ${count}=     Evaluate     ${count}+1
            Continue For Loop
    END
    END
    Log To Console    ${count}
    Log To Console    ${count_filesize}
    IF    ${count} > 0
        Fail    file not found
    ELSE IF     ${count_filesize}>0
        Fail    file not found
    ELSE
        Pass Execution    file found
    END

# Checking for ddc.log file in server directory
#     [Documentation]       Checking for ddc.log file and its size in /eniq/log/ddc_data/${hostname}/${date_dmy}/server directory
#     [Tags]                Server_Metrics
#     FOR    ${element}    IN    @{blade}
#         ${output}=    Execute Command   test -f /eniq/log/ddc_data/${element}/${date_dmy}/server/ddc.log && echo "true"
#         Log To Console    ${output}
#         IF    '${output}' == 'true'
#             ${output}=     Execute Command   ls -lh /eniq/log/ddc_data/${element}/${date_dmy}/server/ddc.log | awk '{print $5}' | cut -d "K" -f 1 | cut -d "M" -f 1
#             Log To Console    ${output}
#             IF    ${output}==0
#                 ${count_filesize}=     Evaluate     ${count_filesize}+1
#                 Log To Console    ${count_filesize}
#             END
#         ELSE
#             ${count}=     Evaluate     ${count}+1
#             Continue For Loop
#     END
#     END
#     Log To Console    ${count}
#     Log To Console    ${count_filesize}
#     IF    ${count} > 0
#         Fail    file not found
#     ELSE IF     ${count_filesize}>0
#         Fail    file not found
#     ELSE
#         Pass Execution    file found
#     END

Checking for df.txt file in server directory
    [Documentation]       Checking for df.txt file and its size in /eniq/log/ddc_data/${hostname}/${date_dmy}/server directory
    [Tags]                Server_Metrics
    FOR    ${element}    IN    @{blade}
        ${output}=    Execute Command   test -f /eniq/log/ddc_data/${element}/${date_dmy}/server/df.txt && echo "true"
        Log To Console    ${output}
        IF    '${output}' == 'true'
            ${output}=     Execute Command   ls -lh /eniq/log/ddc_data/${element}/${date_dmy}/server/df.txt | awk '{print $5}' | cut -d "K" -f 1 | cut -d "M" -f 1
            Log To Console    ${output}
            IF    ${output}==0
                ${count_filesize}=     Evaluate     ${count_filesize}+1
                Log To Console    ${count_filesize}
            END
        ELSE
            ${count}=     Evaluate     ${count}+1
            Continue For Loop
    END
    END
    Log To Console    ${count}
    Log To Console    ${count_filesize}
    IF    ${count} > 0
        Fail    file not found
    ELSE IF     ${count_filesize}>0
        Fail    file not found
    ELSE
        Pass Execution    file found
    END

Checking for dmidecode.txt file in server directory
    [Documentation]       Checking for dmidecode.txt file and its size in /eniq/log/ddc_data/${hostname}/${date_dmy}/server directory
    [Tags]                Server_Metrics
    FOR    ${element}    IN    @{blade}
        ${output}=    Execute Command   test -f /eniq/log/ddc_data/${element}/${date_dmy}/server/dmidecode.txt && echo "true"
        Log To Console    ${output}
        IF    '${output}' == 'true'
            ${output}=     Execute Command   ls -lh /eniq/log/ddc_data/${element}/${date_dmy}/server/dmidecode.txt | awk '{print $5}' | cut -d "K" -f 1 | cut -d "M" -f 1
            Log To Console    ${output}
            IF    ${output}==0
                ${count_filesize}=     Evaluate     ${count_filesize}+1
                Log To Console    ${count_filesize}
            END
        ELSE
            ${count}=     Evaluate     ${count}+1
            Continue For Loop
    END
    END
    Log To Console    ${count}
    Log To Console    ${count_filesize}
    IF    ${count} > 0
        Fail    file not found
    ELSE IF     ${count_filesize}>0
        Fail    file not found
    ELSE
        Pass Execution    file found
    END

Checking for dmsetup.txt file in server directory
    [Documentation]       Checking for dmsetup.txt file and its size in /eniq/log/ddc_data/${hostname}/${date_dmy}/server directory
    [Tags]                Server_Metrics
    FOR    ${element}    IN    @{blade}
        ${output}=    Execute Command   test -f /eniq/log/ddc_data/${element}/${date_dmy}/server/dmsetup.txt && echo "true"
        Log To Console    ${output}
        IF    '${output}' == 'true'
            ${output}=     Execute Command   ls -lh /eniq/log/ddc_data/${element}/${date_dmy}/server/dmsetup.txt | awk '{print $5}' | cut -d "K" -f 1 | cut -d "M" -f 1
            Log To Console    ${output}
            IF    ${output}==0
                ${count_filesize}=     Evaluate     ${count_filesize}+1
                Log To Console    ${count_filesize}
            END
        ELSE
            ${count}=     Evaluate     ${count}+1
            Continue For Loop
    END
    END
    Log To Console    ${count}
    Log To Console    ${count_filesize}
    IF    ${count} > 0
        Fail    file not found
    ELSE IF     ${count_filesize}>0
        Fail    file not found
    ELSE
        Pass Execution    file found
    END

Checking for ERICddccore.rpminfo file in server directory
    [Documentation]       Checking for ERICddccore.rpminfo file and its size in /eniq/log/ddc_data/${hostname}/${date_dmy}/server directory
    [Tags]                Server_Metrics
    FOR    ${element}    IN    @{blade}
        ${output}=    Execute Command   test -f /eniq/log/ddc_data/${element}/${date_dmy}/server/ERICddccore.rpminfo && echo "true"
        Log To Console    ${output}
        IF    '${output}' == 'true'
            ${output}=     Execute Command   ls -lh /eniq/log/ddc_data/${element}/${date_dmy}/server/ERICddccore.rpminfo | awk '{print $5}' | cut -d "K" -f 1 | cut -d "M" -f 1
            Log To Console    ${output}
            IF    ${output}==0
                ${count_filesize}=     Evaluate     ${count_filesize}+1
                Log To Console    ${count_filesize}
            END
        ELSE
            ${count}=     Evaluate     ${count}+1
            Continue For Loop
    END
    END
    Log To Console    ${count}
    Log To Console    ${count_filesize}
    IF    ${count} > 0
        Fail    file not found
    ELSE IF     ${count_filesize}>0
        Fail    file not found
    ELSE
        Pass Execution    file found
    END

Checking for hostname file in server directory
    [Documentation]       Checking for hostname file and its size in /eniq/log/ddc_data/${hostname}/${date_dmy}/server directory
    [Tags]                Server_Metrics
    FOR    ${element}    IN    @{blade}
        ${output}=    Execute Command   test -f /eniq/log/ddc_data/${element}/${date_dmy}/server/hostname && echo "true"
        Log To Console    ${output}
        IF    '${output}' == 'true'
            ${output}=     Execute Command   ls -lh /eniq/log/ddc_data/${element}/${date_dmy}/server/hostname | awk '{print $5}' | cut -d "K" -f 1 | cut -d "M" -f 1
            Log To Console    ${output}
            IF    ${output}==0
                ${count_filesize}=     Evaluate     ${count_filesize}+1
                Log To Console    ${count_filesize}
            END
        ELSE
            ${count}=     Evaluate     ${count}+1
            Continue For Loop
    END
    END
    Log To Console    ${count}
    Log To Console    ${count_filesize}
    IF    ${count} > 0
        Fail    file not found
    ELSE IF     ${count_filesize}>0
        Fail    file not found
    ELSE
        Pass Execution    file found
    END

Checking for ifconfig.txt file in server directory
    [Documentation]       Checking for ifconfig.txt file and its size in /eniq/log/ddc_data/${hostname}/${date_dmy}/server directory
    [Tags]                Server_Metrics
    FOR    ${element}    IN    @{blade}
        ${output}=    Execute Command   test -f /eniq/log/ddc_data/${element}/${date_dmy}/server/ifconfig.txt && echo "true"
        Log To Console    ${output}
        IF    '${output}' == 'true'
            ${output}=     Execute Command   ls -lh /eniq/log/ddc_data/${element}/${date_dmy}/server/ifconfig.txt | awk '{print $5}' | cut -d "K" -f 1 | cut -d "M" -f 1
            Log To Console    ${output}
            IF    ${output}==0
                ${count_filesize}=     Evaluate     ${count_filesize}+1
                Log To Console    ${count_filesize}
            END
        ELSE
            ${count}=     Evaluate     ${count}+1
            Continue For Loop
    END
    END
    Log To Console    ${count}
    Log To Console    ${count_filesize}
    IF    ${count} > 0
        Fail    file not found
    ELSE IF     ${count_filesize}>0
        Fail    file not found
    ELSE
        Pass Execution    file found
    END

Checking for iptables.txt file in server directory
    [Documentation]       Checking for iptables.txt file and its size in /eniq/log/ddc_data/${hostname}/${date_dmy}/server directory
    [Tags]                Server_Metrics
    FOR    ${element}    IN    @{blade}
        ${output}=    Execute Command   test -f /eniq/log/ddc_data/${element}/${date_dmy}/server/iptables.txt && echo "true"
        Log To Console    ${output}
        IF    '${output}' == 'true'
            ${output}=     Execute Command   ls -lh /eniq/log/ddc_data/${element}/${date_dmy}/server/iptables.txt | awk '{print $5}' | cut -d "K" -f 1 | cut -d "M" -f 1
            Log To Console    ${output}
            IF    ${output}==0
                ${count_filesize}=     Evaluate     ${count_filesize}+1
                Log To Console    ${count_filesize}
            END
        ELSE
            ${count}=     Evaluate     ${count}+1
            Continue For Loop
    END
    END
    Log To Console    ${count}
    Log To Console    ${count_filesize}
    IF    ${count} > 0
        Fail    file not found
    ELSE IF     ${count_filesize}>0
        Fail    file not found
    ELSE
        Pass Execution    file found
    END

Checking for jps.log file in server directory
    [Documentation]       Checking for jps.log file and its size in /eniq/log/ddc_data/${hostname}/${date_dmy}/server directory
    [Tags]                Server_Metrics
    FOR    ${element}    IN    @{blade}
        ${output}=    Execute Command   test -f /eniq/log/ddc_data/${element}/${date_dmy}/server/jps.log && echo "true"
        Log To Console    ${output}
        IF    '${output}' == 'true'
            ${output}=     Execute Command   ls -lh /eniq/log/ddc_data/${element}/${date_dmy}/server/jps.log | awk '{print $5}' | cut -d "K" -f 1 | cut -d "M" -f 1
            Log To Console    ${output}
            IF    ${output}==0
                ${count_filesize}=     Evaluate     ${count_filesize}+1
                Log To Console    ${count_filesize}
            END
        ELSE
            ${count}=     Evaluate     ${count}+1
            Continue For Loop
    END
    END
    Log To Console    ${count}
    Log To Console    ${count_filesize}
    IF    ${count} > 0
        Fail    file not found
    ELSE IF     ${count_filesize}>0
        Fail    file not found
    ELSE
        Pass Execution    file found
    END

Checking for lastlog file in server directory
    [Documentation]       Checking for lastlog file and its size in /eniq/log/ddc_data/${hostname}/${date_dmy}/server directory
    [Tags]                Server_Metrics
    FOR    ${element}    IN    @{blade}
        ${output}=    Execute Command   test -f /eniq/log/ddc_data/${element}/${date_dmy}/server/lastlog && echo "true"
        Log To Console    ${output}
        IF    '${output}' == 'true'
            ${output}=     Execute Command   ls -lh /eniq/log/ddc_data/${element}/${date_dmy}/server/lastlog | awk '{print $5}' | cut -d "K" -f 1 | cut -d "M" -f 1
            Log To Console    ${output}
            IF    ${output}==0
                ${count_filesize}=     Evaluate     ${count_filesize}+1
                Log To Console    ${count_filesize}
            END
        ELSE
            ${count}=     Evaluate     ${count}+1
            Continue For Loop
    END
    END
    Log To Console    ${count}
    Log To Console    ${count_filesize}
    IF    ${count} > 0
        Fail    file not found
    ELSE IF     ${count_filesize}>0
        Fail    file not found
    ELSE
        Pass Execution    file found
    END

Checking for last.txt file in server directory
    [Documentation]       Checking for last.txt file and its size in /eniq/log/ddc_data/${hostname}/${date_dmy}/server directory
    [Tags]                Server_Metrics
    FOR    ${element}    IN    @{blade}
        ${output}=    Execute Command   test -f /eniq/log/ddc_data/${element}/${date_dmy}/server/last.txt && echo "true"
        Log To Console    ${output}
        IF    '${output}' == 'true'
            ${output}=     Execute Command   ls -lh /eniq/log/ddc_data/${element}/${date_dmy}/server/last.txt | awk '{print $5}' | cut -d "K" -f 1 | cut -d "M" -f 1
            Log To Console    ${output}
            IF    ${output}==0
                ${count_filesize}=     Evaluate     ${count_filesize}+1
                Log To Console    ${count_filesize}
            END
        ELSE
            ${count}=     Evaluate     ${count}+1
            Continue For Loop
    END
    END
    Log To Console    ${count}
    Log To Console    ${count_filesize}
    IF    ${count} > 0
        Fail    file not found
    ELSE IF     ${count_filesize}>0
        Fail    file not found
    ELSE
        Pass Execution    file found
    END

# Checking for lvs.txt file in server directory
#     [Documentation]       Checking for lvs.txt file and its size in /eniq/log/ddc_data/${hostname}/${date_dmy}/server directory
#     [Tags]                Server_Metrics
#     FOR    ${element}    IN    @{blade}
#         ${output}=    Execute Command   test -f /eniq/log/ddc_data/${element}/${date_dmy}/server/lvs.txt && echo "true"
#         Log To Console    ${output}
#         IF    '${output}' == 'true'
#             ${output}=     Execute Command   ls -lh /eniq/log/ddc_data/${element}/${date_dmy}/server/lvs.txt | awk '{print $5}' | cut -d "K" -f 1 | cut -d "M" -f 1
#             Log To Console    ${output}
#             IF    ${output}==0
#                 ${count_filesize}=     Evaluate     ${count_filesize}+1
#                 Log To Console    ${count_filesize}
#             END
#         ELSE
#             ${count}=     Evaluate     ${count}+1
#             Continue For Loop
#     END
#     END
#     Log To Console    ${count}
#     Log To Console    ${count_filesize}
#     IF    ${count} > 0
#         Fail    file not found
#     ELSE IF     ${count_filesize}>0
#         Fail    file not found
#     ELSE
#         Pass Execution    file found
#     END

Checking for meminfo file in server directory
    [Documentation]       Checking for meminfo file and its size in /eniq/log/ddc_data/${hostname}/${date_dmy}/server directory
    [Tags]                Server_Metrics
    FOR    ${element}    IN    @{blade}
        ${output}=    Execute Command   test -f /eniq/log/ddc_data/${element}/${date_dmy}/server/meminfo && echo "true"
        Log To Console    ${output}
        IF    '${output}' == 'true'
            ${output}=     Execute Command   ls -lh /eniq/log/ddc_data/${element}/${date_dmy}/server/meminfo | awk '{print $5}' | cut -d "K" -f 1 | cut -d "M" -f 1
            Log To Console    ${output}
            IF    ${output}==0
                ${count_filesize}=     Evaluate     ${count_filesize}+1
                Log To Console    ${count_filesize}
            END
        ELSE
            ${count}=     Evaluate     ${count}+1
            Continue For Loop
    END
    END
    Log To Console    ${count}
    Log To Console    ${count_filesize}
    IF    ${count} > 0
        Fail    file not found
    ELSE IF     ${count_filesize}>0
        Fail    file not found
    ELSE
        Pass Execution    file found
    END

Checking for messages file in server directory
    [Documentation]       Checking for messages file and its size in /eniq/log/ddc_data/${hostname}/${date_dmy}/server directory
    [Tags]                Server_Metrics
    FOR    ${element}    IN    @{blade}
        ${output}=    Execute Command   test -f /eniq/log/ddc_data/${element}/${date_dmy}/server/messages && echo "true"
        Log To Console    ${output}
        IF    '${output}' == 'true'
            ${output}=     Execute Command   ls -lh /eniq/log/ddc_data/${element}/${date_dmy}/server/messages | awk '{print $5}' | cut -d "K" -f 1 | cut -d "M" -f 1
            Log To Console    ${output}
            IF    ${output}==0
                ${count_filesize}=     Evaluate     ${count_filesize}+1
                Log To Console    ${count_filesize}
            END
        ELSE
            ${count}=     Evaluate     ${count}+1
            Continue For Loop
    END
    END
    Log To Console    ${count}
    Log To Console    ${count_filesize}
    IF    ${count} > 0
        Fail    file not found
    ELSE IF     ${count_filesize}>0
        Fail    file not found
    ELSE
        Pass Execution    file found
    END

Checking for multipath.txt file in server directory
    [Documentation]       Checking for multipath.txt file and its size in /eniq/log/ddc_data/${hostname}/${date_dmy}/server directory
    [Tags]                Server_Metrics
    FOR    ${element}    IN    @{blade}
        ${output}=    Execute Command   test -f /eniq/log/ddc_data/${element}/${date_dmy}/server/multipath.txt && echo "true"
        Log To Console    ${output}
        IF    '${output}' == 'true'
            ${output}=     Execute Command   ls -lh /eniq/log/ddc_data/${element}/${date_dmy}/server/multipath.txt | awk '{print $5}' | cut -d "K" -f 1 | cut -d "M" -f 1
            Log To Console    ${output}
            IF    ${output}==0
                ${count_filesize}=     Evaluate     ${count_filesize}+1
                Log To Console    ${count_filesize}
            END
        ELSE
            ${count}=     Evaluate     ${count}+1
            Continue For Loop
    END
    END
    Log To Console    ${count}
    Log To Console    ${count_filesize}
    IF    ${count} > 0
        Fail    file not found
    ELSE IF     ${count_filesize}>0
        Fail    file not found
    ELSE
        Pass Execution    file found
    END

# Checking for netstat_an.log file in server directory
#     [Documentation]       Checking for netstat_an.log file and its size in /eniq/log/ddc_data/${hostname}/${date_dmy}/server directory
#     [Tags]                Server_Metrics
#     FOR    ${element}    IN    @{blade}
#         ${output}=    Execute Command   test -f /eniq/log/ddc_data/${element}/${date_dmy}/server/netstat_an.log && echo "true"
#         Log To Console    ${output}
#         IF    '${output}' == 'true'
#             ${output}=     Execute Command   ls -lh /eniq/log/ddc_data/${element}/${date_dmy}/server/netstat_an.log | awk '{print $5}' | cut -d "K" -f 1 | cut -d "M" -f 1
#             Log To Console    ${output}
#             IF    ${output}==0
#                 ${count_filesize}=     Evaluate     ${count_filesize}+1
#                 Log To Console    ${count_filesize}
#             END
#         ELSE
#             ${count}=     Evaluate     ${count}+1
#             Continue For Loop
#     END
#     END
#     Log To Console    ${count}
#     Log To Console    ${count_filesize}
#     IF    ${count} > 0
#         Fail    file not found
#     ELSE IF     ${count_filesize}>0
#         Fail    file not found
#     ELSE
#         Pass Execution    file found
#     END

Checking for netstat_i.log file in server directory
    [Documentation]       Checking for netstat_i.log file and its size in /eniq/log/ddc_data/${hostname}/${date_dmy}/server directory
    [Tags]                Server_Metrics
    FOR    ${element}    IN    @{blade}
        ${output}=    Execute Command   test -f /eniq/log/ddc_data/${element}/${date_dmy}/server/netstat_i.log && echo "true"
        Log To Console    ${output}
        IF    '${output}' == 'true'
            ${output}=     Execute Command   ls -lh /eniq/log/ddc_data/${element}/${date_dmy}/server/netstat_i.log | awk '{print $5}' | cut -d "K" -f 1 | cut -d "M" -f 1
            Log To Console    ${output}
            IF    ${output}==0
                ${count_filesize}=     Evaluate     ${count_filesize}+1
                Log To Console    ${count_filesize}
            END
        ELSE
            ${count}=     Evaluate     ${count}+1
            Continue For Loop
    END
    END
    Log To Console    ${count}
    Log To Console    ${count_filesize}
    IF    ${count} > 0
        Fail    file not found
    ELSE IF     ${count_filesize}>0
        Fail    file not found
    ELSE
        Pass Execution    file found
    END

# Checking for nfsstat_m.txt file in server directory
#     [Documentation]       Checking for nfsstat_m.txt file and its size in /eniq/log/ddc_data/${hostname}/${date_dmy}/server directory
#     [Tags]                Server_Metrics
#     FOR    ${element}    IN    @{blade}
#         ${output}=    Execute Command   test -f /eniq/log/ddc_data/${element}/${date_dmy}/server/nfsstat_m.txt && echo "true"
#         Log To Console    ${output}
#         IF    '${output}' == 'true'
#             ${output}=     Execute Command   ls -lh /eniq/log/ddc_data/${element}/${date_dmy}/server/nfsstat_m.txt | awk '{print $5}' | cut -d "K" -f 1 | cut -d "M" -f 1
#             Log To Console    ${output}
#             IF    ${output}==0
#                 ${count_filesize}=     Evaluate     ${count_filesize}+1
#                 Log To Console    ${count_filesize}
#             END
#         ELSE
#             ${count}=     Evaluate     ${count}+1
#             Continue For Loop
#     END
#     END
#     Log To Console    ${count}
#     Log To Console    ${count_filesize}
#     IF    ${count} > 0
#         Fail    file not found
#     ELSE IF     ${count_filesize}>0
#         Fail    file not found
#     ELSE
#         Pass Execution    file found
#     END

Checking for nfsstat.txt file in server directory
    [Documentation]       Checking for nfsstat.txt file and its size in /eniq/log/ddc_data/${hostname}/${date_dmy}/server directory
    [Tags]                Server_Metrics
    FOR    ${element}    IN    @{blade}
        ${output}=    Execute Command   test -f /eniq/log/ddc_data/${element}/${date_dmy}/server/nfsstat.txt && echo "true"
        Log To Console    ${output}
        IF    '${output}' == 'true'
            ${output}=     Execute Command   ls -lh /eniq/log/ddc_data/${element}/${date_dmy}/server/nfsstat.txt | awk '{print $5}' | cut -d "K" -f 1 | cut -d "M" -f 1
            Log To Console    ${output}
            IF    ${output}==0
                ${count_filesize}=     Evaluate     ${count_filesize}+1
                Log To Console    ${count_filesize}
            END
        ELSE
            ${count}=     Evaluate     ${count}+1
            Continue For Loop
    END
    END
    Log To Console    ${count}
    Log To Console    ${count_filesize}
    IF    ${count} > 0
        Fail    file not found
    ELSE IF     ${count_filesize}>0
        Fail    file not found
    ELSE
        Pass Execution    file found
    END

Checking for pagesize file in server directory
    [Documentation]       Checking for pagesize file and its size in /eniq/log/ddc_data/${hostname}/${date_dmy}/server directory
    [Tags]                Server_Metrics
    FOR    ${element}    IN    @{blade}
        ${output}=    Execute Command   test -f /eniq/log/ddc_data/${element}/${date_dmy}/server/pagesize && echo "true"
        Log To Console    ${output}
        IF    '${output}' == 'true'
            ${output}=     Execute Command   ls -lh /eniq/log/ddc_data/${element}/${date_dmy}/server/pagesize | awk '{print $5}' | cut -d "K" -f 1 | cut -d "M" -f 1
            Log To Console    ${output}
            IF    ${output}==0
                ${count_filesize}=     Evaluate     ${count_filesize}+1
                Log To Console    ${count_filesize}
            END
        ELSE
            ${count}=     Evaluate     ${count}+1
            Continue For Loop
    END
    END
    Log To Console    ${count}
    Log To Console    ${count_filesize}
    IF    ${count} > 0
        Fail    file not found
    ELSE IF     ${count_filesize}>0
        Fail    file not found
    ELSE
        Pass Execution    file found
    END

Checking for partitions file in server directory
    [Documentation]       Checking for partitions file and its size in /eniq/log/ddc_data/${hostname}/${date_dmy}/server directory
    [Tags]                Server_Metrics
    FOR    ${element}    IN    @{blade}
        ${output}=    Execute Command   test -f /eniq/log/ddc_data/${element}/${date_dmy}/server/partitions && echo "true"
        Log To Console    ${output}
        IF    '${output}' == 'true'
            ${output}=     Execute Command   ls -lh /eniq/log/ddc_data/${element}/${date_dmy}/server/partitions | awk '{print $5}' | cut -d "K" -f 1 | cut -d "M" -f 1
            Log To Console    ${output}
            IF    ${output}==0
                ${count_filesize}=     Evaluate     ${count_filesize}+1
                Log To Console    ${count_filesize}
            END
        ELSE
            ${count}=     Evaluate     ${count}+1
            Continue For Loop
    END
    END
    Log To Console    ${count}
    Log To Console    ${count_filesize}
    IF    ${count} > 0
        Fail    file not found
    ELSE IF     ${count_filesize}>0
        Fail    file not found
    ELSE
        Pass Execution    file found
    END

Checking for pvs.txt file in server directory
    [Documentation]       Checking for pvs.txt file and its size in /eniq/log/ddc_data/${hostname}/${date_dmy}/server directory
    [Tags]                Server_Metrics
    FOR    ${element}    IN    @{blade}
        ${output}=    Execute Command   test -f /eniq/log/ddc_data/${element}/${date_dmy}/server/pvs.txt && echo "true"
        Log To Console    ${output}
        IF    '${output}' == 'true'
            ${output}=     Execute Command   ls -lh /eniq/log/ddc_data/${element}/${date_dmy}/server/pvs.txt | awk '{print $5}' | cut -d "K" -f 1 | cut -d "M" -f 1
            Log To Console    ${output}
            IF    ${output}==0
                ${count_filesize}=     Evaluate     ${count_filesize}+1
                Log To Console    ${count_filesize}
            END
        ELSE
            ${count}=     Evaluate     ${count}+1
            Continue For Loop
    END
    END
    Log To Console    ${count}
    Log To Console    ${count_filesize}
    IF    ${count} > 0
        Fail    file not found
    ELSE IF     ${count_filesize}>0
        Fail    file not found
    ELSE
        Pass Execution    file found
    END

# Checking for slabinfo file in server directory
#     [Documentation]       Checking for slabinfo file and its size in /eniq/log/ddc_data/${hostname}/${date_dmy}/server directory
#     [Tags]                Server_Metrics
#     FOR    ${element}    IN    @{blade}
#         ${output}=    Execute Command   test -f /eniq/log/ddc_data/${element}/${date_dmy}/server/slabinfo && echo "true"
#         Log To Console    ${output}
#         IF    '${output}' == 'true'
#             ${output}=     Execute Command   ls -lh /eniq/log/ddc_data/${element}/${date_dmy}/server/slabinfo | awk '{print $5}' | cut -d "K" -f 1 | cut -d "M" -f 1
#             Log To Console    ${output}
#             IF    ${output}==0
#                 ${count_filesize}=     Evaluate     ${count_filesize}+1
#                 Log To Console    ${count_filesize}
#             END
#         ELSE
#             ${count}=     Evaluate     ${count}+1
#             Continue For Loop
#     END
#     END
#     Log To Console    ${count}
#     Log To Console    ${count_filesize}
#     IF    ${count} > 0
#         Fail    file not found
#     ELSE IF     ${count_filesize}>0
#         Fail    file not found
#     ELSE
#         Pass Execution    file found
#     END

Checking for socket.log file in server directory
    [Documentation]       Checking for socket.log file and its size in /eniq/log/ddc_data/${hostname}/${date_dmy}/server directory
    [Tags]                Server_Metrics
    FOR    ${element}    IN    @{blade}
        ${output}=    Execute Command   test -f /eniq/log/ddc_data/${element}/${date_dmy}/server/socket.log && echo "true"
        Log To Console    ${output}
        IF    '${output}' == 'true'
            ${output}=     Execute Command   ls -lh /eniq/log/ddc_data/${element}/${date_dmy}/server/socket.log | awk '{print $5}' | cut -d "K" -f 1 | cut -d "M" -f 1
            Log To Console    ${output}
            IF    ${output}==0
                ${count_filesize}=     Evaluate     ${count_filesize}+1
                Log To Console    ${count_filesize}
            END
        ELSE
            ${count}=     Evaluate     ${count}+1
            Continue For Loop
    END
    END
    Log To Console    ${count}
    Log To Console    ${count_filesize}
    IF    ${count} > 0
        Fail    file not found
    ELSE IF     ${count_filesize}>0
        Fail    file not found
    ELSE
        Pass Execution    file found
    END

# Checking for ss.txt file in server directory
#     [Documentation]       Checking for ss.txt file and its size in /eniq/log/ddc_data/${hostname}/${date_dmy}/server directory
#     [Tags]                Server_Metrics
#     FOR    ${element}    IN    @{blade}
#         ${output}=    Execute Command   test -f /eniq/log/ddc_data/${element}/${date_dmy}/server/ss.txt && echo "true"
#         Log To Console    ${output}
#         IF    '${output}' == 'true'
#             ${output}=     Execute Command   ls -lh /eniq/log/ddc_data/${element}/${date_dmy}/server/ss.txt | awk '{print $5}' | cut -d "K" -f 1 | cut -d "M" -f 1
#             Log To Console    ${output}
#             IF    ${output}==0
#                 ${count_filesize}=     Evaluate     ${count_filesize}+1
#                 Log To Console    ${count_filesize}
#             END
#         ELSE
#             ${count}=     Evaluate     ${count}+1
#             Continue For Loop
#     END
#     END
#     Log To Console    ${count}
#     Log To Console    ${count_filesize}
#     IF    ${count} > 0
#         Fail    file not found
#     ELSE IF     ${count_filesize}>0
#         Fail    file not found
#     ELSE
#         Pass Execution    file found
#     END

Checking for tz.txt file in server directory
    [Documentation]       Checking for tz.txt file and its size in /eniq/log/ddc_data/${hostname}/${date_dmy}/server directory
    [Tags]                Server_Metrics
    FOR    ${element}    IN    @{blade}
        ${output}=    Execute Command   test -f /eniq/log/ddc_data/${element}/${date_dmy}/server/tz.txt && echo "true"
        Log To Console    ${output}
        IF    '${output}' == 'true'
            ${output}=     Execute Command   ls -lh /eniq/log/ddc_data/${element}/${date_dmy}/server/tz.txt | awk '{print $5}' | cut -d "K" -f 1 | cut -d "M" -f 1
            Log To Console    ${output}
            IF    ${output}==0
                ${count_filesize}=     Evaluate     ${count_filesize}+1
                Log To Console    ${count_filesize}
            END
        ELSE
            ${count}=     Evaluate     ${count}+1
            Continue For Loop
    END
    END
    Log To Console    ${count}
    Log To Console    ${count_filesize}
    IF    ${count} > 0
        Fail    file not found
    ELSE IF     ${count_filesize}>0
        Fail    file not found
    ELSE
        Pass Execution    file found
    END

Checking for uptime.txt file in server directory
    [Documentation]       Checking for uptime.txt file and its size in /eniq/log/ddc_data/${hostname}/${date_dmy}/server directory
    [Tags]                Server_Metrics
    FOR    ${element}    IN    @{blade}
        ${output}=    Execute Command   test -f /eniq/log/ddc_data/${element}/${date_dmy}/server/uptime.txt && echo "true"
        Log To Console    ${output}
        IF    '${output}' == 'true'
            ${output}=     Execute Command   ls -lh /eniq/log/ddc_data/${element}/${date_dmy}/server/uptime.txt | awk '{print $5}' | cut -d "K" -f 1 | cut -d "M" -f 1
            Log To Console    ${output}
            IF    ${output}==0
                ${count_filesize}=     Evaluate     ${count_filesize}+1
                Log To Console    ${count_filesize}
            END
        ELSE
            ${count}=     Evaluate     ${count}+1
            Continue For Loop
    END
    END
    Log To Console    ${count}
    Log To Console    ${count_filesize}
    IF    ${count} > 0
        Fail    file not found
    ELSE IF     ${count_filesize}>0
        Fail    file not found
    ELSE
        Pass Execution    file found
    END

# Checking for virtwhat.txt file in server directory
#     [Documentation]       Checking for virtwhat.txt file and its size in /eniq/log/ddc_data/${hostname}/${date_dmy}/server directory
#     [Tags]                Server_Metrics
#     FOR    ${element}    IN    @{blade}
#         ${output}=    Execute Command   test -f /eniq/log/ddc_data/${element}/${date_dmy}/server/virtwhat.txt && echo "true"
#         Log To Console    ${output}
#         IF    '${output}' == 'true'
#             ${output}=     Execute Command   ls -lh /eniq/log/ddc_data/${element}/${date_dmy}/server/virtwhat.txt | awk '{print $5}' | cut -d "K" -f 1 | cut -d "M" -f 1
#             Log To Console    ${output}
#             IF    ${output}==0
#                 ${count_filesize}=     Evaluate     ${count_filesize}+1
#                 Log To Console    ${count_filesize}
#             END
#         ELSE
#             ${count}=     Evaluate     ${count}+1
#             Continue For Loop
#     END
#     END
#     Log To Console    ${count}
#     Log To Console    ${count_filesize}
#     IF    ${count} > 0
#         Fail    file not found
#     ELSE IF     ${count_filesize}>0
#         Fail    file not found
#     ELSE
#         Pass Execution    file found
#     END

Checking for sar.incr file in server directory
    [Documentation]       Checking for sar.incr file and its size in /eniq/log/ddc_data/${hostname}/${date_dmy}/server directory
    [Tags]                Server_Metrics
    FOR    ${element}    IN    @{blade}
        ${output}=    Execute Command   test -f /eniq/log/ddc_data/${element}/${date_dmy}/server/sar.incr && echo "true"
        Log To Console    ${output}
        IF    '${output}' == 'true'
            ${output}=     Execute Command   ls -lh /eniq/log/ddc_data/${element}/${date_dmy}/server/sar.incr | awk '{print $5}' | cut -d "K" -f 1 | cut -d "M" -f 1
            Log To Console    ${output}
            IF    ${output}==0
                ${count_filesize}=     Evaluate     ${count_filesize}+1
                Log To Console    ${count_filesize}
            END
        ELSE
            ${count}=     Evaluate     ${count}+1
            Continue For Loop
    END
    END
    Log To Console    ${count}
    Log To Console    ${count_filesize}
    IF    ${count} > 0
        Fail    file not found
    ELSE IF     ${count_filesize}>0
        Fail    file not found
    ELSE
        Pass Execution    file found
    END

Checking for sar_incr file in server directory
    [Documentation]       Checking for sar_incr file and its size in /eniq/log/ddc_data/${hostname}/${date_dmy}/server directory
    [Tags]                Server_Metrics
    FOR    ${element}    IN    @{blade}
        ${sar_incr}=           Execute Command    cat /eniq/log/ddc_data/${hostname}/${date_dmy}/server/sar.incr | cut -d "@" -f 1
        Set Global Variable    ${sar_incr}
        ${output}=    Execute Command   test -f /eniq/log/ddc_data/${element}/${date_dmy}/server/sar.${sar_incr} && echo "true"
        Log To Console    ${output}
        IF    '${output}' == 'true'
            ${output}=     Execute Command   ls -lh /eniq/log/ddc_data/${element}/${date_dmy}/server/sar.${sar_incr} | awk '{print $5}' | cut -d "K" -f 1 | cut -d "M" -f 1
            Log To Console    ${output}
            IF    ${output}==0
                ${count_filesize}=     Evaluate     ${count_filesize}+1
                Log To Console    ${count_filesize}
            END
        ELSE
            ${count}=     Evaluate     ${count}+1
            Continue For Loop
    END
    END
    Log To Console    ${count}
    Log To Console    ${count_filesize}
    IF    ${count} > 0
        Fail    file not found
    ELSE IF     ${count_filesize}>0
        Fail    file not found
    ELSE
        Pass Execution    file found
    END



