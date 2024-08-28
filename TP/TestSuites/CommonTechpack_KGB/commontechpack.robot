*** Settings ***
Library    RPA.Browser.Selenium
Library    RPA.Tables
Library    OperatingSystem
Library    RPA.FileSystem
Library		SSHLibrary
Library    Collections
Library    Process
Library     ../../Resources/tp.py
Resource     ../../Resources/login.resource
Library    String
Test Setup        Open Connection And Log In
Test Teardown     Close All Connections
#Resource    ./login.resource
*** Variables ***
${host}    atvts4096.athtem.eei.ericsson.se
${port}    2251
${uname}     dcuser
${pwd}       Dcuser%12
${password_dwhdb}      Dc12#
${username_dwhdb}      dc
${database_dwhdb}      dwhdb
${package}    DC_E_CNAXE
${clearcase}    https://clearcase-eniq.seli.wh.rnd.internal.ericsson.com/eniqdel
${sql_query_for_dependnt_intf_on_tp}    select INTERFACENAME from InterfaceDependency where TECHPACKNAME= 'DC_E_CUDB'
${password_db}      Dwhrep12#
${username}      dwhrep
${database}      repdb
${run}		go
${path}     /root/CI/cicd/bin/activate/workspace/TP_ROBOT
${full_pkg_name}	DC_E_CNAXE_R44A_b148.tpi
${both}    du and baseband
${both1}    du and base band
${RBS_package}            DC_E_RBS
${RBSG2_package}        DC_E_RBSG2
#${intf_name}    INTF_DC_E_CUDB_ECIM
${dir_path}     /eniq/connectd/mount_info/eniq_oss_2
${file_path}    /eniq/connectd/mount_info/eniq_oss_2/fs_mount_list
${intf_name}    INTF_DC_E_CUDB_EIR_FE_ECIM
${date}    2023-05-10
${node_name}    SN1
${path_of_pkg_on_jenkins}    /root
${latest_TP_found}    False
${Interfaces_to_update}
${cRANintf}    INTF_DC_E_SHARED_CNF
@{dep_pkg_list}    DIM_E_SHARED_CNF
${epfg_mws}    /net/10.45.192.153/JUMP/EPFG_FT
${mws_path}    /net/10.45.192.153/JUMP/ENIQ_STATS/ENIQ_STATS
${NE_ID}    CUDB02
${cudb_keyname}    cudbsys01
@{output_list}
@{NE_NAME_list}
*** Tasks *** 
# FT 
#     Get dimpkg Name
# 	${file_exist}	Does File Exist    /root/sa/${package}*.tpi
# 	IF  ${file_exist}
# 		Log	${\n}Skipping download as ${package} is already present in directory.
# 	END
# 	IF  not ${file_exist}
# 		Log	${\n}TechPack not present, downloading now.....
#         Downloading techpack
#         Log    ${\n}Techpack downloaded
# 	END
# 	Place the package on the server
# 	Installing TechPack    
# 	Verifying TP installation with tp_installer & engine log files
#     Editing Engine.properties file
# 	Data Format not found verification in engine logs
#     Fetch Rstate of Interface from AdminUI and Clearcase
#     Generate PM Files without Suspected data
#     Starting Adapter Set for Interfaces
# 	Starting Aggregation
# 	#Running BTFT
# 	Get date
# 	Downloading And Installing BT-Ft 

Test
    Write    cd /eniq/home/dcuser
    Read    delay=10s
    Open connection as root user
    Set Client Configuration    prompt=eniqs[eniq_stats] {root} #:    timeout=300
    Execute Command    bash /eniq/installation/core_install/bin/get_cell_count.bsh -d /eniq/installation/config/ -g /var/tmp -t raw -e stats -l /tmp/get_cell_count.log
    ${out}=    Execute Command    cd /eniq/admin/bin ; echo -e "Yes\\n" | bash ./manage_eniq_services.bsh -a start -s ALL
    Log    ${out}
Open Connection And Log In
    ${index}    Open Connection    ${host}      port=${port}    timeout=10
    Set Global Variable    ${index}
    Login    ${uname}        ${pwd}

Get pkg Name
    @{temp}=    Split String From Right    ${full_pkg_name}    separator=_R    max_split=1
    ${package}=    Set Variable    ${temp}[0]
    Set Global Variable    ${package}
Get date
    #Set Client Configuration    prompt=eniqs[eniq_stats] {dcuser} #:    timeout=3600
    ${date}=    Execute Command    date -d '-1 day' '+%Y-%m-%d'
	Set Global Variable    ${date}
TP - ENIQ_TP_UG_TC62 checking services
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
        Log    Everything is working fine
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
        Log    ${other_Status}services${SPACE}are${SPACE}down
        IF    ${other_Status} == ['eniq-engine']
            Log    only engine service is down
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

TP - ENIQ_TP_UG_TC63 Check Dependent Topology Techpack
    IF    '${package}' == 'DC_E_cNELS' or '${package}' == 'DC_E_cRAN'
        Set Client Configuration    prompt=eniqs[eniq_stats] {dcuser} #:    timeout=3600
        Write    cd /eniq/home/dcuser
        Read    delay=10s
        # Write    echo -e "select distinct TECHPACKNAME from TechPackDependency where VERSIONID LIKE '${package}:%'and TECHPACKNAME like 'DIM_%';\\n${run}\\n" | isql -P ${password_db} -U ${username} -S ${database} -b
        # ${dep_pkg_list}=    Read Until Prompt    strip_prompt=True
        # ${dep_pkg_list}    Split String    ${dep_pkg_list}     
        # Remove From List    ${dep_pkg_list}    -1
        # Remove From List    ${dep_pkg_list}    -1
        # Remove From List    ${dep_pkg_list}    -1
        Set Global Variable    ${dep_pkg_list}
    ELSE
        Set Client Configuration    prompt=eniqs[eniq_stats] {dcuser} #:    timeout=3600
        Write    cd /eniq/home/dcuser
        Read    delay=10s
        Write    echo -e "select distinct TECHPACKNAME from TechPackDependency where VERSIONID LIKE '${package}:%'and TECHPACKNAME like 'DIM_%';\\n${run}\\n" | isql -P ${password_db} -U ${username} -S ${database} -b
        ${dep_pkg_list}=    Read Until Prompt    strip_prompt=True
        ${dep_pkg_list}    Split String    ${dep_pkg_list}     
        Remove From List    ${dep_pkg_list}    -1
        Remove From List    ${dep_pkg_list}    -1
        Remove From List    ${dep_pkg_list}    -1
        Set Global Variable    ${dep_pkg_list}
    END

    
TP - ENIQ_TP_UG_TC64 Dependent Topology Techpack Installation   
    FOR    ${dim_pkg}    IN    @{dep_pkg_list}   
    #Set Global Variable    ${dim_pkg}
    TP - ENIQ_TP_UG_TC31 Verify the latest dim TP in Adminui
    # TP - ENIQ_TP_UG_TC32,TP - ENIQ_TP_UG_TC33,TP - ENIQ_TP_UG_TC34 Installing latest TP
    # TP - ENIQ_TP_UG_TC35 verifying TP Installation
    # TP - ENIQ_TP_UG_TC36 Verify TP installer Log
    TP - ENIQ_TP_UG_TC37,TP - ENIQ_TP_UG_TC38 Fetch Rstate of Interface from AdminUI and Clearcase
    TP - ENIQ_TP_UG_TC39,TP - ENIQ_TP_UG_TC40,TP - ENIQ_TP_UG_TC41 Installing dependent interfaces
    TP - ENIQ_TP_UG_TC42 Activating Interface
    #TP - ENIQ_TP_UG_TC43 Verify Interface Activation
    Verify Interface installer Log
    # TP - ENIQ_TP_UG_TC45 Download Latest Epfg
    # TP - ENIQ_TP_UG_TC46 Install Epfg
    TP - ENIQ_TP_UG_TC44 Setting Loader Configuration To Finest
    TP - ENIQ_TP_UG_TC79 Generating Topology files
    TP - ENIQ_TP_UG_TC48,TP - ENIQ_TP_UG_TC54 Loading Topology Files
    TP - ENIQ_TP_UG_TC49,TP - ENIQ_TP_UG_TC54 Loading Topo checking
    TP - ENIQ_TP_UG_TC51 Verify All Loader Tables          
    END
TP - ENIQ_TP_UG_TC65,TP - ENIQ_TP_UG_TC66 Downloading techpack	
    Write    cd /eniq/home/dcuser
    Read    delay=10s
    # Open connection as root user
    # Set Client Configuration    prompt=eniqs[eniq_stats] {root} #:    timeout=3600
    Set Client Configuration    prompt=eniqs[eniq_stats] {dcuser} #:    timeout=3600
    ${latest_mws_path}=   Execute Command    cd ${mws_path};ls -t Features_* | head -n 1
    ${latest_mws_path}    Split String    ${latest_mws_path}    :
    Set Global Variable    ${latest_mws_path}
    Write    cd ${mws_path}
    Read    delay=10s
    Write    cd ${latest_mws_path}[0]/eniq_techpacks
    Read    delay=10s
    Write    ls
    Read    delay=10s
    #${pakage_name}=   Execute Command    cd ${MWS_PATH};ls -Art ${package}_R*.tpi | tail -n 1
    ${pakage_name}=    Execute Command    cd ${mws_path}/${latest_mws_path}[0]/eniq_techpacks;ls -Art ${package}_R*.tpi | tail -n 1
    IF    '${pakage_name}'== '${full_pkg_name}'
        Set Client Configuration    prompt=eniqs[eniq_stats] {dcuser} #:    timeout=3600
        Write    cd ${mws_path}
        Read    delay=10s
        Write    cd ${latest_mws_path}[0]/eniq_techpacks
        Read    delay=10s
        Write    ls
        Read    delay=10s
        Write    scp -r ${full_pkg_name} /eniq/sw/installer
        Read    delay=10s
        IF    '${package}' == 'DC_E_CUDB' 
            Set Client Configuration    prompt=eniqs[eniq_stats] {dcuser} #:    timeout=3600
            Write    cd ${mws_path}
            Read    delay=10s
            Write    cd ${latest_mws_path}[0]/eniq_techpacks
            Read    delay=10s
            Write    ls
            Read    delay=10s
            ${CCDM}=    Execute Command    cd ${mws_path}${latest_mws_path}[0]/eniq_techpacks;ls -Art DC_E_CCDM_R*.tpi | tail -n 1
            Write    cd ${mws_path}
            Read    delay=10s
            Write    cd ${latest_mws_path}[0]/eniq_techpacks
            Read    delay=10s
            Write    ls
            Read    delay=10s
            Write    scp -r ${CCDM} /eniq/sw/installer
        ELSE
            IF    '${package}' == 'DC_E_ERBS'
                    Set Client Configuration    prompt=eniqs[eniq_stats] {dcuser} #:    timeout=3600
                    ${ERBSG2}=    Execute Command    cd ${mws_path}${latest_mws_path}[0]/eniq_techpacks;ls -Art DC_E_ERBSG2_R*.tpi | tail -n 1
                    Write    cd ${mws_path}
                    Read    delay=10s
                    Write    cd ${latest_mws_path}[0]/eniq_techpacks
                    Read    delay=10s
                    Write    ls
                    Read    delay=10s
                    Write    scp -r ${ERBSG2} /eniq/sw/installer
            ELSE
                IF    '${package}' == 'DC_E_VPP'
                    Set Client Configuration    prompt=eniqs[eniq_stats] {dcuser} #:    timeout=3600
                    ${NR}=    Execute Command    cd ${mws_path}${latest_mws_path}[0];ls -Art DC_E_NR_R*.tpi | tail -n 1
                    Write    cd ${mws_path}
                    Read    delay=10s
                    Write    cd ${latest_mws_path}[0]/eniq_techpacks
                    Read    delay=10s
                    Write    ls
                    Read    delay=10s
                    Write    scp -r ${NR} /eniq/sw/installer
                END
            END
                
        END
    ELSE
        Log    'latest techpack not available in MWS path'
    END

    # Set Download Directory    /root/sa
    # Open Available Browser    ${clearcase}    
    # Click Link    xpath=//body//tr[last()-1]//td[2]//a   
    # Click Link    xpath=//body//tr[last()-1]//td[2]//a   
    # ${loc}    Get Location
    # Go To    ${loc}SOLARIS_baseline.html
	# ${temp}=    Get Element Attribute    //table//a[text()='${package}']    href
    # ${temp1}=    Fetch From Right    ${temp}    /
    # Set Global Variable    ${full_pkg_name}    ${temp1}
    # Click Link    xpath=//a[text()='${package}'] 
    # OperatingSystem.Wait Until Created    /root/sa/${package}*.tpi

	
TP - ENIQ_TP_UG_TC67 Upgrade PM Techpack
    # Write    cd /eniq/home/dcuser
    # Read    delay=10s
    Open Connection And Log In
        # Read    delay=10s
    Write    cd /eniq/home/dcuser
    Read    delay=10s
   # ${downloaded_tp}		Tpi File Loc
	#Log		${\n}Downloaded TechPack is: ${downloaded_tp}
	${tp_exist}		Execute Command    test -f /eniq/sw/installer/${full_pkg_name} && echo True || echo False     
	IF 	${tp_exist}
	Log	${\n}TechPack Already present in Server.
	ELSE
	Log	${\n}TechPack not present, transferring.....
	#Put File    /root/sa/${downloaded_tp}    /eniq/sw/installer
	END
    # ${downloaded_tp}		Tpi File Loc
	# Log		${\n}Downloaded TechPack is: ${downloaded_tp}
	# ${tp_exist}		Execute Command    test -f /eniq/sw/installer/${downloaded_tp} && echo True || echo False     
	# IF 	${tp_exist}
	# Log	${\n}TechPack Already present in Server.
	# ELSE
	# Log	${\n}TechPack not present, transferring.....
	# Put File    /root/sa/${downloaded_tp}    /eniq/sw/installer
	# END
	# ${tp_exist_in_server}		Execute Command    test -f /eniq/sw/installer/${downloaded_tp} && echo True || echo False     
	# IF  ${tp_exist_in_server}
	# 	Log	${\n}${downloaded_tp} transferred to the FT server.
	# 	OperatingSystem.Remove File    /root/sa/${downloaded_tp}
	# ELSE
	# 	Log	${\n}TechPack not transferred, Error occurred.
	# END
	
TP - ENIQ_TP_UG_TC68,TP - ENIQ_TP_UG_TC69 Installing TechPack  
    Write    cd /eniq/home/dcuser
    Read    delay=10s   
	Log		${\n}TechPack Installation Started......
    Set Client Configuration    prompt=eniqs[eniq_stats] {dcuser} #:    timeout=3600
    Write    cd /eniq/sw/installer ; rm -rf tp_stage_file ; rm -rf install_lockfile 
    Read Until Prompt
    Write    cd /eniq/sw/installer ; ./tp_installer -p . -t ${package}
    #Read Until Prompt
    ${out}=    Read Until Prompt
    IF    '${package}' == 'DC_E_CUDB' 
        Write    cd /eniq/home/dcuser
        Read    delay=10s   
        Log		${\n}TechPack Installation Started......
        Set Client Configuration    prompt=eniqs[eniq_stats] {dcuser} #:    timeout=3600
        Write    cd /eniq/sw/installer ; rm -rf tp_stage_file ; rm -rf install_lockfile 
        Read Until Prompt
        Write    cd /eniq/sw/installer ; ./tp_installer -p . -t 'DC_E_CCDM'
        ${out}=    Read Until Prompt
    ELSE
        IF    '${package}' == 'DC_E_ERBS'
				Write    cd /eniq/home/dcuser
                Read    delay=10s   
                Log		${\n}TechPack Installation Started......
                Set Client Configuration    prompt=eniqs[eniq_stats] {dcuser} #:    timeout=3600
                Write    cd /eniq/sw/installer ; rm -rf tp_stage_file ; rm -rf install_lockfile 
                Read Until Prompt
                Write    cd /eniq/sw/installer ; ./tp_installer -p . -t 'DC_E_ERBSG2'
                ${out}=    Read Until Prompt
		ELSE
            IF    '${package}' == 'DC_E_VPP'
				Write    cd /eniq/home/dcuser
                Read    delay=10s   
                Log		${\n}TechPack Installation Started......
                Set Client Configuration    prompt=eniqs[eniq_stats] {dcuser} #:    timeout=3600
                Write    cd /eniq/sw/installer ; rm -rf tp_stage_file ; rm -rf install_lockfile 
                Read Until Prompt
                Write    cd /eniq/sw/installer ; ./tp_installer -p . -t 'DC_E_NR'
                ${out}=    Read Until Prompt
            END
		END
			
	END
TP - ENIQ_TP_UG_TC70 Verifying TP installation with tp_installer & engine log files
    Write    cd /eniq/home/dcuser
    Read    delay=10s
	Log    ${\n}TechPack Installation Verification started.....
	${out}    Engine Log Check    ${host}    ${port}    ${uname}    ${pwd}    ${package}
    IF	 ${out}
	Log		${\n}Verification Done. TechPack installed correctly.${\n}No keywords found in log files.
	ELSE
	Log 		${\n}Keywords found in Log files, check report.
	#Fatal Error		Stopping the Test case execution
	Fail
	END
TP - ENIQ_TP_UG_TC180 Steps for ENM mapping in vapp servers 
    Skip If    '${package}' != 'DC_E_CUDB'    Skipping the execution since this testcase is not applicable for ${package}
    Write    cd /eniq/home/dcuser
    Read    delay=10s
    Open connection as root user 
    ${output}    Execute Command      cd /eniq/sw/conf/ ; echo "eniq_oss_2 2.2.2.2" >> .oss_ref_name_file && vi .oss_ref_name_file -c ":wq" 
    ${output1}    Execute Command   cd /eniq/sw/conf/ && cat .oss_ref_name_file
    #  Log    ${output1}
    sleep    1m
    ${execute}    Execute Command    cd /eniq/connectd/mount_info/ && cat .oss_ref_name_file 
    Log    ${execute}
    ${flag}    ${message}    tp.checking    ${output1}    ${execute}
    IF    ${flag}
        Log    'matching'
    ELSE
        Log    'not matching'
    END    
   
    # Should Be Equal As Strings     ${output1}    ${execute}
#     Create Directory And File    
#    [Arguments]    ${dir_path}    ${file_path}
    ${dir_exists}=   Run Keyword And Return Status  Directory Should Exist    ${dir_path}
    ${dir_exist}=   tp.Return True False    ${dir_exists}
    IF    '${dir_exist}' == 'False'
        ${dir_created}=    Write    mkdir ${dir_path}
         Log    " ${dir_created} directory successfully created"
    END
    
    ${file_exists}=    Run Keyword And Return Status    File Should Exist    ${file_path}
    ${file_exist}=    tp.Return True False    ${file_exists}
    IF    '${file_exist}' == 'False'
            ${file_created}=    Write    touch ${file_path}
            Log    "${file_created} file created successfully "
            
    END  
   
#Content to add in fs_mount_list
    ${add1}     Execute Command   cd /eniq/connectd/mount_info/eniq_oss_2/ ; echo "2.2.2.2 /vx/ENM434-pm1 /pmic1" >> fs_mount_list && vi fs_mount_list -c ":wq"
    ${add2}    Execute Command    cd /eniq/connectd/mount_info/eniq_oss_2/ ; echo "2.2.2.2 /vx/ENM434-pm2 /pmic2" >> fs_mount_list && vi fs_mount_list -c ":wq"
    ${ADD}    Execute Command    cd /eniq/connectd/mount_info/eniq_oss_2/ && cat fs_mount_list
    Log    ${ADD}

#switch to dcuser
    Open Connection And Log In
#     Log        login dcuser
#Restart the engine service
    Set Client Configuration    prompt=eniqs[eniq_stats] {dcuser} #:    timeout=3600
    Write    engine restart
            ${output1}=    Read Until Prompt
            Write    engine -e status
            ${output2}=    Read Until Prompt 
            ${engine_profile}=    tp.Getting engine profile       ${output2}
            IF    '${engine_profile}' == 'Current Profile: NoLoads'
                Write    engine -e changeProfile 'NoLoads'
                ${output3}=    Read Until Prompt
                ${contains}=    Run Keyword And Return Status    Should Contain    ${output3}    Change profile requested successfully
                IF    '${contains}' != 'True'
                    Fail
                END
            END         
    Sleep    3m
	
TP - ENIQ_TP_UG_TC71,TP - ENIQ_TP_UG_TC72,TP - ENIQ_TP_UG_TC73,TP - ENIQ_TP_UG_TC74 Fetch Rstate of Interface from AdminUI and Clearcase
    IF    '${package}' == 'DC_E_cNELS' or '${package}' == 'DC_E_cRAN'
        Write    cd /eniq/home/dcuser
        Read    delay=10s
        Set Client Configuration    prompt=eniqs[eniq_stats] {dcuser} #:    timeout=300
        #Write    echo -e "select INTERFACENAME from InterfaceDependency where TECHPACKNAME= '${package}'\\n${run}\\n" | isql -P ${password_db} -U ${username} -S ${database} -b
        #${output1}=    Read until Prompt
        Log    ${cRANintf}
        ${name}   ${dep_int}     tp.Dependent pkg and intf  ${package}  ${cRANintf}
        Set Global Variable    ${dep_int}
        Set Global Variable    ${name}
        FOR    ${intf_name}    IN    @{dep_int}
            # Open clearcasevobs
            # ${rstate_vobs}    Get Text    //table//a[text()='${intf_name}']/../following-sibling::td[3]
            # Log    ${\n}R-State of ${intf_name} in Clearcase is = ${rstate_vobs}
            # Open connection as root user
            # Set Client Configuration    prompt=eniqs[eniq_stats] {root} #:    timeout=3600
            Set Client Configuration    prompt=eniqs[eniq_stats] {dcuser} #:    timeout=3600
            Write    cd ${mws_path}
            Write    cd ${latest_mws_path}[0]/eniq_techpacks
            Write    ls
            ${release}=   Execute Command    cd ${mws_path}/${latest_mws_path}[0]/eniq_techpacks;ls -Art ${intf_name}_R*.tpi | tail -n 1
            # Write    ls
            Log    ${release}
            ${rstate}    Split String    ${release}    ${intf_name}_
            ${rstate_mws}    Split String    ${rstate}[1]    _   
            Log    ${rstate_mws}
            Sleep    180s
            Open Connection And Log In
            # Write    su - dcuser
            # Read    delay=10s
            Write    cd /eniq/home/dcuser
            Read    delay=10s
            Set Client Configuration    prompt=eniqs[eniq_stats] {dcuser} #:    timeout=3600
            Write    echo -e "select RSTATE from DataInterface where INTERFACENAME LIKE '${intf_name}'\\n${run}\\n" | isql -P ${password_db} -U ${username} -S ${database} -b
            ${output1}=    Read    delay=3s
            ${rstate_adminui}=   tp.Filter Name    ${output1}  
            Log    ${\n}Rstate in AdminUI is= ${rstate_adminui}
            # IF    '${rstate_vobs}' != '${rstate_adminui}'
            IF    '${rstate_mws}[0]' != '${rstate_adminui}'
                Log    ${\n}Rstate not equal
                # Open connection as root user
                # Set Client Configuration    prompt=eniqs[eniq_stats] {root} #:    timeout=3600
                # Write    cd ${mws_path}
                Set Client Configuration    prompt=eniqs[eniq_stats] {dcuser} #:    timeout=3600
                Write    cd ${mws_path}
                Write    cd ${latest_mws_path}[0]/eniq_techpacks
                Write    ls
                Write    scp -r ${intf_name} /eniq/sw/installer
                
                Write    cd /eniq/home/dcuser
                Read    delay=10s
            #Downloading TP from vobs    ${pkg}[0]
            # Installing TP    ${pkg}[0]
           # FOR    ${intf_name}    IN    @{dep_int}
					# Write    cd /eniq/home/dcuser
					# Read    delay=10s
					# Set Download Directory    /root/intf
					# Open Available Browser    ${clearcase}    
					# Click Link    xpath=//body//tr[last()-1]//td[2]//a   
					# Click Link    xpath=//body//tr[last()-1]//td[2]//a   
					# ${loc}    Get Location
					# Go To    ${loc}SOLARIS_baseline.html
					# ${temp}=    Get Element Attribute    //table//a[text()='${intf_name}']    href
					# ${temp1}=    Fetch From Right    ${temp}    /
					# Set Global Variable    ${pkg_name}    ${temp1}
					# Click Link    xpath=//a[text()='${intf_name}'] 
					# OperatingSystem.Wait Until Created    /root/intf/${intf_name}*.tpi


					# Write    cd /eniq/home/dcuser
					# Read    delay=10s
					# ${downloaded_interface}		Tpi File Loc Interface
					# Log		${\n}Downloaded TechPack is: ${downloaded_interface}
					# ${tp_exist}		Execute Command    test -f /eniq/sw/installer/${downloaded_interface} && echo True || echo False     
					# IF 	${tp_exist}
					# Log	${\n}TechPack Already present in Server.
					# ELSE
					# Log	${\n}TechPack not present, transferring.....
					# Put File    /root/intf/${downloaded_interface}    /eniq/sw/installer
					# END
					# ${tp_exist_in_server}		Execute Command    test -f /eniq/sw/installer/${downloaded_interface} && echo True || echo False     
					# IF  ${tp_exist_in_server}
					# 	Log	${\n}${downloaded_interface} transferred to the FT server.
					# 	OperatingSystem.Remove File    /root/intf/${downloaded_interface}
					# ELSE
					# 	Log	${\n}TechPack not transferred, Error occurred.
					# END    


					Write    cd /eniq/home/dcuser
					Read    delay=10s   
					Log		${\n}TechPack Installation Started......
					Set Client Configuration    prompt=eniqs[eniq_stats] {dcuser} #:    timeout=3600
					Write    cd /eniq/sw/installer ; rm -rf tp_stage_file ; rm -rf install_lockfile 
					Read Until Prompt
					Write    cd /eniq/sw/installer ; ./tp_installer -p . -t ${intf_name}
					#Read Until Prompt
					${out}=    Read Until Prompt
				#END        
            ELSE
                Log   ${\n}Rstate in both places are equal
            END
            # Execute Command    cd /eniq/sw/installer ; ./activate_interface -o eniq_oss_1 -t ${intf_name}
        END
    ELSE
        Open Connection And Log In
        Write    cd /eniq/home/dcuser
        Read    delay=10s
        Set Client Configuration    prompt=eniqs[eniq_stats] {dcuser} #:    timeout=300
        Write    echo -e "select INTERFACENAME from InterfaceDependency where TECHPACKNAME= '${package}'\\n${run}\\n" | isql -P ${password_db} -U ${username} -S ${database} -b
        ${output1}=    Read until Prompt
        IF    '${package}' == 'DC_E_CUDB'
				${name}   ${dep_int}     tp.Dependent pkg and intf cudb  ${package}  ${output1}
				Set Global Variable    ${dep_int}
				Set Global Variable    ${name}
		ELSE
            IF    '${package}' == 'DC_E_ERBS'
                ${name}   ${dep_int}     tp.Dependent pkg and intf ERBS  ${package}  ${output1}
                Set Global Variable    ${dep_int}
                Set Global Variable    ${name}
            ELSE
                IF    '${package}' == 'DC_E_VPP'
                    ${name}   ${dep_int}     tp.Dependent pkg and intf VPP  ${package}  ${output1}
                    Set Global Variable    ${dep_int}
                    Set Global Variable    ${name}
                ELSE
                    ${name}   ${dep_int}     tp.Dependent pkg and intf  ${package}  ${output1}
                    Set Global Variable    ${dep_int}
                    Set Global Variable    ${name}
                END
            END
        END
        FOR    ${intf_name}    IN    @{dep_int}
            # Open clearcasevobs
            # ${rstate_vobs}    Get Text    //table//a[text()='${intf_name}']/../following-sibling::td[3]
            # Log    ${\n}R-State of ${intf_name} in Clearcase is = ${rstate_vobs}
            # Open connection as root user
            # Set Client Configuration    prompt=eniqs[eniq_stats] {root} #:    timeout=3600
            Set Client Configuration    prompt=eniqs[eniq_stats] {dcuser} #:    timeout=3600
            Write    cd ${mws_path}
            Write    cd ${latest_mws_path}[0]/eniq_techpacks
            Write    ls
            ${release}=   Execute Command    cd ${mws_path}/${latest_mws_path}[0]/eniq_techpacks;ls -Art ${intf_name}_R*.tpi | tail -n 1
            # Write    ls
            Log    ${release}
            # ${release}=   Execute Command    cd ${MWS_PATH};ls -Art ${intf_name}_R*.tpi | tail -n 1
            # # Write    ls
            # Log    ${release}
            ${rstate}    Split String    ${release}    ${intf_name}_
            ${rstate_mws}    Split String    ${rstate}[1]    _   
            Log    ${rstate_mws}
            Sleep    180s
            Open Connection And Log In
            Write    echo -e "select RSTATE from DataInterface where INTERFACENAME LIKE '${intf_name}'\\n${run}\\n" | isql -P ${password_db} -U ${username} -S ${database} -b
            ${output1}=    Read    delay=3s
            ${rstate_adminui}=   tp.Filter Name    ${output1}  
            Log    ${\n}Rstate in AdminUI is= ${rstate_adminui}
           # IF    '${rstate_vobs}' != '${rstate_adminui}'
            IF    '${rstate_mws}[0]' != '${rstate_adminui}'
                Log    ${\n}Rstate not equal
                # Open connection as root user
                # Set Client Configuration    prompt=eniqs[eniq_stats] {root} #:    timeout=3600
                # Write    cd ${mws_path}
                # Write    ls
                Set Client Configuration    prompt=eniqs[eniq_stats] {dcuser} #:    timeout=3600
                Write    cd ${mws_path}
                Read    delay=10s
                Write    cd ${latest_mws_path}[0]/eniq_techpacks
                Read    delay=10s
                Write    ls
                Read    delay=10s
                Write    scp -r ${intf_name} /eniq/sw/installer
                
                
            # Downloading TP from vobs    ${pkg}[0]
            # Installing TP    ${pkg}[0]
                #FOR    ${intf_name}    IN    @{dep_int}
                        # Write    cd /eniq/home/dcuser
                        # Read    delay=10s
                        # Set Download Directory    /root/intf
                        # Open Available Browser    ${clearcase}    
                        # Click Link    xpath=//body//tr[last()-1]//td[2]//a   
                        # Click Link    xpath=//body//tr[last()-1]//td[2]//a   
                        # ${loc}    Get Location
                        # Go To    ${loc}SOLARIS_baseline.html
                        # ${temp}=    Get Element Attribute    //table//a[text()='${intf_name}']    href
                        # ${temp1}=    Fetch From Right    ${temp}    /
                        # Set Global Variable    ${pkg_name}    ${temp1}
                        # Click Link    xpath=//a[text()='${intf_name}'] 
                        # OperatingSystem.Wait Until Created    /root/intf/${intf_name}*.tpi


                        # Write    cd /eniq/home/dcuser
                        # Read    delay=10s
                        # ${downloaded_interface}		Tpi File Loc Interface
                        # Log		${\n}Downloaded TechPack is: ${downloaded_interface}
                        # ${tp_exist}		Execute Command    test -f /eniq/sw/installer/${downloaded_interface} && echo True || echo False     
                        # IF 	${tp_exist}
                        # Log	${\n}TechPack Already present in Server.
                        # ELSE
                        # Log	${\n}TechPack not present, transferring.....
                        # Put File    /root/intf/${downloaded_interface}    /eniq/sw/installer
                        # END
                        # ${tp_exist_in_server}		Execute Command    test -f /eniq/sw/installer/${downloaded_interface} && echo True || echo False     
                        # IF  ${tp_exist_in_server}
                        #     Log	${\n}${downloaded_interface} transferred to the FT server.
                        #     OperatingSystem.Remove File    /root/intf/${downloaded_interface}
                        # ELSE
                        #     Log	${\n}TechPack not transferred, Error occurred.
                        # END    
                        Open Connection And Log In
                        Write    cd /eniq/home/dcuser
                        Read    delay=10s   
                        Log		${\n}TechPack Installation Started......
                        Set Client Configuration    prompt=eniqs[eniq_stats] {dcuser} #:    timeout=3600
                        Write    cd /eniq/sw/installer ; rm -rf tp_stage_file ; rm -rf install_lockfile 
                        Read Until Prompt
                        Write    cd /eniq/sw/installer ; ./tp_installer -p . -t ${intf_name}
                        #Read Until Prompt
                        ${out}=    Read Until Prompt
                           
            ELSE
                Log   ${\n}Rstate in both places are equal
            END
            # Execute Command    cd /eniq/sw/installer ; ./activate_interface -o eniq_oss_1 -t ${intf_name}
        END
    END
TP - ENIQ_TP_UG_TC75,TP - ENIQ_TP_UG_TC76 Activating Interface DC 
    IF    '${package}' == 'DC_E_cNELS' or '${package}' == 'DC_E_cRAN'
		Open Connection And Log In
        Write    cd 
		Read    delay=10s
		Set Client Configuration    prompt=eniqs[eniq_stats] {dcuser} #:    timeout=3600
		Write    cd /eniq/sw/installer ; rm -rf tp_stage_file ; rm -rf install_lockfile 
		Read Until Prompt
		Write    cd /eniq/sw/installer ; ./activate_interface -o eniq_oss_1 -t ${package}
		${out}=     Read Until Prompt
		sleep	120
		Write    cd /eniq/home/dcuser
		Read    delay=10s
		Set Client Configuration    prompt=eniqs[eniq_stats] {dcuser} #:    timeout=300
		#Write    echo -e "select INTERFACENAME from InterfaceDependency where TECHPACKNAME= '${package}'\\n${run}\\n" | isql -P ${password_db} -U ${username} -S ${database} -b
		#${output1}=    Read until Prompt
		Log    ${cRANintf}
		${name}   ${dep_int}     tp.Dependent pkg and intf  ${package}  ${cRANintf}
		Set Global Variable    ${dep_int}
		Set Global Variable    ${name}
		FOR    ${intf_name}    IN    @{dep_int}
			${intf_name_verified}=    Run Keyword And Return Status    Should Contain Any   ${out}    ${intf_name} 
			IF    '${intf_name_verified}' == 'True'
				Log   ${intf_name} already installed
				
			ELSE
                Write    cd /eniq/sw/installer ; ./activate_interface -o eniq_oss_1 -i ${intf_name}
				${newinterface}=     Read Until Prompt
				#Execute Command    cd /eniq/sw/installer ; ./activate_interface -o eniq_oss_1 -i ${intf_name}
				Sleep	120s	
			END
		END
	ELSE
        Open Connection And Log In
		Write    cd 
		Read    delay=10s
		Set Client Configuration    prompt=eniqs[eniq_stats] {dcuser} #:    timeout=3600
		Write    cd /eniq/sw/installer ; rm -rf tp_stage_file ; rm -rf install_lockfile 
		Read Until Prompt
		Write    cd /eniq/sw/installer ; ./activate_interface -o eniq_oss_1 -t ${package}
		${out}=     Read Until Prompt
		sleep	120
		Write    cd /eniq/home/dcuser
		Read    delay=10s
		Set Client Configuration    prompt=eniqs[eniq_stats] {dcuser} #:    timeout=3600
		Write    echo -e "select INTERFACENAME from InterfaceDependency where TECHPACKNAME= '${package}'\\n${run}\\n" | isql -P ${password_db} -U ${username} -S ${database} -b
		${output1}=    Read until Prompt
        IF    '${package}' == 'DC_E_CUDB'
            ${name}   ${dep_int}     tp.Dependent pkg and intf cudb  ${package}  ${output1}
			Set Global Variable    ${dep_int}
			Set Global Variable    ${name}
            FOR    ${intf_name}    IN    @{dep_int}
                Set Client Configuration    prompt=eniqs[eniq_stats] {dcuser} #:    timeout=3600
                Write    cd /eniq/sw/installer ; rm -rf tp_stage_file ; rm -rf install_lockfile 
                Read Until Prompt
                Write    cd /eniq/sw/installer ; ./activate_interface -o eniq_oss_2 -i ${intf_name}
                ${out}=     Read Until Prompt
                Sleep    3m 
            END
		ELSE
            IF    '${package}' == 'DC_E_ERBS'
                        Set Client Configuration    prompt=eniqs[eniq_stats] {dcuser} #:    timeout=3600
                        ${name}   ${dep_int}     tp.Dependent pkg and intf ERBS  ${package}  ${output1}
                        Set Global Variable    ${dep_int}
                        Set Global Variable    ${name}
            ELSE
                IF    '${package}' == 'DC_E_VPP'
                    ${name}   ${dep_int}     tp.Dependent pkg and intf VPP  ${package}  ${output1}
                    Set Global Variable    ${dep_int}
                    Set Global Variable    ${name}
                ELSE
                    ${name}   ${dep_int}     tp.Dependent pkg and intf  ${package}  ${output1}
                    Set Global Variable    ${dep_int}
                    Set Global Variable    ${name}
                END
            END
        END
		# ${name}   ${dep_int}     tp.Dependent pkg and intf  ${package}  ${output1}
		# Set Global Variable    ${dep_int}
		# Set Global Variable    ${name}
		FOR    ${intf_name}    IN    @{dep_int}
			${intf_name_verified}=    Run Keyword And Return Status    Should Contain Any   ${out}    ${intf_name} 
			IF    '${intf_name_verified}' == 'True'
				Log   ${intf_name} already installed
				
			ELSE
                IF    '${package}' == 'DC_E_CUDB'
                    Write    cd /eniq/sw/installer ; ./activate_interface -o eniq_oss_2 -i ${intf_name}
                    ${newinterface}=     Read Until Prompt
                    #Execute Command    cd /eniq/sw/installer ; ./activate_interface -o eniq_oss_1 -i ${intf_name}
                    Sleep	120s
                ELSE
                    Write    cd /eniq/sw/installer ; ./activate_interface -o eniq_oss_1 -i ${intf_name}
                    ${newinterface}=     Read Until Prompt
                    #Execute Command    cd /eniq/sw/installer ; ./activate_interface -o eniq_oss_1 -i ${intf_name}
                    Sleep	120s
                END	
			END
		END
	END	
TP - ENIQ_TP_UG_TC78 Download Latest Epfg
    Write    cd /eniq/home/dcuser
    Read    delay=10s
    # Set Client Configuration    prompt=eniqs[eniq_stats] {dcuser} #:    timeout=3600
    # Open clearcasevobs
    # ${epfgpkgtmp}=    Get Element Attribute    //a[contains(text(),'epfg_ft')]    href
    # ${epfgpkg}=    Fetch From Right    ${epfgpkgtmp}    /
    # Set Global Variable    ${epfgpkg}    ${epfgpkg}
    # ${epfgrstate}=    Fetch From Right    ${epfgpkg}    _
    # ${epfgrstate}=    Catenate    SEPARATOR=    epfg_    ${epfgrstate}
    # Set Global Variable    ${epfgrstate}    ${epfgrstate}
    # Log    ${index}
    # Open Connection    ${jnkns_server}
    # Login               root        shroot
    # Write    rm -rf tppkg ; mkdir tppkg ; cd tppkg ; wget ${epfgpkgtmp} ; pwd
    # Read    delay=100s
    # Switch Connection    ${index}
    # Write    cd 
    # Read    delay=10s
    Open connection as root user
    Set Client Configuration    prompt=eniqs[eniq_stats] {root} #:    timeout=3600
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
	
TP - ENIQ_TP_UG_TC78 Install Epfg 
    Write    cd /eniq/home/dcuser
    Read    delay=10s
    # Set Client Configuration    prompt=eniqs[eniq_stats] {dcuser} #:    timeout=300 
    Open Connection And Log in
    Write    cd /eniq/home/dcuser
    Read    delay=10s
    Set Client Configuration    prompt=eniqs[eniq_stats] {dcuser} #:    timeout=300
    # Write    su - dcuser
    # Write    Dcuser%12
    # Write    cd /eniq/home/dcuser
    # Write    ls
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
    # Put File    /root/tppkg/${epfgpkg}     /eniq/home/dcuser
    # Write    cd /eniq/home/dcuser ; rm -r epfg ; unzip -o ${epfgpkg} ; unzip -o ${epfgrstate} ; cd epfg ; chmod -R 777 *.* ; ./epfg_preconfig_for_ft.sh 
    # Read Until Prompt
TP - ENIQ_TP_UG_TC77 Editing Engine.properties file
    Write    cd /eniq/home/dcuser
    Read    delay=2s
    Set Client Configuration    prompt=eniqs[eniq_stats] {dcuser} #:    timeout=300
	Log  ${\n}Dependent names are: ${\n}${dep_int}
    setting to finest   ${name}    ${host}
    Log      ${\n}Changed the Dependent Interfaces value from INFO to FINEST.    

TP - ENIQ_TP_UG_TC81 Generate PM Files without Suspected data
    Write    cd /eniq/home/dcuser
    Read    delay=10s
    ${date_hour}=    Execute Command    date -d 'day' '+%H'
    log    ${date_hour}
    Set Global Variable    ${date_hour}
    IF    '${date_hour}'>='22'
        Log    'today date'
        ${date}=    Execute Command    date -d '' '+%Y-%m-%d'
	    Set Global Variable    ${date}
        Set Client Configuration    prompt=eniqs[eniq_stats] {dcuser} #:    timeout=3600
        Put File    ${path}/ENIQ_TC_Automation/TP/Resources/epfgerbs1.pl    /eniq/home/dcuser
        Edit Epfg For Counter Validation N Multiple Oss    ${host}    ${port}    ${uname}    ${pwd}
        Write     cd /eniq/home/dcuser ; echo -e "${full_pkg_name}" | perl epfgerbs1.pl  

    ELSE
        Log    'Yesterday date'
        ${date}=    Execute Command    date -d '-1 day' '+%Y-%m-%d'
	    Set Global Variable    ${date}
        Set Client Configuration    prompt=eniqs[eniq_stats] {dcuser} #:    timeout=3600
        IF    '${package}' == 'DC_E_CUDB'
            Put File    ${path}/ENIQ_TC_Automation/TP/Resources/CUDB_SPEC.pl    /eniq/home/dcuser
            Edit Epfg For Cudbenmpmfile     ${host}    ${port}    ${uname}    ${pwd}
            Write     cd /eniq/home/dcuser ; echo -e "${full_pkg_name}" | perl CUDB_SPEC.pl
        ELSE
            IF    '${package}' == 'DC_E_BULK_CM'
                Put File    ${path}/ENIQ_TC_Automation/TP/Resources/epfg_bulk.pl    /eniq/home/dcuser
                ${dt}    Execute Command    date -d '5 Min' '+%d-%m-%Y-%H:%M'
                Edit Epfg For Bulk Cm    ${host}    ${port}    ${uname}    ${pwd}    ${dt}
                Write     cd /eniq/home/dcuser ; echo -e "${full_pkg_name}" | perl epfg_bulk.pl        
            ELSE
                Put File    ${path}/ENIQ_TC_Automation/TP/Resources/epfgerbs.pl    /eniq/home/dcuser
                Edit Epfg For Counter Validation N Multiple Oss    ${host}    ${port}    ${uname}    ${pwd}
                Write     cd /eniq/home/dcuser ; echo -e "${full_pkg_name}" | perl epfgerbs.pl 
            END    
        END
    END
    ${out}=    Read Until Prompt
	Write    cd /eniq/home/dcuser/epfg ; ./start_epfg.sh
	${out}=    Read Until Prompt
	Sleep    300s
    Log    ${\n}Starting Adapter Set
    FOR    ${intf_name}    IN    @{dep_int}		
		Write    echo -e "select DATAFORMATTYPE from DataInterface where INTERFACENAME LIKE '${intf_name}'\\n${run}\\n" | isql -P ${password_db} -U ${username} -S ${database} -b
		${par}    Read    delay=3s
		${parser_name}    Get Parser Value    ${par}
		${oss}    ${adapter}    Adapter Activate    ${intf_name}    ${parser_name}
		Write     engine -e startSet '${oss}' '${adapter}'
		${out}    Read Until Prompt    strip_prompt=True
		Log    ${\n}${out}
		Should Contain    ${out}    Start set requested successfully    Failed starting Adapter set for ${intf_name}
	END
    Log    ${\n}Adapter Set Successfully Started
    Sleep    300s
TP - ENIQ_TP_UG_TC Counter data Validation
    Skip If    '${package}' == 'DC_E_IPTRANSPORT'    Skipping this TestCase Execution Since it is not applicable for ${package}
    Set Client Configuration    prompt=eniqs[eniq_stats] {dcuser} #:    timeout=3600
    Write    cd /eniq/home/dcuser
    Read    delay=10s
    
    Write    echo -e "Select Top 1 dataname from Measurementkey where typeid like '${package}:%' and iselement like'1' and uniquekey like '1'\\n${run}\\n" | isql -P ${password_db} -U ${username} -S ${database} -b
	${output}=    Read Until Prompt    
    ${node}=    filter name    ${output}
    #Write    echo -e "select top 1 basetablename from MeasurementTable where MTABLEID LIKE '${package}:(%' and (TABLELEVEL= 'raw')\\n${run}\\n" | isql -P ${password_db} -U ${username} -S ${database} -b
	Write    echo -e "select TOP 1 TYPENAME from MeasurementType WHERE TYPEID like '%${package}%' and Description not like '%Deprecated%' and followjohn='1' and RANKINGTABLE='0'\\n${run}\\n" | isql -P ${password_db} -U ${username} -S ${database} -b
    ${output1}=    Read Until Prompt     
	${table}=    Filter Name    ${output1}
	Write    echo -e "select distinct ${node} from ${table}_RAW where datetime_id = '${date} 10:00:00'\\n${run}\\n" | isql -P Dc12# -U Dc -S dwhdb -b
	${output2}=    Read Until Prompt    
	${node_name}=    filter name    ${output2}
    Write    rm -rf BT-FT_Log ; rm -rf BT-FT_Script
    Read Until Prompt
    Open nexus tpkpiscript
   # ${btft_link}=    Get Element Attribute    //a[contains(text(),'BT-FT')]    href
    ${btft_link}=    Get Element Attribute    (//a[contains(text(),'BT-FT_Script')])[last()-1]    href
    ${btft_script}=    Fetch From Right    ${btft_link}    /
	# Open Connection    ${jnkns_server}
    # Login               root        shroot
    # Write    rm -rf tppkg ; mkdir tppkg ; cd tppkg ; wget ${btft_link} ; pwd
    # Read    delay=20s
    # Switch Connection    ${index}
    # Put File    /root/tppkg/${btft_script}    /eniq/home/dcuser
    # Write    cd /eniq/home/dcuser ; unzip -o ${btft_script} ; cd BT-FT_Script/ ; chmod 777 *
    # Read Until Prompt
    # changing bt ft file    ${host}    ${port}    ${uname}    ${pwd}
    Open Connection    ${jnkns_server}
    Login               root        shroot
    Write    rm -rf tppkg ; mkdir tppkg ; cd tppkg ; wget ${btft_link} ; pwd
    Read    delay=20s
    Switch Connection    ${index}
    Put File    /root/tppkg/${btft_script}    /eniq/home/dcuser
    Write    cd /eniq/home/dcuser ; unzip -o ${btft_script} ; cd BT-FT_Script/ ; chmod 777 *
    Read Until Prompt
    changing bt ft file    ${host}    ${port}    ${uname}    ${pwd}
    Write    cd 
    Read    delay=10s
    Execute Command    cd /eniq/home/dcuser/BT-FT_Script/ ; sed -i -e 's/\r$//' BT-FT_script.sh
    Write    cd /eniq/home/dcuser/BT-FT_Script/ ; echo -e "${full_pkg_name}\\n5,7\\n${date} 10:00:00\\n${node}\\n${node_name}\\nNE_NAME" |./BT-FT_script.sh    
    ${Execute}=    Read Until Prompt
    ${status}=    BT_FT_validation_For_Aggregation    ${Execute}
    IF    ${status} == False
        Fail   ${\n}${Execute}
    END
TP - ENIQ_TP_UG_TC206 DC_E_IPTRANSPORT Specific
    Skip If    '${package}' != 'DC_E_IPTRANSPORT'    Skipping this TestCase Execution Since it is not applicable for ${package}
    Set Client Configuration    prompt=eniqs[eniq_stats] {dcuser} #:    timeout=3600
    Write    cd /eniq/home/dcuser
    Read    delay=10s
    
    Write    echo -e "Select Top 1 dataname from Measurementkey where typeid like '${package}:%' and iselement like'1' and uniquekey like '1'\\n${run}\\n" | isql -P ${password_db} -U ${username} -S ${database} -b
	${output}=    Read Until Prompt    
    ${node}=    filter name    ${output}
    Write    echo -e "select top 1 basetablename from MeasurementTable where MTABLEID LIKE '${package}:(%' and (TABLELEVEL= 'raw')\\n${run}\\n" | isql -P ${password_db} -U ${username} -S ${database} -b
	${output1}=    Read Until Prompt     
	${table}=    Filter Name    ${output1}
	Write    echo -e "select distinct ${node} from ${table} where datetime_id = '${date} 10:00:00'\\n${run}\\n" | isql -P Dc12# -U Dc -S dwhdb -b
	${output2}=    Read Until Prompt    
	${node_name}=    filter name    ${output2}
    Write    rm -rf BT-FT_Log ; rm -rf BT-FT_Script
    Read Until Prompt
    Open nexus tpkpiscript
   # ${btft_link}=    Get Element Attribute    //a[contains(text(),'BT-FT')]    href
    ${btft_link}=    Get Element Attribute    (//a[contains(text(),'BT-FT_Script')])[last()-1]    href
    ${btft_script}=    Fetch From Right    ${btft_link}    /
	# Open Connection    ${jnkns_server}
    # Login               root        shroot
    # Write    rm -rf tppkg ; mkdir tppkg ; cd tppkg ; wget ${btft_link} ; pwd
    # Read    delay=20s
    # Switch Connection    ${index}
    # Put File    /root/tppkg/${btft_script}    /eniq/home/dcuser
    # Write    cd /eniq/home/dcuser ; unzip -o ${btft_script} ; cd BT-FT_Script/ ; chmod 777 *
    # Read Until Prompt
    # changing bt ft file    ${host}    ${port}    ${uname}    ${pwd}
    Open Connection    ${jnkns_server}
    Login               root        shroot
    Write    rm -rf tppkg ; mkdir tppkg ; cd tppkg ; wget ${btft_link} ; pwd
    Read    delay=20s
    Switch Connection    ${index}
    Put File    /root/tppkg/${btft_script}    /eniq/home/dcuser
    Write    cd /eniq/home/dcuser ; unzip -o ${btft_script} ; cd BT-FT_Script/ ; chmod 777 *
    Read Until Prompt
    changing bt ft file    ${host}    ${port}    ${uname}    ${pwd}
    Write    cd 
    Read    delay=10s
    Execute Command    cd /eniq/home/dcuser/BT-FT_Script/ ; sed -i -e 's/\r$//' BT-FT_script.sh
    Write    cd /eniq/home/dcuser/BT-FT_Script/ ; echo -e "${full_pkg_name}\\n5,7,15\\n${date} 10:00:00\\n${node}\\n${node_name}\\nNE_NAME" |./BT-FT_script.sh    
    ${Execute}=    Read Until Prompt
    ${status}=    BT_FT_validation_For_Aggregation    ${Execute}
    IF    ${status} == False
        Fail   ${\n}${Execute}
    END

TP - ENIQ_TP_UG_TC82 Generate PM Files with Suspected data
    Write    cd /eniq/home/dcuser
    Read    delay=10s
    Set Client Configuration    prompt=eniqs[eniq_stats] {dcuser} #:    timeout=3600
    IF    '${package}' == 'DC_E_CUDB'
        Put File    ${path}/ENIQ_TC_Automation/TP/Resources/epfg_suspected.pl    /eniq/home/dcuser
        Edit Epfg For Cudbenmpmfile     ${host}    ${port}    ${uname}    ${pwd}
        Write     cd /eniq/home/dcuser ; echo -e "${full_pkg_name}" | perl epfg_suspected.pl
    ELSE
        Put File    ${path}/ENIQ_TC_Automation/TP/Resources/epfg_suspected.pl    /eniq/home/dcuser
        Write     echo -e "${full_pkg_name}" | perl epfg_suspected.pl
    END
    ${out}=    Read Until Prompt
	Write    cd /eniq/home/dcuser/epfg ; ./start_epfg.sh
	${out}=    Read Until Prompt
	Sleep    120s

TP - ENIQ_TP_UG_TC83,TP - ENIQ_TP_UG_TC84 Starting Adapter Set for Interfaces
    Write    cd /eniq/home/dcuser
    Read    delay=10s
    Set Client Configuration    prompt=eniqs[eniq_stats] {dcuser} #:    timeout=3600
    Log    ${\n}Starting Adapter Set
    FOR    ${intf_name}    IN    @{dep_int}		
		Write    echo -e "select DATAFORMATTYPE from DataInterface where INTERFACENAME LIKE '${intf_name}'\\n${run}\\n" | isql -P ${password_db} -U ${username} -S ${database} -b
		${par}    Read    delay=3s
		${parser_name}    Get Parser Value    ${par}
        IF    '${package}' == 'DC_E_CUDB'
            ${oss}    ${adapter}    tp.Adapter Activate1    ${intf_name}    ${parser_name}
        ELSE
		    ${oss}    ${adapter}    Adapter Activate    ${intf_name}    ${parser_name}
        END
		Write     engine -e startSet '${oss}' '${adapter}'
		${out}    Read Until Prompt    strip_prompt=True
		Log    ${\n}${out}
		Should Contain    ${out}    Start set requested successfully    Failed starting Adapter set for ${intf_name}
        Sleep    300s
	END
    Log    ${\n}Adapter Set Successfully Started
    Sleep    300s
CHECKING ENM MAPPING 
    Skip If    '${package}' != 'DC_E_CUDB'    Skipping the execution since this testcase is not applicable for ${package}
    IF    '${package}' == 'DC_E_CUDB'
        Set Client Configuration    prompt=eniqs[eniq_stats] {dcuser} #:    timeout=3600
        ${mapping}    Execute Command    cd /eniq/log/sw_log/engine/${intf_name}-eniq_oss_2 ; ls -Art engine*.log | tail -n 1
        Log    ${mapping}
        ${mapping1}    Execute Command    cd /eniq/log/sw_log/engine/${intf_name}-eniq_oss_2 && cat ${mapping}
        ${flag}    ${message}      tp.mapping or not      ${mapping1}
        IF    ${flag}
            Log    ${message}
        ELSE
            Log    ${message}
            
        END
    END
TP - ENIQ_TP_UG_TC85 Verify Raw Table Loading 
    Write    cd /eniq/home/dcuser
	Read    delay=3s
	Set Client Configuration    prompt=eniqs[eniq_stats] {dcuser} #:    timeout=3500
    # Open clearcasevobs
    # ${buildno}    Get Element Attribute    //table//a[text()='${package}']    href
    # ${buildno}    Fetch From Right    ${buildno}    _b
    # ${buildno}    Split String From Right    ${buildno}    .
    ${buildno}    Split String From Right    ${full_pkg_name}    ${package}_
    Log    ${buildno}
    ${buildno}    Split String    ${buildno}[1]    _b
    ${buildno}    Split String    ${buildno}[1]    .tpi
   # Log    ${buildno}[0]
    ${buildno}    Set Variable    ${buildno}[0]
    Set Global Variable    ${buildno}
    Write    echo -e "select TYPENAME from MeasurementType WHERE TYPEID like '%${package}:((${buildno}))%' and Description not like '%Deprecated%' and followjohn='1' and RANKINGTABLE='0'\\n${run}\\n" | isql -P ${password_db} -U ${username} -S ${database} -b
    ${table_names}    Read Until Prompt
    ${table_names}    Split String    ${table_names}
    ${length}    Get Length    ${table_names}
    ${total_tables}    Evaluate    ${length}-3 
    FOR    ${i}    IN RANGE   0    ${total_tables}
        Write    echo -e "select rowstatus from ${table_names}[${i}]_RAW where DATE_ID='${date}';\\n${run}\\n" | isql -P ${password_dwhdb} -U ${username_dwhdb} -S ${database_dwhdb} -b
        ${status}    Read Until Prompt
        ${status}    Split String    ${status}
        ${length}    Get Length    ${status}
        ${status}    Evaluate    ${length}-3
        IF    ${length}<7
            Run Keyword And Continue On Failure    Fail    ${\n}${table_names}[${i}] <--Table Data Showing Empty in Database.
        ELSE
            Log    ${\n}All Tables Data is loaded correctly.
        END
    END    
# TP - ENIQ_TP_UG_TC180 Steps for ENM mapping in vapp servers 
#     Skip If    '${package}' != 'DC_E_CUDB'    Skipping the execution since this testcase is not applicable for ${package}
#     Write    cd /eniq/home/dcuser
#     Read    delay=10s
#     Open connection as root user 
#     ${output}    Execute Command      cd /eniq/sw/conf/ ; echo "eniq_oss_2 2.2.2.2" >> .oss_ref_name_file && vi .oss_ref_name_file -c ":wq" 
#     ${output1}    Execute Command   cd /eniq/sw/conf/ && cat .oss_ref_name_file
#     #  Log    ${output1}
#     sleep    1m
#     ${execute}    Execute Command    cd /eniq/connectd/mount_info/ && cat .oss_ref_name_file 
#     Log    ${execute}
#     ${flag}    ${message}    checking    ${output1}    ${execute}
#     IF    ${flag}
#         Log    'matching'
#     ELSE
#         Log    'not matching'
#     END    
   
#     # Should Be Equal As Strings     ${output1}    ${execute}
# #     Create Directory And File    
# #    [Arguments]    ${dir_path}    ${file_path}
#     ${dir_exists}=   Run Keyword And Return Status  Directory Should Exist    ${dir_path}
#     ${dir_exist}=   Return True False    ${dir_exists}
#     IF    '${dir_exist}' == 'False'
#         ${dir_created}=    Write    mkdir ${dir_path}
#          Log    " ${dir_created} directory successfully created"
#     END
    
#     ${file_exists}=    Run Keyword And Return Status    File Should Exist    ${file_path}
#     ${file_exist}=    Return True False    ${file_exists}
#     IF    '${file_exist}' == 'False'
#             ${file_created}=    Write    touch ${file_path}
#             Log    "${file_created} file created successfully "
            
#     END  
   
# #Content to add in fs_mount_list
#     ${add1}     Execute Command   cd /eniq/connectd/mount_info/eniq_oss_2/ ; echo "2.2.2.2 /vx/ENM434-pm1 /pmic1" >> fs_mount_list && vi fs_mount_list -c ":wq"
#     ${add2}    Execute Command    cd /eniq/connectd/mount_info/eniq_oss_2/ ; echo "2.2.2.2 /vx/ENM434-pm2 /pmic2" >> fs_mount_list && vi fs_mount_list -c ":wq"
#     ${ADD}    Execute Command    cd /eniq/connectd/mount_info/eniq_oss_2/ && cat fs_mount_list
#     Log    ${ADD}

# #switch to dcuser
#     Write    su - dcuser
# #     Log        login dcuser
# #Restart the engine service
#     Set Client Configuration    prompt=eniqs[eniq_stats] {dcuser} #:    timeout=3600
#     Write    engine restart
#             ${output1}=    Read Until Prompt
#             Write    engine -e status
#             ${output2}=    Read Until Prompt 
#             ${engine_profile}=    Getting engine profile       ${output2}
#             IF    '${engine_profile}' == 'Current Profile: NoLoads'
#                 Write    engine -e changeProfile 'NoLoads'
#                 ${output3}=    Read Until Prompt
#                 ${contains}=    Run Keyword And Return Status    Should Contain    ${output3}    Change profile requested successfully
#                 IF    '${contains}' != 'True'
#                     Fail
#                 END
#             END         
#     Sleep    3m
  
# #Activating Interface
#     Set Client Configuration    prompt=eniqs[eniq_stats] {dcuser} #:    timeout=3600
#     Write    cd /eniq/sw/installer ; ./activate_interface -o eniq_oss_2 -i ${intf_name}
#     ${out}=     Read Until Prompt
#     Sleep    3m 
# #edit epfg file
#     Set Client Configuration    prompt=eniqs[eniq_stats] {dcuser} #:    timeout=3600
    
#     Put File    CUDB_SPEC.pl    /eniq/home/dcuser
#     Edit Epfg For Cudbenmpmfile     ${host}    ${port}    ${uname}    ${pwd}
# 	Write     cd /eniq/home/dcuser ; echo -e "${package}_R34A_b119.tpi" | perl CUDB_SPEC.pl
#     ${out}=    Read Until Prompt
    
#     ${output}    Execute Command    cd /eniq/home/dcuser/epfg ; ./start_epfg.sh
#     Sleep    2m

# #check the filename of PM file generation
#     Set Client Configuration    prompt=eniqs[eniq_stats] {dcuser} #:    timeout=3600
#     write    cd /eniq/data/pmdata/eniq_oss_2/CUDB_ECIM/dir1 ;ls
#     ${file_name}    Read Until Prompt
#     Log    ${file_name} 
#     ${NE_ID}       verify key    ${file_name}
#     Log    ${NE_ID} 
#     ${cudb_keyname}    Verify Key1    ${file_name}    
    
# #change info to finest
#     Set Client Configuration    prompt=eniqs[eniq_stats] {dcuser} #:    timeout=300
# 	Write    echo -e "${sql_query_for_dependnt_intf_on_tp}\\n${run}\\n" | isql -P ${password_db} -U ${username} -S ${database} -b
#     ${output1}=    Read until prompt
#     ${name}   ${dep_int}     tp.Dependent pkg and intf  ${package}   ${output1}
#     Set Global Variable    ${dep_int}
#     Log  ${\n}Dependent names are: ${\n}${dep_int}
#     Log    ${name}   
#     setting_to_finest_CUDB   ${name}    ${host}
#     Log      ${\n}Changed the Dependent Interfaces value from INFO to FINEST.
    
	
# #Starting Adapter Set for Interfaces
#     Set Client Configuration    prompt=eniqs[eniq_stats] {dcuser} #:
#     Log    ${\n}Starting Adapter Set
#     #FOR    ${intf_name}    IN    @{dep_int}
#     Write    echo -e "select DATAFORMATTYPE from DataInterface where INTERFACENAME LIKE '${intf_name}'\\n${run}\\n" | isql -P ${password_db} -U ${username} -S ${database} -b
#     ${par}    Read Until Prompt
#     ${parser_name}    Get Parser Value    ${par}
#     ${oss}    ${adapter}    Adapter Activate1    ${intf_name}    ${parser_name}
#     Write     engine -e startSet '${oss}' '${adapter}'
#     ${out}    Read Until Prompt    strip_prompt=True
#     Log    ${\n}${out}
#     Should Contain    ${out}    Start set requested successfully    Failed starting Adapter set for ${intf_name}
#     Sleep    3m         
#     #END
#     Log    ${\n}Adapter Set Successfully Started

#     #check eniqoss mapping or not
# #check eniqoss mapping or not
#     Set Client Configuration    prompt=eniqs[eniq_stats] {dcuser} #:    timeout=3600
#     ${mapping}    Execute Command    cd /eniq/log/sw_log/engine/${intf_name}-eniq_oss_2 ; ls -Art engine*.log | tail -n 1
#     Log    ${mapping}
#     ${mapping1}    Execute Command    cd /eniq/log/sw_log/engine/${intf_name}-eniq_oss_2 && cat ${mapping}
#     ${flag}    ${message}      mapping or not      ${mapping1}
#     IF    ${flag}
#         Log    ${message}
#     ELSE
#         Log    ${message}
        
#     END
Verifying cudb_system key
    Skip If    '${package}' != 'DC_E_CUDB'    Skipping the execution since this testcase is not applicable for ${package}
    Set Client Configuration    prompt=eniqs[eniq_stats] {dcuser} #:    timeout=3600
    # Test
    Write    echo -e "select BASETABLENAME from Measurementtable where MTABLEID LIKE 'DC_E_CUDB:(%' and (TABLELEVEL= 'raw')\\n${run}\\n" | isql -P ${password_db} -U ${username} -S ${database} -b
    ${out1}=    Read Until Prompt 
    ${out2}    deletelastrows    ${out1}
    ${out}    Split String    ${out2}    
    
    FOR    ${i}    IN    @{out}
        ${k}    Strip String    ${i}
        # open dcuser connection
        # Set Client Configuration    prompt=eniqs[eniq_stats] {dcuser} #:    timeout=3600
        # Test
        Write    echo -e "select cudb_system from ${k} where NE_ID ='${NE_ID}' AND DATETIME_ID='${date}' and oss_id like '%eniq_oss_1%'\\n${run}\\n" | isql -P Dc12# -U Dc -S dwhdb -b
	#Write    echo -e "select cudb_system from ${k} where  DATETIME_ID='${date}'\\n${run}\\n" | isql -P Dc12# -U Dc -S dwhdb -b
        ${cudb_key}    Read Until Prompt
        Log     ${cudb_key}
        ${key}    Split String    ${cudb_key}    
        ${verify_cudb_key}    Strip String    ${key}[0]
        Log     ${verify_cudb_key} 
        ${check}=    Run Keyword And Return Status   Should Contain Any    ${cudb_key}    'cudb_system' not found  
        Log    ${check}
        ${flag}    ${message}    verify sql cudb key    ${verify_cudb_key}     ${check}       ${cudb_keyname} 

        IF    ${flag}
            Log    ${message}
        ELSE
            Log    ${message}
            Fail
        END

    END
Starting Aggregation
    #Skip If    '${package}' == 'DC_E_NETOP'    Skipping this TestCase Execution Since it is not applicable for ${package}
    Skip IF    '${package}' == 'DC_E_NETOP' or '${package}' == 'DC_E_BULK_CM'   Skipping this TestCase Execution Since it is not applicable for ${package}
    Write    cd /eniq/home/dcuser
    Read    delay=10s
    IF    '${date_hour}'>='22'
        log    'today date'
        Sleep    2h

    ELSE
        log    'yesterday date'
    END
    Set Client Configuration    prompt=eniqs[eniq_stats] {dcuser} #:    timeout=3600
    Write    echo -e "select basetablename from MeasurementTable where MTABLEID LIKE '${package}:%' and TABLELEVEL in('DAY','COUNT')\\n${run}\\n" | isql -P ${password_db} -U ${username} -S ${database} -b
	${out}    Read    delay=5s
	${table_name}    Get Table Names    ${package}    ${out}
	FOR    ${table}    IN    @{table_name}
		write     engine -e startSet '${package}' '${table}' 
		${out}    Read Until Prompt    strip_prompt=True
		Log    ${\n}${out} 
		Should Contain    ${out}    Start set requested successfully    Failed Aggregation for ${table}
	END
	Write    echo -e "/eniq/sw/bin/engine -e startSet DWH_MONITOR AutomaticREAggregation\\n" | isql -P ${password_db} -U ${username} -S ${database} -b
	${Reaggregation}    Read Until Prompt   
TP - ENIQ_TP_UG_TC95 Configuration of Custom Placeholder(CP) for BUSY HOUR check
    #Skip If    '${package}' == 'DC_E_NETOP'   Skipping this TestCase Execution Since it is not applicable for ${package}
    Skip IF    '${package}' == 'DC_E_NETOP' or '${package}' == 'DC_E_BULK_CM'   Skipping this TestCase Execution Since it is not applicable for ${package}
    Write    cd /eniq/home/dcuser
    Read    delay=10s
    Set Client Configuration    prompt=eniqs[eniq_stats] {dcuser} #:    timeout=3600
	Write    echo -e "select top 1 typeid from measurementcounter where typeid like '${package}%'\\n${run}\\n" | isql -P ${password_db} -U ${username} -S ${database} -b
	${out1}=    Read Until Prompt
	${typeid}=    tp.Filter Name    ${out1}
	${tablename}=    Split String From Right    ${typeid}    separator=:    max_split=1
	Write    echo -e "select bhobject from busyhourmapping where typeid = '${typeid}' and bhtype='CP0'\\n${run}\\n" | isql -P ${password_db} -U ${username} -S ${database} -b
	${out2}=    Read Until Prompt
	${bhobject}=    tp.Filter Name    ${out2}
    Set Global Variable    ${bhobject}
	Write    echo -e "select bhlevel from busyhourmapping where typeid = '${typeid}' and bhtype='CP0' and bhobject = '${bhobject}'\\n${run}\\n" | isql -P ${password_db} -U ${username} -S ${database} -b
	${out3}=    Read Until Prompt
	${bhlevel}=    tp.Filter Name    ${out3}
	Write    echo -e "select versionid from DWHTechPacks where techpack_name = '${package}'\\n${run}\\n" | isql -P ${password_db} -U ${username} -S ${database} -b
	${out4}=    Read Until Prompt
	${version_id}=    tp.Filter Name    ${out4}
	Write    echo -e "select top 1 basetablename from measurementtable where tablelevel ='RAW' and typeid like '${package}%' order by basetablename asc\\n${run}\\n" | isql -P ${password_db} -U ${username} -S ${database} -b
	${out5}=    Read Until Prompt
	${typename}=    tp.Filter Name    ${out5}
	Write    echo -e "insert into busyhoursource (VERSIONID,BHLEVEL,BHTYPE,TYPENAME,TARGETVERSIONID,BHOBJECT) values ('${version_id}','${bhlevel}','CP0','${typename}','${version_id}','${bhobject}')\\n${run}\\n" | isql -P ${password_db} -U ${username} -S ${database} -b
	${out6}=    Read Until Prompt
	${Insert_id}=    tp.Filter Name    ${out6}
    Sleep    2m
	Write    echo -e "select top 1 dataname from measurementcounter where typeid = '${typeid}'\\n${run}\\n" | isql -P ${password_db} -U ${username} -S ${database} -b
	${out7}=    Read Until Prompt
	${countername}=    tp.Filter Name    ${out7}
	Write    echo -e "UPDATE Busyhour SET BHCRITERIA='SUM(${countername})' , description='Test' , enable = 1 WHERE BHTYPE='CP0' and BHLEVEL='${bhlevel}';\\n${run}\\n" | isql -P ${password_db} -U ${username} -S ${database} -b
	${out8}=    Read Until Prompt
	${Updated_id}=    tp.Filter Name    ${out8}
    Sleep    2m
    Write    echo -e "select DATANAME from Measurementkey where typeid like '%${version_id}:${bhlevel}%'\\n${run}\\n" | isql -P ${password_db} -U ${username} -S ${database} -b
    # Write    echo -e "select   dataname from Measurementkey where typeid like '%${bhlevel}%'\\n${run}\\n" | isql -P ${password_db} -U ${username} -S ${database} -b
    ${keys}    Read Until Prompt
    #${check}=    Run Keyword And Return Status   Should Contain Any    ${keys}    0 rows  
    ${keys1}    deletelastrows    ${keys}
    ${keysname}    Split String    ${keys1}
    # ${keyss}    Get Length    ${keysname}
    ${index} =    Set Variable    -1
     FOR    ${i}    IN    @{keysname}
        ${index}=    Evaluate    ${index} + 1
        #Log    ${version_id},${bhlevel},${i},${typename}.${i},${index},${bhobject}
        Write    echo -e "insert into BusyhourRankkeys (VERSIONID,BHLEVEL,BHTYPE,KEYNAME,KEYVALUE,ORDERNBR,TARGETVERSIONID,BHOBJECT) values ('${version_id}','${bhlevel}','CP0','${i}','${typename}.${i}','${index}','${version_id}','${bhobject}')\\n${run}\\n" | isql -P ${password_db} -U ${username} -S ${database} -b  
        ${keysadded}    Read Until Prompt
        Sleep    60s
    END
    Write    echo -e "UPDATE AggregationRule set ENABLE = '1' WHERE BHTYPE='${bhobject}_CP0' and RULETYPE='RANKBH' \\n${run}\\n" | isql -P ${password_db} -U ${username} -S ${database} -b;
    ${AggRUle}=    Read Until Prompt
    Sleep    600s
	write     /eniq/sw/bin/engine -e startSet DWH_MONITOR UpdateFirstLoadings 
	${out}    Read Until Prompt    strip_prompt=True
	Log    ${\n}${out} 
	Should Contain    ${out}    Start set requested successfully    Failed Aggregation for UpdateFirstLoadings
	write     /eniq/sw/bin/engine -e startSet DWH_MONITOR UpdateMonitoredTypes 
	${out}    Read Until Prompt    strip_prompt=True
	Log    ${\n}${out} 
	Should Contain    ${out}    Start set requested successfully    Failed Aggregation for UpdateMonitoredTypes
	write     /eniq/sw/bin/engine -e startSet DWH_MONITOR UpdateMonitoring 
	${out}    Read Until Prompt    strip_prompt=True
	Log    ${\n}${out} 
	Should Contain    ${out}    Start set requested successfully    Failed Aggregation for UpdateMonitoring
	write     /eniq/sw/bin/engine -e startSet DWH_MONITOR AggregationRuleCopy 
	${out}    Read Until Prompt    strip_prompt=True
	Log    ${\n}${out} 
	Should Contain    ${out}    Start set requested successfully    Failed Aggregation for AggregationRuleCopy
	write     /eniq/sw/bin/engine -e startSet DWH_MONITOR AutomaticAggregation 
	${out}    Read Until Prompt    strip_prompt=True
	Log    ${\n}${out} 
	Should Contain    ${out}    Start set requested successfully    Failed Aggregation for AutomaticAggregation
	write     /eniq/sw/bin/engine -e startSet DWH_MONITOR AutomaticREAggregation 
	${out}    Read Until Prompt    strip_prompt=True
	Log    ${\n}${out} 
	Should Contain    ${out}    Start set requested successfully    Failed Aggregation for AutomaticREAggregation
    IF    '${package}' == 'DC_E_ERBS' or '${package}' == 'DC_E_BULK_CM' or '${package}' == 'DC_E_CNAXE' or '${package}' == 'DC_E_SBG' or '${package}' == 'DC_E_GGSN' or '${package}' == 'DC_E_CMN_STS' or '${package}' == 'DC_E_CUDB' or '${package}' == 'DC_E_RBS'
            Sleep    9600s
    ELSE
            Sleep    7200s
    END
# Running BTFT 
#     # write    echo -e "select ACTION_CONTENTS_01 from Meta_transfer_actions WHERE COLLECTION_SET_ID LIKE '286' and ACTION_TYPE LIKE 'parse'\\ngo\\n" | isql -P Etlrep12# -U etlrep -S repdb -b
# 	# ${out}    Read    delay=5s
# 	# ${indir}   get indir value    ${out}
# 	# Log    ${indir}
# 	Open Available Browser    https://arm1s11-eiffel013.eiffel.gic.ericsson.se:8443/nexus/content/repositories/releases/com/ericsson/eniq/stats/tp/CNAXE/cnaxe_bo/    headless=True
# 	${count}=    Get Element Count   //tr
# 	${names}=    Create List
# 	FOR    ${i}    IN RANGE    3   ${count}+1
# 	    ${name}=    Get Text    xpath=//tr[${i}]/td[1]
# 	    Append To List    ${names}    ${name}
# 	END
# 	${a}    Evaluate   sorted(@{names},reverse=True)
	# Log    ${a}


TP - ENIQ_TP_UG_TC50, TP - ENIQ_TP_UG_TC52,TP - ENIQ_TP_UG_TC53, TP - ENIQ_TP_UG_TC80,TP - ENIQ_TP_UG_TC204 Downloading And Installing BT-Ft
    Write    cd 
    Read    delay=10s
	Set Client Configuration    prompt=eniqs[eniq_stats] {dcuser} #:    timeout=3600
	Write    echo -e "Select Top 1 dataname from Measurementkey where typeid like '${package}:%' and iselement like'1' and uniquekey like '1'\\n${run}\\n" | isql -P ${password_db} -U ${username} -S ${database} -b
	${out}=    Read Until Prompt
	${node}=    tp.filter name    ${out}
    # Write    rm -rf BT-FT_Log ; rm -rf BT-FT_Script
    # ${x}=    Read Until Prompt
    Open nexus tpkpiscript
    #${btft_link}=    Get Element Attribute    //a[contains(text(),'BT-FT_Script_R10H_b19')]    href
    ${btft_link}=    Get Element Attribute    (//a[contains(text(),'BT-FT_Script')])[last()-1]    href
    ${btft_script}=    Fetch From Right    ${btft_link}    /
	#Write    echo -e "select top 1 basetablename from MeasurementTable where MTABLEID LIKE '${package}:(%' and (TABLELEVEL= 'raw')\\n${run}\\n" | isql -P ${password_db} -U ${username} -S ${database} -b
	Write    echo -e "select TOP 1 TYPENAME from MeasurementType WHERE TYPEID like '%${package}%' and Description not like '%Deprecated%' and followjohn='1' and RANKINGTABLE='0'\\n${run}\\n" | isql -P ${password_db} -U ${username} -S ${database} -b
    ${out1}=    Read Until Prompt
	${table}=    tp.Filter Name    ${out1}
	Write    echo -e "select distinct ${node} from ${table}_RAW where datetime_id = '${date} 10:00:00'\\n${run}\\n" | isql -P Dc12# -U Dc -S dwhdb -b
	${out2}=    Read Until Prompt
	${node_name}=    tp.filter name    ${out2}
    #new code added
    Set Client Configuration    prompt=eniqs[eniq_stats] {dcuser} #:    timeout=3600
    Write    echo -e "select typeclassid from measurementtypeclass where versionid like '%${package}:((${buildno}))%' and description not like 'DEFAULT'\\n${run}\\n" | isql -P ${password_db} -U ${username} -S ${database} -b
    ${names}    Read    delay=5
    #//3
    ${names}    tp.deletelastrows3    ${names}
    ${names}    split string    ${names}
   
    ${length}    Get Length    ${names}
    ${status}    Evaluate    ${length}-3
   FOR    ${i}    IN    @{names}
        Log    ${i}
        Set Client Configuration    prompt=eniqs[eniq_stats] {dcuser} #:    timeout=3600
        Write    echo -e "select top 1 typename from measurementtype where typeclassid like '%${i}%' and followjohn=1\\n${run}\\n" | isql -P ${password_db} -U ${username} -S ${database} -b
        ${names}    Read    delay=5
        ${names}    tp.deletelastrows3    ${names}
        Append To List    ${output_list}    ${names}
        log    ${output_list}
 
    END
    FOR    ${element}    IN    @{output_list}
        ${element}    Strip String    ${element}
        log    ${element}_raw
        Write    echo -e "select distinct NE_NAME from ${element}_RAW;\\n${run}\\n" | isql -P ${password_dwhdb} -U ${username_dwhdb} -S ${database_dwhdb} -b
        ${status}    Read Until Prompt
        ${names}    tp.deletelastrows3    ${status}
        ${names}    Strip String    ${names}
        @{NE_NAME_list1}=    Split String    ${names}
        Log    ${names}
        FOR    ${element}    IN    @{NE_NAME_list1}
            Log    ${element} 
            Append To List    ${NE_NAME_list}    ${element}
            Log    ${NE_NAME_list}
            ${full_name}    Evaluate    ','.join(${NE_NAME_list})  
            ${NE_NAME_list1}=    Set Variable    ${full_name}
        END
    END
    #new code ended
    # Open Connection    ${jnkns_server}
    # Login               root        shroot
    # Write    rm -rf tppkg ; mkdir tppkg ; cd tppkg ; wget ${btft_link} ; pwd
    # Read    delay=20s
    # Switch Connection    ${index}
    # Write    cd 
    # Read    delay=10s
    # Put File    /root/tppkg/${btft_script}    /eniq/home/dcuser
    # Write    cd /eniq/home/dcuser ; unzip -o ${btft_script} ; cd BT-FT_Script/ ; chmod 777 *
    # Read Until Prompt
	# tp.Changing Bt Ft File    ${host}    ${port}    ${uname}    ${pwd}
    @{tp}=    Split String From Right    ${package}    separator=_    max_split=1
    ${tp_lower_case}=    Convert To Lowercase    ${tp}[1]
    @{temp}=    Split String From Right    ${full_pkg_name}    separator=_R    max_split=1
    @{r_temp}=    Split String From Right    ${temp}[1]    separator=_
    @{b_temp}=    Split String From Right    ${r_temp}[1]    separator=.
    ${b}=    Remove String    ${b_temp}[0]    b
   # IF    '${package}' == 'DC_E_ERBS' or '${package}' == 'DC_E_CPP' or '${package}' == 'DC_E_BSS' or '${package}' == 'DC_E_SOEM MBH' or '${package}' == 'DC_E_UDM' or '${package}' == 'DC_E_SGSN' or '${package}' == 'DC_E_SASN' or '${package}' == 'DC_E_MGW' or '${package}' == 'DC_E_LLE' or '${package}' == 'DC_E_IPTNMS' or '${package}' == 'DC_E_IPRAN' or '${package}' == 'DC_E_IPPROBE' or '${package}' == 'DC_E_IMSGW' or '${package}' == 'DC_E_GGSN' or '${package}' == 'DC_E_FFAXW' or '${package}' == 'DC_E_FFAX' or '${package}' == 'DC_E_ERBSG2' or '${package}' == 'DC_E_EBSW' or '${package}' == 'DC_E_EBSS' or '${package}' == 'DC_E_EBSG' or '${package}' == 'DC_E_CPG' or '${package}' == 'DC_E_CNAXE' or '${package}' == 'DC_E_CMN_STS_PC' or '${package}' == 'DC_E_CMN_STS' or '${package}' == 'DC_E_CS' or '${package}' == 'DC_E_RAN' or '${package}' == 'DC_E_RBS'
    IF    '${package}' == 'DC_E_BSS' or '${package}' == 'DC_E_CMN_STS' or '${package}' == 'DC_E_CNAXE' or '${package}' == 'DC_E_CPP' or '${package}' == 'DC_E_ERBS' or '${package}' == 'DC_E_ERBSG2' or '${package}' == 'DC_E_FFAX' or '${package}' == 'DC_E_FFAXW' or '${package}' == 'DC_E_GGSN' or '${package}' == 'DC_E_IMSGW_SBG' or '${package}' == 'DC_E_LLE' or '${package}' == 'DC_E_IPPROBE' or '${package}' == 'DC_E_MGW' or '${package}' == 'DC_E_UDM' or '${package}' == 'DC_E_CMN_STS_PC' or '${package}' == 'DC_E_LTE_OPTIMIZATION' or '${package}' == 'DC_E_SGSN'
        ${mod_file_link}    Set Variable    https://arm1s11-eiffel013.eiffel.gic.ericsson.se:8443/nexus/content/repositories/releases/com/ericsson/eniq/stats/tp/${tp}[1]/${tp_lower_case}_etl/FD/R${r_temp}[0]/${package}_${b}/${package}_${b}_R${r_temp}[0]_SetsModifications_TPC.xml
        Open Connection    ${jnkns_server}
        Login               root        shroot
        Write    rm -rf tppkg ; mkdir tppkg ; cd tppkg ; wget ${mod_file_link} ; pwd
        Read    delay=30s
        #@{dircontents}    SSHLibrary.List Directory    /root/tppkg/
        Switch Connection    ${index}
        #${mod_file_exist}    Does File Exist    /root/tppkg/${package}_${b}_R${r_temp}[0]_SetsModifications_TPC.xml
        #IF    '${package}_${b}_R${r_temp}[0]_SetsModifications_TPC.xml' in @{dircontents}
            Put File    /root/tppkg/${package}_${b}_R${r_temp}[0]_SetsModifications_TPC.xml    /eniq/home/dcuser/BT-FT_Script
        #END
        Write    cd /eniq/home/dcuser/BT-FT_Script/ ; echo -e "${full_pkg_name}\\n1,2,3,4,5,6,7,8,9,10,11,12,13\\n${date} 10:00:00\\n${node}\\n${NE_NAME_list1}\\nNE_NAME\\n/eniq/home/dcuser/${package}_${b}_R${r_temp}[0]_SetsModifications_TPC.xml" |./BT-FT_script.sh
        ${out}=    Read Until Prompt
    ELSE   
    # Write    cd 
    # Read    delay=10s
    # Execute Command    cd /eniq/home/dcuser/BT-FT_Script/ ; sed -i -e 's/\r$//' BT-FT_script.sh
    #Read Until Prompt
        IF    '${package}' == 'DC_E_NR'
            Write    cd /eniq/home/dcuser/BT-FT_Script/ ; echo -e "${full_pkg_name}\\n15\\n${date} 10:00:00\\n${node}\\n${node_name}\\nNE_NAME" |./BT-FT_script.sh
            ${out}=    Read Until Prompt
        ELSE
            IF    '${package}' == 'DC_E_ADC' or '${package}' == 'DC_E_CCSM' or '${package}' == 'DC_E_SGSNMME'
                Write    cd /eniq/home/dcuser/BT-FT_Script/ ; echo -e "${full_pkg_name}\\n1,2,3,4,6,8,9,10,11,12,13\\n${date} 10:00:00\\n${node}\\n${node_name}\\nNE_NAME" |./BT-FT_script.sh
                ${out}=    Read Until Prompt
            ELSE
                Write    cd /eniq/home/dcuser/BT-FT_Script/ ; echo -e "${full_pkg_name}\\n1,2,3,4,6,8,9,10,11,12,13\\n${date} 10:00:00\\n${node}\\n${NE_NAME_list1}\\nNE_NAME" |./BT-FT_script.sh
                ${out}=    Read Until Prompt
            END
        END
    END
	tp.BT FT Validation    ${out}
# TP - ENIQ_TP_UG_TC86,TP - ENIQ_TP_UG_TC89,TP - ENIQ_TP_UG_TC90 Verify the Table Data
#     Set Client Configuration    prompt=eniqs[eniq_stats] {dcuser} #:    timeout=3600
#     Write    cd /eniq/home/dcuser
#     Read    delay=10s
    
#     Write    echo -e "Select Top 1 dataname from Measurementkey where typeid like '${package}:%' and iselement like'1' and uniquekey like '1'\\n${run}\\n" | isql -P ${password_db} -U ${username} -S ${database} -b
# 	${output}=    Read Until Prompt    
#     ${node}=    filter name    ${output}
#     Write    echo -e "select top 1 basetablename from MeasurementTable where MTABLEID LIKE '${package}:(%' and (TABLELEVEL= 'raw')\\n${run}\\n" | isql -P ${password_db} -U ${username} -S ${database} -b
# 	${output1}=    Read Until Prompt     
# 	${table}=    Filter Name    ${output1}
# 	Write    echo -e "select distinct ${node} from ${table} where datetime_id = '${date} 10:00:00'\\n${run}\\n" | isql -P Dc12# -U Dc -S dwhdb -b
# 	${output2}=    Read Until Prompt    
# 	${node_name}=    filter name    ${output2}
#     #Write    rm -rf BT-FT_Log ; rm -rf BT-FT_Script
#     #Read Until Prompt
#     Open nexus tpkpiscript
#     #${btft_link}=    Get Element Attribute    //a[contains(text(),'BT-FT')]    href
#     ${btft_link}=    Get Element Attribute    (//a[contains(text(),'BT-FT_Script')])[last()-1]    href
#     ${btft_script}=    Fetch From Right    ${btft_link}    /
# 	# Open Connection    ${jnkns_server}
#     # Login               root        shroot
#     # Write    rm -rf tppkg ; mkdir tppkg ; cd tppkg ; wget ${btft_link} ; pwd
#     # Read    delay=20s
#     # Switch Connection    ${index}
#     #Put File    /root/tppkg/${btft_script}    /eniq/home/dcuser
#     #Write    cd /eniq/home/dcuser ; unzip -o ${btft_script} ; cd BT-FT_Script/ ; chmod 777 *
#     #Read Until Prompt
#     #changing bt ft file    ${host}    ${port}    ${uname}    ${pwd}
#     Write    cd /eniq/home/dcuser/BT-FT_Script/ ; echo -e "${full_pkg_name}\\n2,4\\n${date} 10:15:00\\n${node}\\n${node_name}\\nNE_NAME" |./BT-FT_script.sh    
#     ${Execute}=    Read Until Prompt
#     ${status}=    BT_FT_validation_For_Aggregation    ${Execute}
#     IF    ${status} == False
#         Fail   Data loading and key checking failed${\n}${Execute}
#     END      

TP - ENIQ_TP_UG_TC92,TP - ENIQ_TP_UG_TC93,TP - ENIQ_TP_UG_TC94 Verify delta table Loading
    IF    '${package}' == 'DC_E_GGSN' or '${package}' == 'DC_E_MGW' or '${package}' == 'DC_E_WMG' or '${package}' == 'DC_E_CPP' or '${package}' == 'DC_E_TCU'
        Write    cd /eniq/home/dcuser
        Read    delay=10s
        Set Client Configuration    prompt=eniqs[eniq_stats] {dcuser} #:    timeout=600
	    Write    echo -e "select versionid from versioning where techpack_name='${package}'\\n${run}\\n" | isql -P ${password_db} -U ${username} -S ${database} -b
	    ${outf}=    Read Until Prompt
	    ${package_b}=    tp.Filter Name    ${outf}
	    Write    echo -e "select distinct typeid from measurementtable where tablelevel = 'Raw' and typeid like'${package}:((144))%'\\n${run}\\n" | isql -P ${password_db} -U ${username} -S ${database} -b
	    ${out}=    Read Until Prompt
	    ${result}=    Set Variable    false
	    @{tables}=    tp.Get Table List    ${out}
	    FOR    ${element}    IN    @{tables}
	    	Write    echo -e "select dataname from measurementcounter where typeid like '${package_b}:${element}'\\n${run}\\n" | isql -P ${password_db} -U ${username} -S ${database} -b
	    	${out4}=    Read Until Prompt
	    	@{counterlist}=    tp.Get Counter List    ${out4}
	    	FOR    ${counter}    IN    @{counterlist}
	    		Write    echo -e "Select Top 1 DC_RELEASE from ${element}_RAW where DATE_ID = '2023-03-30'\\n${run}\\n" | isql -P Dc12# -U Dc -S dwhdb -b
	            ${out1}=    Read Until Prompt
	            ${dc_release_raw}=    tp.Filter Name    ${out1}
	    		Write    echo -e "Select deltacalcsupport from MeasurementDeltaCalcSupport where TYPEID like '${package_b}:${element}' and vendorrelease like '${dc_release_raw}'\\n${run}\\n" | isql -P ${password_db} -U ${username} -S ${database} -b
	            ${out3}=    Read Until Prompt
	         	${deltacalcsupport}=    tp.Filter Name    ${out3}
	    		Write    echo -e "select countertype from measurementcounter where typeid like '${package_b}:${element}' and dataname='${counter}'\\n${run}\\n" | isql -P ${password_db} -U ${username} -S ${database} -b
	    	    ${out5}=    Read Until Prompt
	    		${countertype}=    tp.Filter Name    ${out5}
	    		Write    echo -e "Select ${counter} from ${element}_RAW order by Datetime_id asc\\n${run}\\n" | isql -P Dc12# -U Dc -S dwhdb -b
	    	    ${out6}=    Read Until Prompt
	    		Write    echo -e "Select ${counter} from ${element}_DELTA order by Datetime_id asc\\n${run}\\n" | isql -P Dc12# -U Dc -S dwhdb -b
	    	    ${out7}=    Read Until Prompt
	    		${res}=    tp.Validate Peg Gauge Delta    ${out6}    ${out7}    ${countertype}    ${deltacalcsupport}
	    	END
	    END
	END
TP - ENIQ_TP_UG_TC96 Verify Aggregating RAW tables 
    #Skip If    '${package}' == 'DC_E_NETOP'   Skipping this TestCase Execution Since it is not applicable for ${package}
    Skip IF    '${package}' == 'DC_E_NETOP' or '${package}' == 'DC_E_BULK_CM'   Skipping this TestCase Execution Since it is not applicable for ${package}
    Set Client Configuration    prompt=eniqs[eniq_stats] {dcuser} #:    timeout=3600
    Write    cd /eniq/home/dcuser
    Read    delay=10s
    Write    echo -e "select distinct basetablename,* from measurementtable WHERE MTABLEID like '%${package}%' and TABLELEVEL like '%RAW%'\\n${run}\\n" | isql -P ${password_db} -U ${username} -S ${database} -b
    ${Get_all_raw_tables}    Read Until Prompt   
    Log    ${Get_all_raw_tables}
    ${length_of_all_raw_tables}    Get Length    ${Get_all_raw_tables}
    Log    ${length_of_all_raw_tables}
    Write    echo -e "select basetablename from MeasurementTable where MTABLEID LIKE '${package}:%' and TABLELEVEL in('DAY','COUNT')\\n${run}\\n" | isql -P ${password_db} -U ${username} -S ${database} -b
    ${out}    Read Until Prompt
	#${table_name}    Get Table Names    ${package}    ${out}
	#FOR    ${table}    IN    @{table_name}
#		Write     engine -e startSet '${package}' '${table}' 
#		${out}    Read Until Prompt   
#		Should Contain    ${out}    Start set requested successfully    Failed Aggregation for ${table}
#	END
 #   Write    echo -e "/eniq/sw/bin/engine -e startSet DWH_MONITOR UpdateFirstLoadings\\n" | isql -P ${password_db} -U ${username} -S ${database} -b
  #  ${Firstloading}    Read Until Prompt    
  #  Write    echo -e "/eniq/sw/bin/engine -e startSet DWH_MONITOR AutomaticREAggregation\\n" | isql -P ${password_db} -U ${username} -S ${database} -b
  #  ${Aggregation}    Read Until Prompt    

TP - ENIQ_TP_UG_TC97 Show Aggregation
    #Skip If    '${package}' == 'DC_E_NETOP'    Skipping this TestCase Execution Since it is not applicable for ${package}
    Skip IF    '${package}' == 'DC_E_NETOP' or '${package}' == 'DC_E_BULK_CM'   Skipping this TestCase Execution Since it is not applicable for ${package}
    Set Client Configuration    prompt=eniqs[eniq_stats] {dcuser} #:    timeout=3600
	Write    cd /eniq/home/dcuser
    Read    delay=2s
	Write     echo -e " Select VENDORID from Measurementtype where TYPEID like '%${package}' and FOLLOWJOHN like '%0%'\\n${Run}\\n"| isql -P ${password_db} -U ${username} -S ${database} -b
    ${typeid_not_equal_to_1}      Read   delay=10s
    ${typeid}    Values    ${typeid_not_equal_to_1}
    Log    ${typeid}
	Write     echo -e " Select AGGREGATION,DATE_ID,STATUS,AGGREGATIONSCOPE,TYPENAME from LOG_AggregationStatus where DATE_ID = '${date}' and AGGREGATION like '%${package}%' and AGGREGATIONSCOPE like '%DAY%' and status not like '%FAILEDDEPENDENCY%' and status not like '%BLOCKED%' and aggregation not like '%DAYBH%' and aggregation not like '%RANKBH%'\\n${Run}\\n"| isql -P ${password_dwhdb} -U ${username_dwhdb} -S ${database_dwhdb} -b
    ${SQLquery}      Read Until Prompt  
    ${flag}     ${message}=  Aggregation    ${SQLquery}
    IF  ${flag} 
        Log To Console    ${\n}${message}
		Log    Testcase is Passed!
    ELSE
        Log     ${\n}${message}
        Fail    Testcase got failed because there are ${message} some tables which are in not loaded state!
    END
# Start Aggregation Rankbh and Daybh
# 	Write    cd /eniq/home/dcuser
#     Read    delay=10s
#     Set Client Configuration    prompt=eniqs[eniq_stats] {dcuser} #:    timeout=3600
#     Write    echo -e "select basetablename from MeasurementTable where MTABLEID LIKE '${package}:%' and TABLELEVEL in('DAYBH')\\n${run}\\n" | isql -P ${password_db} -U ${username} -S ${database} -b
# 	${out}    Read    delay=5s
# 	${table_name}    Get Table Names    ${package}    ${out}
# 	FOR    ${table}    IN    @{table_name}
# 		write     engine -e startSet '${package}' '${table}_${bhobject}' 
# 		${out}    Read Until Prompt    strip_prompt=True
# 		Log    ${\n}${out} 
# 		Should Contain    ${out}    Start set requested successfully    Failed Aggregation for ${table}
# 	END
# 	Sleep	1m
#     Set Client Configuration    prompt=eniqs[eniq_stats] {dcuser} #:    timeout=3600
#     Write     echo -e " Select AGGREGATION from LOG_AggregationStatus where DATE_ID = '${date}' and AGGREGATION like '%${package}%' and AGGREGATIONSCOPE like '%DAY%' and aggregation like '%RANKBH%'\\n${Run}\\n"| isql -P ${password_dwhdb} -U ${username_dwhdb} -S ${database_dwhdb} -b
#     ${out}      Read Until Prompt
#     ${out2}    deletelastrows    ${out}
# 	${out2}		Split String	${out2}
# 	${cp0_tablename}	Run Keyword And Return Status    Should Contain Any    ${out}   0 rows affected
# 	IF	'${cp0_tablename}' == 'True'
# 		Log	cpo table not configured
# 	ELSE
# 		FOR    ${i}    IN    @{out2}	
# 			write     engine -e startSet '${package}' 'Aggregator_${i}'
# 			${out}    Read Until Prompt    strip_prompt=True
# 			# Log    Aggregator_${out2} 
# 			Should Contain    ${out}    Start set requested successfully    Failed Aggregation for Aggregator_${i}
# 		END	
# 	END
# 	# Write    echo -e "/eniq/sw/bin/engine -e startSet DWH_MONITOR AutomaticREAggregation\\n" | isql -P ${password_db} -U ${username} -S ${database} -b
# 	# ${Reaggregation}    Read Until Prompt  
#     write     /eniq/sw/bin/engine -e startSet DWH_MONITOR UpdateFirstLoadings 
# 	${out}    Read Until Prompt    strip_prompt=True
# 	Log    ${\n}${out} 
# 	Should Contain    ${out}    Start set requested successfully    Failed Aggregation for UpdateFirstLoadings
# 	write     /eniq/sw/bin/engine -e startSet DWH_MONITOR UpdateMonitoredTypes 
# 	${out}    Read Until Prompt    strip_prompt=True
# 	Log    ${\n}${out} 
# 	Should Contain    ${out}    Start set requested successfully    Failed Aggregation for UpdateMonitoredTypes
# 	write     /eniq/sw/bin/engine -e startSet DWH_MONITOR UpdateMonitoring 
# 	${out}    Read Until Prompt    strip_prompt=True
# 	Log    ${\n}${out} 
# 	Should Contain    ${out}    Start set requested successfully    Failed Aggregation for UpdateMonitoring
# 	write     /eniq/sw/bin/engine -e startSet DWH_MONITOR AggregationRuleCopy 
# 	${out}    Read Until Prompt    strip_prompt=True
# 	Log    ${\n}${out} 
# 	Should Contain    ${out}    Start set requested successfully    Failed Aggregation for AggregationRuleCopy
# 	write     /eniq/sw/bin/engine -e startSet DWH_MONITOR AutomaticAggregation 
# 	${out}    Read Until Prompt    strip_prompt=True
# 	Log    ${\n}${out} 
# 	Should Contain    ${out}    Start set requested successfully    Failed Aggregation for AutomaticAggregation
# 	write     /eniq/sw/bin/engine -e startSet DWH_MONITOR AutomaticREAggregation 
# 	${out}    Read Until Prompt    strip_prompt=True
# 	Log    ${\n}${out} 
# 	Should Contain    ${out}    Start set requested successfully    Failed Aggregation for AutomaticREAggregation
# 	Sleep	4800s 
# TP - ENIQ_TP_UG_TC98,TP - ENIQ_TP_UG_TC99,TP - ENIQ_TP_UG_TC101 Verify the Table Data 
#     Set Client Configuration    prompt=eniqs[eniq_stats] {dcuser} #:    timeout=3600
#     Write    cd /eniq/home/dcuser
#     Read    delay=10s
    
#     Write    echo -e "Select Top 1 dataname from Measurementkey where typeid like '${package}:%' and iselement like'1' and uniquekey like '1'\\n${run}\\n" | isql -P ${password_db} -U ${username} -S ${database} -b
# 	${output}=    Read Until Prompt    
#     ${node}=    filter name    ${output}
#     Write    echo -e "select top 1 basetablename from MeasurementTable where MTABLEID LIKE '${package}:(%' and (TABLELEVEL= 'raw')\\n${run}\\n" | isql -P ${password_db} -U ${username} -S ${database} -b
# 	${output1}=    Read Until Prompt     
# 	${table}=    Filter Name    ${output1}
# 	Write    echo -e "select distinct ${node} from ${table} where datetime_id = '${date} 10:00:00'\\n${run}\\n" | isql -P Dc12# -U Dc -S dwhdb -b
# 	${output2}=    Read Until Prompt    
# 	${node_name}=    filter name    ${output2}
#     #Write    rm -rf BT-FT_Log ; rm -rf BT-FT_Script
#     #Read Until Prompt
#     Open nexus tpkpiscript
#     #${btft_link}=    Get Element Attribute    //a[contains(text(),'BT-FT')]    href
#     ${btft_link}=    Get Element Attribute    (//a[contains(text(),'BT-FT_Script')])[last()-1]    href
#     ${btft_script}=    Fetch From Right    ${btft_link}    /
# 	# Open Connection    ${jnkns_server}
#     # Login               root        shroot
#     # Write    rm -rf tppkg ; mkdir tppkg ; cd tppkg ; wget ${btft_link} ; pwd
#     # Read    delay=20s
#     # Switch Connection    ${index}
#     #Put File    /root/tppkg/${btft_script}    /eniq/home/dcuser
#     #Write    cd /eniq/home/dcuser ; unzip -o ${btft_script} ; cd BT-FT_Script/ ; chmod 777 *
#     #Read Until Prompt
#     #changing bt ft file    ${host}    ${port}    ${uname}    ${pwd}
#     Write    cd /eniq/home/dcuser/BT-FT_Script/ ; echo -e "${full_pkg_name}\\n8\\n${date} 10:15:00\\n${node}\\n${node_name}\\nNE_NAME" |./BT-FT_script.sh    
#     ${Execute}=    Read Until Prompt
#     ${status}=    BT_FT_validation_For_Aggregation    ${Execute}
#     IF    ${status} == False
#         Fail   Aggregation Failed${\n}${Execute}
#     END
TP - ENIQ_TP_UG_TC100 Verify the Count tables.
    Set Client Configuration    prompt=eniqs[eniq_stats] {dcuser} #:    timeout=3600
    Write    cd /eniq/home/dcuser
    Read    delay=3s
    write    echo -e "select basetablename from MeasurementTable where MTABLEID LIKE '${package}:(%' and (TABLELEVEL= 'count')\\n${run}\\n" | isql -P ${password_db} -U ${username} -S ${database} -b   
    ${Output}=    Read Until Prompt    strip_prompt=True
    ${table_name}=    Set Variable    ${Output}
    
    ${output1}    Split String    ${Output}    
    Remove From List    ${output1}    -1
    Remove From List    ${output1}    -1
    Remove From List    ${output1}    -1
    
    FOR    ${i}    IN    @{Output1}
        ${k}    Strip String    ${i}
        ${k}=    Replace String    ${k}    _COUNT    ${EMPTY}
        Write    echo -e "select DATANAME from MeasurementColumn WHERE MTABLEID like '%${k}:COUNT%' and DATANAME !='DC_SUSPECTFLAG'\\n${run}\\n" | isql -P ${password_db} -U ${username} -S ${database} -b
        ${Output2}=    Read Until Prompt    strip_prompt=True
        ${output3}    Split String    ${Output2}    
        Remove From List    ${output3}    -1
        Remove From List    ${output3}    -1
        Remove From List    ${output3}    -1
        #${output3}    Strip String    ${output3}
        #${output3}=    Replace String    ${output3}    DC_SUSPECTFLAG    ${EMPTY}
        FOR    ${j}    IN    @{Output3}
            ${H}    Strip String    ${j}
            write    echo -e "Select ${H} from ${k}_COUNT where DATE_ID= '${date}'\\n${run}\\n" | isql -P ${password_dwhdb} -U ${username_dwhdb} -S ${database_dwhdb} -w 5000 -b
            ${Count_Table}=    Read Until Prompt    strip_prompt=True
            ${Count_Table}    Replace String    ${Count_Table}    NULL    ${SPACE}
            ${Count_Table}    Replace String    ${Count_Table}    ${SPACE}    ${EMPTY}
            ${Count_Table}    Split String    ${Count_Table}    \n
            Log    ${Count_Table}
            write    echo -e "Select ${H} from ${k}_DELTA where DATE_ID= '${date}'\\n${run}\\n" | isql -P ${password_dwhdb} -U ${username_dwhdb} -S ${database_dwhdb} -w 5000 -b
            ${Delta_Table}=    Read Until Prompt    strip_prompt=True
            ${Delta_Table}    Replace String    ${Delta_Table}    NULL    ${SPACE}
            ${Delta_Table}    Replace String    ${Delta_Table}    ${SPACE}    ${EMPTY}
            ${Delta_Table}    Split String    ${Delta_Table}    \n
            Log    ${Delta_Table}
                
            ${status}    ${message}    Count Delta Val Not In List    ${Count_Table}    ${Delta_Table}    
            IF    ${status}
                Log    ${\n}${message}
            ELSE
                Run Keyword And Continue On Failure   ${\n}Values that are not present in Count are:-${\n}${message}
            END
        END
    END
TP - ENIQ_TP_UG_TC102 Verify the RANKBH CP0 View
    Set Client Configuration    prompt=eniqs[eniq_stats] {dcuser} #:    timeout=3600
	Write    cd /eniq/home/dcuser
	Read    delay=15s
	#IF    '${package}'=='DC_E_RBS' or '${package}'=='DC_E_CPP' or '${package}'=='DC_E_ERBSG2' or '${package}'=='DC_E_RAN' or '${package}'=='DC_E_MGW' or '${package}'=='DC_E_BSS' or '${package}'=='DC_E_SGSN' or '${package}'=='DC_E_CNAXE' or '${package}'==DC_E_CMN_STS' or '${package}'=='DC_E_RBSG2'
    Skip    'Skipping this TestCase Execution Since it is not applicable for ${package}'
    #END
    Write     echo -e " Select AGGREGATION,DATE_ID,STATUS,AGGREGATIONSCOPE from LOG_AggregationStatus where DATE_ID = '${date}' and AGGREGATION like '%${package}%' and AGGREGATIONSCOPE like '%DAY%' and aggregation like '%RANKBH%'\\n${Run}\\n"| isql -P ${password_dwhdb} -U ${username_dwhdb} -S ${database_dwhdb} -b
    ${SQLquery}      Read Until Prompt 
    ${show_table_names}    Values    ${SQLquery}
    Write     echo -e "Select bhobject from Busyhour where BHCRITERIA NOT like '' and BHLEVEL like '%${package}%' and BHTYPE like '%CP%'and ENABLE = 1\\n${Run}\\n"| isql -P ${password_db} -U ${username} -S ${database} -b
    ${bhobject}       Read Until Prompt   
    ${bhobject2}     values    ${bhobject} 
    ${bhobject3}    Split String    ${bhobject2}	
    Write     echo -e "Select bhtype from Busyhour where BHCRITERIA NOT like '' and BHLEVEL like '%${package}%' and BHTYPE like '%CP%'and ENABLE = 1\\n${Run}\\n"| isql -P ${password_db} -U ${username} -S ${database} -b
    ${bhtype}       Read Until Prompt   
    ${bhtype2}     values    ${bhtype} 
    ${bhtype3}    Split String    ${bhtype2}
    #${bhobject_and_bhtype}    combining_bhobject_and_bhtype    ${bhobject3}[0]    ${bhtype3}[0]
    #Log    ${package}_${bhobject2}BH_RANKBH_${bhobject_and_bhtype}    
    ${failed_tables}=  list_of_failed_dependency_tables    ${show_table_names}
    ${abc}    failed_tables_str_conversion   ${failed_tables}
    ${contains}=    Run Ke yword And Return Status    Should Contain Any      ${abc}    ${package}_${bhobject3}[0]BH_RANKBH_${bhobject3}[0]_${bhtype3}[0]    
    IF    '${contains}' == 'True'
        Fail    Testcase is Failed as ${package}_${bhobject2}BH_RANKBH_${bhobject3}[0]_${bhtype3}[0] table is in FAILED STATE.
    ELSE
        ${not_loaded}=   list_of_not_loaded_tables       ${show_table_names}
        ${pqr}    Not Loaded Tables    ${not_loaded}
        ${contains}=    Run Keyword And Return Status    Should Contain   ${pqr}    ${package}_${bhobject3}[0]BH_RANKBH_${bhobject3}[0]_${bhtype3}[0]
        IF    '${contains}' == 'True'
            Log    ${package}_${bhobject2}BH_RANKBH_${bhobject3}[0]_${bhtype3}[0] is present in NOT LOADED STATE! 
            Fail    Testcase is Failed as ${package}_${bhobject2}BH_RANKBH_${bhobject3}[0]_${bhtype3}[0] is in NOTLOADED STATE.    
        ELSE 
            ${aggregated_tables}    list_of_aggregated_tables    ${show_table_names}
            ${x2y2}    Aggregated Tables    ${aggregated_tables}
            Log    ${x2y2}
            ${contains}=    Run Keyword And Return Status    Should Contain Any  ${x2y2}    ${package}_${bhobject3}[0]BH_RANKBH_${bhobject3}[0]_${bhtype3}[0]
            IF    '${contains}' == 'True'
                Write     echo -e "Select * from ${package}_${bhobject3}[0]BH_RANKBH_${bhobject3}[0]_${bhtype3}[0]\\n${Run}\\n"| isql -P ${password_dwhdb} -U ${username_dwhdb} -S ${database_dwhdb} -b
                ${rankbh_cp0_table_name}    Read Until Prompt
                Write     echo -e "Select bhlevel,bhobject,bhtype from busyhour where versionid like '%${package}%' and bhtype like '%CP0%' and BHCRITERIA NOT like ''\\n${Run}\\n"| isql -P ${password_db} -U ${username} -S ${database} -b
                ${get_rankbh_level}    Read Until Prompt
                ${x2}    Strip String    ${get_rankbh_level}  
                ${y2}     Values    ${x2}
                ${z3}     Split String    ${y2}
                Write  echo -e "Select HOUR_ID,BHTYPE from ${z3}[0]_RANKBH_${z3}[1]_${z3}[2] where DATE_ID='${date}'\\n${Run}\\n"| isql -P ${password_dwhdb} -U ${username_dwhdb} -S ${database_dwhdb} -b
                ${RANKBHCP0_SQL_query}      Read Until Prompt
                ${RANKBHCP0_SQL_query_output}    Split String    ${RANKBHCP0_SQL_query}   
                Write     echo -e "Select basetablename from measurementtable where mtableid like '%${package}%' and tablelevel like '%daybh%' order by basetablename asc\\n${Run}\\n"| isql -P ${password_db} -U ${username} -S ${database} -b
                ${DAYBH2}      Read Until Prompt 
                ${xyz2}    Strip String    ${DAYBH2}
                ${xyz3}    Values    ${xyz2}
                ${xyz4}    Split String    ${xyz3}
                Write  echo -e "Select busyhour,bhtype from ${xyz4}[0] where DATE_ID= '${date}'\\n${Run}\\n"| isql -P ${password_dwhdb} -U ${username_dwhdb} -S ${database_dwhdb} -b
                ${daybhout}      Read Until Prompt    
                ${daybh_output}    Split String    ${daybhout}   
                Write  echo -e "Select HOUR_ID,BHTYPE from ${z3}[0]_RANKBH_${z3}[1]_${z3}[2] where bhvalue=(Select max(bhvalue) from ${z3}[0]_RANKBH_${z3}[1]_${z3}[2] where DATE_ID='${date}')\\n${Run}\\n"| isql -P ${password_dwhdb} -U ${username_dwhdb} -S ${database_dwhdb} -b
                ${maxhourid}      Read Until Prompt
                ${maxhourid_output}    Split String    ${maxhourid}  
                Write     echo -e "Select BHCRITERIA,VERSIONID from Busyhour WHERE VERSIONID like '%${package}%' and BHTYPE like '%CP0%' and bhcriteria not like ''//DESCRIPTION like '%test%'\\n${Run}\\n"| isql -P ${password_db} -U ${username} -S ${database} -b
                ${busyhour_query}      Read Until Prompt
                ${busyhour_query_output}    Split String    ${busyhour_query}    \r\n
                ${a}    Strip String    ${busyhour_query_output}[0]
                ${b}    Split String From Right   ${busyhour_query_output}[0]    (    
                ${x2}    Strip String    ${b}[0]
                ${z}    Strip String     ${x2} 
                ${c}    Strip String    ${b}[1]
                ${d}    Remove String    ${b}[1]   )
                ${e}    Strip String    ${d}
                ${abc}    Strip String    ${busyhour_query_output}[1]
                Write        echo -e "select * from Measurementcounter where DATANAME like '%${e}%' and TYPEID like '%${abc}%'\\n${Run}\\n"| isql -P ${password_db} -U ${username} -S ${database} -b
                ${query_measurement_counter}      Read Until Prompt  
                ${query_measurement_counter_output}    Split String    ${query_measurement_counter}   
                ${f}    Split String From Right   ${query_measurement_counter_output}[0]    :
                Switch Connection    ${index}
                Write     echo -e "Select HOUR_ID,BHTYPE from ${z3}[0]_RANKBH_${z3}[1]_${z3}[2] where bhvalue=(Select max(bhvalue) from ${z3}[0]_RANKBH_${z3}[1]_${z3}[2] where DATE_ID='${date}') \\n${Run}\\n"| isql -P ${password_dwhdb} -U ${username_dwhdb} -S ${database_dwhdb} -b
                ${maxbhvalue}    Read Until Prompt     
                ${maxbhvalueone}    Strip String    ${maxbhvalue}
                ${mm}     Split String    ${maxbhvalueone}
                Write     echo -e "Select sum(${e}) from ${f}[2]_RAW where DATE_ID = '${date}' and HOUR_ID = ${mm}[0]\\n${Run}\\n"| isql -P ${password_dwhdb} -U ${username_dwhdb} -S ${database_dwhdb} -b
                ${counter}    Read Until Prompt   
                ${sum_of_counter_output}    Values   ${counter}
                Write     echo -e "Select sum(BHVALUE) from ${z3}[0]_RANKBH_${z3}[1]_${z3}[2] where bhvalue=(Select max(bhvalue) from ${z3}[0]_RANKBH_${z3}[1]_${z3}[2] where DATE_ID ='${date}')\\n${Run}\\n"| isql -P ${password_dwhdb} -U ${username_dwhdb} -S ${database_dwhdb} -b
                ${Bhvalue}    Read Until Prompt   
                ${sum_of_Bhvalue_output}    Values    ${Bhvalue}
                ${bhvalue_out}    Valueone    ${sum_of_Bhvalue_output}            
                IF    ${sum_of_counter_output} == ${bhvalue_out}
                    Log   RANKBH CP0 Testcase is Passed!
                ELSE
                    Fail    CP0 Values mismatch! Hence, Testcase Failed!
                END     

                ELSE
                    Fail    RANKBH CP0  table is not configured!
                END                    
            END    
    END
TP - ENIQ_TP_UG_TC103 Checking the Configuration of Product Placeholder(PP) for BUSY HOUR check
    Set Client Configuration    prompt=eniqs[eniq_stats] {dcuser} #    timeout=3600
    Write    cd /eniq/home/dcuser
    ${tt}    Read    delay=3s
    write    echo -e "Select bhtype, bhlevel from Busyhour where VERSIONID like '%${package}%' and PLACEHOLDERTYPE like '%pp%' and BHCRITERIA != ''\\n${run}\\n" | isql -P ${password_db} -U ${username} -S ${database} -b 
	${output}    Read Until Prompt    
	${checkPP}=    Run Keyword And Return Status   Should Contain Any    ${output}    (0 rows affected) 
	Set Global Variable    ${checkPP}
    IF    '${checkPP}' == 'True'
        Log   RANKBH PP table not there in this techpack
    ELSE
        ${output}    Split String    ${output}   
        ${len}    Get Length    ${output}
        ${len}    Evaluate    int((${len} -3)/2)
        FOR    ${i}    IN RANGE    0    ${len}    2
            write    echo -e "select enable from busyhour where bhlevel like '${output}[${i+1}]' and bhtype like '${output}[${i}]' and enable=1\\n${run}\\n" | isql -P ${password_db} -U ${username} -S ${database} -b        
            ${output2}=    Read Until Prompt    strip_prompt=True
            ${output1}    Split String    ${output2}
            ${output2}    Run Keyword And Return Status   Should Contain Any    ${output2}    (0 rows affected)
            IF    '${output2}'=='True'
                Log    ${output}${i+1} table not enabled
            ELSE
                Log    ${output}${i+1} table enabled  
            END
            # ${l}    Get Length    ${output1}
            # IF    ${l}<4
            #     Run Keyword And Continue On Failure    Fail    ${\n}Length is not equal to verify 
            # END
        END   
    END    

######Ashwini Code start
TP - ENIQ_TP_UG_TC104 Verify the RANKBH PPs Views.
    Set Client Configuration    prompt=eniqs[eniq_stats] {dcuser}     timeout=3600s
    Skip    'Skipping this TestCase Execution Since it is not applicable for ${package}'
    Write    cd /eniq/home/dcuser
    ${tt}    Read    delay=5s
    IF    '${checkPP}' == 'True'
                    Log   RANKBH PP table not there in this techpack
	ELSE
        Write    echo -e "Select BHLEVEL,BHOBJECT,BHCRITERIA,ENABLE,VERSIONID,DESCRIPTION from Busyhour where BHCRITERIA NOT like '' and BHLEVEL like '%${package}%' and ENABLE = 1\\n${Run}\\n"| isql -P ${password_db} -U ${username} -S ${database} -b
        ${rankbh}       Read Until Prompt   
        ${p2}     values    ${rankbh}     
        ${q2}    Split String    ${p2}    
        Write    echo -e "Select basetablename from measurementtable where tablelevel like '%rankbh%' and mtableid like '%${package}%'\\n${Run}\\n"| isql -P ${password_db} -U ${username} -S ${database} -b
        ${rankbhtablenames}       Read Until Prompt   
        ${rankbhtablenames2}     values    ${rankbhtablenames}     
        ${rankbhtablenames3}    Split String    ${rankbhtablenames2}    
        Write    echo -e "Select bhlevel from busyhour where versionid like '%${package}%' and bhcriteria NOT LIKE ''\\n${Run}\\n"| isql -P ${password_db} -U ${username} -S ${database} -b
        ${bhlevel}       Read Until Prompt       
        ${bhlevel2}     values2    ${bhlevel}     
        ${bhlevel4}    solve       ${bhlevel2}    
        ${bhlevel3}    Split String    ${bhlevel4}        
        Write    echo -e "Select bhtype from busyhour where versionid like '%${package}%' and bhcriteria NOT LIKE ''\\n${Run}\\n"| isql -P ${password_db} -U ${username} -S ${database} -b
            ${bhtype}       Read Until Prompt   
            ${bhtype2}     values    ${bhtype}         
            ${bhtype3}    Split String    ${bhtype2}        
            FOR     ${j}    IN    @{bhtype3}
                Log    ${j}
            END
        Write    echo -e "Select bhobject from busyhour where versionid like '%${package}%' and bhcriteria NOT LIKE ''\\n${Run}\\n"| isql -P ${password_db} -U ${username} -S ${database} -b
        ${bhobject}       Read Until Prompt   
        ${bhobject2}     values   ${bhobject}     
        ${bhobject3}   Split String    ${bhobject2}        
        ${pqr}    ${len}      abc     ${bhobject3}    ${bhtype3}         
        ${rst}    ${len2}      Abc    ${bhlevel3}    ${pqr}        
        FOR     ${i}    IN    @{rst}
            Log    ${i}        
            ${k}        matchstring        ${i}        
            Write    echo -e "Select BHVALUE,HOUR_ID,bhobject from ${i} where BHVALUE = (Select max(BHVALUE) from ${i} where DATE_ID = '${date}')\\n${Run}\\n"| isql -P ${password_dwhdb} -U ${username_dwhdb} -S ${database_dwhdb} -b
            ${bhvalue_and_hourid}       Read Until Prompt   
            ${bhvalue}     values    ${bhvalue_and_hourid}        
            ${bh_and_hourid}    Split String    ${bhvalue}        
            IF    '${package}' == 'DC_E_CNAXE'
                Set Client Configuration    prompt=eniqs[eniq_stats] {dcuser}     timeout=100s
                SSHLibrary.Write    echo -e "Select BHCRITERIA from Busyhour where BHCRITERIA NOT like '' and VERSIONID like '%${package}%' and BHLEVEL like '%${package}_${k}BH%'\\n${Run}\\n"| isql -P ${password_db} -U ${username} -S ${database} -b
                ${query_bhcriteria}       Read Until Prompt   
                ${bhcriteria}     values    ${query_bhcriteria}            
                ${a}    Split String    ${bhcriteria}
                IF    '${a}[0]' == 'max(NSUBSCNT)'               
                        ${b}    Split String    ${bhcriteria}                    
                        ${b1}    Split String From Right    ${b}[0]    (                    
                        ${x}    Split String From Right    ${b1}[1]    )                    
                        Write    echo -e "select * from Measurementcounter where DATANAME like '%${x}[0]%' and TYPEID like '%${package}%'\\n${Run}\\n"| isql -P ${password_db} -U ${username} -S ${database} -b
                        ${tablename_of_bhcriteria}       Read Until Prompt   
                        ${bhcriteria_tablename}     values    ${tablename_of_bhcriteria}                    
                        ${tablename}    Split String    ${bhcriteria_tablename}                    
                        ${table}    Split String from Right     ${tablename}[0]    :                    
                        Write    echo -e "Select ${b}[0] from ${table}[2]_RAW where HOUR_ID=${bh_and_hourid}[1]\\n${Run}\\n"| isql -P ${password_dwhdb} -U ${username_dwhdb} -S ${database_dwhdb} -b
                        ${formula_calculation}       Read Until Prompt   
                        ${formula}     values    ${formula_calculation}                    
                        ${counter_formula}    Split String    ${formula}                    
                        SSHLibrary.Write    echo -e "Select sum(BHVALUE) from ${i} where BHVALUE = (Select max(BHVALUE) from ${i})\\n${Run}\\n"| isql -P ${password_dwhdb} -U ${username_dwhdb} -S ${database_dwhdb} -b
                        ${sumofbhvalue}       Read Until Prompt   
                        ${bhvalueone}     values    ${sumofbhvalue}                     
                        ${xyz}    compareone   ${bhvalueone}    ${formula}                    
                        IF    '${xyz}' == '${TRUE}'
                            Log     Testcase is Passed!
                        ELSE
                            Fail	Testcase is Failed!                        
                        END
                ELSE IF    '${bhcriteria}' == 'SUM(CAPMEAS_NCA)'
                    ${b}    Split String    ${bhcriteria}                
                    ${b1}    Split String From Right    ${b}[0]    (                
                    ${x}    Split String From Right    ${b1}[1]    )                
                    Write    echo -e "select * from Measurementcounter where DATANAME like '%${x}[0]%' and TYPEID like '%${package}%'\\n${Run}\\n"| isql -P ${password_db} -U ${username} -S ${database} -b
                    ${tablename_of_bhcriteria}       Read Until Prompt   
                    ${bhcriteria_tablename}     values    ${tablename_of_bhcriteria}                
                    ${tablename}    Split String    ${bhcriteria_tablename}                
                    ${table}    Split String from Right     ${tablename}[0]    :                
                    Write    echo -e "Select ${b}[0] from ${table}[2]_RAW where HOUR_ID=${bh_and_hourid}[1]\\n${Run}\\n"| isql -P ${password_dwhdb} -U ${username_dwhdb} -S ${database_dwhdb} -b
                        ${formula_calculation}       Read Until Prompt   
                        ${formula}     values    ${formula_calculation}                    
                        ${counter_formula}    Split String    ${formula}                    
                        SSHLibrary.Write    echo -e "Select sum(BHVALUE) from ${i} where BHVALUE = (Select max(BHVALUE) from ${i})\\n${Run}\\n"| isql -P ${password_dwhdb} -U ${username_dwhdb} -S ${database_dwhdb} -b
                        ${sumofbhvalue}       Read Until Prompt   
                        ${bhvalueone}     values    ${sumofbhvalue}                     
                        ${xyz}    compareone   ${bhvalueone}    ${formula}                    
                        IF    '${xyz}' == '${TRUE}'
                            Log     Testcase is Passed!
                        ELSE
                            Fail     Testcase is Failed!                        
                        END
                ELSE IF    '${bhcriteria}' == 'max(CAPMEAS_SCCPEAK)'
                    ${b}    Split String    ${bhcriteria}                
                    ${b1}    Split String From Right    ${b}[0]    (                
                    ${x}    Split String From Right    ${b1}[1]    )                
                ELSE IF    '${bhcriteria}' == 'max(VLRSUBS_TNSVLR)'
                    ${b}    Split String    ${bhcriteria}                
                    ${b1}    Split String From Right    ${b}[0]    (                
                    ${x}    Split String From Right    ${b1}[1]    )                
                    Write     echo -e "select * from Measurementcounter where DATANAME like '%${x}[0]%' and TYPEID like '%${package}%'\\n${Run}\\n"| isql -P ${password_db} -U ${username} -S ${database} -b
                        ${tablename_of_bhcriteria}       Read Until Prompt   
                        ${bhcriteria_tablename}     values    ${tablename_of_bhcriteria}                    
                        ${tablename}    Split String    ${bhcriteria_tablename}                    
                        ${table}    Split String from Right     ${tablename}[0]    :                    
                    Write     echo -e "Select ${b}[0] from ${table}[2]_RAW where HOUR_ID=${bh_and_hourid}[1]\\n${Run}\\n"| isql -P ${password_dwhdb} -U ${username_dwhdb} -S ${database_dwhdb} -b
                        ${formula_calculation}       Read Until Prompt   
                        ${formula}     values    ${formula_calculation}                    
                        ${counter_formula}    Split String    ${formula}                    
                        SSHLibrary.Write     echo -e "Select sum(BHVALUE) from ${i} where BHVALUE = (Select max(BHVALUE) from ${i})\\n${Run}\\n"| isql -P ${password_dwhdb} -U ${username_dwhdb} -S ${database_dwhdb} -b
                        ${sumofbhvalue}       Read Until Prompt   
                        ${bhvalueone}     values    ${sumofbhvalue}                     
                        ${xyz}    compareone   ${bhvalueone}    ${formula}
                        
                        IF    '${xyz}' == '${TRUE}'
                            Log     Testcase is Passed!
                        ELSE
                            Fail     Testcase is Failed!                        
                        END
                ELSE IF    '${bhcriteria}' == 'max(VLRSUBS_TNSPRSEXOUTD)'
                    ${b}    Split String    ${bhcriteria}                
                    ${b1}    Split String From Right    ${b}[0]    (                
                    ${x}    Split String From Right    ${b1}[1]    )                
                    Write     echo -e "select * from Measurementcounter where DATANAME like '%${x}[0]%' and TYPEID like '%${package}%'\\n${Run}\\n"| isql -P ${password_db} -U ${username} -S ${database} -b
                        ${tablename_of_bhcriteria}       Read Until Prompt   
                        ${bhcriteria_tablename}     values    ${tablename_of_bhcriteria}                    
                        ${tablename}    Split String    ${bhcriteria_tablename}                    
                        ${table}    Split String from Right     ${tablename}[0]    :                    
                    Write     echo -e "Select ${b}[0] from ${table}[2]_RAW where HOUR_ID=${bh_and_hourid}[1]\\n${Run}\\n"| isql -P ${password_dwhdb} -U ${username_dwhdb} -S ${database_dwhdb} -b
                        ${formula_calculation}       Read Until Prompt   
                        ${formula}     values    ${formula_calculation}                    
                        ${counter_formula}    Split String    ${formula}                    
                        SSHLibrary.Write     echo -e "Select sum(BHVALUE) from ${i} where BHVALUE = (Select max(BHVALUE) from ${i})\\n${Run}\\n"| isql -P ${password_dwhdb} -U ${username_dwhdb} -S ${database_dwhdb} -b
                        ${sumofbhvalue}       Read Until Prompt   
                        ${bhvalueone}     values    ${sumofbhvalue}                     
                        ${xyz}    compareone   ${bhvalueone}    ${formula}                    
                        IF    '${xyz}' == '${TRUE}'
                            Log     Testcase is Passed!
                        ELSE
                            Fail     Testcase is Failed!                       
                        END
                ELSE IF    '${bhcriteria}' == 'max(THRPEAK)'
                    ${b}    Split String    ${bhcriteria}                
                    ${b1}    Split String From Right    ${b}[0]    (                
                    ${x}    Split String From Right    ${b1}[1]    )                
                    Write     echo -e "select * from Measurementcounter where DATANAME like '%${x}[0]%' and TYPEID like '%${package}%'\\n${Run}\\n"| isql -P ${password_db} -U ${username} -S ${database} -b
                        ${tablename_of_bhcriteria}       Read Until Prompt   
                        ${bhcriteria_tablename}     values    ${tablename_of_bhcriteria}                    
                        ${tablename}    Split String    ${bhcriteria_tablename}                    
                        ${table}    Split String from Right     ${tablename}[0]    :                    
                    Write     echo -e "Select ${b}[0] from ${table}[2]_RAW where HOUR_ID=${bh_and_hourid}[1]\\n${Run}\\n"| isql -P ${password_dwhdb} -U ${username_dwhdb} -S ${database_dwhdb} -b
                        ${formula_calculation}       Read Until Prompt   
                        ${formula}     values    ${formula_calculation}                    
                        ${counter_formula}    Split String    ${formula}                    
                        SSHLibrary.Write     echo -e "Select sum(BHVALUE) from ${i} where BHVALUE = (Select max(BHVALUE) from ${i})\\n${Run}\\n"| isql -P ${password_dwhdb} -U ${username_dwhdb} -S ${database_dwhdb} -b
                        ${sumofbhvalue}       Read Until Prompt   
                        ${bhvalueone}     values    ${sumofbhvalue}                     
                        ${xyz}    compareone   ${bhvalueone}    ${formula}                    
                        IF    '${xyz}' == '${TRUE}'
                            Log     Testcase is Passed!
                        ELSE
                            Fail     Testcase is Failed!                      
                        END
                ELSE IF    '${bhcriteria}' == 'max(LSCC_LSCCCOUNTTHRPEAK)'
                    ${b}    Split String    ${bhcriteria}                    
                    ${b1}    Split String From Right    ${b}[0]    (                
                    ${x}    Split String From Right    ${b1}[1]    )                
                    Write     echo -e "select * from Measurementcounter where DATANAME like '%${x}[0]%' and TYPEID like '%${package}%'\\n${Run}\\n"| isql -P ${password_db} -U ${username} -S ${database} -b
                        ${tablename_of_bhcriteria}       Read Until Prompt   
                        ${bhcriteria_tablename}     values    ${tablename_of_bhcriteria}                    
                        ${tablename}    Split String    ${bhcriteria_tablename}                    
                        ${table}    Split String from Right     ${tablename}[0]    :                    
                    Write     echo -e "Select ${b}[0] from ${table}[2]_RAW where HOUR_ID=${bh_and_hourid}[1]\\n${Run}\\n"| isql -P ${password_dwhdb} -U ${username_dwhdb} -S ${database_dwhdb} -b
                        ${formula_calculation}       Read Until Prompt   
                        ${formula}     values    ${formula_calculation}                    
                        ${counter_formula}    Split String    ${formula}                    
                        SSHLibrary.Write     echo -e "Select sum(BHVALUE) from ${i} where BHVALUE = (Select max(BHVALUE) from ${i})\\n${Run}\\n"| isql -P ${password_dwhdb} -U ${username_dwhdb} -S ${database_dwhdb} -b
                        ${sumofbhvalue}       Read Until Prompt   
                        ${bhvalueone}     values    ${sumofbhvalue}                     
                        ${xyz}    compareone   ${bhvalueone}    ${formula}                    
                        IF    '${xyz}' == '${TRUE}'
                            Log     Testcase is Passed!
                        ELSE
                            Fail     Testcase is Failed!                        
                        END
                ELSE IF    '${bhcriteria}' == 'sum(NCELHUNNTOT)'
                    ${b}    Split String    ${bhcriteria}                
                    ${b1}    Split String From Right    ${b}[0]    (                
                    ${x}    Split String From Right    ${b1}[1]    )                
                    Write     echo -e "select * from Measurementcounter where DATANAME like '%${x}[0]%' and TYPEID like '%${package}%'\\n${Run}\\n"| isql -P ${password_db} -U ${username} -S ${database} -b
                        ${tablename_of_bhcriteria}       Read Until Prompt   
                        ${bhcriteria_tablename}     values    ${tablename_of_bhcriteria}                    
                        ${tablename}    Split String    ${bhcriteria_tablename}                    
                        ${table}    Split String from Right     ${tablename}[0]    :                    
                    Write     echo -e "Select ${b}[0] from ${table}[2]_RAW where HOUR_ID=${bh_and_hourid}[1]\\n${Run}\\n"| isql -P ${password_dwhdb} -U ${username_dwhdb} -S ${database_dwhdb} -b
                        ${formula_calculation}       Read Until Prompt   
                        ${formula}     values    ${formula_calculation}                    
                        ${counter_formula}    Split String    ${formula}                    
                        SSHLibrary.Write     echo -e "Select sum(BHVALUE) from ${i} where BHVALUE = (Select max(BHVALUE) from ${i})\\n${Run}\\n"| isql -P ${password_dwhdb} -U ${username_dwhdb} -S ${database_dwhdb} -b
                        ${sumofbhvalue}       Read Until Prompt   
                        ${bhvalueone}     values    ${sumofbhvalue}                     
                        ${xyz}    compareone   ${bhvalueone}    ${formula}                   
                        IF    '${xyz}' == '${TRUE}'
                            Log     Testcase is Passed!
                        ELSE
                            Fail     Testcase is Failed!                        
                        END
                ELSE IF    '${bhcriteria}' == 'max(LSCC_LSCCCOUNT)'
                    ${b}    Split String    ${bhcriteria}                
                    ${b1}    Split String From Right    ${b}[0]    (                
                    ${x}    Split String From Right    ${b1}[1]    )                
                ELSE IF    '${bhcriteria}' == 'sum(vgAcceptedReq_actual)'
                    ${b}    Split String    ${bhcriteria}                
                    ${b1}    Split String From Right    ${b}[0]    (                
                    ${x}    Split String From Right    ${b1}[1]    )                
                    Write     echo -e "select * from Measurementcounter where DATANAME like '%${x}[0]%' and TYPEID like '%${package}%'\\n${Run}\\n"| isql -P ${password_db} -U ${username} -S ${database} -b
                        ${tablename_of_bhcriteria}       Read Until Prompt   
                        ${bhcriteria_tablename}     values    ${tablename_of_bhcriteria}                   
                        ${tablename}    Split String    ${bhcriteria_tablename}                    
                        ${table}    Split String from Right     ${tablename}[0]    :                    
                    Write     echo -e "Select ${b}[0] from ${table}[2]_RAW where HOUR_ID=${bh_and_hourid}[1]\\n${Run}\\n"| isql -P ${password_dwhdb} -U ${username_dwhdb} -S ${database_dwhdb} -b
                        ${formula_calculation}       Read Until Prompt   
                        ${formula}     values    ${formula_calculation}                    
                        ${counter_formula}    Split String    ${formula}                    
                        SSHLibrary.Write     echo -e "Select sum(BHVALUE) from ${i} where BHVALUE = (Select max(BHVALUE) from ${i})\\n${Run}\\n"| isql -P ${password_dwhdb} -U ${username_dwhdb} -S ${database_dwhdb} -b
                        ${sumofbhvalue}       Read Until Prompt   
                        ${bhvalueone}     values    ${sumofbhvalue}                     
                        ${xyz}    compareone   ${bhvalueone}    ${formula}                    
                        IF    '${xyz}' == '${TRUE}'
                            Log     Testcase is Passed!
                        ELSE
                            Fail     Testcase is Failed!                        
                        END
                ELSE IF    '${bhcriteria}' == 'max(NSUBSCNT)'
                    ${b}    Split String    ${bhcriteria}                
                    ${b1}    Split String From Right    ${b}[0]    (                
                    ${x}    Split String From Right    ${b1}[1]    )                
                    Write     echo -e "select * from Measurementcounter where DATANAME like '%${x}[0]%' and TYPEID like '%${package}%'\\n${Run}\\n"| isql -P ${password_db} -U ${username} -S ${database} -b
                        ${tablename_of_bhcriteria}       Read Until Prompt   
                        ${bhcriteria_tablename}     values    ${tablename_of_bhcriteria}                    
                        ${tablename}    Split String    ${bhcriteria_tablename}                    
                        ${table}    Split String from Right     ${tablename}[0]    :                    
                    Write     echo -e "Select ${b}[0] from ${table}[2]_RAW where HOUR_ID=${bh_and_hourid}[1]\\n${Run}\\n"| isql -P ${password_dwhdb} -U ${username_dwhdb} -S ${database_dwhdb} -b
                        ${formula_calculation}       Read Until Prompt   
                        ${formula}     values    ${formula_calculation}                    
                        ${counter_formula}    Split String    ${formula}                    
                        SSHLibrary.Write     echo -e "Select sum(BHVALUE) from ${i} where BHVALUE = (Select max(BHVALUE) from ${i})\\n${Run}\\n"| isql -P ${password_dwhdb} -U ${username_dwhdb} -S ${database_dwhdb} -b
                        ${sumofbhvalue}       Read Until Prompt   
                        ${bhvalueone}     values    ${sumofbhvalue}                     
                        ${xyz}    compareone   ${bhvalueone}    ${formula}
                        IF    '${xyz}' == '${TRUE}'
                            Log     Testcase is Passed!
                        ELSE
                            Fail     Testcase is Failed!                        
                        END
                ELSE 
                    Log    BHCRITERIA IS EMPTY!
                END
            END
        END
        IF    '${package}' == 'DC_E_ERBSG2' or '${package}'== 'DC_E_ERBS'
        SSHLibrary.Write     echo -e "Select BHCRITERIA from Busyhour where BHCRITERIA NOT like '' and VERSIONID like '%DC_E_ERBSG2%' and BHTYPE like'P%0' and BHOBJECT like '%MSC%'\\n${Run}\\n"| isql -P ${password_db} -U ${username} -S ${database} -b
        ${query_bhcriteria}       Read Until Prompt   
        ${bhcriteria}     values    ${query_bhcriteria}    
        ${a}    Strip String    ${bhcriteria}    
        ${b}    Split String    ${bhcriteria}    
        Split String From Right    ${b}[0]    ()   
        ${c}    Split String From Right   ${b}[0]    (       
        ${x}    Split String From Right    ${c}[3]    ,     
        Write     echo -e "select * from Measurementcounter where DATANAME like '%${x}[0]%' and TYPEID like '%${package}%'\\n${Run}\\n"| isql -P ${password_db} -U ${username} -S ${database} -b
        ${tablename_of_bhcriteria}       Read Until Prompt   
        ${bhcriteria_tablename}     values    ${tablename_of_bhcriteria}    
        ${tablename}    Split String    ${bhcriteria_tablename}    
        ${table}    Split String from Right     ${tablename}[0]    :    
        Write     echo -e "Select ${b}[0] from ${table}[2]_RAW where HOUR_ID=${bh_and_hourid}[1]\\n${Run}\\n"| isql -P ${password_dwhdb} -U ${username_dwhdb} -S ${database_dwhdb} -b
        ${formula_calculation}       Read Until Prompt   
        ${formula}     values    ${formula_calculation}    
        ${counter_formula}    Split String    ${formula}    
        SSHLibrary.Write     echo -e "Select sum(BHVALUE) from ${i} where BHVALUE = (Select max(BHVALUE) from ${i})\\n${Run}\\n"| isql -P ${password_dwhdb} -U ${username_dwhdb} -S ${database_dwhdb} -b
        ${sumofbhvalue}       Read Until Prompt   
        ${bhvalueone}     values    ${sumofbhvalue}     
        ${xyz}    compareone   ${bhvalueone}    ${formula}
        IF    '${xyz}' == '${TRUE}'
            Log     Testcase is Passed!
        ELSE
            Fail     Testcase is Failed!
        END
        ELSE
        # SSHLibrary.Write     echo -e "Select BHCRITERIA from Busyhour where BHCRITERIA NOT like '' and VERSIONID like '%${package}%' and BHTYPE like'P%0' and BHOBJECT like '%MSC%'\\n${Run}\\n"| isql -P ${password_db} -U ${username} -S ${database} -b
        # ${query_bhcriteria}       Read Until Prompt   
        SSHLibrary.Write     echo -e "Select BHCRITERIA from Busyhour where BHCRITERIA NOT like '' and VERSIONID like '%${package}%' and BHTYPE like'P%0'\\n${Run}\\n"| isql -P ${password_db} -U ${username} -S ${database} -b
        ${query_bhcriteria}       Read Until Prompt  
        ${bhcriteria}     values    ${query_bhcriteria}
        ${a}    Strip String    ${bhcriteria}
        ${b}    Split String    ${bhcriteria}
        ${b1}    Split String From Right    ${b}[0]    (
        ${x}    Split String From Right    ${b1}[1]    )
        SSHLibrary.Write     echo -e "select * from Measurementcounter where DATANAME like '%${x}[0]%' and TYPEID like '%${package}%'\\n${Run}\\n"| isql -P ${password_db} -U ${username} -S ${database} -b
        ${tablename_of_bhcriteria}       Read Until Prompt   
        ${bhcriteria_tablename}     values    ${tablename_of_bhcriteria}
        ${tablename}    Split String    ${bhcriteria_tablename}
        ${table}    Split String from Right     ${tablename}[0]    :
        Write     echo -e "Select ${b}[0] from ${table}[2]_RAW where HOUR_ID=${bh_and_hourid}[1]\\n${Run}\\n"| isql -P ${password_dwhdb} -U ${username_dwhdb} -S ${database_dwhdb} -b
        ${formula_calculation}       Read Until Prompt   
        ${formula}     values    ${formula_calculation}
        ${counter_formula}    Split String    ${formula}
        SSHLibrary.Write     echo -e "Select sum(BHVALUE) from ${i} where BHVALUE = (Select max(BHVALUE) from ${i})\\n${Run}\\n"| isql -P ${password_dwhdb} -U ${username_dwhdb} -S ${database_dwhdb} -b
        ${sumofbhvalue}       Read Until Prompt   
        ${bhvalueone}     values    ${sumofbhvalue} 
        ${xyz}    compareone   ${bhvalueone}    ${formula}
        IF    '${xyz}' == '${TRUE}'
            Log     Testcase is Passed!
        ELSE
            Fail     Testcase is Failed!
        END
        END
    END    
TP - ENIQ_TP_UG_TC105,TP - ENIQ_TP_UG_TC106 Verify daybh and rankbh  
    Set Client Configuration    prompt=eniqs[eniq_stats] {dcuser} #:    timeout=3600
    Write    cd /eniq/home/dcuser
    Read    delay=15s
    IF    '${checkPP}' == 'True'
        Log     RANKBH PP table not there in this techpack
	#IF    '${package}'=='DC_E_RBS' or '${package}'=='DC_E_CPP' or '${package}'=='DC_E_ERBSG2' or '${package}'=='DC_E_RAN' or '${package}'=='DC_E_MGW' or '${package}'=='DC_E_BSS' or '${package}'=='DC_E_SGSN' or '${package}'=='DC_E_CNAXE' or '${package}'=='DC_E_CMN_STS' or '${package}'=='DC_E_RBSG2'
       # Skip    'Skipping this TestCase Execution Since it is not applicable for ${package}' 
    ELSE
        Write     echo -e " Select AGGREGATION from LOG_AggregationStatus where DATE_ID = '${date}' and AGGREGATION like '%${package}%' and AGGREGATIONSCOPE like '%DAY%' and status not like '%FAILEDDEPENDENCY%' and status not like '%BLOCKED%' and aggregation like '%RANKBH%' and AGGREGATION not like '%cp0%'\\n${Run}\\n"| isql -P ${password_dwhdb} -U ${username_dwhdb} -S ${database_dwhdb} -b
        ${SQLquery}      Read Until Prompt
        ${SQLquery1}    deletelastrows    ${SQLquery}
        ${SQLquery1}    Split String    ${SQLquery1}
        ${contains}=    Run Ke yword And Return Status    Should Contain Any      ${SQLquery}    (0 rows affected)
        IF    '${contains}' == 'True'
            Fail    Testcase is Failed as ${SQLquery1} table is in FAILED STATE.
        ELSE
            FOR    ${i}    IN    @{SQLquery1}
                
                #Log    ${version_id},${bhlevel},${i},${typename}.${i},${index},${bhobject}
                Write     echo -e " Select ROWSTATUS from ${i} where DATE_ID = '${date}'\\n${Run}\\n"| isql -P ${password_dwhdb} -U ${username_dwhdb} -S ${database_dwhdb} -b 
                ${Status}    Read Until Prompt
                ${Status1}    deletelastrows    ${Status}
                ${Status}=    Run Keyword And Return Status    Should Contain Any      ${Status}    (0 rows affected)
                IF    '${Status}' == 'True'
                    Fail    Testcase is Failed as ${i} table is in FAILED STATE.
                END
            END
        END
        Write     echo -e " Select TYPENAME from LOG_AggregationStatus where DATE_ID = '${date}' and AGGREGATION like '%${package}%' and AGGREGATIONSCOPE like '%DAY%' and status not like '%FAILEDDEPENDENCY%' and status not like '%BLOCKED%' and aggregation like '%DAYBH%'\\n${Run}\\n"| isql -P ${password_dwhdb} -U ${username_dwhdb} -S ${database_dwhdb} -b
        ${SQLquery}      Read Until Prompt
        ${SQLquery2}    deletelastrows    ${SQLquery}
        ${SQLquery2}    Split String    ${SQLquery2}
        ${contains}=    Run Keyword And Return Status    Should Contain Any      ${SQLquery}    (0 rows affected)
        IF    '${contains}' == 'True'
            Fail    Testcase is Failed as ${SQLquery} table is in FAILED STATE.
        ELSE
            FOR    ${i}    IN    @{SQLquery2}
                
                #Log    ${version_id},${bhlevel},${i},${typename}.${i},${index},${bhobject}
                Write     echo -e " Select ROWSTATUS from ${i}_DAYBH where DATE_ID = '${date}'\\n${Run}\\n"| isql -P ${password_dwhdb} -U ${username_dwhdb} -S ${database_dwhdb} -b 
                ${Status}    Read Until Prompt
                ${Status}    deletelastrows    ${Status}
                ${Status}=    Run Keyword And Return Status    Should Contain Any      ${Status}    (0 rows affected)
                IF    '${Status}' == 'True'
                    Fail    Testcase is Failed as ${i} table is in FAILED STATE.
                END
            END
        END         
            #${show_table_names}    Values    ${SQLquery}
            # Write     echo -e "Select bhobject from Busyhour where BHCRITERIA NOT like '' and BHLEVEL like '%${package}%' and BHTYPE like '%CP%'and ENABLE = 1\\n${Run}\\n"| isql -P ${password_db} -U ${username} -S ${database} -b
            # ${bhobject}       Read Until Prompt   
            # ${bhobject2}     values    ${bhobject} 
            # ${bhobject3}    Split String    ${bhobject2}
            # Write     echo -e "Select bhtype from Busyhour where BHCRITERIA NOT like '' and BHLEVEL like '%${package}%' and BHTYPE like '%CP%'and ENABLE = 1\\n${Run}\\n"| isql -P ${password_db} -U ${username} -S ${database} -b
            # ${bhtype}       Read Until Prompt   
            # ${bhtype2}     values    ${bhtype} 
            # ${bhtype3}    Split String    ${bhtype2}
            # #${bhobject_and_bhtype}    combining_bhobject_and_bhtype    ${bhobject3}    ${bhtype3}    
            # ${failed_dependency_tables}=  list_of_failed_dependency_tables    ${show_table_names}
            # ${failed_tables}    failed_tables_str_conversion   ${failed_dependency_tables}
            # ${contains}=    Run Keyword And Return Status    Should Contain Any      ${failed_tables}    ${package}_${bhobject2}BH_RANKBH_${bhobject_and_bhtype}    
            # IF    '${contains}' == 'True'
            #     Fail    Testcase is Failed as ${package}_${bhobject2}BH_RANKBH_${bhobject_and_bhtype} table is in FAILED STATE.
            # ELSE
            #     ${not_loaded}=   list_of_not_loaded_tables       ${show_table_names}
            #     ${not_loaded_tables}    Not Loaded Tables    ${not_loaded}
            #     ${contains}=    Run Keyword And Return Status    Should Contain   ${not_loaded_tables}    ${package}_${bhobject2}BH_RANKBH_${bhobject_and_bhtype}
            #     IF    '${contains}' == 'True'
            #         Log    ${package}_${bhobject2}BH_RANKBH_${bhobject_and_bhtype} is present in NOT LOADED STATE! 
            #         Fail    Testcase is Failed as ${package}_${bhobject2}BH_RANKBH_${bhobject_and_bhtype} is in NOTLOADED STATE.    
            #     ELSE 
            #         ${aggregated_tables}    list_of_aggregated_tables    ${show_table_names}
            #         ${x2y2}    Aggregated Tables    ${aggregated_tables}
            #         ${contains}=    Run Keyword And Return Status    Should Contain Any  ${x2y2}    ${package}_${bhobject2}BH_RANKBH_${bhobject_and_bhtype}
            #         IF    '${contains}' == 'True'
            #             Write     echo -e "Select * from ${package}_${bhobject2}BH_RANKBH_${bhobject_and_bhtype}\\n${Run}\\n"| isql -P ${password_dwhdb} -U ${username_dwhdb} -S ${database_dwhdb} -b
            #             ${rankbh_cp0_table_name}    Read Until Prompt
            #             Write     echo -e "Select bhlevel,bhobject,bhtype from busyhour where versionid like '%${package}%' and bhtype like '%CP0%' and BHCRITERIA NOT like ''\\n${Run}\\n"| isql -P ${password_db} -U ${username} -S ${database} -b
            #             ${get_rankbh_level}    Read Until Prompt
            #             ${x2}    Strip String    ${get_rankbh_level} 
            #             ${y2}     Values    ${x2}
            #             ${z3}     Split String    ${y2}
            #             Write  echo -e "Select HOUR_ID,BHTYPE from ${z3}[0]_RANKBH_${z3}[1]_${z3}[2] where DATE_ID='${date}'\\n${Run}\\n"| isql -P ${password_dwhdb} -U ${username_dwhdb} -S ${database_dwhdb} -b
            #             ${RANKBHCP0_SQL_query}      Read Until Prompt
            #             ${RANKBHCP0_SQL_query_output}    Split String    ${RANKBHCP0_SQL_query}   
            #             Write     echo -e "Select basetablename from measurementtable where mtableid like '%${package}%' and tablelevel like '%daybh%' order by basetablename asc\\n${Run}\\n"| isql -P ${password_db} -U ${username} -S ${database} -b
            #             ${DAYBH2}      Read Until Prompt
            #             ${xyz2}    Strip String    ${DAYBH2}
            #             ${xyz3}    Values    ${xyz2}
            #             ${xyz4}    Split String    ${xyz3}
            #             Write  echo -e "Select HOUR_ID,BHTYPE from ${z3}[0]_RANKBH_${z3}[1]_${z3}[2] where bhvalue=(Select max(bhvalue) from ${z3}[0]_RANKBH_${z3}[1]_${z3}[2] where DATE_ID='${date}')\\n${Run}\\n"| isql -P ${password_dwhdb} -U ${username_dwhdb} -S ${database_dwhdb} -b
            #             ${maxhourid}      Read Until Prompt
            #             ${maxhourid_output}    Split String    ${maxhourid}  
            #             Write  echo -e "Select busyhour,bhtype from ${xyz4}[0] where DATE_ID= '${date}'\\n${Run}\\n"| isql -P ${password_dwhdb} -U ${username_dwhdb} -S ${database_dwhdb} -b
            #             ${daybhout}      Read Until Prompt    
            #             ${daybh_output}    Split String    ${daybhout}   
            #             IF    '${maxhourid_output}[0]'!='${daybh_output}[0]' and '${maxhourid_output}[1]'!='${daybh_output}[1]'
            #                 Fail    Busyhour is not matching with the HOUR ID of RANKBHCP0 table also BHtype is not matching with the BHTYPE of RANKBHCP0 table
            #                 Log    Hence, the verification of rankbh and daybh is not possible and the testcase is FAILED!
            #             ELSE
            #                 Write  echo -e "Select busyhour,bhtype from ${xyz4}[0] where DATE_ID= '${date}' and busyhour= ${maxhourid_output}[0] and bhtype like '%${maxhourid_output}[1]%'\\n${Run}\\n"| isql -P ${password_dwhdb} -U ${username_dwhdb} -S ${database_dwhdb} -b
            #                 ${busyhour_and_bhtype}    Read Until Prompt
            #                 ${busyhourandbhtype}    Split String    ${busyhour_and_bhtype}
            #                 Log    Testcased is Passed!
            #                 Log    Raw Data for the busyhour is loaded in the DAYBH table
            #             END
            #         ELSE
            #             Fail    RANKBHCP0 table is not configured!
            #         END                    
            #    END 
           #END    
        #END
    END

######Ashwini Code End


TP - ENIQ_TP_UG_TC172,TP - ENIQ_TP_UG_TC175 checking rbs and rbsg2
    Skip If    '${package}' != 'DC_E_RBS'    Skipping this TestCase Execution Since it is not applicable for ${package}
    
    Write    cd /eniq/home/dcuser
    Read    delay=10s
     ${RBSG2buildno}=    Execute Command    cd ${MWS_PATH}/${latest_mws_path}[0]/eniq_techpacks;ls -Art DC_E_RBSG2_R*.tpi | tail -n 1   
    ${RBSG2buildno}    Split String    ${RBSG2buildno}    DC_E_RBSG2_R
    ${RBSG2buildno}    Split String    ${RBSG2buildno}[1]    _b
    ${RBSG2buildno}    Split String    ${RBSG2buildno}[1]    .
    #----get rbs latest buildnumber
    # Open clearcasevobs
    # ${temp_RBS}=    Get Element Attribute    //table//a[text()='${RBS_package}']    href
    # ${temp2}=    Fetch From Right    ${temp_RBS}    /
    # Set Global Variable    ${full_RBS_pkg_name}    ${temp2}
    # ${RBSbuildno}=    tp.RBSG2 build number  ${full_RBS_pkg_name}
    ${prevbuildno}=    tp.prev build number   ${buildno} 
    log    ${prevbuildno}
    #---get RBSG2 latest buildnumber
    # Open clearcasevobs
    # ${temp_RBS}=    Get Element Attribute    //table//a[text()='${RBSG2_package}']    href
    # ${temp2}=    Fetch From Right    ${temp_RBS}    /
    # Set Global Variable    ${full_RBS_pkg_name}    ${temp2}
    # ${RBSG2buildno}=    tp.RBSG2 build number  ${full_RBS_pkg_name}

    
    #---verify new counters added or not
   
    Set Client Configuration    prompt=eniqs[eniq_stats] {dcuser} #:    timeout=300
    
    Write    echo -e "select dataname from measurementcounter where TYPEID like '%DC_E_RBS:((${buildno}))%' AND dataname NOT IN(select dataname from measurementcounter where TYPEID like '%DC_E_RBS:((${prevbuildno}))%')\\n${run}\\n" | isql -P ${password_db} -U ${username} -S ${database} -b
    ${New_counters}    Read Until Prompt    
    Log    ${New_counters}
    ${check}    Run Keyword And Return Status   Should Contain Any    ${New_counters}    (0 rows affected)
    Log    ${check}  
    IF  ${check}
    Log    'New counters not added'
    ELSE
        Log    'new counters--${New_counters}'
        ${new_counter}    tp.deletelastrows    ${New_counters}
        ${temp}    Split String    ${new_counter}    
        
        # ${new_counter}=   Remove From List    ${temp}    -2 
         
        # Log    ${new_counter}
        FOR    ${i}    IN    @{temp}
        Log    ${i}
        ${k}    Strip String    ${i}
        
    
        # Set Client Configuration    prompt=eniqs[eniq_stats] {dcuser} #:    timeout=300
        # Test
        Write    echo -e "select DESCRIPTION from measurementcounter where TYPEID like '%DC_E_RBS:((${buildno}))%' and dataname like '%${k}'\\n${run}\\n" | isql -P ${password_db} -U ${username} -S ${database} -b
        ${RBS_description_all}    Read Until Prompt
        ${RBS_description_all1}     Convert To Lower Case    ${RBS_description_all}
            
        Log    ${RBS_description_all}
        ${check}    Run Keyword And Return Status   Should Contain Any    ${RBS_description_all1}    du and base
            IF  ${check}
                Log    'the table/counter is present in both RBS and RBSG2'
            ELSE
                ${check1}    Run Keyword And Return Status   Should Contain Any    ${RBS_description_all1}     baseband node
                IF    ${check1} 
                    Log    'the table/counter is present only in RBSG2'
                ELSE
                    ${check2}    Run Keyword And Return Status   Should Contain Any    ${RBS_description_all1}      du node
                    IF    ${check2}
                        Log    'the table/counter is present only in RBS.'
                    ELSE
                        Log    'discription not matched above 3 conditions '
                        Fail
                    END
                END
            
            END
        END
    END    


    # Set Client Configuration    prompt=eniqs[eniq_stats] {dcuser} #:    timeout=300
    Write    echo -e "select DESCRIPTION from measurementcounter where TYPEID like '%DC_E_RBSG2:((${RBSG2buildno}[0]))%'\\n${run}\\n" | isql -P ${password_db} -U ${username} -S ${database} -b
    ${RBSG2_description}    Read    delay=5

    # Set Client Configuration    prompt=eniqs[eniq_stats] {dcuser} #:    timeout=300
    Write    echo -e "select DESCRIPTION from measurementcounter where TYPEID like '%DC_E_RBS:((${buildno}))%'\\n${run}\\n" | isql -P ${password_db} -U ${username} -S ${database} -b
    ${RBS_description}    Read    delay=5

   
    ${flag}    ${message}=   tp.compare rbsg2 rbs description    ${RBSG2_description}           ${RBS_description}
    IF     ${flag} 
        Log    ${message}
    ELSE
        Log    ${message}
        
    END
   # TP - ENIQ_TP_UG_TC190 verify supported node versions
   
    #Set Client Configuration    prompt=eniqs[eniq_stats] {dcuser} #:    timeout=300
    Write    echo -e "select vendorrelease from SupportedVendorRelease WHERE versionid like '%${RBS_package}:((${buildno}[0]))%'\\n${run}\\n" | isql -P ${password_db} -U ${username} -S ${database} -b
    ${RBS_out12}    Read    delay=5
    Write    echo -e "select vendorrelease from SupportedVendorRelease WHERE versionid like '%${RBSG2_package}:((${RBSG2buildno}[0]))%'\\n${run}\\n" | isql -P ${password_db} -U ${username} -S ${database} -b
    ${RBSG2_output}    Read    delay=5
    #...comapare node versions
    tp.compare node versions    ${RBS_out12}     ${RBSG2_output}
TP - ENIQ_TP_UG_TC171 Run the Combined view script for RBSG2
     Skip If
     ...    '${package}'!='DC_E_RBSG2'
     ...    Skipping the Execution since this testcase is not applicable for ${package}
    Set Client Configuration    prompt=eniqs[eniq_stats] {dcuser} #:    timeout=300
    Write    cd /eniq/home/dcuser
    Read    delay=10s
    Execute command     cd /eniq/sw/installer ; ./WCDMACombinedViewCreation.bsh WCDMACombinedViewConfigFile.csv
    Write    echo -e "select BASETABLENAME from Measurementtable where MTABLEID LIKE 'DC_E_RBS:(%' and (TABLELEVEL= 'raw')\\n${run}\\n" | isql -P ${password_db} -U ${username} -S ${database} -b
    ${out1}=    Read Until Prompt 
    ${table}    deletelastrows    ${out1}
    ${table1}=    Split String    ${table}
    Log To Console    ${table}
    FOR    ${i}    IN    @{table1}
    Write    echo -e "Select viewtext from sysviews where viewname='${i}' and viewtext like'%DC_E_RBSG2%'\\n${run}\\n" | isql -P Dc12# -U dc -S dwhdb -b
    ${output1}=    Read Until Prompt
    ${flag}=     Run Keyword And Return Status    Should Contain Any      ${output1}    0 rows affected
        IF    ${flag}     
            Log    'RBSG2 view defination not presented in RBS'
        ELSE
            Log    'RBSG2 view defination presented in RBS'
        END
    END
	
TP - ENIQ_TP_UG_TC182 verifying id format bulkcm specific   
        Skip If    '${package}' != 'DC_E_BULK_CM'    Skipping this TestCase Execution Since it is not applicable for ${package} 
        Write    cd /eniq/home/dcuser
        Read    delay=10s
        # Open clearcasevobs
        # ${rstate}    Get Text    //table//a[text()='DC_E_BULK_CM']/../following-sibling::td[3]
        ${rstate}    Split String    ${full_pkg_name}    ${package}_
        ${rstate}    Split String    ${rstate}[1]    _
        Log    ${rstate}[0]
        Go To    https://arm1s11-eiffel013.eiffel.gic.ericsson.se:8443/nexus/content/repositories/releases/com/ericsson/eniq/stats/tp/BULK_CM/bulk_cm_etl/FD/${rstate}[0]
        Click Element    //a[contains(text(),'${pkg}')]
        ${modeltlink}=    Get Element Attribute    //tr[3]//a    href
        ${modeltname}=    Fetch From Right    ${modeltlink}    /
        Open Connection    ${jnkns_server}
        Login               root        shroot
        Write    rm -rf bulkcm
        Write    mkdir bulkcm && cd bulkcm && wget ${modeltlink} && wget https://arm1s11-eiffel013.eiffel.gic.ericsson.se:8443/nexus/content/repositories/releases/com/ericsson/eniq/stats/tp/TP_KPI_Script/bulkcm_script.zip && unzip bulkcm_script.zip
        Write    source /root/CI/cicd/bin/activate && cd /root/bulkcm && echo -e "${modeltname}\\n2\\n4" | python bulkcm_script.py 
        ${output}=    Read    delay=30s
        Write    cd /root && rm -rf /root/bulkcm
        Read    delay=10s
        Switch Connection    ${index}
        Write    cd 
        Read    delay=10s
        ${temp}=    Get Lines Containing String    ${output}    in row
        IF    '${temp}' == 'Id counter: scxTimeReferenceId in row ${SPACE}44341'
            Log    no 
        ELSE
            Fail
        END
TP - ENIQ_TP_UG_TC183 verifying extended keys bulkcm specific
        Skip If    '${package}' != 'DC_E_BULK_CM'    Skipping this TestCase Execution Since it is not applicable for ${package}   
        Write    cd /eniq/home/dcuser
        Read    delay=10s   
        # Open clearcasevobs
        # ${rstate}    Get Text    //table//a[text()='DC_E_BULK_CM']/../following-sibling::td[3]
        ${rstate}    Split String    ${full_pkg_name}    ${package}_
        ${rstate}    Split String    ${rstate}[1]    _
        Log    ${rstate}[0]
        Go To    https://arm1s11-eiffel013.eiffel.gic.ericsson.se:8443/nexus/content/repositories/releases/com/ericsson/eniq/stats/tp/BULK_CM/bulk_cm_etl/FD/${rstate}[0]
        Click Element    //a[contains(text(),'${pkg}')]
        ${modeltlink}=    Get Element Attribute    //tr[3]//a    href
        ${modeltname}=    Fetch From Right    ${modeltlink}    /
        Open Connection    atvts4051.athtem.eei.ericsson.se
        Login               root        shroot
        Write    rm -rf bulkcm
        Write    mkdir bulkcm && cd bulkcm && wget ${modeltlink} && wget https://arm1s11-eiffel013.eiffel.gic.ericsson.se:8443/nexus/content/repositories/releases/com/ericsson/eniq/stats/tp/TP_KPI_Script/bulkcm_script.zip && unzip bulkcm_script.zip
        Write    source /root/CI/cicd/bin/activate && cd /root/bulkcm && echo -e "${modeltname}\\n3\\n4" | python bulkcm_script.py 
        ${output}=    Read    delay=120s
        Write    cd /root && rm -rf /root/bulkcm
        Read    delay=10s
        Switch Connection    ${index}
        Write    cd 
        Read    delay=10s
        ${temp}=    Get Lines Containing String    ${output}    in row
        ${str}=    makestr    ${temp}
        IF    '${str}' == 'true'
            Log    Data Validation correct 
        ELSE
            Log    ${str}
            Fail
        END
    
TP - ENIQ_TP_UG_TC169 Afg sepcific testcase
    Skip If    '${package}' != 'DC_E_AFG'    Skipping this TestCase Execution Since it is not applicable for ${package}
	${tmpdate}=    Execute Command    date -d '-1 day' '+%Y%m%d'
    ${result}=    tp.afg specific    ${host}    ${port}    ${uname}    ${pwd}    ${tmpdate}
    IF    '${result}' == 'False'
        Fail
    END
TP - ENIQ_TP_UG_TC185 Run the Combined view script for ERBSG2
    Skip If    '${package}'!='DC_E_ERBS'    Skipping the Execution since this testcase is not applicable for ${package}
    Set Client Configuration    prompt=eniqs[eniq_stats] {dcuser} #:    timeout=500
    Execute Command    cd /eniq/sw/installer; ./erbscombinedview.bsh >testlog.txt
    ${output}=    Execute Command    grep -E 'error|warning' /eniq/sw/installer/testlog.txt
    ${output}=    Run Keyword And Return Status    Should Contain    ${output}    'error|warning'
    IF    '${output}'=='True'
        Fail    Error or Warning found in testlog.txt${\n}${output}
    ELSE
        Log    ${\n}Combined View Script executed successfully and no Error and Warnings are found.
    END

TP - ENIQ_TP_UG_TC187 verify counters of erbsg2 in erbs
    Skip If
    ...    '${package}'!='DC_E_ERBS'
    ...    Skipping the execution since this testcase is not applicable for ${package}
    # Open clearcasevobs
    # ${buildno}    Get Element Attribute    //table//a[text()='DC_E_ERBS']    href
    ${buildno}=    Execute Command    cd ${MWS_PATH}/${latest_mws_path}[0]/eniq_techpacks;ls -Art DC_E_ERBS_R*.tpi | tail -n 1   
    ${buildno}    Split String    ${buildno}    DC_E_ERBS_R
    ${buildno}    Split String    ${buildno}[1]    _b
    ${buildno}    Split String    ${buildno}[1]    .
    #${buildnog2}    Get Element Attribute    //table//a[text()='DC_E_ERBSG2']    href
    ${buildno2}=    Execute Command    cd ${MWS_PATH}/${latest_mws_path}[0]/eniq_techpacks;ls -Art DC_E_ERBSG2_R*.tpi | tail -n 1
    ${buildnog2}    Fetch From Right    ${buildno2}    _b
    ${buildnog2}    Split String From Right    ${buildnog2}    .
    Write    cd /eniq/home/dcuser
    Read    delay=2s
    Set Client Configuration    prompt=eniqs[eniq_stats] {dcuser} #:    timeout=3600
    Write
    ...    echo -e "SELECT dataname FROM measurementcounter WHERE typeid like '%DC_E_ERBSG2:((${buildnog2}[0]))%' AND dataname NOT IN(SELECT dataname FROM measurementcounter WHERE typeid like '%DC_E_ERBS:((${buildno}[0]))%');\\n${run}\\n" | isql -P ${password_db} -U ${username} -S ${database} -b
    ${after_comparison}    Read Until Prompt
    ${after_comparison}    Split String    ${after_comparison}    \r\n
    ${length}    Get Length    ${after_comparison}
    IF    ${length} <= 3
        log    ${\n}All counters in ERBSG2 are present in ERBS
    ELSE
        ${total_counters}    Evaluate    ${length}-3
        log    ${\n}${total_counters} counters in ERBSG2 that are not present in ERBS are listed below-
        FOR    ${i}    IN RANGE    0    ${total_counters}
            Log    ${\n}${after_comparison}[${i}]
        END
        Fail    Hence, failing the Test case
    END
#####Ravi Code start #####
TP - ENIQ_TP_UG_TC203 Verify the loading with multiple MOIDS
        Skip If    '${package}' != 'DC_E_CCRC'    Skipping the execution since this testcase is not applicable for ${package}
        Write    cd /eniq/home/dcuser
        Read    delay=10s
        Set Client Configuration    prompt=eniqs[eniq_stats] {dcuser} #:    timeout=3600
        Put File    ${path}/ENIQ_TC_Automation/TP/Resources/epfg_ccrc.pl   /eniq/home/dcuser
        tp.Edit Epfg For NFMGroupMultiMeasObjLdn    ${host}    ${port}    ${uname}    ${pwd}
        Write     cd /eniq/home/dcuser ; echo -e "${package}_R10A_b12.tpi" | perl epfg_ccrc.pl 
        ${out}=    Read Until Prompt
        Write    cd /eniq/home/dcuser/epfg ; ./start_epfg.sh
        ${out}=    Read Until Prompt
        Sleep    180
        Write    engine -e startSet 'INTF_DC_E_CCRC-eniq_oss_1' 'Adapter_INTF_DC_E_CCRC_3gpp32435'
        ${out}=    Read Until Prompt
        Should Contain    ${out}    Start set requested successfully    Failed starting Adapter set for INTF_DC_E_CCRC-eniq_oss_1
    
        Write    cd /eniq/home/dcuser
        Read    delay=2s
        Set Client Configuration    prompt=eniqs[eniq_stats] {dcuser} #:    timeout=3600
        Write    echo -e "select moid from DC_E_CCRC_NRF_NNRF_NFM_RAW\\n${run}\\n" | isql -P ${password_dwhdb} -U ${username_dwhdb} -S ${database_dwhdb} -b
        ${ccrc_moid_output}=    Read Until Prompt
        Set Global Variable    ${ccrc_moid_output}
        Log    ${ccrc_moid_output}
        Write    echo -e "select operation,remote_endpoint,status_code from DC_E_CCRC_NRF_NNRF_NFM_RAW\\n${run}\\n" | isql -P ${password_dwhdb} -U ${username_dwhdb} -S ${database_dwhdb} -b
        ${ccrc_moid_val_output}=    Read Until Prompt
        Set Global Variable    ${ccrc_moid_val_output}
        Log    ${ccrc_moid_val_output}
        ${flag}    ${message}    tp.Ccrc Moid    ${ccrc_moid_output}    ${ccrc_moid_val_output}
        IF    ${flag}==1
            Log    ${\n}${message}
        ELSE
            Fail    Testcase Failed as ${message}
        END
    

TP - ENIQ_TP_UG_TC202 Verify the Start and Stop Time values
        Skip If    '${package}' != 'DC_E_NETOP'    Skipping the execution since this testcase is not applicable for ${package}
        Write    cd /eniq/home/dcuser
        Read    delay=10s
        Open Connection And Log In
        Set Client Configuration    prompt=eniqs[eniq_stats] {dcuser} #:    timeout=3600
        Write    cd /eniq/home/dcuser
        Read    delay=5s
        Write    echo -e "select TYPEID from MeasurementTable WHERE MTABLEID like'%DC_E_NETOP%'\\n${run}\\n" | isql -P ${password_db} -U ${username} -S ${database} -b
        ${repdb_table_output}=    Read Until Prompt
        ${bar}    ${mrr}    tp.Verify Netop Start And Stop Time    ${repdb_table_output}
        ${NETOP_BAR_file_name}    Execute Command     cd /ericsson/pmic1/pm_storage/NCS_ASCII/BAA01/ && ls
        ${filter_bar file_name}    tp.Verify Netop Start And Stop Time1    ${NETOP_BAR_file_name}
        ${fileid_bar}    Split String From Right    ${filter_bar file_name}    _
        Log    ${\n}${fileid_bar}[-1]
        ${read_bar_file}    Execute Command    cat /ericsson/pmic1/pm_storage/NCS_ASCII/BAA01/${filter_bar file_name} | grep -e 'Start date' -e 'Start time' -e 'RECTIME:' | sort --unique
        Log    ${\n}${read_bar_file}
        FOR    ${bar_table}    IN    @{bar}
            ${bar_table}    Split String From Right    ${bar_table}    :
            Log    ${bar_table}[-1]
            Write    echo -e "select Recording_Start_time,Recording_Stop_time from ${bar_table}[-1]_RAW where BSC_Node_Name='BAA01' and FILE_ID='${fileid_bar}[-1]'\\n${run}\\n" | isql -P ${password_dwhdb} -U ${username_dwhdb} -S ${database_dwhdb} -b
            ${bar_table_output}    Read Until Prompt
            ${bar_table_query_output}    tp.Verify Netop Start And Stop Time2    ${read_bar_file}    ${bar_table_output}
            IF    ${bar_table_query_output} == 1
                Log    PASS
            ELSE
                Fail    Value are not matching
                
            END

        END
        ${NETOP_MRR_file_name}    Execute Command     cd /ericsson/pmic1/pm_storage/MRR_ASCII/BAA01/ && ls
        ${filter_mrr_file_name}    tp.Verify Netop Start And Stop Time1    ${NETOP_MRR_file_name}
        ${fileid_mrr}    Split String From Right    ${filter_mrr_file_name}    _
        Log    ${\n}${fileid_mrr}[-1]
        ${read_mrr_file}    Execute Command    cat /ericsson/pmic1/pm_storage/MRR_ASCII/BAA01/${filter_mrr_file_name} | grep -e 'Start date' -e 'Start time' -e 'Total time recording:' | sort --unique
        Log    ${\n}${read_mrr_file}
        FOR    ${mrr_table}    IN    @{mrr}
            ${mrr_table}    Split String From Right    ${mrr_table}    :
            Log    ${mrr_table}[-1]
            Write    echo -e "select Recording_Start_time,Recording_Stop_time from ${mrr_table}[-1]_RAW where BSC_Node_Name='BAA01' and FILE_ID='${fileid_mrr}[-1]'\\n${run}\\n" | isql -P ${password_dwhdb} -U ${username_dwhdb} -S ${database_dwhdb} -b
            ${mrr_table_output}    Read Until Prompt
            ${mrr_table_query_output}    tp.Verify Netop Start And Stop Time3    ${read_mrr_file}    ${mrr_table_output}
            IF    ${mrr_table_query_output} == 1
                Log    PASS
            ELSE
                Fail    Value are not matching
                
            END

        END

#####Ravi Code End #####

######Bharathi Code Start#########

 TP - ENIQ_TP_UG_TC200 NETOP KEYS - Data Format sheet 
	    Skip If    '${package}' != 'DC_E_NETOP'    Skipping the execution since this testcase is not applicable for ${package}
		${sql_query}    set variable    select TYPEID from MeasurementTable WHERE MTABLEID like'%DC_E_NETOP%'
		${sql_query_netop}    set variable    select DATANAME from dataitem where dataformatid
		${sql_query_netop_type}    set variable    select distinct typeid from measurementkey where typeid like '%DC_E_NETOP%'
		${sql_query_netop_key}    set variable    select dataname from measurementkey where typeid
		${counter}=    create list    ${sql_query}    ${sql_query_netop}    ${sql_query_netop_type}    ${sql_query_netop_key}
		Set Client Configuration    prompt=eniqs[eniq_stats] {dcuser} #:    timeout=300
		Write    cd /eniq/home/dcuser
		Read    delay=5s
		FOR    ${i}    IN RANGE    0    4    2

			Write    echo -e "${counter}[${i}]\\n${run}\\n" | isql -P ${password_db} -U ${username} -S ${database} -b
			${output3}=    Read Until Prompt
			${output3}    tp.Ffaxw Date    ${output3}
			${output3} =  Split String    ${output3} 
			FOR    ${element_table}    IN    @{output3}
				Log    ${element_table}
				${contains}=  Evaluate   "BAR" in """${element_table}"""
				${contains_mrr}=  Evaluate   "MRR" in """${element_table}"""
				Write    echo -e "${counter}[${i+1}]\\nlike '%${element_table}%'\\n\\n${run}\\n" | isql -P ${password_db} -U ${username} -S ${database} -b
				${dataname}=    Read Until Prompt
				${dataname}    tp.Ffaxw Date    ${dataname}
				${dataname} =  Split String    ${dataname}
				IF    ${contains}
					${RID_STATUS_BAR}    Evaluate    'RID' in '''${dataname}'''
					${RECTTIME_STATUS}    Evaluate    'RECTIME' in '''${dataname}'''
					Run Keyword If 
			...        ('${RID_STATUS_BAR}'=='False' or '${RECTTIME_STATUS}'=='False') 
			...         Run Keyword And Continue On Failure    Fail    dataname not matched 
				END
				
				IF    ${contains_mrr}
					${RID_STATUS_MRR}    Evaluate    'RID' in '''${dataname}'''
					${TTIME_STATUS}    Evaluate    'TTIME' in '''${dataname}'''
					Run Keyword If 
			...        ('${RID_STATUS_MRR}'=='False' or '${TTIME_STATUS}'=='False') 
			...         Run Keyword And Continue On Failure    Fail    dataname not matched
				END
				
			END
		END
	

TP - ENIQ_TP_UG_TC198 Verify the calucalations FFAXW 
    #${package}    Evaluate    'DC_E_FFAXW' in '${package}'
        Skip If    '${package}' != 'DC_E_FFAXW'    Skipping the execution since this testcase is not applicable for ${package}
        ${host}    set variable    atvts4066.athtem.eei.ericsson.se
        ${index}    Open Connection    ${host}    port=${port}    timeout=10    
  
        Login    dcuser     Dcuser%12
        Set Client Configuration    prompt=eniqs[eniq_stats] {dcuser} #:    timeout=10
        Write    cd /eniq/home/dcuser
        Read    delay=5s
        Write    echo -e "select TOP 1 DATE_ID from DC_E_FFAXW_KPI\\n${run}\\n" | isql -P Dc12# -U Dc -S dwhdb -b
        ${output3}=    Read Until Prompt
        ${output3}    tp.ffaxw_date    ${output3}
        
        Write    echo -e "select TOP 61 pmBranchDeltaSir from DC_E_RBSG2_CARRIER_V_DAY\\nwhere DATE_ID='${output3}'\\n\\n${run}\\n" | isql -P Dc12# -U Dc -S dwhdb -b
        ${output2}=    Read Until Prompt
        Write    echo -e "select pmBranchDeltaSir_Samples_SD_SD,pmBranchDeltaSir_Samples_MEAN,pmBranchDeltaSir_Samples_MEAN_MEAN from DC_E_FFAXW_KPI\\n${run}\\n" | isql -P Dc12# -U Dc -S dwhdb -b
            ${output4}=    Read Until Prompt
            ${output4} =  Split String    ${output4}     
            Log    ${\n}Standard Deviation=${output4}[0]${\n}Mean=${output4}[1]${\n}Mean_Mean=${output4}[2]
            ${ffaxw}    set variable    True
            ${out}    tp.ffaxw    ${ffaxw}    ${output2}
            ${Status_ffaxw}    tp.ffaxw_comapare    ${output4}    ${out}    
            IF    '${Status_ffaxw}' == 'True'
                Log    "validated calculated values from RBSG2 with FFAXW" 
            ELSE
                Fail
            END

TP - ENIQ_TP_UG_TC199 Verify the calucalations ffax
	    Skip If    '${package}' != 'DC_E_FFAX'    Skipping the execution since this testcase is not applicable for ${package}
		Set Client Configuration    prompt=eniqs[eniq_stats] {dcuser} #:    timeout=10
		Write    cd /eniq/home/dcuser
		Read    delay=5s
		Write    echo -e "select distinct ERBS from DC_E_ERBS_SECTORCARRIER_V_day\\n${run}\\n" | isql -P Dc12# -U Dc -S dwhdb -b
			${output3}=    Read Until Prompt
			${output3}    tp.Ffaxw Date    ${output3}
			${pm}    Set Variable    pmBranchDeltaSinrDistr
			${output3}    Split String    ${output3}    \r
			FOR    ${element}    IN    @{output3}
				${element}    Strip String    ${element}
				FOR    ${counter}    IN RANGE    0    7    1
					Log    ${counter}
					Write    echo -e "select ${pm}${counter} from DC_E_ERBS_SECTORCARRIER_V_day where ERBS = '${element}'\\n${run}\\n" | isql -P Dc12# -U Dc -S dwhdb -b
					${output}=    Read Until Prompt
					${ffaxw}    Set Variable    False
					${out}    tp.ffaxw    ${ffaxw}    ${output}
					Write    echo -e "select ${pm}${counter}_Samples_SD_SD,${pm}${counter}_Samples_MEAN,${pm}${counter}_Samples_MEAN_MEAN from DC_E_FFAX_KPI where ERBS='${element}'\\n${run}\\n" | isql -P Dc12# -U Dc -S dwhdb -b
					${output3}=    Read Until Prompt
					${output4} =  Split String    ${output3}     
					Log    ${\n}Standard Deviation=${output4}[0]${\n}Mean=${output4}[1]${\n}Mean_Mean=${output4}[2]
					${Status_ffaxw}    tp.ffaxw_comapare    ${output4}    ${out}    
					IF    '${Status_ffaxw}' == 'True'
						Log    "validated calculated values from ERBS with FFAX" 
					ELSE
						Run Keyword And Continue On Failure    Fail    "Mismatch of values in ${pm}${counter}"
					END
				END
			END

TP - ENIQ_TP_UG_TC201 Verify the BSC_NODE_NAME
        Skip If    '${package}' != 'DC_E_NETOP'    Skipping the execution since this testcase is not applicable for ${package}
		Set Client Configuration    prompt=eniqs[eniq_stats] {dcuser} #:    timeout=300
		Write    cd /eniq/home/dcuser
		Read    delay=5s
		${bar}    Set Variable    cd /ericsson/pmic1/pm_storage/NCS_ASCII
		${mrr}    Set Variable    cd /ericsson/pmic1/pm_storage/MRR_ASCII

		Write    echo -e "select BASETABLENAME from MeasurementTable WHERE MTABLEID like'%DC_E_NETOP%'\\n${run}\\n" | isql -P ${password_db} -U ${username} -S ${database} -b
			${output3}=    Read Until Prompt
			${output3}    tp.ffaxw Date    ${output3}
			${output3} =  Split String    ${output3}
			FOR    ${element_table}    IN    @{output3}
				Log    ${element_table}
				${contains}=  Evaluate   "BAR" in """${element_table}"""
				${contains_mrr}=  Evaluate   "MRR" in """${element_table}"""
				IF    ${contains}
					${local_bsc_node}    Execute Command    ${bar} && ls
					${local_bsc_node}    Split Command Line    ${local_bsc_node}
				END
				${length}    Get Length    ${local_bsc_node}
				IF    ${length}==0
					Fail    Data is not loaded for netop 
				END
				IF    ${contains_mrr}
					${local_bsc_node}    Execute Command    ${mrr} && ls
					${local_bsc_node}    Split Command Line    ${local_bsc_node}
				END
				FOR    ${element}    IN    @{local_bsc_node}
						IF    ${contains}
							
							${start_pm}    Execute Command    ${bar}/${element} && ls
						END
						IF    ${contains_mrr}
							${start_pm}    Execute Command    ${mrr}/${element} && ls 
						END

						${file_id}=    Split String    ${start_pm}    \n       
						FOR    ${element}    IN    @{file_id}
							${contains_mecontext}=  Evaluate   "MeContext" in """${element}"""
							${contains_managed_element}=  Evaluate   "ManagedElement" in """${element}"""
							IF    '${contains_mecontext}' == 'True' and '${contains_managed_element}' == 'True'
								${file_ids}=    Split String    ${element}    ,
								${me_context_index}    ${managed}    tp.netop_index    ${file_ids}
								${bsc_node_ME}    ${node_file_name}=    Split String    ${file_ids[${me_context_index}]}    =
								${managed_file_id}    ${file_id_name}=    Split String    ${file_ids[${managed}]}    _  
							END    
							IF    '${contains_mecontext}' == 'True' and '${contains_managed_element}' == 'False'
								${file_ids}=    Split String    ${element}    ,
								${bsc_node_ME}    ${node_file_name}=    Split String    ${file_ids[-1]}    = 
								${node_file_name}    ${file_id_name}=    Split String    ${node_file_name}    _
							END
							IF    '${contains_mecontext}' == 'False' and '${contains_managed_element}' == 'True'
								${file_ids}=    Split String    ${element}    ,
								${managed_file_id}    ${file_id}=    Split String    ${file_ids[-1]}    =
								${node_file_name}    ${file_id_name}=    Split String    ${file_id}    _ 
							END
							IF    '${contains_mecontext}' == 'False' and '${contains_managed_element}' == 'False'
								${network_element}=  Evaluate   "NetworkElement" in """${element}"""
								${file_ids}=    Split String    ${element}    ,
								${managed_file_id}    ${file_id}=    Split String    ${file_ids[-1]}    =
								${node_file_name}    ${file_id_name}=    Split String    ${file_id}    _ 
							END
							Write    echo -e "select BSC_Node_Name from ${element_table} where FILE_ID='${file_id_name}' and BSC_Node_Name ='${node_file_name}'\\n${run}\\n" | isql -P Dc12# -U Dc -S dwhdb -b
							${output3}=    Read Until Prompt
							${bsc_node_name}    tp.ffaxw Date    ${output3}
							${bsc_node_status}    Evaluate    '${node_file_name}' in '''${bsc_node_name}'''
							IF    '${bsc_node_status}' == 'False'
								Fail    Bsc_node_name not matched for ${element_table}  
						END
					END
				END          
			END
#####Bharathi Code End #####

######Shubham Code Start#########
TP - ENIQ_TP_UG_TC205 CNAXE_SPECIFIC
    Skip If    '${package}' != 'DC_E_CNAXE'    Skipping this TestCase Execution Since it is not applicable for ${package} 
    Set Client Configuration    prompt=eniqs[eniq_stats] {dcuser} #:    timeout=3600
    Write    cd /eniq/home/dcuser
    Read    delay=5s
   
    
    Write    echo -e "Select distinct NE_FDN from DIM_E_CN_AXE where SOURCE_TYPE= 'ISBladeHybrid' or SOURCE_TYPE= 'BSPHybrid'\\n${run}\\n" | isql -P ${password_dwhdb} -U ${username_dwhdb} -S ${database_dwhdb} -w 200 -b
    ${fdn}=    Read Until Prompt    strip_prompt=True
    ${fdn2}=    Split String    ${fdn}    \n
    
    Remove From List    ${fdn2}    -1
    Remove From List    ${fdn2}    -1
    Remove From List    ${fdn2}    -1
    
    FOR    ${m}    IN    @{fdn2}
        ${m}    Strip String   ${m}

       
        Write    echo -e "Select distinct TARGET_NE,OSS_ID,TARGET_FDN,SOURCE_TYPE from DIM_E_CN_MSCCLMF_AS where TARGET_FDN='${m}' \\n${run}\\n" | isql -P ${password_dwhdb} -U ${username_dwhdb} -S ${database_dwhdb} -b
        ${topo}=    Read Until Prompt    strip_prompt=True   
        ${topo}    Split String    ${topo} 

        Write    echo -e "select BLADE_NAME,OSS_ID,NE_FDN,SOURCE_TYPE from DIM_E_CN_AXE WHERE NE_FDN='${m}'\\n${run}\\n" | isql -P ${password_dwhdb} -U ${username_dwhdb} -S ${database_dwhdb} -b
        ${topo2}=    Read Until Prompt    strip_prompt=True
        ${topo2}    Split String    ${topo2}
            
        IF    '''${topo}''' == '''${topo2}'''
            Log   ${\n}Blade Details are equal for this FDN= ${m}.
        ELSE
            Run Keyword And Continue On Failure    Fail    ${\n}Blade Details are not equal for this FDN= ${m}. 
        END

    END
    Write    echo -e "select basetablename from MeasurementTable where MTABLEID LIKE '${package}:(%' and (TABLELEVEL= 'raw')\\n${run}\\n" | isql -P ${password_db} -U ${username} -S ${database} -b
	${output1}=    Read Until Prompt    strip_prompt=True
    ${Raw_Table}    Split String    ${output1}    \n
    Remove From List    ${Raw_Table}    -1
    Remove From List    ${Raw_Table}    -1
    Remove From List    ${Raw_Table}    -1

    FOR    ${i}    IN    @{Raw_Table}
        ${k}    Strip String    ${i}
        
        Write    echo -e "Select distinct substr(ELEM,charindex(',',elem)+1),OSS_ID,DC_RELEASE from ${k} where DATE_ID='${date}' and ELEM like '%,%'\\n${run}\\n" | isql -P ${password_dwhdb} -U ${username_dwhdb} -S ${database_dwhdb} -w 300 -b
        ${output5}=    Read Until Prompt    strip_prompt=True
        ${output5}    Split String    ${output5}    \n   
        Remove From List    ${output5}    -1
        Remove From List    ${output5}    -1
        Remove From List    ${output5}    -1
       
        Write    echo -e "select distinct STATISTICS_TYPE,OSS_ID,DC_RELEASE from ${k} where DC_RELEASE != '' and STATISTICS_TYPE != ''\\n${run}\\n" | isql -P ${password_dwhdb} -U ${username_dwhdb} -S ${database_dwhdb} -w 300 -b
        ${output6}=    Read Until Prompt    strip_prompt=True
        ${output6}    Split String    ${output6}    \n
        Remove From List    ${output6}    -1
        Remove From List    ${output6}    -1
        Remove From List    ${output6}    -1
        IF    ${output6} != []
            Append To List    ${output5}    ${output6}[0]
        ELSE
            Run Keyword And Continue On Failure    Fail    ${\n}Values that are not present:-
        END
        
        ${PM}=    Create List
        FOR    ${i}    IN    @{output5}
            ${J}=    Replace String    ${i}    ${SPACE}    ${EMPTY}
            
            Append To List    ${PM}    ${J}
        END
        Write    echo -e "Select distinct substr(NE_ID,charindex(',',ne_id)+1),OSS_ID,NE_VERSION from DIM_E_CN_AXE where ne_id like '%,%' and BLADE_NAME != '' and SOURCE_TYPE= 'ISBladeHybrid' or BLADE_NAME != '' and SOURCE_TYPE= 'BSPHybrid'\\n${run}\\n" | isql -P ${password_dwhdb} -U ${username_dwhdb} -S ${database_dwhdb} -w 300 -b
        ${output2}=    Read Until Prompt    strip_prompt=True
        ${output2}    Split String    ${output2}    \n 
        
        Remove From List    ${output2}    -1
        Remove From List    ${output2}    -1
        Remove From List    ${output2}    -1
        ${TOPO}=    Create List
        FOR    ${k}    IN    @{output2}
            ${m}=    Replace String    ${k}    ${SPACE}    ${EMPTY}
            Append To List    ${TOPO}    ${m}
        END
        ${status}    ${message}    Topo Val Not In List    ${PM}    ${TOPO}    
        IF    ${status}
            Log    ${\n}${message}
        ELSE
            Run Keyword And Continue On Failure    Fail    ${\n}Values that are not present in PM are:-
            Log    ${\n}${message}
        END
    END
######Shubham Code END#########
TP - ENIQ_TP_UG_TC184 verify the Mecontext, ManagedElement and subnetwork Loading
    Skip If    '${package}' != 'DC_E_BULK_CM'    Skipping this TestCase Execution Since it is not applicable for ${package}
    Set Client Configuration    prompt=eniqs[eniq_stats] {dcuser} #:    timeout=3600
    Write    cd /eniq/home/dcuser
    Read    delay=10s
    
    Write    echo -e "Select Top 1 dataname from Measurementkey where typeid like '${package}:%' and iselement like'1' and uniquekey like '1'\\n${run}\\n" | isql -P ${password_db} -U ${username} -S ${database} -b
	${output}=    Read Until Prompt    
    ${node}=    filter name    ${output}
    Write    echo -e "select top 1 basetablename from MeasurementTable where MTABLEID LIKE '${package}:(%' and (TABLELEVEL= 'raw')\\n${run}\\n" | isql -P ${password_db} -U ${username} -S ${database} -b
	${output1}=    Read Until Prompt     
	${table}=    Filter Name    ${output1}
	Write    echo -e "select distinct ${node} from ${table} where datetime_id = '${date} 10:00:00'\\n${run}\\n" | isql -P Dc12# -U Dc -S dwhdb -b
	${output2}=    Read Until Prompt    
	${node_name}=    filter name    ${output2}
    #Write    rm -rf BT-FT_Log ; rm -rf BT-FT_Script
    #Read Until Prompt
    Open nexus tpkpiscript
   # ${btft_link}=    Get Element Attribute    //a[contains(text(),'BT-FT')]    href
    ${btft_link}=    Get Element Attribute    (//a[contains(text(),'BT-FT_Script')])[last()-1]    href
    ${btft_script}=    Fetch From Right    ${btft_link}    /
	# Open Connection    ${jnkns_server}
    # Login               root        shroot
    # Write    rm -rf tppkg ; mkdir tppkg ; cd tppkg ; wget ${btft_link} ; pwd
    # Read    delay=20s
    # Switch Connection    ${index}
    #Put File    /root/tppkg/${btft_script}    /eniq/home/dcuser
    #Write    cd /eniq/home/dcuser ; unzip -o ${btft_script} ; cd BT-FT_Script/ ; chmod 777 *
    #Read Until Prompt
    #changing bt ft file    ${host}    ${port}    ${uname}    ${pwd}
    Write    cd /eniq/home/dcuser/BT-FT_Script/ ; echo -e "${full_pkg_name}\\n17\\n${date} 10:00:00\\n${node}\\n${node_name}\\nNE_NAME" |./BT-FT_script.sh    
    ${Execute}=    Read Until Prompt
    ${status}=    BT_FT_validation_For_Aggregation    ${Execute}
    IF    ${status} == False
        Fail   ${\n}${Execute}
    END
TP - ENIQ_TP_UG_TC189,TP - ENIQ_TP_UG_TC178,TP - ENIQ_TP_UG_TC179 Verify the Flex RAW Tables 
    Skip If    '${package}' != 'DC_E_ERBS'    Skipping this TestCase Execution Since it is not applicable for ${package}
    Set Client Configuration    prompt=eniqs[eniq_stats] {dcuser} #:    timeout=3600
    Write    cd /eniq/home/dcuser
    Read    delay=10s
    
    Write    echo -e "Select Top 1 dataname from Measurementkey where typeid like '${package}:%' and iselement like'1' and uniquekey like '1'\\n${run}\\n" | isql -P ${password_db} -U ${username} -S ${database} -b
	${output}=    Read Until Prompt    
    ${node}=    filter name    ${output}
    Write    echo -e "select top 1 basetablename from MeasurementTable where MTABLEID LIKE '${package}:(%' and (TABLELEVEL= 'raw')\\n${run}\\n" | isql -P ${password_db} -U ${username} -S ${database} -b
	${output1}=    Read Until Prompt     
	${table}=    Filter Name    ${output1}
	Write    echo -e "select distinct ${node} from ${table} where datetime_id = '${date} 10:00:00'\\n${run}\\n" | isql -P Dc12# -U Dc -S dwhdb -b
	${output2}=    Read Until Prompt    
	${node_name}=    filter name    ${output2}
    #Write    rm -rf BT-FT_Log ; rm -rf BT-FT_Script
    #Read Until Prompt
    Open nexus tpkpiscript
   # ${btft_link}=    Get Element Attribute    //a[contains(text(),'BT-FT')]    href
    ${btft_link}=    Get Element Attribute    (//a[contains(text(),'BT-FT_Script')])[last()-1]    href
    ${btft_script}=    Fetch From Right    ${btft_link}    /
	# Open Connection    ${jnkns_server}
    # Login               root        shroot
    # Write    rm -rf tppkg ; mkdir tppkg ; cd tppkg ; wget ${btft_link} ; pwd
    # Read    delay=20s
    # Switch Connection    ${index}
    #Put File    /root/tppkg/${btft_script}    /eniq/home/dcuser
    #Write    cd /eniq/home/dcuser ; unzip -o ${btft_script} ; cd BT-FT_Script/ ; chmod 777 *
    #Read Until Prompt
    #changing bt ft file    ${host}    ${port}    ${uname}    ${pwd}
    Write    cd /eniq/home/dcuser/BT-FT_Script/ ; echo -e "${full_pkg_name}\\n16\\n${date} 10:00:00\\n${node}\\n${node_name}\\nNE_NAME" |./BT-FT_script.sh    
    ${Execute}=    Read Until Prompt
    ${status}=    BT_FT_validation_For_Aggregation    ${Execute}
    IF    ${status} == False
        Fail   ${\n}${Execute}
    END

*** Keywords ***
TP - ENIQ_TP_UG_TC31 Verify the latest dim TP in Adminui
    Write    cd 
    Read    delay=10s
    Set Client Configuration    prompt=eniqs[eniq_stats] {dcuser} #:    timeout=3600

    FOR    ${dim_pkg}    IN    @{dep_pkg_list} 
        Set Global Variable    ${dim_pkg}       
        #Open clearcasevobs
        # ${rstate}    Get Text    //table//a[text()='${dim_pkg}']/../following-sibling::td[3]
        # ${temp}=    Get Element Attribute    //table//a[text()='${dim_pkg}']    href
        # ${temp1}=    Fetch From Right    ${temp}    /
        # Set Global Variable    ${full_pkg_name}    ${temp1}
        # Open connection as root user
        # Set Client Configuration    prompt=eniqs[eniq_stats] {root} #:    timeout=3600	
        Set Client Configuration    prompt=eniqs[eniq_stats] {dcuser} #:    timeout=3600
        ${latest_mws_path}=   Execute Command    cd ${mws_path};ls -t Features_* | head -n 1
        ${latest_mws_path}    Split String    ${latest_mws_path}    :
        Set Global Variable    ${latest_mws_path}
        # Write    cd ${mws_path}
        # Write    cd ${latest_mws_path}[0]/eniq_techpacks
        # Write    ls
        ${full_dim_pkg_name}=   Execute Command    cd ${mws_path}/${latest_mws_path}[0]/eniq_techpacks;ls -Art ${dim_pkg}*.tpi | tail -n 1
        # Write    ls
        Log    ${full_dim_pkg_name}
        Set Global Variable     ${full_dim_pkg_name}
        ${rstate}    Split String    ${full_dim_pkg_name}    ${dim_pkg}_
        ${rstate}    Split String    ${rstate}[1]    _
        Log    ${rstate}[0]
        Sleep    300s
        Open Connection And Log In 
        #Write    su - dcuser
        # Read    delay=10s
        Write    cd /eniq/home/dcuser
        Read    delay=10s
        Set Client Configuration    prompt=eniqs[eniq_stats] {dcuser} #:    timeout=3600
        Write    echo -e "select TOP 1 TECHPACK_VERSION from Versioning where TECHPACK_NAME = '${dim_pkg}' ORDER BY TECHPACK_VERSION Desc\\n${run}\\n" | isql -P ${password_db} -U ${username} -S ${database} -b
        ${output1}=    Read Until Prompt
        ${rstate_adminui}=    tp.Filter Name    ${output1}
       # IF    '${rstate}' != '${rstate_adminui}'
        IF    '${rstate}[0]' != '${rstate_adminui}'
            # Open connection as root user
            # Set Client Configuration    prompt=eniqs[eniq_stats] {root} #:    timeout=300
            # Write    cd ${mws_path}
            # ${transfer}    Read    delay=10s
            # Write    ls
            # ${transfer}    Read    delay=10s
            Set Client Configuration    prompt=eniqs[eniq_stats] {dcuser} #:    timeout=3600
            Write    cd ${mws_path}
            Write    cd ${latest_mws_path}[0]/eniq_techpacks
            Write    ls
            Write    scp -r ${full_dim_pkg_name} /eniq/sw/installer
            ${transfer}    Read    delay=10s
            # Go To    ${solarisLink}
            # ${currentpkg}=    Get Element Attribute     xpath=//a[text()='${dim_pkg}']    href
            # Open Connection    ${jnkns_server}
            # Login               root        shroot
            # Write    rm -rf tppkg ; mkdir tppkg ; cd tppkg ; wget ${currentpkg} ; pwd
            # Read    delay=10s
            # Switch Connection    ${index}
            Set Global Variable     ${latest_TP_found}    True 
            TP - ENIQ_TP_UG_TC32,TP - ENIQ_TP_UG_TC33,TP - ENIQ_TP_UG_TC34 Installing latest TP
            TP - ENIQ_TP_UG_TC35 verifying TP Installation
            TP - ENIQ_TP_UG_TC36 Verify TP installer Log 
             
        ELSE
            Log    Latest Dim Tp already installed
        END     
    END
TP - ENIQ_TP_UG_TC32,TP - ENIQ_TP_UG_TC33,TP - ENIQ_TP_UG_TC34 Installing latest TP
    Write    cd 
    Read    delay=10s
    IF    '${latest_TP_found}' == 'True'
        Open Connection And Log In
        Set Client Configuration    prompt=eniqs[eniq_stats] {dcuser} #:    timeout=3600
       # Put File    ${path_of_pkg_on_jenkins}/tppkg/${full_pkg_name}    /eniq/sw/installer
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
    Set Client Configuration    prompt=eniqs[eniq_stats] {dcuser} #:    timeout=3600
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
        Open Connection And Log In
        Write    cd 
        Read    delay=10s
        Set Client Configuration    prompt=eniqs[eniq_stats] {dcuser} #:    timeout=3600
        Write    echo -e "select RSTATE from DataInterface where INTERFACENAME LIKE '${intf_name}'\\n${run}\\n" | isql -P ${password_db} -U ${username} -S ${database} -b
        ${output1}=    Read Until Prompt
        ${new_rstate_inDB}=    Filter Name    ${output1}
        Sleep    200s
        Set Client Configuration    prompt=eniqs[eniq_stats] {dcuser} #:    timeout=3600
        Write    echo -e "select INTERFACEVERSION from DataInterface where INTERFACENAME LIKE '${intf_name}'\\n${run}\\n" | isql -P ${password_db} -U ${username} -S ${database} -b
        ${output2}=    Read Until Prompt 
        ${temp}=    Filter Name    ${output2}
        ${temp1}=    Give Build Number    ${temp}
        ${full_intf_deta}=    Catenate    SEPARATOR=_    ${intf_name}    ${new_rstate_inDB}    b${temp1}.tpi
		# Open clearcasevobs
		# ${temp}=    Get Element Attribute    //table//a[text()='${intf_name}']    href
        # ${temp1}=    Fetch From Right    ${temp}    /
        # Open connection as root user
        # Set Client Configuration    prompt=eniqs[eniq_stats] {root} #:    timeout=3600
        Set Client Configuration    prompt=eniqs[eniq_stats] {dcuser} #:    timeout=3600
        Write    cd ${mws_path}
        Write    cd ${latest_mws_path}[0]/eniq_techpacks
        Write    ls    
        ${temp2}=   Execute Command    cd ${mws_path}/${latest_mws_path}[0]/eniq_techpacks;ls -Art ${intf_name}_R*.tpi | tail -n 1
        # Write    ls
        Log    ${temp2}
		IF    '${temp2}' != '${full_intf_deta}'
		Log    ${\n}Rstate not equal
        Append To List    ${Interfaces_to_update}    ${intf_name}
		# Downloading TP from vobs    ${pkg}[0]
		# Installing TP    ${pkg}[0]
		ELSE
			Log   ${\n}Rstate of ${temp1} in both places are equal
		END
		# Execute Command    cd /eniq/sw/installer ; ./activate_interface -o eniq_oss_1 -t ${intf_name}
	END
    Set Global Variable    ${Interfaces_to_update}

TP - ENIQ_TP_UG_TC39,TP - ENIQ_TP_UG_TC40,TP - ENIQ_TP_UG_TC41 Installing dependent interfaces
    Write    cd 
    Read    delay=10s
    Set Client Configuration    prompt=eniqs[eniq_stats] {dcuser} #:    timeout=3600
    ${res}    Evaluate    bool(${Interfaces_to_update})
    IF    '${res}'=='True'       
    FOR    ${element}    IN    @{Interfaces_to_update}
        # Open connection as root user
        # Set Client Configuration    prompt=eniqs[eniq_stats] {root} #:    timeout=3600
        Set Client Configuration    prompt=eniqs[eniq_stats] {dcuser} #:    timeout=3600
        Write    cd ${mws_path}
        Write    cd ${latest_mws_path}[0]/eniq_techpacks
        Write    ls
        Write    scp -r ${element} /eniq/sw/installer
        ${transfer}    Read    delay=10s
        Open Connection And Log In
        # Read    delay=10s
        Write    cd /eniq/home/dcuser
        Read    delay=10s
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
    ELSE
            Log     All Interfaces installed are latest.${\n}Proceeding with interfaces activation.
    END
TP - ENIQ_TP_UG_TC42 Activating Interface
    Write    cd 
    Read    delay=10s
    Open Connection And Log In
    Set Client Configuration    prompt=eniqs[eniq_stats] {dcuser} #:    timeout=4800
    Write    cd /eniq/sw/installer ; rm -rf tp_stage_file ; rm -rf install_lockfile 
    Read Until Prompt
    Write    cd /eniq/sw/installer ; ./activate_interface -o eniq_oss_1 -t ${dim_pkg}
    ${out}=     Read Until Prompt
TC 10 Verify Interface Activation
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
    
Verify Interface installer Log
    Write    cd 
    Read    delay=2s
    Set Client Configuration    prompt=eniqs[eniq_stats] {dcuser} #:    timeout=3600
    ${res}    Evaluate    bool(${Interfaces_to_update})
    IF    '${res}'=='True'
    FOR    ${element}    IN    @{Interfaces_to_update}
        ${currentpkg}=    Get Element Attribute     xpath=//a[text()='${element}']    href
        ${temp1}=    Fetch From Right    ${currentpkg}    /
        ${fail}=    Checking Log Of Dim Intf    ${temp1}    ${host}    ${port}    ${uname}    ${pwd}
        IF    '${fail}' == 'fail'
            Fail
        END
    END
    ELSE
            Log     All Interfaces installed are latest.
    END
TP - ENIQ_TP_UG_TC45 Download Latest Epfg
    Write    cd 
    Read    delay=10s
    Set Client Configuration    prompt=eniqs[eniq_stats] {dcuser} #:    timeout=3600
    Open clearcasevobs
    ${epfgpkgtmp}=    Get Element Attribute    //a[contains(text(),'epfg_ft')]    href
    ${epfgpkg}=    Fetch From Right    ${epfgpkgtmp}    /
    Set Global Variable    ${epfgpkg}    ${epfgpkg}
    ${epfgrstate}=    Fetch From Right    ${epfgpkg}    _
    ${epfgrstate}=    Catenate    SEPARATOR=    epfg_    ${epfgrstate}
    Set Global Variable    ${epfgrstate}    ${epfgrstate}
    Log    ${index}
    Open Connection    ${jnkns_server}
    Login               root        shroot
    Write    rm -rf tppkg ; mkdir tppkg ; cd tppkg ; wget ${epfgpkgtmp} ; pwd
    Read    delay=100s
    Switch Connection    ${index}
TP - ENIQ_TP_UG_TC46 Install Epfg
    Write    cd 
    Read    delay=10s
    Set Client Configuration    prompt=eniqs[eniq_stats] {dcuser} #:    timeout=300
    Put File    /root/tppkg/${epfgpkg}     /eniq/home/dcuser
    Write    cd /eniq/home/dcuser ; rm -rf epfg ; unzip -o ${epfgpkg} ; unzip -o ${epfgrstate} ; cd epfg ; chmod -R 777 * .* ; ./epfg_preconfig_for_ft.sh 
    Read Until Prompt

TP - ENIQ_TP_UG_TC44 Setting Loader Configuration To Finest
    Write    cd 
    Read    delay=10s
    Set Client Configuration    prompt=eniqs[eniq_stats] {dcuser} #:    timeout=3600
    Write    echo -e "select INTERFACENAME from InterfaceTechpacks where TECHPACKNAME='${dim_pkg}'\\n${run}\\n" | isql -P ${password_db} -U ${username} -S ${database} -b
    ${output1}=    Read Until Prompt
    ${dep_int}=    Filter Interfaces    ${output1}
    Filter Intf Name    ${dim_pkg}    ${output1}    ${host}    ${uname}    ${pwd}
TP - ENIQ_TP_UG_TC79 Generating Topology files
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

TP - ENIQ_TP_UG_TC48,TP - ENIQ_TP_UG_TC54 Loading Topology Files
    Write    cd /eniq/home/dcuser
    Read    delay=10s
    Set Client Configuration    prompt=eniqs[eniq_stats] {dcuser} #:    timeout=300
    Write    echo -e "select INTERFACENAME from InterfaceTechpacks where TECHPACKNAME like( select distinct TECHPACKNAME from TechPackDependency where VERSIONID LIKE '${package}:%'and TECHPACKNAME like 'DIM_%');\\n${run}\\n" | isql -P ${password_db} -U ${username} -S ${database} -b
    ${output1}=    Read Until Prompt
	@{intfDIM}    Filter Interfaces    ${output1}
	#@{intfDIM}=    Create List    DIM_E_LTE    DIM_E_UTRAN
	FOR    ${currintf}    IN    @{intfDIM}
        Write    echo -e "select DATAFORMATTYPE from DataInterface where INTERFACENAME LIKE '${currintf}'\\n${run}\\n" | isql -P ${password_db} -U ${username} -S ${database} -b
	    ${par}    Read Until Prompt
	    ${parser_name}    Filter Name    ${par} 
        Write    engine -e startSet '${currintf}-eniq_oss_1' 'Adapter_${currintf}_${parser_name}'
        ${out}=    Read Until Prompt
	    Should Contain    ${out}    Start set requested successfully    Failed starting Adapter set for ${currintf}-eniq_oss_1
	END
    Log    ${\n}Adapter Set Successfully Started
TP - ENIQ_TP_UG_TC49,TP - ENIQ_TP_UG_TC54 Loading Topo checking
    Write    cd 
    Read    delay=10s
    ${res}=    Loading Topo Check    ${dim_pkg}    ${host}    ${port}    ${uname}    ${pwd}
    IF    '${res}' == 'false'
        Fail

    END
TP - ENIQ_TP_UG_TC51 Verify All Loader Tables
    Write    cd 
    Read    delay=10s
    Set Client Configuration    prompt=eniqs[eniq_stats] {dcuser} #:    timeout=3600
    Write    rm -rf BT-FT_Log ; rm -rf BT-FT_Script
    Read Until Prompt
    Open nexus tpkpiscript
    #${btft_link}=    Get Element Attribute    //a[contains(text(),'BT-FT')]    href
    ${btft_link}=    Get Element Attribute    (//a[contains(text(),'BT-FT_Script')])[last()-1]    href                                           
    ${btft_script}=    Fetch From Right    ${btft_link}    /
    Replace String    ${dim_pkg}    DIM_E_    ${EMPTY}
    ${tp}=    Replace String    ${dim_pkg}    DIM_E_    ${EMPTY}
    ${tp_lower_case}=    Convert To Lowercase    ${tp}
    @{temp}=    Split String From Right    ${full_dim_pkg_name}    separator=_R    max_split=1
    @{r_temp}=    Split String From Right    ${temp}[1]    separator=_
    @{b_temp}=    Split String From Right    ${r_temp}[1]    separator=.
    ${b}=    Remove String    ${b_temp}[0]    b
    IF    '${dim_pkg}' == 'DIM_E_SHARED_CNF'
        ${mod_file_link}    Set Variable    https://arm1s11-eiffel013.eiffel.gic.ericsson.se:8443/nexus/content/repositories/releases/com/ericsson/eniq/stats/tp/${tp}_TOP/${tp}_top_etl/FD/R${r_temp}[0]/${dim_pkg}_${b}/${dim_pkg}_${b}_R${r_temp}[0]_SetsModifications_TPC.xml
    ELSE
        ${mod_file_link}    Set Variable    https://arm1s11-eiffel013.eiffel.gic.ericsson.se:8443/nexus/content/repositories/releases/com/ericsson/eniq/stats/tp/${tp}_TOP/${tp_lower_case}_top_etl/FD/R${r_temp}[0]/${dim_pkg}_${b}/${dim_pkg}_${b}_R${r_temp}[0]_SetsModifications_TPC.xml
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
        Log    man mod tc is passing
    END
        Fail
    END
    IF    ${res_mod} == False
        Fail
    END
