*** Settings ***
Suite Setup        Open Connection And Log In
Suite Teardown     Close All Connections
Library            SSHLibrary
Resource           ../../Resources/resource.txt
 
*** Variables ***

*** Test Cases ***
Verify permission of directory /eniq/admin
    [Tags]                         II
    Set Client Configuration       timeout=25 seconds      prompt=#:
    ${output}=                     Execute Command         ls -ld /eniq/admin | awk '{print $1}'
    Should Be Equal                ${output}               drwxr-xr-x.
    
Verify permission of directory /eniq/archive
    [Tags]                         II
    Set Client Configuration       timeout=25 seconds      prompt=#:
    ${output}=                     Execute Command         ls -ld /eniq/archive | awk '{print $1}'
    Should Be Equal                ${output}               drwxr-xr-x.
    
Verify permission of directory /eniq/backup
    [Tags]                         II
    Set Client Configuration       timeout=25 seconds      prompt=#:
    ${output}=                     Execute Command         ls -ld /eniq/backup | awk '{print $1}'
    Should Be Equal                ${output}               drwxr-xr-x.
    
Verify permission of directory /eniq/data
    [Tags]                         II
    Set Client Configuration       timeout=25 seconds      prompt=#:
    ${output}=                     Execute Command         ls -ld /eniq/data | awk '{print $1}'
    Should Be Equal                ${output}               drwxr-xr-x.
    
Verify permission of directory /eniq/data/etldata_
    [Tags]                         II
    Set Client Configuration       timeout=25 seconds      prompt=#:
    ${output}=                     Execute Command         ls -ld /eniq/data/etldata_ | awk '{print $1}'
    Should Be Equal                ${output}               drwxr-xr-x.
    
Verify permission of directory /eniq/data/etldata_/00
    [Tags]                         II
    Set Client Configuration       timeout=25 seconds      prompt=#:
    ${output}=                     Execute Command         ls -ld /eniq/data/etldata_/00 | awk '{print $1}'
    Should Be Equal                ${output}               drwxr-xr-x.
    
Verify permission of directory /eniq/data/etldata_/01
    [Tags]                         II
    Set Client Configuration       timeout=25 seconds      prompt=#:
    ${output}=                     Execute Command         ls -ld /eniq/data/etldata_/01 | awk '{print $1}'
    Should Be Equal                ${output}               drwxr-xr-x.

Verify permission of directory /eniq/data/etldata_/02
    [Tags]                         II
    Set Client Configuration       timeout=25 seconds      prompt=#:
    ${output}=                     Execute Command         ls -ld /eniq/data/etldata_/02 | awk '{print $1}'
    Should Be Equal                ${output}               drwxr-xr-x.
    
Verify permission of directory /eniq/data/etldata_/03
    [Tags]                         II
    Set Client Configuration       timeout=25 seconds      prompt=#:
    ${output}=                     Execute Command         ls -ld /eniq/data/etldata_/03 | awk '{print $1}'
    Should Be Equal                ${output}               drwxr-xr-x.
    
Verify permission of directory /eniq/data/pmdata
    [Tags]                         II
    Set Client Configuration       timeout=25 seconds      prompt=#:
    ${output}=                     Execute Command         ls -ld /eniq/data/pmdata | awk '{print $1}'
    Should Be Equal                ${output}               drwxr-xr-x.
    
Verify permission of directory /eniq/data/pmdata/eventdata
    [Tags]                         II
    Set Client Configuration       timeout=25 seconds      prompt=#:
    ${output}=                     Execute Command         ls -ld /eniq/data/pmdata/eventdata | awk '{print $1}'
    Should Be Equal                ${output}               drwxr-xr-x.
    
Verify permission of directory /eniq/data/pmdata/eventdata/00
    [Tags]                         II
    Set Client Configuration       timeout=25 seconds      prompt=#:
    ${output}=                     Execute Command         ls -ld /eniq/data/pmdata/eventdata/00 | awk '{print $1}'
    Should Be Equal                ${output}               drwxr-xr-x.
    
Verify permission of directory /eniq/data/pmdata/eventdata/01
    [Tags]                         II
    Set Client Configuration       timeout=25 seconds      prompt=#:
    ${output}=                     Execute Command         ls -ld /eniq/data/pmdata/eventdata/01 | awk '{print $1}'
    Should Be Equal                ${output}               drwxr-xr-x.
    
Verify permission of directory /eniq/data/pmdata/eventdata/02
    [Tags]                         II
    Set Client Configuration       timeout=25 seconds      prompt=#:
    ${output}=                     Execute Command         ls -ld /eniq/data/pmdata/eventdata/02 | awk '{print $1}'
    Should Be Equal                ${output}               drwxr-xr-x.
    
Verify permission of directory /eniq/data/pmdata/eventdata/03
    [Tags]                         II
    Set Client Configuration       timeout=25 seconds      prompt=#:
    ${output}=                     Execute Command         ls -ld /eniq/data/pmdata/eventdata/03 | awk '{print $1}'
    Should Be Equal                ${output}               drwxr-xr-x.
    
Verify permission of directory /eniq/data/pmdata/eventdata/04
    [Tags]                         II
    Set Client Configuration       timeout=25 seconds      prompt=#:
    ${output}=                     Execute Command         ls -ld /eniq/data/pmdata/eventdata/04 | awk '{print $1}'
    Should Be Equal                ${output}               drwxr-xr-x.
    
Verify permission of directory /eniq/data/pmdata/eventdata/05
    [Tags]                         II
    Set Client Configuration       timeout=25 seconds      prompt=#:
    ${output}=                     Execute Command         ls -ld /eniq/data/pmdata/eventdata/05 | awk '{print $1}'
    Should Be Equal                ${output}               drwxr-xr-x.
    
Verify permission of directory /eniq/data/pmdata/eventdata/06
    [Tags]                         II
    Set Client Configuration       timeout=25 seconds      prompt=#:
    ${output}=                     Execute Command         ls -ld /eniq/data/pmdata/eventdata/06 | awk '{print $1}'
    Should Be Equal                ${output}               drwxr-xr-x.
    
Verify permission of directory /eniq/data/pmdata/eventdata/07
    [Tags]                         II
    Set Client Configuration       timeout=25 seconds      prompt=#:
    ${output}=                     Execute Command         ls -ld /eniq/data/pmdata/eventdata/07 | awk '{print $1}'
    Should Be Equal                ${output}               drwxr-xr-x.
    
Verify permission of directory /eniq/data/pmdata/eventdata/08
    [Tags]                         II
    Set Client Configuration       timeout=25 seconds      prompt=#:
    ${output}=                     Execute Command         ls -ld /eniq/data/pmdata/eventdata/08 | awk '{print $1}'
    Should Be Equal                ${output}               drwxr-xr-x.
    
Verify permission of directory /eniq/data/pmdata/eventdata/09
    [Tags]                         II
    Set Client Configuration       timeout=25 seconds      prompt=#:
    ${output}=                     Execute Command         ls -ld /eniq/data/pmdata/eventdata/09 | awk '{print $1}'
    Should Be Equal                ${output}               drwxr-xr-x.
    
Verify permission of directory /eniq/data/pmdata/eventdata/10
    [Tags]                         II
    Set Client Configuration       timeout=25 seconds      prompt=#:
    ${output}=                     Execute Command         ls -ld /eniq/data/pmdata/eventdata/10 | awk '{print $1}'
    Should Be Equal                ${output}               drwxr-xr-x.
    
Verify permission of directory /eniq/data/pmdata/eventdata/11
    [Tags]                         II
    Set Client Configuration       timeout=25 seconds      prompt=#:
    ${output}=                     Execute Command         ls -ld /eniq/data/pmdata/eventdata/11 | awk '{print $1}'
    Should Be Equal                ${output}               drwxr-xr-x.
    
Verify permission of directory /eniq/data/pmdata/eventdata/12
    [Tags]                         II
    Set Client Configuration       timeout=25 seconds      prompt=#:
    ${output}=                     Execute Command         ls -ld /eniq/data/pmdata/eventdata/12 | awk '{print $1}'
    Should Be Equal                ${output}               drwxr-xr-x.
    
Verify permission of directory /eniq/data/pmdata/eventdata/13
    [Tags]                         II
    Set Client Configuration       timeout=25 seconds      prompt=#:
    ${output}=                     Execute Command         ls -ld /eniq/data/pmdata/eventdata/13 | awk '{print $1}'
    Should Be Equal                ${output}               drwxr-xr-x.
    
Verify permission of directory /eniq/data/pmdata/eventdata/14
    [Tags]                         II
    Set Client Configuration       timeout=25 seconds      prompt=#:
    ${output}=                     Execute Command         ls -ld /eniq/data/pmdata/eventdata/14 | awk '{print $1}'
    Should Be Equal                ${output}               drwxr-xr-x.
    
Verify permission of directory /eniq/data/pmdata/eventdata/15
    [Tags]                         II
    Set Client Configuration       timeout=25 seconds      prompt=#:
    ${output}=                     Execute Command         ls -ld /eniq/data/pmdata/eventdata/15 | awk '{print $1}'
    Should Be Equal                ${output}               drwxr-xr-x.
    
Verify permission of directory /eniq/database/dwh_main
    [Tags]                         II
    Set Client Configuration       timeout=25 seconds      prompt=#:
    ${output}=                     Execute Command         ls -ld /eniq/database/dwh_main | awk '{print $1}'
    Should Be Equal                ${output}               drwxr-xr-x.
    
Verify permission of directory /eniq/glassfish
    [Tags]                         II
    Set Client Configuration       timeout=25 seconds      prompt=#:
    ${output}=                     Execute Command         ls -ld /eniq/glassfish | awk '{print $1}'
    Should Be Equal                ${output}               drwxr-xr-x.
    
Verify permission of directory /eniq/home
    [Tags]                         II
    Set Client Configuration       timeout=25 seconds      prompt=#:
    ${output}=                     Execute Command         ls -ld /eniq/home | awk '{print $1}'
    Should Be Equal                ${output}               drwxr-xr-x.
    
Verify permission of directory /eniq/log
    [Tags]                         II
    Set Client Configuration       timeout=25 seconds      prompt=#:
    ${output}=                     Execute Command         ls -ld /eniq/log | awk '{print $1}'
    Should Be Equal                ${output}               drwxr-xr-x.
    
Verify permission of directory /eniq/mediation_sw
    [Tags]                         II
    Set Client Configuration       timeout=25 seconds      prompt=#:
    ${output}=                     Execute Command         ls -ld /eniq/mediation_sw | awk '{print $1}'
    Should Be Equal                ${output}               drwxr-xr-x.
    
Verify permission of directory /eniq/mediation_inter
    [Tags]                         II
    Set Client Configuration       timeout=25 seconds      prompt=#:
    ${output}=                     Execute Command         ls -ld /eniq/mediation_inter | awk '{print $1}'
    Should Be Equal                ${output}               drwxr-xr-x.
    
Verify permission of directory /eniq/sentinel
    [Tags]                         II
    Set Client Configuration       timeout=25 seconds      prompt=#:
    ${output}=                     Execute Command         ls -ld /eniq/sentinel | awk '{print $1}'
    Should Be Equal                ${output}               drwxr-xr-x.
    
Verify permission of directory /eniq/smf
    [Tags]                         II
    Set Client Configuration       timeout=25 seconds      prompt=#:
    ${output}=                     Execute Command         ls -ld /eniq/smf | awk '{print $1}'
    Should Be Equal                ${output}               drwxr-xr-x.
    
Verify permission of directory /eniq/snapshot
    [Tags]                         II
    Set Client Configuration       timeout=25 seconds      prompt=#:
    ${output}=                     Execute Command         ls -ld /eniq/snapshot | awk '{print $1}'
    Should Be Equal                ${output}               drwxr-xr-x.
    
Verify permission of directory /eniq/sybase_iq
    [Tags]                         II
    Set Client Configuration       timeout=25 seconds      prompt=#:
    ${output}=                     Execute Command         ls -ld /eniq/sybase_iq | awk '{print $1}'
    Should Be Equal                ${output}               drwxr-xr-x.
    
Verify permission of directory /eniq/sw
    [Tags]                         II
    Set Client Configuration       timeout=25 seconds      prompt=#:
    ${output}=                     Execute Command         ls -ld /eniq/sw | awk '{print $1}'
    Should Be Equal                ${output}               drwxr-xr-x.
    
Verify permission of directory /eniq/sw/bin
    [Tags]                         II
    Set Client Configuration       timeout=25 seconds      prompt=#:
    ${output}=                     Execute Command         ls -ld /eniq/sw/bin | awk '{print $1}'
    Should Be Equal                ${output}               drwxr-xr-x.
    
Verify permission of directory /eniq/sw/conf
    [Tags]                         II
    Set Client Configuration       timeout=25 seconds      prompt=#:
    ${output}=                     Execute Command         ls -ld /eniq/sw/conf | awk '{print $1}'
    Should Be Equal                ${output}               drwxr-xr-x.
    
Verify permission of directory /eniq/sw/installer
    [Tags]                         II
    Set Client Configuration       timeout=25 seconds      prompt=#:
    ${output}=                     Execute Command         ls -ld /eniq/sw/installer | awk '{print $1}'
    Should Be Equal                ${output}               drwxr-xr-x.
    
Verify permission of directory /eniq/sw/log
    [Tags]                         II
    Set Client Configuration       timeout=25 seconds      prompt=#:
    ${output}=                     Execute Command         ls -ld /eniq/sw/log | awk '{print $1}'
    Should Be Equal                ${output}               drwxr-xr-x.
    
Verify permission of directory /eniq/sw/platform
    [Tags]                         II
    Set Client Configuration       timeout=25 seconds      prompt=#:
    ${output}=                     Execute Command         ls -ld /eniq/sw/platform | awk '{print $1}'
    Should Be Equal                ${output}               drwxr-xr-x.
    
Verify permission of directory /eniq/sw/runtime
    [Tags]                         II
    Set Client Configuration       timeout=25 seconds      prompt=#:
    ${output}=                     Execute Command         ls -ld /eniq/sw/runtime | awk '{print $1}'
    Should Be Equal                ${output}               drwxr-xr-x.
    
Verify permission of directory /eniq/upgrade
    [Tags]                         II
    Set Client Configuration       timeout=25 seconds      prompt=#:
    ${output}=                     Execute Command         ls -ld /eniq/upgrade | awk '{print $1}'
    Should Be Equal                ${output}               drwxr-xr-x.
    
Verify permission of directory /eniq/database/rep_main
    [Tags]                         II
    Set Client Configuration       timeout=25 seconds      prompt=#:
    ${output}=                     Execute Command         ls -ld /eniq/database/rep_main | awk '{print $1}'
    Should Be Equal                ${output}               drwxr-xr-x.
    
Verify permission of directory /eniq/northbound
    [Tags]                         II
    Set Client Configuration       timeout=25 seconds      prompt=#:
    ${output}=                     Execute Command         ls -ld /eniq/northbound | awk '{print $1}'
    Should Be Equal                ${output}               drwxr-xr-x.
    
Verify permission of directory /eniq/northbound/lte_event_stat_file
    [Tags]                         II
    Set Client Configuration       timeout=25 seconds      prompt=#:
    ${output}=                     Execute Command         ls -ld /eniq/northbound/lte_event_stat_file | awk '{print $1}'
    Should Be Equal                ${output}               drwxr-xr-x.

Verify permission of directory /eniq/misc/ldap_db
    [Tags]                         II
    Set Client Configuration       timeout=25 seconds      prompt=#:
    ${output}=                     Execute Command         ls -ld /eniq/misc/ldap_db | awk '{print $1}'
    Should Be Equal                ${output}               drwxr-xr-x.
    
Verify permission of directory /eniq/export
    [Tags]                         II
    Set Client Configuration       timeout=25 seconds      prompt=#:
    ${output}=                     Execute Command         ls -ld /eniq/export | awk '{print $1}'
    Should Be Equal                ${output}               drwxr-xr-x.
    
Verify permission of directory /eniq/fmdata
    [Tags]                         II
    Set Client Configuration       timeout=25 seconds      prompt=#:
    ${output}=                     Execute Command         ls -ld /eniq/fmdata | awk '{print $1}'
    Should Be Equal                ${output}               drwxr-xr-x.
    
Verify permission of directory /eniq/database
    [Tags]                         II
    Set Client Configuration       timeout=25 seconds      prompt=#:
    ${output}=                     Execute Command         ls -ld /eniq/database | awk '{print $1}'
    Should Be Equal                ${output}               drwxr-xr-x.
    
Verify permission of directory /eniq/database/dwh_main_dbspace
    [Tags]                         II
    Set Client Configuration       timeout=25 seconds      prompt=#:
    ${output}=                     Execute Command         ls -ld /eniq/database/dwh_main_dbspace | awk '{print $1}'
    Should Be Equal                ${output}               drwxr-xr-x.
    
Verify permission of directory /eniq/database/dwh_reader
    [Tags]                         II
    Set Client Configuration       timeout=25 seconds      prompt=#:
    ${output}=                     Execute Command         ls -ld /eniq/database/dwh_reader | awk '{print $1}'
    Should Be Equal                ${output}               drwxr-xr-x.
    
Verify permission of directory /eniq/database/dwh_main_dbspace/dbspace_dir_1
    [Tags]                         II
    Set Client Configuration       timeout=25 seconds      prompt=#:
    ${output}=                     Execute Command         ls -ld /eniq/database/dwh_main_dbspace/dbspace_dir_1 | awk '{print $1}'
    Should Be Equal                ${output}               drwxr-xr-x.
    
Verify permission of directory /eniq/database/dwh_main_dbspace/dbspace_dir_2
    [Tags]                         II
    Set Client Configuration       timeout=25 seconds      prompt=#:
    ${output}=                     Execute Command         ls -ld /eniq/database/dwh_main_dbspace/dbspace_dir_2 | awk '{print $1}'
    Should Be Equal                ${output}               drwxr-xr-x.
    
Verify permission of directory /eniq/database/dwh_main_dbspace/dbspace_dir_3
    [Tags]                         II
    Set Client Configuration       timeout=25 seconds      prompt=#:
    ${output}=                     Execute Command         ls -ld /eniq/database/dwh_main_dbspace/dbspace_dir_3 | awk '{print $1}'
    Should Be Equal                ${output}               drwxr-xr-x.
    
Verify permission of directory /eniq/database/dwh_main_dbspace/dbspace_dir_4
    [Tags]                         II
    Set Client Configuration       timeout=25 seconds      prompt=#:
    ${output}=                     Execute Command         ls -ld /eniq/database/dwh_main_dbspace/dbspace_dir_4 | awk '{print $1}'
    Should Be Equal                ${output}               drwxr-xr-x.
    
Verify permission of directory /eniq/database/dwh_main_dbspace/dbspace_dir_5
    [Tags]                         II
    Set Client Configuration       timeout=25 seconds      prompt=#:
    ${output}=                     Execute Command         ls -ld /eniq/database/dwh_main_dbspace/dbspace_dir_5 | awk '{print $1}'
    Should Be Equal                ${output}               drwxr-xr-x.
    
Verify permission of directory /eniq/database/dwh_main_dbspace/dbspace_dir_6
    [Tags]                         II
    Set Client Configuration       timeout=25 seconds      prompt=#:
    ${output}=                     Execute Command         ls -ld /eniq/database/dwh_main_dbspace/dbspace_dir_6 | awk '{print $1}'
    Should Be Equal                ${output}               drwxr-xr-x.
    
Verify permission of directory /eniq/database/dwh_main_dbspace/dbspace_dir_7
    [Tags]                         II
    Set Client Configuration       timeout=25 seconds      prompt=#:
    ${output}=                     Execute Command         ls -ld /eniq/database/dwh_main_dbspace/dbspace_dir_7 | awk '{print $1}'
    Should Be Equal                ${output}               drwxr-xr-x.
    
Verify permission of directory /eniq/database/dwh_main_dbspace/dbspace_dir_8
    [Tags]                         II
    Set Client Configuration       timeout=25 seconds      prompt=#:
    ${output}=                     Execute Command         ls -ld /eniq/database/dwh_main_dbspace/dbspace_dir_8 | awk '{print $1}'
    Should Be Equal                ${output}               drwxr-xr-x.
    
Verify permission of directory /eniq/database/dwh_main_dbspace/dbspace_dir_9
    [Tags]                         II
    Set Client Configuration       timeout=25 seconds      prompt=#:
    ${output}=                     Execute Command         ls -ld /eniq/database/dwh_main_dbspace/dbspace_dir_9 | awk '{print $1}'
    Should Be Equal                ${output}               drwxr-xr-x.
    
Verify permission of directory /eniq/database/dwh_main_dbspace/dbspace_dir_10
    [Tags]                         II
    Set Client Configuration       timeout=25 seconds      prompt=#:
    ${output}=                     Execute Command         ls -ld /eniq/database/dwh_main_dbspace/dbspace_dir_10 | awk '{print $1}'
    Should Be Equal                ${output}               drwxr-xr-x.
    
Verify permission of directory /eniq/database/dwh_temp_dbspace/dbspace_dir_1
    [Tags]                         II
    Set Client Configuration       timeout=25 seconds      prompt=#:
    ${output}=                     Execute Command         ls -ld /eniq/database/dwh_temp_dbspace/dbspace_dir_1 | awk '{print $1}'
    Should Be Equal                ${output}               drwxr-xr-x.
    
Verify permission of directory /eniq/database/dwh_temp_dbspace/dbspace_dir_2
    [Tags]                         II
    Set Client Configuration       timeout=25 seconds      prompt=#:
    ${output}=                     Execute Command         ls -ld /eniq/database/dwh_temp_dbspace/dbspace_dir_2 | awk '{print $1}'
    Should Be Equal                ${output}               drwxr-xr-x.
    
Verify permission of directory /eniq/database/dwh_temp_dbspace/dbspace_dir_3
    [Tags]                         II
    Set Client Configuration       timeout=25 seconds      prompt=#:
    ${output}=                     Execute Command         ls -ld /eniq/database/dwh_temp_dbspace/dbspace_dir_3 | awk '{print $1}'
    Should Be Equal                ${output}               drwxr-xr-x.
    
Verify permission of directory /eniq/database/dwh_temp_dbspace/dbspace_dir_4
    [Tags]                         II
    Set Client Configuration       timeout=25 seconds      prompt=#:
    ${output}=                     Execute Command         ls -ld /eniq/database/dwh_temp_dbspace/dbspace_dir_4 | awk '{print $1}'
    Should Be Equal                ${output}               drwxr-xr-x.

Verify permission of directory /eniq/database/dwh_temp_dbspace/dbspace_dir_5
    [Tags]                         II
    Set Client Configuration       timeout=25 seconds      prompt=#:
    ${output}=                     Execute Command         ls -ld /eniq/database/dwh_temp_dbspace/dbspace_dir_5 | awk '{print $1}'
    Should Be Equal                ${output}               drwxr-xr-x.
    
Verify permission of directory /eniq/northbound/lte_event_ctrs_symlink
    [Tags]                         II
    Set Client Configuration       timeout=25 seconds      prompt=#:
    ${output}=                     Execute Command         ls -ld /eniq/northbound/lte_event_ctrs_symlink | awk '{print $1}'
    Should Be Equal                ${output}               drwxr-xr-x.
    
Verify permission of directory /eniq/data/pmdata_soem
    [Tags]                         II
    Set Client Configuration       timeout=25 seconds      prompt=#:
    ${output}=                     Execute Command         ls -ld /eniq/data/pmdata_soem | awk '{print $1}'
    Should Be Equal                ${output}               drwxr-xr-x.
    
Verify permission of directory /eniq/data/pmdata_sim
    [Tags]                         II
    Set Client Configuration       timeout=25 seconds      prompt=#:
    ${output}=                     Execute Command         ls -ld /eniq/data/pmdata_sim | awk '{print $1}'
    Should Be Equal                ${output}               drwxr-xr-x.
