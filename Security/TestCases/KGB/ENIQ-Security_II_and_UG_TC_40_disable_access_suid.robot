*** Settings ***
Suite Setup        Open Connection and SSH Login
Suite Teardown     Close All Connections

Resource           ../../Resources/cTAF_resource.resource

Library            SSHLibrary  10 seconds
Library            OperatingSystem
Library            String
Library            ../Scripts/eniq_scurity_core.py
Library            Collections
*** Variables ***
@{List_per}=    /usr/lib/polkit-1/polkit-agent-helper-1    /usr/sbin/usernetctl    /usr/sbin/pam_timestamp_check    /usr/sbin/mount.nfs    /usr/sbin/userhelper    /usr/sbin/unix_chkpwd    /usr/bin/chsh    /usr/bin/chfn    /usr/bin/crontab    /usr/bin/gpasswd    /usr/bin/sudo    /usr/bin/chage    /usr/bin/pkexec    /usr/bin/su    /usr/bin/newgrp    /usr/libexec/dbus-1/dbus-daemon-launch-helper    /usr/bin/passwd    /usr/bin/mount    /usr/bin/umount    /usr/bin/staprun

${List_permission_count}=     ${1}
${command_permission_count}=     ${1}
${compare_count}=     ${1}

*** Test Cases ***
verify the access to the files with root suid isdisabled or not
    ${result}=     Execute Command    find / -perm -4000 2> /dev/null
    #### Command output list item
    @{Splitted_Values} =    Split String    ${result}    \n
    FOR    ${value}    IN    @{Splitted_Values}
        ${command_permission_count}=  evaluate  ${command_permission_count} + 1
    END
    
    ### Already list present
    FOR    ${value}    IN    @{List_per}
        ${List_permission_count}=  evaluate  ${List_permission_count} + 1
    END
    
    #### Compare list counter
    FOR    ${val}    IN    @{List_per}
        FOR    ${value}    IN    @{Splitted_Values}
            IF    '${value}' == '${val}'
                ${compare_count}=  evaluate  ${compare_count} + 1
            END
        END
    END