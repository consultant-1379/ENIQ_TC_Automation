*** Settings ***
Library    RPA.Browser.Selenium
Library    OperatingSystem
Library    RPA.FileSystem
Library		SSHLibrary
Library    Collections
Resource    ../../../Resources/login.resource
Library     ../tp.py
Library    String
# Test Setup        Open Connection And Log In
Test Teardown     Close All Connections
#Resource    ./login.resource
*** Variables ***
${host}    atvts4134.athtem.eei.ericsson.se
${port}    2251
${uname}     dcuser
${pwd}       Dcuser%12
${package}    DC_E_AFG
${clearcase}    https://clearcase-eniq.seli.wh.rnd.internal.ericsson.com/eniqdel
${sql_query_for_dependnt_intf_on_tp}    select INTERFACENAME from InterfaceDependency where TECHPACKNAME= '${package}'
${password_db}      Dwhrep12#
${username}      dwhrep
${database}      repdb
${run}		go
*** Tasks *** 
FT 
    Open Connection And Log In
	${out}    Execute Command    who
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
    # Editing Engine.properties file
	# Data Format not found verification in engine logs
    # Fetch Rstate of Interface from AdminUI and Clearcase
    # Starting Adapter Set for Interfaces
	# Starting Aggregation
	# Running BTFT

*** Keywords ***
Open Connection And Log In
    ${index}    Open Connection    ${host}      port=${port}    timeout=10
    Set Global Variable    ${index}
    Login               ${uname}        ${pwd}
	
Downloading techpack	
    Set Download Directory    /root/sa
    Open Available Browser    ${clearcase}    
    Click Link    xpath=//body//tr[last()-1]//td[2]//a   
    Click Link    xpath=//body//tr[last()-1]//td[2]//a   
    ${loc}    Get Location
    Go To    ${loc}SOLARIS_baseline.html 
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
	Write    echo -e "${sql_query_for_dependnt_intf_on_tp}\\n${run}\\n" | isql -P ${password_db} -U ${username} -S ${database} -b
    ${output1}=    Read    delay=3s
	${name}   ${dep_int}     Dependent pkg and intf  ${package}  ${output1}
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
		${rstate_adminui}=   Filter Name    ${output1}  
		Log To Console    ${\n}Rstate in AdminUI is= ${rstate_adminui}
		IF    '${rstate_vobs}' != '${rstate_adminui}'
		Log To Console    ${\n}Rstate not equal
		Downloading TP from vobs    ${pkg}[0]
		Installing TP    ${pkg}[0]
		ELSE
			Log To Console   ${\n}Rstate in both places are equal
		END
		Execute Command    cd /eniq/sw/installer ; ./activate_interface -o eniq_oss_1 -t ${intf_name}
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