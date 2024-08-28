
*** Settings ***
Documentation     Testing alarm
Library    RPA.Browser.Selenium    
Library    SSHLibrary
Library    String
Library    Collections    
Resource    ../../Resources/Keywords/AlarmCfg_keywords.robot
Resource    ../../Resources/Keywords/Cli.robot
Resource    ../../Resources/Keywords/Variables.robot
Resource    ../../Resources/Keywords/AdminUIWebUI.robot
Suite Setup    Connect to server as a dcuser
Suite Teardown    Close All Connections
Library    ../../Scripts/alarm/alarmcfg.py

*** Variables ***
${run}		go   


*** Test Cases ***
TC_01 Verify latest alarm module deployed in ENIQ Server
    Open clearcasevobs
    Getting the latest module and Rstate of alarm from clearcase page	
    Getting the latest module and Rstate of alarm from Server

TC_02 Downloading the latest alarm module
    Verifying if latest alarm module is already installed on server
    Downloading latest alarm module if not installed on server

TC_03 Installing the latest alarm module
    Verifying if latest alarm module is already installed on server
    Installing latest alarm module if not installed on server

TC 04 Verifying if alarm latest module is present after installation.
    Verifying if latest alarm module is already installed on server
    Verifying if latest alarm module got installed on server

TC 05 verifying if alarm latest module is present on adminUI page
    Launch the AdminUI page in browser
    Login To Adminui
    Click Link    Monitoring Commands
    Verifying if latest alarm module is present on adminUI page.   
						
TC 06 verifying alarm Log files
    Getting latest alarm log file and verifying no error should be there

TC 07 Verify latest alarmcfg module deployed in ENIQ Server
    Open clearcasevobs
    Getting the latest module and Rstate of alarmcfg from clearcase page	
    Getting the latest module and Rstate of alarmcfg from Server

TC 08 Downloading the latest alarmcfg module
    Verifying if latest alarmcfg module is already installed on server
    Downloading latest alarmcfg module if not installed on server

TC 09 Installing the latest alarmcfg module
    Verifying if latest alarmcfg module is already installed on server
    Installing latest alarmcfg module if not installed on server

TC 10 Verifying if alarmcfg latest module is present after installation.
    Verifying if latest alarmcfg module is already installed on server
    Verifying if latest alarmcfg module got installed on server

TC 11 verifying if alarmcfg latest module is present on adminUI page
    Launch the AdminUI page in browser
    Login To Adminui
    Click Link    Monitoring Commands
    Verifying if latest alarmcfg module is present on adminUI page.   
						
TC 12 verifying alarmcfg Log files
    Getting latest alarmcfg log file and verifying no error should be there

TC 13 Verify the latest DC_Z_ALARM TP in Adminui
    verify the latest DC_Z_ALARM in Adminui

TC 14 Download and Install the latest DC_Z_ALARM TP
    download and install the latest DC_Z_ALARM TP

TC 15 Verifying TP Installation log
    verifying TP Installation log

TC 16 Verifying TP Installation
    verifying TP Installation

TC 17 Fetch Rstate of Interface from AdminUI and Clearcase
    fetch Rstate of Interface from AdminUI and Clearcase

TC 18 Verify the latest dim TP in Adminui
    verify the latest dim TP in Adminui

TC 19 Download and Install the latest dim TP
    download and install the latest dim TP

TC 20 Verifying TP Installation log
    verifying TP Installation log

TC 21 Verifying TP Installation
    verifying TP Installation

TC 22 Fetch Rstate of Interface from AdminUI and Clearcase
    fetch Rstate of Interface from AdminUI and Clearcase

TC 23 Verify the latest DC_E_MTAS TP in Adminui
    verify the latest DC_E_MTAS in Adminui

TC 24 Download and Install the latest DC_E_MTAS TP
    download and install the latest DC_E_MTAS TP

TC 25 Verifying TP Installation log
    verifying TP Installation log

TC 26 Verifying TP Installation
    verifying TP Installation

TC 27 Fetch Rstate of Interface from AdminUI and Clearcase
    fetch Rstate of Interface from AdminUI and Clearcase

*** Keywords ***
Open clearcasevobs
    # ${chrome_options}=    Evaluate    sys.modules['selenium.webdriver'].ChromeOptions()    sys
    # Log    ${EXEC_DIR}
    # RPA.Browser.Selenium.Create Webdriver    Chrome    executable_path=${EXEC_DIR}/PF/Resources/Drivers/chromedriver.exe    chrome_options=${chrome_options}
    # RPA.Browser.Selenium.Go To    ${clearcase_url}eniqdel 
    Open Available Browser    ${clearcase_url}eniqdel
    RPA.Browser.Selenium.Maximize Browser Window
    Sleep    5s
    RPA.Browser.Selenium.Maximize Browser Window     
    Click Link    //body//tr[last()-1]//td[2]//a
    Click Link    //body//tr[last()-1]//td[2]//a
    ${loc}    Get Location
    Go To    ${loc}SOLARIS_baseline.html

verify the latest DC_Z_ALARM in Adminui
    Open clearcasevobs
    ${DC_Z_ALARM_techpack}=    Get Element Attribute    //a[contains(text(),'DC_Z_ALARM')]    href
    Go To    ${DC_Z_ALARM_techpack}
    ${rstate}    Get Text    //table//a[text()='DC_Z_ALARM']/../following-sibling::td[3]
    ${temp1}=    Fetch From Right    ${DC_Z_ALARM_techpack}    /
    Set Global Variable    ${full_pkg_name}    ${temp1}    
    Set Global Variable    ${DC_Z_ALARM_techpack}
    Connect to physical server
    Put File    ${EXEC_DIR}//PF//Scripts//test.bsh    /eniq/home/dcuser
    Execute Command    cd /eniq/home/dcuser && dos2unix test.bsh
    ${dwhrep_pwd}=    Execute Command    ./test.bsh REP DWHREP | grep -i Password | cut -d ':' -f 2
    Set Global Variable    ${dwhrep_pwd}
    Write    echo -e "select TOP 1 TECHPACK_VERSION from Versioning where TECHPACK_NAME = 'DC_Z_ALARM' ORDER BY TECHPACK_VERSION Desc\\n${run}\\n" | isql -P ${dwhrep_pwd} -U DWHREP -S repdb -b
    ${output1}=    Read Until Prompt
    ${output1}    Get Regexp Matches    ${output1}    \\bR\\d+\\w+\\b
    IF    '${rstate}' != '${output1}[0]'
        Set Global Variable     ${latest_TP_found}    True
        Log To Console    Latest DC_Z_ALARM Tp already installed
    ELSE
        Set Global Variable     ${latest_TP_found}    False
    END

download and install the latest DC_Z_ALARM TP
    Skip If    '${latest_TP_found}' != 'True'   ${\n}Skipping the downloading since latest DC_Z_ALARM package is already present in the server.
    IF    '${latest_TP_found}' == 'True'
        Execute Command    cd /eniq/sw/installer && wget ${DC_Z_ALARM_techpack}
        ${out}    Execute Command    cd /eniq/sw/installer ; ./tp_installer -p . -t ${full_pkg_name}
    END

verifying TP Installation log
    Skip If    '${latest_TP_found}' != 'True'   ${\n}Skipping the downloading since latest DC_Z_ALARM package is already present in the server.
    IF    '${latest_TP_found}' == 'True'   
        ${out_tp_log}    Execute Command    cat /eniq/log/sw_log/tp_installer/*_${full_pkg_name}.log | grep -i 'FAILED\\|EXCEPTION\\|warning\\|severe\\|not found\\|failed\\|Error\\|not enabled\\|disable'
        ${engine_file_name}        Execute Command     cd /eniq/log/sw_log/engine/DC_Z_ALARM && ls -Art *.log | tail -n 1
        ${out}    Execute Command    cat /eniq/log/sw_log/engine/DC_Z_ALARM/${engine_file_name} | grep -i 'FAILED\\|EXCEPTION\\|warning\\|severe\\|not found\\|failed\\|Error\\|not enabled\\|disable'
        ${output_length}    Get Length    ${out}
        ${output_length_tp}    Get Length    ${out_tp_log}
        IF    ${output_length} == 0 and ${output_length_tp} == 0
            Log    Installed successfully
        ELSE
            Fail    
        END
    END

verifying TP Installation
    Skip If    '${latest_TP_found}' != 'True'   ${\n}Skipping the downloading since latest DC_Z_ALARM package is already present in the server.
    IF    '${latest_TP_found}' == 'True'
        Write    echo -e "select TECHPACK_VERSION from Versioning where TECHPACK_NAME='DC_Z_ALARM'\\n${run}\\n" | isql -P ${dwhrep_pwd} -U DWHREP -S repdb -b
        ${output1}=    Read Until Prompt
        ${new_rstate_inDB}=    Filter Latest Name    ${output1}
        Write    echo -e "select VERSIONID from Versioning where TECHPACK_NAME='DC_Z_ALARM'\\n${run}\\n" | isql -P ${dwhrep_pwd} -U DWHREP -S repdb -b
        ${output2}=    Read Until Prompt 
        ${temp}=    Filter Latest Name    ${output2}
        ${temp1}=    Give Build Number    ${temp}
        ${dim_pkg}    Set Variable    DC_Z_ALARM
        ${full_pkg_name_in_db}=    Catenate    SEPARATOR=_    ${dim_pkg}    ${new_rstate_inDB}    b${temp1}.tpi    
        Set Global Variable    ${full_pkg_name_in_db}    ${full_pkg_name_in_db}
        IF    '${full_pkg_name}' != '${full_pkg_name_in_db}'
            Fail
        END
    END

fetch Rstate of Interface from AdminUI and Clearcase
    Skip If    '${latest_TP_found}' != 'True'   ${\n}Skipping the downloading since latest DC_Z_ALARM package is already present in the server.
    Write    echo -e "select INTERFACENAME from InterfaceTechpacks where TECHPACKNAME='DC_Z_ALARM'\\n${run}\\n" | isql -P ${dwhrep_pwd} -U DWHREP -S repdb -b
    ${output1}=    Read Until Prompt
    ${dep_int}=    filter_interfaces    ${output1}
    FOR    ${intf_name}    IN    @{dep_int}
        Write    echo -e "select RSTATE from DataInterface where INTERFACENAME LIKE '${intf_name}'\\n${run}\\n" | isql -P ${dwhrep_pwd} -U DWHREP -S repdb -b
        ${output1}=    Read Until Prompt
        ${new_rstate_inDB}=    Filter Name    ${output1}
        Write    echo -e "select INTERFACEVERSION from DataInterface where INTERFACENAME LIKE '${intf_name}'\\n${run}\\n" | isql -P ${dwhrep_pwd} -U DWHREP -S repdb -b
        ${output2}=    Read Until Prompt 
        ${temp}=    Filter Name    ${output2}
        ${temp1}=    Give Build Number    ${temp}
        ${full_intf_deta}=    Catenate    SEPARATOR=_    ${intf_name}    ${new_rstate_inDB}    b${temp1}.tpi
		Open clearcasevobs
        ${temp}=    Get Element Attribute    //table//a[text()='${intf_name}']    href
        ${temp1}=    Fetch From Right    ${temp}    /
		IF    '${temp1}' != '${full_intf_deta}'
		    Log To Console    ${\n}Rstate not equal
        #Append To List    ${Interfaces_to_update}    ${intf_name}
		# Downloading TP from vobs    ${pkg}[0]
		# Installing TP    ${pkg}[0]
		ELSE
			Log To Console   ${\n}Rstate of ${temp1} in both places are equal
		END
		# Execute Command    cd /eniq/sw/installer ; ./activate_interface -o eniq_oss_1 -t ${intf_name}
	END
    Open clearcasevobs
    # ${chrome_options}=    Evaluate    sys.modules['selenium.webdriver'].ChromeOptions()    sys
    # Log    ${EXEC_DIR}
    # RPA.Browser.Selenium.Create Webdriver    Chrome    executable_path=${EXEC_DIR}/PF/Resources/Drivers/chromedriver.exe    chrome_options=${chrome_options}
    # RPA.Browser.Selenium.Go To    ${clearcase_url}eniqdel
    Open Available Browser    ${clearcase_url}eniqdel
    RPA.Browser.Selenium.Maximize Browser Window
    Sleep    5s
    RPA.Browser.Selenium.Maximize Browser Window
    Click Link    //body//tr[last()-1]//td[2]//a
    Click Link    //body//tr[last()-1]//td[2]//a
    ${loc}    Get Location
    Go To    ${loc}SOLARIS_baseline.html

verify the latest dim TP in Adminui
    Open clearcasevobs
    ${DIM_E_CN_topology}=    Get Element Attribute    //a[contains(text(),'DIM_E_CN')]    href
    ${rstate}    Get Text    //table//a[text()='DIM_E_CN']/../following-sibling::td[3]
    ${temp1}=    Fetch From Right    ${DIM_E_CN_topology}    /
    Set Global Variable    ${full_pkg_name}    ${temp1}    
    Set Global Variable    ${DIM_E_CN_topology}
    Connect to physical server
    Put File    ${EXEC_DIR}//PF//Scripts//test.bsh    /eniq/home/dcuser
    Execute Command    cd /eniq/home/dcuser && dos2unix test.bsh
    ${dwhrep_pwd}=    Execute Command    ./test.bsh REP DWHREP | grep -i Password | cut -d ':' -f 2
    Set Global Variable    ${dwhrep_pwd}
    Write    echo -e "select TOP 1 TECHPACK_VERSION from Versioning where TECHPACK_NAME = 'DIM_E_CN' ORDER BY TECHPACK_VERSION Desc\\n${run}\\n" | isql -P ${dwhrep_pwd} -U DWHREP -S repdb -b
    ${output1}=    Read Until Prompt
    ${output1}    Get Regexp Matches    ${output1}    \\bR\\d+\\w+\\b
    IF    '${rstate}' != '${output1}[0]'
        Set Global Variable     ${latest_TP_found}    True
        Log To Console    Latest Dim Tp already installed
    ELSE
        Set Global Variable     ${latest_TP_found}    False
    END

download and install the latest dim TP
    Skip If    '${latest_TP_found}' != 'True'   ${\n}Skipping the downloading since latest DIM_E_CN package is already present in the server.
    IF    '${latest_TP_found}' == 'True'
        Execute Command    cd /eniq/sw/installer && wget ${DIM_E_CN_topology}
        ${out}    Execute Command    cd /eniq/sw/installer ; ./tp_installer -p . -t ${full_pkg_name}
    END

verifying TP Installation log
    Skip If    '${latest_TP_found}' != 'True'   ${\n}Skipping the downloading since latest DIM_E_CN package is already present in the server.
    IF    '${latest_TP_found}' == 'True'   
        ${out_tp_log}    Execute Command    cat /eniq/log/sw_log/tp_installer/*_${full_pkg_name}.log | grep -i 'FAILED\\|EXCEPTION\\|warning\\|severe\\|not found\\|failed\\|Error\\|not enabled\\|disable'
        ${engine_file_name}        Execute Command     cd /eniq/log/sw_log/engine/DIM_E_CN && ls -Art *.log | tail -n 1
        ${out}    Execute Command    cat /eniq/log/sw_log/engine/DIM_E_CN/${engine_file_name} | grep -i 'FAILED\\|EXCEPTION\\|warning\\|severe\\|not found\\|failed\\|Error\\|not enabled\\|disable'
        ${output_length}    Get Length    ${out}
        ${output_length_tp}    Get Length    ${out_tp_log}
        IF    ${output_length} == 0 and ${output_length_tp} == 0
            Log    Installed successfully
        ELSE
            Fail    
        END
    END

verifying TP Installation
    Skip If    '${latest_TP_found}' != 'True'   ${\n}Skipping the downloading since latest DIM_E_CN package is already present in the server.
    IF    '${latest_TP_found}' == 'True'
        Write    echo -e "select TECHPACK_VERSION from Versioning where TECHPACK_NAME='DIM_E_CN'\\n${run}\\n" | isql -P ${dwhrep_pwd} -U DWHREP -S repdb -b
        ${output1}=    Read Until Prompt
        ${new_rstate_inDB}=    Filter Latest Name    ${output1}
        Write    echo -e "select VERSIONID from Versioning where TECHPACK_NAME='DIM_E_CN'\\n${run}\\n" | isql -P ${dwhrep_pwd} -U DWHREP -S repdb -b
        ${output2}=    Read Until Prompt 
        ${temp}=    Filter Latest Name    ${output2}
        ${temp1}=    Give Build Number    ${temp}
        ${dim_pkg}    Set Variable    DIM_E_CN
        ${full_pkg_name_in_db}=    Catenate    SEPARATOR=_    ${dim_pkg}    ${new_rstate_inDB}    b${temp1}.tpi    
        Set Global Variable    ${full_pkg_name_in_db}    ${full_pkg_name_in_db}
        IF    '${full_pkg_name}' != '${full_pkg_name_in_db}'
            Fail
        END
    END

fetch Rstate of Interface from AdminUI and Clearcase
    Skip If    '${latest_TP_found}' != 'True'   ${\n}Skipping the downloading since latest DIM_E_CN package is already present in the server.
    Write    echo -e "select INTERFACENAME from InterfaceTechpacks where TECHPACKNAME='DIM_E_CN'\\n${run}\\n" | isql -P ${dwhrep_pwd} -U DWHREP -S repdb -b
    ${output1}=    Read Until Prompt
    ${dep_int}=    filter_interfaces    ${output1}
    FOR    ${intf_name}    IN    @{dep_int}
        Write    echo -e "select RSTATE from DataInterface where INTERFACENAME LIKE '${intf_name}'\\n${run}\\n" | isql -P ${dwhrep_pwd} -U DWHREP -S repdb -b
        ${output1}=    Read Until Prompt
        ${new_rstate_inDB}=    Filter Name    ${output1}
        Write    echo -e "select INTERFACEVERSION from DataInterface where INTERFACENAME LIKE '${intf_name}'\\n${run}\\n" | isql -P ${dwhrep_pwd} -U DWHREP -S repdb -b
        ${output2}=    Read Until Prompt 
        ${temp}=    Filter Name    ${output2}
        ${temp1}=    Give Build Number    ${temp}
        ${full_intf_deta}=    Catenate    SEPARATOR=_    ${intf_name}    ${new_rstate_inDB}    b${temp1}.tpi
		Open clearcasevobs
        ${temp}=    Get Element Attribute    //table//a[text()='${intf_name}']    href
        ${temp1}=    Fetch From Right    ${temp}    /
		IF    '${temp1}' != '${full_intf_deta}'
		    Log To Console    ${\n}Rstate not equal
        #Append To List    ${Interfaces_to_update}    ${intf_name}
		# Downloading TP from vobs    ${pkg}[0]
		# Installing TP    ${pkg}[0]
		ELSE
			Log To Console   ${\n}Rstate of ${temp1} in both places are equal
		END
		# Execute Command    cd /eniq/sw/installer ; ./activate_interface -o eniq_oss_1 -t ${intf_name}
	END

    Open clearcasevobs
    # ${chrome_options}=    Evaluate    sys.modules['selenium.webdriver'].ChromeOptions()    sys
    # Log    ${EXEC_DIR}
    # RPA.Browser.Selenium.Create Webdriver    Chrome    executable_path=${EXEC_DIR}/PF/Resources/Drivers/chromedriver.exe    chrome_options=${chrome_options}
    # RPA.Browser.Selenium.Go To    ${clearcase_url}eniqdel 
    Open Available Browser    ${clearcase_url}eniqdel
    RPA.Browser.Selenium.Maximize Browser Window
    Sleep    5s
    RPA.Browser.Selenium.Maximize Browser Window
    Click Link    //body//tr[last()-1]//td[2]//a
    Click Link    //body//tr[last()-1]//td[2]//a
    ${loc}    Get Location
    Go To    ${loc}SOLARIS_baseline.html

verify the latest DC_E_MTAS in Adminui
    Open clearcasevobs
    ${DC_E_MTAS_techpack}=    Get Element Attribute    //a[contains(text(),'DC_E_MTAS')]    href
    Go To    ${DC_E_MTAS_techpack}
    ${rstate}    Get Text    //table//a[text()='DC_E_MTAS']/../following-sibling::td[3]
    ${temp1}=    Fetch From Right    ${DC_E_MTAS_techpack}    /
    Set Global Variable    ${full_pkg_name}    ${temp1}    
    Set Global Variable    ${DC_E_MTAS_techpack}
    Connect to physical server
    Put File    ${EXEC_DIR}//PF//Scripts//test.bsh    /eniq/home/dcuser
    Execute Command    cd /eniq/home/dcuser && dos2unix test.bsh
    ${dwhrep_pwd}=    Execute Command    ./test.bsh REP DWHREP | grep -i Password | cut -d ':' -f 2
    Set Global Variable    ${dwhrep_pwd}
    Write    echo -e "select TOP 1 TECHPACK_VERSION from Versioning where TECHPACK_NAME = 'DC_E_MTAS' ORDER BY TECHPACK_VERSION Desc\\n${run}\\n" | isql -P ${dwhrep_pwd} -U DWHREP -S repdb -b
    ${output1}=    Read Until Prompt
    ${output1}    Get Regexp Matches    ${output1}    \\bR\\d+\\w+\\b
    IF    '${rstate}' != '${output1}[0]'
        Set Global Variable     ${latest_TP_found}    True
        Log To Console    Latest DC_E_MTAS Tp already installed
    ELSE
        Set Global Variable     ${latest_TP_found}    False
    END

download and install the latest DC_E_MTAS TP
    Skip If    '${latest_TP_found}' != 'True'   ${\n}Skipping the downloading since latest DC_Z_ALARM package is already present in the server.
    IF    '${latest_TP_found}' == 'True'
        Execute Command    cd /eniq/sw/installer && wget ${DC_E_MTAS_techpack}
        ${out}    Execute Command    cd /eniq/sw/installer ; ./tp_installer -p . -t ${full_pkg_name}
    END

verifying TP Installation log
    Skip If    '${latest_TP_found}' != 'True'   ${\n}Skipping the downloading since latest DC_E_MTAS package is already present in the server.
    IF    '${latest_TP_found}' == 'True'   
        ${out_tp_log}    Execute Command    cat /eniq/log/sw_log/tp_installer/*_${full_pkg_name}.log | grep -i 'FAILED\\|EXCEPTION\\|warning\\|severe\\|not found\\|failed\\|Error\\|not enabled\\|disable'
        ${engine_file_name}        Execute Command     cd /eniq/log/sw_log/engine/DC_E_MTAS && ls -Art *.log | tail -n 1
        ${out}    Execute Command    cat /eniq/log/sw_log/engine/DC_E_MTAS/${engine_file_name} | grep -i 'FAILED\\|EXCEPTION\\|warning\\|severe\\|not found\\|failed\\|Error\\|not enabled\\|disable'
        ${output_length}    Get Length    ${out}
        ${output_length_tp}    Get Length    ${out_tp_log}
        IF    ${output_length} == 0 and ${output_length_tp} == 0
            Log    Installed successfully
        ELSE
            Fail   
        END
    END

verifying TP Installation
    Skip If    '${latest_TP_found}' != 'True'   ${\n}Skipping the downloading since latest DC_E_MTAS package is already present in the server.
    IF    '${latest_TP_found}' == 'True'
        Write    echo -e "select TECHPACK_VERSION from Versioning where TECHPACK_NAME='DC_E_MTAS'\\n${run}\\n" | isql -P ${dwhrep_pwd} -U DWHREP -S repdb -b
        ${output1}=    Read Until Prompt
        ${new_rstate_inDB}=    Filter Latest Name    ${output1}
        Write    echo -e "select VERSIONID from Versioning where TECHPACK_NAME='DC_E_MTAS'\\n${run}\\n" | isql -P ${dwhrep_pwd} -U DWHREP -S repdb -b
        ${output2}=    Read Until Prompt 
        ${temp}=    Filter Latest Name    ${output2}
        ${temp1}=    Give Build Number    ${temp}
        ${dim_pkg}    Set Variable    DC_E_MTAS
        ${full_pkg_name_in_db}=    Catenate    SEPARATOR=_    ${dim_pkg}    ${new_rstate_inDB}    b${temp1}.tpi    
        Set Global Variable    ${full_pkg_name_in_db}    ${full_pkg_name_in_db}
        IF    '${full_pkg_name}' != '${full_pkg_name_in_db}'
            Fail
        END
    END

fetch Rstate of Interface from AdminUI and Clearcase
    Skip If    '${latest_TP_found}' != 'True'   ${\n}Skipping the downloading since latest DC_E_MTAS package is already present in the server.
    Write    echo -e "select INTERFACENAME from InterfaceTechpacks where TECHPACKNAME='DC_E_MTAS'\\n${run}\\n" | isql -P ${dwhrep_pwd} -U DWHREP -S repdb -b
    ${output1}=    Read Until Prompt
    ${dep_int}=    filter_interfaces    ${output1}
    FOR    ${intf_name}    IN    @{dep_int}
        Write    echo -e "select RSTATE from DataInterface where INTERFACENAME LIKE '${intf_name}'\\n${run}\\n" | isql -P ${dwhrep_pwd} -U DWHREP -S repdb -b
        ${output1}=    Read Until Prompt
        ${new_rstate_inDB}=    Filter Name    ${output1}
        Write    echo -e "select INTERFACEVERSION from DataInterface where INTERFACENAME LIKE '${intf_name}'\\n${run}\\n" | isql -P ${dwhrep_pwd} -U DWHREP -S repdb -b
        ${output2}=    Read Until Prompt 
        ${temp}=    Filter Name    ${output2}
        ${temp1}=    Give Build Number    ${temp}
        ${full_intf_deta}=    Catenate    SEPARATOR=_    ${intf_name}    ${new_rstate_inDB}    b${temp1}.tpi
		Open clearcasevobs
        ${temp}=    Get Element Attribute    //table//a[text()='${intf_name}']    href
        ${temp1}=    Fetch From Right    ${temp}    /
		IF    '${temp1}' != '${full_intf_deta}'
		    Log To Console    ${\n}Rstate not equal
        #Append To List    ${Interfaces_to_update}    ${intf_name}
		# Downloading TP from vobs    ${pkg}[0]
		# Installing TP    ${pkg}[0]
		ELSE
			Log To Console   ${\n}Rstate of ${temp1} in both places are equal
		END
		# Execute Command    cd /eniq/sw/installer ; ./activate_interface -o eniq_oss_1 -t ${intf_name}
	END