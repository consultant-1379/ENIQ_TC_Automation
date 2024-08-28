*** Settings ***
Resource          ../../Resources/login.resource
Library     ../../Resources/tp.py
Library    RPA.RobotLogListener
Library    Collections
Library    Process
Test Setup        Open Connection And Log In
Test Teardown     Close All Connections

*** Variables ***
${dim_pkg}    DIM_E_GRAN
${path_of_pkg_on_jenkins}   /root
${latest_TP_found}    False
@{Interfaces_to_update}
@{test}    1    0    1    0    0    1    1    2
${element}    INTF_DIM_E_CN_HLRCL
${path}    /root/CI/cicd/bin/activate/workspace/TP_ROBOT
${date}    2022-11-06 10:00:00
${full_pkg_name}    DIM_E_CN_R10A_b12.tpi

${password_dwhdb}      Dc12#
${username_dwhdb}      dc
${database_dwhdb}      dwhdb
${cell_sql}    select CELL_NAME,OSS_ID,BSC_NAME from DIM_E_GRAN_CELL
${nrel_sql}    Select NEIGHBORCELL,OSS_ID,NEIGHBORBSC from DIM_E_GRAN_NETOP_CELL_NREL where neighborBsc!=''
${sql_cell}    select distinct OSS_ID,BSC_NAME,CELL_BAND,CELL_ID,CELL_LAYER,CELL_NAME,CELL_TYPE,FPDCH,LAC,MCC,MNC,MSC,SITE_NAME,VENDOR,STATUS,CREATED,MODIFIED,MODIFIER from DIM_E_GRAN_CELL
${sql_netop_cell}    Select distinct OSS_ID,BSC_NAME,CELL_BAND,CELL_ID,CELL_LAYER,CELL_NAME,CELL_TYPE,FPDCH,LAC,MCC,MNC,MSC,SITE_NAME,VENDOR,STATUS,CREATED,MODIFIED,MODIFIER from DIM_E_GRAN_NETOP_CELL
${BSC_SQL}    select BSC_TYPE,OSS_ID,BSC_ID,BSC_FDN,BSC_NAME,BSC_VERSION,SITE,SITE_FDN,SOURCE_FILE,SOURCE_TYPE,SUBNETWORK1,SUBNETWORK2,TRX,VENDOR,STATUS,CREATED,MODIFIED,MODIFIER from DIM_E_GRAN_BSC
${TRC_SQL}    select TRC_TYPE,OSS_ID,TRC_ID,TRC_FDN,TRC_NAME,TRC_VERSION,SITE,SITE_FDN,SOURCE_FILE,SOURCE_TYPE,SUBNETWORK1,SUBNETWORK2,TRX,VENDOR,STATUS,CREATED,MODIFIED,MODIFIER from DIM_E_GRAN_TRC
${BSCTRC_SQL}    select NE_TYPE,OSS_ID,NE_ID,NE_FDN,NE_NAME,NE_VERSION,SITE,SITE_FDN,SOURCE_FILE,SOURCE_TYPE,SUBNETWORK1,SUBNETWORK2,TRX,VENDOR,STATUS,CREATED,MODIFIED,MODIFIER from DIM_E_GRAN_BSCTRC
${ERBS_package}         DC_E_ERBS
${ERBSG2_package}       DC_E_ERBSG2
${epfg_mws}    /net/10.45.192.153/JUMP/EPFG_FT
${mws_path}    /net/10.45.192.153/JUMP/ENIQ_STATS/ENIQ_STATS
*** Test Cases ***
# Common Topology
#     Test
#     Get dimpkg Name
#     checking services
#     Verify the latest dim TP in Adminui
#     Installing latest TP
#     verifying TP Installation
#     Verify TP installer Log
#     Fetch Rstate of Interface from AdminUI and Clearcase
#     Installing dependent interfaces
#     Activating Interface
#     Verify Interface Activation
#     Verify Interface installer Log
#     Setting Loader Configuration To Finest
# 	  Download Latest Epfg
# 	  Install Epfg 
#     Generating Topology files
#     Loading Topology Files
#     Loading Topo checking
#     Verify All Loader Tables
#     Area Files check for DIM_RAN_AREA
#     Area Files check for DIM_BSS_AREA
#     Area Files check for LTE and NR
#     Ascii File Loading
#     Validate ASCII Loading
# *** Keywords ***
Test
    Open connection as root user
    Set Client Configuration    prompt=eniqs[eniq_stats] {root} #:    timeout=300
    Execute Command    bash /eniq/installation/core_install/bin/get_cell_count.bsh -d /eniq/installation/config/ -g /var/tmp -t raw -e stats -l /tmp/get_cell_count.log
    ${out}=    Execute Command    cd /eniq/admin/bin ; echo -e "Yes\\n" | bash ./manage_eniq_services.bsh -a start -s ALL
    Log    ${out}

Get dimpkg Name
    @{temp}=    Split String From Right    ${full_pkg_name}    separator=_R    max_split=1
    ${dim_pkg}=    Set Variable    ${temp}[0]
    Set Global Variable    ${dim_pkg}

TP - ENIQ_TP_UG_TC29 , TP - ENIQ_TP_UG_TC30 checking services
    Write    cd 
    Read    delay=10s
    Open connection as root user
    Set Client Configuration    prompt=eniqs[eniq_stats] {root} #:    timeout=300
    Write    cd /eniq/admin/bin ; bash ./manage_eniq_services.bsh -a list -s ALL
    ${out}=    Read Until Prompt
    ${list_of_services_inactive}=    Services List    ${out}
    FOR    ${element}    IN    @{list_of_services_inactive}
        Write    echo -e "Yes" | bash ./manage_eniq_services.bsh -a restart -s ${element}
        ${out1}=    Read Until Prompt
    END
    Switch Connection    ${index}
    Set Client Configuration    prompt=eniqs[eniq_stats] {dcuser} #:    timeout=3600
    Write    services -s eniq
    ${output}=    Read Until Prompt
    ${other_Status}    System Status    ${output}
    IF    ${other_Status} == []
        Log To Console    Everything is working fine
        Write    engine -e status
        ${output2}=    Read Until Prompt 
        ${engine_profile}=    Getting Engine Profile    ${output2}
        IF    '${engine_profile}' == 'Current Profile: NoLoads'
            Write    engine -e changeProfile 'Normal'
            ${output3}=    Read Until Prompt
            ${contains}=    Run Keyword And Return Status    Should Contain    ${output3}    Change profile requested successfully
            IF    '${contains}' != 'True'
                Fail
            END
        END
    ELSE
        Log To Console    ${other_Status}services${SPACE}are${SPACE}down
        IF    ${other_Status} == ['eniq-engine']
            Log To Console    only engine service is down
            Write    engine restart
            ${output1}=    Read Until Prompt
            Write    engine -e status
            ${output2}=    Read Until Prompt 
            ${engine_profile}=    Getting Engine Profile    ${output2}
            IF    '${engine_profile}' == 'Current Profile: NoLoads'
                Write    engine -e changeProfile 'NoLoads'
                ${output3}=    Read Until Prompt
                ${contains}=    Run Keyword And Return Status    Should Contain    ${output3}    Change profile requested successfully
                IF    '${contains}' != 'True'
                    Fail
                END
            END         
        ELSE
            Fail
        END

    END

    
TP - ENIQ_TP_UG_TC31 Verify the latest dim TP in Adminui
    Write    cd 
    Read    delay=10s
    Set Client Configuration    prompt=eniqs[eniq_stats] {dcuser} #:    timeout=3600
    # Open clearcasevobs
    # ${rstate}    Get Text    //table//a[text()='${dim_pkg}']/../following-sibling::td[3]
    # ${temp}=    Get Element Attribute    //table//a[text()='${dim_pkg}']    href
    # ${temp1}=    Fetch From Right    ${temp}    /
    # Set Global Variable    ${full_pkg_name}    ${temp1}
    Set Client Configuration    prompt=eniqs[eniq_stats] {dcuser} #:    timeout=3600
    ${latest_mws_path}=   Execute Command    cd ${mws_path};ls -t Features_* | head -n 1
    ${latest_mws_path}    Split String    ${latest_mws_path}    :
    Set Global Variable    ${latest_mws_path}
    ${full_dim_pkg_name}=   Execute Command    cd ${mws_path}/${latest_mws_path}[0]/eniq_techpacks;ls -Art ${dim_pkg}*.tpi | tail -n 1
    # Write    ls
    Log    ${full_dim_pkg_name}
    Set Global Variable     ${full_dim_pkg_name}
    ${rstate}    Split String    ${full_dim_pkg_name}    ${dim_pkg}_
    ${rstate}    Split String    ${rstate}[1]    _
    Log    ${rstate}[0]
    Write    echo -e "select TOP 1 TECHPACK_VERSION from Versioning where TECHPACK_NAME = '${dim_pkg}' ORDER BY TECHPACK_VERSION Desc\\n${run}\\n" | isql -P ${password_db} -U ${username} -S ${database} -b
    ${output1}=    Read Until Prompt
    ${rstate_adminui}=    tp.Filter Name    ${output1}
    IF    '${rstate}[0]' != '${rstate_adminui}'
        # Go To    ${solarisLink}
        # ${currentpkg}=    Get Element Attribute     xpath=//a[text()='${dim_pkg}']    href
        # Open Connection    ${jnkns_server}
        # Login               root        shroot
        # Write    rm -rf tppkg ; mkdir tppkg ; cd tppkg ; wget ${currentpkg} ; pwd
        # Read    delay=10s
        # Switch Connection    ${index}
        Set Client Configuration    prompt=eniqs[eniq_stats] {dcuser} #:    timeout=3600
        Write    cd ${mws_path}
        Write    cd ${latest_mws_path}[0]/eniq_techpacks
        Write    ls
        Write    scp -r ${full_dim_pkg_name} /eniq/sw/installer
        ${transfer}    Read    delay=10s
        Set Global Variable     ${latest_TP_found}    True   
    ELSE
        Log To Console    Latest Dim Tp already installed
    END

TP - ENIQ_TP_UG_TC32,TP - ENIQ_TP_UG_TC33,TP - ENIQ_TP_UG_TC34 Installing latest TP
    Write    cd 
    Read    delay=10s
    IF    '${latest_TP_found}' == 'True'
        Set Client Configuration    prompt=eniqs[eniq_stats] {dcuser} #:    timeout=3600
        #Put File    ${path_of_pkg_on_jenkins}/tppkg/${full_pkg_name}    /eniq/sw/installer
        #Put File    H:/Downloads/${full_pkg_name}    /eniq/sw/installer
        Write    cd /eniq/sw/installer ; rm -rf tp_stage_file ; rm -rf install_lockfile 
        Read Until Prompt
        Write    cd /eniq/sw/installer ; ./tp_installer -p . -t ${dim_pkg}
        #Read Until Prompt
        ${out}=    Read Until Prompt
    END
TP - ENIQ_TP_UG_TC35 verifying TP Installation
    Write    cd 
    Read    delay=10s
    IF    '${latest_TP_found}' == 'True'
        Set Client Configuration    prompt=eniqs[eniq_stats] {dcuser} #:    timeout=3600
        Write    echo -e "select TECHPACK_VERSION from Versioning where TECHPACK_NAME='${dim_pkg}'\\n${run}\\n" | isql -P ${password_db} -U ${username} -S ${database} -b
        ${output1}=    Read Until Prompt
        ${new_rstate_inDB}=    Filter Latest Name    ${output1}
        Write    echo -e "select top 1 VERSIONID from Versioning where TECHPACK_NAME='${dim_pkg}' order by versionid desc\\n${run}\\n" | isql -P ${password_db} -U ${username} -S ${database} -b
        ${output2}=    Read Until Prompt 
        ${temp}=    Filter Latest Name    ${output2}
        ${temp1}=    Give Build Number    ${temp}
        ${full_pkg_name_in_db}=    Catenate    SEPARATOR=_    ${dim_pkg}    ${new_rstate_inDB}    b${temp1}.tpi    
        Set Global Variable    ${full_pkg_name_in_db}    ${full_pkg_name_in_db}
        IF    '${full_dim_pkg_name}' != '${full_pkg_name_in_db}'
            Fail
        END
    END

TP - ENIQ_TP_UG_TC36 Verify TP installer Log
    Write    cd 
    Read    delay=10s
    IF    '${latest_TP_found}' == 'True'
        ${stat}=    Checking Tp Installer Log    ${dim_pkg}    ${full_dim_pkg_name}    ${host}    ${port}    ${uname}    ${pwd}
        IF    '${stat}' == 'fail'
            Fail
        END
    END

TP - ENIQ_TP_UG_TC37,TP - ENIQ_TP_UG_TC38 Fetch Rstate of Interface from AdminUI and Clearcase
    Write    cd 
    Read    delay=10s
    Set Client Configuration    prompt=eniqs[eniq_stats] {dcuser} #:    timeout=3600
    Write    echo -e "select INTERFACENAME from InterfaceTechpacks where TECHPACKNAME='${dim_pkg}'\\n${run}\\n" | isql -P ${password_db} -U ${username} -S ${database} -b
    ${output1}=    Read Until Prompt
    ${dep_int}=    Filter Interfaces    ${output1}
    FOR    ${intf_name}    IN    @{dep_int}
        Set Client Configuration    prompt=eniqs[eniq_stats] {dcuser} #:    timeout=3600
        Write    cd 
        Read    delay=10s
        Write    echo -e "select RSTATE from DataInterface where INTERFACENAME LIKE '${intf_name}'\\n${run}\\n" | isql -P ${password_db} -U ${username} -S ${database} -b
        ${output1}=    Read Until Prompt
        ${new_rstate_inDB}=    Filter Name    ${output1}
        Write    echo -e "select INTERFACEVERSION from DataInterface where INTERFACENAME LIKE '${intf_name}'\\n${run}\\n" | isql -P ${password_db} -U ${username} -S ${database} -b
        ${output2}=    Read Until Prompt 
        ${temp}=    Filter Name    ${output2}
        ${temp1}=    Give Build Number    ${temp}
        ${full_intf_deta}=    Catenate    SEPARATOR=_    ${intf_name}    ${new_rstate_inDB}    b${temp1}.tpi
		# Open clearcasevobs
		# ${temp}=    Get Element Attribute    //table//a[text()='${intf_name}']    href
        # ${temp1}=    Fetch From Right    ${temp}    /
        Set Client Configuration    prompt=eniqs[eniq_stats] {dcuser} #:    timeout=3600
        Write    cd ${mws_path} 
        Read    delay=10s
        Write    cd ${latest_mws_path}[0]/eniq_techpacks
        Read    delay=10s
        Write    ls   
        Read    delay=10s 
        ${temp2}=   Execute Command    cd ${mws_path}/${latest_mws_path}[0]/eniq_techpacks;ls -Art ${intf_name}_R*.tpi | tail -n 1
        # Write    ls
        Log    ${temp2}
		IF    '${temp2}' != '${full_intf_deta}'
		Log To Console    ${\n}Rstate not equal
        Append To List    ${Interfaces_to_update}    ${intf_name}
		# Downloading TP from vobs    ${pkg}[0]
		# Installing TP    ${pkg}[0]
		ELSE
			Log To Console   ${\n}Rstate of ${temp1} in both places are equal
		END
		# Execute Command    cd /eniq/sw/installer ; ./activate_interface -o eniq_oss_1 -t ${intf_name}
        Sleep    300s
	END
    Set Global Variable    ${Interfaces_to_update}

TP - ENIQ_TP_UG_TC39,TP - ENIQ_TP_UG_TC40,TP - ENIQ_TP_UG_TC41 Installing dependent interfaces
    Write    cd 
    Read    delay=10s
    Set Client Configuration    prompt=eniqs[eniq_stats] {dcuser} #:    timeout=3600
    FOR    ${element}    IN    @{Interfaces_to_update}
        Set Client Configuration    prompt=eniqs[eniq_stats] {dcuser} #:    timeout=3600
        Write    cd ${mws_path}
        Read    delay=10s
        Write    cd ${latest_mws_path}[0]/eniq_techpacks
        Read    delay=10s
        Write    ls
        Read    delay=10s
        Write    scp -r ${element} /eniq/sw/installer
        ${transfer}    Read    delay=10s
        # Open clearcasevobs
        # ${currentpkg}=    Get Element Attribute     xpath=//a[text()='${element}']    href
        # Open Connection    ${jnkns_server}
        # Set Client Configuration    prompt=[root@atvts4074 ~]#    timeout=3600
        # Login               root        shroot
        # Write    rm -rf tppkg ; mkdir tppkg ; cd tppkg ; wget ${currentpkg} ; pwd
        # Read Until Prompt
        # Switch Connection    ${index}
        # ${temp1}=    Fetch From Right    ${currentpkg}    /
        # Put File    ${path_of_pkg_on_jenkins}/tppkg/${temp1}    /eniq/sw/installer
        #Put File    H:/Downloads/${temp1}    /eniq/sw/installer
		#Write    cd /eniq/sw/installer
        Write    cd /eniq/sw/installer ; ./tp_installer -p . -t ${element}
        ${out}=    Read Until Prompt       
    END
TP - ENIQ_TP_UG_TC42 Activating Interface
    Write    cd 
    Read    delay=10s
    Set Client Configuration    prompt=eniqs[eniq_stats] {dcuser} #:    timeout=3600
    Write    cd /eniq/sw/installer ; rm -rf tp_stage_file ; rm -rf install_lockfile 
    Read Until Prompt
    Write    cd /eniq/sw/installer ; ./activate_interface -o eniq_oss_1 -t ${dim_pkg}
    ${out}=     Read Until Prompt

TP - ENIQ_TP_UG_TC43 Verify Interface Activation
    Write    cd 
    Read    delay=10s
    Set Client Configuration    prompt=eniqs[eniq_stats] {dcuser} #:    timeout=3600
    Write    echo -e "select INTERFACENAME from InterfaceTechpacks where TECHPACKNAME='${dim_pkg}'\\n${run}\\n" | isql -P ${password_db} -U ${username} -S ${database} -b
    ${output1}=    Read Until Prompt
    ${dep_int}=    Filter Interfaces    ${output1}
    FOR    ${element}    IN    @{dep_int}
        ${fail_or_pass}=    Checking Tp Activation    ${element}    ${host}    ${port}    ${uname}    ${pwd}
        IF    '${fail_or_pass}' == 'fail'
            Fail
        END
    END
    
# Verify Interface installer Log
#     FOR    ${element}    IN    @{Interfaces_to_update}
#         ${currentpkg}=    Get Element Attribute     xpath=//a[text()='${element}']    href
#         ${temp1}=    Fetch From Right    ${currentpkg}    /
#         ${fail}=    Checking Log Of Dim Intf    ${temp1}    ${host}    ${port}    ${uname}    ${pwd}
#         IF    '${fail}' == 'fail'
#             Fail
#         END
#     END

TP - ENIQ_TP_UG_TC45 Download Latest Epfg
    Skip    'Skipping this TestCase Execution Since it is not applicable for ${package}'
    Write    cd 
    Read    delay=10s
    Set Client Configuration    prompt=eniqs[eniq_stats] {dcuser} #:    timeout=3600
    # Open clearcasevobs
    # ${epfgpkgtmp}=    Get Element Attribute    //a[contains(text(),'epfg_ft')]    href
    # ${epfgpkg}=    Fetch From Right    ${epfgpkgtmp}    /
    # Set Global Variable    ${epfgpkg}    ${epfgpkg}
    # ${epfgrstate}=    Fetch From Right    ${epfgpkg}    _
    # ${epfgrstate}=    Catenate    SEPARATOR=    epfg_    ${epfgrstate}
    # Set Global Variable    ${epfgrstate}    ${epfgrstate}
    # Log To Console    ${index}
    # Open Connection    ${jnkns_server}
    # Login               root        shroot
    # Write    rm -rf tppkg ; mkdir tppkg ; cd tppkg ; wget ${epfgpkgtmp} ; pwd
    # Read    delay=100s
    # Switch Connection    ${index}
    # Open connection as root user
    # Set Client Configuration    prompt=eniqs[eniq_stats] {root} #:    timeout=3600
    ${epfgpkgtmp}=    Execute Command    cd ${epfg_mws};ls -Art epfg_ft* | tail -n 1
    Log    ${epfgpkgtmp}
    ${epfgpkg}=    Fetch From Right    ${epfgpkgtmp}    /
    Set Global Variable    ${epfgpkg}    ${epfgpkg}
    ${epfgrstate}=    Fetch From Right    ${epfgpkg}    _
    ${epfgrstate}=    Catenate    SEPARATOR=    epfg_    ${epfgrstate}
    Set Global Variable    ${epfgrstate}    ${epfgrstate}
    # Write    ls
    Write    cd ${epfg_mws}
    Write    ls
    Write   sudo cp ${epfgpkgtmp} /eniq/home/dcuser
    ${transfer}    Read    delay=10
TP - ENIQ_TP_UG_TC46 Install Epfg 
    Skip    'Skipping this TestCase Execution Since it is not applicable for ${package}'
    Write    cd 
    Read    delay=10s
    Set Client Configuration    prompt=eniqs[eniq_stats] {dcuser} #:    timeout=300
    # Put File    /root/tppkg/${epfgpkg}     /eniq/home/dcuser
    # Write    cd /eniq/home/dcuser ; rm -rf epfg ; unzip -o ${epfgpkg} ; unzip -o ${epfgrstate} ; cd epfg ; chmod -R 777 * .* ; ./epfg_preconfig_for_ft.sh 
    # Read Until Prompt
    Write    cd /eniq/home/dcuser
    Read    delay=10s
    Set Client Configuration    prompt=eniqs[eniq_stats] {dcuser} #:    timeout=300
    Write    cd /eniq/home/dcuser ; rm -r epfg 
    Write     unzip -o ${epfgpkg} 
    ${transfer}    Read    delay=10
    Write     unzip -o ${epfgrstate} 
    ${transfer}    Read    delay=10
    Write     cd epfg ; 
    ${transfer}    Read    delay=10
    Write    chmod -R 777 *.* 
    ${transfer}    Read    delay=10
    Write     ./epfg_preconfig_for_ft.sh
    ${transfer}    Read    delay=10

TP - ENIQ_TP_UG_TC44 Setting Loader Configuration To Finest
    Write    cd 
    Read    delay=10s
    Set Client Configuration    prompt=eniqs[eniq_stats] {dcuser} #:    timeout=3600
    Write    echo -e "select INTERFACENAME from InterfaceTechpacks where TECHPACKNAME='${dim_pkg}'\\n${run}\\n" | isql -P ${password_db} -U ${username} -S ${database} -b
    ${output1}=    Read Until Prompt
    ${dep_int}=    Filter Interfaces    ${output1}
    Filter Intf Name    ${dim_pkg}    ${output1}    ${host}    ${uname}    ${pwd}

TP - ENIQ_TP_UG_TC47 Generating Topology files
    Write    cd 
    Read    delay=10s
    Set Client Configuration    prompt=eniqs[eniq_stats] {dcuser} #:    timeout=3600
    Write    rm -rf TopologyFiles/
    Read Until Prompt
    Put File    ${path}/ENIQ_TC_Automation/TP/Resources/epfgtopofiles.pl    /eniq/home/dcuser
    Put Directory    ${path}/ENIQ_TC_Automation/TP/Resources/TopologyFiles    /eniq/home/dcuser    recursive=True
    Write    test -d ${path}/ && echo "true"
    ${dir_exist}=    Read Until Prompt
    ${dir_exist}=    Return True False    ${dir_exist}
    IF    '${dir_exist}' == 'true'
        Write    mv ${path}/ENIQ_TC_Automation/TP/Resources/TopologyFiles . ; rm -rf ${path}/
        ${out}=    Read Until Prompt
    END
    Write     echo -e "${dim_pkg}_R10A_b12.tpi" | perl epfgtopofiles.pl 
    ${out1}=    Read Until Prompt

TP - ENIQ_TP_UG_TC48,TP - ENIQ_TP_UG_TC54,TP - ENIQ_TP_UG_TC55 Loading Topology Files
    Write    cd 
    Read    delay=10s
    Set Client Configuration    prompt=eniqs[eniq_stats] {dcuser} #:    timeout=3600
    Write    echo -e "select INTERFACENAME from InterfaceTechpacks where TECHPACKNAME='${dim_pkg}'\\n${run}\\n" | isql -P ${password_db} -U ${username} -S ${database} -b
    ${output1}=    Read Until Prompt
    ${dep_int}=    Filter Interfaces    ${output1}
    FOR    ${currintf}    IN    @{dep_int}
       Write    echo -e "select DATAFORMATTYPE from DataInterface where INTERFACENAME LIKE '${currintf}'\\n${run}\\n" | isql -P ${password_db} -U ${username} -S ${database} -b
	    ${par}    Read    delay=3s
	    ${parser_name}    Filter Name    ${par} 
       Write    engine -e startSet '${currintf}-eniq_oss_1' 'Adapter_${currintf}_${parser_name}'
       ${out}=    Read Until Prompt
    END
TP - ENIQ_TP_UG_TC49,TP - ENIQ_TP_UG_TC54 Loading Topo checking
    Write    cd 
    Read    delay=10s
    ${res}=    Loading Topo Check    ${dim_pkg}    ${host}    ${port}    ${uname}    ${pwd}
    IF    '${res}' == 'false'
        Fail
    END
TP - ENIQ_TP_UG_TC193 verify NR NSA file
    Skip If
    ...    '${dim_pkg}' != 'DIM_E_LTE'
    ...    Skipping the Execution since this testcase is not applicable for ${dim_pkg}
    Write    cd 
    Read    delay=10s
    IF    '${dim_pkg}' == 'DIM_E_LTE'
    Set Client Configuration    prompt=eniqs[eniq_stats] {dcuser} #:    timeout=300
    Write    echo -e "Select ENodeB_NAME from DIM_E_LTE_NR_NSA\\n${run}\\n" | isql -P ${password_dwhdb} -U ${username} -S ${database} -b
    ${ENodeB1}    Read Until Prompt
    Log To Console     ${ENodeB1}
    ${ENodeB}    Strip String    ${ENodeB1}   
    ${ENodeB2}             Split String    ${ENodeB}     \r\n
    Log To Console   ${ENodeB2}
    #----get GNodeb
    # Set Client Configuration    prompt=eniqs[eniq_stats] {dcuser} #:    timeout=300
    Write    echo -e "Select GNodeB_NAME from DIM_E_LTE_NR_NSA\\n${run}\\n" | isql -P ${password_dwhdb} -U ${username} -S ${database} -b
    ${GNodeB1}    Read Until Prompt
    Log To Console    ${GNodeB1}
    ${GNodeB}    Strip String   ${GNodeB1}    
    ${GNodeB2}    Split String    ${GNodeB}     \r\n
    Log To Console   ${GNodeB2}

   ${flag}    ${message}     verify mixed standlone mode    ${ENodeB2}[0]    ${GNodeB2}[0]
   IF    ${flag}
        log    ${message}
    ELSE
        Log    ${message}
    END
      ${flag}    ${message}     verify mixed standlone mode    ${ENodeB2}[1]    ${GNodeB2}[1]
   IF    ${flag}
        log    ${message}
    ELSE
        Log    ${message}
    END
    END
TP - ENIQ_TP_UG_TC181 verify new node versions
    Skip If
    ...    '${dim_pkg}' != 'DIM_E_LLE'
    ...    Skipping the Execution since this testcase is not applicable for ${dim_pkg}
    Write    cd 
    Read    delay=10s
    IF    '${dim_pkg}' == 'DIM_E_LLE'
    Open clearcasevobs
    ${temp}    Get Element Attribute    //table//a[text()='${ERBS_package}']    href
    ${temp1}    Fetch From Right    ${temp}    /
    Set Global Variable    ${full_pkg_name}    ${temp1}
    ${ERBS_BuildNo}    ERBS build number    ${full_pkg_name}
    #---get ERBSG2 build number
    ${temp}    Get Element Attribute    //table//a[text()='${ERBSG2_package}']    href
    ${temp1}    Fetch From Right    ${temp}    /
    Set Global Variable    ${ERBSG2_full_pkg_name}    ${temp1}
    ${ERBSG2_BuildNo}    ERBS build number    ${ERBSG2_full_pkg_name}
    #---Get ERBS/ERBSG2 latest node version
    Set Client Configuration    prompt=eniqs[eniq_stats] {dcuser} #:    timeout=300
    Write
    ...    echo -e "select VENDORRELEASE from SupportedVendorRelease where versionid like '%DC_E_ERBS:((${ERBS_BuildNo}))%' AND VENDORRELEASE IN(select TOP 1 VENDORRELEASE from SupportedVendorRelease where versionid like '%DC_E_ERBSG2:((${ERBSG2_BuildNo}))%' order by VENDORRELEASE DESC)\\n${run}\\n" | isql -P ${password_db} -U ${username} -S ${database} -b
    ${latest_node}    Read    delay=5
    ${lat_node}    Split String    ${latest_node}    \r\n
    ${new_release}    Strip String    ${lat_node}[0]
    Log To Console    ${new_release}
    #---get all ERBS releases
    # Set Client Configuration    prompt=eniqs[eniq_stats] {dcuser} #:    timeout=300
    Write    echo -e "select ERBS_RELEASE from DIM_E_LLE_HWCONNECTEDUSERS where ERBS_RELEASE like '${new_release}'\\n${run}\\n" | isql -P ${password_db} -U ${username} -S ${database} -b
    ${output}    Read    delay=5
    #---check latest ERBS/ERBSg2 release is present in ERBS_RELEASE or not
    ${flag}    ${releases}    compare    ${new_release}    ${output}
    IF   ${flag}
        Log To Console    ${releases}
    ELSE
        Log To Console    ${releases}
        Fail
    END
    #---get latest release hw series data
    # Set Client Configuration    prompt=eniqs[eniq_stats] {dcuser} #:    timeout=300
    Write    echo -e "select HW_SERIES from DIM_E_LLE_HWCONNECTEDUSERS where ERBS_RELEASE like '%${new_release}%'\\n${run}\\n" | isql -P ${password_db} -U ${username} -S ${database} -b
    ${latest_output}    Read    delay=5
    ${node_ver1}    Split String    ${latest_output}    \r\n
    ${abc}    Convert To list    ${node_ver1}
    #---get prev release
    # write    cd eniq/home/dcuser
    # read    delay=3s
    # Set Client Configuration    prompt=eniqs[eniq_stats] {dcuser} #:    timeout=300s
    Write    echo -e "select TOP 1 VENDORRELEASE from (select TOP 2 VENDORRELEASE from SupportedVendorRelease where versionid like '%DC_E_ERBSG2:((${ERBSG2_BuildNo}))%' order by VENDORRELEASE DESC) as SupportedVendorRelease order by VENDORRELEASE ASC\\n${run}\\n" | isql -P ${password_db} -U ${username} -S ${database} -b
    ${prev_node}    Read Until Prompt
    ${node_ver}    Split String    ${prev_node}    \r\n
    ${prev_version}    Strip String    ${node_ver}[0]
    Log To Console    ${prev_version}
    #--get prev release hw series data
    # write    cd eniq/home/dcuser
    # read    delay=3s
    # Set Client Configuration    prompt=eniqs[eniq_stats] {dcuser} #:    timeout=300
    Write    echo -e "select HW_SERIES from DIM_E_LLE_HWCONNECTEDUSERS where ERBS_RELEASE like '%${prev_version}%'\\n${run}\\n" | isql -P ${password_db} -U ${username} -S ${database} -b
    ${prev_release_output}    Read Until Prompt
    ${node_ver2}    Split String    ${prev_release_output}    \r\n
    ${abc2}    Convert To list    ${node_ver2}
    #---compare prev release hw series data and latest release hw series data
    ${flag}    ${message}    Compare Releases    ${abc}    ${abc2}
    IF    ${flag}
        Log To Console    ${message}
    ELSE
        log to console    ${message}
        Fail
    END
    END
TP - ENIQ_TP_UG_TC51 Verify All Loader Tables
    Write    cd 
    Read    delay=10s
    Set Client Configuration    prompt=eniqs[eniq_stats] {dcuser} #:    timeout=3600
    Write    rm -rf BT-FT_Log ; rm -rf BT-FT_Script
    Read Until Prompt
    Open nexus tpkpiscript
    ${btft_link}=    Get Element Attribute    (//a[contains(text(),'BT-FT_Script')])[last()-1]    href
    ${btft_script}=    Fetch From Right    ${btft_link}    /
    @{tp}=    Split String From Right    ${dim_pkg}    separator=_    max_split=1
    ${tp_lower_case}=    Convert To Lowercase    ${tp}[1]
    @{temp}=    Split String From Right    ${full_pkg_name}    separator=_R    max_split=1
    @{r_temp}=    Split String From Right    ${temp}[1]    separator=_
    @{b_temp}=    Split String From Right    ${r_temp}[1]    separator=.
    ${b}=    Remove String    ${b_temp}[0]    b
    IF    '${dim_pkg}' == 'DIM_E_SHARED_CNF'
        ${mod_file_link}    Set Variable    https://arm1s11-eiffel013.eiffel.gic.ericsson.se:8443/nexus/content/repositories/releases/com/ericsson/eniq/stats/tp/SHARED_CNF_TOP/SHARED_CNF_top_etl/FD/R${r_temp}[0]/${dim_pkg}_${b}/${dim_pkg}_${b}_R${r_temp}[0]_SetsModifications_TPC.xml
    ELSE
        ${mod_file_link}    Set Variable    https://arm1s11-eiffel013.eiffel.gic.ericsson.se:8443/nexus/content/repositories/releases/com/ericsson/eniq/stats/tp/${tp}[1]_TOP/${tp_lower_case}_top_etl/FD/R${r_temp}[0]/${dim_pkg}_${b}/${dim_pkg}_${b}_R${r_temp}[0]_SetsModifications_TPC.xml
    END
    Open Connection    ${jnkns_server}
    Login               root        shroot
    Write    rm -rf tppkg ; mkdir tppkg ; cd tppkg ; wget ${mod_file_link} ; pwd
    Read    delay=30s
    Switch Connection    ${index}
    Put File    /root/tppkg/${dim_pkg}_${b}_R${r_temp}[0]_SetsModifications_TPC.xml    /eniq/home/dcuser/BT-FT_Script
    Open Connection    ${jnkns_server}
    Login               root        shroot
    Write    rm -rf tppkg ; mkdir tppkg ; cd tppkg ; wget ${btft_link} ; pwd
    Read    delay=20s
    Switch Connection    ${index}
    Put File    /root/tppkg/${btft_script}    /eniq/home/dcuser
    Write    cd /eniq/home/dcuser ; unzip -o ${btft_script} ; cd BT-FT_Script/ ; chmod 777 *
    Read Until Prompt
    Execute Command    cd /eniq/home/dcuser/BT-FT_Script/ ; sed -i -e 's/\r$//' BT-FT_script.sh
    Write    cd /eniq/home/dcuser/BT-FT_Script/ ; echo -e "${full_pkg_name}\\n${date}\\n2,4\\n/eniq/home/dcuser/${dim_pkg}_${b}_R${r_temp}[0]_SetsModifications_TPC.xml" |./BT-FT_script.sh
    ${out}=    Read Until Prompt
    ${res_topo}    ${res_mod}    BT FT Validation    ${out}
    IF    ${res_topo} == False
        IF    ${res_mod} == True
        Log to Console    man mod tc is passing
    END
        Fail
    END
    IF    ${res_mod} == False
        Fail
    END

TP - ENIQ_TP_UG_TC56 Area Files check for DIM_RAN_AREA
    Skip If
    ...    '${dim_pkg}' != 'DIM_E_UTRAN'
    ...    Skipping the Execution since this testcase is not applicable for ${dim_pkg}
    Write    cd 
    Read    delay=10s
    IF    '${dim_pkg}' == 'DIM_E_UTRAN'
        Set Client Configuration    prompt=eniqs[eniq_stats] {dcuser} #:    timeout=3600
        Put File    ${path}/ENIQ_TC_Automation/TP/Resources/DIM_RAN_AREA    /eniq/data/pmdata/eniq_oss_1/utran/topologyData/DIM_RAN_AREA/               
        Write    engine -e startSet 'INTF_UTRAN_BASE_AREA-eniq_oss_1' 'Adapter_INTF_UTRAN_BASE_AREA_ascii'
        Read Until Prompt
        Set Client Configuration    prompt=eniqs[eniq_stats] {dcuser} #:    timeout=3600
        Write    echo -e "select * from DIM_RAN_AREA\\ngo\\n" | isql -P Dc12# -U dc -S dwhdb -b
        ${out}=    Read Until Prompt
        ${res}=    Verify Area File Data Loading    ${dim_pkg}    ${out}
        IF    '${res}'=='false'
            Fail
        END
    END


TP - ENIQ_TP_UG_TC57 Area Files check for DIM_BSS_AREA
    Skip If
    ...    '${dim_pkg}' != 'DIM_E_GRAN'
    ...    Skipping the Execution since this testcase is not applicable for ${dim_pkg}
    Write    cd 
    Read    delay=10s
    Set Client Configuration    prompt=eniqs[eniq_stats] {dcuser} #:    timeout=3600
    IF    '${dim_pkg}' == 'DIM_E_GRAN'
        Put File    ${path}/ENIQ_TC_Automation/TP/Resources/DIM_BSS_AREA    /eniq/data/pmdata/eniq_oss_1/gran/topologyData/DIM_RAN_AREA/
        Write    engine -e startSet 'INTF_GRAN_BASE_AREA-eniq_oss_1' 'Adapter_INTF_GRAN_BASE_AREA_ascii'
        Read Until Prompt
        Write    echo -e "select * from DIM_BSS_AREA\\ngo\\n" | isql -P Dc12# -U dc -S dwhdb -b
        ${out}=    Read Until Prompt
        ${res}=    Verify Area File Data Loading    ${dim_pkg}    ${out}
        IF    '${res}'=='false'
            Fail
        END
    END
    

TP - ENIQ_TP_UG_TC58 Area Files check for LTE and NR
    Skip If
    ...    '${dim_pkg}' != 'DIM_E_LTE'
    ...    Skipping the Execution since this testcase is not applicable for ${dim_pkg}
    Write    cd 
    Read    delay=10s
    Set Client Configuration    prompt=eniqs[eniq_stats] {dcuser} #:    timeout=3600
    IF    '${dim_pkg}' == 'DIM_E_LTE'
        Put File    ${path}/ENIQ_TC_Automation/TP/Resources/DIM_LTE_AREA    /eniq/data/pmdata/eniq_oss_1/lte/topologyData/DIM_LTE_AREA/
        Put File    ${path}/ENIQ_TC_Automation/TP/Resources/DIM_NRCELLDU_AREA.txt    /eniq/data/pmdata/eniq_oss_1/nr/topologyData/AREA/              
        Write    engine -e startSet 'INTF_LTE_BASE_AREA-eniq_oss_1' 'Adapter_INTF_LTE_BASE_AREA_ascii'
        Read Until Prompt
        Write    engine -e startSet 'INTF_DIM_E_LTE_NR_AREA-eniq_oss_1' 'Adapter_INTF_DIM_E_LTE_NR_AREA_ascii'
        Read Until Prompt
            Write    echo -e "select * from DIM_LTE_AREA\\ngo\\n" | isql -P Dc12# -U dc -S dwhdb -b
        ${out1}=    Read Until Prompt
        Write    echo -e "select * from DIM_E_LTE_NRCELLDU_AREA\\ngo\\n" | isql -P Dc12# -U dc -S dwhdb -b
        ${out2}=    Read Until Prompt
        ${res}=    Verify Area File For Lte Nr    ${dim_pkg}    ${out1}    ${out2}
        IF    '${res}'=='false'
            Fail
        END
    END

TP - ENIQ_TP_UG_TC59 Ascii File Loading
    Set Client Configuration    prompt=eniqs[eniq_stats] {dcuser} #:    timeout=3600
    Write    cd 
    Read    delay=10s
    IF    '${dim_pkg}' == 'DIM_E_CN'
        Put File    ${path}/ENIQ_TC_Automation/TP/Resources/HlrBSMFAssociation    /eniq/data/pmdata/eniq_oss_1/core/topologyData/HlrBSAssoc
        Put File    ${path}/ENIQ_TC_Automation/TP/Resources/CUDBGroupAssociation     /eniq/data/pmdata/eniq_oss_1/core/topologyData/CoreNetwork/CUDBonEBS
        Put File    ${path}/ENIQ_TC_Automation/TP/Resources/CUDBSystemAssociation     /eniq/data/pmdata/eniq_oss_1/core/topologyData/CoreNetwork/CUDBonEBS
        Put File    ${path}/ENIQ_TC_Automation/TP/Resources/HLR.txt     /eniq/data/pmdata/eniq_oss_1/core/topologyData/HLR
        Put File    ${path}/ENIQ_TC_Automation/TP/Resources/VLR.txt     /eniq/data/pmdata/eniq_oss_1/core/topologyData/HLR
        Write    engine -e startSet 'INTF_DIM_E_CN_ASCII-eniq_oss_1' 'Adapter_INTF_DIM_E_CN_ASCII_ascii'
        Read Until Prompt
        Write    engine -e startSet 'INTF_DIM_E_CN_MRSASSOC-eniq_oss_1' 'Adapter_INTF_DIM_E_CN_MRSASSOC_ascii'
        Read Until Prompt
        Write    engine -e startSet 'NTF_DIM_E_CN_CUDBGRP_AS-eniq_oss_1' 'Adapter_NTF_DIM_E_CN_CUDBGRP_AS_ascii'
        Read Until Prompt 
        Write    engine -e startSet 'INTF_DIM_E_CN_HLRBSMF_AS-eniq_oss_1' 'Adapter_INTF_DIM_E_CN_HLRBSMF_AS_ascii'
        Read Until Prompt
        Write    engine -e startSet 'INTF_DIM_E_CN_VLR-eniq_oss_1' 'Adapter_INTF_DIM_E_CN_VLR_ascii'
        Read Until Prompt
        Write    engine -e startSet 'INTF_DIM_E_CN_MSCCLMF_AS-eniq_oss_1' 'Adapter_INTF_DIM_E_CN_MSCCLMF_AS_ascii'
        Read Until Prompt
        Write    engine -e startSet 'INTF_DIM_E_CN_IMSGWMF_AS-eniq_oss_1' 'Adapter_INTF_LTE_BASE_AREA_ascii'
        Read Until Prompt
        Write    engine -e startSet 'INTF_DIM_E_CN_HADDR-eniq_oss_1' 'Adapter_INTF_LTE_BASE_AREA_ascii'
        Read Until Prompt
        Write    engine -e startSet 'INTF_DIM_E_CN_HLR-eniq_oss_1' 'Adapter_INTF_LTE_BASE_AREA_ascii'
        Read Until Prompt
    END
    IF    '${dim_pkg}' == 'DIM_E_IPTRANSPORT'
        Put File    ${path}/ENIQ_TC_Automation/TP/Resources/twampsessions.txt     /eniq/data/pmdata/eniq_oss_1/transport/topologyData/twamp/twampSessionConfig
        Write    engine -e startSet 'INTF_DIM_E_IPTRANSPORT_ROUTER6K_TWAMPSESSIONS-eniq_oss_1' 'Adapter_INTF_DIM_E_IPTRANSPORT_ROUTER6K_TWAMPSESSIONS_ascii'
        Read Until Prompt
    END
    IF    '${dim_pkg}' == 'DIM_E_GRAN'
        Put File     ${path}/ENIQ_TC_Automation/TP/Resources/AREA.txt     /eniq/data/pmdata/eniq_oss_1/gran/topologyData/Area
        Put File     ${path}/ENIQ_TC_Automation/TP/Resources/CHGR     /eniq/data/pmdata/eniq_oss_1/gran/topologyData/CELL
        Put File     ${path}/ENIQ_TC_Automation/TP/Resources/CELL     /eniq/data/pmdata/eniq_oss_1/gran/topologyData/CELL
        Put File     ${path}/ENIQ_TC_Automation/TP/Resources/NREL     /eniq/data/pmdata/eniq_oss_1/gran/topologyData/CELL
        Put File     ${path}/ENIQ_TC_Automation/TP/Resources/DIM_BSS_AREA     /eniq/data/pmdata/eniq_oss_1/gran/topologyData/DIM_BSS_AREA
        Put File     ${path}/ENIQ_TC_Automation/TP/Resources/BscAssociations     /eniq/data/pmdata/eniq_oss_1/gran/topologyData/GranAssociations
        Put File     ${path}/ENIQ_TC_Automation/TP/Resources/BSC     /eniq/data/pmdata/eniq_oss_1/gran/topologyData/GranNetwork
        Put File     ${path}/ENIQ_TC_Automation/TP/Resources/LBG     /eniq/data/pmdata/eniq_oss_1/gran/topologyData/LBG
        Put File     ${path}/ENIQ_TC_Automation/TP/Resources/MCTR     /eniq/data/pmdata/eniq_oss_1/gran/topologyData/MCTR
        Put File     ${path}/ENIQ_TC_Automation/TP/Resources/SCGR     /eniq/data/pmdata/eniq_oss_1/gran/topologyData/SCGR
        Put File     ${path}/ENIQ_TC_Automation/TP/Resources/Site     /eniq/data/pmdata/eniq_oss_1/gran/topologyData/Site
        Put File     ${path}/ENIQ_TC_Automation/TP/Resources/STGAssociations     /eniq/data/pmdata/eniq_oss_1/gran/topologyData/STG
        Put File     ${path}/ENIQ_TC_Automation/TP/Resources/TG     /eniq/data/pmdata/eniq_oss_1/gran/topologyData/TG
        Write    engine -e startSet 'INTF_DIM_E_GRAN_MCTR-eniq_oss_1' 'Adapter_INTF_LTE_BASE_AREA_ascii'
        Read Until Prompt
        Write    engine -e startSet 'INTF_DIM_E_GRAN_LBG-eniq_oss_1' 'Adapter_INTF_LTE_BASE_AREA_ascii'
        Read Until Prompt
        Write    engine -e startSet 'INTF_DIM_E_GRAN_TG-eniq_oss_1' 'Adapter_INTF_LTE_BASE_AREA_ascii'
        Read Until Prompt
        Write    engine -e startSet 'INTF_DIM_E_GRAN_SITE-eniq_oss_1' 'Adapter_INTF_LTE_BASE_AREA_ascii'
        Read Until Prompt
        Write    engine -e startSet 'INTF_DIM_E_GRAN_SCGR-eniq_oss_1' 'Adapter_INTF_LTE_BASE_AREA_ascii'
        Read Until Prompt
        Write    engine -e startSet 'INTF_DIM_E_GRAN_AS-eniq_oss_1' 'Adapter_INTF_LTE_BASE_AREA_ascii'
        Read Until Prompt
        Write    engine -e startSet 'INTF_DIM_E_GRAN_NW-eniq_oss_1' 'Adapter_INTF_LTE_BASE_AREA_ascii'
        Read Until Prompt
        Write    engine -e startSet 'INTF_DIM_E_GRAN_CELL-eniq_oss_1' 'Adapter_INTF_LTE_BASE_AREA_ascii'
        Read Until Prompt
        Write    engine -e startSet 'INTF_DIM_E_GRAN_STGASSOCIATION-eniq_oss_1' 'Adapter_INTF_LTE_BASE_AREA_ascii'
        Read Until Prompt
    END
    IF    '${dim_pkg}' == 'DIM_E_LTE'
        Put File     ${path}/ENIQ_TC_Automation/TP/Resources/MimVersion.txt     /eniq/data/pmdata/eniq_oss_1/LTEASCII
        Put File     ${path}/ENIQ_TC_Automation/TP/Resources/NRNSA_export.zip     /eniq/data/pmdata/eniq_oss_1/lte/topologyData/NRNSA
        Put File     ${path}/ENIQ_TC_Automation/TP/Resources/DIM_NRCELLDU_AREA.txt     /eniq/data/pmdata/eniq_oss_1/nr/topologyData/AREA
        Write    engine -e startSet 'INTF_DIM_E_LTE_ASCII-eniq_oss_1' 'Adapter_INTF_LTE_BASE_AREA_ascii'
        Read Until Prompt
        Write    engine -e startSet 'INTF_DIM_E_LTE_NR_NSA-eniq_oss_1' 'Adapter_INTF_LTE_BASE_AREA_ascii'
        Read Until Prompt
        Write    engine -e startSet 'INTF_DIM_E_LTE_NR_AREA-eniq_oss_1' 'Adapter_INTF_LTE_BASE_AREA_ascii'
        Read Until Prompt
    END
    IF    '${dim_pkg}' == 'DIM_E_UTRAN'
        Put File     ${path}/ENIQ_TC_Automation/TP/Resources/RBS_LIC.txt     /eniq/data/pmdata/eniq_oss_1/utran/topologyData/RBSASCII
        Put File     ${path}/ENIQ_TC_Automation/TP/Resources/RBS_RAX.txt     /eniq/data/pmdata/eniq_oss_1/utran/topologyData/RBSASCII
        Write    engine -e startSet 'INTF_DIM_RAN_RBS_ASCII-eniq_oss_1' 'Adapter_INTF_DIM_RAN_RBS_ASCII_ascii'
        Read Until Prompt
    END
    IF    '${dim_pkg}' == 'DIM_E_TSS'
        Put File     ${path}/ENIQ_TC_Automation/TP/Resources/TSSMFAssociation     /eniq/data/pmdata/eniq_oss_1/tss/topologyData/TSSISAssoc
        Write    engine -e startSet 'INTF_DIM_E_TSS_ISASSOC-eniq_oss_1' 'Adapter_INTF_LTE_BASE_AREA_ascii'
        Read Until Prompt
    END
TP - ENIQ_TP_UG_TC60 Validate ASCII Loading
    Write    cd 
    Read    delay=10s
    Set Client Configuration    prompt=eniqs[eniq_stats] {dcuser} #:    timeout=3600
    Write    rm -rf BT-FT_Log ; rm -rf BT-FT_Script
    Read Until Prompt
    Open nexus tpkpiscript
    ${btft_link}=    Get Element Attribute    (//a[contains(text(),'BT-FT_Script')])[last()-1]    href
    ${btft_script}=    Fetch From Right    ${btft_link}    /
    Open Connection    ${jnkns_server}
    Login               root        shroot
    Write    rm -rf tppkg ; mkdir tppkg ; cd tppkg ; wget ${btft_link} ; pwd
    Read    delay=20s
    Switch Connection    ${index}
    Put File    /root/tppkg/${btft_script}    /eniq/home/dcuser
    Write    unzip -o ${btft_script} ; cd BT-FT_Script/ ; chmod 777 *
    Read Until Prompt
    Write    cd /eniq/home/dcuser/BT-FT_Script/ ; echo -e "${full_pkg_name}\\n${date}\\n10" |./BT-FT_script.sh
    ${out}=    Read Until Prompt
    ${res}=    tp.BT FT Validation    ${out}
    IF    '${res}' == 'fail'
        Fail
    END

#Bharathi code starts
TP - ENIQ_TP_UG_TC177 NR-verify PLMN Tables
    Skip If
    ...    '${dim_pkg}' != 'DIM_E_NR'
    ...    Skipping the Execution since this testcase is not applicable for ${dim_pkg}
	IF	'${dim_pkg}'=='DIM_E_NR'
		${host}    set variable    atvts4134.athtem.eei.ericsson.se
		${index}    Open Connection    ${host}    port=${port}    timeout=10 
		Login    dcuser     Dcuser%12 
		Write    echo -e "select MCC,MNC from DIM_E_LTE_NR_NRCELLCU_PLMN\\n${run}\\n" | isql -P Dc12# -U Dc -S dwhdb -b
		${output1}=    Read    delay=7s
		Execute Command    cd /eniq/home/ && mkdir nr
		Put File    ${path}/ENIQ_TC_Automation/TP/Resources/TopologyFiles/NR/*.xml    /eniq/home/nr
		${output2}=    Read    delay=7s
		${engine_nr_file_name}    Execute Command     cd /eniq/home/nr && ls -Art *.xml
		${y}    Split Command Line    ${engine_nr_file_name}
		@{getmccmnc}    Create List
		FOR    ${intf_name}    IN    @{y}
			${getmcc}    Execute Command    awk -F "[><]" '/mcc/{print $3}' /eniq/home/nr/${intf_name}
			${getmnc}    Execute Command    awk -F "[><]" '/mnc/{print $3}' /eniq/home/nr/${intf_name}
			${getmcc} =	Split String	${getmcc}    \n	
			${getmnc}=  Split String    ${getmnc}    \n  
			Append To List    ${getmccmnc}     ${getmcc}
			Append To List    ${getmccmnc}     ${getmnc}
			
		END
		${output2}     tp.nr_plmn    ${output1}    ${getmccmnc}
		IF    '${output2}' == 'True'
			Log To Console    "Validated the key values of mcc and mnc from DB and XML";.
		ELSE
			Fail    "Failed to Validate the key values of mcc and mnc from DB and XML"
		END

		${del_dir}    Execute Command    cd /eniq/home/ && rm -rf nr
	END
TP - ENIQ_TP_UG_TC191,TP - ENIQ_TP_UG_TC192,TP - ENIQ_TP_UG_TC194 utran specific
    Skip If
    ...    '${dim_pkg}' != 'DIM_E_UTRAN'
    ...    Skipping the Execution since this testcase is not applicable for ${dim_pkg}
	IF	'${dim_pkg}'=='DIM_E_UTRAN'
		Set Client Configuration    prompt=eniqs[eniq_stats] {dcuser} #:    timeout=300
		Write    cd /eniq/home/dcuser
		Read    delay=5s
		Execute Command    cd /eniq/home/ && mkdir utran
		Put File    ${path}/ENIQ_TC_Automation/TP/Resources/TopologyFiles/UTRAN/utran/topologyData/RBS/*.xml    /eniq/home/utran
		${output2}=   Read    delay=5s
		${engine_utran_file_name}    Execute Command     cd /eniq/home/utran && ls -Art *.xml
		${y}    Split Command Line    ${engine_utran_file_name}
		FOR    ${engine_utran_file_name}    IN    @{y}
			${associatedTag}    Execute Command      grep 'associatedRnc' /eniq/home/utran/${engine_utran_file_name}
			${Empty}    Run Keyword And Return Status    Should not Be Empty      ${associatedTag}
			IF    ${Empty} == True
				${con_xml}    Execute Command      grep 'associatedRnc' /eniq/home/utran/${engine_utran_file_name} | awk -F "[><]" '{print $3}' | cut -d"=" -f4-
				Write    echo -e "Select distinct RNC_ID from DIM_E_RAN_RBSLOCALCELL\\nwhere RBS_ID='${con_xml}'\\n\\n${run}\\n" | isql -P Dc12# -U Dc -S dwhdb -b
				${output1}=    Read Until Prompt
				${comp}    tp.compare_utran    ${output1}    ${con_xml}
			ELSE
				${fd}    Execute Command    cat /eniq/home/utran/${engine_utran_file_name} | grep -m1 fdn | cut -d"=" -f2- | awk '{print $1}'
				${fd} =	Split String	${fd}    ,
				${fd1}    Convert To String    ${fd}
				${fd}    Remove String    ${fd1}    "
				${fd}    Remove String    ${fd}    '  
				
				${mecontext}    ${con_xml}    ${comp1}   tp.compare1 utran    ${fd}
				Write    echo -e "Select distinct RNC_ID from DIM_E_RAN_RBSLOCALCELL\\nwhere RBS_ID='${mecontext}'\\n\\n${run}\\n" | isql -P Dc12# -U Dc -S dwhdb -b -b
				${output1}=    Read Until Prompt
				${comp}    tp.compare2_utran    ${output1}    ${con_xml}    ${comp1}
			END

			IF    '${comp}' == 'True'
				${final}    set Variable    False
				${final2}    set Variable    False
				Log To Console    "RNC_ID key is validated from database and xml"
			ELSE IF    '${comp}' == 'EMPTY'
				${final}    set Variable    False
				${final2}    set Variable    False
				Log To Console    RNC_ID KEY not load if SubNetwork=SubNetwork orSubNetwork=ONRM* 
			ELSE
				Log To Console    "Mismatch of RNC_ID from database and xml or data is not loaded"
				${final2}    set Variable    True
				${final}    set Variable    True
		   
			END
		END
		IF    '${final2}' == 'True'
				Fail
		END
		IF    '${final}' == 'True' 
			 FAIL
		END
		${del_dir}    Execute Command    cd /eniq/home/ && rm -rf utran
	END

#Bharathi code end


#Ravi code starts from here
TP - ENIQ_TP_UG_TC195 Verify the NREL table
    Skip If
    ...    '${dim_pkg}' != 'DIM_E_GRAN'
    ...    Skipping the Execution since this testcase is not applicable for ${dim_pkg}
    IF    '${dim_pkg}' == 'DIM_E_GRAN'
        Write    cd /eniq/home/dcuser
        Read    delay=2s
        Set Client Configuration    prompt=eniqs[eniq_stats] {dcuser} #:    timeout=3600
        Write    echo -e "Select NEIGHBORCELL,OSS_ID,NEIGHBORBSC from DIM_E_GRAN_NETOP_CELL_NREL where neighborBsc!=''\\n${run}\\n" | isql -P ${password_dwhdb} -U ${username_dwhdb} -S ${database_dwhdb} -b
        ${nrel_output}=    Read Until Prompt
        Set Global Variable    ${nrel_output}
        Log To Console    {\n}    ${nrel_output}
        Write    echo -e "select CELL_NAME,OSS_ID,BSC_NAME from DIM_E_GRAN_CELL\\n${run}\\n" | isql -P ${password_dwhdb} -U ${username_dwhdb} -S ${database_dwhdb} -b
        ${cell_output}=    Read Until Prompt
        Set Global Variable    ${cell_output}
        Log To Console    {\n}    ${cell_output}
        ${flag}    ${message}    tp.NREL Filter    ${nrel_output}    ${cell_output}
        IF    ${flag}==1
            Log    ${\n}${message}
        ELSE
            Fail    Testcase Failed as ${message}
        END
    END

TP - ENIQ_TP_UG_TC196 Verify the CELL table
    Skip If
    ...    '${dim_pkg}' != 'DIM_E_GRAN'
    ...    Skipping the Execution since this testcase is not applicable for ${dim_pkg}
    Write    cd 
    Read    delay=10s
    IF    '${dim_pkg}' == 'DIM_E_GRAN'
        Set Client Configuration    prompt=eniqs[eniq_stats] {dcuser} #:    timeout=3600
        Write    echo -e "select distinct OSS_ID,BSC_NAME,CELL_BAND,CELL_ID,CELL_LAYER,CELL_NAME,CELL_TYPE,FPDCH,LAC,MCC,MNC,MSC,SITE_NAME,VENDOR,STATUS,CREATED,MODIFIED,MODIFIER from DIM_E_GRAN_CELL\\n${run}\\n" | isql -P ${password_dwhdb} -U ${username_dwhdb} -S ${database_dwhdb} -b
        ${cell_output2}=    Read     delay=5
        Set Global Variable    ${cell_output2}
        Log To Console    {\n}    ${cell_output2}
        Write    echo -e "Select distinct OSS_ID,BSC_NAME,CELL_BAND,CELL_ID,CELL_LAYER,CELL_NAME,CELL_TYPE,FPDCH,LAC,MCC,MNC,MSC,SITE_NAME,VENDOR,STATUS,CREATED,MODIFIED,MODIFIER from DIM_E_GRAN_NETOP_CELL\\n${run}\\n" | isql -P ${password_dwhdb} -U ${username_dwhdb} -S ${database_dwhdb} -b
        ${netop_cell_output}=    Read    delay=5
        Set Global Variable    ${netop_cell_output}
        Log To Console    {\n}    ${netop_cell_output}
        ${flag}    ${message}     tp.Compare Cell And Netop Cell    ${cell_output2}    ${netop_cell_output}
        IF    ${flag}==1
            Log    ${\n}${message}
        ELSE
            Fail    Testcase Failed as ${message}
            
        END
    END
    
TP - ENIQ_TP_UG_TC197 Verify the BSCTRC table
    Skip If
    ...    '${dim_pkg}' != 'DIM_E_GRAN'
    ...    Skipping the Execution since this testcase is not applicable for ${dim_pkg}
    IF    '${dim_pkg}' == 'DIM_E_GRAN'
        Write    cd /eniq/home/dcuser
        Read    delay=2s
        Set Client Configuration    prompt=eniqs[eniq_stats] {dcuser} #:    timeout=3600
        Write    echo -e "select BSC_TYPE,OSS_ID,BSC_ID,BSC_FDN,BSC_NAME,BSC_VERSION,SITE,SITE_FDN,SOURCE_FILE,SOURCE_TYPE,SUBNETWORK1,SUBNETWORK2,TRX,VENDOR,STATUS from DIM_E_GRAN_BSC\\n${run}\\n" | isql -P ${password_dwhdb} -U ${username_dwhdb} -S ${database_dwhdb} -b
        ${BSC_OUTPUT}=    Read Until Prompt
        Set Global Variable    ${BSC_OUTPUT}
        Log To Console    {\n}    ${BSC_OUTPUT}
        Write    echo -e "select TRC_TYPE,OSS_ID,TRC_ID,TRC_FDN,TRC_NAME,TRC_VERSION,SITE,SITE_FDN,SOURCE_FILE,SOURCE_TYPE,SUBNETWORK1,SUBNETWORK2,TRX,VENDOR,STATUS from DIM_E_GRAN_TRC\\n${run}\\n" | isql -P ${password_dwhdb} -U ${username_dwhdb} -S ${database_dwhdb} -b
        ${TRC_OUTPUT}=    Read Until Prompt
        Set Global Variable    ${TRC_OUTPUT}
        Log To Console    {\n}    ${TRC_OUTPUT}
        Write    echo -e "select NE_TYPE,OSS_ID,NE_ID,NE_FDN,NE_NAME,NE_VERSION,SITE,SITE_FDN,SOURCE_FILE,SOURCE_TYPE,SUBNETWORK1,SUBNETWORK2,TRX,VENDOR,STATUS from DIM_E_GRAN_BSCTRC\\n${run}\\n" | isql -P ${password_dwhdb} -U ${username_dwhdb} -S ${database_dwhdb} -b
        ${BSCTRC_OUTPUT}=    Read Until Prompt
        Set Global Variable    ${BSCTRC_OUTPUT}
        Log To Console    {\n}    ${BSCTRC_OUTPUT}
        ${flag}    ${message}    tp.Compare Bsctrc    ${BSC_OUTPUT}    ${TRC_OUTPUT}    ${BSCTRC_OUTPUT}
        IF    ${flag}==1
        Log    ${\n}${message}
        ELSE
            Fail    Testcase Failed as ${message}
            
        END
    END
# Ravi code ENDs here
TP - ENIQ_TP_UG_TC53 Verify External Stataments Data
    Write    cd 
    Read    delay=10s
	Set Client Configuration    prompt=eniqs[eniq_stats] {dcuser} #:    timeout=3600
    IF    '${dim_pkg}' == 'DIM_E_UTRAN'
        Set Client Configuration    prompt=eniqs[eniq_stats] {dcuser} #:    timeout=3600
        Write    echo -e "Select Top 1 dataname from ReferenceColumn where typeid like '%DIM_E_UTRAN%' and description='RNC Identifier (NE_NAME)'\\n${run}\\n" | isql -P ${password_db} -U ${username} -S ${database} -b 
       #Write    echo -e "Select Top 1 dataname from ReferenceColumn where typeid like '%DIM_E_UTRAN%' and description='RNC Identifier'\\n${run}\\n" | isql -P ${password_db} -U ${username} -S ${database} -b
        ${ut_out}=    Read Until Prompt
        ${node}=    tp.filter name    ${ut_out}
    ELSE
        Set Client Configuration    prompt=eniqs[eniq_stats] {dcuser} #:    timeout=3600
        Write    echo -e "Select Top 1 dataname from ReferenceColumn where typeid like '%${dim_pkg}%' and description='Network Element Name' or description='Node Name' or description='NE_Name' or description='NE_ID'\\n${run}\\n" | isql -P ${password_db} -U ${username} -S ${database} -b
        ${out}=    Read Until Prompt
	    ${node}=    tp.filter name    ${out}
    END
    # Write    echo -e "Select Top 1 Select top 1 MODIFIED from '${dim_pkg}'\\n${run}\\n" | isql -P ${password_dwhdb} -U ${username_dwhdb} -S ${database_dwhdb} -b
    # ${Date_id}=    Read Until Prompt
    # ${Date_id}=    tp.filter Name    ${Date_id}
	# Write    echo -e "Select Top 1 dataname from ReferenceColumn where typeid like '%${dim_pkg}%' and description='Network Element Name' or description='Node Name' or description='NE_Name' or description='NE_ID'\\n${run}\\n" | isql -P ${password_db} -U ${username} -S ${database} -b
	# ${out}=    Read Until Prompt
	# ${node}=    tp.filter name    ${out}
    Write    rm -rf BT-FT_Log ; rm -rf BT-FT_Script
    ${x}=    Read Until Prompt
    Open nexus tpkpiscript
    ${btft_link}=    Get Element Attribute    (//a[contains(text(),'BT-FT_Script')])[last()-1]    href
    ${btft_script}=    Fetch From Right    ${btft_link}    /
	Write    echo -e "select top 1 TYPENAME from ReferenceTable where TYPEID LIKE '%${dim_pkg}%'\\n${run}\\n" | isql -P ${password_db} -U ${username} -S ${database} -b
	${out1}=    Read Until Prompt
	${table}=    tp.Filter Name    ${out1}
	#Write    echo -e "select distinct ${node} from ${table} where MODIFIED = '${Date_id}'\\n${run}\\n" | isql -P Dc12# -U Dc -S dwhdb -b
    Write    echo -e "select distinct ${node} from ${table}\\n${run}\\n" | isql -P Dc12# -U Dc -S dwhdb -b
	${out2}=    Read Until Prompt
	${node_name}=    tp.filter name    ${out2}
    Open Connection    ${jnkns_server}
    Login               root        shroot
    Write    rm -rf tppkg ; mkdir tppkg ; cd tppkg ; wget ${btft_link} ; pwd
    Read    delay=20s
    Switch Connection    ${index}
    Write    cd 
    Read    delay=10s
    Put File    /root/tppkg/${btft_script}    /eniq/home/dcuser
    Write    cd /eniq/home/dcuser ; unzip -o ${btft_script} ; cd BT-FT_Script/ ; chmod 777 *
    Read Until Prompt
	tp.Changing Bt Ft File    ${host}    ${port}    ${uname}    ${pwd}
    ${tp}=    Replace String    ${dim_pkg}    DIM_E_    ${EMPTY}
    ${tp_lower_case}=    Convert To Lowercase    ${tp}
    @{temp}=    Split String From Right    ${full_pkg_name}    separator=_R    max_split=1
    @{r_temp}=    Split String From Right    ${temp}[1]    separator=_
    @{b_temp}=    Split String From Right    ${r_temp}[1]    separator=.
    ${b}=    Remove String    ${b_temp}[0]    b
    IF    '${dim_pkg}' == 'DIM_E_LTE' or '${dim_pkg}' == 'DIM_E_UTRAN' or '${dim_pkg}' == 'DIM_E_TSS' or '${dim_pkg}' == 'DIM_E_LLE' or '${dim_pkg}' == 'DIM_E_GRAN' or '${dim_pkg}' == 'DIM_E_IPTRANSPORT'
        ${mod_file_link}    Set Variable    https://arm1s11-eiffel013.eiffel.gic.ericsson.se:8443/nexus/content/repositories/releases/com/ericsson/eniq/stats/tp/${tp}_TOP/${tp_lower_case}_top_etl/FD/R${r_temp}[0]/${dim_pkg}_${b}/${dim_pkg}_${b}_R${r_temp}[0]_SetsModifications_TPC.xml
        Open Connection    ${jnkns_server}
        Login               root        shroot
        Write    rm -rf tppkg ; mkdir tppkg ; cd tppkg ; wget ${mod_file_link} ; pwd
        Read    delay=30s
        #@{dircontents}    SSHLibrary.List Directory    /root/tppkg/
        Switch Connection    ${index}
        #${mod_file_exist}    Does File Exist    /root/tppkg/${dim_pkg}_${b}_R${r_temp}[0]_SetsModifications_TPC.xml
        #IF    '${dim_pkg}_${b}_R${r_temp}[0]_SetsModifications_TPC.xml' in @{dircontents}
            Put File    /root/tppkg/${dim_pkg}_${b}_R${r_temp}[0]_SetsModifications_TPC.xml    /eniq/home/dcuser/BT-FT_Script
        #END
    END    
    Write    cd 
    Read    delay=10s
    Execute Command    cd /eniq/home/dcuser/BT-FT_Script/ ; sed -i -e 's/\r$//' BT-FT_script.sh
    #Read Until Prompt
    IF    '${dim_pkg}' == 'DIM_E_LTE' or '${dim_pkg}' == 'DIM_E_UTRAN' or '${dim_pkg}' == 'DIM_E_TSS' or '${dim_pkg}' == 'DIM_E_LLE' or '${dim_pkg}' == 'DIM_E_GRAN' or '${dim_pkg}' == 'DIM_E_IPTRANSPORT'
		Write    cd /eniq/home/dcuser/BT-FT_Script/ ; echo -e "${full_pkg_name}\\n5\\n${date}\\n${node}\\n${node_name}\\nNE_NAME\\n/eniq/home/dcuser/${dim_pkg}_${b}_R${r_temp}[0]_SetsModifications_TPC.xml" |./BT-FT_script.sh
        ${out}=    Read Until Prompt
	ELSE
		Write    cd /eniq/home/dcuser/BT-FT_Script/ ; echo -e "${full_pkg_name}\\n1,2,3,4\\n${date}\\n${node}\\n${node_name}\\nNE_NAME\\n/eniq/home/dcuser/${dim_pkg}_${b}_R${r_temp}[0]_SetsModifications_TPC.xml" |./BT-FT_script.sh
        ${out}=    Read Until Prompt
	END
	tp.BT FT Validation    ${out}