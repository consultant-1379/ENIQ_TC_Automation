*** Keywords ***

open app coverage map analysis
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
    Go To    ${base_url}${app_coverage_url}
    sleep    30
    ${IsElementVisible}=    Run Keyword And Return Status    Element Should not be Visible    xpath://div[contains(text(),'Missing Data')]
	Run Keyword If    ${IsElementVisible} is ${FALSE}   Close missing data window
	sleep    30
    wait for page to load
    capture page screenshot
    
Close missing data window
	Wait Until Page Contains Element      xpath://span[contains(text(),'Apply to all inaccessible data tables in this analysis')]     timeout=150
    Click Element    xpath://span[contains(text(),'Apply to all inaccessible data tables in this analysis')]
    sleep    5
    Wait Until Page Contains Element      xpath://button[contains(text(),'OK')]     timeout=150
    Click Element    xpath://button[contains(text(),'OK')]
    
wait for page to load
    sleep   2
    Wait Until Element Is Not Visible     class:sfx_progress-bar-container_1118        timeout=2400
    sleep   2   
    Wait Until Element Is Not Visible     class:sfx_progress-bar-container_1118        timeout=2400
    sleep   2
    
verify the page title  
	[Arguments]     ${expectedText}
    ${text}=    Selenium2Library.Get text  xpath: //*[@class="sfx_page-title_219"]
    Log    ${text}
    Should contain     ${expectedText}	 ${text}
    wait for page to load
	capture page screenshot
	
Test teardown
    Capture page screenshot
    Close Browser
    
Click on the scroll down button
    [Arguments]     ${button}    ${n}
    @{element}=    Get WebElements	    xpath: //div[@class="ScrollbarButton sf-element sf-element-scroll-bar-button sfpc-bottom"]
    ${scroll_button}=        Get from list     ${element}    ${button}
    FOR    ${i}    IN RANGE    0    ${n} 
           Run Keyword and Ignore Error    Click element     ${scroll_button}           
    END
    wait for page to load
	capture page screenshot
	
Click on the scroll up button
    [Arguments]     ${button}    ${n}
    @{element}=    Get WebElements	    xpath://div[@class="ScrollbarButton sf-element sf-element-scroll-bar-button sfpc-top"]
    ${scroll_button}=        Get from list     ${element}    ${button}
    FOR    ${i}    IN RANGE    0    ${n} 
           Click element     ${scroll_button}           
    END
    wait for page to load
	capture page screenshot	
	 
	
network analytics logo should be visible
	element should be visible    xpath:((//div[@class="HtmlTextArea sf-enable-selection sf-focusable"])//table//img)[1]
	wait for page to load
	capture page screenshot
	
app coverage map logo should be visible
	element should be visible    xpath:((//div[@class="HtmlTextArea sf-enable-selection sf-focusable"])//table//img)[2]
	wait for page to load
	capture page screenshot
	
verify that the button is visible
	[Arguments]    ${button}
	element should be visible    xpath://*[@title="${button}"]
	wait for page to load
	capture page screenshot
	
validate that the button is visible
	[Arguments]    ${button}
	element should be visible    xpath://*[@value="${button}"]
	wait for page to load
	capture page screenshot
	
click on button
	[Arguments]    ${buttonValue}
	sleep     5
	Wait Until Element Is Visible     xpath: //*[@value='${buttonValue}']    300
    Click element     xpath: //*[@value='${buttonValue}']
	wait for page to load
	capture page screenshot
	
click on the button
	[Arguments]    ${buttonTitle}
	sleep     5
	Wait Until Element Is Visible     xpath: //*[@title='${buttonTitle}']    300
    Click element     xpath: //*[@title='${buttonTitle}']
	wait for page to load
	capture page screenshot
	
verify that the Performance Targets section is visible
	element should be visible    xpath://*[@id="PerfThresholdItem"]
	element should be visible    xpath://div[@class="ui-accordion-content ui-helper-reset ui-widget-content ui-corner-bottom ui-accordion-content-active"]
	wait for page to load
	capture page screenshot

verify that the MSA Configuration section is visible
	element should be visible    xpath://*[@id="ui-accordion-accordion-panel-1"]
	element should be visible    xpath://div[@class="ui-accordion-content ui-helper-reset ui-widget-content ui-corner-bottom ui-accordion-content-active"]
	wait for page to load
	capture page screenshot
	
open MSA Configurations
	sleep    2
	click element    xpath://*[@id="MSAItem"]
	sleep    2
	wait for page to load
	capture page screenshot
	
Go to home page if not already at home
	${pageTitle}=    Selenium2Library.Get text  xpath: //*[@class="sfx_page-title_219"]
	IF 		"${pageTitle}"== "Settings"	
		Click on the scroll down button    0    30
		Click element     xpath: //*[@title="Home"]
	ELSE IF    "${pageTitle}" != "Home"		
		Click element     xpath: //*[@title="Home"]
	END
	wait for page to load
	capture page screenshot
	
configure DL Performance Targets
	[Arguments]    ${dl}
	click element    xpath://*[@class="sf-element sf-element-control sfc-property"][1]
	Wait Until Element Is Visible     xpath: //*[@title='${dl}']    300
	click element    xpath://div[@title="${dl}"]
	sleep    2
	wait for page to load
	capture page screenshot
	
configure UL Performance Targets
	[Arguments]    ${ul}
	click element    xpath:/html/body/div/div[2]/div/div[1]/div/div/div[2]/div/div/div/div/div/div/div/div/div[1]/div[1]/div[1]/div[1]/div/div[1]/div[1]/font[14]/span/div/div[2]
	Wait Until Element Is Visible     xpath: //*[@title='${ul}']    300
	click element    xpath://div[@title="${ul}"]
	sleep    2
	wait for page to load
	capture page screenshot
	
enter the number of data sources
	[Arguments]    ${dataSource}
	sleep    10
	clear element text    xpath:/html/body/div/div[2]/div/div[1]/div/div/div[2]/div/div/div/div/div/div/div/div/div[1]/div[1]/div[1]/div[1]/div/div[2]/p[2]/font/font/span/input
	sleep    10
	Selenium2Library.Input text    xpath:/html/body/div/div[2]/div/div[1]/div/div/div[2]/div/div/div/div/div/div/div/div/div[1]/div[1]/div[1]/div[1]/div/div[2]/p[2]/font/font/span/input    ${dataSource}
	wait for page to load
	capture page screenshot
	
enter the data source
	[Arguments]    ${dataSource}
	clear element text    xpath:/html/body/div/div[2]/div/div[1]/div/div/div[2]/div/div/div/div/div/div/div/div/div[1]/div[1]/div[1]/div[1]/div/div[2]/p[3]/font[4]/span/span/textarea
	sleep    10
	Selenium2Library.Input text    xpath:/html/body/div/div[2]/div/div[1]/div/div/div[2]/div/div/div/div/div/div/div/div/div[1]/div[1]/div[1]/div[1]/div/div[2]/p[3]/font[4]/span/span/textarea    ${dataSource}
	clear element text    xpath:/html/body/div/div[2]/div/div[1]/div/div/div[2]/div/div/div/div/div/div/div/div/div[1]/div[1]/div[1]/div[1]/div/div[2]/p[3]/font[4]/span/span/textarea
	Selenium2Library.Input text    xpath:/html/body/div/div[2]/div/div[1]/div/div/div[2]/div/div/div/div/div/div/div/div/div[1]/div[1]/div[1]/div[1]/div/div[2]/p[3]/font[4]/span/span/textarea    ${dataSource}
	wait for page to load
	capture page screenshot
	
verify that the connection is not made
	sleep    10
	${text}=    Selenium2Library.get text    xpath:/html/body/div/div[2]/div/div[1]/div/div/div[2]/div/div/div/div/div/div/div/div/div[1]/div[1]/div[1]/div[1]/div/div[2]/p[8]/span/span/font/span
	Log    ${text}
	should be equal    ${text}    Invalid data source name!
	wait for page to load
	capture page screenshot
	
select throughput type
	[Arguments]    ${throughput}
	sleep    10
	click element    xpath://span[@class="sf-element sf-element-control sfc-property"]
	sleep    10
	click element    xpath://div[@title="${throughput}"]
	wait for page to load
	capture page screenshot
	
set the performance target
    [Arguments]    ${target}
    sleep    10
    click element    xpath:(//div[@class="ComboBoxTextDivContainer"])[2]
    sleep    10
    click element    xpath://div[@title="${target}"]
    wait for page to load
    capture page screenshot
	
set performance target
    [Arguments]    ${target}
    sleep    10
    click element    xpath:(//div[@class="ComboBoxTextDivContainer"])[3]
    sleep    10
    click element    xpath://div[@title="${target}"]
    wait for page to load
    capture page screenshot
	
validate the graph titles and the graphs
	element should contain    xpath://div[@class="flex-item flex-container-horizontal flex-justify-start flex-align-center"]    Worst Performing Cells (Ranked by Avg Failed User Sessions) 
	element should be visible    xpath://div[@title="Cell Failure Rate over Time (Hourly)"]
	element should be visible    xpath://*[@class="sf-element sf-element-canvas-visualization"]
	element should be visible    xpath://*[@class="sf-element sf-element-canvas-visualization"][1]
	wait for page to load
	capture page screenshot
	
verify that the map and graph are visible
	element should be visible    xpath://div[@class="tibco-map"]
	element should be visible    xpath://div[@class="sf-element sf-element-canvas-visualization"]
	wait for page to load
	capture page screenshot
	
verify that the graph title is visible
	[Arguments]    ${title}
	element should be visible    xpath://div[@title="${title}"]
	wait for page to load
	capture page screenshot
	
verify DL and UL charts are visible
	sleep    10
	element should contain    xpath://div[@class="flex-item flex-container-horizontal flex-justify-start flex-align-center"]    DL Throughput
	element should contain    xpath:/html/body/div/div[2]/div/div[1]/div/div/div[2]/div/div/div[2]/div/div/div/div/div/div[4]/div[2]/div[2]    UL Throughput
	wait for page to load
	capture page screenshot
	
verify that the Success Target slider is visible
	element should be visible    xpath://span[@class="sf-element sf-element-control sfc-property sfc-slider TextAreaSlider ShowLabels"]
	wait for page to load
	capture page screenshot
	
verify that the Performance Target dropdowns are visible
	element should be visible    xpath://div[@class="ComboBoxTextDivContainer"]
	element should be visible    xpath://div[@class="ComboBoxTextDivContainer"][1]
	wait for page to load
	capture page screenshot
	
Suite setup steps    
    Set Screenshot Directory   ./Screenshots

Suite teardown steps
    Capture page screenshot
	
verify that the charts are visible
	element should be visible    xpath://div[@class="sf-element sf-element-canvas-visualization"]
	element should be visible    xpath://div[@class="sf-element sf-element-canvas-visualization"][1]
	wait for page to load
	capture page screenshot
	
verify the chart title for Uplink
	sleep    10
	element should contain    xpath:/html/body/div/div[2]/div/div[1]/div/div/div[2]/div/div/div[2]/div/div/div/div/div/div[4]/div[2]/div[2]    Target UL Throughput
 	wait for page to load
	capture page screenshot
	
verify the chart title for Downlink
	sleep    10
	run keyword and ignore error    element should contain    xpath:/html/body/div/div[2]/div/div[1]/div/div/div[2]/div/div/div[2]/div/div/div/div/div/div[4]/div[2]/div[2]    Target DL Throughput
 	wait for page to load
	capture page screenshot
	
move Success Target slider to the left
	[Arguments]    ${n}
	wait until element is visible    xpath://div[@class="Button LeftEnabled sf-element sf-element-button"]    300
	FOR    ${i}    IN RANGE    0    ${n} 
           Click element    xpath://div[@class="Button LeftEnabled sf-element sf-element-button"]               
    END
	wait for page to load
	capture page screenshot
	
make a selection on the Worst Performing Cells chart
	wait until element is visible    xpath://div[@class="sf-element sf-element-canvas-visualization"]    300
	Selenium2Library.drag and drop by offset    xpath://div[@class="sf-element sf-element-canvas-visualization"]    50    5							   
	wait for page to load
	capture page screenshot
	
read the marked value
	wait until element is visible    xpath://div[@class="sfx_label_223"][3]    300
	${value}=    Selenium2Library.get text    xpath://div[@class="sfx_label_223"][2]
	Log    ${value}
	[Return]    ${value}
	wait for page to load
	capture page screenshot
	
verify that the marked value is 0
	wait until element is visible    xpath://div[@class="sfx_label_223"][3]    300
	${value}=    Selenium2Library.get text    xpath://div[@class="sfx_label_223"][2]
	Log    ${value}
	[Return]    ${value}
	should be equal    ${value}    0 marked
	wait for page to load
	capture page screenshot
	
verify Cell Performance Ranking Page opens on App Coverage Map Analysis
    sleep    5s
	${title}=    Selenium2Library.Get Text     class:sf-root
    Should Contain      ${title}     Cell Performance: 7 Days
    
Select from Uplink/Downlink dropdown 
    [Arguments]    ${value}
    Click on the scroll down button     3     2
    Selenium2Library.Click Element    class:ComboBoxTextDivContainer
    Selenium2Library.Click Element    xpath://div[@class='ListItems']//div[@title='${value}']
    wait for page to load
	capture page screenshot
 
mark on the "Worst Performing Cells (Ranked by Avg Failed User Sessions)" chart
	sleep	5s
	#Selenium2Library.Click Element At Coordinates 		xpath:(//div[@class='sf-element-canvas-image'])[1]		${500}		${30}	
	#Selenium2Library.Drag And Drop By Offset		xpath:(//div[@class='sf-element-canvas-image'])[1]		${500}		${30}
	Selenium2Library.Drag And Drop By Offset		xpath:(//div[@class='sf-element sf-element-canvas-visualization'])[1]		${200}		${20}
	wait for page to load
	capture page screenshot
	
mark any cell on the "Worst Performing Cells (Ranked by Avg Failed User Sessions)" chart 
	sleep	5s
	#Selenium2Library.Click Element At Coordinates 		xpath:(//div[@class='sf-element-canvas-image'])[1]		${500}		${30}	
	Selenium2Library.Click Element At Coordinates		xpath:(//div[@class='sf-element sf-element-canvas-visualization'])[1]		${200}		${50}
	sleep 	5s
	#Selenium2Library.Drag And Drop By Offset		xpath:(//div[@class='sf-element-canvas-image'])[1]		${500}		${30}
	#Selenium2Library.Drag And Drop By Offset		xpath:(//div[@class='sf-element sf-element-canvas-visualization'])[1]		${200}		${50}
	wait for page to load
	capture page screenshot	
	

record the tooltip values
	Sleep    5s
	Mouse Over 		xpath://div[@class='sf-element sf-element-visual sfc-bar-chart sfc-trellis-visualization sfpc-first-column sfpc-last-column sfpc-active']
	sleep	5s
	${toolTip}=    Selenium2Library.Get Text    xpath: //*[@class="sf-tooltip sf-plot-tooltip RoundedDropShadow"]
	Log    ${toolTip}
	${actualUiValue}=    Split String from Right    ${toolTip}
	${words}=	Split String from Right		${toolTip}	:	1	
	${avgFailedSessions}=	Get From List    ${words}    1
	Log    ${avgFailedSessions}
	Log    ${actualUiValue}
	${erbsValue}=    Get From List    ${actualUiValue}    1
	${cellValue}=    Get From List    ${actualUiValue}    3
	Log  		${erbsValue}
	Log     	${cellValue} 
	[Return]	${erbsValue}	${cellValue}	${avgFailedSessions.strip()} 
	wait for page to load
	capture page screenshot
	
select the performance target
    [Arguments]    ${target}
    sleep    10
    click element    xpath:(//div[@class="ComboBoxTextDivContainer"])[2]
    sleep    4
    click element    xpath://div[@title="${target}"]
    wait for page to load
    capture page screenshot

select the performance target for UL
	[Arguments]    ${target}
    sleep    4
    click element    xpath:(//div[@class="ComboBoxTextDivContainer"])[3]
    sleep    4
    click element    xpath://div[@title="${target}"]
    wait for page to load
    capture page screenshot	
   
place cursor on "Cell Failure Rate over Time" chart and record its tooltip values for UL
	Sleep    5s
	SikuliLibrary.Mouse Move Location		600		550
	sleep	5s
	${toolTip}=    Selenium2Library.Get Text    xpath: //*[@class="sf-tooltip sf-plot-tooltip RoundedDropShadow"]
	Log    ${toolTip}
	${actualUiValue}=    Split String from Right    ${toolTip}
	${cellFailureVal}=	Get From List    ${actualUiValue}    4
	Log    ${cellFailureVal}
	Log    ${actualUiValue}
	${DateValue}=    Get From List    ${actualUiValue}    1
	Log  		${DateValue}	${cellFailureVal} 
	[Return]	${DateValue}	${cellFailureVal}	
	wait for page to load
	capture page screenshot	
	
	
filter the erbs node with node value	
	[Arguments]    ${nodevalue}
	sleep	5s
	Selenium2Library.Input text  	xpath: (//input[@class='SearchInput sf-element-input sf-suppress-forms-accept-command sf-suppress-forms-cancel-command sf-input-with-placeholder'])[1]		${nodevalue}
	click element    xpath:(//div[@title='Click to search'])[1]
	#click element    xpath://div[@title='${nodevalue}']
	sleep 	10s
	wait for page to load
	capture page screenshot


filter cell values	
	[Arguments]    ${cellvalue}
	sleep	5s
	Click on the scroll down button     2     9
	Selenium2Library.Input text  	xpath: (//input[@class='SearchInput sf-element-input sf-suppress-forms-accept-command sf-suppress-forms-cancel-command sf-input-with-placeholder'])[2]		${cellvalue}
	click element    xpath:(//div[@title='Click to search'])[2]
	click element    xpath://div[@title='${cellvalue}']
	sleep 	9s
	wait for page to load
	capture page screenshot
	
read the first node from ERBS list	
	${nodeName}=	Selenium2Library.Get text  	xpath:(//div[@class='ListItems'])[1]//div[@class='sf-element-list-box-item'][1]
	Log 	${nodeName}
	[Return]    ${nodeName}
	
read the first cell from list	
	#${cellname}=	Selenium2Library.Get text  	xpath:(//div[@class='ListItems'])[2]//div[@class='sf-element-list-box-item'][1]
	${cellname}=	Selenium2Library.Get text  	xpath:(//div[@class='ListItems'])[2]//div[@class='sf-element-list-box-item'][2]
	#${cellname}=	Selenium2Library.Get text  	xpath:(//div[@class='sf-element-list-box-item'])[8]
	#${cellname}=	Selenium2Library.Get text	xpath:(//div[@class='ListItems'])[2]//div[@class='sf-element-list-box-item'][6]
	Log 	${cellname}
	[Return]    ${cellname}

read time axis value
	${timeaxis}=	Selenium2Library.Get text	xpath:(//div[@class="sfpc-bottom"])[1]	
	Log 	${timeaxis}
	${region} =  SikuliLibrary.Get Extended Region From Image  ${IMAGE_DIR}\\cellChart1.png  below   1 
	${text}=	SikuliLibrary.Read text from region		${region}
	Log 	${text}
	#[Return]    ${timeaxis}
	wait for page to load
	capture page screenshot
	
Get time name   
    ${chartName}=	Selenium2Library.Get text  	xpath:(//div[@class='flex-item flex-align-start sf-element sf-element-text-box sf-single-line-text'])[2]
    Log		${chartName}
    ${hour}=     set variable     0
    ${hourPresent}  ${value}=  Run Keyword And Ignore Error  Should Contain   ${chartName}      Hourly 
		IF  	'${hourPresent}'=='PASS'
			SikuliLibrary.Set ocr text read    True
    		${text}=    SikuliLibrary.Get text
   			Log    ${text}		
			${words}=    Split String from Right    ${text}		HOUR_ID:
			Log		${words}
			${values}=	Get From List    ${words}    1	
			Log		${values}
			${words1}=    Split String from Right    ${values}		HOUR_ID
			Log		${words1}
			${values1}=	Get From List    ${words1}    0	
			Log		${values1}
			${words2}=    Split String from Right    ${values1}		<=
			Log		${words2}scroll 
			${values2}=	Get From List    ${words2}    0	
			Log		${values2}
			${str}= 	Replace String		${values2}		(		${SPACE}	1
			Log		$str.strip()}
			${hour}=     set variable     ${str.strip()}
	END
	Log 	${hour}
	[Return]    ${hour}
	wait for page to load
	capture page screenshot		
	


record the tooltip values of Worst Performing Cells Graph
	sleep    5s
	Mouse Over 		xpath://div[@class='sf-element sf-element-visual sfc-bar-chart sfc-trellis-visualization sfpc-first-column sfpc-last-column sfpc-active']
	sleep	5s
	${toolTip}=    Selenium2Library.Get Text    xpath: //*[@class="sf-tooltip sf-plot-tooltip RoundedDropShadow"]
	Log    ${toolTip}
	${actualUiValue}=    Split String from Right    ${toolTip}
	${words}=	Split String from Right		${toolTip}	:	1	
	${avgFailedSessions}=	Get From List    ${words}    1
	Log    ${avgFailedSessions}
	Log    ${actualUiValue}
	${erbsValue}=    Get From List    ${actualUiValue}    1
	${cellValue}=    Get From List    ${actualUiValue}    3
	Log    ${erbsValue}	
	Log    ${cellValue} 
	[Return]	${erbsValue}	${cellValue}	${avgFailedSessions.strip()} 
	wait for page to load
	capture page screenshot
	
place cursor on "Cell Failure Rate over Time" chart and record its tooltip values    
	Sleep    5s
	Mouse Over 		xpath:(//div[@class='sf-element sf-element-visual-content sfc-bar-chart sfc-trellis-visualization'])[2]
	sleep	5s
	${toolTip}=    Selenium2Library.Get Text    xpath: //*[@class="sf-tooltip sf-plot-tooltip RoundedDropShadow"]
	Log    ${toolTip}
	${actualUiValue}=    Split String from Right    ${toolTip}
	${cellFailureVal}=	Get From List    ${actualUiValue}    4
	Log    ${cellFailureVal}
	Log    ${actualUiValue}
	${DateValue}=    Get From List    ${actualUiValue}    1
	Log  	${DateValue}
	Log	    ${cellFailureVal}
	[Return]	${DateValue}	${cellFailureVal}
	wait for page to load
	capture page screenshot
	
get sql query from json file
    [Arguments]     ${json_file}     ${data}
    ${json}=    OperatingSystem.get file    ${json_file}
    &{object}=    Evaluate     json.loads('''${json}''')     json
    [return]       ${object}[${data}]
    
select the performance target for uplink
	[Arguments]    ${target}
    sleep    10
    click element    xpath:(//div[@class="ComboBoxTextDivContainer"])[3]
    sleep    10
    click element    xpath://div[@title="${target}"]
    wait for page to load
    capture page screenshot
	
select hour id
	Click on the scroll up button	2	7
	${chartName}=	Selenium2Library.Get text  	xpath:(//div[@class='flex-item flex-align-start sf-element sf-element-text-box sf-single-line-text'])[2]
    Log		${chartName}
    ${hourPresent}   ${value}=  Run Keyword And Ignore Error  Should Contain   ${chartName}      Hourly 
		IF  	'${hourPresent}'=='PASS'
			wait until element is visible    xpath:(//div[@class='RightAligned EditableLabel'])[2]//div[@class='sf-element-text-box ValueLabel']    300
			Selenium2Library.drag and drop    xpath:(//div[@class='Handle sf-element sf-element-thumb TouchTarget'])[4]		xpath:(//div[@class='Handle sf-element sf-element-thumb TouchTarget'])[3]
		END
	${hourid}=	Selenium2Library.Get text  	xpath:(//div[@class="RightAligned EditableLabel"])[2]
	Log    ${hourid}
	[Return]    ${hourid}
	wait for page to load
	capture page screenshot
	
click on the scroll right button	
    [Arguments]     ${button}    ${n}
    @{element}=    Get WebElements	    xpath: //div[@class="ScrollbarButton sf-element sf-element-scroll-bar-button sfpc-right"]
    ${scroll_button}=        Get from list     ${element}    ${button}
    FOR    ${i}    IN RANGE    0    ${n} 
           Click element     ${scroll_button}           
    END
    wait for page to load
	capture page screenshot  