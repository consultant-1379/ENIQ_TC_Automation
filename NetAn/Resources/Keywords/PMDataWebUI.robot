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
    Selenium2Library.Input Text    name:username    Administrator
    Selenium2Library.Input Text    name:password    Ericsson01
    Click Element    class:LoginButton
    Sleep    5
    Go To    ${base_url}${nodes_and_services_url}	
	sleep    20
	${IsElementVisible}=    Run Keyword And Return Status    Element Should be Visible     xpath://*[@title='Auto WEB_PLAYER']
	Run Keyword If    ${IsElementVisible} is ${FALSE}   run keyword and ignore error   Navigate to Auto WEB_PLAYER
	
	
	
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
    @{element}=    Get WebElements      xpath://button[@id='tss-dropdown-menu']
	FOR    ${ele}    IN    @{element}
		${text}=       Selenium2library.Get text       ${ele}
		Run keyword if      "${text}"=="Update service"      Click on Update service button      ${ele}
		Run keyword if      "${text}"=="Update service"      exit for loop
	END
   
   
Click on Update service button 
    [Arguments]      ${ele}
    Click element     ${ele}
    sleep     2s
    @{element}=    Get WebElements      xpath://button[@id='tss-dropdown-menu']
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
    Should contain     Status Service installed successfully              ${text} 
    	
Install the latest PM Data package
	${ps_file}    Set Variable    ${EXEC_DIR}\\ENIQ_TC_Automation\\NetAn\\Other\\Files\\PMDataInstallation.ps1
	${result}=    Run    Powershell -NoProfile -ExecutionPolicy Unrestricted -Command "& {Start-Process PowerShell -ArgumentList '-NoProfile -ExecutionPolicy Unrestricted -File ""${ps_file}"""' -Verb RunAs}";
    
execute the command
	[Arguments]    ${command}
	Remove file    ${EXEC_DIR}\\ENIQ_TC_Automation\\NetAn\\Other\\Files\\commandFile.ps1
    Append to file    ${EXEC_DIR}\\ENIQ_TC_Automation\\NetAn\\Other\\Files\\commandFile.ps1    ${command} | Out-File -FilePath "${EXEC_DIR}\\ENIQ_TC_Automation\\NetAn\\Other\\Files\\logFile.txt"
    ${ps_file}    Set Variable    ${EXEC_DIR}\\ENIQ_TC_Automation\\NetAn\\Other\\Files\\commandFile.ps1
    ${result}=    Run    Powershell -NoProfile -ExecutionPolicy Unrestricted -Command "& {Start-Process PowerShell -ArgumentList '-NoProfile -ExecutionPolicy Unrestricted -File ""${ps_file}""' -Verb RunAs}";
    ${fileContents}=    OperatingSystem.Get file    ${EXEC_DIR}\\ENIQ_TC_Automation\\NetAn\\Other\\Files\\logFile.txt    encoding=UTF-16
    Log    ${fileContents}
    [Return]    ${fileContents}
  
verify that the pm data package has been installed
	${logs}=    execute the command    get-features
	${chrome_options}=    Evaluate    sys.modules['selenium.webdriver'].ChromeOptions()      sys
	Call Method    ${chrome_options}    add_argument    --ignore-certificate-errors
	Create Webdriver    Chrome    executable_path=${EXEC_DIR}/ENIQ_TC_Automation/NetAn/Resources/Drivers/chromedriver.exe      chrome_options=${chrome_options}
    Go To    https://arm1s11-eiffel013.eiffel.gic.ericsson.se:8443/nexus/content/repositories/assure-releases/com/ericsson/eniq/netanserver/features/network-analytics-pm-data/
	@{element}=    Get WebElements	    xpath: ((//table[@cellspacing="10"])//tbody//tr)
	${ele}=     Get from list     ${element}    -4
	${text}=    selenium2library.get text    ${ele}
	Log    ${text}
	@{textList}=    split string    ${text}    /
	${text}=    get from list    ${textList}    0
	Log    ${text}
	Log    ${logs}
	should contain    ${logs}    ${text}
	
click on the button
	[Arguments]    ${pageTitle}
	sleep     5
	Wait Until Element Is Visible     xpath: //*[@title='${pageTitle}']    300
    ${status}=    run keyword and return status    Click element     xpath: //*[@title='${pageTitle}']
    IF    "${status}"=="FALSE"
    	Wait Until Page Is Loaded
    	Click element     xpath: //*[@title='${pageTitle}']
    END
	Wait Until Page Is Loaded
	capture page screenshot
	
open counter mapping table in pm-data
	${chrome_options}=    Evaluate    sys.modules['selenium.webdriver'].ChromeOptions()      sys
	Call Method    ${chrome_options}    add_argument    --ignore-certificate-errors
	Create Webdriver    Chrome    options=${chrome_options}
    Go To    ${base_url}   
    Maximize Browser Window
    Sleep    5
    Selenium2Library.Input Text    name:username    Administrator
    Selenium2Library.Input Text    name:password    Ericsson01
    Click Element    class:LoginButton
	Sleep    5
    Go To    ${base_url}${counter_mapping}
    click on the button    Spotfire library
    Wait Until Element Is Visible     xpath: (//div[@class="sfx_title_614 sfx_one-line_581" and contains(text(),'Ericsson Library')])    30
    Double Click element     xpath: (//div[@class="sfx_title_614 sfx_one-line_581" and contains(text(),'Ericsson Library')])
    Wait Until Element Is Visible     xpath: (//div[@class="sfx_title_614 sfx_one-line_581" and contains(text(),'General')])    30
    Double Click element     xpath: (//div[@class="sfx_title_614 sfx_one-line_581" and contains(text(),'General')])
    Wait Until Element Is Visible     xpath: (//div[@class="sfx_title_614 sfx_one-line_581" and contains(text(),'PM Data')])    30
    Double Click element     xpath: (//div[@class="sfx_title_614 sfx_one-line_581" and contains(text(),'PM Data')])
    Wait Until Element Is Visible     xpath: (//div[@class="sfx_title_614 sfx_one-line_581" and contains(text(),'PM-Data')])    30
    Double Click element     xpath: (//div[@class="sfx_title_614 sfx_one-line_581" and contains(text(),'PM-Data')])
    Wait Until Element Is Visible     xpath: (//div[@class="sfx_title_614 sfx_one-line_581" and contains(text(),'Analysis')])    30
    Double Click element     xpath: (//div[@class="sfx_title_614 sfx_one-line_581" and contains(text(),'Analysis')])
    Wait Until Element Is Visible     xpath: (//div[@class="sfx_title_614 sfx_one-line_581" and contains(text(),'Counter Mapping')])    30
    Double Click element     xpath: (//div[@class="sfx_title_614 sfx_one-line_581" and contains(text(),'Counter Mapping')])
    click on the button    OK
    click on the button    Start from visualizations
    Wait Until Element Is Visible     xpath: ((//div[@class="sfx_section_307"])//div)[1]    30
    Click element     xpath: ((//div[@class="sfx_section_307"])//div)[1]
    Wait Until Element Is Visible     xpath: (//div[@title="Counter Mapping"])    60
    capture page screenshot
    
filter the counter values with
    [Arguments]    ${nodeType}
    click on the button    Data in analysis
    wait until page contains element    xpath: (//div[@class="sfx_item-text_811 sf-element-text-box" and contains(text(),'NODETYPE')])     30
    ${status}=    run keyword and return status    element should be visible    xpath: (//div[@class="sfx_item-text_811 sf-element-text-box" and contains(text(),'NODETYPE')])
    Run keyword if    ${status}==False    Click on the scroll down button    1    10 
    mouse over    xpath: (//div[@class="sfx_item-text_811 sf-element-text-box" and contains(text(),'NODETYPE')])
    wait until element is visible    xpath: ((((//div[@class="sfx_item-content_804 sfx_body-item-content_794" and div[1]="NODETYPE"])//div)[7])//div[@title="Show filter"])    30
    click element    xpath: ((((//div[@class="sfx_item-content_804 sfx_body-item-content_794" and div[1]="NODETYPE"])//div)[7])//div[@title="Show filter"])
    wait until element is visible    xpath: (//input[@class="SearchInput sf-element-input sf-suppress-forms-accept-command sf-suppress-forms-cancel-command sf-input-with-placeholder"])    30
    Clear Element Text      xpath: (//input[@class="SearchInput sf-element-input sf-suppress-forms-accept-command sf-suppress-forms-cancel-command sf-input-with-placeholder"])
    input text    xpath: (//input[@class="SearchInput sf-element-input sf-suppress-forms-accept-command sf-suppress-forms-cancel-command sf-input-with-placeholder"])    ${nodeType}
    click on the button    Click to search
    wait until element is visible    xpath: ((//div[@class="ListItems"])//div[@title="${nodeType}"])    30
    click element    xpath: ((//div[@class="ListItems"])//div[@title="${nodeType}"])
    Wait Until Page Is Loaded
    click on the button    Data in analysis
    ${text}=    Get Text    xpath://*[@class="sfx_label_223"][1]
    Log    ${text}
    @{rowList}=    split string from right    ${text}    separator=\ of
    ${text}=    Remove String    ${rowList}[0]    ,													
    [Return]    ${text}
    should not be equal    ${text}    0 of 0 rows
    capture page screenshot
    
Click on the scroll down button
    [Arguments]     ${button}    ${n}
    @{element}=    Get WebElements	    xpath: //div[@class="ScrollbarButton sf-element sf-element-scroll-bar-button sfpc-bottom"]
    ${scroll_button}=        Get from list     ${element}    ${button}
    FOR    ${i}    IN RANGE    0    ${n} 
           Run Keyword and Ignore Error    Click element     ${scroll_button}           
    END
    Wait Until Page Is Loaded
	capture page screenshot
	
get sql query from json file
    [Arguments]     ${json_file}     ${data}
    ${json}=    OperatingSystem.get file    ${json_file}
    &{object}=    Evaluate     json.loads('''${json}''')     json
    [return]       ${object}[${data}]
	Wait Until Page Is Loaded
	capture page screenshot
	
verify that the same count is present in ENIQ DB
	[Arguments]    ${rows}    ${query}
	${dbOutput}=    Query ENIQ DB REPDB    ${query}
	${dbOutput}=    convert to string    ${dbOutput}
	${status}=    run keyword and return status    should contain    ${dbOutput}    ${rows}
	
open measure mapping table in pm-data
	${chrome_options}=    Evaluate    sys.modules['selenium.webdriver'].ChromeOptions()      sys
	Call Method    ${chrome_options}    add_argument    --ignore-certificate-errors
	Create Webdriver    Chrome    options=${chrome_options}
    Go To    ${base_url}   
    Maximize Browser Window
    Sleep    5
    Selenium2Library.Input Text    name:username    Administrator
    Selenium2Library.Input Text    name:password    Ericsson01
    Click Element    class:LoginButton
	Sleep    5
    Go To    ${base_url}${counter_mapping}
    click on the button    Spotfire library
    Wait Until Element Is Visible     xpath: (//div[@class="sfx_title_614 sfx_one-line_581" and contains(text(),'Ericsson Library')])    30
    Double Click element     xpath: (//div[@class="sfx_title_614 sfx_one-line_581" and contains(text(),'Ericsson Library')])
    Wait Until Element Is Visible     xpath: (//div[@class="sfx_title_614 sfx_one-line_581" and contains(text(),'General')])    30
    Double Click element     xpath: (//div[@class="sfx_title_614 sfx_one-line_581" and contains(text(),'General')])
    Wait Until Element Is Visible     xpath: (//div[@class="sfx_title_614 sfx_one-line_581" and contains(text(),'PM Data')])    30
    Double Click element     xpath: (//div[@class="sfx_title_614 sfx_one-line_581" and contains(text(),'PM Data')])
    Wait Until Element Is Visible     xpath: (//div[@class="sfx_title_614 sfx_one-line_581" and contains(text(),'PM-Data')])    30
    Double Click element     xpath: (//div[@class="sfx_title_614 sfx_one-line_581" and contains(text(),'PM-Data')])
    Wait Until Element Is Visible     xpath: (//div[@class="sfx_title_614 sfx_one-line_581" and contains(text(),'Analysis')])    30
    Double Click element     xpath: (//div[@class="sfx_title_614 sfx_one-line_581" and contains(text(),'Analysis')])
    Wait Until Element Is Visible     xpath: (//div[@class="sfx_title_614 sfx_one-line_581" and text()="Measure Mapping"])    30
    Double Click element     xpath: (//div[@class="sfx_title_614 sfx_one-line_581" and text()="Measure Mapping"])
    click on the button    OK
    click on the button    Start from visualizations
    Wait Until Element Is Visible     xpath: ((//div[@class="sfx_section_307"])//div)[1]    30
    Click element     xpath: ((//div[@class="sfx_section_307"])//div)[1]
    Wait Until Element Is Visible     xpath: (//div[@title="Measure Mapping"])    60
    capture page screenshot
	
filter the measure values with
    [Arguments]    ${nodeType}
    click on the button    Data in analysis
    ${status}=    run keyword and return status    element should be visible    xpath: (//div[@class="sfx_item-text_811 sf-element-text-box" and contains(text(),'Measures')])
    Run keyword if    ${status}==False    Click on the scroll down button    1    10 
    mouse over    xpath: (//div[@class="sfx_item-text_811 sf-element-text-box" and contains(text(),'Measures')])
    wait until element is visible    xpath: ((((//div[@class="sfx_item-content_804 sfx_body-item-content_794" and div[1]="NODETYPE"])//div)[7])//div[@title="Show filter"])    30
    click element    xpath: ((((//div[@class="sfx_item-content_804 sfx_body-item-content_794" and div[1]="NODETYPE"])//div)[7])//div[@title="Show filter"])
    wait until element is visible    xpath: (//input[@class="SearchInput sf-element-input sf-suppress-forms-accept-command sf-suppress-forms-cancel-command sf-input-with-placeholder"])    30
    Clear Element Text      xpath: (//input[@class="SearchInput sf-element-input sf-suppress-forms-accept-command sf-suppress-forms-cancel-command sf-input-with-placeholder"])
    input text    xpath: (//input[@class="SearchInput sf-element-input sf-suppress-forms-accept-command sf-suppress-forms-cancel-command sf-input-with-placeholder"])    ${nodeType}
    click on the button    Click to search
    wait until element is visible    xpath: ((//div[@class="ListItems"])//div[@title="${nodeType}"])    30
    click element    xpath: ((//div[@class="ListItems"])//div[@title="${nodeType}"])
    Wait Until Page Is Loaded
    click on the button    Data in analysis
    ${text}=    Get Text    xpath://*[@class="sfx_label_223"][1]
    Log    ${text}
    @{rowList}=    split string from right    ${text}    separator=\ of
    ${text}=    set variable    ${rowList}[0]    
    [Return]    ${text}
    should not be equal    ${text}    0 of 0 rows
    capture page screenshot	 
    
get formula for the KPI
    [Arguments]     ${json_file}     ${data}
    ${json}=    OperatingSystem.get file    ${json_file}
    &{object}=    Evaluate     json.loads('''${json}''')     json
    [return]       ${object}[${data}]
	
read the formula for selected KPI
	[Arguments]    ${nodeType}
	wait until element is visible    xpath: ((//div[@class="valueCellCanvas"])//div//div[@row="1" and @column="1"])    30
	${formula}=    selenium2library.get text    xpath: ((//div[@class="valueCellCanvas"])//div//div[@row="1" and @column="1"])
	Log    ${formula}
	Run keyword if    "${formula}"=="${nodeType}"     ${formula}=    selenium2library.get text    xpath: ((//div[@class="valueCellCanvas"])//div//div[@row="1" and @column="4"])
	[Return]    ${formula}
	
verify that the formula from Measures.csv matched the formula from Analysis
	[Arguments]     ${formulaCSV}     ${formulaPMEx}
	${formulaCSV}=    Convert To Uppercase    ${formulaCSV}
	${formulaCSV}=    Replace String    ${formulaCSV}    SUM    ${EMPTY}
	${formulaCSV}=    Replace String    ${formulaCSV}    (    ${EMPTY}
	${formulaCSV}=    Replace String    ${formulaCSV}    )    ${EMPTY}
	${formulaPMEx}=    Convert To Uppercase    ${formulaPMEx}
	${formulaPMEx}=    Replace String    ${formulaPMEx}    SUM    ${EMPTY}
	${formulaPMEx}=    Replace String    ${formulaPMEx}    (    ${EMPTY}
	${formulaPMEx}=    Replace String    ${formulaPMEx}    )    ${EMPTY}
	Log    ${formulaCSV}
	Log    ${formulaPMEx}
	${status}=    run keyword and return status    should be equal    ${formulaCSV}    ${formulaPMEx}
	
put cursor on
	[Arguments]    ${text}
	mouse over    xpath: (//div[@title="${text}"])
	Wait Until Page Is Loaded
	capture page screenshot
	
verify that the measure is present in PMEx
	[Arguments]    ${measure}
	@{list}=      Split string      ${measure}     ,  
    FOR    ${kpi}    IN    @{list}
           Clear Element Text      xpath://input[contains(@class,'sf-element sf-element-input sf-input-with-placeholder')]
           Selenium2Library.Input Text     xpath://input[contains(@class,'sf-element sf-element-input sf-input-with-placeholder')]     ${kpi} 
           press keys      xpath://input[contains(@class,'sf-element sf-element-input sf-input-with-placeholder')]     ENTER
           sleep    5s           
           ${text}=    Selenium2Library.Get text      xpath: (//div[@name='valueCellCanvas']//div[@row='1' and @column='0'])[1]
           Log    ${text}
           should contain    ${text}    ${kpi}    ignore_case=true
     END
	Wait Until Page Is Loaded
	capture page screenshot
	
verify that the measure is present in PMA
	[Arguments]    ${measureList}
	@{list}=      Split string      ${measureList}    ,
    FOR    ${measure}    IN    @{list}
           Clear Element Text      xpath: (//div[@class="sf-list-box-container VirtualListBox sf-suppress-forms-accept-command sf-suppress-forms-cancel-command sf-focusable"])[4]//input
		   Selenium2Library.Input Text     xpath: (//div[@class="sf-list-box-container VirtualListBox sf-suppress-forms-accept-command sf-suppress-forms-cancel-command sf-focusable"])[4]//input    ${measure}
		   press keys      xpath: (//div[@class="sf-list-box-container VirtualListBox sf-suppress-forms-accept-command sf-suppress-forms-cancel-command sf-focusable"])[4]//input     ENTER
           Wait Until Page Is Loaded
		   #element should be visible      xpath: //div[contains(text(),'${measure}')]    60		   
     END
	Wait Until Page Is Loaded
	capture page screenshot
	
select measure type
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
    Click on the scroll down button       5        21
    Wait Until Page Is Loaded
    capture page screenshot	

Suite setup steps for PMA and PMEX
	Set Screenshot Directory   ./Screenshots
    Set Selenium Implicit Wait        60s
    Install Utility mobule in web player
    Close Browser
    open PMEx analysis
    change mode to       Editing
	Connect to DB PMEx
	Save the analysis
	Close Browser
	open PMA analysis
	change mode to       Editing
	Connect to DB PMA
	Navigate to landing page
	Save the analysis
	Close browser
	
Click on Administration button in PMEx
    Wait Until Page Contains Element      xpath: //img[@title='Administration']     timeout=600
	Click on the scroll down button    0    15
    Click element     xpath://img[@title='Administration']
    Sleep    10
	Wait Until Page Contains Element       xpath: //input[@value='Sync with ENIQ']       timeout=1500
    Capture page screenshot	 
	
Navigate to landing page
    ${count}=      Get Element Count       xpath: //img[@title='Home']
    IF     ${count}>0
		  Navigate to section in PMA    Home						   
          Click element     xpath://img[@title='Home']
          Sleep    20s
    ELSE    
          minimize window    0
          sleep    5s  
    END
	
Save the analysis
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
    Wait Until Page Is Loaded	
	
change mode to
	[Arguments]    ${mode}
	Wait Until Page Contains Element      xpath: //div[@class='sfx_author-dropdown_506']     timeout=300
	Click element       xpath: //div[@class='sfx_author-dropdown_506']
	Wait Until Page Contains Element      xpath://div[@title='${mode}']     timeout=300
	Click Element      xpath://div[@title='${mode}']
    Run keyword IF    "${mode}"=="Editing"        Wait Until Element Is Visible      xpath://div[@title='Data in analysis']       timeout=1500
	Wait Until Page Is Loaded
	capture page screenshot
	
open PMA analysis
    ${chrome_options}=    Evaluate    sys.modules['selenium.webdriver'].ChromeOptions()      sys
	Call Method    ${chrome_options}    add_argument    --ignore-certificate-errors
	Create Webdriver    Chrome    options=${chrome_options}
    Go To    ${base_url}
    Maximize Browser Window   
    Sleep    5
    Selenium2Library.Input Text    name:username    Administrator
    Selenium2Library.Input Text    name:password    Ericsson01
    Selenium2Library.Click element    class:LoginButton
    Sleep    5
    Go To    ${base_url}${pma_url}
    sleep    15
    ${IsElementVisible}=    Run Keyword And Return Status    Element Should not be Visible    xpath://div[contains(text(),'Missing Data')]
	Run Keyword If    ${IsElementVisible} is ${FALSE}   Close missing data window
	run keyword and ignore error    Navigate to section in PMA    Home
	run keyword and ignore error    click on the button    Home															 
    Wait Until Page Contains Element      xpath://input[@value='Alarm Rules Manager']     timeout=1500
    Wait Until Page Is Loaded
    capture page screenshot
	
open PMEx analysis
    ${chrome_options}=    Evaluate    sys.modules['selenium.webdriver'].ChromeOptions()      sys
	Call Method    ${chrome_options}    add_argument    --ignore-certificate-errors
	Create Webdriver    Chrome    options=${chrome_options}
    Go To    ${base_url}   
    Maximize Browser Window
    Sleep    5
    Selenium2Library.Input Text    name:username    Administrator
    Selenium2Library.Input Text    name:password    Ericsson01
    Click Element    class:LoginButton
    Sleep    5
    Go To    ${base_url}${pmex_url}
    Wait Until Page Is Loaded
	Wait Until Page Contains Element      xpath: //input[@value='Report Manager']     timeout=1500
    capture page screenshot
	
Suite teardown steps for PMA and PMEX
	Close Browser

Test teardown steps for PMA and PMEX
	run keyword and ignore error    Close All Connections
	run keyword and ignore error    NetAnAdminUI.click on button    Logout
	run keyword and ignore error    Close Browser
    
Connect to DB PMEx
    Click on Administration button in PMEx
	Change Mode To     Editing
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
    Wait Until Page Is Loaded

    Click element     xpath: //input[@value='Sync with ENIQ']
    Sleep    80s
    Wait Until Page Is Loaded
    capture page screenshot
    Click element     xpath://img[@title='Home']
	Sleep     2
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
    Wait Until Page Is Loaded    
   
Connect to DB PMA
    [Arguments]     ${eniq_name}=NetAn_ODBC
    Click on Administration button in PMA
    Connect to DB in PMA     localhost       netanserver      Ericsson01     ${eniq_name}
    Click on Sync with Eniq in PMA
    
Click on Sync with Eniq in PMA
    Click on the scroll down button       5         1
	Sleep       2s
    Click element     xpath: //input[@value='Sync with ENIQ']
	Capture page screenshot
    Wait Until Page Is Loaded
    Sleep     5s
	Capture page screenshot
    
Click on Administration button in PMA
    Wait Until Page Contains Element      xpath: //img[@title='Administration']     timeout=1500
    Click element     xpath://img[@title='Administration']
    Sleep    20s
	capture page screenshot
	
click on next
	Wait Until Page Contains Element      xpath: (//div[@title="Next"])    30
	Click Element    xpath: (//div[@title="Next"])
	Wait Until Page Is Loaded
	capture page screenshot
	
minimize window
    [Arguments]  ${button}
    @{element}=    Get WebElements	    xpath: //div[@title='Restore visualization layout']
    ${min_button}=        Get from list     ${element}     ${button}
    Click element     ${min_button}
	
Navigate to section in PMA
    [Arguments]     ${section}
	${count}=       set variable      0
	move the cursor to    ENIQ Connection Status
	maximize window    1
	Sleep      5s	
	FOR    ${i}    IN RANGE    0     15
	    ${count}=     Get Element Count       xpath: //*[contains(text(),'${section}') or @title="${section}"]
         IF      ${count}>0
                 Exit for loop
	     ELSE
		         click on next
				 Sleep     3s
				 Capture page screenshot
         END
	END
	IF      ${count}==0  
		          FAIL     Section ${section} is not available in UI
	END
	
move the cursor to
	[Arguments]    ${text}
	Wait Until Page Contains Element    xpath://div[contains(text(),'${text}')]    120    
	mouse over    xpath://div[contains(text(),'${text}')]
	Wait Until Page Is Loaded
    Capture page screenshot
    
maximize window
    [Arguments]  ${button}
    @{element}=    Get WebElements	    xpath: //div[@title='Maximize visualization']
    ${max_button}=        Get from list     ${element}     ${button}
    Click element     ${max_button}
	
Connect to DB in PMA
    [Arguments]      ${url_value}      ${username_value}        ${password_value}      ${Eniq_DB_Value}      
    ${window}=      set variable       Setup Data Source
    Run keyword and ignore error    Wait Until Element Is Enabled          xpath: //div[@title='Restore visualization layout']      timeout=120s        
    Run keyword and ignore error    Click element      xpath: //div[@title='Restore visualization layout']
    Navigate to section in PMA         ${window} 
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
    Wait Until Page Is Loaded
    sleep   5s
    capture page screenshot
    minimize window     0
    Sleep     10s   
    
Wait Until Page Is Loaded
	Sleep   3s
	Wait Until Element Is Not Visible      xpath://*[@class='sf-svg-loader-12x12']              timeout=3000
    Wait Until Element Is Not Visible     class:sfx_progress-bar-container_1118       timeout=3000
    Sleep   2s
    Wait Until Element Is Not Visible     class:sfx_progress-bar-container_1118       timeout=3000
    Sleep   2s    
    
open adminui page
	${chrome_options}=    Evaluate    sys.modules['selenium.webdriver'].ChromeOptions()      sys
	Call Method    ${chrome_options}    add_argument    --ignore-certificate-errors
	Create Webdriver    Chrome    options=${chrome_options}
    Go To    ${adminui}   
    Maximize Browser Window
    Sleep    5
    Selenium2Library.Input Text    name:userName    eniq	
    Selenium2Library.Input Text    name:userPassword    Eniq@1234
    Click Element    name:submit
    ${IsElementVisible}=    Run Keyword And Return Status     alert should be present    Alert Text: Engine is set to NoLoads
    Run Keyword If    ${IsElementVisible}    handle alert    accept
    capture page screenshot 
    
run command
	[Arguments]    ${command}
	Write    ${command}
	${logs}=    Read    delay=10s
	Log    ${logs}
	[Return]    ${logs}
    
Open Connection And Log In
	[Arguments]    ${puttyServer}    ${puttyPort}    ${puttyUserName}    ${puttyPassword}
	${index}=    run keyword and ignore error    Open Connection    host=${puttyServer}    port=${puttyPort}    timeout=10
    run keyword and ignore error    Set Global Variable    ${index}
    run keyword and ignore error    Login    ${puttyUserName}    ${puttyPassword} 
    
Reset everything if changed and login to dcuser
	run command    su - dcuser
	run command    cd /eniq/home/dcuser
	${txt}=    run command    pwd
	Log    ${txt}
	should contain    ${txt}    /eniq/home/dcuser
	
Get the TP name and version from TP file
	[Arguments]    ${pkg}
    @{pkgList}=    Split String From Right    ${pkg}    separator=_R    max_split=1
    ${tpName}=    Set Variable    ${pkgList}[0]
    ${version}=    set variable    ${pkgList}[1]
    @{versionList}=    Split String from right    ${version}    separator=.tpi    max_split=1
    ${version}=    set variable    ${versionList}[0]
    Set Global Variable    ${tpName}
    Set Global Variable    ${version} 
    
check if the TP file already exists and return status
	[Arguments]    ${pkg}
	${status}=    run command    ls -l /eniq/sw/installer/${pkg}
	Log    ${status}
	${status}=    run keyword and return status    should not contain    ${status}    ls: cannot access /eniq/sw/installer/${pkg}: No such file or directory
    Log    ${status}
    [Return]    ${status}
	
download and place the downloaded tpi file in the server
	[Arguments]    ${pkg}
	${chrome_options}=    Evaluate    sys.modules['selenium.webdriver'].ChromeOptions()      sys
	Call Method    ${chrome_options}    add_argument    --ignore-certificate-errors
	Create Webdriver    Chrome    options=${chrome_options}
	Go To    ${clearcase}
	Maximize Browser Window
    Click Link    xpath=//body//tr[last()-1]//td[2]//a   
    Click Link    xpath=//body//tr[last()-1]//td[2]//a   
    ${loc}    Get Location
    Go To    ${loc}SOLARIS_baseline.html
	${temp}=    Get Element Attribute    //table//a[text()='${tpName}']    href
    ${temp1}=    Fetch From Right    ${temp}    /
    Set Global Variable    ${pkg}    ${temp1}
    Click Link    xpath=//a[text()='${tpName}']
    OperatingSystem.Wait Until Created    C:\\Users\\Administrator\\Downloads\\${pkg}    timeout=40
	Put File    C:\\Users\\Administrator\\Downloads\\${pkg}    /eniq/sw/installer
	${status}=		Execute Command    test -f /eniq/sw/installer/${pkg} && echo True || echo False     
	IF  ${status}
		OperatingSystem.Remove File    C:\\Users\\Administrator\\Downloads\\${pkg}
	ELSE
		Log   	Techpack could not be transferred
	END
		
Install the techpack
	write    cd /eniq/sw/installer && ./tp_installer -p . -t ${tpName}
	${tpInstallationStatus}=    read    delay=60
	Log    ${tpInstallationStatus}
	
verify if the TechPack is installed in the server
	open adminui page
	Wait Until Element Is Visible     xpath:(//table[@class="menu"])//*[contains(text(),'TechPack Installation')]    300
    Click element     xpath:(//table[@class="menu"])//*[contains(text(),'TechPack Installation')]
    wait until element is visible    xpath: //b[contains(text(),'No Tech Pack Installation In Progress')]    60
	${status}=    run keyword and return status    element should be visible    xpath: //table//tbody//tr[(td[contains(text(),'${tpName}')]) and td[1]='${tpName}' and td[3]='R${version}']
	Wait Until Element Is Visible     xpath:(//table[@class="menu"])//*[contains(text(),'Logout')]    300
    Click element     xpath:(//table[@class="menu"])//*[contains(text(),'Logout')]
    [Return]    ${status}
    
verify that the TechPack is installed
 	open adminui page
	Wait Until Element Is Visible     xpath:(//table[@class="menu"])//*[contains(text(),'TechPack Installation')]    300
    Click element     xpath:(//table[@class="menu"])//*[contains(text(),'TechPack Installation')]
    wait until element is visible    xpath: //b[contains(text(),'No Tech Pack Installation In Progress')]    60
	element should be visible    xpath: //table//tbody//tr[(td[contains(text(),'${tpName}')]) and td[1]='${tpName}' and td[3]='R${version}']
	Wait Until Element Is Visible     xpath:(//table[@class="menu"])//*[contains(text(),'Logout')]    300
    Click element     xpath:(//table[@class="menu"])//*[contains(text(),'Logout')]
	
get data from CSV file for the KPI
	[Arguments]     ${fileName}    ${KPIName}
    ${csvFile}=    OperatingSystem.Get File    ${EXEC_DIR}\\ENIQ_TC_Automation\\NetAn\\Resources\\Data\\pm-data\\${fileName}
    @{read}=    Create List    ${csvFile}
    @{lines}=    Split To Lines    @{read}    1
    FOR    ${line_csv}    IN    @{lines}
    	Log    ${line_csv}
    	${status}=    run keyword and return status    should contain    ${line_csv}    ${KPIName}    ignore_case=true
    	set global variable    ${line_csv}
    	run keyword if    "${status}"=="True"    Exit For Loop
    END
    [Return]    ${line_csv}
    
get KPI formula and Table Information from CSV file   
	[Arguments]    ${data}
    @{kpiDetails}=    split string    ${data}    ,    max_split=2
    ${flag}    set variable    0
    FOR    ${i}    IN    @{kpiDetails}
    	Log    ${i}
    	${flag}=    evaluate    ${flag}+1
    	Log    ${flag}
    	run keyword if    ${flag}==3    set global variable    ${i}
    END
    ${kpiFormula}=    get from list    ${kpiDetails}    1
    Log    ${i}
    @{infoList}=    split string    ${i}    "
    FOR    ${j}    IN    @{infoList}
    	Log    ${j}
    END
    ${infoItem}=    get from List    ${infoList}      1
    Log    ${infoItem}
    Log    ${kpiFormula}
    [Return]    ${kpiFormula}    ${infoItem}
	
Verify data integrity of the measures in PMA
        [Arguments]    ${measure_list}     ${sql1}     ${sql2}     ${sql3}     ${sql4}
        @{list}=      Split string      ${measure_list}    ,
        ${count}=     set variable    1
        ${date_id}=        Get cell value     DATE_ID      1
        @{date}=      Split string      ${date_id}
        ${date_value}=      Get from list     ${date}    0
        ${time_value}=      Get from list     ${date}    1
        ${ampm}=      Get from list     ${date}    2
        ${moid}=        Get cell value     MOID      1
        selenium2library.mouse over    xpath://*[contains(text(),'OSS_ID')]
        sleep    2
        Click on scroll right button     0     50
        FOR    ${measure}    IN    @{list}
            ${measure_value}=     Get cell value     MEASUREVALUE_${count}      1
            Log       ${measure_value}            
            Log       ${sql${count}}
            Log       ${date_value}
            ${date_value}=    convert date    ${date_value}    result_format=%Y-%m-%d   date_format=%m/%d/%Y
            ${date_value}=    catenate    ${date_value}    ${time_value}
            ${date_value}=    catenate    ${date_value}    ${ampm}
            ${query}=    replace string    ${sql${count}}    DATETIME_VALUE    \'${date_value}\'    
            ${query}=    replace string    ${query}    UNIQUE_ID_VALUE    \'${moid}\'
            ${db_value}=      Query Sybase database     ${query}    
            Log        ${db_value}
            Should Contain        ${db_value}      ${measure_value}      
        END

verify that the columns used in KPI formula are present in Counters column and in DB
	[Arguments]    ${formula}    ${table}
	Log    ${table}
	${formula}=    convert to string    ${formula}
	@{counterList}=    split string    ${table}    ,
	FOR    ${counter}    IN    @{counterList}
		${counter}=    convert to string    ${counter}
		should contain    ${formula}    ${counter}    ignore_case=true
		@{query}=    split string    ${counter}    .
		${tableName}=    get from list    ${query}    0
		${columnName}=    get from list    ${query}    1
		${dbResult}=    query sybase database    sp_columns ${tableName}
		Log    ${dbResult} 
		${dbResult}=    convert to string    ${dbResult}
		should contain    ${dbResult}    ${columnName}    ignore_case=true
	END
	