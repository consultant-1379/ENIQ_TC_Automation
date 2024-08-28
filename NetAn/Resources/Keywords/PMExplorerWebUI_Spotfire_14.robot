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
${notification_container}               sfx_notification-panel-empty_334


*** Keywords ***


#######################################33 Spotfire version dependent keywords ###############################################
check the show in user interface for tables
	[Arguments]    ${table}        ${click}=12
	Wait Until Page Contains Element      xpath:(//div[@title="Data"])    100
	Click Element    xpath:(//div[@title="Data"])
	Wait Until Page Contains Element      xpath:(//div[@title="Data canvas"])    30
	Click Element    xpath:(//div[@title="Data canvas"])
	Sleep     20s
	FOR    ${i}    IN RANGE    0     50
		${command} =  Run Keyword And Return Status    Element Should Not Be Visible      xpath:(//div[@title="${table}"])
		Capture page screenshot
		Run Keyword if      ${command}        Click Element    xpath://div[@title='Next data table']  
		Sleep     1s
        IF      "${command}"=="False"
					Exit for loop
		END
	END	
	Click Element    xpath://div[@title='Click for more options']
	Click Element    xpath://div[text()='Settings' and @class='contextMenuItemLabel']
	Sleep       2s
	${command} =  Run Keyword And Return Status    Element Should Not Be Visible      xpath://div[@class='sfx_label_42' and text()='Show data table in user interface']/..//div[@class='sfx_checkbox_40 sfx_checked_41']
	Capture page screenshot
	Run Keyword if      ${command}       Click Element    xpath://div[@class='sfx_label_42' and text()='Show data table in user interface']/..//div[@class='sfx_checkbox_40']
	
	Click Element    xpath://button[@class='sf-element-button' and text()='Close']
	Sleep       2s
	Click Element    xpath://div[@class='sfx_close-container_1282']
	wait for page to load
	capture page screenshot	
	
select a column to add to the report
	Wait Until Page Contains Element     xpath:(//div[@title = "Data canvas"])     timeout=1500
	Click Element     xpath:(//div[@title = "Data canvas"])
	Sleep     20s
	FOR    ${i}    IN RANGE    0     50
		${command} =  Run Keyword And Return Status    Element Should Not Be Visible      xpath://div[@title='pm_DC_E_TCU_ACLENTRYIP6_DAY(No Aggregation Level)__NetAn_ODBC' and @class='sfx_dropdown_1269']
		Capture page screenshot
		Run Keyword if      ${command}        Click Element    xpath://div[@title='Next data table']  
		Sleep     1s
        IF      "${command}"=="False"
					Exit for loop
		END
	END	
	wait for page to load
	capture page screenshot	
	
add a calculated column
	Wait Until Page Contains Element      xpath:(//*[@class="sfx_buttonSvg_1189"])[2]     timeout=15
    Click Element    xpath:(//*[@class="sfx_buttonSvg_1189"])[2]
    sleep    3
    click on the button    Add columns
    click on the button    Other
    Sleep     2s
    FOR    ${i}    IN RANGE    0     30
         ${status}=     Run Keyword And Return Status        Element should be visible         xpath://div[@class='sfx_title_552 sfx_one-line_517' and @title='pm_DC_E_TCU_ACLENTRYIP4_DAY(No Aggregation Level)__NetAn_ODBC']
         IF   ${status} is ${TRUE}
               Exit For Loop
         ELSE
		       Mouse Over      xpath://div[text()='Linked copy to data table in analysis']
			   sleep    2s
               Run keyword if      ${status}==False      Selenium2Library.Drag And Drop By Offset      xpath:(//*[@class="sfx_handle-holder_11"])[6]      0      70
         END
         
    END
    Sleep      2s  
    Click Element     xpath://div[@class='sfx_title_552 sfx_one-line_517' and @title='pm_DC_E_TCU_ACLENTRYIP4_DAY(No Aggregation Level)__NetAn_ODBC']
    Sleep      2s
    click on the button    OK                
    sleep     5s
	#Click Element     xpath://button[@class='sf-element-button' and text()='OK']
	sleep     5s
    click on the button    Data
    click on the button    Add calculated column...
    ${column_expression}=     set variable    "[ACLENTRYPACKETS]+[ACLENTRYPACKETS (2)]"
    selenium2library.Press Keys    xpath:(//div[@class="CodeMirror-code"])     ${column_expression}
    sleep    2
    selenium2library.input text    xpath:(//input[@class="sf-element-input"])    calculatedColumn
               
    Wait Until Page Contains Element      xpath:(//button[@class="sf-element-button"])[1]     timeout=15
    Click Element    xpath:(//button[@class="sf-element-button"])[1]
    sleep    5  
    Wait Until Page Contains Element      xpath://div[@class='sfx_close-container_1282']    timeout=15
    Click Element    xpath://div[@class='sfx_close-container_1282']
    wait for page to load
    capture page screenshot

####################################### Spotfire version dependent keywords end ###############################################


open pm explorer analysis
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
    Go To    ${base_url}${pmex_url}
    #${IsElementVisible}=    Run Keyword And Return Status    Element Should not be Visible    xpath://div[contains(text(),'Missing Data')]
	#Run Keyword If    ${IsElementVisible} is ${FALSE}   Close missing data window
    wait for page to load
    Sleep    2s
	Wait Until Page Contains Element      xpath: //input[@value='Report Manager']     timeout=1500
    capture page screenshot

Logout from PM explorer
    Click element      xpath://div[@title='User']
	Sleep    2s
	Click element      xpath://div[@title='Log out']
	Sleep    5s
	Runkeyword and ignore error      click element      xpath://button[text()='No']
	Runkeyword and ignore error      click element      xpath://button[text()='OK']
	Wait Until Page Contains Element      xpath://div[text()='You have successfully logged out.']     timeout=60
	Capture page screenshot

Click on fetch pmdata button
    Click on scroll down button     1    2 
	Runkeyword and ignore error      Wait Until Element Is Visible         xpath://input[@value='Fetch PM Data' and contains(@style,'rgb(255, 255, 255)')]       timeout=120
    Click element     xpath://input[@value='Fetch PM Data']
	Sleep     2s
	Element Should Not Be Visible       xpath://div[@class='sfx_notification-actions_433']
    capture page screenshot
	wait for page to load
    Wait Until Page Contains Element      id:pageLabel     timeout=1500
	capture page screenshot

Click on create information link button 
	Wait Until Page Contains Element      xpath://*[@value="Create Information Link(s)"]     timeout=1500
	Click Element      xpath://*[@value="Create Information Link(s)"]
	Sleep    10s
	wait for page to load
	capture page screenshot	

Click on data integrity check box
	Click on scroll down button     1    2
	Wait Until Page Contains Element      xpath://div[@title="Data Integrity Check"]     timeout=1500
	Click Element      xpath://div[@title="Data Integrity Check"]
	sleep    3
	wait for page to load
    capture page screenshot

Click on update all pages check box
	Click on scroll down button     1    2
	Wait Until Page Contains Element      xpath://div[@title="Update All Pages"]     timeout=1500
	Click Element      xpath://div[@title="Update All Pages"]
	sleep    3
    capture page screenshot

Click on cancel button in save report page
	Wait Until Page Contains Element      xpath://input[@value="Cancel"]     timeout=1500
	Click Element      xpath://input[@value="Cancel"]
	sleep    3
    capture page screenshot

Click on update pmdata button
    #Click on scroll down button     1    2 
    Click element     xpath://input[@value='Update PM Data']
	capture page screenshot
	Sleep     2s
	capture page screenshot	
	wait for page to load
    capture page screenshot	
	
		

Check the Data Integrity Check box and Fetch PM Data
	Click on scroll down button     1    2
	Wait Until Page Contains Element      xpath://div[@title="Data Integrity Check"]     timeout=1500
	Click Element      xpath://div[@title="Data Integrity Check"]
	sleep    3
    Click on fetch pmdata button
    capture page screenshot

Verify error message when creating the alarm without collection name
	sleep    2s
    Clear Element Text      xpath:(//input[contains(@class,'sf-element sf-element-control sfc-property sfc-text-box')])[1]
	sleep    3s
	Click on Save button
	Wait Until Page Contains Element      xpath://*[contains(text(),'Collection Name is Required')]    100
	element should be visible    xpath://*[contains(text(),'Collection Name is Required')]
	wait for page to load
	capture page screenshot
	
Verify error message when saving the alarm without collection name
	sleep    2s
	FOR    ${i}    IN RANGE    0     3
		Clear Element Text      xpath:(//input[contains(@class,'sf-element sf-element-control sfc-property sfc-text-box')])[1]
		sleep    3s
	END
	Click on the save button on edit page	
	Wait Until Element Is Visible      xpath://*[contains(text(),'Collection Name is Required')]    100
	element should be visible    xpath://*[contains(text(),'Collection Name is Required')]
	wait for page to load
	capture page screenshot
	
Click on Save report to Library button
    Wait Until Page Contains Element      xpath://input[@value='Save Report to Library']       timeout=1500
    sleep    3s
    Click element    xpath://input[@value='Save Report to Library']  
    capture page screenshot
    wait for page to load
    Wait Until Element Is Visible     xpath: //input[@value='Create']    300   
    wait for page to load
    capture page screenshot
	
Click Save report button
	Wait Until Page Contains Element      id:saveBtn   timeout=1500	
	${status} =      Run keyword and return status     Click element    id:saveBtn
	IF    "${status}"=="False"
	      Click on scroll down button     2       1
		  Click element    id:saveBtn
    END    
	Wait Until Element Is Visible      xpath://input[@value='Save Report to Library']       timeout=300	
    wait for page to load
    
Click on scroll down button
    [Arguments]     ${button}    ${n}
    @{element}=    Get WebElements	    xpath: //div[@class="ScrollbarButton sf-element sf-element-scroll-bar-button sfpc-bottom"]
    ${scroll_button}=        Get from list     ${element}    ${button}
    FOR    ${i}    IN RANGE    0    ${n} 
           Run Keyword and Ignore Error    Click element     ${scroll_button}           
    END
	Sleep      2s
	capture page screenshot
	
	
change the mode to
	[Arguments]    ${mode}
	Wait Until Page Contains Element      xpath: ${author_dropdown}     timeout=300
	Click element       xpath: ${author_dropdown}
	Wait Until Page Contains Element      xpath://div[@title='${mode}']     timeout=300
	Click Element      xpath://div[@title='${mode}']
    Run keyword IF    "${mode}"=="Editing"        Wait Until Element Is Visible      xpath://div[@title='Data in analysis']       timeout=1500
	wait for page to load
	capture page screenshot
 
# This keyword is executing at suite setup. Cannot be used inside testcase
Connect to DB and sync with eniq
    Click on Administration button
	change the mode to     Editing
    @{element}=    Get WebElements	    xpath: //input[@class='sf-element sf-element-control sfc-property sfc-text-box']
    ${name}=        Get from list     ${element}    0
    ${username}=        Get from list     ${element}    1
    ${password}=        Get from list     ${element}    2
    ${eniqs}=        Get from list     ${element}    3
    Selenium2Library.Input Text    ${name}       localhost 
    Sleep     1s
    Selenium2Library.Input Text    ${username}       netanserver
    Sleep     1s
    Selenium2Library.Input Text    ${password}       Ericsson01 
    Sleep     1s
    Click element     xpath: //input[@id='a49e8a2e448349398408b044a165fee5']
    Sleep     10s
    FOR    ${i}    IN RANGE    0     5
         ${text}=      Get text      xpath://span[@id='a78fbda81332476ab91b65a4b88dad30']
         IF    '${text}'=='Connection OK'
               Exit For Loop
         ELSE IF     '${text}'=='please provide Value for: NetAn SQL DB URL'
               Selenium2Library.Input Text    ${name}       localhost
               
         ELSE IF     '${text}'=='please provide Value for: NetAn User Name'
               Selenium2Library.Input Text    ${username}       netanserver     
    
         ELSE IF       '${text}'=='please provide Value for: NetAn Password'
               Selenium2Library.Input Text    ${password}       Ericsson01
         ELSE IF       '${text}'=='please provide Value for: NetAn Password'
               Selenium2Library.Input Text    ${password}       Ericsson01			   
         END
         Sleep     1s
         Click element     xpath: //input[@id='a49e8a2e448349398408b044a165fee5']
         Sleep     10s
    END     
    
    FOR    ${i}    IN RANGE    0     5
          Clear Element Text      ${eniqs}
          Selenium2Library.Input Text    ${eniqs}       NetAn_ODBC 
          
    END   
        
    Sleep    3s
    Click element     xpath: //input[@id='075d5400a00740b1b64261f11e3d4f27']
    
    Sleep    10s
    wait for page to load

    Click element     xpath: //input[@value='Sync with ENIQ']
    Sleep    80s
    wait for page to load
    capture page screenshot
    Click element     xpath://img[@title='Home']
	Sleep     2
    click element       xpath://div[@title='File']
    click element       xpath://div[@title='Save as']
    click element       xpath://div[@title='Library item...']
    sleep     3s
    click element       xpath:${save_analysis_button}
    sleep     20s
    click element       xpath://button[text()='Yes']
    sleep     5s
    click element       xpath://button[text()='Yes']
    sleep     10s
    wait for page to load
    

Suite setup steps for WebUI
     Set Screenshot Directory   ./Screenshots
     Set Selenium Implicit Wait        60s
     Install Utility mobule in web player
     Close Browser
     open pm explorer analysis
     Connect to DB and sync with eniq
     Close Browser
     
Suite teardown steps for WebUI
     Close Browser
     
Test teardown steps for webUI
    Run Keyword and Ignore Error        Capture page screenshot
	Run Keyword and Ignore Error        Logout from PM explorer
    Run Keyword and Ignore Error        Close Browser

Verify the Measure Type check box enabled
    [Arguments]    ${measure type}
    @{list}=      Split string      ${measure type}    ,
    Click on scroll down button     9    3
    Element should be visible          xpath://div[@title='Counter']    
	Capture page screenshot
	
Verify the available measures
    [Arguments]     ${Measure}
   	@{list}=      Split string      ${Measure}     ,  
    FOR    ${meas}    IN    @{list}
        Sleep    3s
        ${measure_name_ui}=    Get text    xpath://div[@name='valueCellCanvas']//div[@row='1' and @column='0']
        Should Match     ${Measure}      ${measure_name_ui}
        #@{element}=    Get WebElements      xpath://div[@name='valueCellCanvas']//div[@row='1' and @column='1']
        #${ele}=        Get from list     ${element}    1  
        #Click element      ${ele} 
        Capture page screenshot
    END
          
Select All values in MO Class
    Click on scroll down button     9    5
	Click element       xpath:((//div[@class='ListItems'])[5]//div)[1]
	Capture page screenshot
	    
Select all MO classes in UI
    Click on scroll down button     9    7
    FOR    ${i}    IN RANGE   0   20
		@{element}=    Get WebElements      xpath:(//div[@class='ListItems'])[5]
		FOR    ${ele}    IN    @{element}
			 ${text}=  get text        ${ele}
			 Should not contain      ${text}     'Null'
			 Should not contain      ${text}     '{empty}'
		END
	END
    
Select all MO classes in UI for comma
    Click on scroll down button     9      7
    FOR    ${i}    IN RANGE   0   20
	    @{element}=    Get WebElements      xpath:(//div[@class='ListItems'])[5]
		FOR    ${ele}    IN    @{element}
			 ${text}=  get text        ${ele}
			 Should not contain      ${text}     '
			 Should not contain      ${text}     ,
		END
	END

change to page navigation to
	[Arguments]    ${mode}
	Wait Until Page Contains Element      xpath:${sfx_page_title}     timeout=300
	FOR    ${i}    IN RANGE    0     10
         ${status}=      Run keyword and return status   element should be visible      xpath://*[@title="Add new page"]
         IF   ${status} is ${TRUE}
               Exit For Loop
         ELSE
		        Run keyword and ignore error     open context menu      xpath:${sfx_page_title}
				Sleep    2s
				Run keyword and ignore error     Click Element      xpath:(//div[@class="contextMenuItemLabel"])[1]
				Sleep    2s
				Run keyword and ignore error     Click Element      xpath:(//div[@title="${mode}"])
				capture page screenshot
         END
         
    END

clear all fields in NetAn Connection
    @{element}=    Get WebElements	    xpath: //input[@class='sf-element sf-element-control sfc-property sfc-text-box']
    ${name}=        Get from list     ${element}    0
    ${username}=        Get from list     ${element}    1
    ${password}=        Get from list     ${element}    2
    ${eniqs}=        Get from list     ${element}    3
    Selenium2Library.Input Text    ${name}       ${EMPTY} 
    Sleep     1s
    Selenium2Library.Input Text    ${username}       ${EMPTY} 
    Sleep     1s
    Selenium2Library.Input Text    ${password}       ${EMPTY}  
    Sleep     1s
    Click element     xpath: //input[@id='a49e8a2e448349398408b044a165fee5']
    Sleep     10s
    FOR    ${i}    IN RANGE    0     5
         ${text}=      Selenium2Library.Get text      xpath://span[@id='a78fbda81332476ab91b65a4b88dad30']
         IF    '${text}'=='please provide Value for: NetAn SQL DB URL'
               Exit For Loop
         ELSE IF     '${text}'=='Connection OK'
                Selenium2Library.Input Text    ${name}       ${EMPTY} 
				Sleep     1s
				Selenium2Library.Input Text    ${username}       ${EMPTY} 
				Sleep     1s
				Selenium2Library.Input Text    ${password}       ${EMPTY}  
				Sleep     1s
				Click element     xpath: //input[@id='a49e8a2e448349398408b044a165fee5'] 
         END
         Sleep     10s
    END    
    Sleep    10s
	FOR    ${i}    IN RANGE    0     5
          Clear Element Text      ${eniqs}
          
    END           
    Sleep    3s
    Click element     xpath: //input[@id='075d5400a00740b1b64261f11e3d4f27']
	capture page screenshot	


Validate that the failed DataSource is not present in DataSource selection
    Wait Until Element Is Visible      xpath:(//div[@class="ComboBoxTextDivContainer"])[1]     300
    click element    xpath:(//div[@class="ComboBoxTextDivContainer"])[1]
    sleep    2
    element should not be visible      xpath://div[@title='Failed_ODBC']
    wait for page to load
	capture page screenshot	


Click on Edit button
    Click on scroll down button     1       2
	Wait Until Element Is Enabled      xpath: //input[@value="Edit"]     timeout=1500
    Click Element    xpath: //input[@value="Edit"]
	wait for page to load
	capture page screenshot	
	
Verify that the Edit page is visible
    Wait Until Page Contains Element      id:pageLabel     timeout=1500
	Sleep    5s
    Click Element    xpath:(//div[@class="sf-element sf-element-check-box flex-item flex-no-shrink flex-align-start sfpc-unchecked"])
	Sleep      10s
	wait for page to load
	element should be visible    xpath://*[text()='Select Topology']
	element should be visible    xpath://*[text()='Select Time']
	capture page screenshot
		
Click on View button
    Click on scroll down button     1       2
	Wait Until Element Is Enabled      xpath: //input[@value="View"]     timeout=1500
    Click Element    xpath: //input[@value="View"]
	wait for page to load
	capture page screenshot
		
	
Click on Report manager button   
	Click on scroll down button    0    15								   
    Wait Until Page Contains Element      xpath: //input[@value='Report Manager']     timeout=1500
	Click Element    xpath: //input[@value='Report Manager']
    Wait Until Element Is Visible     xpath: //input[@value='Create']    1500
    wait for page to load
    capture page screenshot	
	
Click on Create button
    capture page screenshot
    Wait Until Element Is Visible     xpath: //input[@value='Create']    300
    Click element     xpath: //input[@value='Create']
	FOR    ${i}    IN RANGE    0     10
	     Run keyword and ignore error        Wait Until Element Is Visible     xpath://div[@class='ComboBoxTextDivContainer']    300
         ${status}=      Run keyword and return status   element should not be visible      xpath://input[@value='Create']
         IF   ${status} is ${TRUE}
               Exit For Loop
         ELSE
		      Click element    xpath://input[@value='Create']
			  wait for page to load
         END
    END		  
	
Select ENIQ DataSource as
    [Arguments]     ${data_source}
    Sleep      10s
    @{element}=    Get WebElements	    xpath: //div[@class='ComboBoxTextDivContainer']
    ${node_type_ele}=        Get from list     ${element}    0
    Click element     ${node_type_ele}
    Click element      xpath://div[@title='${data_source}']	
    wait for page to load
	
Select ENIQ DataSource
    [Arguments]     ${data_source}
    Select ENIQ DataSource as	     ${data_source}
	
click on Select ENIQ DataSource dropdown
	Wait Until Page Contains Element      xpath:(//div[@class="ComboBoxTextDivContainer"])[1]     500
	click element      xpath:(//div[@class="ComboBoxTextDivContainer"])[1]
    wait for page to load
	capture page screenshot
	
Select System area
	[Arguments]     ${sys_area}
    Select System area as      ${sys_area}
	
Select the System area
    [Arguments]     ${sys_area}
    Select System area as      ${sys_area}
	
Select the System area as
    [Arguments]     ${sys_area}
    Select System area as      ${sys_area}
	
Select Node type
	[Arguments]     ${node_type}
    Select Node type as       ${node_type}
	
select the Node type
    [Arguments]     ${node_type}
    Select Node type as       ${node_type}
	
verify that Get Data For has proper value selected
	[Arguments]    ${getDataFor}
	element should be visible    xpath:(//div[@class="sf-element-text-box" and @title="${getDataFor}"])
	capture page screenshot
	
verify that Node Type has correct value selected
	[Arguments]    ${nodeType}
	element should be visible    xpath:(//div[@class="sf-element-text-box" and @title="${nodeType}"])
	capture page screenshot

Select Get Data For as
    [Arguments]     ${get_data_for}
	Click on scroll down button    6     5
	Sleep      10s
    @{element}=    Get WebElements	    xpath: //div[@class='ComboBoxTextDivContainer']
    ${node_type_ele}=        Get from list     ${element}    3
    Click element     ${node_type_ele}
    sleep  2s
    click element       xpath:(//div[@class="sf-element-dropdown-list-item" and @title="${get_data_for}"])
	wait for page to load
	capture page screenshot

Select Get Data For
	[Arguments]     ${get_data_for}
	Select Get Data For as        ${get_data_for}
	
click on the Get Data For dropdown
	Wait Until Page Contains Element      xpath:(//div[@class="ComboBoxTextDivContainer"])[4]     500
	click element      xpath:(//div[@class="ComboBoxTextDivContainer"])[4]
	capture page screenshot

verify the list items in Get Data For dropdown
	${listItems}=    Selenium2library.get text    xpath:(//div[@class="sf-element-dropdown-list sfc-scrollable"])
	Log    ${listItems}
	should contain    ${listItems}    Node(s)
	should contain    ${listItems}    Collection
	should contain    ${listItems}    Network
	should contain    ${listItems}    SubNetwork
	capture page screenshot


change Get Data For value in edit page
	[Arguments]    ${getDataFor}
	Wait Until Page Contains Element      xpath:(//div[@class="ComboBoxTextDivContainer"])[2]     timeout=1500
	sleep    3
    Click Element    xpath:(//div[@class="ComboBoxTextDivContainer"])[2]
    sleep    3
    Wait Until Page Contains Element      xpath:(//div[@title="${getDataFor}" and @class="sf-element-dropdown-list-item"])     timeout=1500
    Click Element    xpath:(//div[@title="${getDataFor}" and @class="sf-element-dropdown-list-item"])
	capture page screenshot

Click on Refresh nodes button
    Click on scroll down button    6    10
    sleep   2s
    Click element     xpath: //input[@value='Refresh Nodes'][1]
    Wait Until Page Contains Element      xpath://input[contains(@class,'SearchInput sf-element-input sf-suppress-forms-accept-command sf-suppress-forms-cancel-command sf-input-with-placeholder')]     timeout=1500
    wait for page to load
    capture page screenshot


Select Nodes as
    [Arguments]    ${node_list}
    Click on scroll down button     6    5
    @{list}=      Split string      ${node_list}    ,
     FOR    ${node}    IN    @{list}	       
		   wait until element is visible    xpath: //input[contains(@class,'SearchInput sf-element-input sf-suppress-forms-accept-command sf-suppress-forms-cancel-command sf-input-with-placeholder')]    30
           FOR    ${i}    IN RANGE    0    7
			   Run keyword and ignore error      Clear Element Text      xpath://input[contains(@class,'SearchInput sf-element-input sf-suppress-forms-accept-command sf-suppress-forms-cancel-command sf-input-with-placeholder')]
			   Run keyword and ignore error       wait until element is visible    xpath: //input[contains(@class,'SearchInput sf-element-input sf-suppress-forms-accept-command sf-suppress-forms-cancel-command sf-input-with-placeholder')]    30
			   Run keyword and ignore error       click element    xpath: //input[contains(@class,'SearchInput sf-element-input sf-suppress-forms-accept-command sf-suppress-forms-cancel-command sf-input-with-placeholder')]
			   Sleep     5s
			   Run keyword and ignore error        Selenium2Library.Input Text     xpath: //input[contains(@class,'SearchInput sf-element-input sf-suppress-forms-accept-command sf-suppress-forms-cancel-command sf-input-with-placeholder')]     ${node} 
			   Click on scroll down button     6    1
			   Click on scroll up button     6    1
			   sleep    2s
			   wait for page to load
			   ${text}=    Selenium2Library.Get Text     xpath: ((//div[@class='ListItems'])[2]//div[@class='sf-element-list-box-item'])[1]
			   ${status}=    Run keyword and return status       Should match      ${text}        ${node}
			    Capture page screenshot
			   IF    ${status}==True    
						   Capture page screenshot
						   exit for loop
			   END
		    END
		   ${status}=     Run Keyword And Return Status        Element should be visible          xpath://div[@title='${node}']
		   Click element      xpath://div[@title='${node}']      modifier=CTRL
		   sleep   1s
		   wait for page to load
           capture page screenshot	   
     END

Select Nodes
	[Arguments]    ${node_list}
    Select Nodes as      ${node_list}

Select the Nodes as
    [Arguments]    ${node_list}
    Select Nodes as      ${node_list}

Select the Nodes
    [Arguments]    ${node_list}
    Select Nodes as      ${node_list}

Select Aggregation as 
    [Arguments]     ${Aggregation}
    Click on scroll down button    6     25         
    @{element}=    Get WebElements	    xpath: //div[@class='ComboBoxTextDivContainer']
    ${Aggregation_ele}=        Get from list     ${element}    4
    Click element     ${Aggregation_ele}
    Sleep    3s
    Click element      xpath://div[@class='sf-element-dropdown-list-item'][@title='${Aggregation}']
    Sleep    5s
    wait for page to load
    capture page screenshot
	
Select MOClass as 
    [Arguments]    ${MOClass}
    Click on scroll down button     9    5
    @{list}=      Split string      ${MOClass}    ,
    FOR    ${mo}    IN    @{list}
        Clear Element Text     xpath:(//input[@class='SearchInput sf-element-input sf-suppress-forms-accept-command sf-suppress-forms-cancel-command sf-input-with-placeholder'])[4] 
        Selenium2Library.Input Text     xpath:(//input[@class='SearchInput sf-element-input sf-suppress-forms-accept-command sf-suppress-forms-cancel-command sf-input-with-placeholder'])[4]    ${MOClass} 
        sleep    1s
        Click on scroll up button     9    3
        #Wait Until Page Contains Element    xpath://div[@title='${mo}']
        #Press Keys      xpath:(//input[@class='SearchInput sf-element-input sf-suppress-forms-accept-command sf-suppress-forms-cancel-command sf-input-with-placeholder'])[4]      RETURN
        sleep    5s
        wait for page to load
        Click element      xpath://div[@title='${mo}']      modifier=CTRL   
        sleep   1s
        Capture page screenshot
    END	

Select System area and verify none value is not present
    [Arguments]     ${sys_area}
    sleep  3s      #3 seconds given for syatem area to load based on selected data source
    @{element}=    Get WebElements	    xpath: //div[@class='ComboBoxTextDivContainer']
    ${sys_area_ele}=        Get from list     ${element}    1
    Wait Until Element Is Visible        ${sys_area_ele}
    Click element     ${sys_area_ele}
    sleep    2s
    element should not be visible    xpath://div[contains(@class,'sf-element-dropdown-list-item') and @title="(None)"]
    sleep  1s
    Click element      xpath://div[@title='${sys_area}']
	wait for page to load				  
    element should not be visible    xpath:((//span[@style= "COLOR: #fa7864"])[1])//span[contains(text(),'Select System Area')]
	capture page screenshot
			  
Select Aggregation
	[Arguments]     ${Aggregation}
    Select Aggregation as        ${Aggregation}

Select the Aggregation as
	[Arguments]     ${Aggregation}
    Select Aggregation as        ${Aggregation}

Select the Aggregation
	[Arguments]     ${Aggregation}
    Select Aggregation as        ${Aggregation}


Select the measure type 
    [Arguments]     ${list}
	Run keyword and ignore error      Select All values in MO Class
    @{measure_type}=      Split string      ${list}    ,
    ${InList}=    Get Match Count    ${measure_type}    COUNTER
    ${status}=     Run Keyword And Return Status        Element should be visible          xpath://div[@title='Counter']
    Run keyword if    ${InList}!=1 and ${status}==True  Click element    xpath://div[@title='Counter']
    sleep    2
    ${InList}=    Get Match Count    ${measure_type}    PDF_COUNTER
    ${status}=     Run Keyword And Return Status        Element should be visible          xpath://div[@title='PDF Counter']
    Run keyword if    ${InList}!=1 and ${status}==True    Click element    xpath://div[@title='PDF Counter']
	click on scroll down button       9        2
    sleep    2
    ${InList}=    Get Match Count    ${measure_type}    ERICSSON_KPI
    ${status}=     Run Keyword And Return Status        Element should be visible          xpath://div[@title='Ericsson KPI']
    Run keyword if    ${InList}!=1 and ${status}==True    Click element    xpath://div[@title='Ericsson KPI']
    Sleep   2s
    ${InList}=    Get Match Count    ${measure_type}    RI
    ${status}=     Run Keyword And Return Status        Element should be visible          xpath://div[@title='RI']
    Run keyword if    ${InList}!=1 and ${status}==True    Click element    xpath://div[@title='RI']
    sleep    2
	click on scroll down button       9        2
    ${InList}=    Get Match Count    ${measure_type}    CUSTOM_KPI
    ${status}=     Run Keyword And Return Status        Element should be visible          xpath://div[@title='Custom KPI'] 
    Run keyword if    ${InList}!=1 and ${status}==True    Click element    xpath://div[@title='Custom KPI']    
	click on scroll down button       9        2															
    sleep    2s
    ${InList}=    Get Match Count    ${measure_type}    FLEX_COUNTER
    ${status}=     Run Keyword And Return Status        Element should be visible          xpath://div[@title='Flex Counter']
    Run keyword if    ${InList}!=1 and ${status}==True    Click element    xpath://div[@title='Flex Counter']
    sleep    2
	click on scroll down button       9        2
    ${InList}=    Get Match Count    ${measure_type}    FLEX_PDF
    ${status}=     Run Keyword And Return Status        Element should be visible          xpath://div[@title='Flex+PDF Counter']
    Run keyword if    ${InList}!=1 and ${status}==True    Click element    xpath://div[@title='Flex+PDF Counter']
	click on scroll down button       9        10
    Clear Element text      xpath://input[@placeholder='Type to filter by text']	

Select measure type 
    [Arguments]     ${list}
    Select the measure type       ${list} 

Select measure type without Custom KPI
    [Arguments]     ${list}
    Select the measure type       ${list} 

Select KPIs
	[Arguments]    ${kpi_list}
	@{list}=      Split string      ${kpi_list}     ,  
	wait for page to load
	element should not be visible    xpath:((//div[@class="ListItems"])[5])//div[contains(text,'(All) 0 values')]				  
    FOR    ${kpi}    IN    @{list}
            Clear Element Text      xpath://input[contains(@class,'sf-element sf-element-input sf-input-with-placeholder')]
            Selenium2Library.Input Text     xpath://input[contains(@class,'sf-element sf-element-input sf-input-with-placeholder')]     ${kpi} 
            click on scroll down button       9        1
            wait until element is visible     xpath://div[@name='valueCellCanvas']//div[@row='1' and @column='0']   60          
            #@{element}=    Get WebElements      xpath://div[@name='valueCellCanvas']//div[@row='1' and @column='0']
            #${ele}=        Get from list     ${element}    0
			#wait until element is visible    ${ele}    15
			Sleep      5s
            Click element       xpath://div[@name='valueCellCanvas']//div[@row='1' and @column='0']  
			sleep    2s
		    ${marked}=    selenium2library.get text    xpath:(//div[@class="${sfx_label}"])[2]
		    IF    "${marked}"=="0 marked"
				FOR    ${i}    IN RANGE    0     4
					wait until element is visible     xpath://div[@name='valueCellCanvas']//div[@row='1' and @column='0']   60          
					@{element}=    Get WebElements      xpath://div[@name='valueCellCanvas']//div[@row='1' and @column='0']
					${ele}=        Get from list     ${element}    0
					wait until element is visible    ${ele}    15
					Click element      ${ele}
					sleep    2
					${marked}=    selenium2library.get text    xpath:(//div[@class="${sfx_label}"])[2]
					run keyword if    "${marked}"!="0 marked"    exit for loop
				END
		    END				
            wait until element is visible    xpath: //input[@value='>>']    30
            Click element      xpath: //input[@value='>>']
			wait for page to load			
		    ${text}=    selenium2library.get text    xpath: ((//div[@class="valueCellsContainer"])[3])//div[@name="valueCellCanvas"]
		    ${status}=    run keyword and return status    should contain    ${text}    ${kpi}	    ignore_case=true		
		    IF    "${status}"=="False"
		        FOR    ${i}    IN RANGE    1    15
					Run keyword and ignore error    Click element      xpath: //input[@value='>>']
			        sleep    10
				    Run keyword and ignore error        wait until element is visible    xpath: ((//div[@class="valueCellsContainer"])[3])//div[@name="valueCellCanvas"]    30
				    ${text}=    selenium2library.get text    xpath: ((//div[@class="valueCellsContainer"])[3])//div[@name="valueCellCanvas"]
				    ${status}=    run keyword and return status    should contain    ${text}    ${kpi}	    ignore_case=true
				    run keyword if    "${status}"=="True"  exit for loop
			    END
		    END
		    sleep   5s
            wait for page to load
		    Capture page screenshot
    END

Select KPI
	[Arguments]    ${kpi_list}
	Select KPIs          ${kpi_list}

Select the KPIs
    [Arguments]    ${kpi_list}
	Select KPIs          ${kpi_list}

Select time drop down to  
    [Arguments]    ${time}  
     @{element}=    Get WebElements	    xpath: //div[@class='ComboBoxTextDivContainer']
     ${_ele}=        Get from list     ${element}    5
     Click element     ${ele}
     Sleep    3s
     Click element      xpath://div[@title='${time}'] 
     Sleep    2s
     wait for page to load


Select Aggregation in select time as
     [Arguments]    ${Aggregation}
	 sleep    5s	
     Click on scroll down button    7    3	 
     @{element}=    Get WebElements	    xpath: //div[@class='ComboBoxTextDivContainer']
     ${Aggregation_ele}=        Get from list     ${element}    6
     Click element     ${Aggregation_ele}
     Sleep    3s
     Click element      xpath://div[@title='${Aggregation}']
     wait for page to load   

Verify if fetch pm data button is disabled
    ${status1}=      Run keyword and return status       Click element     xpath: //input[@value='Fetch PM Data']
	Run keyword IF     ${status1}==True     FAIL      msg= Fetch nodes button is enabled
    wait for page to load
    capture page screenshot

Verify if fetch pm data button is enabled
    ${status1}=      Run keyword and return status       Element should be visible     xpath: //input[@value='Fetch PM Data']
	Run keyword IF     ${status1}==False     FAIL      msg= Fetch nodes button is disabled
    wait for page to load
    capture page screenshot
 
Verify the page title
    [Arguments]     ${Aggregation}     ${data_source}    ${Aggregation_in_time}
    wait for page to load
    Wait Until Page Contains Element      id:pageLabel     timeout=1500																   
    ${text}=    Get text   id:pageLabel
    Log    ${text}
    Should contain    ${text}    ${Aggregation}
    Should contain    ${text}    ${data_source}
    #${list}=    Split String	 ${kpi}    .
    #${table}=    Get From List    ${list}    1
    #Should contain    ${text}    ${Aggregation} 
    IF    "${Aggregation_in_time}"=="ROP"
        Should contain    ${text}    RAW
    ELSE IF       "${Aggregation_in_time}"=="BusyHour"
        Should contain        ${text}    DAYBH	
    ELSE
        ${agg}=     Convert To Upper Case     ${Aggregation_in_time}
        Should contain    ${text}    ${agg}
    END
    capture page screenshot
     
Verify columns displayed
    [Arguments]     ${colums_list}
    @{list}=      Split string      ${colums_list}    ,
    FOR    ${col}    IN    @{list}
        Element Should Be Visible     xpath://div[text()='${col}']      
    END      
    capture page screenshot
     
Enter details to save report to library
    [Arguments]     ${report_name}    ${access_type}     ${description}
	Wait Until Page Contains Element       xpath://span[@id='reportNameInputField']//input[@class='sf-element sf-element-control sfc-property sfc-text-box']           timeout=1500
    ${date}=     Get Current Date
    ${date_string}=     Convert to string     ${date}
    ${ds}=     Replace String	    ${date_string}	   :   	_
    ${ds1}=    Replace String	    ${ds}	   ${SPACE}   	_ 
    ${date_string}=    Replace String	    ${ds1}	   .   	_ 
    Log      ${date_string}
	Clear Element text                xpath://span[@id='reportNameInputField']//input[@class='sf-element sf-element-control sfc-property sfc-text-box'] 
    Sleep     2s
    Selenium2Library.Input Text      xpath://span[@id='reportNameInputField']//input[@class='sf-element sf-element-control sfc-property sfc-text-box']      ${report_name}${date_string}
    Click on scroll down button    3    4
	sleep    5s		   
    Click element    xpath://div[@class='ComboBoxTextDivContainer']
    sleep    2s
    Click element    xpath://div[@title='${access_type}']
	Scroll Element Into view    xpath://textarea[@class='sf-element sf-element-control sfc-property sfc-text-box']													 
    Clear Element text      xpath://textarea[@class='sf-element sf-element-control sfc-property sfc-text-box']
    sleep    2
    Selenium2Library.Input Text    xpath://textarea[@class='sf-element sf-element-control sfc-property sfc-text-box']    ${description} 
    sleep    2s
	Click on scroll up button    3    4
    [return]       ${report_name}${date_string}	
	
click on Save Report button
    Wait Until Element Is Not Visible                xpath://*[@class='sf-svg-loader-12x12']          timeout=300
    Wait Until Page Contains Element      xpath://*[@value="Save Report"]     timeout=1500
    Run keyword and ignore error     Click on scroll down button    2     1
	Run keyword and ignore error     Click on scroll down button    3     1
	Click Element      xpath://*[@value="Save Report"]
    wait for page to load
    capture page screenshot	
	
Click on Save Report
	click on Save Report button	
	
Verify saved report available in Report manager GUI 
     [Arguments]    ${report_name}    ${access_type}     ${description}
     Wait Until Element Is Visible         xpath: //input[@value='Create']        300
     Click on scroll down button     5    2
     Clear Element Text       xpath://input[@class='sf-element sf-element-input sf-input-with-placeholder']
	 Sleep    5s
     Selenium2Library.Input Text     xpath://input[@class='sf-element sf-element-input sf-input-with-placeholder']      ${report_name}
     Sleep    6s
     press key      xpath://div[@class='HtmlTextArea sf-enable-selection sf-focusable']      \\13
     Sleep    5s
	 wait for page to load
     ${report_name_ui}=    Get text    xpath://div[@name='valueCellCanvas']//div[@row='1' and @column='1']
     ${access_type_ui}=    Get text    xpath://div[@name='valueCellCanvas']//div[@row='1' and @column='3']
     ${description_ui}=    Get text    xpath://div[@name='valueCellCanvas']//div[@row='1' and @column='2']
     ${report_title}=    Get text    xpath://div[@name='valueCellCanvas']//div[@row='1' and @column='4']
     Should Match     ${report_name}      ${report_name_ui}
     Should Match     ${access_type}      ${access_type_ui}
     Should Match     ${description}      ${description_ui}
	 
	 
Verify that the report is saved to the DB
    [Arguments]     ${reportname}
    ${sql}=    set variable    select "ReportName" FROM "tblSavedReports" WHERE "ReportName"='${reportname}'
    ${results}=  Query Postgre database and return output     ${sql}
    ${value}=    Get From List    ${results}     0
    Should contain    ${value}      ${reportname}	 
	 
Click on Administration button
    Wait Until Page Contains Element      xpath: //img[@title='Administration']     timeout=600
	Click on scroll down button    0    15
    Click element     xpath://img[@title='Administration']
    Sleep    10
	Wait Until Page Contains Element       xpath: //input[@value='Sync with ENIQ']       timeout=1500
    Capture page screenshot	 
	 
	 
Click on Collection Manager button    
    Wait Until Page Contains Element      xpath: //input[@value='Collection Manager']     timeout=1500
	Click on scroll down button    0    15
    Click Element    xpath: //input[@value='Collection Manager']
    Wait Until Page Contains Element      xpath: //input[@value='Create Collection']     timeout=1500
    wait for page to load
    capture page screenshot	 
	 
Click on Create Collection button
	Wait Until Page Contains Element      xpath: //input[@value='Create Collection']     timeout=1500
    Click Element    xpath: //input[@value='Create Collection']
    wait for page to load
	capture page screenshot	 
	 
validate the page title  
	[Arguments]     ${expectedText}
    wait for page to load
    ${text}=    Selenium2Library.Get text  xpath: ${sfx_page_title}
    Log    ${text}
    Should contain     ${expectedText}	 ${text}
	capture page screenshot
		 
Enter the Collection name
	Clear Element Text      xpath:(//input[contains(@class,'sf-element sf-element-control sfc-property sfc-text-box')])[1]
	${currDate}=    Get current date
	${collectionName}=    set variable    Collection_${currDate}
	sleep    2s		
    Selenium2Library.Input Text     xpath:(//input[contains(@class,'sf-element sf-element-control sfc-property sfc-text-box')])[1]    ${collectionName}
	sleep     2s
	Click on scroll down button    6    1
	Click on scroll up button    6    1
	FOR    ${i}    IN RANGE    0     5
         ${text}=         Get Element Attribute        xpath:(//input[contains(@class,'sf-element sf-element-control sfc-property sfc-text-box')])[1]         value
         IF    '${text}'=='${collectionName}'
               Exit For Loop
         ELSE 
		        Clear Element Text      xpath:(//input[contains(@class,'sf-element sf-element-control sfc-property sfc-text-box')])[1]
				Sleep     1s
				Selenium2Library.Input Text     xpath:(//input[contains(@class,'sf-element sf-element-control sfc-property sfc-text-box')])[1]    ${collectionName}
				Click on scroll down button    6    1
				Click on scroll up button    6    1
				Sleep      1s
         	END
   	 END   	
    #press keys      xpath:(//input[contains(@class,'sf-element sf-element-control sfc-property sfc-text-box')]     ENTER
    [Return]    ${collectionName}
	wait for page to load
	capture page screenshot	 

Enter the Collection name for edit in dynamic collection
	Clear Element Text      xpath:(//input[contains(@class,'sf-element sf-element-control sfc-property sfc-text-box')])[1]
	${currDate}=    Get current date
	${collectionName}=    set variable    Collection_${currDate}
	sleep    2s		
    Selenium2Library.Input Text     xpath:(//input[contains(@class,'sf-element sf-element-control sfc-property sfc-text-box')])[1]    ${collectionName}
	sleep     2s
	Click on scroll down button    3    1
	Click on scroll up button    3    1
	FOR    ${i}    IN RANGE    0     5
         ${text}=         Get Element Attribute        xpath:(//input[contains(@class,'sf-element sf-element-control sfc-property sfc-text-box')])[1]         value
         IF    '${text}'=='${collectionName}'
               Exit For Loop
         ELSE 
		        Clear Element Text      xpath:(//input[contains(@class,'sf-element sf-element-control sfc-property sfc-text-box')])[1]
				Sleep     1s
				Selenium2Library.Input Text     xpath:(//input[contains(@class,'sf-element sf-element-control sfc-property sfc-text-box')])[1]    ${collectionName}
				Click on scroll down button    3    1
				Click on scroll up button    3    1
				Sleep      1s
         	END
   	 END   	
    #press keys      xpath:(//input[contains(@class,'sf-element sf-element-control sfc-property sfc-text-box')]     ENTER
    [Return]    ${collectionName}
	wait for page to load
	capture page screenshot	 

Enter the Collection name for dynamic collection
    [Arguments]        ${collectionName}
	Clear Element Text      xpath:(//input[contains(@class,'sf-element sf-element-control sfc-property sfc-text-box')])[1]
	sleep    2s		
    Selenium2Library.Input Text     xpath:(//input[contains(@class,'sf-element sf-element-control sfc-property sfc-text-box')])[1]    ${collectionName}
	sleep     2s
	Click on scroll down button    3    1
	Click on scroll up button    3    1
	FOR    ${i}    IN RANGE    0     5
         ${text}=         Get Element Attribute        xpath:(//input[contains(@class,'sf-element sf-element-control sfc-property sfc-text-box')])[1]         value
         IF    '${text}'=='${collectionName}'
               Exit For Loop
         ELSE 
		        Clear Element Text      xpath:(//input[contains(@class,'sf-element sf-element-control sfc-property sfc-text-box')])[1]
				Sleep     1s
				Selenium2Library.Input Text     xpath:(//input[contains(@class,'sf-element sf-element-control sfc-property sfc-text-box')])[1]    ${collectionName}
				Click on scroll down button    3    1
				Click on scroll up button    3    1
				Sleep      1s
         	END
   	 END   	
    #press keys      xpath:(//input[contains(@class,'sf-element sf-element-control sfc-property sfc-text-box')]     ENTER
    [Return]    ${collectionName}
	wait for page to load
	capture page screenshot

	
	
verify that the DataSource is present and select it
	[Arguments]     ${data_source}
    Sleep    2
    Wait Until Element Is Visible      xpath:(//div[@class="ComboBoxTextDivContainer"])[1]     300
    click element    xpath:(//div[@class="ComboBoxTextDivContainer"])[1]
    sleep    2
    element should be visible      xpath://div[@title='${data_source}']
    click element    xpath://div[@title='${data_source}']
	capture page screenshot

Check the Dynamic Collection check box
    Click on scroll down button     6    15
	Wait Until Page Contains Element      xpath://div[@class="flex-item flex-container-horizontal flex-inline-container flex-align-center"]     timeout=1500
	Click Element      xpath://div[@class="flex-item flex-container-horizontal flex-inline-container flex-align-center"]
	Wait Until Page Contains Element         xpath://input[@id="643a8f060b154024ae32a0583a9f793d"]        150
	capture page screenshot


Enter Wildcard Expression
	[Arguments]    ${wildcardExp}
	Click on scroll down button     3    15
	Clear Element Text      xpath://input[@id="643a8f060b154024ae32a0583a9f793d"]
	Selenium2Library.Input Text     xpath://input[@id="643a8f060b154024ae32a0583a9f793d"]    ${wildcardExp}
    press key      xpath://input[@id="643a8f060b154024ae32a0583a9f793d"]     \\13
	Sleep     3s
	capture page screenshot
	
Verify that the Collection is created
	[Arguments]    ${collectionName}
	place cursor on    CollectionName
	sleep    2		  
    Click on maximise window button     0
	sleep    5
	${status}=    run keyword and return status    Element should be visible    xpath://*[contains(text(),'${collectionName}')]
	IF    "${status}"=="False"
		FOR    ${i}    IN RANGE    0    20
			place cursor on    CollectionName
			sleep    2	
			Click on scroll up button    0    5
			${status}=    run keyword and return status    Element should be visible    xpath://*[contains(text(),'${collectionName}')]
			Exit For Loop If     ${status} == True
		END				
	END
	place cursor on    CreatedBy
	place cursor on    CollectionName
    click on the button    Restore visualization layout
	wait for page to load
	capture page screenshot

wait for page to load
	Sleep   3s
	run keyword and ignore error       Wait Until Element Is Not Visible      xpath://*[@class='sf-svg-loader-12x12']              timeout=1500
    run keyword and ignore error       Wait Until Element Is Not Visible     class:${sfx_progress-bar}       timeout=1500
    Sleep   2s
    run keyword and ignore error       Wait Until Element Is Not Visible     class:${sfx_progress-bar}       timeout=1500
    Sleep   2s
	run keyword and ignore error       Wait Until Element Is Not Visible      xpath://*[@class='sf-svg-loader-12x12']              timeout=1500

	
	 
############################################### old keywords   #############################################################################


Close missing data window
	Wait Until Page Contains Element      xpath://span[contains(text(),'Apply to all inaccessible data tables in this analysis')]     timeout=150
    Click Element    xpath://span[contains(text(),'Apply to all inaccessible data tables in this analysis')]
    sleep    5
    Wait Until Page Contains Element      xpath://button[contains(text(),'OK')]     timeout=150
    Click Element    xpath://button[contains(text(),'OK')]	
 
Click on Select measure
    Click on scroll down button     6    20 
    Click element     id:selectMeasure
   
Click on Select time   
    Click on scroll down button     6    20 
    Click element     id:selectTimes

Click on Add button
    Sleep    3s
    Click element     xpath://input[@value='Add >>']
     	
Verify that the results are displayed for selected filter values
    [Arguments]    ${FilterValue}
	${status}=    run keyword and return status    Wait Until Page Contains Element      xpath://div[@class='cell-text' and text()='${FilterValue}']    timeout=20
	IF    "${status}"=="False"
		wait until element is visible    xpath: (//div[@class="ComboBoxTextDivContainer"])    30
		click element    xpath: (//div[@class="ComboBoxTextDivContainer"])
		wait until element is visible    xpath: ((//div[@class="ListItems"])//div[@class="sf-element-dropdown-list-item"])[1]    30
		click element    xpath: ((//div[@class="ListItems"])//div[@class="sf-element-dropdown-list-item"])[1]
	END
	wait until element is visible    //div[@class='cell-text' and text()='${FilterValue}']    timeout=60
	capture page screenshot								  
  
Get cell value 
    [Arguments]  ${col}    ${row}
    ${count}=     set variable    0
    @{element}=    Get WebElements	    xpath://div[@name='frozenRowsCanvas']//div[@row='0']
    FOR    ${ele}    IN    @{element}
        ${text}=    Selenium2Library.Get Text   ${ele}
        ${cell_value}=    Run Keyword And Return If     "${text}" == "${col}"     Selenium2Library.Get text  xpath://div[@name='valueCellCanvas']//div[@row='${row}' and @column='${count}']     
        Run Keyword If     "${text}" == "${col}"    exit for loop  
        ${count}=   Evaluate    ${count} + 1             
        
    END
    Log     ${cell_value} 
    [return]  ${cell_value} 
    
Open Report
    [Arguments]     ${Report_name}
    @{element}=    Get WebElements	    xpath: //div[@name='valueCellCanvas']//div[@column=1]
    ${ele}=    Get from list     ${element}    -1
    Click element    ${ele}
    # FOR    ${ele}    IN    @{element}
        # ${text}=    Selenium2Library.Get Text   ${ele}
        # Run Keyword If     "${text}" == "${Report_name}"    Click element    ${ele}
        # Run Keyword If     "${text}" == "${Report_name}"    exit for loop                
        
    # END
    Sleep    5
    Click element     xpath: //input[@value='View']
    wait for page to load  
    Capture Page Screenshot
   
Verify Dataintegrity of the Measure
      [Arguments]     ${col_list_name}     ${formula}     ${Measure}
      ${col_list}=      Split string      ${col_list_name}    ,
      ${val}=     set variable    ${formula}
      FOR    ${col}    IN    @{col_list}
        ${col_value}=     Get cell value      ${col}       1
        ${str} =	Replace String	    ${val}	   ${col}   	${col_value}         
        ${val}=     set variable    ${str}
      END
      Log     ${val}
      ${value}=     Evaluate    ${val}
      ${num}=    Convert To Number	    ${value}    2
      ${string_value}=      Convert To String      ${num}
      ${measure_value}=    Get cell value       ${Measure}    1
      Should contain     ${string_value}      ${measure_value}
   
Select the Collection
	Click text    deleteCollection
	#Click Element    xpath: //div[@text='deleteCollection']
	wait for page to load
	capture page screenshot
	
Click on Delete Collection button
	Wait Until Page Contains Element      xpath: //input[@value='Delete Collection']     timeout=1500
    Click Element    xpath: //input[@value='Delete Collection']
	wait for page to load
	capture page screenshot

reload the data
    Click Element    xpath: //div[@title='Data']   
    Wait Until Page Contains Element      xpath: //div[@title='Reload linked data']     timeout=150
    Click Element    xpath: //div[@title='Reload linked data']
	
Click OK on Confirmation Window
	Wait Until Page Contains Element      xpath: //div[@class='ui-dialog ui-widget ui-widget-content ui-corner-all ui-dialog-buttons']     timeout=1500
    Wait Until Page Contains Element      xpath: //button[@class='ui-button ui-widget ui-state-default ui-corner-all ui-button-text-only']     timeout=1500
    Click Element    xpath: //button[@class='ui-button ui-widget ui-state-default ui-corner-all ui-button-text-only'][1]
    wait for page to load
	capture page screenshot
	
Connect to the ENIQ DB
    Wait Until Page Contains Element      xpath: //img[@title='Administration']     timeout=1500
    Click element     xpath://img[@title='Administration']
    Sleep    5s
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
    Selenium2Library.Input Text    ${password}       Ericsson01 
    Sleep     1s
    Click element     xpath: //input[@id='a49e8a2e448349398408b044a165fee5']
    Sleep     10s
    FOR    ${i}    IN RANGE    0     5
         ${text}=      Selenium2Library.Get text      xpath://span[@id='a78fbda81332476ab91b65a4b88dad30']
         IF    '${text}'=='Connection OK'
               Exit For Loop
         ELSE IF     '${text}'=='please provide Value for: NetAn SQL DB URL'
               Selenium2Library.Input Text    ${name}       localhost
               
         ELSE IF     '${text}'=='please provide Value for: NetAn User Name'
               Selenium2Library.Input Text    ${username}       netanserver     
    
         ELSE IF       '${text}'=='please provide Value for: NetAn Password'
               Selenium2Library.Input Text    ${password}       Ericsson01 
         END
         Sleep     1s
         Click element     xpath: //input[@id='a49e8a2e448349398408b044a165fee5']
         Sleep     10s
    END    
    FOR    ${i}    IN RANGE    0     5
          Clear Element Text      ${eniqs}
          Selenium2Library.Input Text    ${eniqs}       NetAn_ODBC           
    END       
    Sleep    3s
    Click element     xpath: //input[@id='075d5400a00740b1b64261f11e3d4f27']    
    Sleep    10s
    
    
Verify that the Collection is deleted
	[Arguments]    ${name}
	Element should not contain    xpath:(//div[@class="valueCellsContainer"])[1]    ${name}
	wait for page to load
	capture page screenshot



Select DataSource as
	[Arguments]     ${data_source}
    Sleep      10s
    @{element}=    Get WebElements	    xpath://span[@class="sf-element sf-element-control sfc-property"]
    ${node_type_ele}=        Get from list     ${element}    0
    Click element      ${node_type_ele}
    Click element      xpath://div[@title='${data_source}']
	wait for page to load
	capture page screenshot

Click on Add >>
	Wait Until Page Contains Element      xpath: //input[@value="Add >>"]     timeout=1500
    Click Element    xpath: //input[@value="Add >>"]
	wait for page to load
	capture page screenshot
	
Click on Save button
	Wait Until Page Contains Element      xpath: //input[@value="Save"]     timeout=1500
    Click Element    xpath: //input[@value="Save"]
	wait for page to load
	capture page screenshot
	
Click on the save button on edit page
	sleep    5
	Wait Until Page Contains Element      xpath:(//input[@value="Save"])[3]     timeout=1500
    Click Element    xpath:(//input[@value="Save"])[3]
	wait for page to load
	capture page screenshot

Click on Next Button
    Click element  	    xpath: //div[@title='Next']	

Set FlexFilterValues to
    [Arguments]     ${filtertype}
    Sleep      10s
    Click on scroll down button     18    3
    @{element}=    Get WebElements      xpath://div[@name='valueCellCanvas']//div[@row='1' and @column='0']                                        
    ${ele}=        Get from list     ${element}    1
    Click element      ${ele}  
    Sleep      10s   
    @{element}=    Get WebElements	    xpath: //div[@class='ComboBoxTextDivContainer']
    ${filter_type_ele}=        Get from list     ${element}    10
    Click element     ${filter_type_ele}
    Click element      xpath://div[@title='${filtertype}']
    sleep     10s
    capture page screenshot

Fetch Flex filter values
    Click on scroll down button     18    6
    Click element       xpath://input[@value='Refresh filter list']
    sleep     5s
 

Select Flex filter value as
    [Arguments]    ${flexfilter}
    ${count}=     set variable    0
    @{list_filter}=  Create List
    @{list}=      Split string      ${flexfilter}    ,
    FOR    ${filter}    IN    @{list}    
           Log       ${count}              
           @{element}=    Get WebElements	    xpath://input[contains(@class,'SearchInput sf-element-input sf-suppress-forms-accept-command sf-suppress-forms-cancel-command sf-input-with-placeholder')]
           ${scroll_button}=        Get from list     ${element}    4
           Click on scroll down button     18    6
           Clear Element Text      ${scroll_button}
           Selenium2Library.Input Text      ${scroll_button}     ${filter} 
           Run keyword and ignore error      Press key      ${scroll_button}     \\13
           sleep    2s
           Run keyword and ignore error     Click element      ${scroll_button}
		   Click on scroll down button     18    1
           wait for page to load
           ${result}=       Get Element Count     xpath://div[@title='${filter}'] 
           IF              ${result}!=0
                 Click element      xpath://div[@title='${filter}']      modifier=CTRL
                 ${count}=      Evaluate    ${count} + 1
                 Append to List       ${list_filter}      ${filter}
           ELSE      
                 Log      ${result}
           END                 
     END
     capture page screenshot
     Log       ${count}
     [Return]       ${count}        @{list_filter}  

Click on button value to add flex filter
     Sleep      5s
     Click on scroll down button     18    10
     Click element        xpath://input[@value='Apply flex filter settings']
     Sleep      10s


Verify that Flex Filter is added to selected measure
    [Arguments]    ${FilterValue}
    #
    #Sleep      5s
    Mouse Over      xpath:(//div[@class="valueCellsContainer"])[3]
    Sleep       5s
    click on the scroll right button       15      85
    Sleep       5s
	${table_filter_value}=    selenium2library.get text    xpath:(//div[@class="sf-element sf-element-visual-content sfc-table"])[3]
	should contain    ${table_filter_value}    ${FilterValue}	      
    
Verify that Fetch and Add Flex filter buttons are not visible
    wait for page to load
    Click on scroll down button     18    26
    ${result}=       Get Element Count     xpath://div[@id="flexCounter"][@style="PADDING-BOTTOM: 15px; DISPLAY: none"]
    IF    ${result}==1
        # click on scroll up button     18    12
        capture page screenshot 
    ELSE
        Log      ${result} 
    END

Verify File Availability and counter availability column present
    ${check}=      set variable    0
    ${count}=          Get Element Count         xpath://div[@class="sf-element-table-cell flex-justify-end flex-align-end \ sfc-column-header sfpc-level-1 sfpc-level-last sfpc-odd-column"]//div    
    ${count}=   Evaluate    ${count} - 1                
    @{element}=        Selenium2Library.Get WebElements       xpath://div[@class="sf-element-table-cell flex-justify-end flex-align-end \ sfc-column-header sfpc-level-1 sfpc-level-last sfpc-odd-column"]//div  
    ${ele}=        Get from list     ${element}    ${count}
    ${Column_name}=        Get Text       ${ele}         
    ${count_1}=          Get Element Count       xpath://div[@class="sf-element-table-cell flex-justify-end flex-align-end \ sfc-column-header sfpc-level-1 sfpc-level-last sfpc-even-column"]//div    
    ${count_1}=   Evaluate    ${count_1} - 1
    @{element_1}=        Selenium2Library.Get WebElements       xpath://div[@class="sf-element-table-cell flex-justify-end flex-align-end \ sfc-column-header sfpc-level-1 sfpc-level-last sfpc-even-column"]//div  
    ${ele_1}=        Get from list     ${element_1}    ${count_1}
    ${Column_name_1}=        Get Text       ${ele_1} 
    Should Match       ${Column_name}       Counter Availability
    Should Match       ${Column_name_1}       File Availability  


Verify that the Report has data         
    Page Should Contain Element       xpath://div[@class="sf-element-table-cell flex-justify-start flex-align-start \ sfc-value-cell sfpc-odd-column sfpc-odd-row"]//div   
    wait for page to load
    capture page screenshot

verify that the month_id value in datetime_id
    [Arguments]    ${month_id}
    #@{element}=        Selenium2Library.Get WebElements       xpath://div[@class="sf-element-table-cell flex-justify-start flex-align-start \ sfc-value-cell sfpc-odd-column sfpc-odd-row"]//div  
    #${ele}=        Get from list     ${element}    0
    #${month}=    selenium2library.Get text      ${ele}
	${month}=    Get cell value       DATETIME_ID    1
    Log    ${month}
    should contain    ${month}    ${month_id}
    wait for page to load
    capture page screenshot
  
 

    
Verify that Create Interval section is visible
	element should be visible    xpath://div[@id="createInterval"]
	wait for page to load
	capture page screenshot

Select the report
	[Arguments]    ${reportName}
	Click on scroll down button     5    2
	Clear Element Text      xpath://input[@class='sf-element sf-element-input sf-input-with-placeholder']																								  
    Sleep    3
	Selenium2Library.Input Text     xpath://input[@class='sf-element sf-element-input sf-input-with-placeholder']      ${report_name}
    Sleep    3
    press key      xpath://div[@class='HtmlTextArea sf-enable-selection sf-focusable']      \\13
    Sleep    5
    Click Element    xpath://div[@class="sf-element-table-cell flex-justify-start flex-align-start \ sfc-value-cell sfpc-even-column sfpc-odd-row"]
	wait for page to load
	capture page screenshot
	
Check the Show Selection Panel checkbox
    Wait Until Page Contains Element      xpath:(//div[contains(@class,"sf-element sf-element-check-box flex-item flex-no-shrink flex-align-start sfpc-")])     timeout=1500
    Run keyword and ignore error      Click Element    xpath:(//div[@class="sf-element sf-element-check-box flex-item flex-no-shrink flex-align-start sfpc-unchecked"])
	wait for page to load
	Wait Until Page Contains Element      xpath://*[text()='Select Topology']        timeout=1500
	capture page screenshot									   

	
Close the Edit page
	Wait Until Page Contains Element      xpath: //input[@value="Close Report"]     timeout=1500
    Click Element    xpath: //input[@value="Close Report"]
    sleep    3
    Wait Until Page Contains Element      xpath:(//label[@class="Okbutton"])[5]   timeout=15
    Click Element    xpath:(//label[@class="Okbutton"])[5]
    sleep    5
	wait for page to load
	capture page screenshot


Verify that the View page is visible
	element should be visible    xpath://div[@name="valueCellsContainer"]
	wait for page to load
	capture page screenshot
	
Close the View Report page
	Wait Until Page Contains Element      xpath: //input[@value="Close Report"]     timeout=15
    Click Element    xpath: //input[@value="Close Report"]
    sleep    3
    Wait Until Page Contains Element      xpath:(//label[@class="Okbutton"])   timeout=15
    Click Element    xpath:(//label[@class="Okbutton"])
    sleep    5
    wait for page to load
	capture page screenshot
	
Click on Collection Manager button from Report Manager page
    Click Element    xpath: //input[@value='Collection Manager']
    Wait Until Page Contains Element      xpath: //input[@value='Create Collection']     timeout=1500
    capture page screenshot
	
####NEW TEST CASES END####

####NEW TEST CASES II####

Click on Delete Report button
	Wait Until Page Contains Element      xpath: //span[@id="deleteReportButton"]     timeout=1500
    Click Element    xpath: //span[@id="deleteReportButton"]
    wait for page to load
    capture page screenshot
    
Click on Delete in confirmation window
	Wait Until Page Contains Element      xpath://div[@class="deleteReportButton"]     timeout=1500
	Wait Until Page Contains Element      xpath://label[@class="delete1"]     timeout=1500
	Click Element      xpath://label[@class="delete1"]
	wait for page to load
    capture page screenshot
    
Verify that the selected Report is deleted
	[Arguments]    ${reportName}
	Element should not contain    xpath://div[@class='valueCellsContainer']    ${reportName}
	wait for page to load
    capture page screenshot
	
Select the NodeName in Preview section
	@{element}=    Get WebElements      xpath://div[@class="sf-element-table-cell flex-justify-start flex-align-start \ sfc-value-cell sfpc-odd-column sfpc-odd-row"]
    ${ele}=        Get from list     ${element}    0
    Click element      ${ele}
	wait for page to load
	capture page screenshot
	
Select created Collection
	[Arguments]    ${collection}
	[Return]    ${collection}
	place cursor on    CollectionName
    Click on maximise window button     0
	sleep    5
	click on scroll up button    0     5
	Wait Until Page Contains Element      xpath://*[contains(text(),'${collection}')]     timeout=1500
	Click element      xpath://*[contains(text(),'${collection}')]
	sleep    5
	place cursor on    CollectionName
	sleep    3
    click on the button    Restore visualization layout
	wait for page to load
	capture page screenshot
	
Click on the EDIT button
	Wait Until Page Contains Element      xpath://input[@value="Edit Collection"]     timeout=1500
	Click Element      xpath://input[@value="Edit Collection"]
	wait for page to load
	capture page screenshot
	
Verify that the Edit page opens up
	${pageText}=    Selenium2Library.get text    xpath://div[@id="id396"]
	Element Text should be    xpath://div[@id="id396"]    Collection Name, System Area, Node Type will be uneditable \ 
	[Return]    ${pageText}
	wait for page to load
	capture page screenshot
	
Clear Search Nodes text
	Clear Element Text      xpath://input[@class="SearchInput sf-element-input sf-suppress-forms-accept-command sf-suppress-forms-cancel-command sf-input-with-placeholder"]
	wait for page to load
	capture page screenshot
	
Add all nodes to the collection
	Click on scroll down button    6    25								   
	Click on Fetch Nodes 
    Clear Search Nodes text
    Click Element      xpath://div[@class="sf-element-list-box-item"][1]
    Click on Add >>
    wait for page to load
	capture page screenshot

Add all nodes to the collection in Edit
	Click on scroll down button    6    25								   
	Click on Fetch Nodes in Edit Mode
    Clear Search Nodes text
    Click Element      xpath://div[@class="sf-element-list-box-item"][1]
    Click on Add >>
    wait for page to load
	capture page screenshot

Click on Save
	Wait Until Page Contains Element      xpath://div[@id="saveChangesBtn"]     timeout=1500
	Click Element      xpath://div[@id="saveChangesBtn"]
	wait for page to load
	capture page screenshot
	
Create an Interval
	[Arguments]    ${interval}    ${startDate}    ${endDate}
	Click on scroll down button    7    12
	${currDate}=    Get current date
	${intervalName}=    set variable    ${interval}_${currDate}
	@{element}=    Get WebElements	    xpath: //input[@class='sf-element sf-element-control sfc-property sfc-text-box']
        ${ele}=        Get from list     ${element}    17	
	Clear Element Text      ${ele}
	Sleep     3s
	Click element       ${ele} 
	Selenium2Library.Press keys     ${ele}    ${intervalName}
	Sleep      1s
    Click on scroll down button    7    1
	Click on scroll up button    7    1	
	Capture page screenshot
	FOR    ${i}    IN RANGE    0     5
         ${text}=         Get Element Attribute        ${ele}        value
         IF    '${text}'=='${intervalName}'
               Exit For Loop
         ELSE 
		        	Clear Element Text      ${ele}
				Sleep     1s
				Selenium2Library.Input Text     ${ele}    ${intervalName}
				Click on scroll down button    7    1
				Click on scroll up button    7    1
				Sleep      1s
         	END
   	 END
	

	Click on scroll down button    7    1	
	Capture page screenshot	 
	@{element}=    Get WebElements	    xpath: //input[@class='sf-element sf-element-control sfc-property sfc-text-box']
      	${ele}=        Get from list     ${element}    18	
	Sleep     3s
	Click element       ${ele} 
	Selenium2Library.Press keys     ${ele}    ${startDate}
	Sleep    3s
	Capture page screenshot	 
	Click on scroll down button    7    3
	@{element}=    Get WebElements	    xpath: //input[@class='sf-element sf-element-control sfc-property sfc-text-box']
    	${ele}=        Get from list     ${element}    21	
	Click element       ${ele} 
	Selenium2Library.Press keys     ${ele}       ${endDate}
	Sleep     3s
	Capture page screenshot	 
	Click on scroll down button    7    1
	Click on scroll up button    7    1
	Capture page screenshot	 
	Click on scroll down button    7    7
	Sleep    3s   
	Wait Until Page Contains Element      xpath://input[@value="Add Interval"]     timeout=1500
	Click Element      xpath://input[@value="Add Interval"]
	sleep    5
	capture page screenshot
	click on scroll up button    7    50
	[Return]    ${intervalName}
	wait for page to load
	capture page screenshot

	
create an interval for report generation
	[Arguments]    ${startDate}    ${endDate}
	click on scroll down button       7       16
	${currDate}=    Get current date
	${intervalName}=    set variable    Interval_${currDate}
	Selenium2Library.Input Text     xpath:(//input[@class="sf-element sf-element-control sfc-property sfc-text-box"])[18]    ${intervalName}
	sleep    5
	click element    xpath:(//input[@class="sf-element sf-element-control sfc-property sfc-text-box"])[19]
	@{dateList}=      Split string      ${startDate}    /
    sleep    2
    ${date}=    get from list    ${dateList}    0
	press keyboard button    ${date}
	sleep    2
	${month}=    get from list    ${dateList}    1
	press keyboard button    ${month}
	sleep    2
	${year}=    get from list    ${dateList}    2
	press keyboard button    ${year}
	sleep    5
	@{dateList1}=      Split string      ${endDate}    /
	click on scroll down button       7       2
    click element    xpath:(//input[@class="sf-element sf-element-control sfc-property sfc-text-box"])[22]
    sleep    5
    ${date1}=    get from list    ${dateList1}    0
	press keyboard button    ${date1}
	sleep    5
	${month1}=    get from list    ${dateList1}    1
	press keyboard button    ${month1}
	sleep    5
	click on button    Add Interval
	sleep    10
	click on button    Add Interval
	[Return]    ${intervalName}
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
    
select an existing interval	
    Click Element      xpath:(//div[@class='valueCellCanvas'])//div[contains(text(),'Interval')]			
	wait for page to load
	capture page screenshot
	
select an interval
	[Arguments]    ${intervalName}
	${status}=    run keyword and return status    Click Element       xpath:(//div[@class="valueCellCanvas"])//div[contains(text(),'${intervalName}')]
	IF    "${status}"=="False"
		FOR    ${i}    IN RANGE    0    200
			place cursor on    Start Time
			Click on scroll down button    12    3
			${status}=    run keyword and return status    Element should be visible    xpath://*[contains(text(),'${intervalName}')]
			Exit For Loop If     ${status} == True
		END		
    Click Element      xpath:(//div[@class="valueCellCanvas"])//div[contains(text(),'${intervalName}')]		
	END
	
	wait for page to load
	capture page screenshot
	
Select no subnetwork
    capture page screenshot
	Run Keyword And Ignore Error      Click Element       xpath:(//div[@class='ListItems'])[4]//div[@class='sf-element-list-box-item sfpc-selected']       modifier=CTRL
	
Select Collection
	[Arguments]    ${node_list}
	Click on scroll down button    6     25    
    @{list}=      Split string      ${node_list}    ,
     FOR    ${node}    IN    @{list}
           Clear Element Text      xpath:(//input[@placeholder='Type to search in list'])[2]
		   sleep    5s		  
           Selenium2Library.Input Text     xpath:(//input[@placeholder='Type to search in list'])[2]     ${node} 
           Click on scroll down button    6     1
		   sleep    2s
           wait for page to load
           Click element      xpath://div[@title='${node}']      modifier=CTRL
           sleep   1s
     END		 
    wait for page to load
	capture page screenshot
	

		
select SubNetwork
	[Arguments]    ${subNetwork_list}
	@{subNetwork}=      Split string      ${subNetwork_list}    ,
	Click on scroll down button     6    21
     FOR    ${subNet}    IN    @{subNetwork}
	
           FOR    ${i}    IN RANGE    0    7
			   Run keyword and ignore error      Clear Element Text      xpath://*[@id="8447faec751d4048a47f1ab93c521944"]/div[1]/input
			   Sleep     2s
			   Run keyword and ignore error       Click element     xpath://*[@id="8447faec751d4048a47f1ab93c521944"]/div[1]/input      
			   Sleep     3s
			   Run keyword and ignore error        Selenium2Library.Input Text     xpath://*[@id="8447faec751d4048a47f1ab93c521944"]/div[1]/input       ${subNet}      
			   Click on scroll down button     6    1
			   Click on scroll up button     6    1
			   sleep    2s
			   wait for page to load
			   ${text}=    Selenium2Library.Get Text     xpath: ((//div[@class='ListItems'])[4]//div[@class='sf-element-list-box-item'])[1]
			   ${status}=    Run keyword and return status       Should match      ${text}        ${subNet}
			   Capture page screenshot
			   IF    ${status}==True    
						   Capture page screenshot
						   exit for loop
			   END
		    END
	 Click element      xpath://div[@title='${subNet}' and (@class='sf-element-list-box-item' or @class='sf-element-list-box-item sfpc-selected')]      modifier=CTRL
           sleep   1s
     END
    wait for page to load
	capture page screenshot

Select Day of the week
    [Arguments]     ${list}
    @{day}=      Split string      ${list}    ,
    Click on scroll down button    7    18
    sleep    2    
    ${InList}=    Get Match Count    ${day}    Monday
    Run keyword if    ${InList}!=1    Click element    xpath://div[@title='Monday']
    sleep    2
    ${InList}=    Get Match Count    ${day}    Tuesday
    Run keyword if    ${InList}!=1    Click element    xpath://div[@title='Tuesday']
    Sleep    2       
    ${InList}=    Get Match Count    ${day}    Wednesday
    Run keyword if    ${InList}!=1    Click element    xpath://div[@title='Wednesday']
    sleep    2
    ${InList}=    Get Match Count    ${day}    Thursday
    Run keyword if    ${InList}!=1    Click element    xpath://div[@title='Thursday']
    sleep    2
    ${InList}=    Get Match Count    ${day}    Friday
    Run keyword if    ${InList}!=1    Click element    xpath://div[@title='Friday']
    sleep    2
    ${InList}=    Get Match Count    ${day}    Saturday
    Run keyword if    ${InList}!=1    Click element    xpath://div[@title='Saturday']
    sleep    2
    ${InList}=    Get Match Count    ${day}    Sunday
    Run keyword if    ${InList}!=1    Click element    xpath://div[@title='Sunday']
    
Change the View to
	[Arguments]    ${view}
	change the mode to	       ${view}
	
Change the Visualization type to Pie chart
	sleep    10
	Wait Until Page Contains Element      xpath://div[@title="Visualization types"]     timeout=15
	Click Element      xpath://div[@title="Visualization types"]
	sleep    5
	Wait Until Page Contains Element      xpath://div[@class="${visualisations_type}"][7]     timeout=15
	Click Element      xpath://div[@class="${visualisations_type}"][7]
	
####NEW TEST CASES II END####

########## MR-EQEV-103716 Test Cases ##########

click on the button
	[Arguments]    ${button}
	Scroll Element Into View    xpath://*[@title="${button}"]
	Wait Until Page Contains Element      xpath://*[@title="${button}"]     timeout=1500
	Click Element      xpath://*[@title="${button}"]
	wait for page to load
	capture page screenshot
	
click on button
	[Arguments]    ${button}
	Wait Until Page Contains Element      xpath://*[@value="${button}"]     timeout=1500
	Click Element      xpath://*[@value="${button}"]
	Sleep    10s
	wait for page to load
	capture page screenshot
	
click on sync with eniq button
    Wait Until Page Contains Element      xpath://*[@value="Sync with ENIQ"]     timeout=1500
	Click Element      xpath://*[@value="Sync with ENIQ"]
	Sleep     5s
	capture page screenshot
	
verify that the button is visible
	[Arguments]    ${button}
	element should be visible    xpath://*[@value="${button}"]
	Sleep     3s		 
	wait for page to load
	capture page screenshot
	
verify that the button is present
	[Arguments]    ${button}
	element should be visible    xpath://*[@title="${button}"]
	wait for page to load
	capture page screenshot
	

Connect to the DB
    @{element}=    Get WebElements	    xpath: //input[@class='sf-element sf-element-control sfc-property sfc-text-box']
    ${name}=        Get from list     ${element}    0
    ${username}=        Get from list     ${element}    1
    ${password}=        Get from list     ${element}    2
    ${eniqs}=        Get from list     ${element}    3
    Selenium2Library.Input Text    ${name}       localhost 
    Sleep     1s
    Selenium2Library.Input Text    ${username}       netanserver
    Sleep     1s
    Selenium2Library.Input Text    ${password}       Ericsson01 
    Sleep     1s
    Click element     xpath: //input[@id='a49e8a2e448349398408b044a165fee5']
    Sleep     10s
    FOR    ${i}    IN RANGE    0     5
         ${text}=      Selenium2Library.Get text      xpath://span[@id='a78fbda81332476ab91b65a4b88dad30']
         IF    '${text}'=='Connection OK'
               Exit For Loop
         ELSE IF     '${text}'=='please provide Value for: NetAn SQL DB URL'
               Selenium2Library.Input Text    ${name}       localhost               
         ELSE IF     '${text}'=='please provide Value for: NetAn User Name'
               Selenium2Library.Input Text    ${username}       netanserver       
         ELSE IF       '${text}'=='please provide Value for: NetAn Password'
               Selenium2Library.Input Text    ${password}       Ericsson01 
         END
         Sleep     1s
         Click element     xpath: //input[@id='a49e8a2e448349398408b044a165fee5']
         Sleep     10s
    END    
    FOR    ${i}    IN RANGE    0     5
          Clear Element Text      ${eniqs}
          Selenium2Library.Input Text    ${eniqs}       NetAn_ODBC         
    END       
    Sleep    3s
    Click element     xpath: //input[@id='075d5400a00740b1b64261f11e3d4f27']    
    Sleep    10s
    wait for page to load
	capture page screenshot
   
verify that the connection to NetAn database is made
	${text}=    Selenium2Library.get text 	xpath:(//*[@id="table-data"])//td[6]//span[1]
	should be equal    ${text}    Connection OK
	wait for page to load
	capture page screenshot
	
verify that the connection to datasource(s) is made
	${text1}=    Selenium2Library.get text 	xpath:((//*[@id="table-data"])//td[6]//span[1])[2]
	should be equal    ${text1}    Connected
	wait for page to load
	capture page screenshot
	
delete the datasource
	[Arguments]    ${dataSource}
	Click element     xpath://*[contains(text(),'${dataSource}')]
	click on the scroll down button     4        3
	click on button    Remove
	Click element     xpath:(//label[@class="deleteConnectionsInput"])[2]
	capture page screenshot
	Sleep     10s
	${text1}=    Selenium2Library.get text 	  xpath:((//div[@class="deleteConnectionDialog"])[3])
	should contain    ${text1}     Connection deleted successfully
	capture page screenshot
	
verify that the datasource is deleted
	[Arguments]    ${dataSource}
	${text1}=    Selenium2Library.get text 	  xpath:((//div[@class="deleteConnectionDialog"])[3])//div[2]//span
	should contain    ${text1}     Connection deleted successfully
	wait for page to load
	capture page screenshot
	
Connect to Multiple ENIQs
    @{element}=    Get WebElements	    xpath: //input[@class='sf-element sf-element-control sfc-property sfc-text-box']
    ${name}=        Get from list     ${element}    0
    ${username}=        Get from list     ${element}    1
    ${password}=        Get from list     ${element}    2
    ${eniqs}=        Get from list     ${element}    3
    Selenium2Library.Input Text    ${name}       localhost 
    Sleep     1s
    Selenium2Library.Input Text    ${username}       netanserver
    Sleep     1s
    Selenium2Library.Input Text    ${password}       Ericsson01 
    Sleep     1s
    Click element     xpath: //input[@id='a49e8a2e448349398408b044a165fee5']
    Sleep     10s
    FOR    ${i}    IN RANGE    0     5
         ${text}=      Selenium2Library.Get text      xpath://span[@id='a78fbda81332476ab91b65a4b88dad30']
         IF    '${text}'=='Connection OK'
               Exit For Loop
         ELSE IF     '${text}'=='please provide Value for: NetAn SQL DB URL'
               Selenium2Library.Input Text    ${name}       localhost               
         ELSE IF     '${text}'=='please provide Value for: NetAn User Name'
               Selenium2Library.Input Text    ${username}       netanserver       
         ELSE IF       '${text}'=='please provide Value for: NetAn Password'
               Selenium2Library.Input Text    ${password}       Ericsson01 
         END
         Sleep     1s
         Click element     xpath: //input[@id='a49e8a2e448349398408b044a165fee5']
         Sleep     10s
    END    
    FOR    ${i}    IN RANGE    0     5
          Clear Element Text      ${eniqs}
          Selenium2Library.Input Text    ${eniqs}       NetAn_ODBC,4140_ODBC        
    END       
    Sleep    3s
    Click element     xpath: //input[@id='075d5400a00740b1b64261f11e3d4f27']    
    Sleep    10s
    wait for page to load
	capture page screenshot
	
verify that the connection failed for one datasource
	${text1}=    Selenium2Library.get text 	xpath://div[@name="valueCellsContainer"]
	Log    ${text1}
	should contain    ${text1}    4140_ODBC
	should contain    ${text1}    Failed
	wait for page to load
	capture page screenshot

verify that sync is done properly
	wait for page to load
	SikuliLibrary.screen should not contain    ${IMAGE_DIR}\\PMEX_Sync_Unsuccessful.PNG
	wait for page to load
	capture page screenshot
	

	

	
go to the Page tab
	Click on forward button    20
	sleep    2
	Wait Until Page Contains Element      xpath:(//div[@class="${page_tab}"])[10]     timeout=30
	Click Element      xpath:(//div[@class="${page_tab}"])[10]
	wait for page to load
	capture page screenshot


Click on forward button
    [Arguments]    ${n}
    FOR    ${i}    IN RANGE    0    ${n} 
           Click element     xpath:(//div[@title="Forward"])           
    END
    
verify that the table has data
	${rows}=    Selenium2Library.get text    xpath:(//div[@class="${sfx_label}"])[1]
	Log    ${rows}
	should not be equal    ${rows}    0 rows
	wait for page to load
	capture page screenshot
	
select the SubNetwork List table
	Wait Until Page Contains Element      xpath://div[@class="sf-element sf-element-text-box"]     timeout=30
	Click Element      xpath://div[@class="sf-element sf-element-text-box"]
	sleep    2
	Wait Until Page Contains Element      xpath://div[@title="SubNetwork List"]     timeout=30
	Click Element      xpath://div[@title="SubNetwork List"]
	wait for page to load
	capture page screenshot
	
########## MR-EQEV-103716 Test Cases End ##########

################################################ IA85008 EQEV-142996 #################################	

click on Measure Selection page button
    Wait Until Page Contains Element      xpath://*[@value="Measure Selection"]     timeout=15
    Click Element      xpath://*[@value="Measure Selection"]
    wait for page to load
    capture page screenshot

Click on add data button
	Sleep      2s
	Wait Until Page Contains Element      xpath:(//div[@title="Data"])    100
	Click Element    xpath:(//div[@title="Data"])
	Sleep   2s
	Wait Until Page Contains Element      xpath:(//div[@title="Add data..."])    100
	Click Element    xpath:(//div[@title="Add data..."])
	wait for page to load
	capture page screenshot

Add Calculated column and verify if the column is added
    sleep    3s
    change the mode to     Editing
	sleep    3s
	Sleep      2s
	Wait Until Page Contains Element      xpath:(//div[@title="Data"])    100
	Click Element    xpath:(//div[@title="Data"])
	Sleep   2s
	Wait Until Page Contains Element      xpath:(//div[@title="Add calculated column..."])    100
	Click Element    xpath:(//div[@title="Add calculated column..."])
	sleep    3s
    ${column_expression}=     set variable    ([PMRADIOTHPVOLUL]
    ${column_expression_1}=     set variable    ([PMMACVOLUL] * (8 / 1000))) / [PMPUSCHSCHEDACTIVITY]
    selenium2library.Press Keys    xpath:(//div[@class="CodeMirror-code"])     ${column_expression}
	sleep    3s
    sleep      1s
    Press Keys    None    DELETE
	sleep    3s
    Press Keys    None    SPACE
	sleep    3s
    selenium2library.Press Keys    xpath:(//div[@class="CodeMirror-code"])     +
	sleep    3s
    Press Keys    None    SPACE
	sleep    3s
    selenium2library.Press Keys    xpath:(//div[@class="CodeMirror-code"])     ${column_expression_1}
	sleep    3s
	Click Element    xpath:((//div[@class="flex-item flex-no-shrink flex-align-start"])[2])//input
	sleep    2s
	Selenium2Library.Input Text    xpath:((//div[@class="flex-item flex-no-shrink flex-align-start"])[2])//input       Normalized Average UL MAC Cell Throughput - KPI
	sleep    3s
	Click element    xpath://button[contains(text(),'OK')]
	wait for page to load
	sleep     3s
	Mouse Over      xpath://div[@name="valueCellsContainer"]
	sleep    2s
	click on the scroll right button    0    50
	sleep    20s
	Verify columns displayed     Normalized Average UL MAC Cell Throughput - KPI
	wait for page to load
	capture page screenshot

Navigate to next page
	[Arguments]     ${search_page}
	Sleep      10s
    Click element      xpath: //div[@class='ComboBoxTextDivContainer']
	Sleep   2s
	Click element      xpath://div[@title='${search_page}']
	wait for page to load
	capture page screenshot

Deactivate all exsisting selection in column from new data and make new selection
	[Arguments]     ${column_list}
	Sleep      3s
	Wait Until Page Contains Element      xpath://div[@title="Columns from new data"]    100
    Click element      xpath://div[@title="Columns from new data"]
	sleep    2s
	Wait Until Page Contains Element      xpath://div[@title="Deselect all"]    100
    Click element      xpath://div[@title="Deselect all"]
	@{list}=      Split string      ${column_list}     ,
	FOR    ${kpi}    IN    @{list}
        Clear Element Text      xpath:(//input[contains(@class,'SearchInput sf-element-input sf-suppress-forms-accept-command sf-suppress-forms-cancel-command sf-input-with-placeholder')])[2]
		Sleep   3s
        Selenium2Library.Input Text     xpath:(//input[contains(@class,'SearchInput sf-element-input sf-suppress-forms-accept-command sf-suppress-forms-cancel-command sf-input-with-placeholder')])[2]     ${kpi} 
		Click element      xpath://div[@title="Columns from new data"]
        wait until element is visible     xpath://div[@title="${kpi}"]
		Click element      xpath://div[@title="${kpi}"]
		sleep   5s
        wait for page to load
		Capture page screenshot
    END
	
Select join setting
    [Arguments]    ${join_value}
	Sleep      3s
	Wait Until Page Contains Element      xpath://div[@title="Join settings"]    100
    Click element      xpath://div[@title="Join settings"]
	sleep    2s
	Wait Until Page Contains Element      xpath://div[@title="${join_value}"]    100
    Click element      xpath://div[@title="${join_value}"]
	sleep   5s
    wait for page to load
	Capture page screenshot

Remove Existing Matched Columns
	sleep    5s
	${count}=     Get Element Count       xpath://div[@title="Remove match"]
	FOR    ${i}    IN RANGE    0     15
	    ${count}=     Get Element Count       xpath://div[@title="Remove match"]
        IF      ${count}==0
			Exit For Loop
	    ELSE IF    ${count}==1
			Run Keyword and Ignore Error    Click element      xpath://div[@title="Remove match"]
		ELSE
		    Run Keyword and Ignore Error    Click element      xpath:(//div[@title="Remove match"])[1]
        END
	END
	capture page screenshot
	
Add column in match column window
    [Arguments]    ${left_column}    ${right_column}    ${data_type}
	Click element    xpath://div[@title="Add match"]
	Sleep    10s
	${left_input}=    set variable    xpath:(//input[@class="SearchInput sf-element-input sf-suppress-forms-accept-command sf-suppress-forms-cancel-command sf-input-with-placeholder"])[3]
	sleep    30s
	Click element    ${left_input}
	sleep    2s
	Selenium2Library.Input Text    ${left_input}       ${left_column}
	sleep    3s
	Click element    xpath:(//div[contains(text(),'From new data')])[2]
	sleep    3s
	Click element    xpath:(//div[@title="${left_column} (${data_type})"])[1]
	sleep    3s
	Clear Element Text      ${left_input}
	Click element    ${left_input}
	sleep    3s
	Click element    xpath:(//div[contains(text(),'From new data')])[2]
	sleep    2s
	Selenium2Library.Input Text    ${left_input}       ${right_column}
	sleep    3s
	Click element    xpath:(//div[contains(text(),'From new data')])[2]
	sleep    2s
	Click element    xpath:((//div[@class="flex-item flex-grow flex-align-start VirtualListBox sf-suppress-forms-accept-command sf-suppress-forms-cancel-command"])[2])//div[@title="${right_column} (${data_type})"]
    sleep    2s
	Click element    xpath://div[@title="Add"]
	capture page screenshot

Add columns from first Data table
	Navigate to next page    pm_DC_E_ERBS_EUTRANCELLFDD_DAY(No Aggregation Level)__NetAn_ODBC
    sleep    3s
    change the mode to     Editing
	sleep    3s
    Click on add data button
	sleep    5s	
	Click element    xpath://div[@title="Other" and contains(@class,"sfx_sidebar-item_")]
	sleep    3s
	Scroll Element Into view      xpath://div[@title="DIM_E_LTE_SHARINGGRP"]
	sleep     3s
    Click element    xpath://div[@title="DIM_E_LTE_SHARINGGRP"]
	sleep     1s
    Click element    xpath://div[contains(@class,"flex-item flex-container-horizontal flex-no-shrink flex-align-center sfx_icons-container_")]
	sleep     1s
	capture page screenshot
	Click element    xpath://div[contains(text(),'Add as columns to')]
	sleep     1s
	${status}=    run keyword and return status    Scroll Element Into view      xpath://div[@title="pm_DC_E_ERBS_EUTRANCELLFDD_DAY(No Aggregation Level)__NetAn_ODBC" and contains(@class,"sfx_dropdown-target-item_")]
	IF    "${status}"=="False"
		Click Element      xpath:(//div[contains(@class,"flex-item flex-grow flex-align-start sfx_DropdownText_")])[2]
		sleep    3s
		Scroll Element Into view      xpath://div[@title="pm_DC_E_ERBS_EUTRANCELLFDD_DAY(No Aggregation Level)__NetAn_ODBC" and contains(@class,"sfx_dropdown-target-item_")]
	END
	sleep     1s
	Click element    xpath://div[@title="pm_DC_E_ERBS_EUTRANCELLFDD_DAY(No Aggregation Level)__NetAn_ODBC" and contains(@class,"sfx_dropdown-target-item_")]
	sleep     1s
    Click element    xpath://div[@title="Settings for added columns"]
	sleep     1s
	Remove Existing Matched Columns
	Add column in match column window    MOID    eUtranCellRef_DN    String
	Add column in match column window    OSS_ID    OSS_ID    String
	Add column in match column window    SN    NE_FDN    String
	Deactivate all exsisting selection in column from new data and make new selection     gUtranCellRelationRef_DN,sharingGroup_DN
	Select join setting     Inner join
	Click element    xpath://button[contains(text(),'OK')]
	sleep    3s
	Click element    xpath://div[@title="OK"]
    wait for page to load
    capture page screenshot

Add columns from second Data table
	Navigate to next page    pm_DC_E_ERBS_EUTRANCELLFDD_DAY(No Aggregation Level)__NetAn_ODBC
    sleep    3s
    change the mode to     Editing
	sleep    3s
    Click on add data button
	sleep    5s	
	Click element    xpath://div[@title="Other" and contains(@class,"sfx_sidebar-item_")]
	sleep    3s
	Scroll Element Into view      xpath://div[@title="pm_DC_E_NR_NRCELLDU_DAY(No Aggregation Level)__NetAn_ODBC"]
	sleep     3s
    Click element    xpath://div[@title="pm_DC_E_NR_NRCELLDU_DAY(No Aggregation Level)__NetAn_ODBC"]
	sleep     1s
    Click element    xpath://div[contains(@class,"flex-item flex-container-horizontal flex-no-shrink flex-align-center sfx_icons-container_")]
	sleep     1s
	capture page screenshot
	Click element    xpath://div[contains(text(),'Add as columns to')]
	sleep     1s
	${status}=    run keyword and return status    Scroll Element Into view      xpath://div[@title="pm_DC_E_ERBS_EUTRANCELLFDD_DAY(No Aggregation Level)__NetAn_ODBC" and contains(@class,"sfx_dropdown-target-item_")]
	IF    "${status}"=="False"
		Click Element      xpath:(//div[contains(@class,"flex-item flex-grow flex-align-start sfx_DropdownText_")])[2]
		sleep    3s
		Scroll Element Into view      xpath://div[@title="pm_DC_E_ERBS_EUTRANCELLFDD_DAY(No Aggregation Level)__NetAn_ODBC" and contains(@class,"sfx_dropdown-target-item_")]
	END
	sleep     1s
	Click element    xpath://div[@title="pm_DC_E_ERBS_EUTRANCELLFDD_DAY(No Aggregation Level)__NetAn_ODBC" and contains(@class,"sfx_dropdown-target-item_")]
	sleep     1s
    Click element    xpath://div[@title="Settings for added columns"]
	sleep     1s
	Remove Existing Matched Columns
	Add column in match column window    gUtranCellRelationRef_DN    MOID    String
	Add column in match column window    OSS_ID    OSS_ID    String
	Add column in match column window    SN    SN    String
	Add column in match column window    DATE_ID    DATE_ID    Date
	Deactivate all exsisting selection in column from new data and make new selection     NRCellDU,PMMACVOLUL
	Select join setting     Inner join
	Click element    xpath://button[contains(text(),'OK')]
	sleep    3s
	Click element    xpath://div[@title="OK"]
    wait for page to load
    capture page screenshot

Add columns from third Data table
	Navigate to next page    pm_DC_E_ERBS_EUTRANCELLFDD_DAY(No Aggregation Level)__NetAn_ODBC
    sleep    3s
    change the mode to     Editing
	sleep    3s
    Click on add data button
	sleep    5s	
	Click element    xpath://div[@title="Other" and contains(@class,"sfx_sidebar-item_")]
	sleep    3s
	Scroll Element Into view      xpath://div[@title="pm_DC_E_ERBS_SHARINGGROUP_DAY(No Aggregation Level)__NetAn_ODBC"]
	sleep     3s
    Click element    xpath://div[@title="pm_DC_E_ERBS_SHARINGGROUP_DAY(No Aggregation Level)__NetAn_ODBC"]
	sleep     1s
    Click element    xpath://div[contains(@class,"flex-item flex-container-horizontal flex-no-shrink flex-align-center sfx_icons-container_")]
	sleep     1s
	capture page screenshot
	Click element    xpath://div[contains(text(),'Add as columns to')]
	sleep     3s
	${status}=    run keyword and return status    Scroll Element Into view      xpath://div[@title="pm_DC_E_ERBS_EUTRANCELLFDD_DAY(No Aggregation Level)__NetAn_ODBC" and contains(@class,"sfx_dropdown-target-item_")]
	IF    "${status}"=="False"
		Click Element      xpath:(//div[contains(@class,"flex-item flex-grow flex-align-start sfx_DropdownText_")])[2]
		sleep    3s
		Scroll Element Into view      xpath://div[@title="pm_DC_E_ERBS_EUTRANCELLFDD_DAY(No Aggregation Level)__NetAn_ODBC" and contains(@class,"sfx_dropdown-target-item_")]
	END
	sleep     1s
	Click element    xpath://div[@title="pm_DC_E_ERBS_EUTRANCELLFDD_DAY(No Aggregation Level)__NetAn_ODBC" and contains(@class,"sfx_dropdown-target-item_")]
	sleep     1s
    Click element    xpath://div[@title="Settings for added columns"]
	sleep     1s
	Remove Existing Matched Columns
	Add column in match column window    sharingGroup_DN    MOID    String
	Add column in match column window    OSS_ID    OSS_ID    String
	Add column in match column window    SN    SN    String
	Add column in match column window    DATE_ID    DATE_ID    Date
	Deactivate all exsisting selection in column from new data and make new selection     PMPUSCHSCHEDACTIVITY
	Select join setting     Inner join
	Click element    xpath://button[contains(text(),'OK')]
	sleep    3s
	Click element    xpath://div[@title="OK"]
    wait for page to load
    capture page screenshot

Add columns from another table
    ${to_tbl_name}=    set variable    pm_DC_E_ERBS_EUTRANCELLFDD_DAY(No Aggregation Level)__NetAn_ODBC
	Navigate to next page    ${to_tbl_name}
   
########## MR-EQEV-103716 II ##########

Verify the access type column in node collection
	element should be visible    xpath:(//div[contains(text(),'AccessType')])
	wait for page to load
	capture page screenshot
	
confirm collection deletion
	sleep    2
	Click element     xpath:(//label[@class="deleteCollectionsInput"])[1]
	sleep    5
	wait for page to load
	capture page screenshot
save the collection
	Wait Until Element Is Visible      xpath:(//*[@value="Save"])[2]     300
    Click element     xpath:(//*[@value="Save"])[2]
	wait for page to load
	capture page screenshot

save the collection in collection manager page
	Wait Until Element Is Visible      xpath:(//*[@value="Save"])[1]     300
    Click element     xpath:(//*[@value="Save"])[1]
	wait for page to load
	capture page screenshot
	
save the dynamic collection in edit mode
	Wait Until Element Is Visible      xpath:(//*[@value="Save"])[2]     300
    Click element     xpath:(//*[@value="Save"])[2]
	wait for page to load
	capture page screenshot

save the collection in edit page
    wait for page to load
    Wait Until Element Is Visible      xpath:(//*[@value="Save"])[3]     300
    Click element     xpath:(//*[@value="Save"])[3]
	wait for page to load	
	${text}=    Selenium2Library.Get text  xpath: ${sfx_page_title}
    Log    ${text}
	${status}=    run keyword and return status    should contain    ${text}    Manage Collection
	IF    ${status}==False
		FOR    ${i}    IN RANGE    0    7
			Wait Until Element Is Visible      xpath:(//*[@value="Save"])[3]     5
			Click element     xpath:(//*[@value="Save"])[3]
			wait for page to load
			${status}=    run keyword and return status    should contain    ${text}    Manage Collection
			Log    ${status}
			Run keyword if     ${status}==True    exit for loop
		END
	END
	wait for page to load
	capture page screenshot																		
	
uncheck the Dynamic Collection check box
	Click on scroll down button    3    15
	Wait Until Page Contains Element      xpath://div[@class="flex-item flex-container-horizontal flex-inline-container flex-align-center"]     timeout=1500
	click element      xpath:(//div[@class="flex-item flex-container-horizontal flex-inline-container flex-align-center"])
	wait for page to load
	capture page screenshot
	
verify that the deleted collection is not present
	[Arguments]    ${name}
	${text}=    Selenium2Library.get text    xpath:(//div[@class="contentContainer"])[1]
	Log    ${text}
	should not contain    ${text}    ${name}
	wait for page to load
	capture page screenshot
	
########## MR-EQEV-103716 II END ##########

########## MR-EQEV-103716 III ##########

Scroll down if element title is not visible
	[Arguments]    ${button}    ${n}    ${elementTitle}
	${IsElementVisible}=    Run Keyword And Return Status    Element Should Be Visible    xpath://*[@title="${elementTitle}"]
	Run Keyword If    ${IsElementVisible} is ${FALSE}   Click on scroll down button    ${button}     ${n}
	wait for page to load
	capture page screenshot
	
Scroll down if element class is not visible
	[Arguments]    ${button}    ${n}    ${elementClass}
	${IsElementVisible}=    Run Keyword And Return Status    Element Should Be Visible    xpath://*[@class="${elementClass}"]
	Run Keyword Unless    ${IsElementVisible}    Click on scroll down button    ${button}     ${n}
	wait for page to load
	capture page screenshot
	
Scroll down if element id is not visible
	[Arguments]    ${button}    ${n}    ${elementId}
	${IsElementVisible}=    Run Keyword And Return Status    Element Should Be Visible    xpath://*[@id="${elementId}"]
	Run Keyword Unless    ${IsElementVisible}    Click on scroll down button    ${button}     ${n}
	wait for page to load
	capture page screenshot
	
Scroll down if element value is not visible
	[Arguments]    ${button}    ${n}    ${elementValue}
	${IsElementVisible}=    Run Keyword And Return Status    Element Should Be Visible    xpath://*[@value="${elementValue}"]
	Run Keyword Unless    ${IsElementVisible}    Click on scroll down button    ${button}     ${n}
	wait for page to load
	capture page screenshot

		
verify that the element is disabled
	[Arguments]    ${elementValue}
	Element Should Be Disabled    xpath://*[@value="${elementValue}"]
	wait for page to load
	capture page screenshot
	
verify that the element is not interactable
	[Arguments]    ${status}
	${statusString}=    convert to string    ${status}
	should be equal    ${statusString}    False
	wait for page to load
	capture page screenshot
	
Open Custom KPI Manager Application
	AutoItLibrary.Run    C:\\Program Files (x86)\\TIBCO\\Spotfire\\11.4.2\\Spotfire.Dxp /server:"https://localhost/" /username:Administrator /password:Ericsson01 /file:${dxp_file_loc}/Custom_KPI_Manager_1.dxp
	Wait until screen contain     ${IMAGE_DIR}\\certificate.PNG    300
    Click    ${IMAGE_DIR}\\certificateYes.PNG
    Sleep    10s
	Wait until screen contain     ${IMAGE_DIR}\\PMD_Home_Page.PNG    300
    Sleep    15
    Capture Screen    
    
click on Custom KPI Manager button    
	sleep    5
    Wait until screen contain     ${IMAGE_DIR}\\PMD_Custom_KPI_Manager.PNG    300
    Click    ${IMAGE_DIR}\\PMD_Custom_KPI_Manager.PNG
	
	
verify that the KPI List Page opened up
	sleep    5
	Screen should contain     ${IMAGE_DIR}\\PMD_KPI_List_Page.PNG
	
click on Generate KPI Template button
	sleep    5
	Wait until screen contain     ${IMAGE_DIR}\\PMD_Generate_KPI_Template_Button.PNG    300
	Click    ${IMAGE_DIR}\\PMD_Generate_KPI_Template_Button.PNG
	
verify that the Generate KPI Template button is working
	sleep    5
	Screen should contain     ${IMAGE_DIR}\\PMD_Generate_KPI_Template_Verification.PNG	
	

Connect to 4140 DB
    @{element}=    Get WebElements	    xpath: //input[@class='sf-element sf-element-control sfc-property sfc-text-box']
    ${name}=        Get from list     ${element}    0
    ${username}=        Get from list     ${element}    1
    ${password}=        Get from list     ${element}    2
    ${eniqs}=        Get from list     ${element}    3
    Selenium2Library.Input Text    ${name}       localhost 
    Sleep     1s
    Selenium2Library.Input Text    ${username}       netanserver
    Sleep     1s
    Selenium2Library.Input Text    ${password}       Ericsson01 
    Sleep     1s
    Click element     xpath: //input[@id='a49e8a2e448349398408b044a165fee5']
    Sleep     10s
    FOR    ${i}    IN RANGE    0     5
         ${text}=      Selenium2Library.Get text      xpath://span[@id='a78fbda81332476ab91b65a4b88dad30']
         IF    '${text}'=='Connection OK'
               Exit For Loop
         ELSE IF     '${text}'=='please provide Value for: NetAn SQL DB URL'
               Selenium2Library.Input Text    ${name}       localhost               
         ELSE IF     '${text}'=='please provide Value for: NetAn User Name'
               Selenium2Library.Input Text    ${username}       netanserver       
         ELSE IF       '${text}'=='please provide Value for: NetAn Password'
               Selenium2Library.Input Text    ${password}       Ericsson01 
         END
         Sleep     1s
         Click element     xpath: //input[@id='a49e8a2e448349398408b044a165fee5']
         Sleep     10s
    END    
    FOR    ${i}    IN RANGE    0     5
          Clear Element Text      ${eniqs}
          Selenium2Library.Input Text    ${eniqs}       4140_ODBC         
    END       
    Sleep    3s
    Click element     xpath: //input[@id='075d5400a00740b1b64261f11e3d4f27']    
    Sleep    10s
    wait for page to load
	capture page screenshot	
	
Connect to DB
    @{element}=    Get WebElements	    xpath: //input[@class='sf-element sf-element-control sfc-property sfc-text-box']
    ${name}=        Get from list     ${element}    0
    ${username}=        Get from list     ${element}    1
    ${password}=        Get from list     ${element}    2
    ${eniqs}=        Get from list     ${element}    3
    Selenium2Library.Input Text    ${name}       localhost 
    Sleep     1s
    Selenium2Library.Input Text    ${username}       netanserver
    Sleep     1s
    Selenium2Library.Input Text    ${password}       Ericsson01 
    Sleep     1s
    Click element     xpath: //input[@id='a49e8a2e448349398408b044a165fee5']
    Sleep     10s
    FOR    ${i}    IN RANGE    0     5
         ${text}=      Selenium2Library.Get text      xpath://span[@id='a78fbda81332476ab91b65a4b88dad30']
         IF    '${text}'=='Connection OK'
               Exit For Loop
         ELSE IF     '${text}'=='please provide Value for: NetAn SQL DB URL'
               Selenium2Library.Input Text    ${name}       localhost               
         ELSE IF     '${text}'=='please provide Value for: NetAn User Name'
               Selenium2Library.Input Text    ${username}       netanserver       
         ELSE IF       '${text}'=='please provide Value for: NetAn Password'
               Selenium2Library.Input Text    ${password}       Ericsson01 
         END
         Sleep     1s
         Click element     xpath: //input[@id='a49e8a2e448349398408b044a165fee5']
         Sleep     10s
    END    
    FOR    ${i}    IN RANGE    0     5
          Clear Element Text      ${eniqs}
          Selenium2Library.Input Text    ${eniqs}       NetAn_ODBC,4140_ODBC         
    END       
    Sleep    3s
    Click element     xpath: //input[@id='075d5400a00740b1b64261f11e3d4f27']    
    Sleep    10s
    wait for page to load
	capture page screenshot	
	
verify that sync with eniq failed
	wait for page to load
	${text}=    selenium2library.get text    xpath:(//div[@id="select1"])//table//tbody//tr[3]//td[2]//font//font
	Log    ${text}
	should contain    ${text}    Sync With ENIQ is not successful
	wait for page to load
	capture page screenshot
	
verify list box is not empty
	${text}=    selenium2library.get text    xpath:(//div[@class="ScrollArea"])[2]
	Log    ${text}
	should not contain    ${text}    (All) 0 values
	wait for page to load
	capture page screenshot
	
verify that nodes are visible for the selected Node type
	${text}=    selenium2library.get text    xpath:(//div[@class="ScrollArea"])[2]
	Log    ${text}
	should not contain    ${text}    (All) 0 values
	wait for page to load
	capture page screenshot
	

	
verify that the connected DataSource is present
	[Arguments]    ${odbc}
	Select ENIQ DataSource as          ${odbc}
	capture page screenshot
	
Connect to ENIQ with incorrect Credentials
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
    Click element     xpath: //input[@id='a49e8a2e448349398408b044a165fee5']
    Sleep     10s
    FOR    ${i}    IN RANGE    0     5
         ${text}=      Selenium2Library.Get text      xpath://span[@id='a78fbda81332476ab91b65a4b88dad30']
         IF    '${text}'=='Connection OK'
               Exit For Loop
         ELSE IF     '${text}'=='please provide Value for: NetAn SQL DB URL'
               Selenium2Library.Input Text    ${name}       localhost               
         ELSE IF     '${text}'=='please provide Value for: NetAn User Name'
               Selenium2Library.Input Text    ${username}       netanserver       
         ELSE IF       '${text}'=='please provide Value for: NetAn Password'
               Selenium2Library.Input Text    ${password}       Ericsson055 
         END
         Sleep     1s
         Click element     xpath: //input[@id='a49e8a2e448349398408b044a165fee5']
         Sleep     10s
    END    
    FOR    ${i}    IN RANGE    0     5
          Clear Element Text      ${eniqs}
          Selenium2Library.Input Text    ${eniqs}       NetAn_ODBC        
    END       
    Sleep    3s
    Click element     xpath: //input[@id='075d5400a00740b1b64261f11e3d4f27']    
    Sleep    10s
    wait for page to load
	capture page screenshot
	
verify that connection is not made
	${text}=    Selenium2Library.get text 	xpath:(//*[@id="table-data"])//td[6]//span[1]
	should be equal    ${text}    Cannot Create Connection
	wait for page to load
	capture page screenshot


	
	

	
	
verify that a message is shown if Node type is not selected
	${message}=    Selenium2library.get text    xpath:(//span[@id="nodeTypeRequired"])//span
	Log    ${message}
	should contain    ${message}    Select Node Type
	wait for page to load
	capture page screenshot	
	

	

	
verify that the selected measure is present in Selected Measures
	[Arguments]    ${measure}
	${measures}=    selenium2library.get text    xpath:(//div[@class="sf-element sf-element-visual-content sfc-table"])[3]
	Log    ${measures}
	should contain    ${measures}    ${measure}	
	
verify the list items in Aggregation dropdown
	Wait Until Page Contains Element      xpath:(//div[@class="ComboBoxTextDivContainer"])[7]     500
	click element      xpath:(//div[@class="ComboBoxTextDivContainer"])[7]
	sleep    2
	${listItems}=    Selenium2library.get text    xpath:(//div[@class="sf-element-dropdown-list sfc-scrollable"])
	Log    ${listItems}
	should contain    ${listItems}    BusyHour
	should contain    ${listItems}    Day
	should contain    ${listItems}    Hour
	should contain    ${listItems}    Month
	should contain    ${listItems}    ROP
	should contain    ${listItems}    Week
	wait for page to load
	capture page screenshot
	
verify that a message is displayed for Node selection
	${message}=    selenium2library.get text    xpath:(//span[@id="alert10"])//span
	Log    ${message}
	should contain    ${message}    Select Node Type
	wait for page to load
	capture page screenshot
	
verify that the created collection is present in Collections list
	[Arguments]    ${name}
	Clear Element Text      xpath:(//input[@class="SearchInput sf-element-input sf-suppress-forms-accept-command sf-suppress-forms-cancel-command sf-input-with-placeholder"])[2]
    sleep    2
    Selenium2Library.Input Text     xpath:(//input[@class="SearchInput sf-element-input sf-suppress-forms-accept-command sf-suppress-forms-cancel-command sf-input-with-placeholder"])[2]     ${name} 
    sleep    2
    press keys    xpath:(//input[contains(@class,'SearchInput sf-element-input sf-suppress-forms-accept-command sf-suppress-forms-cancel-command sf-input-with-placeholder')])[2]    ENTER
    sleep    2
    element should be visible    xpath:((//div[@class="ListItems"])[3])//div[@title="${name}"]
    wait for page to load
	capture page screenshot

########## MR-EQEV-103716 III END ##########

get the month from interval date
	[Arguments]    ${date}
	Log 	${date}
	${list}= 	Split string      ${date}    /
	${month}=    Get From List    ${list}    1
	Log 	${month}
	[Return]    ${month}

Verify monthID with proper data for selected month
    [Arguments]   	 ${expected}		 ${actual}
	${expected}=    Strip String    ${expected}
	${expected}= 	Convert to Integer  	${expected}
	${expected}= 	Convert to String  	${expected}
	${actual}=    Strip String    ${actual}
	should be equal    ${expected}    ${actual}
	capture page screenshot
	
########## MR-EQEV-103716 IV ##########
	
open the properties menu and view columns
	[Arguments]    ${name}
	Wait Until Element Is Visible         xpath: //input[@value='Create']        300
    Click on scroll down button     5    2
    Clear Element Text       xpath://input[@class='sf-element sf-element-input sf-input-with-placeholder']
    Selenium2Library.Input Text     xpath://input[@class='sf-element sf-element-input sf-input-with-placeholder']      ${name}
    Sleep    6s
    press key      xpath://div[@class='HtmlTextArea sf-enable-selection sf-focusable']      \\13
    Sleep    5s
    Wait Until Page Contains Element      xpath://*[contains(text(),'${name}')]                1500
    open context menu      xpath://*[contains(text(),'${name}')]
    sleep    2
    click element    xpath:(//div[@title="Properties"])[2]
    Wait Until Page Contains Element      xpath:(//div[@class="PropertiesPopout RoundedDropShadow sf-element-ui-resizable"])    30
    sleep    3
    click element    xpath:(//div[@id="exp2"])
    sleep    3
    click on button    Select columns...
    wait until page contains element    xpath:(//div[@class="ScrollArea"])[1]    30
    wait until page contains element    xpath:(//div[@class="ScrollArea"])[2]    30
    ${text}=    get text    xpath:(//div[@class="ScrollArea"])[1]
    Log    ${text}
    ${text1}=    get text    xpath:(//div[@class="ScrollArea"])[2]
    Log    ${text1}
    [Return]    ${text}    ${text1}
    wait for page to load
    capture page screenshot
	
verify that the columns are present in Select Columns
	[Arguments]    ${availableColumns}    ${selectedColumns}
	should contain    ${availableColumns}    MeasureType
	should contain    ${selectedColumns}    MeasuresName
	wait for page to load
	capture page screenshot
	
verify that the MeasureName column is present and contains the measure
	[Arguments]    ${measureName}
	${text}=    get text    xpath:(//div[@class="valueCellsContainer"])
	Log    ${text}
	
Open the Custom KPI Manager Application
	AutoItLibrary.Run    C:\\Program Files (x86)\\TIBCO\\Spotfire\\11.4.2\\Spotfire.Dxp /server:"https://win-ffsa55l2fbs/" /username:Administrator /password:Ericsson01 /file:${dxp_file_loc}/Custom_KPI_Manager_1.dxp
	Wait until screen contain     ${IMAGE_DIR}\\MissingDataScreen.PNG    300
    Click    ${IMAGE_DIR}\\MissingDatacheckbox.PNG
    sleep    2
    Click    ${IMAGE_DIR}\\OKButton.PNG												   
	Wait until screen contain     ${IMAGE_DIR}\\PMD_Home_Page.PNG    300
    Sleep    15
    Capture Screen  
	
click on the Custom KPI Manager button    
	sleep    5
    Wait until screen contain     ${IMAGE_DIR}\\PMD_Custom_KPI_Manager.PNG    300
    Click    ${IMAGE_DIR}\\PMD_Custom_KPI_Manager.PNG	
	
verify that KPI List Page opened up
	sleep    5
	Screen should contain     ${IMAGE_DIR}\\PMD_KPI_List_Page.PNG	
	
verify that the custom KPI is present
	${text}=    selenium2library.get text    xpath:(//div[@class="valueCellsContainer"])[2]
	Log    ${text}
	should not be empty    ${text}
	
########## MR-EQEV-103716 IV END ##########

Open PMEx Application
	AutoItLibrary.Run    C:\\Program Files (x86)\\TIBCO\\Spotfire\\11.4.2\\Spotfire.Dxp /server:"https://atvts4133.athtem.eei.ericsson.se/" /username:Administrator /password:Ericsson01 /file:${dxp_file_loc}/PM_Explorer_S11_4.dxp
	Wait until screen contain     ${IMAGE_DIR}\\PMEx_DXP4_Verification.PNG    300
    Sleep    15
    Capture Screen
    
open tblSavedReports in Information Links in PMEx	
	Click    ${IMAGE_DIR}\\PMD_Data_Button.PNG
	sleep    3
	Click    ${IMAGE_DIR}\\PMD_Information_Designer.PNG
	sleep    5
	double click    ${IMAGE_DIR}\\PMD_Ericsson_Library_Folder.PNG
	sleep    5
	double click    ${IMAGE_DIR}\\PMD_General_Folder.PNG
	sleep    3
	double click    ${IMAGE_DIR}\\PMD_PMData_Folder.PNG
	sleep    3
	double click    ${IMAGE_DIR}\\PMD_PM-Data_Folder.PNG
	sleep    3
	double click    ${IMAGE_DIR}\\PMD_InformationPackage.PNG
	sleep    3
	double click    ${IMAGE_DIR}\\PMEx_Columns.PNG
	sleep    5
	double click    ${IMAGE_DIR}\\PMEx_tblSavedReports.PNG
	sleep    5	

verify that MeasureName and MeasureType share the same path
	sleep    5
	Screen should contain     ${IMAGE_DIR}\\PMEx_Measure_Columns

Read the addReportToLibrary script
	${scriptContent}=     OperatingSystem.Get File    ${EXEC_DIR}\\ENIQ_TC_Automation\\NetAn\\Scripts\\IronPythonScripts\\addReportToLibrary.py 
 	Log    ${scriptContent}
 	[Return]    ${scriptContent}

verify that the Insert query is present in the script
	[Arguments]    ${scriptContent}
	${query}=    set variable    INSERT INTO "tblSavedReports" ("ReportName","ReportDescription", "ReportAccess","ReportTableList", "ReportGraphList", "CreatedBy", "CreatedOn", "ENIQName", "CollectionID", "MeasureName", "MeasureType", "ModifiedBy", "LastModifiedOn")
	should contain    ${scriptContent}    ${query}
	
########## MR-EQEV-91078 ##########

verify that the label and input fields are visible
	element should be visible    xpath:(//div[@id="Node-selection"])//table//tbody//tr//td//p[contains(text(),'Information Link Name')]
	wait for page to load
	capture page screenshot	
	
enter the information link name
	[Arguments]    ${name}
	${date}=     Get Current Date
    ${date_string}=     Convert to string     ${date}
    ${ds}=     Replace String	    ${date_string}	   :   	_
    ${ds1}=    Replace String	    ${ds}	   ${SPACE}   	_ 
    ${date_string}=    Replace String	    ${ds1}	   .   	_ 
    Log      ${date_string}
	Clear Element Text      xpath:(//span[@id="ilName"])//input
	sleep    5
	Selenium2Library.Input Text     xpath:(//span[@id="ilName"])//input    ${name}${date_string}
    wait for page to load
	capture page screenshot
	[return]       ${name}${date_string}

scroll down untill element visible 
	[Arguments]    ${element_xpath}    ${button}    ${count}

	FOR    ${i}    IN RANGE    0     10
		${status}=     Run Keyword And Return Status        Element should be visible          xpath://*[contains(text(),'${element_xpath}')]
		IF   ${status} is ${TRUE}
			Exit For Loop
		ELSE
			Run keyword if      ${status}==False      Click on scroll down button    ${button}   ${count}
		END
	END

select a Information Link Storage Location and Save it
	[Arguments]    ${path}   
	scroll down untill element visible    ${path}    2    3
	Click Element      xpath://*[contains(text(),'${path}')]
	sleep    5
	click on scroll down button    1    2		   
	Click Element    xpath://input[@value='Save Information Link']
	sleep    5s
	wait for page to load
	Wait Until Element Is Visible      xpath://*[contains(text(),'OK')]     timeout=1500
	Click element     xpath://*[contains(text(),'OK')]
	wait for page to load
	capture page screenshot

	
return the visible folder name
    ${text}=    selenium2library.get text    xpath:(//div[@class="ScrollArea"])
	Log    ${text}
	${first_line}=     Get Line     ${text}    0
	Log    ${first_line}
    wait for page to load
	capture page screenshot
	[Return]    ${first_line}
	
select a Information Link Storage Location
	[Arguments]    ${path}
	Click element     xpath://*[contains(text(),'${path}')]
	sleep    5
	wait for page to load
	capture page screenshot

verify that the different locations are visible
	[Arguments]      ${folder_name}
	Sleep      5s
	${text}=    selenium2library.get text    xpath:(//div[@class="ScrollArea"])
	Log    ${text}
	[Return]    ${text}
	should contain    ${text}    ${folder_name}
	wait for page to load
	capture page screenshot

validate that No Matching DataSources found
    @{element}=    Get WebElements	    xpath:(//span[@id="dataSourceNameLabel"])
	${name}=        Get from list     ${element}    0   
	${message}=    selenium2library.get text    ${name}
	Log    ${message}
	should contain    ${message}    No Matched Data Source in Information Designer.Please Create one
	wait for page to load
	capture page screenshot

########## MR-EQEV-91078 END ##########

Connect to the DB with wrong credentials
    @{element}=    Get WebElements	    xpath: //input[@class='sf-element sf-element-control sfc-property sfc-text-box']
    ${name}=        Get from list     ${element}    0
    ${username}=        Get from list     ${element}    1
    ${password}=        Get from list     ${element}    2
    ${eniqs}=        Get from list     ${element}    3
    Selenium2Library.Input Text    ${name}       localhost 
    Sleep     1s
    Selenium2Library.Input Text    ${username}       netanserver
    Sleep     1s
    Selenium2Library.Input Text    ${password}       Ericsson012
    Sleep     1s
    Click element     xpath: //input[@id='a49e8a2e448349398408b044a165fee5']
    Sleep     10s
    FOR    ${i}    IN RANGE    0     5
         ${text}=      Selenium2Library.Get text      xpath://span[@id='a78fbda81332476ab91b65a4b88dad30']
         IF    '${text}'=='Connection OK'
               Exit For Loop
         ELSE IF     '${text}'=='please provide Value for: NetAn SQL DB URL'
               Selenium2Library.Input Text    ${name}       localhost               
         ELSE IF     '${text}'=='please provide Value for: NetAn User Name'
               Selenium2Library.Input Text    ${username}       netanserver       
         ELSE IF       '${text}'=='please provide Value for: NetAn Password'
               Selenium2Library.Input Text    ${password}       Ericsson013 
         END
         Sleep     1s
         Click element     xpath: //input[@id='a49e8a2e448349398408b044a165fee5']
         Sleep     10s
    END    
    FOR    ${i}    IN RANGE    0     5
          Clear Element Text      ${eniqs}   
          Selenium2Library.Input Text    ${eniqs}       NetAn_ODBC       
    END       
    Sleep    3s
    Click element     xpath: //input[@id='075d5400a00740b1b64261f11e3d4f27']    
    Sleep    10s
    wait for page to load
	capture page screenshot
	
verify that the connection to NetAn database is not made
	${text}=    Selenium2Library.get text    xpath:(//span[@id='a78fbda81332476ab91b65a4b88dad30'])
	

verify that the month_id value is
    [Arguments]    ${month_id}
    ${month}=    selenium2library.Get text    xpath:(//div[@class="sf-element-table-cell flex-justify-end flex-align-start \ sfc-value-cell sfpc-even-column sfpc-odd-row"])//div[1]
    Log    ${month}
    should be equal    ${month}    ${month_id}
    wait for page to load
    capture page screenshot

select the created report
	[Arguments]    ${report}
	Wait Until Element Is Visible         xpath: //input[@value='Create']        300
    Click on scroll down button     5    2
	FOR    ${i}    IN RANGE    0    7
		Clear Element Text       xpath://input[@class='sf-element sf-element-input sf-input-with-placeholder']
		Selenium2Library.Input Text     xpath://input[@class='sf-element sf-element-input sf-input-with-placeholder']      ${report}
		Sleep    6s
		press key      xpath://div[@class='HtmlTextArea sf-enable-selection sf-focusable']      \\13
		Sleep    5s
	    wait for page to load	
		${status}=     Run Keyword And Return Status        Element should be visible           xpath://*[contains(text(),'${report}')] 
	    IF    ${status}==True    
						   Capture page screenshot
						   exit for loop
		END
	END
    
	Click element     xpath://*[contains(text(),'${report}')]
	Sleep    5s   
	wait for page to load						
    capture page screenshot


######################################## IMPROVEMENT 105271	########################################
	
verify that the column LastModifiedOn is present
    #Mouse Over      xpath:(//div[@class="valueCellsContainer"])[1]
    #click on the scroll right button      2      15
	${columnName}=    get text    xpath:(//div[@class="sf-element-table-cell flex-justify-start flex-align-end \ sfc-column-header sfpc-level-1 sfpc-level-last sfpc-odd-column"])[4]
	Log    ${columnName}
	should contain    ${columnName}    LastModifiedOn
	wait for page to load
	capture page screenshot	
	
verify that the column LastModifiedOn contains date in the preferred format
	${columnName}=    get text    xpath:(//div[@class="sf-element-table-cell flex-justify-start flex-align-start \ sfc-value-cell sfpc-odd-column sfpc-odd-row"])[3]
	Log    ${columnName}
	wait for page to load
	capture page screenshot	
	
select the table from Data table list
    [Arguments]    ${table}
    Wait Until Page Contains Element      xpath:(//div[@class="sf-element sf-element-text-box"])[1]   10
    Click Element    xpath:(//div[@class="sf-element sf-element-text-box"])[1]
    Wait Until Page Contains Element      xpath:(//div[@class="contextMenuItemLabel"])[2]   10
	Click Element    xpath:(//div[@class="contextMenuItemLabel"])[2]
    wait for page to load
    capture page screenshot
	
verify that the message is added to the Create Collection Page
	${msg}=    get text    xpath:(//span[@id="action-message"])
	Log    ${msg}
	should contain    ${msg}    ENIQ Data Source Name, System Area, Node Type will be uneditable
	wait for page to load
	capture page screenshot	
	
verify the message Collection name already exists
	${msg}=    get text    xpath:(//span[@id="action-message"])
	Log    ${msg}
	should contain    ${msg}    Collection name already exists
	wait for page to load
	capture page screenshot	
	

	
edit the Aggregation	
	[Arguments]     ${Aggregation}
	Sleep    5s
    @{element}=    Get WebElements	    xpath: //div[@class='ComboBoxTextDivContainer']
    ${Aggregation_ele}=        Get from list     ${element}    4
    Click element     ${Aggregation_ele}
    Sleep    3s
    Click element      xpath://div[@title='${Aggregation}']
    Sleep    5s
    wait for page to load
	capture page screenshot
	
	
	
verify that the column LastModifiedOn is present in Report Manager page
	${columnName}=    get text    xpath:(//div[@class="sf-element-table-cell flex-justify-start flex-align-end \ sfc-column-header sfpc-level-1 sfpc-level-last sfpc-odd-column sfc-wrap"])[4]
	Log    ${columnName}
	should contain    ${columnName}    LastModifiedOn
	wait for page to load
	capture page screenshot	
	
enter the report name
	[Arguments]    ${name}
	Clear Element Text      xpath://span[@id='reportNameInputField']//input[@class='sf-element sf-element-control sfc-property sfc-text-box'] 
    Sleep    2s
	Selenium2Library.Input Text      xpath://span[@id='reportNameInputField']//input[@class='sf-element sf-element-control sfc-property sfc-text-box']      ${name}
	capture page screenshot      	
	
verify that a report with entered name already exists
	element should be visible    xpath:(//*[contains(text(),'You or another user have already created a report with this name.')])
	wait for page to load
	capture page screenshot	
	

	
click the OK button
	Wait Until Page Contains Element      xpath://*[contains(text(),'OK')]    300
    Click element     xpath://*[contains(text(),'OK')]
	wait for page to load
	capture page screenshot		
	
verify that the column ModifiedBy is present
	Mouse Over      xpath:(//div[@class="valueCellsContainer"])[1]
    click on the scroll right button    2    30
	Element should be visible     xpath://div[text()='ModifiedBy']
	capture page screenshot	
	
verify that the column ModifiedBy is present in Report Manager page	
	Mouse Over      xpath:(//div[@class="valueCellsContainer"])[1]
    click on the scroll right button    2    10
	${columnName}=    get text      xpath:(//div[@class="cell-text sf-element-text-overflow-check"])[11]
	Log    ${columnName}
	should contain    ${columnName}    ModifiedBy
	wait for page to load
	capture page screenshot	
	
verify that the ModifiedBy column is empty
	[Arguments]    ${report_name}
	Wait Until Element Is Visible         xpath: //input[@value='Create']        300
    Click on scroll down button     5    2
    Selenium2Library.Input Text     xpath://input[@class='sf-element sf-element-input sf-input-with-placeholder']      ${report_name}
    Sleep    3s
    press key      xpath://div[@class='HtmlTextArea sf-enable-selection sf-focusable']      \\13
    Sleep    5s
    ${value}=    get text    xpath:(//div[@class="sf-element-table-cell flex-justify-start flex-align-start \ sfc-value-cell sfpc-odd-column sfpc-odd-row"])[5]
	Log    ${value}
	should contain    ${value}    ${EMPTY}
	capture page screenshot		
	
verify that the ModifiedBy column in Collection Manager page is empty
	[Arguments]    ${collection_name}
	${value}=    get text    xpath:(//div[@class="sf-element-table-cell flex-justify-start flex-align-start \ sfc-value-cell sfpc-even-column sfpc-odd-row"])[3]
	Log    ${value}
	should contain    ${value}    ${EMPTY}
	wait for page to load
	capture page screenshot
	
######################################## IMPROVEMENT 105271	END ########################################

######################################## IMPROVEMENT 103911 ########################################

verify that the SubNetwork Viewer is added as a different Section	
	Element Should Be Visible    xpath:((//div[@class="HtmlTextArea sf-enable-selection sf-focusable"])[5]//font//p//font)[1]
	Element Should Be Visible    xpath:(//div[@class="sf-element sf-element-visual sfc-table sfpc-first-column"])[2]
	wait for page to load
	capture page screenshot
	
verify that the SubNetwork List is added as a different Table
	Element Should Be Visible    xpath:((//div[@class="HtmlTextArea sf-enable-selection sf-focusable"])[5]//font//p//font)[1]
	Element Should Be Visible    xpath:(//div[@class="sf-element sf-element-visual sfc-table sfpc-first-column"])[2]
	wait for page to load
	capture page screenshot
	
verify that NodeName is added as a separate column	
	${column}=    get text    xpath:(//div[@class="sf-element-table-cell flex-justify-start flex-align-end \ sfc-column-header sfpc-level-1 sfpc-level-last sfpc-odd-column"])[9]//div
	Log    ${column}
	should contain    ${column}    NodeName
	wait for page to load
	capture page screenshot
	
select a SubNetwork from the list
	Wait Until Page Contains Element      xpath:((//div[@class="valueCellsContainer"])[3]//div[@class="sf-element-table-cell flex-justify-start flex-align-start \ sfc-value-cell sfpc-odd-column sfpc-odd-row"])[1]	
	${column}=    get text    xpath:((//div[@class="valueCellsContainer"])[3]//div[@class="sf-element-table-cell flex-justify-start flex-align-start \ sfc-value-cell sfpc-odd-column sfpc-odd-row"])[1]
	Log    ${column}
	[Return]    ${column}
	Click Element    xpath:((//div[@class="valueCellsContainer"])[3]//div[@class="sf-element-table-cell flex-justify-start flex-align-start \ sfc-value-cell sfpc-odd-column sfpc-odd-row"])[1]
	${column1}=    get text    xpath:(//div[@class="flex-item flex-align-start sf-element sf-element-text-box sf-single-line-text"])[4]
	Log    ${column1}
	wait for page to load
	capture page screenshot
	
verify that the NodeName column is displaying Nodes in selected SubNetwork
	[Arguments]    ${subnet}
	${column1}=    get text    xpath:(//div[@class="flex-item flex-align-start sf-element sf-element-text-box sf-single-line-text"])[4]
	Log    ${column1}
	should contain    ${column1}    ${subnet}
	wait for page to load
	capture page screenshot	
	
verify that the title of NodeName table is the selected SubNetwork
	[Arguments]    ${subnet}
	${column1}=    get text    xpath:(//div[@class="flex-item flex-align-start sf-element sf-element-text-box sf-single-line-text"])[4]
	Log    ${column1}
	should contain    ${column1}    ${subnet}
	wait for page to load
	capture page screenshot	
	
verify that the subnetwork table is empty
	Wait Until Page Contains Element      xpath:(//div[@name="valueCellsContainer"])[3]
	Click Element    xpath:(//div[@name="valueCellsContainer"])[3]
	sleep    2
	${text}=    Get Text    xpath:(//div[@class="${sfx_label}"])[1]
	IF    "${text}" == "0 of 0 rows"
	       ${flag}=     set variable      True
    ELSE
	       ${flag}=     set variable      False
	END
    [Return]       ${flag}
    #should be equal    ${text}    0 of 0 rows
	wait for page to load
	capture page screenshot	

verify that the NodeName column is not empty
	Wait Until Page Contains Element      xpath:(//div[@name="valueCellsContainer"])[4]
	Click Element    xpath:(//div[@name="valueCellsContainer"])[4]
	sleep    2
	${text}=    Get Text    xpath:(//div[@class="${sfx_label}"])[1]
    should not be equal    ${text}    0 of 0 rows
	wait for page to load
	capture page screenshot
	
verify that the NodeName column is also empty
	Wait Until Page Contains Element      xpath:(//div[@name="valueCellsContainer"])[4]
	Click Element    xpath:(//div[@name="valueCellsContainer"])[4]
	sleep    2
	${text}=    Get Text    xpath:(//div[@class="${sfx_label}"])[1]
    should be equal    ${text}    0 of 0 rows
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
	
select the table ENIQDatasources for visualization
	Wait Until Page Contains Element      xpath:(//div[@class="ComboBoxTextDivContainer"])    30
	Click Element    xpath:(//div[@class="ComboBoxTextDivContainer"])
	sleep    2
	Wait Until Page Contains Element      xpath:(//div[@title="ENIQDataSources"])    30
	Click Element    xpath:(//div[@title="ENIQDataSources"])
	wait for page to load
	capture page screenshot

select the table Modified Topology Data for visualization
	Wait Until Page Contains Element      xpath:(//div[@class="ComboBoxTextDivContainer"])    30
	Click Element    xpath:(//div[@class="ComboBoxTextDivContainer"])
	sleep    2							 
	Wait Until Page Contains Element      xpath:(//div[@title="Modified Topology Data"])    30
	Click Element    xpath:(//div[@title="Modified Topology Data"])
	wait for page to load
	capture page screenshot
	
	
									   
	
select the table SubNetwork List for visualization
	Wait Until Page Contains Element      xpath:(//div[@class="ComboBoxTextDivContainer"])    30
	Click Element    xpath:(//div[@class="ComboBoxTextDivContainer"])
	sleep    2
	Wait Until Page Contains Element      xpath:(//div[@title="SubNetwork List"])    30
	Click Element    xpath:(//div[@title="SubNetwork List"])
	wait for page to load
	capture page screenshot
	
Change the Visualization type to Table
	sleep    5
	Wait Until Page Contains Element      xpath://div[@class="${visualisations_type}"][1]     timeout=15
	Click Element      xpath://div[@class="${visualisations_type}"][1]
	wait for page to load
	capture page screenshot	
	
validate that the connected datasource is present in ENIQDatasources
	${text}=    Get Text    xpath:(//div[@class="valueCellsContainer"])
	Log    ${text}
	should contain    ${text}    NetAn_ODBC
	wait for page to load
	capture page screenshot
	
read DataSourceName in SubNework List table
	[Arguments]    ${ds}
	Click Element    xpath://div[contains(text(),'DataSourceName')]
	Sleep      3s
    Click Element    xpath://div[@title = 'Sort by this column from highest to lowest value (Shift+click).']
	Sleep      3s
	${text}=    Get Text    xpath:(//div[@class="sf-element-table-cell flex-justify-start flex-align-start \ sfc-value-cell sfpc-odd-column sfpc-odd-row"])[3]
	Log    ${text}
	should contain    ${text}    ${ds}
	wait for page to load
	capture page screenshot
	
read DataSourceName in Modified Topology Data table
	${text}=    Get Text    xpath:(//div[@class="cell-text"])[6]
	Log    ${text}
	should contain    ${text}    NetAn_ODBC
	[Return]    ${text}
	wait for page to load
	capture page screenshot	
	
validate that the message is present if analysis is not saved with NetAn details
	element should be visible    xpath://*[contains(text(),'please provide Value for: NetAn SQL DB URL')]
	sleep    2
	#element should be visible    xpath://*[contains(text(),'Enter Data Source Name')]
	wait for page to load
	capture page screenshot
	
click on the back button
	[Arguments]    ${n}
    FOR    ${i}    IN RANGE    0    ${n} 
           Click element     xpath:(//div[@title="Back"])           
    END	
	wait for page to load
	capture page screenshot
	
validate the error message in Sync With Eniq
	capture page screenshot
	Click Element       xpath://*[@value="Sync with ENIQ"]
	Sleep      2s
	capture page screenshot
	wait until element is visible      xpath:(//div[contains(text(),'Could not perform action')])    30
    capture page screenshot
	
Open PMEx DXP Application
	AutoItLibrary.Run    C:\\Program Files (x86)\\TIBCO\\Spotfire\\11.4.2\\Spotfire.Dxp /server:"https://localhost/" /username:Administrator /password:Ericsson01 /file:${dxp_file_loc}/PM_Explorer.dxp
    Wait until screen contain     ${IMAGE_DIR}\\certificate.PNG    300
    Click    ${IMAGE_DIR}\\certificateYes.PNG
    Sleep    10s
    #Wait until screen contain     ${IMAGE_DIR}\\dontInstall.PNG    300
    #Click    ${IMAGE_DIR}\\dontInstall.PNG
    #Control Click    Security Alert    ${EMPTY}    Button4    left    1    0    0
    #Wait until screen contain     ${IMAGE_DIR}\\MissingDataScreen.PNG    300
																		 
    #Click    ${IMAGE_DIR}\\MissingDatacheckbox.PNG
    #Click    ${IMAGE_DIR}\\OKButton.PNG
    #Sleep    10
    Wait until screen contain     ${IMAGE_DIR}\\PMExS11Page.PNG    300
    Sleep    15
    Capture Screen	
	
open the Properties tab in Document Properties
	sleep    2
	wait until screen contain    ${IMAGE_DIR}\\FileMenu.PNG    300
	Click    ${IMAGE_DIR}\\FileMenu.PNG
	wait until screen contain    ${IMAGE_DIR}\\DocumentProperties.PNG    300
	Click    ${IMAGE_DIR}\\DocumentProperties.PNG
	wait until screen contain    ${IMAGE_DIR}\\PropertiesButton.PNG    300
	Click    ${IMAGE_DIR}\\PropertiesButton.PNG
	capture screen
	
scroll down to TriggerConnect Property
	sleep    2	
	FOR    ${i}    IN RANGE    0    180 
		   sleep    0.5
           Click    ${IMAGE_DIR}\\PMEX_Scroll_Down.PNG       
    END
	capture screen
	
scroll down to TriggerSubNetwork Property
	sleep    2	
	FOR    ${i}    IN RANGE    0    180 
		   sleep    0.5
           Click    ${IMAGE_DIR}\\PMEX_Scroll_Down.PNG       
    END
	capture screen
	
read the TriggerConnect timestamp
	Set ocr text read    True
    ${text}=    SikuliLibrary.Get text
    Log    ${text}
    [Return]    ${text}	
	capture screen
	
read the TriggerSubNetwork timestamp
	Set ocr text read    True
    ${text}=    SikuliLibrary.Get text
    Log    ${text}
    [Return]    ${text}	
	capture screen	
	
verify that 'Measure Mapping' is kept as a single word
	sleep    2
	element should be visible    xpath://*[contains(text(),'Measure Mapping')]
	wait for page to load
	capture page screenshot	
	
select the table Measure Mapping for visualization
	Wait Until Page Contains Element      xpath:(//div[@class="ComboBoxTextDivContainer"])
	Click Element    xpath:(//div[@class="ComboBoxTextDivContainer"])
	sleep    2
	
	Wait Until Page Contains Element      xpath:(//div[@title="Measure Mapping"])    100
	Click Element    xpath:(//div[@title="Measure Mapping"])
	wait for page to load
	capture page screenshot	

select the table MoClass for visualization
    Wait Until Page Contains Element      xpath:(//div[@class="ComboBoxTextDivContainer"])
	Click Element    xpath:(//div[@class="ComboBoxTextDivContainer"])
	sleep    2
	Wait Until Page Contains Element      xpath:(//div[@title="MoClass"])    100
	Click Element    xpath:(//div[@title="MoClass"])
	wait for page to load
	capture page screenshot	
verify that there's data in the Measure Mapping table
	${text}=    Get Text    xpath:(//div[@class="${sfx_label}"])[1]
	Log    ${text}
    wait for page to load
	capture page screenshot	
	
Verify that there's data in the MOClass table
	${text}=    Get Text    xpath:(//div[@class="${sfx_label}"])[1]
	Log    ${text}
    wait for page to load
	capture page screenshot											 
read the EniqName column values in ENIQDatasources
	${text}=    Get Text    xpath:(//div[@class="sf-element-table-cell flex-justify-start flex-align-start \ sfc-value-cell sfpc-even-column sfpc-odd-row"])[1]
	${text1}=    Get Text    xpath:(//div[@class="sf-element-table-cell flex-justify-start flex-align-start \ sfc-value-cell sfpc-even-column sfpc-even-row"])[1]
	Log    ${text}
	Log    ${text1}
	[Return]    ${text}    ${text1}
	wait for page to load
	capture page screenshot	
	
click on Sync with Eniq
	sleep    2
	Click element     xpath: //input[@value='Sync with ENIQ']
    Sleep    80s
	wait for page to load
	capture page screenshot	
	
read the DatasourceName column values in Modified Topology Data	
	${value}=    get text    xpath:(//div[@class="sf-element-table-cell flex-justify-start flex-align-start \ sfc-value-cell sfpc-even-column sfpc-odd-row"])[3]
	Log    ${value}
	[Return]    ${value}
	wait for page to load
	capture page screenshot
	
	
read the DataSourceName column values in SubNework List table	
	[Arguments]    ${ds1}    ${ds2}    ${ds3}
	${text}=    Get Text    xpath:(//div[@class="sf-element-table-cell flex-justify-start flex-align-start \ sfc-value-cell sfpc-odd-column sfpc-odd-row"])[3]
	Log    ${text}
	should contain    ${text}    ${ds1}
	wait for page to load
	capture page screenshot
	
check failed message if Fetch SubNetwork failed
	${result}=    Run Keyword And Return Status    element should be visible    xpath://*[contains(text(),'Failed to fetch subnetwork')]
	Log    ${result}
	[Return]    ${result}
	wait for page to load
	capture page screenshot	
	

	
the dataSources from the above 2 tables should match
	[Arguments]    ${ds1}    ${ds2}
	sleep    2
	Log    ${ds1}
	Log    ${ds2}
	wait for page to load
	capture page screenshot	
	
read the DataSourceName in SubNework List table
	${text}=    Get Text    xpath:(//div[@class="sf-element-table-cell flex-justify-start flex-align-start \ sfc-value-cell sfpc-odd-column sfpc-odd-row"])[3]
	Log    ${text}
	[Return]    ${text}
	wait for page to load
	capture page screenshot	
	
go to the Properties tab in Document Properties
	sleep    2
	wait until screen contain    ${IMAGE_DIR}\\PropertiesButton.PNG    300
	Click    ${IMAGE_DIR}\\PropertiesButton.PNG
	sleep    2
	
######################################## IMPROVEMENT EQEV-103911 END ########################################

######################################## IMPROVEMENT EQEV-108162 ########################################

Verify the delete message 
    [Arguments]    ${name}
	Select created Collection      ${name}
	Sleep      5s
	click on button    Delete Collection
	sleep    2
	Element should be visible   xpath://*[contains(text(),'Selected Collection will be deleted, Do you want to proceed ?')]
	wait for page to load
	capture page screenshot
    
Select Collections
	[Arguments]    ${node_list}
    @{list}=      Split string      ${node_list}    ,
     FOR    ${node}    IN    @{list}
           Clear Element Text      xpath:(//input[contains(@class,'SearchInput sf-element-input sf-suppress-forms-accept-command sf-suppress-forms-cancel-command sf-input-with-placeholder')])[2]
           Selenium2Library.Input Text     xpath:(//input[contains(@class,'SearchInput sf-element-input sf-suppress-forms-accept-command sf-suppress-forms-cancel-command sf-input-with-placeholder')])[2]     ${node} 
           Click on scroll down button    6     1
           sleep    2s
           wait for page to load
           Click element      xpath://div[@title='${node}']      modifier=CTRL
           sleep   1s
     END
    wait for page to load
	capture page screenshot
	
######################################## IMPROVEMENT EQEV-108162 END ########################################

Click on the scroll down button
    [Arguments]     ${button}    ${n}
    @{element}=    Get WebElements	    xpath: //div[@class="ScrollbarButton sf-element sf-element-scroll-bar-button sfpc-bottom"]
    ${scroll_button}=        Get from list     ${element}    ${button}
    FOR    ${i}    IN RANGE    0    ${n} 
           Run Keyword and Ignore Error    Click element     ${scroll_button}           
    END
    wait for page to load
	capture page screenshot
	
select a node
    Wait Until Page Contains Element      xpath:(//div[@class="sf-element-list-box-item sfpc-selected"])    100
	Click Element    xpath:(//div[@class="sf-element-list-box-item sfpc-selected"])
    wait for page to load
	capture page screenshot
	
Enter the Calendar Interval
	[Arguments]    ${startDate}    ${endDate}
	click on scroll down button    7    11
	sleep    3
	FOR    ${i}    IN RANGE    0    3 
		Click element       (//input[@class="sf-element sf-element-control sfc-property sfc-text-box"])[6]
		Selenium2Library.Press keys     (//input[@class="sf-element sf-element-control sfc-property sfc-text-box"])[6]    ${startDate}
		sleep    2
		click on scroll up button    7    12
		click on scroll down button    7    10
		sleep    2
		${status}=     Run keyword and return status     Element should not be visible      xpath://span[@id='msg4' and @style='COLOR: #fa7864']
		IF      "${status}"=="True"
					Exit for loop
		END
		
	END 
	
	FOR    ${i}    IN RANGE    0    3 
		Click element       (//input[@class="sf-element sf-element-control sfc-property sfc-text-box"])[7]
	    Selenium2Library.Press keys     (//input[@class="sf-element sf-element-control sfc-property sfc-text-box"])[7]    06:00am	
		sleep    2
		click on scroll up button    7    12
		click on scroll down button    7    10
		sleep    2
		${status}=     Run keyword and return status     Element should not be visible      xpath://span[@id='msg5' and @style='COLOR: #fa7864']
		IF      "${status}"=="True"
					Exit for loop
		END
		
	END 
	
	FOR    ${i}    IN RANGE    0    3 
		Click element       (//input[@class="sf-element sf-element-control sfc-property sfc-text-box"])[9]
	    Selenium2Library.Press keys     (//input[@class="sf-element sf-element-control sfc-property sfc-text-box"])[9]    ${endDate}	
		sleep    2
		click on scroll up button    7    12
		click on scroll down button    7    10
		sleep    2
		${status}=     Run keyword and return status     Element should not be visible      xpath://span[@id='msg6' and @style='COLOR: #fa7864']
		IF      "${status}"=="True"
					Exit for loop
		END
		
	END 
	
	FOR    ${i}    IN RANGE    0    3 
		Click element       (//input[@class="sf-element sf-element-control sfc-property sfc-text-box"])[10]
		Selenium2Library.Press keys     (//input[@class="sf-element sf-element-control sfc-property sfc-text-box"])[10]    12:00pm	
		sleep    2
		click on scroll up button    7    12
		click on scroll down button    7    10
		sleep    2
		${status}=     Run keyword and return status     Element should not be visible      xpath://span[@id='msg7' and @style='COLOR: #fa7864']
		IF      "${status}"=="True"
					Exit for loop
		END
		
	END 
    wait for page to load
    Capture page screenshot
	
	
Enter Preceding period
    [Arguments]    ${preceding_period}
    Clear Element Text      xpath:(//input[contains(@class,'sf-element sf-element-control sfc-property sfc-text-box')])[12]
    sleep    3s
    Selenium2Library.Input Text     xpath:(//input[contains(@class,'sf-element sf-element-control sfc-property sfc-text-box')])[12]      ${preceding_period}
    sleep    3s
	Click on scroll down button     6    1	   
	sleep    2s
    wait for page to load
    Capture page screenshot

Select Preceding Period Units as
    [Arguments]     ${preceding_period_units}
    @{element}=    Get WebElements	    xpath: //div[@class='ComboBoxTextDivContainer']
    ${Aggregation_ele}=        Get from list     ${element}    7
    Click element     ${Aggregation_ele}
    Sleep    3s
    Click element      xpath://div[@class='sf-element-dropdown-list-item'][@title='${preceding_period_units}']
    Sleep    5s
    wait for page to load
    capture page screenshot

Enter the time range
	[Arguments]    ${startTime}    ${endTime}
	click on scroll up button    7    12
	click on scroll down button    7    8
	@{element}=    Get WebElements	    xpath: //input[@class='sf-element sf-element-control sfc-property sfc-text-box']
    ${ele}=        Get from list     ${element}    6	
	#Clear Element Text      ${ele}
	Click element        ${ele}
	sleep    2
	Selenium2Library.Press keys      ${ele}    ${startTime}
	sleep    2
	click on scroll down button    7    2
	@{element}=    Get WebElements	    xpath: //input[@class='sf-element sf-element-control sfc-property sfc-text-box']
    ${ele}=        Get from list     ${element}    9
	#Clear Element Text      ${ele}
	sleep    2
	Selenium2Library.Press keys      ${ele}    ${endTime}
	capture page screenshot
	click on scroll up button    7    12
	wait for page to load
	capture page screenshot
	
######################################## MR EQEV-109214 ########################################

select the created collections
	[Arguments]    ${collection1}    ${collection2}
	place cursor on    CollectionName
	Click on scroll up button    2    15
	Wait Until Page Contains Element      xpath://*[contains(text(),'${collection1}')]    100
	Click element      xpath://*[contains(text(),'${collection1}')]      modifier=CTRL
	sleep    2
	Wait Until Page Contains Element      xpath://*[contains(text(),'${collection2}')]    100
	Click element      xpath://*[contains(text(),'${collection2}')]      modifier=CTRL
	wait for page to load
	capture page screenshot
	
validate that the button is disabled
	[Arguments]    ${button}
	Element should be visible    xpath:(//span[@id="ModifyCollectionDisabled"])//input[@value="${button}"]
	wait for page to load
	capture page screenshot
	
select Day in Advanced Options
	[Arguments]     ${list}
    @{day}=      Split string      ${list}    ,
    click on scroll up button    7    20
    Click on scroll down button    7    13    
    ${InList}=    Get Match Count    ${day}    MONDAY
    Run keyword if    ${InList}!=1    Click element    xpath://div[@title='Monday']
    sleep    2
    ${InList}=    Get Match Count    ${day}    TUESDAY
    Run keyword if    ${InList}!=1    Click element    xpath://div[@title='Tuesday']
    sleep    2
    ${InList}=    Get Match Count    ${day}    WEDNESDAY
    Run keyword if    ${InList}!=1    Click element    xpath://div[@title='Wednesday']
    Sleep   2s
    ${InList}=    Get Match Count    ${day}    THURSDAY
    Run keyword if    ${InList}!=1    Click element    xpath://div[@title='Thursday']
    sleep    2
    ${InList}=    Get Match Count    ${day}    FRIDAY
    Run keyword if    ${InList}!=1    Click element    xpath://div[@title='Friday']
    sleep    2    
    ${InList}=    Get Match Count    ${day}    SATURDAY
    Run keyword if    ${InList}!=1    Click element    xpath://div[@title='Saturday']
    sleep    2
    ${InList}=    Get Match Count    ${day}    SUNDAY
    Run keyword if    ${InList}!=1    Click element    xpath://div[@title='Sunday']
    wait for page to load
	capture page screenshot
    
validate that the section is present
	[Arguments]    ${title}
	Element should be visible    xpath://*[contains(text(),'${title}')]
	wait for page to load
	capture page screenshot
	
validate that the Hour of Day filter is a check box filter
	FOR    ${i}    IN RANGE    0     24
		Element should be visible    xpath:(//div[@class="flex-item flex-container-horizontal flex-inline-container flex-align-center"])//div[@title="${i}"]
    END
    wait for page to load
	capture page screenshot
	
validate that Hour Of Day filter is enabled only for HOUR or ROP
	click on scroll up button    7    20
    Select Aggregation in select time as    Hour
    Click on scroll down button    7    16
    Click element      xpath:(//div[@class="flex-item flex-container-horizontal flex-inline-container flex-align-center"])//div[@title="0"]
    sleep    2
    ${status}=       runkeyword and return status        Click element     xpath:(//span[@id='HourofDay']//div[contains(@class,'sf-element sf-element-check-box flex-item flex-no-shrink flex-align-start sfpc-')])[1]
    Run keyword if     "${status}"=="False"        FAIL      Hour of day checkbox is disbaled
    click on scroll up button    7    20
    Select Aggregation in select time as    ROP
    Click on scroll down button    7    16
    Click element      xpath:(//div[@class="flex-item flex-container-horizontal flex-inline-container flex-align-center"])//div[@title="0"]
    sleep    2
    ${status}=       runkeyword and return status        Click element     xpath:(//span[@id='HourofDay']//div[contains(@class,'sf-element sf-element-check-box flex-item flex-no-shrink flex-align-start sfpc-')])[1]
    Run keyword if     "${status}"=="False"        FAIL      Hour of day checkbox is disbaled
    wait for page to load
    capture page screenshot
	
validate that Hour Of Day filter is disabled for Aggregations other than Hour and ROP
	click on scroll up button    7    20
	Select Aggregation in select time as    BusyHour
	Click on scroll down button    7    16
	${status}=    Run Keyword And Return Status    Click element      xpath:(//div[@class="flex-item flex-container-horizontal flex-inline-container flex-align-center"])//div[@title="0"]
	Log    ${status}
	${status}=    convert to string    ${status}
	should be equal    ${status}    False
	sleep    2	
	${status}=       runkeyword and return status        Click element     xpath:(//span[@id='HourofDay']//div[contains(@class,'sf-element sf-element-check-box flex-item flex-no-shrink flex-align-start sfpc-')])[1]
	Run keyword if     "${status}"=="True"        FAIL      Hour of day checkbox is enabled	
	click on scroll up button    7    20
	Select Aggregation in select time as    Day
	Click on scroll down button    7    16
	${status}=    Run Keyword And Return Status    Click element      xpath:(//div[@class="flex-item flex-container-horizontal flex-inline-container flex-align-center"])//div[@title="0"]
	Log    ${status}
	${status}=    convert to string    ${status}
	should be equal    ${status}    False
	sleep    2
	${status}=       runkeyword and return status        Click element     xpath:(//span[@id='HourofDay']//div[contains(@class,'sf-element sf-element-check-box flex-item flex-no-shrink flex-align-start sfpc-')])[1]
	Run keyword if     "${status}"=="True"        FAIL      Hour of day checkbox is enabled
	click on scroll up button    7    20
	Select Aggregation in select time as    Week
	Click on scroll down button    7    16
	${status}=    Run Keyword And Return Status    Click element      xpath:(//div[@class="flex-item flex-container-horizontal flex-inline-container flex-align-center"])//div[@title="0"]
	Log    ${status}
	${status}=    convert to string    ${status}
	should be equal    ${status}    False
	sleep    2
	${status}=       runkeyword and return status        Click element     xpath:(//span[@id='HourofDay']//div[contains(@class,'sf-element sf-element-check-box flex-item flex-no-shrink flex-align-start sfpc-')])[1]
	Run keyword if     "${status}"=="True"        FAIL      Hour of day checkbox is enabled
	wait for page to load
	capture page screenshot
	
select Hour ID for Hour of Day filtering
	[Arguments]     ${list}
    @{hour}=      Split string      ${list}    ,
    click on scroll up button    7    25
    Click on scroll down button    7    25 
    ${InList}=    Get Match Count    ${hour}    0
    Run keyword if    ${InList}!=1    Click element    xpath://div[@title='0']
    sleep    2
    ${InList}=    Get Match Count    ${hour}    1
    Run keyword if    ${InList}!=1    Click element    xpath://div[@title='1']
    sleep    2
    ${InList}=    Get Match Count    ${hour}    2
    Run keyword if    ${InList}!=1    Click element    xpath://div[@title='2']
    Sleep   2s
    ${InList}=    Get Match Count    ${hour}    3
    Run keyword if    ${InList}!=1    Click element    xpath://div[@title='3']
    sleep    2
    ${InList}=    Get Match Count    ${hour}    4
    Run keyword if    ${InList}!=1    Click element    xpath://div[@title='4']
    sleep    2    
    ${InList}=    Get Match Count    ${hour}    5
    Run keyword if    ${InList}!=1    Click element    xpath://div[@title='5']
    sleep    2
    ${InList}=    Get Match Count    ${hour}    6
    Run keyword if    ${InList}!=1    Click element    xpath://div[@title='6']
    wait for page to load
	capture page screenshot
	
Launch the Tibco spotfire PM Explorer Application DXP 8
	AutoItLibrary.Run    C:\\Program Files (x86)\\TIBCO\\Spotfire\\11.4.2\\Spotfire.Dxp /server:"https://localhost/" /username:Administrator /password:Ericsson01 /file:${dxp_file_loc}/PM_Explorer_S11_8.dxp  
    Sleep    25
    Capture Screen
    
Go to the Report Manager Page
	[Arguments]    ${TextFileContent}     ${ExecuteInTransaction}
    Click on element    ${IMAGE_DIR}\\FileMenu.PNG      ${IMAGE_DIR}\\DocumentProperties.PNG     3
    Click on element    ${IMAGE_DIR}\\DocumentProperties.PNG      ${IMAGE_DIR}\\PropertiesButton.PNG     3
    Click on element    ${IMAGE_DIR}\\PropertiesButton.PNG      ${IMAGE_DIR}\\ScriptButton.PNG     3
    Click on element    ${IMAGE_DIR}\\ScriptButton.PNG      ${IMAGE_DIR}\\checkbox.PNG     3
    Click on element    ${IMAGE_DIR}\\checkbox.PNG      ${IMAGE_DIR}\\newButton.PNG     3
    Click on element    ${IMAGE_DIR}\\newButton.PNG      ${IMAGE_DIR}\\scriptTextArea.PNG     3
    Run Keyword If    ${ExecuteInTransaction}==False    Click    ${IMAGE_DIR}\\ExecuteInTransaction.PNG
    Sleep    2s
    Click    ${IMAGE_DIR}\\scriptTextArea.PNG
    Paste text    ${IMAGE_DIR}\\scriptTextArea1.PNG    ${TextFileContent}
    sleep    3
    Click    ${IMAGE_DIR}\\runScriptButton.PNG
    Sleep    70s
    Wait until screen contain     ${IMAGE_DIR}\\OutputOkNew.PNG    300
    Capture Screen
    Sleep    10s
    Click    ${IMAGE_DIR}\\CancelButton.PNG
    Sleep    5
    Click    ${IMAGE_DIR}\\NOActionButton.PNG
    Sleep    10s
    Click    ${IMAGE_DIR}\\OKButton.PNG
    Sleep    25s
    Click    ${IMAGE_DIR}\\GeneralTab.PNG
    Sleep    2s
    Click    ${IMAGE_DIR}\\OKButton.PNG
    Sleep    8s
    Capture Screen

select the report with hour id and click on Edit
	sleep    2
	Click    ${IMAGE_DIR}\\PMEX_Report_With_Hour_ID.PNG
	sleep    2
	Click    ${IMAGE_DIR}\\PMEx_Edit_Report_Button.PNG
	sleep    60
	Capture Screen	
	
open data table properties and verify the sql
	sleep    3
	Click on element    ${IMAGE_DIR}\\dataButton.PNG      ${IMAGE_DIR}\\dataTableProperties.PNG     3
	sleep    5
	Click    ${IMAGE_DIR}\\dataTableProperties.PNG
	FOR    ${i}    IN RANGE    0    30
		Click    ${IMAGE_DIR}\\PMEX_Scroll_Down_Button.PNG
		sleep    1
    END
    Wait until screen contain    ${IMAGE_DIR}\\PMEX_Hour_ID_Report_Name.PNG    60
    Click    ${IMAGE_DIR}\\PMEX_Hour_ID_Report_Name.PNG
    sleep    5
	Wait until screen contain    ${IMAGE_DIR}\\sourceInformationTab.PNG    300
	Click    ${IMAGE_DIR}\\sourceInformationTab.PNG
	Set ocr text read     True
	${text}=    SikuliLibrary.Get text
	Log    ${text}
	should contain    ${text}    1
	should contain    ${text}    2
	should contain    ${text}    3
	should contain    ${text}    4
	should contain    ${text}    5
	should contain    ${text}    6
	should contain    ${text}    7

Get iron_python script for navigation					  
    [Arguments]    ${Filepath}
    ${TextFileContent}=     OperatingSystem.Get File    ${Filepath}
    Log       ${TextFileContent}
    [return]     ${TextFileContent}
    
verify that Hour of Day filtering is present in Edit page
	Element should be visible    xpath:(//div[@id="hourDayFilterView"])
	wait for page to load
	capture page screenshot
	
verify that the specified Hour ID is selected in Edit page
	Element should be visible    xpath:(//div[@class="sf-element sf-element-check-box flex-item flex-no-shrink flex-align-start sfpc-unchecked"])[1]
	Element should be visible    xpath:(//div[@class="sf-element sf-element-check-box flex-item flex-no-shrink flex-align-start sfpc-unchecked"])[2]
	Element should be visible    xpath:(//div[@class="sf-element sf-element-check-box flex-item flex-no-shrink flex-align-start sfpc-unchecked"])[3]
	click on the scroll right button    7    20
	Element should be visible    xpath:(//div[@class="sf-element sf-element-check-box flex-item flex-no-shrink flex-align-start sfpc-unchecked"])[4]
	Element should be visible    xpath:(//div[@class="sf-element sf-element-check-box flex-item flex-no-shrink flex-align-start sfpc-unchecked"])[5]
	Element should be visible    xpath:(//div[@class="sf-element sf-element-check-box flex-item flex-no-shrink flex-align-start sfpc-unchecked"])[6]
	wait for page to load
	capture page screenshot
	
click on the scroll right button
	[Arguments]     ${button}    ${n}
    @{element}=    Get WebElements	    xpath: //div[@class="ScrollbarButton sf-element sf-element-scroll-bar-button sfpc-right"]
    ${scroll_button}=        Get from list     ${element}    ${button}
    FOR    ${i}    IN RANGE    0    ${n} 
           Click element     ${scroll_button}
           sleep    0.5           
    END
    wait for page to load
	capture page screenshot
	
edit Hour ID for Hour of Day filtering
	[Arguments]     ${list}
    @{hour}=      Split string      ${list}    ,
    Scroll Element Into view    xpath:(//div[@id="hourDayFilterView"]) 
    ${InList}=    Get Match Count    ${hour}    0
    Run keyword if    ${InList}!=1    Click element    xpath://div[@title='0']
    sleep    2
    ${InList}=    Get Match Count    ${hour}    1
    Run keyword if    ${InList}!=1    Click element    xpath://div[@title='1']
    sleep    2
    ${InList}=    Get Match Count    ${hour}    4
    Run keyword if    ${InList}!=1    Click element    xpath://div[@title='4']
    sleep    2    
    ${InList}=    Get Match Count    ${hour}    5
    Run keyword if    ${InList}!=1    Click element    xpath://div[@title='5']
    wait for page to load
	capture page screenshot
	
Select Aggregation in edit page
	[Arguments]    ${aggregation}
	Wait Until Element Is Visible     xpath:(//div[@class="ComboBoxTextDivContainer"])[7]    300
    Click element     xpath:(//div[@class="ComboBoxTextDivContainer"])[7]
    sleep    3
    click on the button    ${aggregation}
	wait for page to load
	capture page screenshot
		
validate that Hour Of Day filter is disabled for Aggregations other than Hour and ROP in edit page
	Select Aggregation in edit page    BusyHour
	Click on scroll down button    9    16
	${status}=    Run Keyword And Return Status    Click element      xpath:(//div[@class="flex-item flex-container-horizontal flex-inline-container flex-align-center"])//div[@title="0"]
	Log    ${status}
	${status}=    convert to string    ${status}
	should be equal    ${status}    False
	sleep    2
	click on scroll up button    9    20
	Select Aggregation in edit page    Day
	Click on scroll down button    9    16
	${status}=    Run Keyword And Return Status    Click element      xpath:(//div[@class="flex-item flex-container-horizontal flex-inline-container flex-align-center"])//div[@title="0"]
	Log    ${status}
	${status}=    convert to string    ${status}
	should be equal    ${status}    False
	sleep    2
	click on scroll up button    9    20
	Select Aggregation in edit page    Week
	Click on scroll down button    9    16
	${status}=    Run Keyword And Return Status    Click element      xpath:(//div[@class="flex-item flex-container-horizontal flex-inline-container flex-align-center"])//div[@title="0"]
	Log    ${status}
	${status}=    convert to string    ${status}
	should be equal    ${status}    False
	sleep    2
	click on scroll up button    9    20
	Select Aggregation in edit page    Hour
	Click on scroll down button    9    16
	${status}=    Run Keyword And Return Status    Click element      xpath:(//div[@class="flex-item flex-container-horizontal flex-inline-container flex-align-center"])//div[@title="0"]
	Log    ${status}
	${status}=    convert to string    ${status}
	should be equal    ${status}    True
	sleep    2
	click on scroll up button    9    20
	Select Aggregation in edit page    ROP
	Click on scroll down button    9    16
	${status}=    Run Keyword And Return Status    Click element      xpath:(//div[@class="flex-item flex-container-horizontal flex-inline-container flex-align-center"])//div[@title="0"]
	Log    ${status}
	${status}=    convert to string    ${status}
	should be equal    ${status}    True								 
	wait for page to load
	capture page screenshot
	
verify that the checkboxes are present one after the other
	wait until page contains element    xpath: (//span[@id="expandTag" and contains(text(),'+')])    5
	${status}=    run keyword and return status    element should be visible    xpath: (//span[@id="expandTag" and contains(text(),'+')])
	IF    "${status}"=="True"
		Click on scroll down button    7    10  
		Element should be visible    xpath:(//div[@id="weekDayFilterView"])//table//tbody//tr[1]//div[@title="Monday"]
		Element should be visible    xpath:(//div[@id="weekDayFilterView"])//table//tbody//tr[1]//div[@title="Tuesday"]
		Element should be visible    xpath:(//div[@id="weekDayFilterView"])//table//tbody//tr[1]//div[@title="Wednesday"]
		Element should be visible    xpath:(//div[@id="weekDayFilterView"])//table//tbody//tr[1]//div[@title="Thursday"]
		Element should be visible    xpath:(//div[@id="weekDayFilterView"])//table//tbody//tr[2]//div[@title="Friday"]
		Element should be visible    xpath:(//div[@id="weekDayFilterView"])//table//tbody//tr[2]//div[@title="Saturday"]
		Element should be visible    xpath:(//div[@id="weekDayFilterView"])//table//tbody//tr[2]//div[@title="Sunday"]
	ELSE
		wait until element is visible    xpath: (//span[@id="expandTag" and contains(text(),'+')])    5
		click element    xpath: (//span[@id="expandTag" and contains(text(),'+')])
		Click on scroll down button    7    10
		Element should be visible    xpath:(//div[@id="weekDayFilterView"])//table//tbody//tr[1]//div[@title="Monday"]
		Element should be visible    xpath:(//div[@id="weekDayFilterView"])//table//tbody//tr[1]//div[@title="Tuesday"]
		Element should be visible    xpath:(//div[@id="weekDayFilterView"])//table//tbody//tr[1]//div[@title="Wednesday"]
		Element should be visible    xpath:(//div[@id="weekDayFilterView"])//table//tbody//tr[1]//div[@title="Thursday"]
		Element should be visible    xpath:(//div[@id="weekDayFilterView"])//table//tbody//tr[2]//div[@title="Friday"]
		Element should be visible    xpath:(//div[@id="weekDayFilterView"])//table//tbody//tr[2]//div[@title="Saturday"]
		Element should be visible    xpath:(//div[@id="weekDayFilterView"])//table//tbody//tr[2]//div[@title="Sunday"]
	END
	wait for page to load
	capture page screenshot
	
verify that the filter check boxes are checked by default
	Click on scroll down button     7    19
    Element should not be visible    xpath:(//div[@id='A']//div[@class='sf-element sf-element-check-box flex-item flex-no-shrink flex-align-start sfpc-unchecked'])
    wait for page to load
    capture page screenshot
	
verify that only the day selected during report creation is checked
	click on the button    Monday
	Element should be visible    xpath:(//div[@class="sf-element sf-element-check-box flex-item flex-no-shrink flex-align-start sfpc-unchecked"])[1]
	Element should be visible    xpath:(//div[@class="sf-element sf-element-check-box flex-item flex-no-shrink flex-align-start sfpc-unchecked"])[2]
	Element should be visible    xpath:(//div[@class="sf-element sf-element-check-box flex-item flex-no-shrink flex-align-start sfpc-unchecked"])[5]
	Element should be visible    xpath:(//div[@class="sf-element sf-element-check-box flex-item flex-no-shrink flex-align-start sfpc-unchecked"])[6]
	click on the scroll right button     7    20  
	Element should be visible    xpath:(//div[@class="sf-element sf-element-check-box flex-item flex-no-shrink flex-align-start sfpc-unchecked"])[3]
	Element should be visible    xpath:(//div[@class="sf-element sf-element-check-box flex-item flex-no-shrink flex-align-start sfpc-unchecked"])[4]
	Element should be visible    xpath:(//div[@class="sf-element sf-element-check-box flex-item flex-no-shrink flex-align-start sfpc-unchecked"])[7]
	wait for page to load
	capture page screenshot
	
select Day in Advanced Options in edit page
	[Arguments]     ${list}
    @{day}=      Split string      ${list}    ,
    Scroll Element Into view    xpath:(//div[@id="weekDayFilterView"])   
    ${InList}=    Get Match Count    ${day}    MONDAY
    Run keyword if    ${InList}!=1    Click element    xpath://div[@title='Monday']
    sleep    2
    ${InList}=    Get Match Count    ${day}    TUESDAY
    Run keyword if    ${InList}!=1    Click element    xpath://div[@title='Tuesday']
    sleep    2
    ${InList}=    Get Match Count    ${day}    FRIDAY
    Run keyword if    ${InList}!=1    Click element    xpath://div[@title='Friday']
    sleep    2    
    ${InList}=    Get Match Count    ${day}    SATURDAY
    Run keyword if    ${InList}!=1    Click element    xpath://div[@title='Saturday']
    wait for page to load
	capture page screenshot
	
validate that Hour ID filtering is disabled
	Click on scroll down button    7    16
	${status}=    Run Keyword And Return Status    Click element      xpath:(//div[@class="flex-item flex-container-horizontal flex-inline-container flex-align-center"])//div[@title="0"]
	Log    ${status}
	${status}=    convert to string    ${status}
	should be equal    ${status}    False
	wait for page to load
	capture page screenshot
	
uncheck Days in Advanced Options
	[Arguments]     ${list}
    @{day}=      Split string      ${list}    ,
    click on scroll up button    7    20
    Click on scroll down button    7    13    
    ${InList}=    Get Match Count    ${day}    MONDAY
    Run keyword if    ${InList}==1    Click element    xpath://div[@title='Monday']
    sleep    2
    ${InList}=    Get Match Count    ${day}    TUESDAY
    Run keyword if    ${InList}==1    Click element    xpath://div[@title='Tuesday']
    sleep    2
    ${InList}=    Get Match Count    ${day}    WEDNESDAY
    Run keyword if    ${InList}==1    Click element    xpath://div[@title='Wednesday']
    Sleep   2s
    ${InList}=    Get Match Count    ${day}    THURSDAY
    Run keyword if    ${InList}==1    Click element    xpath://div[@title='Thursday']
    sleep    2
    ${InList}=    Get Match Count    ${day}    FRIDAY
    Run keyword if    ${InList}==1    Click element    xpath://div[@title='Friday']
    sleep    2    
    ${InList}=    Get Match Count    ${day}    SATURDAY
    Run keyword if    ${InList}==1    Click element    xpath://div[@title='Saturday']
    sleep    2
    ${InList}=    Get Match Count    ${day}    SUNDAY
    Run keyword if    ${InList}==1    Click element    xpath://div[@title='Sunday']
    wait for page to load
	capture page screenshot
	
verify that error message is visible
	Wait Until Page Contains Element    xpath://*[contains(text(),'Error: Please check at least one Day of Week check box to proceed with report creation')]     50
    wait for page to load
    capture page screenshot

######################################## MR EQEV-109214 END ########################################

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
	
verify that connection to FailedDB failed and server is considered failed
    element should be visible    xpath:(//div[@class="sf-element-table-cell flex-justify-start flex-align-end \ sfc-column-header sfpc-level-1 sfpc-level-last sfpc-odd-column" and @row="0" and @column="2"])
	FOR    ${i}    IN RANGE    1    4
        ${txt}=    Selenium2Library.get text    xpath: (//div[@class="valueCellCanvas"])//div//div[@row="${i}" and @column="2"]
	    Log    ${txt}
	    ${status}=    run keyword and return status    should contain    ${txt}    Failed:
	    Log    ${status}
	    Run keyword If    "${status}"=="True"    Exit For Loop
    END
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
	should be equal    ${status1}    ${status}
	wait for page to load
	capture page screenshot
	
select the created collection and click on delete
	[Arguments]    ${name}
	place cursor on    CollectionName
	Click on scroll up button    2    50
	${status}=    run keyword and return status    Click Element       xpath://*[contains(text(),'${name}')]
	IF    "${status}"=="False"
		FOR    ${i}    IN RANGE    0    200
			place cursor on    CollectionName
			Click on scroll down button    2    3
			${status}=    run keyword and return status    Element should be visible    xpath://*[contains(text(),'${name}')]
			Exit For Loop If     ${status} == True
		END		
		Click Element      xpath://*[contains(text(),'${name}')]
		
	END
	wait for page to load
	sleep    5s
	click on button    Delete Collection
	sleep    7s	  
    
close the delete popup using X symbol
	Wait Until Page Contains Element      xpath:(//label[@class="deleteCollectionOptions"])[1]    100
	Click element      xpath:(//label[@class="deleteCollectionOptions"])[1]
	wait for page to load
	capture page screenshot
	
verify that sync is done successfully
    ${status}=    get text    xpath:(//div[@class="sf-element-table-cell flex-justify-start flex-align-start \ sfc-value-cell sfpc-even-column sfpc-odd-row"])[2]
    Log    ${status}
    should not be empty    ${status}
    wait for page to load
	capture page screenshot
	
######################################## MR EQEV-110751 END ########################################

verify that the node has been updated in all other pages
	[Arguments]     ${Node}
	Wait Until Page Contains Element      xpath:(//div[@class="ComboBoxTextDivContainer"])[1]    1500
	Click element      xpath:(//div[@class="ComboBoxTextDivContainer"])[1]
	sleep    2
	Wait Until Page Contains Element      xpath:(((//div[@class="ScrollArea"])[5])//div[contains(text(),'TR-Report')])[1]    100
	Click element      xpath:(((//div[@class="ScrollArea"])[5])//div[contains(text(),'TR-Report')])[1]
	sleep    20
	click on the scroll down button    8    12
	sleep     2																   
	element should be visible    xpath:(//div[@class="sf-element-list-box-item sfpc-selected" and @title="${Node}"])
	sleep    5
	Wait Until Page Contains Element      xpath:(//div[@class="ComboBoxTextDivContainer"])[1]    100
	Click element      xpath:(//div[@class="ComboBoxTextDivContainer"])[1]
	sleep    2
	Wait Until Page Contains Element      xpath:(((//div[@class="ScrollArea"])[5])//div[contains(text(),'TR-Report')])[2]    100
	Click element      xpath:(((//div[@class="ScrollArea"])[5])//div[contains(text(),'TR-Report')])[2]
	sleep    20
	Check the Show Selection Panel checkbox
	sleep     1s  
	click on the scroll down button    8    12
	element should be visible    xpath:(//div[@class="sf-element-list-box-item sfpc-selected" and @title="${Node}"])
	sleep    5
	Wait Until Page Contains Element      xpath:(//div[@class="ComboBoxTextDivContainer"])[1]    100
	Click element      xpath:(//div[@class="ComboBoxTextDivContainer"])[1]
	sleep    2
	Wait Until Page Contains Element      xpath:(((//div[@class="ScrollArea"])[5])//div[contains(text(),'TR-Report')])[3]    100
	Click element      xpath:(((//div[@class="ScrollArea"])[5])//div[contains(text(),'TR-Report')])[3]
	sleep    20
	Check the Show Selection Panel checkbox
	sleep      1s								
	click on the scroll down button    8    12
	element should be visible    xpath:(//div[@class="sf-element-list-box-item sfpc-selected" and @title="${Node}"])
	wait for page to load
	capture page screenshot


	


verify that Data Source has proper value selected
	[Arguments]    ${dataSource}	
	element should be visible    xpath:(//div[@class="sf-element-text-box" and @title="${dataSource}"])
	wait for page to load
	capture page screenshot
	
verify that Object Aggregation has proper value selected
	[Arguments]    ${objectAggregation}	
	element should be visible    xpath:(//div[@class="sf-element-text-box" and @title="${objectAggregation}"])
	wait for page to load
	capture page screenshot
	
verify that the correct Node is selected
	[Arguments]    ${node}	
	element should be visible    xpath:(//div[@class="sf-element-list-box-item sfpc-selected" and @title="${node}"])
	wait for page to load
	capture page screenshot
	
verify that Preceding Period has proper value selected
	[Arguments]    ${period}
	element should be visible    xpath:(//div[@class="sf-element-text-box" and @title="${period}"])
	wait for page to load
	capture page screenshot
	
verify that Aggregation has proper value selected
	[Arguments]    ${aggregation}	
	element should be visible    xpath:(//div[@class="sf-element-text-box" and @title="${aggregation}"])
	wait for page to load
	capture page screenshot

Close Edit page
	Wait Until Page Contains Element      xpath: //input[@value="Close Report"]     timeout=1500
    Click Element    xpath: //input[@value="Close Report"]
    sleep    3
    Wait Until Page Contains Element      xpath:(//span[contains(text(),'OK') and @class="ui-button-text"])[2]     timeout=15
    Click Element    xpath:(//span[contains(text(),'OK') and @class="ui-button-text"])[2]
    sleep    5
	wait for page to load
	capture page screenshot
	

	
verify that an error occurred
	${text}=    get text    xpath:((//span[@id="dataAvailEdit"])//table//tbody//tr//td//p//span)
	Log    ${text}
	should contain    ${text}    Error: Please select at least one subnetwork
	wait for page to load
	capture page screenshot
	
install the PM Explorer R4A145 package
	${ps_file}    Set Variable    ${EXEC_DIR}\\ENIQ_TC_Automation\\NetAn\\Other\\Files\\installPMExplorerR4A145.ps1
	${result}=    Run    Powershell -NoProfile -ExecutionPolicy Unrestricted -Command "& {Start-Process PowerShell -ArgumentList '-NoProfile -ExecutionPolicy Unrestricted -File ""${ps_file}""' -Verb RunAs}";
	sleep    120
	
install the PM Explorer R5A08 package
	${ps_file}    Set Variable    ${EXEC_DIR}\\ENIQ_TC_Automation\\NetAn\\Other\\Files\\installPMExplorerR5A08.ps1
	${result}=    Run    Powershell -NoProfile -ExecutionPolicy Unrestricted -Command "& {Start-Process PowerShell -ArgumentList '-NoProfile -ExecutionPolicy Unrestricted -File ""${ps_file}""' -Verb RunAs}";
	sleep    120
	


verify that KeyError notification pops up
	sleep    5
	element should be visible    xpath:(//*[@title="Could not execute script 'FetchPMInformation': KeyError"])
	wait for page to load
	capture page screenshot

select object aggregation in edit page
	[Arguments]    ${objectAggregation}
	Wait Until Page Contains Element      xpath:(//div[@class="ComboBoxTextDivContainer"])[4]     timeout=1500
    Click Element    xpath:(//div[@class="ComboBoxTextDivContainer"])[4]
    sleep    3
    Wait Until Page Contains Element      xpath:(//div[@class="ListItems"])[5]//div[@title="${objectAggregation}"]     timeout=1500
    Click Element    xpath:(//div[@class="ListItems"])[5]//div[@title="${objectAggregation}"]
	wait for page to load
	capture page screenshot
	
	
verify that the calculated column is added to the report
	Mouse Over      xpath://div[text()='DATE_ID']
	click on the scroll right button     0    50
	element should be visible    xpath://div[contains(text(),'calculatedColumn')]
	wait for page to load
	capture page screenshot
	
######################################################### MR EQEV-109561 #########################################################
	
Click on the Access drop down button
	Wait Until Page Contains Element    xpath:(//div[@class='ComboBoxTextDivContainer'])[4]
	Click element    xpath:(//div[@class='ComboBoxTextDivContainer'])[4]
	sleep    3
	element should be visible    xpath:(//div[contains(text(),'Public')])
	element should be visible    xpath:(//div[contains(text(),'Private')])
	wait for page to load
	capture page screenshot 
	
verify that the dropdown is disabled
	wait Until Page Contains Element    xpath:(//*[@id="accesstype"])
	${status}=    run keyword and return status    Click element    xpath:(//*[@id="accesstype"])
	Log    ${status}
	wait for page to load
	capture page screenshot 
	
Verify the Access Type warning Message is Visible
	wait Until Page Contains Element    xpath:(//span[contains (text(),'The access type cannot be changed as the')])
	wait Until Page Contains Element    xpath:(//span[contains (text(),'The access type cannot be changed as the')])
	wait Until Page Contains Element    xpath:(//span[contains (text(),'The access type cannot be changed as the')])
	wait for page to load
	capture page screenshot 
	
Select Access Type
    [Arguments]    ${access_type}=Private
    Click on Scroll down button      6       5
	Wait Until Page Contains Element    xpath:(//div[@class='ComboBoxTextDivContainer'])[4]
	Click element    xpath:(//div[@class='ComboBoxTextDivContainer'])[4]
	sleep    3
	element should be visible    xpath://div[@title='${access_type}']
	Click element    xpath://div[@title='${access_type}']
	wait for page to load
	capture page screenshot 
	
Open pm explorer analysis with another user
    [Arguments]    ${user_name}=Administrator1	   ${password}=Ericsson01
    ${chrome_options}=    Evaluate    sys.modules['selenium.webdriver'].ChromeOptions()      sys
	#Call Method    ${chrome_options}    add_argument    --incognito
	Call Method    ${chrome_options}    add_argument    --ignore-certificate-errors
	Create Webdriver    Chrome    options=${chrome_options}
    Go To    ${base_url}   
    Maximize Browser Window
    Sleep    5
	Selenium2Library.Input Text    xpath:${username_xpath}     ${user_name}
    Selenium2Library.Input Text    xpath:${password_xpath}    ${password}
    Click Element    xpath:${loginButton_xpath}  
    Sleep    5
    Go To    ${base_url}${pmex_url}
	sleep    10
    ${IsElementVisible}=    Run Keyword And Return Status    Element Should not be Visible    xpath://div[contains(text(),'Missing Data')]
	Run Keyword If    ${IsElementVisible} is ${FALSE}   Close missing data window
					  
    Wait Until Page Contains Element      xpath: //input[@value='Report Manager']     timeout=1500
	wait for page to load
    capture page screenshot
    
verify that the warning message is not visible
	element should not be visible    xpath:(//span[contains (text(),'The access type cannot be changed as the')])
	wait for page to load
	capture page screenshot
	
Verify The Access Type Is Public By Default
	element should be visible    xpath:(//div[@title="Public"])
	wait for page to load
	capture page screenshot 
	
Drag and select the Access Type Options
	drag and drop    xpath:(((//div[@class="ListItems"])[3])//div[@title="Public"])    xpath:(((//div[@class="ListItems"])[3])//div[@title="Private"])
	sleep    6
	element should be visible    xpath:(//div[@title="Public"])
	wait for page to load
	capture page screenshot
	wait for page to load
	capture page screenshot
	
######################################################### MR EQEV-109561 END #########################################################

Suite teardown steps
    Close Spotfire Application
    sleep    2
    
Suite setup steps
    Selenium2Library.Set Screenshot Directory   ./Screenshots   
    
close the certificate prompt
    sleep    10
	press keyboard button    '{TAB}'
	sleep    5
	press keyboard button    '{ENTER}'
	
open search prompt and search for
	[Arguments]    ${text}
	sleep    5    
    open search prompt
	enter text    ${text}
	sleep    4
	press keyboard button    '{ENTER}'
	sleep    5
	
read an return the output
	sleep    30
	RPA.Windows.Click  id:outputTextBox
	sleep    4
	copy and paste output
	${spotfireOutput}=    OperatingSystem.get file    ${EXEC_DIR}\\SpotfireOutput.txt
	Log    ${spotfireOutput}
	[Return]    ${spotfireOutput}
	
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
	selenium2library.capture page screenshot
	
go to document properties and run the script
	[Arguments]    ${script}	
	control window    Document Properties
	sleep    5
	RPA.Windows.Click   name:Properties
	control window    Document Properties
	sleep    4
	RPA.Windows.Click  id:scriptButton
	sleep    4
	control window    Script – Act on Property Change
	sleep    4
	RPA.Windows.Click  id:useScriptRadioButton
	sleep    5
	RPA.Windows.Click  id:newButton
	sleep    4
	control window    New Script
	RPA.Windows.Click  id:wrapInTransactionCheckbox
	sleep    4
	RPA.Windows.Click  id:nameTextBox
	click button multiple times    {TAB}    3
	paste the text    ${script}
    RPA.Desktop.Clear Clipboard
	sleep    4
	RPA.Windows.Click  id:runButton
	sleep    10
	
place cursor on
	[Arguments]    ${text}
	mouse over    xpath://*[contains(text(),'${text}')]
	wait for page to load
	capture page screenshot
	
Click on maximise window button
    [Arguments]    ${button}
    @{element}=    Get WebElements	    xpath: //div[@title='Maximize visualization']
    ${max_button}=        Get from list     ${element}     ${button}
    Click element     ${max_button}
    
Navigate to the section
    [Arguments]     ${section}
	${count}=       set variable      0
	place cursor on    Node Selection Manager
	Click on maximise window button    2
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
Connect to Failed DB
    @{element}=    Get WebElements	    xpath: //input[@class='sf-element sf-element-control sfc-property sfc-text-box']
    ${name}=        Get from list     ${element}    0
    ${username}=        Get from list     ${element}    1
    ${password}=        Get from list     ${element}    2
    ${eniqs}=        Get from list     ${element}    3
    Selenium2Library.Input Text    ${name}       localhost 
    Sleep     1s
    Selenium2Library.Input Text    ${username}       netanserver
    Sleep     1s
    Selenium2Library.Input Text    ${password}       Ericsson01 
    Sleep     1s
    Click element     xpath: //input[@id='a49e8a2e448349398408b044a165fee5']
    Sleep     10s
    FOR    ${i}    IN RANGE    0     5
         ${text}=      Selenium2Library.Get text      xpath://span[@id='a78fbda81332476ab91b65a4b88dad30']
         IF    '${text}'=='Connection OK'
               Exit For Loop
         ELSE IF     '${text}'=='please provide Value for: NetAn SQL DB URL'
               Selenium2Library.Input Text    ${name}       localhost               
         ELSE IF     '${text}'=='please provide Value for: NetAn User Name'
               Selenium2Library.Input Text    ${username}       netanserver       
         ELSE IF       '${text}'=='please provide Value for: NetAn Password'
               Selenium2Library.Input Text    ${password}       Ericsson01 
         END
         Sleep     1s
         Click element     xpath: //input[@id='a49e8a2e448349398408b044a165fee5']
         Sleep     10s
    END    
    FOR    ${i}    IN RANGE    0     5
          Clear Element Text      ${eniqs}
          Selenium2Library.Input Text    ${eniqs}       Failed_ODBC         
    END       
    Sleep    3s
    Click element     xpath: //input[@id='075d5400a00740b1b64261f11e3d4f27']    
    Sleep    10s
    wait for page to load
	capture page screenshot			

verify that the connection failed for Multiple datasource
	${text1}=    Selenium2Library.get text 	xpath:((//tr[@id="table-data"])[2]//td[6])
	Log    ${text1}
	should contain    ${text1}    Failed_ODBC
	should contain    ${text1}    Failed
	wait for page to load
	capture page screenshot	


click on Measure Selection button
    Wait Until Page Contains Element      xpath://*[@value="Measure Selection"]     timeout=15
    Click Element      xpath://*[@value="Measure Selection"]
    wait for page to load
    click on the scroll down button    7    12
    wait for page to load
    capture page screenshot



select the table ENIQDatasources in visualization
    [Arguments]    ${button}
    Click Element      xpath://div[@class="sf-element sf-element-button"][1]
    Click Element      xpath://div[@class="contextMenuItem"][${button}]
	wait for page to load
	capture page screenshot	
################################################ TEST COVERAGE GAPS ################################################

verify that the edit and delete buttons are enabled
	wait for page to load
	Element Should Be Enabled    xpath://*[@value="Edit Collection"]
	sleep    5
	Element Should Be Enabled    xpath://*[@value="Delete Collection"]
	wait for page to load
	capture page screenshot
	
verify that if collections are not selected edit and delete buttons are disabled
	wait for page to load
	Element Should not Be visible    xpath://*[@value="Edit Collection"]   
	sleep    5
	Element Should not Be visible    xpath://*[@value="Delete Collection"]
	wait for page to load
	capture page screenshot	

verify that the home icon is visible
	element should be visible    xpath:(//img[@class="sf-element sf-element-control sfc-action sfc-action-image"])
	Sleep    10s
    wait for page to load
	capture page screenshot	

Verify Flex filter values appear in the listbox
    wait for page to load
    Click on scroll down button     17    26
    ${result}=       Get Element Count     xpath://span[@id='hideflexaddbutton']
    IF    ${result}==1
        click on scroll up button     17    12
        capture page screenshot 
    ELSE
        Log      ${result} 
    END
	
verify that the SubNetwork List is empty
	Click on Collection Manager button
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
	
verify that the SubNetwork List is not empty
	Click on Collection Manager button
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
	
verify that the node is present in Selected Nodes list
	[Arguments]    ${node}
	Wait Until Page Contains Element      xpath:(//div[@class="sf-element-list-box sfc-scrollable"])[2]     timeout=1500
	${text1}=    Selenium2Library.get text    xpath:(//div[@class="sf-element-list-box sfc-scrollable"])[2]
	Log    ${text1}
	should contain    ${text1}    ${node}
	wait for page to load
	capture page screenshot
	
validate that the Add and Remove buttons are disabled
	Click on scroll down button    5    20
	Wait Until Page Contains Element      xpath:(//*[@value="Add >>"])     timeout=1500
	element should not be visible      xpath:(//*[@value="Add >>"])
	Wait Until Page Contains Element      xpath:(//*[@value="<< Remove"])     timeout=1500
	element should not be visible      xpath:(//*[@value="<< Remove"])
	wait for page to load
	capture page screenshot
	
validate that the Add and Remove buttons are enabled
	Wait Until Page Contains Element      xpath:(//*[@value="Add >>"])     timeout=1500
	element should be enabled      xpath:(//*[@value="Add >>"])
	Wait Until Page Contains Element      xpath:(//*[@value="<< Remove"])     timeout=1500
	element should be enabled      xpath:(//*[@value="<< Remove"])
	wait for page to load
	capture page screenshot
	
verify that the row count is 0 and Create button is disabled
	Wait Until Page Contains Element      xpath:(//div[@class="ScrollArea"])[2]     timeout=1500
	${text}=    Selenium2Library.get text    xpath:(//div[@class="ScrollArea"])[2]
	Log    ${text}
	should contain    ${text}    0 values
	Wait Until Page Contains Element      xpath:(//*[@value="Save"])     timeout=1500
	element should not be visible    xpath:(//*[@value="Save"])
	wait for page to load
	capture page screenshot
	
verify that the row count is not 0 and Create button is enabled
	Wait Until Page Contains Element      xpath:(//div[@class="ScrollArea"])[2]     timeout=1500
	${text}=    Selenium2Library.get text    xpath:(//div[@class="ScrollArea"])[2]
	Log    ${text}
	should not contain    ${text}    0 values
	Wait Until Page Contains Element      xpath:(//*[@value="Save"])     timeout=1500
	element should be enabled    xpath:(//*[@value="Save"])
	wait for page to load
	capture page screenshot
	
select a created collection and verify that nodes are displayed
	place cursor on    NodeNameORExpression
	sleep    2
	Click on maximise window button    1
	wait for page to load
	Wait Until Page Contains Element      xpath:(//div[@class="valueCellsContainer"])     timeout=1500
	sleep    2s
	${text1}=    Selenium2Library.get text    xpath:(//div[@class="valueCellsContainer"])
	Log    ${text1}
	sleep    2
	should not be equal    ${text1}    ${EMPTY}
	place cursor on    NodeNameORExpression
	sleep    2
    click on the button    Restore visualization layout
	wait for page to load
	capture page screenshot
	
verify that Add, Remove, Fetch nodes and Import nodes from File buttons are disabled
	Wait Until Page Contains Element      xpath://*[@value='Add >>']     timeout=1500
	element should not be visible      xpath://*[@value='Add >>']
	Wait Until Page Contains Element      xpath://*[@value='<< Remove']     timeout=1500
	element should not be visible      xpath://*[@value='<< Remove']
	Wait Until Page Contains Element      xpath://*[@value='Fetch nodes']     timeout=1500
	element should not be visible      xpath://*[@value='Fetch nodes']
	Wait Until Page Contains Element      xpath://*[@value='Import nodes from File']     timeout=1500
	element should not be visible      xpath://*[@value='Import nodes from File']
	wait for page to load
	capture page screenshot
	
Verify the error connection status message with empty name/URL
	@{element}=    Get WebElements	    xpath: //input[@class='sf-element sf-element-control sfc-property sfc-text-box']
    ${name}=        Get from list     ${element}    0
    Selenium2Library.Input Text    ${name}       ${EMPTY}
    Sleep     1s
    Click element     xpath: //input[@id='a49e8a2e448349398408b044a165fee5']
    Sleep     10s
    wait for page to load
	element should be visible     xpath://*[contains(text(),' please provide Value for: NetAn SQL DB URL')]
	wait for page to load
	capture page screenshot  
	
Verify the error connection status message with empty username
	@{element}=    Get WebElements	    xpath: //input[@class='sf-element sf-element-control sfc-property sfc-text-box']
    ${username}=        Get from list     ${element}    1
    Selenium2Library.Input Text    ${username}       ${EMPTY} 
    Sleep     1s
    Click element     xpath: //input[@id='a49e8a2e448349398408b044a165fee5']
    Sleep     10s
	element should be visible     xpath://*[contains(text(),'please provide Value for: NetAn User Name')]
	wait for page to load
	capture page screenshot
	
Verify the error connection status message with empty password
	@{element}=    Get WebElements	    xpath: //input[@class='sf-element sf-element-control sfc-property sfc-text-box']
    ${password}=        Get from list     ${element}    2
    Selenium2Library.Input Text    ${password}       ${EMPTY}  
    Sleep     1s
    Click element     xpath: //input[@id='a49e8a2e448349398408b044a165fee5']
    Sleep     10s  
    wait for page to load
	element should be visible     xpath://*[contains(text(),' please provide Value for: NetAn Password')]
	wait for page to load
	capture page screenshot

Verify Connection status column of single ENIQ Datasource for failed connection
    @{element}=    Get WebElements	    xpath: //input[@class='sf-element sf-element-control sfc-property sfc-text-box']
    ${name}=        Get from list     ${element}    0
    ${username}=        Get from list     ${element}    1
    ${password}=        Get from list     ${element}    2
    ${eniqs}=        Get from list     ${element}    3
    Selenium2Library.Input Text    ${name}       localhost 
    Sleep     1s
    Selenium2Library.Input Text    ${username}       netanserver
    Sleep     1s
    Selenium2Library.Input Text    ${password}       Ericsson01 
    Sleep     1s
    Click element     xpath: //input[@id='a49e8a2e448349398408b044a165fee5']
    Sleep     10s
    FOR    ${i}    IN RANGE    0     5
         ${text}=      Selenium2Library.Get text      xpath://span[@id='a78fbda81332476ab91b65a4b88dad30']
         IF    '${text}'=='Connection OK'
               Exit For Loop
         ELSE IF     '${text}'=='please provide Value for: NetAn SQL DB URL'
               Selenium2Library.Input Text    ${name}       localhost
               
         ELSE IF     '${text}'=='please provide Value for: NetAn User Name'
               Selenium2Library.Input Text    ${username}       netanserver     
    
         ELSE IF       '${text}'=='please provide Value for: NetAn Password'
               Selenium2Library.Input Text    ${password}       Ericsson01 
         END
         Sleep     1s
         Click element     xpath: //input[@id='a49e8a2e448349398408b044a165fee5']
         Sleep     10s
    END    
    FOR    ${i}    IN RANGE    0     5
          Clear Element Text      ${eniqs}
          Selenium2Library.Input Text    ${eniqs}       Failed_ODBC           
    END       
    Sleep    3s
    Click element     xpath: //input[@id='075d5400a00740b1b64261f11e3d4f27']    
    Sleep    60s 
    element should be visible    xpath://*[contains(text(),'Failed to connect with: Failed_ODBC')]
    wait for page to load
    capture page screenshot 
    
Verify connection status column is successful and ENIQ input field is empty
	sleep    30
	${text}=    Selenium2Library.get text   xpath:(//input[@class="sf-element sf-element-control sfc-property sfc-text-box"])[4]
	Log    ${text}
	should contain    ${text}    ${EMPTY}
	sleep    5
	element should be visible    xpath://div[contains(text(),'Connected')]
	wait for page to load
    capture page screenshot

verify connection status in ENIQ Datasource
	element should be visible    xpath:(//div[@class="sf-element-table-cell flex-justify-start flex-align-end \ sfc-column-header sfpc-level-1 sfpc-level-last sfpc-odd-column" and @row="1" and @column="0"])
	${status}=    get text    xpath:(//div[@class="sf-element-table-cell flex-justify-start flex-align-start \ sfc-value-cell sfpc-odd-column sfpc-odd-row" and @row="1" and @column="2"])
	Log    ${status}
	should contain    ${status}    Connected
	wait for page to load
	capture page screenshot

connect to the database with empty DataSource
    @{element}=    Get WebElements	    xpath: //input[@class='sf-element sf-element-control sfc-property sfc-text-box']
    ${name}=        Get from list     ${element}    0
    ${username}=        Get from list     ${element}    1
    ${password}=        Get from list     ${element}    2
    ${eniqs}=        Get from list     ${element}    3
    FOR    ${i}    IN RANGE    0     5
          Clear Element Text      ${eniqs}
          Selenium2Library.Input Text    ${eniqs}       ${EMPTY}           
    END       
    Sleep    3s
    Click element     xpath: //input[@id='075d5400a00740b1b64261f11e3d4f27']    
    Sleep    60s      //wait time for ENIQ DB connection
    wait for page to load
    capture page screenshot 

verify that LastSuccessfulSync column is empty before sync with ENIQ
	element should be visible    xpath:(//div[@class="sf-element-table-cell flex-justify-start flex-align-end \ sfc-column-header sfpc-level-1 sfpc-level-last sfpc-even-column" and @row="0" and @column="3"])
	${status}=    get text    xpath:(//div[@class="sf-element-table-cell flex-justify-start flex-align-start \ sfc-value-cell sfpc-even-column sfpc-odd-row" and @row="1" and @column="3"])
	Log    ${status}
	should be equal    ${status}    ${EMPTY}
	wait for page to load
    capture page screenshot 

verify that Remove button is enabled for single selection in DataSources
	Wait Until Page Contains Element    xpath:(//div[@class="sf-element-table-cell flex-justify-start flex-align-start \ sfc-value-cell sfpc-odd-column sfpc-odd-row"])[1]   timeout=1500
	click element    xpath:(//div[@class="sf-element-table-cell flex-justify-start flex-align-start \ sfc-value-cell sfpc-odd-column sfpc-odd-row"])[1]
	Click on the scroll down button    4    5
	Wait Until Page Contains Element    xpath:(//input[@value="Remove"])[2]    timeout=1500
	element should be enabled    xpath:(//input[@value="Remove"])[2]
	wait for page to load
    capture page screenshot 

verify that Remove button is disabled for multiple selections in DataSources
	Wait Until Page Contains Element    xpath:(//div[@class="sf-element-table-cell flex-justify-start flex-align-start \ sfc-value-cell sfpc-odd-column sfpc-odd-row"])[1]   timeout=1500
	click element    xpath:(//div[@class="sf-element-table-cell flex-justify-start flex-align-start \ sfc-value-cell sfpc-odd-column sfpc-odd-row"])[1]
	sleep    2
	Wait Until Page Contains Element    xpath:(//div[@class="sf-element-table-cell flex-justify-start flex-align-start \ sfc-value-cell sfpc-odd-column sfpc-even-row"])[1]   timeout=1500
	click element    xpath:(//div[@class="sf-element-table-cell flex-justify-start flex-align-start \ sfc-value-cell sfpc-odd-column sfpc-even-row"])[1]    modifier=CTRL
	Click on the scroll down button    4    5
	Wait Until Page Contains Element    xpath:(//input[@value="Remove"])[2]    timeout=1500
	click element    xpath:(//input[@value="Remove"])[2]
	Wait Until Page Contains Element    xpath://label[@class="deleteconnectiontitle" and contains(text(),'Delete Connection')]   timeout=1500
	Element should not be visible    xpath://label[@class="deleteconnectiontitle" and contains(text(),'Delete Connection')]
	wait for page to load
    capture page screenshot	

Verify the Access type is displays Private collection for User
    [Arguments]         ${collName}
	place cursor on    CollectionName
	Click on scroll up button    2    50
	${status}=    run keyword and return status    Click Element       xpath://*[contains(text(),'${collName}')]
	IF    "${status}"=="False"
		FOR    ${i}    IN RANGE    0    50
			place cursor on    CollectionName
			Click on scroll down button    2    3
			${status}=    run keyword and return status    Element should be visible    xpath://*[contains(text(),'${collName}')]
			Exit For Loop If     ${status} == True
		END		
		Click Element      xpath://*[contains(text(),'${collName}')]		
	END
	sleep    5s
	${row}=       Get Element Attribute            xpath://div[text()='${collName}']/..       row
	${AccessType}=    Get text    xpath:(//div[@row="${row}" and @column="4"])
	Log    ${AccessType} 
	Should contain    ${AccessType}    Private
	wait for page to load
	capture page screenshot
	
Verify the Access type is Public for the Last Collection created
	[Arguments]         ${collName}
	place cursor on    CollectionName
	Click on scroll up button    2    50
	${status}=    run keyword and return status    Click Element       xpath://*[contains(text(),'${collName}')]
	IF    "${status}"=="False"
		FOR    ${i}    IN RANGE    0    50
			place cursor on    CollectionName
			Click on scroll down button    2    3
			${status}=    run keyword and return status    Element should be visible    xpath://*[contains(text(),'${collName}')]
			Exit For Loop If     ${status} == True
		END		
		Click Element      xpath://*[contains(text(),'${collName}')]		
	END
	sleep    5s
	${row}=       Get Element Attribute            xpath://div[text()='${collName}']/..       row
	${AccessType}=    Get text    xpath:(//div[@row="${row}" and @column="4"])
	Log    ${AccessType}
	wait for page to load
	capture page screenshot	
	
Verify the Warning message Is Visible on Save Report Page
	element should be visible    xpath:(//*[contains(text(),'Report access type must be private when')])
	element should be visible    xpath:(//*[contains(text(),'a private collection has been used within')])
	element should be visible    xpath:(//*[contains(text(),'the report.')])
	wait for page to load
	capture page screenshot
	
Verify that the dropdown is disabled in Save report
	wait Until Page Contains Element    xpath:(//*[@id="reportaccesstype"])
	${status}=    run keyword and return status    Click element    xpath:(//*[@id="reportaccesstype"])
	Log    ${status}
	should be equal     '${status}'     'False'										
	wait for page to load
	capture page screenshot

verify that error message "Collection name already exists" is displayed
	Wait Until Page Contains Element      xpath://span[contains(text(),'Collection name already exists')]    timeout=1500
	element should be visible    xpath://span[contains(text(),'Collection name already exists')]
	capture page screenshot
	
click on Cancel button on Collection Creation page
	Wait Until Page Contains Element      xpath://*[@value="Cancel"]     timeout=1500
	Click Element    xpath://input[@value="Cancel"]
	wait for page to load
	capture page screenshot
	
validate that collection gets created after name correction
	Click on scroll up button    3    12
	${collectionName}=    Enter the Collection name for edit in dynamic collection
	click on button    Save
	validate the page title    Manage Collection
	wait for page to load
	capture page screenshot
									 
Enter Collection name
    [Arguments]    ${collectionName}
	Clear Element Text      xpath://input[contains(@class,'sf-element sf-element-control sfc-property sfc-text-box')]
	${currDate}=    Get current date
	sleep    2s			  
    Selenium2Library.Input Text     xpath://input[contains(@class,'sf-element sf-element-control sfc-property sfc-text-box')]    ${collectionName}
	sleep     2s
	Click on scroll down button    6    1
	Click on scroll up button    6    1
	FOR    ${i}    IN RANGE    0     5
         ${text}=         Get Element Attribute        xpath:(//input[contains(@class,'sf-element sf-element-control sfc-property sfc-text-box')])[1]         value
         IF    '${text}'=='${collectionName}'
               Exit For Loop
         ELSE 
		        Clear Element Text      xpath:(//input[contains(@class,'sf-element sf-element-control sfc-property sfc-text-box')])[1]
				Sleep     1s
				Selenium2Library.Input Text     xpath:(//input[contains(@class,'sf-element sf-element-control sfc-property sfc-text-box')])[1]    ${collectionName}
				Click on scroll down button    6    1
				Click on scroll up button    6    1
				Sleep      1s
         	END
   	 END   	
    #press keys      xpath:(//input[contains(@class,'sf-element sf-element-control sfc-property sfc-text-box')]     ENTER
    [Return]    ${collectionName}
	wait for page to load
	capture page screenshot
	
verify alert message if System Area is not selected
	Wait Until Page Contains Element      xpath:((//span[@id="systemAreaRequired"])//span[contains(text(),'Select System Area')])	 timeout=300
	element should be visible    xpath:((//span[@id="systemAreaRequired"])//span[contains(text(),'Select System Area')])
	wait for page to load
	capture page screenshot
	
verify alert message if Node Type is not selected
	Wait Until Page Contains Element      xpath:((//span[@id="nodeTypeRequired"])//span[contains(text(),'Select Node Type')])	 timeout=300
	element should be visible    xpath:((//span[@id="nodeTypeRequired"])//span[contains(text(),'Select Node Type')])
	capture page screenshot
	
Verify if all fields are empty when opening measure selection page
    element should be visible     xpath:(//div[text()="---" and @class="sf-element-text-box"])[1]
    element should be visible     xpath:(//div[text()="---" and @class="sf-element-text-box"])[2]
    element should be visible     xpath:(//div[text()="---" and @class="sf-element-text-box"])[3]
    element should be visible     xpath:(//div[text()="---" and @class="sf-element-text-box"])[4]
    Click on scroll down button    6    8
    element should be visible     xpath:(//div[text()="---" and @class="sf-element-text-box"])[5]
    Click on scroll down button    9    4
    element should be visible     xpath:(//div[contains(text(),'(All) 0 values')])[4]
    element should be visible     xpath:(//div[text()="---" and @class="sf-element-text-box"])[6]
    element should be visible     xpath:(//div[text()="---" and @class="sf-element-text-box"])[7]
    Click on scroll up button    9    4
    Click on scroll up button    6    8
    wait for page to load
    capture page screenshot
	
Verify if node type is present for all system areas
    Click element     xpath:(//div[@class='ComboBoxTextDivContainer'])[2]
    Click element    xpath://div[@title="Core"]
    sleep  3s
    Click element     xpath:(//div[@class='ComboBoxTextDivContainer'])[3]
    element should be visible    xpath://div[@title="CCDM"]
    Click element     xpath:(//div[@class='ComboBoxTextDivContainer'])[2]
	Click element    xpath://div[@title="Radio"]
    sleep  5s
    Click element     xpath:(//div[@class='ComboBoxTextDivContainer'])[3]
	element should be visible    xpath://div[@title="ERBS"]
    Click element     xpath:(//div[@class='ComboBoxTextDivContainer'])[2]
	Click element    xpath://div[@title="Transport"]
    sleep  5s
    Click element     xpath:(//div[@class='ComboBoxTextDivContainer'])[3]
	element should be visible    xpath://div[@title="ESC"]
    wait for page to load
	capture page screenshot
	
Verify if all fields without selecting data source
    Click element     xpath:(//div[@class='ComboBoxTextDivContainer'])[2]
	element should not be visible    xpath://div[@title="Core"]
    Click element     xpath:(//div[@class='ComboBoxTextDivContainer'])[3]
	element should not be visible    xpath://div[@title="CCDM"]
	element should not be visible    xpath://div[@title="ERBS"]
	element should not be visible    xpath://div[@title="ESC"]
    Click on scroll down button    6    8
    Click element     xpath:(//div[@class='ComboBoxTextDivContainer'])[5]
	element should not be visible    xpath://div[@title="No Aggregation"]
	Click on scroll up button    6    8
    wait for page to load
	capture page screenshot
	
Verify if all fields are empty message is displayed
    element should be visible     xpath://span[contains(text(),'Select ENIQ data source')]
    element should be visible     xpath://span[contains(text(),'Select System Area')]
    element should be visible     xpath://span[contains(text(),'Select Node Type')]
	Click on scroll down button    6    8
    element should be visible     xpath://span[contains(text(),'Select Nodes')]
    element should be visible     xpath://span[contains(text(),'Select Object Aggregation')]
    element should be visible     xpath://span[contains(text(),'Select Period')]
    element should be visible     xpath://span[contains(text(),'Select Aggregation')]
	Click on scroll up button    6    8
	Select Get Data For    Node(s)
    Click on scroll down button    6    8
	element should not be visible    xpath://input[@value='Refresh Nodes'][1]
	Click on scroll up button    6    8
	Select Get Data For    Network
    wait for page to load
	capture page screenshot
	
Verify if all fields are empty when the value of ENIQ data source is changed
    [Arguments]    ${data_source_01}    ${data_source_02}
    Select ENIQ DataSource    ${data_source_02}
    sleep  50s
    element should be visible     xpath://span[contains(text(),'Select System Area')]
    element should be visible     xpath://span[contains(text(),'Select Node Type')]
	Select ENIQ DataSource    ${data_source_01}
	sleep  3s
    wait for page to load
	capture page screenshot
	
Verify if all fields are empty when the value of System Area dropdown is changed
    [Arguments]    ${sys_area_01}    ${sys_area_02}
    Select the System area    ${sys_area_02}
    sleep  3s
    element should be visible     xpath://span[contains(text(),'Select Node Type')]
    Click on scroll down button    9    4
    element should be visible     xpath:(//div[contains(text(),'(All) 0 values')])[4]
	Click on scroll up button    9    4
	Select the System area    ${sys_area_01}
    sleep  3s
    wait for page to load
	capture page screenshot
	
Select KPIs and verify fetch pm data button
	[Arguments]    ${kpi_list}
	@{list}=      Split string      ${kpi_list}     ,  
    FOR    ${kpi}    IN    @{list}
           Clear Element Text      xpath://input[contains(@class,'sf-element sf-element-input sf-input-with-placeholder')]
           Selenium2Library.Input Text     xpath://input[contains(@class,'sf-element sf-element-input sf-input-with-placeholder')]     ${kpi} 
           press key      xpath://input[contains(@class,'sf-element sf-element-input sf-input-with-placeholder')]     \\13
           sleep    5s
           
           @{element}=    Get WebElements      xpath://div[@name='valueCellCanvas']//div[@row='1' and @column='0']
           ${ele}=        Get from list     ${element}    0
           Click element      ${ele}      
           sleep   2s
	       element should not be visible    xpath:(//input[@value='Fetch PM Data'])[1]
           Click element      xpath://input[@value='>>'] 
           sleep   5s
	       element should not be visible    xpath:(//input[@value='Fetch PM Data'])[1]
           wait for page to load
	   Capture page screenshot
     END

Select System area and verify the contents
    [Arguments]     ${sys_area}
    sleep  3s      #3 seconds given for syatem area to load based on selected data source
    @{element}=    Get WebElements	    xpath: //div[@class='ComboBoxTextDivContainer']
    ${sys_area_ele}=        Get from list     ${element}    1
    Wait Until Element Is Visible        ${sys_area_ele}
	Click element     ${sys_area_ele}
    sleep  3s
	element should be visible     xpath://div[@title="Core"]
	element should be visible     xpath://div[@title="Radio"]
	element should be visible     xpath://div[@title="Transport"]
    Click element      xpath://div[@title='${sys_area}']
	wait for page to load				  
    element should not be visible    xpath:((//span[@style= "COLOR: #fa7864"])[1])//span[contains(text(),'Select System Area')]
	capture page screenshot
	
Select Aggregation and verify the contents
    [Arguments]     ${Aggregation}
    Click on scroll down button    6     25         
    @{element}=    Get WebElements	    xpath: //div[@class='ComboBoxTextDivContainer']
    ${Aggregation_ele}=        Get from list     ${element}    4
    Click element     ${Aggregation_ele}
    Sleep    3s
	element should be visible     xpath://div[@title="No Aggregation"]
	element should be visible     xpath://div[@title="Node"]
	element should be visible     xpath://div[@title="All Selected"]
    Click element      xpath://div[@class='sf-element-dropdown-list-item'][@title='${Aggregation}']
    Sleep    5s
    wait for page to load
    capture page screenshot
	
Select Get Data For and verify the contents
    [Arguments]     ${get_data_for}
	Click on scroll down button    6     5
	Sleep      10s
    @{element}=    Get WebElements	    xpath: //div[@class='ComboBoxTextDivContainer']
    ${node_type_ele}=        Get from list     ${element}    3
    Click element     ${node_type_ele}
    sleep  2s
	element should be visible     xpath://div[@title="Node(s)"]
	element should be visible     xpath://div[@title="Collection"]
	element should be visible     xpath://div[@title="Network"]
	element should be visible     xpath://div[@title="SubNetwork" and @class="sf-element-dropdown-list-item"]
    click element       xpath:(//div[@class="sf-element-dropdown-list-item" and @title="${get_data_for}"])
	sleep  2s
	element should be enabled    xpath:(//input[@value="Refresh Nodes"])[2]
	IF    '${get_data_for}'=='Node(s)'
          element should be visible     xpath://font[contains(text(),'Nodes')]
    ELSE IF     '${get_data_for}'=='Collection'
          element should be visible     xpath://font[contains(text(),'Collections')]
    ELSE IF     '${get_data_for}'=='SubNetwork'
          element should be visible     xpath://font[contains(text(),'SubNetwork')]
    END
    Sleep     1s
	wait for page to load    
	capture page screenshot

Select multiple nodes
    [Arguments]    ${node_list_01}    ${node_list_02}
    Click on scroll down button     6    5
    @{list_01}=      Split string      ${node_list_01}    ,
     FOR    ${node}    IN    @{list_01}
           Clear Element Text      xpath://input[contains(@class,'SearchInput sf-element-input sf-suppress-forms-accept-command sf-suppress-forms-cancel-command sf-input-with-placeholder')]
           Selenium2Library.Input Text     xpath://input[contains(@class,'SearchInput sf-element-input sf-suppress-forms-accept-command sf-suppress-forms-cancel-command sf-input-with-placeholder')]     ${node} 
           press key      xpath://input[contains(@class,'SearchInput sf-element-input sf-suppress-forms-accept-command sf-suppress-forms-cancel-command sf-input-with-placeholder')]     \\13
           sleep    2s
           wait for page to load
           Click element      xpath://div[@title='${node}']      modifier=CTRL
           sleep   1s
           wait for page to load
           Capture page screenshot
     END
    @{list_02}=      Split string      ${node_list_02}    ,
	 FOR    ${node}    IN    @{list_02}
           Clear Element Text      xpath://input[contains(@class,'SearchInput sf-element-input sf-suppress-forms-accept-command sf-suppress-forms-cancel-command sf-input-with-placeholder')]
           Selenium2Library.Input Text     xpath://input[contains(@class,'SearchInput sf-element-input sf-suppress-forms-accept-command sf-suppress-forms-cancel-command sf-input-with-placeholder')]     ${node} 
           press key      xpath://input[contains(@class,'SearchInput sf-element-input sf-suppress-forms-accept-command sf-suppress-forms-cancel-command sf-input-with-placeholder')]     \\13
           sleep    2s
           wait for page to load
           Click element      xpath://div[@title='${node}']      modifier=CTRL
           sleep    2s
           Clear Element Text      xpath://input[contains(@class,'SearchInput sf-element-input sf-suppress-forms-accept-command sf-suppress-forms-cancel-command sf-input-with-placeholder')]
           sleep    3s
		   wait for page to load
           Capture page screenshot
     END

Select multiple subnetwork
    [Arguments]    ${node_list_01}    ${node_list_02}
    Click on scroll down button     6    5
    @{list_01}=      Split string      ${node_list_01}    ,
     FOR    ${node}    IN    @{list_01}
           Clear Element Text      xpath:(//input[contains(@class,'SearchInput sf-element-input sf-suppress-forms-accept-command sf-suppress-forms-cancel-command sf-input-with-placeholder')])[3]
           Selenium2Library.Input Text     xpath:(//input[contains(@class,'SearchInput sf-element-input sf-suppress-forms-accept-command sf-suppress-forms-cancel-command sf-input-with-placeholder')])[3]     ${node} 
           press key      xpath:(//input[contains(@class,'SearchInput sf-element-input sf-suppress-forms-accept-command sf-suppress-forms-cancel-command sf-input-with-placeholder')])[3]     \\13
           sleep    2s
           wait for page to load
           Click element      xpath://div[@title='${node}']      modifier=CTRL
           sleep   1s
           wait for page to load
           Capture page screenshot
     END
    @{list_02}=      Split string      ${node_list_02}    ,
	 FOR    ${node}    IN    @{list_02}
           Clear Element Text      xpath:(//input[contains(@class,'SearchInput sf-element-input sf-suppress-forms-accept-command sf-suppress-forms-cancel-command sf-input-with-placeholder')])[3]
           Selenium2Library.Input Text     xpath:(//input[contains(@class,'SearchInput sf-element-input sf-suppress-forms-accept-command sf-suppress-forms-cancel-command sf-input-with-placeholder')])[3]     ${node} 
           press key      xpath:(//input[contains(@class,'SearchInput sf-element-input sf-suppress-forms-accept-command sf-suppress-forms-cancel-command sf-input-with-placeholder')])[3]     \\13
           sleep    2s
           wait for page to load
           Click element      xpath://div[@title='${node}']      modifier=CTRL
           sleep    2s
           Clear Element Text      xpath:(//input[contains(@class,'SearchInput sf-element-input sf-suppress-forms-accept-command sf-suppress-forms-cancel-command sf-input-with-placeholder')])[3]
           sleep    3s
		   wait for page to load
           Capture page screenshot
     END

Verify if aggregation dropdown will is restricted when object aggregation is not selected
    Select time drop down to      Last 30 Days
    Click on scroll down button    6    8
    element should be visible     xpath://span[contains(text(),'Select Object Aggregation')]
    sleep  2s
    Click element     xpath:(//div[@class='ComboBoxTextDivContainer'])[7]
	element should not be visible    xpath://div[@title="Day" and @class='sf-element-dropdown-list-item sfpc-selected']
	sleep  3s
    wait for page to load
	capture page screenshot
	
Verify if all fields are same while saving in edit mode
    [Arguments]     ${report_name}    ${access_type}     ${description}
	Wait Until Page Contains Element       xpath://span[@id='reportNameInputField']//input[@class='sf-element sf-element-control sfc-property sfc-text-box']           timeout=1500
	element should be visible    xpath://input[@value="${report_name}"]
    Click on scroll down button    3    6
	element should be visible    xpath://*[contains(text(),'${access_type}')]
	element should be visible    xpath://textarea[contains(text(),'${description}')]
	Click on scroll up button    3    10
	wait for page to load
	capture page screenshot
	
Verify if file availability column in added after checking data integrity check box on create page
	Wait Until Page Contains Element       xpath://*[contains(text(),'File Availability')]           timeout=1500
	element should be visible    xpath://*[contains(text(),'File Availability')]
	wait for page to load
	capture page screenshot
	
Verify if file availability column in added after checking data integrity check box on edit and view page
    Mouse Over      xpath://*[contains(text(),'DATE_ID')]
    Click on the scroll right button    0    40
    Wait Until Page Contains Element       xpath://*[contains(text(),'File Availability')]           timeout=1500
    element should be visible    xpath://*[contains(text(),'File Availability')]
    wait for page to load
    capture page screenshot
	
Verify if file availability column in removed after unchecking data integrity check box
    Wait Until Page Does Not Contain Element       xpath://*[contains(text(),'File Availability')]           timeout=1500
    element should not be visible    xpath://*[contains(text(),'File Availability')]
    wait for page to load
    capture page screenshot

Verify if all files are getting update when click on update all pages check box
    [Arguments]     ${report_name}    ${Aggregation}
    Wait Until Page Contains Element       xpath:(//div[@class="ComboBoxTextDivContainer"])[1]           timeout=1500
    Click Element    xpath:(//div[@class="ComboBoxTextDivContainer"])[1]
    Wait Until Page Contains Element       xpath://div[contains(@class,'sf-element-dropdown-list-item') and @title='${report_name}:pm_DC_E_NR_EVENTS_NRCELLCU_V_${Aggregation}(No Aggregation Level)__NetAn_ODBC_PDF']           timeout=120
    element should be visible    xpath://div[contains(@class,'sf-element-dropdown-list-item') and @title='${report_name}:pm_DC_E_NR_EVENTS_NRCELLCU_V_${Aggregation}(No Aggregation Level)__NetAn_ODBC_PDF']
    wait for page to load
    capture page screenshot

Select System area as
    [Arguments]     ${sys_area}
    sleep  3s      #3 seconds given for syatem area to load based on selected data source
    @{element}=    Get WebElements	    xpath: //div[@class='ComboBoxTextDivContainer']
    ${sys_area_ele}=        Get from list     ${element}    1
    Wait Until Element Is Visible        ${sys_area_ele}
    Click element     ${sys_area_ele}
    sleep  1s
    Click element      xpath://div[@title='${sys_area}']
	wait for page to load				  
    element should not be visible    xpath:((//span[@style= "COLOR: #fa7864"])[1])//span[contains(text(),'Select System Area')]
	capture page screenshot
	
Select Node type as
    [Arguments]     ${node_type}
    Sleep      10s
	Run keyword and ignore error        Click on scroll down button    6     5
    @{element}=    Get WebElements      xpath: //div[@class='ComboBoxTextDivContainer']
    ${node_type_ele}=        Get from list     ${element}    2
    Click element     ${node_type_ele}
    sleep  2s
    Run keyword and ignore error           Click on scroll down button    19   40
    FOR    ${i}    IN RANGE    0     10
         ${status}=     Run Keyword And Return Status        Element should be visible          xpath://div[@title='${node_type}']
         IF   ${status} is ${TRUE}
               Exit For Loop
         ELSE
               Run keyword if      ${status}==False      Click on scroll up button    19   5
         END
         
    END
    Click element      xpath://div[@title='${node_type}']
    sleep    2
    wait for page to load                
    element should not be visible    xpath:((//span[@style= "COLOR: #fa7864"]))//span[contains(text(),'Select Node Type')]
    capture page screenshot

Select Node type as for collection Manager
    [Arguments]     ${node_type}
    Sleep      10s
    @{element}=    Get WebElements	    xpath: //div[@class='ComboBoxTextDivContainer']
    ${node_type_ele}=        Get from list     ${element}    2
    Click element     ${node_type_ele}
    sleep  2s
    ${status}=     Run Keyword And Return Status        Element should be visible          xpath://div[@title='${node_type}']
    Run keyword if      ${status}==False      Click on scroll down button    10   10
    Click element      xpath://div[@title='${node_type}']
    sleep    2
	wait for page to load				  
    element should not be visible    xpath:((//span[@style= "COLOR: #fa7864"]))//span[contains(text(),'Select Node Type')]
    capture page screenshot
	
Click on the Preview button
	Wait Until Page Contains Element      xpath://input[@value="Preview"]     timeout=1500
	element should be enabled    xpath://input[@value="Preview"]
	Click Element      xpath://input[@value="Preview"]
	Wait Until Page Contains Element      xpath:(//div[@class="contentContainer"])     timeout=1500
	${text}=    Selenium2Library.get text    xpath:(//div[@class="contentContainer"])
	Log    ${text}
	should not be equal    ${text}    ${EMPTY}
	capture page screenshot
	
verify alert message shows up for incorrect syntax in Wildcard Expression
	Click on scroll down button     3    15
	Wait Until Page Contains Element      xpath://input[@id="643a8f060b154024ae32a0583a9f793d"]     timeout=1500
	Clear Element Text      xpath://input[@id="643a8f060b154024ae32a0583a9f793d"]
	Selenium2Library.Input Text     xpath://input[@id="643a8f060b154024ae32a0583a9f793d"]    FDN sike '%ROOT%'
    press keys      xpath://input[@id="643a8f060b154024ae32a0583a9f793d"]     ENTER
    click on button    Preview
    Wait Until Page Contains Element      xpath:(//span[@id="action-message"]//*[contains(text(),'**Failed to fetch Nodes...Invalid wildcard expression!')])    timeout=1500
    element should be visible    xpath:(//span[@id="action-message"]//*[contains(text(),'**Failed to fetch Nodes...Invalid wildcard expression!')])
	Click on scroll up button     3    15
	capture page screenshot
	
verify alert message if Wildcard Expression field is empty
	Click on scroll down button     3    15
	Wait Until Page Contains Element      xpath://input[@id="643a8f060b154024ae32a0583a9f793d"]     timeout=1500
	Clear Element Text      xpath://input[@id="643a8f060b154024ae32a0583a9f793d"]
	Selenium2Library.Input Text     xpath://input[@id="643a8f060b154024ae32a0583a9f793d"]    ${EMPTY}
    press keys      xpath://input[@id="643a8f060b154024ae32a0583a9f793d"]     ENTER
    click on button    Preview
    Wait Until Page Contains Element      xpath:(//span[@id="action-message"]//*[contains(text(),'**Invalid wildcard expression!')])    timeout=1500
    element should be visible    xpath:(//span[@id="action-message"]//*[contains(text(),'**Invalid wildcard expression!')])
    Click on scroll up button     3    15
	capture page screenshot
	
verify alert message if we click on Create while Wildcard Expression field is empty
	Click on scroll down button     3    15
	Wait Until Page Contains Element      xpath://input[@id="643a8f060b154024ae32a0583a9f793d"]     timeout=1500
	Clear Element Text      xpath://input[@id="643a8f060b154024ae32a0583a9f793d"]
	Selenium2Library.Input Text     xpath://input[@id="643a8f060b154024ae32a0583a9f793d"]    ${EMPTY}
    press keys      xpath://input[@id="643a8f060b154024ae32a0583a9f793d"]     ENTER
    click on button    Preview
    Wait Until Page Contains Element      xpath:(//span[@id="action-message"]//*[contains(text(),'**Invalid wildcard expression!')])    timeout=1500
    element should be visible    xpath:(//span[@id="action-message"]//*[contains(text(),'**Invalid wildcard expression!')])
    Click on scroll up button     3    15
	capture page screenshot

verify that the collection created by Administrator is not visible
	[Arguments]    ${name}
	element should not be visible    xpath://*[contains(text(),'${name}')]
	wait for page to load
	capture page screenshot

verify alert message if we click on Save while System Area, Node Type and Collection Name are empty
	[Arguments]    ${collectionName}
	Click on scroll up button     3    25
	Enter the Collection name for dynamic collection    ${EMPTY}
	@{element}=    Get WebElements	    xpath: //div[@class='ComboBoxTextDivContainer']
    ${sys_area_ele}=        Get from list     ${element}    1
    Wait Until Element Is Visible        ${sys_area_ele}
    Click element     ${sys_area_ele}
    sleep  1s
    Click element      xpath://div[@title='(None)']
	wait for page to load	
	click on button    Save
	click on the scroll down button     3    10
	Wait Until Page Contains Element      xpath://div[@class="flex-item flex-container-horizontal flex-inline-container flex-align-center"]    timeout=1500
	Click Element      xpath://div[@class="flex-item flex-container-horizontal flex-inline-container flex-align-center"]
	Wait Until Page Contains Element      xpath:(//*[contains(text(),'Note: To save a collection, add nodes to the Selected Nodes panel.')])    timeout=1500
	element should be visible    xpath:(//*[contains(text(),'Note: To save a collection, add nodes to the Selected Nodes panel.')])
	click on the scroll down button     6    10
	Wait Until Page Contains Element      xpath://div[@class="flex-item flex-container-horizontal flex-inline-container flex-align-center"]    timeout=1500
	Click Element      xpath://div[@class="flex-item flex-container-horizontal flex-inline-container flex-align-center"]
	Click on scroll up button     3    25
	Enter the Collection name for dynamic collection    ${collectionName}
	verify that the DataSource is present and select it    NetAn_ODBC
	select the System area as    Core
	click on the scroll down button     3    10
	select the Node type    CCES
	capture page screenshot
	
un-check Dynamic Collection check-box and verify Selected Nodes panel is empty
	Wait Until Page Contains Element      xpath://div[@class="flex-item flex-container-horizontal flex-inline-container flex-align-center"]    timeout=1500
	Click Element      xpath://div[@class="flex-item flex-container-horizontal flex-inline-container flex-align-center"]
	Wait Until Page Contains Element      xpath:(//div[@title="Selected Nodes"])     timeout=1500
	${text}=    Selenium2Library.get text    xpath:(//div[@class="ListContainer"])[2]
	Log    ${text}
	should be equal    ${text}    ${EMPTY}
	click on the scroll down button     6    15
	Wait Until Page Contains Element      xpath://div[@class="flex-item flex-container-horizontal flex-inline-container flex-align-center"]    timeout=1500
	Click Element      xpath://div[@class="flex-item flex-container-horizontal flex-inline-container flex-align-center"]
	Wait Until Page Contains Element      xpath:(//div[@title="Preview"])    timeout=150
	click on the scroll down button     3    25
	Click on the Preview button
	capture page screenshot
	
check the Dynamic Collection check-box and verify Preview panel is empty
	Wait Until Page Contains Element      xpath://div[@class="flex-item flex-container-horizontal flex-inline-container flex-align-center"]    timeout=1500
	Click Element      xpath://div[@class="flex-item flex-container-horizontal flex-inline-container flex-align-center"]
	Wait Until Page Contains Element      xpath:(//div[@title="Preview"])    timeout=150
	${text}=    Selenium2Library.get text    xpath:(//div[@name="valueCellsContainer"])
	Log    ${text}
	should be equal    ${text}    ${EMPTY}
	click on the scroll down button     3    10
	Wait Until Page Contains Element      xpath://div[@class="flex-item flex-container-horizontal flex-inline-container flex-align-center"]    timeout=1500
	Click Element      xpath://div[@class="flex-item flex-container-horizontal flex-inline-container flex-align-center"]
	Wait Until Page Contains Element      xpath:(//div[@title="Selected Nodes"])    timeout=150
	Click on scroll down button    6    20
	click on button    Fetch nodes
	select the Nodes    CCES01
	click on button    Add >>
	capture page screenshot
	
select System Area and verify Node Type is empty
	Click On Scroll Up Button    6    7
	Select System area    Core
	${text1}=    Selenium2Library.get text    xpath:(//div[@class="ComboBoxTextDivContainer"])[3]//div
	Log    ${text1}
	should not be equal    ${text1}    Radio
	Select System area    Radio
	click on the scroll down button    6    7
    Select Node type    NR
	wait for page to load
	capture page screenshot
	
verify ModifiedBy column in Collection Manager page after Collection is modified
	[Arguments]    ${collectionName}
	place cursor on    CollectionName
	Click on scroll up button    2    100
	${status}=    run keyword and return status    Element should be visible       xpath://*[contains(text(),'${collectionName}')]
	IF    "${status}"=="False"
		FOR    ${i}    IN RANGE    0    50
			place cursor on    CollectionName
			Click on scroll down button    2    3
			${status}=    run keyword and return status    Element should be visible    xpath://*[contains(text(),'${collectionName}')]
			Exit For Loop If     ${status} == True
		END
		element should be visible      xpath://*[contains(text(),'${collectionName}')]		
	END
	place cursor on    CollectionName
	sleep    3
	click on the scroll right button    2    30
	${text1}=    Selenium2Library.get text    xpath:((//div[@class="valueCellCanvas"])[1])//div[@row="1" and @column="8"]
	Log    ${text1}
	should contain    ${text1}    Administrator
	capture page screenshot

select the created collection and click on edit
	[Arguments]    ${name}
	Select created Collection      ${name}
	Sleep    5s
	click on button    Edit Collection
	validate the page title    Create Collection
	${status1}=    run keyword and return status    element should be visible    xpath:(//div[@title="All Nodes"])
	IF    "${status1}"=="True"
		Wait Until Page Contains Element      xpath:(//div[@class="sf-element-list-box sfc-scrollable"])[1]     timeout=150
		${text1}=    Selenium2Library.get text    xpath:(//div[@class="sf-element-list-box sfc-scrollable"])[1]
		Log    ${text1}
		should contain    ${text1}    ${EMPTY}
		element should not be visible      xpath:(//*[@value="Add >>"])
		element should be enabled      xpath:(//*[@value="<< Remove"])
	ELSE
		Wait Until Page Contains Element      xpath:(//div[@class="valueCellsContainer"])     timeout=150
		${text2}=    Selenium2Library.get text    xpath:(//div[@class="valueCellsContainer"])
		Log    ${text2}
		should be equal    ${text2}    ${EMPTY}
	END
	capture page screenshot
	
select created collection and verify selected node is present in Edit page
	[Arguments]    ${name}    ${collectionNode}
	Select created Collection      ${name}
	sleep    2
					  
	click on button    Edit Collection
	validate the page title    Create Collection
	${status1}=    run keyword and return status    element should be visible    xpath:(//div[@title="All Nodes"])
	IF    "${status1}"=="True"
		Wait Until Page Contains Element      xpath:(//div[@class="sf-element-list-box sfc-scrollable"])[1]     timeout=150
		${text1}=    Selenium2Library.get text    xpath:(//div[@class="sf-element-list-box sfc-scrollable"])[1]
		Log    ${text1}
		should contain    ${text1}    ${EMPTY}
		${nodes}=    Selenium2Library.get text    xpath:(//div[@class="ScrollArea"])[2]
		Log    ${nodes}
		should contain    ${nodes}    ${collectionNode}
		element should not be visible      xpath:(//*[@value="Add >>"])
	ELSE
		Wait Until Page Contains Element      xpath:(//div[@class="valueCellsContainer"])     timeout=150
		${text2}=    Selenium2Library.get text    xpath:(//div[@class="valueCellsContainer"])
		Log    ${text2}
		should be equal    ${text2}    ${EMPTY}
	END
	capture page screenshot
	
Click on Fetch Nodes
	Click on scroll down button     6       20									  
	Wait Until Page Contains Element      xpath: //input[@value="Fetch nodes"]     timeout=1500
	element should be enabled      xpath:(//*[@value="Fetch nodes"])
	Wait Until Page Contains Element      xpath: //*[@value="Import nodes from File"]     timeout=1500
	element should be enabled      xpath:(//*[@value="Import nodes from File"])
    Click Element    xpath: //input[@value="Fetch nodes"]
    capture page screenshot
    Wait Until Page Does Not Contain Element      xpath:(//div[@class="ListItems"]//div[@title="(All) 0 values"])[2]     timeout=600
    Wait Until Page Contains Element      xpath:(//div[@class="ScrollArea"])[1]    150
    ${text1}=    Selenium2Library.get text    xpath:(//div[@class="ScrollArea"])[1]
	Log    ${text1}
	should not be equal    ${text1}    (All) 0 values
	Wait Until Page Contains Element      xpath:(//div[@class="ScrollArea"])[2]     timeout=150
	${text2}=    Selenium2Library.get text    xpath:(//div[@class="ScrollArea"])[2]
	Log    ${text2}
	should contain    ${text2}    (All) 0 values    
	capture page screenshot

Click on Fetch Nodes in Edit Mode
	Click on scroll down button     6       20									  
	Wait Until Page Contains Element      xpath: //input[@value="Fetch nodes"]     timeout=1500
	element should be enabled      xpath:(//*[@value="Fetch nodes"])
	Wait Until Page Contains Element      xpath: //*[@value="Import nodes from File"]     timeout=1500
	element should be enabled      xpath:(//*[@value="Import nodes from File"])
    Click Element    xpath: //input[@value="Fetch nodes"]
	capture page screenshot
	
verify that << Remove button removes selected node from Selected Nodes list
	Wait Until Page Contains Element      xpath:(//div[@class="ScrollArea"])[2]     timeout=150
	${text}=    Selenium2Library.get text    xpath:(//div[@class="ScrollArea"])[2]
	Log    ${text}
	should not contain    ${text}    (All) 0 values
	Wait Until Page Contains Element      xpath:(//input[@value="<< Remove"])[1]     timeout=150
	Click Element    xpath:(//input[@value="<< Remove"])[1]
	capture page screenshot
	sleep    2
	Wait Until Page Contains Element      xpath:(//div[@class="ScrollArea"])[2]     timeout=150
	${text}=    Selenium2Library.get text    xpath:(//div[@class="ScrollArea"])[2]
	Log    ${text}
	should contain    ${text}    (All) 0 values
	click on the scroll down button    6    20
	Click on Add >>
	capture page screenshot

verify error message if already existing name is entered while editing report
	[Arguments]    ${name}    ${newName}
	Log    ${name}
	Log    ${newName}
	Clear Element Text      xpath://input[@class='sf-element sf-element-control sfc-property sfc-text-box'][1]
	sleep    2s
	Selenium2Library.Input Text     xpath://input[@class='sf-element sf-element-control sfc-property sfc-text-box'][1]    ${name}
																																					
    capture page screenshot
    Wait Until Page Contains Element      xpath:(//*[@value="Save"])[3]    150
    click element    xpath:(//*[@value="Save"])[3]
    capture page screenshot
    sleep    2
    verify the message Collection name already exists
    Clear Element Text      xpath://input[@class='sf-element sf-element-control sfc-property sfc-text-box'][1]
	sleep    2s
	Selenium2Library.Input Text     xpath://input[@class='sf-element sf-element-control sfc-property sfc-text-box'][1]    ${newName}
	sleep    2s
    capture page screenshot
	
verify that the DataSource, System Area and Node Type are displaying correct values
	[Arguments]    ${dataSource}    ${systemArea}    ${nodeType}
	${status}=    run keyword and return status    click on scroll up button    6    20
	IF    "${status}"=="False"
		click on scroll up button    3    20
	END
	Wait Until Page Contains Element      xpath:(//div[@class="ComboBoxTextDivContainer"]//div[@title="${dataSource}"])     timeout=150
	element should be visible    xpath:(//div[@class="ComboBoxTextDivContainer"]//div[@title="${dataSource}"])
	${status}=    run keyword and return status    click element    xpath:(//div[@class="ComboBoxTextDivContainer"]//div[@title="${dataSource}"])
	element should not be visible    xpath:(//div[@class="ScrollArea"])[3]
	Wait Until Page Contains Element      xpath:(//div[@class="ComboBoxTextDivContainer"]//div[@title="${systemArea}"])     timeout=150
	element should be visible    xpath:(//div[@class="ComboBoxTextDivContainer"]//div[@title="${systemArea}"])
	${status}=    run keyword and return status    click element    xpath:(//div[@class="ComboBoxTextDivContainer"]//div[@title="${systemArea}"])
	element should not be visible    xpath:(//div[@class="ScrollArea"])[3]
	Wait Until Page Contains Element      xpath:(//div[@class="ComboBoxTextDivContainer"]//div[@title="${nodeType}"])     timeout=150
	element should be visible    xpath:(//div[@class="ComboBoxTextDivContainer"]//div[@title="${nodeType}"])
	${status}=    run keyword and return status    click element    xpath:(//div[@class="ComboBoxTextDivContainer"]//div[@title="${nodeType}"])
	element should not be visible    xpath:(//div[@class="ScrollArea"])[3]
	${status}=    run keyword and return status    click on scroll down button    6    20
	IF    "${status}"=="False"
		click on scroll down button    3    20
	END
	capture page screenshot	
	
verify alert message if we click on Save while Wildcard Expression syntax is incorrect
	Click on scroll down button     3    15
	Wait Until Page Contains Element      xpath://input[@id="643a8f060b154024ae32a0583a9f793d"]     timeout=1500
	Clear Element Text      xpath://input[@id="643a8f060b154024ae32a0583a9f793d"]
	Selenium2Library.Input Text     xpath://input[@id="643a8f060b154024ae32a0583a9f793d"]    FDN sike '%ROOT%'
    press keys      xpath://input[@id="643a8f060b154024ae32a0583a9f793d"]     ENTER
    save the collection
    Wait Until Page Contains Element      xpath:(//span[@id="action-message"]//*[contains(text(),'**Invalid wildcard expression!')])    timeout=150
    element should be visible    xpath:(//span[@id="action-message"]//*[contains(text(),'**Invalid wildcard expression!')])
	Click on scroll up button     3    15
	capture page screenshot		
	
un-check Dynamic Collection check-box and verify Selected Nodes panel is empty on Edit page
	Click on scroll up button     3    15
	Click on scroll down button     3    15
	Wait Until Page Contains Element      xpath://div[@class="flex-item flex-container-horizontal flex-inline-container flex-align-center"]    timeout=1500
	Click Element      xpath://div[@class="flex-item flex-container-horizontal flex-inline-container flex-align-center"]
	Wait Until Page Contains Element      xpath:(//div[@title="Selected Nodes"])     timeout=1500
	${text}=    Selenium2Library.get text    xpath:(//div[@class="ListContainer"])[2]
	Log    ${text}
	should be equal    ${text}    ${EMPTY}
	click on the scroll down button     6    15
	Wait Until Page Contains Element      xpath://div[@class="flex-item flex-container-horizontal flex-inline-container flex-align-center"]    timeout=1500
	Click Element      xpath://div[@class="flex-item flex-container-horizontal flex-inline-container flex-align-center"]
	Click on scroll up button     3    15
	capture page screenshot	
	
check the Dynamic Collection check-box and verify Preview panel is empty on Edit page
	Click on scroll up button     6    15
	Click on scroll down button     6    15
	Wait Until Page Contains Element      xpath://div[@class="flex-item flex-container-horizontal flex-inline-container flex-align-center"]    timeout=1500
	Click Element      xpath://div[@class="flex-item flex-container-horizontal flex-inline-container flex-align-center"]
	Wait Until Page Contains Element      xpath:(//div[@title="Preview"])    timeout=150
	${text}=    Selenium2Library.get text    xpath:(//div[@name="valueCellsContainer"])
	Log    ${text}
	should contain    ${text}    ${EMPTY}
	click on the scroll down button     3    10
	Wait Until Page Contains Element      xpath://div[@class="flex-item flex-container-horizontal flex-inline-container flex-align-center"]    timeout=1500
	Click Element      xpath://div[@class="flex-item flex-container-horizontal flex-inline-container flex-align-center"]
	Wait Until Page Contains Element      xpath:(//div[@title="Selected Nodes"])    timeout=150
	Click on scroll down button    6    20
	click on button    Fetch nodes
	select the Nodes    CCES01
	click on button    Add >>
	capture page screenshot
	
verify alert message if we click on Save while Wildcard Expression field is empty
	Click on scroll down button     3    15
	Wait Until Page Contains Element      xpath://input[@id="643a8f060b154024ae32a0583a9f793d"]     timeout=1500
	Clear Element Text      xpath://input[@id="643a8f060b154024ae32a0583a9f793d"]
	Selenium2Library.Input Text     xpath://input[@id="643a8f060b154024ae32a0583a9f793d"]    ${EMPTY}
    press keys      xpath://input[@id="643a8f060b154024ae32a0583a9f793d"]     ENTER
    save the collection
    Wait Until Page Contains Element      xpath:(//span[@id="action-message"]//*[contains(text(),'**Invalid wildcard expression!')])    timeout=1500
    element should be visible    xpath:(//span[@id="action-message"]//*[contains(text(),'**Invalid wildcard expression!')])
    Click on scroll up button     3    15
	capture page screenshot	
	
verify that << Remove button removes selected node from Selected Nodes list on Edit page
	[Arguments]    ${node}
	Wait Until Page Contains Element      xpath:(//div[@class="ScrollArea"])[2]     timeout=150
	${text}=    Selenium2Library.get text    xpath:(//div[@class="ScrollArea"])[2]
	Log    ${text}
	should not contain    ${text}    (All) 0 values
	Wait Until Page Contains Element      xpath:(//input[@value="<< Remove"])[1]     timeout=150
	Click Element    xpath:(//input[@value="<< Remove"])[1]
	capture page screenshot
	sleep    2
	Wait Until Page Contains Element      xpath:(//div[@class="ScrollArea"])[2]     timeout=150
	${text}=    Selenium2Library.get text    xpath:(//div[@class="ScrollArea"])[2]
	Log    ${text}
	should contain    ${text}    (All) 0 values
	Wait Until Page Contains Element      xpath:(//input[@value="Save"])[4]    150
	${status}=    run keyword and return status    click element    xpath:(//input[@value="Save"])[4]
	element should not be visible    xpath:(//div[@title="Manage Collection"]) 
	Wait Until Page Contains Element      xpath:(//input[@value="<< Remove"])[1]     timeout=150
	element should not be visible    xpath:(//input[@value="<< Remove"])[1]
	click on the scroll down button    6    20
	Click on Fetch Nodes
	Select Nodes    ${node}
	Click on Add >>
	Wait Until Page Contains Element      xpath:(//input[@value="Save"])[4]    150
	${status}=    run keyword and return status    click element    xpath:(//input[@value="Save"])[4]
	element should not be visible    xpath:(//div[@title="Manage Collection"])
	capture page screenshot
	
go to Home page
	Wait Until Page Contains Element      xpath:(//img[@title="Home"])    150
	click element    xpath:(//img[@title="Home"])
	capture page screenshot
	
break the NetAn connection
    @{element}=    Get WebElements	    xpath: //input[@class='sf-element sf-element-control sfc-property sfc-text-box']
    ${name}=        Get from list     ${element}    0
    ${username}=        Get from list     ${element}    1
    ${password}=        Get from list     ${element}    2
    ${eniqs}=        Get from list     ${element}    3
    Selenium2Library.Input Text    ${name}       ${EMPTY}
    Sleep     1s
    Selenium2Library.Input Text    ${username}       ${EMPTY}
    Sleep     1s
    Selenium2Library.Input Text    ${password}       ${EMPTY}
    Sleep     1s
    Click element     xpath: //input[@id='a49e8a2e448349398408b044a165fee5']
    Sleep     10s
    FOR    ${i}    IN RANGE    0     5
          Clear Element Text      ${eniqs}
          Selenium2Library.Input Text    ${eniqs}       ${EMPTY}    
    END       
    Sleep    3s
    Click element     xpath: //input[@id='075d5400a00740b1b64261f11e3d4f27']
    Sleep    10s
    wait for page to load
	capture page screenshot			
	
verify that DataBase connection exception is visible
	Wait Until Page Contains Element      xpath:((//div[@title="Error in dataBase connection"])[1])     timeout=150
	element should be visible    xpath:((//div[@title="Error in dataBase connection"])[1])
	capture page screenshot
	
select the created collection and delete it
	[Arguments]    ${name}
	place cursor on    CollectionName
	Click on scroll up button    2    50
	${status}=    run keyword and return status    Click Element       xpath://*[contains(text(),'${name}')]
	IF    "${status}"=="False"
		FOR    ${i}    IN RANGE    0    50
			place cursor on    CollectionName
			Click on scroll down button    2    3
			${status}=    run keyword and return status    Element should be visible    xpath://*[contains(text(),'${name}')]
			Exit For Loop If     ${status} == True
		END		
		Click Element      xpath://*[contains(text(),'${name}')]		
	END
	Wait Until Element Is Visible      xpath://*[@value="Delete Collection"]
	click on button    Delete Collection
	Wait Until Element Is Visible           xpath://label[@class='deleteCollectionOptions1' and text()='Cancel']    150
	Click element     xpath://label[@class='deleteCollectionOptions1' and text()='Cancel']
	sleep    2
	Wait Until Element Is Visible      xpath://*[@value="Delete Collection"]    150
	click on button    Delete Collection	
	Wait Until Element Is Visible           xpath://label[@class='deleteCollectionsInput' and text()='Delete']    150
	Click element     xpath://label[@class='deleteCollectionsInput' and text()='Delete']
	Wait Until Element Is Not Visible    xpath://label[@class='deleteCollectionsInput' and text()='Delete']    150          1500
	capture page screenshot
	Wait Until Page Does Not Contain Element           xpath://*[contains(text(),'${name}')]            1500
	capture page screenshot	
	
validate the Collection is created with correct details
	[Arguments]    ${collectionName}    ${dataSource}    ${systemArea}    ${nodeType}
	place cursor on    CollectionName
	Click on scroll up button    2    100
	${status}=    run keyword and return status    Element should be visible       xpath://*[contains(text(),'${collectionName}')]
	IF    "${status}"=="False"
		FOR    ${i}    IN RANGE    0    50
			place cursor on    CollectionName
			Click on scroll down button    2    3
			${status}=    run keyword and return status    Element should be visible    xpath://*[contains(text(),'${collectionName}')]
			Exit For Loop If     ${status} == True
		END
		element should be visible      xpath://*[contains(text(),'${collectionName}')]		
	END
	Wait Until Element Is Visible           xpath://*[contains(text(),'${dataSource}')]    150
	element should be visible    xpath://*[contains(text(),'${dataSource}')]
	Wait Until Element Is Visible           xpath://*[contains(text(),'${systemArea}')]    150
	element should be visible    xpath://*[contains(text(),'${systemArea}')]
	Wait Until Element Is Visible           xpath://*[contains(text(),'${nodeType}')]    150
	element should be visible    xpath://*[contains(text(),'${nodeType}')]
	capture page screenshot
	
Verify the pop is coming as delete cannot be completed
     ${text}=    Selenium2Library.get text 	xpath://*[contains(text(),'The delete action cannot be completed')]
     Should contain      ${text}      The delete action cannot be completed	
	 Wait Until Element Is Visible    xpath:(//label[@class="deleteCollectionsInput" and contains(text(),'OK')])    150
	 click element    xpath:(//label[@class="deleteCollectionsInput" and contains(text(),'OK')])
	 Wait Until Element Is not Visible    xpath:(//label[@class="deleteCollectionsInput" and contains(text(),'OK')])    150
	 Wait Until Element Is Visible    xpath:(//*[@value="Delete Collection"])[1]    150
	 click on button    Delete Collection
	 ${text}=    Selenium2Library.get text 	xpath://*[contains(text(),'The delete action cannot be completed')]
     Should contain      ${text}      The delete action cannot be completed	
	 Wait Until Element Is Visible    xpath:(//label[@class="deleteCollectionOptions"])[2]    150
	 click element    xpath:(//label[@class="deleteCollectionOptions"])[2]
	 Wait Until Element Is not Visible    xpath:(//label[@class="deleteCollectionsInput" and contains(text(),'OK')])    150
	 capture page screenshot
	 
########## MR-EQEV-124461 Test Cases ##########	
Change the Visualization type to Waterfall chart
    Wait Until Page Contains Element    xpath:(//div[@class="sf-element sf-element-visual-content sfc-table"])  30
	open context menu    xpath:(//div[@class="sf-element sf-element-visual-content sfc-table"])
	Wait Until Page Contains Element     xpath:(//div[@title="Switch visualization to"])  10
	click element  xpath:(//div[@title="Switch visualization to"]) 
	Wait Until Page Contains Element     xpath:(//div[@title="Waterfall chart"])  10
	click element  xpath:(//div[@title="Waterfall chart"])
	Wait Until Page Contains Element  xpath:(//div[@class="sf-element-canvas-image"])  300
	element should be visible  xpath:(//div[@class="sf-element-canvas-image"])
	capture page screenshot
	
Change the Visualization type to Parallel Coordinate chart
    Wait Until Page Contains Element    xpath:(//div[@class="sf-element sf-element-visual-content sfc-table"])  30
	open context menu    xpath:(//div[@class="sf-element sf-element-visual-content sfc-table"])
	Wait Until Page Contains Element     xpath:(//div[@title="Switch visualization to"])  10
	click element  xpath:(//div[@title="Switch visualization to"]) 
	Wait Until Page Contains Element     xpath:(//div[@title="Parallel coordinate plot"])  10
	click element  xpath:(//div[@title="Parallel coordinate plot"])
	Wait Until Page Contains Element  xpath:(//div[@class="sf-element sf-element-canvas-visualization"])  300
	element should be visible  xpath:(//div[@class="sf-element sf-element-canvas-visualization"])
	capture page screenshot

Change the Visualization type to Map chart
    Wait Until Page Contains Element    xpath:(//div[@class="sf-element sf-element-visual-content sfc-table"])  30
	open context menu    xpath:(//div[@class="sf-element sf-element-visual-content sfc-table"])
	Wait Until Page Contains Element     xpath:(//div[@title="Switch visualization to"])  300
	click element  xpath:(//div[@title="Switch visualization to"]) 
	Wait Until Page Contains Element     xpath:(//div[@title="Map chart"])  500
	click element  xpath:(//div[@title="Map chart"])
	sleep    2 
	Wait Until Element Is Visible    xpath:(//img[@class="tibco-image-1"])[1]   1000
	element should be visible  xpath:(//img[@class="tibco-image-1"])[1]   
	capture page screenshot


Click on Cancel button for save report dialog
	Wait Until Page Contains Element      xpath:(//label[@class="cancelChart"])[1]     timeout=1500
	Click Element    xpath:(//label[@class="cancelChart"])[1]
	Wait Until Element Is Not Visible       xpath:((//div[@class="Dialog-Chart"])[1])       timeout=300
	Element Should Not Be Visible     xpath:((//div[@class="Dialog-Chart"])[1])
	capture page screenshot
	
Click on Cancel button for save report dialog2
	Wait Until Page Contains Element      xpath:(//label[@class="cancelChart"])[2]     timeout=1500
	Click Element    xpath:(//label[@class="cancelChart"])[2]
	Wait Until Element Is Not Visible       xpath:((//div[@class="Dialog-Chart2"])[1])       timeout=300
	Element Should Not Be Visible     xpath:((//div[@class="Dialog-Chart2"])[1])
	capture page screenshot
	
Click on Continue button
	Wait Until Page Contains Element      xpath:(//label[@class="Continue"])     timeout=1500
	Click Element    xpath:(//label[@class="Continue"])
	wait for page to load
	capture page screenshot

Click Save report button for dialog
	Wait Until Page Contains Element      id:saveBtn   timeout=1500	
	${status} =      Run keyword and return status     Click element    id:saveBtn
	IF    "${status}"=="False"
	      Click on scroll down button     2       1
		  Click element    id:saveBtn
    END    
	Wait Until Element Is Visible      xpath:((//div[@class="Dialog-Chart"])[1])       timeout=300
	element should be visible    xpath:((//div[@class="Dialog-Chart"])[1])

Click Save report button for dialog2
	Wait Until Page Contains Element      id:saveBtn   timeout=1500	
	${status} =      Run keyword and return status     Click element    id:saveBtn
	IF    "${status}"=="False"
	      Click on scroll down button     2       1
		  Click element    id:saveBtn
    END    
	Wait Until Element Is Visible      xpath:((//div[@class="Dialog-Chart2"])[1])       timeout=300
	element should be visible    xpath:((//div[@class="Dialog-Chart2"])[1])
	
Validation of text UnsupportedChartType	
	Wait Until Element Is Visible     xpath:((//div[@class="Dialog-Chart"])[1])       timeout=300
	element should be visible    xpath:((//div[@class="layout"])[7])
	
Validation of text UnsupportedChart SupportedChart
	Wait Until Element Is Visible     xpath:((//div[@class="Dialog-Chart2"])[1])       timeout=300
	element should be visible    xpath:((//div[@class="layout"])[8])



Verify the graph list is displayed for report    
    [Arguments]        ${graph_type} 
     ${graph_type_ui}=    Get text    xpath://div[@name='valueCellCanvas']//div[@row='1' and @column='5']
     Should contain     ${graph_type_ui}       ${graph_type}	
	 
	 
################################################# MR EQEV-124498 START ########################################

Validate PDFKPI listed under Ericsson_KPI measure type
	[Arguments]      ${kpi_name}
	${pdf_kpi_name}=    Get text     xpath:(//div[@name='valueCellCanvas']//div[@row='1' and @column='0'])[1]
	should be equal        ${kpi_name}     ${pdf_kpi_name} 

Verify Pivot table is created
	[Arguments]     ${pivoted}  
	Wait Until Page Contains Element      id:pageLabel     timeout=1500																   
    ${text}=    Get text   id:pageLabel
    Log    ${text}
    Should contain    ${text}    ${pivoted}
    
Select Nodes in edit mode
    [Arguments]    ${node_list}
    Click on scroll down button     8    5
    @{list}=      Split string      ${node_list}    ,
     FOR    ${node}    IN    @{list}
           Clear Element Text      xpath://input[contains(@class,'SearchInput sf-element-input sf-suppress-forms-accept-command sf-suppress-forms-cancel-command sf-input-with-placeholder')]
           Selenium2Library.Input Text     xpath://input[contains(@class,'SearchInput sf-element-input sf-suppress-forms-accept-command sf-suppress-forms-cancel-command sf-input-with-placeholder')]     ${node} 
           press key      xpath://input[contains(@class,'SearchInput sf-element-input sf-suppress-forms-accept-command sf-suppress-forms-cancel-command sf-input-with-placeholder')]     \\13
           sleep    2s
           wait for page to load
           Click element      xpath://div[@title='${node}']
           sleep   1s
		   Capture page screenshot
     END
          
Verify updated node updated in edit mode
	[Arguments]     ${input_name} 
	Sleep      100s       
	Click on scroll down button    8    5
	Sleep      10s
	Mouse Over      xpath://div[@class="valueCellsContainer"]	
	Element should be visible       xpath: //div[contains(text(),'${input_name}')]

Verify pivot column is available 
	[Arguments]     ${input_name}
	Mouse Over      xpath://div[@class="valueCellsContainer"]	
	${status}=    run keyword and return status    Element should be visible       xpath://*[contains(text(),'${input_name}')]
	IF    "${status}"=="False"
		Click on maximise window button    0
		FOR    ${i}    IN RANGE    0    150									 
			${status}=    run keyword and return status    Element should be visible    xpath://*[contains(text(),'${input_name}')]
			scroll over to the measures column
			Exit For Loop If     ${status} == True
		END					 	
	END 
	${column_name}=         Get text      xpath://*[contains(text(),'${input_name}')]
	should contain        ${column_name}    ${input_name}


Verify given column is available and check for the value
	[Arguments]     ${input_name}        ${check_value}	
	Mouse Over      xpath://div[@class="valueCellsContainer"]	
	${status}=    run keyword and return status    Element should be visible       xpath://*[contains(text(),'${input_name}')]
	IF    "${status}"=="False"
		Click on maximise window button    0
		FOR    ${i}    IN RANGE    0    150									 
			${status}=    run keyword and return status    Element should be visible    xpath://*[contains(text(),'${input_name}')]
			scroll over to the measures column
			Exit For Loop If     ${status} == True
		END					 	
	END 
	${column_name}=         Get text      xpath://*[contains(text(),'${input_name}')]
	should be equal        ${input_name}    ${column_name}
    ${count}=     set variable    0
	@{element}=    Get WebElements	    xpath://div[@name='frozenRowsCanvas']//div[@row='0']
    FOR    ${ele}    IN    @{element}
        ${text}=    Selenium2Library.Get Text   ${ele}
        log        ${count}
        IF      "${text}" == "${input_name}"
		    Runkeyword and ignore error         Click element       xpath://div[text()='DATETIME_ID' or text()='DATE_ID']
			Runkeyword and ignore error         wait until element is visible           xpath://div[@title='Sort by this column from highest to lowest value (Shift+click).']       30
			Runkeyword and ignore error         Click element       xpath://div[@title='Sort by this column from highest to lowest value (Shift+click).']	
            Sleep     5s
			${kpi_value}=         Selenium2Library.Get text  xpath://div[@name='valueCellCanvas']//div[@row='1' and @column='${count}']     
            exit for loop    
        END    
		${count}=   Evaluate    ${count} + 1                     
    END 
    Log        ${kpi_value}
    IF    "${check_value}"==":"   
        IF    "${input_name}"=="DATE_ID" 
            should not contain    ${kpi_value}    ${check_value}
        ELSE
            should contain    ${kpi_value}    ${check_value} 
        END         
    ELSE
        should contain    ${kpi_value}    ${check_value}  
    END
    ${status}=    run keyword and return status    Click on minimise window button    1
	Log    ${status}
	run keyword if    "${status}"=="False"     Mouse Over      xpath://div[@class="valueCellsContainer"]				 

Verify measure type is stored as Ericsson KPI for instrumentation in data base
    [Arguments]     ${kpi_name}
    ${sql}=    set variable    select "MeasureType" FROM "PMEx_Instrumentation" WHERE "MeasureName"='${kpi_name}' and "TimeStamp" = (Select max("TimeStamp") from "PMEx_Instrumentation")
    ${results}=  Query Postgre database and return output     ${sql}
    ${value}=    Get From List    ${results}     0
    Should contain    ${value}      Ericsson KPI	


################################################# MR EQEV-124498 END ########################################
	
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

click on cancel button for sync with eniq
     Wait Until Element Is Visible         class:${sfx_progress-bar}       timeout=3000
     Wait Until Element Is Visible         xpath://*[@title='Cancel']        timeout=3000
	 Sleep   5s
	 Click element                 xpath://*[@title='Cancel'] 

################################################ Opening Information Link #################################

open browser with home page
	${chrome_options}=    Evaluate    sys.modules['selenium.webdriver'].ChromeOptions()      sys
	Call Method    ${chrome_options}    add_argument    --ignore-certificate-errors
	Create Webdriver    Chrome    options=${chrome_options}
    Go To    ${base_url}   
    Maximize Browser Window
    Sleep    5
    Selenium2Library.Input Text    xpath:${username_xpath}     Administrator
    Selenium2Library.Input Text    xpath:${password_xpath}    Ericsson01
    Click Element    xpath:${loginButton_xpath} 
    Sleep    5
	
Open the information link
	[Arguments]    ${InformationLink}        ${tablename}
	Click Element       xpath:${analytics_page}
    Sleep      5
    Click Element       xpath://div[@title='Spotfire library']
    Sleep      5
    Double Click Element        xpath://div[contains(text(),'Custom Library')]
    Sleep      5
    Click Element       xpath://div[@title='Sort']
    Sleep      2
    Click Element       xpath://div[@title='Modified']
    Sleep       2
    Double Click Element        xpath://div[contains(text(),'PMEX Reports')]
	Sleep       2
	${il_name}=              set variable       ${InformationLink}_${tablename}
	run keyword and ignore error    wait until element is visible    xpath: //div[contains(text(),'${il_name}')]    300
    Double Click Element        xpath: //div[contains(text(),'${il_name}')]
    Sleep      5
	run keyword and ignore error    wait until element is visible    xpath: //div[contains(text(),'Information Links')]    300
    Double Click Element        xpath://div[contains(text(),'Information Links')]
    Sleep      5
	run keyword and ignore error    wait until element is visible    xpath: //div[contains(text(),'InfoLink_${il_name}')]    300
    Double Click Element        xpath://div[contains(text(),'InfoLink_${il_name}')]
	wait for page to load
	run keyword and ignore error    wait until element is visible    xpath: //div[contains(text(),'OK')]	    300
    Click Element    xpath://div[contains(text(),'OK')]	
    Sleep      15
    Element Should Not Be Visible       xpath://div[contains(text(),'OK')]
    wait for page to load
    Capture Page Screenshot
    Sleep     30s	
    click on the button    Start from visualizations
    Sleep      5
	Change the Visualization type to Table
	Sleep      5

Check for the Information link data
	${text}=    Get Text    xpath:(//div[@class="${sfx_label}"])[1]
    Should not contain      ${text}     '0 of 0 rows'

Validate the information link name based on aggregation selection
	[Arguments]    ${InformationLink_name}        ${aggregation}
	IF    "${aggregation}"=="ROP"
        Should contain    ${InformationLink_name}    RAW
    ELSE
        Should contain    ${InformationLink_name}    ${aggregation}
    END
	
Verify the date column value
	${date_value}=     Get cell value    DATE_ID    1
	${status}=    run keyword and return status     should not contain    ${date_value}     "00:00"
	Log     ${status}
	should be equal    '${status}'    'True'
	Capture Page Screenshot

scroll over to the measures column
	FOR    ${i}    IN RANGE    0    5
		   Wait Until Page Contains Element    xpath: (//div[@class="ScrollbarButton sf-element sf-element-scroll-bar-button sfpc-right"])[1]    30
		   ${status}=    run keyword and return status    Click element    xpath: (//div[@class="ScrollbarButton sf-element sf-element-scroll-bar-button sfpc-right"])[1]
		   Log    ${status}
		   run keyword if    "${status}"=="False"     Mouse Over      xpath://div[@class="valueCellsContainer"]
    END
    wait for page to load
	capture page screenshot
	
Click on minimise window button
    [Arguments]  ${button}
    @{element}=    Get WebElements	    xpath: //div[@title='Restore visualization layout']
    ${min_button}=        Get from list     ${element}     ${button}
    Click element     ${min_button}
#################################################################
	
verify the drop down for PDF counter is set to 'ALL'
	wait until page contains element    xpath:(//div[@name='valueCellCanvas']//div[@row='1' and @column='0'])[2]    300
    ${pdf_kpi_name}=    Get text     xpath:(//div[@name='valueCellCanvas']//div[@row='1' and @column='0'])[2]
    wait until page contains element    xpath:(//div[@name='valueCellCanvas']//div[@row='1' and @column='0'])[2]    300
    Sleep      3
    Click element    xpath:(//div[@name='valueCellCanvas']//div[@row='1' and @column='0'])[2]
    Sleep      3
    wait until element is enabled     xpath:(//div[@title="All"])[1]    30
    wait until element is visible    xpath:(//div[@title="All"])[1]    30
    ${text}=    selenium2library.get text    xpath: (//div[@title="All"])[1]
    Log    ${text}
    should be equal    ${text}    All
   
	
verify the drop down for PDF counter is set to 'Custom'
	wait until page contains element    xpath:(//div[@name='valueCellCanvas']//div[@row='1' and @column='0'])[2]    300
	${pdf_kpi_name}=    Get text     xpath:(//div[@name='valueCellCanvas']//div[@row='1' and @column='0'])[2]
	wait until page contains element    xpath:(//div[@name='valueCellCanvas']//div[@row='1' and @column='0'])[2]    300
	Click element    xpath:(//div[@name='valueCellCanvas']//div[@row='1' and @column='0'])[2]
	wait until element is enabled     xpath:(//div[@title="All"])[1]    30
	click element    xpath:(//div[@title="All"])[1]
	wait until element is visible    xpath:(//div[@title="Custom"])[1]    5
	click element   xpath:(//div[@title="Custom"])[1]
	click on scroll down button    18    4 
	wait until page contains element    xpath: (//span[@id="hidelabel"])//input[@class="sf-element sf-element-control sfc-property sfc-text-box"]
	click element    xpath: (//span[@id="hidelabel"])//input[@class="sf-element sf-element-control sfc-property sfc-text-box"]
	Input text    xpath: (//span[@id="hidelabel"])//input[@class="sf-element sf-element-control sfc-property sfc-text-box"]    4
	click on button     Apply PDF settings

Verify save report page for no data
    ${status}=    run keyword and return status     Element Should Not Be Visible   xpath:(//div[@name='valueCellsContainer']//div[@row='0' and @column='0'])
	Log     ${status}
	IF    "${status}"=="True"
	      Element Should Not Be Visible   xpath:(//div[@title="Error in fetching data"])
    END    
	capture page screenshot	
Verify the same scenario when value drop down for PDF counter is set to 'Custom'
	Click on Create button
    Select ENIQ DataSource    NetAn_ODBC
    Select the System area    Radio
    Select Node type    NR
    Select Get Data For    SubNetwork
    select SubNetwork    G2RBS01
    Select Aggregation as    SubNetwork
    Select the measure type    PDF_COUNTER   
    Select KPIs    pmRadioUeRepCqi64QamRank4Distr.DC_E_NR_NRCELLDU_V_RAW
    verify the drop down for PDF counter is set to 'Custom'
    Select time drop down to      Last 7 Days  
    Select Aggregation in select time as     ROP  
    Click on fetch pmdata button
    Verify the page title    SubNetwork      NetAn_ODBC     ROP
    Verify columns displayed    SubNetwork
	Click on Save Report
	${report_name}=    Enter details to save report to library    Report.    Public    test
	Click on Save report to Library button
	Verify saved report available in Report manager GUI     ${report_name}    Public   test
    Verify that the report is saved to the DB     ${report_name} 
    
verify the drop down for Flex counter is set to 'ALL'
	wait until page contains element    xpath:(//div[@name='valueCellCanvas']//div[@row='1' and @column='0'])[2]    300
	${flex_counter}=    Get text     xpath:(//div[@name='valueCellCanvas']//div[@row='1' and @column='0'])[2]
	wait until page contains element    xpath:(//div[@name='valueCellCanvas']//div[@row='1' and @column='0'])[2]    300
	Click element    xpath:(//div[@name='valueCellCanvas']//div[@row='1' and @column='0'])[2]
	wait until element is enabled     xpath:(//div[@title="All"])[2]    30
	wait until element is visible    xpath:(//div[@title="All"])[2]    30
	${text}=    selenium2library.get text    xpath: (//div[@title="All"])[2]
	Log    ${text}
	should be equal    ${text}    All
	
Verify the same scenario when value drop down for Flex counter is set to 'Custom'
	Click on Create button
    Select ENIQ DataSource    NetAn_ODBC
    Select the System area    Radio
    Select Node type    NR
    Select Get Data For    SubNetwork
    select SubNetwork    G2RBS01
    Select Aggregation as    SubNetwork
    Select the measure type    FLEX_COUNTER   
    Select KPIs    pmEbsCellDowntimeMan.DC_E_NR_EVENTS_NRCELLDU_FLEX_RAW
    verify the drop down for Flex counter is set to 'Custom'
    Select time drop down to      Last 7 Days  
    Select Aggregation in select time as     ROP  
    Click on fetch pmdata button
    Verify the page title    SubNetwork      NetAn_ODBC     ROP
    Verify columns displayed    SubNetwork
	Click on Save Report
	${report_name}=    Enter details to save report to library    Report.    Public    test
	Click on Save report to Library button
	Verify saved report available in Report manager GUI     ${report_name}    Public   test
    Verify that the report is saved to the DB     ${report_name}
    
verify the drop down for Flex counter is set to 'Custom'
	wait until page contains element    xpath:(//div[@name='valueCellCanvas']//div[@row='1' and @column='0'])[2]    300
	${pdf_kpi_name}=    Get text     xpath:(//div[@name='valueCellCanvas']//div[@row='1' and @column='0'])[2]
	wait until page contains element    xpath:(//div[@name='valueCellCanvas']//div[@row='1' and @column='0'])[2]    300
	Click element    xpath:(//div[@name='valueCellCanvas']//div[@row='1' and @column='0'])[2]
	wait until element is enabled     xpath:(//div[@title="All"])[2]    30
	click element    xpath:(//div[@title="All"])[2]
	wait until element is visible    xpath:(//div[@title="Custom"])[1]    5
	click element   xpath:(//div[@title="Custom"])[1]
	click on scroll down button    18    8 
	click on button    Refresh filter list
	click on scroll down button    18    20 
	click on button     Apply flex filter settings	
	
Verify that the chosen measure type changes the available measures list 
	Select the measure type    COUNTER
	wait until element is visible    xpath: ((//div[@class="valueCellCanvas"])[2])//div//div    300
	${text}=    selenium2library.get text    xpath: ((//div[@class="valueCellCanvas"])[2])//div//div
	Log    ${text}
	click on scroll up button       9        25
	Select the measure type    PDF_COUNTER,RI,FLEX_COUNTER,FLEX_PDF
	wait until element is visible    xpath: ((//div[@class="valueCellCanvas"])[2])//div//div     300
	${text1}=    selenium2library.get text    xpath: ((//div[@class="valueCellCanvas"])[2])//div//div
	Log    ${text1}
	should not be equal    ${text1}    ${text}
	click on scroll up button       9        25
	Select the measure type    ERICSSON_KPI,CUSTOM_KPI
	Capture Page Screenshot
	
	
Verify if all pages are updated when click on update all pages check box
    [Arguments]     ${report_name}    ${Aggregation}
    Wait Until Page Contains Element       xpath:(//div[@class="ComboBoxTextDivContainer"])[1]           timeout=1500
    Click Element    xpath:(//div[@class="ComboBoxTextDivContainer"])[1]
    Wait Until Page Contains Element       xpath: //div[contains(@class,'sf-element-dropdown-list-item') and @title='${report_name}:pm_DC_E_ERBS_EUTRANCELLTDD_FLEX_${Aggregation}(No Aggregation Level)__NetAn_ODBC']           timeout=120
    element should be visible    xpath: //div[contains(@class,'sf-element-dropdown-list-item') and @title='${report_name}:pm_DC_E_ERBS_EUTRANCELLTDD_FLEX_${Aggregation}(No Aggregation Level)__NetAn_ODBC']
    wait for page to load
    capture page screenshot
	
Enter the time period details
	[Arguments]       ${number}      ${month}
	Click on scroll down button     7     2
	@{element}=    Get WebElements	    xpath: //input[@class="sf-element sf-element-control sfc-property sfc-text-box"]
	${scroll_button}=        Get from list     ${element}    11
	Clear Element Text      ${scroll_button}
	Sleep   5s
	Selenium2Library.Input Text     ${scroll_button}     ${number} 
	Sleep     2s
	@{element}=    Get WebElements	    xpath: //div[@class='ComboBoxTextDivContainer']
	${Aggregation_ele}=        Get from list     ${element}    7
	Click element     ${Aggregation_ele}
	Wait Until Page Contains Element       xpath://div[@title='${month}']          timeout=10
	Click element      xpath://div[@title='${month}']	


Navigate to next page and verify the data
	[Arguments]     ${search_page}
	Sleep      10s
    Click element      xpath: //div[@class='ComboBoxTextDivContainer']
	Sleep   2s
	Click element      xpath://div[@title='${search_page}']
	Sleep   20s
	Verify that the Report has data  																																								 	


Verify the available filters
	change the mode to     Editing
	${status}=    run keyword and return status     Element Should Be Visible    xpath: //*[@class="sf-element sf-element-panel-header sfpc-top"]	
	Log     ${status}
	IF    "${status}"=="False"
		Wait Until Element Is Visible     xpath: //*[@id="Spotfire.FilterPanel"]    300
		Click element     xpath: //*[@id="Spotfire.FilterPanel"]
	END
	${status}=    run keyword and return status     Element Should Not Be Visible    xpath: //*[@class="TableHeader sf-element-filter-table-group-title FilterHeader"]//*[@title="Datetime Interval Definitions"]
	Should Be Equal     '${status}'     'True'
	Wait Until Element Is Visible     xpath: //*[@id="Spotfire.FilterPanel"]    300
	Click element     xpath: //*[@id="Spotfire.FilterPanel"]
	Capture Page Screenshot

Verify the available filters in all other pages
	Wait Until Page Contains Element      xpath:(//div[@class="ComboBoxTextDivContainer"])[1]    1500
	Click element      xpath:(//div[@class="ComboBoxTextDivContainer"])[1]
	sleep    2
	Wait Until Page Contains Element      xpath:(((//div[@class="ScrollArea"])[5])//div[contains(text(),'Report')])[1]    100
	Click element      xpath:(((//div[@class="ScrollArea"])[5])//div[contains(text(),'Report')])[1]
	sleep    20														   
	Verify the available filters
	sleep    5
	Wait Until Page Contains Element      xpath:(//div[@class="ComboBoxTextDivContainer"])[1]    100
	Click element      xpath:(//div[@class="ComboBoxTextDivContainer"])[1]
	sleep    2
	Wait Until Page Contains Element      xpath:(((//div[@class="ScrollArea"])[5])//div[contains(text(),'Report')])[2]    100
	Click element      xpath:(((//div[@class="ScrollArea"])[5])//div[contains(text(),'Report')])[2]
	sleep    20
	Verify the available filters
	sleep    5
	Wait Until Page Contains Element      xpath:(//div[@class="ComboBoxTextDivContainer"])[1]    100
	Click element      xpath:(//div[@class="ComboBoxTextDivContainer"])[1]
	sleep    2
	Wait Until Page Contains Element      xpath:((//div[@class="ScrollArea"])//div[contains(text(),'Report')])[3]    100
	Click element      xpath:((//div[@class="ScrollArea"])//div[contains(text(),'Report')])[3]
	sleep    20
	Verify the available filters
	wait for page to load

################################################ EQEV-125672 #################################	

Set PDFbinValues to	
    [Arguments]     ${binvalue}
    Sleep      2s
    Click on scroll down button     18    2
    @{element}=    Get WebElements      xpath://div[@name='valueCellCanvas']//div[@row='1' and @column='0']                                        
    ${ele}=        Get from list     ${element}    1
    Click element      ${ele}  
    Sleep      2s   
    @{element}=    Get WebElements	    xpath: //div[@class='ComboBoxTextDivContainer']
    ${filter_type_ele}=        Get from list     ${element}    9
    Click element     ${filter_type_ele}
    Click element      xpath://div[@title='${binvalue}']
    sleep     2s
    capture page screenshot

Search for bin_value in index text box
	[Arguments]     ${binvalue}
	Click on scroll down button     18    3
	Selenium2Library.Input Text     xpath:(//input[contains(@class,'sf-element sf-element-control sfc-property sfc-text-box')])[29]    ${binvalue} 
	Sleep     5s
	Click on scroll down button     18    4
	Click element       xpath://input[@value='Apply PDF settings']
		
Click on Ignore Null Values check box
    ${status}=     Run Keyword And Return Status        Element should be visible          xpath://div[@title='Ignore Null Values']
    Run keyword if  ${status}==True  Click element    xpath://div[@title='Ignore Null Values']	
	
Verify given column is not available 	
	[Arguments]     ${input_name}	
	Mouse Over      xpath://div[@class="valueCellsContainer"]	
	Element should not be visible       xpath://*[contains(text(),'${input_name}')]	
	
Switch report page
    [Arguments]     ${report_name}
    Wait Until Page Contains Element       xpath:(//div[@class="ComboBoxTextDivContainer"])[1]           timeout=1500
    Click Element    xpath:(//div[@class="ComboBoxTextDivContainer"])[1]
    Wait Until Page Contains Element       xpath: //div[@title='${report_name}']           timeout=120
    Sleep      5s
    Click Element    xpath: //div[@title='${report_name}']
    wait for page to load
    capture page screenshot
	
Check whether the given value is present in the DCVECTOR_INDEX column
	[Arguments]       ${bin}       ${check}
	Sleep      3s
	Click Element    xpath://div[contains(text(),'DCVECTOR_INDEX')]
	Sleep      3s
    Click Element    xpath://div[@title = 'Sort by this column from highest to lowest value (Shift+click).']
	IF       ${check}==0		
		Wait Until Element Is Not Visible    xpath:(//div[@class="valueCellCanvas"])//div//div[@column="1"]//div[contains(text(),'${bin}')]    150
	ELSE
		Wait Until Element Is Visible    xpath:(//div[@class="valueCellCanvas"])//div//div[@column="1"]//div[contains(text(),'${bin}')]    150
	END	  
	
Fill the row count
    [Arguments]     ${count}
	Clear Element Text      xpath://input[contains(@class,'sf-element sf-element-control sfc-property sfc-text-box')][1]
	Selenium2Library.Input Text     xpath://input[contains(@class,'sf-element sf-element-control sfc-property sfc-text-box')][1]     ${count} 
	press key      xpath://input[contains(@class,'sf-element sf-element-control sfc-property sfc-text-box')][1]     \\13
	sleep    5s
	Capture page screenshot
	
verify that node name updated in all pages
	[Arguments]     ${Node}
	Wait Until Page Contains Element      xpath:(//div[@class="ComboBoxTextDivContainer"])[1]    1500
	Click element      xpath:(//div[@class="ComboBoxTextDivContainer"])[1]
	sleep    2
	Wait Until Page Contains Element      xpath:(((//div[@class="ScrollArea"])[5])//div[contains(text(),'__NetAn_ODBC')])    100
	Click element      xpath:(((//div[@class="ScrollArea"])[5])//div[contains(text(),'__NetAn_ODBC')])
	sleep    20
    Check the Show Selection Panel checkbox	
    sleep     1s 
    click on the scroll down button    8    12
	sleep     2																   
	element should be visible    xpath:(//div[@class="sf-element-list-box-item sfpc-selected" and @title="${Node}"])
	sleep    5
	Wait Until Page Contains Element      xpath:(//div[@class="ComboBoxTextDivContainer"])[1]    100
	Click element      xpath:(//div[@class="ComboBoxTextDivContainer"])[1]
	sleep    2
	Wait Until Page Contains Element      xpath:(((//div[@class="ScrollArea"])[5])//div[contains(text(),'__NetAn_ODBC_FLEXPIVOT')])    100
	Click element      xpath:(((//div[@class="ScrollArea"])[5])//div[contains(text(),'__NetAn_ODBC_FLEXPIVOT')])
	sleep    20
	Check the Show Selection Panel checkbox
	sleep     1s  
	click on the scroll down button    8    12
	element should be visible    xpath:(//div[@class="sf-element-list-box-item sfpc-selected" and @title="${Node}"])
	sleep    5
	Wait Until Page Contains Element      xpath:(//div[@class="ComboBoxTextDivContainer"])[1]    100
	Click element      xpath:(//div[@class="ComboBoxTextDivContainer"])[1]
	wait for page to load
	capture page screenshot
	
Verify the row counts to be same as given in measure selection page
    [Arguments]     ${count}
	${text}=    set variable    ${count} of ${count} rows
	${text1}=      Get text      xpath:(//div[@class="${sfx_label}"])[1]
	Log      ${text1}
	should be equal    ${text}    ${text1}
	Capture page screenshot

Verify the row counts in all the pages
    [Arguments]     ${count}
	Wait Until Page Contains Element      xpath:(//div[@class="ComboBoxTextDivContainer"])[1]    1500
	Click element      xpath:(//div[@class="ComboBoxTextDivContainer"])[1]
	sleep    2
	Wait Until Page Contains Element      xpath:(((//div[@class="ScrollArea"])[5])//div[contains(text(),'Report')])[1]    100
	Click element      xpath:(((//div[@class="ScrollArea"])[5])//div[contains(text(),'Report')])[1]
	wait for page to load
	Check the Show Selection Panel checkbox
	sleep     2s	
	click element      xpath:(//div[@class="valueCellsContainer"])[1]
	sleep     5s										   
	Verify the row counts to be same as given in measure selection page     ${count}
	sleep    5
	Wait Until Page Contains Element      xpath:(//div[@class="ComboBoxTextDivContainer"])[1]    100
	Click element      xpath:(//div[@class="ComboBoxTextDivContainer"])[1]
	sleep    2
	Wait Until Page Contains Element      xpath:(((//div[@class="ScrollArea"])[5])//div[contains(text(),'Report')])[2]    100
	Click element      xpath:(((//div[@class="ScrollArea"])[5])//div[contains(text(),'Report')])[2]
	sleep      20s
	Check the Show Selection Panel checkbox
	wait for page to load
	click element      xpath:(//div[@class="valueCellsContainer"])[1]
	sleep    5s
	Verify the row counts to be same as given in measure selection page     ${count}
	sleep    5
	wait for page to load

click on information link button
	Wait Until Page Contains Element      xpath://*[@value="Create Information Link(s)"]     timeout=1500
	Click Element      xpath://*[@value="Create Information Link(s)"]
	Sleep    10s
	capture page screenshot
	
Check for the error notification is not present
	Click Element      xpath://*[@title="Notifications"]
	Sleep    3s
	${notification}=    Get text    xpath://div[@class='${notification_container}']
	Should contain          ${notification}         There are currently no notifications	
	
Select MOClass as empty and verify error message and fetch pmdata button is disbaled
    Click on scroll up button     9    20
	sleep     2s
    Click on scroll down button     9    5
    Clear Element Text     xpath:(//input[@class='SearchInput sf-element-input sf-suppress-forms-accept-command sf-suppress-forms-cancel-command sf-input-with-placeholder'])[4]
    Selenium2Library.Input Text     xpath:(//input[@class='SearchInput sf-element-input sf-suppress-forms-accept-command sf-suppress-forms-cancel-command sf-input-with-placeholder'])[4]    (Epmty) 
    sleep    5
    Click on scroll down button     9    1
	sleep    1
    Click on scroll up button     9    1
    Capture page screenshot
	wait for page to load
    Click element      xpath:(//*[contains(text(),'(Empty)')])[3]
    sleep    1s
    Click on scroll down button     9    8
    sleep    2s
	Element should be visible     xpath:(//*[contains(text(),'Select Valid MO Class')])
    Click on scroll up button     9    8
    wait for page to load
	Verify if fetch pm data button is disabled
	element should not be visible    xpath://div[@row="1" and @column="0"]
    Click element      xpath:(//div[contains(@title,'(All)')])[4]
    Click on scroll down button     9    25
	sleep    2s
    wait for page to load
    Capture page screenshot
	
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
			  
Verify integrity of new counter type
	[Arguments]    ${measure_list}     ${sql1}     ${sql2}     ${sql3}     ${sql4}
	@{list}=      Split string      ${measure_list}    ,
	${count}=     set variable    1
	${date_value}=        Get cell value     DATETIME_ID      1
	# @{date}=      Split string      ${date_id}
	# ${date_value}=      Get from list     ${date}    0
	${moid}=        Get cell value     SN      1
	${DCVECTOR_INDEX}=        Get cell value        DCVECTOR_INDEX    1
	${FLEX_FILTERHASHINDEX}=        Get cell value    FLEX_FILTERHASHINDEX    1
	selenium2library.mouse over    xpath://*[contains(text(),'OSS_ID')]
	sleep    2
	Run keyword and return status       Click on the scroll right button     0     50
	FOR    ${measure}    IN    @{list}
		${measure_value}=     Get cell value     PMEBSUACBARRINGPROB      1
		Log       ${measure_value}            
		Log       ${sql${count}}
		
		${date_value}=    convert date    ${date_value}    result_format=%Y-%m-%d %H:%M:%S  date_format=%m/%d/%Y %I:%M:%S %p
		${query}=    replace string    ${sql${count}}    DATETIME_VALUE    \'${date_value}\'    
		${query}=    replace string    ${query}    UNIQUE_ID_VALUE    \'${moid}\'
		${query}=    replace string    ${query}    DCVECTOR_INDEX_VALUE    \'${DCVECTOR_INDEX}\'
		${query}=    replace string    ${query}    FLEX_FILTERHASHINDEX_VALUE    \'${FLEX_FILTERHASHINDEX}\'

		${db_values}=      Query Sybase database     ${query}
		Log        ${db_values}
		${db_value}=    Verify Element In List        ${db_values}        ${measure_value}
		Log        ${db_value}
		${db_value}=    convert to string      ${db_value}
		Should Contain        ${db_value}      ${measure_value}
	END								