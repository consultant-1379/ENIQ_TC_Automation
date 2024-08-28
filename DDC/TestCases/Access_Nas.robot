*** Settings ***
Suite Setup        Open Connection And Log In
Suite Teardown     Close All Connections
Library            SSHLibrary
Library            DateTime
Library            DependencyLibrary
Library            String
Resource           ../Resources/Resource.resource


*** Test Cases ***
Checking for passwordless connectivity TC01
    [Documentation]        Checking for passwordless connectivity between ENIQ and NAS servers
    [Tags]                 Access_Nas
    ${nas_nodes}=          Execute Command    ls -lrt /eniq/log/ddc_data/${hostname}/${date_dmy}/remotehosts | awk '{print $9}' | tail -2
    Log    ${nas_nodes}
    ${count_nodes}=        Execute Command    ls /eniq/log/ddc_data/${hostname}/${date_dmy}/remotehosts | wc -l
    Should Be Equal As Strings    ${count_nodes}    2

Indentifing the master node TC02
    [Documentation]        Checking the Master node
    [Tags]                 Access_Nas
    ${master_node1}=          Execute Command     grep -w ManagementConsole /eniq/log/ddc_data/${hostname}/${date_dmy}/remotehosts/*1_ACCESSNAS/server/hastatus_sum.txt | grep ONLINE | awk '{print $3}' | cut -d'_' -f 2- | tail -n 2
    Log    ${master_node1}
    Set Global Variable    ${master_node1}
    ${master_node2}=          Execute Command     grep -w ManagementConsole /eniq/log/ddc_data/${hostname}/${date_dmy}/remotehosts/*2_ACCESSNAS/server/hastatus_sum.txt | grep ONLINE | awk '{print $3}' | cut -d'_' -f 2- | tail -n 2
    Log    ${master_node2}
    Set Global Variable    ${master_node2}
    ${output}=      Run Keyword And Return Status     Should Be Equal    ${master_node1}    ${master_node2}
    Log     ${output}
    Set Global Variable    ${output}

Checking for ddc_sfs file in access_nas1 TC03
    Depends on test        Indentifing the master node TC02
    [Documentation]        Checking for ddc_sfs file in /eniq/log/ddc_data/${hostname}/${date_dmy}/remotehosts/*1_ACCESSNAS directory
    [Tags]                 Access_Nas
    IF    ${output} == True
        ${nas_path1}=          Execute Command     ls /eniq/log/ddc_data/${hostname}/${date_dmy}/remotehosts/*${master_node1}_ACCESSNAS/ddc_sfs
        Set Global variable    ${nas_path1}
        ${var}=    Run Keyword And Return Status    Check File Exists      ${nas_path1}
        IF    ${var} == True
            Check File Size        ${nas_path1}
        ELSE
            Fail     File not available.
        END
    END

Checking for physipaddr file in access_nas1 TC04
    Depends on test        Indentifing the master node TC02
    [Documentation]        Checking for physipaddr file in /eniq/log/ddc_data/${hostname}/${date_dmy}/remotehosts/*1_ACCESSNAS directory
    [Tags]                 Access_Nas
    IF    ${output} == True
        ${nas_path2}=          Execute Command     ls /eniq/log/ddc_data/${hostname}/${date_dmy}/remotehosts/*${master_node1}_ACCESSNAS/physipaddr
        Set Global variable    ${nas_path2}
        ${var}=    Run Keyword And Return Status    Check File Exists      ${nas_path2}
        IF    ${var} == True
            Check File Size        ${nas_path2}
        ELSE
            Fail    File not available.
        END
    END

Checking for ManagementConsole file in access_nas1 TC05
    Depends on test        Indentifing the master node TC02
    [Documentation]        Checking for ManagementConsole file in /eniq/log/ddc_data/${hostname}/${date_dmy}/remotehosts/*1_ACCESSNAS directory
    [Tags]                 Access_Nas
    IF    ${output} == True
        ${nas_path3}=          Execute Command     ls /eniq/log/ddc_data/${hostname}/${date_dmy}/remotehosts/*${master_node1}_ACCESSNAS/ManagementConsole
        Set Global variable    ${nas_path3}
        ${var}=    Run Keyword And Return Status    Check File Exists      ${nas_path3}
        IF    ${var} == True
            Check File Size Does Not Exists       ${nas_path3}
        ELSE
            Fail    File not available.
        END
    END

Checking for storage_fs_list file in access_nas1 TC06
    Depends on test        Indentifing the master node TC02
    [Documentation]        Checking for storage_fs_list file in /eniq/log/ddc_data/${hostname}/${date_dmy}/remotehosts/*1_ACCESSNAS directory
    [Tags]                 Access_Nas
    IF    ${output} == True
        ${nas_path4}=          Execute Command     ls /eniq/log/ddc_data/${hostname}/${date_dmy}/remotehosts/*${master_node1}_ACCESSNAS/storage_fs_list.txt
        Set Global variable    ${nas_path4}
        ${var}=    Run Keyword And Return Status    Check File Exists      ${nas_path4}
        IF    ${var} == True
            Check File Size        ${nas_path4}
        ELSE
            Fail     File not available.
        END
    END

Checking for storage_disk_list file in access_nas1 TC07
    Depends on test        Indentifing the master node TC02
    [Documentation]        Checking for storage_disk_list file in /eniq/log/ddc_data/${hostname}/${date_dmy}/remotehosts/*1_ACCESSNAS directory
    [Tags]                 Access_Nas
    IF    ${output} == True
        ${nas_path5}=          Execute Command     ls /eniq/log/ddc_data/${hostname}/${date_dmy}/remotehosts/*${master_node1}_ACCESSNAS/storage_disk_list.txt
        Set Global variable    ${nas_path5}
        ${var}=    Run Keyword And Return Status    Check File Exists      ${nas_path5}
        IF    ${var} == True
            Check File Size        ${nas_path5}
        ELSE
            Fail     File not available.
        END
    END

Checking for network_ip_addr file in access_nas1 TC08
    Depends on test        Indentifing the master node TC02
    [Documentation]        Checking for network_ip_addr file in /eniq/log/ddc_data/${hostname}/${date_dmy}/remotehosts/*1_ACCESSNAS directory
    [Tags]                 Access_Nas
    IF    ${output} == True
        ${nas_path6}=          Execute Command     ls /eniq/log/ddc_data/${hostname}/${date_dmy}/remotehosts/*${master_node1}_ACCESSNAS/network_ip_addr.txt
        Set Global variable    ${nas_path6}
        ${var}=    Run Keyword And Return Status    Check File Exists      ${nas_path6}
        IF    ${var} == True
            Check File Size        ${nas_path6}
        ELSE
            Fail     File not available.
        END
    END

Checking for NAS_Audit file in access_nas1 TC09
    Depends on test        Indentifing the master node TC02
    [Documentation]        Checking for NAS_Audit file in /eniq/log/ddc_data/${hostname}/${date_dmy}/remotehosts/*1_ACCESSNAS directory
    [Tags]                 Access_Nas
    IF    ${output} == True
        ${nas_path7}=          Execute Command     ls /eniq/log/ddc_data/${hostname}/${date_dmy}/remotehosts/*${master_node1}_ACCESSNAS/NAS_Audit_*.html | tail -1
        Set Global variable    ${nas_path7}
        ${var}=    Run Keyword And Return Status    Check File Exists      ${nas_path7}
        IF    ${var} == True
            Check File Size        ${nas_path7}
        ELSE
            ${date_ymd} =    Execute Command    date +%Y%m%d
            Set Global Variable    ${date_ymd}
            Execute Write Command     su - storadm
            Execute Write Command      ssh support@nasconsole
            ${audit_file}=     Execute Write Command    ls -lrth /home/support/audit_report/ | grep -i '\\bNAS_Audit_*.*${date_ymd}*.*html\\b' | tail -1
            ${output_nas}=    Get Regexp Matches    ${audit_file}      NAS_Audit_\\S+${date_ymd}\\S+.html
            Should Not Be Empty    ${output_nas}
            Log    ${output_nas}
        END
    END

Checking for hostname file in access_nas1 TC10
    Depends on test        Indentifing the master node TC02
    [Documentation]        Checking for hostname file in /eniq/log/ddc_data/${hostname}/${date_dmy}/remotehosts/*1_ACCESSNAS directory
    [Tags]                 Access_Nas
    IF    ${output} == True
        ${nas_path8}=          Execute Command     ls /eniq/log/ddc_data/${hostname}/${date_dmy}/remotehosts/*${master_node1}_ACCESSNAS/server/hostname
        Set Global variable    ${nas_path8}
        ${var}=    Run Keyword And Return Status    Check File Exists      ${nas_path8}
        IF    ${var} == True
            Check File Size        ${nas_path8}
        ELSE
            Fail     File not available.
        END
    END

Checking for sar file in access_nas1 TC11
    [Documentation]        Checking for sar file in /eniq/log/ddc_data/${hostname}/${date_dmy}/remotehosts/*1_ACCESSNAS directory
    [Tags]                 Access_Nas
    IF    ${output} == True
        ${nas_path9}=          Execute Command     ls /eniq/log/ddc_data/${hostname}/${date_dmy}/remotehosts/*${master_node1}_ACCESSNAS/server/sar.txt
        Set Global variable    ${nas_path9}
        ${var}=    Run Keyword And Return Status    Check File Exists      ${nas_path9}
        IF    ${var} == True
            Check File Size        ${nas_path9}
        ELSE
            Log     File not available.
        END
    END

Checking for df file in access_nas1 TC12
    [Documentation]        Checking for df file in /eniq/log/ddc_data/${hostname}/${date_dmy}/remotehosts/*1_ACCESSNAS directory
    [Tags]                 Access_Nas
    IF    ${output} == True
        ${nas_path10}=          Execute Command     ls /eniq/log/ddc_data/${hostname}/${date_dmy}/remotehosts/*${master_node1}_ACCESSNAS/server/df.txt
        Set Global variable    ${nas_path10}
        ${var}=    Run Keyword And Return Status    Check File Exists      ${nas_path10}
        IF    ${var} == True
            Check File Size        ${nas_path10}
        ELSE
            Log     File not available.
        END
    END

Checking for mtab file in access_nas1 TC13
    [Documentation]        Checking for mtab file in /eniq/log/ddc_data/${hostname}/${date_dmy}/remotehosts/*1_ACCESSNAS directory
    [Tags]                 Access_Nas
    IF    ${output} == True
        ${nas_path11}=          Execute Command     ls /eniq/log/ddc_data/${hostname}/${date_dmy}/remotehosts/*${master_node1}_ACCESSNAS/server/mtab
        Set Global variable    ${nas_path11}
        ${var}=    Run Keyword And Return Status    Check File Exists      ${nas_path11}
        IF    ${var} == True
            Check File Size        ${nas_path11}
        ELSE
            Log     File not available.
        END
    END

Checking for ip_link file in access_nas1 TC14
    [Documentation]        Checking for ip_link.txt file in /eniq/log/ddc_data/${hostname}/${date_dmy}/remotehosts/*1_ACCESSNAS directory
    [Tags]                 Access_Nas
    IF    ${output} == True
        ${nas_path12}=          Execute Command     ls /eniq/log/ddc_data/${hostname}/${date_dmy}/remotehosts/*${master_node1}_ACCESSNAS/server/ip_link.txt
        Set Global variable    ${nas_path12}
        ${var}=    Run Keyword And Return Status    Check File Exists      ${nas_path12}
        IF    ${var} == True
            Check File Size        ${nas_path12}
        ELSE
            Log     File not available.
        END
    END

Checking for showmount file in access_nas1 TC15
    [Documentation]        Checking for showmount.txt file in /eniq/log/ddc_data/${hostname}/${date_dmy}/remotehosts/*1_ACCESSNAS directory
    [Tags]                 Access_Nas
    IF    ${output} == True
        ${nas_path13}=          Execute Command     ls /eniq/log/ddc_data/${hostname}/${date_dmy}/remotehosts/*${master_node1}_ACCESSNAS/server/showmount.txt
        Set Global variable    ${nas_path13}
        ${var}=    Run Keyword And Return Status    Check File Exists      ${nas_path13}
        IF    ${var} == True
            Check File Size        ${nas_path13}
        ELSE
            Log     File not available.
        END
    END

Checking for netstat file in access_nas1 TC16
    [Documentation]        Checking for netstat.txt file in /eniq/log/ddc_data/${hostname}/${date_dmy}/remotehosts/*1_ACCESSNAS directory
    [Tags]                 Access_Nas
    IF    ${output} == True
        ${nas_path14}=          Execute Command     ls /eniq/log/ddc_data/${hostname}/${date_dmy}/remotehosts/*${master_node1}_ACCESSNAS/server/netstat.txt
        Set Global variable    ${nas_path14}
        ${var}=    Run Keyword And Return Status    Check File Exists      ${nas_path14}
        IF    ${var} == True
            Check File Size        ${nas_path14}
        ELSE
            Log     File not available.
        END
    END

Checking for ps file in access_nas1 TC17
    [Documentation]        Checking for ps.txt file in /eniq/log/ddc_data/${hostname}/${date_dmy}/remotehosts/*1_ACCESSNAS directory
    [Tags]                 Access_Nas
    IF    ${output} == True
        ${nas_path15}=          Execute Command     ls /eniq/log/ddc_data/${hostname}/${date_dmy}/remotehosts/*${master_node1}_ACCESSNAS/server/ps.txt
        Set Global variable    ${nas_path15}
        ${var}=    Run Keyword And Return Status    Check File Exists      ${nas_path15}
        IF    ${var} == True
            Check File Size        ${nas_path15}
        ELSE
            Log     File not available.
        END
    END

Checking for df_i file in access_nas1 TC18
    [Documentation]        Checking for df_i.txt file in /eniq/log/ddc_data/${hostname}/${date_dmy}/remotehosts/*1_ACCESSNAS directory
    [Tags]                 Access_Nas
    IF    ${output} == True
        ${nas_path16}=          Execute Command     ls /eniq/log/ddc_data/${hostname}/${date_dmy}/remotehosts/*${master_node1}_ACCESSNAS/server/df_i.txt
        Set Global variable    ${nas_path16}
        ${var}=    Run Keyword And Return Status    Check File Exists      ${nas_path16}
        IF    ${var} == True
            Check File Size        ${nas_path16}
        ELSE
            Log     File not available.
        END
    END

Checking for partitions file in access_nas1 TC19
    [Documentation]        Checking for partitions file in /eniq/log/ddc_data/${hostname}/${date_dmy}/remotehosts/*1_ACCESSNAS directory
    [Tags]                 Access_Nas
    IF    ${output} == True
        ${nas_path17}=          Execute Command     ls /eniq/log/ddc_data/${hostname}/${date_dmy}/remotehosts/*${master_node1}_ACCESSNAS/server/partitions
        Set Global variable    ${nas_path17}
        ${var}=    Run Keyword And Return Status    Check File Exists      ${nas_path17}
        IF    ${var} == True
            Check File Size        ${nas_path17}
        ELSE
            Log     File not available.
        END
    END

Checking for vxdisk_list file in access_nas1 TC20
    [Documentation]        Checking for vxdisk_list.txt file in /eniq/log/ddc_data/${hostname}/${date_dmy}/remotehosts/*1_ACCESSNAS directory
    [Tags]                 Access_Nas
    IF    ${output} == True
        ${nas_path18}=          Execute Command     ls /eniq/log/ddc_data/${hostname}/${date_dmy}/remotehosts/*${master_node1}_ACCESSNAS/server/vxdisk_list.txt
        Set Global variable    ${nas_path18}
        ${var}=    Run Keyword And Return Status    Check File Exists      ${nas_path18}
        IF    ${var} == True
            Check File Size        ${nas_path18}
        ELSE
            Log     File not available.
        END
    END

Checking for vxdmpadm file in access_nas1 TC21
    [Documentation]        Checking for vxdmpadm file in /eniq/log/ddc_data/${hostname}/${date_dmy}/remotehosts/*1_ACCESSNAS directory
    [Tags]                 Access_Nas
    IF    ${output} == True
        ${nas_path19}=          Execute Command     ls /eniq/log/ddc_data/${hostname}/${date_dmy}/remotehosts/*${master_node1}_ACCESSNAS/server/vxdmpadm* | tail -1
        Set Global variable    ${nas_path19}
        ${var}=    Run Keyword And Return Status    Check File Exists      ${nas_path19}
        IF    ${var} == True
            Check File Size        ${nas_path19}
        ELSE
            Log     File not available.
        END
    END

Checking for hastatus_sum file in access_nas1 TC22
    [Documentation]        Checking for hastatus_sum.txt file in /eniq/log/ddc_data/${hostname}/${date_dmy}/remotehosts/*1_ACCESSNAS directory
    [Tags]                 Access_Nas
    IF    ${output} == True
        ${nas_path20}=          Execute Command     ls /eniq/log/ddc_data/${hostname}/${date_dmy}/remotehosts/*${master_node1}_ACCESSNAS/server/hastatus_sum.txt
        Set Global variable    ${nas_path20}
        ${var}=    Run Keyword And Return Status    Check File Exists      ${nas_path20}
        IF    ${var} == True
            Check File Size        ${nas_path20}
        ELSE
            Log     File not available.
        END
    END

Checking for ifconfig file in access_nas1 TC23
    [Documentation]        Checking for ifconfig.txt file in /eniq/log/ddc_data/${hostname}/${date_dmy}/remotehosts/*1_ACCESSNAS directory
    [Tags]                 Access_Nas
    IF    ${output} == True
        ${nas_path21}=          Execute Command     ls /eniq/log/ddc_data/${hostname}/${date_dmy}/remotehosts/*${master_node1}_ACCESSNAS/server/ifconfig.txt
        Set Global variable    ${nas_path21}
        ${var}=    Run Keyword And Return Status    Check File Exists      ${nas_path21}
        IF    ${var} == True
            Check File Size        ${nas_path21}
        ELSE
            Log     File not available.
        END
    END

Checking for nfsd file in access_nas1 TC24
    [Documentation]        Checking for nfsd file in /eniq/log/ddc_data/${hostname}/${date_dmy}/remotehosts/*1_ACCESSNAS directory
    [Tags]                 Access_Nas
    IF    ${output} == True
        ${nas_path22}=          Execute Command     ls /eniq/log/ddc_data/${hostname}/${date_dmy}/remotehosts/*${master_node1}_ACCESSNAS/server/nfsd
        Set Global variable    ${nas_path22}
        ${var}=    Run Keyword And Return Status    Check File Exists      ${nas_path22}
        IF    ${var} == True
            Check File Size        ${nas_path22}
        ELSE
            Log     File not available.
        END
    END

Checking for pool_stats file in access_nas1 TC25
    [Documentation]        Checking for pool_stats file in /eniq/log/ddc_data/${hostname}/${date_dmy}/remotehosts/*1_ACCESSNAS directory
    [Tags]                 Access_Nas
    IF    ${output} == True
        ${nas_path23}=          Execute Command     ls /eniq/log/ddc_data/${hostname}/${date_dmy}/remotehosts/*${master_node1}_ACCESSNAS/server/pool_stats
        Set Global variable    ${nas_path23}
        ${var}=    Run Keyword And Return Status    Check File Exists      ${nas_path23}
        IF    ${var} == True
            Check File Size        ${nas_path23}
        ELSE
            Log     File not available.
        END
    END

Checking for meminfo file in access_nas1 TC26
    [Documentation]        Checking for meminfo file in /eniq/log/ddc_data/${hostname}/${date_dmy}/remotehosts/*1_ACCESSNAS directory
    [Tags]                 Access_Nas
    IF    ${output} == True
        ${nas_path24}=          Execute Command     ls /eniq/log/ddc_data/${hostname}/${date_dmy}/remotehosts/*${master_node1}_ACCESSNAS/server/meminfo
        Set Global variable    ${nas_path24}
        ${var}=    Run Keyword And Return Status    Check File Exists      ${nas_path24}
        IF    ${var} == True
            Check File Size        ${nas_path24}
        ELSE
            Log     File not available.
        END
    END

Checking for slabinfo file in access_nas1 TC27
    [Documentation]        Checking for slabinfo file in /eniq/log/ddc_data/${hostname}/${date_dmy}/remotehosts/*1_ACCESSNAS directory
    [Tags]                 Access_Nas
    IF    ${output} == True
        ${nas_path25}=          Execute Command     ls /eniq/log/ddc_data/${hostname}/${date_dmy}/remotehosts/*${master_node1}_ACCESSNAS/server/slabinfo
        Set Global variable    ${nas_path25}
        ${var}=    Run Keyword And Return Status    Check File Exists      ${nas_path25}
        IF    ${var} == True
            Check File Size        ${nas_path25}
        ELSE
            Log     File not available.
        END
    END

Checking for vxstat file in access_nas1 TC28
    [Documentation]        Checking for vxstat.txt file in /eniq/log/ddc_data/${hostname}/${date_dmy}/remotehosts/*1_ACCESSNAS directory
    [Tags]                 Access_Nas
    IF    ${output} == True
        ${nas_path26}=          Execute Command     ls /eniq/log/ddc_data/${hostname}/${date_dmy}/remotehosts/*${master_node1}_ACCESSNAS/server/vxstat.txt
        Set Global variable    ${nas_path26}
        ${var}=    Run Keyword And Return Status    Check File Exists      ${nas_path26}
        IF    ${var} == True
            Check File Size        ${nas_path26}
        ELSE
            Log     File not available.
        END
    END

Checking for ethtool file in access_nas1 TC29
    [Documentation]        Checking for ethtool file in /eniq/log/ddc_data/${hostname}/${date_dmy}/remotehosts/*1_ACCESSNAS directory
    [Tags]                 Access_Nas
    IF    ${output} == True
        ${nas_path27}=          Execute Command     ls /eniq/log/ddc_data/${hostname}/${date_dmy}/remotehosts/*${master_node1}_ACCESSNAS/server/ethtool* | tail -1
        Set Global variable    ${nas_path27}
        ${var}=    Run Keyword And Return Status    Check File Exists      ${nas_path27}
        IF    ${var} == True
            Check File Size        ${nas_path27}
        ELSE
            Log     File not available.
        END
    END

Checking for vxfsstat file in access_nas1 TC30
    [Documentation]        Checking for vxfsstat file in /eniq/log/ddc_data/${hostname}/${date_dmy}/remotehosts/*1_ACCESSNAS directory
    [Tags]                 Access_Nas
    IF    ${output} == True
        ${nas_path28}=          Execute Command     ls /eniq/log/ddc_data/${hostname}/${date_dmy}/remotehosts/*${master_node1}_ACCESSNAS/server/vxfsstat* | tail -1
        Set Global variable    ${nas_path28}
        ${var}=    Run Keyword And Return Status    Check File Exists      ${nas_path28}
        IF    ${var} == True
            Check File Size        ${nas_path28}
        ELSE
            Log     File not available.
        END
    END

Checking for fc_hba file in access_nas1 TC31
    [Documentation]        Checking for fc_hba.txt file in /eniq/log/ddc_data/${hostname}/${date_dmy}/remotehosts/*1_ACCESSNAS directory
    [Tags]                 Access_Nas
    IF    ${output} == True
        ${nas_path29}=          Execute Command     ls /eniq/log/ddc_data/${hostname}/${date_dmy}/remotehosts/*${master_node1}_ACCESSNAS/server/fc_hba.txt
        Set Global variable    ${nas_path29}
        ${var}=    Run Keyword And Return Status    Check File Exists      ${nas_path29}
        IF    ${var} == True
            Check File Size        ${nas_path29}
        ELSE
            Log     File not available.
        END
    END

Checking for dmidecode file in access_nas1 TC32
    [Documentation]        Checking for dmidecode.txt file in /eniq/log/ddc_data/${hostname}/${date_dmy}/remotehosts/*1_ACCESSNAS directory
    [Tags]                 Access_Nas
    IF    ${output} == True
        ${nas_path30}=          Execute Command     ls /eniq/log/ddc_data/${hostname}/${date_dmy}/remotehosts/*${master_node1}_ACCESSNAS/server/dmidecode.txt
        Set Global variable    ${nas_path30}
        ${var}=    Run Keyword And Return Status    Check File Exists      ${nas_path30}
        IF    ${var} == True
            Check File Size        ${nas_path30}
        ELSE
            Log     File not available.
        END
    END
