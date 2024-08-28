*** Variables ***

${username_xpath}       //input[@class='w-full pt-2 pb-2 pl-3 text-ellipsis pr-3 ng-untouched ng-pristine ng-invalid' and @placeholder='Username']
${password_xpath}        //input[@class='w-full pt-2 pb-2 pl-3 text-ellipsis pr-3 ng-untouched ng-pristine ng-invalid' and @placeholder='Password']
${loginButton_xpath}      //button[@data-testid='login-button']
${sfx_label}                sfx_label_1333
${sfx_page_title}         (//div[@class="sfx_page-title_1329"])
${author_dropdown}        //div[@class='sfx_author-dropdown_1174']
${save_analysis_button}           (//div[text()='Save'])[3]
${visualisations_type}           sfx_button_318 sfx_button-enabled_317

*** Keywords ***

open uplink interference analysis
	${chrome_options}=    Evaluate    sys.modules['selenium.webdriver'].ChromeOptions()      sys
	Call Method    ${chrome_options}    add_argument    --ignore-certificate-errors
	Create Webdriver    Chrome    options=${chrome_options}
    Go To    ${base_url}   
    Maximize Browser Window
    Sleep    3
    Selenium2Library.Input Text    ${username_xpath}    Administrator
    Selenium2Library.Input Text    ${password_xpath}    Ericsson01
    Click Element    ${loginButton_xpath}
    Sleep    3
    Go To    ${base_url}${uplink_url}
    sleep    10
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
    ${text}=    Selenium2Library.Get text  xpath: ${sfx_page_title}
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
	
Go to home page if not already at home
	${pageTitle}=    Selenium2Library.Get text  xpath: ${sfx_page_title}
	IF 		"${pageTitle}" != "Home"	
		Click element     xpath: //*[@title="Home"]
	END
	wait for page to load
	capture page screenshot
	
Suite setup steps    
    Set Screenshot Directory   ./Screenshots

Suite teardown steps
    Capture page screenshot
 
network analytics logo should be visible
	element should be visible    xpath:((//div[@align="center"])[2]//div//table//tbody//tr//td//p//img)[1]
	wait for page to load
	capture page screenshot
	
uplink interference logo should be visible
	element should be visible    xpath:((//div[@align="center"])[2]//div//table//tbody//tr)[2]//td//img
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
	
click on PUCCH/PUSCH Analysis button
	sleep     5
	Wait Until Element Is Visible     xpath: //*[@id='PUSCHPUCCHButton']    300
    Click element     xpath: //*[@id='PUSCHPUCCHButton']
	wait for page to load
	capture page screenshot
	
click on button with id
	[Arguments]    ${buttonId}
	sleep     5
	Wait Until Element Is Visible     xpath: //*[@id='${buttonId}']    300
    Click element     xpath: //*[@id='${buttonId}']
	wait for page to load
	capture page screenshot
	
click the button
	[Arguments]    ${buttonText}
	Wait Until Element Is Visible     xpath://*[contains(text(),'${buttonText}')]    30
	Click Element       xpath://*[contains(text(),'${buttonText}')]
	wait for page to load
	capture page screenshot
	
make selection on the Worst 500 Cells chart
	Wait Until Element Is Visible     xpath:(//div[@class="sf-element sf-element-canvas-visualization"])[2]    300
    Selenium2Library.drag and drop by offset    xpath:(//div[@class="sf-element sf-element-canvas-visualization"])[2]    20    20
	wait for page to load
	capture page screenshot
	
read the marked value
	wait until element is visible    xpath://div[@class="${sfx_label}"][3]    300
	${value}=    Selenium2Library.get text    xpath://div[@class="${sfx_label}"][2]
	Log    ${value}
	[Return]    ${value}
	wait for page to load
	capture page screenshot
	
verify that the marked value is 0
	wait until element is visible    xpath://div[@class="${sfx_label}"][3]    300
	${value}=    Selenium2Library.get text    xpath://div[@class="${sfx_label}"][2]
	Log    ${value}
	[Return]    ${value}
	should be equal    ${value}    0 marked
	wait for page to load
	capture page screenshot
	
enter the number of data sources
	[Arguments]    ${dataSource}
	sleep    3
	clear element text    xpath://input[@class="sf-element sf-element-control sfc-property sfc-text-box"]
	sleep    3
	Selenium2Library.Input text    xpath://input[@class="sf-element sf-element-control sfc-property sfc-text-box"]    ${dataSource}
	wait for page to load
	capture page screenshot
	
enter the data source
	[Arguments]    ${dataSource}
	clear element text    xpath:(//*[@class="sf-element sf-element-control sfc-property sfc-text-box"])[2]
	sleep    5
	Selenium2Library.Input text    xpath:(//*[@class="sf-element sf-element-control sfc-property sfc-text-box"])[2]    ${dataSource}
	clear element text    xpath:(//*[@class="sf-element sf-element-control sfc-property sfc-text-box"])[2]
	Selenium2Library.Input text    xpath:(//*[@class="sf-element sf-element-control sfc-property sfc-text-box"])[2]    ${dataSource}
	wait for page to load
	capture page screenshot
	
verify that the connection is not made
	Wait until Element is visible        xpath://span[text()='Invalid data source name!']            30
	wait for page to load
	capture page screenshot
	
select Interference measure and Aggregation as
	[Arguments] 	${interferenceMeasure}		${aggregation}
	${element}=    Get WebElements	    xpath: //div[@class='ComboBoxTextDivContainer']
    ${interferenceMeasureType}=        Get from list     ${element}    0
    Click element     ${interferenceMeasureType}
    sleep    2
    wait for page to load
    Click element      xpath://div[@title='${interferenceMeasure}']
    sleep    2
    wait for page to load
    ${aggElement}=    Get WebElements	    xpath: //div[@class='ComboBoxTextDivContainer']
    ${aggregationType}=        Get from list     ${aggElement}    1
    Click element     ${aggregationType}
    sleep    2
    wait for page to load
    Click element      xpath://div[@title='${aggregation}']
	wait for page to load
	capture page screenshot
	
verify that the charts are named for
	[Arguments] 	${interferenceMeasure}		${aggregation}
	sleep    10
	IF    "${interferenceMeasure}" == "Interference Power"
		   element should contain    xpath:(//div[@class="sf-element sf-element-visualization-description sfpc-top"])[1]    Interference Power
           element should not contain    xpath:(//div[@class="sf-element sf-element-visualization-description sfpc-top"])[1]    Noise Rise
		   element should contain    xpath:(//div[@class="sf-element sf-element-visualization-description sfpc-top"])[2]    Interference Power
           element should not contain    xpath:(//div[@class="sf-element sf-element-visualization-description sfpc-top"])[2]    Noise Rise
		   element should contain    xpath:(//div[@class="sf-element sf-element-visualization-description sfpc-top"])[4]    Interference Power
           element should not contain    xpath:(//div[@class="sf-element sf-element-visualization-description sfpc-top"])[4]    Noise Rise
		   element should contain    xpath:(//div[@class="sf-element sf-element-visualization-description sfpc-top"])[8]    Interference Power
           element should not contain    xpath:(//div[@class="sf-element sf-element-visualization-description sfpc-top"])[8]    Noise Rise
    	
    ELSE IF    "${interferenceMeasure}" == "Noise Rise"
           element should contain    xpath:(//div[@class="sf-element sf-element-visualization-description sfpc-top"])[1]    Noise Rise
           element should not contain    xpath:(//div[@class="sf-element sf-element-visualization-description sfpc-top"])[1]    Interference Power
		   element should contain    xpath:(//div[@class="sf-element sf-element-visualization-description sfpc-top"])[2]    Noise Rise
           element should not contain    xpath:(//div[@class="sf-element sf-element-visualization-description sfpc-top"])[2]    Interference Power
		   element should contain    xpath:(//div[@class="sf-element sf-element-visualization-description sfpc-top"])[4]    Noise Rise
           element should not contain    xpath:(//div[@class="sf-element sf-element-visualization-description sfpc-top"])[4]    Interference Power
		   element should contain    xpath:(//div[@class="sf-element sf-element-visualization-description sfpc-top"])[8]    Noise Rise
           element should not contain    xpath:(//div[@class="sf-element sf-element-visualization-description sfpc-top"])[8]    Interference Power
    END
	IF    "${aggregation}" == "Average"
           element should contain    xpath:(//div[@class="sf-element sf-element-visualization-description sfpc-top"])[1]    Average
           element should not contain    xpath:(//div[@class="sf-element sf-element-visualization-description sfpc-top"])[1]    Maximum  
           element should contain    xpath:(//div[@class="sf-element sf-element-visualization-description sfpc-top"])[2]    Average
           element should not contain    xpath:(//div[@class="sf-element sf-element-visualization-description sfpc-top"])[2]    Maximum 
           element should contain    xpath:(//div[@class="sf-element sf-element-visualization-description sfpc-top"])[4]    Average
           element should not contain    xpath:(//div[@class="sf-element sf-element-visualization-description sfpc-top"])[4]    Maximum 
           element should contain    xpath:(//div[@class="sf-element sf-element-visualization-description sfpc-top"])[8]    Average
           element should not contain    xpath:(//div[@class="sf-element sf-element-visualization-description sfpc-top"])[8]    Maximum 		   
    	
    ELSE IF    "${aggregation}" == "Maximum"
           element should contain    xpath:(//div[@class="sf-element sf-element-visualization-description sfpc-top"])[1]    Maximum
           element should not contain    xpath:(//div[@class="sf-element sf-element-visualization-description sfpc-top"])[1]    Average   
		   element should contain    xpath:(//div[@class="sf-element sf-element-visualization-description sfpc-top"])[2]    Maximum
           element should not contain    xpath:(//div[@class="sf-element sf-element-visualization-description sfpc-top"])[2]    Average   
		   element should contain    xpath:(//div[@class="sf-element sf-element-visualization-description sfpc-top"])[4]    Maximum
           element should not contain    xpath:(//div[@class="sf-element sf-element-visualization-description sfpc-top"])[4]    Average   
		   element should contain    xpath:(//div[@class="sf-element sf-element-visualization-description sfpc-top"])[8]    Maximum
           element should not contain    xpath:(//div[@class="sf-element sf-element-visualization-description sfpc-top"])[8]    Average   
    	
    END
	wait for page to load
	capture page screenshot
	

verify the x-axis of the charts
	[Arguments] 	${interferenceMeasure}
	sleep    10
	IF    "${interferenceMeasure}" == "Interference Power"
		FOR    ${i}    IN RANGE    1    4
           element should contain    xpath:(//div[@class="itemText sf-element sf-element-text-box"])[${i}]    Interference Power
           element should not contain    xpath:(//div[@class="itemText sf-element sf-element-text-box"])[${i}]    Noise Rise
    	END
    ELSE IF    "${interferenceMeasure}" == "Noise Rise"
		FOR    ${i}    IN RANGE    1    4
           element should contain    xpath:(//div[@class="itemText sf-element sf-element-text-box"])[${i}]    Noise Rise
           element should not contain    xpath:(//div[@class="itemText sf-element sf-element-text-box"])[${i}]    Interference Power
    	END
    END
    wait for page to load
	capture page screenshot
	
verify that the charts on PUCCH/PUSCH Analysis are named for
	[Arguments] 	${interferenceMeasure}		${aggregation}
	IF    "${interferenceMeasure}" == "Interference Power"
		FOR    ${i}    IN RANGE    1    2
           element should contain    xpath:(//div[@class="sf-element sf-element-visualization-description sfpc-top"])[${i}]    Interference Power
           element should not contain    xpath:(//div[@class="sf-element sf-element-visualization-description sfpc-top"])[${i}]    Noise Rise
           element should contain    xpath:(//div[@class="flex-item flex-align-start sf-element sf-element-text-box sf-single-line-text"])[${i}]    Interference Power
           element should not contain    xpath:(//div[@class="flex-item flex-align-start sf-element sf-element-text-box sf-single-line-text"])[${i}]    Noise Rise
    	END
    ELSE IF    "${interferenceMeasure}" == "Noise Rise"
		FOR    ${i}    IN RANGE    1    2
           element should contain    xpath:(//div[@class="sf-element sf-element-visualization-description sfpc-top"])[${i}]    Noise Rise
           element should not contain    xpath:(//div[@class="sf-element sf-element-visualization-description sfpc-top"])[${i}]    Interference Power
           element should contain    xpath:(//div[@class="flex-item flex-align-start sf-element sf-element-text-box sf-single-line-text"])[1]    Noise Rise
           element should not contain    xpath:(//div[@class="flex-item flex-align-start sf-element sf-element-text-box sf-single-line-text"])[2]    Interference Power
    	END
    END
    IF    "${aggregation}" == "Average"
		FOR    ${i}    IN RANGE    1    2
           element should contain    xpath:(//div[@class="sf-element sf-element-visualization-description sfpc-top"])[${i}]    Average
           element should not contain    xpath:(//div[@class="sf-element sf-element-visualization-description sfpc-top"])[${i}]    Maximum
           element should contain    xpath:(//div[@class="flex-item flex-align-start sf-element sf-element-text-box sf-single-line-text"])[${i}]    Average
           element should not contain    xpath:(//div[@class="flex-item flex-align-start sf-element sf-element-text-box sf-single-line-text"])[${i}]    Maximum
    	END
    ELSE IF    "${aggregation}" == "Maximum"
		FOR    ${i}    IN RANGE    1    2
           element should contain    xpath:(//div[@class="sf-element sf-element-visualization-description sfpc-top"])[${i}]    Maximum
           element should not contain    xpath:(//div[@class="sf-element sf-element-visualization-description sfpc-top"])[${i}]    Average
           element should contain    xpath:(//div[@class="flex-item flex-align-start sf-element sf-element-text-box sf-single-line-text"])[${i}]    Maximum
           element should not contain    xpath:(//div[@class="flex-item flex-align-start sf-element sf-element-text-box sf-single-line-text"])[${i}]    Average
    	END
    END
	wait for page to load
	capture page screenshot
	
verify the axis labels on PUCCH/PUSCH Analysis
	[Arguments]    ${interferenceMeasure}
	@{INDICES} =  Create List  1    3    4    5
	IF    "${interferenceMeasure}" == "Interference Power"
		FOR    ${i}    IN    @{INDICES}
           element should contain    xpath:(//div[@class="itemText sf-element sf-element-text-box"])[${i}]    Interference Power
           element should not contain    xpath:(//div[@class="itemText sf-element sf-element-text-box"])[${i}]    Noise Rise
           element should contain    xpath:(//div[@class="itemText sf-element sf-element-text-box"])[${i}]    Interference Power
           element should not contain    xpath:(//div[@class="itemText sf-element sf-element-text-box"])[${i}]    Noise Rise
    	END
    ELSE IF    "${interferenceMeasure}" == "Noise Rise"
		FOR    ${i}    IN     @{INDICES}
           element should contain    xpath:(//div[@class="itemText sf-element sf-element-text-box"])[${i}]    Noise Rise
           element should not contain    xpath:(//div[@class="itemText sf-element sf-element-text-box"])[${i}]    Interference Power
           element should contain    xpath:(//div[@class="itemText sf-element sf-element-text-box"])[${i}]    Noise Rise
           element should not contain    xpath:(//div[@class="itemText sf-element sf-element-text-box"])[${i}]    Interference Power
    	END
    END
	wait for page to load
	capture page screenshot
	
select the channel as	
	[Arguments] 	${channel}		
	wait for page to load
	${element}=    Get WebElements	    xpath: //div[@class='ComboBoxTextDivContainer']
    ${channelType}=        Get from list     ${element}    0
    Click element     ${channelType}
    Click element      xpath://div[@title='${channel}']	
	wait for page to load
	capture page screenshot
	
verify the title of the chart for channel
	[Arguments] 	${channel}
	element should contain    xpath:(//div[@class="flex-item flex-align-start sf-element sf-element-text-box sf-single-line-text"])[2]    ${channel}
    wait for page to load
	capture page screenshot

verify that the charts on PRB Analysis are named for
	[Arguments] 	${interferenceMeasure}		${aggregation}
	IF    "${interferenceMeasure}" == "Interference Power"
		FOR    ${i}    IN RANGE    1    2
           element should contain    xpath:(//div[@class="sf-element sf-element-visualization-description sfpc-top"])[1]    Interference Power
           element should not contain    xpath:(//div[@class="sf-element sf-element-visualization-description sfpc-top"])[1]    Noise Rise
        END
    ELSE IF    "${interferenceMeasure}" == "Noise Rise"
		FOR    ${i}    IN RANGE    1    2
           element should contain    xpath:(//div[@class="sf-element sf-element-visualization-description sfpc-top"])[1]    Noise Rise
           element should not contain    xpath:(//div[@class="sf-element sf-element-visualization-description sfpc-top"])[1]    Interference Power
    	END
    END
    IF    "${aggregation}" == "Average"
		FOR    ${i}    IN RANGE    1    2
           element should contain    xpath:(//div[@class="sf-element sf-element-visualization-description sfpc-top"])[1]    Average
           element should not contain    xpath:(//div[@class="sf-element sf-element-visualization-description sfpc-top"])[1]    Maximum
        END
    ELSE IF    "${aggregation}" == "Maximum"
		FOR    ${i}    IN RANGE    1    2
           element should contain    xpath:(//div[@class="sf-element sf-element-visualization-description sfpc-top"])[1]    Maximum
           element should not contain    xpath:(//div[@class="sf-element sf-element-visualization-description sfpc-top"])[1]    Average
        END
    END
	wait for page to load
	capture page screenshot
	
verify the axis labels on PRB Analysis
	[Arguments]    ${interferenceMeasure}
	IF    "${interferenceMeasure}" == "Interference Power"
		element should contain    xpath:(//div[@class="itemText sf-element sf-element-text-box"])[2]    Interference Power
        element should not contain    xpath:(//div[@class="itemText sf-element sf-element-text-box"])[2]    Noise Rise
    ELSE IF    "${interferenceMeasure}" == "Noise Rise"
		element should contain    xpath:(//div[@class="itemText sf-element sf-element-text-box"])[2]    Noise Rise
        element should not contain    xpath:(//div[@class="itemText sf-element sf-element-text-box"])[2]    Interference Power
    END
	wait for page to load
	capture page screenshot
	
verify the axis labels on Antenna Branch Analysis
	[Arguments]    ${interferenceMeasure}
	IF    "${interferenceMeasure}" == "Interference Power"
		element should contain    xpath:(//div[@class="itemText sf-element sf-element-text-box"])[2]    Interference Power
        element should not contain    xpath:(//div[@class="itemText sf-element sf-element-text-box"])[2]    Noise Rise
        element should contain    xpath:(//div[@class="itemText sf-element sf-element-text-box"])[3]    Interference Power
        element should not contain    xpath:(//div[@class="itemText sf-element sf-element-text-box"])[3]    Noise Rise
    ELSE IF    "${interferenceMeasure}" == "Noise Rise"
		element should contain    xpath:(//div[@class="itemText sf-element sf-element-text-box"])[2]    Noise Rise
        element should not contain    xpath:(//div[@class="itemText sf-element sf-element-text-box"])[2]    Interference Power
        element should contain    xpath:(//div[@class="itemText sf-element sf-element-text-box"])[3]    Noise Rise
        element should not contain    xpath:(//div[@class="itemText sf-element sf-element-text-box"])[3]    Interference Power
    END
	wait for page to load
	capture page screenshot
	
verify that the charts on Antenna Branch Analysis are named for
	[Arguments] 	${interferenceMeasure}		${aggregation}
	IF    "${interferenceMeasure}" == "Interference Power"
		FOR    ${i}    IN RANGE    1    2
           element should contain    xpath:(//div[@class="sf-element sf-element-visualization-description sfpc-top"])[1]    Interference Power
           element should not contain    xpath:(//div[@class="sf-element sf-element-visualization-description sfpc-top"])[1]    Noise Rise
        END
    ELSE IF    "${interferenceMeasure}" == "Noise Rise"
		FOR    ${i}    IN RANGE    1    2
           element should contain    xpath:(//div[@class="sf-element sf-element-visualization-description sfpc-top"])[1]    Noise Rise
           element should not contain    xpath:(//div[@class="sf-element sf-element-visualization-description sfpc-top"])[1]    Interference Power
    	END
    END
    IF    "${aggregation}" == "Average"
		FOR    ${i}    IN RANGE    1    2
           element should contain    xpath:(//div[@class="flex-item flex-align-start sf-element sf-element-text-box sf-single-line-text"])[1]    Average
           element should not contain    xpath:(//div[@class="flex-item flex-align-start sf-element sf-element-text-box sf-single-line-text"])[1]    Maximum
        END
    ELSE IF    "${aggregation}" == "Maximum"
		FOR    ${i}    IN RANGE    1    2
           element should contain    xpath:(//div[@class="flex-item flex-align-start sf-element sf-element-text-box sf-single-line-text"])[1]    Maximum
           element should not contain    xpath:(//div[@class="flex-item flex-align-start sf-element sf-element-text-box sf-single-line-text"])[1]    Average
        END
    END
	wait for page to load
	capture page screenshot
	
verify that the charts on Node Troubleshooting are named for	
	[Arguments] 	${interferenceMeasure}		${aggregation}
	sleep    10
	IF    "${interferenceMeasure}" == "Interference Power"
		FOR    ${i}    IN RANGE    1    8
           element should contain    xpath:(//div[@class="flex-item flex-align-start sf-element sf-element-text-box sf-single-line-text"])[${i}]    Interference Power
           element should not contain    xpath:(//div[@class="flex-item flex-align-start sf-element sf-element-text-box sf-single-line-text"])[${i}]    Noise Rise
    	END
    ELSE IF    "${interferenceMeasure}" == "Noise Rise"
		FOR    ${i}    IN RANGE    1    8
           element should contain    xpath:(//div[@class="flex-item flex-align-start sf-element sf-element-text-box sf-single-line-text"])[${i}]    Noise Rise
           element should not contain    xpath:(//div[@class="flex-item flex-align-start sf-element sf-element-text-box sf-single-line-text"])[${i}]    Interference Power
    	END
    END
	wait for page to load
	capture page screenshot
	
verify the x and y axis of the charts
	[Arguments]    ${interferenceMeasure}
	@{INDICES} =  Create List   2    3    4
	IF    "${interferenceMeasure}" == "Interference Power"
		FOR    ${i}    IN    @{INDICES}
           element should contain    xpath:(//div[@class="itemText sf-element sf-element-text-box"])[${i}]    Interference Power
           element should not contain    xpath:(//div[@class="itemText sf-element sf-element-text-box"])[${i}]    Noise Rise
        END
    ELSE IF    "${interferenceMeasure}" == "Noise Rise"
		FOR    ${i}    IN     @{INDICES}
           element should contain    xpath:(//div[@class="itemText sf-element sf-element-text-box"])[${i}]    Noise Rise
           element should not contain    xpath:(//div[@class="itemText sf-element sf-element-text-box"])[${i}]    Interference Power
        END
    END
	wait for page to load
	capture page screenshot
	
reading values from the tooltip in chart
	[Arguments]    ${chartName}
	sleep    5
	IF    "${chartName}" == "PRB Analysis"
    	Open Context Menu    xpath:(//div[@class="sf-element-canvas-image sfc-transition-background"])[5]
    ELSE IF    "${chartName}" == "Antenna Analysis"
    	Open Context Menu    xpath:(//div[@class="sf-element-canvas-image sfc-transition-background"])[7]
    ELSE IF    "${chartName}" == "PUCCH Analysis"
    	Open Context Menu    xpath:(//div[@class="sf-element-canvas-image sfc-transition-background"])[3]
    ELSE IF    "${chartName}" == "PUSCH Analysis"
    	Open Context Menu    xpath:(//div[@class="sf-element-canvas-image sfc-transition-background"])[6]
    END
    sleep    5
	click element      xpath://div[@title='Maximize visualization']
	sleep   2s
	mouse over      xpath:(//div[@class='sf-element-canvas-image'])[1]
	${toolTip}=    Selenium2Library.Get Text    xpath: //*[@class="sf-tooltip sf-plot-tooltip RoundedDropShadow"]
	[Log]    ${toolTip}
	${actualUiValue}=    Split String from Right    ${toolTip}
	[Log]    ${actualUiValue}
	${cellValue}=    Get From List    ${actualUiValue}    1
	${uiValue}=    Get From List    ${actualUiValue}    5
	[Log]    ${uiValue}    ${cellValue}
	Open Context Menu      xpath:(//div[@class='sf-element-canvas-image'])[1]
	sleep   2s
	click element      xpath://div[@title='Restore visualization layout']
	[Return]    ${uiValue}    ${cellValue}
	sleep    5
	wait for page to load
	capture page screenshot
	
get sql query from json file
    [Arguments]     ${json_file}     ${data}
    ${json}=    OperatingSystem.get file    ${json_file}
    &{object}=    Evaluate     json.loads('''${json}''')     json
    [return]       ${object}[${data}]
    wait for page to load
	capture page screenshot
    
Query ENIQ database
	[Arguments]       ${sql_query}    ${cellFDN}
	${sql_query}=     Replace String    ${sql_query}    @cellFDN 		 \'%${cellFDN}%'\
    log    ${sql_query}
    ${value}=     Query Sybase database     ${sql_query}
    log    ${value}
    ${string_value}=      Convert to string      ${value}[0]
    [return]     ${string_value}
    sleep    6
    wait for page to load
	capture page screenshot
	
Match UI with DB Value
	[Arguments]    ${uiValue}    ${DB_Value}
	Log    ${DB_Value}
	${DB_Value}=    Evaluate    ${DB_Value}+0.00
	Log    ${DB_Value}
	Log    ${uiValue}
	${uiValue}=    Evaluate    ${uiValue}+0.00
	Log    ${DB_Value}
	Log    ${uiValue}
	Verify UI value is matching with DB value    ${uiValue}     ${DB_Value}
	sleep    7
	wait for page to load
	capture page screenshot	
	
adjust the slider to 500 cells
	sleep    10
	Click on scroll right button on the current page    14    0
	wait for page to load
	capture page screenshot
	
Click on scroll right button on the current page
	[Arguments]    ${n}    ${instance}	
	sleep    2
	${element}=    Get WebElements    xpath: //div[@class='Button RightEnabled sf-element sf-element-button']
	${scroll_button}=    Get from list    ${element}    ${instance}
	FOR    ${i}    IN RANGE    0    ${n}
		Click element    ${scroll_button}
    END
    wait for page to load
	capture page screenshot
	
make selection on the PUCCH Cells chart
	sleep    5
	Selenium2Library.drag and drop by offset    xpath:(//div[@class="sf-element sf-element-canvas-visualization"])[3]    50    -120
	wait for page to load
	capture page screenshot
	
make selection on the PRB chart
	sleep    5
	Selenium2Library.drag and drop by offset    xpath:(//div[@class="sf-element sf-element-canvas-visualization"])[2]    50    -120
	wait for page to load
	capture page screenshot
	
make selection on the Antenna Branch Analysis chart
	sleep    5
	Selenium2Library.drag and drop by offset    xpath:(//div[@class="sf-element sf-element-canvas-visualization"])[2]    50    -120
	wait for page to load
	capture page screenshot

select the channel
	[Arguments]    ${channel}		
	Wait Until Element Is Visible     xpath:(//div[@class="ComboBoxTextDivContainer"])    30
	Click Element       xpath:(//div[@class="ComboBoxTextDivContainer"])
	sleep    3
	Wait Until Element Is Visible     xpath://div[@title="${channel}"]    30
	Click Element       xpath://div[@title="${channel}"]
	wait for page to load
	capture page screenshot	
	
select days for filtered data
	sleep    5
	Selenium2Library.drag and drop by offset    xpath:(//div[@class="sf-element sf-element-canvas-visualization"])[1]	 50    -120
	wait for page to load
	capture page screenshot
	
select days for filtered data for PRB
	sleep    5
	Selenium2Library.drag and drop by offset    xpath:(//div[@class="sf-element sf-element-canvas-visualization"])[2]	 80    -180
	wait for page to load
	capture page screenshot	
	
select days for filtered data for Antenna Branch Analysis
	sleep    5
	Selenium2Library.drag and drop by offset    xpath:(//div[@class="sf-element sf-element-canvas-visualization"])[2]	 80    -180
	wait for page to load
	capture page screenshot
	
Click on node troubleshooting button
	Wait Until Element Is Visible     xpath: //input[@value='Node Troubleshooting']    300
	Click on the scroll down button    0     5
	sleep    3s
    Click element     xpath: //input[@value='Node Troubleshooting']
	wait for page to load
	capture page screenshot
	
Click on PRB detailed analysis button
	Wait Until Element Is Visible     xpath: //div[@id="PRBButton"]    300
    Click element     xpath: //div[@id="PRBButton"]
	wait for page to load
	capture page screenshot
	
Click on PUCCH/PUSCH detailed analysis button
	Wait Until Element Is Visible     xpath: //div[@id="PUSCHPUCCHButton"]    300
    Click element     xpath: //div[@id="PUSCHPUCCHButton"]
	wait for page to load
	capture page screenshot
	
Click on antenna branch detailed analysis button
	Wait Until Element Is Visible     xpath: //div[@id="AntennaButton"]    300
    Click element     xpath: //div[@id="AntennaButton"]
	wait for page to load
	capture page screenshot
	
Click on filtered data button
	Wait Until Element Is Visible     xpath: //div[@id='RawDataButton']    300
    Click element     xpath: //div[@id='RawDataButton']
	wait for page to load
	capture page screenshot
	
Click on Fetch button
	sleep    2
	Wait Until Element Is Visible     xpath:(//div[@id="FetchButton"])    30
	Click Element       xpath:(//div[@id="FetchButton"])
	sleep    3
	wait for page to load
	capture page screenshot	
	
Click on fetch data button
    sleep    3s
	click on the scroll down button    4    45
	sleep    2s
	Wait Until Element Is Visible     xpath: //input[@value='Fetch Data']    300
    Click element     xpath: //input[@value='Fetch Data']
	wait for page to load
	capture page screenshot
	
Verify if the column is present in the Filtered data page
	[Arguments]    ${column_name}
	Wait Until Element Is Visible     xpath://div[(text()='${column_name}')]    300
    element should be visible    xpath://div[(text()='${column_name}')]
	sleep    2
	wait for page to load
	capture page screenshot

make selection on Interference Level chart
	sleep    5
	Selenium2Library.drag and drop by offset    xpath:(//div[@class="sf-element sf-element-canvas-visualization"])[2]	 50    -120
	wait for page to load
	capture page screenshot
	
make selection on Select Time Period chart
	sleep    5
	run keyword and ignore error       Selenium2Library.drag and drop        xpath:(//div[@class='sf-splitter'])[5]         xpath:(//div[@class='sf-element-canvas-image'])[1]
	sleep    2
	Selenium2Library.drag and drop by offset    xpath:(//div[@class="sf-element sf-element-canvas-visualization"])[3]	 50    -150
	wait for page to load
	capture page screenshot
	
Query the ENIQ Database and return output
	[Arguments]       ${sql_query}    ${dateTime}
	${sql_query}=     Replace String    ${sql_query}    @dateAndTime    \'${dateTime}'\
    log    ${sql_query}
    ${value}=     Query Sybase database     ${sql_query}
    log    ${value}
    ${string_value}=      Convert to string      ${value}[0]
    [return]     ${string_value}
    sleep    5
    wait for page to load
	capture page screenshot	
	
reading the dateTime and KPI values
	${dateTime}=    selenium2library.get text    xpath:(//div[@class="sf-element-table-cell flex-justify-start flex-align-start \ sfc-value-cell sfpc-odd-column sfpc-odd-row"])[1]
	${kpiValue}=    selenium2library.get text    xpath:(//div[@class="sf-element-table-cell flex-justify-end flex-align-start \ sfc-value-cell sfpc-even-column sfpc-odd-row"])[4]
	Log    ${dateTime}
	Log    ${kpiValue}
	[Return]    ${dateTime}    ${kpiValue}
	wait for page to load
	capture page screenshot	

select node for filtered data	
	[Arguments]    ${node}
	sleep     5
	wait for page to load
	FOR    ${i}    IN RANGE    0     10
		${status}=    run keyword and return status    Element Should Be Visible      xpath:(//div[@class="ScrollArea"])//div[contains(text(),'${node}')]
		IF      "${status}"=="False"
				Click on the scroll down button     3    1
				wait for page to load
		ELSE
				exit for loop
		END
	END
	Wait Until Element Is Visible     xpath:(//div[@class="ScrollArea"])//div[contains(text(),'${node}')]    300
    Click element     xpath:(//div[@class="ScrollArea"])//div[contains(text(),'${node}')]
	wait for page to load
	capture page screenshot		
	
verify that the filtered data page has data
	${value}=    selenium2library.get text    xpath:(//div[@class="${sfx_label}"])[1]
	Log    ${value}
	should not contain    ${value}    0 of 0 rows
	wait for page to load
	capture page screenshot
	
############################################# MR: EQEV-92472 #############################################

All input panels should be present
	element should be visible    xpath:(//div[@class="sf-element sf-element-visual-content sfc-text-area"])[3]
	element should be visible    xpath:(//div[@class="sf-element sf-element-visual-content sfc-text-area"])[4]
	wait for page to load
	capture page screenshot
	
verify that Cell/Branch drop down is visible and select Cell
	Wait Until Element Is Visible     xpath:(//div[@class="ComboBoxTextDivContainer"])[3]    300
    Click element     xpath:(//div[@class="ComboBoxTextDivContainer"])[3]
    sleep    5
    element should be visible    xpath:(//div[@title="Cell"])
    element should be visible    xpath:(//div[@title="Branch"])
    sleep    5
    Click element     xpath:(//div[@title="Cell"])
	wait for page to load
	capture page screenshot
	
verify that Band and Frequency check box is visible
	element should be visible    xpath://*[text()='Band and Frequency ']
	wait for page to load
	capture page screenshot
	
verify that Channel Bandwidth check box is visible
	element should be visible    xpath://*[text()='Channel Bandwidth ']
	wait for page to load
	capture page screenshot

verify the button is visible
	[Arguments]    ${buttonText}
	element should be visible     xpath://div[contains(text(),'${buttonText}')]    300
    wait for page to load
	capture page screenshot
	
verify that all navigation buttons are working
	click the button    Antenna Branch Analysis
	verify the page title    Antenna Branch Analysis
	click the button    << Uplink Interference Health Check
	verify the page title    Uplink Interference Health Check
	click the button    PRB Analysis
	click the button    << Uplink Interference Health Check
	verify the page title    Uplink Interference Health Check
	click the button    PUCCH/PUSCH Analysis
	verify the page title    PUCCH/PUSCH Analysis
	click the button    << Uplink Interference Health Check
	verify the page title    Uplink Interference Health Check


verify that the marked value is not 0
	wait until element is visible    xpath://div[@class="${sfx_label}"][3]    300
	${value}=    Selenium2Library.get text    xpath://div[@class="${sfx_label}"][2]
	Log    ${value}
	[Return]    ${value}
	#should not be equal    ${value}    0 marked
	wait for page to load
	capture page screenshot

verify that all navigation buttons on PUCCH/PUSCH: Detailed Analysis are working properly
	click the button    Filtered Data >>
	verify the page title    PUCCH/PUSCH Filtered Raw Data
	click the button    << PUSCH/PUCCH Detailed Analysis
	verify the page title    PUCCH/PUSCH: Detailed Analysis
	click the button    << PUCCH/PUSCH Analysis
	verify the page title    PUCCH/PUSCH Analysis

verify that all navigation buttons on PRB: Detailed Analysis are working properly
	click the button    Filtered Data >>
	verify the page title    PRB Filtered Raw Data
	click the button    << PRB Detailed Analysis
	verify the page title    PRB: Detailed Analysis
	click the button    << PRB Analysis
	verify the page title    PRB Analysis
	click the button    << Uplink Interference Health Check 
	verify the page title    Uplink Interference Health Check Cell
	click on the button    Home
	verify the page title    Home
	
select days for filtered data on PRB: Detailed Analysis
	sleep    5
	Selenium2Library.drag and drop by offset    xpath:(//div[@class="sf-element sf-element-canvas-visualization"])[2]	 50    -120
	wait for page to load
	capture page screenshot

verify that all navigation buttons on Health Check: Antenna Branch Detailed Analysis are working properly
	click the button    Filtered Data >>
	verify the page title    Antenna Branch Filtered Raw Data
	click the button    << Antenna Branch Detailed Analysis
	verify the page title    Antenna Branch: Detailed Analysis
	click the button    << Antenna Branch Analysis
	verify the page title    Antenna Branch Analysis
	click the button    << Uplink Interference Health Check 
	verify the page title    Uplink Interference Health Check Cell
	click on the button    Home
	verify the page title    Home

select days for filtered data on Health Check: Antenna Branch Detailed Analysis
	sleep    5
	Selenium2Library.drag and drop by offset    xpath:(//div[@class="sf-element sf-element-canvas-visualization"])[2]	 50    -120
	wait for page to load
	capture page screenshot

select eNodeB and click on Fetch Data 
    Wait Until Page Contains Element      xpath:(//div[@class="sf-element-list-box-item"])[1]    100
	Click Element    xpath:(//div[@class="sf-element-list-box-item"])[1]
	sleep    2
	${node}=    get text    xpath:(//div[@class="sf-element-list-box-item sfpc-selected"])
	Log    ${node}
	[Return]    ${node}
	sleep    5
	click on the scroll down button    4    45
	click on button    Fetch Data
    wait for page to load
	capture page screenshot

verify that Node Troubleshooting Page for the selected node is visible
	[Arguments]    ${node}
	${title}=    get text    xpath:(//div[@class="HtmlTextArea sf-enable-selection sf-focusable"])
	Log    ${title}
	[Return]    ${title}
	should contain    ${title}    ${node}
	wait for page to load
	capture page screenshot

verify that Cell/Branch drop down has Cell and Branch and select Cell
	Wait Until Page Contains Element      xpath:(//div[@class="ComboBoxTextDivContainer"])[3]    100
	Click Element    xpath:(//div[@class="ComboBoxTextDivContainer"])[3]
	sleep    3
	element should be visible    xpath:((//div[@class="ListItems"])[2])//div[@title="Cell"]
	element should be visible    xpath:((//div[@class="ListItems"])[2])//div[@title="Branch"]
	Wait Until Page Contains Element      xpath:((//div[@class="ListItems"])[2])//div[@title="Cell"]    100
	Click Element    xpath:((//div[@class="ListItems"])[2])//div[@title="Cell"]
	wait for page to load
	capture page screenshot

verify that the check box 'Band and Frequency' is visible
	element should be visible    xpath://*[contains(text(),'Band and Frequency')]
	wait for page to load
	capture page screenshot
	
verify that the check box 'Channel Bandwidth' is visible
	element should be visible    xpath://*[contains(text(),'Channel Bandwidth')]
	wait for page to load
	capture page screenshot

verify that all navigation buttons on Node Troubleshooting Page are working properly
	click the button    Antenna Branch Detailed Analysis
	verify the page title    Antenna Branch: Detailed Analysis
	click the button    << Node Troubleshooting
	verify the page title    Node Troubleshooting
	click the button    PRB Detailed Analysis
	verify the page title    PRB: Detailed Analysis
	click the button    << Node Troubleshooting
	verify the page title    Node Troubleshooting
	click the button    PUCCH/PUSCH Detailed Analysis
	verify the page title    PUCCH/PUSCH: Detailed Analysis
	click the button    << Node Troubleshooting
	verify the page title    Node Troubleshooting
	click on the button    Home
	verify the page title    Home

make selection on Worst 100 PUCCH Cells by Interference Power
	Wait Until Element Is Visible     xpath:(//div[@class="sf-element-canvas-image"])[2]    300
    Selenium2Library.drag and drop by offset    xpath:(//div[@class="sf-element-canvas-image"])[2]    20    20
    wait for page to load
	capture page screenshot
	
make selection on Worst 100 PUSCH Cells by Interference Power
	Wait Until Element Is Visible     xpath:(//div[@class="sf-element-canvas-image"])[5]    300
    Selenium2Library.drag and drop by offset    xpath:(//div[@class="sf-element-canvas-image"])[5]    20    20
    wait for page to load
	capture page screenshot

select a node for comparison
	Wait Until Page Contains Element      xpath:((//div[@class='ListItems'])//div[contains(@class,'sf-element-list-box-item')])[1]    100
	Click Element    xpath:((//div[@class='ListItems'])//div[contains(@class,'sf-element-list-box-item')])[1]
	wait for page to load
	capture page screenshot
	
make selection on Worst 100 PUSCH PRB Cells by Interference Power
	Wait Until Element Is Visible     xpath:(//div[@class="sf-element-canvas-image"])[2]    300
	Run keyword and ignore error       Selenium2Library.drag and drop     xpath:(//div[@class='sf-element-thumb TouchTarget'])[4]              xpath:(//div[@class='sf-element-thumb TouchTarget'])[3]
    sleep     2
	Run keyword and ignore error       Selenium2Library.drag and drop     xpath:(//div[@class='sf-element-thumb TouchTarget'])[4]              xpath:(//div[@class='sf-element-thumb TouchTarget'])[3]
    sleep     2

	Selenium2Library.drag and drop by offset    xpath:(//div[@class="sf-element-canvas-image"])[2]    20    20
	
    wait for page to load
	capture page screenshot

############################################# MR: EQEV-92472 END ########################################
make selection on Worst 100 PUCCH Cells by Interference Power in PUCCH/PUSCH Analysis page
	Wait Until Element Is Visible     xpath:(//div[@class="sf-element-canvas-image"])[3]    300
    Selenium2Library.drag and drop by offset    xpath:(//div[@class="sf-element-canvas-image"])[3]    20    20
    wait for page to load
	capture page screenshot
	
	
############################################# TR: IA81685 START #############################################
select cell value in PRB analysis page
	sleep     5
	Wait Until Element Is Visible     xpath:(//div[contains(@class,'sf-element-list-box-item')])[1]    300
    Click element     xpath:(//div[contains(@class,'sf-element-list-box-item')])[1]
	wait for page to load
	capture page screenshot	
	
verify that Band and frequency has some values
	Wait Until Page Contains Element    xpath:(//div[@class="flex-item flex-align-start sf-element sf-element-text-box"])[3]    300
	${value}=    Selenium2Library.get text    xpath:(//div[@class="flex-item flex-align-start sf-element sf-element-text-box"])[3]
	Log    ${value}
	[Return]    ${value}
	should not be equal    ${value}    (Empty)
	wait for page to load
	capture page screenshot

verify that Channel Bandwidth has some values
	wait until element is visible    xpath:(//div[@class="flex-item flex-align-start sf-element sf-element-text-box"])[7]    300
	${value}=    Selenium2Library.get text    xpath:(//div[@class="flex-item flex-align-start sf-element sf-element-text-box"])[7]
	Log    ${value}
	[Return]    ${value}
	should not be equal    ${value}    (Empty)
	wait for page to load
	capture page screenshot

verify that Band and frequency has some values in node trouble shooting
	wait until element is visible    xpath:(//div[@class="flex-item flex-align-start sf-element sf-element-text-box"])[1]    300
	${value}=    Selenium2Library.get text    xpath:(//div[@class="flex-item flex-align-start sf-element sf-element-text-box"])[1]
	Log    ${value}
	[Return]    ${value}
	should not be equal    ${value}    (Empty)
	wait for page to load
	capture page screenshot
	
verify that Channel Bandwidth has some values in node trouble shooting
	wait until element is visible    xpath:(//div[@class="flex-item flex-align-start sf-element sf-element-text-box"])[5]    300
	${value}=    Selenium2Library.get text    xpath:(//div[@class="flex-item flex-align-start sf-element sf-element-text-box"])[5]
	Log    ${value}
	[Return]    ${value}
	should not be equal    ${value}    (Empty)
	wait for page to load
	capture page screenshot
	
############################################# TR: IA81685 END #############################################