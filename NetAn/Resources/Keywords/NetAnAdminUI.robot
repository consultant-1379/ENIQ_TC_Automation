*** Keywords ***

open the adminui page
	${chrome_options}=    Evaluate    sys.modules['selenium.webdriver'].ChromeOptions()      sys
	Call Method    ${chrome_options}    add_argument    --ignore-certificate-errors
	Selenium2library.Create Webdriver    Chrome    executable_path=${EXEC_DIR}/ENIQ_TC_Automation/NetAn/Resources/Drivers/chromedriver.exe      chrome_options=${chrome_options}
    Go To    ${adminui}  
    Maximize Browser Window
    Sleep    3
    Selenium2Library.Input Text    name:userName    eniq	
    Selenium2Library.Input Text    name:userPassword    Eniq@1234
    Click Element    name:submit
    ${IsElementVisible}=    Run Keyword And Return Status     alert should be present    Alert Text: Engine is set to NoLoads
    Run Keyword If    ${IsElementVisible}    handle alert    accept
    capture page screenshot
    
wait for page to load
    sleep   2
    Wait Until Element Is Not Visible     class:sfx_progress-bar-container_1118        timeout=2400
    sleep   2   
    Wait Until Element Is Not Visible     class:sfx_progress-bar-container_1118        timeout=2400
    sleep   2
    
Click on the scroll down button
    [Arguments]     ${button}    ${n}
    @{element}=    Get WebElements	    xpath: //div[@class="ScrollbarButton sf-element sf-element-scroll-bar-button sfpc-bottom"]
    ${scroll_button}=        Get from list     ${element}    ${button}
    FOR    ${i}    IN RANGE    0    ${n} 
           Click element     ${scroll_button}           
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
    Selenium2library.Set Screenshot Directory   ./Screenshots

Suite teardown steps
    Capture page screenshot

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

select the package
	[Arguments]    ${package}
	Wait Until Element Is Visible     xpath:(//select[@name="selectedpack"])    30
	Click Element       xpath:(//select[@name="selectedpack"])
	sleep    2
	Wait Until Element Is Visible     xpath://*[contains(text(),'${package}')]    30
	Click Element       xpath://*[contains(text(),'${package}')]
	wait for page to load
	capture page screenshot

select the type
	[Arguments]    ${type}
	Wait Until Element Is Visible     xpath:(//select[@name="selectedsettype"])    30
	Click Element       xpath:(//select[@name="selectedsettype"])
	sleep    2
	Wait Until Element Is Visible     xpath:(//select[@name="selectedsettype"])//option[@value="${type}"]    30
	Click Element       xpath:(//select[@name="selectedsettype"])//option[@value="${type}"]
	wait for page to load
	capture page screenshot

enter the name filter
	[Arguments]    ${filter}
	Selenium2Library.Input Text    name:searchstring    ${filter}
	wait for page to load
	capture page screenshot

click on the button
	[Arguments]    ${buttonValue}
	sleep     5
	Wait Until Element Is Visible     xpath://*[@value="${buttonValue}"]    300
    Click element     xpath://*[@value="${buttonValue}"]
	wait for page to load
	capture page screenshot
	
verify that the execution status is FINISHED
	${text}=    Selenium2Library.Get text  xpath:(//table[@border="1"])//tbody//tr[2]//td[5]
    Log    ${text}
    Should contain	  ${text}     FINISHED
    sleep    5
    wait for page to load
	capture page screenshot	

Test teardown
    Capture page screenshot
    click on button    Logout
    Close Browser