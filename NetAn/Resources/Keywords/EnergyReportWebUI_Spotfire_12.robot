*** Keywords ***

open energy report analysis
    ${chrome_options}=    Evaluate    sys.modules['selenium.webdriver'].ChromeOptions()      sys
	Call Method    ${chrome_options}    add_argument    --ignore-certificate-errors
	Create Webdriver    Chrome    executable_path=${EXEC_DIR}/ENIQ_TC_Automation/NetAn/Resources/Drivers/chromedriver.exe      chrome_options=${chrome_options}
    Go To    ${base_url}   
    Maximize Browser Window
    Sleep    5
    Selenium2Library.Input Text   xpath:(//input[@class="w-full pt-2 pb-2 pl-3 text-ellipsis pr-3 ng-untouched ng-pristine ng-invalid"])[1]    Administrator
    sleep    3
    Selenium2Library.Input Text   xpath:/html/body/tss-root/div/div/tss-login/div/div/form/tss-input[2]/div/div/input    Ericsson01
    sleep    3
    Click Element   xpath:/html/body/tss-root/div/div/tss-login/div/div/form/button
    Sleep    5
    Go To    ${base_url}${energyreport_url}
    sleep    40
    ${IsElementVisible}=    Run Keyword And Return Status    Element Should not be Visible    xpath://div[contains(text(),'Missing Data')]
	Run Keyword If    ${IsElementVisible} is ${FALSE}   Close missing data window
	sleep    60
    wait for page to load
    capture page screenshot
    
Close missing data window
	Wait Until Page Contains Element      xpath://span[contains(text(),'Apply to all inaccessible data tables in this analysis')]     timeout=150
    Click Element    xpath://span[contains(text(),'Apply to all inaccessible data tables in this analysis')]
    sleep    5
    Wait Until Page Contains Element      xpath://button[contains(text(),'OK')]     timeout=150
    Click Element    xpath://button[contains(text(),'OK')]
    wait for page to load
    capture page screenshot


	
	
	
	
	
	
verify that the Energy Report logo is visible
	sleep    5
	element should be visible    xpath:((//div[@class="HtmlTextArea sf-enable-selection sf-focusable"])//div//div//div//table//tbody//tr)[2]//td//img
	wait for page to load
	capture page screenshot
	
verify that the Network Analytics logo is visible
	sleep    5
	element should be visible    xpath:((//div[@class="HtmlTextArea sf-enable-selection sf-focusable"])//div//div//div//table//tbody//tr//td//p//img)[1]
	wait for page to load
	capture page screenshot
	
verify that the Settings and Reset icons are visible
	Click on the scroll down button    0   15														 
	sleep    2
	Element should be visible    xpath://*[@title="Reset All Filters and Markings"]    300
	sleep    2
	Element should be visible    xpath://*[@title="Settings"]
	wait for page to load
	capture page screenshot
	
verify the page title  
	[Arguments]     ${expectedText}
	wait for page to load
    ${text}=    Selenium2Library.Get text  xpath: //*[@class="sfx_page-title_375"]
    Log    ${text}
    ${status}=    run keyword and return status    Should contain     ${text}    ${expectedText}
    IF    "${status}"=="FALSE"
    	sleep    60
    	${text}=    Selenium2Library.Get text  xpath: //*[@class="sfx_page-title_375"]
    	Log    ${text}
    	Should contain     ${text}    ${expectedText}
    END
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
	
Test teardown
    Capture page screenshot
    Close Browser
    
Enter the number of data sources
	[Arguments]    ${number}
	Selenium2Library.Input text    xpath://*[@class="sf-element sf-element-control sfc-property sfc-text-box"]    ${number}
	wait for page to load
	capture page screenshot
	
Enter the data source
	[Arguments]    ${dataSource}
	sleep    2
	Selenium2Library.Clear element text    xpath:/html/body/div/div[2]/div/div[1]/div/div/div[2]/div/div/div/div/div/div/div/div/div[1]/div[1]/div/div[1]/p[5]/strong/font/span/textarea
	sleep    2
	Selenium2Library.Input text    xpath:/html/body/div/div[2]/div/div[1]/div/div/div[2]/div/div/div/div/div/div/div/div/div[1]/div[1]/div/div[1]/p[5]/strong/font/span/textarea     ${dataSource}
	wait for page to load
	capture page screenshot
    
click on button value
	[Arguments]    ${buttonValue}
	sleep     5
	Wait Until Element Is Visible     xpath: //*[@value='${buttonValue}']    300
    ${status}=    run keyword and return status    Click element     xpath: //*[@value='${buttonValue}']
    IF    "${status}"=="FALSE"
    	sleep    30
    	Click element     xpath: //*[@value='${buttonValue}']
    END
	wait for page to load
	capture page screenshot
	
Verify that the data source is added
	${Text}=    Selenium2Library.get text    xpath://span[@id="fdc2eb6caf244d7c801eb9bb0330623b"]							   
	Log    ${text}
	[Return]    ${text}
	wait for page to load
	capture page screenshot
	
verify the Energy Usage page header is visible
	${headerText}=    Selenium2Library.get text    xpath://*[@class="sf-element sf-element-visual sfc-text-area sfpc-first-row sfpc-first-column sfpc-last-column"]
	Log    ${headerText}
	[Return]    ${headerText}
	wait for page to load
	capture page screenshot
	
verify that four input panels are visible
	Element should be visible    xpath://*[@class="sf-element sf-element-visual sfc-text-area sfpc-first-column"]
	wait for page to load
	capture page screenshot
	
verify that four visual panels are visible
	sleep    2
	Element should be visible    xpath://div[@class="sf-element sf-element-visual sfc-line-chart sfc-trellis-visualization"]
	Element should be visible    xpath://div[@class="sf-element sf-element-visual sfc-bar-chart sfc-trellis-visualization"][2]
	Element should be visible    xpath://div[@class="sf-element sf-element-visual sfc-kpi-chart sfpc-last-column"]
	wait for page to load
	capture page screenshot
	
Verify titles of the graphs
	sleep    2
	Element should be visible    xpath://div[@title="Top 100 nodes with highest energy consumption – pmConsumedEnergy"]
	Element should be visible    xpath://div[@title="Data volume - downlink and uplink"]
	Element should be visible    xpath://div[@title="Energy consumption"]
	Element should be visible    xpath://div[@title="Top 100 nodes with hightest data volumes - \ downlink and uplink"]
	Element should be visible    xpath://div[@title="Data volume - downlink and uplink"]
	Element should be visible    xpath://div[@title="Data volume"]
	wait for page to load
	capture page screenshot
	

	
	
	
	
	
	
	
	
	
	
	
	
	
	
verify that the graph is visible for the selected RAT
	Element should be visible    xpath:(//div[@title="Top 100 nodes with highest energy consumption – pmConsumedEnergy"])
	wait for page to load
	capture page screenshot
	
verify 'Top 100 nodes - Data Volumes: Downlink and Uplink' graph is visible
	Element should be visible    xpath:(//div[@class="sf-element sf-element-canvas-visualization"])[2]
	wait for page to load
	capture page screenshot
	

	
	
	
	
	
	
	
verify that the Energy Consumption – pmConsumedEnergy has data
	Element should be visible    xpath:(//div[@class="sf-element sf-element-canvas-visualization"])[3]
	wait for page to load
	capture page screenshot
	
verify that 'Data Volume - Downlink and Uplink' chart is visible
	Element should be visible    xpath:(//div[@class="sf-element sf-element-canvas-visualization"])[4]
	wait for page to load
	capture page screenshot
	
verify that 'Energy Consumption' chart is visible
	Element should be visible    xpath://div[@class="sf-element sf-element-visual sfc-kpi-chart sfpc-last-column"][1]
	wait for page to load
	capture page screenshot
	
verify that 'Data Volume' chart is visible
	Element should be visible    xpath://div[@class="sf-element sf-element-visual sfc-kpi-chart sfpc-last-column"][2]
	wait for page to load
	capture page screenshot
	
validate the page header as Energy Meter (7 Days)
	Click on the scroll down button    3    1
	sleep    3
	SikuliLibrary.screen should contain    ${IMAGE_DIR}\\Energy_Report_Energy_Meters.PNG
	wait for page to load
	capture page screenshot
	
validate the graph title
	[Arguments]    ${graphTitle}
	Element should be visible    xpath://*[contains(text(),'${graphTitle}')]
	wait for page to load
	capture page screenshot
	
verify that the button is visible
	[Arguments]    ${buttonTitle}
	Element should be visible    xpath://*[@title="${buttonTitle}"]
	wait for page to load
	capture page screenshot
	
validate that the button is visible
	[Arguments]    ${buttonTitle}
	Element should be visible    xpath://*[@value="${buttonTitle}"]
	wait for page to load
	capture page screenshot
	
make selection on first graph
	Selenium2Library.Drag And Drop by Offset 	xpath://div[@class="sf-element sf-element-canvas-visualization"]    -200    -120
	wait for page to load
	capture page screenshot
	
verify that the bottom graph has data
	${value}=    Selenium2Library.get text    xpath://div[@class="sfx_label_379"][2]
	[Return]    ${value}
	should not be equal    ${value}    0 marked
	wait for page to load
	capture page screenshot
	
validate the page header as Energy Usage (Historical View - Up to 6 months)
	sleep    3
	Element should be visible    xpath:(//div[@class="HtmlTextArea sf-enable-selection sf-focusable"])[2]
	wait for page to load
	capture page screenshot
	
verify that the table is visible
	[Arguments]    ${tableTitle}
	Element should be visible    xpath://*[@title="${tableTitle}"]
	wait for page to load
	capture page screenshot
	
get nodes from current page
	[Arguments]    ${node1}    ${node2}
	Set ocr text read    True
	${text}=    SikuliLibrary.Get text
	Log    ${text}
	[Return]    ${text}
	should contain    ${text}    ${node1}
	should contain    ${text}    ${node2}
	wait for page to load
	capture page screenshot
	
verify that selected nodes are present in Data Volume chart
	[Arguments]    ${node1}    ${node2}
	Set ocr text read    True
	${text}=    SikuliLibrary.Get text
	Log    ${text}
	[Return]    ${text}
	should contain    ${text}    ${node1}
	should contain    ${text}    ${node2}
	wait for page to load
	capture page screenshot
	
verify that selected nodes are present in Energy Consumption chart
	[Arguments]    ${node1}    ${node2}
	Set ocr text read    True
	${text}=    SikuliLibrary.Get text
	Log    ${text}
	[Return]    ${text}
	should contain    ${text}    ${node1}
	should contain    ${text}    ${node2}
	wait for page to load
	capture page screenshot
	
#################### REMAINING LEGACY TEST CASES ####################
	
click on the button
	[Arguments]    ${pageTitle}
	sleep     5
	Wait Until Element Is Visible     xpath: //*[@title='${pageTitle}']    300
    ${status}=    run keyword and return status    Click element     xpath: //*[@title='${pageTitle}']
    IF    "${status}"=="FALSE"
    	sleep    30
    	Click element     xpath: //*[@title='${pageTitle}']
    END
	wait for page to load
	capture page screenshot
	
click on button
	[Arguments]    ${buttonValue}
	sleep     5
	Wait Until Element Is Visible     xpath: //*[@value='${buttonValue}']    300
    ${status}=    run keyword and return status    Click element     xpath: //*[@value='${buttonValue}']
    IF    "${status}"=="FALSE"
    	sleep    30
    	Click element     xpath: //*[@value='${buttonValue}']
    END
	wait for page to load
	capture page screenshot


	
	
	
	
	
select Energy Saving Feature
	[Arguments]    ${feature}
	Wait Until Element Is Visible     xpath://div[contains(text(),'${feature}')]    30
	Click Element       xpath://div[contains(text(),'${feature}')]
	wait for page to load
	capture page screenshot

select an area on the License Chart
	selenium2library.drag and drop by offset    xpath:(//div[@class="sf-element sf-element-canvas-visualization"])[1]    100    80	
	wait for page to load
	capture page screenshot
	
select an area on the pmdConsumedEnergy chart
	selenium2library.drag and drop by offset    xpath:(//div[@class="sf-element sf-element-canvas-visualization"])[1]    100    80	
	wait for page to load
	capture page screenshot
select an area on the energy saving usage cell chart
	selenium2library.drag and drop by offset    xpath:(//div[@class="sf-element sf-element-canvas-visualization"])[1]    300    150	
	wait for page to load
	capture page screenshot
	
verify that the list box is visible
	[Arguments]    ${title}
	Element should be visible    xpath://*[contains(text(),'${title}')]
	wait for page to load
	capture page screenshot
	
verify the graph title is present
	[Arguments]    ${title}
	Element should be visible    xpath://*[contains(text(),'${title}')]
	wait for page to load
	capture page screenshot	
	
select nodes on Node Details page
	[Arguments]    ${node}
	Wait Until Element Is Visible     xpath:(//div[@class="ScrollArea"])//div[contains(text(),'${node}')]    30
	Click Element       xpath:(//div[@class="ScrollArea"])//div[contains(text(),'${node}')]
	wait for page to load
	capture page screenshot
	
select threshold feature
	[Arguments]    ${feature}
	Wait Until Element Is Visible     xpath:(((//div[@class="sf-element-list-box sfc-scrollable"])[3]//div)[1]//div)[1]//div[contains(text(),'${feature}')]    30
	Click Element       xpath:(((//div[@class="sf-element-list-box sfc-scrollable"])[3]//div)[1]//div)[1]//div[contains(text(),'${feature}')]
	wait for page to load
	capture page screenshot
	
select a tile in Select Energy Consumed
	selenium2library.drag and drop by offset    xpath:(//div[@class="flex-item flex-container-vertical flex-inline-container flex-align-start flex-fill-vertical sf-kpi-tile"])[5]    100    100
	wait for page to load
	capture page screenshot	
	
select Total Downlink Volume
	Wait Until Element Is Visible     xpath:(//div[@class="KpiLayout"])[1]    30
	Click Element       xpath:(//div[@class="KpiLayout"])[1]
	wait for page to load
	capture page screenshot	
	
select an area on Energy consumption per date
	selenium2library.drag and drop by offset    xpath:(//div[@class="sf-element-canvas-image sfc-transition-background"])[1]    500    150    
	wait for page to load
	selenium2library.drag and drop by offset    xpath:(//div[@class="sf-element-canvas-image sfc-transition-background"])[1]    300    100
	wait for page to load
	capture page screenshot										 
	
select an area on Uplink volume, downlink volume per date
	selenium2library.drag and drop by offset    xpath:(//div[@class="sf-element-canvas-image sfc-transition-background"])[2]    300    -80    
	wait for page to load
	capture page screenshot

#################### REMAINING LEGACY TEST CASES END ####################	
	
verify that the selected nodes have data in historical trend page
	Wait Until Page Contains Element      xpath:(//div[@class="sfx_label_379"])[1]    300
	sleep    2
	${text}=    selenium2library.get text    xpath:(//div[@class="sfx_label_379"])[1]
	Log    ${text}
	should not be equal    ${text}    0 of 0 rows
	wait for page to load
	capture page screenshot
	
verify that the table Energy Saving Feature Thresholds is visible
    element should be visible    xpath:(//div[@class="flex-item flex-container-horizontal flex-justify-start flex-align-center"])[2]
    wait for page to load
	capture page screenshot
	

	
	
	
	
	
	
select an Energy Saving Feature
	Wait Until Element Is Visible     xpath:((//div[@class="ListItems"])[2]//div[@class="sf-element-list-box-item"])[1]    30
	Click Element       xpath:((//div[@class="ListItems"])[2]//div[@class="sf-element-list-box-item"])[1]
	wait for page to load
	capture page screenshot
	
select a threshold feature
	Wait Until Element Is Visible     xpath:(((//div[@class="ListItems"])[3])//div[@class="sf-element-list-box-item"])[1]    30
	Click Element       xpath:(((//div[@class="ListItems"])[3])//div[@class="sf-element-list-box-item"])[1]
	wait for page to load
	
################################################## MR EQEV-115143 ##################################################	

verify that Energy Report opened without errors
	verify the page title    Home
	click on the scroll down button    0    20
	validate that the button is visible    Energy Usage
	validate that the button is visible    Energy Saving Features
	validate that the button is visible    Network Summary
	wait for page to load
	capture page screenshot
	
Change the View to
	[Arguments]    ${view}
	Wait Until Page Contains Element      xpath://div[@class="sfx_simple-dropdown_935 sfx_enabled_934"]     timeout=15
	Click Element      xpath://div[@class="sfx_simple-dropdown_935 sfx_enabled_934"]
	sleep    5
	Wait Until Page Contains Element      xpath://div[@title="${view}"]     timeout=15
	Click Element      xpath://div[@title="${view}"]
	wait for page to load
	capture page screenshot
	
change to page navigation to
	[Arguments]    ${mode}
	Wait Until Page Contains Element      xpath:(//div[@class="sfx_page-title_375"])     timeout=30
	open context menu      xpath:(//div[@class="sfx_page-title_375"])
	sleep    2
	Wait Until Page Contains Element      xpath:(//div[@class="contextMenuItemLabel"])[1]     timeout=30
	Click Element      xpath:(//div[@class="contextMenuItemLabel"])[1]
	sleep    2
	Wait Until Page Contains Element      xpath:(//div[@title="${mode}"])     timeout=30
	Click Element      xpath:(//div[@title="${mode}"])
	wait for page to load
	capture page screenshot
	
Change the Visualization type to Table
	sleep    5
	Wait Until Page Contains Element      xpath://div[@class="sfx_button_303 sfx_button-enabled_302"][1]     timeout=15
	Click Element      xpath://div[@class="sfx_button_303 sfx_button-enabled_302"][1]
	wait for page to load
	capture page screenshot
	
Select the data table
	[Arguments]    ${instance}    ${n}    ${table}
	Wait Until Page Contains Element      xpath:(//div[@class="sf-element sf-element-axis-tray-item sf-nowrap itemEditable"])     timeout=30
	Click Element      xpath:(//div[@class="sf-element sf-element-axis-tray-item sf-nowrap itemEditable"])
	sleep    5
	click on the scroll down button    ${instance}    ${n}
	click on the button    ${table}
	wait for page to load
	capture page screenshot	
	
read the number of rows retrieved
	Wait Until Page Contains Element      xpath:(//div[@class="sfx_label_379"])[1]    300
	sleep    2
	${text}=    Selenium2Library.Get text    xpath:(//div[@class="sfx_label_379"])[1]
	Log    ${text}
	[Return]    ${text}
	wait for page to load
	capture page screenshot	
	
install the energy report analysis
    [Arguments]    ${version}
    ${chrome_options}=    Evaluate    sys.modules['selenium.webdriver'].ChromeOptions()      sys
    Call Method    ${chrome_options}    add_argument    --ignore-certificate-errors
    Create Webdriver    Chrome    executable_path=${EXEC_DIR}/ENIQ_TC_Automation/NetAn/Resources/Drivers/chromedriver.exe      chrome_options=${chrome_options}
    Go To    https://arm1s11-eiffel013.eiffel.gic.ericsson.se:8443/nexus/content/repositories/assure-releases/com/ericsson/eniq/netanserver/features/network-analytics-energy-report/${version}/network-analytics-energy-report-${version}.zip
    sleep    20
    close browser
    Remove file    ${EXEC_DIR}\\ENIQ_TC_Automation\\NetAn\\Other\\Files\\reinstallEnergyReport.ps1
    Append to file    ${EXEC_DIR}\\ENIQ_TC_Automation\\NetAn\\Other\\Files\\reinstallEnergyReport.ps1    cd C:\\Users\\Administrator\\Downloads\n
    Append to file    ${EXEC_DIR}\\ENIQ_TC_Automation\\NetAn\\Other\\Files\\reinstallEnergyReport.ps1    Install-feature .\\network-analytics-energy-report-${version}.zip -force
    ${ps_file}    Set Variable    ${EXEC_DIR}\\ENIQ_TC_Automation\\NetAn\\Other\\Files\\reinstallEnergyReport.ps1
    ${result}=    Run    Powershell -NoProfile -ExecutionPolicy Unrestricted -Command "& {Start-Process PowerShell -ArgumentList '-NoProfile -ExecutionPolicy Unrestricted -File ""${ps_file}""' -Verb RunAs}";
    sleep    90
	
execute the command
	[Arguments]    ${command}
    Write    ${command}
    ${output}=    Read    delay=2s
    Log     ${output}
    [Return]    ${output}
    
Connect to server as a dcuser
	Open Connection    ieatrcxb4070.athtem.eei.ericsson.se    port=22    timeout=10
    Login    dcuser    Dcuser_123	
	
Query the eniq database and fetch an inactive node	
	${dbResult}=    Query Sybase database    SELECT TOP 1 ERBS_NAME FROM DIM_E_LTE_ERBS WHERE STATUS ='DEACTIVE'
	Log    ${dbResult}
	${dbResult}=    convert to string    ${dbResult}
	${dbResult1}=    split string    ${dbResult}    [('
	${dbResult1}=    get from list    ${dbResult1}    1
	${dbResult1}=    split string    ${dbResult1}    '
	${dbResult1}=    get from list    ${dbResult1}    0
	${dbResult1}=    convert to string    ${dbResult1}
	Log    ${dbResult1}	
	[Return]    ${dbResult1}
	capture page screenshot
	
make selection on Top 100 nodes with highest energy consumption – pmConsumedEnergy
	Selenium2Library.Drag And Drop by Offset 	xpath:((//div[@class="sf-focusable"])[1])    -160    -100	
	wait for page to load
	capture page screenshot
	
############################################################### MR-115772 ###############################################################

select RAT(s)
	Wait Until Element Is Visible     xpath:(((//div[@class="ListItems"])[1])//div)[1]    300
	${listItem}=    Selenium2Library.get text    xpath:(((//div[@class="ListItems"])[1])//div)[1]
	IF    "${listItem}"!="(All) 0 value"
		Wait Until Element Is Visible     xpath:(((//div[@class="ListItems"])[1])//div)[1]    300
		click element    xpath:(((//div[@class="ListItems"])[1])//div)[1]
	END
	capture page screenshot
	
select a RAT
	select RAT(s)
	capture page screenshot
	
click on Hardware and Software Overview >> button
	wait until element is enabled    xpath:(//input[@value="Hardware and Software Overview >>"])[1]	300
	Wait Until Element Is Visible     xpath:(//input[@value="Hardware and Software Overview >>"])[1]	300
	click element    xpath:(//input[@value="Hardware and Software Overview >>"])[1]	
	capture page screenshot	
	
click on Energy Meters >> button
	wait until element is enabled    xpath:(//input[@value="Energy Meters >>"])[1]	300
	Wait Until Element Is Visible     xpath:(//input[@value="Energy Meters >>"])[1]	300
	click element    xpath:(//input[@value="Energy Meters >>"])[1]	
	capture page screenshot
	
select Software Type(s)
	Click on the scroll down button    4    20
	Wait Until Element Is Visible     xpath:(((//div[@class="ListItems"])[2])//div)[1]    300
	${listItem}=    Selenium2Library.get text    xpath:(((//div[@class="ListItems"])[2])//div)[1]
	IF    "${listItem}"!="(All) 0 value"
		Wait Until Element Is Visible     xpath:(((//div[@class="ListItems"])[2])//div)[1]    300
		click element    xpath:(((//div[@class="ListItems"])[2])//div)[1]
	END
	capture page screenshot	
	
verify that 'Consumed energy per node per software' chart is visible
	Wait Until Element Is Visible     xpath:(//div[@class="sf-element sf-element-canvas-visualization"])[2]    300
	element should be visible    xpath:(//div[@class="sf-element sf-element-canvas-visualization"])[2]
	capture page screenshot	
	
click on Reset All Filters and Markings button
	Click on the scroll down button    0   15
	Wait Until Element Is Visible     xpath: //*[@title='Reset All Filters and Markings']    300
    ${status}=    run keyword and return status    Click element     xpath: //*[@title='Reset All Filters and Markings']
    IF    "${status}"=="FALSE"
    	Wait Until Element Is Visible     xpath: //*[@title='Reset All Filters and Markings']    300
    	Click element     xpath: //*[@title='Reset All Filters and Markings']
    END
	wait for page to load
	capture page screenshot
	
go to energy report home page
	Wait Until Element Is Visible     xpath://*[@class="sfx_page-title_375"]    300
	${text}=    Selenium2Library.Get text  xpath: //*[@class="sfx_page-title_375"]
    Log    ${text}
    IF    "${text}"!="Home"
    	${status}=    run keyword and return status    element should be visible    xpath:(//img[@title="Home"])
    	IF    "${status}"=="True"
    		Wait Until Element Is Visible     xpath:(//img[@title="Home"])    90
    		Click element     xpath:(//img[@title="Home"])
    	ELSE
    		Wait Until Element Is Visible     xpath:(//img[@title="home"])    90
    		Click element     xpath:(//img[@title="home"])
    	END
    	sleep    2
		wait for page to load					  
    	Wait Until Element Is Visible     xpath://*[@class="sfx_page-title_375"]    300
		${text}=    Selenium2Library.Get text  xpath: //*[@class="sfx_page-title_375"]
    	Log    ${text}
    	should contain    ${text}    Home
    END
    wait for page to load
	capture page screenshot	
	
make selection on 'Consumed energy per node per software' chart
	Wait Until Element Is Visible     xpath:(//div[@class="sf-element sf-element-canvas-visualization"])[4]    300
	Selenium2Library.Drag And Drop by Offset 	xpath:(//div[@class="sf-element sf-element-canvas-visualization"])[4]    -160    -100
	Wait Until Page Contains Element      xpath:(//div[@class="sfx_label_379"])[1]    300
	sleep    2
	${text}=    selenium2library.get text    xpath:(//div[@class="sfx_label_379"])[1]
	Log    ${text}
	should not be equal    ${text}    0 of 0 rows
	capture page screenshot	
	
select the Node(s)
	Wait Until Element Is Visible     xpath:(((//div[@class="ListItems"])[1])//div)[1]    300
	${listItem}=    Selenium2Library.get text    xpath:(((//div[@class="ListItems"])[1])//div)[1]
	IF    "${listItem}"!="(All) 0 value"
		Wait Until Element Is Visible     xpath:(((//div[@class="ListItems"])[1])//div)[1]    300
		click element    xpath:(((//div[@class="ListItems"])[1])//div)[1]
	END
	capture page screenshot

select Node(s)
	select the Node(s)
	
make selection on 'Date Volume per Software Chart' chart
	Wait Until Element Is Visible     xpath:(//div[@class="sf-element sf-element-canvas-visualization"])[1]    300
	Selenium2Library.Drag And Drop by Offset 	xpath:(//div[@class="sf-element sf-element-canvas-visualization"])[1]    -160    -100
	Wait Until Page Contains Element      xpath:(//div[@class="sfx_label_379"])[1]    300
	sleep    2
	${text}=    selenium2library.get text    xpath:(//div[@class="sfx_label_379"])[1]
	Log    ${text}
	should not be equal    ${text}    0 of 0 rows
	capture page screenshot
	
verify that Downlink, uplink volume per software chart is visible
	Wait Until Element Is Visible     xpath:(//div[@class="sf-element sf-element-canvas-visualization"])[2]    300
	element should be visible    xpath:(//div[@class="sf-element sf-element-canvas-visualization"])[2]
	capture page screenshot
	
select Hardware Type(s)
	Wait Until Element Is Visible     xpath:(((//div[@class="ListItems"])[2])//div)[1]    300
	${listItem}=    Selenium2Library.get text    xpath:(((//div[@class="ListItems"])[2])//div)[1]
	IF    "${listItem}"!="(All) 0 value"
		Wait Until Element Is Visible     xpath:(((//div[@class="ListItems"])[2])//div)[1]    300
		click element    xpath:(((//div[@class="ListItems"])[2])//div)[1]
	END
	capture page screenshot	
	
verify that 'Consumed energy per node per hardware' chart is visible
	Wait Until Element Is Visible     xpath:(//div[@class="sf-element sf-element-canvas-visualization"])[1]    300
	element should be visible    xpath:(//div[@class="sf-element sf-element-canvas-visualization"])[1]
	capture page screenshot
	
make selection on 'Consumed energy per node per hardware' chart
	Wait Until Element Is Visible     xpath:(//div[@class="sf-element sf-element-canvas-visualization"])[1]    300
	Selenium2Library.Drag And Drop by Offset 	xpath:(//div[@class="sf-element sf-element-canvas-visualization"])[1]    -160    -100
	Wait Until Page Contains Element      xpath:(//div[@class="sfx_label_379"])[1]    300
	sleep    2																						   
	${text}=    selenium2library.get text    xpath:(//div[@class="sfx_label_379"])[1]
	Log    ${text}
	should not be equal    ${text}    0 of 0 rows
	capture page screenshot	
	
verify that 'Consumed energy per unit' chart is visible
	Wait Until Element Is Visible     xpath:(//div[@class="sf-element sf-element-canvas-visualization"])[1]    300
	element should be visible    xpath:(//div[@class="sf-element sf-element-canvas-visualization"])[1]
	capture page screenshot	
	
make selection on 'Consumed energy per unit' chart
	Wait Until Element Is Visible     xpath:(//div[@class="sf-element sf-element-canvas-visualization"])[1]    300
	Selenium2Library.Drag And Drop by Offset 	xpath:(//div[@class="sf-element sf-element-canvas-visualization"])[1]    -160    -100
	Wait Until Page Contains Element      xpath:(//div[@class="sfx_label_379"])[1]    300
	sleep    2																   
	${text}=    selenium2library.get text    xpath:(//div[@class="sfx_label_379"])[1]
	Log    ${text}
	should not be equal    ${text}    0 of 0 rows
	capture page screenshot
	
verify that 'Consumed energy - selected unit(s)' chart is visible
	Wait Until Element Is Visible     xpath:(//div[@class="sf-element sf-element-canvas-visualization"])[2]    300
	element should be visible    xpath:(//div[@class="sf-element sf-element-canvas-visualization"])[2]
	capture page screenshot
	
select Hardware Type(s) on Network Summary page
	Wait Until Element Is Visible     xpath:(((//div[@class="ListItems"])[1])//div)[1]    300
	${listItem}=    Selenium2Library.get text    xpath:(((//div[@class="ListItems"])[1])//div)[1]
	IF    "${listItem}"!="(All) 0 value"
		Wait Until Element Is Visible     xpath:(((//div[@class="ListItems"])[1])//div)[1]    300
		click element    xpath:(((//div[@class="ListItems"])[1])//div)[1]
	END
	capture page screenshot
	
verify that 'Consumed energy vs node count per hardware' chart is visible
	Wait Until Element Is Visible     xpath:(//div[@class="sf-element sf-element-canvas-visualization"])[1]    300
	element should be visible    xpath:(//div[@class="sf-element sf-element-canvas-visualization"])[1]
	capture page screenshot		
	
make selection on 'Consumed energy vs node count per hardware' chart
	Wait Until Element Is Visible     xpath:(//div[@class="sf-element sf-element-canvas-visualization"])[1]    300
	Selenium2Library.Drag And Drop by Offset 	xpath:(//div[@class="sf-element sf-element-canvas-visualization"])[1]    -160    -100
	Wait Until Page Contains Element      xpath:(//div[@class="sfx_label_379"])[1]    300
	sleep    2																						   
	${text}=    selenium2library.get text    xpath:(//div[@class="sfx_label_379"])[1]
	Log    ${text}
	should not be equal    ${text}    0 of 0 rows
	capture page screenshot
	
verify that 'Consumed energy - selected hardware' chart is visible
	Wait Until Element Is Visible     xpath:(//div[@class="sf-element sf-element-canvas-visualization"])[2]    300
	element should be visible    xpath:(//div[@class="sf-element sf-element-canvas-visualization"])[2]
	capture page screenshot	
	
Suite setup steps for Energy Report
	Set Screenshot Directory   ./Screenshots
	Set Selenium Implicit Wait        60s
	open energy report analysis
	
Suite teardown steps for Energy Report
    Close Browser
	
Test teardown steps for Energy Report
    Capture page screenshot
    go to energy report home page
    
select Hardware Type(s) on Hardware and Software Overview - Energy page
	Wait Until Element Is Visible     xpath:(((//div[@class="ListItems"])[1])//div)[1]    300
	${listItem}=    Selenium2Library.get text    xpath:(((//div[@class="ListItems"])[1])//div)[1]
	IF    "${listItem}"!="(All) 0 value"
		Wait Until Element Is Visible     xpath:(((//div[@class="ListItems"])[1])//div)[1]    300
		click element    xpath:(((//div[@class="ListItems"])[1])//div)[1]
	END
	capture page screenshot

Selection in Select Hardware Type(s) list box
    Wait until page contains element    xpath:(((//div[@class="ListItems"])[1])//div)[1]    300
    ${text}=    Selenium2Library.get text    xpath:(((//div[@class="ListItems"])[1])//div)[1]
	Log   $(text)
	IF    "${text}"!="(All) 0 values"
	    Wait until page contains element    xpath:(((//div[@class="ListItems"])[1])//div)[1]    300
		click element    xpath:(((//div[@class="ListItems"])[1])//div)[1]
	END
	capture page screenshot

Selection in Select Software Type(s) list box
    Wait until page contains element    xpath:(((//div[@class="ListItems"])[2])//div)[2]    300
    ${text}=    Selenium2Library.get text    xpath:(((//div[@class="ListItems"])[2])//div)[2]
	Log   $(text)
	IF    "${text}"!="(All) 0 values"
	    Wait until page contains element    xpath:(((//div[@class="ListItems"])[2])//div)[2]    300
		click element    xpath:(((//div[@class="ListItems"])[2])//div)[2]
	END
	capture page screenshot
	sleep    30
	wait for page to load

Make selection on Consumed energy per node per hardware chart
	Selenium2Library.Drag And Drop by Offset 	xpath:(//div[@class="sf-element sf-element-canvas-visualization"])[1]    -160    -100
	capture page screenshot
	sleep    10

Make selection on Consumed energy per node per software chart
	Selenium2Library.Drag And Drop by Offset 	xpath:(//div[@class="sf-element sf-element-canvas-visualization"])[4]    -160    -100
	capture page screenshot
	wait for page to load

Verify that 'Consumed energy - selected software' chart is visible
    Wait Until Page Contains Element      xpath:(//div[@class="sf-element-canvas-image sfc-transition-background"])[3]    300
	element should be visible    xpath:(//div[@class="sf-element-canvas-image sfc-transition-background"])[3]
	capture page screenshot
	wait for page to load

Selection in Select Node(s) list box
    Wait until page contains element    xpath:(((//div[@class="ListItems"])[1])//div)[1]    300
    ${text}=    Selenium2Library.get text    xpath:(((//div[@class="ListItems"])[1])//div)[1]
	Log   $(text)
	IF    "${text}"!="(All) 0 values"
	    Wait until page contains element    xpath:(((//div[@class="ListItems"])[1])//div)[1]    300
		click element    xpath:(((//div[@class="ListItems"])[1])//div)[1]
	END
	capture page screenshot
	wait for page to load

Verify that 'Data volume per software' chart is visible
    Wait Until Page Contains Element      xpath:(//div[@class="sf-element-canvas-image sfc-transition-background"])[1]    300
	element should be visible    xpath:(//div[@class="sf-element-canvas-image sfc-transition-background"])[1]
	capture page screenshot

wait for page to load
    Sleep   3s
	Wait Until Element Is Not Visible      xpath://*[@class='sf-svg-loader-12x12']              timeout=3000
    Sleep    2s

Click on Energy Usage button
    Click element     xpath://input[@value='Energy Usage'][1]
    capture page screenshot

Click on Software Throughput >> button
    Click element     xpath://input[@value='Software Throughput >>'][1]
    Wait Until Page Contains Element      xpath://input[contains(@class,'SearchInput sf-element-input sf-suppress-forms-accept-command sf-suppress-forms-cancel-command sf-input-with-placeholder')]     timeout=1500
    capture page screenshot

Click on Network Summary button
    Click element     xpath://input[@value='Network Summary'][1]
    capture page screenshot
	
Click on Software Overview >> button
    Click element     xpath://input[@value='Software Overview >>'][1]
    capture page screenshot

Selection in Software Type(s) list box
    Wait until page contains element    xpath:(((//div[@class="ListItems"])[1])//div)[1]    300
    ${text}=    Selenium2Library.get text    xpath:(((//div[@class="ListItems"])[1])//div)[1]
	Log   $(text)
	IF    "${text}"!="(All) 0 values"
	    Wait until page contains element    xpath:(((//div[@class="ListItems"])[1])//div)[1]    300
		click element    xpath:(((//div[@class="ListItems"])[1])//div)[1]
	END
	capture page screenshot
	wait for page to load

Verify that 'Node count per software version' chart is visible
    Wait Until Page Contains Element      xpath:(//div[@class="sf-element-canvas-image sfc-transition-background"])[1]    300
	element should be visible    xpath:(//div[@class="sf-element-canvas-image sfc-transition-background"])[1]
	capture page screenshot

Verify that 'Consumed energy per software version' chart is visible
    Wait Until Page Contains Element      xpath:(//div[@class="sf-element-canvas-image sfc-transition-background"])[3]    300
	element should be visible    xpath:(//div[@class="sf-element-canvas-image sfc-transition-background"])[3]
	capture page screenshot

Make selection on Node count per software version chart
	Selenium2Library.Drag And Drop by Offset 	xpath:(//div[@class="sf-element sf-element-canvas-visualization"])[1]    -160    -100
	capture page screenshot
	wait for page to load

Verify that 'Consumed energy per date' chart is visible
    Wait Until Page Contains Element      xpath:(//div[@class="sf-element-canvas-image sfc-transition-background"])[3]    300
	element should be visible    xpath:(//div[@class="sf-element-canvas-image sfc-transition-background"])[3]
	capture page screenshot

Verify that 'Uplink volume, downlink volume per date' chart is visible
    Wait Until Page Contains Element      xpath:(//div[@class="sf-element-canvas-image sfc-transition-background"])[2]    300
	element should be visible    xpath:(//div[@class="sf-element-canvas-image sfc-transition-background"])[2]
	capture page screenshot
	
Verify that 'Uplink volume, downlink volume per date' chart is visible on Software Overview page
    Wait Until Page Contains Element      xpath:(//div[@class="sf-element-canvas-image sfc-transition-background"])[4]    300
	element should be visible    xpath:(//div[@class="sf-element-canvas-image sfc-transition-background"])[4]
	capture page screenshot
	
Verify that 'Uplink volume, downlink volume per software version' chart is visible
	Wait Until Page Contains Element      xpath:(//div[@class="sf-element-canvas-image sfc-transition-background"])[5]    300
	element should be visible    xpath:(//div[@class="sf-element-canvas-image sfc-transition-background"])[5]
	capture page screenshot
	
make selection on Top 100 Nodes with Highest Energy Consumption chart
	Selenium2Library.Drag And Drop by Offset 	xpath:(//div[@class="sf-element sf-element-canvas-visualization"])[1]    -160    -100
	Wait Until element is visible      xpath:(//div[@class="sfx_label_379"])[1]    300
	sleep    2
	${text}=    selenium2library.get text    xpath:(//div[@class="sfx_label_379"])[1]
	Log    ${text}
	should not be equal    ${text}    0 of 0 rows
	capture page screenshot	
	wait for page to load		
	
################################################# MR-115772 END #################################################

select nodes and cell values
	Wait Until element is visible      xpath: (((//div[@class="ListItems"])[1])//div)[1]    30
	click element    xpath: (((//div[@class="ListItems"])[1])//div)[1]
	click on the scroll down button    6    25
	FOR    ${i}    IN RANGE    1    9
		Wait Until page contains element      xpath: (((//div[@class="ListItems"])[2])//div)[${i}]    30
		run keyword and ignore error    click element    xpath: (((//div[@class="ListItems"])[2])//div)[${i}]
		click on the scroll down button    6    25
		sleep    2
		Wait Until page contains element      xpath: (((//div[@class="ListItems"])[3])//div)[${i}]    30
		${status}=    run keyword and return status    element should be visible    xpath: (((//div[@class="ListItems"])[3])//div)[${i}]
		Log    ${status}
		${status1}=    run keyword and return status    element should be enabled    xpath: (((//div[@class="ListItems"])[3])//div)[${i}]
		Log    ${status1}
		Run keyword if    "${status}"=="True" or "${status1}"=="True"    click element    xpath: (((//div[@class="ListItems"])[3])//div)[${i}]
		wait for page to load
		wait until page contains element    xpath:(//div[@class="sf-element sf-element-canvas-visualization"])[1]    30
		selenium2library.drag and drop by offset    xpath:(//div[@class="sf-element sf-element-canvas-visualization"])[1]    500    150
		${value}=    Selenium2Library.get text    xpath://div[@class="sfx_label_379"][2]
		${status}=    run keyword and return status    should not be equal    ${value}    0 marked
		Run keyword if    "${status}"=="True"    Exit For Loop
		IF    "${status}"=="False"
			FOR    ${j}    IN RANGE    1    9
				Wait Until page contains element      xpath: (((//div[@class="ListItems"])[3])//div)[${j}]    30
				run keyword and ignore error    click element    xpath: (((//div[@class="ListItems"])[3])//div)[${j}]
				sleep    2
				wait for page to load
				wait until page contains element    xpath:(//div[@class="sf-element sf-element-canvas-visualization"])[1]    30
				selenium2library.drag and drop by offset    xpath:(//div[@class="sf-element sf-element-canvas-visualization"])[1]    500    150
				${value}=    Selenium2Library.get text    xpath://div[@class="sfx_label_379"][2]
				${status}=    run keyword and return status    should not be equal    ${value}    0 marked
				Run keyword if    "${status}"=="True"    Exit For Loop
				capture page screenshot
			END
		END
		${value}=    Selenium2Library.get text    xpath://div[@class="sfx_label_379"][2]
		${status}=    run keyword and return status    should not be equal    ${value}    0 marked
		Run keyword if    "${status}"=="True"    Exit For Loop
	END

select an area on License chart
	wait until element is visible    xpath:(//div[@class="sf-element sf-element-canvas-visualization"])[1]    30
	selenium2library.drag and drop by offset    xpath:(//div[@class="sf-element sf-element-canvas-visualization"])[1]    120    -50
	wait for page to load 
	capture page screenshot
	
verify that the marked value is not 0
	${value}=    Selenium2Library.get text    xpath://div[@class="sfx_label_379"][2]
	[Return]    ${value}
	should not be equal    ${value}    0 marked
	wait for page to load
	capture page screenshot
	
	
select data in energy saving feature license table	
	wait until element is visible    xpath: ((//div[@name="valueCellCanvas"])[2])//div//div[@row="1" and @column="0"]     30
	click element    xpath: ((//div[@name="valueCellCanvas"])[2])//div//div[@row="1" and @column="0"]
	wait for page to load
	capture page screenshot
	
select data in energy saving feature Threshold table
	wait until element is visible    xpath: ((//div[@name="valueCellCanvas"])[1])//div//div[@row="1" and @column="0"]     30
	click element    xpath: ((//div[@name="valueCellCanvas"])[1])//div//div[@row="1" and @column="0"]
	wait for page to load
	capture page screenshot
	
select Node(s)
	Wait Until Element Is Visible     xpath:(((//div[@class="ListItems"])[1])//div)[1]    300
	${listItem}=    Selenium2Library.get text    xpath:(((//div[@class="ListItems"])[1])//div)[1]
	IF    "${listItem}"!="(All) 0 value"
		Wait Until Element Is Visible     xpath:(((//div[@class="ListItems"])[1])//div)[1]    300
		click element    xpath:(((//div[@class="ListItems"])[1])//div)[1]
	END
	capture page screenshot
	
verify node name present in list
	[Arguments]    ${nodeName}
	wait until element is visible    xpath: (//input[@class="SearchInput sf-element-input sf-suppress-forms-accept-command sf-suppress-forms-cancel-command sf-input-with-placeholder"])[2]    30
	clear element text    xpath: (//input[@class="SearchInput sf-element-input sf-suppress-forms-accept-command sf-suppress-forms-cancel-command sf-input-with-placeholder"])[2]
	Selenium2library.input text    xpath: (//input[@class="SearchInput sf-element-input sf-suppress-forms-accept-command sf-suppress-forms-cancel-command sf-input-with-placeholder"])[2]    ${nodeName}
	Click on the scroll right button    5    20
	wait until element is visible    xpath: (//div[@class="VirtualBoxMagnifier"])[2]    30
	click element    xpath: (//div[@class="VirtualBoxMagnifier"])[2]	
	wait for page to load
	element should be visible    xpath: ((//div[@class="ListItems"])[2])//div[text()="${nodeName}"]
	capture page screenshot

verify active and inactive nodes do not match
	[Arguments]    ${Arg1}    ${Arg2}
	should not be equal    ${Arg1}    ${Arg2}
	
Query the eniq database and fetch an active node	
	${dbResult}=    Query Sybase database    SELECT TOP 1 ERBS_NAME FROM DIM_E_LTE_ERBS WHERE STATUS ='ACTIVE'
	Log    ${dbResult}
	${dbResult}=    convert to string    ${dbResult}
	${dbResult1}=    split string    ${dbResult}    [('
	${dbResult1}=    get from list    ${dbResult1}    1
	${dbResult1}=    split string    ${dbResult1}    '
	${dbResult1}=    get from list    ${dbResult1}    0
	${dbResult1}=    convert to string    ${dbResult1}
	Log    ${dbResult1}	
	[Return]    ${dbResult1}
	capture page screenshot
	
Click on the scroll right button
    [Arguments]     ${button}    ${n}
    @{element}=    Get WebElements	    xpath: //div[@class="ScrollbarButton sf-element sf-element-scroll-bar-button sfpc-right"]
    ${scroll_button}=        Get from list     ${element}    ${button}
    FOR    ${i}    IN RANGE    0    ${n} 
           Run Keyword and Ignore Error    Click element     ${scroll_button}           
    END
    wait for page to load
	capture page screenshot	

verify that four historical trend visual panels are visible
	sleep    2
	Element should be visible    xpath:(//div[@class="sf-element sf-element-canvas-visualization"])[1]
	Element should be visible    xpath:(//div[@class="sf-element sf-element-canvas-visualization"])[2]
	Element should be visible    xpath:(//div[@class="sf-element sf-element-visual sfc-cross-table sfpc-last-column"])[1]
	Element should be visible    xpath:(//div[@class="sf-element sf-element-visual sfc-cross-table sfpc-last-column"])[2]
	wait for page to load
	capture page screenshot