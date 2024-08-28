*** Keywords ***

open lte kpi dashboard analysis
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
    Go To    ${base_url}${ltekpi_url}
    wait for page to load
	go to home page if not at home
	Wait Until Page Contains Element      xpath: (//input[@value="KPI Dashboard"])     timeout=600
    capture page screenshot
    
Close missing data window
	Wait Until Page Contains Element      xpath://span[contains(text(),'Apply to all inaccessible data tables in this analysis')]     timeout=150
    Click Element    xpath://span[contains(text(),'Apply to all inaccessible data tables in this analysis')]
    sleep    5
    Wait Until Page Contains Element      xpath://button[contains(text(),'OK')]     timeout=150
    Click Element    xpath://button[contains(text(),'OK')]
    wait for page to load
    capture page screenshot
	
verify the page title  
	[Arguments]     ${expectedText}
	wait for page to load
    ${text}=    Selenium2Library.Get text  xpath: //*[@class="sfx_page-title_219"]
    Log    ${text}
    ${status}=    run keyword and return status    Should be equal     ${text}    ${expectedText}
    IF    "${status}"=="FALSE"
    	wait for page to load
    	${text}=    Selenium2Library.Get text  xpath: //*[@class="sfx_page-title_219"]
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
	
Test teardown
    Capture page screenshot
    Close Browser
	
click on the button
	[Arguments]    ${pageTitle}
	sleep     5
	Wait Until Element Is Visible     xpath: //*[@title='${pageTitle}']    300
    ${status}=    run keyword and return status    Click element     xpath: //*[@title='${pageTitle}']
    IF    "${status}"=="FALSE"
    	sleep    30
    	Click element     xpath: //*[@title='${pageTitle}']
    END
	Sleep    10s
	wait for page to load
	capture page screenshot
	
click on button
	[Arguments]    ${buttonValue}
	sleep     5
	Wait Until Element Is Visible     xpath: //*[@value='${buttonValue}']    300
    ${status}=    run keyword and return status    Click element     xpath: //*[@value='${buttonValue}']
    IF    "${status}"=="FALSE"
    	sleep    30
    	Click element     xpath: //*[@value='${buttonValue}']
    END
	Sleep    10s
	wait for page to load
	capture page screenshot
	
execute the command
	[Arguments]    ${command}
    Write    ${command}
    ${output}=    Read    delay=2s
    Log     ${output}
    [Return]    ${output}
	
Suite setup steps for LTE KPI Dashboard
	Set Screenshot Directory   ./Screenshots
	Set Selenium Implicit Wait        60s
	
Suite teardown steps for LTE KPI Dashboard
    Close Browser
	
Test teardown steps for LTE KPI Dashboard
    Capture page screenshot
	Close Browser
    
wait for page to load
    Sleep   5s
	Wait Until Element Is Not Visible      xpath://*[@class='sf-svg-loader-12x12']              timeout=600
    Sleep    2s

add the KPI to selected KPIs
	[Arguments]    ${kpi}
	${status}=    run keyword and return status    element should be visible     xpath: (//div[@title="${kpi}"]) 
	IF    "${status}"=="False"
		FOR    ${i}    IN RANGE    0    4
			Run keyword if    "${i}"=="2"    Click on the scroll down button    5    20
			Click on the scroll down button    ${i}   3
			${status}=    run keyword and return status    element should be visible     xpath: (//div[@title="${kpi}"])   
			Run keyword if    "${status}"=="True"    exit for loop
			FOR    ${j}    IN RANGE    0    7		  
				IF    "${status}"=="False"
					Click on the scroll down button    ${i}   3		
					${status}=    run keyword and return status    element should be visible     xpath: (//div[@title="${kpi}"])
					Run keyword if    "${status}"=="True"    exit for loop
				END
			END
		END
	END
	sleep    2
	Wait Until Element Is Visible      xpath: (//div[@title="${kpi}"])    30
    Click element     xpath: (//div[@title="${kpi}"])
    Click on the scroll up button    5    30
    [Return]    ${kpi}
	wait for page to load
	capture page screenshot

add 'Initial E-RAB Establishment Success Rate for Emergency Calls' KPI to selected KPIs
	Click on the scroll down button    0   3
    Click element     xpath: (//div[@title="Initial E-RAB Establishment Success Rate for Emergency Calls"])
    Click on the scroll up button    5    30
	wait for page to load
	capture page screenshot
	
clear the Selected KPIs
	click on the scroll down button    5    20
	Wait Until Element Is Visible     xpath: //*[@value='Clear']    300
	click element    xpath: //*[@value='Clear']
	click on the scroll up button    5    20
	wait for page to load
	capture page screenshot
	
go to home page if not at home
	wait for page to load
	${pageTitle}=    Selenium2Library.Get text  xpath: //*[@class="sfx_page-title_219"]
	IF 		"${pageTitle}" != "Home"
        scroll element into view		xpath: //*[@title="Home"]
      	Click element     xpath: //*[@title="Home"]
	END
	Wait Until Element Is Visible     xpath://*[@class='sfx_page-title_219' and text()='Home']      1500
	wait for page to load
	capture page screenshot
	
Click on the scroll up button
    [Arguments]     ${button}    ${n}
    @{element}=    Get WebElements	    xpath: //div[@class="ScrollbarButton sf-element sf-element-scroll-bar-button sfpc-top"]
    ${scroll_button}=        Get from list     ${element}    ${button}
    FOR    ${i}    IN RANGE    0    ${n} 
           Run Keyword and Ignore Error    Click element     ${scroll_button}           
    END
    wait for page to load
	capture page screenshot
	
get sql query from json file
    [Arguments]     ${json_file}     ${data}
    ${json}=    OperatingSystem.get file    ${json_file}
    &{object}=    Evaluate     json.loads('''${json}''')     json
    [return]       ${object}[${data}]
	wait for page to load
	capture page screenshot
	
verify that the DB and UI values match
	[Arguments]    ${uiValue}    ${dbValue}
	${diff}=    Evaluate   ${uiValue}-${dbValue}
	Run keyword if      ${diff}>1 or ${diff}<-1      FAIL
	#${dbValue}=    convert to string    ${dbValue}
	#should contain    ${dbValue}    ${uiValue}
	#wait for page to load
	#capture page screenshot

Match UI with DB Value
	[Arguments]    ${uiValue}    ${DB_Value}
	Log    ${DB_Value}
	${dbValue}=    get from list    ${DB_Value}    0
	Log    ${dbValue}
	${dbValue1}=    convert to string    ${dbValue}
	${dbValue1}=    split string    ${dbValue1}    '
	${dbValue1}=    get from list    ${dbValue1}    1
	#${uiValue}=    Remove everything after decimal point from measure value    ${uiValue}
	Log    ${uiValue}
	#${dbValue1}=    Remove everything after decimal point from measure value    ${dbValue1}
	Log    ${dbValue1}
	${uiValue1}=       Convert to Number      ${uiValue}
	${dbValue2}=       Convert to Number      ${dbValue1}
	verify that the DB and UI values match    ${uiValue1}     ${dbValue2}

Remove everything after decimal point from measure value
	[Arguments]    ${value}
	${words}=    Split String	${value}    .
	Log 	${words}
	${formattedValue}=     Get From List    ${words}    0
	${formattedValue}=    Strip String    ${formattedValue}
	[return] 	${formattedValue}
	Log 	${formattedValue}

verify that 'Network View (Up to 7 Days)' chart is visible
	Wait Until Element Is Visible     xpath:(//div[@class="sf-element-canvas-image"])[1]    300
	element should be visible    xpath:(//div[@class="sf-element-canvas-image"])[1]
	capture page screenshot	
	
verify that 'Worst Performing Cells (Latest ROP)' chart is visible
	Wait Until Element Is Visible     xpath:(//div[@class="sf-element-canvas-image"])[2]    300
	element should be visible    xpath:(//div[@class="sf-element-canvas-image"])[2]
	capture page screenshot	
	
verify that 'Up to 7 Days' chart is visible
	Wait Until Element Is Visible     xpath:(//div[@class="sf-element-canvas-image"])[3]    300
	element should be visible    xpath:(//div[@class="sf-element-canvas-image"])[3]
	capture page screenshot
	
Make selection on worst performing cells(latest rop) chart
	Wait Until Element Is Visible      xpath: (//div[@class="sf-element-canvas-image"])[2]    300
	Selenium2Library.Drag And Drop by Offset 	xpath: (//div[@class="sf-element-canvas-image"])[2]    -160    -100
	wait until element is visible    xpath: //div[@class="sfx_label_223"][2]    300
	sleep    1
	${value}=    Selenium2Library.get text    xpath: //div[@class="sfx_label_223"][2]
	Log    ${value}
	IF    "${value}"=="0 marked"
		Wait Until Element Is Visible      xpath: (//div[@class="sf-element-canvas-image"])[2]    300
		Selenium2Library.Drag And Drop by Offset 	xpath: (//div[@class="sf-element-canvas-image"])[2]    -160    -100
		wait until element is visible    xpath: //div[@class="sfx_label_223"][2]    300
		sleep    1
		${value1}=    Selenium2Library.get text    xpath: //div[@class="sfx_label_223"][2]
		IF    "${value1}"=="0 marked"
			Wait Until Element Is Visible      xpath: (//div[@class="sf-element-canvas-image"])[2]    300
			Selenium2Library.Drag And Drop by Offset 	xpath: (//div[@class="sf-element-canvas-image"])[2]    -160    -100
			wait until element is visible    xpath: //div[@class="sfx_label_223"][2]    300
			${value2}=    Selenium2Library.get text    xpath: //div[@class="sfx_label_223"][2]
			IF    "${value2}"=="0 marked"
				Wait Until Element Is Visible      xpath: (//div[@class="sf-element-canvas-image"])[2]    300
				Selenium2Library.Drag And Drop by Offset 	xpath: (//div[@class="sf-element-canvas-image"])[2]    -160    -100
			END
		END
	END
	wait for page to load
	capture page screenshot

read the difference value for selected KPI
	Click on the scroll down button    4   5
	${value}=    Selenium2Library.Get text    xpath:(//p[@id="diffIn2RopsKPI1"])
	Log    ${value}
	[Return]    ${value}
	wait for page to load
	capture page screenshot	
	
click on reset filters and markings button
	Click on the scroll down button    0   25	
	Wait Until Element Is Visible     xpath: //*[@title='Reset Filters & Markings']    300
    ${status}=    run keyword and return status    Click element     xpath: //*[@title='Reset Filters & Markings']
    wait for page to load
	capture page screenshot
	
Match UI with DB Value after approximation
	[Arguments]    ${DB_Value}       ${uiValue}    
	#${uiValue}=    Remove everything after decimal point from measure value    ${uiValue}
	Log    ${uiValue}
	#${dbValue1}=    Remove everything after decimal point from measure value    ${DB_Value}
	Log    ${DB_Value}
	verify that the DB and UI values match    ${uiValue}     ${DB_Value}
	
Make selection on 'Up to 7 Days' chart 
	Wait Until Element Is Visible      xpath: (//div[@class="sf-element-canvas-image"])[3]    300
	Selenium2Library.Drag And Drop by Offset 	xpath: (//div[@class="sf-element-canvas-image"])[3]    -160    -100
	wait until element is visible    xpath: //div[@class="sfx_label_223"][2]    300
	sleep    1
	${value}=    Selenium2Library.get text    xpath: //div[@class="sfx_label_223"][2]
	Log    ${value}
	IF    "${value}"=="0 marked"
		Wait Until Element Is Visible      xpath: (//div[@class="sf-element-canvas-image"])[3]    300
		Selenium2Library.Drag And Drop by Offset 	xpath: (//div[@class="sf-element-canvas-image"])[3]    -160    -100
		wait until element is visible    xpath: //div[@class="sfx_label_223"][2]    300
		sleep    1
		${value1}=    Selenium2Library.get text    xpath: //div[@class="sfx_label_223"][2]
		IF    "${value1}"=="0 marked"
			Wait Until Element Is Visible      xpath: (//div[@class="sf-element-canvas-image"])[3]    300
			Selenium2Library.Drag And Drop by Offset 	xpath: (//div[@class="sf-element-canvas-image"])[3]    -160    -100
			wait until element is visible    xpath: //div[@class="sfx_label_223"][2]    300
			${value2}=    Selenium2Library.get text    xpath: //div[@class="sfx_label_223"][2]
			IF    "${value2}"=="0 marked"
				Wait Until Element Is Visible      xpath: (//div[@class="sf-element-canvas-image"])[3]    300
				Selenium2Library.Drag And Drop by Offset 	xpath: (//div[@class="sf-element-canvas-image"])[3]    -160    -100
			END
		END
	END
	wait for page to load
	capture page screenshot
	
Click on the scroll right button
    [Arguments]     ${button}    ${n}
    @{element}=    Get WebElements	    xpath: //div[@class="ScrollbarButton sf-element sf-element-scroll-bar-button sfpc-right"]
    ${scroll_button}=        Get from list     ${element}    ${button}
    FOR    ${i}    IN RANGE    0    ${n} 
           Run Keyword and Ignore Error    Click element     ${scroll_button}           
    END
    wait for page to load
	capture page screenshot
	
select a KPI on KPI view - Node page
	[Arguments]    ${kpi}
	click on the scroll right button    6    10
	${status}=    run keyword and return status    element should be visible     xpath: (//div[@class="ListItems"]//div[@title="${kpi}"]) 
	IF    "${status}"=="False"
		FOR    ${i}    IN RANGE    1    5
			Run keyword if    "${i}"=="3"    Click on the scroll down button    6    35
			Click on the scroll down button    ${i}   3
			${status}=    run keyword and return status    element should be visible     xpath: (//div[@class="ListItems"]//div[@title="${kpi}"])
			Run keyword if    "${status}"=="True"    exit for loop
			FOR    ${j}    IN RANGE    0    7		  
				IF    "${status}"=="False"
					Click on the scroll down button    ${i}   3		
					${status}=    run keyword and return status    element should be visible     xpath: (//div[@class="ListItems"]//div[@title="${kpi}"])
					Run keyword if    "${status}"=="True"    exit for loop
				END
			END
		END
	END
	sleep    2
	Wait Until Element Is Visible      xpath: (//div[@class="ListItems"]//div[@title="${kpi}"])    30
    Click element     xpath: (//div[@class="ListItems"]//div[@title="${kpi}"])
    Click on the scroll up button    6    30
    wait for page to load
	capture page screenshot
	
click on Node View button
	Click on the scroll right button    0    30
	Wait Until Element Is Visible      xpath: (//input[@value="Node View"])    60
	Click element     xpath: (//input[@value="Node View"])
	wait for page to load
	capture page screenshot
	
click on Refresh Data button
	Wait Until Element Is Visible      xpath: (//input[@value="Refresh Data"])    60
	Click element     xpath://input[@value="Refresh Data"]
	Sleep    5s
	wait for page to load
	capture page screenshot
	
make selection on Selected Nodes chart
	Wait Until Element Is Visible      xpath: (//div[@class="sf-element-canvas-image sfc-transition-background"])[1]       60
	Selenium2Library.Drag And Drop by Offset 	xpath: (//div[@class="sf-element-canvas-image sfc-transition-background"])[1]    460    100
	wait until element is visible    xpath: //div[@class="sfx_label_223"][2]    300
	sleep    1
	${value}=    Selenium2Library.get text    xpath: //div[@class="sfx_label_223"][2]
	Log    ${value}
	IF    "${value}"=="0 marked"
		click on Refresh Data button
		Wait Until Element Is Visible      xpath: (//div[@class="sf-element-canvas-image sfc-transition-background"])[1]        60
		Selenium2Library.Drag And Drop by Offset 	xpath: (//div[@class="sf-element-canvas-image sfc-transition-background"])[1]    -460    -100
		wait until element is visible    xpath: //div[@class="sfx_label_223"][2]    300
		sleep    1
		${value1}=    Selenium2Library.get text    xpath: //div[@class="sfx_label_223"][2]
		IF    "${value1}"=="0 marked"
		    click on Refresh Data button
			Wait Until Element Is Visible      xpath: (//div[@class="sf-element-canvas-image sfc-transition-background"])[1]       60
			Selenium2Library.Drag And Drop by Offset 	xpath: (//div[@class="sf-element-canvas-image sfc-transition-background"])[1]    -460    100
			wait until element is visible    xpath: //div[@class="sfx_label_223"][2]    300
			${value2}=    Selenium2Library.get text    xpath: //div[@class="sfx_label_223"][2]
			IF    "${value2}"=="0 marked"
				Wait Until Element Is Visible      xpath: (//div[@class="sf-element-canvas-image sfc-transition-background"])[1]
				Selenium2Library.Drag And Drop by Offset 	xpath: (//div[@class="sf-element-canvas-image sfc-transition-background"])[1]    460    -100
			END
		END
	END
	wait for page to load
	capture page screenshot
	
verify that the marked value is not 0
	wait until element is visible    xpath: //div[@class="sfx_label_223"][2]    300
	${value}=    Selenium2Library.get text    xpath: //div[@class="sfx_label_223"][2]
	Log    ${value}
	should not be equal    ${value}    0 marked
	wait for page to load
	capture page screenshot

add 'GTP-U Downlink Packet Out of Order Rate' KPI to selected KPIs
	Click on the scroll down button    6   35
	click on the scroll right button    6    10
	Click on the scroll down button    3   16
	wait until element is visible     xpath: (//div[@class="ListItems"]//div[@title="GTP-U Downlink Packet Out of Order Rate"])    30
    Click element     xpath: (//div[@class="ListItems"]//div[@title="GTP-U Downlink Packet Out of Order Rate"])
	wait for page to load
	capture page screenshot

add 'Mean UL PDCP UE Throughput' KPI to selected KPIs
	Click on the scroll down button    6   35
	click on the scroll right button    6    10
	Click on the scroll down button    3   16
	wait until element is visible     xpath: (//div[@class="ListItems"]//div[@title="Mean UL PDCP UE Throughput"])    30
    Click element     xpath: (//div[@class="ListItems"]//div[@title="Mean UL PDCP UE Throughput"])
	wait for page to load
	capture page screenshot

add 'UTRAN SRVCC Success Rate' KPI to selected KPIs
	Click on the scroll down button    6   35
	click on the scroll right button    6    10
	Click on the scroll down button    4   10
	wait until element is visible     xpath: (//div[@class="ListItems"]//div[@title="UTRAN SRVCC Success Rate"])    30
    Click element     xpath: (//div[@class="ListItems"]//div[@title="UTRAN SRVCC Success Rate"])
	wait for page to load
	capture page screenshot

add 'UTRAN SRVCC Success Rate' KPI to selected KPI in Settings
    Click on the scroll down button    5   20
	click on the scroll down button    3    5
    Click element     xpath: (//div[@title="UTRAN SRVCC Success Rate"])
    Click on the scroll up button    5    30
    wait for page to load
    capture page screenshot
	
make selection on Upto 7 Days chart
	Wait Until Element Is Visible      xpath: (//div[@class="sf-element-canvas-image sfc-transition-background"])[2]
	Selenium2Library.Drag And Drop by Offset 	xpath: (//div[@class="sf-element-canvas-image sfc-transition-background"])[2]    460    100
	wait until element is visible    xpath: //div[@class="sfx_label_223"][2]    300
	sleep    1
	${value}=    Selenium2Library.get text    xpath: //div[@class="sfx_label_223"][2]
	Log    ${value}
	IF    "${value}"=="0 marked"
		Wait Until Element Is Visible      xpath: (//div[@class="sf-element-canvas-image sfc-transition-background"])[2]
		Selenium2Library.Drag And Drop by Offset 	xpath: (//div[@class="sf-element-canvas-image sfc-transition-background"])[2]    -460    -100
		wait until element is visible    xpath: //div[@class="sfx_label_223"][2]    300
		sleep    1
		${value1}=    Selenium2Library.get text    xpath: //div[@class="sfx_label_223"][2]
		IF    "${value1}"=="0 marked"
			Wait Until Element Is Visible      xpath: (//div[@class="sf-element-canvas-image sfc-transition-background"])[2]
			Selenium2Library.Drag And Drop by Offset 	xpath: (//div[@class="sf-element-canvas-image sfc-transition-background"])[2]    -460    100
			wait until element is visible    xpath: //div[@class="sfx_label_223"][2]    300
			${value2}=    Selenium2Library.get text    xpath: //div[@class="sfx_label_223"][2]
			IF    "${value2}"=="0 marked"
				Wait Until Element Is Visible      xpath: (//div[@class="sf-element-canvas-image sfc-transition-background"])[2]
				Selenium2Library.Drag And Drop by Offset 	xpath: (//div[@class="sf-element-canvas-image sfc-transition-background"])[2]    460    -100
			END
		END
	END
	wait for page to load
	capture page screenshot
	
make selection on Cell View chart
	Wait Until Element Is Visible      xpath: (//div[@class="sf-element-canvas-image sfc-transition-background"])[1]
	Selenium2Library.Drag And Drop by Offset 	xpath: (//div[@class="sf-element-canvas-image sfc-transition-background"])[1]    460    100
	wait until element is visible    xpath: //div[@class="sfx_label_223"][2]    300
	sleep    1
	${value}=    Selenium2Library.get text    xpath: //div[@class="sfx_label_223"][2]
	Log    ${value}
	IF    "${value}"=="0 marked"
		Wait Until Element Is Visible      xpath: (//div[@class="sf-element-canvas-image sfc-transition-background"])[1]
		Selenium2Library.Drag And Drop by Offset 	xpath: (//div[@class="sf-element-canvas-image sfc-transition-background"])[1]    -460    -100
		wait until element is visible    xpath: //div[@class="sfx_label_223"][2]    300
		sleep    1
		${value1}=    Selenium2Library.get text    xpath: //div[@class="sfx_label_223"][2]
		IF    "${value1}"=="0 marked"
			Wait Until Element Is Visible      xpath: (//div[@class="sf-element-canvas-image sfc-transition-background"])[1]
			Selenium2Library.Drag And Drop by Offset 	xpath: (//div[@class="sf-element-canvas-image sfc-transition-background"])[1]    -460    100
			wait until element is visible    xpath: //div[@class="sfx_label_223"][2]    300
			${value2}=    Selenium2Library.get text    xpath: //div[@class="sfx_label_223"][2]
			IF    "${value2}"=="0 marked"
				Wait Until Element Is Visible      xpath: (//div[@class="sf-element-canvas-image sfc-transition-background"])[1]
				Selenium2Library.Drag And Drop by Offset 	xpath: (//div[@class="sf-element-canvas-image sfc-transition-background"])[1]    460    -100
			END
		END
	END
	wait for page to load
	capture page screenshot
	
verify that the filtered data page has data
	Wait Until Page Contains Element      xpath:(//div[@name="valueCellsContainer"])    30
	click element    xpath:(//div[@name="valueCellsContainer"])
	sleep    2	
	Wait Until Page Contains Element      xpath:(//div[@class="sfx_label_223"])[1]    300
	${text}=    selenium2library.get text    xpath:(//div[@class="sfx_label_223"])[1]
	Log    ${text}
	should not be equal    ${text}    0 of 0 rows
	wait for page to load
	capture page screenshot
	
read the Latest ROP value for selected KPI
	Wait Until Element Is Visible      xpath: (//span[@id="lastRopKPI1"]//span//span[@class="EmbeddedMiniatureVisualization"])    30
	${value}=    Selenium2Library.Get text    xpath: (//span[@id="lastRopKPI1"]//span//span[@class="EmbeddedMiniatureVisualization"])
	Log    ${value}
	[Return]    ${value}
	wait for page to load
	capture page screenshot	
	
read the Latest ROP value for the selected KPI
	Wait Until Element Is Visible      xpath: (//span[@id="lastRopKPI1"])    30
	${value}=    Selenium2Library.Get text    xpath: (//span[@id="lastRopKPI1"])
	Log    ${value}
	[Return]    ${value}
	wait for page to load
	capture page screenshot
	
click on the settings button
	Click on the scroll down button    0    25
	Wait Until Element Is Visible     xpath: //*[@title='Settings']    30
    ${status}=    run keyword and return status    Click element     xpath: //*[@title='Settings']
    IF    "${status}"=="False"
    	wait for page to load
    	Click element     xpath: //*[@title='Settings']
    END
	wait for page to load
	capture page screenshot
	
verify that the difference between the two ROP values is correct
	[Arguments]    ${dbValue1}    ${dbValue2}    ${uiValue}
	Log    ${dbValue1}
	Log    ${dbValue2}
	Log    ${uiValue}
	${dbValue1}=    get from list    ${dbValue1}    0
	${dbValue1}=    convert to string    ${dbValue1}
	${dbValue1}=    split string from right    ${dbValue1}    '
	Log    ${dbValue1}
	${dbValue1}=    get from list    ${dbValue1}    1
	${dbValue1}=    convert to number    ${dbValue1}
	sleep    2
	${dbValue2}=    get from list    ${dbValue2}    0
	${dbValue2}=    convert to string    ${dbValue2}
	${dbValue2}=    split string from right    ${dbValue2}    '
	Log    ${dbValue2}
	${dbValue2}=    get from list    ${dbValue2}    1
	${dbValue2}=    convert to number    ${dbValue2}
	${dbValue1}=    Evaluate    abs(${dbValue1})
	${dbValue2}=    Evaluate    abs(${dbValue2})
	${differenceValue}=    Evaluate    ${dbValue1} - ${dbValue2}
	#${differenceValue}=    Evaluate    abs(${differenceValue})
	#${differenceValue}=    convert to string    ${differenceValue}
	${uiValue1}=         convert to number    ${uiValue}
	Match UI with DB Value after approximation    ${differenceValue}    ${uiValue1}
	wait for page to load
	capture page screenshot