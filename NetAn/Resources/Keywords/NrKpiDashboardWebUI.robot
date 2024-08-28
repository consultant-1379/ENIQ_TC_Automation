*** Keywords ***
suite setup for webui
	#Set Environment Variable  webdriver.chrome.driver    ${CURDIR}/../../drivers/chromedriver.exe
	Set Environment Variable  webdriver.chrome.driver    ./drivers/chromedriver.exe
	Set Screenshot Directory   ./Screenshots
	
################# nr-kpi-dashboard ##################

open nr kpi dashboard page
    ${chrome_options}=    Evaluate    sys.modules['selenium.webdriver'].ChromeOptions()      sys
	Call Method    ${chrome_options}    add_argument    --ignore-certificate-errors
	Create Webdriver    Chrome    executable_path=${EXEC_DIR}/ENIQ_TC_Automation/NetAn/Resources/Drivers/chromedriver_108.exe      chrome_options=${chrome_options}
    Go To    ${base_url}
    Maximize Browser Window
    Sleep    5
    Selenium2Library.Input Text    name:username    Administrator
    Selenium2Library.Input Text    name:password    Ericsson01
    Click Element    class:LoginButton
    Sleep    5
    Go To    ${base_url}${nrNsa_url}
	sleep    40
    ${IsElementVisible}=    Run Keyword And Return Status    Element Should not be Visible    xpath://div[contains(text(),'Missing Data')]
	Run Keyword If    ${IsElementVisible} is ${FALSE}   Close missing data window
	sleep    30
    wait for page to load
	
Close missing data window
	Wait Until Page Contains Element      xpath://span[contains(text(),'Apply to all inaccessible data tables in this analysis')]     timeout=150
    Click Element    xpath://span[contains(text(),'Apply to all inaccessible data tables in this analysis')]
    sleep    5
    Wait Until Page Contains Element      xpath://button[contains(text(),'OK')]     timeout=150
    Click Element    xpath://button[contains(text(),'OK')]
    
wait for page to load
    Sleep   5s
    Wait Until Element Is Not Visible     xpath://div[@class='sfx_root_191 sfx_webcontrol-root-document-loaded_193']        timeout=2400
    Sleep   3s
    Wait Until Element Is Not Visible     xpath://div[@class='sfx_root_191 sfx_webcontrol-root-document-loaded_193']        timeout=2400
    Sleep   40s

verify that the button is visible
	[Arguments]    ${button}
	element should be visible    xpath://*[@value="${button}"]
	capture page screenshot

verify that the image is visible
	[Arguments]    ${image}
	element should be visible    xpath://*[@title="${image}"]
	capture page screenshot

scroll down into view
	Click Element		xpath://div[@class='ScrollbarButton sf-element sf-element-scroll-bar-button sfpc-bottom']
	Click Element		xpath://div[@class='ScrollbarButton sf-element sf-element-scroll-bar-button sfpc-bottom']
	Click Element		xpath://div[@class='ScrollbarButton sf-element sf-element-scroll-bar-button sfpc-bottom']
	Click Element		xpath://div[@class='ScrollbarButton sf-element sf-element-scroll-bar-button sfpc-bottom']
	Click Element		xpath://div[@class='ScrollbarButton sf-element sf-element-scroll-bar-button sfpc-bottom']
	
click on the image
	[Arguments]    ${image}
	Click Image	   xpath://*[@title="${image}"]
	sleep	10s
	capture page screenshot

click on clear button
	FOR    ${i}    IN RANGE    0    23 
           Click element     xpath://html/body/div/div[2]/div/div[1]/div/div/div[2]/div/div/div/div/div/div/div/div/div[2]/div/div/div[2]/div[2]           
    END
    Click Element		xpath://*[@value="Clear"]
    
select KPIs
    Scroll Element Into View    xpath://*[@id='4f3572bbe0f8412990e9a16c18faa127']
    ${element}=    Get WebElements    xpath://div[@class='sf-element-list-box sfc-scrollable']
    ${ele}=    Get From List      ${element}     4
    Log		${ele}
#    FOR    ${element}    IN    @{elements}
#        ${text}=    Get Element Attribute    ${element}    title
#        Log    ${text}
	Sleep	3s


Select KPI as Differentiated Initial E-RAB Establishment Success Rate captured in eNodeB
    Scroll Element Into View    xpath://*[@class='sf-element-list-box-item sfpc-selected']
    Sleep    5s
    ${text}=    Get Text    xpath://*[@id="cb69ff1de8914f9a9e8aaeba3b54db89"]/div/div/div/div[1]/div/div/div[1]
    FOR    ${i}    IN RANGE    0    5 
           Click Element     xpath://*[@id="cb69ff1de8914f9a9e8aaeba3b54db89"]/div/div/div/div[1]/div/div/div[1]           
    END
    Wait Until Element Contains		xpath://*[@id="cb69ff1de8914f9a9e8aaeba3b54db89"]/div/div/div/div[1]/div/div/div[1]		Differentiated Initial E-RAB Establishment Success Rate captured in eNodeB

Select KPI as Differentiated Initial E-RAB Establishment Success Rate, no MO signaling captured in eNodeB
    Scroll Element Into View    xpath://*[@id="cb69ff1de8914f9a9e8aaeba3b54db89"]/div/div/div/div[1]/div/div/div[2]
    Sleep    5s
    ${text}=    Selenium2Library.Get Text    xpath://*[@id="cb69ff1de8914f9a9e8aaeba3b54db89"]/div/div/div/div[1]/div/div/div[2]
    FOR    ${i}    IN RANGE    0    5 
           Click Element     xpath://*[@id="cb69ff1de8914f9a9e8aaeba3b54db89"]/div/div/div/div[1]/div/div/div[2]        
    END
    Wait Until Element Contains		xpath://*[@id="cb69ff1de8914f9a9e8aaeba3b54db89"]/div/div/div/div[1]/div/div/div[2]		Differentiated Initial E-RAB Establishment Success Rate, no MO signaling captured in eNodeB

Select KPI as Verifying Random Access Success Rate Captured in gNodeB
    Scroll Element Into View    xpath://*[@id="cb69ff1de8914f9a9e8aaeba3b54db89"]/div/div/div/div[1]/div/div/div[4]
    Sleep    5s
    ${text}=    Selenium2Library.Get Text    xpath://*[@id="cb69ff1de8914f9a9e8aaeba3b54db89"]/div/div/div/div[1]/div/div/div[4]
    FOR    ${i}    IN RANGE    0    5 
           Click Element     xpath://*[@id="cb69ff1de8914f9a9e8aaeba3b54db89"]/div/div/div/div[1]/div/div/div[4]        
    END
    Wait Until Element Contains		xpath://*[@id="cb69ff1de8914f9a9e8aaeba3b54db89"]/div/div/div/div[1]/div/div/div[4]		Random Access Success Rate captured in gNodeB

Select KPI as EN-DC Setup Success Rate captured in eNodeB
    Scroll Element Into View    xpath://*[@id="cb69ff1de8914f9a9e8aaeba3b54db89"]/div/div/div/div[1]/div/div/div[5]
    Sleep    5s
    ${text}=    Selenium2Library.Get Text    xpath://*[@id="cb69ff1de8914f9a9e8aaeba3b54db89"]/div/div/div/div[1]/div/div/div[5]
    FOR    ${i}    IN RANGE    0    5 
           Click Element     xpath://*[@id="cb69ff1de8914f9a9e8aaeba3b54db89"]/div/div/div/div[1]/div/div/div[5]        
    END
    Wait Until Element Contains		xpath://*[@id="cb69ff1de8914f9a9e8aaeba3b54db89"]/div/div/div/div[1]/div/div/div[5]		EN-DC Setup Success Rate captured in eNodeB

Select KPI as EN-DC Setup Success Rate captured in gNodeB					
    Scroll Element Into View    xpath://*[@id="cb69ff1de8914f9a9e8aaeba3b54db89"]//*[@title='EN-DC Setup Success Rate captured in gNodeB']
    Sleep    5s
    ${text}=    Selenium2Library.Get Text    xpath://*[@id="cb69ff1de8914f9a9e8aaeba3b54db89"]//*[@title='EN-DC Setup Success Rate captured in gNodeB']
    FOR    ${i}    IN RANGE    0    5 
           Click Element     xpath://*[@id="cb69ff1de8914f9a9e8aaeba3b54db89"]//*[@title='EN-DC Setup Success Rate captured in gNodeB']        
    END
    Wait Until Element Contains		xpath://*[@id="cb69ff1de8914f9a9e8aaeba3b54db89"]//*[@title='EN-DC Setup Success Rate captured in gNodeB']		EN-DC Setup Success Rate captured in gNodeB

Select KPI as Differentiated E-RAB Retainability - Percentage Lost Captured in eNodeB
    Scroll Element Into View    xpath://*[@id="2fe9c291f1ba49e6a2219d24d84daa10"]/div/div/div/div[1]/div/div/div[1]
    Sleep    5s
    ${text}=    Selenium2Library.Get Text    xpath://*[@id="2fe9c291f1ba49e6a2219d24d84daa10"]/div/div/div/div[1]/div/div/div[1]
    FOR    ${i}    IN RANGE    0    5 
           Click Element     xpath://*[@id="2fe9c291f1ba49e6a2219d24d84daa10"]/div/div/div/div[1]/div/div/div[1]        
    END
    Wait Until Element Contains		xpath://*[@id="2fe9c291f1ba49e6a2219d24d84daa10"]/div/div/div/div[1]/div/div/div[1]		Differentiated E-RAB Retainability - Percentage Lost captured in eNodeB

Select KPI as Differentiated Average DL PDCP UE Throughput Captured in eNode
    Scroll Element Into View    xpath://*[@id="4f3572bbe0f8412990e9a16c18faa127"]/div/div/div/div[1]/div/div/div[1]
    Sleep    5s
    ${text}=    Selenium2Library.Get Text    xpath://*[@id="4f3572bbe0f8412990e9a16c18faa127"]/div/div/div/div[1]/div/div/div[1]
    FOR    ${i}    IN RANGE    0    5 
           Click Element     xpath://*[@id="4f3572bbe0f8412990e9a16c18faa127"]/div/div/div/div[1]/div/div/div[1]        
    END
    Wait Until Element Contains		xpath://*[@id="4f3572bbe0f8412990e9a16c18faa127"]/div/div/div/div[1]/div/div/div[1]		Differentiated Average DL PDCP UE Throughput captured in eNodeB

Select KPI as Differentiated Average CA DL PDCP UE Throughput Captured in eNode
    Scroll Element Into View    xpath://*[@id="4f3572bbe0f8412990e9a16c18faa127"]/div/div/div/div[1]/div/div/div[2]
    Sleep    5s
    ${text}=    Selenium2Library.Get Text    xpath://*[@id="4f3572bbe0f8412990e9a16c18faa127"]/div/div/div/div[1]/div/div/div[2]
    FOR    ${i}    IN RANGE    0    5 
           Click Element     xpath://*[@id="4f3572bbe0f8412990e9a16c18faa127"]/div/div/div/div[1]/div/div/div[2]        
    END
    Wait Until Element Contains		xpath://*[@id="4f3572bbe0f8412990e9a16c18faa127"]/div/div/div/div[1]/div/div/div[2]		Differentiated Average CA DL PDCP UE Throughput captured in eNodeB

Select KPI as Differentiated Average UL PDCP UE Throughput Captured in eNode
    Scroll Element Into View    xpath://*[@id="4f3572bbe0f8412990e9a16c18faa127"]/div/div/div/div[1]/div/div/div[3]
    Sleep    5s
    ${text}=    Selenium2Library.Get Text    xpath://*[@id="4f3572bbe0f8412990e9a16c18faa127"]/div/div/div/div[1]/div/div/div[3]
    FOR    ${i}    IN RANGE    0    5 
           Click Element     xpath://*[@id="4f3572bbe0f8412990e9a16c18faa127"]/div/div/div/div[1]/div/div/div[3]        
    END
    Wait Until Element Contains		xpath://*[@id="4f3572bbe0f8412990e9a16c18faa127"]/div/div/div/div[1]/div/div/div[3]		Differentiated Average UL PDCP UE Throughput captured in eNodeB

Select KPI as Differentiated Average CA UL PDCP UE Throughput Captured in eNode
    Scroll Element Into View    xpath://*[@id="4f3572bbe0f8412990e9a16c18faa127"]/div/div/div/div[1]/div/div/div[4]
    Sleep    5s
    ${text}=    Selenium2Library.Get Text    xpath://*[@id="4f3572bbe0f8412990e9a16c18faa127"]/div/div/div/div[1]/div/div/div[4]
    FOR    ${i}    IN RANGE    0    5 
           Click Element     xpath://*[@id="4f3572bbe0f8412990e9a16c18faa127"]/div/div/div/div[1]/div/div/div[4]        
    END
    Wait Until Element Contains		xpath://*[@id="4f3572bbe0f8412990e9a16c18faa127"]/div/div/div/div[1]/div/div/div[4]		Differentiated Average CA UL PDCP UE Throughput captured in eNodeB

Select KPI as Partial Cell Availability for eNodeB Cell
    Scroll Element Into View    xpath://*[@id="6acff5396495428dad21bc2b21f6fdd8"]/div/div/div/div[1]/div/div/div[1]
    Sleep    5s
    ${text}=    Selenium2Library.Get Text    xpath://*[@id="6acff5396495428dad21bc2b21f6fdd8"]/div/div/div/div[1]/div/div/div[1]
    FOR    ${i}    IN RANGE    0    5 
           Click Element     xpath://*[@id="6acff5396495428dad21bc2b21f6fdd8"]/div/div/div/div[1]/div/div/div[1]        
    END
    Wait Until Element Contains		xpath://*[@id="6acff5396495428dad21bc2b21f6fdd8"]/div/div/div/div[1]/div/div/div[1]		Partial Cell Availability for eNodeB Cell

Select KPI as Partial Cell Availability for gNodeB Cell
    Scroll Element Into View    xpath://*[@id="6acff5396495428dad21bc2b21f6fdd8"]/div/div/div/div[1]/div/div/div[2]
    Sleep    5s
    ${text}=    Selenium2Library.Get Text    xpath://*[@id="6acff5396495428dad21bc2b21f6fdd8"]/div/div/div/div[1]/div/div/div[2]
    FOR    ${i}    IN RANGE    0    5 
           Click Element     xpath://*[@id="6acff5396495428dad21bc2b21f6fdd8"]/div/div/div/div[1]/div/div/div[2]        
    END
    Wait Until Element Contains		xpath://*[@id="6acff5396495428dad21bc2b21f6fdd8"]/div/div/div/div[1]/div/div/div[2]		Partial Cell Availability for gNodeB Cell

Select KPI as Random Access Success Rate captured in eNodeB
    Scroll Element Into View    xpath://*[@id="cb69ff1de8914f9a9e8aaeba3b54db89"]/div/div/div/div[1]/div/div/div[3]
    Sleep    5s
    ${text}=    Selenium2Library.Get Text    xpath://*[@id="cb69ff1de8914f9a9e8aaeba3b54db89"]/div/div/div/div[1]/div/div/div[3]
    FOR    ${i}    IN RANGE    0    5 
           Click Element     xpath://*[@id="cb69ff1de8914f9a9e8aaeba3b54db89"]/div/div/div/div[1]/div/div/div[3]        
    END
    Wait Until Element Contains		xpath://*[@id="cb69ff1de8914f9a9e8aaeba3b54db89"]/div/div/div/div[1]/div/div/div[3]		Random Access Success Rate captured in eNodeB

Select KPI as UL Packet Loss Captured in gNodeB
    Scroll Element Into View    xpath://*[@id="4f3572bbe0f8412990e9a16c18faa127"]/div/div/div/div[1]/div/div/div[5]
    Sleep    5s
    ${text}=    Selenium2Library.Get Text    xpath://*[@id="4f3572bbe0f8412990e9a16c18faa127"]/div/div/div/div[1]/div/div/div[5]
    FOR    ${i}    IN RANGE    0    5 
           Click Element     xpath://*[@id="4f3572bbe0f8412990e9a16c18faa127"]/div/div/div/div[1]/div/div/div[5]        
    END
    Wait Until Element Contains		xpath://*[@id="4f3572bbe0f8412990e9a16c18faa127"]/div/div/div/div[1]/div/div/div[5]		UL Packet Loss Captured in gNodeB

Select KPI as Differentiated Cell Mobility Success Rate in LTE
    Scroll Element Into View    xpath://*[@id="6888246131c24bd98dae4701671c1209"]/div/div/div/div[1]/div/div/div[1]
    Sleep    5s
    ${text}=    Selenium2Library.Get Text    xpath://*[@id="6888246131c24bd98dae4701671c1209"]/div/div/div/div[1]/div/div/div[1]
    FOR    ${i}    IN RANGE    0    5 
           Click Element     xpath://*[@id="6888246131c24bd98dae4701671c1209"]/div/div/div/div[1]/div/div/div[1]        
    END
    Wait Until Element Contains		xpath://*[@id="6888246131c24bd98dae4701671c1209"]/div/div/div/div[1]/div/div/div[1]		Differentiated Cell Mobility Success Rate in LTE

Select KPI as Differentiated Cell Handover Success Rate in LTE
    Scroll Element Into View    xpath://*[@id="6888246131c24bd98dae4701671c1209"]/div/div/div/div[1]/div/div/div[2]
    Sleep    5s
    ${text}=    Selenium2Library.Get Text    xpath://*[@id="6888246131c24bd98dae4701671c1209"]/div/div/div/div[1]/div/div/div[2]
    FOR    ${i}    IN RANGE    0    5 
           Click Element     xpath://*[@id="6888246131c24bd98dae4701671c1209"]/div/div/div/div[1]/div/div/div[2]        
    END
    Wait Until Element Contains		xpath://*[@id="6888246131c24bd98dae4701671c1209"]/div/div/div/div[1]/div/div/div[2]		Differentiated Cell Handover Success Rate in LTE

Select KPI as Differentiated Cell Handover Execution Success Rate in LTE
    Scroll Element Into View    xpath://*[@id="6888246131c24bd98dae4701671c1209"]/div/div/div/div[1]/div/div/div[3]
    Sleep    5s
    ${text}=    Selenium2Library.Get Text    xpath://*[@id="6888246131c24bd98dae4701671c1209"]/div/div/div/div[1]/div/div/div[3]
    FOR    ${i}    IN RANGE    0    5 
           Click Element     xpath://*[@id="6888246131c24bd98dae4701671c1209"]/div/div/div/div[1]/div/div/div[3]        
    END
    Wait Until Element Contains		xpath://*[@id="6888246131c24bd98dae4701671c1209"]/div/div/div/div[1]/div/div/div[3]		Differentiated Cell Handover Execution Success Rate in LTE

Select KPI as SCG Radio Resource Retainability Captured in gNodeB
    Scroll Element Into View    xpath://*[@id="2fe9c291f1ba49e6a2219d24d84daa10"]/div/div/div/div[1]/div/div/div[2]
    Sleep    5s
    ${text}=    Selenium2Library.Get Text    xpath://*[@id="2fe9c291f1ba49e6a2219d24d84daa10"]/div/div/div/div[1]/div/div/div[2]
    FOR    ${i}    IN RANGE    0    5 
           Click Element     xpath://*[@id="2fe9c291f1ba49e6a2219d24d84daa10"]/div/div/div/div[1]/div/div/div[2]        
    END
    Wait Until Element Contains		xpath://*[@id="2fe9c291f1ba49e6a2219d24d84daa10"]/div/div/div/div[1]/div/div/div[2]		SCG Radio Resource Retainability Captured in gNodeB

Select KPI as Average DL MAC Cell Throughput Captured in gNodeB- Fixed Time Normalized
    Scroll Element Into View    xpath://*[@id="4f3572bbe0f8412990e9a16c18faa127"]//*[@title='Average DL MAC Cell Throughput Captured in gNodeB- Fixed Time Normalized']
    Sleep    5s
    ${text}=    Selenium2Library.Get Text    xpath://*[@id="4f3572bbe0f8412990e9a16c18faa127"]//*[@title='Average DL MAC Cell Throughput Captured in gNodeB- Fixed Time Normalized']
    FOR    ${i}    IN RANGE    0    5 
           Click Element     xpath://*[@id="4f3572bbe0f8412990e9a16c18faa127"]//*[@title='Average DL MAC Cell Throughput Captured in gNodeB- Fixed Time Normalized']        
    END
    Wait Until Element Contains		xpath://*[@id="4f3572bbe0f8412990e9a16c18faa127"]//*[@title='Average DL MAC Cell Throughput Captured in gNodeB- Fixed Time Normalized']		Average DL MAC Cell Throughput Captured in gNodeB- Fixed Time Normalized

Select KPI as Normalized Average DL MAC Cell Throughput Captured in gNodeB Considering Traffic
    Scroll Element Into View    xpath://*[@id="4f3572bbe0f8412990e9a16c18faa127"]//*[@title='Normalized Average DL MAC Cell Throughput Captured in gNodeB Considering Traffic']
    Sleep    5s
    ${text}=    Selenium2Library.Get Text    xpath://*[@id="4f3572bbe0f8412990e9a16c18faa127"]//*[@title='Normalized Average DL MAC Cell Throughput Captured in gNodeB Considering Traffic']
    FOR    ${i}    IN RANGE    0    5 
           Click Element     xpath://*[@id="4f3572bbe0f8412990e9a16c18faa127"]//*[@title='Normalized Average DL MAC Cell Throughput Captured in gNodeB Considering Traffic']        
    END
    Wait Until Element Contains		xpath://*[@id="4f3572bbe0f8412990e9a16c18faa127"]//*[@title='Normalized Average DL MAC Cell Throughput Captured in gNodeB Considering Traffic']		Normalized Average DL MAC Cell Throughput Captured in gNodeB Considering Traffic

Select KPI as Normalized DL MAC Cell Throughput Captured in gNodeB Considering Actual PDSCH Slot Only
    Scroll Element Into View    xpath://*[@id="4f3572bbe0f8412990e9a16c18faa127"]//*[@title='Normalized DL MAC Cell Throughput Captured in gNodeB Considering Actual PDSCH Slot Only']
    Sleep    5s
    ${text}=    Selenium2Library.Get Text    xpath://*[@id="4f3572bbe0f8412990e9a16c18faa127"]//*[@title='Normalized DL MAC Cell Throughput Captured in gNodeB Considering Actual PDSCH Slot Only']
    FOR    ${i}    IN RANGE    0    5 
           Click Element     xpath://*[@id="4f3572bbe0f8412990e9a16c18faa127"]//*[@title='Normalized DL MAC Cell Throughput Captured in gNodeB Considering Actual PDSCH Slot Only']        
    END
    Wait Until Element Contains		xpath://*[@id="4f3572bbe0f8412990e9a16c18faa127"]//*[@title='Normalized DL MAC Cell Throughput Captured in gNodeB Considering Actual PDSCH Slot Only']		Normalized DL MAC Cell Throughput Captured in gNodeB Considering Actual PDSCH Slot Only

Select KPI as Average DL MAC DRB Throughput Captured in gNodeB
    Scroll Element Into View    xpath://*[@id="4f3572bbe0f8412990e9a16c18faa127"]//*[@title='Average DL MAC DRB Throughput Captured in gNodeB']
    Sleep    5s
    ${text}=    Selenium2Library.Get Text    xpath://*[@id="4f3572bbe0f8412990e9a16c18faa127"]//*[@title='Average DL MAC DRB Throughput Captured in gNodeB']
    FOR    ${i}    IN RANGE    0    5 
           Click Element     xpath://*[@id="4f3572bbe0f8412990e9a16c18faa127"]//*[@title='Average DL MAC DRB Throughput Captured in gNodeB']        
    END
    Wait Until Element Contains		xpath://*[@id="4f3572bbe0f8412990e9a16c18faa127"]//*[@title='Average DL MAC DRB Throughput Captured in gNodeB']		Average DL MAC DRB Throughput Captured in gNodeB

Select KPI as DL MAC DRB Throughput per QoS Captured in gNodeB
    Scroll Element Into View    xpath://*[@id="4f3572bbe0f8412990e9a16c18faa127"]//*[@title='DL MAC DRB Throughput per QoS Captured in gNodeB']
    Sleep    5s
    ${text}=    Selenium2Library.Get Text    xpath://*[@id="4f3572bbe0f8412990e9a16c18faa127"]//*[@title='DL MAC DRB Throughput per QoS Captured in gNodeB']
    FOR    ${i}    IN RANGE    0    5 
           Click Element     xpath://*[@id="4f3572bbe0f8412990e9a16c18faa127"]//*[@title='DL MAC DRB Throughput per QoS Captured in gNodeB']        
    END
    Wait Until Element Contains		xpath://*[@id="4f3572bbe0f8412990e9a16c18faa127"]//*[@title='DL MAC DRB Throughput per QoS Captured in gNodeB']		DL MAC DRB Throughput per QoS Captured in gNodeB


Select on KPI details
    Click element    xpath://*[@id='KPIName1']
    Scroll Element Into View    xpath://*[@id="8334e086f39340f689e565e1ebb96723"]
    Click element    xpath://*[@id="8334e086f39340f689e565e1ebb96723"]
    Sleep	2s
    Wait Until Page Contains Element		xpath://*[@class='sf-element sf-element-visualization-area']
    Element Should Not Contain		xpath://html/body/div/div[2]/div/div[1]/div/div/div[1]/div/div/div[4]/div[1]/div[1]		0 of 0 rows
    capture page screenshot

filtered data page title should be visible
	Sleep	5s
	Wait Until Element Contains		xpath://*[@class='sf-element sf-element-text-box']		Filters
	capture page screenshot
	
verify raw filtered data
	Wait Until Element Contains		xpath://html/body/div/div[2]/div/div[1]/div/div/div[1]/div/div/div[4]/div[1]/div[1]		0 of 0 rows
	capture page screenshot

verify KPIs
    ${kpiname1}=    Get Text    xpath://*[@id="296d5fa7ae3249d0a22e37b77cd6b7de"]
    Log    ${kpiname1}
    ${kpiname2}=    Get Text    xpath://*[@id="9575be4d7eec418fad4d2056a3afbe78"]
    Log    ${kpiname2}
    ${kpiname3}=    Get Text    xpath://*[@id="e1dacc4052ce4fb8a17015c1bdf2a410"]
    Log    ${kpiname3}
    ${kpiname4}=    Get Text    xpath://*[@id="4acbceacac93453f839cc2b254d06038"]
    Log    ${kpiname4}
    ${kpiname5}=    Get Text    xpath://*[@id="bccb9064c90647e089b457552d09d679"]
    Log    ${kpiname5}
    ${kpiname6}=    Get Text    xpath://*[@id="79407f5839384b35bcffbbf0c5dcf7a6"]
    Log    ${kpiname6}
    ${kpiname7}=    Get Text    xpath://*[@id="31765cd6b66d44adb94a32acf8a23632"]
    Log    ${kpiname7}
    ${kpiname8}=    Get Text    xpath://*[@id="b2209498a6e844b0a0fa9d32184af681"]
    Log    ${kpiname8}
    ${kpiname9}=    Get Text    xpath://*[@id="1c24f1e0aae74fd7a4454c8f009fbaa1"]
    Log    ${kpiname9}
    ${kpiname10}=    Get Text    xpath://*[@id="c072df090e0947adb172464b38acf405"]
    Log    ${kpiname10}
    ${kpiname11}=    Get Text    xpath://*[@id="070660afca0748d8a585a4273429133f"]
    Log    ${kpiname11}
    ${kpiname12}=    Get Text    xpath://*[@id="6ce47d260ddb46539218ebe0ae556253"]
    Log    ${kpiname12}


click on the button
	[Arguments]    ${button}
	element should be visible    xpath://*[@value="${button}"]
	Click Element		xpath://*[@value="${button}"]
	sleep	5s
	capture page screenshot	
	

zoom in page
	Press Keys    None	CTRL+'\\45'
	Press Keys    None	CTRL+'\\45'
   
validate the page components  
	[Arguments]     ${expectedText1}	${expectedText2}	${expectedText3}	${expectedText4}
    ${text1}=    Selenium2Library.Get text  xpath://*[@id="02526cfbe13a44449d558dc3e3399526"]
    ${text2}=    Selenium2Library.Get text  xpath://*[@id="aa1b4c730e5546c9bc94e5e6750e8c2e"]
    ${text3}=    Selenium2Library.Get text  xpath://*[@id="92db5ec7a40848fbb3b6865dac4b9b70"]
    ${text4}=    Selenium2Library.Get text  xpath://*[@id="6435a7548f9a47d9a387bc2d36b34675"]
    Log    ${text1}
    Log    ${text2}
    Log    ${text3}
    Log    ${text4}
    Should contain     ${expectedText1}	 ${text1}
    Should contain     ${expectedText2}	 ${text2}
    Should contain     ${expectedText3}	 ${text3}
    Should contain     ${expectedText4}	 ${text4}

validate the home page components
    ${text}=	Partial Cell Availability for eNodeB Cell
	${ele1}=    Selenium2Library.Get text  xpath://*[@id="296d5fa7ae3249d0a22e37b77cd6b7de"]  
	Log		${ele1}
    Should contain     ${ele1}	 ${text}