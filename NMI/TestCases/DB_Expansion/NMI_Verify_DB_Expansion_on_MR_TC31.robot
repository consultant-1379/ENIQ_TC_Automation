*** Settings ***
Library           OperatingSystem

*** Test Cases ***
Checking if core install stage - create_disk_partition is entered successfully
    [Tags]                DB-Expansion  MB
    ${DB_MB_Log}=         Get File                  DB_expansion_automation.log
    Set Global Variable   ${DB_MB_Log}
    Should Contain        ${DB_MB_Log}              Entering core install stage - create_disk_partition

Checking if partitions over data disks are succcesfully created
    [Tags]                DB-Expansion  MB
    Should Contain        ${DB_MB_Log}              Successfully created partitions over data disks

Checking if core install stage - create_lun_map is entered successfully
    [Tags]                DB-Expansion  MB
    Should Contain        ${DB_MB_Log}              Entering core install stage - create_lun_map

Checking if LUN Map ini file is created successfully
    [Tags]                DB-Expansion  MB
    Should Contain        ${DB_MB_Log}              Successfully created LUN Map ini file 

Checking if execution of /eniq/admin/bin/update_cell_node_count.bsh is started
    [Tags]                DB-Expansion  MB
    Should Contain        ${DB_MB_Log}              Starting to execute /eniq/admin/bin/update_cell_node_count.bsh

Checking if core install stage - create_db_sym_links is entered successfully
    [Tags]                DB-Expansion  MB
    Should Contain        ${DB_MB_Log}              Entering core install stage - create_db_sym_links

Checking if DB Sym Links are created successfully
    [Tags]                DB-Expansion  MB
    Should Contain        ${DB_MB_Log}              Successfully created DB Sym Links

Checking if mainDB files are added successfully
    [Tags]                DB-Expansion  MB
    Should Contain        ${DB_MB_Log}              Successfully added mainDB files
