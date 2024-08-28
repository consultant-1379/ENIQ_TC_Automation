*** Settings ***
Documentation     Testing Alarmcfg Webpage
Library    RPA.Browser.Selenium
Library    SSHLibrary
Library    String
Library    Collections
Library    ../../Scripts/alarm/alarmcfg.py
Resource    ../../Resources/Keywords/Variables.robot
Resource    ../../Resources/Keywords/AdminUIWebUI.robot   
Resource    ../../Resources/Keywords/Cli.robot

*** Variables ***
${run}		go

*** Test Cases ***
Verify the latest DC_E_MTAS TP in Adminui
    verify the latest DC_E_MTAS in Adminui
Download and Install the latest DC_E_MTAS TP
    download and install the latest DC_E_MTAS TP
Verifying TP Installation log
    verifying TP Installation log
Verifying TP Installation
    verifying TP Installation
Fetch Rstate of Interface from AdminUI and Clearcase
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