*** Settings ***
Resource          ../Resources/login.resource
Library           ./server.py
Library    RPA.RobotLogListener
Library    Collections
Test Setup        Open Connection And Log In
Test Teardown     Close All Connections

*** Variables ***
${dim_pkg}    DIM_E_CN
${path_of_pkg_on_jenkins}   /root
${latest_TP_found}    False
@{Interfaces_to_update}
@{test}    1    0    1    0    0    1    1    2
${element}    INTF_DIM_E_CN_HLRCL
${path}    H:/
${date}    2023-03-23 07:01:25
${full_pkg_name}    DIM_E_CN_R42A_b174.tpi
*** Test Cases ***
Common Topology
    #Test
    Test1
    #Get dimpkg Name
    #checking services
    #Verify the latest dim TP in Adminui
    #Installing latest TP
    # verifying TP Installation
    # Verify TP installer Log
    # Fetch Rstate of Interface from AdminUI and Clearcase
    # Installing dependent interfaces
    # Activating Interface
    # Verify Interface Activation
    # Verify Interface installer Log
    # Setting Loader Configuration To Finest
	# Download Latest Epfg
	# Install Epfg 
    #Generating Topology files
    #Loading Topology Files
    # Loading Topo checking
    #Verify All Loader Tables
    #Area Files check for DIM_RAN_AREA
    #Area Files check for DIM_BSS_AREA
    #Area Files check for LTE and NR
    #Ascii File Loading
    #Validate ASCII Loading
    #Manual modification
*** Keywords ***
Test
    Set Client Configuration    prompt=eniqs[eniq_stats] {root} #:    timeout=300
    Write    cd /eniq/home/dcuser
    Read    delay=10s
Test1 
    Open clearcasevobs
Get dimpkg Name
    @{temp}=    Split String From Right    ${full_pkg_name}    separator=_R    max_split=1
    ${dim_pkg}=    Set Variable    ${temp}[0]
    Set Global Variable    ${dim_pkg}
checking services
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

    
Verify the latest dim TP in Adminui
    Set Client Configuration    prompt=eniqs[eniq_stats] {dcuser} #:    timeout=3600
    Open clearcasevobs
    ${rstate}    Get Text    //table//a[text()='${dim_pkg}']/../following-sibling::td[3]
    ${temp}=    Get Element Attribute    //table//a[text()='${dim_pkg}']    href
    ${temp1}=    Fetch From Right    ${temp}    /
    Set Global Variable    ${full_pkg_name}    ${temp1}
    Write    echo -e "select TOP 1 TECHPACK_VERSION from Versioning where TECHPACK_NAME = '${dim_pkg}' ORDER BY TECHPACK_VERSION Desc\\n${run}\\n" | isql -P ${password_db} -U ${username} -S ${database} -b
    ${output1}=    Read Until Prompt
    ${rstate_adminui}=    Filter Name    ${output1}
    IF    '${rstate}' != '${rstate_adminui}'
        Go To    ${solarisLink}
        ${currentpkg}=    Get Element Attribute     xpath=//a[text()='${dim_pkg}']    href
        Open Connection    ${jnkns_server}
        Login               root        shroot
        Write    rm -rf tppkg ; mkdir tppkg ; cd tppkg ; wget ${currentpkg} ; pwd
        Read    delay=10s
        Switch Connection    ${index}
        Set Global Variable     ${latest_TP_found}    True   
    ELSE
        Log To Console    Latest Dim Tp already installed
    END

Installing latest TP
    IF    '${latest_TP_found}' == 'True'
        Set Client Configuration    prompt=eniqs[eniq_stats] {dcuser} #:    timeout=3600
        Put File    ${path_of_pkg_on_jenkins}/tppkg/${full_pkg_name}    /eniq/sw/installer
        #Put File    H:/Downloads/${full_pkg_name}    /eniq/sw/installer
        Write    cd /eniq/sw/installer ; ./tp_installer -p . -t ${dim_pkg}
        #Read Until Prompt
        ${out}=    Read Until Prompt
    END
verifying TP Installation
    IF    '${latest_TP_found}' == 'True'
        Set Client Configuration    prompt=eniqs[eniq_stats] {dcuser} #:    timeout=3600
        Write    echo -e "select TECHPACK_VERSION from Versioning where TECHPACK_NAME='${dim_pkg}'\\n${run}\\n" | isql -P ${password_db} -U ${username} -S ${database} -b
        ${output1}=    Read Until Prompt
        ${new_rstate_inDB}=    Filter Latest Name    ${output1}
        Write    echo -e "select VERSIONID from Versioning where TECHPACK_NAME='${dim_pkg}'\\n${run}\\n" | isql -P ${password_db} -U ${username} -S ${database} -b
        ${output2}=    Read Until Prompt 
        ${temp}=    Filter Latest Name    ${output2}
        ${temp1}=    Give Build Number    ${temp}
        ${full_pkg_name_in_db}=    Catenate    SEPARATOR=_    ${dim_pkg}    ${new_rstate_inDB}    b${temp1}.tpi    
        Set Global Variable    ${full_pkg_name_in_db}    ${full_pkg_name_in_db}
        IF    '${full_pkg_name}' != '${full_pkg_name_in_db}'
            Fail
        END
    END

Verify TP installer Log
    IF    '${latest_TP_found}' == 'True'
        ${stat}=    Checking Tp Installer Log    ${dim_pkg}    ${full_pkg_name_in_db}    ${host}    ${port}    ${uname}    ${pwd}
        IF    '${stat}' == 'fail'
            Fail
        END
    END

Fetch Rstate of Interface from AdminUI and Clearcase
    Set Client Configuration    prompt=eniqs[eniq_stats] {dcuser} #:    timeout=3600
    Write    echo -e "select INTERFACENAME from InterfaceTechpacks where TECHPACKNAME='${dim_pkg}'\\n${run}\\n" | isql -P ${password_db} -U ${username} -S ${database} -b
    ${output1}=    Read Until Prompt
    ${dep_int}=    Filter Interfaces    ${output1}
    FOR    ${intf_name}    IN    @{dep_int}
        Write    echo -e "select RSTATE from DataInterface where INTERFACENAME LIKE '${intf_name}'\\n${run}\\n" | isql -P ${password_db} -U ${username} -S ${database} -b
        ${output1}=    Read Until Prompt
        ${new_rstate_inDB}=    Filter Name    ${output1}
        Write    echo -e "select INTERFACEVERSION from DataInterface where INTERFACENAME LIKE '${intf_name}'\\n${run}\\n" | isql -P ${password_db} -U ${username} -S ${database} -b
        ${output2}=    Read Until Prompt 
        ${temp}=    Filter Name    ${output2}
        ${temp1}=    Give Build Number    ${temp}
        ${full_intf_deta}=    Catenate    SEPARATOR=_    ${intf_name}    ${new_rstate_inDB}    b${temp1}.tpi
		Open clearcasevobs
		${temp}=    Get Element Attribute    //table//a[text()='${intf_name}']    href
        ${temp1}=    Fetch From Right    ${temp}    /
		IF    '${temp1}' != '${full_intf_deta}'
		Log To Console    ${\n}Rstate not equal
        Append To List    ${Interfaces_to_update}    ${intf_name}
		# Downloading TP from vobs    ${pkg}[0]
		# Installing TP    ${pkg}[0]
		ELSE
			Log To Console   ${\n}Rstate of ${temp1} in both places are equal
		END
		# Execute Command    cd /eniq/sw/installer ; ./activate_interface -o eniq_oss_1 -t ${intf_name}
	END

Installing dependent interfaces
        Set Client Configuration    prompt=eniqs[eniq_stats] {dcuser} #:    timeout=3600
    FOR    ${element}    IN    @{Interfaces_to_update}
        Open clearcasevobs
        ${currentpkg}=    Get Element Attribute     xpath=//a[text()='${element}']    href
        Open Connection    ${jnkns_server}
        Set Client Configuration    prompt=[root@atvts4074 ~]#    timeout=3600
        Login               root        shroot
        Write    rm -rf tppkg ; mkdir tppkg ; cd tppkg ; wget ${currentpkg} ; pwd
        Read Until Prompt
        Switch Connection    ${index}
        ${temp1}=    Fetch From Right    ${currentpkg}    /
        Put File    ${path_of_pkg_on_jenkins}/tppkg/${temp1}    /eniq/sw/installer
        #Put File    H:/Downloads/${temp1}    /eniq/sw/installer
		#Write    cd /eniq/sw/installer
        Write    cd /eniq/sw/installer ; ./tp_installer -p . -t ${element}
        ${out}=    Read Until Prompt       
    END
Activating Interface
    Set Client Configuration    prompt=eniqs[eniq_stats] {dcuser} #:    timeout=3600
    Write    cd /eniq/sw/installer ; ./activate_interface -o eniq_oss_1 -t ${dim_pkg}
    ${out}=     Read Until Prompt

Verify Interface Activation
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
    
Verify Interface installer Log
    FOR    ${element}    IN    @{Interfaces_to_update}
        ${currentpkg}=    Get Element Attribute     xpath=//a[text()='${element}']    href
        ${temp1}=    Fetch From Right    ${currentpkg}    /
        ${fail}=    Checking Log Of Dim Intf    ${temp1}    ${host}    ${port}    ${uname}    ${pwd}
        IF    '${fail}' == 'fail'
            Fail
        END
    END

Download Latest Epfg
    Set Client Configuration    prompt=eniqs[eniq_stats] {dcuser} #:    timeout=3600
    Open clearcasevobs
    ${epfgpkgtmp}=    Get Element Attribute    //a[contains(text(),'epfg_ft')]    href
    ${epfgpkg}=    Fetch From Right    ${epfgpkgtmp}    /
    Set Global Variable    ${epfgpkg}    ${epfgpkg}
    ${epfgrstate}=    Fetch From Right    ${epfgpkg}    _
    ${epfgrstate}=    Catenate    SEPARATOR=    epfg_    ${epfgrstate}
    Set Global Variable    ${epfgrstate}    ${epfgrstate}
    Log To Console    ${index}
    Open Connection    ${jnkns_server}
    Login               root        shroot
    Write    rm -rf tppkg ; mkdir tppkg ; cd tppkg ; wget ${epfgpkgtmp} ; pwd
    Read    delay=100s
    Switch Connection    ${index}
Install Epfg  
    Put File    /root/tppkg/${epfgpkg}     /eniq/home/dcuser
    Write    cd /eniq/home/dcuser ; rm -r epfg ; unzip -o ${epfgpkg} ; unzip -o ${epfgrstate} ; cd epfg ; chmod -R 777 * .* ; ./epfg_preconfig_for_ft.sh 
    Read Until Prompt

Setting Loader Configuration To Finest
    Set Client Configuration    prompt=eniqs[eniq_stats] {dcuser} #:    timeout=3600
    Write    echo -e "select INTERFACENAME from InterfaceTechpacks where TECHPACKNAME='${dim_pkg}'\\n${run}\\n" | isql -P ${password_db} -U ${username} -S ${database} -b
    ${output1}=    Read Until Prompt
    ${dep_int}=    Filter Interfaces    ${output1}
    Filter Intf Name    ${dim_pkg}    ${output1}    ${host}    ${uname}    ${pwd}

Generating Topology files
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

Loading Topology Files
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
Loading Topo checking
    ${res}=    Loading Topo Check    ${dim_pkg}    ${host}    ${port}    ${uname}    ${pwd}
    IF    '${res}' == 'false'
        Fail
    END
Verify All Loader Tables
    Set Client Configuration    prompt=eniqs[eniq_stats] {dcuser} #:    timeout=3600
    #Write    rm -rf BT-FT_Log ; rm -rf BT-FT_Script
    #Read Until Prompt
    #Open nexus tpkpiscript
    #${btft_link}=    Get Element Attribute    //a[contains(text(),'BT-FT')]    href
    #${btft_script}=    Fetch From Right    ${btft_link}    /
    @{tp}=    Split String From Right    ${dim_pkg}    separator=_    max_split=1
    ${tp_lower_case}=    Convert To Lowercase    ${tp}[1]
    @{temp}=    Split String From Right    ${full_pkg_name}    separator=_R    max_split=1
    @{r_temp}=    Split String From Right    ${temp}[1]    separator=_
    @{b_temp}=    Split String From Right    ${r_temp}[1]    separator=.
    ${b}=    Remove String    ${b_temp}[0]    b
    ${mod_file_link}    Set Variable    https://arm1s11-eiffel013.eiffel.gic.ericsson.se:8443/nexus/content/repositories/releases/com/ericsson/eniq/stats/tp/${tp}[1]_TOP/${tp_lower_case}_top_etl/FD/R${r_temp}[0]/${dim_pkg}_${b}/${dim_pkg}_${b}_R${r_temp}[0]_SetsModifications_TPC.xml
    Open Connection    ${jnkns_server}
    Login               root        shroot
    Write    rm -rf tppkg ; mkdir tppkg ; cd tppkg ; wget ${mod_file_link} ; pwd
    Read    delay=30s
    Switch Connection    ${index}
    Put File    H:/Downloads/${dim_pkg}_${b}_R${r_temp}[0]_SetsModifications_TPC.xml    /eniq/home/dcuser/BT-FT_Script
    Open Connection    ${jnkns_server}
    Login               root        shroot
    #Write    rm -rf tppkg ; mkdir tppkg ; cd tppkg ; wget ${btft_link} ; pwd
    #Read    delay=20s
    Switch Connection    ${index}
    #Put File    /root/tppkg/${btft_script}    /eniq/home/dcuser
    #Write    cd /eniq/home/dcuser ; unzip -o ${btft_script} ; cd BT-FT_Script/ ; chmod 777 *
    #Read Until Prompt
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

Area Files check for DIM_RAN_AREA
    Set Client Configuration    prompt=eniqs[eniq_stats] {dcuser} #:    timeout=3600
    IF    '${dim_pkg}' == 'DIM_E_UTRAN'
        Put File    ${path}/ENIQ_TC_Automation/TP/Resources/DIM_RAN_AREA    /eniq/data/pmdata/eniq_oss_1/utran/topologyData/DIM_RAN_AREA/               
        Write    engine -e startSet 'INTF_UTRAN_BASE_AREA-eniq_oss_1' 'Adapter_INTF_UTRAN_BASE_AREA_ascii'
        Read Until Prompt
        Write    echo -e "select * from DIM_RAN_AREA\\ngo\\n" | isql -P Dc12# -U dc -S dwhdb -b
        ${out}=    Read Until Prompt
        ${res}=    Verify Area File Data Loading    ${dim_pkg}    ${out}
        IF    '${res}'=='false'
            Fail
        END
    END


Area Files check for DIM_BSS_AREA
    Set Client Configuration    prompt=eniqs[eniq_stats] {dcuser} #:    timeout=3600
    IF    '${dim_pkg}' == 'DIM_E_GRAN'
        Put File    ${path}/ENIQ_TC_Automation/TP/Resources/DIM_BSS_AREA    /eniq/data/pmdata/eniq_oss_1/utran/topologyData/DIM_RAN_AREA/
        Write    engine -e startSet 'INTF_GRAN_BASE_AREA-eniq_oss_1' 'Adapter_INTF_GRAN_BASE_AREA_ascii'
        Read Until Prompt
        Write    echo -e "select * from DIM_BSS_AREA\\ngo\\n" | isql -P Dc12# -U dc -S dwhdb -b
        ${out}=    Read Until Prompt
        ${res}=    Verify Area File Data Loading    ${dim_pkg}    ${out}
        IF    '${res}'=='false'
            Fail
        END
    END
    

Area Files check for LTE and NR
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

Ascii File Loading
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
        Write    engine -e startSet 'INTF_DIM_E_IPTRANSPORT_ROUTER6K_TWAMPSESSIONS-eniq_oss_1' 'Adapter_INTF_LTE_BASE_AREA_ascii'
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
        Write    engine -e startSet 'INTF_DIM_RAN_RBS_ASCII-eniq_oss_1' 'Adapter_INTF_LTE_BASE_AREA_ascii'
        Read Until Prompt
    END
    IF    '${dim_pkg}' == 'DIM_E_TSS'
        Put File     ${path}/ENIQ_TC_Automation/TP/Resources/TSSMFAssociation     /eniq/data/pmdata/eniq_oss_1/tss/topologyData/TSSISAssoc
        Write    engine -e startSet 'INTF_DIM_E_TSS_ISASSOC-eniq_oss_1' 'Adapter_INTF_LTE_BASE_AREA_ascii'
        Read Until Prompt
    END
Validate ASCII Loading
    Set Client Configuration    prompt=eniqs[eniq_stats] {dcuser} #:    timeout=3600
    Write    rm -rf BT-FT_Log ; rm -rf BT-FT_Script
    Read Until Prompt
    Open nexus tpkpiscript
    ${btft_link}=    Get Element Attribute    //a[contains(text(),'BT-FT')]    href
    ${btft_script}=    Fetch From Right    ${btft_link}    /
    Open Connection    ${jnkns_server}
    Login               root        shroot
    Write    rm -rf tppkg ; mkdir tppkg ; cd tppkg ; wget ${btft_link} ; pwd
    Read    delay=20s
    Switch Connection    ${index}
    Put File    /root/tppkg/${btft_script}    /eniq/home/dcuser
    Write    unzip -o ${btft_script} ; cd BT-FT_Script/ ; chmod 777 *
    Read Until Prompt
    Write    cd /eniq/home/dcuser/BT-FT_Script/ ; echo -e "${full_pkg_name}\\n${date}\\n2" |./BT-FT_script.sh
    ${out}=    Read Until Prompt
    ${res}=    BT FT Validation    ${out}
    IF    '${res}' == 'fail'
        Fail
    END

Manual modification
    Set Client Configuration    prompt=eniqs[eniq_stats] {dcuser} #:    timeout=3600
    @{tp}=    Split String From Right    ${dim_pkg}    separator=_    max_split=1
    ${tp_lower_case}=    Convert To Lowercase    ${tp}[1]
    @{temp}=    Split String From Right    ${full_pkg_name}    separator=_R    max_split=1
    @{r_temp}=    Split String From Right    ${temp}[1]    separator=_
    @{b_temp}=    Split String From Right    ${r_temp}[1]    separator=.
    ${b}=    Remove String    ${b_temp}[0]    b
    ${mod_file_link}    Set Variable    https://arm1s11-eiffel013.eiffel.gic.ericsson.se:8443/nexus/content/repositories/releases/com/ericsson/eniq/stats/tp/${tp}[1]_TOP/${tp_lower_case}_top_etl/FD/R${r_temp}[0]/${dim_pkg}_${b}/${dim_pkg}_${b}_R${r_temp}[0]_SetsModifications_TPC.xml
    Open Connection    ${jnkns_server}
    Login               root        shroot
    Write    rm -rf tppkg ; mkdir tppkg ; cd tppkg ; wget ${mod_file_link} ; pwd
    Read    delay=10s
    Switch Connection    ${index}
    Put File    /root/tppkg/${dim_pkg}_${b}_R${r_temp}[0]_SetsModifications_TPC.xml    /eniq/home/dcuser/BT-FT_Script