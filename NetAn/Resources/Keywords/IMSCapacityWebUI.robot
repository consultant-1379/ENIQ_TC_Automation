*** Settings ***
Library    Selenium2Library

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
${notification_container1}    sfx_notification-panel-empty_492


*** Keywords ***
suite setup for webui
	#Set Environment Variable  webdriver.chrome.driver    ${CURDIR}/../../drivers/chromedriver.exe
	Set Environment Variable  webdriver.chrome.driver    ./drivers/chromedriver.exe
	Set Screenshot Directory   ./Screenshots


  #####ims Capacity################
open ims capacity analysis
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
    Go To    ${base_url}${ims_url}
    sleep    30s
    ${IsElementVisible}=    Run Keyword And Return Status    Element Should not be Visible    xpath://div[contains(text(),'Missing Data')]
	Run Keyword If    ${IsElementVisible} is ${FALSE}   Close missing data window
	sleep    30
    wait for page to load

Suite setup steps for IMS Capacity Analysis
	Set Screenshot Directory   ./Screenshots
	Set Selenium Implicit Wait        60s
	open ims capacity analysis

Suite teardown steps for IMS Capacity Analysis
    Close Browser

Test teardown steps for IMS Capacity Analysis
    Capture page screenshot
    run keyword and ignore error    Go to home page if not already at home

verify buttons for Capacity
    [Arguments]       ${node}
    Element Should Be Visible    xpath: //*[@title="Home"]
    Element Should Be Visible    xpath: //*[@value="IMS Node Overview"]
    Element Should Be Visible    xpath: //*[@value="${node}: Traffic"]
    Element Should Be Visible    xpath: //*[@value="${node}: Filtered Data"]
    sleep   3

verify buttons for Traffic
    [Arguments]       ${node}
    Element Should Be Visible    xpath: //*[@title="Home"]
    Element Should Be Visible    xpath: //*[@value="IMS Node Overview"]
    Element Should Be Visible    xpath: //*[@value="${node}: Platform and Capacity"]
    Element Should Be Visible    xpath: //*[@value="${node}: Filtered Data"]
    sleep   3

verify buttons for Traffic HSS-FE
    [Arguments]       ${node}
    Element Should Be Visible    xpath: //*[@title="Home"]
    Element Should Be Visible    xpath: //*[@value="IMS Node Overview"]
    Element Should Be Visible    xpath: //*[@value="${node}:Platform and Capacity"]
    Element Should Be Visible    xpath: //*[@value="${node}: Filtered Data"]
    sleep   3

verify buttons for Traffic without Capacity
    [Arguments]       ${node}
    Element Should Be Visible    xpath: //*[@title="Home"]
    Element Should Be Visible    xpath: //*[@value="IMS Node Overview"]
    Element Should Be Visible    xpath: //*[@value="${node}: Platform"]
    Element Should Be Visible    xpath: //*[@value="${node}: Filtered Data"]
    sleep   3

verify home button
    Element Should Be Visible    xpath: //*[@title="Home"]

multiselect for KPI
    [Arguments]      ${list1}    ${list2}
    Drag And Drop    xpath://*[@title="${list1}"]    xpath://*[@title="${list2}"]
    Sleep    3s

Close missing data window
	Wait Until Page Contains Element      xpath://span[contains(text(),'Apply to all inaccessible data tables in this analysis')]     timeout=150
    Click Element    xpath://span[contains(text(),'Apply to all inaccessible data tables in this analysis')]
    sleep    5
    Wait Until Page Contains Element      xpath://button[contains(text(),'OK')]     timeout=150
    Click Element    xpath://button[contains(text(),'OK')]

Bypass security window
    Sleep    1s
    Click Element    xpath://*[@id="details-button"]
    Sleep    2s
    Click Link       xpath://*[@id="proceed-link"]
    Sleep    2s

click on Home button
	Wait Until Element Is Visible     xpath: //*[@title="Home"]    300
    Click element     xpath: //*[@title="Home"]
    wait for page to load
    capture page screenshot

click on button
    [Arguments]      ${button}
	Wait Until Element Is Visible     xpath: //*[contains(@value,"${button}")]    120
    Click element     xpath: //*[contains(@value,"${button}")]
    wait for page to load
    capture page screenshot

click on the Reset button
	Wait Until Element Is Visible     xpath: //*[@title="Reset"]    300
    Click element     xpath: //*[@title="Reset"]
    wait for page to load
    capture page screenshot

click on the Settings button
	Wait Until Element Is Visible     xpath: //*[@title="Settings"]    300
    Click element     xpath: //*[@title="Settings"]
    wait for page to load
    capture page screenshot

click on the IMS Node Overview button
	Wait Until Element Is Visible     xpath: //*[@title="IMS Node Overview"]    400
    Click element     xpath: //*[@title="IMS Node Overview"]
    wait for page to load
    capture page screenshot

click on 'CSCF: Platform and Capacity >>' link
	Wait Until Element Is Visible     xpath: //*[@id="cscfPlatform"]    300
    Click element     xpath: //*[@id="cscfPlatform"]
    wait for page to load
    capture page screenshot

validate the page title as
	[Arguments]     ${expectedText}
    ${text}=    Selenium2Library.Get text  xpath: ${sfx_page_title}
    Log    ${text}
    Should contain     ${expectedText}	 ${text}
    wait for page to load
    capture page screenshot

validate the node type as
	[Arguments]     ${nodeid}     ${expectedText}
    ${text}=    Selenium2Library.Get text  xpath: //*[@id="${nodeid}"]
    Log    ${text}
    Should contain     ${expectedText}	 ${text}
    wait for page to load
    capture page screenshot

change threshold of node types
	${ele}=      Get WebElement      xpath: //*[@id="9637dd0add8d42dd86f82c952b27821d"]/div/div/div[4]
    Selenium2Library.Drag And Drop By Offset    ${ele}    -50    0
    sleep     2s
    wait for page to load
    capture page screenshot

wait for the page
	[Arguments]     ${pageName}
	Wait Until Element Is Visible	//*[@class="sfx_page-title_1329" and text()='${pageName}']	100
    wait for page to load
    capture page screenshot

validate the text
	[Arguments]     ${expectedText}
	Sleep 	5s
	Click on scroll down button based on index		2
    ${text}=     Get Element Attribute 		xpath: //*[@id="5434f8a1-470b-4a9e-ac27-60676d01779e"]/font/table/tbody/tr[1]/td[2]/span/span[1]		strong
    Log    ${text}
    Should contain     ${text}	 ${expectedText}
    wait for page to load
    capture page screenshot

click on Home button if current its not in home page
	${pageTitle}=    Selenium2Library.Get text  xpath: ${sfx_page_title}
	IF  "${pageTitle}" != "HOME"	Click element     xpath: //*[@title="Home"]
    wait for page to load
    capture page screenshot

make selections on chart
	SikuliLibrary.Drag And Drop 	${IMAGE_DIR}\\KPIDetails1.PNG  	 ${IMAGE_DIR}\\KPIDetails4.PNG
    wait for page to load
    capture page screenshot

Click on scroll down button based on index
    [Arguments] 	${n}
	@{element}=     Get WebElements     xpath://*[@id="id157"]/div/div[2]/div[2]
	${scroll_button}=     Get From List   ${element} 0
	FOR     ${i}    IN RANGE    0  ${n}
		Click element ${scroll_button}
	END
    wait for page to load
    capture page screenshot

Click on the scroll down button
    [Arguments]     ${button}    ${n}
    @{element}=    Get WebElements	    xpath: //div[@class="ScrollbarButton sf-element sf-element-scroll-bar-button sfpc-bottom"]
    ${scroll_button}=       Get From List    ${element}    ${button}
    FOR    ${i}    IN RANGE    0    ${n}
           Run Keyword and Ignore Error    Click element     ${scroll_button}
    END
    wait for page to load
	capture page screenshot

click on 'CSCF: Traffic' link
	Wait Until Element Is Visible     xpath: //*[@id="cscfTraffic"]    300
    Click element     xpath: //*[@id="cscfTraffic"]
    wait for page to load
    capture page screenshot

validate the title
	[Arguments]     ${expectedTitle}
    ${text}=    Selenium2Library.Get text    xpath: //*[@title='${expectedTitle}']
    Log    ${text}
    Should contain     ${expectedTitle}	 ${text.strip()}
    wait for page to load
    capture page screenshot

verify that the Network Analytics logo is present
    Sleep    2s
    Page Should Contain Image  xpath:/html/body/div/div[2]/div/div[1]/div/div/div[2]/div/div/div/div/div/div/div/div/div[1]/div/div/div[1]/div/div/div/table/tbody/tr[1]/td/p/img
    Sleep    2s
    Capture Page Screenshot

verify that the IMS Capacity Analysis logo is present
    Sleep    2s
    Element Should Contain    xpath:/html/body/div/div[2]/div/div[1]/div/div/div[2]/div/div/div/div/div/div/div/div/div[1]/div/div/div[1]/div/div/div/table/tbody/tr[2]/td/div/div      IMS Capacity Analysis
    Sleep    2s
    Capture Page Screenshot

verify that the IMS Node Overview button is present
    Sleep    2s
    Page Should Contain Element    xpath: //*[@title="IMS Node Overview"]
    Sleep    2s
    Capture Page Screenshot

verify that the Settings button is present
    Sleep    2s
    Page Should Contain Element    xpath: //*[@title="Settings"]
    Sleep    2s
    Capture Page Screenshot

verify that the Reset button is present
    Sleep    2s
    Page Should Contain Element    xpath: //*[@title="Reset"]
    Sleep    2s
    Capture Page Screenshot

verify that the home button is present
    Sleep    2s
    Element Should Be Visible    xpath: //*[@title="Home"]
    Sleep    2s
    Capture Page Screenshot

verify table is generated in Filtered Data page
    Sleep    2s
    Page Should Not Contain    ${Missing_Data_Message}
    Sleep    2s
    Capture Page Screenshot

Verify the Reset button has reset filters and markings
    Sleep    2s
    Page Should Contain    ${Missing_Data_Message}
    Sleep    2s
    Capture Page Screenshot

verify the Time Range label is present
    Sleep    2s
    Element Should Contain    xpath:/html/body/div/div[2]/div/div[1]/div/div/div[2]/div/div/div/div/div/div/div/div/div[2]/div/div/div[1]/font/table/tbody/tr[1]/td[2]/span/span[1]		Time Range
    Sleep    2s
    capture page screenshot

verify IMS Node Overview is present
    Sleep    2s
    Page Should Contain Image    xpath:/html/body/div/div[2]/div/div[1]/div/div/div[2]/div/div/div/div/div/div/div/div/div[2]/div/div/div[1]/font/table/tbody/tr[1]/td[1]/img
    Sleep    2s
    capture page screenshot

verify Time Range dropdown is present
    Sleep    2s
    Element Should Be Visible    //*[@class="sf-element-text-box"]
    Sleep    2s
    capture page screenshot

verify Time range and KPIs are displayed
    validate the title time range  		Time Range:
    Element Should Be Visible    xpath: //*[@class="ComboBoxTextDivContainer"]
    validate the title kpis 	KPIs:
    Scroll Element Into View    xpath: //*[@class="ListItems"]
    Element Should Be Visible    xpath: //*[@class="ListItems"]
    wait for page to load
    capture page screenshot

validate the title time range
	[Arguments]     ${expectedTitle}
	${text}=    Selenium2Library.Get text   xpath: //strong/font[text()='Time Range:']
	Log    ${text}
    Should contain     ${expectedTitle}	 ${text}
    wait for page to load
    capture page screenshot

validate the title kpis
	[Arguments]     ${expectedTitle}
	${text}=    Selenium2Library.Get text  xpath: //strong/font[text()='KPIs:']
	Log    ${text}
    Should contain     ${expectedTitle}	  ${text}
    wait for page to load
    capture page screenshot

click on IMS Node Overview button on Home page
    Wait Until Element Is Visible     xpath: //*[@value="IMS Node Overview"]    400
    Click element     xpath: //*[@value="IMS Node Overview"]
    wait for page to load
    capture page screenshot

validate the title time range in IMS Node Overview page
	[Arguments]     ${expectedTitle}
	${text}=    Selenium2Library.Get text   xpath: //span[1]/strong
	Log    ${text}
    Should contain     ${expectedTitle}	 ${text}
    wait for page to load
    capture page screenshot

click on MTAS:Traffic button from Home page
	Wait Until Element Is Visible     xpath: //*[@value="MTAS:Traffic"]    400
    Click element     xpath: //*[@value="MTAS:Traffic"]
    wait for page to load
    capture page screenshot

click on 'MTAS: Platform and Capacity >>' link
	Wait Until Element Is Visible     xpath: //*[@id="mtasPlatform"]    300
    Click element     xpath: //*[@id="mtasPlatform"]
    wait for page to load
    capture page screenshot

click on 'SBG: Platform >>' link
	Wait Until Element Is Visible     xpath: //*[@id="sbgPlatform"]    300
    Click element     xpath: //*[@id="sbgPlatform"]
    wait for page to load
    capture page screenshot

click on Traffic button from Home page
	[Arguments]     ${buttonName}
	Wait Until Element Is Visible     xpath: //*[@value='${buttonName}']    400
    Click element     xpath: //*[@value='${buttonName}']
    wait for page to load
    capture page screenshot

click on 'MRS: Platform >>' link
	Wait Until Element Is Visible     xpath: //*[@id="MRSPlatform"]    300
    Click element     xpath: //*[@id="MRSPlatform"]
    wait for page to load
    capture page screenshot

click on 'HSS: Platform and Capacity >>' link
	Wait Until Element Is Visible     xpath: //*[@id="HSSPlatform"]    300
    Click element     xpath: //*[@id="HSSPlatform"]
    wait for page to load
    capture page screenshot

click on 'HSS-FE: Platform and Capacity >>' link
	Wait Until Element Is Visible     xpath: //*[@id="HSS-FEPlatform"]    300
    Click element     xpath: //*[@id="HSS-FEPlatform"]
    wait for page to load
    capture page screenshot

click on "Settings" img button
	Wait Until Element Is Visible     xpath: //*[@title="Settings"]    300
    Click element     xpath: //*[@title="Settings"]
    wait for page to load
    capture page screenshot

click on "Filtered Data" button
	Wait Until Element Is Visible     xpath: //*[@value="Filtered Data"]    100
    Click element     xpath: //*[@value="Filtered Data"]
    wait for page to load
    capture page screenshot

click on 'CSCF: Traffic >>' link
	Wait Until Element Is Visible     xpath: //*[@id="cscfTraffic"]    300
    Click element     xpath: //*[@id="cscfTraffic"]
    wait for page to load
    capture page screenshot

 click on 'MTAS: Traffic >>' link
 	Wait Until Element Is Visible     xpath: //*[@id="mtasTraffic"]    300
    Click element     xpath: //*[@id="mtasTraffic"]
    wait for page to load
    capture page screenshot

click on 'HSS: Traffic >>' link
	Wait Until Element Is Visible     xpath: //*[@id="HSSTraffic"]    300
    Click element     xpath: //*[@id="HSSTraffic"]
    wait for page to load
    capture page screenshot

click on 'MRS: Traffic >>' link
	Wait Until Element Is Visible     xpath: //*[@id="MRSTraffic"]    300
    Click element     xpath: //*[@id="MRSTraffic"]
    wait for page to load
    capture page screenshot

click on 'SBG: Traffic >>' link
	Wait Until Element Is Visible     xpath: //*[@id="sbgTraffic"]    300
    Click element     xpath: //*[@id="sbgTraffic"]
    wait for page to load
    capture page screenshot

click on 'HSS-FE: Traffic >>' link
 	Wait Until Element Is Visible     xpath: //*[@id="HSS-FETraffic"]    100
    Click element     xpath: //*[@id="HSS-FETraffic"]
    wait for page to load
    capture page screenshot

validate page title as
	[Arguments]     ${expectedText}
	sleep    5
    ${text}=    Selenium2Library.Get text  xpath: ${sfx_page_title}
    Log    ${text}
    Should contain     ${expectedText}    ${text}
    wait for page to load
    capture page screenshot

#################spotfire11#########################
click on link
	[Arguments]    ${linkTitle}
	sleep    4
    IF "${linkTitle}" == "MRS: Platform >>"
    	  Click on scroll down button on IMS Node Overview Page    20    0
          Wait Until Element Is Visible     xpath: //*[@id="MRSPlatform"]    300
		  Click element    xpath: //*[@id="MRSPlatform"]
    ELSE IF "${linkTitle}" == "CSCF: Platform and Capacity >>"
          Wait Until Element Is Visible     xpath: //*[@id="cscfPlatform"]    300
    	  Click element    xpath: //*[@id="cscfPlatform"]
    ELSE IF "${linkTitle}" == "CSCF: Traffic >>"
    	  Wait Until Element Is Visible     xpath: //*[@id="cscfTraffic"]    300
    	  Click element    xpath: //*[@id="cscfTraffic"]
    ELSE IF "${linkTitle}" == "HSS: Platform and Capacity >>"
          Click on scroll down button on IMS Node Overview Page    20    0
          Wait Until Element Is Visible     xpath: //*[@id="HSSPlatform"]    300
    	  Click element    xpath: //*[@id="HSSPlatform"]
    ELSE IF "${linkTitle}" == "HSS: Traffic >>"
          Click on scroll down button on IMS Node Overview Page    20    0
          Wait Until Element Is Visible     xpath: //*[@id="HSSTraffic"]    300
    	  Click element    xpath: //*[@id="HSSTraffic"]
    ELSE IF "${linkTitle}" == "HSS-FE: Platform and Capacity >>"
          Click on scroll down button on IMS Node Overview Page    20    0
          Wait Until Element Is Visible     xpath: //*[@id="HSS-FEPlatform"]    300
    	  Click element    xpath: //*[@id="HSS-FEPlatform"]
    ELSE IF "${linkTitle}" == "HSS-FE: Traffic >>"
          Click on scroll down button on IMS Node Overview Page    20    0
          Wait Until Element Is Visible     xpath: //*[@id="HSS-FETraffic"]    300
    	  Click element    xpath: //*[@id="HSS-FETraffic"]
    ELSE IF "${linkTitle}" == "MRS: Traffic >>"
          Click on scroll down button on IMS Node Overview Page    20    0
          Wait Until Element Is Visible     xpath: //*[@id="MRSTraffic"]    300
    	  Click element    xpath: //*[@id="MRSTraffic"]
    ELSE IF "${linkTitle}" == "MTAS: Platform and Capacity >>"
          Click on scroll down button on IMS Node Overview Page    20    0
          Wait Until Element Is Visible     xpath: //*[@id="mtasPlatform"]    300
    	  Click element    xpath: //*[@id="mtasPlatform"]
    ELSE IF "${linkTitle}" == "MTAS: Traffic >>"
          Click on scroll down button on IMS Node Overview Page    20    0
          Wait Until Element Is Visible     xpath: //*[@id="mtasTraffic"]    300
    	  Click element    xpath: //*[@id="mtasTraffic"]
    ELSE IF "${linkTitle}" == "SBG: Platform >>"
          Click on scroll down button on IMS Node Overview Page    20    0
          Wait Until Element Is Visible     xpath: //*[@id="sbgPlatform"]    300
    	  Click element    xpath: //*[@id="sbgPlatform"]
    ELSE IF "${linkTitle}" == "SBG: Traffic >>"
          Click on scroll down button on IMS Node Overview Page    20    0
          Wait Until Element Is Visible     xpath: //*[@id="sbgTraffic"]    300
    	  Click element    xpath: //*[@id="sbgTraffic"]
    END
    wait for page to load
    capture page screenshot

Make Selection in Time Range
	Sleep    3
	Wait Until Element Is Visible     xpath: //*[@class="sf-element sf-element-control sfc-property"]   60
	Click element     xpath: //*[@class="sf-element sf-element-control sfc-property"]
	sleep    2
	Wait Until Element Is Visible     xpath: //*[@title="Last 30 days"]    300
	Click element     xpath: //*[@title="Last 30 days"]
    wait for page to load
    capture page screenshot

Click on scroll down button on IMS Node Overview Page
	[Arguments]    ${n}    ${instance}
	sleep    2
	${element}=    Get WebElements    xpath: //div[@class='ScrollbarButton sf-element sf-element-scroll-bar-button sfpc-bottom']
	${scroll_button}=     Get From List     ${element}    ${instance}
	FOR    ${i}    IN RANGE    0    ${n}
		run keyword and ignore error    Click element    ${scroll_button}
    END
    wait for page to load
    capture page screenshot

In KPIs section select
	[Arguments]    ${kpiTitle}
	sleep    4s
	Wait Until Element Is Visible     xpath: //*[@title='${kpiTitle}']    300
    Click element     xpath: //*[@title='${kpiTitle}']
    wait for page to load
    capture page screenshot

select nodes from 'Node KPI Performance' section
	Sleep    3
	Selenium2Library.drag and drop by offset    xpath:(//div[@class="sf-element sf-element-canvas-visualization"])[2]    50    -200
	wait for page to load
    capture page screenshot

select CSCF nodes from 'Node KPI Performance' section
	Sleep    3
	Selenium2Library.drag and drop by offset    xpath:(//div[@class="sf-element sf-element-canvas-visualization"])[2]    50    -200
	wait for page to load
    capture page screenshot

select CSCF nodes from 'Node KPI Performance' section for filtered data
	Sleep    3
	Selenium2Library.drag and drop by offset    xpath:(//div[@class="sf-element sf-element-canvas-visualization"])[1]    50    -200
	wait for page to load
    capture page screenshot

select HSS nodes from 'Node KPI Performance' section
	Sleep    3
	Selenium2Library.drag and drop by offset    xpath:(//div[@class="sf-element sf-element-canvas-visualization"])[2]    50    -200
	wait for page to load
    capture page screenshot

select HSS nodes from 'Node KPI Performance' for Platform section
	Sleep    3
	Selenium2Library.drag and drop by offset    xpath:(//div[@class="sf-element sf-element-canvas-visualization"])[1]    50    -200
	wait for page to load
    capture page screenshot

select MTAS nodes from 'Node KPI Performance' section
	Sleep    3
	Selenium2Library.drag and drop by offset    xpath:(//div[@class="sf-element sf-element-canvas-visualization"])[1]    50    -200
	wait for page to load
    capture page screenshot

select SBG nodes from 'Node KPI Performance' section
	Sleep    3
	Selenium2Library.drag and drop by offset    xpath:(//div[@class="sf-element sf-element-canvas-visualization"])[1]    -50    -200
    wait for page to load
    capture page screenshot

select HSS-FE nodes from 'Node KPI Performance' section
	Sleep    3
	Selenium2Library.Drag and drop by offset    xpath:(//div[@class="sf-element sf-element-canvas-visualization"])[1]    50    -200
    wait for page to load
    capture page screenshot

make selection in the HSS-FE 'KPI Details' graph
    Selenium2Library.Drag and drop by offset    xpath: (//div[@class="sf-element-canvas-image"])[2]     150    -250
    wait for page to load
    capture page screenshot

make selection in the 'KPI Details' graph
    Selenium2Library.Drag and drop by offset    xpath: (//div[@class="sf-element-canvas-image"])[2]     150    -250
    wait for page to load
    capture page screenshot

make selection in the CSCF 'KPI Details' graph
    Selenium2Library.Drag and drop by offset    xpath: (//div[@class="sf-element-canvas-image"])[1]     150    -250
    wait for page to load
    capture page screenshot

make selection in the HSS 'KPI Details' graph
    Selenium2Library.Drag and drop by offset    xpath: (//div[@class="sf-element-canvas-image"])[1]     150    -250
    wait for page to load
    capture page screenshot

make selection in the HSS Platform 'KPI Details' graph
    Selenium2Library.Drag and drop by offset    xpath: (//div[@class="sf-element-canvas-image"])[2]     150    -250
    wait for page to load
    capture page screenshot

make selection in the MRS 'KPI Details' graph
    Selenium2Library.Drag and drop by offset    xpath: (//div[@class="sf-element-canvas-image"])[2]     150    -250
    wait for page to load
    capture page screenshot

click on 'Filtered Data' button on the current page
	sleep	 10
	Wait Until Element Is Visible     xpath: //*[@value="Filtered Data"]    300
    Click element     xpath: //*[@value="Filtered Data"]
    wait for page to load
    capture page screenshot

record NodeName & DateTime of first raw from the UI for CSCF
	sleep    3
	${nodeName}=    Selenium2Library.Get text  xpath: //*[@class="sf-element-table-cell flex-justify-start flex-align-start \ sfc-value-cell sfpc-even-column sfpc-odd-row"]
	Log    ${nodeName}
	${dateTime}=    Selenium2Library.Get text  xpath: //*[@class="sf-element-table-cell flex-justify-start flex-align-start \ sfc-value-cell sfpc-even-column sfpc-odd-row"][2]
	Log    ${dateTime}
	${measureValue}=    Selenium2Library.Get text  xpath: //*[@class="sf-element-table-cell flex-justify-end flex-align-start \ sfc-value-cell sfpc-odd-column sfpc-odd-row"][2]
	${measureValue}=    DataIntegrity_Keywords.Remove everything after decimal point from measure value     ${measureValue}
	Log    ${measureValue}
	[Return]    ${measureValue}    ${nodeName}    ${dateTime}
    wait for page to load
    capture page screenshot

record NodeName & DateTime of first raw from the UI for MTAS
	sleep    3
	${nodeName}=    Selenium2Library.Get text  xpath: //*[@class="sf-element-table-cell flex-justify-start flex-align-start \ sfc-value-cell sfpc-odd-column sfpc-odd-row"][3]
	Log    ${nodeName}
	${dateTime}=    Selenium2Library.Get text  xpath: //*[@class="sf-element-table-cell flex-justify-start flex-align-start \ sfc-value-cell sfpc-odd-column sfpc-odd-row"][1]
	Log    ${dateTime}
	${measureValue}=    Selenium2Library.Get text  xpath: //*[@class="sf-element-table-cell flex-justify-end flex-align-start \ sfc-value-cell sfpc-odd-column sfpc-odd-row"][1]
	${measureValue}=    DataIntegrity_Keywords.Remove everything after decimal point from measure value     ${measureValue}
	Log    ${measureValue}
	[Return]    ${measureValue}    ${nodeName}    ${dateTime}
    wait for page to load
    capture page screenshot

record NodeName & DateTime of first raw from the UI for SBG
	sleep    3
	${nodeName}=    Selenium2Library.Get text  xpath: //*[@class="sf-element-table-cell flex-justify-start flex-align-start \ sfc-value-cell sfpc-odd-column sfpc-odd-row"][3]
	Log    ${nodeName}
	${dateTime}=    Selenium2Library.Get text  xpath: //*[@class="sf-element-table-cell flex-justify-start flex-align-start \ sfc-value-cell sfpc-odd-column sfpc-odd-row"][1]
	Log    ${dateTime}
	${measureValue}=    Selenium2Library.Get text  xpath: //*[@class="sf-element-table-cell flex-justify-end flex-align-start \ sfc-value-cell sfpc-odd-column sfpc-odd-row"][1]
	Log    ${measureValue}
	${measureValue}=    DataIntegrity_Keywords.Remove everything after decimal point from measure value     ${measureValue}
	[Return]    ${measureValue}    ${nodeName}    ${dateTime}
    wait for page to load
    capture page screenshot

record NodeName & DateTime of first raw from the UI for HSS
	sleep    3
	${nodeName}=    Selenium2Library.Get text  xpath: //*[@class="sf-element-table-cell flex-justify-start flex-align-start \ sfc-value-cell sfpc-odd-column sfpc-odd-row"][3]
	Log    ${nodeName}
	${dateTime}=    Selenium2Library.Get text  xpath: //*[@class="sf-element-table-cell flex-justify-start flex-align-start \ sfc-value-cell sfpc-odd-column sfpc-odd-row"][1]
	Log    ${dateTime}
	${measureValue}=    Selenium2Library.Get text  xpath: //*[@class="sf-element-table-cell flex-justify-end flex-align-start \ sfc-value-cell sfpc-odd-column sfpc-odd-row"][1]
	${measureValue}=    DataIntegrity_Keywords.Remove everything after decimal point from measure value     ${measureValue}
	Log    ${measureValue}
	[Return]    ${measureValue}      ${nodeName}    ${dateTime}
    wait for page to load
    capture page screenshot

record NodeName & DateTime of first raw from the UI for MRS
	sleep    3
	${nodeName}=    Selenium2Library.Get text  xpath: //*[@class="sf-element-table-cell flex-justify-start flex-align-start \ sfc-value-cell sfpc-odd-column sfpc-odd-row"][3]
	Log    ${nodeName}
	${dateTime}=    Selenium2Library.Get text  xpath: //*[@class="sf-element-table-cell flex-justify-start flex-align-start \ sfc-value-cell sfpc-odd-column sfpc-odd-row"][1]
	Log    ${dateTime}
	${measureValue}=    Selenium2Library.Get text  xpath: //*[@class="sf-element-table-cell flex-justify-end flex-align-start \ sfc-value-cell sfpc-odd-column sfpc-odd-row"][1]
	${measureValue}=    DataIntegrity_Keywords.Remove everything after decimal point from measure value     ${measureValue}
	Log    ${measureValue}
	[Return]     ${measureValue}    ${nodeName}    ${dateTime}
    wait for page to load
    capture page screenshot

record NodeName & DateTime of first raw from the UI for HSS-FE
	sleep    3
	${nodeName}=    Selenium2Library.Get text  xpath: //*[@class="sf-element-table-cell flex-justify-start flex-align-start \ sfc-value-cell sfpc-odd-column sfpc-odd-row"][3]
	Log    ${nodeName}
	${dateTime}=    Selenium2Library.Get text  xpath: //*[@class="sf-element-table-cell flex-justify-start flex-align-start \ sfc-value-cell sfpc-odd-column sfpc-odd-row"][1]
	Log    ${dateTime}
	${measureValue}=    Selenium2Library.Get text  xpath: //*[@class="sf-element-table-cell flex-justify-end flex-align-start \ sfc-value-cell sfpc-odd-column sfpc-odd-row"][1]
	${measureValue}=    DataIntegrity_Keywords.Remove everything after decimal point from measure value     ${measureValue}
	Log    ${measureValue}
	[Return]      ${measureValue}      ${nodeName}    ${dateTime}
    wait for page to load
    capture page screenshot

query the eniq database for
	[Arguments]    ${sql_query}     ${nodeName}    ${dateTime}
	${DB_Value}=     DataIntegrity_Keywords.Query ENIQ database IMS    ${sql_query}    ${dateTime}    ${nodeName}
	${DB_Value}=		DataIntegrity_Keywords.Remove everything after decimal point from measure value     ${DB_Value}
	#Verify UI value is matching with DB value    ${Measure_Value}     ${DB_Value}
	[Return]    ${DB_Value}
    wait for page to load
    capture page screenshot

query the eniq database for cscf
	[Arguments]    ${sql_query}     ${nodeName}    ${dateTime}
	${DB_Value}=     Query ENIQ database IMS CSCF   ${sql_query}    ${dateTime}    ${nodeName}
	${DB_Value}=		DataIntegrity_Keywords.Remove everything after decimal point from measure value     ${DB_Value}
	#Verify UI value is matching with DB value    ${Measure_Value}     ${DB_Value}
	[Return]    ${DB_Value}
    wait for page to load
    capture page screenshot

get sql query from json file
    [Arguments]     ${json_file}     ${data}
    ${json}=    OperatingSystem.get file    ${json_file}
    &{object}=    Evaluate     json.loads('''${json}''')     json
    [Return]       ${object}[${data}]
    wait for page to load
    capture page screenshot

Compare UI with DB value
	[Arguments]    ${measureValue}    ${DB_Value}
	Log    ${DB_Value}
	Log    ${measureValue}
	${measureValue}=    DataIntegrity_Keywords.Remove everything after decimal point from measure value     ${measureValue}
	DataIntegrity_Keywords.Verify UI value is matching with DB value    ${measureValue}     ${DB_Value}
    wait for page to load
    capture page screenshot

Click on horizontal scroll button
	[Arguments]    ${n}    ${instance}
	sleep    2
	${element}=    Get WebElements    xpath: //div[@class='ScrollbarButton sf-element sf-element-scroll-bar-button sfpc-right']
	${scroll_button}=    Get From List      ${element}    ${instance}
	FOR    ${i}    IN RANGE    0    ${n}
		Click element    ${scroll_button}
    END
    wait for page to load
    capture page screenshot

click on Home button if not in home page
	${pageTitle}=    Selenium2Library.Get text    xpath: ${sfx_page_title}
	IF  "${pageTitle}" != "HOME"
		Click element    xpath: //*[@title="Home"]
    END
    wait for page to load
    capture page screenshot

click on IMS Node Overview button
	click on Home button if not in home page
	Wait Until Element Is Visible     xpath: //*[@title="IMS Node Overview"]    300
    Click element     xpath: //*[@title="IMS Node Overview"]
    wait for page to load
    capture page screenshot

click on Reset button
	click on Home button if not in home page
	Click on scroll down button on IMS Node Overview Page    10    0
	Wait Until Element Is Visible     xpath: //*[@title="Reset"]    300
    Click element     xpath: //*[@title="Reset"]
    wait for page to load
    capture page screenshot

wait for page to load
    Sleep   3s
    Wait Until Element Is Not Visible     class:${sfx_progress-bar}        timeout=2400
    Sleep   3s
    Wait Until Element Is Not Visible     class:${sfx_progress-bar}        timeout=2400
    Sleep   3s
    capture page screenshot

click on 'HSS-FE: Traffic' link
	Wait Until Element Is Visible     xpath: //*[@id="HSS-FETraffic"]    300
    Click element     xpath: //*[@id="HSS-FETraffic"]
    wait for page to load
    capture page screenshot

select MRS nodes from 'Node KPI Performance' section
	sleep    3
	Selenium2Library.drag and drop by offset    xpath:(//div[@class="sf-element sf-element-canvas-visualization"])[1]    50    -200
    wait for page to load
    capture page screenshot

back to home page
	Click element     xpath: //*[@title="Home"]
    wait for page to load
    capture page screenshot

validate threshold limit of node type on the basis of color
    Scroll down if element style is not visible    0    20    color: rgb(216, 24, 28); text-align: right;
	element should be visible    xpath:(//span[@style="color: rgb(216, 24, 28); text-align: right;"])
    wait for page to load
    capture page screenshot

Scroll down if element style is not visible
	[Arguments]    ${button}    ${n}    ${elementStyle}
	${IsElementVisible}=    Run Keyword And Return Status    Element Should Be Visible    xpath://*[@style="${elementStyle}"]
	Run Keyword If    ${IsElementVisible} == ${False}   Click on scroll down button on IMS Node Overview Page    ${button}     ${n}
	wait for page to load
	capture page screenshot

verify KPI Settings configuration table in settings page
    [Arguments]     ${columnName1}      ${columnName2}      ${columnName3}      ${NodeType1}    ${NodeType2}    ${NodeType3}    ${NodeType4}    ${NodeType5}    ${NodeType6}
    ${column1}=     Selenium2Library.Get Text    xpath: //*[@class="HtmlTextArea sf-enable-selection sf-focusable"]/span/table/tbody[2]/tr[1]/td[1]/font
    ${column2}=     Selenium2Library.Get Text    xpath: //*[@class="HtmlTextArea sf-enable-selection sf-focusable"]/span/table/tbody[2]/tr[1]/td[2]/font
    ${column3}=     Selenium2Library.Get Text          xpath: //*[@class="HtmlTextArea sf-enable-selection sf-focusable"]/span/table/tbody[2]/tr[1]/td[3]/font
    ${row1NodeType}=     Selenium2Library.Get Text     xpath: //*[@class="HtmlTextArea sf-enable-selection sf-focusable"]/span/table/tbody[2]/tr[2]/td[1]/font
    ${row2NodeType}=     Selenium2Library.Get Text     xpath: //*[@class="HtmlTextArea sf-enable-selection sf-focusable"]/span/table/tbody[2]/tr[4]/td[1]/font
    ${row3NodeType}=     Selenium2Library.Get Text     xpath: //*[@class="HtmlTextArea sf-enable-selection sf-focusable"]/span/table/tbody[2]/tr[6]/td[1]/font
    ${visible}=     Run Keyword And Return Status    Element Should Be Visible    xpath://*[@class="HtmlTextArea sf-enable-selection sf-focusable"]/span/table/tbody[2]/tr[12]/td[1]/font
    Run Keyword If    ${visible} == ${False}    Drag And Drop    xpath:/html/body/div/div[2]/div/div[1]/div/div/div[2]/div/div/div/div/div/div/div/div/div[2]/div/div/div[2]/div[1]     xpath:/html/body/div/div[2]/div/div[1]/div/div/div[2]/div/div/div/div/div/div/div/div/div[2]/div/div/div[2]/div[2]
    ${row4NodeType}=     Selenium2Library.Get Text     xpath: //*[@class="HtmlTextArea sf-enable-selection sf-focusable"]/span/table/tbody[2]/tr[8]/td[1]/font
    ${row5NodeType}=     Selenium2Library.Get Text     xpath: //*[@class="HtmlTextArea sf-enable-selection sf-focusable"]/span/table/tbody[2]/tr[10]/td[1]/font
    ${row6NodeType}=     Selenium2Library.Get Text     xpath: //*[@class="HtmlTextArea sf-enable-selection sf-focusable"]/span/table/tbody[2]/tr[13]/td[1]/font
    Log    ${column1}
    Log    ${column2}
    Log    ${column3}
    Log    ${row1NodeType}
    Log    ${row2NodeType}
    Log    ${row3NodeType}
    Log    ${row4NodeType}
    Log    ${row5NodeType}
    Log    ${row6NodeType}
    Should Contain    ${columnName1}    ${column1}
    Should Contain    ${columnName2}    ${column2}
    Should Contain    ${columnName3}    ${column3}
    Should Contain    ${NodeType1}      ${row1NodeType}
    Should Contain    ${NodeType2}      ${row2NodeType}
    Should Contain    ${NodeType3}      ${row3NodeType}
    Should Contain    ${NodeType4}      ${row4NodeType}
    Should Contain    ${NodeType5}      ${row5NodeType}
    Should Contain    ${NodeType6}      ${row6NodeType}
    Sleep    5s
    capture page screenshot
	
Summary of node type should be visible in table
	[Arguments]     ${expectedText1}     ${expectedText2}     ${expectedText3}     ${expectedText4}     ${expectedText5}     ${expectedText6}     ${expectedText7}     ${expectedText8}     ${expectedText9}     ${expectedText10}     ${expectedText11}     ${expectedText12}     ${expectedText13}     ${expectedText14}     ${expectedText15}     ${expectedText16}
	${element1}=    Selenium2Library.Get text  xpath: //*[@class="HtmlTextArea sf-enable-selection sf-focusable"]/table/tbody/tr[3]/td[1]/font/b
	${element2}=    Selenium2Library.Get text  xpath: //*[@class="HtmlTextArea sf-enable-selection sf-focusable"]/table/tbody/tr[5]/td[1]/font/b
	${element3}=    Selenium2Library.Get text  xpath: //*[@class="HtmlTextArea sf-enable-selection sf-focusable"]/table/tbody/tr[7]/td[1]/font/b
	${element4}=    Selenium2Library.Get text  xpath: //*[@class="HtmlTextArea sf-enable-selection sf-focusable"]/table/tbody/tr[9]/td[1]/font/b
	${element5}=    Selenium2Library.Get text  xpath: //*[@class="HtmlTextArea sf-enable-selection sf-focusable"]/table/tbody/tr[11]/td[1]/font/b
	${element6}=    Selenium2Library.Get text  xpath: //*[@class="HtmlTextArea sf-enable-selection sf-focusable"]/table/tbody/tr[13]/td[1]/font/b
	${element7}=    Selenium2Library.Get text  xpath: //*[@class="HtmlTextArea sf-enable-selection sf-focusable"]/table/tbody/tr[1]/td[1]/font
	${element8}=    Selenium2Library.Get text  xpath: //*[@class="HtmlTextArea sf-enable-selection sf-focusable"]/table/tbody/tr[1]/td[2]/font
	${element9}=    Selenium2Library.Get text  xpath: //*[@class="HtmlTextArea sf-enable-selection sf-focusable"]/table/tbody/tr[1]/td[3]/font
	${element10}=    Selenium2Library.Get text  xpath: //*[@class="HtmlTextArea sf-enable-selection sf-focusable"]/table/tbody/tr[1]/td[4]/font
	${element11}=    Selenium2Library.Get text  xpath: //*[@class="HtmlTextArea sf-enable-selection sf-focusable"]/table/tbody/tr[2]/td[1]/font
	${element12}=    Selenium2Library.Get text  xpath: //*[@class="HtmlTextArea sf-enable-selection sf-focusable"]/table/tbody/tr[2]/td[2]/font
	${element13}=    Selenium2Library.Get text  xpath: //*[@class="HtmlTextArea sf-enable-selection sf-focusable"]/table/tbody/tr[2]/td[3]/font
	${element14}=    Selenium2Library.Get text  xpath: //*[@class="HtmlTextArea sf-enable-selection sf-focusable"]/table/tbody/tr[2]/td[4]/font
	${element15}=    Selenium2Library.Get text  xpath: //*[@class="HtmlTextArea sf-enable-selection sf-focusable"]/table/tbody/tr[2]/td[5]/font
	${element16}=    Selenium2Library.Get text  xpath: //*[@class="HtmlTextArea sf-enable-selection sf-focusable"]/table/tbody/tr[2]/td[6]/font				
	Log    ${element1}
	Log    ${element2}
	Log    ${element3}
	Log    ${element4}
	Log    ${element5}
	Log    ${element6}
	Log    ${element7}
	Log    ${element8}
	Log    ${element9}
	Log    ${element10}
	Log    ${element11}
	Log    ${element12}
	Log    ${element13}
	Log    ${element14}
	Log    ${element15}
	Log    ${element16}
    Should contain     ${expectedText1}	 ${element1}
    Should contain     ${expectedText2}	 ${element2}
    Should contain     ${expectedText3}	 ${element3}
    Should contain     ${expectedText4}	 ${element4}
    Should contain     ${expectedText5}	 ${element5}
    Should contain     ${expectedText6}	 ${element6}
    Should contain     ${expectedText7}	 ${element7}
    Should contain     ${expectedText8}	 ${element8}
    Should contain     ${expectedText9}	 ${element9}
    Should contain     ${expectedText10}	 ${element10}
    Should contain     ${expectedText11}	 ${element11}
    Should contain     ${expectedText12}	 ${element12}
    Should contain     ${expectedText13}	 ${element13}
    Should contain     ${expectedText14}	 ${element14}
    Should contain     ${expectedText15}	 ${element15}
    Should contain     ${expectedText16}	 ${element16}
    wait for page to load
    capture page screenshot
    
check Navigation button for each node type 
	[Arguments]     ${expectedText1}     ${expectedText2}     ${expectedText3}     ${expectedText4}     ${expectedText5}     ${expectedText6}     ${expectedText7}     ${expectedText8}     ${expectedText9}     ${expectedText10}     ${expectedText11}     ${expectedText12}
	${element1}=    Selenium2Library.Get text  xpath: //*[@id="cscfPlatform"]
	${element2}=    Selenium2Library.Get text  xpath: //*[@id="cscfTraffic"]
	${element3}=    Selenium2Library.Get text  xpath: //*[@id="HSSPlatform"]
	${element4}=    Selenium2Library.Get text  xpath: //*[@id="HSSTraffic"]
	${element5}=    Selenium2Library.Get text  xpath: //*[@id="HSS-FEPlatform"]
	${element6}=    Selenium2Library.Get text  xpath: //*[@id="HSS-FETraffic"]
	${element7}=    Selenium2Library.Get text  xpath: //*[@id="MRSPlatform"]
	${element8}=    Selenium2Library.Get text  xpath: //*[@id="MRSTraffic"]
	${element9}=    Selenium2Library.Get text  xpath: //*[@id="mtasPlatform"]
	${element10}=    Selenium2Library.Get text  xpath: //*[@id="mtasTraffic"]
	${element11}=    Selenium2Library.Get text  xpath: //*[@id="sbgPlatform"]
	${element12}=    Selenium2Library.Get text  xpath: //*[@id="sbgTraffic"]
	Log    ${element1}
	Log    ${element2}
	Log    ${element3}
	Log    ${element4}
	Log    ${element5}
	Log    ${element6}
	Log    ${element7}
	Log    ${element8}
	Log    ${element9}
	Log    ${element10}
	Log    ${element11}
	Log    ${element12}
    Should contain     ${expectedText1}	 ${element1}
    Should contain     ${expectedText2}	 ${element2}
    Should contain     ${expectedText3}	 ${element3}
    Should contain     ${expectedText4}	 ${element4}
    Should contain     ${expectedText5}	 ${element5}
    Should contain     ${expectedText6}	 ${element6}
    Should contain     ${expectedText7}	 ${element7}
    Should contain     ${expectedText8}	 ${element8}
    Should contain     ${expectedText9}	 ${element9}
    Should contain     ${expectedText10}	 ${element10}
    Should contain     ${expectedText11}	 ${element11}
    Should contain     ${expectedText12}	 ${element12}
    wait for page to load
    capture page screenshot    

Go to home page if not already at home
	${pageTitle}=    Selenium2Library.Get text  xpath: ${sfx_page_title}
	IF  "${pageTitle}" != "HOME"
        scroll element into view		xpath: //*[@title="Home"]
		Click element     xpath: //*[@title="Home"]
	END
	wait for page to load
	capture page screenshot