
*** Keywords ***

suite setup for webui
	Set Environment Variable  webdriver.chrome.driver    ./drivers/chromedriver.exe
	Set Screenshot Directory   ./Screenshots

open app coverage map analysis
    ${chrome_options}=    Evaluate    sys.modules['selenium.webdriver'].ChromeOptions()      sys
	Call Method    ${chrome_options}    add_argument    --ignore-certificate-errors
	Create Webdriver    Chrome    executable_path=C:/Ericsson/chromedriver.exe      chrome_options=${chrome_options}
    Go To    ${base_url}   
    Maximize Browser Window
    Sleep    5
    Selenium2Library.Input Text    name:username    Administrator
    Selenium2Library.Input Text    name:password    Ericsson01
    Selenium2Library.Click Element    class:LoginButton
    Sleep    10
    Go To    ${base_url}${app_coverage_url}
    Sleep    30
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
    
verify app coverage map analysis page opened
	${title}=    Get Title
    Should Contain      ${title}     App Coverage Map
    
click on cell performance button
    Selenium2Library.Click Element     xpath://input[@value='Cell Performance']
    
verify Cell Performance Ranking Page opens on App Coverage Map Analysis
    sleep    5s
	${title}=    Selenium2Library.Get Text     class:sf-root
    Should Contain      ${title}     Cell Performance: 7 Days
    
Select from Uplink/Downlink dropdown 
    [Arguments]    ${value}
    Click on scroll down button     3     2
    Selenium2Library.Click Element    class:ComboBoxTextDivContainer
    Selenium2Library.Click Element    xpath://div[@class='ListItems']//div[@title='${value}']
    
Click on the scroll down button
    [Arguments]     ${button}    ${n}
    @{element}=    Get WebElements	    xpath: //div[@class="ScrollbarButton sf-element sf-element-scroll-bar-button sfpc-bottom"]
    ${scroll_button}=        Get from list     ${element}    ${button}
    FOR    ${i}    IN RANGE    0    ${n} 
           Run Keyword and Ignore Error    Click element     ${scroll_button}           
    END
    wait for page to load
	capture page screenshot
    
Click on Cell Site Location button
    Selenium2Library.Click Element     xpath://input[@value='Cell Site Location >>']
    
verify Cell Site Location Page opens on App Coverage Map Analysis
    sleep    5s
	${title}=    Selenium2Library.Get Text     class:sf-root
    Should Contain      ${title}     Cell Site Location   
    
click on cell performance Ranking button
    Selenium2Library.Click Element     xpath://input[@value='<< Cell Performance Ranking']
    
click on Home button
    Selenium2Library.Click Element     xpath://*[@title='Home']
    
verify Home Page opens on App Coverage Map Analysis
    sleep    5s
	Selenium2Library.Element Should Be Visible      xpath://input[@value='Cell Performance']    
    Selenium2Library.Element Should Be Visible      xpath://input[@value='Network Overview'] 
    
click on Network Overview button
    Selenium2Library.Click Element     xpath://input[@value='Network Overview']

verify Network Overview opens on App Coverage Map Analysis
    sleep    5s
	${title}=    Selenium2Library.Get Text     class:sf-root
    Should Contain      ${title}     Network Overview: 7 Days    
    
verify license number displayed
    [Arguments]     ${license}
    Click on scroll down button    0     7
    ${title}=    Selenium2Library.Get Text     class:sf-root
    Should Contain      ${title}     ${license} 
    
Verify first chart title displayed as
    [Arguments]     ${value}
    @{element}=    Selenium2Library.Get WebElements	    xpath://div[@class='flex-item flex-align-start sf-element sf-element-text-box sf-single-line-text']
    ${ele}=        Get from list     ${element}    0
    ${title}=    Selenium2Library.Get Text     ${ele}
    Should Contain      ${title}     ${value} 
    
     
    