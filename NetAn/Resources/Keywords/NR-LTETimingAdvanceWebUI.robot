*** Keywords ***

open NR and LTE Timing Advance analysis
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
    Go To    ${base_url}${nr-lte_timing_advance_url}
    wait for page to load
    capture page screenshot
    
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
	
Go to home page if not already at home
	${pageTitle}=    Selenium2Library.Get text  xpath: //*[@class="sfx_page-title_219"]
	IF 		"${pageTitle}" != "GSM Optimisation Reports"	
		Click element     xpath: //*[@title="Home"]
	END
	wait for page to load
	capture page screenshot
	
Suite setup steps    
    Set Screenshot Directory   ./Screenshots

Suite teardown steps
    Capture page screenshot
    
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
	
verify that the chart is visible
	[Arguments]    ${chart}
	element should be visible    xpath://*[@title="${chart}"]
	wait for page to load
	capture page screenshot
	
Select the Nodes
    [Arguments]    ${node_list}
    @{list}=      Split string      ${node_list}    ,
     FOR    ${node}    IN    @{list}
           Clear Element Text      xpath://input[contains(@class,'SearchInput sf-element-input sf-suppress-forms-accept-command sf-suppress-forms-cancel-command sf-input-with-placeholder')]
           sleep    1
           Selenium2Library.Input Text     xpath://input[contains(@class,'SearchInput sf-element-input sf-suppress-forms-accept-command sf-suppress-forms-cancel-command sf-input-with-placeholder')]     ${node} 
           sleep    2
           press key      xpath://input[contains(@class,'SearchInput sf-element-input sf-suppress-forms-accept-command sf-suppress-forms-cancel-command sf-input-with-placeholder')]     \\13
           sleep    2s
           wait for page to load
           Click element      xpath://div[@title='${node}']      modifier=CTRL
           sleep   1s
     END	
	wait for page to load
	capture page screenshot
	
select the subnetwork
	[Arguments]    ${subnetwork}
	Clear Element Text      xpath:(//input[@class="SearchInput sf-element-input sf-suppress-forms-accept-command sf-suppress-forms-cancel-command sf-input-with-placeholder"])[1]
    sleep    1
    Selenium2Library.Input Text     xpath:(//input[@class="SearchInput sf-element-input sf-suppress-forms-accept-command sf-suppress-forms-cancel-command sf-input-with-placeholder"])[1]     ${subnetwork} 
    sleep    1
    press key     xpath:(//input[@class="SearchInput sf-element-input sf-suppress-forms-accept-command sf-suppress-forms-cancel-command sf-input-with-placeholder"])[1]     \\13
    sleep    2s
    wait for page to load
    Click element      xpath://div[@title='${subnetwork}']    modifier=CTRL
    sleep   1s
    wait for page to load
	capture page screenshot

select LTE node
	[Arguments]    ${node}
	click element    xpath:(//*[contains(text(),'${node}')])[2]
	wait for page to load
	capture page screenshot	
	
verify that the rows are not 0
	sleep    20
	${verification}=    Selenium2Library.get text    xpath:(//div[@class="sfx_label_223"])[1]
	Log    ${verification}
	[Return]    ${verification}
	should not be equal    ${verification}    0 rows
	wait for page to load
	capture page screenshot