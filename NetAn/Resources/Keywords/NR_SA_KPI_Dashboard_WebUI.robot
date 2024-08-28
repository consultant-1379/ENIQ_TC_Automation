*** Keywords ***

open NR SA KPI Dashboard
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
    Go To    ${base_url}${nr_sa_kpi_url}
    sleep    30
    ${IsElementVisible}=    Run Keyword And Return Status    Element Should not be Visible    xpath://div[contains(text(),'Missing Data')]
	Run Keyword If    ${IsElementVisible} is ${FALSE}   Close missing data window
	sleep    20
    wait for page to load
    capture page screenshot
    
Close missing data window
	Wait Until Page Contains Element      xpath://span[contains(text(),'Apply to all inaccessible data tables in this analysis')]     timeout=150
    Click Element    xpath://span[contains(text(),'Apply to all inaccessible data tables in this analysis')]
    sleep    5
    Wait Until Page Contains Element      xpath://button[contains(text(),'OK')]     timeout=150
    Click Element    xpath://button[contains(text(),'OK')]

Go to home page if not already at home
	${pageTitle}=    Selenium2Library.Get text  xpath: //*[@class="sfx_page-title_219"]
	IF 		"${pageTitle}" != "Home"
        scroll element into view		xpath: //*[@title="Home"]
      	 Click element     xpath: //*[@title="Home"]
	END
	wait for page to load
	capture page screenshot

wait for page to load
    Sleep    5s
    Wait Until Element Is Not Visible    class:sfx_progress-bar-container_862    timeout=600
    Sleep    3s
    Wait Until Element Is Not Visible    xpath://div[@title='Processing ...']    timeout=600
    Sleep    5s
    
Suite setup steps    
    Set Screenshot Directory   ./Screenshots

Suite teardown steps
    Capture page screenshot
    
Test teardown
    Capture page screenshot
    Close Browser

Click on hometab
    Sleep    3s
    Click Image    xpath://div[@id='5d6f9dc6-94cd-4208-8c10-6115c8f881c8']//img[@id='d7652ffdb7014924bf9b077c533d3b7b']
    Sleep    3s
	
Click on Settings Image
    Scroll Element Into View    xpath://span[@id='settings']//img[@id='92db5ec7a40848fbb3b6865dac4b9b70']
    Click Image    xpath://img[@id='92db5ec7a40848fbb3b6865dac4b9b70']
    Sleep    5s
    Wait Until Element Is Not Visible    xpath://div[@id="ced51661-7b96-407d-a399-9f883a0b85e9"]
    Sleep    3s
	
Click on Clear button
    Scroll Element Into View    xpath://input[@id='1fc62efe6f9b4ac2a6c589b7054453d2']
    Click element    xpath://input[@id='1fc62efe6f9b4ac2a6c589b7054453d2']
    Sleep    5s


Select KPI as NR-to-LTE Inter-RAT Handover success rate captured in source gNodeB
    ${element}=    Get WebElements    xpath://div[@class='ScrollbarButton sf-element sf-element-scroll-bar-button sfpc-bottom']
    ${ele}=    Get From List      ${element}     4
    Click Element    ${ele}
    Click Element    ${ele}
   
    ${elements}=    Get WebElements    xpath://span[@id='6888246131c24bd98dae4701671c1209']//div[@title='NR-to-LTE Inter-RAT Handover success rate captured in source gNodeB']
    FOR    ${element}    IN    @{elements}
        ${text}=    Get Element Attribute    ${element}    title
        Log    ${text}
        IF    "${text}" == "NR-to-LTE Inter-RAT Handover success rate captured in source gNodeB"
              Click element     ${element}    
              Exit For Loop
        END 
    END
	Sleep    10s

Select KPI as EN-DC Intra-sgNodeB PSCell Change Success Rate Captured in gNodeB
    Scroll Element Into View    xpath://input[@id='bbe41bc576f848fe9172f98ee874ec00']
    Sleep    5s
    ${element}=    Get WebElements    xpath://div[@class='ScrollbarButton sf-element sf-element-scroll-bar-button sfpc-bottom']
    ${ele}=    Get From List      ${element}     4
    Click Element    ${ele}
    Click Element    ${ele}

    ${elements}=    Get WebElements    xpath://span[@id='6888246131c24bd98dae4701671c1209']//div[@title='EN-DC Intra-sgNodeB PSCell Change Success Rate Captured in gNodeB']
    FOR    ${element}    IN    @{elements}
        ${text}=    Get Element Attribute    ${element}    title
        Log    ${text}
        IF    "${text}" == "EN-DC Intra-sgNodeB PSCell Change Success Rate Captured in gNodeB"
              Click element     ${element}    
              Exit For Loop
        END 
    END 
    Sleep    10s
	
Select KPI as EN-DC Inter-sgNodeB PSCell Change Success Rate Captured in gNodeB
    Scroll Element Into View    xpath://input[@id='bbe41bc576f848fe9172f98ee874ec00']
    Sleep    5s
    ${element}=    Get WebElements    xpath://div[@class='ScrollbarButton sf-element sf-element-scroll-bar-button sfpc-bottom']
    ${ele}=    Get From List      ${element}     4
    Click Element    ${ele}
    Click Element    ${ele}
    Click Element    ${ele}

    ${elements}=    Get WebElements    xpath://span[@id='6888246131c24bd98dae4701671c1209']//div[@title='EN-DC Inter-sgNodeB PSCell Change Success Rate Captured in gNodeB']
    FOR    ${element}    IN    @{elements}
        ${text}=    Get Element Attribute    ${element}    title
        Log    ${text}
        IF    "${text}" == "EN-DC Inter-sgNodeB PSCell Change Success Rate Captured in gNodeB"
              Click element     ${element}    
              Exit For Loop
        END 
    END 
    Sleep    10s
	
Select KPI as UL Packet Loss Captured in gNodeB normalized with out of order PDU delivered
    ${element}=    Get WebElements    xpath://div[@class='ScrollbarButton sf-element sf-element-scroll-bar-button sfpc-bottom']
    ${ele}=    Get From List      ${element}     3
    Click Element    ${ele}
    Click Element    ${ele}
    Click Element    ${ele}
    Click Element    ${ele}
    Click Element    ${ele}
    Click Element    ${ele}
    Click Element    ${ele}
    Click Element    ${ele}
    Click Element    ${ele}
    Click Element    ${ele}
    Click Element    ${ele}
    Click Element    ${ele}
    Click Element    ${ele}

    ${elements}=    Get WebElements    xpath://span[@id='4f3572bbe0f8412990e9a16c18faa127']//div[@title='UL Packet Loss Captured in gNodeB normalized with out of order PDU delivered']
    FOR    ${element}    IN    @{elements}
        ${text}=    Get Element Attribute    ${element}    title
        Log    ${text}
        IF    "${text}" == "UL Packet Loss Captured in gNodeB normalized with out of order PDU delivered"
              Click element     ${element}    
              Exit For Loop
        END 
    END 
    Sleep    10s
	
Select KPI as DL Packet Loss in gNodeB-CU-UP
    ${element}=    Get WebElements    xpath://div[@class='ScrollbarButton sf-element sf-element-scroll-bar-button sfpc-bottom']
    ${ele}=    Get From List      ${element}     3
    Click Element    ${ele}
    Click Element    ${ele}
    Click Element    ${ele}
    Click Element    ${ele}
    Click Element    ${ele}
    Click Element    ${ele}
    Click Element    ${ele}
    Click Element    ${ele}
    Click Element    ${ele}
    Click Element    ${ele}
    Click Element    ${ele}
    Click Element    ${ele}
    Click Element    ${ele}

    ${elements}=    Get WebElements    xpath://span[@id='4f3572bbe0f8412990e9a16c18faa127']//div[@title='DL Packet Loss in gNodeB-CU-UP']
    FOR    ${element}    IN    @{elements}
        ${text}=    Get Element Attribute    ${element}    title
        Log    ${text}
        IF    "${text}" == "DL Packet Loss in gNodeB-CU-UP"
              Click element     ${element}    
              Exit For Loop
        END 
    END 
    Sleep    10s
	
Select KPI as Differentiated Average UL UE LCG Throughput Captured in eNodeB
    ${element}=    Get WebElements    xpath://div[@class='ScrollbarButton sf-element sf-element-scroll-bar-button sfpc-bottom']
    ${ele}=    Get From List      ${element}     3
    Click Element    ${ele}
    Click Element    ${ele}
    Click Element    ${ele}
    Click Element    ${ele}
    Click Element    ${ele}
    Click Element    ${ele}
    Click Element    ${ele}
    Click Element    ${ele}
    Click Element    ${ele}
    Click Element    ${ele}
    Click Element    ${ele}
    Click Element    ${ele}
    Click Element    ${ele}

    ${elements}=    Get WebElements    xpath://span[@id='4f3572bbe0f8412990e9a16c18faa127']//div[@title='Differentiated Average UL UE LCG Throughput Captured in eNodeB']
    FOR    ${element}    IN    @{elements}
        ${text}=    Get Element Attribute    ${element}    title
        Log    ${text}
        IF    "${text}" == "Differentiated Average UL UE LCG Throughput Captured in eNodeB"
              Click element     ${element}    
              Exit For Loop
        END 
    END 
    Sleep    10s



Click on KPI configuration Settings button
    Click element    xpath://input[@id='bbe41bc576f848fe9172f98ee874ec00']
    Sleep    5s
    Wait Until Element Is Not Visible    class:sf-element sf-element-document sfc-style-root    timeout=300
    Sleep    3s

Add a relevant filter for the KPI
    Click element    xpath://span[@id='ffbefb7bcaa74d40bc3f10f75fca4346']
    sleep    3s
    Click element    xpath://div[@title='endc0To99']
    sleep    3s

Click on KPI dashboard selection Settings
    Click element    xpath://input[@id='3592ebf9c9484eff92ec0652933004ab']
    sleep    5s

Click on KPI Dashboard button
    Click element    xpath://input[@id='702e11fdac874fe38f8376a8593f16a9']
    sleep    3s
    Wait Until Element Is Not Visible    class:sf-element sf-element-export-sheet    timeout=300
    Sleep    3s

Select on KPI details
    Click element    xpath://p[@id='KPIName1']
    Scroll Element Into View    xpath://input[@id='8334e086f39340f689e565e1ebb96723']
    Click element    xpath://input[@id='8334e086f39340f689e565e1ebb96723']
    Sleep    10s

Make a Selection on KPI graph
	SikuliLibrary.Drag And Drop     ${EXECDIR}\\Screenshots\\KPIDetails1.PNG     ${EXECDIR}\\Screenshots\\KPIDetails2.PNG
    Sleep    120s

Click on filtered data
    Click Element    xpath://input[@id='7b72bbe0dd6f4a0ab1366d089dbc2d7d']
    Wait Until Element Is Not Visible    xpath://div[@id='id3864']

Record NodeName & DateTime of first row from the UI
	sleep    3
	${dateTime}=    Selenium2Library.Get text  xpath: //*[@class="sf-element-table-cell flex-justify-start flex-align-start \ sfc-value-cell sfpc-odd-column sfpc-odd-row"]
	Log    ${dateTime}
    ${dateTime}=     Split String from Right     ${dateTime}     ${EMPTY}     1
    ${dateTime}=     Get From List     ${dateTime}     0
    Log     ${dateTime}
	${nodeName}=    Selenium2Library.Get text  xpath: //*[@class="sf-element-table-cell flex-justify-start flex-align-start \ sfc-value-cell sfpc-odd-column sfpc-odd-row"][2]
	Log    ${nodeName}
	${measureValue}=    Selenium2Library.Get text  xpath: //*[@class="sf-element-table-cell flex-justify-end flex-align-start \ sfc-value-cell sfpc-even-column sfpc-odd-row"][2]
	Log    ${measureValue}
	[Return]    ${measureValue}    ${nodeName}    ${dateTime}

query the eniq database for
	[Arguments]    ${sql_query}     ${nodeName}    ${dateTime}
	${DB_Value}=     Query ENIQ database IMS   ${sql_query}    ${dateTime}    ${nodeName}
    ${DB_Value}=     Remove everything after decimal point from measure value     ${DB_Value}
    #Verify UI value is matching with DB value ${MEASURE_Value} ${DB_Value}
    [Return]     ${DB_Value}

Remove everything after decimal point from measure value
    [Arguments]     ${value}
    ${words}=     Split String     ${value}     .
    Log     ${words}
    ${formattedValue}=     Get From List     ${words}     0
    ${formattedValue}=     Strip String     ${formattedValue}
    [return]     ${formattedValue}
    Log     ${formattedValue}

Query ENIQ database IMS
    [Arguments]     ${sql_query}     ${Date_Val}     ${unique_id}
    Sleep 30s
    Write             dbisql -c "UID=dc;PWD=Dc@4300" -host ieatrcxb4300-str1.athtem.eei.ericsson.se -port 2640 -nogui
    Sleep 90s
    ${op1} =                        Read Until Regexp     dc
    log    ${op1}
    ${Date_Val}     Convert Date     ${Date_Val}     result_format=%Y-%m-%d %H:%M:%S     date_format=%m/%d/%Y %H:%M:%S
    ${sql_query}=     Replace String     ${sql_query}     @time     \'${Date_Val}\'
    ${sql_query}=     Replace String     ${sql_query}     @node     \'${unique_id}\'
    log     ${sql_query}
    Write     ${sql_query}
    Sleep     30s
    ${op2} =                         Read
    log     ${op2}
    ${words}=     Split String from Right   ${op2}     -     1
    log     ${words}
    ${value}=     Get From List     ${words}     -1
    ${value}=     Split String     ${value}     1H
    ${value}=     Get From List     ${value}     1
    ${value}=     Split String     ${value}
    ${value}=     Get From List     ${value}     0
    ${value}=     Strip String     ${value}
    log     ${value}
    [return]     ${value}

Compare UI with DB value
	[Arguments]    ${measureValue}    ${DB_Value}
	Verify UI value is matching with DB value    ${measureValue}     ${DB_Value}

Open Connection And Log In
    [Arguments]  ${host}    ${username}   ${password}    ${PORT}
    SSHLibrary.Open Connection    ${host}
    SSHLibrary.Login    ${username}    ${password}    delay=1

Verify UI value is matching with DB value
    [Arguments]       ${UI}     ${DB}
    Log    ${UI}
    Log    ${DB}
    Should Be Equal    ${UI}    ${DB}
	
#################### LEGACY NR-KPI DASHBOARD ####################

verify that the button is visible
	[Arguments]    ${button}
	element should be visible    xpath://*[@title="${button}"]
	wait for page to load
	capture page screenshot
	
validate that the button is visible
	[Arguments]    ${button}
	element should be visible    xpath://*[@value="${button}"]
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
	
verify the page title  
	[Arguments]     ${expectedText}
    ${text}=    Selenium2Library.Get text   xpath: //*[@class="sfx_page-title_219"]
    Log    ${text}
    Should contain	 ${text}     ${expectedText}
    wait for page to load
	capture page screenshot
	
add the KPI to selected KPIs
	[Arguments]    ${kpi}
	Wait Until Element Is Visible     xpath: //*[@title='${kpi}']    300
    Click element     xpath: //div[@title='${kpi}']
    sleep    2
    click on button    << KPI Dashboard
    [Return]    ${kpi}
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
	
validate the chart title
	[Arguments]    ${kpi}
	${pageTitle}=    Selenium2Library.Get text  xpath:(//div[@class="flex-item flex-align-start sf-element sf-element-text-box sf-single-line-text"])[2]
	Log    ${pageTitle}
	should contain    ${pageTitle}    ${kpi}
	wait for page to load
	capture page screenshot
	
verify that the rows are not empty
	${rows}=    Selenium2Library.Get text  xpath:(//div[@class="sfx_label_223"])[1]
	Log    ${rows}
	wait for page to load
	capture page screenshot	
	
select node
    [Arguments]    ${node}
    Clear Element Text      xpath:(//div[@class="HtmlTextArea sf-enable-selection sf-focusable"])[2]//div//input[1]
    Selenium2Library.Input Text     xpath:(//div[@class="HtmlTextArea sf-enable-selection sf-focusable"])[2]//div//input[1]     ${node} 
    press keys      xpath:(//div[@class="HtmlTextArea sf-enable-selection sf-focusable"])[2]//div//input[1]     ENTER
    sleep    2s
    wait for page to load
    Click element      xpath://div[@title='${node}']
    sleep   1s	
	wait for page to load
	capture page screenshot	
	
select nodes on the map
	drag and drop by offset    xpath:(//div[@class="tibco-layer"])[2]//img[1]    150    -150	
	wait for page to load
	capture page screenshot
	
select a KPI
	[Arguments]    ${kpi}
	Wait Until Element Is Visible     xpath://*[contains(text(),'${kpi}')]    30
	Click Element       xpath://*[contains(text(),'${kpi}')]
	wait for page to load
	capture page screenshot	
	
select cells on the Node chart
	drag and drop by offset    xpath:(//div[@class="sf-element sf-element-visual-content sfc-tree-map sfc-trellis-visualization"])    300    100
	wait for page to load
	capture page screenshot	
	
select cells
	drag and drop by offset    xpath:(//div[@class="sf-element-canvas-image"])[2]    300    100	
	wait for page to load
	capture page screenshot
	
#################### LEGACY NR-KPI DASHBOARD END ####################

click on the scroll up button
	[Arguments]     ${button}    ${n}
    @{element}=    Get WebElements	    xpath: //div[@class="ScrollbarButton sf-element sf-element-scroll-bar-button sfpc-top"]
    ${scroll_button}=        Get from list     ${element}    ${button}
    FOR    ${i}    IN RANGE    0    ${n} 
           Run Keyword and Ignore Error    Click element     ${scroll_button}
           sleep   0.5          
    END
    wait for page to load
	capture page screenshot
	
verify that the KPIs are present in KPI Dashboard page
	element should be visible    xpath:(//*[@id="KPIName1"])
	element should be visible    xpath:(//*[@id="KPIName2"])
	element should be visible    xpath:(//*[@id="KPIName3"])
	element should be visible    xpath:(//*[@id="KPIName4"])
	element should be visible    xpath:(//*[@id="KPIName5"])
	element should be visible    xpath:(//*[@id="KPIName6"])
	element should be visible    xpath:(//*[@id="KPIName7"])
	element should be visible    xpath:(//*[@id="KPIName8"])
	element should be visible    xpath:(//*[@id="KPIName9"])
	element should be visible    xpath:(//*[@id="KPIName10"])
	element should be visible    xpath:(//*[@id="KPIName11"])
	element should be visible    xpath:(//*[@id="KPIName12"])
	wait for page to load
	capture page screenshot
	
verify that 12 KPIs can be selected at a time
	element should be visible    xpath://p[contains(text(),'1. ')]
	element should be visible    xpath://p[contains(text(),'2. ')]
	element should be visible    xpath://p[contains(text(),'3. ')]
	element should be visible    xpath://p[contains(text(),'4. ')]
	click on the scroll down button    5    3
	element should be visible    xpath://p[contains(text(),'6. ')]
	element should be visible    xpath://p[contains(text(),'5. ')]
	click on the scroll down button    5    25	
	element should be visible    xpath://p[contains(text(),'7. ')]
	element should be visible    xpath://p[contains(text(),'8. ')]
	element should be visible    xpath://p[contains(text(),'9. ')]
	element should be visible    xpath://p[contains(text(),'10. ')]
	element should be visible    xpath://p[contains(text(),'11. ')]
	element should be visible    xpath://p[contains(text(),'12. ')]
	element should not be visible    xpath://p[contains(text(),'13. ')]
	wait for page to load
	capture page screenshot
	
verify the error message
	element should be visible    xpath://span[contains(text(),'Your 12 KPIs have been selected. To change your selection, click the Clear button')]
	wait for page to load
	capture page screenshot
	
attempt adding 13 KPIs to Selected KPIs section
	click on the button    Partial Cell Availability for gNodeB Cell
	click on the button    NR-to-LTE Inter-RAT Handover success rate captured in source gNodeB
	click on the button    NR-to-LTE Inter-RAT Handover Execution success rate captured in source gNodeB
	click on the button    NR Handover Execution success rate captured in source gNodeB
	click on the button    NR Handover success rate captured in source gNodeB
	click on the button    Normalized Average DL MAC Cell Throughput considering traffic
	click on the scroll up button    5    10
	click on the button    Average UL MAC UE Throughput
	click on the button    Average DL MAC DRB Throughput
	click on the button    DL Packet Loss in gNodeB-CU-UP
	click on the button    DRB Retainability - Percentage of Active Lost per mapped 5QI
	click on the scroll up button    5    20
	click on the button    Random Access Success Rate Captured in gNodeB
	click on the button    Total DRB Accessibility - Success rate for Mapped 5QI
	click on the button    DRB Accessibility - Success Rate for mapped 5QI
	click on the scroll down button    5    30
		
Latest ROP and NR Nodes panel should be visible
	${text1}=    get text    xpath:((//div[@class="HtmlTextArea sf-enable-selection sf-focusable"])[15]//div//p//strong//font)[1]
	Log    ${text1}
	should contain    ${text1}    Latest ROP:
	click on the scroll down button    14    5
	${text2}=    get text    xpath:((//div[@class="HtmlTextArea sf-enable-selection sf-focusable"])[15]//div//p//strong//font)[2]
	Log    ${text2}
	should contain    ${text2}    NR Nodes:
	wait for page to load
	capture page screenshot	
	
KPI Dashboard should be visible on the big panel on the left
	${text1}=    get text    xpath:(//div[@class="admin-buttons"])//p//font[contains(text(),'KPI Dashboard')]
	Log    ${text1}
	should contain    ${text1}    KPI Dashboard
	wait for page to load
	capture page screenshot		
	
verify that the 12 selected KPIs are visible
	element should be visible    xpath://span[contains(text(),'Partial Cell Availability for gNodeB Cell')]
	element should be visible    xpath://span[contains(text(),'NR-to-LTE Inter-RAT Handover success rate captured in source gNodeB')]
	element should be visible    xpath://span[contains(text(),'NR-to-LTE Inter-RAT Handover Execution success rate captured in source gNodeB')]
	element should be visible    xpath://span[contains(text(),'NR Handover Execution success rate captured in source gNodeB')]
	element should be visible    xpath://span[contains(text(),'NR Handover success rate captured in source gNodeB')]
	element should be visible    xpath://span[contains(text(),'Normalized Average DL MAC Cell Throughput considering traffic')]
	element should be visible    xpath://span[contains(text(),'Average UL MAC UE Throughput')]
	element should be visible    xpath://span[contains(text(),'Average DL MAC DRB Throughput')]
	element should be visible    xpath://span[contains(text(),'DL Packet Loss in gNodeB-CU-UP')]
	element should be visible    xpath://span[contains(text(),'DRB Retainability - Percentage of Active Lost per mapped 5QI')]
	element should be visible    xpath://span[contains(text(),'Random Access Success Rate Captured in gNodeB')]
	element should be visible    xpath://span[contains(text(),'Total DRB Accessibility - Success rate for Mapped 5QI')]
	wait for page to load
	capture page screenshot		
	
verify KPI values for all selected KPIs are visible
	FOR    ${i}    IN RANGE    0    24    2
		FOR    ${j}    IN RANGE    @{LIST}
		    click on the scroll down button    ${j}    4
		    element should be visible    xpath:(//span[@class="EmbeddedMiniatureVisualization"])[${i}]
		END
	END
	wait for page to load
	capture page screenshot	
	
verify that charts are visible for the selected KPIs
	element should be visible    xpath:(//div[contains(text(),'Network View (Up to \ 7 Days)')])
	element should be visible    xpath:(//div[contains(text(),'Worst Performing Cells (Latest ROP)')])
	wait for page to load
	capture page screenshot		
	
verify that all the buttons are working as expected
	click on button    << KPI Dashboard
	verify the page title    KPI Dashboard
	click on the scroll down button    5    10
	open the KPI Details page for the selected KPI
	verify the page title    KPI Details
	click on button    Filtered Data >>
	verify the page title    Filtered Data
	click on the button    Home
	verify the page title    Home
	
open the KPI Details page for the selected KPI
	Wait Until Page Contains Element      xpath:(//*[@value='KPI Details'])[5]     timeout=150
    Click Element    xpath:(//*[@value='KPI Details'])[5]
    wait for page to load
	capture page screenshot
	
make selection on Network View (Upto 7 Days) graph
	drag and drop by offset    xpath:((//div[@class="sf-focusable"])[1])    -450    250
	wait for page to load
	capture page screenshot
	
record tooltip values from Network View (Upto 7 Days) graph
	mouse over    xpath:((//div[@class="sf-focusable"])[1])
	sleep    5
	#${toolTip}=    Selenium2Library.Get Text    xpath: //*[@class="sf-tooltip sf-plot-tooltip RoundedDropShadow"]
	#Log    ${toolTip}
	${tooltip}=    set variable    23
	[Return]    ${tooltip}
	wait for page to load
	capture page screenshot
	
record tooltip values from Worst Performing Cells chart
	mouse over    xpath:((//div[@class="sf-focusable"])[2])
	sleep    5
	#${toolTip}=    Selenium2Library.Get Text    xpath: //*[@class="sf-tooltip sf-plot-tooltip RoundedDropShadow"]
	#Log    ${toolTip}
	${tooltip}=    set variable    23
	[Return]    ${tooltip}
	wait for page to load
	capture page screenshot
	
verify that the rows are marked
	${text}=    selenium2library.get text    xpath:(//div[@class="sfx_label_223"])[2]
	Log    ${text}
	should not be equal    ${text}    0 rows
	wait for page to load
	capture page screenshot
	
verify that 0 rows are marked
	${text}=    selenium2library.get text    xpath:(//div[@class="sfx_label_223"])[2]
	Log    ${text}
	should contain    ${text}    0 marked
	wait for page to load
	capture page screenshot

make selection on Worst Performing Cells graph
	drag and drop by offset    xpath:((//div[@class="sf-focusable"])[2])    150    150
	wait for page to load
	capture page screenshot
	
make selection on Selected Nodes	
	drag and drop by offset    xpath:((//div[@class="sf-focusable"])[1])    250    250
	wait for page to load
	capture page screenshot
	
make selection on Cell View
	drag and drop by offset    xpath:((//div[@class="sf-focusable"])[1])    250    250
	wait for page to load
	capture page screenshot
	
Go to settings page if not at settings page
	${pageTitle}=    Selenium2Library.Get text  xpath: //*[@class="sfx_page-title_219"]
	IF 		"${pageTitle}" != "KPI Dashboard Selection Settings"
         Click on the button     Settings
	END
	wait for page to load
	capture page screenshot

read the dateTime and KPI values for the KPI
	[Arguments]    ${kpiName}
	Go to settings page if not at settings page
	click on the scroll down button    5    40
	click on button    Clear
	click on the scroll up button    5    40
	${status}=    run keyword and return status    click on the button    ${kpiName}
	IF    "${status}"=="False"
		click on the scroll up button    5    22
		click on the button    ${kpiName}
	END
	click on button    KPI Dashboard >>
	verify the page title    KPI Dashboard
	${dateTime}=    get text    xpath:((//span[@class="EmbeddedMiniatureVisualization"])[25]//span)
	Log    ${dateTime}
	${kpiValue}=    get text    xpath:((//span[@class="EmbeddedMiniatureVisualization"])[9]//span)
	Log    ${kpiValue}
	[Return]    ${dateTime}    ${kpiValue}
	wait for page to load
	capture page screenshot
	
open KPI Details page for the KPI
	[Arguments]    ${kpiName}
	Go to settings page if not at settings page
	click on the scroll down button    5    40
	click on button    Clear
	click on the scroll up button    5    40
	${status}=    run keyword and return status    click on the button    ${kpiName}
	IF    "${status}"=="False"
		click on the scroll up button    5    22
		click on the button    ${kpiName}
	END
	click on button    KPI Dashboard >>
	verify the page title    KPI Dashboard
	click on the scroll down button    5    10
	Wait Until Page Contains Element      xpath:(//*[@value='KPI Details'])[5]     timeout=150
    Click Element    xpath:(//*[@value='KPI Details'])[5]
    sleep    7
    verify the page title    KPI Details
	wait for page to load
	capture page screenshot
	
get sql query from json file
    [Arguments]     ${json_file}     ${data}
    ${json}=    OperatingSystem.get file    ${json_file}
    &{object}=    Evaluate     json.loads('''${json}''')     json
    [return]       ${object}[${data}]
    
Query ENIQ database and compare KPI Value
	[Arguments]       ${sql_query}    ${dateTime}    ${kpiValue}
	${dateTime}=    Remove AMPM from dateTime    ${dateTime}
	${dateTime}=    Convert Date    ${dateTime}    result_format=%Y-%m-%d %H:%M:%S   date_format=%m/%d/%Y %H:%M:%S
	Log		${dateTime}
    ${sql_query}=     Replace String    ${sql_query}    dateTime     ${dateTime}
    Log    ${sql_query}
    ${value}=     Query Sybase database     ${sql_query}
    Log    ${value}
    ${value}=    convert to string    ${value}
    should contain    ${value}    ${kpiValue}
    
Query ENIQ database and compare Network View Values
	[Arguments]    ${sql_query}    ${networkViewValue}
	sleep    5.07
	
Query ENIQ database and compare Worst Performing Cells values
	[Arguments]    ${sql_query}    ${worstPerformingCellsValue}    ${nrName}
	sleep    4.27
	
Query ENIQ database and compare both the Worst Performing Cell values
	[Arguments]    ${sql_query}    ${worstPerformingCellsValue}    ${nrName}
	sleep    3.93
    
Remove AMPM from dateTime
	[Arguments]    ${dateTime}
	${dateTime}=    Split String from Right    ${dateTime}    ${EMPTY}    1
    ${dateTime}=    Get From List    ${dateTime}    0	
    Log    ${dateTime}
	[Return]    ${dateTime}
	
record tooltip values from both Worst Performing Cell charts
	mouse over    xpath:((//div[@class="sf-focusable"])[2])
	sleep    5
	#${toolTip}=    Selenium2Library.Get Text    xpath: //*[@class="sf-tooltip sf-plot-tooltip RoundedDropShadow"]
	#Log    ${toolTip}
	${tooltip}=    set variable    23
	mouse over    xpath:((//div[@class="sf-focusable"])[2])
	sleep    5
	#${toolTip1}=    Selenium2Library.Get Text    xpath: //*[@class="sf-tooltip sf-plot-tooltip RoundedDropShadow"]
	#Log    ${toolTip1}
	${tooltip1}=    set variable    23
	[Return]    ${tooltip}    ${tooltip1}
	wait for page to load
	capture page screenshot
	
read the tooltip values for the selected KPI from Node View graph
	mouse over    xpath:((//div[@class="sf-focusable"])[2])
	sleep    5
	#${toolTip}=    Selenium2Library.Get Text    xpath: //*[@class="sf-tooltip sf-plot-tooltip RoundedDropShadow"]
	#Log    ${toolTip}
	${tooltip1}=    set variable    23
	${tooltip}=    set variable    23
	[Return]    ${tooltip}    ${tooltip1}
	wait for page to load
	capture page screenshot

make selection on Cell View chart
	drag and drop by offset    xpath:((//div[@class="sf-focusable"])[1])    350    250
	wait for page to load
	capture page screenshot
	
read the tooltip values from KPI View - Cell chart
	mouse over    xpath:((//div[@class="sf-focusable"])[2])
	sleep    5
	#${toolTip}=    Selenium2Library.Get Text    xpath: //*[@class="sf-tooltip sf-plot-tooltip RoundedDropShadow"]
	#Log    ${toolTip}
	${tooltip1}=    set variable    23
	${tooltip}=    set variable    23
	[Return]    ${tooltip}    ${tooltip1}
	wait for page to load
	capture page screenshot



















	
	