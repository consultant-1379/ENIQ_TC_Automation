*** Variables ***
${username_xpath}       //input[@class='w-full pt-2 pb-2 pl-3 text-ellipsis pr-3 ng-untouched ng-pristine ng-invalid' and @placeholder='Username']
${password_xpath}        //input[@class='w-full pt-2 pb-2 pl-3 text-ellipsis pr-3 ng-untouched ng-pristine ng-invalid' and @placeholder='Password']
${loginButton_xpath}      //button[@data-testid='login-button']
${sfx_label}                sfx_label_1333
${sfx_page_title}         (//div[@class="sfx_page-title_1329"])
${author_dropdown}        //div[@class='sfx_author-dropdown_1174']
${save_analysis_button}           (//div[text()='Save'])[3]
${visualisations_type}           sfx_button_318 sfx_button-enabled_317
${sfx_progress-bar}              sfx_progress-bar-container_65
${analytics_page}               //div[@class='bg-tibco-app-bg-analytics flex h-20 hover:shadow-tibco-shadow-4 items-center justify-center rounded-lg shadow-tibco-shadow-1 text-5xl text-tibco-app-icon-analytics transition w-20']
${page_tab}                     sfx_page-tab_1314 sf-element-page-tab
${notification_container}    sfx_notification-panel-empty_334
${notification_container1}    sfx_notification-panel-empty_492





*** Keywords ***

suite setup for webui
	Set Environment Variable  webdriver.chrome.driver    ./drivers/chromedriver.exe
	Set Screenshot Directory   ./Screenshots

	
open NR app coverage map analysis
    ${chrome_options}=    Evaluate    sys.modules['selenium.webdriver'].ChromeOptions()      sys
	#Call Method    ${chrome_options}    add_argument    --incognito
	Call Method    ${chrome_options}    add_argument    --ignore-certificate-errors
	Create Webdriver    Chrome    options=${chrome_options}
    Go To    ${base_url}   
    Maximize Browser Window
    Sleep    5
    Selenium2Library.Input Text    xpath:${username_xpath}     Administrator
    Selenium2Library.Input Text    xpath:${password_xpath}    Ericsson01
    Click Element    xpath:${loginButton_xpath}  
    Sleep    5
    Go To    ${base_url}${nr_app_coverage_url}
    #${IsElementVisible}=    Run Keyword And Return Status    Element Should not be Visible    xpath://div[contains(text(),'Missing Data')]
	#Run Keyword If    ${IsElementVisible} is ${FALSE}   Close missing data window
    wait for page to load
    Sleep    2s
    capture page screenshot
	
	
network analytics logo should be visible
	element should be visible    xpath:((//div[@class="HtmlTextArea sf-enable-selection sf-focusable"])//table//img)[1]
	wait for page to load
	capture page screenshot
	
NR app coverage map logo should be visible
	element should be visible    xpath:((//div[@class="HtmlTextArea sf-enable-selection sf-focusable"])//table//img)[2]
	wait for page to load
	capture page screenshot
	
validate that the button is visible
	[Arguments]    ${button}
	element should be visible    xpath://*[@value="${button}"]
	wait for page to load
	capture page screenshot
	
verify that the button is visible
	[Arguments]    ${button}
	element should be visible    xpath://*[@title="${button}"]
	wait for page to load
	capture page screenshot
	
click on the button
	[Arguments]    ${buttonTitle}
	sleep     5
	Wait Until Element Is Visible     xpath: //*[@title='${buttonTitle}']    300
    Click element     xpath: //*[@title='${buttonTitle}']
	wait for page to load
	capture page screenshot
	
verify the page title  
	[Arguments]     ${expectedText}
    ${text}=    Selenium2Library.Get text  xpath: ${sfx_page_title}
    Log    ${text}
    Should contain     ${expectedText}	 ${text}
    wait for page to load
	capture page screenshot
	
	
	
click on button
	[Arguments]    ${buttonValue}
	sleep     5
	Wait Until Element Is Visible     xpath: //*[@value='${buttonValue}' or @title='${buttonValue}']    300
    Click element     xpath: //*[@value='${buttonValue}' or @title='${buttonValue}']
	wait for page to load
	capture page screenshot
	
Test teardown
    Capture page screenshot
    Close Browser
	
	
Suite setup steps for NR App Coverage
    Set Screenshot Directory   ./Screenshots
	

Suite teardown steps for NR App Coverage
    Capture page screenshot
	Close Browser
	
	
	
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
	
	
make a selection on the Worst Performing Cells chart
	wait until element is visible    xpath://div[@class="sf-element sf-element-canvas-visualization"]    300
	Selenium2Library.drag and drop by offset    xpath://div[@class="sf-element sf-element-canvas-visualization"]    50    5							   
	wait for page to load
	capture page screenshot
	
	
read the marked value
	wait until element is visible    xpath://div[@class='sfx_label_1333'][2]   300
	${value}=    Selenium2Library.get text    xpath://div[@class='sfx_label_1333'][2]
	Log    ${value}
	[Return]    ${value}
	wait for page to load
	capture page screenshot
	
verify that the marked value is 0
	wait until element is visible    xpath://div[@class='sfx_label_1333'][2]    300
	${value}=    Selenium2Library.get text    xpath://div[@class='sfx_label_1333'][2]
	Log    ${value}
	[Return]    ${value}
	should be equal    ${value}    0 marked
	wait for page to load
	capture page screenshot
	
	
Open Performance target
    Wait Until Element Is Visible     xpath: //div[@class='toggle'][1]    300
    Click element     xpath: //div[@class='toggle'][1]
	wait for page to load
	capture page screenshot

Click on the scroll down button performance targets
    [Arguments]     ${button}    ${n}
    @{element}=    Get WebElements	    xpath: (//div[@class='ScrollbarButton sf-element sf-element-scroll-bar-button sfpc-bottom'])[3]
    ${scroll_button}=        Get from list     ${element}    ${button}
    FOR    ${i}    IN RANGE    0    ${n} 
           Run Keyword and Ignore Error    Click element     ${scroll_button}           
    END
    wait for page to load
	capture page screenshot
	

Select downlink performance
    Wait Until Element Is Visible     xpath: //div[@class='sf-element-text-box'][1]
	Click element    xpath: //div[@class='sf-element-text-box'][1]
    Click element    xpath: //div[@class='sf-element-dropdown-list-item' and @title='0.10']	
	sleep   3s
	Click element    xpath: (//div[@class="ComboBoxTextDivContainer"])[2]
	Click element    xpath: (//div[@class='sf-element-dropdown-list-item' and @title='2.00'])	
	Sleep    5s
	Click element    xpath: (//div[@class="ComboBoxTextDivContainer"])[3]
	click on scroll up button    2    30
	Sleep    5s
	FOR    ${i}    IN RANGE    0     10
		${status}=     Run Keyword And Return Status        Element should be visible           xpath: //div[@class='sf-element-dropdown-list-item' and @title='10.00']
		IF   ${status} is ${TRUE}
			Exit For Loop
		ELSE
			Run keyword if      ${status}==False      Click on the scroll down button    2   3
			capture page screenshot
		END
	END
	Click element       xpath: //div[@class='sf-element-dropdown-list-item' and @title='10.00']
	
	capture page screenshot
	
	Click element    xpath: (//div[@class="ComboBoxTextDivContainer"])[4]
	click on scroll up button    2    30
	Sleep    5s
	FOR    ${i}    IN RANGE    0     10
		${status}=     Run Keyword And Return Status        Element should be visible          xpath: //div[@class='sf-element-dropdown-list-item' and @title='700.00']
		IF   ${status} is ${TRUE}
			Exit For Loop
		ELSE
			Run keyword if      ${status}==False      Click on the scroll down button    2   16
			capture page screenshot
		END
	END
	Sleep    15s
	Click element    xpath: //div[@class='sf-element-dropdown-list-item' and @title='700.00']
	capture page screenshot
	
	Click element    xpath: (//div[@class="ComboBoxTextDivContainer"])[5]
	click on scroll up button    2    30
	Sleep    5s
	FOR    ${i}    IN RANGE    0     10
		${status}=     Run Keyword And Return Status        Element should be visible          xpath: //div[@class='sf-element-dropdown-list-item' and @title='1500.00']
		IF   ${status} is ${TRUE}
			Exit For Loop
		ELSE
			Run keyword if      ${status}==False      Click on the scroll down button    2   16
			capture page screenshot
		END
	END
	Click element    xpath: //div[@class='sf-element-dropdown-list-item' and @title='1500.00']
	capture page screenshot
	
	

Select uplink performance
	Click element    xpath: (//div[@class="ComboBoxTextDivContainer"])[6]
	click on scroll up button    2    30
	Sleep    5s
	FOR    ${i}    IN RANGE    0     10
		${status}=     Run Keyword And Return Status        Element should be visible          xpath: //div[@class='sf-element-dropdown-list-item' and @title='0.07']
		IF   ${status} is ${TRUE}
			Exit For Loop
		ELSE
			Run keyword if      ${status}==False      Click on the scroll down button    2   3
			capture page screenshot
		END
	END
	Click element    xpath: //div[@class='sf-element-dropdown-list-item' and @title='0.07']
	capture page screenshot
	
	
	Click on the scroll down button    0   10
	Click element    xpath: (//div[@class="ComboBoxTextDivContainer"])[7]
	click on scroll up button    2    30
	Sleep    5s
	FOR    ${i}    IN RANGE    0     10
		${status}=     Run Keyword And Return Status        Element should be visible          xpath: //div[@class='sf-element-dropdown-list-item' and @title='1.00']
		IF   ${status} is ${TRUE}
			Exit For Loop
		ELSE
			Run keyword if      ${status}==False      Click on the scroll down button    2   3
			capture page screenshot
		END
	END
	Sleep    15s
	Click element    xpath: //div[@class='sf-element-dropdown-list-item' and @title='1.00']
	capture page screenshot
	
	
	Click element    xpath: (//div[@class="ComboBoxTextDivContainer"])[8]
	click on scroll up button    2    30
	Sleep    5s
	FOR    ${i}    IN RANGE    0     10
		${status}=     Run Keyword And Return Status        Element should be visible          xpath: //div[@class='sf-element-dropdown-list-item' and @title='50.00']
		IF   ${status} is ${TRUE}
			Exit For Loop
		ELSE
			Run keyword if      ${status}==False      Click on the scroll down button    2   16
			capture page screenshot
		END
	END
	Click element    xpath: //div[@class='sf-element-dropdown-list-item' and @title='50.00']
	capture page screenshot

	Click element    xpath: (//div[@class="ComboBoxTextDivContainer"])[9]
	click on scroll up button    2    30
	Sleep    5s
	FOR    ${i}    IN RANGE    0     10
		${status}=     Run Keyword And Return Status        Element should be visible          xpath: //div[@class='sf-element-dropdown-list-item' and @title='100.00']
		IF   ${status} is ${TRUE}
			Exit For Loop
		ELSE
			Run keyword if      ${status}==False      Click on the scroll down button    2   16
			capture page screenshot
		END
	END
	Click element    xpath: //div[@class='sf-element-dropdown-list-item' and @title='100.00']
	capture page screenshot
	
	Click element    xpath: (//div[@class="ComboBoxTextDivContainer"])[10]
	click on scroll up button    2    30
	Sleep    5s
	FOR    ${i}    IN RANGE    0     10
		${status}=     Run Keyword And Return Status        Element should be visible          xpath: //div[@class='sf-element-dropdown-list-item' and @title='150.00']
		IF   ${status} is ${TRUE}
			Exit For Loop
		ELSE
			Run keyword if      ${status}==False      Click on the scroll down button    2   16
			capture page screenshot
		END
	END
	Click element    xpath: //div[@class='sf-element-dropdown-list-item' and @title='150.00']
	capture page screenshot



	
Click on submit button
	Click on the scroll down button    0   30
    Wait Until Element Is Visible     xpath: //input[@value='Submit']    300
    Click element     xpath: //input[@value='Submit']
	wait for page to load
	capture page screenshot
	
wait for page to load
    sleep   2
    Wait Until Element Is Not Visible     class:sfx_progress-bar-container_1118        timeout=2400
    sleep   2   
    Wait Until Element Is Not Visible     class:sfx_progress-bar-container_1118        timeout=2400
    sleep   2
	
Go to home page if not already at home
	wait for page to load
	Wait Until Page Contains Element      xpath: ${sfx_page_title}     timeout=1500
	${pageTitle}=    Selenium2Library.Get text  xpath: ${sfx_page_title}
	Should Contain     ${pageTitle}       Home  	
	capture page screenshot
	
Go to home page if not already at home backup
	Wait Until Page Contains Element      xpath: ${sfx_page_title}     timeout=1500
	${pageTitle}=    Selenium2Library.Get text  xpath: ${sfx_page_title}
	#IF 		"${pageTitle}"== "Settings"	
		Click on the scroll down button    0    30
		Click element     xpath: //*[@title="Home"]
	ELSE IF    "${pageTitle}" != "Home"		
		Click element     xpath: //*[@title="Home"]
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


click on scroll up button
	[Arguments]  ${button}    ${n}
    @{element}=    Get WebElements	    xpath: //div[@class='ScrollbarButton sf-element sf-element-scroll-bar-button sfpc-top']
    ${scroll_button}=        Get from list     ${element}    ${button}
    FOR    ${i}    IN RANGE    0    ${n} 
           Run Keyword and Ignore Error          Click element     ${scroll_button}           
    END
	Sleep     2s
	capture page screenshot
	
	
scroll down untill element visible 
	[Arguments]    ${element_xpath}    ${button}    ${count}

	FOR    ${i}    IN RANGE    0     10
		${status}=     Run Keyword And Return Status        Element should be visible          xpath://*[contains(text(),'${element_xpath}')]
		IF   ${status} is ${TRUE}
			Exit For Loop
		ELSE
			Run keyword if      ${status}==False      Click on the scroll down button    ${button}   ${count}
		END
	END


mark on the "Worst Performing Cells (Ranked by Avg Failed User Sessions)" chart
	sleep	5s
	Selenium2Library.Drag And Drop By Offset		xpath:(//div[@class='sf-element sf-element-canvas-visualization'])[1]		${200}		${20}
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
	
get sql query from json file
    [Arguments]     ${json_file}     ${data}
    ${json}=    OperatingSystem.get file    ${json_file}
    &{object}=    Evaluate     json.loads('''${json}''')     json
    [return]       ${object}[${data}]
	
Query ENIQ database for Cell Failure Rate 
	[Arguments]       ${sql_query}    ${nodeVal}    ${cellVal}		${dateId}		
	Log		${Date_Val}
    ${sql_query}=     Replace String    ${sql_query}    ERBS_NODE     \'${nodeVal}\'
    ${sql_query}=     Replace String    ${sql_query}    CELL_NAME      \'${cellVal}\'
    ${sql_query}=     Replace String    ${sql_query}    DATEID      \'${Date_Val}\'
    log    ${sql_query}
    ${value}=     Query Sybase database     ${sql_query}
    log    ${value}
    ${string_value}=      Convert to string      ${value}[0]
    [return]     ${string_value}
	
	
Select from Uplink/Downlink dropdown 
	[Arguments]    ${value}
	sleep     5
	Click element    (//div[@class='sf-element-dropdown'])[1]
	Wait Until Element Is Visible     xpath: //*[@title='${value}']    300
    Click element     xpath: //*[@title='${value}']
	wait for page to load
	capture page screenshot
	
	
select the performance target
    [Arguments]    ${target}
    sleep    10
    click element    xpath:(//div[@class="ComboBoxTextDivContainer"])[2]
    sleep    4
	Wait Until Element Is Visible    xpath://div[@title="${target}"]
    click element    xpath://div[@title="${target}"]
    wait for page to load
    capture page screenshot
	
	
select the performance target for UL
    [Arguments]    ${target}
    sleep    10
    click element    xpath:(//div[@class="ComboBoxTextDivContainer"])[3]
    sleep    4
	Wait Until Element Is Visible    xpath://div[@title="${target}"]
    click element    xpath://div[@title="${target}"]
    wait for page to load
    capture page screenshot
	
get NR date value
	Wait Until Element Is Visible     xpath: (//div[@class='Handle sf-element sf-element-thumb TouchTarget'])[2]
	Wait Until Element Is Visible     xpath: (//div[@class='Handle sf-element sf-element-thumb TouchTarget'])[1]
	Selenium2Library.Drag And Drop    xpath: (//div[@class='Handle sf-element sf-element-thumb TouchTarget'])[2]    xpath: (//div[@class='Handle sf-element sf-element-thumb TouchTarget'])[1]
	Wait Until Element Is Visible     xpath: (//div[@class='sf-element-text-box ValueLabel'])[2]
	${text}=    Selenium2Library.Get text  xpath: (//div[@class='sf-element-text-box ValueLabel'])[2]
	${text}=    Convert Date    ${text}    result_format=%Y-%m-%d   date_format=%m/%d/%Y 
	[Return]    ${text}     
	capture page screenshot
	
	
Replace the Date value
    [Arguments]    ${query}    ${DateValue}   
	${sql}=    catenate    DECLARE @date DATETIME SET @date=DATE_TIME   ${query}
	Log    ${sql}
	${sql}=    Replace String    ${sql}    DATE_TIME      \'${DateValue}\'
	Log    ${sql}
	[Return]    ${sql}
	
	
Format DB Value of Cell Failure Rate
	[Arguments]       ${DB_Value}
	Log    ${DB_Value}
	${dbValue1}=    convert to string    ${dbValue}
	Log    ${dbValue1}
	[Return]	${dbValue1}
	
	
Verify UI value is matching with DB value
    [Arguments]       ${UI}     ${DB}
	Log    ${UI}
    Log    ${DB}
	${dbVal}=    convert to string    ${DB}
    Should Contain    ${DB}    ${UI}
	
	
Compare UI and DB values
	[Arguments]       ${UI}     ${DB}
    Log    ${UI}
    Log    ${DB}
	${dbValue1}=    convert to string    ${DB}
	${dbValue1}=    split string    ${dbValue1}    '
	${dbValue2}=    get from list    ${dbValue1}    1
	${DB_Value_num}=      Convert To Number	     ${dbValue2}       0
	Log       ${DB_Value_num}
	${UI_Value_num}=      Convert To Number	     ${UI}       0
	Log       ${UI_Value_num}
	${diff}=    Evaluate   ${UI_Value_num}-${DB_Value_num}
	Run keyword if      ${diff}>1 or ${diff}<-1      FAIL
	
Compare UI and DB values in avg
	[Arguments]       ${UI}     ${DB}
    Log    ${UI}
    Log    ${DB}
	${dbValue1}=    Split String from Right    ${DB}    '    2
	${dbValue1}=    get from list    ${dbValue1}    1
	${dbValue1}=    convert to string    ${dbValue1}    
	${DB_Value_num}=      Convert To Number	     ${dbValue1}       0
	Log       ${DB_Value_num}
	${UI_Value_num}=      Convert To Number	     ${UI}       0
	Log       ${UI_Value_num}
	${diff}=    Evaluate   ${UI_Value_num}-${DB_Value_num}
	Run keyword if      ${diff}>1 or ${diff}<-1      FAIL


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
	[Return]	${cellFailureVal}
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
	
	
	
	
Mark on the Histroical Trend for Selected Cell chart
	sleep	5s
	Selenium2Library.Drag And Drop By Offset		xpath:(//div[@class='sf-element sf-element-canvas-visualization'])[1]		${200}		${20}
	wait for page to load
	capture page screenshot
	

record the tooltip values for Selected cells
	Wait Until Element Is Visible    xpath:(//div[@class='sf-element-canvas-image'])[1]    30
	Mouse Over 		xpath:(//div[@class='sf-element-canvas-image'])[1]
	Wait Until Element Is Visible    xpath: //*[@class="sf-tooltip sf-plot-tooltip RoundedDropShadow"]    30    
	${toolTip}=    Selenium2Library.Get Text    xpath: //*[@class="sf-tooltip sf-plot-tooltip RoundedDropShadow"]
	Log    ${toolTip}
	${actualUiValue}=    Split String from Right    ${toolTip}
	${cellFailureVal}=	Get From List    ${actualUiValue}    2
	${words}=	Split String from Right		${toolTip}	:	1	
	${avgFailedSessions}=	Get From List    ${words}    1
	Log    ${cellFailureVal}
	Log    ${actualUiValue}
	Log	    ${cellFailureVal}
	Log	   ${avgFailedSessions}
	[Return]	${cellFailureVal}    ${avgFailedSessions}    
	wait for page to load
	capture page screenshot
	
	
	
record the tooltip values for Selected cells for failure rate
	Wait Until Element Is Visible    xpath:(//div[@class='sf-element-canvas-image'])[1]    30
	Mouse Over 		xpath:(//div[@class='sf-element-canvas-image'])[1]
	Wait Until Element Is Visible    xpath: //*[@class="sf-tooltip sf-plot-tooltip RoundedDropShadow"]    30    
	${toolTip}=    Selenium2Library.Get Text    xpath: //*[@class="sf-tooltip sf-plot-tooltip RoundedDropShadow"]
	Log    ${toolTip}
	${actualUiValue}=    Split String from Right    ${toolTip}
	${cellFailureVal}=	Get From List    ${actualUiValue}    2
	${words}=	Split String from Right		${toolTip}	:	1	
	${avgFailedSessions}=	Get From List    ${words}    1
	Log    ${cellFailureVal}
	Log    ${actualUiValue}
	Log	    ${cellFailureVal}
	Log	   ${avgFailedSessions}
	[Return]	${cellFailureVal}    
	wait for page to load
	capture page screenshot	
	
record the tooltip values for Parent nodes
	Wait Until Element Is Visible    xpath:(//div[@class='sf-element-canvas-image'])[2]    30
	Mouse Over 		xpath:(//div[@class='sf-element-canvas-image'])[2]
	Wait Until Element Is Visible    xpath: //*[@class="sf-tooltip sf-plot-tooltip RoundedDropShadow"]    30    
	${toolTip}=    Selenium2Library.Get Text    xpath: //*[@class="sf-tooltip sf-plot-tooltip RoundedDropShadow"]
	Log    ${toolTip}
	${actualUiValue}=    Split String from Right    ${toolTip}
	${cellFailureVal}=	Get From List    ${actualUiValue}    2
	Log    ${cellFailureVal}
	Log    ${actualUiValue}
	Log	    ${cellFailureVal}
	[Return]	${cellFailureVal}    
	wait for page to load
	capture page screenshot


record the tooltip values for Selected cells for avg
	Wait Until Element Is Visible    xpath:(//div[@class='sf-element-canvas-image'])[1]    30
	Mouse Over 		xpath:(//div[@class='sf-element-canvas-image'])[1]
	Wait Until Element Is Visible    xpath: //*[@class="sf-tooltip sf-plot-tooltip RoundedDropShadow"]    30    
	${toolTip}=    Selenium2Library.Get Text    xpath: //*[@class="sf-tooltip sf-plot-tooltip RoundedDropShadow"]
	Log    ${toolTip}
	${actualUiValue}=    Split String from Right    ${toolTip}
	${cellFailureVal}=	Get From List    ${actualUiValue}    2
	
	Log    ${cellFailureVal}
	Log    ${actualUiValue}
	Log	    ${cellFailureVal}
	[Return]	${cellFailureVal}    
	wait for page to load
	capture page screenshot




verify DL and UL charts are visible
	sleep    10
	element should contain    xpath://div[@class="flex-item flex-container-horizontal flex-justify-start flex-align-center"]    DL Throughput
	element should contain    xpath:/html/body/div/div[2]/div/div[1]/div/div/div[2]/div/div/div[2]/div/div/div/div/div/div[4]/div[2]/div[2]    UL Throughput
	wait for page to load
	capture page screenshot
	
	
verify that the Performance Target dropdowns are visible
	element should be visible    xpath://div[@class="ComboBoxTextDivContainer"]
	element should be visible    xpath://div[@class="ComboBoxTextDivContainer"][1]
	wait for page to load
	capture page screenshot
	
	
mark on the network overiew DL chart
	sleep	5s
	Selenium2Library.Drag And Drop By Offset		xpath:(//div[@class='sf-element sf-element-canvas-visualization'])[1]		${200}		${20}
	wait for page to load
	capture page screenshot 
	




place cursor and record its tooltip values for Network Overview    
	Sleep    5s
	Mouse Over 		xpath:(//div[@class='sf-element sf-element-visual-content sfc-bar-chart sfc-trellis-visualization'])[1]
	sleep	5s
	${toolTip}=    Selenium2Library.Get Text    xpath: //*[@class="sf-tooltip sf-plot-tooltip RoundedDropShadow"]
	Log    ${toolTip}
	${actualUiValue}=    Split String from Right    ${toolTip}
	${TargetPerformance}=	Get From List    ${actualUiValue}    7
	Log    ${TargetPerformance}
	Log    ${actualUiValue}
	[Return]	${TargetPerformance}
	wait for page to load
	capture page screenshot
	
place cursor and record its tooltip values for Network Overview2
	Sleep    5s
	Mouse Over 		xpath:(//div[@class='sf-element sf-element-visual-content sfc-bar-chart sfc-trellis-visualization'])[2]
	sleep	5s
	${toolTip}=    Selenium2Library.Get Text    xpath: //*[@class="sf-tooltip sf-plot-tooltip RoundedDropShadow"]
	Log    ${toolTip}
	${actualUiValue}=    Split String from Right    ${toolTip}
	${TargetPerformance}=	Get From List    ${actualUiValue}    7
	Log    ${TargetPerformance}
	Log    ${actualUiValue}
	[Return]	${TargetPerformance}
	wait for page to load
	capture page screenshot

	
	


validate rate target value with failure rate
    [Arguments]    ${DB_VALUE}
	
	${DB_VAL}=    Split String from Right    ${DB_VALUE}    '    2
	${DB_VAL}=    get from list    ${DB_VAL}    1
	${DB_VAL}=    convert to string    ${DB_VAL}    
	${DB_Value_num}=      Convert To Number	     ${DB_VAL}       0
	Log       ${DB_Value_num}

	${Target}=    place cursor and record its tooltip values for Network Overview
	
	IF    ${DB_Value_num}<0.25
	
	   should contain    ${Target}    Successful
	   
	END
	   
	IF    ${DB_Value_num}>=0.25
	 
	   should contain    ${Target}    Unsuccessful
	   
	END
	   
	

select the performance target in Network overview(DL)
    [Arguments]    ${target}
    sleep    10
    click element    xpath:(//div[@class="ComboBoxTextDivContainer"])[1]
    sleep    4
	Wait Until Element Is Visible    xpath://div[@title="${target}"]
    click element    xpath://div[@title="${target}"]
    wait for page to load
    capture page screenshot	
	
	
	
	
select the performance target in Network overview(UL)
    [Arguments]    ${target}
    sleep    10
    click element    xpath:(//div[@class="ComboBoxTextDivContainer"])[2]
    sleep    4
	Wait Until Element Is Visible    xpath://div[@title="${target}"]
    click element    xpath://div[@title="${target}"]
    wait for page to load
    capture page screenshot	


mark on the network overiew UL chart
	sleep	5s
	wait for page to load
	Selenium2Library.Drag And Drop By Offset		xpath:(//div[@class='sf-element sf-element-canvas-visualization'])[2]		${200}		${20}
	wait for page to load
	capture page screenshot
	
	
	
Slide the Sucess Target
    [Arguments]     ${button}    ${n}
    @{element}=    Get WebElements	    xpath: //div[@class="Button RightEnabled sf-element sf-element-button"]
    ${scroll_button}=        Get from list     ${element}    ${button}
    FOR    ${i}    IN RANGE    0    ${n} 
           Run Keyword and Ignore Error    Click element     ${scroll_button}           
    END
    wait for page to load
	capture page screenshot
	
	
	
Reset sucess target slider
#	@{element}=    Get WebElements	    xpath: //div[@class="Button LeftEnabled sf-element sf-element-button"]
#   ${scroll_button}=        Get from list     ${element}    0
    FOR    ${i}    IN RANGE    0    50 
		   sleep    1
           Run Keyword and Ignore Error    Click element      xpath: //div[@class="Button LeftEnabled sf-element sf-element-button"]           
    END
    wait for page to load
	capture page screenshot
	
	
	
Reset sucess target slider to the last 
    FOR    ${i}    IN RANGE    0    50 
		   sleep    1
           Run Keyword and Ignore Error    Click element      xpath: (//div[@class="Button RightEnabled sf-element sf-element-button"])           
    END
    wait for page to load
	capture page screenshot
	
validate rate target value with failure rate for UL 
    [Arguments]    ${DB_VALUE}
	
	${DB_VAL}=    Split String from Right    ${DB_VALUE}    '    2
	${DB_VAL}=    get from list    ${DB_VAL}    1
	${DB_VAL}=    convert to string    ${DB_VAL}    
	${DB_Value_num}=      Convert To Number	     ${DB_VAL}       0
	Log       ${DB_Value_num}

	${Target}=    place cursor and record its tooltip values for Network Overview2
	
	IF    ${DB_Value_num}<0.15
	
	   should contain    ${Target}    Successful
	   
	END
	   
	IF    ${DB_Value_num}>=0.15
	 
	   should contain    ${Target}    Unsuccessful
	   
	END

mark on the Historic Trend in Network Overview for DL chart
	sleep	5s
	Selenium2Library.Drag And Drop By Offset		xpath:(//div[@class='sf-element sf-element-canvas-visualization'])[2]		${200}		${20}
	wait for page to load
	capture page screenshot
	
	
mark on the Historic Trend in Network Overview for UL chart
	sleep	5s
	Selenium2Library.Drag And Drop By Offset		xpath:(//div[@class='sf-element sf-element-canvas-visualization'])[1]		${200}		${20}
	wait for page to load
	capture page screenshot
	
	
validate rate target value with failure rate for Historic Trend for DL
    [Arguments]    ${DB_VALUE}
	
	${DB_VAL}=    Split String from Right    ${DB_VALUE}    '    2
	${DB_VAL}=    get from list    ${DB_VAL}    1
	${DB_VAL}=    convert to string    ${DB_VAL}    
	${DB_Value_num}=      Convert To Number	     ${DB_VAL}       0
	Log       ${DB_Value_num}

	${Target}=    place cursor and record its tooltip values for Network Overview for Historical Trend 
	
	IF    ${DB_Value_num}<0.1
	
	   should contain    ${Target}    Successful
	   
	END
	   
	IF    ${DB_Value_num}>=0.1
	 
	   should contain    ${Target}    Unsuccessful
	   
	END
	
	
validate rate target value with failure rate for Historic Trend for UL
    [Arguments]    ${DB_VALUE}
	
	${DB_VAL}=    Split String from Right    ${DB_VALUE}    '    2
	${DB_VAL}=    get from list    ${DB_VAL}    1
	${DB_VAL}=    convert to string    ${DB_VAL}    
	Log       ${DB_VAL}

	${Target}=    place cursor and record its tooltip values for Network Overview for Historical Trend 
	
	IF    ${DB_VAL}<0.05
	
	   should contain    ${Target}    Successful
	   
	END
	   
	IF    ${DB_VAL}>=0.05
	 
	   should contain    ${Target}    Unsuccessful
	   
	END
	
	
Validate the Map chart is visible or not
	sleep	5s
	Selenium2Library.Drag And Drop By Offset		xpath: (//img[@class='tibco-tile tibco-tile-loaded'])[1]		${200}		${20} 
	wait for page to load
	capture page screenshot
	
	
Check for the error notification is not present
	Click Element      xpath://*[@title="Notifications"]
	Sleep    3s
	${notification}=    Selenium2Library.Get Text    xpath: //div[@class='${notification_container}']
	Should contain          ${notification}         There are currently no notifications
	Click Element      xpath://*[@title="Notifications"]
	capture page screenshot
	
	
Select NR name
    [Arguments]    ${NR_list}
    #Click on scroll down button     6    5
    @{list}=      Split string      ${NR_list}    ,
     FOR    ${node}    IN    @{list}
		   wait until element is visible    xpath: (//input[contains(@class,'SearchInput sf-element-input sf-suppress-forms-accept-command sf-suppress-forms-cancel-command sf-input-with-placeholder')])[1]    30
           Selenium2Library.Clear Element Text      xpath: (//input[contains(@class,'SearchInput sf-element-input sf-suppress-forms-accept-command sf-suppress-forms-cancel-command sf-input-with-placeholder')])[1]
           wait until element is visible    xpath: (//input[contains(@class,'SearchInput sf-element-input sf-suppress-forms-accept-command sf-suppress-forms-cancel-command sf-input-with-placeholder')])[1]    30
		   Run keyword and ignore error       (//input[contains(@class,'SearchInput sf-element-input sf-suppress-forms-accept-command sf-suppress-forms-cancel-command sf-input-with-placeholder')])[1]
		   Sleep     5s
		   Selenium2Library.Input Text     xpath: (//input[contains(@class,'SearchInput sf-element-input sf-suppress-forms-accept-command sf-suppress-forms-cancel-command sf-input-with-placeholder')])[1]     ${node} 
           #Click on scroll down button     6    1
		   sleep    2s
           wait for page to load 
		   wait until element is visible    xpath: //div[@title='${node}' and contains(@class,'sf-element-list-box-item')]    60    
           Click element      xpath: //div[@title='${node}' and contains(@class,'sf-element-list-box-item')]      modifier=CTRL
           sleep   1s
           wait for page to load
           Capture page screenshot
     END
	 
	 
Validate Map Chart switch to table
	change the mode to     Editing
	Sleep    3s
	Selenium2Library.Drag And Drop By Offset		xpath: (//img[@class='tibco-tile tibco-tile-loaded'])[1]		${200}		${20}
	wait for page to load
    #Wait Until Element Is Visible    xpath: (//img[@class='tibco-tile tibco-tile-loaded'])[1]    30
	open context menu    xpath: (//img[@class='tibco-tile tibco-tile-loaded'])[1]   
	Wait Until Element Is Visible   xpath: (//div[@title='Switch visualization to'])    30
	Click Element    xpath: (//div[@title='Switch visualization to'])
	Wait Until Element Is Visible    xpath: //div[@title='Table']
	Click element   //div[@title='Table'] 
	capture page screenshot
	#Wait Until Element Is Visible    xpath: (//div[@class="contextMenuItem menuActive"])//*[contains(text(),'Table')]
	#Click Element    xpath: (//div[@class="contextMenuItem menuActive"])//*[contains(text(),'Table')] 
	
	
change the mode to
	[Arguments]    ${mode}
	Wait Until Page Contains Element      xpath: //div[@class='sfx_author-dropdown_1174']     timeout=300
	Click element       xpath: //div[@class='sfx_author-dropdown_1174']
	Wait Until Page Contains Element      xpath://div[@title='${mode}']     timeout=300
	Click Element      xpath://div[@title='${mode}']
    Run keyword IF    "${mode}"=="Editing"        Wait Until Element Is Visible      xpath://div[@title='Data in analysis']       timeout=1500
	wait for page to load
	capture page screenshot
	

Validate table value	
	Wait Until Element Is Visible    xpath: //div[@name='valueCellCanvas']//div[@row='1' and @column='0']
	Click Element      xpath: //div[@name='valueCellCanvas']//div[@row='1' and @column='0']
	capture page screenshot
	
	
record the tooltip values for Cell site page
	Wait Until Element Is Visible    xpath:(//div[@class='sf-element-canvas-image'])[1]    30
	Mouse Over 		xpath:(//div[@class='sf-element-canvas-image'])[1]
	Wait Until Element Is Visible    xpath: //*[@class="sf-tooltip sf-plot-tooltip RoundedDropShadow"]    30    
	${toolTip}=    Selenium2Library.Get Text    xpath: //*[@class="sf-tooltip sf-plot-tooltip RoundedDropShadow"]
	Log    ${toolTip}
	${actualUiValue}=    Split String from Right    ${toolTip}
	${cellFailureVal}=	Get From List    ${actualUiValue}    2
	${words}=	Split String from Right		${toolTip}	:	1	
	${avgFailedSessions}=	Get From List    ${words}    1
	Log    ${cellFailureVal}
	Log    ${actualUiValue}
	Log	    ${cellFailureVal}
	Log	   ${avgFailedSessions}
	[Return]	${cellFailureVal}    ${avgFailedSessions}    
	wait for page to load
	capture page screenshot
	
	
select the performance target network view UL
    [Arguments]    ${target}
    sleep    10
    click element    xpath: (//div[@class='ComboBoxTextDivContainer'])[3]
    sleep    4
	Wait Until Element Is Visible    xpath://div[@title="${target}"]
    click element    xpath://div[@title="${target}"]
    wait for page to load
    capture page screenshot
	
	
	
open Library file  
    ${chrome_options}=    Evaluate    sys.modules['selenium.webdriver'].ChromeOptions()      sys
	#Call Method    ${chrome_options}    add_argument    --incognito
	Call Method    ${chrome_options}    add_argument    --ignore-certificate-errors
	Create Webdriver    Chrome    options=${chrome_options}
    Go To    ${base_url}   
    Maximize Browser Window
    Sleep    5
    Selenium2Library.Input Text    xpath:${username_xpath}     Administrator
    Selenium2Library.Input Text    xpath:${password_xpath}    Ericsson01
    Click Element    xpath:${loginButton_xpath}  
    Sleep    5
	Click Element     xpath: //div[@class='bg-tibco-app-bg-library flex h-20 hover:shadow-tibco-shadow-4 items-center justify-center rounded-lg shadow-tibco-shadow-1 text-5xl text-tibco-app-icon-library transition w-20']
	Wait Until Element Is Visible    xpath: //div[@class='px-4 row cursor-default group tss-row-even cursor-pointer']    30
	Double click element    xpath: //div[@class='px-4 row cursor-default group tss-row-even cursor-pointer']	
	Wait Until Element Is Visible    xpath: (//div[@class='px-4 row cursor-default group cursor-pointer'])[1]    10
	Double click element    xpath: (//div[@class='px-4 row cursor-default group cursor-pointer'])[1]
	Wait Until Element Is Visible    xpath: //div[@class='px-4 row cursor-default group cursor-pointer']    10
	Double click element    xpath: //div[@class='px-4 row cursor-default group cursor-pointer']
	capture page screenshot
	
Copy analysis and Information package files for 4115
	Wait Until Element Is Visible    xpath: (//input[@class='ng-star-inserted'])[2]    10
	Click Element    xpath: (//input[@class='ng-star-inserted'])[2]
	Wait Until Element Is Visible    xpath: (//input[@class='ng-star-inserted'])[3]    10
	Click Element    xpath: (//input[@class='ng-star-inserted'])[3]
	Wait Until Element Is Visible    xpath: (//button[@class='tss-text-button'])[2]    10
	Click Element    xpath: (//button[@class='tss-text-button'])[2]
	Wait Until Element Is Visible    xpath: //div[@class='px-4 row cursor-default group cursor-pointer']
	Double click element    xpath: //div[@class='px-4 row cursor-default group cursor-pointer']
	Wait Until Element Is Visible    xpath: //div[@class='px-4 row cursor-default group tss-row-even cursor-pointer']
	Double click element    xpath: //div[@class='px-4 row cursor-default group tss-row-even cursor-pointer']
	Wait Until Element Is Visible    xpath: //button[@class='cursor-pointer font-semibold rounded-full h-8 px-4 border text-white hover:text-tibco-blue-P2 hover:bg-white border-white active:text-tibco-blue-P4 active:border-tibco-blue-P4']
	Click Element    xpath: //button[@class='cursor-pointer font-semibold rounded-full h-8 px-4 border text-white hover:text-tibco-blue-P2 hover:bg-white border-white active:text-tibco-blue-P4 active:border-tibco-blue-P4']
    capture page screenshot
	

Copy analysis and Information package files for 4070
	Wait Until Element Is Visible    xpath: (//input[@class='ng-star-inserted'])[2]    10
	Click Element    xpath: (//input[@class='ng-star-inserted'])[2]
	Wait Until Element Is Visible    xpath: (//input[@class='ng-star-inserted'])[3]    10
	Click Element    xpath: (//input[@class='ng-star-inserted'])[3]
	Wait Until Element Is Visible    xpath: (//button[@class='tss-text-button'])[2]    10
	Click Element    xpath: (//button[@class='tss-text-button'])[2]
	Wait Until Element Is Visible    xpath: //div[@class='px-4 row cursor-default group cursor-pointer']
	Double click element    xpath: //div[@class='px-4 row cursor-default group cursor-pointer']
	Wait Until Element Is Visible    xpath: //div[@class='px-4 row cursor-default group cursor-pointer']
	Double click element    xpath: //div[@class='px-4 row cursor-default group cursor-pointer']
	Wait Until Element Is Visible    xpath: //button[@class='cursor-pointer font-semibold rounded-full h-8 px-4 border text-white hover:text-tibco-blue-P2 hover:bg-white border-white active:text-tibco-blue-P4 active:border-tibco-blue-P4']
	Click Element    xpath: //button[@class='cursor-pointer font-semibold rounded-full h-8 px-4 border text-white hover:text-tibco-blue-P2 hover:bg-white border-white active:text-tibco-blue-P4 active:border-tibco-blue-P4']
    capture page screenshot

Open primary data source Analysis
    ${chrome_options}=    Evaluate    sys.modules['selenium.webdriver'].ChromeOptions()      sys
	#Call Method    ${chrome_options}    add_argument    --incognito
	Call Method    ${chrome_options}    add_argument    --ignore-certificate-errors
	Create Webdriver    Chrome    options=${chrome_options}
    Go To    ${base_url}   
    Maximize Browser Window
    Sleep    5
    Selenium2Library.Input Text    xpath:${username_xpath}     Administrator
    Selenium2Library.Input Text    xpath:${password_xpath}    Ericsson01
    Click Element    xpath:${loginButton_xpath}  
    Sleep    5
	Go To    ${base_url}${4070_nr_app_coverage}
	wait until element is visible    xpath :(//div[@class="ScrollbarButton sf-element sf-element-scroll-bar-button sfpc-top"])    120
	
	
Open MSA Configuration 
    Wait Until Element Is Visible     xpath: (//div[@class='toggle'])[2]    300
    Click element     xpath: (//div[@class='toggle'])[2]
	wait for page to load
	capture page screenshot
	
	
Enter secondary data source
	[Arguments]    ${num}
	#Click on scroll down button     3    15
	Clear Element Text      xpath: (//input[@class='sf-element sf-element-control sfc-property sfc-text-box'])[2]
	Selenium2Library.Input Text     xpath: (//input[@class='sf-element sf-element-control sfc-property sfc-text-box'])[2]    ${num}
    press key      xpath: (//input[@class='sf-element sf-element-control sfc-property sfc-text-box'])[2]     \\13
	Sleep     3s
	capture page screenshot
	
Enter name of data source
	[Arguments]    ${name}
	#Click on scroll down button     3    15
	Clear Element Text      xpath: //textarea[@class='sf-element sf-element-control sfc-property sfc-text-box']
	Selenium2Library.Input Text     xpath: //textarea[@class='sf-element sf-element-control sfc-property sfc-text-box']    ${name}
    Selenium2Library.press key      xpath: //textarea[@class='sf-element sf-element-control sfc-property sfc-text-box']     \\13
	Sleep     3s
	capture page screenshot	
	

Click on Configure MSA button
	Click on the scroll down button    0   30
    Wait Until Element Is Visible     xpath: //input[@id='501a51eea1aa48ebaa7b348b135d2e04']    300
    Click element     xpath: //input[@id='501a51eea1aa48ebaa7b348b135d2e04']
	wait for page to load
	capture page screenshot
	
	
	
replace the datasource in FeatureInstaller
	[Arguments]    ${fileLocation}    ${dsOriginal}    ${dsNew}
	${fileContents}=    Get File    ${fileLocation}
	Log    ${fileContents}
	Remove file    ${fileLocation}
	${fileContents}=    Replace String    ${fileContents}    ${dsOriginal}    ${dsNew}
	Append to File    ${fileLocation}    ${fileContents}
	
install feature
    [Arguments]    ${feature}
	${fileContents}=    Get File    ${EXEC_DIR}\\ENIQ_TC_Automation\\NetAn\\Other\\Files\\FeatureInstall.ps1
	Log    ${fileContents}
	Remove file    ${EXEC_DIR}\\ENIQ_TC_Automation\\NetAn\\Other\\Files\\FeatureInstall.ps1
    ${fileContents}=    Replace String    ${fileContents}    featureName    ${feature}
	Append to File    ${EXEC_DIR}\\ENIQ_TC_Automation\\NetAn\\Other\\Files\\FeatureInstall.ps1    ${fileContents}
    ${ps_file}    Set Variable    ${EXEC_DIR}\\ENIQ_TC_Automation\\NetAn\\Other\\Files\\FeatureInstall.ps1
    ${result}=    Run Process    Powershell.exe    ${ps_file}
	Log    ${result.stdout}
	[Return]    ${feature}
	
replace the featureName in FeatureInstall file
	[Arguments]    ${feature}
	${fileContents}=    Get File    ${EXEC_DIR}\\ENIQ_TC_Automation\\NetAn\\Other\\Files\\FeatureInstall.ps1
	Log    ${fileContents}
	Remove file    ${EXEC_DIR}\\ENIQ_TC_Automation\\NetAn\\Other\\Files\\FeatureInstall.ps1
    ${fileContents}=    Replace String    ${fileContents}    ${feature}    featureName
	Append to File    ${EXEC_DIR}\\ENIQ_TC_Automation\\NetAn\\Other\\Files\\FeatureInstall.ps1    ${fileContents}
	
	
Validate MSA message
    wait until element is visible    xpath: //*[contains(text(),"MSA Configuration done for data sources: ['atvts4115']")]     300
	capture page screenshot
	
	
	
	
Switch from line chart to bar chart
	change the mode to     Editing
	Sleep    3s
	Selenium2Library.Drag And Drop By Offset		xpath: (//div[@class='sf-element-canvas-image'])[2]		${200}		${20}
	wait for page to load
    #Wait Until Element Is Visible    xpath: (//div[@class='sf-element-canvas-image'])[2]    30
	open context menu    xpath: (//div[@class='sfpc-left sf-element-interaction-access-area'])[2]   
	Wait Until Element Is Visible   xpath: (//div[@title='Switch visualization to'])    30
	Click Element    xpath: (//div[@title='Switch visualization to'])
	Wait Until Element Is Visible    xpath: //div[@title='Bar chart']
	Click element   //div[@title='Bar chart'] 
	capture page screenshot
	#Wait Until Element Is Visible    xpath: (//div[@class="contextMenuItem menuActive"])//*[contains(text(),'Bar chart')]
	#Click Element    xpath: (//div[@class="contextMenuItem menuActive"])//*[contains(text(),'Bar chart')] 
	
	
	
place cursor and record its tooltip values for Network Overview for Historical Trend 
	Sleep    5s
	Mouse Over 		xpath:(//div[@class='sf-element sf-element-visual-content sfc-bar-chart sfc-trellis-visualization'])[1]
	sleep	5s
	${toolTip}=    Selenium2Library.Get Text    xpath: //*[@class="sf-tooltip sf-plot-tooltip RoundedDropShadow"]
	Log    ${toolTip}
	${actualUiValue}=    Split String from Right    ${toolTip}
	${TargetPerformance}=	Get From List    ${actualUiValue}    12
	Log    ${TargetPerformance}
	Log    ${actualUiValue}
	[Return]	${TargetPerformance}
	wait for page to load
	capture page screenshot
	
	
	
Navigating to Home
	Wait Until Page Contains Element      xpath: ${sfx_page_title}     timeout=1500
	${pageTitle}=    Selenium2Library.Get text  xpath: ${sfx_page_title}
	IF 		"${pageTitle}"== "Settings"	
		Click on the scroll down button    0    30
		Click element     xpath: //*[@title="Home"]
	END