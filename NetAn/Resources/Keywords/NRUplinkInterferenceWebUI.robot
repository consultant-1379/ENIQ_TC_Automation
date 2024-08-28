*** Keywords ***

Open NR Uplink Interference analysis
    ${chrome_options}=    Evaluate    sys.modules['selenium.webdriver'].ChromeOptions()      sys
	Call Method    ${chrome_options}    add_argument    --ignore-certificate-errors
	Create Webdriver    Chrome    options=${chrome_options}
    Go To    ${base_url}   
    Maximize Browser Window
    Sleep    3
    Selenium2Library.Input Text    name:username    Administrator
    Selenium2Library.Input Text    name:password    Ericsson01
    Click Element    class:LoginButton
    Sleep    3
    Go To    ${base_url}${nr_uplink_url}
    Sleep    40
    ${IsElementVisible}=    Run Keyword And Return Status    Element Should not be Visible    xpath://div[contains(text(),'Missing Data')]
	Run Keyword If    ${IsElementVisible} is ${FALSE}   Close missing data window
	wait for page to load
    capture page screenshot

Close missing data window
	Wait Until Page Contains Element      xpath://span[contains(text(),'Apply to all inaccessible data tables in this analysis')]     timeout=150
    Click Element    xpath://span[contains(text(),'Apply to all inaccessible data tables in this analysis')]
    sleep    5
    Wait Until Page Contains Element      xpath://button[contains(text(),'OK')]     timeout=150
    Click Element    xpath://button[contains(text(),'OK')]
    wait for page to load
    capture page screenshot

Suite setup steps
	Set Screenshot Directory   ./Screenshots
	#Set Selenium Implicit Wait        60s
	#Open NR Uplink Interference analysis

Suite teardown steps
    Close Browser

Test teardown steps
    Capture page screenshot
	#Click element     xpath: //*[@title='File']
	#wait for page to load
	#Click element     xpath: //*[@title='Close']

wait for page to load
    Sleep   3s
	Wait Until Element Is Not Visible      xpath://*[@class='sf-svg-loader-12x12']              timeout=3000
    Sleep    2s

Go to Home page if not already at home
	${pageTitle}=    Selenium2Library.Get text  xpath: //*[@class="sfx_page-title_219"]
	IF 		"${pageTitle}" != "Home"	
		Click element     xpath: //*[@id="HomeButton"]
	END
	wait for page to load
	capture page screenshot

Suite setup steps for NR Uplink Interference   
    Set Screenshot Directory   ./Screenshots

Suite teardown steps for NR Uplink Interference
    Close Browser

Test teardown steps for NR Uplink Interference
    Capture page screenshot

Verify Network Analytics logo is visible
	element should be visible    xpath:((//div[@align="center"])[2]//div//table//tbody//tr//td//p//img)[1]
	wait for page to load
	capture page screenshot

Verify NR Uplink Interference logo is visible
	element should be visible    xpath:((//div[@align="center"])[2]//div//table//tbody//tr)[2]//td//img
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

Click on the scroll right button
    [Arguments]     ${button}    ${n}
    @{element}=    Get WebElements	    xpath: //div[@class="ScrollbarButton sf-element sf-element-scroll-bar-button sfpc-right"]
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

Verify that the button is visible
	[Arguments]    ${button}
	element should be visible    xpath://*[@title="${button}"]
	wait for page to load
	capture page screenshot

Validate that the button is visible
	[Arguments]    ${button}
	element should be visible    xpath://*[@value="${button}"]
	wait for page to load
	capture page screenshot

Click on the Reset Filters & Markings button
	sleep     5
	Wait Until Element Is Visible     xpath: //*[@title='Reset Filters & Markings']    300
    ${status}=    run keyword and return status    Click element     xpath: //*[@title='Reset Filters & Markings']
    IF    "${status}"=="FALSE"
    	sleep    30
    	Click element     xpath: //*[@title='Reset Filters & Markings']
    END
	wait for page to load
	wait for page to load
	capture page screenshot

Click on the button
	[Arguments]    ${buttonTitle}
	sleep     5
	Wait Until Element Is Visible     xpath: //*[@title='${buttonTitle}']    300
    ${status}=    run keyword and return status    Click element     xpath: //*[@title='${buttonTitle}']
    IF    "${status}"=="FALSE"
    	sleep    30
    	Click element     xpath: //*[@title='${buttonTitle}']
    END
	wait for page to load
	capture page screenshot

Click on the button with value
	[Arguments]    ${buttonValue}
	sleep     5
	Wait Until Element Is Visible     xpath: //*[@value='${buttonValue}']    300
    ${status}=    run keyword and return status    Click element     xpath: //*[@value='${buttonValue}']
    IF    "${status}"=="FALSE"
    	sleep    30
    	Click element     xpath: //*[@value='${buttonValue}']
    END
	wait for page to load
	capture page screenshot

Click on the button with id
	[Arguments]    ${buttonId}
	sleep     5
	Wait Until Element Is Visible     xpath: //*[@id='${buttonId}']    300
    ${status}=    run keyword and return status    Click element     xpath: //*[@id='${buttonId}']
    IF    "${status}"=="FALSE"
    	sleep    30
    	Click element     xpath: //*[@id='${buttonId}']
    END
	wait for page to load
	capture page screenshot

Click on the button with text
	[Arguments]    ${buttonText}
	sleep     5
	Wait Until Element Is Visible     xpath://*[contains(text(),'${buttonText}')]    30
    ${status}=    run keyword and return status    Click element       xpath://*[contains(text(),'${buttonText}')]
    IF    "${status}"=="FALSE"
    	sleep    30
    	Click Element       xpath://*[contains(text(),'${buttonText}')]
    END
	wait for page to load
	capture page screenshot

Verify the page title
	[Arguments]     ${expectedText}
	wait for page to load
    ${text}=    Selenium2Library.Get text  xpath: //*[@class="sfx_page-title_219"]
    Log    ${text}
    Should be equal     ${text}    ${expectedText}
    wait for page to load
	capture page screenshot

Verify that the marked value is not 0
	wait until element is visible    xpath:(//div[@class="sfx_label_223"])[2]   300
	${value}=    Selenium2Library.get text    xpath:(//div[@class="sfx_label_223"])[2]
	Log    ${value}
	should not be equal    ${value}    0 marked
	wait for page to load
	capture page screenshot

Verify that the marked value is 0
	wait until element is visible    xpath:(//div[@class="sfx_label_223"])[2]   300
	${value}=    Selenium2Library.get text    xpath:(//div[@class="sfx_label_223"])[2]
	Log    ${value}
	should be equal    ${value}    0 marked
	wait for page to load
	capture page screenshot

Verify that the marked rows are not 0
	wait until element is visible    xpath:(//div[@class="sfx_label_223"])[1]   300
	${value}=    Selenium2Library.get text    xpath:(//div[@class="sfx_label_223"])[1]
	Log    ${value}
	should not be equal    ${value}    0 of 0 rows
	wait for page to load
	capture page screenshot

Select Interference Measure and Aggregation as
	[Arguments] 	${interferenceMeasure}		${aggregation}
	${element}=    Get WebElements	    xpath: //div[@class='ComboBoxTextDivContainer']
    ${interferenceMeasureType}=        Get from list     ${element}    0
    Click element     ${interferenceMeasureType}
    sleep    2
    wait for page to load
    Click element      xpath://div[@title='${interferenceMeasure}']
    sleep    2
    wait for page to load
    ${aggElement}=    Get WebElements	    xpath: //div[@class='ComboBoxTextDivContainer']
    ${aggregationType}=        Get from list     ${aggElement}    1
    Click element     ${aggregationType}
    sleep    2
    wait for page to load
    Click element      xpath://div[@title='${aggregation}']
	wait for page to load
	capture page screenshot

Adjust the slider to 50 cells
	sleep    2
	Click on the slide right button    40
	wait for page to load
	capture page screenshot

Adjust the slider to 30 cells
	sleep    2
	Click on the slide right button    20
	wait for page to load
	capture page screenshot

Click on slide right button
	[Arguments]    ${instance}    ${n}	
	sleep    2
	${element}=    Get WebElements    xpath: //div[@class='Button RightEnabled sf-element sf-element-button']
	${slide_button}=    Get from list    ${element}    ${instance}
	FOR    ${i}    IN RANGE    0    ${n}
		Click element    ${slide_button}
    END
    wait for page to load
	capture page screenshot

Click on the slide right button
	[Arguments]    ${n}	
	sleep    2
	FOR    ${i}    IN RANGE    0    ${n}
		Click element    xpath: (//div[@class='Button RightEnabled sf-element sf-element-button'])[1]    modifier=CTRL
		Sleep    1s
    END
    wait for page to load
	capture page screenshot

Verify that the Worst Cells chart is named for the cell count
	[Arguments]    ${cellCount}
	sleep    2
	element should contain    xpath:(//div[@class="flex-item flex-align-start sf-element sf-element-text-box sf-single-line-text"])[3]    ${cellCount}
	sleep    1
	element should contain    xpath:(//div[@class="flex-item flex-align-start sf-element sf-element-text-box sf-single-line-text"])[4]    ${cellCount}
	wait for page to load
	capture page screenshot

Click on Band and Frequency checkbox
	Wait Until Element Is Visible     xpath:(//div[@class="flex-item flex-container-horizontal flex-inline-container flex-align-center"])[1]    30
	Click Element       xpath:(//div[@class="flex-item flex-container-horizontal flex-inline-container flex-align-center"])[1]
	wait for page to load
	capture page screenshot

Click on Channel Bandwidth checkbox
	Click on the scroll down button    2    156
	Sleep     3s
	${count}=      Get Element Count       //div[@class="flex-item flex-container-horizontal flex-inline-container flex-align-center"]
	${c}=       Evaluate      ${count}-1
	Click Element       xpath:(//div[@class="flex-item flex-container-horizontal flex-inline-container flex-align-center"])[${c}]
	wait for page to load
	capture page screenshot

Verify that the charts on Health Check are named for
	[Arguments] 	${interferenceMeasure}		${aggregation}
	sleep    10
	IF    "${interferenceMeasure}" == "Interference Power"
		FOR    ${i}    IN RANGE    1    5
           element should contain    xpath:(//div[@class="flex-item flex-align-start sf-element sf-element-text-box sf-single-line-text"])[${i}]    Interference Power
           element should not contain    xpath:(//div[@class="flex-item flex-align-start sf-element sf-element-text-box sf-single-line-text"])[${i}]    Noise Rise
    	END
    ELSE IF    "${interferenceMeasure}" == "Noise Rise"
		FOR    ${i}    IN RANGE    3    5
           element should contain    xpath:(//div[@class="flex-item flex-align-start sf-element sf-element-text-box sf-single-line-text"])[${i}]    Noise Rise
           element should not contain    xpath:(//div[@class="flex-item flex-align-start sf-element sf-element-text-box sf-single-line-text"])[${i}]    Interference Power
    	END
    END
	IF    "${aggregation}" == "Average"
		FOR    ${i}    IN RANGE    3    5
           element should contain    xpath:(//div[@class="flex-item flex-align-start sf-element sf-element-text-box sf-single-line-text"])[${i}]    Avg
           element should not contain    xpath:(//div[@class="flex-item flex-align-start sf-element sf-element-text-box sf-single-line-text"])[${i}]    Max
    	END
    ELSE IF    "${aggregation}" == "Maximum"
		FOR    ${i}    IN RANGE    3    5
           element should contain    xpath:(//div[@class="flex-item flex-align-start sf-element sf-element-text-box sf-single-line-text"])[${i}]    Max
           element should not contain    xpath:(//div[@class="flex-item flex-align-start sf-element sf-element-text-box sf-single-line-text"])[${i}]    Avg
    	END
    END
	wait for page to load
	capture page screenshot

Verify the x-axis of the charts on Health Check
	[Arguments] 	${interferenceMeasure}
	sleep    10
	IF    "${interferenceMeasure}" == "Interference Power"
		FOR    ${i}    IN RANGE    2    6    2
           element should contain    xpath:(//div[@class="itemText sf-element sf-element-text-box"])[${i}]    interference Power
    	END
		FOR    ${i}    IN RANGE    6    10    2
           element should contain    xpath:(//div[@class="itemText sf-element sf-element-text-box"])[${i}]    Interference Power
           element should not contain    xpath:(//div[@class="itemText sf-element sf-element-text-box"])[${i}]    Noise Rise
    	END
    ELSE IF    "${interferenceMeasure}" == "Noise Rise"
		FOR    ${i}    IN RANGE    6    10    2
           element should contain    xpath:(//div[@class="itemText sf-element sf-element-text-box"])[${i}]    Noise Rise
           element should not contain    xpath:(//div[@class="itemText sf-element sf-element-text-box"])[${i}]    Interference Power
    	END
    END
    wait for page to load
	capture page screenshot

Make selection on Network Distribution chart for
	[Arguments]    ${measure}
	IF    "${measure}" == "PUSCH"
		Wait Until Element Is Visible      xpath: (//div[@class="sf-element-canvas-image"])[1]
		Selenium2Library.Drag And Drop by Offset 	xpath: (//div[@class="sf-element-canvas-image"])[1]    -200    -100
		wait until element is visible    xpath: //div[@class="sfx_label_223"][2]    300
		sleep    1
		${value}=    Selenium2Library.get text    xpath: //div[@class="sfx_label_223"][2]
		IF    "${value}"=="0 marked"
			Wait Until Element Is Visible      xpath: (//div[@class="sf-element-canvas-image"])[1]
			Selenium2Library.Drag And Drop by Offset 	xpath: (//div[@class="sf-element-canvas-image"])[1]    200    -100
			wait until element is visible    xpath: //div[@class="sfx_label_223"][2]    300
			sleep    1
			${value1}=    Selenium2Library.get text    xpath: //div[@class="sfx_label_223"][2]
			IF    "${value1}"=="0 marked"
				Wait Until Element Is Visible      xpath: (//div[@class="sf-element-canvas-image"])[1]
				Selenium2Library.Drag And Drop by Offset 	xpath: (//div[@class="sf-element-canvas-image"])[1]    -200    100
				wait until element is visible    xpath: //div[@class="sfx_label_223"][2]    300
				sleep    1
				${value2}=    Selenium2Library.get text    xpath: //div[@class="sfx_label_223"][2]
				IF    "${value2}"=="0 marked"
					Wait Until Element Is Visible      xpath: (//div[@class="sf-element-canvas-image"])[1]
					Selenium2Library.Drag And Drop by Offset 	xpath: (//div[@class="sf-element-canvas-image"])[1]    200    100
				END
			END
		END
    ELSE IF    "${measure}" == "PRB"
		Wait Until Element Is Visible      xpath: (//div[@class="sf-element-canvas-image"])[2]
		Selenium2Library.Drag And Drop by Offset 	xpath: (//div[@class="sf-element-canvas-image"])[2]    -200    -100
		wait until element is visible    xpath: //div[@class="sfx_label_223"][2]    300
		sleep    1
		${value}=    Selenium2Library.get text    xpath: //div[@class="sfx_label_223"][2]
		IF    "${value}"=="0 marked"
			Wait Until Element Is Visible      xpath: (//div[@class="sf-element-canvas-image"])[2]
			Selenium2Library.Drag And Drop by Offset 	xpath: (//div[@class="sf-element-canvas-image"])[2]    200    -100
			wait until element is visible    xpath: //div[@class="sfx_label_223"][2]    300
			sleep    1
			${value1}=    Selenium2Library.get text    xpath: //div[@class="sfx_label_223"][2]
			IF    "${value1}"=="0 marked"
				Wait Until Element Is Visible      xpath: (//div[@class="sf-element-canvas-image"])[2]
				Selenium2Library.Drag And Drop by Offset 	xpath: (//div[@class="sf-element-canvas-image"])[2]    -200    100
				wait until element is visible    xpath: //div[@class="sfx_label_223"][2]    300
				sleep    1
				${value2}=    Selenium2Library.get text    xpath: //div[@class="sfx_label_223"][2]
				IF    "${value2}"=="0 marked"
					Wait Until Element Is Visible      xpath: (//div[@class="sf-element-canvas-image"])[2]
					Selenium2Library.Drag And Drop by Offset 	xpath: (//div[@class="sf-element-canvas-image"])[2]    200    100
				END
			END
		END
    END
	wait for page to load
	capture page screenshot

Make selection on Worst Cells chart for
	[Arguments]    ${measure}
	IF    "${measure}" == "PUSCH"
		Wait Until Element Is Visible      xpath: (//div[@class="sf-element sf-element-canvas-visualization"])[4]
		Selenium2Library.Drag And Drop by Offset 	xpath: (//div[@class="sf-element sf-element-canvas-visualization"])[4]    -200    -100
		wait until element is visible    xpath: //div[@class="sfx_label_223"][2]    300
		sleep    1
		${value}=    Selenium2Library.get text    xpath: //div[@class="sfx_label_223"][2]
		IF    "${value}"=="0 marked"
			Wait Until Element Is Visible      xpath: (//div[@class="sf-element sf-element-canvas-visualization"])[4]
			Selenium2Library.Drag And Drop by Offset 	xpath: (//div[@class="sf-element sf-element-canvas-visualization"])[4]    200    -100
			wait until element is visible    xpath: //div[@class="sfx_label_223"][2]    300
			sleep    1
			${value1}=    Selenium2Library.get text    xpath: //div[@class="sfx_label_223"][2]
			IF    "${value1}"=="0 marked"
				Wait Until Element Is Visible      xpath: (//div[@class="sf-element sf-element-canvas-visualization"])[4]
				Selenium2Library.Drag And Drop by Offset 	xpath: (//div[@class="sf-element sf-element-canvas-visualization"])[4]    -200    100
				wait until element is visible    xpath: //div[@class="sfx_label_223"][2]    300
				sleep    1
				${value2}=    Selenium2Library.get text    xpath: //div[@class="sfx_label_223"][2]
				IF    "${value2}"=="0 marked"
					Wait Until Element Is Visible      xpath: (//div[@class="sf-element sf-element-canvas-visualization"])[4]
					Selenium2Library.Drag And Drop by Offset 	xpath: (//div[@class="sf-element sf-element-canvas-visualization"])[4]    200    100
				END
			END
		END
    ELSE IF    "${measure}" == "PRB"
		Wait Until Element Is Visible      xpath: (//div[@class="sf-element sf-element-canvas-visualization"])[3]
		Selenium2Library.Drag And Drop by Offset 	xpath: (//div[@class="sf-element sf-element-canvas-visualization"])[3]    -200    -100
		wait until element is visible    xpath: //div[@class="sfx_label_223"][2]    300
		sleep    1
		${value}=    Selenium2Library.get text    xpath: //div[@class="sfx_label_223"][2]
		IF    "${value}"=="0 marked"
			Wait Until Element Is Visible      xpath: (//div[@class="sf-element sf-element-canvas-visualization"])[3]
			Selenium2Library.Drag And Drop by Offset 	xpath: (//div[@class="sf-element sf-element-canvas-visualization"])[3]    200    -100
			wait until element is visible    xpath: //div[@class="sfx_label_223"][2]    300
			sleep    1
			${value1}=    Selenium2Library.get text    xpath: //div[@class="sfx_label_223"][2]
			IF    "${value1}"=="0 marked"
				Wait Until Element Is Visible      xpath: (//div[@class="sf-element sf-element-canvas-visualization"])[3]
				Selenium2Library.Drag And Drop by Offset 	xpath: (//div[@class="sf-element sf-element-canvas-visualization"])[3]    -200    100
				wait until element is visible    xpath: //div[@class="sfx_label_223"][2]    300
				sleep    1
				${value2}=    Selenium2Library.get text    xpath: //div[@class="sfx_label_223"][2]
				IF    "${value2}"=="0 marked"
					Wait Until Element Is Visible      xpath: (//div[@class="sf-element sf-element-canvas-visualization"])[3]
					Selenium2Library.Drag And Drop by Offset 	xpath: (//div[@class="sf-element sf-element-canvas-visualization"])[3]    200    100
				END
			END
		END
    END
	wait for page to load
	capture page screenshot

test Make selection on the chart
	Wait Until Element Is Visible      xpath: (//div[@class="sf-element sf-element-canvas-visualization"])[1]
	Selenium2Library.Drag And Drop by Offset 	xpath: (//div[@class="sf-element sf-element-canvas-visualization"])[1]    -220    -100
	sleep    1
	capture page screenshot
	Wait Until Element Is Visible      xpath: (//div[@class="sf-element sf-element-canvas-visualization"])[1]
	Selenium2Library.Drag And Drop by Offset 	xpath: (//div[@class="sf-element sf-element-canvas-visualization"])[1]    -220    60
	sleep    1
	capture page screenshot
	Wait Until Element Is Visible      xpath: (//div[@class="sf-element sf-element-canvas-visualization"])[1]
	Selenium2Library.Drag And Drop by Offset 	xpath: (//div[@class="sf-element sf-element-canvas-visualization"])[1]    250    60
	sleep    1
	capture page screenshot
	Wait Until Element Is Visible      xpath: (//div[@class="sf-element sf-element-canvas-visualization"])[1]
	Selenium2Library.Drag And Drop by Offset 	xpath: (//div[@class="sf-element sf-element-canvas-visualization"])[1]    250    -100
	wait for page to load
	capture page screenshot

Verify message asking cell selection on Health Check page
	sleep    5
    element should contain    xpath: //span[@id='043f09d19ba94d929119646fe97154a9']    Please mark the Cell(s)
	wait for page to load
	capture page screenshot

Verify that the charts on Health Check-PUSCH/PRB Analysis are named for
	[Arguments] 	${interferenceMeasure}		${aggregation}
	sleep    10
	IF    "${interferenceMeasure}" == "Interference Power"
        element should contain    xpath:(//div[@class="flex-item flex-align-start sf-element sf-element-text-box sf-single-line-text"])[1]    Interference Power
        element should not contain    xpath:(//div[@class="flex-item flex-align-start sf-element sf-element-text-box sf-single-line-text"])[1]    Noise Rise
    ELSE IF    "${interferenceMeasure}" == "Noise Rise"
        element should contain    xpath:(//div[@class="flex-item flex-align-start sf-element sf-element-text-box sf-single-line-text"])[1]    Noise Rise
        element should not contain    xpath:(//div[@class="flex-item flex-align-start sf-element sf-element-text-box sf-single-line-text"])[1]    Interference Power
    END
	IF    "${aggregation}" == "Average"
        element should contain    xpath:(//div[@class="flex-item flex-align-start sf-element sf-element-text-box sf-single-line-text"])[1]    Avg
        element should not contain    xpath:(//div[@class="flex-item flex-align-start sf-element sf-element-text-box sf-single-line-text"])[1]    Max
    ELSE IF    "${aggregation}" == "Maximum"
        element should contain    xpath:(//div[@class="flex-item flex-align-start sf-element sf-element-text-box sf-single-line-text"])[1]    Max
        element should not contain    xpath:(//div[@class="flex-item flex-align-start sf-element sf-element-text-box sf-single-line-text"])[1]    Avg
    END
	wait for page to load
	capture page screenshot

Select first 10 cells in 'Select Cells for Comparison' list box
	FOR    ${i}    IN RANGE    1    10
	    Wait Until Page Contains Element      xpath:((//div[@class="ListItems"])//div[@class="sf-element-list-box-item"])[1]    100
	    Click Element    xpath:((//div[@class="ListItems"])//div[@class="sf-element-list-box-item"])[1]    modifier=CTRL
    END
	wait for page to load
	capture page screenshot

Make selection on 'per Selected Cell' chart
	Wait Until Element Is Visible      xpath: (//div[@class="sf-element-canvas-image"])[1]
	Selenium2Library.Drag And Drop by Offset 	xpath: (//div[@class="sf-element-canvas-image"])[1]    -360    -300
	wait until element is visible    xpath: //div[@class="sfx_label_223"][2]    300
	sleep    1
	${value}=    Selenium2Library.get text    xpath: //div[@class="sfx_label_223"][2]
	IF    "${value}"=="0 marked"
		Wait Until Element Is Visible      xpath: (//div[@class="sf-element-canvas-image"])[1]
		Selenium2Library.Drag And Drop by Offset 	xpath: (//div[@class="sf-element-canvas-image"])[1]    -360    140
		wait until element is visible    xpath: //div[@class="sfx_label_223"][2]    300
		sleep    1
		${value1}=    Selenium2Library.get text    xpath: //div[@class="sfx_label_223"][2]
		IF    "${value1}"=="0 marked"
			Wait Until Element Is Visible      xpath: (//div[@class="sf-element-canvas-image"])[1]
			Selenium2Library.Drag And Drop by Offset 	xpath: (//div[@class="sf-element-canvas-image"])[1]    450    140
			wait until element is visible    xpath: //div[@class="sfx_label_223"][2]    300
			sleep    1
			${value2}=    Selenium2Library.get text    xpath: //div[@class="sfx_label_223"][2]
			IF    "${value2}"=="0 marked"
				Wait Until Element Is Visible      xpath: (//div[@class="sf-element-canvas-image"])[1]
				Selenium2Library.Drag And Drop by Offset 	xpath: (//div[@class="sf-element-canvas-image"])[1]    450    -300
			END
		END
	END
	wait for page to load
	capture page screenshot

Select cells on 'Select Cells for Comparison' list box
    Click on the scroll down button         2        4
	Wait Until Page Contains Element      xpath: ((//div[@class="ListItems"])//div[@class="sf-element-list-box-item"])[1]    100
	Click Element    xpath: ((//div[@class="ListItems"])//div[@class="sf-element-list-box-item"])[1]
	wait for page to load
	capture page screenshot

Select days on the 'DAYS' calendar chart for PRB
	Wait Until Page Contains Element      xpath: (//div[@class="sf-element-canvas-image sfc-transition-background"])[2]    100
	Selenium2Library.Drag And Drop by Offset    xpath: (//div[@class="sf-element-canvas-image sfc-transition-background"])[2]    30    100 
	wait for page to load
	capture page screenshot

Select days on the 'DAYS' calendar chart for PUSCH
	Wait Until Page Contains Element      xpath: (//div[@class="sf-element-canvas-image sfc-transition-background"])[1]    100
	Selenium2Library.Drag And Drop by Offset    xpath: (//div[@class="sf-element-canvas-image sfc-transition-background"])[1]    30    100 
	wait for page to load
	capture page screenshot

Make a selection on the 'Select Time Period(s)' chart
	Wait Until Element Is Visible      xpath: (//div[@class="sf-element-canvas-image sfc-transition-background"])[1]
	Selenium2Library.Drag And Drop by Offset 	xpath: (//div[@class="sf-element-canvas-image sfc-transition-background"])[1]    -460    -150
	wait until element is visible    xpath: //div[@class="sfx_label_223"][2]    300
	sleep    1
	${value}=    Selenium2Library.get text    xpath: //div[@class="sfx_label_223"][2]
	Log    ${value}
	IF    "${value}"=="0 marked"
		Wait Until Element Is Visible      xpath: (//div[@class="sf-element-canvas-image sfc-transition-background"])[1]
		Selenium2Library.Drag And Drop by Offset 	xpath: (//div[@class="sf-element-canvas-image sfc-transition-background"])[1]    -460    150
		wait until element is visible    xpath: //div[@class="sfx_label_223"][2]    300
		sleep    1
		${value1}=    Selenium2Library.get text    xpath: //div[@class="sfx_label_223"][2]
		IF    "${value1}"=="0 marked"
			Wait Until Element Is Visible      xpath: (//div[@class="sf-element-canvas-image sfc-transition-background"])[1]
			Selenium2Library.Drag And Drop by Offset 	xpath: (//div[@class="sf-element-canvas-image sfc-transition-background"])[1]    490    150
			wait until element is visible    xpath: //div[@class="sfx_label_223"][2]    300
			sleep    1
			${value2}=    Selenium2Library.get text    xpath: //div[@class="sfx_label_223"][2]
			IF    "${value2}"=="0 marked"
				Wait Until Element Is Visible      xpath: (//div[@class="sf-element-canvas-image sfc-transition-background"])[1]
				Selenium2Library.Drag And Drop by Offset 	xpath: (//div[@class="sf-element-canvas-image sfc-transition-background"])[1]    490    -150
			END
		END
	END
	wait for page to load
	capture page screenshot

Make a selection on the 'per PRB' chart
	Wait Until Element Is Visible      xpath: (//div[@class="sf-element-canvas-image sfc-transition-background"])[3]
	Selenium2Library.Drag And Drop by Offset 	xpath: (//div[@class="sf-element-canvas-image sfc-transition-background"])[3]    -470    -190
	wait until element is visible    xpath: //div[@class="sfx_label_223"][2]    300
	sleep    1
	${value}=    Selenium2Library.get text    xpath: //div[@class="sfx_label_223"][2]
	Log    ${value}
	IF    "${value}"=="0 marked"
		Wait Until Element Is Visible      xpath: (//div[@class="sf-element-canvas-image sfc-transition-background"])[3]
		Selenium2Library.Drag And Drop by Offset 	xpath: (//div[@class="sf-element-canvas-image sfc-transition-background"])[3]    -470    190
		wait until element is visible    xpath: //div[@class="sfx_label_223"][2]    300
		sleep    1
		${value1}=    Selenium2Library.get text    xpath: //div[@class="sfx_label_223"][2]
		IF    "${value1}"=="0 marked"
			Wait Until Element Is Visible      xpath: (//div[@class="sf-element-canvas-image sfc-transition-background"])[3]
			Selenium2Library.Drag And Drop by Offset 	xpath: (//div[@class="sf-element-canvas-image sfc-transition-background"])[3]    490    190
			wait until element is visible    xpath: //div[@class="sfx_label_223"][2]    300
			sleep    1
			${value2}=    Selenium2Library.get text    xpath: //div[@class="sfx_label_223"][2]
			IF    "${value2}"=="0 marked"
				Wait Until Element Is Visible      xpath: (//div[@class="sf-element-canvas-image sfc-transition-background"])[3]
				Selenium2Library.Drag And Drop by Offset 	xpath: (//div[@class="sf-element-canvas-image sfc-transition-background"])[3]    490    -190
			END
		END
	END
	wait for page to load
	capture page screenshot

Verify that 'per PRB' chart is visible
	Wait Until Element Is Visible     xpath:(//div[@class="sf-element-canvas-image"])[3]    300
	element should be visible    xpath:(//div[@class="sf-element-canvas-image"])[3]
	capture page screenshot

Make a selection on the 'PUSCH per Date/Time' chart
	Wait Until Element Is Visible      xpath: (//div[@class="sf-element-canvas-image sfc-transition-background"])[2]
	Selenium2Library.Drag And Drop by Offset 	xpath: (//div[@class="sf-element-canvas-image sfc-transition-background"])[2]    -460    -150
	wait until element is visible    xpath: //div[@class="sfx_label_223"][2]    300
	sleep    1
	${value}=    Selenium2Library.get text    xpath: //div[@class="sfx_label_223"][2]
	Log    ${value}
	IF    "${value}"=="0 marked"
		Wait Until Element Is Visible      xpath: (//div[@class="sf-element-canvas-image sfc-transition-background"])[2]
		Selenium2Library.Drag And Drop by Offset 	xpath: (//div[@class="sf-element-canvas-image sfc-transition-background"])[2]    -460    150
		wait until element is visible    xpath: //div[@class="sfx_label_223"][2]    300
		sleep    1
		${value1}=    Selenium2Library.get text    xpath: //div[@class="sfx_label_223"][2]
		IF    "${value1}"=="0 marked"
			Wait Until Element Is Visible      xpath: (//div[@class="sf-element-canvas-image sfc-transition-background"])[2]
			Selenium2Library.Drag And Drop by Offset 	xpath: (//div[@class="sf-element-canvas-image sfc-transition-background"])[2]    490    150
			wait until element is visible    xpath: //div[@class="sfx_label_223"][2]    300
			sleep    1
			${value2}=    Selenium2Library.get text    xpath: //div[@class="sfx_label_223"][2]
			IF    "${value2}"=="0 marked"
				Wait Until Element Is Visible      xpath: (//div[@class="sf-element-canvas-image sfc-transition-background"])[2]
				Selenium2Library.Drag And Drop by Offset 	xpath: (//div[@class="sf-element-canvas-image sfc-transition-background"])[2]    490    -150
			END
		END
	END
	wait for page to load
	capture page screenshot

Make a selection on the 'pmRadioRecInterferencePowerDistr' chart
	Wait Until Element Is Visible      xpath: (//div[@class="sf-element-canvas-image sfc-transition-background"])[3]
	Selenium2Library.Drag And Drop by Offset 	xpath: (//div[@class="sf-element-canvas-image sfc-transition-background"])[3]    -500    -190
	wait until element is visible    xpath: //div[@class="sfx_label_223"][2]    300
	sleep    1
	${value}=    Selenium2Library.get text    xpath: //div[@class="sfx_label_223"][2]
	Log    ${value}
	IF    "${value}"=="0 marked"
		Wait Until Element Is Visible      xpath: (//div[@class="sf-element-canvas-image sfc-transition-background"])[3]
		Selenium2Library.Drag And Drop by Offset 	xpath: (//div[@class="sf-element-canvas-image sfc-transition-background"])[3]    -500    190
		wait until element is visible    xpath: //div[@class="sfx_label_223"][2]    300
		sleep    1
		${value1}=    Selenium2Library.get text    xpath: //div[@class="sfx_label_223"][2]
		IF    "${value1}"=="0 marked"
			Wait Until Element Is Visible      xpath: (//div[@class="sf-element-canvas-image sfc-transition-background"])[3]
			Selenium2Library.Drag And Drop by Offset 	xpath: (//div[@class="sf-element-canvas-image sfc-transition-background"])[3]    500    190
			wait until element is visible    xpath: //div[@class="sfx_label_223"][2]    300
			sleep    1
			${value2}=    Selenium2Library.get text    xpath: //div[@class="sfx_label_223"][2]
			IF    "${value2}"=="0 marked"
				Wait Until Element Is Visible      xpath: (//div[@class="sf-element-canvas-image sfc-transition-background"])[3]
				Selenium2Library.Drag And Drop by Offset 	xpath: (//div[@class="sf-element-canvas-image sfc-transition-background"])[3]    500    -190
			END
		END
	END
	wait for page to load
	capture page screenshot

Verify that 'pmRadioRecInterferencePowerDistr' chart is visible
	Wait Until Element Is Visible     xpath:(//div[@class="sf-element-canvas-image"])[3]    300
	element should be visible    xpath:(//div[@class="sf-element-canvas-image"])[3]
	capture page screenshot

Verify the default selections on Node Troubleshooting page
	wait until element is visible    xpath:(//div[@class="sfx_label_223"])[1]   300
	${value1}=    Selenium2Library.get text    xpath:(//div[@class="sfx_label_223"])[1]
	Log    ${value1}
	should be equal    ${value1}    0 of 0 rows
	wait until element is visible    xpath:(//div[@class="sfx_label_223"])[2]   300
	${value2}=    Selenium2Library.get text    xpath:(//div[@class="sfx_label_223"])[2]
	Log    ${value2}
	should be equal    ${value2}    0 marked
	wait for page to load
	capture page screenshot

Verify that the charts on Node Troubleshooting are named for
	[Arguments] 	${interferenceMeasure}
	sleep    10
	IF    "${interferenceMeasure}" == "Interference Power"
		FOR    ${i}    IN RANGE    1    5
           element should contain    xpath:(//div[@class="flex-item flex-align-start sf-element sf-element-text-box sf-single-line-text"])[${i}]    Interference Power
           element should not contain    xpath:(//div[@class="flex-item flex-align-start sf-element sf-element-text-box sf-single-line-text"])[${i}]    Noise Rise
    	END
    ELSE IF    "${interferenceMeasure}" == "Noise Rise"
		FOR    ${i}    IN RANGE    1    5
           element should contain    xpath:(//div[@class="flex-item flex-align-start sf-element sf-element-text-box sf-single-line-text"])[${i}]    Noise Rise
           element should not contain    xpath:(//div[@class="flex-item flex-align-start sf-element sf-element-text-box sf-single-line-text"])[${i}]    Interference Power
    	END
    END
	wait for page to load
	capture page screenshot

Verify the axes of the charts on Node Troubleshooting
	[Arguments] 	${interferenceMeasure}
	sleep    10
	IF    "${interferenceMeasure}" == "Interference Power"
		FOR    ${i}    IN RANGE    2    5    2
           element should contain    xpath:(//div[@class="itemText sf-element sf-element-text-box"])[${i}]    Interference Power
           element should not contain    xpath:(//div[@class="itemText sf-element sf-element-text-box"])[${i}]    Noise Rise
    	END
		FOR    ${i}    IN RANGE    5    7
           element should contain    xpath:(//div[@class="itemText sf-element sf-element-text-box"])[${i}]    Interference Power
           element should not contain    xpath:(//div[@class="itemText sf-element sf-element-text-box"])[${i}]    Noise Rise
    	END
    ELSE IF    "${interferenceMeasure}" == "Noise Rise"
		FOR    ${i}    IN RANGE    2    5    2
           element should contain    xpath:(//div[@class="itemText sf-element sf-element-text-box"])[${i}]    Noise Rise
           element should not contain    xpath:(//div[@class="itemText sf-element sf-element-text-box"])[${i}]    Interference Power
    	END
		FOR    ${i}    IN RANGE    5    7
           element should contain    xpath:(//div[@class="itemText sf-element sf-element-text-box"])[${i}]    Noise Rise
           element should not contain    xpath:(//div[@class="itemText sf-element sf-element-text-box"])[${i}]    Interference Power
    	END
    END
    wait for page to load
	capture page screenshot

Select a node from the Node List
	Wait Until Page Contains Element      xpath: ((//div[@class="ListItems"])//div[@class="sf-element-list-box-item"])[1]    100
	Click Element    xpath: ((//div[@class="ListItems"])//div[@class="sf-element-list-box-item"])[1]
	wait for page to load
	capture page screenshot

read the selected node in the Node List
	sleep    5
	${node}=    Selenium2Library.Get Text    xpath: //div[@class="sf-element-list-box-item sfpc-selected"]
	Log    ${node}
	[Return]    ${node}
	wait for page to load
	capture page screenshot

Verify that the Node Troubleshooting page is named for
	[Arguments] 	${nodeName}
	wait for page to load
	${node}=    Selenium2Library.Get Text    xpath: //span[@id="b9665d44ba864c6f99884d5540c9abb2"]
    Log    ${node}
    Should be equal     ${node}    ${nodeName}
	#element should contain    xpath: //span[@id="b9665d44ba864c6f99884d5540c9abb2"]    ${nodeName}
	wait for page to load
	capture page screenshot

Make selection on 'per Cell' chart for
	[Arguments]    ${measure}
	IF    "${measure}" == "PUSCH"
		Wait Until Element Is Visible      xpath: (//div[@class="sf-element sf-element-canvas-visualization"])[2]
		Selenium2Library.Drag And Drop by Offset 	xpath: (//div[@class="sf-element sf-element-canvas-visualization"])[2]    -100    -100
		wait until element is visible    xpath: //div[@class="sfx_label_223"][2]    300
		sleep    1
		${value}=    Selenium2Library.get text    xpath: //div[@class="sfx_label_223"][2]
		IF    "${value}"=="0 marked"
			Wait Until Element Is Visible      xpath: (//div[@class="sf-element sf-element-canvas-visualization"])[2]
			Selenium2Library.Drag And Drop by Offset 	xpath: (//div[@class="sf-element sf-element-canvas-visualization"])[2]    -100    80
			wait until element is visible    xpath: //div[@class="sfx_label_223"][2]    300
			sleep    1
			${value1}=    Selenium2Library.get text    xpath: //div[@class="sfx_label_223"][2]
			IF    "${value1}"=="0 marked"
				Wait Until Element Is Visible      xpath: (//div[@class="sf-element sf-element-canvas-visualization"])[2]
				Selenium2Library.Drag And Drop by Offset 	xpath: (//div[@class="sf-element sf-element-canvas-visualization"])[2]    140    80
				wait until element is visible    xpath: //div[@class="sfx_label_223"][2]    300
				sleep    1
				${value2}=    Selenium2Library.get text    xpath: //div[@class="sfx_label_223"][2]
				IF    "${value2}"=="0 marked"
					Wait Until Element Is Visible      xpath: (//div[@class="sf-element sf-element-canvas-visualization"])[2]
					Selenium2Library.Drag And Drop by Offset 	xpath: (//div[@class="sf-element sf-element-canvas-visualization"])[2]    140    -100
				END
			END
		END
    ELSE IF    "${measure}" == "PRB"
	    Wait Until Element Is Visible      xpath: (//div[@class="sf-element sf-element-canvas-visualization"])[1]
	    Selenium2Library.Drag And Drop by Offset 	xpath: (//div[@class="sf-element sf-element-canvas-visualization"])[1]    -100    -100
	    wait until element is visible    xpath: //div[@class="sfx_label_223"][2]    300
	    sleep    1
	    ${value}=    Selenium2Library.get text    xpath: //div[@class="sfx_label_223"][2]
	    IF    "${value}"=="0 marked"
		    Wait Until Element Is Visible      xpath: (//div[@class="sf-element sf-element-canvas-visualization"])[1]
		    Selenium2Library.Drag And Drop by Offset 	xpath: (//div[@class="sf-element sf-element-canvas-visualization"])[1]    -100    80
		    wait until element is visible    xpath: //div[@class="sfx_label_223"][2]    300
		    sleep    1
		    ${value1}=    Selenium2Library.get text    xpath: //div[@class="sfx_label_223"][2]
		    IF    "${value1}"=="0 marked"
			    Wait Until Element Is Visible      xpath: (//div[@class="sf-element sf-element-canvas-visualization"])[1]
			    Selenium2Library.Drag And Drop by Offset 	xpath: (//div[@class="sf-element sf-element-canvas-visualization"])[1]    140    80
			    wait until element is visible    xpath: //div[@class="sfx_label_223"][2]    300
			    sleep    1
			    ${value2}=    Selenium2Library.get text    xpath: //div[@class="sfx_label_223"][2]
			    IF    "${value2}"=="0 marked"
				    Wait Until Element Is Visible      xpath: (//div[@class="sf-element sf-element-canvas-visualization"])[1]
				    Selenium2Library.Drag And Drop by Offset 	xpath: (//div[@class="sf-element sf-element-canvas-visualization"])[1]    140    -100
			    END
		    END
	    END
	END
	wait for page to load
	capture page screenshot

Make selection on 'per Cell by Date/Time' chart for
	[Arguments]    ${measure}
	IF    "${measure}" == "PUSCH"
		Wait Until Element Is Visible      xpath: (//div[@class="sf-element sf-element-canvas-visualization"])[3]
		Selenium2Library.Drag And Drop by Offset 	xpath: (//div[@class="sf-element sf-element-canvas-visualization"])[3]    -220    -100
		wait until element is visible    xpath: //div[@class="sfx_label_223"][2]    300
		sleep    1
		${value}=    Selenium2Library.get text    xpath: //div[@class="sfx_label_223"][2]
		IF    "${value}"=="0 marked"
			Wait Until Element Is Visible      xpath: (//div[@class="sf-element sf-element-canvas-visualization"])[3]
			Selenium2Library.Drag And Drop by Offset 	xpath: (//div[@class="sf-element sf-element-canvas-visualization"])[3]    -220    60
			wait until element is visible    xpath: //div[@class="sfx_label_223"][2]    300
			sleep    1
			${value1}=    Selenium2Library.get text    xpath: //div[@class="sfx_label_223"][2]
			IF    "${value1}"=="0 marked"
				Wait Until Element Is Visible      xpath: (//div[@class="sf-element sf-element-canvas-visualization"])[3]
				Selenium2Library.Drag And Drop by Offset 	xpath: (//div[@class="sf-element sf-element-canvas-visualization"])[3]    250    60
				wait until element is visible    xpath: //div[@class="sfx_label_223"][2]    300
				sleep    1
				${value2}=    Selenium2Library.get text    xpath: //div[@class="sfx_label_223"][2]
				IF    "${value2}"=="0 marked"
					Wait Until Element Is Visible      xpath: (//div[@class="sf-element sf-element-canvas-visualization"])[3]
					Selenium2Library.Drag And Drop by Offset 	xpath: (//div[@class="sf-element sf-element-canvas-visualization"])[3]    250    -100
				END
			END
		END
    ELSE IF    "${measure}" == "PRB"
	    Wait Until Element Is Visible      xpath: (//div[@class="sf-element sf-element-canvas-visualization"])[4]
	    Selenium2Library.Drag And Drop by Offset 	xpath: (//div[@class="sf-element sf-element-canvas-visualization"])[4]    -220    -100
	    wait until element is visible    xpath: //div[@class="sfx_label_223"][2]    300
	    sleep    1
	    ${value}=    Selenium2Library.get text    xpath: //div[@class="sfx_label_223"][2]
	    IF    "${value}"=="0 marked"
		    Wait Until Element Is Visible      xpath: (//div[@class="sf-element sf-element-canvas-visualization"])[4]
		    Selenium2Library.Drag And Drop by Offset 	xpath: (//div[@class="sf-element sf-element-canvas-visualization"])[4]    -220    60
		    wait until element is visible    xpath: //div[@class="sfx_label_223"][2]    300
		    sleep    1
		    ${value1}=    Selenium2Library.get text    xpath: //div[@class="sfx_label_223"][2]
		    IF    "${value1}"=="0 marked"
			    Wait Until Element Is Visible      xpath: (//div[@class="sf-element sf-element-canvas-visualization"])[4]
			    Selenium2Library.Drag And Drop by Offset 	xpath: (//div[@class="sf-element sf-element-canvas-visualization"])[4]    250    60
			    wait until element is visible    xpath: //div[@class="sfx_label_223"][2]    300
			    sleep    1
			    ${value2}=    Selenium2Library.get text    xpath: //div[@class="sfx_label_223"][2]
			    IF    "${value2}"=="0 marked"
				    Wait Until Element Is Visible      xpath: (//div[@class="sf-element sf-element-canvas-visualization"])[4]
				    Selenium2Library.Drag And Drop by Offset 	xpath: (//div[@class="sf-element sf-element-canvas-visualization"])[4]    250    -100
			    END
		    END
	    END
	END
	wait for page to load
	capture page screenshot

Verify the chart names on Health Check-PRB/PUSCH Analysis
	sleep    5
    element should contain    xpath:(//div[@class="flex-item flex-align-start sf-element sf-element-text-box sf-single-line-text"])[2]    Select upto 10 Cells for Comparison
	element should contain    xpath:(//div[@class="flex-item flex-align-start sf-element sf-element-text-box sf-single-line-text"])[1]    per Selected Cell
	wait for page to load
	capture page screenshot

Verify the chart names on Health Check-PRB Detailed Analysis
	sleep    5
    element should contain    xpath:(//div[@class="flex-item flex-align-start sf-element sf-element-text-box sf-single-line-text"])[2]    Select Time Period(s)
	element should contain    xpath:(//div[@class="flex-item flex-align-start sf-element sf-element-text-box sf-single-line-text"])[4]    Received Uplink Interference Power per PRB (dBm)
	wait for page to load
	capture page screenshot

Verify the chart names on Health Check-PUSCH Detailed Analysis
	sleep    5
    element should contain    xpath:(//div[@class="flex-item flex-align-start sf-element sf-element-text-box sf-single-line-text"])[2]    Average Interference Power in PUSCH per Date/Time
	element should contain    xpath:(//div[@class="flex-item flex-align-start sf-element sf-element-text-box sf-single-line-text"])[3]    Interference Distribution of pmRadioRecInterferencePowerDistr
	wait for page to load
	capture page screenshot

Verify the chart names on Node Troubleshooting-PRB Detailed Analysis
	sleep    5
    element should contain    xpath:(//div[@class="flex-item flex-align-start sf-element sf-element-text-box sf-single-line-text"])[1]    Select Time Period(s)
	element should contain    xpath:(//div[@class="flex-item flex-align-start sf-element sf-element-text-box sf-single-line-text"])[3]    Received Uplink Interference Power per PRB (dBm)
	wait for page to load
	capture page screenshot

Verify the chart names on Node Troubleshooting-PUSCH Detailed Analysis
	sleep    5
    element should contain    xpath:(//div[@class="flex-item flex-align-start sf-element sf-element-text-box sf-single-line-text"])[2]    Average Interference Power in PUSCH per Date/Time
	element should contain    xpath:(//div[@class="flex-item flex-align-start sf-element sf-element-text-box sf-single-line-text"])[3]    Interference Distribution of pmRadioRecInterferencePowerDistr
	wait for page to load
	capture page screenshot


############################################# Future Scope #############################################

Enter number of secondary Data Sources
	[Arguments]    ${n}
	sleep    3
	clear element text    xpath://input[@class="sf-element sf-element-control sfc-property sfc-text-box"]
	sleep    3
	Selenium2Library.Input text    xpath://input[@class="sf-element sf-element-control sfc-property sfc-text-box"]    ${n}
	wait for page to load
	capture page screenshot

Enter secondary Data Source
	[Arguments]    ${dataSource}
	clear element text    xpath:(//*[@class="sf-element sf-element-control sfc-property sfc-text-box"])[2]
	sleep    5
	Selenium2Library.Input text    xpath:(//*[@class="sf-element sf-element-control sfc-property sfc-text-box"])[2]    ${dataSource}
	wait for page to load
	capture page screenshot

Verify that the connection is not made
	sleep    10
	${text}=    Selenium2Library.get text    xpath://div[@class="HtmlTextArea sf-enable-selection sf-focusable"]//p[11]
	Log    ${text}
	should be equal    ${text}    Status: Invalid data source name!
	wait for page to load
	capture page screenshot

reading values from the tooltip in Health Check page chart
	[Arguments]    ${chartName}
	sleep    5
	IF    "${chartName}" == "PUSCH Network"
    	selenium2library.mouse over    xpath:(//div[@class="sf-element-canvas-image"])[1]
    ELSE IF    "${chartName}" == "PRB Network"
    	selenium2library.mouse over    xpath:(//div[@class="sf-element-canvas-image"])[2]
    ELSE IF    "${chartName}" == "PUSCH Worst Cells"
    	selenium2library.mouse over    xpath:(//div[@class="sf-element-canvas-image"])[4]
    ELSE IF    "${chartName}" == "PRB Worst Cells"
    	selenium2library.mouse over    xpath:(//div[@class="sf-element-canvas-image"])[3]
    END
    sleep    5
	${toolTip}=    Selenium2Library.Get Text    xpath: //*[@class="sf-tooltip sf-plot-tooltip RoundedDropShadow"]
	[Log]    ${toolTip}
	${actualUiValue}=    Split String from Right    ${toolTip}
	[Log]    ${actualUiValue}
	${cellValue}=    Get From List    ${actualUiValue}    1
	${uiValue}=    Get From List    ${actualUiValue}    6
	[Log]    ${uiValue}    ${cellValue}
	[Return]    ${uiValue}    ${cellValue}
	sleep    5
	wait for page to load
	capture page screenshot

get sql query from json file
    [Arguments]     ${json_file}     ${data}
    ${json}=    OperatingSystem.get file    ${json_file}
    &{object}=    Evaluate     json.loads('''${json}''')     json
    [return]       ${object}[${data}]
	wait for page to load
	capture page screenshot

query ENIQ database
	[Arguments]       ${sql_query}    ${cellValue}
	${sql_query}=     Replace String    ${sql_query}    @cellValue 		 \'%${cellValue}%'\
    log    ${sql_query}
    ${value}=     Query Sybase database     ${sql_query}
    log    ${value}
    ${string_value}=      Convert to string      ${value}[0]
    [return]     ${string_value}
    sleep    6
    wait for page to load
	capture page screenshot

Match UI with DB Value
	[Arguments]    ${uiValue}    ${db_value}
	Log    ${db_value}
	${db_value}=    Evaluate    ${db_value}+0.00
	Log    ${db_value}
	Log    ${uiValue}
	${uiValue}=    Evaluate    ${uiValue}+0.00
	Log    ${uiValue}
	Verify UI value is matching with DB value    ${uiValue}     ${db_value}
	sleep    7
	wait for page to load
	capture page screenshot

Verify UI value is matching with DB value
	[Arguments]    ${uiValue}    ${dbValue}
	${dbValue}=    convert to string    ${dbValue}
	should contain    ${dbValue}    ${uiValue}
	wait for page to load
	capture page screenshot

reading values from the tooltip in Node Troubleshooting page chart
	[Arguments]    ${chartName}
	sleep    5
	IF    "${chartName}" == "PUSCH per Cell"
    	selenium2library.mouse over    xpath:(//div[@class="sf-focusable"])[2]
    ELSE IF    "${chartName}" == "PUSCH PRB per Cell"
    	selenium2library.mouse over    xpath:(//div[@class="sf-focusable"])[1]
    END
    sleep    5
	${toolTip}=    Selenium2Library.Get Text    xpath: //*[@class="sf-tooltip sf-plot-tooltip RoundedDropShadow"]
	[Log]    ${toolTip}
	${actualUiValue}=    Split String from Right    ${toolTip}
	[Log]    ${actualUiValue}
	${cellValue}=    Get From List    ${actualUiValue}    1
	${uiValue}=    Get From List    ${actualUiValue}    6
	[Log]    ${uiValue}    ${cellValue}
	[Return]    ${uiValue}    ${cellValue}
	sleep    5
	wait for page to load
	capture page screenshot
