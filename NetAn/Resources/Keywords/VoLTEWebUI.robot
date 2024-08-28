*** Keywords ***

open volte analysis
    ${chrome_options}=    Evaluate    sys.modules['selenium.webdriver'].ChromeOptions()      sys
	Call Method    ${chrome_options}    add_argument    --ignore-certificate-errors
	Create Webdriver    Chrome    executable_path=${EXEC_DIR}/ENIQ_TC_Automation/NetAn/Resources/Drivers/chromedriver.exe      chrome_options=${chrome_options}
    Go To    ${base_url}   
    Maximize Browser Window
    Sleep    3
    Selenium2Library.Input Text    name:username    Administrator
    Selenium2Library.Input Text    name:password    Ericsson01
    Click Element    class:LoginButton
    Sleep    3
    Go To    ${base_url}${volte_url}
    sleep    10
    ${IsElementVisible}=    Run Keyword And Return Status    Element Should not be Visible    xpath://div[contains(text(),'Missing Data')]
	Run Keyword If    ${IsElementVisible} is ${FALSE}   Close missing data window
	sleep    30
    wait for page to load
    
Close missing data window
	Wait Until Page Contains Element      xpath://span[contains(text(),'Apply to all inaccessible data tables in this analysis')]     timeout=150
    Click Element    xpath://span[contains(text(),'Apply to all inaccessible data tables in this analysis')]
    sleep    5
    Wait Until Page Contains Element      xpath://button[contains(text(),'OK')]     timeout=150
    Click Element    xpath://button[contains(text(),'OK')]

wait for page to load
    Sleep   5s
    Wait Until Element Is Not Visible     class:sfx_progress-bar-container_1118        timeout=2400
    Sleep   3s   
    Wait Until Element Is Not Visible     class:sfx_progress-bar-container_1118        timeout=2400
    Sleep   3s
    
   
Make selections in KPI
	[Arguments]    ${node}
	IF    "${node}" == "SBG"
		SikuliLibrary.Click    ${IMAGE_DIR}\\sbgKPI.PNG
		sleep    2
		SikuliLibrary.Click    ${IMAGE_DIR}\\sbgKPI1.PNG
		sleep    3
	ELSE IF    "${node}" == "MTAS"
		SikuliLibrary.Click    ${IMAGE_DIR}\\mtasKPI.PNG
		sleep    2
		SikuliLibrary.Click    ${IMAGE_DIR}\\selectDays1.PNG
		sleep    3
	ELSE IF    "${node}" == "GGSN"
		SikuliLibrary.Click    ${IMAGE_DIR}\\ggsnKPI.PNG
		sleep    2
		SikuliLibrary.Click    ${IMAGE_DIR}\\sbgKPI1.PNG
		sleep    3
	ELSE IF    "${node}" == "ERBS"
		SikuliLibrary.Click    ${IMAGE_DIR}\\mtasKPI.PNG
		sleep    4
		SikuliLibrary.Click    ${IMAGE_DIR}\\erbsKPI1.PNG
		sleep    3
	ELSE IF    "${node}" == "MSC"
		SikuliLibrary.Click    ${IMAGE_DIR}\\ggsnKPI.PNG
		sleep    4
		SikuliLibrary.Click    ${IMAGE_DIR}\\erbsKPI1.PNG
		sleep    3
	ELSE IF    "${node}" == "SGSN"
		SikuliLibrary.Click    ${IMAGE_DIR}\\ggsnKPI.PNG
		sleep    4
		SikuliLibrary.Click    ${IMAGE_DIR}\\erbsKPI1.PNG
		sleep    3
	ELSE IF    "${node}" == "CSCF"
		SikuliLibrary.Click    ${IMAGE_DIR}\\ggsnKPI.PNG
		sleep    4
		SikuliLibrary.Click    ${IMAGE_DIR}\\erbsKPI1.PNG
		sleep    3
	END
	wait for page to load
	capture page screenshot
	
click on Home button if not in volte home page
	sleep    3
	${pageTitle}=    Selenium2Library.Get text    xpath: //*[@class="sfx_page-title_219"]
	IF    "${pageTitle}" != "Start"
		Click element    xpath: //*[@title="Home"] 
		Sleep     10s 
    END
    wait for page to load
	capture page screenshot
    
click on s10 Home button if not in VoLTE home page
	sleep    3
	${pageTitle}=    Selenium2Library.Get text    xpath: //*[@class="sfx_page-title_214"]
	IF    "${pageTitle}" != "Start"
		Click element    xpath: //*[@title="Home"]  
    END
    wait for page to load
	capture page screenshot
    
select days to compare
	[Arguments]    ${nodeName}
	IF    "${nodeName}" == "SBG" or "${nodeName}" == "MTAS" or "${nodeName}" == "GGSN" or "${nodeName}" == "ERBS" or "${nodeName}" == "MSC" or "${nodeName}" == "SGSN" or "${nodeName}" == "CSCF"
		SikuliLibrary.Click    ${IMAGE_DIR}\\selectDays1.PNG
	END
    wait for page to load
	capture page screenshot
	
Enable the columns
	[Arguments]    ${column1}    ${column2}
	Wait Until Element Is Visible     xpath: //*[@title="Viewing"]    300
	sleep    2
    Click element     xpath: //*[@title="Viewing"]
    Wait Until Element Is Visible     xpath: //*[@title="Editing"]    300
    Click element     xpath: //*[@title="Editing"]
    sleep    2
    SikuliLibrary.Click    ${IMAGE_DIR}\\changeOK.PNG
    sleep    2
    ${exists}=    SikuliLibrary.Exists    ${IMAGE_DIR}\\filtersWindow.PNG    30
    Log    ${exists}
    IF    "${exists}" != "True"
    	Wait Until Element Is Visible     xpath: //*[@id="Spotfire.FilterPanel"]    300
    	Click element     xpath: //*[@id="Spotfire.FilterPanel"]
    END
    SikuliLibrary.Click    ${IMAGE_DIR}\\searchBar.PNG
    SikuliLibrary.Input Text    ${IMAGE_DIR}\\searchBar.PNG    MeasureValue
    SikuliLibrary.Click    ${IMAGE_DIR}\\searchGo.PNG
    sleep    2    
    Wait Until Element Is Visible     xpath: //*[@id="b79e01cf-4718-494a-9c8c-6eb661a0091c"]/div[1]/label    30
    Click element     xpath: //*[@id="b79e01cf-4718-494a-9c8c-6eb661a0091c"]/div[1]/label
    sleep    2
    SikuliLibrary.Click    ${IMAGE_DIR}\\closeFilters.PNG
    #SikuliLibrary.Right Click    ${IMAGE_DIR}\\table1.PNG
    Mouse Over    xpath: //div[@class="sf-element sf-element-visual-content sfc-table"]
    Click element     xpath: //*[@title="Properties"]
    sleep    2
    Click element     xpath: //*[@id="exp2"]
    click on button value    Select columns...
    sleep    2
    Click element     xpath: //*[@title="${column1}"]
    sleep    2
    Click element     xpath: //button[@title="Add"]
    sleep    2
    Click element     xpath: //*[@title="${Column2}"]
    sleep    2
    Click element     xpath: //button[@title="Add"]
    sleep    2
    Click element     xpath: //*[@title="MeasureValue"]
    sleep    2
    Click on button     1    Move\ down
    sleep    1
    Click on button     1    Move\ down
    sleep    2
    SikuliLibrary.Click    ${IMAGE_DIR}\\closeButton.PNG
    sleep    2
    SikuliLibrary.Click    ${IMAGE_DIR}\\blackCloseButton.PNG
    sleep    2
    wait for page to load
	capture page screenshot
		
Click on button
	[Arguments]    ${n}    ${buttonName}	
	${element}=    Get WebElements    xpath: //*[@title="${buttonName}"]
	FOR    ${i}    IN RANGE    0    ${n}
		Click element    ${element}
    END
    wait for page to load
	capture page screenshot
	
click on VoLTE Reset button
	Click on the scroll down button    0    15
	Wait Until Element Is Visible     xpath: //*[@title="Reset"]    300
    Click element     xpath: //*[@title="Reset"]
    wait for page to load
	capture page screenshot
    
recording nodeName, measureName, measureObject, dateTime and measureValue
	${dateTime}=    Selenium2Library.Get text  xpath: //*[@class="sf-element-table-cell flex-justify-start flex-align-start \ sfc-value-cell sfpc-odd-column sfpc-odd-row"][2]
	Log    ${dateTime}
	${nodeName}=    Selenium2Library.Get text  xpath: //*[@class="sf-element-table-cell flex-justify-start flex-align-start \ sfc-value-cell sfpc-even-column sfpc-odd-row"][5]
	Log    ${nodeName}
	${measureName}=    Selenium2Library.Get text  xpath: //*[@class="sf-element-table-cell flex-justify-start flex-align-start \ sfc-value-cell sfpc-odd-column sfpc-odd-row"][3]
	Log    ${measureName}
	${measureObject}=    Selenium2Library.Get text  xpath: //*[@class="sf-element-table-cell flex-justify-start flex-align-start \ sfc-value-cell sfpc-odd-column sfpc-odd-row"][4]
	Log    ${measureObject}
	#Click on horizontal scroll button in VoLTE    20    0
	${measureValue}=    Selenium2Library.Get text  xpath: //*[@class="sf-element-table-cell flex-justify-end flex-align-start \ sfc-value-cell sfpc-even-column sfpc-odd-row"]
	Log    ${measureValue}
	[Return]    ${nodeName}    ${measureName}    ${measureObject}    ${dateTime}    ${measureValue}
    wait for page to load
	capture page screenshot
	
recording nodeName, measureName, measureObject, dateTime and measureValue for erbs
	${dateTime}=    Selenium2Library.Get text  xpath: //*[@class="sf-element-table-cell flex-justify-start flex-align-start \ sfc-value-cell sfpc-odd-column sfpc-odd-row"][2]
	Log    ${dateTime}
	${nodeName}=    Selenium2Library.Get text  xpath: //*[@class="sf-element-table-cell flex-justify-start flex-align-start \ sfc-value-cell sfpc-even-column sfpc-odd-row"][5]
	Log    ${nodeName}
	${measureName}=    Selenium2Library.Get text  xpath: //*[@class="sf-element-table-cell flex-justify-start flex-align-start \ sfc-value-cell sfpc-odd-column sfpc-odd-row"][3]
	Log    ${measureName}
	${cellFDN}=    Selenium2Library.Get text  xpath: //*[@class="sf-element-table-cell flex-justify-start flex-align-start \ sfc-value-cell sfpc-even-column sfpc-odd-row"][4]
	Log    ${cellFDN}
	#Click on horizontal scroll button in VoLTE    20    0
	${measureValue}=    Selenium2Library.Get text  xpath: //*[@class="sf-element-table-cell flex-justify-end flex-align-start \ sfc-value-cell sfpc-even-column sfpc-odd-row"]
	Log    ${measureValue}
	[Return]    ${nodeName}    ${measureName}    ${cellFDN}    ${dateTime}    ${measureValue}
    wait for page to load
	capture page screenshot
	
Click on horizontal scroll button in VoLTE
	[Arguments]    ${n}    ${instance}	
	sleep    2
	${element}=    Get WebElements    xpath: /html/body/div/div[2]/div/div[1]/div/div/div[2]/div/div/div/div/div/div/div/div/div[1]/div[1]/div/div/div[1]/div/div[3]/div[3]
	${scroll_button}=    Get from list    ${element}    ${instance}
	FOR    ${i}    IN RANGE    0    ${n}
		Click element    ${scroll_button}
    END
    wait for page to load
	capture page screenshot	
	
Verifying the headings of charts
    ${pageTitle}=    Selenium2Library.Get text    xpath: //*[@title="Dedicated Bearer Activation Success"]
    Should Start with    ${pageTitle}    Dedicated Bearer Activation Success 
    ${pageTitle1}=    Selenium2Library.Get text    xpath: //*[@title="E-RAB Retainability Abnormal Releases"]
    Should Start with    ${pageTitle1}    E-RAB Retainability Abnormal Releases
    wait for page to load
	capture page screenshot
    
Making selection on graph
    [Arguments]    ${graphName}
    Selenium2Library.Drag And Drop by Offset 	xpath:(//div[@class="sf-element sf-element-canvas-visualization"])[2]    150    -50
    wait for page to load
	capture page screenshot    
    
Checking marked value
	sleep    3
	${markedValue}=    Selenium2Library.Get text    xpath: //*[@class="sfx_label_223"][2]
    log    ${markedValue}
    wait for page to load
	capture page screenshot
        
Marked value should be 0
	sleep    3
	${markedValue}=    Selenium2Library.Get text    xpath: //*[@class="sfx_label_223"][2]
    log    ${markedValue}
    should contain    ${markedValue}    0 marked
    wait for page to load
	capture page screenshot
	
Select KPI
	sleep    3
	Wait Until Element Is Visible     xpath: //*[@class="tableRed"]    300
    Click element     xpath: //*[@class="tableRed"]
    sleep    3
    wait for page to load
	capture page screenshot
    
first 10 columns should have data
	sleep    2
	selenium2library.Drag And Drop by offset    xpath:(//div[@class="sf-element sf-element-visual-content sfc-table"])    100    -200
	sleep    5s
	@{elements}=       Get WebElements       xpath: //div[@class='sfx_label_223']
	${text}=    Selenium2Library.Get text    ${elements}[2]
	@{list}=      Split string         ${text}
	${columns}=     Convert to Integer      ${list}[0]
	log    ${columns}
	Skip If    ${columns} <= 10    
    sleep    2
    wait for page to load
	capture page screenshot
    
Selecting the SBG and MOID
    [Arguments]      ${sbg}       ${moid}
	sleep    3
	Wait Until Element Is Visible     xpath: //*[@title="${sbg}"]    300
    Click element     xpath: //*[@title="${sbg}"]
    ${sbg}=    Selenium2Library.Get text    xpath: //*[@class="sf-element-list-box-item sfpc-selected"]
    sleep    3
    Wait Until Element Is Visible     xpath: //*[@title="${moid}"]    300
    Click element     xpath: //*[@title="${moid}"]    
    sleep    3
    wait for page to load
	capture page screenshot
    
Selected MOID should come under relevant NetId
	[Arguments]    ${sbg}       ${moid}
	sleep    3
	${sbg1}=    Selenium2Library.Get text    xpath: //*[@id="c4f00e2f7283438e8252f5b72c188fbe"]
	log    ${sbg1}
	Should be equal    ${sbg}    ${sbg1}
	${moid1}=    Selenium2Library.Get text    xpath: //*[@id="a581e3bef7b54dd082b370fd5d4faed2"]
	log    ${moid1}
	Should be equal    ${moid}    ${moid1}
    wait for page to load
	capture page screenshot
	
Relevant section should be empty
    Sleep     5s
	${sbg}=    Selenium2Library.Get text    xpath: //*[@id="c4f00e2f7283438e8252f5b72c188fbe"]
	log    ${sbg}
	Should be equal      "${sbg}"        " "      
	${moid}=    Selenium2Library.Get text    xpath: //*[@id="a581e3bef7b54dd082b370fd5d4faed2"]
	log    ${moid}
	Should be equal      "${moid}"        " "
    wait for page to load
	capture page screenshot  
	
Click on the scroll down button
    [Arguments]     ${button}    ${n}
    @{element}=    Get WebElements	    xpath: //div[@class="ScrollbarButton sf-element sf-element-scroll-bar-button sfpc-bottom"]
    ${scroll_button}=        Get from list     ${element}    ${button}
    FOR    ${i}    IN RANGE    0    ${n} 
           Run Keyword and Ignore Error    Click element     ${scroll_button}           
    END
    wait for page to load
	capture page screenshot
	
get sql query from json file
    [Arguments]     ${json_file}     ${data}
    ${json}=    OperatingSystem.get file    ${json_file}
    &{object}=    Evaluate     json.loads('''${json}''')     json
    [return]       ${object}[${data}]
	
validate the page title as  
	[Arguments]     ${expectedText}
	sleep    5
    ${text}=    Selenium2Library.Get text  xpath: //*[@class='sfx_page-title_214']
    Log    ${text}
    Should contain     ${expectedText}    ${text}
    wait for page to load
	capture page screenshot  
    
validate page title as  
	[Arguments]     ${expectedText}
	sleep    5
    ${text}=    Selenium2Library.Get text  xpath: //*[@class="sfx_page-title_219"]
    Log    ${text}
    Should contain     ${expectedText}    ${text} 
    wait for page to load
	capture page screenshot
	
click on button value
	[Arguments]    ${pageTitle}
	sleep     5
	Wait Until Element Is Visible     xpath: //*[@value='${pageTitle}']    300
    Click element     xpath: //*[@value='${pageTitle}']
    wait for page to load
	capture page screenshot
    
click on button title
	[Arguments]    ${pageTitle}
	sleep     5
	Wait Until Element Is Visible     xpath: //*[@title='${pageTitle}']    300
    Click element     xpath: //*[@title='${pageTitle}']
    sleep     5s
    wait for page to load
	capture page screenshot
	
####UPDATES TO TEST CASES####

Select the KPIs
	SikuliLibrary.Click    ${IMAGE_DIR}\\kpiSelection.PNG   
	sleep    5
    wait for page to load
    capture page screenshot
    
select Days to compare from Daily Breakdown page
	SikuliLibrary.Click    ${IMAGE_DIR}\\selectDays1.PNG   
	wait for page to load
    capture page screenshot	
    
Select the Worst Performing Nodes
	Selenium2Library.Drag And Drop by Offset 	xpath:/html/body/div/div[2]/div/div[1]/div/div/div[2]/div/div/div/div/div/div/div/div/div[4]/div[1]/div/div/div[1]/div[2]    160    100
    wait for page to load
    capture page screenshot
    
Verify that the Graph is visible
	Element should be visible    xpath://*[@class="sf-element-canvas-image sfc-transition-background"]
	wait for page to load
    capture page screenshot
    
Verify that the marked value is greater than 0
	${txt}=    Selenium2Library.get text    xpath://div[@class="sfx_label_223"][2]
	should not be equal    ${txt}    0 rows
	wait for page to load
    capture page screenshot
	
replace the values in the query for ERBS
	[Arguments]    ${sql_query}    ${nodeName}    ${measureName}    ${cellFDN}    ${dateTime}
	${dateTime}=    Remove AMPM from dateTime    ${dateTime}
	${Date_Val}    Convert Date    ${dateTime}    result_format=%Y-%m-%d %H:%M:%S    date_format=%m/%d/%Y %H:%M:%S
	${sql_query}=     Replace String    ${sql_query}    @time      \'${Date_Val}\'
    ${sql_query}=     Replace String    ${sql_query}    @node      \'${nodeName}\'
    ${sql_query}=     Replace String    ${sql_query}    @name      \'${measureName}\'
    ${sql_query}=     Replace String    ${sql_query}    @cell_fdn      \'${cellFDN}\'
    log    ${sql_query}
    [Return]    ${sql_query}
	wait for page to load
    capture page screenshot
    
replace the values in the query
	[Arguments]    ${sql_query}    ${nodeName}    ${measureName}    ${cellFDN}    ${dateTime}
	${dateTime}=    Remove AMPM from dateTime    ${dateTime}
	${Date_Val}    Convert Date    ${dateTime}    result_format=%Y-%m-%d %H:%M:%S    date_format=%m/%d/%Y %H:%M:%S
	${sql_query}=     Replace String    ${sql_query}    @time      \'${Date_Val}\'
    ${sql_query}=     Replace String    ${sql_query}    @node      \'${nodeName}\'
    ${sql_query}=     Replace String    ${sql_query}    @name      \'${measureName}\'
    ${sql_query}=     Replace String    ${sql_query}    @cell_fdn      \'${cellFDN}\'
    log    ${sql_query}
    [Return]    ${sql_query}
	wait for page to load
    capture page screenshot
    
Select the days to compare
	Selenium2Library.Drag And Drop by Offset 	xpath://div[@class="sf-element-canvas-image sfc-transition-background"][1]    160    100
	wait for page to load
    capture page screenshot   
    
replace values in the query
	[Arguments]    ${sql_query}    ${nodeName}    ${measureName}    ${measuredObject}    ${dateTime}
	${dateTime}=    Remove AMPM from dateTime    ${dateTime}
	${Date_Val}    Convert Date    ${dateTime}    result_format=%Y-%m-%d %H:%M:%S    date_format=%m/%d/%Y %H:%M:%S
	${sql_query}=     Replace String    ${sql_query}    @time      \'${Date_Val}\'
    ${sql_query}=     Replace String    ${sql_query}    @node      \'${nodeName}\'
    ${sql_query}=     Replace String    ${sql_query}    @name      \'${measureName}\'
    ${sql_query}=     Replace String    ${sql_query}    @measuredObject      \'${measuredObject}\'
    log    ${sql_query}
    [Return]    ${sql_query}
	wait for page to load
    capture page screenshot
    
click on
	[Arguments]    ${nodeName}
	IF    "${nodeName}" == "SBG"
		Wait Until Element Is Visible     xpath: //*[@id="nodeTable1"]    300
    	Click element     xpath: //*[@id="nodeTable1"]
    ELSE IF    "${nodeName}" == "MTAS"
		Wait Until Element Is Visible     xpath: //*[@id="nodeTable6"]    300
    	Click element     xpath: //*[@id="nodeTable6"]
    ELSE IF    "${nodeName}" == "GGSN"
    	click on the scroll down button     3    23
		Wait Until Element Is Visible     xpath: //*[@id="nodeTable4"]    300
    	Click element     xpath: //*[@id="nodeTable4"]
    ELSE IF    "${nodeName}" == "ERBS"
		Wait Until Element Is Visible     xpath: //*[@id="nodeTable0"]    300
    	Click element     xpath: //*[@id="nodeTable0"]
    ELSE IF    "${nodeName}" == "MSC"
    	click on the scroll down button     3    23
    	Wait Until Element Is Visible     xpath: //*[@id="nodeTable2"]    300
    	Click element     xpath: //*[@id="nodeTable2"]
    ELSE IF    "${nodeName}" == "SGSN"
    	Wait Until Element Is Visible     xpath: //*[@id="nodeTable5"]    300
    	Click element     xpath: //*[@id="nodeTable5"]
    ELSE IF    "${nodeName}" == "CSCF"
    	click on the scroll down button     3    23
		Wait Until Element Is Visible     xpath: //*[@id="nodeTable3"]    300
    	Click element     xpath: //*[@id="nodeTable3"]
    END
    wait for page to load
	capture page screenshot
	
click on tab
	[Arguments]    ${tabName}
	IF    "${tabName}" == "SRVCC"
		Wait Until Element Is Visible     xpath: //*[@id="table6"]    300
    	Click element     xpath: //*[@id="table6"]
    ELSE IF    "${tabName}" == "Accessibility of Voice/Video Service"
		Wait Until Element Is Visible     xpath: //*[@id="table0"]    300
    	Click element     xpath: //*[@id="table0"]
    ELSE IF    "${tabName}" == "Emergency or Priority Call"
		Wait Until Element Is Visible     xpath: //*[@id="table3"]    300
    	Click element     xpath: //*[@id="table3"]
    ELSE IF    "${tabName}" == "VoLTE Service Attach and Registration"
		Wait Until Element Is Visible     xpath: //*[@id="table1"]    300
    	Click element     xpath: //*[@id="table1"]
    ELSE IF    "${tabName}" == "Retainability of Voice/Video Service"
    	Click on the scroll down button    1    25
		Wait Until Element Is Visible     xpath: //*[@id="table4"]    300
    	Click element     xpath: //*[@id="table4"]
    ELSE IF    "${tabName}" == "Integrity of Voice/Video Service"
    	Click on the scroll down button    0    25
		Wait Until Element Is Visible     xpath: //*[@id="table5"]    300
    	Click element     xpath: //*[@id="table5"]
    ELSE IF    "${tabName}" == "ICS call setup"
    	Click on the scroll down button    0    25
    	Wait Until Element Is Visible     xpath: //*[@id="table2"]    300
    	Click element     xpath: //*[@id="table2"]
    END
	wait for page to load
    capture page screenshot
    
recording nodeName, measureName, cellFDN, dateTime and measureValue for ERBS
	${measureValue}=    Selenium2Library.get text    xpath://*[@class="sf-element-table-cell flex-justify-end flex-align-start \ sfc-value-cell sfpc-even-column sfpc-odd-row"]
	Log    ${measureValue}
	${dateTime}=    Selenium2Library.Get text  xpath: //*[@class="sf-element-table-cell flex-justify-start flex-align-start \ sfc-value-cell sfpc-odd-column sfpc-odd-row"][2]
	Log    ${dateTime}
	${measureName}=    Selenium2Library.get text    xpath://*[@class="sf-element-table-cell flex-justify-start flex-align-start \ sfc-value-cell sfpc-even-column sfpc-odd-row"][3]
	Log    ${measureName}
	${nodeName}=    Selenium2Library.Get text  xpath: //*[@class="sf-element-table-cell flex-justify-start flex-align-start \ sfc-value-cell sfpc-even-column sfpc-odd-row"][2]
	Log    ${nodeName}
	${cellFDN}=    Selenium2Library.Get text  xpath: //div[@class="sf-element-table-cell flex-justify-start flex-align-start \ sfc-value-cell sfpc-odd-column sfpc-even-row"][5]
	Log    ${cellFDN}
	[Return]    ${nodeName}    ${measureName}    ${cellFDN}    ${dateTime}    ${measureValue}
	wait for page to load
    capture page screenshot
    
recording nodeName, measureName, cellFDN, dateTime and measureValue
	${measureValue}=    Selenium2Library.get text    xpath://*[@class="sf-element-table-cell flex-justify-end flex-align-start \ sfc-value-cell sfpc-even-column sfpc-odd-row"]
	Log    ${measureValue}
	${dateTime}=    Selenium2Library.Get text  xpath: //*[@class="sf-element-table-cell flex-justify-start flex-align-start \ sfc-value-cell sfpc-odd-column sfpc-odd-row"][2]
	Log    ${dateTime}
	${measureName}=    Selenium2Library.get text    xpath://*[@class="sf-element-table-cell flex-justify-start flex-align-start \ sfc-value-cell sfpc-even-column sfpc-odd-row"][3]
	Log    ${measureName}
	${nodeName}=    Selenium2Library.Get text  xpath: //*[@class="sf-element-table-cell flex-justify-start flex-align-start \ sfc-value-cell sfpc-even-column sfpc-odd-row"][2]
	Log    ${nodeName}
	${cellFDN}=    Selenium2Library.Get text  xpath: //div[@class="sf-element-table-cell flex-justify-start flex-align-start \ sfc-value-cell sfpc-odd-column sfpc-even-row"][5]
	Log    ${cellFDN}
	[Return]    ${nodeName}    ${measureName}    ${cellFDN}    ${dateTime}    ${measureValue}
	wait for page to load
    capture page screenshot
    
recording the nodeName, measureName, measureObject, dateTime and measureValue
	${measureValue}=    Selenium2Library.get text    xpath://*[@class="sf-element-table-cell flex-justify-end flex-align-start \ sfc-value-cell sfpc-even-column sfpc-odd-row"]
	Log    ${measureValue}
	${dateTime}=    Selenium2Library.Get text  xpath: //*[@class="sf-element-table-cell flex-justify-start flex-align-start \ sfc-value-cell sfpc-odd-column sfpc-odd-row"][2]
	Log    ${dateTime}
	${measuredObject}=    Selenium2Library.get text    xpath://*[@class="sf-element-table-cell flex-justify-start flex-align-start \ sfc-value-cell sfpc-even-column sfpc-odd-row"][4]
	Log    ${measuredObject}
	${nodeName}=    Selenium2Library.Get text  xpath: //*[@class="sf-element-table-cell flex-justify-start flex-align-start \ sfc-value-cell sfpc-even-column sfpc-odd-row"][2]
	Log    ${nodeName}
	${measureName}=    Selenium2Library.Get text  xpath://*[@class="sf-element-table-cell flex-justify-start flex-align-start \ sfc-value-cell sfpc-even-column sfpc-odd-row"][3]
	Log    ${measureName}
	[Return]    ${nodeName}    ${measureName}    ${measuredObject}    ${dateTime}    ${measureValue}
	wait for page to load
    capture page screenshot
    
Match UI with DB VoLTE Value
	[Arguments]    ${uiValue}    ${DB_Value}
	Log    ${DB_Value}
	Log    ${uiValue}
	${DB_Value}=    Remove everything after decimal point from measure value    ${DB_Value}
	${uiValue}=    Remove everything after decimal point from measure value    ${uiValue}
	Compare UI and DB values    ${uiValue}     ${DB_Value}
    wait for page to load
	capture page screenshot
	
Compare UI and DB values
	[Arguments]       ${UI}     ${DB}
    Log    ${UI}
    Log    ${DB}
    Should Be Equal    ${UI}    ${DB}
    wait for page to load
	capture page screenshot
    
Select the KPIs for VoLTE Service Attach and Registration
	SikuliLibrary.Click    ${IMAGE_DIR}\\greenSelection.PNG   
	sleep    5
    wait for page to load
    capture page screenshot
    
Select the KPIs for SRVCC
	SikuliLibrary.Click    ${IMAGE_DIR}\\greenSelection.PNG   
	sleep    5
    wait for page to load
    capture page screenshot
 
Select the KPIs for MSC
	SikuliLibrary.Click    ${IMAGE_DIR}\\greenSelection.PNG   
	sleep    5
    wait for page to load
    capture page screenshot
    
Select the KPIs for GGSN
	SikuliLibrary.Click    ${IMAGE_DIR}\\greenSelection.PNG   
	sleep    5
    wait for page to load
    capture page screenshot
    
Select the KPIs for CSCF
	SikuliLibrary.Click    ${IMAGE_DIR}\\greenSelection.PNG   
	sleep    5
    wait for page to load
    capture page screenshot
    
Select the KPIs for MTAS
	SikuliLibrary.Click    ${IMAGE_DIR}\\greenSelection.PNG   
	sleep    5
    wait for page to load
    capture page screenshot
    
Select the KPIs for SBG
	SikuliLibrary.Click    ${IMAGE_DIR}\\greenSelection.PNG   
	sleep    5
    wait for page to load
    capture page screenshot
    
Select the KPIs for Emergency or Priority Call
	SikuliLibrary.Click    ${IMAGE_DIR}\\greenSelection.PNG   
	sleep    5
    wait for page to load
    capture page screenshot
    
Select the KPIs for ICS Call setup
	SikuliLibrary.Click    ${IMAGE_DIR}\\greenSelection.PNG   
	sleep    5
    wait for page to load
    capture page screenshot

############################# UPDATES TO TEST CASES END #############################

Test teardown
    Capture page screenshot
    Close Browser
   
Go to home page if not already at home
	${pageTitle}=    Selenium2Library.Get text  xpath: //*[@class="sfx_page-title_219"]
	IF 		"${pageTitle}" != "Start"	
		Click element     xpath: //*[@title="Home"]
	END
	wait for page to load
	capture page screenshot
	
Make selections in the KPI
	sleep    3
	selenium2library.drag and drop by offset    xpath:(//div[@class="sf-element sf-element-visual sfc-tree-map sfc-trellis-visualization sfpc-first-row sfpc-first-column"])    150    -100
	sleep    5
	selenium2library.drag and drop by offset    xpath:(//div[@class="sf-element sf-element-visual sfc-tree-map sfc-trellis-visualization"])    150    -100
	wait for page to load
	capture page screenshot
	
select the days for comparison
	sleep    3
	selenium2library.drag and drop by offset    xpath:(//div[@class="sf-element sf-element-visual sfc-tree-map sfc-trellis-visualization sfpc-first-row sfpc-first-column"])    150    -100
	wait for page to load
	capture page screenshot