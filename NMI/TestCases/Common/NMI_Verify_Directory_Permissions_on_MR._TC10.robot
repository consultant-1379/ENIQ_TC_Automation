*** Settings ***
Suite Setup        Open Connection and Log In
Suite Teardown     Close All Connections
Library            SSHLibrary
Resource           ../../Resources/resource.txt
 
*** Variables ***

*** Test Cases ***
Open Connection And Log In to coordinator
    [Tags]                         II-Coordinator
    Open Connection                ${host}        port=${PORT}
    Login                          ${username}    ${password}    delay=1
    Log To Console                 Connected to server ${host}:${p}
    
Verify permission of directory /eniq/admin on coordinator
    [Tags]                         II-Coordinator
    Set Client Configuration       timeout=25 seconds      prompt=#:
    ${output}=                     Execute Command         ls -ld /eniq/admin | awk '{print $1}'
    Should Be Equal                ${output}               drwxr-xr-x.
    
Verify permission of directory /eniq/archive on coordinator
    [Tags]                         II-Coordinator
    Set Client Configuration       timeout=25 seconds      prompt=#:
    ${output}=                     Execute Command         ls -ld /eniq/archive | awk '{print $1}'
    Should Be Equal                ${output}               drwxr-xr-x.
    
Verify permission of directory /eniq/backup on coordinator
    [Tags]                         II-Coordinator
    Set Client Configuration       timeout=25 seconds      prompt=#:
    ${output}=                     Execute Command         ls -ld /eniq/backup | awk '{print $1}'
    Should Be Equal                ${output}               drwxr-xr-x.
    
Verify permission of directory /eniq/data on coordinator
    [Tags]                         II-Coordinator
    Set Client Configuration       timeout=25 seconds      prompt=#:
    ${output}=                     Execute Command         ls -ld /eniq/data | awk '{print $1}'
    Should Be Equal                ${output}               drwxr-xr-x.
    
Verify permission of directory /eniq/data/etldata_ on coordinator
    [Tags]                         II-Coordinator
    Set Client Configuration       timeout=25 seconds      prompt=#:
    ${output}=                     Execute Command         ls -ld /eniq/data/etldata_ | awk '{print $1}'
    Should Be Equal                ${output}               drwxr-xr-x.
    
Verify permission of directory /eniq/data/etldata_/00 on coordinator
    [Tags]                         II-Coordinator
    Set Client Configuration       timeout=25 seconds      prompt=#:
    ${output}=                     Execute Command         ls -ld /eniq/data/etldata_/00 | awk '{print $1}'
    Should Be Equal                ${output}               drwxr-xr-x.
    
Verify permission of directory /eniq/data/etldata_/01 on coordinator
    [Tags]                         II-Coordinator
    Set Client Configuration       timeout=25 seconds      prompt=#:
    ${output}=                     Execute Command         ls -ld /eniq/data/etldata_/01 | awk '{print $1}'
    Should Be Equal                ${output}               drwxr-xr-x.

Verify permission of directory /eniq/data/etldata_/02 on coordinator
    [Tags]                         II-Coordinator
    Set Client Configuration       timeout=25 seconds      prompt=#:
    ${output}=                     Execute Command         ls -ld /eniq/data/etldata_/02 | awk '{print $1}'
    Should Be Equal                ${output}               drwxr-xr-x.
    
Verify permission of directory /eniq/data/etldata_/03 on coordinator
    [Tags]                         II-Coordinator
    Set Client Configuration       timeout=25 seconds      prompt=#:
    ${output}=                     Execute Command         ls -ld /eniq/data/etldata_/03 | awk '{print $1}'
    Should Be Equal                ${output}               drwxr-xr-x.
    
Verify permission of directory /eniq/data/pmdata on coordinator
    [Tags]                         II-Coordinator
    Set Client Configuration       timeout=25 seconds      prompt=#:
    ${output}=                     Execute Command         ls -ld /eniq/data/pmdata | awk '{print $1}'
    Should Be Equal                ${output}               drwxr-xr-x.
    
Verify permission of directory /eniq/data/pmdata/eventdata on coordinator
    [Tags]                         II-Coordinator
    Set Client Configuration       timeout=25 seconds      prompt=#:
    ${output}=                     Execute Command         ls -ld /eniq/data/pmdata/eventdata | awk '{print $1}'
    Should Be Equal                ${output}               drwxr-xr-x.
    
Verify permission of directory /eniq/data/pmdata/eventdata/00 on coordinator
    [Tags]                         II-Coordinator
    Set Client Configuration       timeout=25 seconds      prompt=#:
    ${output}=                     Execute Command         ls -ld /eniq/data/pmdata/eventdata/00 | awk '{print $1}'
    Should Be Equal                ${output}               drwxr-xr-x.
    
Verify permission of directory /eniq/data/pmdata/eventdata/01 on coordinator
    [Tags]                         II-Coordinator
    Set Client Configuration       timeout=25 seconds      prompt=#:
    ${output}=                     Execute Command         ls -ld /eniq/data/pmdata/eventdata/01 | awk '{print $1}'
    Should Be Equal                ${output}               drwxr-xr-x.
    
Verify permission of directory /eniq/data/pmdata/eventdata/02 on coordinator
    [Tags]                         II-Coordinator
    Set Client Configuration       timeout=25 seconds      prompt=#:
    ${output}=                     Execute Command         ls -ld /eniq/data/pmdata/eventdata/02 | awk '{print $1}'
    Should Be Equal                ${output}               drwxr-xr-x.
    
Verify permission of directory /eniq/data/pmdata/eventdata/03 on coordinator
    [Tags]                         II-Coordinator
    Set Client Configuration       timeout=25 seconds      prompt=#:
    ${output}=                     Execute Command         ls -ld /eniq/data/pmdata/eventdata/03 | awk '{print $1}'
    Should Be Equal                ${output}               drwxr-xr-x.
    
Verify permission of directory /eniq/data/pmdata/eventdata/04 on coordinator
    [Tags]                         II-Coordinator
    Set Client Configuration       timeout=25 seconds      prompt=#:
    ${output}=                     Execute Command         ls -ld /eniq/data/pmdata/eventdata/04 | awk '{print $1}'
    Should Be Equal                ${output}               drwxr-xr-x.
    
Verify permission of directory /eniq/data/pmdata/eventdata/05 on coordinator
    [Tags]                         II-Coordinator
    Set Client Configuration       timeout=25 seconds      prompt=#:
    ${output}=                     Execute Command         ls -ld /eniq/data/pmdata/eventdata/05 | awk '{print $1}'
    Should Be Equal                ${output}               drwxr-xr-x.
    
Verify permission of directory /eniq/data/pmdata/eventdata/06 on coordinator
    [Tags]                         II-Coordinator
    Set Client Configuration       timeout=25 seconds      prompt=#:
    ${output}=                     Execute Command         ls -ld /eniq/data/pmdata/eventdata/06 | awk '{print $1}'
    Should Be Equal                ${output}               drwxr-xr-x.
    
Verify permission of directory /eniq/data/pmdata/eventdata/07 on coordinator
    [Tags]                         II-Coordinator
    Set Client Configuration       timeout=25 seconds      prompt=#:
    ${output}=                     Execute Command         ls -ld /eniq/data/pmdata/eventdata/07 | awk '{print $1}'
    Should Be Equal                ${output}               drwxr-xr-x.
    
Verify permission of directory /eniq/data/pmdata/eventdata/08 on coordinator
    [Tags]                         II-Coordinator
    Set Client Configuration       timeout=25 seconds      prompt=#:
    ${output}=                     Execute Command         ls -ld /eniq/data/pmdata/eventdata/08 | awk '{print $1}'
    Should Be Equal                ${output}               drwxr-xr-x.
    
Verify permission of directory /eniq/data/pmdata/eventdata/09 on coordinator
    [Tags]                         II-Coordinator
    Set Client Configuration       timeout=25 seconds      prompt=#:
    ${output}=                     Execute Command         ls -ld /eniq/data/pmdata/eventdata/09 | awk '{print $1}'
    Should Be Equal                ${output}               drwxr-xr-x.
    
Verify permission of directory /eniq/data/pmdata/eventdata/10 on coordinator
    [Tags]                         II-Coordinator
    Set Client Configuration       timeout=25 seconds      prompt=#:
    ${output}=                     Execute Command         ls -ld /eniq/data/pmdata/eventdata/10 | awk '{print $1}'
    Should Be Equal                ${output}               drwxr-xr-x.
    
Verify permission of directory /eniq/data/pmdata/eventdata/11 on coordinator
    [Tags]                         II-Coordinator
    Set Client Configuration       timeout=25 seconds      prompt=#:
    ${output}=                     Execute Command         ls -ld /eniq/data/pmdata/eventdata/11 | awk '{print $1}'
    Should Be Equal                ${output}               drwxr-xr-x.
    
Verify permission of directory /eniq/data/pmdata/eventdata/12 on coordinator
    [Tags]                         II-Coordinator
    Set Client Configuration       timeout=25 seconds      prompt=#:
    ${output}=                     Execute Command         ls -ld /eniq/data/pmdata/eventdata/12 | awk '{print $1}'
    Should Be Equal                ${output}               drwxr-xr-x.
    
Verify permission of directory /eniq/data/pmdata/eventdata/13 on coordinator
    [Tags]                         II-Coordinator
    Set Client Configuration       timeout=25 seconds      prompt=#:
    ${output}=                     Execute Command         ls -ld /eniq/data/pmdata/eventdata/13 | awk '{print $1}'
    Should Be Equal                ${output}               drwxr-xr-x.
    
Verify permission of directory /eniq/data/pmdata/eventdata/14 on coordinator
    [Tags]                         II-Coordinator
    Set Client Configuration       timeout=25 seconds      prompt=#:
    ${output}=                     Execute Command         ls -ld /eniq/data/pmdata/eventdata/14 | awk '{print $1}'
    Should Be Equal                ${output}               drwxr-xr-x.
    
Verify permission of directory /eniq/data/pmdata/eventdata/15 on coordinator
    [Tags]                         II-Coordinator
    Set Client Configuration       timeout=25 seconds      prompt=#:
    ${output}=                     Execute Command         ls -ld /eniq/data/pmdata/eventdata/15 | awk '{print $1}'
    Should Be Equal                ${output}               drwxr-xr-x.
    
Verify permission of directory /eniq/database/dwh_main on coordinator
    [Tags]                         II-Coordinator
    Set Client Configuration       timeout=25 seconds      prompt=#:
    ${output}=                     Execute Command         ls -ld /eniq/database/dwh_main | awk '{print $1}'
    Should Be Equal                ${output}               drwxr-xr-x.
    
Verify permission of directory /eniq/glassfish on coordinator
    [Tags]                         II-Coordinator
    Set Client Configuration       timeout=25 seconds      prompt=#:
    ${output}=                     Execute Command         ls -ld /eniq/glassfish | awk '{print $1}'
    Should Be Equal                ${output}               drwxr-xr-x.
    
Verify permission of directory /eniq/home on coordinator
    [Tags]                         II-Coordinator
    Set Client Configuration       timeout=25 seconds      prompt=#:
    ${output}=                     Execute Command         ls -ld /eniq/home | awk '{print $1}'
    Should Be Equal                ${output}               drwxr-xr-x.
    
Verify permission of directory /eniq/log on coordinator
    [Tags]                         II-Coordinator
    Set Client Configuration       timeout=25 seconds      prompt=#:
    ${output}=                     Execute Command         ls -ld /eniq/log | awk '{print $1}'
    Should Be Equal                ${output}               drwxr-xr-x.
    
Verify permission of directory /eniq/mediation_sw on coordinator
    [Tags]                         II-Coordinator
    Set Client Configuration       timeout=25 seconds      prompt=#:
    ${output}=                     Execute Command         ls -ld /eniq/mediation_sw | awk '{print $1}'
    Should Be Equal                ${output}               drwxr-xr-x.
    
Verify permission of directory /eniq/mediation_inter on coordinator
    [Tags]                         II-Coordinator
    Set Client Configuration       timeout=25 seconds      prompt=#:
    ${output}=                     Execute Command         ls -ld /eniq/mediation_inter | awk '{print $1}'
    Should Be Equal                ${output}               drwxr-xr-x.
    
Verify permission of directory /eniq/sentinel on coordinator
    [Tags]                         II-Coordinator
    Set Client Configuration       timeout=25 seconds      prompt=#:
    ${output}=                     Execute Command         ls -ld /eniq/sentinel | awk '{print $1}'
    Should Be Equal                ${output}               drwxr-xr-x.
    
Verify permission of directory /eniq/smf on coordinator
    [Tags]                         II-Coordinator
    Set Client Configuration       timeout=25 seconds      prompt=#:
    ${output}=                     Execute Command         ls -ld /eniq/smf | awk '{print $1}'
    Should Be Equal                ${output}               drwxr-xr-x.
    
Verify permission of directory /eniq/snapshot on coordinator
    [Tags]                         II-Coordinator
    Set Client Configuration       timeout=25 seconds      prompt=#:
    ${output}=                     Execute Command         ls -ld /eniq/snapshot | awk '{print $1}'
    Should Be Equal                ${output}               drwxr-xr-x.
    
Verify permission of directory /eniq/sybase_iq on coordinator
    [Tags]                         II-Coordinator
    Set Client Configuration       timeout=25 seconds      prompt=#:
    ${output}=                     Execute Command         ls -ld /eniq/sybase_iq | awk '{print $1}'
    Should Be Equal                ${output}               drwxr-xr-x.
    
Verify permission of directory /eniq/sw on coordinator
    [Tags]                         II-Coordinator
    Set Client Configuration       timeout=25 seconds      prompt=#:
    ${output}=                     Execute Command         ls -ld /eniq/sw | awk '{print $1}'
    Should Be Equal                ${output}               drwxr-xr-x.
    
Verify permission of directory /eniq/sw/bin on coordinator
    [Tags]                         II-Coordinator
    Set Client Configuration       timeout=25 seconds      prompt=#:
    ${output}=                     Execute Command         ls -ld /eniq/sw/bin | awk '{print $1}'
    Should Be Equal                ${output}               drwxr-xr-x.
    
Verify permission of directory /eniq/sw/conf on coordinator
    [Tags]                         II-Coordinator
    Set Client Configuration       timeout=25 seconds      prompt=#:
    ${output}=                     Execute Command         ls -ld /eniq/sw/conf | awk '{print $1}'
    Should Be Equal                ${output}               drwxr-xr-x.
    
Verify permission of directory /eniq/sw/installer on coordinator
    [Tags]                         II-Coordinator
    Set Client Configuration       timeout=25 seconds      prompt=#:
    ${output}=                     Execute Command         ls -ld /eniq/sw/installer | awk '{print $1}'
    Should Be Equal                ${output}               drwxr-xr-x.
    
Verify permission of directory /eniq/sw/log on coordinator
    [Tags]                         II-Coordinator
    Set Client Configuration       timeout=25 seconds      prompt=#:
    ${output}=                     Execute Command         ls -ld /eniq/sw/log | awk '{print $1}'
    Should Be Equal                ${output}               drwxr-xr-x.
    
Verify permission of directory /eniq/sw/platform on coordinator
    [Tags]                         II-Coordinator
    Set Client Configuration       timeout=25 seconds      prompt=#:
    ${output}=                     Execute Command         ls -ld /eniq/sw/platform | awk '{print $1}'
    Should Be Equal                ${output}               drwxr-xr-x.
    
Verify permission of directory /eniq/sw/runtime on coordinator
    [Tags]                         II-Coordinator
    Set Client Configuration       timeout=25 seconds      prompt=#:
    ${output}=                     Execute Command         ls -ld /eniq/sw/runtime | awk '{print $1}'
    Should Be Equal                ${output}               drwxr-xr-x.
    
Verify permission of directory /eniq/upgrade on coordinator
    [Tags]                         II-Coordinator
    Set Client Configuration       timeout=25 seconds      prompt=#:
    ${output}=                     Execute Command         ls -ld /eniq/upgrade | awk '{print $1}'
    Should Be Equal                ${output}               drwxr-xr-x.
    
Verify permission of directory /eniq/database/rep_main on coordinator
    [Tags]                         II-Coordinator
    Set Client Configuration       timeout=25 seconds      prompt=#:
    ${output}=                     Execute Command         ls -ld /eniq/database/rep_main | awk '{print $1}'
    Should Be Equal                ${output}               drwxr-xr-x.
    
Verify permission of directory /eniq/northbound on coordinator
    [Tags]                         II-Coordinator
    Set Client Configuration       timeout=25 seconds      prompt=#:
    ${output}=                     Execute Command         ls -ld /eniq/northbound | awk '{print $1}'
    Should Be Equal                ${output}               drwxr-xr-x.
    
Verify permission of directory /eniq/northbound/lte_event_stat_file on coordinator
    [Tags]                         II-Coordinator
    Set Client Configuration       timeout=25 seconds      prompt=#:
    ${output}=                     Execute Command         ls -ld /eniq/northbound/lte_event_stat_file | awk '{print $1}'
    Should Be Equal                ${output}               drwxr-xr-x.

Verify permission of directory /eniq/misc/ldap_db on coordinator
    [Tags]                         II-Coordinator
    Set Client Configuration       timeout=25 seconds      prompt=#:
    ${output}=                     Execute Command         ls -ld /eniq/misc/ldap_db | awk '{print $1}'
    Should Be Equal                ${output}               drwxr-xr-x.
    
Verify permission of directory /eniq/export on coordinator
    [Tags]                         II-Coordinator
    Set Client Configuration       timeout=25 seconds      prompt=#:
    ${output}=                     Execute Command         ls -ld /eniq/export | awk '{print $1}'
    Should Be Equal                ${output}               drwxr-xr-x.
    
Verify permission of directory /eniq/fmdata on coordinator
    [Tags]                         II-Coordinator
    Set Client Configuration       timeout=25 seconds      prompt=#:
    ${output}=                     Execute Command         ls -ld /eniq/fmdata | awk '{print $1}'
    Should Be Equal                ${output}               drwxr-xr-x.
    
Verify permission of directory /eniq/database on coordinator
    [Tags]                         II-Coordinator
    Set Client Configuration       timeout=25 seconds      prompt=#:
    ${output}=                     Execute Command         ls -ld /eniq/database | awk '{print $1}'
    Should Be Equal                ${output}               drwxr-xr-x.
    
Verify permission of directory /eniq/database/dwh_main_dbspace on coordinator
    [Tags]                         II-Coordinator
    Set Client Configuration       timeout=25 seconds      prompt=#:
    ${output}=                     Execute Command         ls -ld /eniq/database/dwh_main_dbspace | awk '{print $1}'
    Should Be Equal                ${output}               drwxr-xr-x.
    
Verify permission of directory /eniq/database/dwh_reader on coordinator
    [Tags]                         II-Coordinator
    Set Client Configuration       timeout=25 seconds      prompt=#:
    ${output}=                     Execute Command         ls -ld /eniq/database/dwh_reader | awk '{print $1}'
    Should Be Equal                ${output}               drwxr-xr-x.
    
Verify permission of directory /eniq/database/dwh_main_dbspace/dbspace_dir_1 on coordinator
    [Tags]                         II-Coordinator
    Set Client Configuration       timeout=25 seconds      prompt=#:
    ${output}=                     Execute Command         ls -ld /eniq/database/dwh_main_dbspace/dbspace_dir_1 | awk '{print $1}'
    Should Be Equal                ${output}               drwxr-xr-x.
    
Verify permission of directory /eniq/database/dwh_main_dbspace/dbspace_dir_2 on coordinator
    [Tags]                         II-Coordinator
    Set Client Configuration       timeout=25 seconds      prompt=#:
    ${output}=                     Execute Command         ls -ld /eniq/database/dwh_main_dbspace/dbspace_dir_2 | awk '{print $1}'
    Should Be Equal                ${output}               drwxr-xr-x.
    
Verify permission of directory /eniq/database/dwh_main_dbspace/dbspace_dir_3 on coordinator
    [Tags]                         II-Coordinator
    Set Client Configuration       timeout=25 seconds      prompt=#:
    ${output}=                     Execute Command         ls -ld /eniq/database/dwh_main_dbspace/dbspace_dir_3 | awk '{print $1}'
    Should Be Equal                ${output}               drwxr-xr-x.
    
Verify permission of directory /eniq/database/dwh_main_dbspace/dbspace_dir_4 on coordinator
    [Tags]                         II-Coordinator
    Set Client Configuration       timeout=25 seconds      prompt=#:
    ${output}=                     Execute Command         ls -ld /eniq/database/dwh_main_dbspace/dbspace_dir_4 | awk '{print $1}'
    Should Be Equal                ${output}               drwxr-xr-x.
    
Verify permission of directory /eniq/database/dwh_main_dbspace/dbspace_dir_5 on coordinator
    [Tags]                         II-Coordinator
    Set Client Configuration       timeout=25 seconds      prompt=#:
    ${output}=                     Execute Command         ls -ld /eniq/database/dwh_main_dbspace/dbspace_dir_5 | awk '{print $1}'
    Should Be Equal                ${output}               drwxr-xr-x.
    
Verify permission of directory /eniq/database/dwh_main_dbspace/dbspace_dir_6 on coordinator
    [Tags]                         II-Coordinator
    Set Client Configuration       timeout=25 seconds      prompt=#:
    ${output}=                     Execute Command         ls -ld /eniq/database/dwh_main_dbspace/dbspace_dir_6 | awk '{print $1}'
    Should Be Equal                ${output}               drwxr-xr-x.
    
Verify permission of directory /eniq/database/dwh_main_dbspace/dbspace_dir_7 on coordinator
    [Tags]                         II-Coordinator
    Set Client Configuration       timeout=25 seconds      prompt=#:
    ${output}=                     Execute Command         ls -ld /eniq/database/dwh_main_dbspace/dbspace_dir_7 | awk '{print $1}'
    Should Be Equal                ${output}               drwxr-xr-x.
    
Verify permission of directory /eniq/database/dwh_main_dbspace/dbspace_dir_8 on coordinator
    [Tags]                         II-Coordinator
    Set Client Configuration       timeout=25 seconds      prompt=#:
    ${output}=                     Execute Command         ls -ld /eniq/database/dwh_main_dbspace/dbspace_dir_8 | awk '{print $1}'
    Should Be Equal                ${output}               drwxr-xr-x.
    
Verify permission of directory /eniq/database/dwh_main_dbspace/dbspace_dir_9 on coordinator
    [Tags]                         II-Coordinator
    Set Client Configuration       timeout=25 seconds      prompt=#:
    ${output}=                     Execute Command         ls -ld /eniq/database/dwh_main_dbspace/dbspace_dir_9 | awk '{print $1}'
    Should Be Equal                ${output}               drwxr-xr-x.
    
Verify permission of directory /eniq/database/dwh_main_dbspace/dbspace_dir_10 on coordinator
    [Tags]                         II-Coordinator
    Set Client Configuration       timeout=25 seconds      prompt=#:
    ${output}=                     Execute Command         ls -ld /eniq/database/dwh_main_dbspace/dbspace_dir_10 | awk '{print $1}'
    Should Be Equal                ${output}               drwxr-xr-x.
    
Verify permission of directory /eniq/database/dwh_temp_dbspace/dbspace_dir_1 on coordinator
    [Tags]                         II-Coordinator
    Set Client Configuration       timeout=25 seconds      prompt=#:
    ${output}=                     Execute Command         ls -ld /eniq/database/dwh_temp_dbspace/dbspace_dir_1 | awk '{print $1}'
    Should Be Equal                ${output}               drwxr-xr-x.
    
Verify permission of directory /eniq/database/dwh_temp_dbspace/dbspace_dir_2 on coordinator
    [Tags]                         II-Coordinator
    Set Client Configuration       timeout=25 seconds      prompt=#:
    ${output}=                     Execute Command         ls -ld /eniq/database/dwh_temp_dbspace/dbspace_dir_2 | awk '{print $1}'
    Should Be Equal                ${output}               drwxr-xr-x.
    
Verify permission of directory /eniq/database/dwh_temp_dbspace/dbspace_dir_3 on coordinator
    [Tags]                         II-Coordinator
    Set Client Configuration       timeout=25 seconds      prompt=#:
    ${output}=                     Execute Command         ls -ld /eniq/database/dwh_temp_dbspace/dbspace_dir_3 | awk '{print $1}'
    Should Be Equal                ${output}               drwxr-xr-x.
    
Verify permission of directory /eniq/database/dwh_temp_dbspace/dbspace_dir_4 on coordinator
    [Tags]                         II-Coordinator
    Set Client Configuration       timeout=25 seconds      prompt=#:
    ${output}=                     Execute Command         ls -ld /eniq/database/dwh_temp_dbspace/dbspace_dir_4 | awk '{print $1}'
    Should Be Equal                ${output}               drwxr-xr-x.

Verify permission of directory /eniq/database/dwh_temp_dbspace/dbspace_dir_5 on coordinator
    [Tags]                         II-Coordinator
    Set Client Configuration       timeout=25 seconds      prompt=#:
    ${output}=                     Execute Command         ls -ld /eniq/database/dwh_temp_dbspace/dbspace_dir_5 | awk '{print $1}'
    Should Be Equal                ${output}               drwxr-xr-x.
    
Verify permission of directory /eniq/northbound/lte_event_ctrs_symlink on coordinator
    [Tags]                         II-Coordinator
    Set Client Configuration       timeout=25 seconds      prompt=#:
    ${output}=                     Execute Command         ls -ld /eniq/northbound/lte_event_ctrs_symlink | awk '{print $1}'
    Should Be Equal                ${output}               drwxr-xr-x.
    
Verify permission of directory /eniq/data/pmdata_soem on coordinator
    [Tags]                         II-Coordinator
    Set Client Configuration       timeout=25 seconds      prompt=#:
    ${output}=                     Execute Command         ls -ld /eniq/data/pmdata_soem | awk '{print $1}'
    Should Be Equal                ${output}               drwxr-xr-x.
    
Verify permission of directory /eniq/data/pmdata_sim on coordinator
    [Tags]                         II-Coordinator
    Set Client Configuration       timeout=25 seconds      prompt=#:
    ${output}=                     Execute Command         ls -ld /eniq/data/pmdata_sim | awk '{print $1}'
    Should Be Equal                ${output}               drwxr-xr-x.

Verify cronjob execution
    [Tags]                         II-Coordinator
    Set Client Configuration       timeout=25 seconds      prompt=#:
    ${output}=                     Execute Command         crontab -l | grep -w "disk_partition_check.bsh" | awk -F " " '{print $1}'
        IF                         '${output}' == '0'
        ${pwd}=                    Execute Command         /usr/bin/bash /eniq/installation/core_install/eniq_checks/bin/disk_partition_check.bsh -s
        END

Verify crong flag files
    [Tags]                         II-Coordinator
    Set Client Configuration       timeout=25 seconds      prompt=#:
    ${output}=                     Execute Command         crontab -l | grep -w "disk_partition_check.bsh" | awk -F " " '{print $1}'
        IF                          '${output}' == '0'
        ${pwd}=                     Execute Command        ls -lart /var/tmp | grep -i "mpath_iq_value_" | awk -F " " '{print $1}'
        Should Be Equal             ${pwd}                 -rw-r--r--.
        END
    
Open Connection And Log In to engine
    [Tags]                         II-Engine
    Open Connection                ${host1}        port=${PORT1}
    Login                          ${username1}    ${password1}    delay=1
    Log To Console                 Connected to server ${host1}:${p1}
    
Verify permission of directory /eniq/admin on engine
    [Tags]                         II-Engine
    Set Client Configuration       timeout=25 seconds      prompt=#:
    ${output}=                     Execute Command         ls -ld /eniq/admin | awk '{print $1}'
    Should Be Equal                ${output}               drwxr-xr-x.
    
Verify permission of directory /eniq/archive on engine
    [Tags]                         II-Engine
    Set Client Configuration       timeout=25 seconds      prompt=#:
    ${output}=                     Execute Command         ls -ld /eniq/archive | awk '{print $1}'
    Should Be Equal                ${output}               drwxr-xr-x.
    
Verify permission of directory /eniq/backup on engine
    [Tags]                         II-Engine
    Set Client Configuration       timeout=25 seconds      prompt=#:
    ${output}=                     Execute Command         ls -ld /eniq/backup | awk '{print $1}'
    Should Be Equal                ${output}               drwxr-xr-x.
    
Verify permission of directory /eniq/data on engine
    [Tags]                         II-Engine
    Set Client Configuration       timeout=25 seconds      prompt=#:
    ${output}=                     Execute Command         ls -ld /eniq/data | awk '{print $1}'
    Should Be Equal                ${output}               drwxr-xr-x.
    
Verify permission of directory /eniq/data/etldata_ on engine
    [Tags]                         II-Engine
    Set Client Configuration       timeout=25 seconds      prompt=#:
    ${output}=                     Execute Command         ls -ld /eniq/data/etldata_ | awk '{print $1}'
    Should Be Equal                ${output}               drwxr-xr-x.
    
Verify permission of directory /eniq/data/etldata_/00 on engine
    [Tags]                         II-Engine
    Set Client Configuration       timeout=25 seconds      prompt=#:
    ${output}=                     Execute Command         ls -ld /eniq/data/etldata_/00 | awk '{print $1}'
    Should Be Equal                ${output}               drwxr-xr-x.
    
Verify permission of directory /eniq/data/etldata_/01 on engine
    [Tags]                         II-Engine
    Set Client Configuration       timeout=25 seconds      prompt=#:
    ${output}=                     Execute Command         ls -ld /eniq/data/etldata_/01 | awk '{print $1}'
    Should Be Equal                ${output}               drwxr-xr-x.

Verify permission of directory /eniq/data/etldata_/02 on engine
    [Tags]                         II-Engine
    Set Client Configuration       timeout=25 seconds      prompt=#:
    ${output}=                     Execute Command         ls -ld /eniq/data/etldata_/02 | awk '{print $1}'
    Should Be Equal                ${output}               drwxr-xr-x.
    
Verify permission of directory /eniq/data/etldata_/03 on engine
    [Tags]                         II-Engine
    Set Client Configuration       timeout=25 seconds      prompt=#:
    ${output}=                     Execute Command         ls -ld /eniq/data/etldata_/03 | awk '{print $1}'
    Should Be Equal                ${output}               drwxr-xr-x.
    
Verify permission of directory /eniq/data/pmdata on engine
    [Tags]                         II-Engine
    Set Client Configuration       timeout=25 seconds      prompt=#:
    ${output}=                     Execute Command         ls -ld /eniq/data/pmdata | awk '{print $1}'
    Should Be Equal                ${output}               drwxr-xr-x.
    
Verify permission of directory /eniq/data/pmdata/eventdata on engine
    [Tags]                         II-Engine
    Set Client Configuration       timeout=25 seconds      prompt=#:
    ${output}=                     Execute Command         ls -ld /eniq/data/pmdata/eventdata | awk '{print $1}'
    Should Be Equal                ${output}               drwxr-xr-x.
    
Verify permission of directory /eniq/data/pmdata/eventdata/00 on engine
    [Tags]                         II-Engine
    Set Client Configuration       timeout=25 seconds      prompt=#:
    ${output}=                     Execute Command         ls -ld /eniq/data/pmdata/eventdata/00 | awk '{print $1}'
    Should Be Equal                ${output}               drwxr-xr-x.
    
Verify permission of directory /eniq/data/pmdata/eventdata/01 on engine
    [Tags]                         II-Engine
    Set Client Configuration       timeout=25 seconds      prompt=#:
    ${output}=                     Execute Command         ls -ld /eniq/data/pmdata/eventdata/01 | awk '{print $1}'
    Should Be Equal                ${output}               drwxr-xr-x.
    
Verify permission of directory /eniq/data/pmdata/eventdata/02 on engine
    [Tags]                         II-Engine
    Set Client Configuration       timeout=25 seconds      prompt=#:
    ${output}=                     Execute Command         ls -ld /eniq/data/pmdata/eventdata/02 | awk '{print $1}'
    Should Be Equal                ${output}               drwxr-xr-x.
    
Verify permission of directory /eniq/data/pmdata/eventdata/03 on engine
    [Tags]                         II-Engine
    Set Client Configuration       timeout=25 seconds      prompt=#:
    ${output}=                     Execute Command         ls -ld /eniq/data/pmdata/eventdata/03 | awk '{print $1}'
    Should Be Equal                ${output}               drwxr-xr-x.
    
Verify permission of directory /eniq/data/pmdata/eventdata/04 on engine
    [Tags]                         II-Engine
    Set Client Configuration       timeout=25 seconds      prompt=#:
    ${output}=                     Execute Command         ls -ld /eniq/data/pmdata/eventdata/04 | awk '{print $1}'
    Should Be Equal                ${output}               drwxr-xr-x.
    
Verify permission of directory /eniq/data/pmdata/eventdata/05 on engine
    [Tags]                         II-Engine
    Set Client Configuration       timeout=25 seconds      prompt=#:
    ${output}=                     Execute Command         ls -ld /eniq/data/pmdata/eventdata/05 | awk '{print $1}'
    Should Be Equal                ${output}               drwxr-xr-x.
    
Verify permission of directory /eniq/data/pmdata/eventdata/06 on engine
    [Tags]                         II-Engine
    Set Client Configuration       timeout=25 seconds      prompt=#:
    ${output}=                     Execute Command         ls -ld /eniq/data/pmdata/eventdata/06 | awk '{print $1}'
    Should Be Equal                ${output}               drwxr-xr-x.
    
Verify permission of directory /eniq/data/pmdata/eventdata/07 on engine
    [Tags]                         II-Engine
    Set Client Configuration       timeout=25 seconds      prompt=#:
    ${output}=                     Execute Command         ls -ld /eniq/data/pmdata/eventdata/07 | awk '{print $1}'
    Should Be Equal                ${output}               drwxr-xr-x.
    
Verify permission of directory /eniq/data/pmdata/eventdata/08 on engine
    [Tags]                         II-Engine
    Set Client Configuration       timeout=25 seconds      prompt=#:
    ${output}=                     Execute Command         ls -ld /eniq/data/pmdata/eventdata/08 | awk '{print $1}'
    Should Be Equal                ${output}               drwxr-xr-x.
    
Verify permission of directory /eniq/data/pmdata/eventdata/09 on engine
    [Tags]                         II-Engine
    Set Client Configuration       timeout=25 seconds      prompt=#:
    ${output}=                     Execute Command         ls -ld /eniq/data/pmdata/eventdata/09 | awk '{print $1}'
    Should Be Equal                ${output}               drwxr-xr-x.
    
Verify permission of directory /eniq/data/pmdata/eventdata/10 on engine
    [Tags]                         II-Engine
    Set Client Configuration       timeout=25 seconds      prompt=#:
    ${output}=                     Execute Command         ls -ld /eniq/data/pmdata/eventdata/10 | awk '{print $1}'
    Should Be Equal                ${output}               drwxr-xr-x.
    
Verify permission of directory /eniq/data/pmdata/eventdata/11 on engine
    [Tags]                         II-Engine
    Set Client Configuration       timeout=25 seconds      prompt=#:
    ${output}=                     Execute Command         ls -ld /eniq/data/pmdata/eventdata/11 | awk '{print $1}'
    Should Be Equal                ${output}               drwxr-xr-x.
    
Verify permission of directory /eniq/data/pmdata/eventdata/12 on engine
    [Tags]                         II-Engine
    Set Client Configuration       timeout=25 seconds      prompt=#:
    ${output}=                     Execute Command         ls -ld /eniq/data/pmdata/eventdata/12 | awk '{print $1}'
    Should Be Equal                ${output}               drwxr-xr-x.
    
Verify permission of directory /eniq/data/pmdata/eventdata/13 on engine
    [Tags]                         II-Engine
    Set Client Configuration       timeout=25 seconds      prompt=#:
    ${output}=                     Execute Command         ls -ld /eniq/data/pmdata/eventdata/13 | awk '{print $1}'
    Should Be Equal                ${output}               drwxr-xr-x.
    
Verify permission of directory /eniq/data/pmdata/eventdata/14 on engine
    [Tags]                         II-Engine
    Set Client Configuration       timeout=25 seconds      prompt=#:
    ${output}=                     Execute Command         ls -ld /eniq/data/pmdata/eventdata/14 | awk '{print $1}'
    Should Be Equal                ${output}               drwxr-xr-x.
    
Verify permission of directory /eniq/data/pmdata/eventdata/15 on engine
    [Tags]                         II-Engine
    Set Client Configuration       timeout=25 seconds      prompt=#:
    ${output}=                     Execute Command         ls -ld /eniq/data/pmdata/eventdata/15 | awk '{print $1}'
    Should Be Equal                ${output}               drwxr-xr-x.
    
Verify permission of directory /eniq/database/dwh_main on engine
    [Tags]                         II-Engine
    Set Client Configuration       timeout=25 seconds      prompt=#:
    ${output}=                     Execute Command         ls -ld /eniq/database/dwh_main | awk '{print $1}'
    Should Be Equal                ${output}               drwxr-xr-x.
    
Verify permission of directory /eniq/glassfish on engine
    [Tags]                         II-Engine
    Set Client Configuration       timeout=25 seconds      prompt=#:
    ${output}=                     Execute Command         ls -ld /eniq/glassfish | awk '{print $1}'
    Should Be Equal                ${output}               drwxr-xr-x.
    
Verify permission of directory /eniq/home on engine
    [Tags]                         II-Engine
    Set Client Configuration       timeout=25 seconds      prompt=#:
    ${output}=                     Execute Command         ls -ld /eniq/home | awk '{print $1}'
    Should Be Equal                ${output}               drwxr-xr-x.
    
Verify permission of directory /eniq/log on engine
    [Tags]                         II-Engine
    Set Client Configuration       timeout=25 seconds      prompt=#:
    ${output}=                     Execute Command         ls -ld /eniq/log | awk '{print $1}'
    Should Be Equal                ${output}               drwxr-xr-x.
    
Verify permission of directory /eniq/mediation_sw on engine
    [Tags]                         II-Engine
    Set Client Configuration       timeout=25 seconds      prompt=#:
    ${output}=                     Execute Command         ls -ld /eniq/mediation_sw | awk '{print $1}'
    Should Be Equal                ${output}               drwxr-xr-x.
    
Verify permission of directory /eniq/mediation_inter on engine
    [Tags]                         II-Engine
    Set Client Configuration       timeout=25 seconds      prompt=#:
    ${output}=                     Execute Command         ls -ld /eniq/mediation_inter | awk '{print $1}'
    Should Be Equal                ${output}               drwxr-xr-x.
    
Verify permission of directory /eniq/sentinel on engine
    [Tags]                         II-Engine
    Set Client Configuration       timeout=25 seconds      prompt=#:
    ${output}=                     Execute Command         ls -ld /eniq/sentinel | awk '{print $1}'
    Should Be Equal                ${output}               drwxr-xr-x.
    
Verify permission of directory /eniq/smf on engine
    [Tags]                         II-Engine
    Set Client Configuration       timeout=25 seconds      prompt=#:
    ${output}=                     Execute Command         ls -ld /eniq/smf | awk '{print $1}'
    Should Be Equal                ${output}               drwxr-xr-x.
    
Verify permission of directory /eniq/snapshot on engine
    [Tags]                         II-Engine
    Set Client Configuration       timeout=25 seconds      prompt=#:
    ${output}=                     Execute Command         ls -ld /eniq/snapshot | awk '{print $1}'
    Should Be Equal                ${output}               drwxr-xr-x.
    
Verify permission of directory /eniq/sybase_iq on engine
    [Tags]                         II-Engine
    Set Client Configuration       timeout=25 seconds      prompt=#:
    ${output}=                     Execute Command         ls -ld /eniq/sybase_iq | awk '{print $1}'
    Should Be Equal                ${output}               drwxr-xr-x.
    
Verify permission of directory /eniq/sw on engine
    [Tags]                         II-Engine
    Set Client Configuration       timeout=25 seconds      prompt=#:
    ${output}=                     Execute Command         ls -ld /eniq/sw | awk '{print $1}'
    Should Be Equal                ${output}               drwxr-xr-x.
    
Verify permission of directory /eniq/sw/bin on engine
    [Tags]                         II-Engine
    Set Client Configuration       timeout=25 seconds      prompt=#:
    ${output}=                     Execute Command         ls -ld /eniq/sw/bin | awk '{print $1}'
    Should Be Equal                ${output}               drwxr-xr-x.
    
Verify permission of directory /eniq/sw/conf on engine
    [Tags]                         II-Engine
    Set Client Configuration       timeout=25 seconds      prompt=#:
    ${output}=                     Execute Command         ls -ld /eniq/sw/conf | awk '{print $1}'
    Should Be Equal                ${output}               drwxr-xr-x.
    
Verify permission of directory /eniq/sw/installer on engine
    [Tags]                         II-Engine
    Set Client Configuration       timeout=25 seconds      prompt=#:
    ${output}=                     Execute Command         ls -ld /eniq/sw/installer | awk '{print $1}'
    Should Be Equal                ${output}               drwxr-xr-x.
    
Verify permission of directory /eniq/sw/log on engine
    [Tags]                         II-Engine
    Set Client Configuration       timeout=25 seconds      prompt=#:
    ${output}=                     Execute Command         ls -ld /eniq/sw/log | awk '{print $1}'
    Should Be Equal                ${output}               drwxr-xr-x.
    
Verify permission of directory /eniq/sw/platform on engine
    [Tags]                         II-Engine
    Set Client Configuration       timeout=25 seconds      prompt=#:
    ${output}=                     Execute Command         ls -ld /eniq/sw/platform | awk '{print $1}'
    Should Be Equal                ${output}               drwxr-xr-x.
    
Verify permission of directory /eniq/sw/runtime on engine
    [Tags]                         II-Engine
    Set Client Configuration       timeout=25 seconds      prompt=#:
    ${output}=                     Execute Command         ls -ld /eniq/sw/runtime | awk '{print $1}'
    Should Be Equal                ${output}               drwxr-xr-x.
    
Verify permission of directory /eniq/upgrade on engine
    [Tags]                         II-Engine
    Set Client Configuration       timeout=25 seconds      prompt=#:
    ${output}=                     Execute Command         ls -ld /eniq/upgrade | awk '{print $1}'
    Should Be Equal                ${output}               drwxr-xr-x.
    
Verify permission of directory /eniq/database/rep_main on engine
    [Tags]                         II-Engine
    Set Client Configuration       timeout=25 seconds      prompt=#:
    ${output}=                     Execute Command         ls -ld /eniq/database/rep_main | awk '{print $1}'
    Should Be Equal                ${output}               drwxr-xr-x.
    
Verify permission of directory /eniq/northbound on engine
    [Tags]                         II-Engine
    Set Client Configuration       timeout=25 seconds      prompt=#:
    ${output}=                     Execute Command         ls -ld /eniq/northbound | awk '{print $1}'
    Should Be Equal                ${output}               drwxr-xr-x.
    
Verify permission of directory /eniq/northbound/lte_event_stat_file on engine
    [Tags]                         II-Engine
    Set Client Configuration       timeout=25 seconds      prompt=#:
    ${output}=                     Execute Command         ls -ld /eniq/northbound/lte_event_stat_file | awk '{print $1}'
    Should Be Equal                ${output}               drwxr-xr-x.

Verify permission of directory /eniq/misc/ldap_db on engine
    [Tags]                         II-Engine
    Set Client Configuration       timeout=25 seconds      prompt=#:
    ${output}=                     Execute Command         ls -ld /eniq/misc/ldap_db | awk '{print $1}'
    Should Be Equal                ${output}               drwxr-xr-x.
    
Verify permission of directory /eniq/export on engine
    [Tags]                         II-Engine
    Set Client Configuration       timeout=25 seconds      prompt=#:
    ${output}=                     Execute Command         ls -ld /eniq/export | awk '{print $1}'
    Should Be Equal                ${output}               drwxr-xr-x.
    
Verify permission of directory /eniq/fmdata on engine
    [Tags]                         II-Engine
    Set Client Configuration       timeout=25 seconds      prompt=#:
    ${output}=                     Execute Command         ls -ld /eniq/fmdata | awk '{print $1}'
    Should Be Equal                ${output}               drwxr-xr-x.
    
Verify permission of directory /eniq/database on engine
    [Tags]                         II-Engine
    Set Client Configuration       timeout=25 seconds      prompt=#:
    ${output}=                     Execute Command         ls -ld /eniq/database | awk '{print $1}'
    Should Be Equal                ${output}               drwxr-xr-x.
    
Verify permission of directory /eniq/database/dwh_main_dbspace on engine
    [Tags]                         II-Engine
    Set Client Configuration       timeout=25 seconds      prompt=#:
    ${output}=                     Execute Command         ls -ld /eniq/database/dwh_main_dbspace | awk '{print $1}'
    Should Be Equal                ${output}               drwxr-xr-x.
    
Verify permission of directory /eniq/database/dwh_reader on engine
    [Tags]                         II-Engine
    Set Client Configuration       timeout=25 seconds      prompt=#:
    ${output}=                     Execute Command         ls -ld /eniq/database/dwh_reader | awk '{print $1}'
    Should Be Equal                ${output}               drwxr-xr-x.
    
Verify permission of directory /eniq/database/dwh_main_dbspace/dbspace_dir_1 on engine
    [Tags]                         II-Engine
    Set Client Configuration       timeout=25 seconds      prompt=#:
    ${output}=                     Execute Command         ls -ld /eniq/database/dwh_main_dbspace/dbspace_dir_1 | awk '{print $1}'
    Should Be Equal                ${output}               drwxr-xr-x.
    
Verify permission of directory /eniq/database/dwh_main_dbspace/dbspace_dir_2 on engine
    [Tags]                         II-Engine
    Set Client Configuration       timeout=25 seconds      prompt=#:
    ${output}=                     Execute Command         ls -ld /eniq/database/dwh_main_dbspace/dbspace_dir_2 | awk '{print $1}'
    Should Be Equal                ${output}               drwxr-xr-x.
    
Verify permission of directory /eniq/database/dwh_main_dbspace/dbspace_dir_3 on engine
    [Tags]                         II-Engine
    Set Client Configuration       timeout=25 seconds      prompt=#:
    ${output}=                     Execute Command         ls -ld /eniq/database/dwh_main_dbspace/dbspace_dir_3 | awk '{print $1}'
    Should Be Equal                ${output}               drwxr-xr-x.
    
Verify permission of directory /eniq/database/dwh_main_dbspace/dbspace_dir_4 on engine
    [Tags]                         II-Engine
    Set Client Configuration       timeout=25 seconds      prompt=#:
    ${output}=                     Execute Command         ls -ld /eniq/database/dwh_main_dbspace/dbspace_dir_4 | awk '{print $1}'
    Should Be Equal                ${output}               drwxr-xr-x.
    
Verify permission of directory /eniq/database/dwh_main_dbspace/dbspace_dir_5 on engine
    [Tags]                         II-Engine
    Set Client Configuration       timeout=25 seconds      prompt=#:
    ${output}=                     Execute Command         ls -ld /eniq/database/dwh_main_dbspace/dbspace_dir_5 | awk '{print $1}'
    Should Be Equal                ${output}               drwxr-xr-x.
    
Verify permission of directory /eniq/database/dwh_main_dbspace/dbspace_dir_6 on engine
    [Tags]                         II-Engine
    Set Client Configuration       timeout=25 seconds      prompt=#:
    ${output}=                     Execute Command         ls -ld /eniq/database/dwh_main_dbspace/dbspace_dir_6 | awk '{print $1}'
    Should Be Equal                ${output}               drwxr-xr-x.
    
Verify permission of directory /eniq/database/dwh_main_dbspace/dbspace_dir_7 on engine
    [Tags]                         II-Engine
    Set Client Configuration       timeout=25 seconds      prompt=#:
    ${output}=                     Execute Command         ls -ld /eniq/database/dwh_main_dbspace/dbspace_dir_7 | awk '{print $1}'
    Should Be Equal                ${output}               drwxr-xr-x.
    
Verify permission of directory /eniq/database/dwh_main_dbspace/dbspace_dir_8 on engine
    [Tags]                         II-Engine
    Set Client Configuration       timeout=25 seconds      prompt=#:
    ${output}=                     Execute Command         ls -ld /eniq/database/dwh_main_dbspace/dbspace_dir_8 | awk '{print $1}'
    Should Be Equal                ${output}               drwxr-xr-x.
    
Verify permission of directory /eniq/database/dwh_main_dbspace/dbspace_dir_9 on engine
    [Tags]                         II-Engine
    Set Client Configuration       timeout=25 seconds      prompt=#:
    ${output}=                     Execute Command         ls -ld /eniq/database/dwh_main_dbspace/dbspace_dir_9 | awk '{print $1}'
    Should Be Equal                ${output}               drwxr-xr-x.
    
Verify permission of directory /eniq/database/dwh_main_dbspace/dbspace_dir_10 on engine
    [Tags]                         II-Engine
    Set Client Configuration       timeout=25 seconds      prompt=#:
    ${output}=                     Execute Command         ls -ld /eniq/database/dwh_main_dbspace/dbspace_dir_10 | awk '{print $1}'
    Should Be Equal                ${output}               drwxr-xr-x.
    
Verify permission of directory /eniq/database/dwh_temp_dbspace/dbspace_dir_1 on engine
    [Tags]                         II-Engine
    Set Client Configuration       timeout=25 seconds      prompt=#:
    ${output}=                     Execute Command         ls -ld /eniq/database/dwh_temp_dbspace/dbspace_dir_1 | awk '{print $1}'
    Should Be Equal                ${output}               drwxr-xr-x.
    
Verify permission of directory /eniq/database/dwh_temp_dbspace/dbspace_dir_2 on engine
    [Tags]                         II-Engine
    Set Client Configuration       timeout=25 seconds      prompt=#:
    ${output}=                     Execute Command         ls -ld /eniq/database/dwh_temp_dbspace/dbspace_dir_2 | awk '{print $1}'
    Should Be Equal                ${output}               drwxr-xr-x.
    
Verify permission of directory /eniq/database/dwh_temp_dbspace/dbspace_dir_3 on engine
    [Tags]                         II-Engine
    Set Client Configuration       timeout=25 seconds      prompt=#:
    ${output}=                     Execute Command         ls -ld /eniq/database/dwh_temp_dbspace/dbspace_dir_3 | awk '{print $1}'
    Should Be Equal                ${output}               drwxr-xr-x.
    
Verify permission of directory /eniq/database/dwh_temp_dbspace/dbspace_dir_4 on engine
    [Tags]                         II-Engine
    Set Client Configuration       timeout=25 seconds      prompt=#:
    ${output}=                     Execute Command         ls -ld /eniq/database/dwh_temp_dbspace/dbspace_dir_4 | awk '{print $1}'
    Should Be Equal                ${output}               drwxr-xr-x.

Verify permission of directory /eniq/database/dwh_temp_dbspace/dbspace_dir_5 on engine
    [Tags]                         II-Engine
    Set Client Configuration       timeout=25 seconds      prompt=#:
    ${output}=                     Execute Command         ls -ld /eniq/database/dwh_temp_dbspace/dbspace_dir_5 | awk '{print $1}'
    Should Be Equal                ${output}               drwxr-xr-x.
    
Verify permission of directory /eniq/northbound/lte_event_ctrs_symlink on engine
    [Tags]                         II-Engine
    Set Client Configuration       timeout=25 seconds      prompt=#:
    ${output}=                     Execute Command         ls -ld /eniq/northbound/lte_event_ctrs_symlink | awk '{print $1}'
    Should Be Equal                ${output}               drwxr-xr-x.
    
Verify permission of directory /eniq/data/pmdata_soem on engine
    [Tags]                         II-Engine
    Set Client Configuration       timeout=25 seconds      prompt=#:
    ${output}=                     Execute Command         ls -ld /eniq/data/pmdata_soem | awk '{print $1}'
    Should Be Equal                ${output}               drwxr-xr-x.
    
Verify permission of directory /eniq/data/pmdata_sim on engine
    [Tags]                         II-Engine
    Set Client Configuration       timeout=25 seconds      prompt=#:
    ${output}=                     Execute Command         ls -ld /eniq/data/pmdata_sim | awk '{print $1}'
    Should Be Equal                ${output}               drwxr-xr-x.

Verify cronjob execution
    [Tags]                         II-Engine
    Set Client Configuration       timeout=25 seconds      prompt=#:
    ${output}=                     Execute Command         crontab -l | grep -w "disk_partition_check.bsh" | awk -F " " '{print $1}'
        IF                         '${output}' == '0'
        ${pwd}=                    Execute Command         /usr/bin/bash /eniq/installation/core_install/eniq_checks/bin/disk_partition_check.bsh -s
        END

Verify crong flag files
    [Tags]                         II-Engine
    Set Client Configuration       timeout=25 seconds      prompt=#:
    ${output}=                     Execute Command         crontab -l | grep -w "disk_partition_check.bsh" | awk -F " " '{print $1}'
        IF                          '${output}' == '0'
        ${pwd}=                     Execute Command        ls -lart /var/tmp | grep -i "mpath_iq_value_" | awk -F " " '{print $1}'
        Should Be Equal             ${pwd}                 -rw-r--r--.
        END
    
Open Connection And Log In to reader1
    [Tags]                         II-Reader1
    Open Connection                ${host2}        port=${PORT2}
    Login                          ${username2}    ${password2}    delay=1
    Log To Console                 Connected to server ${host2}:${p2}
    
Verify permission of directory /eniq/admin on reader1
    [Tags]                         II-Reader1
    Set Client Configuration       timeout=25 seconds      prompt=#:
    ${output}=                     Execute Command         ls -ld /eniq/admin | awk '{print $1}'
    Should Be Equal                ${output}               drwxr-xr-x.
    
Verify permission of directory /eniq/archive on reader1
    [Tags]                         II-Reader1
    Set Client Configuration       timeout=25 seconds      prompt=#:
    ${output}=                     Execute Command         ls -ld /eniq/archive | awk '{print $1}'
    Should Be Equal                ${output}               drwxr-xr-x.
    
Verify permission of directory /eniq/backup on reader1
    [Tags]                         II-Reader1
    Set Client Configuration       timeout=25 seconds      prompt=#:
    ${output}=                     Execute Command         ls -ld /eniq/backup | awk '{print $1}'
    Should Be Equal                ${output}               drwxr-xr-x.
    
Verify permission of directory /eniq/data on reader1
    [Tags]                         II-Reader1
    Set Client Configuration       timeout=25 seconds      prompt=#:
    ${output}=                     Execute Command         ls -ld /eniq/data | awk '{print $1}'
    Should Be Equal                ${output}               drwxr-xr-x.
    
Verify permission of directory /eniq/data/etldata_ on reader1
    [Tags]                         II-Reader1
    Set Client Configuration       timeout=25 seconds      prompt=#:
    ${output}=                     Execute Command         ls -ld /eniq/data/etldata_ | awk '{print $1}'
    Should Be Equal                ${output}               drwxr-xr-x.
    
Verify permission of directory /eniq/data/etldata_/00 on reader1
    [Tags]                         II-Reader1
    Set Client Configuration       timeout=25 seconds      prompt=#:
    ${output}=                     Execute Command         ls -ld /eniq/data/etldata_/00 | awk '{print $1}'
    Should Be Equal                ${output}               drwxr-xr-x.
    
Verify permission of directory /eniq/data/etldata_/01 on reader1
    [Tags]                         II-Reader1
    Set Client Configuration       timeout=25 seconds      prompt=#:
    ${output}=                     Execute Command         ls -ld /eniq/data/etldata_/01 | awk '{print $1}'
    Should Be Equal                ${output}               drwxr-xr-x.

Verify permission of directory /eniq/data/etldata_/02 on reader1
    [Tags]                         II-Reader1
    Set Client Configuration       timeout=25 seconds      prompt=#:
    ${output}=                     Execute Command         ls -ld /eniq/data/etldata_/02 | awk '{print $1}'
    Should Be Equal                ${output}               drwxr-xr-x.
    
Verify permission of directory /eniq/data/etldata_/03 on reader1
    [Tags]                         II-Reader1
    Set Client Configuration       timeout=25 seconds      prompt=#:
    ${output}=                     Execute Command         ls -ld /eniq/data/etldata_/03 | awk '{print $1}'
    Should Be Equal                ${output}               drwxr-xr-x.
    
Verify permission of directory /eniq/data/pmdata on reader1
    [Tags]                         II-Reader1
    Set Client Configuration       timeout=25 seconds      prompt=#:
    ${output}=                     Execute Command         ls -ld /eniq/data/pmdata | awk '{print $1}'
    Should Be Equal                ${output}               drwxr-xr-x.
    
Verify permission of directory /eniq/data/pmdata/eventdata on reader1
    [Tags]                         II-Reader1
    Set Client Configuration       timeout=25 seconds      prompt=#:
    ${output}=                     Execute Command         ls -ld /eniq/data/pmdata/eventdata | awk '{print $1}'
    Should Be Equal                ${output}               drwxr-xr-x.
    
Verify permission of directory /eniq/data/pmdata/eventdata/00 on reader1
    [Tags]                         II-Reader1
    Set Client Configuration       timeout=25 seconds      prompt=#:
    ${output}=                     Execute Command         ls -ld /eniq/data/pmdata/eventdata/00 | awk '{print $1}'
    Should Be Equal                ${output}               drwxr-xr-x.
    
Verify permission of directory /eniq/data/pmdata/eventdata/01 on reader1
    [Tags]                         II-Reader1
    Set Client Configuration       timeout=25 seconds      prompt=#:
    ${output}=                     Execute Command         ls -ld /eniq/data/pmdata/eventdata/01 | awk '{print $1}'
    Should Be Equal                ${output}               drwxr-xr-x.
    
Verify permission of directory /eniq/data/pmdata/eventdata/02 on reader1
    [Tags]                         II-Reader1
    Set Client Configuration       timeout=25 seconds      prompt=#:
    ${output}=                     Execute Command         ls -ld /eniq/data/pmdata/eventdata/02 | awk '{print $1}'
    Should Be Equal                ${output}               drwxr-xr-x.
    
Verify permission of directory /eniq/data/pmdata/eventdata/03 on reader1
    [Tags]                         II-Reader1
    Set Client Configuration       timeout=25 seconds      prompt=#:
    ${output}=                     Execute Command         ls -ld /eniq/data/pmdata/eventdata/03 | awk '{print $1}'
    Should Be Equal                ${output}               drwxr-xr-x.
    
Verify permission of directory /eniq/data/pmdata/eventdata/04 on reader1
    [Tags]                         II-Reader1
    Set Client Configuration       timeout=25 seconds      prompt=#:
    ${output}=                     Execute Command         ls -ld /eniq/data/pmdata/eventdata/04 | awk '{print $1}'
    Should Be Equal                ${output}               drwxr-xr-x.
    
Verify permission of directory /eniq/data/pmdata/eventdata/05 on reader1
    [Tags]                         II-Reader1
    Set Client Configuration       timeout=25 seconds      prompt=#:
    ${output}=                     Execute Command         ls -ld /eniq/data/pmdata/eventdata/05 | awk '{print $1}'
    Should Be Equal                ${output}               drwxr-xr-x.
    
Verify permission of directory /eniq/data/pmdata/eventdata/06 on reader1
    [Tags]                         II-Reader1
    Set Client Configuration       timeout=25 seconds      prompt=#:
    ${output}=                     Execute Command         ls -ld /eniq/data/pmdata/eventdata/06 | awk '{print $1}'
    Should Be Equal                ${output}               drwxr-xr-x.
    
Verify permission of directory /eniq/data/pmdata/eventdata/07 on reader1
    [Tags]                         II-Reader1
    Set Client Configuration       timeout=25 seconds      prompt=#:
    ${output}=                     Execute Command         ls -ld /eniq/data/pmdata/eventdata/07 | awk '{print $1}'
    Should Be Equal                ${output}               drwxr-xr-x.
    
Verify permission of directory /eniq/data/pmdata/eventdata/08 on reader1
    [Tags]                         II-Reader1
    Set Client Configuration       timeout=25 seconds      prompt=#:
    ${output}=                     Execute Command         ls -ld /eniq/data/pmdata/eventdata/08 | awk '{print $1}'
    Should Be Equal                ${output}               drwxr-xr-x.
    
Verify permission of directory /eniq/data/pmdata/eventdata/09 on reader1
    [Tags]                         II-Reader1
    Set Client Configuration       timeout=25 seconds      prompt=#:
    ${output}=                     Execute Command         ls -ld /eniq/data/pmdata/eventdata/09 | awk '{print $1}'
    Should Be Equal                ${output}               drwxr-xr-x.
    
Verify permission of directory /eniq/data/pmdata/eventdata/10 on reader1
    [Tags]                         II-Reader1
    Set Client Configuration       timeout=25 seconds      prompt=#:
    ${output}=                     Execute Command         ls -ld /eniq/data/pmdata/eventdata/10 | awk '{print $1}'
    Should Be Equal                ${output}               drwxr-xr-x.
    
Verify permission of directory /eniq/data/pmdata/eventdata/11 on reader1
    [Tags]                         II-Reader1
    Set Client Configuration       timeout=25 seconds      prompt=#:
    ${output}=                     Execute Command         ls -ld /eniq/data/pmdata/eventdata/11 | awk '{print $1}'
    Should Be Equal                ${output}               drwxr-xr-x.
    
Verify permission of directory /eniq/data/pmdata/eventdata/12 on reader1
    [Tags]                         II-Reader1
    Set Client Configuration       timeout=25 seconds      prompt=#:
    ${output}=                     Execute Command         ls -ld /eniq/data/pmdata/eventdata/12 | awk '{print $1}'
    Should Be Equal                ${output}               drwxr-xr-x.
    
Verify permission of directory /eniq/data/pmdata/eventdata/13 on reader1
    [Tags]                         II-Reader1
    Set Client Configuration       timeout=25 seconds      prompt=#:
    ${output}=                     Execute Command         ls -ld /eniq/data/pmdata/eventdata/13 | awk '{print $1}'
    Should Be Equal                ${output}               drwxr-xr-x.
    
Verify permission of directory /eniq/data/pmdata/eventdata/14 on reader1
    [Tags]                         II-Reader1
    Set Client Configuration       timeout=25 seconds      prompt=#:
    ${output}=                     Execute Command         ls -ld /eniq/data/pmdata/eventdata/14 | awk '{print $1}'
    Should Be Equal                ${output}               drwxr-xr-x.
    
Verify permission of directory /eniq/data/pmdata/eventdata/15 on reader1
    [Tags]                         II-Reader1
    Set Client Configuration       timeout=25 seconds      prompt=#:
    ${output}=                     Execute Command         ls -ld /eniq/data/pmdata/eventdata/15 | awk '{print $1}'
    Should Be Equal                ${output}               drwxr-xr-x.
    
Verify permission of directory /eniq/database/dwh_main on reader1
    [Tags]                         II-Reader1
    Set Client Configuration       timeout=25 seconds      prompt=#:
    ${output}=                     Execute Command         ls -ld /eniq/database/dwh_main | awk '{print $1}'
    Should Be Equal                ${output}               drwxr-xr-x.
    
Verify permission of directory /eniq/glassfish on reader1
    [Tags]                         II-Reader1
    Set Client Configuration       timeout=25 seconds      prompt=#:
    ${output}=                     Execute Command         ls -ld /eniq/glassfish | awk '{print $1}'
    Should Be Equal                ${output}               drwxr-xr-x.
    
Verify permission of directory /eniq/home on reader1
    [Tags]                         II-Reader1
    Set Client Configuration       timeout=25 seconds      prompt=#:
    ${output}=                     Execute Command         ls -ld /eniq/home | awk '{print $1}'
    Should Be Equal                ${output}               drwxr-xr-x.
    
Verify permission of directory /eniq/log on reader1
    [Tags]                         II-Reader1
    Set Client Configuration       timeout=25 seconds      prompt=#:
    ${output}=                     Execute Command         ls -ld /eniq/log | awk '{print $1}'
    Should Be Equal                ${output}               drwxr-xr-x.
    
Verify permission of directory /eniq/mediation_sw on reader1
    [Tags]                         II-Reader1
    Set Client Configuration       timeout=25 seconds      prompt=#:
    ${output}=                     Execute Command         ls -ld /eniq/mediation_sw | awk '{print $1}'
    Should Be Equal                ${output}               drwxr-xr-x.
    
Verify permission of directory /eniq/mediation_inter on reader1
    [Tags]                         II-Reader1
    Set Client Configuration       timeout=25 seconds      prompt=#:
    ${output}=                     Execute Command         ls -ld /eniq/mediation_inter | awk '{print $1}'
    Should Be Equal                ${output}               drwxr-xr-x.
    
Verify permission of directory /eniq/sentinel on reader1
    [Tags]                         II-Reader1
    Set Client Configuration       timeout=25 seconds      prompt=#:
    ${output}=                     Execute Command         ls -ld /eniq/sentinel | awk '{print $1}'
    Should Be Equal                ${output}               drwxr-xr-x.
    
Verify permission of directory /eniq/smf on reader1
    [Tags]                         II-Reader1
    Set Client Configuration       timeout=25 seconds      prompt=#:
    ${output}=                     Execute Command         ls -ld /eniq/smf | awk '{print $1}'
    Should Be Equal                ${output}               drwxr-xr-x.
    
Verify permission of directory /eniq/snapshot on reader1
    [Tags]                         II-Reader1
    Set Client Configuration       timeout=25 seconds      prompt=#:
    ${output}=                     Execute Command         ls -ld /eniq/snapshot | awk '{print $1}'
    Should Be Equal                ${output}               drwxr-xr-x.
    
Verify permission of directory /eniq/sybase_iq on reader1
    [Tags]                         II-Reader1
    Set Client Configuration       timeout=25 seconds      prompt=#:
    ${output}=                     Execute Command         ls -ld /eniq/sybase_iq | awk '{print $1}'
    Should Be Equal                ${output}               drwxr-xr-x.
    
Verify permission of directory /eniq/sw on reader1
    [Tags]                         II-Reader1
    Set Client Configuration       timeout=25 seconds      prompt=#:
    ${output}=                     Execute Command         ls -ld /eniq/sw | awk '{print $1}'
    Should Be Equal                ${output}               drwxr-xr-x.
    
Verify permission of directory /eniq/sw/bin on reader1
    [Tags]                         II-Reader1
    Set Client Configuration       timeout=25 seconds      prompt=#:
    ${output}=                     Execute Command         ls -ld /eniq/sw/bin | awk '{print $1}'
    Should Be Equal                ${output}               drwxr-xr-x.
    
Verify permission of directory /eniq/sw/conf on reader1
    [Tags]                         II-Reader1
    Set Client Configuration       timeout=25 seconds      prompt=#:
    ${output}=                     Execute Command         ls -ld /eniq/sw/conf | awk '{print $1}'
    Should Be Equal                ${output}               drwxr-xr-x.
    
Verify permission of directory /eniq/sw/installer on reader1
    [Tags]                         II-Reader1
    Set Client Configuration       timeout=25 seconds      prompt=#:
    ${output}=                     Execute Command         ls -ld /eniq/sw/installer | awk '{print $1}'
    Should Be Equal                ${output}               drwxr-xr-x.
    
Verify permission of directory /eniq/sw/log on reader1
    [Tags]                         II-Reader1
    Set Client Configuration       timeout=25 seconds      prompt=#:
    ${output}=                     Execute Command         ls -ld /eniq/sw/log | awk '{print $1}'
    Should Be Equal                ${output}               drwxr-xr-x.
    
Verify permission of directory /eniq/sw/platform on reader1
    [Tags]                         II-Reader1
    Set Client Configuration       timeout=25 seconds      prompt=#:
    ${output}=                     Execute Command         ls -ld /eniq/sw/platform | awk '{print $1}'
    Should Be Equal                ${output}               drwxr-xr-x.
    
Verify permission of directory /eniq/sw/runtime on reader1
    [Tags]                         II-Reader1
    Set Client Configuration       timeout=25 seconds      prompt=#:
    ${output}=                     Execute Command         ls -ld /eniq/sw/runtime | awk '{print $1}'
    Should Be Equal                ${output}               drwxr-xr-x.
    
Verify permission of directory /eniq/upgrade on reader1
    [Tags]                         II-Reader1
    Set Client Configuration       timeout=25 seconds      prompt=#:
    ${output}=                     Execute Command         ls -ld /eniq/upgrade | awk '{print $1}'
    Should Be Equal                ${output}               drwxr-xr-x.
    
Verify permission of directory /eniq/database/rep_main on reader1
    [Tags]                         II-Reader1
    Set Client Configuration       timeout=25 seconds      prompt=#:
    ${output}=                     Execute Command         ls -ld /eniq/database/rep_main | awk '{print $1}'
    Should Be Equal                ${output}               drwxr-xr-x.
    
Verify permission of directory /eniq/northbound on reader1
    [Tags]                         II-Reader1
    Set Client Configuration       timeout=25 seconds      prompt=#:
    ${output}=                     Execute Command         ls -ld /eniq/northbound | awk '{print $1}'
    Should Be Equal                ${output}               drwxr-xr-x.
    
Verify permission of directory /eniq/northbound/lte_event_stat_file on reader1
    [Tags]                         II-Reader1
    Set Client Configuration       timeout=25 seconds      prompt=#:
    ${output}=                     Execute Command         ls -ld /eniq/northbound/lte_event_stat_file | awk '{print $1}'
    Should Be Equal                ${output}               drwxr-xr-x.

Verify permission of directory /eniq/misc/ldap_db on reader1
    [Tags]                         II-Reader1
    Set Client Configuration       timeout=25 seconds      prompt=#:
    ${output}=                     Execute Command         ls -ld /eniq/misc/ldap_db | awk '{print $1}'
    Should Be Equal                ${output}               drwxr-xr-x.
    
Verify permission of directory /eniq/export on reader1
    [Tags]                         II-Reader1
    Set Client Configuration       timeout=25 seconds      prompt=#:
    ${output}=                     Execute Command         ls -ld /eniq/export | awk '{print $1}'
    Should Be Equal                ${output}               drwxr-xr-x.
    
Verify permission of directory /eniq/fmdata on reader1
    [Tags]                         II-Reader1
    Set Client Configuration       timeout=25 seconds      prompt=#:
    ${output}=                     Execute Command         ls -ld /eniq/fmdata | awk '{print $1}'
    Should Be Equal                ${output}               drwxr-xr-x.
    
Verify permission of directory /eniq/database on reader1
    [Tags]                         II-Reader1
    Set Client Configuration       timeout=25 seconds      prompt=#:
    ${output}=                     Execute Command         ls -ld /eniq/database | awk '{print $1}'
    Should Be Equal                ${output}               drwxr-xr-x.
    
Verify permission of directory /eniq/database/dwh_main_dbspace on reader1
    [Tags]                         II-Reader1
    Set Client Configuration       timeout=25 seconds      prompt=#:
    ${output}=                     Execute Command         ls -ld /eniq/database/dwh_main_dbspace | awk '{print $1}'
    Should Be Equal                ${output}               drwxr-xr-x.
    
Verify permission of directory /eniq/database/dwh_reader on reader1
    [Tags]                         II-Reader1
    Set Client Configuration       timeout=25 seconds      prompt=#:
    ${output}=                     Execute Command         ls -ld /eniq/database/dwh_reader | awk '{print $1}'
    Should Be Equal                ${output}               drwxr-xr-x.
    
Verify permission of directory /eniq/database/dwh_main_dbspace/dbspace_dir_1 on reader1
    [Tags]                         II-Reader1
    Set Client Configuration       timeout=25 seconds      prompt=#:
    ${output}=                     Execute Command         ls -ld /eniq/database/dwh_main_dbspace/dbspace_dir_1 | awk '{print $1}'
    Should Be Equal                ${output}               drwxr-xr-x.
    
Verify permission of directory /eniq/database/dwh_main_dbspace/dbspace_dir_2 on reader1
    [Tags]                         II-Reader1
    Set Client Configuration       timeout=25 seconds      prompt=#:
    ${output}=                     Execute Command         ls -ld /eniq/database/dwh_main_dbspace/dbspace_dir_2 | awk '{print $1}'
    Should Be Equal                ${output}               drwxr-xr-x.
    
Verify permission of directory /eniq/database/dwh_main_dbspace/dbspace_dir_3 on reader1
    [Tags]                         II-Reader1
    Set Client Configuration       timeout=25 seconds      prompt=#:
    ${output}=                     Execute Command         ls -ld /eniq/database/dwh_main_dbspace/dbspace_dir_3 | awk '{print $1}'
    Should Be Equal                ${output}               drwxr-xr-x.
    
Verify permission of directory /eniq/database/dwh_main_dbspace/dbspace_dir_4 on reader1
    [Tags]                         II-Reader1
    Set Client Configuration       timeout=25 seconds      prompt=#:
    ${output}=                     Execute Command         ls -ld /eniq/database/dwh_main_dbspace/dbspace_dir_4 | awk '{print $1}'
    Should Be Equal                ${output}               drwxr-xr-x.
    
Verify permission of directory /eniq/database/dwh_main_dbspace/dbspace_dir_5 on reader1
    [Tags]                         II-Reader1
    Set Client Configuration       timeout=25 seconds      prompt=#:
    ${output}=                     Execute Command         ls -ld /eniq/database/dwh_main_dbspace/dbspace_dir_5 | awk '{print $1}'
    Should Be Equal                ${output}               drwxr-xr-x.
    
Verify permission of directory /eniq/database/dwh_main_dbspace/dbspace_dir_6 on reader1
    [Tags]                         II-Reader1
    Set Client Configuration       timeout=25 seconds      prompt=#:
    ${output}=                     Execute Command         ls -ld /eniq/database/dwh_main_dbspace/dbspace_dir_6 | awk '{print $1}'
    Should Be Equal                ${output}               drwxr-xr-x.
    
Verify permission of directory /eniq/database/dwh_main_dbspace/dbspace_dir_7 on reader1
    [Tags]                         II-Reader1
    Set Client Configuration       timeout=25 seconds      prompt=#:
    ${output}=                     Execute Command         ls -ld /eniq/database/dwh_main_dbspace/dbspace_dir_7 | awk '{print $1}'
    Should Be Equal                ${output}               drwxr-xr-x.
    
Verify permission of directory /eniq/database/dwh_main_dbspace/dbspace_dir_8 on reader1
    [Tags]                         II-Reader1
    Set Client Configuration       timeout=25 seconds      prompt=#:
    ${output}=                     Execute Command         ls -ld /eniq/database/dwh_main_dbspace/dbspace_dir_8 | awk '{print $1}'
    Should Be Equal                ${output}               drwxr-xr-x.
    
Verify permission of directory /eniq/database/dwh_main_dbspace/dbspace_dir_9 on reader1
    [Tags]                         II-Reader1
    Set Client Configuration       timeout=25 seconds      prompt=#:
    ${output}=                     Execute Command         ls -ld /eniq/database/dwh_main_dbspace/dbspace_dir_9 | awk '{print $1}'
    Should Be Equal                ${output}               drwxr-xr-x.
    
Verify permission of directory /eniq/database/dwh_main_dbspace/dbspace_dir_10 on reader1
    [Tags]                         II-Reader1
    Set Client Configuration       timeout=25 seconds      prompt=#:
    ${output}=                     Execute Command         ls -ld /eniq/database/dwh_main_dbspace/dbspace_dir_10 | awk '{print $1}'
    Should Be Equal                ${output}               drwxr-xr-x.
    
Verify permission of directory /eniq/database/dwh_temp_dbspace/dbspace_dir_1 on reader1
    [Tags]                         II-Reader1
    Set Client Configuration       timeout=25 seconds      prompt=#:
    ${output}=                     Execute Command         ls -ld /eniq/database/dwh_temp_dbspace/dbspace_dir_1 | awk '{print $1}'
    Should Be Equal                ${output}               drwxr-xr-x.
    
Verify permission of directory /eniq/database/dwh_temp_dbspace/dbspace_dir_2 on reader1
    [Tags]                         II-Reader1
    Set Client Configuration       timeout=25 seconds      prompt=#:
    ${output}=                     Execute Command         ls -ld /eniq/database/dwh_temp_dbspace/dbspace_dir_2 | awk '{print $1}'
    Should Be Equal                ${output}               drwxr-xr-x.
    
Verify permission of directory /eniq/database/dwh_temp_dbspace/dbspace_dir_3 on reader1
    [Tags]                         II-Reader1
    Set Client Configuration       timeout=25 seconds      prompt=#:
    ${output}=                     Execute Command         ls -ld /eniq/database/dwh_temp_dbspace/dbspace_dir_3 | awk '{print $1}'
    Should Be Equal                ${output}               drwxr-xr-x.
    
Verify permission of directory /eniq/database/dwh_temp_dbspace/dbspace_dir_4 on reader1
    [Tags]                         II-Reader1
    Set Client Configuration       timeout=25 seconds      prompt=#:
    ${output}=                     Execute Command         ls -ld /eniq/database/dwh_temp_dbspace/dbspace_dir_4 | awk '{print $1}'
    Should Be Equal                ${output}               drwxr-xr-x.

Verify permission of directory /eniq/database/dwh_temp_dbspace/dbspace_dir_5 on reader1
    [Tags]                         II-Reader1
    Set Client Configuration       timeout=25 seconds      prompt=#:
    ${output}=                     Execute Command         ls -ld /eniq/database/dwh_temp_dbspace/dbspace_dir_5 | awk '{print $1}'
    Should Be Equal                ${output}               drwxr-xr-x.
    
Verify permission of directory /eniq/northbound/lte_event_ctrs_symlink on reader1
    [Tags]                         II-Reader1
    Set Client Configuration       timeout=25 seconds      prompt=#:
    ${output}=                     Execute Command         ls -ld /eniq/northbound/lte_event_ctrs_symlink | awk '{print $1}'
    Should Be Equal                ${output}               drwxr-xr-x.
    
Verify permission of directory /eniq/data/pmdata_soem on reader1
    [Tags]                         II-Reader1
    Set Client Configuration       timeout=25 seconds      prompt=#:
    ${output}=                     Execute Command         ls -ld /eniq/data/pmdata_soem | awk '{print $1}'
    Should Be Equal                ${output}               drwxr-xr-x.
    
Verify permission of directory /eniq/data/pmdata_sim on reader1
    [Tags]                         II-Reader1
    Set Client Configuration       timeout=25 seconds      prompt=#:
    ${output}=                     Execute Command         ls -ld /eniq/data/pmdata_sim | awk '{print $1}'
    Should Be Equal                ${output}               drwxr-xr-x.

Verify cronjob execution
    [Tags]                         II-Reader1
    Set Client Configuration       timeout=25 seconds      prompt=#:
    ${output}=                     Execute Command         crontab -l | grep -w "disk_partition_check.bsh" | awk -F " " '{print $1}'
        IF                         '${output}' == '0'
        ${pwd}=                    Execute Command         /usr/bin/bash /eniq/installation/core_install/eniq_checks/bin/disk_partition_check.bsh -s
        END

Verify crong flag files
    [Tags]                         II-Reader1
    Set Client Configuration       timeout=25 seconds      prompt=#:
    ${output}=                     Execute Command         crontab -l | grep -w "disk_partition_check.bsh" | awk -F " " '{print $1}'
        IF                          '${output}' == '0'
        ${pwd}=                     Execute Command        ls -lart /var/tmp | grep -i "mpath_iq_value_" | awk -F " " '{print $1}'
        Should Be Equal             ${pwd}                 -rw-r--r--.
        END
    
Open Connection And Log In to reader2
    [Tags]                         II-Reader2
    Open Connection                ${host3}        port=${PORT3}
    Login                          ${username3}    ${password3}    delay=1
    Log To Console                 Connected to server ${host3}:${p3}
    
Verify permission of directory /eniq/admin on reader2
    [Tags]                         II-Reader2
    Set Client Configuration       timeout=25 seconds      prompt=#:
    ${output}=                     Execute Command         ls -ld /eniq/admin | awk '{print $1}'
    Should Be Equal                ${output}               drwxr-xr-x.
    
Verify permission of directory /eniq/archive on reader2
    [Tags]                         II-Reader2
    Set Client Configuration       timeout=25 seconds      prompt=#:
    ${output}=                     Execute Command         ls -ld /eniq/archive | awk '{print $1}'
    Should Be Equal                ${output}               drwxr-xr-x.
    
Verify permission of directory /eniq/backup on reader2
    [Tags]                         II-Reader2
    Set Client Configuration       timeout=25 seconds      prompt=#:
    ${output}=                     Execute Command         ls -ld /eniq/backup | awk '{print $1}'
    Should Be Equal                ${output}               drwxr-xr-x.
    
Verify permission of directory /eniq/data on reader2
    [Tags]                         II-Reader2
    Set Client Configuration       timeout=25 seconds      prompt=#:
    ${output}=                     Execute Command         ls -ld /eniq/data | awk '{print $1}'
    Should Be Equal                ${output}               drwxr-xr-x.
    
Verify permission of directory /eniq/data/etldata_ on reader2
    [Tags]                         II-Reader2
    Set Client Configuration       timeout=25 seconds      prompt=#:
    ${output}=                     Execute Command         ls -ld /eniq/data/etldata_ | awk '{print $1}'
    Should Be Equal                ${output}               drwxr-xr-x.
    
Verify permission of directory /eniq/data/etldata_/00 on reader2
    [Tags]                         II-Reader2
    Set Client Configuration       timeout=25 seconds      prompt=#:
    ${output}=                     Execute Command         ls -ld /eniq/data/etldata_/00 | awk '{print $1}'
    Should Be Equal                ${output}               drwxr-xr-x.
    
Verify permission of directory /eniq/data/etldata_/01 on reader2
    [Tags]                         II-Reader2
    Set Client Configuration       timeout=25 seconds      prompt=#:
    ${output}=                     Execute Command         ls -ld /eniq/data/etldata_/01 | awk '{print $1}'
    Should Be Equal                ${output}               drwxr-xr-x.

Verify permission of directory /eniq/data/etldata_/02 on reader2
    [Tags]                         II-Reader2
    Set Client Configuration       timeout=25 seconds      prompt=#:
    ${output}=                     Execute Command         ls -ld /eniq/data/etldata_/02 | awk '{print $1}'
    Should Be Equal                ${output}               drwxr-xr-x.
    
Verify permission of directory /eniq/data/etldata_/03 on reader2
    [Tags]                         II-Reader2
    Set Client Configuration       timeout=25 seconds      prompt=#:
    ${output}=                     Execute Command         ls -ld /eniq/data/etldata_/03 | awk '{print $1}'
    Should Be Equal                ${output}               drwxr-xr-x.
    
Verify permission of directory /eniq/data/pmdata on reader2
    [Tags]                         II-Reader2
    Set Client Configuration       timeout=25 seconds      prompt=#:
    ${output}=                     Execute Command         ls -ld /eniq/data/pmdata | awk '{print $1}'
    Should Be Equal                ${output}               drwxr-xr-x.
    
Verify permission of directory /eniq/data/pmdata/eventdata on reader2
    [Tags]                         II-Reader2
    Set Client Configuration       timeout=25 seconds      prompt=#:
    ${output}=                     Execute Command         ls -ld /eniq/data/pmdata/eventdata | awk '{print $1}'
    Should Be Equal                ${output}               drwxr-xr-x.
    
Verify permission of directory /eniq/data/pmdata/eventdata/00 on reader2
    [Tags]                         II-Reader2
    Set Client Configuration       timeout=25 seconds      prompt=#:
    ${output}=                     Execute Command         ls -ld /eniq/data/pmdata/eventdata/00 | awk '{print $1}'
    Should Be Equal                ${output}               drwxr-xr-x.
    
Verify permission of directory /eniq/data/pmdata/eventdata/01 on reader2
    [Tags]                         II-Reader2
    Set Client Configuration       timeout=25 seconds      prompt=#:
    ${output}=                     Execute Command         ls -ld /eniq/data/pmdata/eventdata/01 | awk '{print $1}'
    Should Be Equal                ${output}               drwxr-xr-x.
    
Verify permission of directory /eniq/data/pmdata/eventdata/02 on reader2
    [Tags]                         II-Reader2
    Set Client Configuration       timeout=25 seconds      prompt=#:
    ${output}=                     Execute Command         ls -ld /eniq/data/pmdata/eventdata/02 | awk '{print $1}'
    Should Be Equal                ${output}               drwxr-xr-x.
    
Verify permission of directory /eniq/data/pmdata/eventdata/03 on reader2
    [Tags]                         II-Reader2
    Set Client Configuration       timeout=25 seconds      prompt=#:
    ${output}=                     Execute Command         ls -ld /eniq/data/pmdata/eventdata/03 | awk '{print $1}'
    Should Be Equal                ${output}               drwxr-xr-x.
    
Verify permission of directory /eniq/data/pmdata/eventdata/04 on reader2
    [Tags]                         II-Reader2
    Set Client Configuration       timeout=25 seconds      prompt=#:
    ${output}=                     Execute Command         ls -ld /eniq/data/pmdata/eventdata/04 | awk '{print $1}'
    Should Be Equal                ${output}               drwxr-xr-x.
    
Verify permission of directory /eniq/data/pmdata/eventdata/05 on reader2
    [Tags]                         II-Reader2
    Set Client Configuration       timeout=25 seconds      prompt=#:
    ${output}=                     Execute Command         ls -ld /eniq/data/pmdata/eventdata/05 | awk '{print $1}'
    Should Be Equal                ${output}               drwxr-xr-x.
    
Verify permission of directory /eniq/data/pmdata/eventdata/06 on reader2
    [Tags]                         II-Reader2
    Set Client Configuration       timeout=25 seconds      prompt=#:
    ${output}=                     Execute Command         ls -ld /eniq/data/pmdata/eventdata/06 | awk '{print $1}'
    Should Be Equal                ${output}               drwxr-xr-x.
    
Verify permission of directory /eniq/data/pmdata/eventdata/07 on reader2
    [Tags]                         II-Reader2
    Set Client Configuration       timeout=25 seconds      prompt=#:
    ${output}=                     Execute Command         ls -ld /eniq/data/pmdata/eventdata/07 | awk '{print $1}'
    Should Be Equal                ${output}               drwxr-xr-x.
    
Verify permission of directory /eniq/data/pmdata/eventdata/08 on reader2
    [Tags]                         II-Reader2
    Set Client Configuration       timeout=25 seconds      prompt=#:
    ${output}=                     Execute Command         ls -ld /eniq/data/pmdata/eventdata/08 | awk '{print $1}'
    Should Be Equal                ${output}               drwxr-xr-x.
    
Verify permission of directory /eniq/data/pmdata/eventdata/09 on reader2
    [Tags]                         II-Reader2
    Set Client Configuration       timeout=25 seconds      prompt=#:
    ${output}=                     Execute Command         ls -ld /eniq/data/pmdata/eventdata/09 | awk '{print $1}'
    Should Be Equal                ${output}               drwxr-xr-x.
    
Verify permission of directory /eniq/data/pmdata/eventdata/10 on reader2
    [Tags]                         II-Reader2
    Set Client Configuration       timeout=25 seconds      prompt=#:
    ${output}=                     Execute Command         ls -ld /eniq/data/pmdata/eventdata/10 | awk '{print $1}'
    Should Be Equal                ${output}               drwxr-xr-x.
    
Verify permission of directory /eniq/data/pmdata/eventdata/11 on reader2
    [Tags]                         II-Reader2
    Set Client Configuration       timeout=25 seconds      prompt=#:
    ${output}=                     Execute Command         ls -ld /eniq/data/pmdata/eventdata/11 | awk '{print $1}'
    Should Be Equal                ${output}               drwxr-xr-x.
    
Verify permission of directory /eniq/data/pmdata/eventdata/12 on reader2
    [Tags]                         II-Reader2
    Set Client Configuration       timeout=25 seconds      prompt=#:
    ${output}=                     Execute Command         ls -ld /eniq/data/pmdata/eventdata/12 | awk '{print $1}'
    Should Be Equal                ${output}               drwxr-xr-x.
    
Verify permission of directory /eniq/data/pmdata/eventdata/13 on reader2
    [Tags]                         II-Reader2
    Set Client Configuration       timeout=25 seconds      prompt=#:
    ${output}=                     Execute Command         ls -ld /eniq/data/pmdata/eventdata/13 | awk '{print $1}'
    Should Be Equal                ${output}               drwxr-xr-x.
    
Verify permission of directory /eniq/data/pmdata/eventdata/14 on reader2
    [Tags]                         II-Reader2
    Set Client Configuration       timeout=25 seconds      prompt=#:
    ${output}=                     Execute Command         ls -ld /eniq/data/pmdata/eventdata/14 | awk '{print $1}'
    Should Be Equal                ${output}               drwxr-xr-x.
    
Verify permission of directory /eniq/data/pmdata/eventdata/15 on reader2
    [Tags]                         II-Reader2
    Set Client Configuration       timeout=25 seconds      prompt=#:
    ${output}=                     Execute Command         ls -ld /eniq/data/pmdata/eventdata/15 | awk '{print $1}'
    Should Be Equal                ${output}               drwxr-xr-x.
    
Verify permission of directory /eniq/database/dwh_main on reader2
    [Tags]                         II-Reader2
    Set Client Configuration       timeout=25 seconds      prompt=#:
    ${output}=                     Execute Command         ls -ld /eniq/database/dwh_main | awk '{print $1}'
    Should Be Equal                ${output}               drwxr-xr-x.
    
Verify permission of directory /eniq/glassfish on reader2
    [Tags]                         II-Reader2
    Set Client Configuration       timeout=25 seconds      prompt=#:
    ${output}=                     Execute Command         ls -ld /eniq/glassfish | awk '{print $1}'
    Should Be Equal                ${output}               drwxr-xr-x.
    
Verify permission of directory /eniq/home on reader2
    [Tags]                         II-Reader2
    Set Client Configuration       timeout=25 seconds      prompt=#:
    ${output}=                     Execute Command         ls -ld /eniq/home | awk '{print $1}'
    Should Be Equal                ${output}               drwxr-xr-x.
    
Verify permission of directory /eniq/log on reader2
    [Tags]                         II-Reader2
    Set Client Configuration       timeout=25 seconds      prompt=#:
    ${output}=                     Execute Command         ls -ld /eniq/log | awk '{print $1}'
    Should Be Equal                ${output}               drwxr-xr-x.
    
Verify permission of directory /eniq/mediation_sw on reader2
    [Tags]                         II-Reader2
    Set Client Configuration       timeout=25 seconds      prompt=#:
    ${output}=                     Execute Command         ls -ld /eniq/mediation_sw | awk '{print $1}'
    Should Be Equal                ${output}               drwxr-xr-x.
    
Verify permission of directory /eniq/mediation_inter on reader2
    [Tags]                         II-Reader2
    Set Client Configuration       timeout=25 seconds      prompt=#:
    ${output}=                     Execute Command         ls -ld /eniq/mediation_inter | awk '{print $1}'
    Should Be Equal                ${output}               drwxr-xr-x.
    
Verify permission of directory /eniq/sentinel on reader2
    [Tags]                         II-Reader2
    Set Client Configuration       timeout=25 seconds      prompt=#:
    ${output}=                     Execute Command         ls -ld /eniq/sentinel | awk '{print $1}'
    Should Be Equal                ${output}               drwxr-xr-x.
    
Verify permission of directory /eniq/smf on reader2
    [Tags]                         II-Reader2
    Set Client Configuration       timeout=25 seconds      prompt=#:
    ${output}=                     Execute Command         ls -ld /eniq/smf | awk '{print $1}'
    Should Be Equal                ${output}               drwxr-xr-x.
    
Verify permission of directory /eniq/snapshot on reader2
    [Tags]                         II-Reader2
    Set Client Configuration       timeout=25 seconds      prompt=#:
    ${output}=                     Execute Command         ls -ld /eniq/snapshot | awk '{print $1}'
    Should Be Equal                ${output}               drwxr-xr-x.
    
Verify permission of directory /eniq/sybase_iq on reader2
    [Tags]                         II-Reader2
    Set Client Configuration       timeout=25 seconds      prompt=#:
    ${output}=                     Execute Command         ls -ld /eniq/sybase_iq | awk '{print $1}'
    Should Be Equal                ${output}               drwxr-xr-x.
    
Verify permission of directory /eniq/sw on reader2
    [Tags]                         II-Reader2
    Set Client Configuration       timeout=25 seconds      prompt=#:
    ${output}=                     Execute Command         ls -ld /eniq/sw | awk '{print $1}'
    Should Be Equal                ${output}               drwxr-xr-x.
    
Verify permission of directory /eniq/sw/bin on reader2
    [Tags]                         II-Reader2
    Set Client Configuration       timeout=25 seconds      prompt=#:
    ${output}=                     Execute Command         ls -ld /eniq/sw/bin | awk '{print $1}'
    Should Be Equal                ${output}               drwxr-xr-x.
    
Verify permission of directory /eniq/sw/conf on reader2
    [Tags]                         II-Reader2
    Set Client Configuration       timeout=25 seconds      prompt=#:
    ${output}=                     Execute Command         ls -ld /eniq/sw/conf | awk '{print $1}'
    Should Be Equal                ${output}               drwxr-xr-x.
    
Verify permission of directory /eniq/sw/installer on reader2
    [Tags]                         II-Reader2
    Set Client Configuration       timeout=25 seconds      prompt=#:
    ${output}=                     Execute Command         ls -ld /eniq/sw/installer | awk '{print $1}'
    Should Be Equal                ${output}               drwxr-xr-x.
    
Verify permission of directory /eniq/sw/log on reader2
    [Tags]                         II-Reader2
    Set Client Configuration       timeout=25 seconds      prompt=#:
    ${output}=                     Execute Command         ls -ld /eniq/sw/log | awk '{print $1}'
    Should Be Equal                ${output}               drwxr-xr-x.
    
Verify permission of directory /eniq/sw/platform on reader2
    [Tags]                         II-Reader2
    Set Client Configuration       timeout=25 seconds      prompt=#:
    ${output}=                     Execute Command         ls -ld /eniq/sw/platform | awk '{print $1}'
    Should Be Equal                ${output}               drwxr-xr-x.
    
Verify permission of directory /eniq/sw/runtime on reader2
    [Tags]                         II-Reader2
    Set Client Configuration       timeout=25 seconds      prompt=#:
    ${output}=                     Execute Command         ls -ld /eniq/sw/runtime | awk '{print $1}'
    Should Be Equal                ${output}               drwxr-xr-x.
    
Verify permission of directory /eniq/upgrade on reader2
    [Tags]                         II-Reader2
    Set Client Configuration       timeout=25 seconds      prompt=#:
    ${output}=                     Execute Command         ls -ld /eniq/upgrade | awk '{print $1}'
    Should Be Equal                ${output}               drwxr-xr-x.
    
Verify permission of directory /eniq/database/rep_main on reader2
    [Tags]                         II-Reader2
    Set Client Configuration       timeout=25 seconds      prompt=#:
    ${output}=                     Execute Command         ls -ld /eniq/database/rep_main | awk '{print $1}'
    Should Be Equal                ${output}               drwxr-xr-x.
    
Verify permission of directory /eniq/northbound on reader2
    [Tags]                         II-Reader2
    Set Client Configuration       timeout=25 seconds      prompt=#:
    ${output}=                     Execute Command         ls -ld /eniq/northbound | awk '{print $1}'
    Should Be Equal                ${output}               drwxr-xr-x.
    
Verify permission of directory /eniq/northbound/lte_event_stat_file on reader2
    [Tags]                         II-Reader2
    Set Client Configuration       timeout=25 seconds      prompt=#:
    ${output}=                     Execute Command         ls -ld /eniq/northbound/lte_event_stat_file | awk '{print $1}'
    Should Be Equal                ${output}               drwxr-xr-x.

Verify permission of directory /eniq/misc/ldap_db on reader2
    [Tags]                         II-Reader2
    Set Client Configuration       timeout=25 seconds      prompt=#:
    ${output}=                     Execute Command         ls -ld /eniq/misc/ldap_db | awk '{print $1}'
    Should Be Equal                ${output}               drwxr-xr-x.
    
Verify permission of directory /eniq/export on reader2
    [Tags]                         II-Reader2
    Set Client Configuration       timeout=25 seconds      prompt=#:
    ${output}=                     Execute Command         ls -ld /eniq/export | awk '{print $1}'
    Should Be Equal                ${output}               drwxr-xr-x.
    
Verify permission of directory /eniq/fmdata on reader2
    [Tags]                         II-Reader2
    Set Client Configuration       timeout=25 seconds      prompt=#:
    ${output}=                     Execute Command         ls -ld /eniq/fmdata | awk '{print $1}'
    Should Be Equal                ${output}               drwxr-xr-x.
    
Verify permission of directory /eniq/database on reader2
    [Tags]                         II-Reader2
    Set Client Configuration       timeout=25 seconds      prompt=#:
    ${output}=                     Execute Command         ls -ld /eniq/database | awk '{print $1}'
    Should Be Equal                ${output}               drwxr-xr-x.
    
Verify permission of directory /eniq/database/dwh_main_dbspace on reader2
    [Tags]                         II-Reader2
    Set Client Configuration       timeout=25 seconds      prompt=#:
    ${output}=                     Execute Command         ls -ld /eniq/database/dwh_main_dbspace | awk '{print $1}'
    Should Be Equal                ${output}               drwxr-xr-x.
    
Verify permission of directory /eniq/database/dwh_reader on reader2
    [Tags]                         II-Reader2
    Set Client Configuration       timeout=25 seconds      prompt=#:
    ${output}=                     Execute Command         ls -ld /eniq/database/dwh_reader | awk '{print $1}'
    Should Be Equal                ${output}               drwxr-xr-x.
    
Verify permission of directory /eniq/database/dwh_main_dbspace/dbspace_dir_1 on reader2
    [Tags]                         II-Reader2
    Set Client Configuration       timeout=25 seconds      prompt=#:
    ${output}=                     Execute Command         ls -ld /eniq/database/dwh_main_dbspace/dbspace_dir_1 | awk '{print $1}'
    Should Be Equal                ${output}               drwxr-xr-x.
    
Verify permission of directory /eniq/database/dwh_main_dbspace/dbspace_dir_2 on reader2
    [Tags]                         II-Reader2
    Set Client Configuration       timeout=25 seconds      prompt=#:
    ${output}=                     Execute Command         ls -ld /eniq/database/dwh_main_dbspace/dbspace_dir_2 | awk '{print $1}'
    Should Be Equal                ${output}               drwxr-xr-x.
    
Verify permission of directory /eniq/database/dwh_main_dbspace/dbspace_dir_3 on reader2
    [Tags]                         II-Reader2
    Set Client Configuration       timeout=25 seconds      prompt=#:
    ${output}=                     Execute Command         ls -ld /eniq/database/dwh_main_dbspace/dbspace_dir_3 | awk '{print $1}'
    Should Be Equal                ${output}               drwxr-xr-x.
    
Verify permission of directory /eniq/database/dwh_main_dbspace/dbspace_dir_4 on reader2
    [Tags]                         II-Reader2
    Set Client Configuration       timeout=25 seconds      prompt=#:
    ${output}=                     Execute Command         ls -ld /eniq/database/dwh_main_dbspace/dbspace_dir_4 | awk '{print $1}'
    Should Be Equal                ${output}               drwxr-xr-x.
    
Verify permission of directory /eniq/database/dwh_main_dbspace/dbspace_dir_5 on reader2
    [Tags]                         II-Reader2
    Set Client Configuration       timeout=25 seconds      prompt=#:
    ${output}=                     Execute Command         ls -ld /eniq/database/dwh_main_dbspace/dbspace_dir_5 | awk '{print $1}'
    Should Be Equal                ${output}               drwxr-xr-x.
    
Verify permission of directory /eniq/database/dwh_main_dbspace/dbspace_dir_6 on reader2
    [Tags]                         II-Reader2
    Set Client Configuration       timeout=25 seconds      prompt=#:
    ${output}=                     Execute Command         ls -ld /eniq/database/dwh_main_dbspace/dbspace_dir_6 | awk '{print $1}'
    Should Be Equal                ${output}               drwxr-xr-x.
    
Verify permission of directory /eniq/database/dwh_main_dbspace/dbspace_dir_7 on reader2
    [Tags]                         II-Reader2
    Set Client Configuration       timeout=25 seconds      prompt=#:
    ${output}=                     Execute Command         ls -ld /eniq/database/dwh_main_dbspace/dbspace_dir_7 | awk '{print $1}'
    Should Be Equal                ${output}               drwxr-xr-x.
    
Verify permission of directory /eniq/database/dwh_main_dbspace/dbspace_dir_8 on reader2
    [Tags]                         II-Reader2
    Set Client Configuration       timeout=25 seconds      prompt=#:
    ${output}=                     Execute Command         ls -ld /eniq/database/dwh_main_dbspace/dbspace_dir_8 | awk '{print $1}'
    Should Be Equal                ${output}               drwxr-xr-x.
    
Verify permission of directory /eniq/database/dwh_main_dbspace/dbspace_dir_9 on reader2
    [Tags]                         II-Reader2
    Set Client Configuration       timeout=25 seconds      prompt=#:
    ${output}=                     Execute Command         ls -ld /eniq/database/dwh_main_dbspace/dbspace_dir_9 | awk '{print $1}'
    Should Be Equal                ${output}               drwxr-xr-x.
    
Verify permission of directory /eniq/database/dwh_main_dbspace/dbspace_dir_10 on reader2
    [Tags]                         II-Reader2
    Set Client Configuration       timeout=25 seconds      prompt=#:
    ${output}=                     Execute Command         ls -ld /eniq/database/dwh_main_dbspace/dbspace_dir_10 | awk '{print $1}'
    Should Be Equal                ${output}               drwxr-xr-x.
    
Verify permission of directory /eniq/database/dwh_temp_dbspace/dbspace_dir_1 on reader2
    [Tags]                         II-Reader2
    Set Client Configuration       timeout=25 seconds      prompt=#:
    ${output}=                     Execute Command         ls -ld /eniq/database/dwh_temp_dbspace/dbspace_dir_1 | awk '{print $1}'
    Should Be Equal                ${output}               drwxr-xr-x.
    
Verify permission of directory /eniq/database/dwh_temp_dbspace/dbspace_dir_2 on reader2
    [Tags]                         II-Reader2
    Set Client Configuration       timeout=25 seconds      prompt=#:
    ${output}=                     Execute Command         ls -ld /eniq/database/dwh_temp_dbspace/dbspace_dir_2 | awk '{print $1}'
    Should Be Equal                ${output}               drwxr-xr-x.
    
Verify permission of directory /eniq/database/dwh_temp_dbspace/dbspace_dir_3 on reader2
    [Tags]                         II-Reader2
    Set Client Configuration       timeout=25 seconds      prompt=#:
    ${output}=                     Execute Command         ls -ld /eniq/database/dwh_temp_dbspace/dbspace_dir_3 | awk '{print $1}'
    Should Be Equal                ${output}               drwxr-xr-x.
    
Verify permission of directory /eniq/database/dwh_temp_dbspace/dbspace_dir_4 on reader2
    [Tags]                         II-Reader2
    Set Client Configuration       timeout=25 seconds      prompt=#:
    ${output}=                     Execute Command         ls -ld /eniq/database/dwh_temp_dbspace/dbspace_dir_4 | awk '{print $1}'
    Should Be Equal                ${output}               drwxr-xr-x.

Verify permission of directory /eniq/database/dwh_temp_dbspace/dbspace_dir_5 on reader2
    [Tags]                         II-Reader2
    Set Client Configuration       timeout=25 seconds      prompt=#:
    ${output}=                     Execute Command         ls -ld /eniq/database/dwh_temp_dbspace/dbspace_dir_5 | awk '{print $1}'
    Should Be Equal                ${output}               drwxr-xr-x.
    
Verify permission of directory /eniq/northbound/lte_event_ctrs_symlink on reader2
    [Tags]                         II-Reader2
    Set Client Configuration       timeout=25 seconds      prompt=#:
    ${output}=                     Execute Command         ls -ld /eniq/northbound/lte_event_ctrs_symlink | awk '{print $1}'
    Should Be Equal                ${output}               drwxr-xr-x.
    
Verify permission of directory /eniq/data/pmdata_soem on reader2
    [Tags]                         II-Reader2
    Set Client Configuration       timeout=25 seconds      prompt=#:
    ${output}=                     Execute Command         ls -ld /eniq/data/pmdata_soem | awk '{print $1}'
    Should Be Equal                ${output}               drwxr-xr-x.
    
Verify permission of directory /eniq/data/pmdata_sim on reader2
    [Tags]                         II-Reader2
    Set Client Configuration       timeout=25 seconds      prompt=#:
    ${output}=                     Execute Command         ls -ld /eniq/data/pmdata_sim | awk '{print $1}'
    Should Be Equal                ${output}               drwxr-xr-x.

Verify cronjob execution
    [Tags]                         II-Reader2
    Set Client Configuration       timeout=25 seconds      prompt=#:
    ${output}=                     Execute Command         crontab -l | grep -w "disk_partition_check.bsh" | awk -F " " '{print $1}'
        IF                         '${output}' == '0'
        ${pwd}=                    Execute Command         /usr/bin/bash /eniq/installation/core_install/eniq_checks/bin/disk_partition_check.bsh -s
        END

Verify crong flag files
    [Tags]                         II-Reader2
    Set Client Configuration       timeout=25 seconds      prompt=#:
    ${output}=                     Execute Command         crontab -l | grep -w "disk_partition_check.bsh" | awk -F " " '{print $1}'
        IF                          '${output}' == '0'
        ${pwd}=                     Execute Command        ls -lart /var/tmp | grep -i "mpath_iq_value_" | awk -F " " '{print $1}'
        Should Be Equal             ${pwd}                 -rw-r--r--.
        END

