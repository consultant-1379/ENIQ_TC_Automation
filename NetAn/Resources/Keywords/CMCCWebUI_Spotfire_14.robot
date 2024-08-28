*** Variables ***

${username_xpath}         //input[@class='w-full pt-2 pb-2 pl-3 text-ellipsis pr-3 ng-untouched ng-pristine ng-invalid' and @placeholder='Username']
${password_xpath}         //input[@class='w-full pt-2 pb-2 pl-3 text-ellipsis pr-3 ng-untouched ng-pristine ng-invalid' and @placeholder='Password']
${loginButton_xpath}      //button[@data-testid='login-button']
${sfx_label}              sfx_label_1333
${sfx_page_title}         (//div[@class="sfx_page-title_1329"])
${author_dropdown}        //div[@class='sfx_author-dropdown_1174']
${save_analysis_button}   (//div[text()='Save'])[3]
${notification_container}                sfx_notification-panel-empty_334

*** Keywords ***

open cmcc analysis
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
    Go To    ${base_url}${cmcc_url}
    sleep    10
    ${IsElementVisible}=    Run Keyword And Return Status    Element Should not be Visible    xpath://div[contains(text(),'Missing Data')]
	Run Keyword If    ${IsElementVisible} is ${FALSE}   Close missing data window
	go to home page if not at home
	reset all filters and markings
    wait for page to load
    capture page screenshot
	
reset all filters and markings
	wait until element is visible    xpath: (//img[@title="Reset Filters and Markings"])    300
	click element    xpath: (//img[@title="Reset Filters and Markings"])
	wait for page to load
    capture page screenshot
	
go to home page if not at home
	wait until element is visible    xpath: ${sfx_page_title}    30
	${pageTitle}=    Selenium2Library.Get text  xpath: ${sfx_page_title}
	IF 		"${pageTitle}" != "Home"
        scroll element into view		xpath: //*[@title="Return Home"]
		Click element     xpath: //*[@title="Return Home"]
	END
	wait for page to load
	capture page screenshot
	
verify that the Network Analytics logo is visible
	element should be visible    xpath: ((//div[@class="HtmlTextArea sf-enable-selection sf-focusable"])//div//div//div//table//tbody//tr//td//img)[1]
	wait for page to load
	capture page screenshot

verify that the Cmcc logo is visible
	element should be visible    xpath:((//div[@class="HtmlTextArea sf-enable-selection sf-focusable"])//div//div//div//table//tbody//tr)[2]//td//img
	wait for page to load
	capture page screenshot
	
Close missing data window
	Wait Until Page Contains Element      xpath://span[contains(text(),'Apply to all inaccessible data tables in this analysis')]     timeout=150
    Click Element    xpath://span[contains(text(),'Apply to all inaccessible data tables in this analysis')]
    sleep    2
    Wait Until Page Contains Element      xpath://button[contains(text(),'OK')]     timeout=150
    Click Element    xpath://button[contains(text(),'OK')]
    wait for page to load
    capture page screenshot

verify that the Settings and Reset icons are visible
    Click on the scroll down button    0   15								 
	Element should be visible    xpath://*[@title="Reset Filters and Markings"]    300
	sleep    2
	Element should be visible    xpath://*[@title="Settings"]
	wait for page to load
	capture page screenshot

verify the page title  
	[Arguments]     ${expectedText}
	wait for page to load
    ${text}=    Selenium2Library.Get text  xpath: ${sfx_page_title}
    Log    ${text}
    ${status}=    run keyword and return status    Should contain     ${text}    ${expectedText}
    IF    "${status}"=="FALSE"
    	wait for page to load
    	${text}=    Selenium2Library.Get text  xpath: ${sfx_page_title}
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

Click on the scroll left button
    [Arguments]     ${button}    ${n}
    @{element}=    Get WebElements	    xpath: //div[@class="ScrollbarButton sf-element sf-element-scroll-bar-button sfpc-left"]
    ${scroll_button}=        Get from list     ${element}    ${button}
    FOR    ${i}    IN RANGE    0    ${n} 
           Run Keyword and Ignore Error    Click element     ${scroll_button}           
    END
    wait for page to load
	capture page screenshot	
	
Test teardown
    Capture page screenshot
    Close Browser
	
click on button value
	[Arguments]    ${buttonValue}
	sleep     5
	Wait Until Element Is Visible     xpath: //*[@value='${buttonValue}']    300
    ${status}=    run keyword and return status    Click element     xpath: //*[@value='${buttonValue}']
    IF    "${status}"=="FALSE"
    	wait for page to load
    	Click element     xpath: //*[@value='${buttonValue}']
    END
	wait for page to load
	capture page screenshot

verify that the button is visible
	[Arguments]    ${buttonTitle}
	Element should be visible    xpath://*[@title="${buttonTitle}"]
	wait for page to load
	capture page screenshot

wait for page to load
    Sleep   3s
	Wait Until Element Is Not Visible      xpath://*[@class='sf-svg-loader-12x12']              timeout=300
    Sleep    2s
	
click on button
	[Arguments]    ${buttonValue}
	Wait Until Element Is Visible     xpath: //*[@value='${buttonValue}' or @title='${buttonValue}']    100
    ${status}=    run keyword and return status    Click element     xpath: //*[@value='${buttonValue}' or @title='${buttonValue}']
    IF    "${status}"=="FALSE"
    	Wait Until Element Is Visible     xpath: //*[@value='${buttonValue}' or @title='${buttonValue}']    30
    	Click element     xpath: //*[@value='${buttonValue}' or @title='${buttonValue}']
    END
	wait for page to load
	capture page screenshot


Connect to ENIQ DB
    Wait Until Page Contains Element      xpath: //img[@title='Settings']     timeout=150
    Click element     xpath://img[@title='Settings']
    Sleep    2
    wait for page to load
    @{element}=    Get WebElements	    xpath: //input[@class='sf-element sf-element-control sfc-property sfc-text-box']
    ${name}=        Get from list     ${element}    0
    ${username}=        Get from list     ${element}    1
    ${password}=        Get from list     ${element}    2
    ${eniqs}=        Get from list     ${element}    3
    Selenium2Library.Input Text    ${name}       localhost 
    Sleep     10s
    Selenium2Library.Input Text    ${username}        netanserver
    Sleep     4s
    Selenium2Library.Input Text    ${password}        Ericsson01 
    Sleep     5s
    Click element     xpath: (//input[@value="Connect"])[1]
    Sleep     10s
    FOR    ${i}    IN RANGE    0     5
         ${text}=      Selenium2Library.Get text      xpath://span[@id='8391699d0bf14a77bdbb36f28f03daaa']
         IF    '${text}'=='Connection OK'
               Exit For Loop
         ELSE IF     '${text}'=='Provide value for: NetAn SQL DB URL'
               Selenium2Library.Input Text    ${name}       localhost
               
         ELSE IF     '${text}'=='Provide value for: NetAn User Name'
               Selenium2Library.Input Text    ${username}       netanserver     
    
         ELSE IF       '${text}'=='Provide value for: NetAn Password '
               Selenium2Library.Input Text    ${password}       Ericsson01 
         END
         Sleep     1s
         Click element     xpath: (//input[@value="Connect"])[1]
         Sleep     10s
    END 
    
    FOR    ${i}    IN RANGE    0     5
          Click element     xpath: (//div[@class="ScrollbarButton sf-element sf-element-scroll-bar-button sfpc-bottom"])[3]       
          
    END
    Clear Element Text      ${eniqs}
    Selenium2Library.Input Text    ${eniqs}       NetAn_ODBC                 
    Sleep    3s
    Click element     xpath: (//input[@value="Connect"])[2]    
    Sleep    15s

	
verify that the connection to NetAn database is made
	${text}=    Selenium2Library.get text 	xpath:(//*[@id="table-data"])//td[6]//span[1]
	should be equal    ${text}    Connection OK
	wait for page to load
	capture page screenshot
	
verify that the connection to datasource(s) is made
	Click on the scroll down button    2    10   
	${text1}=    Selenium2Library.get text 	xpath:((//*[@id="table-data"])//td[6]//span[1])[2]
	should be equal    ${text1}    Connection OK
	wait for page to load
	capture page screenshot

click on Rule Manager button	
	wait for page to load
	Click on the scroll down button    0    3    
    Wait Until Element Is Visible     xpath: //input[@value="CM Rule Manager"]    200
   	Click element     xpath: //input[@value="CM Rule Manager"]
	wait for page to load
	capture page screenshot

click on Create Rule button	
	wait for page to load
    Click on the scroll down button    0    4
	Wait Until Element Is Visible     xpath: //input[@value="Create Rule"]    200
   	Click element     xpath: //input[@value="Create Rule"]
	wait for page to load
	capture page screenshot

click on Check Check Rules button	
	wait for page to load
    Click on the scroll down button    0    4
	Wait Until Element Is Visible     xpath: //input[@value="Check Rules"]    200
   	Click element     xpath: //input[@value="Check Rules"]
	wait for page to load
	capture page screenshot


Connect to ENIQ with incorrect Credentials
    Wait Until Page Contains Element      xpath: //img[@title='Settings']     timeout=20
    Click element     xpath://img[@title='Settings']
    wait for page to load
    @{element}=    Get WebElements	    xpath: //input[@class='sf-element sf-element-control sfc-property sfc-text-box']
    ${name}=        Get from list     ${element}    0
    ${username}=        Get from list     ${element}    1
    ${password}=        Get from list     ${element}    2
    ${eniqs}=        Get from list     ${element}    3
    Selenium2Library.Input Text    ${name}       localhost 
    Sleep     1s
    Selenium2Library.Input Text    ${username}       netanserver
    Sleep     1s
    Selenium2Library.Input Text    ${password}       Ericsson055 
    Sleep     1s
    Click element     xpath: (//input[@value="Connect"])[1]
    Sleep     10s
    FOR    ${i}    IN RANGE    0     5
         ${text}=      Selenium2Library.Get text      xpath://span[@id='8391699d0bf14a77bdbb36f28f03daaa']
         IF    '${text}'=='Connection OK'
               Exit For Loop
         ELSE IF     '${text}'=='Provide value for: NetAn SQL DB URL'
               Selenium2Library.Input Text    ${name}       localhost               
         ELSE IF     '${text}'=='Provide value for: NetAn User Name'
               Selenium2Library.Input Text    ${username}       netanserver       
         ELSE IF       '${text}'=='Provide value for: NetAn Password '
               Selenium2Library.Input Text    ${password}       Ericsson055 
         END
         Sleep     1s
         Click element     xpath: (//input[@value="Connect"])[1]
         Sleep     10s
    END    
    
    FOR    ${i}    IN RANGE    0     5
          Click element     xpath: (//div[@class="ScrollbarButton sf-element sf-element-scroll-bar-button sfpc-bottom"])[3]       
          
    END
    Clear Element Text      ${eniqs}
    Selenium2Library.Input Text    ${eniqs}       ieatrcxb4832
    Sleep    3s
    Click element     xpath: (//input[@value="Connect"])[2]   
    Sleep    10s
    wait for page to load
	capture page screenshot
	
verify that connection is not made
	${text}=    Selenium2Library.get text 	xpath:(//*[@id="table-data"])//td[6]//span[1]
	should be equal    ${text}    Cannot Create Connection
	wait for page to load
	capture page screenshot

Enter Node Name in Node Exclusion Field
    [Arguments]     ${NodeName}
    @{element}=    Get WebElements	    xpath: //input[@class='sf-element sf-element-control sfc-property sfc-text-box']
    ${name}=        Get from list     ${element}    4
    Selenium2Library.Input Text    ${name}       ${NodeName}
    wait for page to load
	capture page screenshot
	
Verify Node is added in Node exclusion List
    [Arguments]     ${NodeName}
	${text}=    selenium2library.get text    xpath:(//div[@class="ScrollArea"])[1]
	Log    ${text}
	should contain    ${text}    ${NodeName}
	wait for page to load
	capture page screenshot

Select Node in Node exclusion List
    [Arguments]     ${NodeName}
	wait until element is visible    xpath: ((//div[@class="ListItems"]))//div[@class="sf-element-list-box-item" and @title="${NodeName}"]     10
	click element    xpath: ((//div[@class="ListItems"]))//div[@class="sf-element-list-box-item" and @title="${NodeName}"]
	wait for page to load
	capture page screenshot
	
Verify Node is removed in Node exclusion List
    [Arguments]     ${NodeName}
	${text}=    selenium2library.get text    xpath:(//div[@class="ScrollArea"])[1]
	Log    ${text}
	should not contain    ${text}    ${NodeName}
	wait for page to load
	capture page screenshot
	
verify error message should be displayed after add button
	wait for page to load			   
	element should be visible    xpath: (//*[contains(text(),'Node is already excluded')])    30
	wait for page to load
	capture page screenshot
	
click on Execute Rule button
	Click on the scroll down button    8    2
	Wait Until Element Is Visible     xpath: //input[@value="Execute Rules " or @value="Execute Rules"]    200
   	Click element     xpath: //input[@value="Execute Rules " or @value="Execute Rules"]
	wait for page to load
	capture page screenshot

click on Remove Excluded Nodes button to get error
	wait for page to load
	capture page screenshot
	${status}=    run keyword and return status    element should not be visible    xpath: (//div[@class="ListItems"]//div[@class="sf-element-list-box-item sfpc-selected"])
	Run keyword if    "${status}"=="False"    click element    xpath: (//div[@class="ListItems"]//div[@class="sf-element-list-box-item sfpc-selected"])    modifier=CTRL
	click on button    Remove Excluded Nodes
	wait for page to load
	capture page screenshot
	
verify error message should be displayed for Remove button
	wait for page to load			   
	element should be visible    xpath: (//span[contains(text(),'To remove nodes from exclusion list, select a node from the list on the right.')])    30
	wait for page to load
	capture page screenshot
	
create sample Rule with Rulename moclass attribute value	
	[Arguments]     ${RuleName}     ${MOClass}    ${Attribute}    ${Value}
    wait Until Element Is Visible     xpath: //span[@id="ruleNameInput"]//input    200
    Selenium2Library.Input Text    xpath: //span[@id="ruleNameInput"]//input    ${RuleName}
    wait for page to load
    capture page screenshot    
    wait Until Element Is Visible    xpath: (//input[@placeholder="Type to search in list"])[1]
   	Selenium2Library.Input Text    xpath: (//input[@placeholder="Type to search in list"])[1]    ${MOClass}  
    wait until element is visible    xpath: (//div[@class="VirtualBoxMagnifier"])[1]    30
    Click element     xpath: (//div[@class="VirtualBoxMagnifier"])[1]
    wait until element is visible    xpath: //div[@title="${MOClass}"]    30
    Click element     xpath: //div[@title="${MOClass}"]
    wait Until Element Is Visible    xpath: (//input[@placeholder="Type to search in list"])[2]
   	Selenium2Library.Input Text    xpath: (//input[@placeholder="Type to search in list"])[2]    ${Attribute}
	wait until element is visible    xpath: (//div[@class="VirtualBoxMagnifier"])[1]    30
    Click element     xpath: (//div[@class="VirtualBoxMagnifier"])[1]	
    wait Until Element Is Visible    xpath: //div[@title="${Attribute}"]    30
    Click element     xpath: //div[@title="${Attribute}"]
    Click on the scroll down button    2    8
    wait Until Element Is Visible    xpath: //span[@id="valueInputField"]
    sleep    2
	wait Until Element Is Visible    xpath: //span[@id="valueInputField"]//input    30
    Selenium2Library.Input Text    xpath: //span[@id="valueInputField"]//input    ${Value}  
    wait for page to load
    capture page screenshot
		
click on Save Rule button	
    sleep    3s
	run keyword and ignore error       Selenium2Library.drag and drop        xpath:(//div[@class='sf-splitter'])[2]         xpath:(//*[contains(text(),"Rule Name")])[1]
	Click on the scroll down button    4    4
	Wait Until Element Is Visible     xpath: //span[@id="saveRuleButton"]    200
   	Click element     xpath: //span[@id="saveRuleButton"]//input
	wait for page to load
	capture page screenshot

select the Rule Name in CM Rule Manager	
	[Arguments]     ${RuleName}
    verify the page title    CM Rule Manager
	Wait Until Element Is Visible     xpath: //div[contains(text(),"${RuleName}")]    100
   	Click element     xpath: //div[contains(text(),"${RuleName}")]	
	sleep    3s
	wait for page to load
	${status} =  Run Keyword And Return Status    Wait Until Element Is Visible     xpath: //input[@value="Edit"]
	IF    "${status}"=="False"
		Click element     xpath: //div[contains(text(),"${RuleName}")]    modifier=CTRL
		sleep    3s
	    Wait Until Element Is Visible     xpath: //div[contains(text(),"${RuleName}")]    50
		Click element     xpath: //div[contains(text(),"${RuleName}")]
    END
	wait for page to load
	capture page screenshot

Clear MO Instance and Where clause in Existing Value
    verify the page title    Edit Rule
    FOR    ${i}    IN RANGE    0     30
        click element    xpath: (//div[@class="ScrollbarButton sf-element sf-element-scroll-bar-button sfpc-top"])[3]    
    END
    sleep    4s
    Click on the scroll down button    2    24
    Clear Element Text    xpath: (//input[@class="sf-element sf-element-control sfc-property sfc-text-box"])[4]
    sleep    5s
    Clear Element Text    xpath: //td[@class="WhereClause"]//textarea
	sleep    3s
	wait for page to load
	capture page screenshot

click on Delete button	
	Click on the scroll down button    4    2
	Wait Until Element Is Visible     xpath: //input[@value="Delete"]    200
   	Click element     xpath: //input[@value="Delete"]
	wait for page to load
	capture page screenshot

click on Edit button	
	Click on the scroll down button    4    2
	Wait Until Element Is Visible     xpath: //input[@value="Edit"]    200
   	Click element     xpath: //input[@value="Edit"]	 
    verify the page title    Edit Rule    
	capture page screenshot
	
Suite setup steps for CCMC
	open cmcc analysis
	change mode to       Editing
	Connect to ENIQ DB
	wait for page to load
	Save the analysis
	Close Browser
	
Suite teardown steps for CCMC
	capture page screenshot
	close browser

Test teardown steps for CCMC
	capture page screenshot
	close browser

change mode to
	[Arguments]    ${mode}
	Wait Until Page Contains Element      xpath: ${author_dropdown}     timeout=300
	Click element       xpath: ${author_dropdown}
	Wait Until Page Contains Element      xpath://div[@title='${mode}']     timeout=300
	Click Element      xpath://div[@title='${mode}']
    Run keyword IF    "${mode}"=="Editing"        Wait Until Element Is Visible      xpath://div[@title='Data in analysis']       timeout=150
	wait for page to load
	capture page screenshot

Save the analysis
    click element       xpath://div[@title='File']
    click element       xpath://div[@title='Save as']
    click element       xpath://div[@title='Library item...']
    wait for page to load
    click element       xpath:${save_analysis_button}
    sleep     20s
    click element       xpath://button[text()='Yes']
    sleep     15s
    wait for page to load
	capture page screenshot
	
Enter VectorIndex value in Rule Creation
	[Arguments]     ${VectorIndex}     
    Click on the scroll down button    2    4
    wait Until Element Is Visible    xpath: (//input[@class="sf-element sf-element-control sfc-property sfc-text-box"])[3]    30
    Selenium2Library.Input Text    xpath: (//input[@class="sf-element sf-element-control sfc-property sfc-text-box"])[3]   ${VectorIndex}  
    wait for page to load
    capture page screenshot

Enter TableName value in Rule Creation
	[Arguments]     ${TableName}     
    Click on the scroll down button    2    12
    wait Until Element Is Visible    xpath: (//input[@class="sf-element sf-element-control sfc-property sfc-text-box"])[5]    30
    Selenium2Library.Input Text    xpath: (//input[@class="sf-element sf-element-control sfc-property sfc-text-box"])[5]    ${TableName}  
    wait for page to load
    capture page screenshot

Enter MO Instance in Rule Creation
	[Arguments]     ${ID}  
    Click on the scroll down button    2    4
    wait Until Element Is Visible    xpath: (//input[@class="sf-element sf-element-control sfc-property sfc-text-box"])[4]    200
    Selenium2Library.Input Text    xpath: (//input[@class="sf-element sf-element-control sfc-property sfc-text-box"])[4]    ${ID}  
    wait for page to load
    capture page screenshot

Enter Where Clause value in Rule Creation
    [Arguments]    ${WhereClause}  
    Click on the scroll down button    2    15
    wait Until Element Is Visible    xpath: //td[@class="WhereClause"]//textarea    30
    Selenium2Library.Input Text    xpath: //td[@class="WhereClause"]//textarea    ${WhereClause}  
    wait for page to load
    capture page screenshot

Enter Value in Rule Creation
    [Arguments]    ${Value}
    wait Until Element Is Visible    xpath: //span[@id="valueInputField"]    200
    Selenium2Library.Input Text    xpath: //span[@id="valueInputField"]//input    ${Value}
    wait for page to load
    capture page screenshot


Enter RuleName in Rule Creation
    [Arguments]    ${RuleName}
    wait Until Element Is Visible    xpath: //span[@id="ruleNameInput"]//input    200
    Selenium2Library.Input Text    xpath: //span[@id="ruleNameInput"]//input    ${RuleName}
    wait for page to load
    capture page screenshot

Edit Text in Existing Value
    [Arguments]     ${value}    ${NewValue} 
    verify the page title    Edit Rule
    FOR    ${i}    IN RANGE    0     30
        click element    xpath: (//div[@class="ScrollbarButton sf-element sf-element-scroll-bar-button sfpc-top"])[3]    
    END
    IF    '${value}' == "Rule Name"
        sleep    4s
        Clear Element Text    xpath: //span[@id="ruleNameInput"]//input
        sleep    4s
        Enter RuleName in Rule Creation    ${NewValue}
        
    ELSE IF    '${value}' == "Value"    
        Sleep    4s
        Click on the scroll down button    2    4
        Clear Element Text    xpath: //span[@id="valueInputField"]//input
        Enter Value in Rule Creation    ${NewValue}    

    ELSE IF    '${value}' == "VectorIndex"
        sleep    4s
        Click on the scroll down button    2    8
        Clear Element Text    xpath: (//input[@class="sf-element sf-element-control sfc-property sfc-text-box"])[3]
        Enter VectorIndex value in Rule Creation    ${NewValue}     


    ELSE IF    '${value}' == "TableName"
        sleep    4s
        Click on the scroll down button    2    18
        Clear Element Text    xpath: (//input[@class="sf-element sf-element-control sfc-property sfc-text-box"])[5]
        Enter TableName value in Rule Creation    ${NewValue}    

    ELSE IF    '${value}' == "MO Instance"
        sleep    4s
        Click on the scroll down button    2    14
        Clear Element Text    xpath: (//input[@class="sf-element sf-element-control sfc-property sfc-text-box"])[4]
        Enter MO Instance in Rule Creation    ${NewValue}    


    ELSE IF    '${value}' == "WhereClause"
        sleep    5s
        Click on the scroll down button    2    24
        Clear Element Text    xpath: //td[@class="WhereClause"]//textarea
        Enter Where Clause value in Rule Creation    ${NewValue}  

    END 

Error Messages should be Displayed
    Click on the scroll down button    2    35
    wait Until Element Is Visible    xpath: //span[@id="createRuleError"]//span    200
    sleep    15s
    ${text1}=    Selenium2Library.get text 	  xpath: //span[@id="createRuleError"]//span
    ${status}=     Run Keyword And Return Status        Element should be visible          xpath://span[@id="createRuleError"]//span
    IF    '${text1}' == "Please enter required fields., Invalid Attribute"
        Return    ${status} 
    END  
    capture page screenshot


select multiple rules in cm rule page
	sleep     3s
    click element       xpath://div[@row='1' and @column='0']
	sleep    3s
	wait for page to load
	Click element     xpath: //div[@row='1' and @column='0']    modifier=CTRL
	sleep    3s
	Wait Until Element Is Visible     xpath: //div[@row='1' and @column='0']    50
	Click element     xpath: //div[@row='1' and @column='0']
	sleep     10s
    click element       xpath://div[@row='2' and @column='0']    modifier=SHIFT	
	wait for page to load
	capture page screenshot

Verify if edit button is disabled
    ${status1}=      Run keyword and return status       Click element     xpath: xpath: //input[@value="Edit" or @value="Edit "]
	Run keyword IF     ${status1}==True     FAIL      msg= Fetch nodes button is enabled
    wait for page to load
    capture page screenshot

verify navigation should not happen 
	[Arguments]     ${expectedText}
	wait for page to load
    ${text}=    Selenium2Library.Get text  xpath: ${sfx_page_title}
    Log    ${text}
    ${status}=    run keyword and return status    Should not contain     ${text}    ${expectedText}
    wait for page to load
	capture page screenshot
	
select rule to delete
	wait for page to load
	Click Element    xpath:(//div[@class="cell-text"])[1]
	Sleep    2s
    ${text}=    Selenium2Library.Get text  xpath: (//div[@class="cell-text"])[1]
    Log    ${text}
	click on Delete button
	wait for page to load
    ${text1}=    Selenium2Library.Get text  xpath: (//div[@class="cell-text"])[1]
    Log    ${text1}
    ${status}=    run keyword and return status    Should not contain     ${text}    ${text1}
	wait for page to load
	capture page screenshot
	
	
	
select multiple rule to delete
	wait for page to load
	wait until element is visible    xpath: (//div[@class="valueCellCanvas"])//div//div[@row="1" and @column="0"]    30
	Click Element    xpath: (//div[@class="valueCellCanvas"])//div//div[@row="1" and @column="0"]    modifier=CTRL
	Sleep    2s
    ${text}=    Selenium2Library.Get text  xpath: (//div[@class="valueCellCanvas"])//div//div[@row="1" and @column="0"]
	Sleep    1s
    Log    ${text}
	Sleep    1s
	wait until element is visible    xpath: (//div[@class="valueCellCanvas"])//div//div[@row="2" and @column="0"]    30
	Click Element    xpath: (//div[@class="valueCellCanvas"])//div//div[@row="2" and @column="0"]    modifier=CTRL
	Sleep    2s
	${text1}=    Selenium2Library.Get text  xpath: (//div[@class="valueCellCanvas"])//div//div[@row="2" and @column="0"]
	Sleep    1s
	Log    ${text1}
	capture page screenshot
	click on Delete button
	wait for page to load
    ${text2}=    Selenium2Library.Get text  xpath: (//div[@class="valueCellCanvas"])//div//div[@row="1" and @column="0"]
    Log    ${text2}
	Sleep    1s
    ${status}=    run keyword and return status    Should not contain     ${text}    ${text2}
	Sleep    1s
	${status}=    run keyword and return status    Should not contain     ${text1}    ${text2}
	wait for page to load
	capture page screenshot
	

Verify filters in CM Rule Manager
	wait for page to load
	element should be visible    xpath: (//div[@class="ListItems"])[1]
	Sleep    1s
	Click on the scroll down button    7     10
	element should be visible    xpath: (//div[@class="ListItems"])[2]
	Click on the scroll down button    7     20
	element should be visible    xpath: (//div[@class="flex-item flex-align-start sf-element sf-element-text-box"])[1]
	Sleep    2s
	element should be visible    xpath: (//div[@class="flex-item flex-align-start sf-element sf-element-text-box"])[2]
	capture page screenshot
		
Verfiy Date panels
	wait for page to load
	Click on the scroll down button    8     5
	wait until element is visible    xpath: (//div[@class="sf-element-text-box"])    30
	Click Element    xpath:(//div[@class="sf-element-text-box"])
	Sleep    2s
	wait until element is visible    xpath: (//div[@class="sf-element-dropdown-list-item"])[1]    30
	element should be visible    xpath:(//div[@class="sf-element-dropdown-list-item"])[1]
	click element    xpath: (//div[@class="sf-element-dropdown-list-item"])[1]
	capture page screenshot

Verify selected rule is valid in cm rule manager
	wait for page to load
	Click Element    xpath:(//div[@class="cell-text"])[1]
	Sleep    2s
    ${text}=    Selenium2Library.Get text  xpath: (//div[@class="cell-text"])[10]
    Log    ${text}
    ${status}=    run keyword and return status    Should contain     ${text}    Valid	
	
Click on excute rules button
	wait for page to load
	Click Element    xpath:(//input[@value="Execute Rules "])
	Sleep    2s

Click on edit rules button
	wait for page to load
	Click Element    xpath:(//input[@value="Edit "])
	Sleep    2s
	
Click on Discrepancies button
	wait for page to load
	Click Element    xpath:(//input[@value="Discrepancies "])
	Sleep    2s

check rules are vadilated or not
	wait for page to load
	Click Element    xpath:(//div[@class="cell-text"])[1]
	Sleep    2s
    ${text}=    Selenium2Library.Get text  xpath: (//div[@class="cell-text"])[10]
    Log    ${text}
    Should Not Be Empty    	${text}


Filter MO Class
	[Arguments]    ${MOClass} 
    wait Until Element Is Visible    xpath: (//input[@placeholder="Type to search in list"])[1]
    clear element text    xpath: (//input[@placeholder="Type to search in list"])[1]
   	Selenium2Library.Input Text    xpath: (//input[@placeholder="Type to search in list"])[1]    ${MOClass}  
    sleep    2
    press keys    xpath: (//input[@placeholder="Type to search in list"])[1]    ENTER
	Sleep    2s
    wait Until Element Is Visible    xpath: //div[@title="${MOClass}"]
    Click element     xpath: //div[@title="${MOClass}"]
    sleep    2
	capture page screenshot   
	
Select Date from drop down 
	Click on the scroll down button    8    4
    Wait Until Element Is Visible    xpath: //div[@class='ComboBoxTextDivContainer']    30
    Click Element    xpath: //div[@class='ComboBoxTextDivContainer']  
    Sleep    2
    Wait Until Element Is Visible    xpath: (//div[@class="sf-element-dropdown-list-item"])[1]    30
    ${dateValue}=    get text    xpath: (//div[@class="sf-element-dropdown-list-item"])[1]
    Click Element    xpath: (//div[@class="sf-element-dropdown-list-item"])[1] 
    [Return]    ${dateValue}
	wait for page to load
	capture page screenshot     

select a rule from CM Rules
	Wait Until Element Is Visible     xpath: ((//div[@name="valueCellCanvas"])//div//div)[1]
    Click Element    xpath: ((//div[@name="valueCellCanvas"])//div//div)[1]
	wait for page to load
	capture page screenshot     
	
select a rule in Discrepancies page
	Wait Until Element Is Visible     xpath: (//div[@name='valueCellCanvas']//div[@row='1'])[2]        timeout=30
	mouse over    xpath://div[text()='VectorIndex' and @class='cell-text sf-element-text-overflow-check']
	capture page screenshot
	Sleep    1s
	Click on the scroll left button    3    30
    Click Element    xpath: (//div[@name='valueCellCanvas']//div[@row='1' and @column='0'])[2]
	wait for page to load
	capture page screenshot     
    
read the value Percentage Discrepancies
    Wait Until Element Is Visible     xpath: (//div[@name='valueCellCanvas']//div[@row='1' and @column='5'])[2]    30
	sleep    2
    ${text1}=    get text    xpath: (//div[@name='valueCellCanvas']//div[@row='1' and @column='5'])[2]
	${text12}=    Split String	${text1}    
	${text123}=     Get From List    ${text12}    0
	${text}=    Strip String    ${text123}
    Log    ${text}
    [Return]    ${text}
    wait for page to load
	capture page screenshot     

click on Execute Rules button	   
    Click on the scroll down button    4    2
    Wait Until Element Is Visible     xpath: //input[@value="Execute Rules"]    200
   	Click element     xpath: //input[@value="Execute Rules"]
	wait for page to load
	capture page screenshot 
	
get sql query from json file
    [Arguments]     ${json_file}     ${data}
    ${json}=    OperatingSystem.get file    ${json_file}
    &{object}=    Evaluate     json.loads('''${json}''')     json
    [return]       ${object}[${data}]
	wait for page to load
	capture page screenshot

replace date values in the query
    [Arguments]    ${query}    ${dateVal}
    Log    ${query}
    Log    ${dateVal}
    ${query}=    replace string   ${query}     @dateTime    ${dateVal}
    [Return]    ${query} 
    capture page screenshot



select a rule from CM Rules for data intergrity
	[Arguments]    ${Rulename} 
    wait Until Element Is Visible    xpath: (//div[@class="valueCellCanvas"])//div//div//div[text()='${Rulename}']
    Click Element    xpath:(//div[@class="valueCellCanvas"])//div//div//div[text()='${Rulename}']
	capture page screenshot
	
Filter MO Class for case sensitive
	[Arguments]    ${MOClass} 
    wait Until Element Is Visible    xpath: (//input[@placeholder="Type to search in list"])[1]
    clear element text    xpath: (//input[@placeholder="Type to search in list"])[1]
   	Selenium2Library.Input Text    xpath: (//input[@placeholder="Type to search in list"])[1]    ${MOClass}  
    sleep    2
    press keys    xpath: (//input[@placeholder="Type to search in list"])[1]    ENTER
    sleep    3
    Click element     xpath: //div[@title="${MOClass}"]
    sleep    2
	capture page screenshot

select bar charts in discrepancis page
	Wait Until Element Is Visible      xpath: (//div[@class="sf-element-canvas-image sfc-transition-background"])    30
	Selenium2Library.Drag And Drop by Offset 	xpath: (//div[@class="sf-element-canvas-image sfc-transition-background"])    -140    -120
	wait until element is visible    xpath: //div[@class="${sfx_label}"][2]    300
	sleep    1
	${value}=    Selenium2Library.get text    xpath: //div[@class="${sfx_label}"][2]
	Log    ${value}
	IF    "${value}"=="0 marked"
		Wait Until Element Is Visible      xpath: (//div[@class="sf-element-canvas-image sfc-transition-background"])    300
		Selenium2Library.Drag And Drop by Offset 	xpath: (//div[@class="sf-element-canvas-image sfc-transition-background"])    -140    120
		wait until element is visible    xpath: //div[@class="${sfx_label}"][2]    300
		sleep    1
		${value1}=    Selenium2Library.get text    xpath: //div[@class="${sfx_label}"][2]
		IF    "${value1}"=="0 marked"
			Wait Until Element Is Visible      xpath: (//div[@class="sf-element-canvas-image sfc-transition-background"])    300
			Selenium2Library.Drag And Drop by Offset 	xpath: (//div[@class="sf-element-canvas-image sfc-transition-background"])    140    -120
			wait until element is visible    xpath: //div[@class="${sfx_label}"][2]    300
			${value2}=    Selenium2Library.get text    xpath: //div[@class="${sfx_label}"][2]
			IF    "${value2}"=="0 marked"
				Wait Until Element Is Visible      xpath: (//div[@class="sf-element-canvas-image sfc-transition-background"])    300
				Selenium2Library.Drag And Drop by Offset 	xpath: (//div[@class="sf-element-canvas-image sfc-transition-background"])    140    120
			END
		END
	END
	wait for page to load
	capture page screenshot
	
verify that the marked value is not 0
	wait until element is visible    xpath: //div[@class="${sfx_label}"][2]    300
	${value}=    Selenium2Library.get text    xpath: //div[@class="${sfx_label}"][2]
	Log    ${value}
	should not be equal    ${value}    0 marked
	wait for page to load
	capture page screenshot	
	
place cursor on
	[Arguments]    ${text}
	mouse over    xpath://*[contains(text(),'${text}')]
	wait for page to load
	capture page screenshot

Check for the error notification is not present
	Click Element      xpath://*[@title="Notifications"]
	Sleep    3s
	${notification}=    Get text    xpath://div[@class='${notification_container}']
	Should contain          ${notification}         There are currently no notifications	

Verify Check Rules Button
    click on Check Check Rules button
    wait for page to load
    Sleep    3s
    ${count}=    Get Element Count    //div[@class="sf-element-list-box-item"]
    Should Be True    ${count} > 0
    capture page screenshot