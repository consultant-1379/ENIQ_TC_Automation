*** Keywords ***

Open chrome browser
    Set Selenium Implicit Wait       300s
    ${chrome_options}=    Evaluate    sys.modules['selenium.webdriver'].ChromeOptions()      sys
	Call Method    ${chrome_options}    add_argument    --ignore-certificate-errors
	Create Webdriver    Chrome    executable_path=${EXEC_DIR}/ENIQ_TC_Automation/NetAn/Resources/Drivers/chromedriver.exe      chrome_options=${chrome_options}
    Maximize Browser Window
	
open pm alarm analysis
    Open chrome browser
    Go To    ${base_url}   
    Sleep    5
    Selenium2Library.Input Text    name:username    Administrator
    Selenium2Library.Input Text    name:password    Ericsson01
    Selenium2Library.Click element    class:LoginButton
    Sleep    5
    Go To    ${base_url}${pma_url}
    sleep    15
    ${IsElementVisible}=    Run Keyword And Return Status    Element Should not be Visible    xpath://div[contains(text(),'Missing Data')]
	Run Keyword If    ${IsElementVisible} is ${FALSE}   Close missing data window
    Wait Until Page Contains Element      xpath://input[@value='Alarm Rules Manager']     timeout=1500
    wait for page to load
    capture page screenshot
    
Close missing data window
	Wait Until Page Contains Element      xpath://span[contains(text(),'Apply to all inaccessible data tables in this analysis')]     timeout=150
    Click Element    xpath://span[contains(text(),'Apply to all inaccessible data tables in this analysis')]
    sleep    5
    Wait Until Page Contains Element      xpath://button[contains(text(),'OK')]     timeout=150
    Click Element    xpath://button[contains(text(),'OK')]
    
Navigate to alarm setting and change retention period
     [Arguments]      ${retention_period}
     Navigate to section      Alarm Setting
     Click on Next Button
     sleep    3s
     Click element     xpath://div[@class='ComboBoxTextDivContainer']
     sleep      2s
     Click element     xpath://div[@title='${retention_period}']
     sleep     5s
     Click on minimise window button     0
     sleep     5s
 
    
Navigate to section
    [Arguments]     ${section}
	${count}=       set variable      0
	place the cursor on    ENIQ Connection Status
	Click on maximise window button    1
	Sleep      5s	
	FOR    ${i}    IN RANGE    0     15
	    ${count}=     Get Element Count       xpath: //*[contains(text(),'${section}')]
         IF      ${count}>0
                 Exit for loop
	     ELSE
		         Click on Next Button
				 Sleep     3s
				 Capture page screenshot
         END
	END
	IF      ${count}==0  
		          FAIL     Section ${section} is not available in UI
	END 

Deactivate any alarm and verify alarm is in Inactive state
     Click Element      xpath://div[@row='1' and @column='2']
     sleep    5s
     Click on Deactivate button
     Mouse Over      xpath://div[text()='MeasuresName']
     sleep      1s
     Click on scroll right button    1     10
     ${alarm_state}=       Selenium2Library.Get text      xpath://div[@row='1' and @column='4']
     Should contain        ${alarm_state}          Inactive

Click on Export button
     Click on scroll down button     5       4
     Click Element     xpath://input[@value='Export']
     sleep    5s 
	    
Export any alarm and validate successful export message
     Click Element      xpath://div[@row='1' and @column='2']
     sleep    5s
     Click on Export button
     sleep    3s
     Element Should Be Visible        xpath://span[contains(text(),'Rules exported to')]
     
Select any alarm
     Click Element      xpath://div[@row='1' and @column='2']
     sleep    5s
     
Click on Import button
     Click on scroll down button     5       4
     Click Element     xpath://input[@value='Import']
     sleep    5s 
 
Select alarm rule file
    [Arguments]      ${alarm_rule_name}     
    sleep     5s
    @{element}=    Get WebElements	    xpath: //div[@class='sf-splitter']
    ${splitter1}=        Get from list     ${element}    2
    ${splitter2}=        Get from list     ${element}    7
    Drag and drop       ${splitter1}       ${splitter2}
    sleep     2s
    Click element     xpath://div[@class='ArrowContainer']
    sleep    2s
    #@{element}=    Get WebElements	    xpath: //div[contains(@title,'Alarm Definitions Export')]
    #${alarm_rule}=        Get from list     ${element}    0
    #${alarm_rule_name}=      Selenium2library.Get text          ${alarm_rule}
    Click element           xpath: //div[contains(@title,'${alarm_rule_name}')]
    sleep   2s
    
Change alarm rule name in alarm definition file
    @{files}=          OperatingSystem.List Files In Directory        C:\\Ericsson\\PMA_Exports\\          
    FOR      ${file}     IN     @{files}
         Log      ${file}
         ${status}    ${msg}=     Run Keyword And Ignore Error     Should contain       ${file}        Alarm Definitions
			     IF      '${status}'=='PASS'
			            ${alarm_rule_file}=       set variable       ${file}
			            Exit for loop
			     END
    END
    ${date}=     Get Current Date
    ${date_string}=     Convert to string     ${date}
    ${ds}=     Replace String	    ${date_string}	   :   	_
    ${ds1}=    Replace String	    ${ds}	   ${SPACE}   	_ 
    ${date_string}=    Replace String	    ${ds1}	   .   	_ 
    ${contents}=      OperatingSystem.Get File        C:\\Ericsson\\PMA_Exports\\${alarm_rule_file}
    Log     ${contents}
    @{lines}=      Split To Lines      ${contents}
    @{values}=   Split String       ${lines}[1]     ,
    ${alarm_name}=      set variable       ${values}[1]
    ${con} =       replace String      ${contents}      ${alarm_name}       import${date_string}
    Log     ${con}
    Create File         C:\\Ericsson\\PMA_Exports\\${alarm_rule_file}          ${con} 
    ${alarm_formula_file}=      replace string     ${alarm_rule_file}      Definitions        Formulas
    ${contents}=      OperatingSystem.Get File        C:\\Ericsson\\PMA_Exports\\${alarm_formula_file} 
    Log     ${contents}
    ${con} =       replace String      ${contents}      ${alarm_name}       import${date_string}
    Log     ${con}  
    Create File         C:\\Ericsson\\PMA_Exports\\${alarm_formula_file}          ${con}    
    [return]      ${alarm_rule_file}
    
    
    

Click on Import Alarm rules
    ${window}=      set variable       Step 3 - Import and Finish
    Navigate to section         ${window}
    sleep    5
    Click element      xpath://input[@value='Import Alarm Rules']
    sleep   2s
    Click on minimise window button     0
    sleep     5s

Validate alarm rule imported is displayed in import result
    ${window}=      set variable       Import Result
    Navigate to section         ${window}
    ${alarm_rule} =        Selenium2library. Get text        xpath://div[@row='1' and @column='0']
    ${status} =        Selenium2library. Get text        xpath://div[@row='1' and @column='1']
    ${msg} =        Selenium2library. Get text        xpath://div[@row='1' and @column='2']
    #Should contain        ${status}       Import Successful
     
Assign nodes/collections to alarm rule
    ${window}=      set variable       Step 2 - Assign Nodes/Collection to Alarm Rules
    Navigate to section         ${window}
    @{element}=    Get WebElements	    xpath://div[@class='ComboBoxTextDivContainer']
    ${data_source}=        Get from list     ${element}    0
    ${Single Node_Collection_SubNetwork}=        Get from list     ${element}    1
    ${Collection}=        Get from list     ${element}    2
    Click element         ${data_source}
    sleep  2s
    Click element        xpath: //div[@title='NetAn_ODBC' and contains(@class,'sf-element-dropdown-list-item')]
    sleep    2s    
    Click element        xpath:(//div[@class='ComboBoxTextDivContainer'])[2]
    sleep  2s
    Click element        xpath: //div[@title='Collection' and contains(@class,'sf-element-dropdown-list-item')]
    sleep    2s          
    Click element         xpath:(//div[@class='ComboBoxTextDivContainer'])[3]
    sleep  2s
    @{element}=    Get WebElements	    xpath: //div[contains(@class,'sf-element-dropdown-list-item')]
    ${collection_name}=        Get from list     ${element}    0
    Click element         ${collection_name}   
    sleep    2s    
    Click element      xpath://input[@value='Assign Nodes/Collection']
    sleep    2s    
    Click on minimise window button     0
    sleep     5s
    
                
          
         
    
Click on any alarm and delete
     Click Element      xpath://div[@row='1' and @column='2']
     sleep    2s
     Click on Deactivate button
     Click on button    Delete
     sleep   2s
     Click element      xpath://span[text()='Delete alarm']
     sleep   5s
     Click on scroll right button    1     10
     ${alarm_state}=       Selenium2Library.Get text      xpath://div[@row='1' and @column='4']
     Should contain        ${alarm_state}          Deleted   

Delete the collection and verify collection is removed
     [Arguments]    ${collName}
     wait for page to load
     Click Element        xpath://div[contains(text(),'${collName}')]
     sleep    5s
     Click on delete button
     sleep   10s
     @{element}=    Get WebElements	    xpath: //div[@row='1' and @column='0']
     ${collection}=        Get from list     ${element}    0
     ${collection_name_new}=      Selenium2library.Get text          ${collection}
     Should not match        ${collName}          ${collection_name_new}
     
Verify the deletion date of alarm is based on the retention period
     [Arguments]      ${period}
     Click on scroll right button    1     150
     ${date}=       Selenium2Library.Get text      xpath://div[@row='1' and @column='13']
     ${ui_date_value}=       Convert date       ${date}        date_format=%m/%d/%Y       result_format=%m/%d/%Y
     Log     ${date} 
     ${curr_date}=      Get Current Date
     ${del_date}=      Add Time To Date	      ${curr_date}       ${period}
     Log     ${del_date}
     ${del_date_value}=      Convert date       ${del_date}        date_format=%Y-%m-%d %H:%M:%S.%f     result_format=%m/%d/%Y
     Log     ${del_date_value}
     Should Match      ${del_date_value}        ${ui_date_value}
     
     
     
        
Click on Deactivate button
     Click Element     xpath://input[@value='Deactivate']
     sleep    5s    

Click on Alarm rules manager button
    Click Element      xpath://input[@value='Alarm Rules Manager']
    wait for page to load
    capture page screenshot
   
Click on Node Collection manager button
    Click Element      xpath://input[@value='Node Collection Manager']
    wait for page to load
    capture page screenshot
    
Click on Fetch sub network button
     ${window}=      set variable       Step 3: Fetch SubNetwork
     Navigate to section         ${window}     
     Click element      xpath://input[@value='Fetch SubNetwork']
     sleep     5s
     wait for page to load
     capture page screenshot
     Click on minimise window button     0
     Sleep     30s
     capture page screenshot
     
wait for page to load
    Sleep   5s
      
    Wait Until Element Is Not Visible     class:sfx_progress-bar-container_1118        timeout=2400
    Sleep   3s
      
    Wait Until Element Is Not Visible     class:sfx_progress-bar-container_1118        timeout=2400
    Sleep   3s 
    
Set up ENM connection
     ${window}=      set variable       Setup ENM Connection
     Navigate to section         ${window} 
     sleep    5s
     Clear Element Text    xpath://input[@id='eff93c4cd0ac4bcd879ea7381f4912f1']
     Selenium2Library.Input Text    xpath://input[@id='eff93c4cd0ac4bcd879ea7381f4912f1']       ieatenm5300-9.athtem.eei.ericsson.se
    
     Clear Element Text    xpath://input[@id='58fc35ed419744b6b884498582a8c2fd']
     Selenium2Library.Input Text    xpath://input[@id='58fc35ed419744b6b884498582a8c2fd']       Administrator
    
     Clear Element Text    xpath://input[@id='934a079597b24cecaf1c5c7ef7093e67']
     Selenium2Library.Input Text    xpath://input[@id='934a079597b24cecaf1c5c7ef7093e67']       TestPassw0rd
    
     Clear Element Text    xpath://input[@id='93a9f653bf3c487fa93da3463d0eb199']
     Selenium2Library.Input Text    xpath://input[@id='93a9f653bf3c487fa93da3463d0eb199']       eniq_oss_1
     sleep     2s
     
     Click element      xpath: //div[@class='ComboBoxTextDivContainer']
     Click element      xpath://div[@title='NetAn_ODBC']    
     
     Click Element      xpath://input[@id='fe705601231145a1b13adaa8b06a78f0']
     sleep      20s
     FOR    ${i}    IN RANGE    0     5
         ${text}=      Selenium2Library.Get Text      xpath://span[@id='ENMConnectionStatus']
         IF    '${text}'=='ENM, ENIQ Connection Already Exsits'
               Exit For Loop
         ELSE IF     '${text}'=='ENM Connection Setup Successful'
               Exit For Loop
         ELSE IF     '${text}'=='please provide Value for: Server Name'
               Selenium2Library.Input Text    xpath://input[@id='eff93c4cd0ac4bcd879ea7381f4912f1']       ieatenm5300-9.athtem.eei.ericsson.se
               
         ELSE IF     '${text}'=='please provide Value for: OSSID'
               Selenium2Library.Input Text    xpath://input[@id='93a9f653bf3c487fa93da3463d0eb199']       eniq_oss_1
               
         ELSE IF     '${text}'=='please provide Value for: ENM USERNAME'
               Selenium2Library.Input Text    xpath://input[@id='58fc35ed419744b6b884498582a8c2fd']       Administrator     
    
         ELSE IF       '${text}'=='please provide Value for: ENM PASSWORD'
               Selenium2Library.Input Text    xpath://input[@id='934a079597b24cecaf1c5c7ef7093e67']       TestPassw0rd 
         ELSE
               Exit For Loop
         END
         Sleep     1s
         Click Element      xpath://input[@id='fe705601231145a1b13adaa8b06a78f0']
         Sleep     10s
    END     
     
     
     
     wait for page to load
     capture page screenshot
     Click on minimise window button     0
     sleep    5s
     wait for page to load
     sleep    5s
    
Delete the connected ENM
    ${window}=      set variable       Connected ENM(s)
    Navigate to section         ${window} 
    Sleep   3s
    Click element      xpath://div[@row='2' and @column='0']
	sleep     3s
	Press Keys      None      ARROW_UP	
	Sleep     3s
    Click on Next Button
    sleep    2s
    Click on Next Button
    sleep    2s
    Click on delete button
    sleep    5s
    Capture page screenshot
    Click on minimise window button     0
    Sleep     5s
    
Verify ENM connection is not available
    ${window}=      set variable       Connected ENM(s)
    Navigate to section         ${window}
    Sleep   3s
    Element Should Not Be Visible        xpath: //div[contains(text(),'athtem.eei.ericsson.se')]
    Click on minimise window button     0
    Sleep     5s

    
    
    
Click on Administration button
    Wait Until Page Contains Element      xpath: //img[@title='Administration']     timeout=1500
    Click element     xpath://img[@title='Administration']
    Sleep    20s
    
Connect to DB and sync with eniq
    [Arguments]     ${eniq_name}=NetAn_ODBC
    Click on Administration button
    Connect to DB     localhost       netanserver      Ericsson01     ${eniq_name}
    Click on Sync with Eniq 

Validate ENIQ connections are displayed
    [Arguments]      ${eniq}
    ${window}=      set variable       ENIQ Connection Status
    Navigate to section         ${window}
    Capture page screenshot
    @{eniq_list}=      Split string         ${eniq}         ,
    FOR    ${eniq_name}    IN    @{eniq_list}
          Element should be visible         xpath://div[text()='${eniq_name}']    
    END
    Click on minimise window button     0
    Sleep     5s
    
    
Select datasource from Eniq connection status and delete
    [Arguments]     ${eniq_name}
    ${window}=      set variable       ENIQ Connection Status
    Navigate to section         ${window}
    Sleep   3s
    Click element       xpath://div[text()='${eniq_name}']/..    
    Sleep    3s
    Click on Next Button
    sleep    2s
    Click on button    Delete
    sleep    5s
    Click element       xpath:(//span[contains(text(),'Delete')])[2]
    sleep    5
    Click element       xpath:(//span[contains(text(),'OK')])
    Capture page screenshot
    Click on minimise window button     0
    Sleep     5s
    
Verify datasource is not available
    [Arguments]     ${eniq_name}
    ${window}=      set variable       ENIQ Connection Status
    Navigate to section         ${window}
    Sleep   3s
    Element Should Not Be Visible        xpath://div[text()='${eniq_name}']
    Click on minimise window button     0
    Sleep     5s
        
    
Click on delete button
    Click element  	    xpath: //input[@value='Delete Collection']
    sleep    5
    Click element  	    xpath://span[contains(text(),'OK')]
    
Click on Next Button
    Click element  	    xpath: //div[@title='Next']
    
Select the Collection type
      [Arguments]     ${data}
      IF     '${data}[Collection_type]'=='Dynamic'
	      ${status}    ${msg}=     Run Keyword And Ignore Error     Element should be visible      xpath://div[@class='sf-element sf-element-check-box flex-item flex-no-shrink flex-align-start sfpc-unchecked']
			     IF      '${status}'=='PASS'
			             Click element       xpath://div[@class='sf-element sf-element-check-box flex-item flex-no-shrink flex-align-start sfpc-unchecked']
			             sleep      3s
			             click on scroll down button    0    15
			             Selenium2library.Input text      xpath://span[@id='WildcardExpression2']//input        ${data}[WildcardExpression]
			     END
      ELSE IF        '${data}[Collection_type]'=='Static'
          ${status}    ${msg}=     Run Keyword And Ignore Error     Element should be visible      xpath://div[@class='sf-element sf-element-check-box flex-item flex-no-shrink flex-align-start sfpc-checked']
			     IF      '${status}'=='PASS'
			             Click element       xpath://div[@class='sf-element sf-element-check-box flex-item flex-no-shrink flex-align-start sfpc-checked']
			
			     END
      END
      
Click on collection       
      [Arguments]       ${collection_name}
      Sleep     10s
      Mouse Over      xpath://div[text()='CollectionName']
      ${count}=     Get Element count       xpath : //div[@column='0']
      FOR    ${i}    IN RANGE    1     ${count}
           ${name}=     Selenium2library.Get text      xpath://div[@row='${i}' and @column='0']
           IF    '${name}'=='${collection_name}'
                Click element      xpath://div[@row='${i}' and @column='0']
                exit for loop
                sleep     5s
           END
      END
      
Click on Apply changes button
      sleep     10s
      Wait Until Element Is Enabled          xpath://input[@value='Apply Changes']      timeout=120s        
      Click element      xpath://input[@value='Apply Changes']
      sleep    20s
      Capture page screenshot
      
Click on Edit button
      sleep     10s
      Wait Until Element Is Enabled          xpath://input[@value='Edit']      timeout=120s        
      Click element      xpath://input[@value='Edit']
      sleep    20s

Click on Edit collection button
      sleep     10s
      Wait Until Element Is Enabled          xpath://input[@value='Edit Collection']      timeout=120s        
      Click element      xpath://input[@value='Edit Collection']
      sleep    2s      
   
Verify collection is displayed in collection manager UI
      [Arguments]     ${data}       ${collection_name}
      Sleep     10s
      Mouse Over      xpath://div[text()='CollectionName']
      Click on maximise window button       0
      sleep      5s
      ${status}=     set variable      FAIL
      ${count}=     Get Element count       xpath : //div[@column='0']
      Mouse Over      xpath://div[text()='CollectionName']
      click on scroll up button    0    50
      FOR    ${i}    IN RANGE    1     ${count}
           ${name}=     Selenium2library.Get text      xpath://div[@row='${i}' and @column='0']
           IF    '${name}'=='${collection_name}'
                ${status}=     set variable      PASS
                ${node_type}=      Selenium2library.Get text      xpath://div[@row='${i}' and @column='1']
                ${sys_area}=      Selenium2library.Get text      xpath://div[@row='${i}' and @column='2']
                ${eniq_name}=      Selenium2library.Get text      xpath://div[@row='${i}' and @column='4']
                ${collection_type}=      Selenium2library.Get text      xpath://div[@row='${i}' and @column='5']
                Should match      ${node_type}       ${data}[Node_type]
                Should match      ${sys_area}       ${data}[System_area]
                Should match      ${eniq_name}       ${data}[ENIQ_data_source]
                Should match      ${collection_type}       ${data}[Collection_type]
                Exit For Loop
           END
       END
       IF    '${status}'=='FAIL'
             FAIL      msg=Collection not found in UI
       END
             
    
Connect to DB 
    [Arguments]      ${url_value}      ${username_value}        ${password_value}      ${Eniq_DB_Value}      
    ${window}=      set variable       Setup Data Source
    
    Navigate to section         ${window} 
    sleep     10s
    @{element}=    Get WebElements	    xpath: //input[@class='sf-element sf-element-control sfc-property sfc-text-box']
    ${name}=        Get from list     ${element}    0
    ${username}=        Get from list     ${element}    1
    ${password}=        Get from list     ${element}    2
    ${eniqs}=        Get from list     ${element}    3
    Selenium2Library.Input Text    ${name}       ${url_value}
    Sleep     1s
    Selenium2Library.Input Text    ${username}       ${username_value}
    Sleep     1s
    Selenium2Library.Input Text    ${password}       ${password_value} 
    Sleep     1s
    Click element     xpath: //input[@id='531c6c74f6484fa094d9e8a3b53c1283']
    Sleep     10s
    FOR    ${i}    IN RANGE    0     5
         ${text}=      Selenium2Library.Get Text      xpath://span[@id='NetAnResponse']
         IF    '${text}'=='OK'
               Exit For Loop
         ELSE IF     '${text}'=='please provide Value for: NetAn SQL DB URL'
               Selenium2Library.Input Text    ${name}       ${url_value}
               
         ELSE IF     '${text}'=='please provide Value for: NetAn User Name'
               Selenium2Library.Input Text    ${username}       ${username_value}     
    
         ELSE IF       '${text}'=='please provide Value for: NetAn Password'
               Selenium2Library.Input Text    ${password}       ${password_value}  
         END
         Sleep     1s
         Click element     xpath: //input[@id='531c6c74f6484fa094d9e8a3b53c1283']
         Sleep     10s
    END     
    
    FOR    ${i}    IN RANGE    0     5
          Clear Element Text      ${eniqs}
          Selenium2Library.Input Text    ${eniqs}       ${Eniq_DB_Value} 
          
    END 
    
    Click element     xpath: //input[@id='f04c63c1f5dd4ea5b9b1179fa3b26a55']
    
    Sleep    20s
    wait for page to load
    sleep   5s
    capture page screenshot
    Click on minimise window button     0
    Sleep     10s
    
Click on Sync with Eniq  
    ${window}=      set variable       Step 2: Sync With ENIQ
    Navigate to section         ${window} 
    sleep    10s
	Run keyword and ignore error        Click on scroll down button       5         1
	Sleep       2s
    Click element     xpath: //input[@value='Sync with ENIQ']
    sleep    80s
    wait for page to load
    Sleep     5s
    Click on minimise window button     0
    Sleep     10s
    
Click on scroll down button
    [Arguments]  ${button}    ${n}
    Wait Until Page Contains Element      xpath: //div[@class='ScrollbarButton sf-element sf-element-scroll-bar-button sfpc-bottom']     timeout=120
    @{element}=    Get WebElements	    xpath: //div[@class='ScrollbarButton sf-element sf-element-scroll-bar-button sfpc-bottom']
    ${scroll_button}=        Get from list     ${element}    ${button}
    ${status}    ${msg}=     Run Keyword And Ignore Error     Element should be visible      ${scroll_button}
			     IF      '${status}'=='PASS'
			             FOR    ${i}    IN RANGE    0    ${n} 
                               Click element     ${scroll_button}
                         END
			     END
    

Click on scroll left button
    [Arguments]  ${button}    ${n}
    Wait Until Page Contains Element      xpath: //div[@class='ScrollbarButton sf-element sf-element-scroll-bar-button sfpc-left']     timeout=120
    @{element}=    Get WebElements	    xpath: //div[@class='ScrollbarButton sf-element sf-element-scroll-bar-button sfpc-left']
    ${scroll_button}=        Get from list     ${element}    ${button}
    FOR    ${i}    IN RANGE    0    ${n} 
           Click element     ${scroll_button}
           
    END  
	
Click on scroll right button
    [Arguments]  ${button}    ${n}
    Wait Until Page Contains Element      xpath: //div[@class='ScrollbarButton sf-element sf-element-scroll-bar-button sfpc-right']     timeout=120
    @{element}=    Get WebElements	    xpath: //div[@class='ScrollbarButton sf-element sf-element-scroll-bar-button sfpc-right']
    ${scroll_button}=        Get from list     ${element}    ${button}
    ${status}    ${msg}=     Run Keyword And Ignore Error     Element should be visible      ${scroll_button}
			     IF      '${status}'=='PASS'
			             FOR    ${i}    IN RANGE    0    ${n} 
                               run keyword and ignore error    Click element     ${scroll_button}
                         END
			     END   
  
Click on maximise window button
    [Arguments]  ${button}
    @{element}=    Get WebElements	    xpath: //div[@title='Maximize visualization']
    ${max_button}=        Get from list     ${element}     ${button}
    Click element     ${max_button}

    
Click on minimise window button
    [Arguments]  ${button}
    @{element}=    Get WebElements	    xpath: //div[@title='Restore visualization layout']
    ${min_button}=        Get from list     ${element}     ${button}
    Click element     ${min_button}
    
Click on Create button
    Wait Until Element Is Visible     xpath: //input[@value='Create']    300
    Click element     xpath: //input[@value='Create']

Click on Create collection button
	Wait Until Element Is Visible     xpath: //input[@value='Create Collection']    300
	Click element     xpath: //input[@value='Create Collection']
	
Enter alarm name
    [Arguments]     ${alarm_name}
    Wait Until Element Is Visible     xpath: //input[@class='sf-element sf-element-control sfc-property sfc-text-box']    300
    @{element}=    Get WebElements	    xpath: //input[@class='sf-element sf-element-control sfc-property sfc-text-box']
    ${ele}=        Get from list     ${element}     0
    Clear Element Text     ${ele}
    Selenium2Library.Input Text      ${ele}      ${alarm_name}
    sleep    2s
    Clear Element Text     ${ele}
    Selenium2Library.Input Text      ${ele}      ${alarm_name}
 
Enter Collection name
    [Arguments]     ${collection_name}
    ${date}=     Get Current Date
    ${date_string}=     Convert to string     ${date}
    ${ds}=     Replace String	    ${date_string}	   :   	_
    ${ds1}=    Replace String	    ${ds}	   ${SPACE}   	_ 
    ${date_string}=    Replace String	    ${ds1}	   .   	_ 
    Log      ${collection_name}${date_string}
    Wait Until Element Is Visible     xpath: //input[@class='sf-element sf-element-control sfc-property sfc-text-box']    300
    @{element}=    Get WebElements	    xpath: //input[@class='sf-element sf-element-control sfc-property sfc-text-box']
    ${ele}=        Get from list     ${element}     0
    Clear Element Text     ${ele}
    Selenium2Library.Input Text      ${ele}      ${collection_name}${date_string}
    sleep    2s
    Clear Element Text     ${ele}
    Selenium2Library.Input Text      ${ele}      ${collection_name}${date_string}
    [return]      ${collection_name}${date_string}  

Prepare alarm name
    [Arguments]     ${alarm_name}
    ${date}=     Get Current Date
    ${date_string}=     Convert to string     ${date}
    ${ds}=     Replace String	    ${date_string}	   :   	_
    ${ds1}=    Replace String	    ${ds}	   ${SPACE}   	_ 
    ${date_string}=    Replace String	    ${ds1}	   .   	_ 
    Log      ${alarm_name}${date_string}
    [return]      ${alarm_name}${date_string}
    
    
Select alarm type as
    [Arguments]     ${alarm_type}
    Wait Until Element Is Visible      xpath: //div[@class='ComboBoxTextDivContainer']     300
    @{element}=    Get WebElements	    xpath: //div[@class='ComboBoxTextDivContainer']
    ${alarm_type_ele}=        Get from list     ${element}    0
    Click element     ${alarm_type_ele}
    Click element      xpath://div[@title='${alarm_type}']     
    
Select ENIQ Data Source as
    [Arguments]     ${data_source}
    sleep    3s
    @{element}=    Get WebElements	    xpath: //div[@class='ComboBoxTextDivContainer']
    ${data_source_ele}=        Get from list     ${element}    1
    Click element     ${data_source_ele}
    Click element      xpath://div[@title='${data_source}']  
    wait for page to load	
    
Select Single node or Collection or Subnetwork
    [Arguments]     ${selection}
    Wait Until Page Contains Element      xpath:(//div[@class="ComboBoxTextDivContainer"])[3]    150
    Click element     xpath:(//div[@class="ComboBoxTextDivContainer"])[3]
    sleep    2
    Click element      xpath://div[@title='${selection}']     
    wait for page to load
    capture page screenshot       
    
Select System area as
    [Arguments]     ${sys_area}
    Click on scroll down button    3      12
    sleep     3s
    @{element}=    Get WebElements	    xpath: //div[@class='ComboBoxTextDivContainer']
    ${sys_area_ele}=        Get from list     ${element}    4
    Click element     ${sys_area_ele}
    Click element      xpath://div[@title='${sys_area}'] 
  
Select Collection name as
    [Arguments]      ${collection}    
    Click on scroll down button    3      12
    sleep     3s
    @{element}=    Get WebElements	    xpath: //div[@class='ComboBoxTextDivContainer']
    ${sys_area_ele}=        Get from list     ${element}    3
    Click element     ${sys_area_ele}
    Click element      xpath://div[@title='${collection}'] 
    
Select System area for subnetwork as
    [Arguments]     ${sys_area}
    Click on scroll down button    3      12
    sleep     3s
    @{element}=    Get WebElements	    xpath: //div[@class='ComboBoxTextDivContainer']
    ${sys_area_ele}=        Get from list     ${element}    6
    Click element     ${sys_area_ele}
    Click element      xpath://div[@title='${sys_area}']  
    
Select Node type as
    [Arguments]     ${node_type}
    Sleep      10s
    @{element}=    Get WebElements	    xpath: //div[@class='ComboBoxTextDivContainer']
    ${node_type_ele}=        Get from list     ${element}    5
    Click element     ${node_type_ele}
    ${count}=   Get Element Count      xpath://div[@title='${node_type}'] 
    IF    ${count}==0
         Click on scroll down button     7    8  
         ${count}=   Get Element Count      xpath://div[@title='${node_type}']
         IF    ${count}==0
              Click on scroll down button     7    8  
              ${count}=   Get Element Count      xpath://div[@title='${node_type}']
         END
         ${count}=   Get Element Count      xpath://div[@title='${node_type}']
	         IF    ${count}==0
	              Click on scroll down button     7    8  
	              ${count}=   Get Element Count      xpath://div[@title='${node_type}']
	         END
    END						  
    Click element      xpath://div[@title='${node_type}']    

Select Node type for subnetwork as
    [Arguments]     ${node_type}
    Sleep      10s
    @{element}=    Get WebElements	    xpath: //div[@class='ComboBoxTextDivContainer']
    ${node_type_ele}=        Get from list     ${element}    7
    Click element     ${node_type_ele}
    Click element      xpath://div[@title='${node_type}']     
    
Select Measure type as
    [Arguments]     ${measure_type}
    Sleep      10s
    click on the 4th scroll up button    20
    @{element}=    Get WebElements	    xpath: //div[@class='ComboBoxTextDivContainer']
    ${measure_type_ele}=        Get from list     ${element}    8
    Click element     ${measure_type_ele}
    Click element      xpath://div[@title='${measure_type}']    
    
Click on fetch nodes button
    Click element     xpath: //input[@value='Fetch nodes']
    Sleep     20s    
    
    
Select Nodes as
    [Arguments]    @{node_list}
    Click on scroll down button     3    5
    FOR    ${node}    IN    @{node_list}
           Clear Element Text      xpath://tr[@class='singleNode']//span[@class='HtmlTextAreaControl sf-element sf-element-filter-content']//input
           Selenium2Library.Input Text          xpath://tr[@class='singleNode']//span[@class='HtmlTextAreaControl sf-element sf-element-filter-content']//input    ${node} 
           press key           xpath://tr[@class='singleNode']//span[@class='HtmlTextAreaControl sf-element sf-element-filter-content']//input     \\13
           sleep    5s
		   Wait Until Element Is Visible      xpath://div[@title='${node}']     60
           Click element      xpath://div[@title='${node}']      
           sleep   1s
           
     END    

Select Subnetwork as
    [Arguments]    ${subnetwork}
    Click on scroll down button     3    5
    Clear Element Text      xpath://tr[@class='subnetwork']//span[@class='HtmlTextAreaControl sf-element sf-element-filter-content']//input
    Selenium2Library.Input Text          xpath://tr[@class='subnetwork']//span[@class='HtmlTextAreaControl sf-element sf-element-filter-content']//input    ${subnetwork} 
    press key           xpath://tr[@class='subnetwork']//span[@class='HtmlTextAreaControl sf-element sf-element-filter-content']//input     \\13
    sleep    5s
	Wait Until Element Is Visible      xpath://div[@title='${subnetwork}']     60
    Click element      xpath://div[@title='${subnetwork}']      
    sleep   1s

 Select Nodes in collection manager
    [Arguments]    ${nodes}
    @{node_list}=      Split string         ${nodes}         ,
    
    FOR    ${node}    IN    @{node_list}
		   @{element}=    Get WebElements	    xpath: //div[@class='sf-list-box-container VirtualListBox sf-suppress-forms-accept-command sf-suppress-forms-cancel-command sf-focusable']//input
		   ${search_box}=        Get from list     ${element}    0
           Clear Element Text      ${search_box}
           sleep      2s
           @{element}=    Get WebElements	    xpath: //div[@class='sf-list-box-container VirtualListBox sf-suppress-forms-accept-command sf-suppress-forms-cancel-command sf-focusable']//input
		   ${search_box}=        Get from list     ${element}    0
           Selenium2Library.Input Text          ${search_box}      ${node} 
           press key           ${search_box}     \\13
           sleep    5s
		   Wait Until Element Is Visible      xpath://div[@title='${node}']     60
           Click element      xpath://div[@title='${node}']    
           sleep   1s
           Click element      xpath://input[@value='Add >>']     
           sleep   2s 
     END 
    
Click on scroll up button
    [Arguments]  ${button}    ${n}
    @{element}=    Get WebElements	    xpath: //div[@class='ScrollbarButton sf-element sf-element-scroll-bar-button sfpc-top']
    ${scroll_button}=        Get from list     ${element}    ${button}
    FOR    ${i}    IN RANGE    0    ${n} 
           Click element     ${scroll_button}
           
    END    
    
Select measures
    [Arguments]    ${measure_list}
    @{list}=      Split string      ${measure_list}    ,
    FOR    ${measure}    IN    @{list}
           Clear Element Text      xpath://h3[text()='Measure Details']/..//div[@class='sf-list-box-container VirtualListBox sf-suppress-forms-accept-command sf-suppress-forms-cancel-command sf-focusable']//input
           Selenium2Library.Input Text     xpath://h3[text()='Measure Details']/..//div[@class='sf-list-box-container VirtualListBox sf-suppress-forms-accept-command sf-suppress-forms-cancel-command sf-focusable']//input     ${measure} 
           press key      xpath://h3[text()='Measure Details']/..//div[@class='sf-list-box-container VirtualListBox sf-suppress-forms-accept-command sf-suppress-forms-cancel-command sf-focusable']//input     \\13
           sleep    5s
		   Wait Until Element Is Visible      xpath://div[contains(@title,'${measure}')]        60
		   ${status}    ${msg}=     Run Keyword And Ignore Error     Element should be visible      xpath://div[@title='${measure}'] 
			     IF      '${status}'=='PASS'
			            Click element      xpath://div[@title='${measure}']  
			     ELSE
			            Click element      xpath://div[contains(@title,'${measure}')]  
			     END
		   
		   
               
           sleep   1s
           Click element      xpath://input[@value='Add Measure'] 
           sleep   1s
     END
     
Verify data integrity of measures
        [Arguments]    ${measure_list}     ${sql1}     ${sql2}     ${sql3}     ${sql4} 
        @{list}=      Split string      ${measure_list}    ,
        ${count}=     set variable    1
        ${date_id}=        Get cell value     DATE_ID      1
        @{date}=      Split string      ${date_id}
        ${date_value}=      Get from list     ${date}    0
        ${moid}=        Get cell value     MOID      1
        Click on scroll right button     0     50
        FOR    ${measure}    IN    @{list}
            ${measure_value}=     Get cell value     MEASUREVALUE_${count}      1
            Log       ${measure_value}
            ${db_value}=      Query ENIQ database for kpiValue     ${sql${count}}      ${date_value}       ${moid}     
            Log        ${db_value}
            Should Contain        ${db_value}      ${measure_value}      
        END 
        
    
Select Alarm severity as
    [Arguments]     ${alarm_severity}
    Sleep      10s
    @{element}=    Get WebElements	    xpath: //div[@class='ComboBoxTextDivContainer']
    ${measure_type_ele}=        Get from list     ${element}    9
    Click element     ${measure_type_ele}
    Click element      xpath://div[@title='${alarm_severity}']     
    
Select Aggregation as
    [Arguments]     ${aggregation}
    Sleep      10s
    @{element}=    Get WebElements	    xpath: //div[@class='ComboBoxTextDivContainer']
    ${measure_type_ele}=        Get from list     ${element}    10
    Click element     ${measure_type_ele}
    Click element      xpath://div[@title='${aggregation}']        
    
Select Probable cause as
    [Arguments]     ${probable_cause}
    Sleep      10s
    @{element}=    Get WebElements	    xpath: //div[@class='ComboBoxTextDivContainer']
    ${measure_type_ele}=        Get from list     ${element}    14
    Click element     ${measure_type_ele}
    Click element      xpath://div[@title='${probable_cause}']     
    
Select Look back period unit as
    [Arguments]     ${look_back_period_unit}
    Sleep      10s
    @{element}=    Get WebElements	    xpath: //div[@class='ComboBoxTextDivContainer']
    ${ele}=        Get from list     ${element}    11
    Click element     ${ele}
    Click element      xpath://div[@title='${look_back_period_unit}'] 
    sleep    2s
    
Select Date range unit as
    [Arguments]     ${date_range_unit}
    Sleep      10s
    @{element}=    Get WebElements	    xpath: //div[@class='ComboBoxTextDivContainer']
    ${ele}=        Get from list     ${element}    12
    Click element     ${ele}
    Click element      xpath://div[@title='${date_range_unit}'] 
    sleep   2s  
    
Enter Look back period
    [Arguments]     ${look_back_period}
    @{element}=    Get WebElements	    xpath: //input[@class='sf-element sf-element-control sfc-property sfc-text-box']
    ${ele}=        Get from list     ${element}     1
    Clear Element Text     ${ele}
    sleep    2s
    Selenium2Library.Input Text      ${ele}      ${look_back_period}
    
Enter Date range
    [Arguments]     ${date_range}
    @{element}=    Get WebElements	    xpath: //input[@class='sf-element sf-element-control sfc-property sfc-text-box']
    ${ele}=        Get from list     ${element}     2
    Clear Element Text     ${ele}
    sleep    2s
    Selenium2Library.Input Text      ${ele}      ${date_range}
    
Enter specific problem
    [Arguments]     ${specific_problem}      ${alarm_name}=NA
    Clear Element Text       xpath://textarea[@class='sf-element sf-element-control sfc-property sfc-text-box']    
    Selenium2Library.Input Text      xpath://textarea[@class='sf-element sf-element-control sfc-property sfc-text-box']       ${alarm_name}-${specific_problem}
    
Click on Apply alarm template button
    Click element     xpath: //input[@value='Apply Alarm Template']
    Sleep     20s 
    
Verify alarm title
    [Arguments]     ${alarm_name}  
    ${text}=    Selenium2Library.Get Text   class:sf-root
    Log    ${text}
    Should contain    ${text}    ${alarm_name}
   
Verify columns displayed
    [Arguments]     @{colums_list}
    FOR    ${col}    IN    @{colums_list}
        Element Should Be Visible     xpath://div[text()='${col}']      
    END 
    Capture page screenshot
    
Click on Save button
    Click element     xpath: //input[@value='Save']
    Sleep     30s 
    wait for page to load
    Capture page screenshot
    
Click on Cancel button
    Click element     xpath: //input[@value='Cancel']
    Sleep     30s 
    wait for page to load

Verify edited nodes displayed for collection
    [Arguments]     ${nodes}
    Wait Until Page Contains Element      xpath://div[text()='${nodes}']     timeout=120
    Element Should Be Visible       xpath://div[text()='${nodes}']
    
 Activate the alarm
    [Arguments]     ${alarm_name}
    Click element     xpath: //div[text()='${alarm_name}']
    Sleep     2s 
    Click element     xpath: //input[@value='Activate']
    Sleep    300s
    Capture page screenshot
    
Verify alarm displayed in UI
    [Arguments]     ${alarm_name} 
    Mouse Over      xpath://div[text()='MeasuresName']
    sleep    2s
    Click on scroll left button    1     30
    sleep    2s
    Click on scroll down button    1     200
    Element Should Be Visible     xpath://div[text()='${alarm_name}']
    Capture page screenshot
    
Select Alarm
    [Arguments]     ${alarm_name} 
    Mouse Over      xpath://div[text()='MeasuresName']
    sleep    2s
    Click on scroll left button    1     30
    sleep    2s
    Click on scroll down button    1     200
    
    Click element     xpath://div[text()='${alarm_name}']
    Capture page screenshot

Verify specific problem is changed
    [Arguments]     ${alarm_name}          ${specific_problem}
    Mouse Over      xpath://div[text()='MeasuresName']
    sleep    2s
    Click on scroll left button    1     50
    sleep    2s
    Click on scroll down button    1     200
    Click element     xpath://div[text()='${alarm_name}']
    ${row}=       Get Element Attribute            xpath://div[text()='${alarm_name}']/..       row
    Click on scroll right button    1     50
    ${sp}=      Get cell value        SpecificProblem        ${row}
    Should contain        ${sp}          ${specific_problem}
    Should contain        ${sp}          ${alarm_name}
    Capture page screenshot
   
Verify alarm is not displayed in UI
    [Arguments]     ${alarm_name} 
    Mouse Over      xpath://div[text()='MeasuresName']
    sleep    2s
    Click on scroll left button    1     30
    sleep    2s
    Click on scroll down button    1     200
    Element Should Not Be Visible     xpath://div[text()='${alarm_name}']
    Capture page screenshot
    
    
Verify alarm state in DB 
     [Arguments]     ${alarm_name}    ${alarm_state}
     ${sql}=    set variable    select "AlarmState" from "tblAlarmDefinitions" where "AlarmName"='${alarm_name}'
     ${results}=  Query Postgre database and return output     ${sql}
     ${value}=    Get From List    ${results}     0
     Should contain    ${value}      ${alarm_state}
     
Verify alarm in DC_Z_ALARM_NETAN_RAW
     [Arguments]     ${alarm_name}     ${alarm_criteria}
     ${sql}=    set variable    select AlarmName from DC_Z_ALARM_NETAN_RAW where AlarmName='${alarm_name}'
     ${results}=     Query Sybase database     ${sql}
     ${str_value}=     Convert to string       ${results}[0]
     IF     ${alarm_criteria}==1
           Should contain    ${str_value}      ${alarm_name} 
     ELSE  
           Should Be Empty      ${results}
     END   
       
Verify alarm generated in ENM
     [Arguments]     ${alarm_name}    ${node}     ${probable_cause}     ${alarm_criteria}
	 IF     ${alarm_criteria}==1
		 Login to ENM 
		 Click element     xpath: //a[@title='Launch Alarm Monitor (FM)']
		 Sleep    5s
		 ${count}=     Get Element Count     xpath: //span[text()='Add Topology Data']
		 IF    ${count}==0
		       Click element     xpath: //button[@title='Network']
		 END    
		 Sleep    3s
		 Click element     xpath: //span[text()='Add Topology Data']
		 Sleep    3s
		 Click element     xpath: //div[text()='Search']
		 Sleep    3s
		 Selenium2Library.Input text        xpath://input[@name='criteria']    ${node}
		 Sleep    2s
		 Click element     xpath: //button[@class='elNetworkExplorerLib-rSimpleSearch-form-searchBtn ebBtn ebBtn_color_darkBlue']
		 Sleep    5s
		 @{element}=    Get WebElements	    xpath: //input[@class='ebCheckbox']
		 ${ele}=        Get from list     ${element}     0
		 Click element     ${ele}
		 Sleep    2s
		 Click element     xpath://span[text()='Add']
		 Sleep    5s
		 @{element}=    Get WebElements	    xpath: //input[@class='ebInput eaAlarmviewer-nodeList-searchPanel-inputTextbox']
         ${ele}=        Get from list     ${element}     0
         Selenium2library.Input text        ${ele}         ${node}
         sleep    3s
         @{element}=    Get WebElements	    xpath: //button[text()='Find' and @class='ebBtn eaAlarmviewer-nodeList-searchPanel-find']
         ${ele}=        Get from list     ${element}     0
         Click element       ${ele}
         sleep     2s
		 Click element      xpath: //span[@class='eaAlarmviewer-nodeSelection-table-textMatched_current' and text()='${node}']
		 Click element     xpath://button[text()='Apply']
		 Sleep    5s
		 Click element     xpath://span[text()='All']
		 Sleep    5s
		 @{element}=    Get WebElements	    xpath: //tr[@class='ebTableRow elTablelib-row']
		 FOR    ${ele}    IN    @{element}
		     ${text}=    Selenium2Library.Get Text   ${ele}
		     Log    ${text} 
		     ${status}    ${msg}=     Run Keyword And Ignore Error     Should contain    ${text}      ${alarm_name}
		     IF      '${status}'=='PASS'
		             Should contain    ${text}      ${node}
		             Should contain    ${text}      ${probable_cause}
		             Exit for loop
		     END
		 END 
		 IF      '${status}'=='FAIL'   
		          FAIL     Alarm ${alarm_name} is not available in ENM
		 END 
		 Capture page screenshot  
    END
     
	 
	 
Login to ENM   
     Go To     ${enm_url}
     sleep    5s
	 Click element     id:loginNoticeOk
	 Selenium2Library.Input text       id:loginUsername     Administrator
	 Selenium2Library.Input text       id:loginPassword     TestPassw0rd
	 Click element     id:submit
	 sleep    3s
	 Click element     id:continueButton
	 Sleep    10s  
	
Verify worker files are scheduled for PM Alarm
     [Arguments]     ${worker_file}
         
     Go To    ${base_url}${scheduling_and_routing}
     Sleep    5s
     @{element}=    Get WebElements	    xpath: //tr[@class='tss-table-row-item ']
     FOR    ${ele}    IN    @{element}
         ${text}=    Selenium2Library.Get Text   ${ele}
         Log    ${text} 
         ${status}    ${msg}=     Run Keyword And Ignore Error     Should contain    ${text}      ${worker_file}
         IF      '${status}'=='PASS' 
                 Exit for loop
         END
     END 
     IF      '${status}'=='FAIL'   
                 Schedule worker file for PM_ALARM     ${worker_file}
     END    
     
Schedule worker file for PM_ALARM
     [Arguments]     ${workerfile}
     Log      ${workerfile}
     @{element}=    Get WebElements	    xpath: //button[@id='tss-dropdown-menu']
     ${create_rule}=        Get from list     ${element}     0
     ${next}=        Get from list     ${element}     3
     ${ok}=        Get from list     ${element}     8
     ${save1}=      Get from list     ${element}     16
     ${save2}=      Get from list     ${element}     6
     Click element    ${create_rule}
     Click element    ${next}
     Click element    xpath://input[@placeholder='Analysis file']
     sleep    3s
     @{element}=    Get WebElements	    xpath: //input[@class='ng-pristine ng-untouched ng-valid ng-empty']
     ${ele}=        Get from list     ${element}     3
     Click element     ${ele}
     sleep    2s
     @{element}=    Get WebElements	    xpath: //input[@placeholder='Search']
     ${ele}=        Get from list     ${element}     0
     Selenium2Library.Input text      ${ele}     ${workerfile}
     Sleep    3s
     Click element     xpath://span[@title='${workerfile}']
     Click element     ${ok}
     @{element}=    Get WebElements	    xpath: //label[@class='tss-radiobutton--text ng-binding' and text()='Use custom schedule']
     
     ${custom_schedule}=        Get from list     ${element}     0
     Scroll Element Into View     ${custom_schedule}
     Click element     ${custom_schedule}
     sleep    3s
     @{element}=    Get WebElements	    xpath: //input[@placeholder='HH:MM']
     ${ele1}=        Get from list     ${element}     0
     ${ele2}=        Get from list     ${element}     1
     Selenium2Library.Input text      ${ele1}     00:03
     Selenium2Library.Input text      ${ele2}      00:03 
     @{element}=    Get WebElements	    xpath: //input[@type='number']
     ${ele}=        Get from list     ${element}     9
     Selenium2Library.Input text      ${ele}      5
     
     @{element}=    Get WebElements	    xpath: //div[@id='select-box']
     ${ele}=        Get from list     ${element}     7
     Click element       ${ele}
     sleep     2s
     @{element}=    Get WebElements	    xpath: //div[@title='minutes']
     ${ele}=        Get from list     ${element}     1
     Click element       ${ele}
     sleep   2s
     Click element       ${save1}
     sleep   2s
     Click element       ${save2}
     sleep    5s
     Verify worker files are scheduled for PM Alarm     ${workerfile}
    
     
Get cell value 
    [Arguments]  ${col}    ${row}
    ${count}=     set variable    0
    @{element}=    Get WebElements	    xpath://div[@name='valueCellCanvas' or @name='frozenRowsCanvas']//div[@row='0']
    FOR    ${ele}    IN    @{element}
        ${text}=    Selenium2Library.Get Text   ${ele}
		Log      ${text}
        ${cell_value}=    Run Keyword And Return If     "${text}" == "${col}"     Selenium2Library.Get Text  xpath://div[@name='valueCellCanvas' or @name='frozenRowsCanvas']//div[@row='${row}' and @column='${count}']     
        Run Keyword If     "${text}" == "${col}"    exit for loop  
        ${count}=   Evaluate    ${count} + 1             
        
    END
    Log     ${cell_value} 
    [return]  ${cell_value}    
   
Verify alarm criteria
     ${criteria}=     set variable     0
     place the cursor on    MOID
	 Click on scroll right button     0     50
     FOR    ${i}    IN RANGE    1     100
         ${count}=     Get Element Count     xpath://div[@name='valueCellCanvas' or @name='frozenRowsCanvas']//div[@row='${i}']
	     IF    ${count}==0
	           Exit For Loop
	     ELSE
	           ${criteria}=    Get cell value     ALARM_CRITERIA    ${i} 
	           IF     '${criteria}'=='1'
	                Exit for loop
	           ELSE
	                ${criteria}=     set variable     0
	           END      
	          
	     END 
	 END    
     capture page screenshot	 
	 [return]      ${criteria}
         
Validate specific problem error message in client          
	[Arguments]    ${errorMessage}		${expectedErrorMessage}
	should contain    ${errorMessage}    ${expectedErrorMessage}
	capture page screenshot

Select the alarm type
    [Arguments]     ${alarm_type}
    Wait Until Element Is Visible      xpath:(//div[@class='ComboBoxTextDivContainer'])[1]     300
    Click element    xpath:(//div[@class='ComboBoxTextDivContainer'])[1]
    sleep    2
    Click element      xpath://div[@title='${alarm_type}']
	
verify that the button is visible
	[Arguments]    ${button}
	element should be visible    xpath://*[@value="${button}"]
	wait for page to load
	capture page screenshot
	
validate that the button is visible
	[Arguments]    ${button}
	element should be visible    xpath://*[@title="${button}"]
	wait for page to load
	capture page screenshot   
    
Connect to the DB
    [Arguments]     ${eniq_name}
    Click on Administration button
    Connect to DB     localhost       netanserver      Ericsson01     ${eniq_name}
    wait for page to load
	capture page screenshot    
    
verify that the connection to ENIQ is made    
    ${status}=    Selenium2library.get text    xpath:(//table[@id="admin-table"])//tbody//tr[3]//td[6]//span
    Log    ${status}
    should be equal    ${status}    Connected
    wait for page to load
	capture page screenshot
    
read the schedule value
	${value}=    selenium2library.get text    xpath:(//div[@class="sf-element-table-cell flex-justify-end flex-align-start \ sfc-value-cell sfpc-odd-column sfpc-odd-row"])[1]//div
	Log    ${value}
	[Return]    ${value}
	wait for page to load
	capture page screenshot   
    
open the worker analysis file
	Open chrome browser
    Go To    ${base_url}   
    Sleep    5
    Selenium2Library.Input Text    name:username    Administrator
    Selenium2Library.Input Text    name:password    Ericsson01
    Selenium2Library.Click element    class:LoginButton
    Sleep    5
    Go To    ${base_url}${workerAnalysis_2A}
    wait for page to load
    capture page screenshot   
    
enter the server details and connect to it
	Clear Element Text    xpath:(//input[@class="sf-element sf-element-control sfc-property sfc-text-box"])[1]
    Selenium2Library.Input Text    xpath:(//input[@class="sf-element sf-element-control sfc-property sfc-text-box"])[1]       localhost
    sleep    2
    Clear Element Text    xpath:(//input[@class="sf-element sf-element-control sfc-property sfc-text-box"])[2]
    Selenium2Library.Input Text    xpath:(//input[@class="sf-element sf-element-control sfc-property sfc-text-box"])[2]       netanserver
    sleep    2
    Clear Element Text    xpath:(//input[@class="sf-element sf-element-control sfc-property sfc-text-box"])[3]
    Selenium2Library.Input Text    xpath:(//input[@class="sf-element sf-element-control sfc-property sfc-text-box"])[3]       Ericsson01
    sleep    2
    Click element     xpath://input[@value="Connect "]
    Sleep     5
    FOR    ${i}    IN RANGE    0     5
         ${text}=      Selenium2Library.Get Text      xpath://span[@id='NetAnResponse']
         IF    '${text}'=='OK'
               Exit For Loop
         ELSE IF     '${text}'=='please provide Value for: NetAn SQL DB URL'
               Selenium2Library.Input Text    xpath:(//input[@class="sf-element sf-element-control sfc-property sfc-text-box"])[1]       localhost
               
         ELSE IF     '${text}'=='please provide Value for: NetAn User Name'
               Selenium2Library.Input Text    xpath:(//input[@class="sf-element sf-element-control sfc-property sfc-text-box"])[2]       netanserver     
    
         ELSE IF       '${text}'=='please provide Value for: NetAn Password'
               Selenium2Library.Input Text    xpath:(//input[@class="sf-element sf-element-control sfc-property sfc-text-box"])[3]       Ericsson01 
         END
         Sleep     1s
         Click element     xpath: //input[@value="Connect "]
         Sleep    5
    END
	wait for page to load
    capture page screenshot  
    
verify that the worker analysis file is connected
	${text}=      Selenium2Library.Get Text      xpath://span[@id='NetAnResponse']
	Log     ${text}
	should be equal    ${text}    OK  
    wait for page to load
    capture page screenshot
	
############################################ IMPROVEMENT EQEV-105271 ############################################

Select System area for collection manager
    [Arguments]     ${sys_area}
    @{element}=    Get WebElements	    xpath: //div[@class='ComboBoxTextDivContainer']
    ${sys_area_ele}=        Get from list     ${element}    1
    Click element     ${sys_area_ele}
    sleep    2
    Click element      xpath://div[@title='${sys_area}']     
    wait for page to load
    capture page screenshot
    
Select ENIQ Data Source in collection manager
    [Arguments]     ${data_source}
    sleep    3s
    @{element}=    Get WebElements	    xpath: //div[@class='ComboBoxTextDivContainer']
    ${data_source_ele}=        Get from list     ${element}    0
    Click element     ${data_source_ele}
    sleep    2
    Click element      xpath://div[@title='${data_source}']     
    capture page screenshot
    wait for page to load
    
Select Node type for collection manager
    [Arguments]     ${node_type}
    Sleep    5
    @{element}=    Get WebElements	    xpath: //div[@class='ComboBoxTextDivContainer']
    ${node_type_ele}=        Get from list     ${element}    2
    Click element     ${node_type_ele}
    sleep    2
    Click element      xpath://div[@title='${node_type}']   
    capture page screenshot
    wait for page to load
    
verify that the column LastModifiedOn is Present in Node Collection Manager
	${column_name}=    selenium2library.get text    xpath:(//div[@class="sf-element-table-cell flex-justify-start flex-align-end \ sfc-column-header sfpc-level-1 sfpc-level-last sfpc-odd-column"])[4]
	Log    ${column_name}
	should contain    ${column_name}    LastModifiedOn
	capture page screenshot
    wait for page to load  
    
verify that the column LastModifiedOn stores date   
    ${value}=    selenium2library.get text    xpath:(//div[@class="sf-element-table-cell flex-justify-start flex-align-start \ sfc-value-cell sfpc-odd-column sfpc-odd-row"])[4]
    Log    ${value}
    capture page screenshot
    wait for page to load
    
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
	    
Enter Wildcard Expression
	[Arguments]    ${wildcardExp}
	Clear Element Text      xpath:(//span[@id="WildcardExpression2"])//input
	Selenium2Library.Input Text     xpath:(//span[@id="WildcardExpression2"])//input    ${wildcardExp}
    wait for page to load
	capture page screenshot   
    
validate that the message is present
	${msg}=    selenium2library.get text    xpath:((//div[@class="HtmlTextArea sf-enable-selection sf-focusable"])[5]//span)[1]   
    Log    ${msg}
    should contain    ${msg}    ENIQ Data Source Name, System Area, Node Type will be uneditable
    capture page screenshot
    wait for page to load
    
edit the collection name
	[Arguments]    ${name}
	Clear Element Text     xpath:(//td[@id="CollectionName"])//input
    Selenium2Library.Input Text      xpath:(//td[@id="CollectionName"])//input      ${name}
    sleep    2s  
    capture page screenshot
    wait for page to load
    
verify that a Collection with entered name already exists
	${msg}=    selenium2library.get text    xpath:((//div[@class="HtmlTextArea sf-enable-selection sf-focusable"])[8]//span)[1] 
    Log    ${msg}
    should contain    ${msg}    Collection name already exists
    capture page screenshot
    wait for page to load   
    
select system area
	[Arguments]     ${sys_area}
    Wait Until Page Contains Element      xpath:(//div[@class="ComboBoxTextDivContainer"])[5]    150
    Click element     xpath:(//div[@class="ComboBoxTextDivContainer"])[5]
    sleep    2
    Click element      xpath://div[@title='${sys_area}']     
    wait for page to load
    capture page screenshot  
    
select the data source
	[Arguments]     ${datasource}
    Wait Until Page Contains Element      xpath:(//div[@class="ComboBoxTextDivContainer"])[2]    150
    sleep    5
    Click element     xpath:(//div[@class="ComboBoxTextDivContainer"])[2]
    sleep    2
    Click element      xpath://div[@title='${datasource}']     
    wait for page to load
    capture page screenshot    
    
select the created alarm
	[Arguments]    ${name}
	sleep    2
	Click element     xpath://*[contains(text(),'${name}')]
	sleep    2
	wait for page to load
    capture page screenshot   
    
validate the page title
	[Arguments]     ${expectedText}
    ${text}=    Selenium2Library.Get text  xpath: //*[@class="sfx_page-title_219"]
    Log    ${text}
    Should contain     ${text}    ${expectedText}	 
    wait for page to load
	capture page screenshot    
    
verify that the error message is visible
	${msg}=    selenium2library.get text    xpath:(((//div[@class="HtmlTextArea sf-enable-selection sf-focusable"])//div//div//div)[4]//table//tr//span)[16]
    Log    ${msg}
    should contain    ${msg}    Error: Alarm Definition
    capture page screenshot
    wait for page to load
	
############################################ IMPROVEMENT EQEV-105271 END ############################################

############################################ IMPROVEMENT EQEV-103913 ############################################

textfield to enter Wildcard Expression should be visible
	${lbl}=    selenium2library.get text    xpath:(//span[@id="WildcardExpression"])
	Log    ${lbl}
    should contain    ${lbl}    Wildcard Expression
    Element Should Be Visible        xpath:(//span[@id="WildcardExpression2"])//input
    Element Should Be Visible        xpath:(//span[@id="ExpLable2"])
	capture page screenshot
    wait for page to load	
	
Validate that the collection is present in GUI
	[Arguments]    ${collection}
	sleep    10
	Element Should Be Visible        xpath://*[contains(text(),'${collection}')]
	capture page screenshot
    wait for page to load	
	
validate that the ENIQ Datasource is
	[Arguments]    ${dataSource}
	${ds}=    selenium2library.get text    xpath:((//div[@class="ComboBoxTextDivContainer"])//div)[1]
	Log    ${ds}
	should contain    ${ds}    ${dataSource}
	capture page screenshot
    wait for page to load	
	
validate that the System Area is
	[Arguments]    ${area}
	${systemArea}=    selenium2library.get text    xpath:((//div[@class="ComboBoxTextDivContainer"])//div)[2]
	Log    ${systemArea}
	should contain    ${systemArea}    ${area}
	capture page screenshot
    wait for page to load	
	
validate that the Node Type is 
	[Arguments]    ${type}
	${nodeType}=    selenium2library.get text    xpath:((//div[@class="ComboBoxTextDivContainer"])//div)[3]
	Log    ${nodeType}
	should contain    ${nodeType}    ${type}
	capture page screenshot
    wait for page to load	
	
verify that nodes are visible in Preview section	
	${text}=    Get Text    xpath://*[@class="sfx_label_223"][1]
    should not be equal    ${text}    "0 of 0 rows"
	capture page screenshot
    wait for page to load
	
validate that the collection is present in NetAn DB
	[Arguments]     ${collection_name}
     ${sql}=    set variable    select "CollectionName" from "tblCollection"
     ${results}=  Query Postgre database and return output     ${sql}
     ${value}=    Get From List    ${results}     -1
     ${value}=    convert to string    ${value}	
	 Log    ${value}
	 Log    ${collection_name}
	 should contain    ${value}    ${collection_name}
	
validate that the page is refreshed
	Element Should Be Visible    xpath://*[contains(text(),'Select System Area')]
	Element Should Be Visible    xpath://*[contains(text(),'Select Node Type')]
	capture page screenshot
    wait for page to load	
	
go to Node Collection Manager page
	Wait Until Element Is Visible     xpath: //*[@value='Node Collection Manager ']    300
    Click element     xpath: //*[@value='Node Collection Manager ']
	wait for page to load
	capture page screenshot
	
############################################ IMPROVEMENT EQEV-103913 END ############################################

############################################ IMPROVEMENT EQEV-103914 ############################################

verify that the connection to NetAn and ENIQ is made
	${text}=    Get Text    xpath:(//span[@id="NetAnResponse"])//span
	Log    ${text}
	should contain    ${text}    OK
	${text1}=    Get Text    xpath:(//tr[@id="table-data"])[2]//td[6]//span
	Log    ${text1}
	should contain    ${text1}    Connected
	wait for page to load
	capture page screenshot	
	
verify that the ENIQ DataSource is Present in Connected ENIQs
	[Arguments]    ${datasource}
	${text1}=    Get Text    xpath:(//div[@class="sf-element-table-cell flex-justify-start flex-align-start \ sfc-value-cell sfpc-odd-column sfpc-odd-row"])[1]//div
	Log    ${text1}
	should contain    ${text1}    ${datasource}
	wait for page to load
	capture page screenshot	
	
verify that the connected ENIQ is present in tblEniqDS
	[Arguments]    ${ds}
	${sql}=    set variable    select "EniqName" from "tblEniqDS" where "EniqName" = '${ds}'
    ${results}=  Query Postgre database and return output     ${sql}
    ${value}=    Get From List    ${results}     0
    ${value}=    convert to string    ${value}	
	Log    ${value}
	should contain    ${value}    ${ds}
	
validate that NetAn_ODBC is present in Node Collection Manager
	Wait Until Element Is Visible     xpath:(//div[@class="ComboBoxTextDivContainer"])[1]    300
	Click element     xpath:(//div[@class="ComboBoxTextDivContainer"])[1]
	Element Should Be Visible    xpath://*[contains(text(),'NetAn_ODBC')]
	wait for page to load
	capture page screenshot	
	
validate that NetAn_ODBC is present in Alarm Rules Manager	
	Wait Until Element Is Visible     xpath:(//div[@class="ComboBoxTextDivContainer"])[2]    300
	Click element     xpath:(//div[@class="ComboBoxTextDivContainer"])[2]
	Element Should Be Visible    xpath://*[contains(text(),'NetAn_ODBC')]
	wait for page to load
	capture page screenshot
	
click on the connected ENIQ and click on delete
	[Arguments]    ${ds}
	Wait Until Element Is Visible     xpath:(//div[@class="sf-element-table-cell flex-justify-start flex-align-start \ sfc-value-cell sfpc-odd-column sfpc-odd-row"])[1]//div[contains(text(),'${ds}')]    300
	Click element     xpath:(//div[@class="sf-element-table-cell flex-justify-start flex-align-start \ sfc-value-cell sfpc-odd-column sfpc-odd-row"])[1]//div[contains(text(),'${ds}')]
	sleep     2
	Wait Until Element Is Visible     xpath:(//span[@class="admin"])[2]//input[@value="Delete"]    300
	Click element     xpath:(//span[@class="admin"])[2]//input[@value="Delete"]
	wait for page to load
	capture page screenshot
	
click on the failed ENIQ and click on delete
	[Arguments]    ${ds}
	Wait Until Element Is Visible     xpath:(//div[@class="sf-element-table-cell flex-justify-start flex-align-start \ sfc-value-cell sfpc-odd-column sfpc-even-row"])//div[contains(text(),'${ds}')]    300
	Click element     xpath:(//div[@class="sf-element-table-cell flex-justify-start flex-align-start \ sfc-value-cell sfpc-odd-column sfpc-even-row"])//div[contains(text(),'${ds}')]
	sleep     2
	Wait Until Element Is Visible     xpath:(//span[@class="admin"])[2]//input[@value="Delete"]    300
	Click element     xpath:(//span[@class="admin"])[2]//input[@value="Delete"]
	wait for page to load
	capture page screenshot
	
verify that the DataSource cant be deleted	
	${text1}=    Get Text    xpath:((//div[@class="HtmlTextArea sf-enable-selection sf-focusable"])[9]//span)[7]//span
	Log    ${text1}
	wait for page to load
	capture page screenshot
	
verify that the connection failed for 4140_ODBC
	${text1}=    Get Text    xpath:(//tr[@id="table-data"])[2]//td[6]//span
	Log    ${text1}
	should contain    ${text1}    Failed to connect with: 4140_ODBC,
	wait for page to load
	capture page screenshot	
	
verify that an exception occurred while trying to delete 4140_ODBC
	sleep    2
	Element Should Be Visible    xpath://*[contains(text(),'Error in DataBase Connection')]	
	wait for page to load
	capture page screenshot
	
click on the connect button
	Wait Until Element Is Visible     xpath: //*[@value='Connect ']    300
    Click element     xpath: //*[@value='Connect ']
	wait for page to load
	capture page screenshot	
	
enter the datasource
	[Arguments]    ${ds}
	Clear Element Text      xpath:(//input[@class="sf-element sf-element-control sfc-property sfc-text-box"])[4]
    Selenium2Library.Input Text    xpath:(//input[@class="sf-element sf-element-control sfc-property sfc-text-box"])[4]      ${ds}
	wait for page to load
	capture page screenshot	
	
verify that an error occurred while trying to add a DataSource
	sleep    2
	Element Should Be Visible    xpath://*[contains(text(),'Error in DataBase Connection')]	
	wait for page to load
	capture page screenshot
	
verify that the SubNetwork Viewer is added as a different Section	
	Element Should Be Visible    xpath:((//div[@class="HtmlTextArea sf-enable-selection sf-focusable"])[5]//font//p//font)[1]
	Element Should Be Visible    xpath:(//div[@class="sf-element sf-element-visual sfc-table sfpc-first-column"])[2]
	wait for page to load
	capture page screenshot
	
############################################ IMPROVEMENT EQEV-103914 END ############################################

############################################ IMPROVEMENT MR-108162 ############################################

Verify data integrity of the measures
        [Arguments]    ${measure_list}     ${sql1}     ${sql2}     ${sql3}     ${sql4}
        @{list}=      Split string      ${measure_list}    ,
        ${count}=     set variable    1
        ${date_id}=        Get cell value     DATE_ID      1
        @{date}=      Split string      ${date_id}
        ${date_value}=      Get from list     ${date}    0
        ${moid}=        Get cell value     MOID      1
        selenium2library.mouse over    xpath://*[contains(text(),'OSS_ID')]
        sleep    2
        Click on scroll right button     0     50
        FOR    ${measure}    IN    @{list}
            ${measure_value}=     Get cell value     MEASUREVALUE_${count}      1
            Log       ${measure_value}
            ${db_value}=      Query ENIQ database for kpiValue     ${sql${count}}      ${date_value}       ${moid}     
            Log        ${db_value}
            Should Contain        ${db_value}      ${measure_value}      
        END
		
Select a collection and click on delete button
     @{element}=    Get WebElements	    xpath: //div[@row='1' and @column='0']
     ${collection}=        Get from list     ${element}    0
     ${collection_name}=      Selenium2library.Get text          ${collection}
     Click Element      ${collection}
     sleep    5s
     Click on delete button
     
Verify that the deletion verification message is visible 
	 sleep     2
     element should be visible     xpath://*[contains(text(),'Selected Collection will be deleted, Do you want to proceed ?')]
     wait for page to load
     capture page screenshot
     
select the created collection
	[Arguments]    ${name}
	sleep    10
	Click element     xpath://*[contains(text(),'${name}')]
	wait for page to load
	capture page screenshot
	
Verify that the Collection can be deleted if it's not being used
	 sleep     2
     element should be visible     xpath://*[contains(text(),'Selected Collection will be deleted, Do you want to proceed ?')]
     sleep    2
     click element    xpath://*[contains(text(),'OK')]
     wait for page to load
     capture page screenshot
	
Verify when collection is used delete verification message is visible	
     sleep     2
     element should be visible     xpath://*[contains(text(),'The delete action cannot be completed because the following Collection is in use within a PM explorer report or an alarm rule in PM Alarming')]	
	 sleep    2
     wait for page to load
     capture page screenshot	
	
select a collection to generate alarm
	 [Arguments]    ${collection}
	 Wait Until Page Contains Element      xpath:(//div[@class="ComboBoxTextDivContainer"])[4]    30
	 Click Element      xpath:(//div[@class="ComboBoxTextDivContainer"])[4]
	 sleep    2
	 Wait Until Page Contains Element      xpath://*[contains(text(),'${collection}')]
	 click element    xpath://*[contains(text(),'${collection}')]
	 wait for page to load
     capture page screenshot	
	
Click on the Node Collection manager button
	sleep    2
    Click Element      xpath://input[@value='Node Collection Manager ']
    wait for page to load
    capture page screenshot
	
############################################ IMPROVEMENT MR-108162 END ############################################

############################################ MR-103724 ############################################

select a node from the list
	Wait Until Page Contains Element      xpath:(//div[@class="sf-element-list-box-item"])[1]    100
	Click Element    xpath:(//div[@class="sf-element-list-box-item"])[1]
    wait for page to load
	capture page screenshot
	
enter the specific problem
	clear element text    xpath:(//textarea[@class="sf-element sf-element-control sfc-property sfc-text-box"])[1]
	input text    xpath:(//textarea[@class="sf-element sf-element-control sfc-property sfc-text-box"])[1]    NA
	sleep    2
	clear element text    xpath:(//textarea[@class="sf-element sf-element-control sfc-property sfc-text-box"])[1]
	input text    xpath:(//textarea[@class="sf-element sf-element-control sfc-property sfc-text-box"])[1]    NA
	wait for page to load
	capture page screenshot

verify that the exception is visible
	sleep    2
	Element Should Be Visible    xpath://*[contains(text(),'Error in DataBase Connection')]	
	wait for page to load
	capture page screenshot

click on connect button to disconnect Eniq
	Wait Until Page Contains Element      xpath:(//input[@value="Connect "])    30
	click element    xpath:(//input[@value="Connect "])
	wait for page to load
	capture page screenshot

validate that the Measure error is present
	sleep    2
	Element Should Be Visible    xpath://*[contains(text(),'Selected measures must be present in the same table')]
	wait for page to load
	capture page screenshot

validate that the dropdown Alarm Severity is working as expected
	Wait Until Page Contains Element      xpath:(//div[@class="ComboBoxTextDivContainer"])[10]    30
	click element    xpath:(//div[@class="ComboBoxTextDivContainer"])[10]
	sleep    4
	Element Should Be Visible    xpath:(//div[@class="DropdownListContainer sf-element-styled-dialog sfc-style-root prevent-flyout-close"])
	click element    xpath://*[contains(text(),'Critical')]
	wait for page to load
	capture page screenshot

validate that the dropdown Aggregation is working as expected
	Wait Until Page Contains Element      xpath:(//div[@class="ComboBoxTextDivContainer"])[11]    30
	click element    xpath:(//div[@class="ComboBoxTextDivContainer"])[11]
	sleep    4
	Element Should Be Visible    xpath:(//div[@class="DropdownListContainer sf-element-styled-dialog sfc-style-root prevent-flyout-close"])
	click element    xpath://*[contains(text(),'1 Day')]
	wait for page to load
	capture page screenshot

validate that the dropdown Probable Cause is working as expected
	Wait Until Page Contains Element      xpath:(//div[@class="ComboBoxTextDivContainer"])[15]    30
	click element    xpath:(//div[@class="ComboBoxTextDivContainer"])[15]
	sleep    4
	Element Should Be Visible    xpath:(//div[@class="DropdownListContainer sf-element-styled-dialog sfc-style-root prevent-flyout-close"])
	wait for page to load
	capture page screenshot
	
############################################ MR-103724 END ############################################

######################################## MR EQEV-110751 ########################################

verify connection status in DWHDB Connection Status
	element should be visible    xpath:(//div[@class="sf-element-table-cell flex-justify-start flex-align-end \ sfc-column-header sfpc-level-1 sfpc-level-last sfpc-even-column" and @row="0" and @column="1"])
	${status}=    get text    xpath:(//div[@class="sf-element-table-cell flex-justify-start flex-align-start \ sfc-value-cell sfpc-even-column sfpc-odd-row" and @row="1" and @column="1"])
	Log    ${status}
	should contain    ${status}    Connected
	wait for page to load
	capture page screenshot
	
verify connection status in REPDB Connection Status
	element should be visible    xpath:(//div[@class="sf-element-table-cell flex-justify-start flex-align-end \ sfc-column-header sfpc-level-1 sfpc-level-last sfpc-odd-column" and @row="0" and @column="2"])
	${status}=    get text    xpath:(//div[@class="sf-element-table-cell flex-justify-start flex-align-start \ sfc-value-cell sfpc-odd-column sfpc-odd-row" and @row="1" and @column="2"])
	Log    ${status}
	should contain    ${status}    Connected
	wait for page to load
	capture page screenshot
	
verify Last Successful Sync With Eniq column
	element should be visible    xpath:(//div[@class="sf-element-table-cell flex-justify-start flex-align-end \ sfc-column-header sfpc-level-1 sfpc-level-last sfpc-even-column" and @row="0" and @column="3"])
	${status}=    get text    xpath:(//div[@class="sf-element-table-cell flex-justify-start flex-align-start \ sfc-value-cell sfpc-even-column sfpc-odd-row" and @row="1" and @column="3"])
	Log    ${status}
	wait for page to load
	capture page screenshot
	
verify that connection to REPDB failed and server is considered failed
	element should be visible    xpath:(//div[@class="sf-element-table-cell flex-justify-start flex-align-end \ sfc-column-header sfpc-level-1 sfpc-level-last sfpc-odd-column" and @row="0" and @column="2"])
	${status}=    get text    xpath:(//div[@class="sf-element-table-cell flex-justify-start flex-align-start \ sfc-value-cell sfpc-odd-column sfpc-odd-row" and @row="1" and @column="2"])
	Log    ${status}
	should contain    ${status}    Failed: 
	wait for page to load
	capture page screenshot
	
verify Last Successful Sync With Eniq column and return status
	element should be visible    xpath:(//div[@class="sf-element-table-cell flex-justify-start flex-align-end \ sfc-column-header sfpc-level-1 sfpc-level-last sfpc-even-column" and @row="0" and @column="3"])
	${status}=    get text    xpath:(//div[@class="sf-element-table-cell flex-justify-start flex-align-start \ sfc-value-cell sfpc-even-column sfpc-odd-row" and @row="1" and @column="3"])
	Log    ${status}
	[Return]    ${status}
	wait for page to load
	capture page screenshot
	
verify that the Time read from Eniq DS table is the server's time
	[Arguments]    ${status}
	${time}=    get time    hour
	Log    ${time}
	should contain    ${status}    ${time}
	[Return]    ${time}
	wait for page to load
	capture page screenshot
	
verify the time and timezone in Last Successful Sync
	[Arguments]    ${status}
	Log    ${status}
	${str1}=    split string from right    ${status}    -    1
	Should Not Be Empty    ${str1}
	wait for page to load
	capture page screenshot	
	
verify connection status in DWHDB Connection Status and return
	element should be visible    xpath:(//div[@class="sf-element-table-cell flex-justify-start flex-align-end \ sfc-column-header sfpc-level-1 sfpc-level-last sfpc-even-column" and @row="0" and @column="1"])
	${status}=    get text    xpath:(//div[@class="sf-element-table-cell flex-justify-start flex-align-start \ sfc-value-cell sfpc-even-column sfpc-odd-row" and @row="1" and @column="1"])
	Log    ${status}
	[Return]    ${status}
	should contain    ${status}    Connected
	wait for page to load
	capture page screenshot
	
verify connection status in REPDB Connection Status and return
	element should be visible    xpath:(//div[@class="sf-element-table-cell flex-justify-start flex-align-end \ sfc-column-header sfpc-level-1 sfpc-level-last sfpc-odd-column" and @row="0" and @column="2"])
	${status}=    get text    xpath:(//div[@class="sf-element-table-cell flex-justify-start flex-align-start \ sfc-value-cell sfpc-odd-column sfpc-odd-row" and @row="1" and @column="2"])
	Log    ${status}
	[Return]    ${status}
	should contain    ${status}    Connected
	wait for page to load
	capture page screenshot
	
verify that the server is connected properly
	[Arguments]    ${status1}    ${status2}
	should contain    ${status1}    Connected
	should contain    ${status2}    Connected
	wait for page to load
	capture page screenshot
	
enter a false datasource and click on connect
	[Arguments]    ${dataSource}
	Wait Until Element Is Visible     xpath:(//input[@class="sf-element sf-element-control sfc-property sfc-text-box"])[4]    300
	Clear Element Text      xpath:(//input[@class="sf-element sf-element-control sfc-property sfc-text-box"])[4]
    Selenium2Library.input text     xpath:(//input[@class="sf-element sf-element-control sfc-property sfc-text-box"])[4]    ${dataSource}
    sleep    3
    Clear Element Text      xpath:(//input[@class="sf-element sf-element-control sfc-property sfc-text-box"])[4]
    Selenium2Library.input text     xpath:(//input[@class="sf-element sf-element-control sfc-property sfc-text-box"])[4]    ${dataSource}
    sleep    5
    Wait Until Element Is Visible     xpath:(//input[@value="Connect"])[2]    30
	click element    xpath:(//input[@value="Connect"])[2]
    wait for page to load
	capture page screenshot
	
verify that after connection refreshed the LastSuccessful Sync time remains same
	[Arguments]    ${status}
	element should be visible    xpath://*[contains(text(),'${status}')]
	wait for page to load
	capture page screenshot
	
click on client scroll down button
	[Arguments]    ${n}
	sleep    5
	FOR    ${i}    IN RANGE    0    ${n} 
           Click    ${IMAGE_DIR}\\PMEx_Scroll.PNG
           sleep    1         
    END
    sleep    5
	
go to the Administration page
	click on client scroll down button    20
	Wait until screen contain     ${IMAGE_DIR}\\settingsButton.PNG    30
	click    ${IMAGE_DIR}\\settingsButton.PNG
	sleep    5
	
verify that the Last Successful Sync With Eniq column has data
	sleep    20
	SikuliLibrary.screen should contain    ${IMAGE_DIR}\\PMEx_Synced_Report.PNG
	
Launch the Tibco spotfire PM Explorer Application DXP 9	
	AutoItLibrary.Run    C:\\Program Files (x86)\\TIBCO\\Spotfire\\11.4.2\\Spotfire.Dxp /server:"https://localhost/" /username:Administrator /password:Ericsson01 /file:${dxp_file_loc}/PM_Explorer_S11_9.dxp  
    Sleep    25
    Capture Screen
    
validate that the following button is disabled
	[Arguments]    ${buttonValue}
	${status}=    Run Keyword And Return Status    Click element      xpath:(//div[@value="${buttonValue}"]
	Log    ${status}
	${status}=    convert to string    ${status}
	should be equal    ${status}    False
	wait for page to load
	capture page screenshot
	
verify that the Date Time is not updated
	[Arguments]    ${status}
	${status1}=    get text    xpath:(//div[@class="sf-element-table-cell flex-justify-start flex-align-start \ sfc-value-cell sfpc-even-column sfpc-odd-row" and @row="1" and @column="3"])
	Log    ${status1}
	Log    ${status}
	should not be equal    ${status1}    ${status}
	wait for page to load
	capture page screenshot
	
select the created collection and click on delete
	[Arguments]    ${name}
	sleep    2
	Click element     xpath://*[contains(text(),'${name}')]
	sleep    2
	click on button    Delete Collection
	wait for page to load
	capture page screenshot
    
close the delete popup using X symbol
	Wait Until Page Contains Element      xpath:(//span[@class="ui-icon ui-icon-closethick"])[1]    100
	Click element      xpath:(//span[@class="ui-icon ui-icon-closethick"])[1]
	wait for page to load
	capture page screenshot
	
Click on Alarm type and verify the list of alarm types
     Wait Until Page Contains Element     xpath:(//div[@class="ComboBoxTextDivContainer"])[1]    30
	 click element       xpath:(//div[@class="ComboBoxTextDivContainer"])[1]      
     sleep    2
     Element Should Be Visible    xpath://*[contains(text(),'Case Dependent Threshold')]
     Element Should Be Visible    xpath://*[contains(text(),'Dynamic Threshold')]
     Element Should Be Visible    xpath://*[contains(text(),'Continuous Detection')]
     Element Should Be Visible    xpath://*[contains(text(),'Past Comparison Detection')]
     Element Should Be Visible    xpath://*[contains(text(),'Past Comparison Detection + Continuous Detection')]
     Element Should Be Visible    xpath://*[contains(text(),'Threshold')]
     Element Should Be Visible    xpath://*[contains(text(),'Trend')]
     wait for page to load
     capture page screenshot
     
Navigate to the section
    [Arguments]     ${section}
	${count}=       set variable      0
	place the cursor on    ENIQ Connection Status
	Click on maximise window button    1
	Sleep      5s	
	FOR    ${i}    IN RANGE    0     15
	    ${count}=     Get Element Count       xpath:(//*[@value="${section}"])
         IF      ${count}>0
                 Exit for loop
	     ELSE
		         Click on Next Button
				 Sleep     3s
				 Capture page screenshot
         END
	END
	IF      ${count}==0  
		          FAIL     Section ${section} is not available in UI
	END
	
	
Click on measure types and verify the list of measures
	Wait Until Page Contains Element     xpath:(//div[@class="ComboBoxTextDivContainer"])[9]    30
	 click element       xpath:(//div[@class="ComboBoxTextDivContainer"])[9]      
     sleep    2
     Element Should Be Visible    xpath:(//div[@title="Counter"])
     Element Should Be Visible    xpath:(//div[@title="KPI"])
     Element Should Be Visible    xpath:(//div[@title="RI"])
     wait for page to load
     capture page screenshot

Click on Probable cause and verify the list
	Wait Until Page Contains Element     xpath:(//div[@class="ComboBoxTextDivContainer"])[9]    30
	 click element       xpath:(//div[@class="ComboBoxTextDivContainer"])[9]      
     sleep    2
     Element Should Be Visible    xpath://*[contains(text(),'Counter')]
     wait for page to load
     capture page screenshot

Verify the alarm state
    ${alarm_state}=    Get text    xpath:(//div[@class="cell-text"])[5]
    Log    ${alarm_state}
    Should contain    ${alarm_state}    Active
    wait for page to load
    capture page screenshot
    
Activate an alarm
    Wait Until Page Contains Element     xpath:(//div[@class="sf-element-table-cell flex-justify-start flex-align-start \ sfc-value-cell sfpc-odd-column sfpc-odd-row" and @row="1" and @column="0"])    300
    click element       xpath:(//div[@class="sf-element-table-cell flex-justify-start flex-align-start \ sfc-value-cell sfpc-odd-column sfpc-odd-row" and @row="1" and @column="0"])
    sleep    5
    Click element     xpath: //input[@value='Activate']
    wait for page to load
    capture page screenshot

scroll down until export button is visible
    FOR    ${i}    IN RANGE    0    10
           Click element     xpath:(//div[@class="ScrollbarButton sf-element sf-element-scroll-bar-button sfpc-bottom"])[6]
           sleep    0.5           
    END
    wait for page to load
    capture page screenshot


Select an Alarm rule file
     Wait Until Page Contains Element     xpath:(//div[@class="ComboBoxTextDivContainer"])[1]    300
	 Click element     xpath:(//div[@class="ComboBoxTextDivContainer"])[1]
	 sleep    3
	 Wait Until Page Contains Element     xpath:((//div[@class="ListItems"])//div[1])[3]    300
	 Click element     xpath:((//div[@class="ListItems"])//div[1])[3]
	 wait for page to load
	 capture page screenshot
	
select NetAn_ODBC as DataSource in Alarm Rules Import Manager 
    Wait Until Page Contains Element     xpath:(//div[@class="ComboBoxTextDivContainer"])[2]    300
    Click element     xpath:(//div[@class="ComboBoxTextDivContainer"])[2]
	sleep    3
    Wait Until Page Contains Element     xpath:(//div[@title="NetAn_ODBC"])    300
    Click element     xpath:(//div[@title="NetAn_ODBC"])
    wait for page to load
    capture page screenshot
   
Select single node in Alarm Rules Import Manager   
    Wait Until Page Contains Element     xpath:(//div[@class="ComboBoxTextDivContainer"])[3]    300
    Click element     xpath:(//div[@class="ComboBoxTextDivContainer"])[3]
    sleep    3
    Wait Until Page Contains Element     xpath:(//div[@title="Single Node"])    300
    Click element     xpath:(//div[@title="Single Node"])
    wait for page to load
    capture page screenshot

select node in Alarm Rules Import Manager
    Wait Until Page Contains Element     xpath:(//div[@class="sf-element-list-box-item"])[1]    300
    Click element     xpath:(//div[@class="sf-element-list-box-item"])[1]
    wait for page to load
    capture page screenshot

select Alarm Rules to be imported
    Wait Until Page Contains Element     xpath:(//div[@class="sf-element-table-cell flex-justify-start flex-align-start \ sfc-value-cell sfpc-odd-column sfpc-odd-row"])[3]    30
    click element     xpath:(//div[@class="sf-element-table-cell flex-justify-start flex-align-start \ sfc-value-cell sfpc-odd-column sfpc-odd-row"])[3]
    wait for page to load
    capture page screenshot

verify import result
    [Arguments]    ${alarm_name}
    element should be visible    xpath:(//div[@class="valueCellsContainer"])[1]//*[contains(text(),'${alarm_name}')]
    wait for page to load
    capture page screenshot

click on the element
    [Arguments]    ${title}
    Wait Until Page Contains Element      xpath://*[contains(text(),'${title}')]     timeout=15
    Click Element      xpath://*[contains(text(),'${title}')]
    wait for page to load
    capture page screenshot

verify that alarm generation failed
    element should be visible    xpath://*[contains(text(),'Measure input required')]
    wait for page to load
    capture page screenshot

Verify the deleted alarm message
	${text}=    get text    xpath:((//div[@id="dialog-error"])//p)[1]
	Log    ${text}
	should contain    ${text}    To delete or edit, alarm state must be Inactive
    wait for page to load
    capture page screenshot

select an activated alarm and click on delete
    Wait Until Page Contains Element    xpath:(//div[@class="sf-element sf-element-visual-content sfc-table"])//*[contains(text(),'Active')]
    Click element     xpath: (//div[@class="sf-element sf-element-visual-content sfc-table"])//*[contains(text(),'Active')]
    Sleep     2s 
    Click element     xpath: //input[@value='Delete']
    wait for page to load
    Capture page screenshot
    
verify that an alarm with same name already exists
    [Arguments]    ${alarm_name}
    element should be visible    xpath:(//*[contains(text(),'Error: Alarm Definition "${alarm_name}" already exists')])
    wait for page to load
    Capture page screenshot
	
######################################## MR EQEV-110751 END ########################################

place the cursor on
	[Arguments]    ${text}
	mouse over    xpath://div[contains(text(),'${text}')]
	wait for page to load
    Capture page screenshot    
    
click on the 4th scroll up button    
    [Arguments]    ${n}
    FOR    ${i}    IN RANGE    0    ${n} 
           Run Keyword and Ignore Error    Click element     xpath:(//div[@class="ScrollbarButton sf-element sf-element-scroll-bar-button sfpc-top"])[4]
           sleep    .5           
    END
    wait for page to load
	
open a new instance of the application
	[Arguments]    ${appTitle}    ${exeFile}	
	${status}=    run keyword and return status   RPA.Windows.Close window    ${appTitle}
	windows run    ${exeFile}
	
close the application if already running
	[Arguments]    ${appTitle}    ${exeFile}	
	${status}=    run keyword and return status   RPA.Windows.Close window    ${appTitle}
	
close the Missing Information Link window
	sleep    60
	control window    Missing Information Link
	RPA.Windows.Click  id:openEmptyDataRadioButton
	sleep    3
	RPA.Windows.Click  id:sameForAllCheckbox
	sleep    3
	RPA.Windows.Click  id:okButton
	sleep    5
	${status}=    run keyword and return status    RPA.Windows.Click  id:Maximize-Restore
	
Close Spotfire Application
    Selenium2Library.Capture page screenshot
    AutoItLibrary.ProcessClose      Spotfire.Dxp.exe 
    OperatingSystem.Run    taskkill /f /im Spotfire.dxp.exe
    Sleep    10s
	capture page screenshot
	
####################################################################################################################

Verify PMA screen image
	#Wait Until Page Contains Element    xpath:(//div[@class='HtmlTextArea sf-enable-selection sf-focusable
	sleep    4	
	
verify that the connection to NetAn is made
	${text}=    Get Text    xpath:(//span[@id="NetAnResponse"])//span
	Log    ${text}
	should contain    ${text}    OK
	wait for page to load
	capture page screenshot	

Verify after the NetAn Connection is made "OK" message is visible 
	${text}=    Get Text    xpath:(//span[@id="NetAnResponse"])//span
	Log    ${text}
	should contain    ${text}    OK
	wait for page to load
	capture page screenshot	
	
	
verify that connection to Eniq is made	
	${text1}=    Get Text    xpath:(//tr[@id="table-data"])[2]//td[6]//span
	Log    ${text1}
	should contain    ${text1}    Connected
	wait for page to load
	capture page screenshot
	
Connect to ENIQ with incorrect Credentials
	[Arguments]      ${url_value}      ${username_value}        ${password_value}      ${Eniq_DB_Value}      
    ${window}=      set variable       Setup Data Source
    
    Navigate to section         ${window} 
    sleep     10s
    @{element}=    Get WebElements	    xpath: //input[@class='sf-element sf-element-control sfc-property sfc-text-box']
    ${name}=        Get from list     ${element}    0
    ${username}=        Get from list     ${element}    1
    ${password}=        Get from list     ${element}    2
    ${eniqs}=        Get from list     ${element}    3
    Selenium2Library.Input Text    ${name}       ${url_value}
    Sleep     1s
    Selenium2Library.Input Text    ${username}       ${username_value}
    Sleep     1s
    Selenium2Library.Input Text    ${password}       ${password_value} 
    Sleep     1s
    Click element     xpath: //input[@id='531c6c74f6484fa094d9e8a3b53c1283']
    Sleep     10s
    FOR    ${i}    IN RANGE    0     5
         ${text}=      Selenium2Library.Get Text      xpath://span[@id='NetAnResponse']
         IF    '${text}'=='OK'
               Exit For Loop
         ELSE IF     '${text}'=='please provide Value for: NetAn SQL DB URL'
               Selenium2Library.Input Text    ${name}       ${url_value}
               
         ELSE IF     '${text}'=='please provide Value for: NetAn User Name'
               Selenium2Library.Input Text    ${username}       ${username_value}     
    
         ELSE IF       '${text}'=='please provide Value for: NetAn Password'
               Selenium2Library.Input Text    ${password}       ${password_value}
         END
         Sleep     1s
         Click element     xpath: //input[@id='531c6c74f6484fa094d9e8a3b53c1283']
         Sleep     10s
    END     
    
    FOR    ${i}    IN RANGE    0     5
          Clear Element Text      ${eniqs}
          Selenium2Library.Input Text    ${eniqs}       ${Eniq_DB_Value} 
          
    END 
    
    Click element     xpath: //input[@id='f04c63c1f5dd4ea5b9b1179fa3b26a55']
    
    Sleep    20s
    wait for page to load
    sleep   5s
    capture page screenshot
    Click on minimise window button     0
    Sleep     10s

Verify after the NetAn Connection is not made "please provide Value for: NetAn User Name" message is visible
	sleep	6
	Element Should Be Visible    xpath://span[contains(text(),'please provide Value for: NetAn User Name')]
	wait for page to load
	capture page screenshot

Verify after the NetAn Connection is not made "Cannot create connection" message is visible
	sleep   6  
	Element Should Be Visible    xpath://span[contains(text(),'Cannot Create Connection')]
	wait for page to load
	capture page screenshot

Verify after the NetAn Connection is not made "please provide Value for: NetAn Password" message is visible
	Element Should Be Visible    xpath://span[contains(text(),'please provide Value for: NetAn Password')]
	wait for page to load
	capture page screenshot

Connect to ENIQ with No Password
	[Arguments]      ${url_value}      ${username_value}        ${password_value}      ${Eniq_DB_Value}      
    ${window}=      set variable       Setup Data Source
    
    Navigate to section         ${window} 
    sleep     10s
    @{element}=    Get WebElements	    xpath: //input[@class='sf-element sf-element-control sfc-property sfc-text-box']
    ${name}=        Get from list     ${element}    0
    ${username}=        Get from list     ${element}    1
    ${password}=        Get from list     ${element}    2
    ${eniqs}=        Get from list     ${element}    3
    Selenium2Library.Input Text    ${name}       ${url_value}
    Sleep     1s
    Selenium2Library.Input Text    ${username}       ${username_value}
    Sleep     1s
    Selenium2Library.Input Text    ${password}       ${password_value} 
    Sleep     1s
    Click element     xpath: //input[@id='531c6c74f6484fa094d9e8a3b53c1283']
    Sleep     10s	
    FOR    ${i}    IN RANGE    0     5
         ${text}=      Selenium2Library.Get Text      xpath://span[@id='NetAnResponse']
         IF    '${text}'=='OK'
               Exit For Loop
         ELSE IF     '${text}'=='please provide Value for: NetAn SQL DB URL'
               Selenium2Library.Input Text    ${name}       ${url_value}
               
         ELSE IF     '${text}'=='please provide Value for: NetAn User Name'
               Selenium2Library.Input Text    ${username}       ${username_value}     
    
         ELSE IF       '${text}'=='please provide Value for: NetAn Password'
               Selenium2Library.Input Text    ${password}       ${EMPTY}
         END
         Sleep     1s
         Click element     xpath: //input[@id='531c6c74f6484fa094d9e8a3b53c1283']
         Sleep     10s
    END
    
Verify after the Eniq Connection is made "Connection" message is visible
	Element Should Be Visible    xpath://span[contains(text(),'Connected')]
	wait for page to load
	capture page screenshot   
	
Verify after the Eniq Connection is made "failed to connect with: "wrong_ODBC" message is visible
	Element Should Be Visible    xpath://span[contains(text(),'Failed to connect with: wrong_ODBC')]
	wait for page to load
	capture page screenshot




Connect to ENIQ with wrong Eniq_ODBC
	[Arguments]      ${url_value}      ${username_value}        ${password_value}      ${wrong_ODBC}      
    ${window}=      set variable       Setup Data Source
    
    Navigate to section         ${window} 
    sleep     10s
    @{element}=    Get WebElements	    xpath: //input[@class='sf-element sf-element-control sfc-property sfc-text-box']
    ${name}=        Get from list     ${element}    0
    ${username}=        Get from list     ${element}    1
    ${password}=        Get from list     ${element}    2
    ${eniqs}=        Get from list     ${element}    3
    Selenium2Library.Input Text    ${name}       ${url_value}
    Sleep     1s
    Selenium2Library.Input Text    ${username}       ${username_value}
    Sleep     1s
    Selenium2Library.Input Text    ${password}       ${password_value} 
    Sleep     1s
    Click element     xpath: //input[@id='531c6c74f6484fa094d9e8a3b53c1283']
    Sleep     10s
    FOR    ${i}    IN RANGE    0     5
         ${text}=      Selenium2Library.Get Text      xpath://span[@id='NetAnResponse']
         IF    '${text}'=='OK'
               Exit For Loop
         ELSE IF     '${text}'=='please provide Value for: NetAn SQL DB URL'
               Selenium2Library.Input Text    ${name}       ${url_value}
               
         ELSE IF     '${text}'=='please provide Value for: NetAn User Name'
               Selenium2Library.Input Text    ${username}       ${username_value}     
    
         ELSE IF       '${text}'=='please provide Value for: NetAn Password'
               Selenium2Library.Input Text    ${password}       ${password_value}
         END
         Sleep     1s
         Click element     xpath: //input[@id='531c6c74f6484fa094d9e8a3b53c1283']
         Sleep     10s
    END     
    
    FOR    ${i}    IN RANGE    0     5
          Clear Element Text      ${eniqs}
          Selenium2Library.Input Text    ${eniqs}       ${wrong_ODBC} 
          
    END 
    
    Click element     xpath: //input[@id='f04c63c1f5dd4ea5b9b1179fa3b26a55']
    
    Sleep    20s

Verify after the Eniq Connection is made "failed to connect with: "Wrong_ODBC,NetAn_ODBC" message is visible
	Element Should Be Visible    xpath://span[contains(text(),'Failed to connect with: Wrong_ODBC, NetAn_ODBC')]
	wait for page to load
	capture page screenshot   
	
	
verify Last Successful Sync With Eniq column Is Empty
	sleep    5
	element should be visible    xpath:(//div[@class="sf-element-table-cell flex-justify-start flex-align-end \ sfc-column-header sfpc-level-1 sfpc-level-last sfpc-even-column" and @row="0" and @column="3"])
	${status}=    get text    xpath:(//div[@class="sf-element-table-cell flex-justify-start flex-align-start \ sfc-value-cell sfpc-even-column sfpc-odd-row" and @row="1" and @column="3"])
	Log    ${status}
	SHOULD BE EQUAL    ${status}   ${EMPTY}
	wait for page to load
	capture page screenshot
	
place the cursor on button
	[Arguments]    ${text}
	mouse over    xpath://*[@value="${text}"]
	wait for page to load
    Capture page screenshot  
    
    
click on any ENIQ connection and click on delete
	[Arguments]    ${ds}
	Wait Until Element Is Visible     xpath:(//div[@class="sf-element-table-cell flex-justify-start flex-align-start \ sfc-value-cell sfpc-odd-column sfpc-odd-row"])[1]//div[contains(text(),'${ds}')]    300
	Click element     xpath:(//div[@class="sf-element-table-cell flex-justify-start flex-align-start \ sfc-value-cell sfpc-odd-column sfpc-odd-row"])[1]//div[contains(text(),'${ds}')]
	sleep     2
	place the cursor on    Last Successful Sync With ENIQ
	Click on Next Button
	Click on button    Delete
	wait for page to load
    Capture page screenshot 

click on an ENIQ connection and click on delete
	Wait Until Element Is Visible     xpath:(//div[@class="sf-element-table-cell flex-justify-start flex-align-start \ sfc-value-cell sfpc-odd-column sfpc-even-row" and @row="2" and @column="0"])    300
	Click element    xpath:(//div[@class="sf-element-table-cell flex-justify-start flex-align-start \ sfc-value-cell sfpc-odd-column sfpc-even-row" and @row="2" and @column="0"])
	sleep    2
	place the cursor on    Last Successful Sync With ENIQ
	Click on Next Button
	Click on button    Delete
	Verify the delete box enabled
	wait for page to load
    Capture page screenshot
	
	
Verify the delete box enabled
	element should be visible    xpath:(//span[contains(text(),'The following connection will be deleted. Do you want to proceed?')])
	element should be visible    xpath:(//label[@class="deleteConnectionsInput"])[2]
	wait for page to load
    Capture page screenshot 
    

Verify the Eniq server selected
	[Arguments]    ${eniq_name}
	element should be visible    xpath:(//span[contains(text(),'${eniq_name}')])
	element should be visible    xpath:(//label[@class="deleteConnectionsInput"])[2]
	wait for page to load
    Capture page screenshot
    
click on an ENIQ connection and check the Eniq Name and click on delete
	Wait Until Element Is Visible     xpath:(//div[@class="sf-element-table-cell flex-justify-start flex-align-start \ sfc-value-cell sfpc-odd-column sfpc-even-row" and @row="2" and @column="0"])    300
	Click element    xpath:(//div[@class="sf-element-table-cell flex-justify-start flex-align-start \ sfc-value-cell sfpc-odd-column sfpc-even-row" and @row="2" and @column="0"])
	sleep    2
	place the cursor on    Last Successful Sync With ENIQ
	Click on Next Button
	Click on button    Delete
	Verify the Eniq server selected    4140_ODBC
	wait for page to load
    Capture page screenshot
    
    
click on an ENIQ connection and check the Eniq Name and click on cancel
	Wait Until Element Is Visible     xpath:(//div[@class="sf-element-table-cell flex-justify-start flex-align-start \ sfc-value-cell sfpc-odd-column sfpc-even-row" and @row="2" and @column="0"])    300
	Click element    xpath:(//div[@class="sf-element-table-cell flex-justify-start flex-align-start \ sfc-value-cell sfpc-odd-column sfpc-even-row" and @row="2" and @column="0"])
	sleep    2
	place the cursor on    Last Successful Sync With ENIQ
	Click on Next Button
	Click on button    Delete
	Verify the delete box enabled
	Verify the Eniq server selected    4140_ODBC
	Wait Until Element Is Visible     xpath:(//label[@class="deleteConnectionOptions1"])
	Click element    xpath:(//label[@class="deleteConnectionOptions1"])
	wait for page to load
    Capture page screenshot
    
click on an ENIQ connection and click on Cross 
	Wait Until Element Is Visible     xpath:(//div[@class="sf-element-table-cell flex-justify-start flex-align-start \ sfc-value-cell sfpc-odd-column sfpc-even-row" and @row="2" and @column="0"])    300
	Click element    xpath:(//div[@class="sf-element-table-cell flex-justify-start flex-align-start \ sfc-value-cell sfpc-odd-column sfpc-even-row" and @row="2" and @column="0"])
	sleep    2
	place the cursor on    Last Successful Sync With ENIQ
	Click on Next Button
	Click on button    Delete
	Verify the delete box enabled
	Verify the Eniq server selected    4140_ODBC
	Wait Until Element Is Visible     xpath:(//label[@class="deleteConnectionOptions"])[2]
	Click element    xpath:(//label[@class="deleteConnectionOptions"])[2]
	wait for page to load
    Capture page screenshot 
    
click on delete button to delete an Eniq connection 
	Wait Until Element Is Visible     xpath:(//div[@class="sf-element-table-cell flex-justify-start flex-align-start \ sfc-value-cell sfpc-odd-column sfpc-even-row" and @row="2" and @column="0"])    300
	Click element    xpath:(//div[@class="sf-element-table-cell flex-justify-start flex-align-start \ sfc-value-cell sfpc-odd-column sfpc-even-row" and @row="2" and @column="0"])
	sleep    2
	place the cursor on    Last Successful Sync With ENIQ
	Click on Next Button
	Click on button    Delete
	Verify the Eniq server selected    4140_ODBC
	Wait Until Element Is Visible     xpath:(//label[@class="deleteConnectionsInput"])[2]
	Click element    xpath:(//label[@class="deleteConnectionsInput"])[2]
	wait for page to load
    Capture page screenshot
    
Verify The delete dialoge is shown after deletion of an eniq server
	element should be visible   xpath:(//span[contains(text(),'Connection deleted successfully')])    
    wait for page to load
    Capture page screenshot

click on the OK button after Deletion message
	Wait Until Element Is Visible    xpath:((//div[@class="deletefooter"]//label[@class="deleteConnectionsInput"]))[3]
	Click element    xpath:((//div[@class="deletefooter"]//label[@class="deleteConnectionsInput"]))[3]
	wait for page to load
    Capture page screenshot
    
Verify the Collection in delete box
	[Arguments]    ${collections}
	${text}=    Selenium2Library.get text    xpath:((//div[@class="layout"])//span)[1]
	Log    ${text}
	should contain    ${text}    ${collections}
	wait for page to load
    Capture page screenshot
	
Click on OK Button
	Wait Until Element Is Visible    xpath:((//div[@class='deletefooter'])//label[@class='deleteConnectionsInput'])[1]
	Click element    	xpath:((//div[@class='deletefooter'])//label[@class='deleteConnectionsInput'])[1]
	wait for page to load
    Capture page screenshot
	
Verify The delete Button should be disabled
	place the cursor on    Last Successful Sync With ENIQ
	Click on Next Button
	sleep    4
	wait for page to load
    Capture page screenshot	
	
Verify The delete Button should be disabled with failed datasource
	place the cursor on    Last Successful Sync With ENIQ
	Click on Next Button
	sleep    4
	wait for page to load
    Capture page screenshot	
	
	
change the mode to
	[Arguments]    ${mode}
	Wait Until Page Contains Element      xpath: //div[@class='sfx_author-dropdown_506']     timeout=300
	Click element       xpath: //div[@class='sfx_author-dropdown_506']
	Wait Until Page Contains Element      xpath://div[@title='${mode}']     timeout=300
	Click Element      xpath://div[@title='${mode}']
	Sleep    20s		
	capture page screenshot
	
go to the Page tab
	Click on forward button    20
	sleep    2
	Wait Until Page Contains Element      xpath:(//div[@class="sfx_page-tab_204 sf-element-page-tab"])[10]     timeout=30
	Click Element      xpath:(//div[@class="sfx_page-tab_204 sf-element-page-tab"])[10]
	wait for page to load
	capture page screenshot	
	
Click on forward button
    [Arguments]    ${n}
    FOR    ${i}    IN RANGE    0    ${n} 
           Click element     xpath:(//div[@title="Forward"])           
    END	
	
select the table Measure Mapping for visualization
	Wait Until Page Contains Element      xpath:(//div[@class="ComboBoxTextDivContainer"])
	Click Element    xpath:(//div[@class="ComboBoxTextDivContainer"])
	sleep    2
	click on scroll up button    2    50
	sleep    2
	Click on scroll down button     2    12	
	click on the button    Measure Mapping
	wait for page to load
	capture page screenshot 
	
verify that there's data in the Measure Mapping table
	${text}=    Get Text    xpath://*[@class="sfx_label_223"][1]
	Log    ${text}
    wait for page to load
	capture page screenshot	
	
verify Last Successful Sync With Eniq column 
	sleep    5
	element should be visible    xpath:(//div[@class="sf-element-table-cell flex-justify-start flex-align-end \ sfc-column-header sfpc-level-1 sfpc-level-last sfpc-even-column" and @row="0" and @column="3"])
	${status}=    get text    xpath:(//div[@class="sf-element-table-cell flex-justify-start flex-align-start \ sfc-value-cell sfpc-even-column sfpc-odd-row" and @row="1" and @column="3"])
	Log    ${status}
	SHOULD BE EQUAL    ${status}   ${EMPTY}
	wait for page to load
	capture page screenshot	
	
change to page navigation to
	[Arguments]    ${mode}
	Wait Until Page Contains Element      xpath:(//div[@class="sfx_page-title_219"])     timeout=30
	open context menu      xpath:(//div[@class="sfx_page-title_219"])
	sleep    2
	Wait Until Page Contains Element      xpath:(//div[@class="contextMenuItemLabel"])[1]     timeout=30
	Click Element      xpath:(//div[@class="contextMenuItemLabel"])[1]
	sleep    2
	Wait Until Page Contains Element      xpath:(//div[@title="${mode}"])     timeout=30
	Click Element      xpath:(//div[@title="${mode}"])
	wait for page to load
	capture page screenshot	
	
Click on the filter box for DataSourceName
	Click on scroll down button     1    2 
    Element should be visible    xpath:(//*[contains(text(),'DataSourceName')])[1]
    Click Element    xpath:(//*[contains(text(),'DataSourceName')])[1]
    sleep    5
    Element should be visible    xpath:(//div[@class="sfx_item-text_811 sf-element-text-box"])[9]
    Click Element    xpath:(//div[@class="sfx_item-text_811 sf-element-text-box"])[9]
    sleep    5
    Element should be visible    xpath:((//div[@class="sfx_item-right-box_812"])[9])
    Click Element    xpath:((//div[@class="sfx_item-right-box_812"])[9])
    sleep    3
    ${txt}=    Selenium2Library.get text    xpath:(//div[@class="flex-item flex-align-start sf-element sf-element-text-box"])
    Log    ${txt}
    [Return]    ${txt}
	wait for page to load
	capture page screenshot
	
Change the Visualization type to Table
	sleep    10
	click on the button    Start from visualizations
	sleep    5
	Wait Until Page Contains Element      xpath://div[@class="sfx_button_303 sfx_button-enabled_302"][1]     timeout=15
	Click Element      xpath://div[@class="sfx_button_303 sfx_button-enabled_302"][1]
	    
Verify that the measure mapping table has data	
	${text}=    Get Text    xpath://*[@class="sfx_label_223"][1]
    should not be equal    ${text}    "0 of 0 rows"
	capture page screenshot
    wait for page to load	
	
verify that the Time read from Eniq DS table is the server's time
	[Arguments]    ${status}
	${time}=    get time    hour
	Log    ${time}
	should contain    ${status}    ${time}
	[Return]    ${time}
	wait for page to load
	capture page screenshot
	
Suite setup steps for pmalarm
	 Set Screenshot Directory   ./Screenshots
	 Set Selenium Implicit Wait        60s
	 Install Utility mobule in web player
	 Close Browser	 
	 open pm alarm analysis
	 change the mode to       Editing
	 Connect to DB and sync with eniq
	 Save the analysis file
	 Close browser

Suite teardown steps for pmalarm
    Close browser

Test teardown steps for pmalarm
    Capture page screenshot
	Close browser
	 
Save the analysis file 
    #Click element     xpath://img[@title='Home']
	Sleep     2s
    click element       xpath://div[@title='File']
    click element       xpath://div[@title='Save as']
    click element       xpath://div[@title='Library item...']
    sleep     3s
    click element       xpath://div[text()='Save' and @class='sfx_button-text_564']
    sleep     20s
    click element       xpath://button[text()='Yes']
    sleep     5s
    click element       xpath://button[text()='Yes']
    sleep     10s
    wait for page to load
	
####################################################################################################################