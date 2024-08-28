*** Keywords ***

#### RPO-LTE ###

open ran performance lte overview analysis
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
    Go To    ${base_url}${rpo_lte_url}
    sleep    10
    ${IsElementVisible}=    Run Keyword And Return Status    Element Should not be Visible    xpath://div[contains(text(),'Missing Data')]
	Run Keyword If    ${IsElementVisible} is ${FALSE}   Close missing data window
	sleep    30
    wait for page to load
    capture page screenshot
    
Navigate to the section
    [Arguments]     ${section}
	${count}=       set variable      0
	place the cursor on    Latest ROP
	Click on maximise window button    0
	Sleep      5s	
	FOR    ${i}    IN RANGE    0     30
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

place the cursor on
	[Arguments]    ${text}
	mouse over    xpath://*[contains(text(),'${text}')]
	wait for page to load
    Capture page screenshot
    
Click on maximise window button
    [Arguments]  ${button}
    @{element}=    Get WebElements	    xpath: //div[@title='Maximize visualization']
    ${max_button}=        Get from list     ${element}     ${button}
    Click element     ${max_button}
    
Click on Next Button
    Click element  	    xpath: //div[@title='Next']								
Close missing data window
	Wait Until Page Contains Element      xpath://span[contains(text(),'Apply to all inaccessible data tables in this analysis')]     timeout=150
    Click Element    xpath://span[contains(text(),'Apply to all inaccessible data tables in this analysis')]
    sleep    5
    Wait Until Page Contains Element      xpath://button[contains(text(),'OK')]     timeout=150
    Click Element    xpath://button[contains(text(),'OK')]
    
wait for page to load
    Sleep   5s
    Wait Until Element Is Not Visible     class:sfx_progress-bar-container_1118        timeout=2400
    Sleep   3s   
    Wait Until Element Is Not Visible     class:sfx_progress-bar-container_1118        timeout=2400
    Sleep   3s
    
verify that the Network Analytics logo is visible
	element should be visible    xpath:((//div[@class="HtmlTextArea sf-enable-selection sf-focusable"])//div//div//div//table//tbody//tr//td//p//img)[1]
	wait for page to load
	capture page screenshot	
	
verify that the Ran Performance Overview logo is visible
	element should be visible    xpath:((//div[@class="HtmlTextArea sf-enable-selection sf-focusable"])//div//div//div//table//tbody//tr//td//p//img)[2]
   	wait for page to load
	capture page screenshot
	
verify that the reset button is visible
	element should be visible    xpath://*[@title="Reset All Filters and Markings"]
	wait for page to load
	capture page screenshot
	
verify that the button is visible
	[Arguments]    ${button}
	element should be visible    xpath://*[@value="${button}"]
	wait for page to load
	capture page screenshot
	
verify that the button is present
	[Arguments]    ${button}
	element should be visible    xpath://*[@title="${button}"]
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
	
click button
	[Arguments]    ${buttonPartialValue}
	sleep     5
	Wait Until Element Is Visible     xpath: //*[contains(@value,'${buttonPartialValue}')]    300
    Click element     xpath: //*[contains(@value,'${buttonPartialValue}')]
	wait for page to load
	capture page screenshot	
	
 	
	
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
    
make selection in worst performing nodes
	Selenium2Library.Drag And Drop by Offset 	xpath://div[@class="sf-element-canvas-image sfc-transition-background"]    -100    -50
	wait for page to load
	capture page screenshot
	
read the marked value
	${markedValue}=    Selenium2Library.get text 	xpath://div[@class="sfx_label_223"][2]
	[Return]    ${markedValue}
	wait for page to load
	capture page screenshot
	
verify that the marked value is not equal to
	[Arguments]    ${markedValue}
	${newMarked}=    Selenium2Library.get text 	xpath://div[@class="sfx_label_223"][2]
	should not be equal    ${newMarked}    ${markedValue}
	wait for page to load
	capture page screenshot
	
Go to home page if not already at home
	${pageTitle}=    Selenium2Library.Get text  xpath: //*[@class="sfx_page-title_219"]
	IF 		"${pageTitle}" != "Home"	
		Click element     xpath: //*[@title="Return to Home"]
	END
	wait for page to load
	capture page screenshot
	
select the KPI Initial E-RAB Establishment SR (%)
	Wait Until Element Is Visible     xpath: //div[@class="ComboBoxTextDivContainer"]    300
    Click element     xpath: //div[@class="ComboBoxTextDivContainer"]
    sleep    2
	Wait Until Element Is Visible     xpath://*[@class="sf-element-dropdown-list-item"]    300
	sleep    2
    Click element     xpath:/html/body/div[2]/div/div/div/div[1]/div/div/div[3]
    wait for page to load
	capture page screenshot
	
select the KPI
	[Arguments]    ${kpi}
	Wait Until Element Is Visible     xpath: //div[@class="ComboBoxTextDivContainer"]    300
    Click element     xpath: //div[@class="ComboBoxTextDivContainer"]
    sleep    2
	Wait Until Element Is Visible     xpath://*[@title="${kpi}"]    300
	sleep    2
    Click element     xpath: //*[@title="${kpi}"]
	wait for page to load
	capture page screenshot
	
verify that the title of the map is
	[Arguments]    ${mapTitle}
	${title}=    Selenium2Library.Get text  xpath://div[@class="flex-item flex-align-start sf-element sf-element-text-box sf-single-line-text"]
	[Return]    ${title}
	should contain    ${title}    ${mapTitle}    
	wait for page to load
	capture page screenshot
	
select a KPI for KPI Information
	[Arguments]    ${kpi}
	Wait Until Element Is Visible     xpath: //div[@title="${kpi}"]    300
    Click element     xpath: //div[@title="${kpi}"]
	wait for page to load
	capture page screenshot
	
verify that the graph heading contains
	[Arguments]    ${graphTitle}
	${title}=    Selenium2Library.Get text  xpath://div[@class="flex-item flex-align-start sf-element sf-element-text-box sf-single-line-text"]
	[Return]    ${title}
	should contain    ${title}    ${graphTitle}  
	wait for page to load
	capture page screenshot
	
KPI summary for 24-hours and Month is visible
	[Arguments]    ${graphTitle}
	element should be visible    xpath://div[@class="sf-element sf-element-visualization-description sfpc-top"]
	${title}=    Selenium2Library.Get text    xpath://div[@class="sf-element sf-element-visualization-description sfpc-top"]
	[Return]    ${title}
	should contain    ${title}    ${graphTitle}
	wait for page to load
	capture page screenshot
	
select a counter
	[Arguments]    ${counter}
	Wait Until Element Is Visible     xpath: //div[@title="${counter}"]    300
    Click element     xpath: //div[@title="${counter}"]
	wait for page to load
	capture page screenshot
	
verify that table is visible for the selected nodes
	element should be visible    xpath://div[@title="DC_E_ERBS_EUTRANCELLFDD_RAW"]
	element should be visible    xpath://div[@title="DC_E_ERBS_EUTRANCELLFDD_DAY"]
	element should be visible    xpath://div[@title="DC_E_ERBS_EVENTS_EUTRANCELLFDD_V (Worst Performing Nodes)"]
	element should be visible    xpath://div[@title="DIM_E_LTE_SITE"]
	wait for page to load
	capture page screenshot
	
select a KPI
	[Arguments]    ${kpi}
	Wait Until Element Is Visible     xpath: //div[@class="ComboBoxTextDivContainer"]    300
	sleep    2
    Click element     xpath: //div[@class="ComboBoxTextDivContainer"]
    sleep    2
    Wait Until Element Is Visible     xpath: //div[@title='${kpi}']    300
    sleep    2
    Click element     xpath: //div[@title='${kpi}']
	wait for page to load
	capture page screenshot
	
select nodes
	[Arguments]    ${node_list}
    @{list}=      Split string      ${node_list}    ,
     FOR    ${node}    IN    @{list}
           Clear Element Text      xpath://input[contains(@class,'sf-element sf-element-control sfc-property sfc-text-box')]
           sleep    1
           Click element    xpath://input[contains(@class,'sf-element sf-element-control sfc-property sfc-text-box')]
           sleep    2
           Selenium2Library.Input Text     xpath://input[contains(@class,'sf-element sf-element-control sfc-property sfc-text-box')]     ${node} 
           press keys     xpath://input[contains(@class,'sf-element sf-element-control sfc-property sfc-text-box')]     ENTER
           sleep    2s
           wait for page to load
           Click element      xpath://div[@title='${node}']      modifier=CTRL
           sleep   1s
     END
    wait for page to load
	capture page screenshot
	
select a node
	Wait Until Element Is Visible     xpath:(//div[@class="sf-element-list-box-item"])[1]    30
	click element    xpath:(//div[@class="sf-element-list-box-item"])[1]
	wait for page to load
	capture page screenshot
     
verify that data is visible for the selected nodes
	element should be visible    xpath://div[@title="DC_E_ERBS_EUTRANCELLFDD_RAW"]
	element should be visible    xpath://div[@title="DC_E_ERBS_EUTRANCELLFDD_DAY"]
	element should be visible    xpath://div[@title="DC_E_ERBS_EVENTS_EUTRANCELLFDD_V (Node Information)"]
	wait for page to load
	capture page screenshot
	
#### RPO-WCDMA ####
	
open ran performance wcdma overview analysis
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
    Go To    ${base_url}${rpo_wcdma_url}
    sleep    10
    ${IsElementVisible}=    Run Keyword And Return Status    Element Should not be Visible    xpath://div[contains(text(),'Missing Data')]
	Run Keyword If    ${IsElementVisible} is ${FALSE}   Close missing data window
    wait for page to load
    capture page screenshot
    
verify that 14 KPIs are available in 3 categories
	element should be visible    xpath://div[@class="sf-element sf-element-visual sfc-text-area sfpc-first-column sfpc-last-column"]
	element should be visible    xpath://div[@class="sf-element sf-element-visual-content sfc-text-area"]
	${title}=    Selenium2Library.Get text    xpath://div[@class="sf-element sf-element-visual sfc-text-area sfpc-first-column sfpc-last-column"]
	[Return]    ${title}
	should be equal    ${title}    Service Utilization KPIs
	element should be visible    xpath://div[@class="sf-element sf-element-visual sfc-text-area sfpc-first-column sfpc-last-column"][2]
	${title1}=    Selenium2Library.Get text    xpath://div[@class="sf-element sf-element-visual sfc-text-area sfpc-first-column sfpc-last-column"][2]
	[Return]    ${title1}
	should be equal    ${title1}    Mobility and Accessibility KPIs
	element should be visible    xpath://div[@class="sf-element sf-element-visual sfc-text-area sfpc-first-column sfpc-last-column"][4]
	${title2}=    Selenium2Library.Get text    xpath://div[@class="sf-element sf-element-visual sfc-text-area sfpc-first-column sfpc-last-column"][4]
	[Return]    ${title2}
	should be equal    ${title2}    Quality of Service KPIs
	wait for page to load
    capture page screenshot
    
select a QoS KPI
	[Arguments]    ${kpi}
	Click on the scroll down button    3    2
	Click element      xpath:/html/body/div/div[2]/div/div[1]/div/div/div[2]/div/div/div/div/div/div/div/div/div[6]/div/div/div[1]/p[2]/span/div/div[2]/div
	click on the button    ${kpi}
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
	
click on QoS KPI Details button
	Click element      xpath://input[@value="QoS KPI Details "]
	wait for page to load
	capture page screenshot
	
read the date and time
	${dateTime}=    Selenium2Library.Get text    xpath://span[@class="EmbeddedMiniatureVisualization"]
	[Return]    ${dateTime}
	wait for page to load
	capture page screenshot
	
read the nodeName and measureValue
	Mouse Move    ${IMAGE_DIR}\\RPO_Read_KPI_Values.PNG
	sleep    3
	${data}=    Selenium2Library.Get text    xpath://div[@class="sf-tooltip sf-plot-tooltip RoundedDropShadow"]
	Log    ${data}
	${splitData}=    split string    ${data}    :
	Log    ${splitData}
	${measure}=    Get From List    ${splitData}    2
	${nodeName}=    Get From List    ${splitData}    1
	${nodeName1}=    split string from right    ${nodeName}    \n
	${node}=    Get From List    ${nodeName1}    0
	[Return]    ${node}    ${measure}
	wait for page to load
	capture page screenshot


##########################    WCDMA     #######################################	

verify that the Ran Performance Overview WCDMA logo is visible
	element should be visible    xpath:((//div[@class="HtmlTextArea sf-enable-selection sf-focusable"])//div//div//div//table//tbody//tr//td//p//img)[2]
   	wait for page to load
	capture page screenshot	
	
Click on Home button
	Wait Until Element Is Visible     xpath: //*[@title='Home']    300
    Click element     xpath: //*[@title='Home']
	wait for page to load
	capture page screenshot

verify that the Network Analytics logo is visible in RPO-WCDMA
	element should be visible    xpath:((//div[@class="HtmlTextArea sf-enable-selection sf-focusable"])//div//div//div//table//tbody//tr//td//p//img)[1]
	wait for page to load
	capture page screenshot		

verify "Latest ROP" and "Data availability" is visible in the top-right portion	
    element should be visible    xpath:(//*[text()='Latest ROP ']/../..//SPAN)[5]
    ${title}=    Selenium2Library.Get text    xpath://*[@class="HtmlTextArea sf-enable-selection sf-focusable"]/span[1]/font
	[Return]    ${title}
	should be equal    ${title}    Latest ROP 
    element should be visible    xpath:(//FONT[text()='Data availabilty ']/../..//SPAN)[10]
    ${title}=    Selenium2Library.Get text    xpath://*[@class="HtmlTextArea sf-enable-selection sf-focusable"]/span[3]/font
	[Return]    ${title}
	should be equal    ${title}    Data availabilty 
	wait for page to load
	capture page screenshot
	
verify KPIs of Service Utilization	
	element should be visible    xpath://*[@title="Average session length for data connections (PacketintHs_U_MHT)"] 
	element should be visible    xpath://*[@title="Total traffic volume (Packetint_U_Trafficvolume)"] 
	element should be visible    xpath:(//*[@class='flex-item flex-align-start sf-element sf-element-text-box sf-single-line-text'])[2]
	element should be visible    xpath://*[@title="EUL traffic volume (PacketintEul_U_Trafficvolume)"] 
	element should be visible    xpath://*[@title="Speech erlang (Speech_U_User)"]
	wait for page to load
	capture page screenshot
    
verify data in charts of Utilization	
    element should be visible    xpath:(//*[@class='sf-element sf-element-visual-content sfc-line-chart sfc-trellis-visualization'])[1]	
    element should be visible    xpath:(//*[@class='sf-element sf-element-visual-content sfc-line-chart sfc-trellis-visualization'])[2]	
    element should be visible    xpath:(//*[@class='sf-element sf-element-visual-content sfc-line-chart sfc-trellis-visualization'])[3]	
    element should be visible    xpath:(//*[@class='sf-element sf-element-visual-content sfc-line-chart sfc-trellis-visualization'])[4]	
    element should be visible    xpath:(//*[@class='sf-element sf-element-visual-content sfc-line-chart sfc-trellis-visualization'])[5]
    wait for page to load
	capture page screenshot

verify detailed data in charts of Details Page
    element should be visible    xpath://*[@class='sf-element sf-element-visual sfc-bar-chart sfc-trellis-visualization sfpc-first-column'][1]
    element should be visible    xpath://*[@class='sf-element sf-element-visual sfc-bar-chart sfc-trellis-visualization sfpc-first-column'][2] 
    wait for page to load
	capture page screenshot
verify pages displayed on left hand side of settings page
   ${text}=         Selenium2library.Get text        xpath://div[@id='id52']
   Log        ${text} 
   Should contain         ${text}          Pages:
   Should contain         ${text}          Overview
   Should contain         ${text}          Quality of Service
   Should contain         ${text}          Utilization
   Should contain         ${text}          Mobility And Accessibility
   Should contain         ${text}          Favorites
   Should contain         ${text}          Play Settings
   
verify display duration is displayed in settings page
    Click on the scroll down button    3    10
    sleep     2s
    Element Should Be Enabled        xpath://*[text()='Display duration (seconds):']
    Element Should Be Enabled        xpath://div[@class='SliderContainer']
    
verify favorites is displayed with KPIs in settings page
    ${text}=         Selenium2library.Get text        xpath://div[@id='id46']
    Log        ${text} 
    Should contain         ${text}          Favorites:
    Should contain         ${text}          KPI Favorite 1
    Should contain         ${text}          KPI Favorite 2
    Should contain         ${text}          KPI Favorite 3
    Should contain         ${text}          KPI Favorite 4
    Should contain         ${text}          KPI Favorite 5

Select KPI Favourite
    [Arguments]     ${no}       ${KPI}
    @{element}=    Get WebElements	    xpath: //div[@class='ComboBoxTextDivContainer']
    ${ele}=        Get from list     ${element}    			${no}
    Click element         ${ele}
    sleep  2s
    Click element             xpath://div[@title='${KPI}']
    sleep    10s
    
verify favorites page contains KPI information
    [Arguments]     ${KPI}
    Element Should Be Enabled        xpath://div[contains(text(),'${KPI}')]
      
Select page in settings
    [Arguments]     ${page}
    Click element             //div[@title='${page}']
    sleep     2s
      
	
verify KPIs of Quality of Service
	element should be visible    xpath://*[@title="Speech drop rate (Speech R)"] 
    element should be visible    xpath://*[@title="HS connection drop rate (PacketintHs_R)"] 
    element should be visible    xpath://*[@title="Cell throughput (PacketintHs_I_DlTp)"] 	
    element should be visible    xpath://*[@title="Cell availability (AV)"] 	
	wait for page to load
	capture page screenshot

verify data in charts of Quality of Service KPIs
	element should be visible    xpath:(//*[@class='sf-element sf-element-visual-content sfc-line-chart sfc-trellis-visualization'])[1]	
    element should be visible    xpath:(//*[@class='sf-element sf-element-visual-content sfc-line-chart sfc-trellis-visualization'])[2]	
    element should be visible    xpath:(//*[@class='sf-element sf-element-visual-content sfc-line-chart sfc-trellis-visualization'])[3]	
    element should be visible    xpath:(//*[@class='sf-element sf-element-visual-content sfc-line-chart sfc-trellis-visualization'])[4]
	wait for page to load
	capture page screenshot
	
################### WCDMA-DataIntegrity ###################
	
get sql query from json file
    [Arguments]     ${json_file}     ${data}
    ${json}=    OperatingSystem.get file    ${json_file}
    &{object}=    Evaluate     json.loads('''${json}''')     json
    [return]       ${object}[${data}]
	wait for page to load
	capture page screenshot
	
replace values in the query
	[Arguments]    ${sql_query}    ${dateTime}    ${node}
	Log    ${node}
	${node}=    catenate    SEPARATOR=    %    ${node}
	${node}=    Remove String    ${node}    ${SPACE}    ${EMPTY}
	${AmPm}    ${dateTime}=    Get AMPM and DateTime from DateTime Stamp    ${dateTime}   
	${Date_Val}    Convert Date    ${dateTime}    result_format=%Y-%m-%d %H:%M    date_format=%m/%d/%Y %H:%M
	${Date_Val}=    Add AMPM to DateTime Stamp    ${AmPm}    ${Date_Val}
	${sql_query}=     Replace String    ${sql_query}    @uiDate      \'${Date_Val}\'
	${sql_query}=     Replace String    ${sql_query}    @uiNode      \'${node}\'
    log    ${sql_query}
    [Return]    ${sql_query}
	wait for page to load
    capture page screenshot
    
Match UI with DB RPO Value
	[Arguments]    ${uiValue}    ${DB_Value}
	Log    ${DB_Value}
	${dbValue}=    get from list    ${DB_Value}    0
	Log    ${dbValue}
	${dbValue1}=    convert to string    ${dbValue}
	${dbValue1}=    split string    ${dbValue1}    '
	${dbValue1}=    get from list    ${dbValue1}    1
	${uiValue}=    Remove everything after decimal point from measure value    ${uiValue}
	Log    ${uiValue}
	${dbValue1}=    Remove everything after decimal point from measure value    ${dbValue1}
	Log    ${dbValue1}
	Compare UI and DB values    ${uiValue}     ${dbValue1}
	
Compare UI and DB values
	[Arguments]       ${UI}     ${DB}
    Log    ${UI}
    Log    ${DB}
    should be equal     ${DB}   ${UI}
    
read the nodeName and measureValue from current week chart
	#Mouse Move    ${IMAGE_DIR}\\RPO_Read_KPI_Values.PNG
	Selenium2Library.Drag And Drop    xpath:(//div[@class="sf-element sf-element-canvas-visualization"])[2]    xpath:(//div[@class="sf-element sf-element-canvas-visualization"])[1]
																																											 
	sleep    3
	${data}=    Selenium2Library.Get text    xpath://div[@class="sf-tooltip sf-plot-tooltip RoundedDropShadow"]
	Log    ${data}
	${splitData}=    split string    ${data}    :
	Log    ${splitData}
	${measure}=    Get From List    ${splitData}    2
	${nodeName}=    Get From List    ${splitData}    1
	${nodeName1}=    split string from right    ${nodeName}    \n
	${node}=    Get From List    ${nodeName1}    0
	[Return]    ${node}    ${measure}
	wait for page to load
	capture page screenshot
	
read the nodeName and measureValue from last week chart
	Mouse Move    ${IMAGE_DIR}\\RPO_Read_Pastweek_KPI.PNG
	sleep    3
	${data}=    Selenium2Library.Get text    xpath://div[@class="sf-tooltip sf-plot-tooltip RoundedDropShadow"]
	Log    ${data}
	${splitData}=    split string    ${data}    :
	Log    ${splitData}
	${measure}=    Get From List    ${splitData}    2
	${nodeName}=    Get From List    ${splitData}    1
	${nodeName1}=    split string from right    ${nodeName}    \n
	${node}=    Get From List    ${nodeName1}    0
	[Return]    ${node}    ${measure}
	wait for page to load
	capture page screenshot
	
read the nodeName and measureValue from past week chart
	mouse over    xpath:/html/body/div/div[2]/div/div[1]/div/div/div[2]/div/div/div/div/div/div/div/div/div[4]/div[1]/div/div/div[1]/div[2]
	sleep    3
	${data}=    Selenium2Library.Get text    xpath://div[@class="sf-tooltip sf-plot-tooltip RoundedDropShadow"]
	Log    ${data}
	${splitData}=    split string    ${data}    :
	Log    ${splitData}
	${measure}=    Get From List    ${splitData}    2
	${nodeName}=    Get From List    ${splitData}    1
	${nodeName1}=    split string from right    ${nodeName}    \n
	${node}=    Get From List    ${nodeName1}    0
	[Return]    ${node}    ${measure}
	wait for page to load
	capture page screenshot
	
select a Utilization KPI
	[Arguments]    ${kpi}
	Click on the scroll down button    3    2
	Click element      xpath:/html/body/div/div[2]/div/div[1]/div/div/div[2]/div/div/div/div/div/div/div/div/div[6]/div/div/div[1]/p[2]/span/div/div[2]/div
	click on the button    ${kpi}
	wait for page to load
	capture page screenshot
	
read the nodeName and measureValue from current week Utilization chart
	Mouse Move    ${IMAGE_DIR}\\RPO_Utilization_KPI.PNG
	sleep    3
	${data}=    Selenium2Library.Get text    xpath://div[@class="sf-tooltip sf-plot-tooltip RoundedDropShadow"]
	Log    ${data}
	${splitData}=    split string    ${data}    :
	Log    ${splitData}
	${measure}=    Get From List    ${splitData}    2
	${nodeName}=    Get From List    ${splitData}    1
	${nodeName1}=    split string from right    ${nodeName}    \n
	${node}=    Get From List    ${nodeName1}    0
	[Return]    ${node}    ${measure}
	wait for page to load
	capture page screenshot
	
select the pages for dashboard
	[Arguments]    ${list}
	@{pages}=    split string    ${list}    ,
	click element    xpath://div[@title="Overview"]
	FOR    ${page}     IN    @{pages}
		click element    xpath://div[@title="${page}"]    modifier=CTRL
		sleep    2
	END
	wait for page to load
	capture page screenshot
	
decrease the display duration
	[Arguments]    ${n}    ${button}
	@{element}=    Get WebElements	    xpath:/html/body/div/div[2]/div/div[1]/div/div/div[2]/div/div/div/div/div/div/div/div/div[3]/div/div/div[1]/div/div[3]/span/div/div/div[2]
    ${scroll_button}=        Get from list     ${element}    ${button}
    FOR    ${i}    IN RANGE    0    ${n} 
           Click element     ${scroll_button}           
    END
    wait for page to load
	capture page screenshot
	
Verify the page titles in Play Dashboard
	wait for page to load
	FOR    ${i}    IN RANGE    0    4
		${text}=    Selenium2Library.Get text  xpath: //*[@class="sfx_page-title_219"]
		Log    ${text}
		should contain    Overview,Quality of Service,Utilization    ${text}
		sleep    10
	END
	wait for page to load
	capture page screenshot

select a KPI with index
	[Arguments]    ${kpi}	${index}
	Wait Until Element Is Visible     xpath: (//div[@class="ComboBoxTextDivContainer"])[${index}]    300
	sleep    2
    Click element     xpath: (//div[@class="ComboBoxTextDivContainer"])[${index}]
    sleep    2
    Wait Until Element Is Visible     xpath: //div[@title='${kpi}']    300
    sleep    2
    Click element     xpath: //div[@title='${kpi}']
	wait for page to load
	capture page screenshot
	
Select 5 favorite KPIs under Favorites
	select a KPI with index		Speech accessibility	1	
	select a KPI with index		Data accessibility		2
	select a KPI with index		Speech drop rate	3
	click on the scroll down button    1    10
	select a KPI with index		Share of speech calls handed over to GSM	4
	select a KPI with index		Cell availability	 5
	
	
verify five selected KPIs of Settings page is visible in favorites page
	validate selected kpi in setting page by passing index		5		Speech accessibility
	validate selected kpi in setting page by passing index		1		Data accessibility
	validate selected kpi in setting page by passing index		2		Speech drop rate
	validate selected kpi in setting page by passing index		3		Share of speech calls handed over to GSM
	validate selected kpi in setting page by passing index		4		Cell availability
	
validate selected kpi in setting page by passing index	
	[Arguments]    	${index}	${kpi}
	element should be visible    xpath:(//div[@class="flex-item flex-align-start sf-element sf-element-text-box sf-single-line-text"])[${index}]
	${title}=    Selenium2Library.Get text    xpath:(//div[@class="flex-item flex-align-start sf-element sf-element-text-box sf-single-line-text"])[${index}]
	[Return]    ${title}
	should contain    ${title}    ${kpi}	ignore_case=True
	wait for page to load
	capture page screenshot
	
Select another 5 favorite KPIs under Favorites	
	select a KPI with index		HS connection drop rate		1	
	select a KPI with index		Total traffic volume		2
	select a KPI with index		HS traffic volume	3
	click on the scroll down button    1    10
	select a KPI with index		Average session length for data connections		4
	select a KPI with index		Cell throughput	  5
	
	
verify selected KPIs is visible in Settings page 
	validate selected kpi in setting page by passing index		5		HS connection drop rate
	validate selected kpi in setting page by passing index		1		Total traffic volume
	validate selected kpi in setting page by passing index		2		HS traffic volume
	validate selected kpi in setting page by passing index		3		Average session length for data connections
	validate selected kpi in setting page by passing index		4		Cell throughput
	
click on Mobility and Accessibility KPI Details
	Wait Until Element Is Visible     xpath:(//input[@class="sf-element sf-element-control sfc-action sfc-action-button"])[2]    30
    sleep    2
    Click element     xpath:(//input[@class="sf-element sf-element-control sfc-action sfc-action-button"])[2]
    wait for page to load
	capture page screenshot
	
select a Mobility and Accessibility KPI
	[Arguments]    ${kpi}
	Click on the scroll down button    3    2
	Click element      xpath:(//div[@class="ComboBoxTextDivContainer"])[2]
	click on the button    ${kpi}
	wait for page to load
	capture page screenshot
	
read the nodeName and measureValue from current week Mobility and Accessibility chart
	SikuliLibrary.Mouse Move    ${IMAGE_DIR}\\RPO_Mobility_KPI.PNG
	sleep    3
	${data}=    Selenium2Library.Get text    xpath://div[@class="sf-tooltip sf-plot-tooltip RoundedDropShadow"]
	Log    ${data}
	${splitData}=    split string    ${data}    :
	Log    ${splitData}
	${measure}=    Get From List    ${splitData}    2
	${nodeName}=    Get From List    ${splitData}    1
	${nodeName1}=    split string from right    ${nodeName}    \n
	${node}=    Get From List    ${nodeName1}    0
	[Return]    ${node}    ${measure}
	wait for page to load
	capture page screenshot
	
Latest ROP and Data Availability should be visible in the top-right portion
	${text}=    selenium2library.get text    xpath:(//div[@class="HtmlTextArea sf-enable-selection sf-focusable"])[3]
	should contain    ${text}    Latest ROP
	should contain    ${text}    Data availabilty 
	wait for page to load
	capture page screenshot
	
verify KPIs of Mobility and Accessibility
	element should be visible    xpath://*[@title="Speech accessibility (Speech_A)"] 
	element should be visible    xpath://*[@title="Data accessibility (Packetint_A)"] 
	element should be visible    xpath://*[@title="Handover to GSM success rate for speech (Speech_M_IRATHO)"] 
	element should be visible    xpath://*[@title="Share of speech calls handed over to GSM (Speech_M_IRATHO_GSM_AR)"]
	element should be visible    xpath://*[@title="Share of speech calls originating from CS fall back from LTE (Speech_M_CSFB_AR)"]
	wait for page to load
	capture page screenshot
	
Then verify data in charts of Mobility and Accessibility
	element should be visible    xpath:(//div[@class="sf-element sf-element-canvas-visualization"])[1]
	element should be visible    xpath:(//div[@class="sf-element sf-element-canvas-visualization"])[2]
	element should be visible    xpath:(//div[@class="sf-element sf-element-canvas-visualization"])[3]
	element should be visible    xpath:(//div[@class="sf-element sf-element-canvas-visualization"])[4]
	element should be visible    xpath:(//div[@class="sf-element sf-element-canvas-visualization"])[5]
	wait for page to load
	capture page screenshot
	
Verify detailed data in charts
	Selenium2Library.Drag And Drop by Offset 	xpath:(//div[@class="sf-element sf-element-canvas-visualization"])[1]    70    -70
	${markedValue}=    Selenium2Library.get text 	xpath://div[@class="sfx_label_223"][2]
	sleep    5
	[Return]    ${markedValue}
	should not be equal    ${markedValue}    0 rows
	wait for page to load
	capture page screenshot