*** Settings ***
Library            SSHLibrary
Library            DateTime
Library            DependencyLibrary

*** Variables ***
${host}         10.150.67.17
${username}     root
${password}     8151@Rhel
${port}         24

*** Variables ***
${bis_mount_path}          /eniq/BIS
${netan_mount_path}        /eniq/netanserver
${ocs_adds_mount_path}     /eniq/OCS/ADDS
${ocs_ccs_mount_path}      /eniq/OCS/CCS
${ocs_vda_mount_path}      /eniq/OCS/VDA
${ocs_without_citrix_mount_path}    /eniq/OCS-WITHOUT-CITRIX
${count}             0
${count_filesize}      0

*** Keywords ***
Open Connection And Log In
    Open Connection    ${host}    ${port}
    Login    ${username}    ${password}    delay=1
    ${curr_date_Y_m_d} =    Get Current Date    result_format=%Y_%m_%d
    Set Global Variable    ${curr_date_Y_m_d}
    ${date_Y-m-d} =    Get Current Date    result_format=%Y-%m-%d
    Set Global Variable    ${date_Y-m-d}
    ${date_dmy} =    Get Current Date    result_format=%d%m%y
    Set Global Variable    ${date_dmy}
    ${date_ymd} =    Execute Command    date +%Y%m%d
    Set Global Variable    ${date_ymd}
    ${yesterday_date}=       Execute Command    /usr/bin/date --date='yesterday' +'%d-%m-%Y'
    Set Global variable      ${yesterday_date}
    ${yesterday_date_dmy}=       Execute Command    /usr/bin/date --date='yesterday' +'%d%m%y'
    Set Global variable      ${yesterday_date_dmy}
    ${yesterday_ymd}=       Execute Command    /usr/bin/date --date='yesterday' +'%Y%m%d'
    Set Global variable      ${yesterday_ymd}
    ${curr_date_y-b-d} =     Execute Command    date +%Y-%b-%d
    Set Global variable      ${curr_date_y-b-d}
    ${curr_date_d.m.y}=      Execute Command    date +%d.%m.%y
    Set Global variable      ${curr_date_d.m.y}
    ${hostname} =    Execute Command    hostname
    Set Global Variable    ${hostname}
    ${hostname_engine} =    Execute Command   cat /etc/hosts | grep engine | cut -d ' ' -f 3
    Set Global Variable    ${hostname_engine}
    ${hostname_reader_1} =    Execute Command   cat /etc/hosts | grep dwh_reader_1 | cut -d ' ' -f 3
    Set Global Variable    ${hostname_reader_1}
    ${hostname_reader_2} =    Execute Command   cat /etc/hosts | grep dwh_reader_2 | cut -d ' ' -f 3
    Set Global Variable    ${hostname_reader_2}
    ${timestamp} =    Execute Command    date +"%H:%M"
    Set Global Variable    ${timestamp}
    @{blade}    Create List    ${hostname}    ${hostname_engine}    ${hostname_reader_1}    ${hostname_reader_2}
    Set Global Variable    @{blade}

Check File Exists
    [Arguments]    ${path}
    Log    ${path}
    File Should Exist    ${path}

Check File Does Not Exists
    [Arguments]    ${path}
    Log    ${path}
    File Should Not Exist    ${path}

Check Directory Exists
    [Arguments]    ${path}
    Log    ${path}
    Directory Should Exist    ${path}

Check File Size
    [Arguments]    ${file}
    Log    ${file}
    Set Client Configuration    timeout=25 seconds      prompt=#:
    ${output} =     Execute Command       ls -lh ${file} | awk '{print $5}'
    Log     ${output}
    Should Not Be Equal As Strings       ${output}       0

Count Of Files
    [Arguments]    ${dir}
    Log    ${dir}
    ${count}=     Execute Command    ls ${dir} | wc -l
    Set Global Variable    ${count}

Check Missing File
    [Arguments]    ${dir1}    ${dir2}
    Log    ${dir1}
    Log    ${dir2}
    ${count1}=    Execute Command    ls ${dir1} | wc -l
    ${count2}=    Execute Command    ls ${dir2} | wc -l
    Should Be Equal    ${count1}    ${count2}

unmounting logs
    [Arguments]    ${mount_path}
    Log    ${mount_path}
    write    umount -l ${mount_path}
    ${output}    Read    delay=5s
    Set Global Variable    ${output}

Check File Size Does Not Exists
    [Arguments]    ${file}
    Log    ${file}
    Set Client Configuration    timeout=25 seconds      prompt=#:
    ${output} =     Execute Command       ls -lh ${file} | awk '{print $5}' | cut -d "K" -f 1 | cut -d "M" -f 1
    Log     ${output}
    Should be Equal As Strings       ${output}       0

Check File Size New
    [Arguments]    ${file}
    Log    ${file}
    Set Client Configuration    timeout=25 seconds      prompt=#:
    ${output} =     Execute Command       ls -lh ${file} | awk '{print $5}' | cut -d "K" -f 1 | cut -d "M" -f 1
    Log     ${output}
    Should Not Be Equal As Strings       ${output}       0
    [Return]    ${output}

Execute Write Command
    [Arguments]    ${write_cmd_args}
    Write    ${write_cmd_args}
    ${output} =     Read    delay= 3s
    [Return]    ${output}

