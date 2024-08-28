*** Keywords ***

Open chrome browser
    Set Selenium Implicit Wait       300s
    ${chrome_options}=    Evaluate    sys.modules['selenium.webdriver'].ChromeOptions()      sys
	Call Method    ${chrome_options}    add_argument    --ignore-certificate-errors
	Create Webdriver    Chrome          options=${chrome_options}
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
	#run keyword and ignore error    navigate to this section    Home
	#run keyword and ignore error    click on the button    Home															 
    Wait Until Page Contains Element      xpath://input[@value='Alarm Rules Manager']     timeout=1500
    wait for page to load
    capture page screenshot
	
open pm alarm analysis with another username
    [Arguments]      ${user_name}=Administrator1     ${password}=Ericsson01
    ${chrome_options}=    Evaluate    sys.modules['selenium.webdriver'].ChromeOptions()      sys
	Call Method    ${chrome_options}    add_argument    --ignore-certificate-errors
	Create Webdriver    Chrome    options=${chrome_options}
    Go To    ${base_url}   
    Maximize Browser Window
    Sleep    5
    Selenium2Library.Input Text    name:username    ${user_name}
    Selenium2Library.Input Text    name:password    ${password}
    Click Element    class:LoginButton
    Sleep    5
    Go To    ${base_url}${pma_url}
    sleep    15
    ${IsElementVisible}=    Run Keyword And Return Status    Element Should not be Visible    xpath://div[contains(text(),'Missing Data')]
	Run Keyword If    ${IsElementVisible} is ${FALSE}   Close missing data window
	run keyword and ignore error    navigate to this section    Home
	run keyword and ignore error    click on the button    Home															 
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
     Mouse Over      xpath://div[text()='MeasuresName']
     sleep      1s
     FOR    ${i}    IN RANGE    0     50
         ${status}=     Run Keyword And Return Status        Element should be visible          xpath://div[@title='${node_type}']
         IF   ${status} is ${TRUE}
               Exit For Loop
         ELSE
               Run keyword if      ${status}==False      Click on scroll up button    0    15
         END
    END
    Click Element      xpath://div[@row='1' and @column='0']
    sleep    5s
    Click on Deactivate button
    ${alarm_state}=       Selenium2Library.Get text      xpath://div[@row='1' and @column='5']
    Should contain        ${alarm_state}          Inactive

Click on Export button
     Click on scroll down button     4       10
	 sleep    5s			
     Click Element     xpath://input[@value='Export']
     sleep    5s 
	 Element Should Be Visible        xpath://span[contains(text(),'Rules exported to')]  
	    
Export any alarm and validate successful export message
    Mouse Over      xpath://div[text()='MeasuresName']
    sleep      1s
    FOR    ${i}    IN RANGE    0     50
        ${status}=     Run Keyword And Return Status        Element should be visible          xpath://div[@row='1' and @column='0']
        IF   ${status} is ${TRUE}
              Exit For Loop
        ELSE
              Run keyword if      ${status}==False      Click on scroll up button    0    15
        END
    END
    Click Element      xpath://div[@row='1' and @column='0']
    sleep    3s
    Click on scroll down button    4    5
    sleep    2s
    Click on Export button
    sleep    3s
    Element Should Be Visible        xpath://span[contains(text(),'Rules exported to')]
    wait for page to load
    capture page screenshot
     
Select any alarm
     Click Element      xpath://div[@row='1' and @column='2']
     sleep    5s
     
Click on Import button
     Click on scroll down button     4       10
     Click Element     xpath://input[@value='Import']
     sleep    5s 
 
Verify error message when creating the alarm without collection name
    click on scroll up button    0     30
	sleep    2s
    Clear Element Text      xpath:(//input[contains(@class,'sf-element sf-element-control sfc-property sfc-text-box')])[1]
	sleep    3s
	Click on Create button
	Wait Until Page Contains Element      xpath://*[contains(text(),'Collection name is Required')]    100
	element should be visible    xpath://*[contains(text(),'Collection name is Required')]
	wait for page to load
	capture page screenshot
	
Verify error message when saving the alarm without collection name
	sleep    2s
    Clear Element Text      xpath:(//input[contains(@class,'sf-element sf-element-control sfc-property sfc-text-box')])[1]
	sleep    3s
	Click on Save button
	Wait Until Page Contains Element      xpath://*[contains(text(),'Collection name is Required')]    100
	element should be visible    xpath://*[contains(text(),'Collection name is Required')]
	wait for page to load
	capture page screenshot
    
Click on Cancel button in edit page
    Click element     xpath: (//input[@value='Cancel'])[2]
    Sleep     30s 
    wait for page to load

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
    click on scroll down button    7    10
    sleep    5s
	Wait Until Element Is Visible      xpath://input[@value='Import Alarm Rules']              timeout=30																																																																												
    Click element      xpath://input[@value='Import Alarm Rules']
	sleep    10s			
    capture page screenshot

Validate alarm rule imported is displayed in import result
	sleep     2s
    ${count}=     Get Element count       xpath : //div[@title='Maximize visualization']
    FOR    ${i}    IN RANGE    1     ${count}+1  
        Mouse Over      xpath://div[@title='Import Result']
	    capture page screenshot
		sleep     2s
        Click element       xpath: (//div[@title='Maximize visualization'])[${i}]
		sleep     2s
	    ${status}    ${msg}=     Run Keyword And Ignore Error     Element should be visible      xpath://div[@title='Import Result']
        IF      '${status}'=='PASS'
            Exit For Loop
		ELSE	
            Click on minimise window button     0
			sleep     5s
        END
    END
	sleep    2s
    ${window}=      set variable       Import Result
    ${alarm_rule} =        Selenium2library. Get text        xpath://div[@row='1' and @column='0']
    ${status} =        Selenium2library. Get text        xpath://div[@row='1' and @column='1']
    ${msg} =        Selenium2library. Get text        xpath://div[@row='1' and @column='2']
    Should contain        ${status}       Import Successful
    wait for page to load
    capture page screenshot
     
Assign nodes/collections to alarm rule
    ${window}=      set variable       Step 2 - Assign Nodes/Collection to Alarm Rules
    @{element}=    Get WebElements	    xpath://div[@class='ComboBoxTextDivContainer']
    ${data_source}=        Get from list     ${element}    1
    ${Single Node_Collection_SubNetwork}=        Get from list     ${element}    2
    ${Collection}=        Get from list     ${element}    3
    ${count}=     Get Element count       xpath : //div[@title='Maximize visualization']
    FOR    ${i}    IN RANGE    1     ${count}+1  
        Mouse Over      xpath://div[@title='Step 2 - Assign Nodes/Collection to Alarm Rules']
	    capture page screenshot
		sleep     2s
        Click element       xpath: (//div[@title='Maximize visualization'])[${i}]
		sleep     2s
	    ${status}    ${msg}=     Run Keyword And Ignore Error     Element should be visible      xpath://div[@title='Step 2 - Assign Nodes/Collection to Alarm Rules']
        IF      '${status}'=='PASS'
            Exit For Loop
		ELSE	
            Click on minimise window button     0
			sleep     5s
        END
    END
    sleep  2s
    Click element        xpath:(//div[@class='ComboBoxTextDivContainer'])[1]
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
    sleep     2s	
    Click on minimise window button     0
	sleep     2s
    ${count}=     Get Element count       xpath : //div[@title='Maximize visualization']
    FOR    ${i}    IN RANGE    1     ${count}+1  
        Mouse Over      xpath://div[@title='Alarm Rules - To Be Imported']
	    capture page screenshot
		sleep     2s
        Click element       xpath: (//div[@title='Maximize visualization'])[${i}]
		sleep     2s
	    ${status}    ${msg}=     Run Keyword And Ignore Error     Element should be visible      xpath://div[@title='Alarm Rules - To Be Imported']
        IF      '${status}'=='PASS'
            Exit For Loop
		ELSE	
            Click on minimise window button     0
			sleep     5s
        END
    END
    Click element       xpath://div[@row='1' and @column='0']
	sleep     2s
    Click on minimise window button     0
	sleep     2s
    ${count_01}=     Get Element count       xpath : //div[@title='Maximize visualization']
    FOR    ${i}    IN RANGE    1     ${count_01}+1  
        Mouse Over      xpath://div[@title='Step 2 - Assign Nodes/Collection to Alarm Rules']
	    capture page screenshot
		sleep     2s
        Click element       xpath: (//div[@title='Maximize visualization'])[${i}]
		sleep     2s
	    ${status}    ${msg}=     Run Keyword And Ignore Error     Element should be visible      xpath://div[@title='Step 2 - Assign Nodes/Collection to Alarm Rules']
        IF      '${status}'=='PASS'
            Exit For Loop
		ELSE	
            Click on minimise window button     0
			sleep     5s
        END
    END
    sleep  2s
    capture page screenshot
    Click element      xpath://input[@value='Assign Nodes/Collection']
	wait for page to load
    sleep    20s    
    Click on minimise window button     0
    sleep     3s
    capture page screenshot
    
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

Delete the collection
    Click element  	    xpath: //input[@value='Delete Collection']
    sleep    5s
	Click element       xpath://*[@class='deleteCollectionsInput' and text()='Delete']
    sleep    5s

Delete the collection and verify collection is removed
     [Arguments]    ${collName}
     wait for page to load
     Click on collection        ${collName}
     sleep    5s
     Click on delete button
     sleep   10s
     @{element}=    Get WebElements	    xpath: //div[@row='1' and @column='1']
     ${collection}=        Get from list     ${element}    0
     ${collection_name_new}=      Selenium2library.Get text          ${collection}
     Log     ${collection_name_new}
     Should not match        ${collName}          ${collection_name_new}
     capture page screenshot
          
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
    Click on scroll down button     0    5 								   
    Click Element      xpath://input[@value='Alarm Rules Manager']
    wait for page to load
    capture page screenshot
   
Click on Node Collection manager button
    Click on scroll down button     0     5
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
    Sleep   2	  
	Run keyword and ignore error      Wait Until Element Is Not Visible      xpath://*[@class='sf-svg-loader-12x12']              timeout=30  
    Run keyword and ignore error      Wait Until Element Is Not Visible     class:sfx_progress-bar-container_1118       timeout=3000
	Run keyword and ignore error      Wait Until Element Is Not Visible      xpath://*[@class='sf-svg-loader-12x12']              timeout=30  

	 
    
Set up ENM connection
     ${window}=      set variable       Setup ENM Connection
     Click element      xpath:(//img[@title='Administration'])
     sleep    5s
     wait until element is visible    xpath: //*[contains(text(),'Setup ENM Connection')]
     Click on scroll down button     3    15
     sleep     2s
     Clear Element Text    xpath://input[@id='eff93c4cd0ac4bcd879ea7381f4912f1']
     sleep     2s
     Selenium2Library.Input Text    xpath://input[@id='eff93c4cd0ac4bcd879ea7381f4912f1']       ieatenm5426-9.athtem.eei.ericsson.se
     sleep     2s
     wait until element is visible    xpath: //input[@id='58fc35ed419744b6b884498582a8c2fd']    30
     Click element    xpath://input[@id='58fc35ed419744b6b884498582a8c2fd']
     Clear Element Text    xpath://input[@id='58fc35ed419744b6b884498582a8c2fd']
     sleep     2s
     Selenium2Library.Input Text    xpath://input[@id='58fc35ed419744b6b884498582a8c2fd']       Administrator
     sleep     2s
     wait until element is visible    xpath: //input[@id='934a079597b24cecaf1c5c7ef7093e67']    30
     Click element    xpath://input[@id='934a079597b24cecaf1c5c7ef7093e67']
     Clear Element Text    xpath://input[@id='934a079597b24cecaf1c5c7ef7093e67']
     sleep     2s
     Selenium2Library.Input Text    xpath://input[@id='934a079597b24cecaf1c5c7ef7093e67']       TestPassw0rd
     sleep    2
     wait until element is visible    xpath: (//input[@class="sf-element sf-element-control sfc-property sfc-text-box"])[8]    30
     Click element    xpath: (//input[@class="sf-element sf-element-control sfc-property sfc-text-box"])[8]
     Clear Element Text    xpath: (//input[@class="sf-element sf-element-control sfc-property sfc-text-box"])[8]
     sleep    2
     Selenium2Library.Input Text    xpath: (//input[@class="sf-element sf-element-control sfc-property sfc-text-box"])[8]       eniq_oss_1
     sleep     2s
     wait until element is visible    xpath: (//div[@class="ComboBoxTextDivContainer"])    30
     Click element      xpath: (//div[@class="ComboBoxTextDivContainer"])
     wait until element is visible    xpath: //div[@title='NetAn_ODBC']     30
     Click element      xpath://div[@title='NetAn_ODBC']    
     sleep     3s
     Click on scroll down button     3    5
     wait until element is visible    xpath: //input[@id='fe705601231145a1b13adaa8b06a78f0']    30
     Click Element      xpath://input[@id='fe705601231145a1b13adaa8b06a78f0']
     sleep      20s
     FOR    ${i}    IN RANGE    0     5
         ${text}=      Selenium2Library.Get Text      xpath://span[@id='ENMConnectionStatus']
         
         Click on scroll down button     3    5
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
    Wait Until Page Contains Element      xpath: //img[@title='Administration']     150
    Click element     xpath://img[@title='Administration']
    wait for page to load
	validate the page title    Administration
	run keyword and ignore error    Click on minimise window button    0
	capture page screenshot

Click on Settings button
    Wait Until Page Contains Element      xpath: //img[@title="Settings"]     timeout=1500
    Click element     xpath://img[@title="Settings"]
    Sleep    20s
	capture page screenshot	
    
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
    Click on button    Remove
    sleep    5s
	Wait Until Page Contains Element      xpath: (//label[@class="deleteConnectionsInput"])[2]    30
    Click element       xpath: (//label[@class="deleteConnectionsInput"])[2]																								
    sleep    5
	Wait Until Page Contains Element      xpath: (//label[@class="deleteConnectionsInput"])[3]    30
    Wait Until element is visible      xpath: (//label[@class="deleteConnectionsInput"])[3]    30
    Wait Until element is enabled      xpath: (//label[@class="deleteConnectionsInput"])[3]    30
    Click element       xpath: (//label[@class="deleteConnectionsInput"])[3]																								
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
    Click element  	    xpath://label[contains(text(),'Delete') and @class= 'deleteCollectionsInput']


    
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
    [Arguments]    ${collection_name}
	[Return]    ${collection_name}
	place the cursor on    CollectionName
    Click on maximise window button     0
	sleep    5
	run keyword and ignore error    click on scroll up button    0     80
	Wait Until Page Contains Element      xpath://*[contains(text(),'${collection_name}')]     timeout=1500
	Click element      xpath://*[contains(text(),'${collection_name}')]
	sleep    5
	place the cursor on    CollectionName
	sleep    3
    click on the button    Restore visualization layout
	wait for page to load
	capture page screenshot
      
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
      wait for page to load	  
   	
Validate if the contents are same in edit page
    [Arguments]    ${alarm_name}    ${sys_area}    ${node_type}    ${alarm_type}    ${measure}
    sleep    3s
	Wait Until Element Is Visible      xpath://input[@value="${alarm_name}"]     60
    Element should be visible      xpath://input[@value="${alarm_name}"]
    Element should be visible      xpath://*[contains(text(),'${sys_area}')]
    Element should be visible      xpath://*[contains(text(),'${node_type}')]
    Element should be visible      xpath://*[contains(text(),'${measure}')]
    ${status1}=      Run keyword and return status       Element should be visible          xpath://input[@value="${alarm_name}"] 
    ${status2}=      Run keyword and return status       Element should be visible          xpath://div[@title="${alarm_type}"] 
	${status3}=      Run keyword and return status       Element should be visible          xpath://span[contains(text(),'${sys_area}')]
	${status4}=      Run keyword and return status       Element should be visible          xpath://span[contains(text(),'${node_type}')]
	${status5}=      Run keyword and return status       Element should be visible          xpath://span[contains(text(),'${measure}')]
	Run keyword IF     ${status1}==False     FAIL      msg= Alarm name is not Editable
    Run keyword IF     ${status2}==False     FAIL      msg= Alarm type is not Editable
    Run keyword IF     ${status3}==False     FAIL      msg= System Area is Editable
    Run keyword IF     ${status4}==False     FAIL      msg= Node type is Editable
    Run keyword IF     ${status5}==False     FAIL      msg= Measure is Editable
    Click on Cancel button
    wait for page to load
    capture page screenshot

Validate the controls in edit page
    [Arguments]    ${alarm_name}
    Click on Edit button
    sleep    3s
    Select Single node or Collection or Subnetwork in edit page      Collection
	Wait Until Element Is Visible      xpath://*[contains(text(),'Node Collection')]     60
    Element should be visible      xpath://*[contains(text(),'Node Collection')]
    Element should be visible      xpath://div[@title="(None)"]
    Select Single node or Collection or Subnetwork in edit page      Single Node
	Wait Until Element Is Visible      xpath://input[@value="Fetch Nodes"]     60
    Element should be visible      xpath://input[@value="Fetch Nodes"]
    Element should be visible      xpath://div[@title="(All) 0 values"]
    Click on fetch nodes button
    Select Nodes as     G2RBS01
    Click on Apply changes button
    Click on Save button
    Select Alarm       ${alarm_name}
    Click on Edit button
    Select Single node or Collection or Subnetwork in edit page      Collection
	Wait Until Element Is Visible      xpath://*[contains(text(),'Node Collection')]     60
    Element should be visible      xpath://div[@title="(None)"]
    Select Single node or Collection or Subnetwork in edit page      SubNetwork
	Wait Until Element Is Visible      xpath://*[contains(text(),'Select a single SubNetwork to proceed')]     60
    Element should be visible      xpath://*[contains(text(),'Select a single SubNetwork to proceed')]
    Element should be visible      xpath://div[@title="ERBS-SUBNW-1"]
	Wait Until Page Contains Element      xpath://*[contains(text(),'(All)') and @class="sf-element-list-box-item sfpc-selected"]      60
    Element should be visible      xpath://*[contains(text(),'(All)') and @class="sf-element-list-box-item sfpc-selected"]      60
    capture page screenshot
	Wait Until Element Is Visible      xpath://*[contains(text(),'Select a single SubNetwork to proceed')]     60
    Element should be visible      xpath://*[contains(text(),'Select a single SubNetwork to proceed')]
    Click on Apply changes button
    sleep     2s
    wait for page to load
    Element should be visible      xpath://*[contains(text(),'Alarm Details')]
    Select Single node or Collection or Subnetwork in edit page      Single Node
	Wait Until Element Is Visible      xpath://input[@value="Fetch Nodes"]     60
    Click on fetch nodes button
    Click element      xpath://div[@title='G2RBS01']
    Click element      xpath://div[@title='G2RBS04']      modifier=CTRL
	Wait Until Element Is Visible      xpath://*[contains(text(),'Select a single node to proceed')]     60
    Element should be visible      xpath://*[contains(text(),'Select a single node to proceed')]
    Click on Apply changes button
    sleep     2s
    wait for page to load
    Element should be visible      xpath://*[contains(text(),'Alarm Details')]
    capture page screenshot

Verify if the fetch nodes and import nodes from file should be disabled before selecting Node Type and System Area
    sleep    3s
    Click on scroll down button    0     25
    sleep    3s
    ${status1}=      Run keyword and return status       Click element     xpath: //input[@value='Fetch nodes']
    ${status2}=      Run keyword and return status       Click element     xpath: //input[@value='Import nodes from File']
	Run keyword IF     ${status1}==True     FAIL      msg= Fetch nodes button is enabled
    Run keyword IF     ${status2}==True     FAIL      msg= Import nodes from file button is enabled
    wait for page to load
    capture page screenshot

Verify if the fetch nodes and import nodes from file should be enabled after selecting Node Type and System Area
    sleep    3s
    ${status1}=      Run keyword and return status       Click element     xpath: //input[@value='Fetch nodes']
    ${status2}=      Run keyword and return status       Click element     xpath: //input[@value='Import nodes from File']
	Run keyword IF     ${status1}==False     FAIL      msg= Fetch nodes button is disabled
    Run keyword IF     ${status2}==False     FAIL      msg= Import nodes from file button is disabled
    wait for page to load
    capture page screenshot

Verify node type system area and single or collection node in alarm column
    [Arguments]    ${alarm_name}     ${node_type}       ${sys_area}       ${alarm_type}
    sleep    2s
    FOR    ${i}    IN RANGE    0     10
         ${status}=     Run Keyword And Return Status        Element should be visible         xpath://div[contains(text(),'${alarm_name}')]
         IF   ${status} is ${TRUE}
               Exit For Loop
         ELSE
               Run keyword if      ${status}==False      Click on scroll down button    0    15
         END
    END    
    Click element      xpath://div[contains(text(),'${alarm_name}')]
    Sleep     1s
    ${count}=     Get Element count       xpath : //div[@column='0']
    FOR    ${i}    IN RANGE    ${count}+1     1
         ${name}=     Selenium2library.Get text      xpath://div[@row='${i}' and @column='1']
         IF    '${name}'=='${alarm_name}'
                ${status}=     set variable      PASS
                Click on scroll right button    0    80
                ${node_type}=      Selenium2library.Get text      xpath://div[@row='${i}' and @column='2']
                ${sys_area}=      Selenium2library.Get text      xpath://div[@row='${i}' and @column='3']
                ${alarm_type}=      Selenium2library.Get text      xpath://div[@row='${i}' and @column='6']
                Should match      ${node_type}       Radio
                Should match      ${sys_area}       NR
                Should match      ${alarm_type}       Single Node
                Exit For Loop
         END
    END
    IF    '${status}'=='FAIL'
         FAIL      msg=Alarm not found in UI
    END
    Click on scroll left button    0    50
    wait for page to load
	Capture page screenshot

Verify collection is displayed in collection manager UI
      [Arguments]     ${data}       ${collection_name}
      Sleep     10s
      Mouse Over      xpath://div[text()='CollectionName']
      Click on maximise window button       0
      sleep      5s
      ${status}=     set variable      FAIL
      ${count}=     Get Element count       xpath : //div[@column='0']
      Mouse Over      xpath://div[text()='CollectionName']
      capture page screenshot
      FOR    ${i}    IN RANGE    1     ${count}
           ${name}=     Selenium2library.Get text      xpath://div[@row='${i}' and @column='1']
           IF    '${name}'=='${collection_name}'
                ${status}=     set variable      PASS
                ${node_type}=      Selenium2library.Get text      xpath://div[@row='${i}' and @column='2']
                ${sys_area}=      Selenium2library.Get text      xpath://div[@row='${i}' and @column='3']
                ${eniq_name}=      Selenium2library.Get text      xpath://div[@row='${i}' and @column='6']
                ${collection_type}=      Selenium2library.Get text      xpath://div[@row='${i}' and @column='7']
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
    Run keyword and ignore error    Wait Until Element Is Enabled          xpath: //div[@title='Restore visualization layout']      timeout=120s        
    Run keyword and ignore error    Click element      xpath: //div[@title='Restore visualization layout']
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
	Capture page screenshot
    wait for page to load
    Sleep     5s
	Capture page screenshot
	Click on minimise window button     0
    Sleep     10s
    
Navigate to Home page
    ${count}=      Get Element Count       xpath: //img[@title='Home']
    IF     ${count}>0
		  Navigate to this section    Home						   
          Click element     xpath://img[@title='Home']
          Sleep    20s
    ELSE    
          Click on minimise window button    0
          sleep    5s  
    END 
    
Click on scroll down button
    [Arguments]     ${button}    ${n}
    @{element}=    Get WebElements	    xpath: //div[@class="ScrollbarButton sf-element sf-element-scroll-bar-button sfpc-bottom"]
    ${scroll_button}=        Get from list     ${element}    ${button}
    FOR    ${i}    IN RANGE    0    ${n} 
           Run Keyword and Ignore Error    Click element     ${scroll_button}           
    END
	Sleep      2s
	capture page screenshot

click on scroll up button
    [Arguments]     ${button}    ${n}
    @{element}=    Get WebElements	    xpath: //div[@class='ScrollbarButton sf-element sf-element-scroll-bar-button sfpc-top']
    ${scroll_button}=        Get from list     ${element}    ${button}
    FOR    ${i}    IN RANGE    0    ${n} 
           Run Keyword and Ignore Error    Click element     ${scroll_button}           
    END
	Sleep      2s
	capture page screenshot

Click on scroll left button
    [Arguments]  ${button}    ${n}
    Wait Until Page Contains Element      xpath: //div[@class='ScrollbarButton sf-element sf-element-scroll-bar-button sfpc-left']     timeout=120
    @{element}=    Get WebElements	    xpath: //div[@class='ScrollbarButton sf-element sf-element-scroll-bar-button sfpc-left']
    ${scroll_button}=        Get from list     ${element}    ${button}
    FOR    ${i}    IN RANGE    0    ${n} 
           run keyword and ignore error    Click element     ${scroll_button}
           
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
	sleep    10s			

Click on Create collection button
	Wait Until Element Is Visible     xpath: //input[@value='Create Collection']    300
	Click element     xpath: //input[@value='Create Collection']
	wait for page to load
	
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
    wait for page to load
    capture page screenshot
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
    Click element      xpath://div[@title='${alarm_type}' and (@class='sf-element-dropdown-list-item sfpc-selected' or @class='sf-element-dropdown-list-item')]     
    
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
    sleep    5			  
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
  
Select System area and verify none value is not present
    [Arguments]     ${sys_area}
    Click on scroll down button    3      12
    sleep     3s
    @{element}=    Get WebElements	    xpath: //div[@class='ComboBoxTextDivContainer']
    ${sys_area_ele}=        Get from list     ${element}    4
    Click element     ${sys_area_ele}
    sleep    2s
    element should not be visible    xpath://div[contains(@class,'sf-element-dropdown-list-item') and @title="(None)"]
    sleep    2s
    Click element      xpath://div[@title='${sys_area}']   
    wait for page to load
    capture page screenshot
  
Select Collection name as
    [Arguments]      ${collection}    
    Click on scroll down button    3      12
    sleep     3s
    @{element}=    Get WebElements	    xpath: //div[@class='ComboBoxTextDivContainer']
    ${sys_area_ele}=        Get from list     ${element}    3
    Click element     ${sys_area_ele}
	Run keyword and ignore error       click on scroll up button    9       30
	${status}=    run keyword and return status    element should be visible    xpath: //div[@title='${collection}']    
	IF    "${status}"=="False"
		FOR    ${i}    IN RANGE    0    200
			click on scroll down button    9    5
			${status}=    run keyword and return status    element should be visible    xpath: //div[@title='${collection}']
			run keyword if    "${status}"=="True"    exit for loop
		END
	END
    Click element      xpath://div[@title='${collection}']
	capture page screenshot
    
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
	wait for page to load
    wait until element is visible    xpath: (//div[@class="ComboBoxTextDivContainer"])[6]    30
	click element    xpath: (//div[@class="ComboBoxTextDivContainer"])[6]
	sleep    5
	Run keyword and ignore error         click on scroll up button    9    30
	${status}=    run keyword and return status    element should be visible    xpath: (///div[(@class="sf-element-dropdown-list-item" or @class="sf-element-dropdown-list-item sfpc-selected") and @title="${node_type}"])
	IF    "${status}"=="False"
		FOR    ${i}    IN RANGE    0     20
			click on scroll down button    9    10
			${status1}=    run keyword and return status    element should be visible    xpath: (//div[(@class="sf-element-dropdown-list-item" or @class="sf-element-dropdown-list-item sfpc-selected") and @title="${node_type}"])
			run keyword if    "${status1}"=="True"    Exit for loop
		END
	END
	wait until element is visible    xpath: (//div[(@class="sf-element-dropdown-list-item" or @class="sf-element-dropdown-list-item sfpc-selected") and @title="${node_type}"])    30
	click element    xpath: (//div[(@class="sf-element-dropdown-list-item" or @class="sf-element-dropdown-list-item sfpc-selected") and @title="${node_type}"])
	wait for page to load
	capture page screenshot

Select Node type for subnetwork as
    [Arguments]     ${node_type}
    Sleep      10s
    @{element}=    Get WebElements	    xpath: //div[@class='ComboBoxTextDivContainer']
    ${node_type_ele}=        Get from list     ${element}    7
    Click element     ${node_type_ele}
    Click element      xpath://div[@title='${node_type}']     
    
Select Measure type as
    [Arguments]    ${list}
				  
	click on scroll up button       5        21
	@{measure_type}=      Split string      ${list}    ,
    ${InList}=    Get Match Count    ${measure_type}    COUNTER
    ${status}=     Run Keyword And Return Status        Element should be visible          xpath: (//div[@title="Counter"])
    Run keyword if    ${InList}!=1 and ${status}==True  Click element    xpath: (//div[@title="Counter"])
    sleep    2
    ${InList}=    Get Match Count    ${measure_type}    CUSTOM_KPI
    ${status}=     Run Keyword And Return Status        Element should be visible          xpath: (//div[@title="Custom KPI"])
    Run keyword if    ${InList}!=1 and ${status}==True    Click element    xpath: (//div[@title="Custom KPI"])
	sleep    2
    ${InList}=    Get Match Count    ${measure_type}    KPI
    ${status}=     Run Keyword And Return Status        Element should be visible          xpath: (//div[@title="KPI"])
    Run keyword if    ${InList}!=1 and ${status}==True    Click element    xpath: (//div[@title="KPI"])
    Sleep   2s
    ${InList}=    Get Match Count    ${measure_type}    RI
    ${status}=     Run Keyword And Return Status        Element should be visible          xpath: (//div[@title="RI"])
    Run keyword if    ${InList}!=1 and ${status}==True    Click element    xpath: (//div[@title="RI"])
	Sleep   2s
    ${InList}=    Get Match Count    ${measure_type}    FLEX_COUNTER
    ${status}=     Run Keyword And Return Status        Element should be visible          xpath: (//div[@title="Flex Counter"])
    Run keyword if    ${InList}!=1 and ${status}==True    Click element    xpath: (//div[@title="Flex Counter"])
	Sleep   2s
    ${InList}=    Get Match Count    ${measure_type}    FLEX+PDF_COUNTER
    ${status}=     Run Keyword And Return Status        Element should be visible          xpath: (//div[@title="Flex+PDF Counter"])
    Run keyword if    ${InList}!=1 and ${status}==True    Click element    xpath: (//div[@title="Flex+PDF Counter"])
	Sleep   2s
    ${InList}=    Get Match Count    ${measure_type}    PDF_COUNTER
    ${status}=     Run Keyword And Return Status        Element should be visible          xpath: (//div[@title="PDF Counter"])
    Run keyword if    ${InList}!=1 and ${status}==True    Click element    xpath: (//div[@title="PDF Counter"])													   
    click on scroll down button       5        21
    wait for page to load
    capture page screenshot
    
Click on fetch nodes button in Node collection manager
    Click on scroll down button    0     30
    Click element     xpath: //input[@value='Fetch nodes']
    Sleep     20s    


Click on fetch nodes button in Alarm rules manager
    Click on scroll down button    5     20
    Click element     xpath: //input[@value='Fetch Nodes']
    Sleep     20s 
    
Select Nodes as
    [Arguments]    @{node_list}
    Click on scroll down button     5    9
    FOR    ${node}    IN    @{node_list}
		   Wait Until Element Is Visible      xpath: //tr[@class='singleNode']//span[@class='HtmlTextAreaControl sf-element sf-element-filter-content']//input    30																																					  
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
    Click on scroll down button     5    15
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
           run keyword and ignore error    Click element     ${scroll_button}
           
    END    
    
Select measures
    [Arguments]    ${measure_list}
    @{list}=      Split string      ${measure_list}    ,
    FOR    ${measure}    IN    @{list}
		   ${status}=    run keyword and return status    element should be visible    xpath: (//div[@class="sf-list-box-container VirtualListBox sf-suppress-forms-accept-command sf-suppress-forms-cancel-command sf-focusable"])[4]//input
		   IF    "${status}"=="False"
				click on scroll down button    5    16
		   END
           Clear Element Text      xpath:(//div[@class="sf-list-box-container VirtualListBox sf-suppress-forms-accept-command sf-suppress-forms-cancel-command sf-focusable"])[4]//input
		   wait until element is visible    xpath: (//div[@class="sf-list-box-container VirtualListBox sf-suppress-forms-accept-command sf-suppress-forms-cancel-command sf-focusable"])[4]//input    30
           sleep    2
		   wait until element is visible    xpath: (//div[@class="sf-list-box-container VirtualListBox sf-suppress-forms-accept-command sf-suppress-forms-cancel-command sf-focusable"])[4]//input    30
		   Selenium2Library.Input Text     xpath:(//div[@class="sf-list-box-container VirtualListBox sf-suppress-forms-accept-command sf-suppress-forms-cancel-command sf-focusable"])[4]//input    ${measure}
		   sleep    2		 
           wait until element is visible    xpath: (//div[@title="Click to search"])[4]    30
		   click element    xpath: (//div[@title="Click to search"])[4]
           sleep    5s
		   ${status}    ${msg}=     Run Keyword And Ignore Error     Element should be visible      xpath: (//div[contains(text(),'${measure}') or contains(@title,'${measure}')])
			     IF      '${status}'=='PASS'
						wait until element is visible    xpath: (//div[contains(text(),'${measure}') or contains(@title,'${measure}')])    10
			            Click element      xpath: (//div[contains(text(),'${measure}') or contains(@title,'${measure}')])
			     ELSE
			            wait until element is visible    xpath: (//div[@title="Click to search"])[4]    5
						click element    xpath: (//div[@title="Click to search"])[4]
						wait until element is visible    xpath: (//div[contains(text(),'${measure}') or contains(@title,'${measure}')])    5
						click element    xpath: (//div[contains(text(),'${measure}') or contains(@title,'${measure}')])
			     END
		   click on scroll down button    5    8				 
           sleep   1s
           Click element      xpath://input[@value='Add Measure']
		   capture page screenshot
           sleep   1s
		   click on scroll up button    5    8
     END
	 click on scroll down button    5    8
	 wait for page to load
	 capture page screenshot
         
Select Look back period unit as
    [Arguments]     ${look_back_period_unit}
    Sleep      10s
    @{element}=    Get WebElements	    xpath: //div[@class='ComboBoxTextDivContainer']
    ${ele}=        Get from list     ${element}    12
	wait until element is visible     ${ele}
    Click element     ${ele}
	wait until element is visible    xpath: //div[@title='${look_back_period_unit}']    30
	sleep    2
    Click element      xpath: //div[@title='${look_back_period_unit}']
	${status}=    run keyword and return status    element should not be visible    xpath: //div[@title='${look_back_period_unit}']
	IF    "${status}"=="False"
		wait until element is visible    xpath: (//div[@class="ListItems"])[6]//div[@title="${look_back_period_unit}"]    30
		Click element      xpath: (//div[@class="ListItems"])[6]//div[@title="${look_back_period_unit}"]
	END
	capture page screenshot
    
Select Date range unit as
    [Arguments]     ${date_range_unit}
    Sleep      10s
    @{element}=    Get WebElements	    xpath: //div[@class='ComboBoxTextDivContainer']
    ${ele}=        Get from list     ${element}    13
	wait until element is visible     ${ele}
    Click element     ${ele}
	wait until element is visible    xpath: //div[@title='${date_range_unit}' and (@class='sf-element-dropdown-list-item sfpc-selected' or @class='sf-element-dropdown-list-item')]    30
    Click element      xpath: //div[@title='${date_range_unit}' and (@class='sf-element-dropdown-list-item sfpc-selected' or @class='sf-element-dropdown-list-item')] 
    sleep   2s
	${status}=    run keyword and return status    element should not be visible    xpath: //div[@title='${date_range_unit}' and (@class='sf-element-dropdown-list-item sfpc-selected' or @class='sf-element-dropdown-list-item')]
	IF    "${status}"=="False"
		wait until element is visible    xpath: //div[@title='${date_range_unit}' and (@class='sf-element-dropdown-list-item sfpc-selected' or @class='sf-element-dropdown-list-item')]    30
		Click element      xpath: //div[@title='${date_range_unit}' and (@class='sf-element-dropdown-list-item sfpc-selected' or @class='sf-element-dropdown-list-item')]
	END
	capture page screenshot	
    
Enter Look back period
    [Arguments]     ${look_back_period}
    @{element}=    Get WebElements	    xpath: //input[@class='sf-element sf-element-control sfc-property sfc-text-box']
    ${ele}=        Get from list     ${element}     2
    Clear Element Text     ${ele}
    sleep    2s
    Selenium2Library.Input Text      ${ele}      ${look_back_period}
	capture page screenshot
    
Enter Date range
    [Arguments]     ${date_range}
    @{element}=    Get WebElements	    xpath: //input[@class='sf-element sf-element-control sfc-property sfc-text-box']
    ${ele}=        Get from list     ${element}     3
    Clear Element Text     ${ele}
    sleep    2s
    Selenium2Library.Input Text      ${ele}      ${date_range}
	capture page screenshot
    
Enter specific problem
    [Arguments]     ${specific_problem}      ${alarm_name}=NA
    Clear Element Text       xpath://textarea[@class='sf-element sf-element-control sfc-property sfc-text-box']    
    Selenium2Library.Input Text      xpath://textarea[@class='sf-element sf-element-control sfc-property sfc-text-box']       ${alarm_name}-${specific_problem}
    wait for page to load
    Capture page screenshot

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
    Sleep     10s 
    Click element     xpath: //input[@value='Activate']
    Sleep    30s
    Capture page screenshot
    
Select Alarm
    [Arguments]     ${alarm_name} 
    Mouse Over      xpath://div[text()='MeasuresName']
    sleep    2s
    Click on scroll down button    1     200
    
    Click element     xpath://div[text()='${alarm_name}']
    Capture page screenshot

Verify specific problem is changed
    [Arguments]     ${alarm_name}          ${specific_problem}
    Mouse Over      xpath://div[text()='MeasuresName']
    sleep    2s
    Click on scroll down button    1     200
    Click element     xpath://div[text()='${alarm_name}']
    ${row}=       Get Element Attribute            xpath://div[text()='${alarm_name}']/..       row
    ${sp}=      Get cell value        SpecificProblem        ${row}
    Should contain        ${sp}          ${specific_problem}
    Should contain        ${sp}          ${alarm_name}
    Capture page screenshot
         
Verify alarm is not displayed in UI
    [Arguments]     ${alarm_name} 
    Mouse Over      xpath://div[text()='MeasuresName']
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
	 Capture page screenshot					 
     
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
     ${status}=    run keyword and return status    element should not be visible	    xpath: (//span[@class="ng-binding ng-scope" and contains(text(),'${worker_file}')])
     Log    ${status}
     IF    "${status}"=="True"
     	Schedule worker file for PM_ALARM     ${worker_file}
     ELSE
     	@{element}=    get webelements    xpath: (//tr[@class="tss-table-row-item"])
     	FOR    ${ele}    IN    @{element}
        	 ${text}=    Selenium2Library.Get Text   ${ele}
         	 Log    ${text} 
         	 ${status}    ${msg}=     Run Keyword And return status     Should contain    ${text}      ${worker_file}
         	 IF      '${status}'=='True' 
                 Exit for loop
         	 END
		 
         	 IF      '${status}'=='False'   
                 Schedule worker file for PM_ALARM     ${worker_file}
                 exit for loop
     	 	 END
      	END 
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
     Click element    xpath: (//div[@class="browse-input-button ng-binding"])[1]
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
		${text}=    convert to string    ${text}
		${col}=    convert to string    ${col}
		${status}=    run keyword and return status    should contain    ${text}    ${col}
        ${cell_value}=    Run Keyword If     "${status}" == "True"     Selenium2Library.Get Text  xpath://div[@name='valueCellCanvas' or @name='frozenRowsCanvas']//div[@row='${row}' and @column='${count}']     
        Run Keyword If     "${status}" == "True"    exit for loop
        ${count}=   Evaluate    ${count} + 1        
		
    END
    Log     ${cell_value} 
    [return]  ${cell_value}   
   
Verify alarm criteria
     ${criteria}=     set variable     0
	 Click on scroll left button    0    20									
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
	wait until element is visible    xpath: (//td[contains(text(),'Select ENIQ data source')])    30
	click element    xpath: (//td[contains(text(),'Select ENIQ data source')])
	sleep    2
    @{element}=    Get WebElements	    xpath: //div[@class='ComboBoxTextDivContainer']
    ${data_source_ele}=        Get from list     ${element}    0
    Click element     ${data_source_ele}
    sleep    2
    Click element      xpath://div[@title='${data_source}' and contains(@class,'sf-element-dropdown-list-item')]
	sleep    2
    capture page screenshot
    wait for page to load
    
Select Node type for collection manager
    [Arguments]     ${node_type}
    Click on scroll down button    0     5
    Sleep    5
    @{element}=    Get WebElements	    xpath: //div[@class='ComboBoxTextDivContainer']
    ${node_type_ele}=        Get from list     ${element}    2
    Click element     ${node_type_ele}
	sleep    2	
	${status}=    run keyword and return status    element should be visible    xpath: (//div[@class="sf-element-dropdown-list-item" and @title="${node_type}"])
	IF    "${status}"=="False"
		FOR    ${i}    IN RANGE    0     20
			click on scroll down button    10    5
			${status1}=    run keyword and return status    element should be visible    xpath: (//div[@class="sf-element-dropdown-list-item" and @title="${node_type}"])
			run keyword if    "${status1}"=="True"    Exit for loop
		END
	END
	wait until element is visible    xpath: (//div[@class="sf-element-dropdown-list-item" and @title="${node_type}"])    30
	click element    xpath: (//div[@class="sf-element-dropdown-list-item" and @title="${node_type}"])	
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
	
click on Active button
	[Arguments]    
	sleep     5
	Wait Until Element Is Visible     xpath: //*[@title='Active']    300
    Click element     xpath: //*[@title='Active']
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
	${msg}=    selenium2library.get text    xpath://*[contains(text(),'Collection name already exists')]				 
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
	Click on scroll down button    2    20
	${msg}=    selenium2library.get text    xpath: //*[contains(text(),"Error")]
    Log    ${msg}
    should contain    ${msg}    Error: Alarm Definition
    capture page screenshot
    wait for page to load
	
############################################ IMPROVEMENT EQEV-105271 END ############################################

############################################ IMPROVEMENT EQEV-103913 ############################################

textfield to enter Wildcard Expression should be visible
    Click on scroll down button    0       20
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
    Click on scroll down button    0      5
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
Navigate to Setup Data Source window
    Click on Administration button
    ${window}=      set variable       Setup Data Source
    Run keyword and ignore error    Wait Until Element Is Enabled          xpath: //div[@title='Restore visualization layout']      timeout=120s        
    Run keyword and ignore error    Click element      xpath: //div[@title='Restore visualization layout']
    Navigate to section         ${window}
	
verify that the connection to NetAn and ENIQ is made
    ${window}=      set variable       Setup Data Source
    Run keyword and ignore error    Wait Until Element Is Enabled          xpath: //div[@title='Restore visualization layout']      timeout=120s        
    Run keyword and ignore error    Click element      xpath: //div[@title='Restore visualization layout']
    Navigate to section         ${window} 
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
	${window}=      set variable       ENIQ Connection Status
    Run keyword and ignore error    Wait Until Element Is Enabled          xpath: //div[@title='Restore visualization layout']      timeout=120s        
    Run keyword and ignore error    Click element      xpath: //div[@title='Restore visualization layout']
    Navigate to section         ${window} 
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
	#Wait Until Element Is Visible     xpath:(//span[@class="admin"])[2]//input[@value="Delete"]    300
	#Click element     xpath:(//span[@class="admin"])[2]//input[@value="Delete"]
	sleep    5s
    click on next button
    Wait Until Element Is Visible     xpath://span[@id="deleteenable"]//input[@value="Remove"]    300
	Click element     xpath://span[@id="deleteenable"]//input[@value="Remove"]
	wait for page to load
	capture page screenshot
click on the delete confirmation button
    Wait Until Element Is Visible     xpath://label[text()='Delete']    30
    Sleep     5s
	Click element     xpath://label[text()='Delete']
	wait for page to load
	capture page screenshot										   
	
click on the failed ENIQ and click on delete
	[Arguments]    ${ds}
	${window}=      set variable       ENIQ Connection Status
    Run keyword and ignore error    Wait Until Element Is Enabled          xpath: //div[@title='Restore visualization layout']      timeout=120s        
    Run keyword and ignore error    Click element      xpath: //div[@title='Restore visualization layout']
    Navigate to section         ${window} 
	Wait Until Element Is Visible     xpath://div[text()='${ds}']    300
	Click element     xpath://div[text()='${ds}']
	capture page screenshot
	Click on Next Button
	Sleep     3s
	Capture page screenshot
	Wait Until Element Is Visible     xpath://span[@id='EnmToDeleteLabel']//span[text()='${ds}']  300
	Click element     xpath:(//input[@value='Remove'])[1]
	Sleep     3s
	Click element     xpath://label[text()='Delete']
	wait for page to load
	capture page screenshot
	
verify that the DataSource cant be deleted	
    Run Keyword And Ignore Error          Wait Until Element Is Not Visible        xpath://*[@class='sf-svg-loader-12x12']        timeout=300
	Run Keyword And Ignore Error          Wait Until Element Is Visible       xpath:(//div[@class='deleteConnectionDialog'])[1]         timeout=300
	${text1}=    Get Text    xpath:(//div[@class='deleteConnectionDialog'])[1]
	Log    ${text1}
	should contain    ${text1}    The delete action cannot be completed
	wait for page to load
	capture page screenshot
	
verify that the connection failed for 4140_ODBC
	${text1}=    Get Text    xpath:(//tr[@id="table-data"])[2]//td[6]//span
	Log    ${text1}
	should contain    ${text1}    Failed to connect with: 4140_ODBC,
	wait for page to load
	capture page screenshot	
	
verify that no exception occurred while trying to delete Failed_ODBC
	sleep    2
	Element Should not Be Visible    xpath://*[contains(text(),'Error in DataBase Connection')]	
	wait for page to load
	capture page screenshot
	
click on the connect button
	Wait Until Element Is Visible     xpath: //*[@value='Connect ']    300
    Click element     xpath: //*[@value='Connect ']
	wait for page to load
	capture page screenshot

click on the connect button to connect ENIQ DB
	Wait Until Element Is Visible     xpath: //*[@value='Connect']    300
    Click element     xpath: //*[@value='Connect']
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
	
verify that an error occurred while trying to add a DataSource without connecting to NETAN
	sleep    2
	Element Should Be Visible    xpath://*[contains(text(),'Please connect to NetAn DB before connection ENIQ')]	
	wait for page to load
	capture page screenshot
	
verify that the SubNetwork Viewer is added as a different Section	
	Element Should Be Visible    xpath:((//div[@class="HtmlTextArea sf-enable-selection sf-focusable"])[5]//font//p//font)[1]
	Element Should Be Visible    xpath:(//div[@class="sf-element sf-element-visual sfc-table sfpc-first-column"])[2]
	wait for page to load
	capture page screenshot
	
############################################ IMPROVEMENT EQEV-103914 END ############################################

############################################ IMPROVEMENT MR-108162 ############################################

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
    Click on collection     ${name}
					  
						
	
Verify that the Collection can be deleted if it's not being used
	 sleep     2
     element should be visible     xpath://*[contains(text(),'Selected Collection will be deleted, Do you want to proceed ?')]
     sleep    2
     click element    xpath://label[@class='deleteCollectionsInput'][contains(text(),'Delete')]
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
	Wait Until Page Contains Element      xpath:(//div[@class="ComboBoxTextDivContainer"])[11]    30
	click element    xpath:(//div[@class="ComboBoxTextDivContainer"])[11]
	sleep    4
	Element Should Be Visible    xpath:(//div[@class="DropdownListContainer sf-element-styled-dialog sfc-style-root prevent-flyout-close"])
	click element    xpath://*[contains(text(),'Critical')]
	wait for page to load
	capture page screenshot

validate that the dropdown Aggregation is working as expected
	Wait Until Page Contains Element      xpath:(//div[@class="ComboBoxTextDivContainer"])[12]    30
	click element    xpath:(//div[@class="ComboBoxTextDivContainer"])[12]
	sleep    4
	Element Should Be Visible    xpath:(//div[@class="DropdownListContainer sf-element-styled-dialog sfc-style-root prevent-flyout-close"])
	click element    xpath://*[contains(text(),'1 Day')]
	wait for page to load
	capture page screenshot

validate that the dropdown Probable Cause is working as expected
	Wait Until Page Contains Element      xpath:(//div[@class="ComboBoxTextDivContainer"])[16]    30
	click element    xpath:(//div[@class="ComboBoxTextDivContainer"])[16]
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
     
Click on measure types and verify the list of measures
    sleep    2
    click on scroll up button       5      20
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
	 click on scroll down button       1     2
     Wait Until Page Contains Element     xpath:(//div[@class="ComboBoxTextDivContainer"])[1]    300
	 Click element     xpath:(//div[@class="ComboBoxTextDivContainer"])[1]
	 sleep    3
	 Wait Until Page Contains Element     xpath:((//div[@class="ListItems"])//div[2])[3]    300
	 Click element     xpath:((//div[@class="ListItems"])//div[2])[3]
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
	click on scroll down button       10     10
    wait for page to load
    capture page screenshot

select node in Alarm Rules Import Manager
	click on scroll down button       10     6
    Wait Until Page Contains Element     xpath:(//div[@class="sf-element-list-box-item"])[2]    300
    Click element     xpath:(//div[@class="sf-element-list-box-item"])[2]
	capture page screenshot
	click on scroll down button       10     15
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
    Wait Until Page Contains Element     xpath://*[contains(text(),'To delete or edit, alarm state must be Inactive')]    300
	${text}=    get text    xpath://*[contains(text(),'To delete or edit, alarm state must be Inactive')]
	Log    ${text}
	should contain    ${text}    To delete or edit, alarm state must be Inactive
    wait for page to load
    capture page screenshot

select an activated alarm and click on delete
    Wait Until Page Contains Element    xpath:(//div[@class="sf-element sf-element-visual-content sfc-table"])//*[contains(text(),'Active')]
    Click element     xpath: (//div[@class="sf-element sf-element-visual-content sfc-table"])//*[contains(text(),'Active')]
    Sleep     2s 
    Click on scroll up button    4    5
    Sleep     2s 
    Click element     xpath: //input[@value='Delete']
    Sleep     2s
    wait for page to load
    Capture page screenshot

Validate if after changing System area value Node type is empty for Single Node
    [Arguments]     ${system_area_1}     ${system_area_2}
    Select System area as      ${system_area_2}
    Sleep     3s
    Wait Until Page Contains Element    xpath://div[@title="---"]    150
    element should be visible    xpath://div[@title="---"]
    Select System area as      ${system_area_1}
    wait for page to load
    Capture page screenshot
  
Validate if after changing System area value Node type is empty for SubNetwork
    [Arguments]     ${system_area_1}     ${system_area_2}
    Select System area for subnetwork as      ${system_area_2}
    Sleep     3s
    Wait Until Page Contains Element    xpath://div[@title="---"]    150
    element should be visible    xpath://div[@title="---"]
    Select System area for subnetwork as      ${system_area_1}
    wait for page to load
    Capture page screenshot

Validate if Measure listbox is updated only after System Area and Node Type value is entered
    Sleep     3s
	Wait Until Element Is Not Visible      xpath://div[@title="(All) 0 values"]     300
    Element Should Not Be Visible        xpath://div[@title="(All) 0 values"]
    wait for page to load
    Capture page screenshot

Validate if exception message is thrown when creating alarm without Alarm Name
    Sleep     3s
    Wait Until Page Contains Element    xpath://*[contains(text(),'Alarm Name required ')]    150
    element should be visible    xpath://*[contains(text(),'Alarm Name required ')]
    wait for page to load
    Capture page screenshot

Verify cancle button in deleted alarm message dialog box
    Wait Until Page Contains Element     xpath:(//label[@class="deletealarmclose"])[2]    300
    Click element     xpath:(//label[@class="deletealarmclose"])[2]
    Sleep    2s
	Wait Until Element Is Not Visible      xpath://*[contains(text(),'To delete or edit, alarm state must be Inactive')]     300
    Element Should Not Be Visible        xpath://*[contains(text(),'To delete or edit, alarm state must be Inactive')]
    wait for page to load
    capture page screenshot

Verify OK button in deleted alarm message dialog box
    Wait Until Page Contains Element     xpath:(//label[contains(text(),'OK') and @class="deleteBtnInput"])[1]    300
    Click element     xpath:(//label[contains(text(),'OK') and @class="deleteBtnInput"])[1]
    Sleep    2s
	Wait Until Element Is Not Visible      xpath://*[contains(text(),'To delete or edit, alarm state must be Inactive')]     300
    Element Should Not Be Visible        xpath://*[contains(text(),'To delete or edit, alarm state must be Inactive')]
    wait for page to load
    capture page screenshot
    
verify that an alarm with same name already exists
    [Arguments]    ${alarm_name}
    element should be visible    xpath:(//*[contains(text(),'Error: Alarm Definition "${alarm_name}" already exists')])
    wait for page to load
    Capture page screenshot

Validate measures are getting cleared when clicking on clear measure button
    [Arguments]     ${measure}
    click on scroll down button    5    35
    Sleep   3s
	Click element      xpath:(//div[@class="sf-list-box-container VirtualListBox sf-suppress-forms-accept-command sf-suppress-forms-cancel-command sf-focusable"])[4]//input
    sleep      1s
    Press Keys    None    TAB
    sleep      1s
    Press Keys    None    TAB
    wait until element is visible    xpath://input[@value = "Clear Measures"]    30    
	Click element      xpath://input[@value = "Clear Measures"]
    sleep      2s
    wait for page to load
    sleep      1s
    Element Should not be Visible    xpath://span[contains(text(),'${measure}')]
    capture page screenshot

######################################## MR EQEV-110751 END ########################################
  
    
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
	Wait Until Element Is Visible    xpath:((//div[@class="deletefooter"]//label[@class="deleteConnectionsInput"]))[1]
	Click element    xpath:((//div[@class="deletefooter"]//label[@class="deleteConnectionsInput"]))[1]
	wait for page to load
    Capture page screenshot
verify that Deletion POPUP is closed After clicking OK
    wait for page to load
    Wait Until Element Is Not Visible       xpath:(//div[@class='deleteConnectionDialog'])[1]         timeout=30
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

Suite setup steps for pmalarm
	 Set Screenshot Directory   ./Screenshots
	 Set Selenium Implicit Wait        60s
	 Install Utility mobule in web player
	 Close Browser	 
	 #open pm alarm analysis
	 #change the mode to       Editing
	 #Connect to DB and sync with eniq
	 #Set up ENM connection
	 #Navigate to Home page
	 #Save the analysis file
	 #Close browser
	 #open worker_analysis1
	 #Connect to DB_workerfile
	 #Save the analysis file
	 #open worker_analysis2A
	 #Connect to DB_workerfile
	 #Save the analysis file
	 #open worker_analysis2B
	 #Connect to DB_workerfile
	 #Save the analysis file
	 #open worker_analysis3
	 #Connect to DB_workerfile
	 #Save the analysis file

Suite setup steps for pmalarm for pmdata
	 Set Screenshot Directory   ./Screenshots
	 Set Selenium Implicit Wait        60s
	 Install Utility mobule in web player
	 Close Browser	 
	 open pm alarm analysis
	 change the mode to       Editing
	 Connect to DB and sync with eniq
	 #Set up ENM connection
	 Navigate to Home page
	 Save the analysis file
	 Close browser
	 #open worker_analysis1
	 #Connect to DB_workerfile
	 #Save the analysis file
	 #open worker_analysis2A
	 #Connect to DB_workerfile
	 #Save the analysis file
	 #open worker_analysis2B
	 #Connect to DB_workerfile
	 #Save the analysis file
	 #open worker_analysis3
	 #Connect to DB_workerfile
	 #Save the analysis file
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

Navigate to this section
    [Arguments]     ${section}
	${count}=       set variable      0
	place the cursor on    ENIQ Connection Status
	Click on maximise window button    1
	Sleep      5s	
	FOR    ${i}    IN RANGE    0     15
	    ${count}=     Get Element Count       xpath:(//*[@title="${section}"])
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
	  	
place the cursor on
	[Arguments]    ${text}
	Wait Until Page Contains Element    xpath://div[contains(text(),'${text}')]    120    
	mouse over    xpath://div[contains(text(),'${text}')]
	wait for page to load
    Capture page screenshot
	
verify that the dropdown is disabled
	Click on scroll down button    0      10
	wait Until Page Contains Element    xpath:(//*[@id="accesstype"])
	${status}=    run keyword and return status    Click element    xpath:(//*[@id="accesstype"])
	Log    ${status}
	wait for page to load
	capture page screenshot 
	
	
Select Access Type
    [Arguments]    ${access_type}=Private
    Click on Scroll down button      0       15
	Wait Until Page Contains Element    xpath:(//div[@class='ComboBoxTextDivContainer'])[4]
	Click element    xpath:(//div[@class='ComboBoxTextDivContainer'])[4]
    capture page screenshot
	sleep    3
	element should be visible    xpath:(//div[contains(text(),${access_type})])
	Click element    xpath:(//div[contains(text(),${access_type})])
    Sleep     2
	wait for page to load
	capture page screenshot
	
Check the dynamic collection check-box
    Click on Scroll down button      0       10
	${status}=     run keyword and return status    Element should be visible      xpath://div[@class='sf-element sf-element-check-box flex-item flex-no-shrink flex-align-start sfpc-unchecked']
	IF      '${status}'=='True'
			Click element       xpath://div[@class='sf-element sf-element-check-box flex-item flex-no-shrink flex-align-start sfpc-unchecked']
			sleep      3s
	END
	wait for page to load
	capture page screenshot

Enter the WildcardExpression
	[Arguments]     ${expression}
	Click on Scroll down button      0       30
	#Wait Until Element Is Visible     xpath: //input[@class='sf-element sf-element-control sfc-property sfc-text-box']    300
    @{element}=    Get WebElements	    xpath: //input[@class='sf-element sf-element-control sfc-property sfc-text-box']
    ${ele}=        Get from list     ${element}     1
    Clear Element Text     ${ele}
	sleep    2s
    Selenium2Library.Input Text      ${ele}      ${expression}
    sleep    2s
	wait for page to load
	capture page screenshot
	
Verify create edit and delete buttons atre not visible in the page
    ${status}=    run keyword and return status    Element Should Not Be Visible      xpath: //input[@value='Create Collection']
	Log     ${status}
	should be equal    '${status}'    'True'
	${status}=    run keyword and return status    Element Should Not Be Visible      xpath: //input[@value='Edit Collection']
	Log     ${status}
	should be equal    '${status}'    'True'
	${status}=    run keyword and return status    Element Should Not Be Visible      xpath: //input[@value='Delete Collection']
    Log     ${status}
	should be equal    '${status}'    'True'
	wait for page to load


Verify create edit and delete buttons are not visible in the alarm page
    ${status}=    run keyword and return status    Element Should Not Be Visible      xpath: //input[@value='Create']
	Log     ${status}
	should be equal    '${status}'    'True'
	${status}=    run keyword and return status    Element Should Not Be Visible      xpath: //input[@value='Edit']
	Log     ${status}
	should be equal    '${status}'    'True'
	${status}=    run keyword and return status    Element Should Not Be Visible      xpath: //input[@value='Delete']
    Log     ${status}
	should be equal    '${status}'    'True'
	wait for page to load
select the table MoClass for visualization
    Wait Until Page Contains Element      xpath:(//div[@class="ComboBoxTextDivContainer"])
	Click Element    xpath:(//div[@class="ComboBoxTextDivContainer"])
	sleep    2
	Wait Until Page Contains Element      xpath:(//div[@title="MoClass"])    100
	Click Element    xpath:(//div[@title="MoClass"])
	wait for page to load
	capture page screenshot	
	
select the table from Data table list
    [Arguments]    ${table}
    Wait Until Page Contains Element      xpath:(//div[@class="sf-element sf-element-text-box"])[1]   10
    Click Element    xpath:(//div[@class="sf-element sf-element-text-box"])[1]
    Click on scroll down button     3    30
    Wait Until Page Contains Element      xpath:(//div[@class="contextMenuItemLabel"])[33]   10
	Click Element    xpath:(//div[@class="contextMenuItemLabel"])[33]
    wait for page to load
    capture page screenshot
    
Verify that there's data in the MOClass table
	wait for page to load
	${text}=    Get Text    xpath://*[@class="sfx_label_223"][1]
	Log    ${text}
	should not be equal    "${text}"    "0 of 0 rows"    
	capture page screenshot
	
Select MOClass as 
    [Arguments]    ${MOClass}
    Click on scroll up button     5    35
    @{list}=      Split string      ${MOClass}    ,
    FOR    ${mo}    IN    @{list}
        Clear Element Text     xpath:(//input[@class='SearchInput sf-element-input sf-suppress-forms-accept-command sf-suppress-forms-cancel-command sf-input-with-placeholder'])[3] 
        Selenium2Library.Input Text     xpath:(//input[@class='SearchInput sf-element-input sf-suppress-forms-accept-command sf-suppress-forms-cancel-command sf-input-with-placeholder'])[3]    ${MOClass} 
        sleep    1s
        Click on scroll up button     5    20
        sleep    5s
        wait for page to load
        Click element      xpath://div[@title='${mo}']      modifier=CTRL   
        sleep   1s
        Capture page screenshot
    END
    
Select MOClass as empty and verify error message
    Click on scroll up button     5    35
    Clear Element Text     xpath:(//input[@class='SearchInput sf-element-input sf-suppress-forms-accept-command sf-suppress-forms-cancel-command sf-input-with-placeholder'])[3] 
    Selenium2Library.Input Text     xpath:(//input[@class='SearchInput sf-element-input sf-suppress-forms-accept-command sf-suppress-forms-cancel-command sf-input-with-placeholder'])[3]    (Empty) 
    sleep    1s
    Click on scroll up button     5    20
    sleep    15s
    wait for page to load
    Run Keyword And Return Status     Click element      xpath:(//div[@title="(Empty)"])[1]
    Run Keyword And Return Status     Click element      xpath:(//div[@title="(Empty)"])[2]
    sleep    1s
    Wait Until Page Contains Element      xpath:(//*[contains(text(),'Select Valid MO Class')])    50
	Element should be visible     xpath:(//*[contains(text(),'Select Valid MO Class')])
    sleep    2s
    click on Apply alarm template button
    Wait Until Page Contains Element      xpath:(//span[contains(text(),'Select valid MO Class')])    10
	Element should be visible     xpath:(//span[contains(text(),'Select valid MO Class')])
    sleep    5s
    Run Keyword And Return Status     Click element      xpath:(//*[contains(text(),'(All)')])[2]
    Run Keyword And Return Status     Click element      xpath:(//*[contains(text(),'(All)')])[3]
    sleep    3s
	Element Should not be Visible    xpath:(//*[contains(text(),'Select Valid MO Class')])
    wait for page to load
    Capture page screenshot
    
Select System area for collection manager and verify none value is not present
    [Arguments]     ${sys_area}
    @{element}=    Get WebElements	    xpath: //div[@class='ComboBoxTextDivContainer']
    ${sys_area_ele}=        Get from list     ${element}    1
    Click element     ${sys_area_ele}
    sleep    2
    Click element      xpath://div[@title='${sys_area}']     
    sleep    2s
    element should not be visible    xpath://div[contains(@class,'sf-element-dropdown-list-item') and @title="(None)"]
    wait for page to load
    capture page screenshot
    
Verify the Measure Type check box enabled
    [Arguments]    ${measure type}
    @{list}=      Split string      ${measure type}    ,
    #Click on scroll down button     9    3
    Element should be visible          xpath://div[@title='Counter']    
	Capture page screenshot
	
Verify the measures
    [Arguments]     ${Measure}
   	@{list}=      Split string      ${Measure}     ,  
    FOR    ${meas}    IN    @{list}
	    Clear Element Text      xpath:(//div[@class="sf-list-box-container VirtualListBox sf-suppress-forms-accept-command sf-suppress-forms-cancel-command sf-focusable"])[4]//input
		sleep    2
        Selenium2Library.Input Text     xpath:(//div[@class="sf-list-box-container VirtualListBox sf-suppress-forms-accept-command sf-suppress-forms-cancel-command sf-focusable"])[4]//input    ${measure}
		sleep    2		 
        press keys      xpath:(//div[@class="sf-list-box-container VirtualListBox sf-suppress-forms-accept-command sf-suppress-forms-cancel-command sf-focusable"])[4]//input     ENTER
        wait until element is visible	    xpath: //div[@title='${meas}']    30
        Capture page screenshot
    END
          
Select All values in MO Class
    Click on scroll up button     5    35
    Click element       xpath:((//div[@class='ListItems'])[3]//div)[1]
	Capture page screenshot
	    
Select all MO classes in UI
    Click on scroll up button     5    35
    FOR    ${i}    IN RANGE   0   20
		@{element}=    Get WebElements      xpath:(//div[@class='ListItems'])[5]
		FOR    ${ele}    IN    @{element}
			 ${text}=  get text        ${ele}
			 Should not contain      ${text}     'Null'
			 Should not contain      ${text}     '{empty}'
		END
	END
    
Select all MO classes in UI for comma
    Click on scroll up button     5    35
    FOR    ${i}    IN RANGE   0   20
	    @{element}=    Get WebElements      xpath:(//div[@class='ListItems'])[5]
		FOR    ${ele}    IN    @{element}
			 ${text}=  get text        ${ele}
			 Should not contain      ${text}     '
			 Should not contain      ${text}     ,
		END
	END
Select the measure type 
    [Arguments]    ${list}				  
	click on scroll up button       5        21
	@{measure_type}=      Split string      ${list}    ,
    ${InList}=    Get Match Count    ${measure_type}    COUNTER
    ${status}=     Run Keyword And Return Status        Element should be visible          xpath: (//div[@title="Counter"])
    Run keyword if    ${InList}!=1 and ${status}==True  Click element    xpath: (//div[@title="Counter"])
    sleep    2
    ${InList}=    Get Match Count    ${measure_type}    CUSTOM_KPI
    ${status}=     Run Keyword And Return Status        Element should be visible          xpath: (//div[@title="Custom KPI"])
    Run keyword if    ${InList}!=1 and ${status}==True    Click element    xpath: (//div[@title="Custom KPI"])
	sleep    2
    ${InList}=    Get Match Count    ${measure_type}    KPI
    ${status}=     Run Keyword And Return Status        Element should be visible          xpath: (//div[@title="KPI"])
    Run keyword if    ${InList}!=1 and ${status}==True    Click element    xpath: (//div[@title="KPI"])
    Sleep   2s
    ${InList}=    Get Match Count    ${measure_type}    RI
    ${status}=     Run Keyword And Return Status        Element should be visible          xpath: (//div[@title="RI"])
    Run keyword if    ${InList}!=1 and ${status}==True    Click element    xpath: (//div[@title="RI"])
	Sleep   2s
    ${InList}=    Get Match Count    ${measure_type}    FLEX_COUNTER
    ${status}=     Run Keyword And Return Status        Element should be visible          xpath: (//div[@title="Flex Counter"])
    Run keyword if    ${InList}!=1 and ${status}==True    Click element    xpath: (//div[@title="Flex Counter"])
	Sleep   2s
    ${InList}=    Get Match Count    ${measure_type}    FLEX+PDF_COUNTER
    ${status}=     Run Keyword And Return Status        Element should be visible          xpath: (//div[@title="Flex+PDF Counter"])
    Run keyword if    ${InList}!=1 and ${status}==True    Click element    xpath: (//div[@title="Flex+PDF Counter"])
	Sleep   2s
    ${InList}=    Get Match Count    ${measure_type}    PDF_COUNTER
    ${status}=     Run Keyword And Return Status        Element should be visible          xpath: (//div[@title="PDF Counter"])
    Run keyword if    ${InList}!=1 and ${status}==True    Click element    xpath: (//div[@title="PDF Counter"])
    click on scroll down button       5        21
    wait for page to load
    capture page screenshot

click on next button
	Wait Until Page Contains Element      xpath: (//div[@title="Next"])    30
	Click Element    xpath: (//div[@title="Next"])
	wait for page to load
	capture page screenshot
	
Select Alarm severity as
    [Arguments]     ${alarm_severity}
    Click on scroll up button    5    50
    wait until element is visible	    xpath: (//div[@class="ComboBoxTextDivContainer"])[11]    30
    click element    xpath: (//div[@class="ComboBoxTextDivContainer"])[11]
    wait until element is visible    xpath: //div[@title='${alarm_severity}']    30
    Click element      xpath: //div[@title='${alarm_severity}']     
    
Select Aggregation as
    [Arguments]     ${aggregation}
    wait until element is visible	    xpath: (//div[@class="ComboBoxTextDivContainer"])[12]    30
    click element    xpath: (//div[@class="ComboBoxTextDivContainer"])[12]
    wait until element is visible    xpath: //div[@title='${aggregation}']    30
    Click element      xpath: //div[@title='${aggregation}'] 	
	
Select Probable cause as
    [Arguments]     ${probable_cause}
    wait until element is visible	    xpath: (//div[@class="ComboBoxTextDivContainer"])[16]    30
    click element    xpath: (//div[@class="ComboBoxTextDivContainer"])[16]
	sleep    2
	${status}=    run keyword and return status    element should be visible    xpath: //div[@title='${probable_cause}']
	IF    "${status}"=="False"
		FOR    ${i}    IN RANGE    0    21
			Click on scroll up button    9    6
			${status}=    run keyword and return status    element should be visible    xpath: //div[@title='${probable_cause}']
			run keyword if    "${status}"=="True"    exit for loop
		END
	END
    wait until element is visible    xpath: //div[@title='${probable_cause}']    30
    Click element      xpath: //div[@title='${probable_cause}']
	wait for page to load 
	capture page screenshot
	
Verify Element In List
    [Arguments]        ${list_element}    ${search_element}
    ${db_value}=     Set Variable    0
    FOR    ${temp_item}    IN    @{list_element}
        Log    ${temp_item}[0]
        ${item}=    set variable     ${temp_item}[0]
        ${str_item}=    convert to string      ${item}
        Log     ${str_item}
        IF      ${search_element}==${str_item}
            ${db_value}=     Set Variable        ${str_item}
            Exit for loop
        END
    END
    Log     ${db_value}
    [return]    ${db_value}				  					   
Verify data integrity of the measures
        [Arguments]    ${measure_list}     ${sql1}     ${sql2}     ${sql3}     ${sql4}
        @{list}=      Split string      ${measure_list}    ,
        ${count}=     set variable    1
        ${date_value}=        Get cell value     DATETIME_ID      1
        # @{date}=      Split string      ${date_id}
        # ${date_value}=      Get from list     ${date}    0
        ${moid}=        Get cell value     MOID      1
        ${DCVECTOR_INDEX}=        Get cell value        DCVECTOR_INDEX    1
        ${FLEX_FILTERHASHINDEX}=        Get cell value    FLEX_FILTERHASHINDEX    1
        selenium2library.mouse over    xpath://*[contains(text(),'OSS_ID')]
        sleep    2
        Click on scroll right button     0     50
        FOR    ${measure}    IN    @{list}
            ${measure_value}=     Get cell value     MEASUREVALUE_${count}      1
            Log       ${measure_value}            
            Log       ${sql${count}}
            ${date_value}=    convert date    ${date_value}    result_format=%Y-%m-%d %H:%M:%S  date_format=%m/%d/%Y %I:%M:%S %p
            ${query}=    replace string    ${sql${count}}    DATETIME_VALUE    \'${date_value}\'    
            ${query}=    replace string    ${query}    UNIQUE_ID_VALUE    \'${moid}\'
            ${query}=    replace string    ${query}    DCVECTOR_INDEX_VALUE    \'${DCVECTOR_INDEX}\'
            ${query}=    replace string    ${query}    FLEX_FILTERHASHINDEX_VALUE    \'${FLEX_FILTERHASHINDEX}\'
            Log     ${query}
            ${db_values}=      Query Sybase database     ${query}            
            Log        ${db_values}
            ${db_value}=    Verify Element In List        ${db_values}        ${measure_value}
            Log        ${db_value}
			${db_value}=    convert to string      ${db_value}
            Should Contain        ${db_value}      ${measure_value}   
        END	
	
	
Click on Apply alarm template button
    Click element     xpath: //input[@value='Apply Alarm Template']
    wait for page to load
	capture page screenshot
	
Verify alarm title
    [Arguments]     ${alarm_name} 
    wait for page to load 
    ${text}=    Selenium2Library.Get Text   class:sf-root
    Log    ${text}
    Should contain    ${text}    ${alarm_name}	
	
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
        	
Verify alarm displayed in UI
    [Arguments]     ${alarm_name} 
    Mouse Over      xpath://div[text()='MeasuresName']
    ${status}=    run keyword and return status    Element Should Be Visible     xpath://div[text()='${alarm_name}']
    IF    "${status}"=="False"
    	FOR    ${i}    IN RANGE    0    200
    		click on scroll down button    1    10
    		${status}=    run keyword and return status    Element Should Be Visible     xpath://div[text()='${alarm_name}']
    		Run keyword if    "${status}"=="True"    exit for loop
    	END
    END
    Capture page screenshot

Click on fetch nodes button
    Click on scroll down button    5     20
    Click element     xpath: //input[@value='Fetch Nodes']
    Sleep     20s	
	
	
	
	
############# MR EQEV-110783 #############


Select PDF value from dropdown
    [Arguments]     ${selection}
    Wait Until Page Contains Element      xpath: (//div[@class='sf-element-text-box'])[9]    30
    Click element    xpath: (//div[@class='sf-element-text-box'])[9]
    sleep    2
	Wait Until Page Contains Element      xpath: //div[@title='${selection}']         30
    Click element      xpath://div[@title='${selection}']     
    wait for page to load
    capture page screenshot 


Click on apply PDF setting button
    Click element     xpath: //input[@value='Apply PDF settings']
    Sleep     20s 
	
Enter Custom value
    [Arguments]     ${custom_value}
    @{element}=    Get WebElements	    xpath: //input[@class='sf-element sf-element-control sfc-property sfc-text-box']
    ${ele}=        Get from list     ${element}     1
    Clear Element Text     ${ele}
    sleep    2s
    Selenium2Library.Input Text      ${ele}      ${custom_value}
	
	
validate Measure error message
   Wait Until Element Is Visible   xpath: //span[contains(text(),'Selected measures must be present in the same table')]
   capture page screenshot
  
  
Select Flex value from dropdown   
   [Arguments]     ${selection1}
    Wait Until Page Contains Element      xpath: (//div[@class='sf-element-text-box'])[10]    160
    Click element    xpath: (//div[@class='sf-element-text-box'])[10]
    sleep    2
    Click element      xpath:(//div[@title='${selection1}'])[2]    
    wait for page to load
    capture page screenshot 
	

Validate PDF successful Message
   Wait Until Element Is Visible   xpath: //span[contains(text(),'PDF settings applied successfully.')]
   capture page screenshot

	
	
Validate PDF Error Message
   Wait Until Element Is Visible   xpath: //span[contains(text(),'Please add a valid Index.Format is comma separated. Use "-" for a range, e.g. 1,2-6,8')]
   capture page screenshot
   
   
   
   
open worker_analysis1
    Open chrome browser
    Go To    ${base_url}   
    Sleep    5
    Selenium2Library.Input Text    name:username    Administrator
    Selenium2Library.Input Text    name:password    Ericsson01
    Selenium2Library.Click element    class:LoginButton
    Sleep    5
    Go To    ${base_url}${workerAnalysis_1}
    sleep    15
    ${IsElementVisible}=    Run Keyword And Return Status    Element Should not be Visible    xpath://div[contains(text(),'Missing Data')]
	Run Keyword If    ${IsElementVisible} is ${FALSE}   Close missing data window
    wait for page to load
    capture page screenshot
	
	
open worker_analysis2A
    Open chrome browser
    Go To    ${base_url}   
    Sleep    5
    Selenium2Library.Input Text    name:username    Administrator
    Selenium2Library.Input Text    name:password    Ericsson01
    Selenium2Library.Click element    class:LoginButton
    Sleep    5
    Go To    ${base_url}${workerAnalysis_2A}
    sleep    15
    ${IsElementVisible}=    Run Keyword And Return Status    Element Should not be Visible    xpath://div[contains(text(),'Missing Data')]
	Run Keyword If    ${IsElementVisible} is ${FALSE}   Close missing data window
    wait for page to load
    capture page screenshot

	
open worker_analysis2B
    Open chrome browser
    Go To    ${base_url}   
    Sleep    5
    Selenium2Library.Input Text    name:username    Administrator
    Selenium2Library.Input Text    name:password    Ericsson01
    Selenium2Library.Click element    class:LoginButton
    Sleep    5
    Go To    ${base_url}${workerAnalysis_2B}
    sleep    15
    ${IsElementVisible}=    Run Keyword And Return Status    Element Should not be Visible    xpath://div[contains(text(),'Missing Data')]
	Run Keyword If    ${IsElementVisible} is ${FALSE}   Close missing data window
    wait for page to load
    capture page screenshot
	
	
open worker_analysis3
    Open chrome browser
    Go To    ${base_url}   
    Sleep    5
    Selenium2Library.Input Text    name:username    Administrator
    Selenium2Library.Input Text    name:password    Ericsson01
    Selenium2Library.Click element    class:LoginButton
    Sleep    5
    Go To    ${base_url}${workerAnalysis_3}
    sleep    15
    ${IsElementVisible}=    Run Keyword And Return Status    Element Should not be Visible    xpath://div[contains(text(),'Missing Data')]
	Run Keyword If    ${IsElementVisible} is ${FALSE}   Close missing data window
    wait for page to load
    capture page screenshot
		
Connect to DB_workerfile
    Connect to DB     localhost       netanserver      Ericsson01  


Click on Refresh button
	Click on scroll down button    5    5
	Wait Until Element Is Visible    xpath: //input[@value='Refresh filter list']
    Click element     xpath: //input[@value='Refresh filter list']
    Sleep     20s 
	
	
Enter flex custom value
    [Arguments]     ${custom_value1}
    @{element}=    Get WebElements	    xpath: //input[@class='SearchInput sf-element-input sf-suppress-forms-accept-command sf-suppress-forms-cancel-command sf-input-with-placeholder']
    ${ele}=        Get from list     ${element}     4
    Clear Element Text     ${ele}
    sleep    2s
    Selenium2Library.Input Text      ${ele}      ${custom_value1}


Select Flex Counter value from dropdown   
   [Arguments]     ${selection1}
    Wait Until Page Contains Element      xpath: (//div[@class='sf-element-text-box'])[10]    160
    Click element    xpath: (//div[@class='sf-element-text-box'])[10]
    sleep    2
    Click element      xpath:(//div[@title='${selection1}'])   
    wait for page to load
    capture page screenshot 
	
Click on apply Flex setting button
	Click on scroll down button    5    5
    Click element     xpath: (//input[@value='Apply flex filter settings'])[1]
    Sleep     20s
	
Click on Apply Flex setting button_custom
	Click on scroll down button    5    5
    Click element     xpath: (//input[@value='Apply flex filter settings'])[2]
    Sleep     20s						   

Check pivot counter values
	Click on scroll down button    5    10
	wait until page contains element    xpath: (//div[@class='sf-element sf-element-check-box flex-item flex-no-shrink flex-align-start sfpc-unchecked'])[6]    30
    Click element     xpath: (//div[@class='sf-element sf-element-check-box flex-item flex-no-shrink flex-align-start sfpc-unchecked'])[6]
    Sleep     20s 

Click on preview button
    Wait Until Element Is Visible     xpath: //*[@value='Preview']    300
    Click element     xpath: //*[@value='Preview']
	wait for page to load
	capture page screenshot
    
Verify ModifiedBy column is updated to 
    [Arguments]      ${user}           ${collection}
	${row}=       Get element attribute       xpath:(//div[contains(text(),'${collection}')])[1]/..           row
	Mouse Over      xpath://div[text()='CollectionName']
    Click on scroll right button    1     50
	${value}=     get text    xpath://div[@row='${row}' and @column='9']//div
    Log    ${value}
	Should match     Administrator         ${value}
    capture page screenshot
    wait for page to load
	
Verify edit collection and delete collection buttons are disabled when no collection selected
    ${status1}=      Run keyword and return status       Click element          xpath://input[@value='Edit Collection'] 
	${status2}=      Run keyword and return status       Click element          xpath: //input[@value='Delete Collection']
	Run keyword IF     ${status1}==True     FAIL      msg= Edit collection button is enabled before selecting collection
    Run keyword IF     ${status2}==True     FAIL      msg= Delete collection button is enabled before selecting collection
	Capture page screenshot

Validate Error Message Thrown If The Table From Selected Counter Is Not Present In Selected Multitable KPI
	wait for page to load
    Element Should Be Visible      xpath://*[text()='Selected measures must be present in the same table']
	capture page screenshot
	
Validate Error Message Thrown If The Table From Selected RI Is Not Present In Selected KPI
	wait for page to load
    Element Should Be Visible      xpath://*[text()='Selected measures must be present in the same table']
	capture page screenshot
	
select the created collection and click on delete
	[Arguments]    ${collection_name}
	place the cursor on    CollectionName
    Click on maximise window button     0
	run keyword and ignore error    click on scroll up button    0     80
	Wait Until Page Contains Element      xpath://*[contains(text(),'${collection_name}')]     30
	Click element      xpath://*[contains(text(),'${collection_name}')]
	sleep    2
	place the cursor on    CollectionName
	sleep    2
    click on the button    Restore visualization layout
	capture page screenshot
	wait Until Page Contains Element      xpath: (//*[@value="Delete Collection"])     30
	Click element      xpath: (//*[@value="Delete Collection"])
	wait for page to load
	capture page screenshot
	
close the delete collection prompt using Cancel button
	Wait Until element is visible      xpath: (//label[text()="Delete Collection" and @class="deletecollectiontitle"])[1]    30
	Wait Until element is visible      xpath: (//label[text()="Cancel" and @class="deleteCollectionOptions1"])     30
	Click element      xpath: (//label[text()="Cancel" and @class="deleteCollectionOptions1"])
	capture page screenshot

close the delete collection prompt using Close button
	Wait Until element is visible      xpath: (//label[text()="Delete Collection" and @class="deletecollectiontitle"])[1]    30
	Wait Until element is visible      xpath: (//div[@class="deleteCollectionheader"]//label[@class="deleteCollectionOptions"])[1]     30
	Click element      xpath: (//div[@class="deleteCollectionheader"]//label[@class="deleteCollectionOptions"])[1]
	capture page screenshot
	
verify that Preview section is empty
	${text}=    Get Text    xpath://*[@class="sfx_label_223"][1]
    should be equal    "${text}"    "0 of 0 rows"
	capture page screenshot

Validate error message in node collection manager page
     [Arguments]      ${msg}
	 ${text}=    Get Text    xpath://span[@id='action-message']
	 should be equal    ${text}    ${msg}
	 capture page screenshot
	 
Verify Add >> button is disabled
    ${status}=      Run keyword and return status       Click element           xpath://input[@value='Add >>'] 
	Run keyword IF     ${status}==True     FAIL      msg= Add >> button is enabled
	Capture page screenshot	 

Verify Remove >> button is enabled
    ${status}=      Run keyword and return status       Click element           xpath://input[@value='<< Remove'] 
	Run keyword IF     ${status}==False     FAIL      msg= << Remove button is disabled
	Capture page screenshot
	 
Verify Import nodes from File button is disabled
    ${status}=      Run keyword and return status       Click element           xpath://input[@value='Import nodes from File'] 
	Run keyword IF     ${status}==True     FAIL      msg= Import nodes from File button is enabled
	Capture page screenshot	

Verify Fetch nodes button is disabled
    ${status}=      Run keyword and return status       Click element           xpath://input[@value='Fetch nodes'] 
	Run keyword IF     ${status}==True     FAIL      msg= Fetch nodes button is enabled
	Capture page screenshot	
	
Verify Node panel is empty for All nodes
    Element should be visible            xpath://div[@title='All Nodes']/../../..//div[@title='(All) 0 values'] 
	Capture page screenshot	
	
Verify Node panel is not empty for All nodes
    Element should not be visible            xpath://div[@title='All Nodes']/../../..//div[@title='(All) 0 values'] 
	Capture page screenshot	

Verify Node panel is empty for selected nodes
    Element should be visible            xpath://div[@title='Selected Nodes']/../../..//div[@title='(All) 0 values'] 
	Capture page screenshot		
	
Verify Node panel is not empty for selected nodes
    Element should not be visible            xpath://div[@title='Selected Nodes']/../../..//div[@title='(All) 0 values'] 
	Capture page screenshot	
	
Verify Select Eniq data source, system area and node type is disabled in edit collection
    ${status1}=      Run keyword and return status       Select ENIQ Data Source in collection manager        NetAn_ODBC
	${status2}=      Run keyword and return status       Select System area for collection manager        Radio
	${status3}=      Run keyword and return status       Select Node type for collection manager             NR
	Run keyword IF     ${status1}==True     FAIL      msg= Able to select ENIQ Data Source
	Run keyword IF     ${status2}==True     FAIL      msg= Able to select System area
	Run keyword IF     ${status3}==True     FAIL      msg= Able to select Node type
	Capture page screenshot
	
validate that the collection information is correct in NetAn DB
	[Arguments]     ${collection_name}        ${sys_area}        ${node_type}
     ${sql}=    set variable         select "SystemArea" from "tblCollection" where "CollectionName"='${collection_name}'
	 Log       ${sql}
     ${results}=  Query Postgre database and return output     ${sql}
     Log    ${results}
	 ${value}=    Get From List    ${results}     -1
     ${value}=    convert to string    ${value}	
	 Log    ${value}
	 Log    ${sys_area}
	 should contain    ${value}    ${sys_area}
	 
	 ${sql}=    set variable         select "NodeType" from "tblCollection" where "CollectionName"='${collection_name}'
	 Log       ${sql}
     ${results}=  Query Postgre database and return output     ${sql}
     Log    ${results}
	 ${value}=    Get From List    ${results}     -1
     ${value}=    convert to string    ${value}	
	 Log    ${value}
	 Log    ${node_type}
	 should contain    ${value}    ${node_type}

verify that the connection failed for Failed_ODBC
    ${window}=      set variable       Setup Data Source
    Run keyword and ignore error    Wait Until Element Is Enabled          xpath: //div[@title='Restore visualization layout']      timeout=120s        
    Run keyword and ignore error    Click element      xpath: //div[@title='Restore visualization layout']
    Navigate to section         ${window} 
	${text1}=    Get Text    xpath://span[@id='cb9e2a858b964ef6a34d4f825befa8fb']
	Log    ${text1}
	should contain    ${text1}    Failed to connect with: Failed_ODBC
	capture page screenshot	
	
select created collection and read column value
	[Arguments]    ${collectionName}    ${columnName}
	place the cursor on    CollectionName
    Click on maximise window button     0
	sleep    5
	run keyword and ignore error    click on scroll up button    0     80
	Wait Until Page Contains Element      xpath://*[contains(text(),'${collection_name}')]     timeout=150
	Click element      xpath://*[contains(text(),'${collection_name}')]
	sleep    2
	${time1}=    Get cell value    ${columnName}    1
	place the cursor on    CollectionName
	sleep    3
    click on the button    Restore visualization layout
	[Return]    ${time1}
	wait for page to load
	capture page screenshot
	
verify that the LastModifiedOn values do not match
	[Arguments]    ${val1}    ${val2}
	should not be equal    ${val1}    ${val2}
	
Enter Wildcard Expression
	[Arguments]    ${wildcardExp}
	Click on Scroll down button      0       20
	Clear Element Text      xpath:(//span[@id="WildcardExpression2"])//input
	Selenium2Library.Input Text     xpath:(//span[@id="WildcardExpression2"])//input    ${wildcardExp}
    wait for page to load
	capture page screenshot
	
verify that the Administration button is visible and working
	element should be visible    xpath: (//img[@class="sf-element sf-element-control sfc-action sfc-action-image" and @title="Administration"])
	Click on Administration button
	validate the page title    Administration
	click on the button    Home
	validate the page title    Home
	capture page screenshot
	
verify that the Node Collection Manager button is visible and working
	element should be visible    xpath: (//input[@class="sf-element sf-element-control sfc-action sfc-action-button" and @value="Node Collection Manager"])
	Click on Node Collection manager button
	validate the page title    Node Collection Manager
	click on the button    Home
	validate the page title    Home
	capture page screenshot
	
verify that the Alarm Rules Manager button is visible and working
	element should be visible    xpath: (//input[@class="sf-element sf-element-control sfc-action sfc-action-button" and @value="Alarm Rules Manager"])
	Click on Alarm rules manager button
	validate the page title    Alarm Rules Manager
	click on the button    Home
	validate the page title    Home
	capture page screenshot
Navigate to the section
    [Arguments]     ${section}
	${count}=       set variable      0
	run keyword and ignore error    Click on minimise window button    0															 
	place the cursor on    ENIQ Connection Status
	Click on maximise window button    1
	Sleep      5s	
	FOR    ${i}    IN RANGE    0     15
	    ${count}=     Get Element Count       xpath: (//*[@value="${section}" or @title="${section}" or contains(text(),'${section}')])
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
disconnect the ENIQ db and go to home page
    Navigate to section    Setup Data Source
	wait until element is visible    xpath: (//input[@value="Connect "])    30
	click element    xpath: (//input[@value="Connect "])
	wait until element is visible    xpath: (//span[@id="NetAnResponse"])//span[contains(text(),'Cannot Create Connection')]    60
	capture page screenshot
	wait until element is visible    xpath: (//input[@value="Connect"])    30
	click element    xpath: (//input[@value="Connect"])
	wait until element is visible    xpath: (//span[contains(text(),'Please connect to NetAn DB before connection ENIQ')])    60
	capture page screenshot
	Click on minimise window button    0
	navigate to the section    Home
	wait until element is visible    xpath: (//img[@title="Home"])    30
	click element    xpath: (//img[@title="Home"])
	capture page screenshot										  
select the created alarm and click on edit button
	[Arguments]    ${alarmName}
	place the cursor on    AlarmName
    Click on maximise window button     0
	Wait Until Page Contains Element      xpath://*[contains(text(),'${alarmName}')]     30
	Click element      xpath://*[contains(text(),'${alarmName}')]
	sleep    2
	place the cursor on    AlarmName
	sleep    2
    Click on minimise window button    0
	wait until element is visible    xpath: (//input[@value="Edit"])    30
	click element    xpath: (//input[@value="Edit"])
	capture page screenshot
	
verify that the "Could not change property" error pops up
	wait until element is visible    xpath: (//div[@class="sfx_text-wrapper_429"])//div[@title="Could not change property."]    60
	capture page screenshot

verify that the connection to ENIQ is made
	validate the page title    Administration
	Navigate to section    Setup Data Source
    ${status}=    Selenium2library.get text    xpath:(//table[@id="admin-table"])//tbody//tr[3]//td[6]//span
    Log    ${status}
    should be equal    ${status}    Connected
	Click on minimise window button     0
    wait for page to load
	capture page screenshot
	
verify that the connection to ENM is made
	validate the page title    Administration
	Navigate to section    Setup ENM Connection
    ${status}=    Selenium2library.get text    xpath: (//span[@id="ENMConnectionStatus"])//span
    Log    ${status}
    should be equal    ${status}    ENM Connection Setup Successful
	Click on minimise window button     0
    wait for page to load
	capture page screenshot	
	
	
	
############# MR EQEV-124466 #############	
	
	
	
verify that the SubNetwork List is empty
	Click on Node Collection manager button
	place cursor on    SubNetworkName
	sleep    2
	Click on maximise window button    2
	sleep    10
	${text1}=    Selenium2Library.get text    xpath:(//div[@class="valueCellsContainer"])
	Log    ${text1}
	sleep    2
	Should Be Equal   ${text1}    ${EMPTY}
	place cursor on    SubNetworkName
	sleep    2
	click on the button    Restore visualization layout
	Wait Until Page Contains Element      xpath://*[@title="Home"]     timeout=1500
    Click Element      xpath://*[@title="Home"]
	wait for page to load
	capture page screenshot
	
	
place cursor on
	[Arguments]    ${text}
	mouse over    xpath://*[contains(text(),'${text}')]
	wait for page to load
	capture page screenshot
	
	
go to Home page
	Navigate to the section    Deleted Items
	Wait Until Page Contains Element      xpath:(//img[@title="Home"])    150
	click element    xpath:(//img[@title="Home"])
	capture page screenshot
	
	
verify that the SubNetwork List is not empty
	Click on Node Collection manager button
	place cursor on    SubNetworkName
	sleep    2
	Click on maximise window button    2
	sleep    10
	${text1}=    Selenium2Library.get text    xpath:(//div[@class="valueCellsContainer"])
	Log    ${text1}
	sleep    2
	should not be equal    ${text1}    ${EMPTY}
	place cursor on    SubNetworkName
	sleep    2
	click on the button    Restore visualization layout
	wait for page to load
	capture page screenshot
	
###################################################

read the Last Successful Sync With Eniq value
	wait until element is visible    xpath: ((//div[@class="valueCellCanvas"])//div//div[@column="3"])//div    30
	${text}=    Selenium2library.get text    xpath: ((//div[@class="valueCellCanvas"])//div//div[@column="3"])//div
	Log    ${text}
	[Return]    ${text}
	capture page screenshot
	
verify the time and timezone in Last Successful Sync
	[Arguments]    ${text}
	${text1}=    convert date    ${text}    %Y-%m-%d %H:%M:%S
	Log    ${text1}
	should contain    ${text}    ${text1}
	should contain    ${text}    Europe/Dublin
	capture page screenshot
	
read the connectied ENIQ from ENIQ Connection Status page
	wait until element is visible    xpath: ((//div[@class="valueCellCanvas"])//div//div[@column="0"])//div    30
	${text}=    Selenium2library.get text    xpath: ((//div[@class="valueCellCanvas"])//div//div[@column="0"])//div
	Log    ${text}
	[Return]    ${text}
	capture page screenshot
	
verify that the connected ENIQ is present in "Select ENIQ data source" dropdown
	[Arguments]    ${eniq}
	wait until element is visible    xpath: (//div[@class="ComboBoxTextDivContainer"])[2]    30
	click element    xpath: (//div[@class="ComboBoxTextDivContainer"])[2]
	wait until element is visible    xpath: ((//div[@class="ScrollArea"])[6])//div[@class="ListItems"]    30
	${text}=    Selenium2library.get text    xpath: ((//div[@class="ScrollArea"])[6])//div[@class="ListItems"]
	Log    ${text}
	should contain    ${text}    ${eniq}
	capture page screenshot
	
verify that the element is disabled
	[Arguments]    ${element}
	${status}=    run keyword and return status    element should be disabled    xpath: (//*[@value="${element}" or @title="${element}"])
	Run keyword if    "${status}"=="False"    element should not be visible    xpath: (//*[@value="${element}" or @title="${element}"])
	capture page screenshot	
	
verify that the Time read from Eniq DS table is the server's time
	[Arguments]    ${status}
	${time}=    get time    hour
	Log    ${time}
	should contain    ${status}    ${time}
	[Return]    ${time}
	wait for page to load
	capture page screenshot
	
start sync with eniq and click on cancel
	wait until element is visible    xpath: (//input[@value="Sync with ENIQ"])    30
	click element    xpath: (//input[@value="Sync with ENIQ"])
	sleep    5
	wait until element is visible    xpath: (//div[@title="Cancel" or contains(text(),'Cancel')])    120
	click element    xpath: (//div[@title="Cancel" or contains(text(),'Cancel')])
	sleep    5
	FOR    ${i}    IN RANGE    0    10
		${status}=    run keyword and return status    element should not be visible    xpath: (//div[@title="Cancel" or contains(text(),'Cancel')])
		Run keyword if    "${status}"=="True"    exit for loop
		${status}=    run keyword and return status    element should not be visible    xpath: (//div[@title="Cancel" or contains(text(),'Cancel')])
		IF    "${status}"=="False"
			wait until element is visible    xpath: (//div[@title="Cancel" or contains(text(),'Cancel')])    120
			click element    xpath: (//div[@title="Cancel" or contains(text(),'Cancel')])
		END
	END
	wait for page to load
	capture page screenshot
	
verify connection status in the DWHDB Connection Status
	wait until element is visible    xpath: ((//div[@name="valueCellCanvas"])//div//div[@row="1" and @column="1"]//div)    30
	${text}=    Selenium2library.get text    xpath: ((//div[@name="valueCellCanvas"])//div//div[@row="1" and @column="1"]//div)
	Log    ${text}
	should contain    ${text}    Connected
    wait for page to load
	capture page screenshot
	
verify connection status in the REPDB Connection Status
	wait until element is visible    xpath: ((//div[@name="valueCellCanvas"])//div//div[@row="1" and @column="2"]//div)    30
	${text}=    Selenium2library.get text    xpath: ((//div[@name="valueCellCanvas"])//div//div[@row="1" and @column="2"]//div)
	Log    ${text}
	should contain    ${text}    Connected
	wait for page to load
	capture page screenshot
	
Click on Assign Nodes/Collection button
    sleep    2s
    Click element      xpath://input[@value='Assign Nodes/Collection']
    capture page screenshot
	
	
Verify Warning Message for selecting MultipleNodes
    Click element      xpath://div[@title='G2RBS01']
    Click element      xpath://div[@title='G2RBS04']      modifier=CTRL
	Wait Until Element Is Visible      xpath://*[contains(text(),'Select a single node to proceed')]     60
    Element should be visible      xpath://*[contains(text(),'Select a single node to proceed')]
    capture page screenshot 