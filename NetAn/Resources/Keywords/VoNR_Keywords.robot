*** Keywords ***

open vo-nr analysis
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
    Go To    ${base_url}${vo_nr_url}
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