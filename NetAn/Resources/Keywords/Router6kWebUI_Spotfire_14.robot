*** Variables ***

${username_xpath}         //input[@class='w-full pt-2 pb-2 pl-3 text-ellipsis pr-3 ng-untouched ng-pristine ng-invalid' and @placeholder='Username']
${password_xpath}         //input[@class='w-full pt-2 pb-2 pl-3 text-ellipsis pr-3 ng-untouched ng-pristine ng-invalid' and @placeholder='Password']
${loginButton_xpath}      //button[@data-testid='login-button']
${sfx_label}              sfx_label_1333
${sfx_page_title}         sfx_page-title_1329
${author_dropdown}        //div[@class='sfx_author-dropdown_1174']
${save_analysis_button}   (//div[text()='Save'])[3]
${notification_container}               sfx_notification-panel-empty_334

*** Keywords ***

login to netan webplayer
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

Validate empty visulalization is present
	${value}=    Selenium2Library.get text      xpath: (//div[@class="errorContainer"]//div)
	should contain        ${value}      Mark values from the previous graph.	
	
open router6k analysis
    login to netan webplayer
    Go To    ${base_url}${router6k_url}
    sleep    10
    ${IsElementVisible}=    Run Keyword And Return Status    Element Should not be Visible    xpath://div[contains(text(),'Missing Data')]
	Run Keyword If    ${IsElementVisible} is ${FALSE}   Close missing data window
    wait for page to load
	go to home page if not at home	
	reset all filters and markings
    wait for page to load
    capture page screenshot

wait for page to load
    Sleep   3s
	Wait Until Element Is Not Visible      xpath://*[@class='sf-svg-loader-12x12']              timeout=3000
    Sleep    2s

Close missing data window
	Wait Until Page Contains Element      xpath://span[contains(text(),'Apply to all inaccessible data tables in this analysis')]     timeout=150
    Click Element    xpath://span[contains(text(),'Apply to all inaccessible data tables in this analysis')]
    sleep    5
    Wait Until Page Contains Element      xpath://button[contains(text(),'OK')]     timeout=150
    Click Element    xpath://button[contains(text(),'OK')]
    wait for page to load
    capture page screenshot

reset all filters and markings
	wait until element is visible    xpath: (//p[@id="reset"])    300
	click element    xpath: (//p[@id="reset"])
	wait for page to load
    capture page screenshot
	
go to home page if not at home
	wait until element is visible    xpath: //*[@class="${sfx_page_title}"]    30
	${pageTitle}=    Selenium2Library.Get text  xpath: //*[@class="${sfx_page_title}"]
	IF 		"${pageTitle}" != "Home"
        scroll element into view		xpath: //*[@title="Home"]
		Click element     xpath: //*[@title="Home"]
	END
	wait for page to load
	capture page screenshot

Suite setup steps for Router6k
    Set Screenshot Directory   ./Screenshots

Suite teardown steps for Router6k
    Close Browser

Test teardown steps for Router6k
    Capture page screenshot

Verify Network Analytics logo is visible
	element should be visible    xpath:((//div[@align="center"])[2]//div//table//tbody//tr//td//p//img)[1]
	wait for page to load
	capture page screenshot

Verify the page title
	[Arguments]     ${expectedText}
	wait for page to load
    ${text}=    Selenium2Library.Get text  xpath: //div[@class="${sfx_page_title}"]
    Log    ${text}
    Should be equal     ${text}    ${expectedText}
    wait for page to load
	capture page screenshot

Verify Router6k logo is visible
	element should be visible    xpath://div[@id="router6k_icon"]
	wait for page to load
	capture page screenshot

Click on scroll up button
    [Arguments]     ${button}    ${n}
    @{element}=    Get WebElements	    xpath: //div[@class="ScrollbarButton sf-element sf-element-scroll-bar-button sfpc-top"]
    ${scroll_button}=        Get from list     ${element}    ${button}
    FOR    ${i}    IN RANGE    0    ${n} 
           Run Keyword and Ignore Error    Click element     ${scroll_button}           
    END
	Sleep      2s
	capture page screenshot

Click on scroll down button
    [Arguments]     ${button}    ${n}
    @{element}=    Get WebElements	    xpath: //div[@class="ScrollbarButton sf-element sf-element-scroll-bar-button sfpc-bottom"]
    ${scroll_button}=        Get from list     ${element}    ${button}
    FOR    ${i}    IN RANGE    0    ${n} 
           Run Keyword and Ignore Error    Click element     ${scroll_button}           
    END
	Sleep      2s
	capture page screenshot

Click on scroll left button
    [Arguments]     ${button}    ${n}
    @{element}=    Get WebElements	    xpath: //div[@class="ScrollbarButton sf-element sf-element-scroll-bar-button sfpc-left"]
    ${scroll_button}=        Get from list     ${element}    ${button}
    FOR    ${i}    IN RANGE    0    ${n} 
           Run Keyword and Ignore Error    Click element     ${scroll_button}           
    END
	Sleep      2s
	capture page screenshot

Click on scroll right button
    [Arguments]     ${button}    ${n}
    @{element}=    Get WebElements	    xpath: //div[@class="ScrollbarButton sf-element sf-element-scroll-bar-button sfpc-right"]
    ${scroll_button}=        Get from list     ${element}    ${button}
    FOR    ${i}    IN RANGE    0    ${n} 
           Run Keyword and Ignore Error    Click element     ${scroll_button}           
    END
	Sleep      2s
	capture page screenshot

Verify that the button is visible
	[Arguments]    ${button}
	element should be visible    xpath://*[@title="${button}"]
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

Check for the error notification is not present
	Click Element      xpath://*[@title="Notifications"]
	Sleep    3s
	
    capture page screenshot
	${notification}=    Get text    xpath://div[@class='${notification_container}']
	
    capture page screenshot
	Should contain          ${notification}         There are currently no notifications	
	
Select KPI Category as  
    [Arguments]     ${kpi_type}
	Run Keyword And Continue on Failure    Click on scroll left button    8    10
    Run Keyword And Continue on Failure    Click on scroll left button    6    10

    @{element}=    Get WebElements      xpath: //div[@class='ComboBoxTextDivContainer']
    ${kpi_types}=        Get from list     ${element}    0
    Click element     ${kpi_types}
    sleep  2s
    Click element      xpath://div[@title='${kpi_type}']
    sleep    2
    wait for page to load
    capture page screenshot

Select KPI as
    [Arguments]    ${kpi_name_list}    
    
    Run Keyword And Continue on Failure    Click on scroll left button    6    8
    Run Keyword And Continue on Failure    Click on scroll left button    8    10
    @{list}=      Split string      ${kpi_name_list}     ,  
    FOR    ${kpi_name}    IN    @{list}
        FOR    ${i}    IN RANGE    0    5
            ${status}=      Run keyword and return status   element should be visible      xpath: //div[@class='ListItems']/div[@title='${kpi_name}']
            IF    ${status} is ${TRUE}
                sleep    2s
                Click element    xpath: //div[@class='ListItems']/div[@title='${kpi_name}']    modifier=CTRL
                Exit For Loop
            ELSE
                Run Keyword And Continue on Failure    Click on scroll right button    8    15
                Run Keyword And Continue on Failure    Click on scroll right button    6    15

                Run Keyword And Continue on Failure    Click on scroll down button    2    5
                Run Keyword And Continue on Failure    Click on scroll down button    3    5
                
                Run Keyword And Continue on Failure    Click on scroll left button    8    15
                Run Keyword And Continue on Failure    Click on scroll left button    6    15
            END
        END
	
	${status} =      Run keyword and return status     element should be visible    xpath: //div[@class='ListItems']/div[@title='${kpi_name}' and @class="sf-element-list-box-item sfpc-selected"]
	IF    "${status}"=="False"
	    Click element    xpath: //div[@class='ListItems']/div[@title='${kpi_name}']    modifier=CTRL
    END    
	IF    "${status}"=="False"
    Run keyword and return status    Click element    xpath: //div[@class='ListItems']/div[@title='...']    modifier=CTRL	
    END    
    END        
    wait for page to load
    capture page screenshot

Select Aggregation level as  
    [Arguments]     ${aggregation_level}
	Run Keyword And Continue on Failure    Click on scroll left button    6    8
    Run Keyword And Continue on Failure    Click on scroll left button    8    10
    @{element}=    Get WebElements      xpath: //div[@class='ComboBoxTextDivContainer']
    ${aggregation_levels}=        Get from list     ${element}    1
    Click element     ${aggregation_levels}
    sleep  2s
    Click element      xpath://div[@title='${aggregation_level}']
    sleep    2
    wait for page to load
    capture page screenshot

Select Aggregation function as
    [Arguments]     ${aggregation_function}
	Run Keyword And Continue on Failure    Click on scroll left button    6    8
    Run Keyword And Continue on Failure    Click on scroll left button    8    10
    @{element}=    Get WebElements      xpath: //div[@class='ComboBoxTextDivContainer']
    ${aggregation_functions}=        Get from list     ${element}    2
    Click element     ${aggregation_functions}
    sleep  2s
    Click element      xpath://div[@title='${aggregation_function}']
    sleep    2
    wait for page to load
    capture page screenshot

Select nodenames as
    [Arguments]    ${nodename_list}		${page_name}
    
    Run Keyword And Continue on Failure    Click on scroll left button    8    10
    Run Keyword And Continue on Failure    Click on scroll right button    6    10
    Run Keyword And Continue on Failure    Click on scroll up button    5    10
    Run Keyword And Continue on Failure    Click on scroll left button    6    10
    capture page screenshot
    @{list}=      Split string      ${nodename_list}     ,  
    FOR    ${nodename}    IN    @{list}
        FOR    ${i}    IN RANGE    0    5
            ${status}=      Run keyword and return status   element should be visible      xpath: (//div[@class='ListItems']/div[@title='${nodename}'])[2]
            log    ${status}
            IF    ${status} is ${TRUE}
                Click element    xpath: (//div[@class='ListItems']/div[@title='${nodename}'])[2]    modifier=CTRL
                Exit For Loop
            ELSE
                Run Keyword And Continue on Failure    Click on scroll right button    6    5
                Run Keyword And Continue on Failure    Click on scroll down button    5    3
                Run Keyword And Continue on Failure    Click on scroll left button    6    8

                Run Keyword And Continue on Failure    Click on scroll right button    8    10
                Run Keyword And Continue on Failure    Click on scroll down button    8    3
                Run Keyword And Continue on Failure    Click on scroll left button    8    10
            END
        END
    END        
    wait for page to load
    capture page screenshot

Click Refresh Button
    Run Keyword And Continue on Failure    Click on scroll left button    6    8
    Run Keyword And Continue on Failure    Click on scroll down button    6    30 
	Run keyword and Continue on Failure		Click on scroll down button    8     30
	Run Keyword And Continue on Failure    Click on scroll left button    8    10
    Click on the button with value    Refresh Data
    wait for page to load
    capture page screenshot
    Sleep    3

Nav to page 
    [Arguments]        ${button_name}
    Click on the button with value        ${button_name}

make chart select after refresh nodes
    Selenium2Library.Drag And Drop By Offset      xpath:(//div[@class="sf-element-canvas-image"])[1]      0      70
	sleep     3s
	Wait Until Element Is Visible      xpath:(//div[@class="sf-element-canvas-image"])[2]
    Selenium2Library.Drag And Drop By Offset      xpath:(//div[@class="sf-element-canvas-image"])[2]    -460    -100
    wait for page to load
    capture page screenshot
	

make selection on the chart
    [Arguments]    ${chart_path}
	Wait Until Element Is Visible      ${chart_path}
	Selenium2Library.Drag And Drop by Offset 	${chart_path}    460    100
	wait until element is visible    xpath: (//div[@class="${sfx_label}"])[2]    300
	sleep    1
	${value}=    Selenium2Library.get text    xpath: (//div[@class="${sfx_label}"])[2]
	Log    ${value}
	IF    "${value}"=="0 marked"
		Wait Until Element Is Visible      ${chart_path}
		Selenium2Library.Drag And Drop by Offset 	${chart_path}    -460    -100
		wait until element is visible    xpath: (//div[@class="${sfx_label}"])[2]    300
		sleep    1
		${value1}=    Selenium2Library.get text    xpath: (//div[@class="${sfx_label}"])[2]
		IF    "${value1}"=="0 marked"
			Wait Until Element Is Visible      ${chart_path}
			Selenium2Library.Drag And Drop by Offset 	${chart_path}    -460    100
			wait until element is visible    xpath: (//div[@class="${sfx_label}"])[2]    300
			${value2}=    Selenium2Library.get text    xpath: (//div[@class="${sfx_label}"])[2]
			IF    "${value2}"=="0 marked"
				Wait Until Element Is Visible      ${chart_path}
				Selenium2Library.Drag And Drop by Offset 	${chart_path}    460    -100
			END
		END
	END
	wait for page to load
	capture page screenshot

Get all kpi html content
    ${inner_html}=    Selenium2Library.Get Element Attribute        xpath: (//div[@class="KpiLayout"])    innerHTML
    RETURN    ${inner_html}

Get Data Table Row Header html
    ${inner_html_1}=    Selenium2Library.Get Element Attribute        xpath: (//div[@name='frozenRowsContainer'])    innerHTML
    Click Element		xpath: (//div[@name='frozenRowsContainer'])
	Click on scroll right button    3    70
    ${inner_html_2}=    Selenium2Library.Get Element Attribute        xpath: (//div[@name='frozenRowsContainer'])    innerHTML
	Click on scroll right button    3    70
    ${inner_html_3}=    Selenium2Library.Get Element Attribute        xpath: (//div[@name='frozenRowsContainer'])    innerHTML
	Click on scroll right button    3    70
    ${inner_html_4}=    Selenium2Library.Get Element Attribute        xpath: (//div[@name='frozenRowsContainer'])    innerHTML
	Click on scroll right button    3    70
    ${inner_html_5}=    Selenium2Library.Get Element Attribute        xpath: (//div[@name='frozenRowsContainer'])    innerHTML
    ${inner_html}=    Set Variable    '${inner_html_1}\n${inner_html_2}\n${inner_html_3}\n${inner_html_4}\n${inner_html_5}'
	
	Click Element		xpath: (//div[@name='frozenRowsContainer'])
	Run Keyword And Continue on Failure    Click on scroll left button    3    300
    RETURN    ${inner_html}

Get Chart Title Count
    wait for page to load
    ${result}=    Get Element Count    xpath: (//div[@class="flex-item flex-align-start sf-element sf-element-text-box sf-single-line-text"])
    capture page screenshot
    RETURN    ${result}

Get StartDate EndDate From Filter
	[Arguments]		${page_name}
    wait for page to load
	
	IF		"${page_name}"=="Node Level KPIs"
		Run keyword and ignore error        Click on scroll down button    6     30
		Run Keyword And Continue on Failure    Click on scroll left button    6    10
        
        ${start_date_element}=    Set Variable		(//div[@class="rawFilter"]//div[@class='LeftAligned EditableLabel']/div[@class='sf-element-text-box ValueLabel'])
        ${ui_date_1}=	Get Text   xpath: ${start_date_element}
        
        Run Keyword And Continue on Failure    Click on scroll right button    6    10
		${end_date_element}=    Set Variable		(//div[@class="rawFilter"]//div[@class='RightAligned EditableLabel']/div[@class='sf-element-text-box ValueLabel'])
		${ui_date_2}=	Get Text   xpath: ${end_date_element}

	ELSE
		Run keyword and ignore error        Click on scroll down button    8     30
		Run Keyword And Continue on Failure    Click on scroll left button    8    10
		
		${start_date_element}=    Set Variable		(//div[@class="rawFilterInterface"]//div[@class='LeftAligned EditableLabel']/div[@class='sf-element-text-box ValueLabel'])
		${ui_date_1}=	Get Text   xpath: ${start_date_element}
		
		Run Keyword And Continue on Failure    Click on scroll right button    8    10
		${end_date_element}=    Set Variable		(//div[@class="rawFilterInterface"]//div[@class='RightAligned EditableLabel']/div[@class='sf-element-text-box ValueLabel'])
		${ui_date_2}=	Get Text   xpath: ${end_date_element}
	END
	
	${start_date}=    Convert Datetime     ${ui_date_1}    %m/%d/%Y    %Y-%m-%d
    ${end_date}=    Convert Datetime     ${ui_date_2}    %m/%d/%Y    %Y-%m-%d
    
	RETURN    ${start_date}    ${end_date}

Get First Row Data From Table
	${data_html_1}=    Selenium2Library.Get Element Attribute    xpath: (//div[@name='valueCellsContainer'])    innerHTML
    Click Element    xpath: (//div[@name='frozenRowsContainer'])
    
	Run Keyword And Continue on Failure    Click on scroll right button    3    70
    ${data_html_2}=    Selenium2Library.Get Element Attribute    xpath: (//div[@name='valueCellsContainer'])    innerHTML
	Run Keyword And Continue on Failure    Click on scroll right button    3    70
    ${data_html_3}=    Selenium2Library.Get Element Attribute    xpath: (//div[@name='valueCellsContainer'])    innerHTML
	Run Keyword And Continue on Failure    Click on scroll right button    3    70
    ${data_html_4}=    Selenium2Library.Get Element Attribute    xpath: (//div[@name='valueCellsContainer'])    innerHTML
	Run Keyword And Continue on Failure    Click on scroll right button    3    70
    ${data_html_5}=    Selenium2Library.Get Element Attribute    xpath: (//div[@name='valueCellsContainer'])    innerHTML
    
	${data_html}=    Set Variable    '${data_html_1}\n${data_html_2}\n${data_html_3}${data_html_4}\n${data_html_5}'
	RETURN		${data_html}

Get First Row Data from Filtered Data
    wait for page to load
    Click on the button with value    Filtered Data >>
    wait for page to load
    
    ${row_number}=    Selenium2Library.Get Element Attribute    xpath: (//div[@name='valueCellCanvas']/div/div)    row

    ${row_headers_html}=    Get Data Table Row Header html
	
    ${data_html}=    Get First Row Data From Table
    capture page screenshot
    
    RETURN    ${row_headers_html}    ${data_html}    ${row_number}


