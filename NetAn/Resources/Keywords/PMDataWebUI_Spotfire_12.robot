*** Keywords ***

Install Utility mobule in web player
      Open Nodes and services
      Click on Update service button and verify successfull message
	 
	 
Open Nodes and services
    ${chrome_options}=    Evaluate    sys.modules['selenium.webdriver'].ChromeOptions()      sys
	Call Method    ${chrome_options}    add_argument    --ignore-certificate-errors
	Create Webdriver    Chrome    options=${chrome_options}
    Go To    ${base_url}   
    Maximize Browser Window
    Sleep    5
    Selenium2Library.Input Text   xpath:(//input[@class="w-full pt-2 pb-2 pl-3 text-ellipsis pr-3 ng-untouched ng-pristine ng-invalid"])[1]    Administrator
    sleep    3
    Selenium2Library.Input Text   xpath:/html/body/tss-root/div/div/tss-login/div/div/form/tss-input[2]/div/div/input    Ericsson01
    sleep    3
    Click Element   xpath:/html/body/tss-root/div/div/tss-login/div/div/form/button
    Sleep    5
    Go To    ${base_url}${nodes_and_services_url_s12}
	sleep    20
    ${IsElementVisible}=    Run Keyword And Return Status    Element Should be Visible     xpath://*[@title='Auto WEB_PLAYER']
	Run Keyword If    ${IsElementVisible} is ${FALSE}   run keyword and ignore error      Navigate to Auto WEB_PLAYER
	
	
	
Navigate to Auto WEB_PLAYER   
    FOR    ${i}    IN RANGE    0    5 
           Click element     xpath://*[@class='tss-hierarchy__button']
	       sleep    3  
           ${IsElementVisible}=    Run Keyword And Return Status    Element Should be Visible     xpath://*[@title='Auto WEB_PLAYER']
           Capture page screenshot		   
           Run Keyword If    ${IsElementVisible} is ${TRUE}   exit for loop		   
    END   
	Click element     xpath://*[@title='Auto WEB_PLAYER']
	sleep    3
	Capture page screenshot	
	Capture page screenshot
	
	
Click on Update service button and verify successfull message				  
    @{element}=    Get WebElements      xpath://button[@class='tss-button secondary ng-star-inserted']
    #${ele}=        Get from list     ${element}    0
	FOR    ${ele}    IN    @{element}
		${text}=       Selenium2library.Get text       ${ele}
		Run keyword if      "${text}"=="Update service"      Click on Update service button      ${ele}
		Run keyword if      "${text}"=="Update service"      exit for loop
	END
   
   
Click on Update service button 
    [Arguments]      ${ele}
    Click element     ${ele}
    sleep     2s
    @{element}=    Get WebElements      xpath://button[@class='tss-button secondary ng-star-inserted']
    ${ele}=        Get from list     ${element}    23
    Click element     ${ele}
    sleep     120s
    @{element}=    Get WebElements      xpath://div[@class='tss-grid']//div
    ${ele}=        Get from list     ${element}    2
    ${text}=  Selenium2library.Get text      ${ele} 
    Run keyword if      "${text}"!="Status Service installed successfully"     Sleep  120s  
    @{element}=    Get WebElements      xpath://div[@class='tss-grid']//div
    ${ele}=        Get from list     ${element}    2
    ${text}=  Selenium2library.Get text      ${ele} 
    Should contain     Status Service installed successfully            ${text}   
    
    