*** Keywords ***

place the file in the directory
	[Arguments]    ${file}    ${srcPath}    ${destPath}
	Fileupload.Winscp File Upload     ${file}    ${srcPath}    ${destPath}	
	
activate the interface
    ${status}=    execute the command    if [ -f CV_INFORMATION_STORE_R13A_b417.tpi ]
    IF    "${status}"=="False"
        FileUpload.File Paste And Activate Interface
    ELSE 
        execute the command    rm CV_INFORMATION_STORE_R13A_b417.tpi
        FileUpload.File Paste And Activate Interface        
	
Connect to server as a dcuser
	Open Connection    ieatrcxb4070.athtem.eei.ericsson.se    port=22    timeout=10
    Login    dcuser    Dcuser_123
    
execute the command
	[Arguments]    ${command}
    Write    ${command}
    ${output}=    Read    delay=2s
    Log     ${output}
    [Return]    ${output}
    
Check for the file permission
   [Arguments]     ${file}    ${directory}
   execute the command    cd /eniq/data/pmdata/eniq_oss_1/
   execute the command    pwd
   execute the command    chmod -R 777 ${directory}
   execute the command    cd /eniq/data/pmdata/eniq_oss_1/${directory}
   execute the command    chmod -R 777 ${file}
   verify the file permission    ${file}    ${directory}
    
verify the file permission
	[Arguments]     ${file}    ${directory}
    execute the command    cd /eniq/data/pmdata/eniq_oss_1/${directory}
	${result_1}=     execute the command    ls -l ${file}  
	Log    ${result_1}
	[Return]    ${result_1}
	should contain    ${result_1}    rwxrwxrwx

verify the file placed in proper directory
	[Arguments]     ${file}    ${directory}
    execute the command    cd /eniq/data/pmdata/eniq_oss_1/${directory}
	${file_place}=    execute the command    ls
	should contain    ${file_place}    ${file} 
	
Trigger the interface
	open the adminui page
	click on button     ETLC Set Scheduling
	verify the page title    ETLC Set Scheduling

select the type
	[Arguments]    ${package}
	Wait Until Element Is Visible     xpath:(//select[@name="settype"])    30
	Click Element       xpath:(//select[@name="settype"])
	sleep    2
	Wait Until Element Is Visible     xpath://*[contains(text(),'${package}')]    30
	Click Element       xpath://*[contains(text(),'${package}')]
	wait for page to load
	capture page screenshot
	
	
select the package	
	[Arguments]    ${package}
	Wait Until Element Is Visible     xpath:(//select[@name="packageSets"])    30
	Click Element       xpath:(//select[@name="packageSets"])
	sleep    2
	Wait Until Element Is Visible     xpath://*[contains(text(),'${package}')]    30
	Click Element       xpath://*[contains(text(),'${package}')]
	sleep    5
	click on button    Start
	wait for page to load
	capture page screenshot 
	
open the adminui page
	${chrome_options}=    Evaluate    sys.modules['selenium.webdriver'].ChromeOptions()      sys
	Call Method    ${chrome_options}    add_argument    --ignore-certificate-errors
	Selenium2library.Create Webdriver    Chrome    executable_path=${EXEC_DIR}/ENIQ_TC_Automation/NetAn/Resources/Drivers/chromedriver.exe      chrome_options=${chrome_options}
    Selenium2Library.Go To    ${adminui}  
    Maximize Browser Window
    Sleep    3
    Selenium2Library.Input Text    name:userName    eniq	
    Selenium2Library.Input Text    name:userPassword    Rhel@4070
    Click Element    name:submit
    ${IsElementVisible}=    Run Keyword And Return Status     alert should be present    Alert Text: Engine is set to NoLoads
    Run Keyword If    ${IsElementVisible}    handle alert    accept
    capture page screenshot	
	
click on button
	[Arguments]    ${buttonValue}
	sleep     5
	Wait Until Element Is Visible     xpath:(//table[@class="menu"])//*[contains(text(),'${buttonValue}')]    300
    Click element     xpath:(//table[@class="menu"])//*[contains(text(),'${buttonValue}')]
	wait for page to load
	capture page screenshot	

verify the page title  
	[Arguments]     ${expectedText}
    ${text}=    Selenium2Library.Get text  xpath:(((//td[2])[1])//font)[1]//a
    Log    ${text}
    Should contain     ${expectedText}	 ${text}
    wait for page to load
	capture page screenshot


wait for page to load
    sleep   2
    Wait Until Element Is Not Visible     class:sfx_progress-bar-container_1118        timeout=2400
    sleep   2   
    Wait Until Element Is Not Visible     class:sfx_progress-bar-container_1118        timeout=2400
    sleep   2	
    
Verify that the table has data
	[Arguments]    ${db_result}    ${table_name}
	Log    ${db_result}
	IF    "${table_name}" == "DIM_E_VOWIFI_KPI"
	    ${count1}=    count values in list     ${db_result}    'Percentage'
	    Log    ${count1}
	    ${status}=    should not be equal    ${count1}    0
	ELSE IF    "${table_name}" == "DIM_E_VOWIFI_NODE"
		${count1}=    count values in list    ${db_result}    'Unknown'
	    Log    ${count1}
	    ${status}=    should not be equal    ${count1}    0	    
	END
	Log    ${status}
	[Return]     ${status}
	    
Test teardown steps
    Capture page screenshot
    run keyword and ignore error    click on button     Logout
    run keyword and ignore error    Close Browser		
	
Verify that the table is not empty
	[Arguments]    ${status}
	Log    ${status}
	
	
query the DC_E_VOWIFI_KPI_RAW table
	[Arguments]    ${KPI_ID}    ${KPI_NAME}
	${KPI_ID}=    convert to integer    ${KPI_ID}
	#${db_result}=    Query Sybase database    select * from DC_E_VOWIFI_KPI_RAW where KPI_ID="${KPI_ID}"
	${db_result}=    Query Sybase database    select * from DIM_E_VOWIFI_KPI where KPI_ID = ${KPI_ID}
	Log    ${db_result}
	${db_result}=    convert to string    ${db_result}
	should contain    ${db_result}    ${KPI_NAME}
	
set logs to finest for
	[Arguments]    ${pkgName}
	Wait Until Element Is Visible    xpath:(//select[@name="logLevel:${pkgName}"])    300
	Click element    xpath:(//select[@name="logLevel:${pkgName}"])
	sleep    3
	Wait Until Element Is Visible    xpath:(//select[@name="logLevel:${pkgName}"]//option[@value="FINEST"])    300
	Click element    xpath:(//select[@name="logLevel:${pkgName}"]//option[@value="FINEST"])	
	
Trigger the interfaces
	set logs to finest for    INTF_CV_CSCF_CSCF-eniq_oss_1
	set logs to finest for    INTF_CV_DIM_ACM_CONFIG-eniq_oss_1
	set logs to finest for    INTF_CV_DIM_MEASURE_CONTROL-eniq_oss_1
	set logs to finest for    INTF_CV_DIM_MEASURE_LIMITS-eniq_oss_1  
	set logs to finest for    INTF_CV_DIM_NODE_CONTROL-eniq_oss_1 
	set logs to finest for    INTF_CV_DIM_SEGMENT-eniq_oss_1
	set logs to finest for    INTF_CV_ERBS_EUTRANCELL-eniq_oss_1
	set logs to finest for    INTF_CV_ERBS_EUTRANCELL_ACM-eniq_oss_1
	set logs to finest for    INTF_CV_ERBS_EUTRANCELL_V-eniq_oss_1
	set logs to finest for    INTF_CV_ERBS_PMULINTERFERENCEREPORT_UL-eniq_oss_1
	set logs to finest for    INTF_CV_GGSN_PGW-eniq_oss_1
	set logs to finest for    INTF_CV_MSC_CNAXE-eniq_oss_1
	set logs to finest for    INTF_CV_MTAS_MTAS-eniq_oss_1
	set logs to finest for    INTF_CV_SBG_IMSGW-eniq_oss_1
	set logs to finest for    INTF_CV_SGSN_MME-eniq_oss_1
	
click on the button
	[Arguments]    ${button}
	Wait until page contains element    xpath://*[@value="${button}"]    timeout=300
	Click Element      xpath://*[@value="${button}"]
	wait for page to load
	capture page screenshot
	
save the changes made
	Wait until page contains element    xpath://*[@value="Save changes"]    timeout=2400
	Run keyword and ignore error    Click Element      xpath://*[@value="Save changes"]
	wait for page to load
	capture page screenshot
	
Verify the parser logs
	[Arguments]    ${path}    ${interface}
	element should be visible    xpath:(//*[contains(text(),'com.distocraft.dc5000.etl.information_store_parser.information_store_parser')])[1]      30
	element should be visible    xpath:(//*[contains(text(),'/eniq/data/pmdata/eniq_oss_1/InformationStore/${path}')])[1]    30
	element should be visible    xpath:(//*[contains(text(),'/eniq/data/etldata_/01/adapter_tmp/${path}/${interface}')])[1]      30
	element should be visible    xpath:(//*[contains(text(),'Start')])[4]      30
	element should be visible    xpath:(//*[contains(text(),'parsing')])[1]      30
	element should be visible    xpath:(//*[contains(text(),'processed')])[2]      30
	element should be visible    xpath:(//*[contains(text(),'parsed')])[5]      30		
	
Click on link
	[Arguments]    ${adapter}
	Wait Until Element Is Visible    xpath://*[contains(text(),'${adapter}')]    30
	Click Element    xpath://*[contains(text(),'${adapter}')]
	wait for page to load
	capture page screenshot
	
	
Verify that the table has data for this table
	[Arguments]    ${db_result}    
	Log    ${db_result}
	${db_result}=    convert to string    ${db_result}
	should contain    ${db_result}    eniq_oss_1
		

Verify the parser logs for SBG_IMSGW
	element should be visible    xpath:(//*[contains(text(),'com.distocraft.dc5000.etl.information_store_parser.information_store_parser')])[1]      30
	element should be visible    xpath:(//*[contains(text(),'/eniq/data/pmdata/eniq_oss_1/InformationStore/dc_cv_imsgw_sbg')])[1]    30
	element should be visible    xpath:(//*[contains(text(),'/eniq/data/etldata_/01/adapter_tmp/dc_cv_sbg_imsgw/INTF_CV_SBG_IMSGW-eniq_oss_1')])[1]      30
	element should be visible    xpath:(//*[contains(text(),'Start')])[4]      30
	element should be visible    xpath:(//*[contains(text(),'parsing')])[1]      30
	element should be visible    xpath:(//*[contains(text(),'processed')])[2]      30
	element should be visible    xpath:(//*[contains(text(),'parsed')])[5]      30												 