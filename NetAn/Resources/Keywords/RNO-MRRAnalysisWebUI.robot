*** Keywords ***

open rno-mrr analysis
	${chrome_options}=    Evaluate    sys.modules['selenium.webdriver'].ChromeOptions()      sys
	Call Method    ${chrome_options}    add_argument    --ignore-certificate-errors
	Create Webdriver    Chrome    executable_path=${EXEC_DIR}/ENIQ_TC_Automation/NetAn/Resources/Drivers/chromedriver.exe      chrome_options=${chrome_options}
    Go To    ${base_url}   
    Maximize Browser Window
    Sleep    3
    Selenium2Library.Input Text    name:username    Administrator
    Selenium2Library.Input Text    name:password    Ericsson01
    Click Element    class:LoginButton
    sleep    3
    Go To    ${base_url}${rno-mrr_url}
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
    capture page screenshot				   
    
wait for page to load
    sleep   10
    Wait Until Element Is Not Visible     class:sfx_progress-bar-container_1118        timeout=2400
    sleep   10   
    Wait Until Element Is Not Visible     class:sfx_progress-bar-container_1118        timeout=2400
    sleep   10
    
verify the page title  
	[Arguments]     ${expectedText}
	wait for page to load
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
	
Go to home page if not already at home
	${pageTitle}=    Selenium2Library.Get text  xpath: //*[@class="sfx_page-title_219"]
	IF 		"${pageTitle}" != "GSM Optimisation Reports"
        scroll element into view		xpath: //*[@title="Home"]
		Click element     xpath: //*[@title="Home"]
	END
	wait for page to load
	capture page screenshot
	
Suite setup steps    
    Set Screenshot Directory   ./Screenshots

Suite teardown steps
    Capture page screenshot
 
network analytics logo should be visible
	scroll element into view	xpath:(//div[@class="HtmlTextArea sf-enable-selection sf-focusable"])//div[1]//div[1]//div[1]//table[1]//tbody//tr//td//p//img[1]
	element should be visible    xpath:(//div[@class="HtmlTextArea sf-enable-selection sf-focusable"])//div[1]//div[1]//div[1]//table[1]//tbody//tr//td//p//img[1]
	wait for page to load
	capture page screenshot
	
rno-mrr logo should be visible
	scroll element into view	xpath:(//div[@class="HtmlTextArea sf-enable-selection sf-focusable"])//div[1]//div[1]//div[1]//table[1]//tbody[1]//tr[2]//td[1]//img[1]
	element should be visible    xpath:(//div[@class="HtmlTextArea sf-enable-selection sf-focusable"])//div[1]//div[1]//div[1]//table[1]//tbody[1]//tr[2]//td[1]//img[1]
	wait for page to load
	capture page screenshot
	
verify that the button is visible
	[Arguments]    ${button}
	scroll element into view	xpath://*[@title="${button}"]
	element should be visible    xpath://*[@title="${button}"]
	wait for page to load
	capture page screenshot
	
validate that the button is visible
	[Arguments]    ${button}
	scroll element into view	xpath://*[@value="${button}"]
	element should be visible    xpath://*[@value="${button}"]
	wait for page to load
	capture page screenshot
	
click on button
	[Arguments]    ${buttonValue}
	sleep     5
	scroll element into view	xpath: //*[@value='${buttonValue}']
	Wait Until Element Is Visible     xpath: //*[@value='${buttonValue}']    300
    Click element     xpath: //*[@value='${buttonValue}']
	wait for page to load
	capture page screenshot
	
click on the button
	[Arguments]    ${buttonTitle}
	sleep     5
	scroll element into view	xpath: //*[@title='${buttonTitle}']
	Wait Until Element Is Visible     xpath: //*[@title='${buttonTitle}']    300
    Click element     xpath: //*[@title='${buttonTitle}']
	wait for page to load
	capture page screenshot
	
click on PUCCH/PUSCH Analysis button
	sleep     5
	scroll element into view	xpath: //*[@id='PUSCHPUCCHButton']
	Wait Until Element Is Visible     xpath: //*[@id='PUSCHPUCCHButton']    300
    Click element     xpath: //*[@id='PUSCHPUCCHButton']
	wait for page to load
	capture page screenshot
	
click on button with id
	[Arguments]    ${buttonId}
	sleep     5
	Wait Until Element Is Visible     xpath: //*[@id='${buttonId}']    300
	scroll element into view	xpath: //*[@id='${buttonId}']
    Click element     xpath: //*[@id='${buttonId}']
	wait for page to load
	capture page screenshot
	
click the button
	[Arguments]    ${buttonText}
	Wait Until Element Is Visible     xpath://*[contains(text(),'${buttonText}')]    30
	scroll element into view	xpath://*[contains(text(),'${buttonText}')]
	Click Element       xpath://*[contains(text(),'${buttonText}')]
	wait for page to load
	capture page screenshot
	
verify that all statistical threshold dropdowns respond
	FOR    ${i}    IN RANGE    2    50    2
	    IF    "${i}" == "26"
	        click on the scroll down button    0    25
		    Wait Until Element Is Visible     xpath:(//div[@class="ComboBoxTextDivContainer"])[${i}]    30
		    scroll element into view	xpath:(//div[@class="ComboBoxTextDivContainer"])[${i}]
		    Click Element       xpath:(//div[@class="ComboBoxTextDivContainer"])[${i}]
		    sleep    2
		    element should be visible    xpath://div[@class="ScrollArea"]
		ELSE
		    Wait Until Element Is Visible     xpath:(//div[@class="ComboBoxTextDivContainer"])[${i}]    30
		    scroll element into view	xpath:(//div[@class="ComboBoxTextDivContainer"])[${i}]
		    Click Element       xpath:(//div[@class="ComboBoxTextDivContainer"])[${i}]
		    sleep    2
		    element should be visible    xpath://div[@class="ScrollArea"]
		END
	END
	wait for page to load
	capture page screenshot
	
verify that all Percentile Markers respond
	FOR    ${i}    IN RANGE    1    13
	    IF    "${i}" == "7"
	        click on the scroll down button    0    21
		    ${text}=    Selenium2Library.get text    xpath:(//span[@class="ValueLabel"])[${i}]
		    Wait Until Element Is Visible     xpath:(//div[@class="Button LeftEnabled sf-element sf-element-button"])[${i}]    30		
		    FOR    ${j}    IN RANGE    0    10
			    scroll element into view	xpath:(//div[@class="Button LeftEnabled sf-element sf-element-button"])[${i}]
			    click element    xpath:(//div[@class="Button LeftEnabled sf-element sf-element-button"])[${i}]
			    sleep    1
		    END
		    sleep    1
		    ${text1}=    Selenium2Library.get text    xpath:(//span[@class="ValueLabel"])[${i}]
		    should not be equal    ${text}    ${text1}
	    ELSE
	        ${text}=    Selenium2Library.get text    xpath:(//span[@class="ValueLabel"])[${i}]
		    Wait Until Element Is Visible     xpath:(//div[@class="Button LeftEnabled sf-element sf-element-button"])[${i}]    30		
		    FOR    ${j}    IN RANGE    0    10
			    scroll element into view	xpath:(//div[@class="Button LeftEnabled sf-element sf-element-button"])[${i}]
			    click element    xpath:(//div[@class="Button LeftEnabled sf-element sf-element-button"])[${i}]
			    sleep    1
		    END
		    sleep    1
		    ${text1}=    Selenium2Library.get text    xpath:(//span[@class="ValueLabel"])[${i}]
		    should not be equal    ${text}    ${text1}
		 END
	END
	wait for page to load
	capture page screenshot
	
verify that the Select No. of Days Recordings to Display drop down is visible
	element should be visible    xpath:(//div[@class="ComboBoxTextDivContainer"])[49]	
	wait for page to load
	capture page screenshot
	
set the number of days to be
	[Arguments]    ${days}
	Wait Until Element Is Visible    xpath:(//div[@class="ComboBoxTextDivContainer"])[49]
	scroll element into view	xpath:(//div[@class="ComboBoxTextDivContainer"])[49]
	click element    xpath:(//div[@class="ComboBoxTextDivContainer"])[49]
	sleep    2
	click element    xpath://div[@title="${days}"]
	wait for page to load
	capture page screenshot
	
reduce the values of Percentile Ranges by
	[Arguments]    ${n}
	FOR    ${i}    IN RANGE    1    5
		${text}=    Selenium2Library.get text    xpath:(//span[@class="ValueLabel"])[${i}]
		Wait Until Element Is Visible     xpath:(//div[@class="Button LeftEnabled sf-element sf-element-button"])[${i}]    30
		FOR    ${j}    IN RANGE    0    ${n}
		    scroll element into view	xpath:(//div[@class="Button LeftEnabled sf-element sf-element-button"])[${i}]
			click element    xpath:(//div[@class="Button LeftEnabled sf-element sf-element-button"])[${i}]
			sleep    1
		END
		sleep    1
	END
	wait for page to load
	capture page screenshot

	
set value to Statistical Thresholds
	[Arguments]    ${n}
	FOR    ${i}    IN RANGE    2    8    2
		Wait Until Element Is Visible     xpath:(//div[@class="ComboBoxTextDivContainer"])[${i}]    30
		scroll element into view	xpath:(//div[@class="ComboBoxTextDivContainer"])[${i}]
		Click Element       xpath:(//div[@class="ComboBoxTextDivContainer"])[${i}]
		sleep    1
		click element    xpath://div[@title="${n}"]
		sleep    1
	END
	wait for page to load
	capture page screenshot
	
verify that the Data Resolution drop down is visible
	element should be visible    xpath:(//div[@class="ComboBoxTextDivContainer"])[50]	
	wait for page to load
	capture page screenshot
	
select the data resolution
	[Arguments]    ${dataResolution}
	Wait Until Element Is Visible    xpath:(//div[@class="ComboBoxTextDivContainer"])[50]
	scroll element into view	xpath:(//div[@class="ComboBoxTextDivContainer"])[50]
	click element    xpath:(//div[@class="ComboBoxTextDivContainer"])[50]
	sleep    2
	scroll element into view	xpath://div[@title="${dataResolution}"]
	click element    xpath://div[@title="${dataResolution}"]
	wait for page to load
	capture page screenshot
	
verify that recordings are present in Individual Recordings
	${text}=    Selenium2Library.get text    xpath:(//div[@class="valueCellsContainer"])[1]
	Log    ${text}
	should contain    ${text}    BAA
	wait for page to load
	capture page screenshot
	
select a recording
	[Arguments]    ${recording}
	Wait Until Element Is Visible     xpath://*[contains(text(),'${recording}')]    30
	scroll element into view	xpath://*[contains(text(),'${recording}')]
	Click Element       xpath://*[contains(text(),'${recording}')]
	wait for page to load
	capture page screenshot
	
verify that selected recording is loaded
	[Arguments]    ${selected}
	sleep    10
	wait for page to load
	${text}=    Selenium2Library.get text    xpath:(//div[@class="valueCellsContainer"])[2]
	Log    ${text}
	should contain    ${text}    ${selected}
	wait for page to load
	capture page screenshot
	
select recordings for
	[Arguments]    ${recordings}
    wait for page to load
	#scroll element into view	xpath://*[contains(text(),'${recordings}')]
    Click element      xpath:(//div[@row="1" and @column="0"])
    sleep    2
	#scroll element into view	xpath:(//*[contains(text(),'${recordings}')])[2]
    Click element      xpath:(//div[@row="2" and @column="0"])      modifier=CTRL
    wait for page to load
	capture page screenshot
	
enter the group name
	[Arguments]    ${name}
	Clear Element Text      xpath://input[@class="sf-element sf-element-control sfc-property sfc-text-box"]
    Selenium2Library.Input Text     xpath://input[@class="sf-element sf-element-control sfc-property sfc-text-box"]     ${name} 
    wait for page to load
	capture page screenshot
	
verify that the created group is present
	[Arguments]    ${name}
	${text}=    Selenium2Library.get text    xpath:(//div[@name="valueCellsContainer"])[1]
	${status}=    run keyword and return status    should contain    ${text}    ${name}
	FOR    ${i}    IN RANGE    0    10
		Exit For Loop IF    "${status}"=="True"
		IF    "${status}"=="False"
			place the cursor on    GroupingName
			click on the scroll down button    3    2
			${text}=    Selenium2Library.get text    xpath:(//div[@name="valueCellsContainer"])[1]
			${status}=    run keyword and return status    should contain    ${text}    ${name}
			Exit For Loop IF    "${status}"=="True"
		END
	END	
	wait for page to load
	capture page screenshot
	
verify that the Grouped Recordings is created
	[Arguments]    ${name}
	sleep    5
	${verification}=    Selenium2Library.get text    xpath:(//span[@class="important"])
	pass execution if    "${verification}"!="${name}"    Recordings with same BSC name not found.
	should contain    ${verification}    ${name}
	wait for page to load
	capture page screenshot
	
change the View to
	[Arguments]    ${view}
	Wait Until Page Contains Element      xpath://div[@class="sfx_simple-dropdown_935 sfx_enabled_934"]     timeout=15
	Click Element      xpath://div[@class="sfx_simple-dropdown_935 sfx_enabled_934"]
	sleep    5
	Wait Until Page Contains Element      xpath://div[@title="${view}"]     timeout=15
	Click Element      xpath://div[@title="${view}"]
	
change to page navigation to
	[Arguments]    ${mode}
	Wait Until Page Contains Element      xpath:(//div[@class="sfx_page-title_219"])     timeout=30
	open context menu      xpath:(//div[@class="sfx_page-title_219"])
	sleep    2
	Wait Until Page Contains Element      xpath:(//div[@class="contextMenuItemLabel"])[1]     timeout=30
	scroll element into view	xpath:(//div[@class="contextMenuItemLabel"])[1]
	Click Element      xpath:(//div[@class="contextMenuItemLabel"])[1]
	sleep    2
	Wait Until Page Contains Element      xpath:(//div[@title="${mode}"])     timeout=30
	scroll element into view	xpath:(//div[@title="${mode}"])
	Click Element      xpath:(//div[@title="${mode}"])
	wait for page to load
	capture page screenshot	
	
validate the page title
	[Arguments]    ${title}	
	Wait Until Page Contains Element      xpath:(//div[@class="sfx_page-tab_204 sf-element-page-tab sfx_active-page-tab_203 sf-element-active-page-tab"])//span[1]
	${text}=    Selenium2Library.get text    xpath:(//div[@class="sfx_page-tab_204 sf-element-page-tab sfx_active-page-tab_203 sf-element-active-page-tab"])//span[1]
	Log    ${text}
	should be equal    ${text}    ${title}
	wait for page to load
	capture page screenshot
	
select a group
	[Arguments]    ${group}
	Wait Until Element Is Visible     xpath://*[contains(text(),'${group}')]    30
	scroll element into view	xpath://*[contains(text(),'${group}')]
	Click Element       xpath://*[contains(text(),'${group}')]
	wait for page to load
	capture page screenshot
	
verify that the selected group is loaded
	[Arguments]    ${name}
	wait for page to load
	sleep    120
	${text}=    Selenium2Library.get text    xpath:(//div[@name="valueCellsContainer"])[2]
	should contain    ${text}    ${name}
	wait for page to load
	capture page screenshot
	
verify that the group is deleted
	[Arguments]    ${name}
	sleep    5
	wait for page to load
	sleep   120
	${text}=    Selenium2Library.get text    xpath:(//div[@name="valueCellsContainer"])[2]
	should not contain    ${text}    ${name}
	wait for page to load
	capture page screenshot
	
click on MRR Trend Report button
	Wait Until Element Is Visible     xpath:(//*[contains(text(),'MRR Trend Report')])[2]    30
	scroll element into view	xpath:(//*[contains(text(),'MRR Trend Report')])[2]
	Click Element       xpath:(//*[contains(text(),'MRR Trend Report')])[2]
	wait for page to load
	capture page screenshot
	
verify that Filter Measures drop down and its contents are visible
	element should be visible     xpath:(//div[@class="ComboBoxTextDivContainer"])    30
	scroll element into view	xpath:(//div[@class="ComboBoxTextDivContainer"])
	Click Element       xpath:(//div[@class="ComboBoxTextDivContainer"])
	sleep    2
	element should be visible    xpath:(//div[@class="sf-element-dropdown-list sfc-scrollable"])
	wait for page to load
	capture page screenshot
	
select a measure from Filter Measures drop down
	[Arguments]    ${measure}
	Wait Until Element Is Visible     xpath:(//div[@class="ComboBoxTextDivContainer"])    30
	Click Element       xpath:(//div[@class="ComboBoxTextDivContainer"])
	sleep    2
	Wait Until Element Is Visible    xpath://div[@title="${measure}"]
	scroll element into view	xpath://div[@title="${measure}"]
	Click Element       xpath://div[@title="${measure}"]
	wait for page to load
	capture page screenshot
	
verify that the selected measure reflects on the chart title
	[Arguments]    ${measure}
	${title}=    Selenium2Library.get text    xpath:(//div[@class="flex-item flex-align-start sf-element sf-element-text-box sf-single-line-text"])[1]
	Log    ${title}
	should contain    ${title}    ${measure}    
	wait for page to load
	capture page screenshot
	
select the measure
	[Arguments]    ${measure}
	scroll element into view	xpath://div[@title="${measure}"]
	Click Element       xpath:(//div[@title="${measure}"])
	wait for page to load
	capture page screenshot
	
verify that the measure is added to the Overview Table View
	[Arguments]    ${measure}
	${text}=    Selenium2Library.get text    xpath:(//div[@name="frozenRowsContainer"])
	should contain    ${text}    ${measure}
	wait for page to load
	capture page screenshot
	
verify that the measure is not present in Overview Table View
	[Arguments]    ${measure}
	sleep    5
	${text}=    Selenium2Library.get text    xpath:(//div[@name="frozenRowsContainer"])
	should not contain    ${text}    ${measure}
	wait for page to load
	capture page screenshot
	
verify that 'Select Measure' is visible
	${text}=    get text    xpath:(//div[@class="HtmlTextArea sf-enable-selection sf-focusable"])[4]//div[1]//h3
	Log    ${text}
	should be equal    ${text}    Select Measures
	scroll element into view	xpath:(//div[@class="HtmlTextArea sf-enable-selection sf-focusable"])[4]//div[1]//span[1]
	element should be visible    xpath:(//div[@class="HtmlTextArea sf-enable-selection sf-focusable"])[4]//div[1]//span[1]
	wait for page to load
	capture page screenshot

verify that 'Select Cell' is visible
	scroll element into view	xpath://*[contains(text(),'Select Cell ')]
	element should be visible     xpath://*[contains(text(),'Select Cell ')]
	sleep    2
	click element    xpath:(//div[@class="ComboBoxTextDivContainer"])[1]
	sleep    2
	element should be visible    xpath:(//div[@class="ScrollArea"])[2]
	wait for page to load
	capture page screenshot
	
verify that 'Filter Measure' is present
	scroll element into view	xpath://*[contains(text(),'Filter Measure')]
	element should be visible     xpath://*[contains(text(),'Filter Measure')]
	wait for page to load
	capture page screenshot
	
verify that 'Cell Filter' is present
	scroll element into view	xpath://*[contains(text(),'Cell Filter')]
	element should be visible     xpath://*[contains(text(),'Cell Filter')]
	wait for page to load
	capture page screenshot
	
verify that 'Select Channel Group' is present
	Click on the scroll down button    4    20
	scroll element into view	xpath://*[contains(text(),'Select Channel Group ')]
	element should be visible     xpath://*[contains(text(),'Select Channel Group ')]
	sleep    2
	scroll element into view	xpath:(//div[@class="ComboBoxTextDivContainer"])[1]
	click element    xpath:(//div[@class="ComboBoxTextDivContainer"])[1]
	sleep    2
	scroll element into view	xpath:(//div[@class="ScrollArea"])[2]
	element should be visible    xpath:(//div[@class="ScrollArea"])[2]
	wait for page to load
	capture page screenshot
	
verify that 'Filter No. of Cells' is present
	scroll element into view	xpath://*[contains(text(),'Filter no. of Cells')]
	element should be visible     xpath://*[contains(text(),'Filter no. of Cells')]
    wait for page to load
	capture page screenshot
	
click on MRR Comparison Chart button
	scroll element into view	xpath:(//*[contains(text(),'MRR Comparison Chart')])[2]
	Wait Until Element Is Visible     xpath:(//*[contains(text(),'MRR Comparison Chart')])[2]    30
	scroll element into view	xpath:(//*[contains(text(),'MRR Comparison Chart')])[2]
	Click Element       xpath:(//*[contains(text(),'MRR Comparison Chart')])[2]
	wait for page to load
	capture page screenshot
	
click on MRR Cell Comparison Overview Histogram button
	Wait Until Element Is Visible     xpath:(//*[contains(text(),'MRR Comparison Overview Histogram')])[2]    30
	scroll element into view	xpath:(//*[contains(text(),'MRR Comparison Overview Histogram')])[2]
	Click Element       xpath:(//*[contains(text(),'MRR Comparison Overview Histogram')])[2]
	wait for page to load
	capture page screenshot
	
verify that the file is exported
	sleep    60
	${verification}=    get text    xpath:(//td[@class="action-button"])//span[1]
	Log    ${verification}
	should be equal    ${verification}    File exported to 'C:\\NetAn_MRRMSMT_Exports'
	wait for page to load
	capture page screenshot
	
verify that the Histograms are visible
	scroll element into view	xpath:(//div[@class="flex-item flex-align-start sf-element sf-element-text-box sf-single-line-text"])
	element should be visible    xpath:(//div[@class="flex-item flex-align-start sf-element sf-element-text-box sf-single-line-text"])
	element should be visible    xpath:(//div[@class="sf-element sf-element-visualization-description sfpc-top"])
	element should be visible    xpath:(//div[@class="sf-element-canvas-image sfc-transition-background"])
	wait for page to load
	capture page screenshot
	
click on MRR Comparison Report button
	scroll element into view	xpath:(//*[contains(text(),'MRR Comparison Report')])[2]
	Wait Until Element Is Visible     xpath:(//*[contains(text(),'MRR Comparison Report')])[2]    30
	Click Element       xpath:(//*[contains(text(),'MRR Comparison Report')])[2]
	wait for page to load
	capture page screenshot
	
verify that the Comparison chart is visible
	scroll element into view	xpath:(//div[@class="flex-item flex-align-start sf-element sf-element-text-box sf-single-line-text"])
	element should be visible    xpath:(//div[@class="flex-item flex-align-start sf-element sf-element-text-box sf-single-line-text"])
	element should be visible    xpath:(//div[@class="sf-element sf-element-tabular-content"])
	wait for page to load
	capture page screenshot
	
verify that the MRR Trend Report charts are visible
	scroll element into view	xpath:(//div[@class="flex-item flex-align-start sf-element sf-element-text-box sf-single-line-text"])
	element should be visible    xpath:(//div[@class="flex-item flex-align-start sf-element sf-element-text-box sf-single-line-text"])
	element should be visible    xpath:(//div[@class="sf-element-canvas-image sfc-transition-background"])
	element should be visible    xpath:(//div[@class="flex-item flex-align-start sf-element sf-element-text-box sf-single-line-text"])[2]
	element should be visible    xpath:(//div[@class="sf-element sf-element-visual-content sfc-cross-table"])
	wait for page to load
	capture page screenshot
    wait for page to load
    capture page screenshot