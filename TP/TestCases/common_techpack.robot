*** Settings ***
Library    RPA.Browser.Selenium
Library    OperatingSystem
Library    RPA.FileSystem
Library		SSHLibrary
Library    Collections
Library     ../Resources/tp.py
Resource     ../Resources/login.resource
Library    String
Test Setup        Open Connection And Log In
Test Teardown     Close All Connections
#Resource    ./login.resource
*** Variables ***
${host}    atvts4134.athtem.eei.ericsson.se
${port}    2251
${uname}     dcuser
${pwd}       Dcuser%12
${package}    DC_E_HSS
${clearcase}    https://clearcase-eniq.seli.wh.rnd.internal.ericsson.com/eniqdel
${sql_query_for_dependnt_intf_on_tp}    select INTERFACENAME from InterfaceDependency where TECHPACKNAME= '${package}'
${password_db}      Dwhrep12#
${username}      dwhrep
${database}      repdb
${run}		go
${path}    H:
${full_pkg_name}	DC_E_HSS_R25B_b228.tpi
*** Tasks *** 
FT 
    Test
    #Get pkg Name
	#Placing topo files in respective indir
	#Loading topo files for dc techpack
	# ${file_exist}	Does File Exist    /root/sa/${package}*.tpi
	# IF  ${file_exist}
	# 	Log To Console	${\n}Skipping download as ${package} is already present in directory.
	# END
	# IF  not ${file_exist}
	# 	Log to console	${\n}TechPack not present, downloading now.....
    #     Downloading techpack
    #     Log To Console    ${\n}Techpack downloaded
	# END
	# Place the package on the server
	# Installing TechPack    
	# Verifying TP installation with tp_installer & engine log files
    #Editing Engine.properties file
	# Data Format not found verification in engine logs
    # Fetch Rstate of Interface from AdminUI and Clearcase
    #Generate PM Files without Suspected data
	#Generate PM Files with Suspected data
    #Starting Adapter Set for Interfaces
	#Starting Aggregation
	#Running BTFT
	#Get date
	#Downloading And Installing BT-Ft
	#Verify Key Loading chechk
	#Verify delta table Loading
	#Afg sepcific testcase
    #Busy Hour Configuration

*** Keywords ***
Test
    Set Client Configuration    prompt=eniqs[eniq_stats] {root} #:    timeout=300
    Write    cd /eniq/home/dcuser
    Read    delay=10s
	
Open Connection And Log In
    ${index}    Open Connection    ${host}      port=${port}    timeout=10
    Set Global Variable    ${index}
    Login    ${uname}        ${pwd}

Placing topo files in respective indir
    Put File    ${path}/ENIQ_TC_Automation/TP/Resources/epfg_topo_for_dc.pl    /eniq/home/dcuser/
	Set Client Configuration    prompt=eniqs[eniq_stats] {dcuser} #:    timeout=3600
    Write    rm -rf TopologyFiles/
    Read Until Prompt
	    Put Directory    ${path}/ENIQ_TC_Automation/TP/Resources/TopologyFiles    /eniq/home/dcuser    recursive=True
    Write    test -d ${path}/ && echo "true"
    ${dir_exist}=    Read Until Prompt
    ${dir_exist}=    Return True False    ${dir_exist}
    IF    '${dir_exist}' == 'true'
        Write    mv ${path}/ENIQ_TC_Automation/TP/Resources/TopologyFiles . ; rm -rf ${path}/
        ${out}=    Read Until Prompt
    END
    Write     echo -e "${package}_R10A_b12.tpi" | perl epfg_topo_for_dc.pl 
    ${out1}=    Read Until Prompt

Loading topo files for dc techpack
    Set Client Configuration    prompt=eniqs[eniq_stats] {dcuser} #:    timeout=300
    Write    echo -e "select INTERFACENAME from InterfaceTechpacks where TECHPACKNAME like( select distinct TECHPACKNAME from TechPackDependency where VERSIONID LIKE '${package}:%'and TECHPACKNAME like 'DIM_%');\\n${run}\\n" | isql -P ${password_db} -U ${username} -S ${database} -b
    ${output1}=    Read Until Prompt
	@{intfDIM}    Filter Interfaces    ${output1}
	#@{intfDIM}=    Create List    DIM_E_LTE    DIM_E_UTRAN
	FOR    ${currintf}    IN    @{intfDIM}
        Write    echo -e "select DATAFORMATTYPE from DataInterface where INTERFACENAME LIKE '${currintf}'\\n${run}\\n" | isql -P ${password_db} -U ${username} -S ${database} -b
	    ${par}    Read Until Prompt
	    ${parser_name}    server.Filter Name    ${par} 
        Write    engine -e startSet '${currintf}-eniq_oss_1' 'Adapter_${currintf}_${parser_name}'
        ${out}=    Read Until Prompt
	    Should Contain    ${out}    Start set requested successfully    Failed starting Adapter set for ${currintf}-eniq_oss_1
	END
    Log To Console    ${\n}Adapter Set Successfully Started

Get pkg Name
    @{temp}=    Split String From Right    ${full_pkg_name}    separator=_R    max_split=1
    ${package}=    Set Variable    ${temp}[0]
    Set Global Variable    ${package}
Downloading techpack	
    Set Download Directory    /root/sa
    Open Available Browser    ${clearcase}    
    Click Link    xpath=//body//tr[last()-1]//td[2]//a   
    Click Link    xpath=//body//tr[last()-1]//td[2]//a   
    ${loc}    Get Location
    Go To    ${loc}SOLARIS_baseline.html
	${temp}=    Get Element Attribute    //table//a[text()='${package}']    href
    ${temp1}=    Fetch From Right    ${temp}    /
    Set Global Variable    ${full_pkg_name}    ${temp1}
    Click Link    xpath=//a[text()='${package}'] 
    OperatingSystem.Wait Until Created    /root/sa/${package}*.tpi
	
Place the package on the server
    ${downloaded_tp}		Tpi File Loc
	Log to Console		${\n}Downloaded TechPack is: ${downloaded_tp}
	${tp_exist}		Execute Command    test -f /eniq/sw/installer/${downloaded_tp} && echo True || echo False     
	IF 	${tp_exist}
	Log to console	${\n}TechPack Already present in Server.
	ELSE
	Log to console	${\n}TechPack not present, transferring.....
	Put File    /root/sa/${downloaded_tp}    /eniq/sw/installer
	END
	${tp_exist_in_server}		Execute Command    test -f /eniq/sw/installer/${downloaded_tp} && echo True || echo False     
	IF  ${tp_exist_in_server}
		Log To Console	${\n}${downloaded_tp} transferred to the FT server.
		OperatingSystem.Remove File    /root/sa/${downloaded_tp}
	ELSE
		Log to console	${\n}TechPack not transferred, Error occurred.
	END
	
Installing TechPack    
	Log To Console		${\n}TechPack Installation Started......
    # ${tp_installer_output}    Execute Command    cd /eniq/sw/installer && ./tp_installer -p . -t ${package}
	# log to console		${\n}${tp_installer_output}
	
Editing Engine.properties file
    Set Client Configuration    prompt=eniqs[eniq_stats] {dcuser} #:    timeout=300
	Write    echo -e "${sql_query_for_dependnt_intf_on_tp}\\n${run}\\n" | isql -P ${password_db} -U ${username} -S ${database} -b
    ${output1}=    Read until Prompt
	${name}   ${dep_int}     tp.Dependent pkg and intf  ${package}  ${output1}
    Set Global Variable    ${dep_int}
	Log to console  ${\n}Dependent names are: ${\n}${dep_int}
    setting to finest   ${name}
    log to console      ${\n}Changed the Dependent Interfaces value from INFO to FINEST.
    
Verifying TP installation with tp_installer & engine log files
	Log To Console    ${\n}TechPack Installation Verification started.....
	${out}    Engine Log Check    ${host}    ${port}    ${uname}    ${pwd}    ${package}
    IF	 ${out}
	Log to console		${\n}Verification Done. TechPack installed correctly.${\n}No keywords found in log files.
	ELSE
	Log to console 		${\n}Keywords found in Log files, check report.
	Fatal Error		Stopping the Test case execution
	END
	
Data Format not found verification in engine logs
	${engine_file_name}		Execute Command		cd /eniq/log/sw_log/engine/${package} && ls -Art *.log | tail -n 1
	Log to console		${\n}Engine file name: ${engine_file_name}
	${output}	${rc}=		Execute Command		cd /eniq/log/sw_log/engine/${package} && grep -i 'Data format not found' ./${engine_file_name}		return_rc=True
	IF		${rc}==0
	Log to console		${\n}Keyword found in engine log file${\n}${output}
	ELSE
	Log to console		${\n}*Data format not found* in Engine log file.
	END
Open clearcasevobs
    Open Available Browser    ${clearcase}     headless=true   
    Maximize Browser Window
    Click Link    //body//tr[last()-1]//td[2]//a
    Click Link    //body//tr[last()-1]//td[2]//a
    ${loc}    Get Location
    ${solarisLink}    Set Variable      ${loc}SOLARIS_baseline.html
    Set Global Variable    ${solarisLink}
    Go To    ${loc}SOLARIS_baseline.html
Fetch Rstate of Interface from AdminUI and Clearcase
    FOR    ${intf_name}    IN    @{dep_int}
		Open clearcasevobs
		${rstate_vobs}    Get Text    //table//a[text()='${intf_name}']/../following-sibling::td[3]
		Log To Console    ${\n}R-State of ${intf_name} in Clearcase is = ${rstate_vobs}
		Write    echo -e "select RSTATE from DataInterface where INTERFACENAME LIKE '${intf_name}'\\n${run}\\n" | isql -P ${password_db} -U ${username} -S ${database} -b
		${output1}=    Read    delay=3s
		${rstate_adminui}=   tp.Filter Name    ${output1}  
		Log To Console    ${\n}Rstate in AdminUI is= ${rstate_adminui}
		IF    '${rstate_vobs}' != '${rstate_adminui}'
		Log To Console    ${\n}Rstate not equal
		# Downloading TP from vobs    ${pkg}[0]
		# Installing TP    ${pkg}[0]
		ELSE
			Log To Console   ${\n}Rstate in both places are equal
		END
		# Execute Command    cd /eniq/sw/installer ; ./activate_interface -o eniq_oss_1 -t ${intf_name}
	END
Starting Adapter Set for Interfaces
    Set Client Configuration    prompt=eniqs[eniq_stats] {dcuser} #:
    Log To Console    ${\n}Starting Adapter Set
    FOR    ${intf_name}    IN    @{dep_int}		
		Write    echo -e "select DATAFORMATTYPE from DataInterface where INTERFACENAME LIKE '${intf_name}'\\n${run}\\n" | isql -P ${password_db} -U ${username} -S ${database} -b
		${par}    Read    delay=3s
		${parser_name}    Get Parser Value    ${par}
		${oss}    ${adapter}    Adapter Activate    ${intf_name}    ${parser_name}
		Write     engine -e startSet '${oss}' '${adapter}'
		${out}    Read Until Prompt    strip_prompt=True
		Log To Console    ${\n}${out}
		Should Contain    ${out}    Start set requested successfully    Failed starting Adapter set for ${intf_name}
	END
    Log To Console    ${\n}Adapter Set Successfully Started
	Sleep    120
Starting Aggregation
    Set Client Configuration    prompt=eniqs[eniq_stats] {dcuser} #:
    Write    echo -e "select basetablename from MeasurementTable where MTABLEID LIKE '${package}:%' and TABLELEVEL in('DAY','COUNT')\\n${run}\\n" | isql -P ${password_db} -U ${username} -S ${database} -b
	${out}    Read    delay=5s
	${table_name}    Get Table Names    ${package}    ${out}
	FOR    ${table}    IN    @{table_name}
		write     engine -e startSet '${package}' '${table}' 
		${out}    Read Until Prompt    strip_prompt=True
		Log To Console    ${\n}${out} 
		Should Contain    ${out}    Start set requested successfully    Failed Aggregation for ${table}
	END
	
Running BTFT 
    # write    echo -e "select ACTION_CONTENTS_01 from Meta_transfer_actions WHERE COLLECTION_SET_ID LIKE '286' and ACTION_TYPE LIKE 'parse'\\ngo\\n" | isql -P Etlrep12# -U etlrep -S repdb -b
	# ${out}    Read    delay=5s
	# ${indir}   get indir value    ${out}
	# Log to console    ${indir}
	Open Available Browser    https://arm1s11-eiffel013.eiffel.gic.ericsson.se:8443/nexus/content/repositories/releases/com/ericsson/eniq/stats/tp/CNAXE/cnaxe_bo/    headless=True
	${count}=    Get Element Count   //tr
	${names}=    Create List
	FOR    ${i}    IN RANGE    3   ${count}+1
	    ${name}=    Get Text    xpath=//tr[${i}]/td[1]
	    Append To List    ${names}    ${name}
	END
	${a}    Evaluate   sorted(@{names},reverse=True)
	Log To Console    ${a}

Download Latest Epfg
    Set Client Configuration    prompt=eniqs[eniq_stats] {dcuser} #:    timeout=3600
    Open clearcasevobs
    ${epfgpkgtmp}=    Get Element Attribute    //a[contains(text(),'epfg_ft')]    href
	Go To    ${epfgpkgtmp}
    ${epfgpkg}=    Fetch From Right    ${epfgpkgtmp}    /
    Set Global Variable    ${epfgpkg}    ${epfgpkg}
    ${epfgrstate}=    Fetch From Right    ${epfgpkg}    _
    ${epfgrstate}=    Catenate    SEPARATOR=    epfg_    ${epfgrstate}
    Set Global Variable    ${epfgrstate}    ${epfgrstate}
    Log To Console    ${index}
    # Open Connection    ${jnkns_server}
    # Login               root        shroot
    # Write    rm -rf tppkg ; mkdir tppkg ; cd tppkg ; wget ${epfgpkgtmp} ; pwd
    # Read    delay=100s
    # Switch Connection    ${index}
Install Epfg
    Set Client Configuration    prompt=eniqs[eniq_stats] {dcuser} #:    timeout=3600
    Put File    ${path}/Downloads/${epfgpkg}     /eniq/home/dcuser
    Write    cd /eniq/home/dcuser ; rm -r epfg ; unzip -o ${epfgpkg} ; unzip -o ${epfgrstate} ; cd epfg ; chmod -R 777 * .* ; ./epfg_preconfig_for_ft.sh 
    Read Until Prompt
Get date
    #Set Client Configuration    prompt=eniqs[eniq_stats] {dcuser} #:    timeout=3600
    ${date}=    Execute Command    date -d '-1 day' '+%Y-%m-%d'
	Set Global Variable    ${date}
Generate PM Files without Suspected data
    Set Client Configuration    prompt=eniqs[eniq_stats] {dcuser} #:    timeout=3600
    Put File    ${path}/ENIQ_TC_Automation/TP/Resources/epfgerbs.pl    /eniq/home/dcuser
    Edit Epfg For Counter Validation N Multiple Oss    ${host}    ${port}    ${uname}    ${pwd}
	Write     cd /eniq/home/dcuser ; echo -e "${package}_R10A_b12.tpi" | perl epfgerbs.pl 
    ${out}=    Read Until Prompt
	#Write    cd /eniq/home/dcuser/epfg ; ./start_epfg.sh
	#${out}=    Read Until Prompt
	#Sleep    180

Generate PM Files with Suspected data
    Set Client Configuration    prompt=eniqs[eniq_stats] {dcuser} #:    timeout=3600
	Put File    ${path}/ENIQ_TC_Automation/TP/Resources/epfg_suspected.pl    /eniq/home/dcuser
	Write     echo -e "${package}_R10A_b12.tpi" | perl epfgerbs.pl
    ${out}=    Read Until Prompt
	Write    cd /eniq/home/dcuser/epfg ; ./start_epfg.sh
	${out}=    Read Until Prompt
	Sleep    180

Downloading And Installing BT-Ft
	Set Client Configuration    prompt=eniqs[eniq_stats] {dcuser} #:    timeout=3600
	# Write    echo -e "Select Top 1 dataname from Measurementkey where typeid like '${package}:%' and iselement like'1' and uniquekey like '1'\\n${run}\\n" | isql -P ${password_db} -U ${username} -S ${database} -b
	# ${out}=    Read Until Prompt
	# ${node}=    tp.filter name    ${out}
    #Write    rm -rf BT-FT_Log ; rm -rf BT-FT_Script
    #Read Until Prompt
    # Open nexus tpkpiscript
    # ${btft_link}=    Get Element Attribute    //a[contains(text(),'BT-FT')]    href
    # ${btft_script}=    Fetch From Right    ${btft_link}    /
	# Write    echo -e "select top 1 basetablename from MeasurementTable where MTABLEID LIKE '${package}:(%' and (TABLELEVEL= 'raw')\\n${run}\\n" | isql -P ${password_db} -U ${username} -S ${database} -b
	# ${out1}=    Read Until Prompt
	# ${table}=    tp.Filter Name    ${out1}
	# Write    echo -e "select distinct ${node} from ${table} where datetime_id = '${date} 10:00:00'\\n${run}\\n" | isql -P Dc12# -U Dc -S dwhdb -b
	# ${out2}=    Read Until Prompt
	# ${node_name}=    tp.filter name    ${out2}
    # Open Connection    ${jnkns_server}
    # Login               root        shroot
    # Write    rm -rf tppkg ; mkdir tppkg ; cd tppkg ; wget ${btft_link} ; pwd
    # Read    delay=20s
    # Switch Connection    ${index}
    #Put File    /root/tppkg/${btft_script}    /eniq/home/dcuser
    Write    cd /eniq/home/dcuser ; unzip -o BT-FT_Script_R10D_b15.zip ; cd BT-FT_Script/ ; chmod 777 *
    Read Until Prompt
	tp.changing bt ft file    ${host}    ${port}    ${uname}    ${pwd}
	IF    '${pkg}' == 'DC_E_NR'
		Write    cd /eniq/home/dcuser/BT-FT_Script/ ; echo -e "${full_pkg_name}\\n3,4,5,6,7,8,14\\n${date} 10:00:00\\n${node}\\n${node_name}" |./BT-FT_script.sh
        ${out}=    Read Until Prompt
	ELSE
		Write    cd /eniq/home/dcuser/BT-FT_Script/ ; echo -e "${full_pkg_name}\\n3,4,5,6,7,8\\n${date} 10:00:00\\n${node}\\n${node_name}" |./BT-FT_script.sh
        ${out}=    Read Until Prompt
	END
    
	tp.BT FT Validation    ${out}
    #${res}=    BT FT Validation    ${out}
    #IF    '${res}' == 'fail'
    #    Fail
    #END

Verify Key Loading chechk
    Set Client Configuration    prompt=eniqs[eniq_stats] {dcuser} #:    timeout=3600
	Write    echo -e "select basetablename from MeasurementTable where MTABLEID LIKE '${package}:(%' and (TABLELEVEL= 'raw')\\n${run}\\n" | isql -P ${password_db} -U ${username} -S ${database} -b
	${out}=    Read Until Prompt
	@{tablelist}=    tp.get table list    ${out}
	# FOR    ${element}    IN    @{tablelist}
	# 	Write    echo -e "select datetime_id from ${element}\\n${run}\\n" | isql -P Dc12# -U dc -S dwhdb -b
	#     ${out1}=    Read Until Prompt
	#     Write    echo -e "select DC_TIMEZONE from ${element}\\n${run}\\n" | isql -P Dc12# -U dc -S dwhdb -b
	#     ${out2}=    Read Until Prompt
	#     Write    echo -e "select UTC_DATETIME_ID from ${element}\\n${run}\\n" | isql -P Dc12# -U dc -S dwhdb -b
	#     ${out3}=    Read Until Prompt
	# 	${res}=    verify datetime utctime    ${out1}    ${out2}    ${out3}
	# 	Exit For Loop IF    "${res}" == "False"
	# END
	# IF    "${res}" == "False"
	# 	Fail
	# END
	# Log to Console    Datetime_id & utc_datetime_id successfully verified
	FOR    ${element}    IN    @{tablelist}
		Write    echo -e "select oss_id from ${element}\\n${run}\\n" | isql -P Dc12# -U dc -S dwhdb -b
	    ${out1}=    Read Until Prompt
		${ossId}=    Validating OssId    ${out1}
		Exit For Loop IF    "${ossId}" == "False"
	END
	IF    "${ossId}" == "False"
	 	Fail
	END

Verify delta table Loading
    IF    '${package}' == 'DC_E_GGSN' OR '${package}' == 'DC_E_MGW' OR '${package}' == 'DC_E_WMG' or '${package}' == 'DC_E_CPP' or '${package}' == 'DC_E_TCU'
        Set Client Configuration    prompt=eniqs[eniq_stats] {dcuser} #:    timeout=600
	    Write    echo -e "select versionid from versioning where techpack_name='${package}'\\n${run}\\n" | isql -P ${password_db} -U ${username} -S ${database} -b
	    ${outf}=    Read Until Prompt
	    ${package_b}=    tp.Filter Name    ${outf}
	    Write    echo -e "select distinct typeid from measurementtable where tablelevel = 'Raw' and typeid like'${package_b}%'\\n${run}\\n" | isql -P ${password_db} -U ${username} -S ${database} -b
	    ${out}=    Read Until Prompt
	    ${result}=    Set Variable    false
	    @{tables}=    tp.Get Table List    ${out}
	    FOR    ${element}    IN    @{tables}
	    	Write    echo -e "select dataname from measurementcounter where typeid like '${package_b}:${element}'\\n${run}\\n" | isql -P ${password_db} -U ${username} -S ${database} -b
	    	${out4}=    Read Until Prompt
	    	@{counterlist}=    Get Counter List    ${out4}
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
	    		${res}=    Validate Peg Gauge Delta    ${out6}    ${out7}    ${countertype}    ${deltacalcsupport}
	    	END
	    END
	END

Afg sepcific testcase
    ${result}=    afg specific    'atvts4130.athtem.eei.ericsson.se'    '2251'    'dcuser'    'Dcuser%12'    '20230328'
	
Busy Hour Configuration
    Set Client Configuration    prompt=eniqs[eniq_stats] {dcuser} #:    timeout=600
	Write    echo -e "select top 1 typeid from measurementcounter where typeid like '${package}%'\\n${run}\\n" | isql -P ${password_db} -U ${username} -S ${database} -b
	${out1}=    Read Until Prompt
	${typeid}=    tp.Filter Name    ${out1}
	${tablename}=    Split String From Right    ${typeid}    separator=:    max_split=1
	Write    echo -e "select bhobject from busyhourmapping where typeid = '${typeid}' and bhtype='CP0'\\n${run}\\n" | isql -P ${password_db} -U ${username} -S ${database} -b
	${out2}=    Read Until Prompt
	${bhobject}=    tp.Filter Name    ${out2}
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
	${version_id}=    tp.Filter Name    ${out6}
	Write    echo -e "select top 1 dataname from measurementcounter where typeid = '${typeid}'\\n${run}\\n" | isql -P ${password_db} -U ${username} -S ${database} -b
	${out7}=    Read Until Prompt
	${countername}=    tp.Filter Name    ${out7}
	Write    echo -e "UPDATE Busyhour SET BHCRITERIA='SUM(${countername})' , description='Test' , enable = 1 WHERE BHTYPE='CP0' and BHLEVEL='${bhlevel}';\\n${run}\\n" | isql -P ${password_db} -U ${username} -S ${database} -b
	${out8}=    Read Until Prompt
	${version_id}=    tp.Filter Name    ${out8}
	write     /eniq/sw/bin/engine -e startSet DWH_MONITOR AggregationRuleCopy 
	${out}    Read Until Prompt    strip_prompt=True
	Log To Console    ${\n}${out} 
	Should Contain    ${out}    Start set requested successfully    Failed Aggregation for AggregationRuleCopy
	write     /eniq/sw/bin/engine -e startSet DWH_MONITOR AutomaticAggregation 
	${out}    Read Until Prompt    strip_prompt=True
	Log To Console    ${\n}${out} 
	Should Contain    ${out}    Start set requested successfully    Failed Aggregation for AutomaticAggregation
	write     /eniq/sw/bin/engine -e startSet DWH_MONITOR AutomaticREAggregation 
	${out}    Read Until Prompt    strip_prompt=True
	Log To Console    ${\n}${out} 
	Should Contain    ${out}    Start set requested successfully    Failed Aggregation for AutomaticREAggregation
	write     /eniq/sw/bin/engine -e startSet DWH_MONITOR UpdateMonitoredTypes 
	${out}    Read Until Prompt    strip_prompt=True
	Log To Console    ${\n}${out} 
	Should Contain    ${out}    Start set requested successfully    Failed Aggregation for UpdateMonitoredTypes
	write     /eniq/sw/bin/engine -e startSet DWH_MONITOR UpdateMonitoring 
	${out}    Read Until Prompt    strip_prompt=True
	Log To Console    ${\n}${out} 
	Should Contain    ${out}    Start set requested successfully    Failed Aggregation for UpdateMonitoring
	write     /eniq/sw/bin/engine -e startSet DWH_MONITOR UpdateMonitoringOnStartup 
	${out}    Read Until Prompt    strip_prompt=True
	Log To Console    ${\n}${out} 
	Should Contain    ${out}    Start set requested successfully    Failed Aggregation for UpdateMonitoringOnStartup