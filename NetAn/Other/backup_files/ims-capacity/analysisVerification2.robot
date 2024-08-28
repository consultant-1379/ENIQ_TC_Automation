*** Settings ***
Documentation     Testing Ima
Library           Selenium2Library
Library           OperatingSystem
Library           Selenium2Library
Library           SikuliLibrary
Library           Collections
Library           String
Resource          ./Resources/Keywords/IMSCapacityWebUI.robot
Suite setup        Set Screenshot Directory    ./Screenshots



*** Variables ***
${base_url}=       https://localhost/
${ims_url}=       spotfire/wp/analysis?file=/Ericsson%20Library/IMS/IMS-Analysis/Ericsson-IMS-Capacity-Analysis/Analyses/Ericsson-IMS-Capacity-Analysis&waid=wvRsOLxisk6XmIoi8nn2F-181911061eT_3E&wavid=0								  
{browser_name}=   chrome
${IMAGE_DIR}        ${EXECDIR}/Other/sikuli-images

*** Test Cases ***

Verify the CSCF: Platform and Capacity page_031
    open ims capacity analysis
    Sleep 	10s
    click on Home button if current its not in home page
    wait for the page 	 HOME
    click on the Reset button
    Sleep 	5s
    click on the IMS Node Overview button
    wait for the page 	 IMS Node Overview
    validate the page title as 	  IMS Node Overview
    click on 'CSCF: Platform and Capacity >>' link
    wait for the page 	  CSCF: Platform and Capacity
    validate the page title as 	  CSCF: Platform and Capacity
    make selections on chart
    click on Home button
    wait for the page 	 HOME
    click on the Reset button
    Sleep 	7s
    click on the IMS Node Overview button
    wait for the page 	 IMS Node Overview
    click on 'CSCF: Platform and Capacity >>' link
    wait for the page 	  CSCF: Platform and Capacity
    validate the page title as 	  CSCF: Platform and Capacity
    Capture page screenshot
    [Teardown]    Close Browser
    
Verify IMS Analysis_IMS 0032
    open ims capacity analysis
    click on Home button if current its not in home page
    wait for the page 	 HOME
    click on the Reset button
    Sleep 	5s
    click on the IMS Node Overview button
    wait for the page 	 IMS Node Overview
    validate the page title as 	  IMS Node Overview
    validate the title time range in IMS Node Overview page  	 Time Range:
    Capture page screenshot
    [Teardown]    Close Browser

Verify IMS_ IMS 033
    open ims capacity analysis
    click on Home button if current its not in home page
    wait for the page 	 HOME
    click on the Reset button
    Sleep 	5s
    click on the IMS Node Overview button
    wait for the page 	 IMS Node Overview
    validate the page title as 	  IMS Node Overview
    click on Home button
    wait for the page 	 HOME
   	validate the page title as 	  HOME
    click on the IMS Node Overview button
    wait for the page 	 IMS Node Overview
    validate the page title as 	  IMS Node Overview
    Capture page screenshot
    [Teardown]    Close Browser
    
Verify IMS Analysis_IMS 0034
    open ims capacity analysis
    Sleep 	5s
    click on Home button if current its not in home page
    wait for the page 	 HOME
    click on the Reset button
    Sleep 	5s
    click on the IMS Node Overview button
    wait for the page 	 IMS Node Overview
    validate the page title as 	  IMS Node Overview
    click on 'CSCF: Platform and Capacity >>' link
    wait for the page	 CSCF: Platform and Capacity
    validate the page title as 	  CSCF: Platform and Capacity
    validate the title	  Node KPI Performance
	validate the title 	  KPI Details
    validate the title time range  		Time Range:
    validate the title kpis 	KPIs:
    click on the IMS Node Overview button from CSCF page
    wait for the page 	 IMS Node Overview
    click on 'CSCF: Traffic' link
    wait for the page 	 CSCF: Traffic
    validate the page title as		CSCF: Traffic
    click on the IMS Node Overview button from CSCF page
    wait for the page 	 IMS Node Overview
    click on Home button
    wait for the page 	 HOME
   	validate the page title as 	  HOME
    Capture page screenshot
    [Teardown]    Close Browser        
    
Verify IMS Analysis_IMS 0035
    open ims capacity analysis
    Sleep 	5s
    click on Home button if current its not in home page
    wait for the page 	 HOME
    click on the Reset button
    Sleep 	5s
    click on the IMS Node Overview button
    wait for the page 	 IMS Node Overview
    validate the page title as 	  IMS Node Overview
    Click on scroll down button of node table	 4
    click on 'MTAS: Platform and Capacity >>' link
    wait for the page	 MTAS:Platform and Capacity 
    validate the page title as 	  MTAS:Platform and Capacity 
    validate the title	  Node KPI Performance
	validate the title 	  KPI Details
    validate the title time range  		Time Range:
    validate the title kpis 	KPIs:
    click on MTAS:Traffic button from Home page
    wait for the page 	 MTAS: Traffic
    validate the page title as 	  MTAS: Traffic 
    validate the title	  Node KPI Performance
	validate the title 	  KPI Details
    validate the title time range  		Time Range:
    validate the title kpis 	KPIs:
    click on the IMS Node Overview button on Home page
    wait for the page 	 IMS Node Overview
    validate the page title as 	  IMS Node Overview
    click on Home button
    wait for the page 	 HOME
   	validate the page title as 	  HOME
    Capture page screenshot
    [Teardown]    Close Browser     
     
Verify IMS Analysis_IMS 0036
    open ims capacity analysis
    Sleep 	5s
    click on Home button if current its not in home page
    wait for the page 	 HOME
    click on the Reset button
    Sleep 	5s
    click on the IMS Node Overview button
    wait for the page 	 IMS Node Overview
    validate the page title as 	  IMS Node Overview
    Click on scroll down button of node table	 7
    click on 'SBG: Platform >>' link
    wait for the page	 SBG: Platform
    validate the page title as 	  SBG: Platform 
    validate the title	  Node KPI Performance
	validate the title 	  KPI Details
    validate the title time range  		Time Range:
    validate the title kpis 	KPIs:
    click on Traffic button from Home page	 SBG:Traffic
    wait for the page 	 SBG: Traffic
    validate the page title as 	  SBG: Traffic 
    validate the title	  Node KPI Performance
	validate the title 	  KPI Details
    validate the title time range  		Time Range:
    validate the title kpis 	KPIs:
    click on the IMS Node Overview button on Home page
    wait for the page 	 IMS Node Overview
    validate the page title as 	  IMS Node Overview
    click on Home button
    wait for the page 	 HOME
   	validate the page title as 	  HOME
    Capture page screenshot
    [Teardown]    Close Browser     
    
Verify IMS Analysis_IMS 0037
    open ims capacity analysis
    Sleep 	5s
    click on Home button if current its not in home page
    wait for the page 	 HOME
    click on the Reset button
    Sleep 	5s
    click on the IMS Node Overview button
    wait for the page 	 IMS Node Overview
    validate the page title as 	  IMS Node Overview
    Click on scroll down button of node table	 7
    click on 'MRS: Platform >>' link
    wait for the page	 MRS: Platform
    validate the page title as 	  MRS: Platform 
    validate the title	  Node KPI Performance
	validate the title 	  KPI Details
    validate the title time range  		Time Range:
    validate the title kpis 	KPIs:
    click on Traffic button from Home page	 MRS: Traffic
    wait for the page 	 MRS: Traffic
    validate the page title as 	  MRS: Traffic 
    validate the title	  Node KPI Performance
	validate the title 	  KPI Details
    validate the title time range  		Time Range:
    validate the title kpis 	KPIs:
    click on the IMS Node Overview button on Home page
    wait for the page 	 IMS Node Overview
    validate the page title as 	  IMS Node Overview
    click on Home button
    wait for the page 	 HOME
   	validate the page title as 	  HOME
    Capture page screenshot
    [Teardown]    Close Browser 
    
Verify IMS Analysis_IMS 0038
    open ims capacity analysis
    Sleep 	5s
    click on Home button if current its not in home page
    wait for the page 	 HOME
    click on the Reset button
    Sleep 	5s
    click on the IMS Node Overview button
    wait for the page 	 IMS Node Overview
    validate the page title as 	  IMS Node Overview
    click on 'HSS: Platform and Capacity >>' link
    wait for the page	 HSS: Platform and Capacity
    validate the page title as 	  HSS: Platform and Capacity 
    validate the title	  Node KPI Performance
	validate the title 	  KPI Details
    validate the title time range  		Time Range:
    validate the title kpis 	KPIs:
    click on Traffic button from Home page	 HSS: Traffic
    wait for the page 	 HSS: Traffic
    validate the page title as 	  HSS: Traffic
    validate the title	  Node KPI Performance
	validate the title 	  KPI Details
    validate the title time range  		Time Range:
    validate the title kpis 	KPIs:
    click on the IMS Node Overview button on Home page
    wait for the page 	 IMS Node Overview
    validate the page title as 	  IMS Node Overview
    click on Home button
    wait for the page 	 HOME
   	validate the page title as 	  HOME
    Capture page screenshot
    [Teardown]    Close Browser     
    
Verify IMS Analysis_IMS 0039
    open ims capacity analysis
    Sleep 	5s
    click on Home button if current its not in home page
    wait for the page 	 HOME
    click on the Reset button
    Sleep 	5s
    click on the IMS Node Overview button
    wait for the page 	 IMS Node Overview
    validate the page title as 	  IMS Node Overview
    click on 'HSS-FE: Platform and Capacity >>' link
    wait for the page	 HSS-FE: Platform and Capacity
    validate the page title as 	  HSS-FE: Platform and Capacity 
    validate the title	  Node KPI Performance
	validate the title 	  KPI Details
    validate the title time range  		Time Range:
    validate the title kpis 	KPIs:
    click on Traffic button from Home page	 HSS-FE: Traffic
    wait for the page 	 HSS-FE: Traffic
    validate the page title as 	  HSS-FE: Traffic
    validate the title	  Node KPI Performance
	validate the title 	  KPI Details
    validate the title time range  		Time Range:
    validate the title kpis 	KPIs:
    click on the IMS Node Overview button on Home page
    wait for the page 	 IMS Node Overview
    validate the page title as 	  IMS Node Overview
    click on Home button
    wait for the page 	 HOME
   	validate the page title as 	  HOME
    Capture page screenshot
    [Teardown]    Close Browser 
    
      
    
Verify IMS Analysis_IMS 0040
    open ims capacity analysis
    Sleep 	5s
    click on Home button if current its not in home page
    wait for the page 	 HOME
    click on the Reset button
    Sleep 	5s
    validate the page title as 	  HOME
    click on "Settings" img button
    wait for the page 	 Settings
    validate the page title as	  Settings
    click on Home button
    wait for the page 	 HOME
   	validate the page title as 	  HOME
    Capture page screenshot
    [Teardown]    Close Browser    

        
Verify IMS Analysis_IMS 0041
    open ims capacity analysis
    Sleep 	5s
    click on Home button if current its not in home page
    wait for the page 	 HOME
    click on the Reset button
    Sleep 	4s
    click on the IMS Node Overview button
    wait for the page 	 IMS Node Overview
    validate the page title as 	  IMS Node Overview
    click on 'CSCF: Platform and Capacity >>' link
    wait for the page	 CSCF: Platform and Capacity
    validate the page title as 	  CSCF: Platform and Capacity
    click on "Filtered Data" button
    wait for the page 	 CSCF Filtered Data
    validate the page title as		CSCF Filtered Data
    click on Home button
    wait for the page 	 HOME
   	validate the page title as 	  HOME
    Capture page screenshot
    [Teardown]    Close Browser 
            
Verify IMS Analysis_IMS 0042
    open ims capacity analysis
    Sleep 	5s
    click on Home button if current its not in home page
    wait for the page 	 HOME
    click on the Reset button
    Sleep 	4s
    click on the IMS Node Overview button
    wait for the page 	 IMS Node Overview
    validate the page title as 	  IMS Node Overview
    click on 'HSS: Platform and Capacity >>' link
    wait for the page	 HSS: Platform and Capacity
    validate the page title as 	  HSS: Platform and Capacity 
    click on "Filtered Data" button
    wait for the page 	 HSS Filtered Data
    validate the page title as		HSS Filtered Data
    click on Home button
    wait for the page 	 HOME
   	validate the page title as 	  HOME
    Capture page screenshot
    [Teardown]    Close Browser 
    
Verify IMS Analysis_IMS 0043
    open ims capacity analysis
    Sleep 	5s
    click on Home button if current its not in home page
    wait for the page 	 HOME
    click on the Reset button
    Sleep 	4s
    click on the IMS Node Overview button
    wait for the page 	 IMS Node Overview
    validate the page title as 	  IMS Node Overview
    Click on scroll down button of node table	 4
    click on 'MTAS: Platform and Capacity >>' link
    wait for the page	 MTAS:Platform and Capacity 
    validate the page title as 	  MTAS:Platform and Capacity
    click on "Filtered Data" button
    wait for the page 	 MTAS Filtered Data
    validate the page title as		MTAS Filtered Data
    click on Home button
    wait for the page 	 HOME
   	validate the page title as 	  HOME
    Capture page screenshot
    [Teardown]    Close Browser            
    
Verify IMS Analysis_IMS 0044
    open ims capacity analysis
    Sleep 	5s
    click on Home button if current its not in home page
    wait for the page 	 HOME
    click on the Reset button
    Sleep 	4s
    click on the IMS Node Overview button
    wait for the page 	 IMS Node Overview
    validate the page title as 	  IMS Node Overview
    Click on scroll down button of node table	 7
    click on 'SBG: Platform >>' link
    wait for the page	 SBG: Platform
    validate the page title as 	  SBG: Platform  
    click on "Filtered Data" button
    wait for the page 	 SBG Filtered Data
    validate the page title as		SBG Filtered Data
    click on Home button
    wait for the page 	 HOME
   	validate the page title as 	  HOME
    Capture page screenshot
    [Teardown]    Close Browser    
    
Verify IMS Analysis_IMS 0045
    open ims capacity analysis
    Sleep 	5s
    click on Home button if current its not in home page
    wait for the page 	 HOME
    click on the Reset button
    Sleep 	4s
    click on the IMS Node Overview button
    wait for the page 	 IMS Node Overview
    validate the page title as 	  IMS Node Overview
    Click on scroll down button of node table	 7
    click on 'MRS: Platform >>' link
    wait for the page	 MRS: Platform
    validate the page title as 	  MRS: Platform 
    click on "Filtered Data" button
    wait for the page 	 MRS Filtered Data
    validate the page title as		MRS Filtered Data
    click on Home button
    wait for the page 	 HOME
   	validate the page title as 	  HOME
    Capture page screenshot
    [Teardown]    Close Browser     
    
Verify IMS Analysis_IMS 0046
    open ims capacity analysis
    Sleep 	5s
    click on Home button if current its not in home page
    wait for the page 	 HOME
    click on the Reset button
    Sleep 	4s
    click on the IMS Node Overview button
    wait for the page 	 IMS Node Overview
    validate the page title as 	  IMS Node Overview
    click on 'HSS-FE: Platform and Capacity >>' link
    wait for the page	 HSS-FE: Platform and Capacity
    validate the page title as 	  HSS-FE: Platform and Capacity  
    click on "Filtered Data" button
    wait for the page 	 HSS-FE Filtered Data
    validate the page title as		HSS-FE Filtered Data
    click on Home button
    wait for the page 	 HOME
   	validate the page title as 	  HOME
    Capture page screenshot
    [Teardown]    Close Browser     
    
Verify IMS Analysis_IMS 0047
    open ims capacity analysis
    Sleep 	5s
    click on Home button if current its not in home page
    wait for the page 	 HOME
    click on the Reset button
    Sleep 	4s
    click on the IMS Node Overview button
    wait for the page 	 IMS Node Overview
    validate the page title as 	  IMS Node Overview
    click on 'CSCF: Traffic >>' link
    wait for the page	 CSCF: Traffic
    validate the page title as 	  CSCF: Traffic 
    click on "Filtered Data" button
    wait for the page 	 CSCF Filtered Data
    validate the page title as		CSCF Filtered Data
    click on Home button
    wait for the page 	 HOME
   	validate the page title as 	  HOME
    Capture page screenshot
    [Teardown]    Close Browser   
    
Verify IMS Analysis_IMS 0048
    open ims capacity analysis
    Sleep 	5s
    click on Home button if current its not in home page
    wait for the page 	 HOME
    click on the Reset button
    Sleep 	4s
    click on the IMS Node Overview button
    wait for the page 	 IMS Node Overview
    validate the page title as 	  IMS Node Overview
    Click on scroll down button of node table	 5
    click on 'MTAS: Traffic >>' link
    wait for the page	 MTAS: Traffic
    validate the page title as 	  MTAS: Traffic 
    click on "Filtered Data" button
    wait for the page 	 MTAS Filtered Data
    validate the page title as		MTAS Filtered Data
    click on Home button
    wait for the page 	 HOME
   	validate the page title as 	  HOME
    Capture page screenshot
    [Teardown]    Close Browser      

Verify IMS Analysis_IMS 0049
    open ims capacity analysis
    Sleep 	5s
    click on Home button if current its not in home page
    wait for the page 	 HOME
    click on the Reset button
    Sleep 	4s
    click on the IMS Node Overview button
    wait for the page 	 IMS Node Overview
    validate the page title as 	  IMS Node Overview
    Click on scroll down button of node table	 9
    click on 'SBG: Traffic >>' link
    wait for the page	 SBG: Traffic
    validate the page title as 	  SBG: Traffic  
    click on "Filtered Data" button
    wait for the page 	 SBG Filtered Data
    validate the page title as		SBG Filtered Data
    click on Home button
    wait for the page 	 HOME
   	validate the page title as 	  HOME
    Capture page screenshot
    [Teardown]    Close Browser     
    
 Verify IMS Analysis_IMS 0050
    open ims capacity analysis
    Sleep 	5s
    click on Home button if current its not in home page
    wait for the page 	 HOME
    click on the Reset button
    Sleep 	4s
    click on the IMS Node Overview button
    wait for the page 	 IMS Node Overview
    validate the page title as 	  IMS Node Overview
    Click on scroll down button of node table	 5
    click on 'MRS: Traffic >>' link
    wait for the page	 MRS: Traffic
    validate the page title as 	  MRS: Traffic 
    click on "Filtered Data" button
    wait for the page 	 MRS Filtered Data
    validate the page title as		MRS Filtered Data
    click on Home button
    wait for the page 	 HOME
   	validate the page title as 	  HOME
    Capture page screenshot
    [Teardown]    Close Browser 
    
Verify IMS Analysis_IMS 0051
    open ims capacity analysis
    Sleep 	5s
    click on Home button if current its not in home page
    wait for the page 	 HOME
    click on the Reset button
    Sleep 	4s
    click on the IMS Node Overview button
    wait for the page 	 IMS Node Overview
    validate the page title as 	  IMS Node Overview
    click on 'HSS: Traffic >>' link
    wait for the page	 HSS: Traffic
    validate the page title as 	  HSS: Traffic
    click on "Filtered Data" button
    wait for the page 	 HSS Filtered Data
    validate the page title as		HSS Filtered Data
    click on Home button
    wait for the page 	 HOME
   	validate the page title as 	  HOME
    Capture page screenshot
    [Teardown]    Close Browser    
    
Verify IMS Analysis_IMS 0052
    open ims capacity analysis
    Sleep 	5s
    click on Home button if current its not in home page
    wait for the page 	 HOME
    click on the Reset button
    Sleep 	4s
    click on the IMS Node Overview button
    wait for the page 	 IMS Node Overview
    validate the page title as 	  IMS Node Overview
    click on 'HSS-FE: Traffic >>' link
    wait for the page	 HSS-FE: Traffic
    validate the page title as 	  HSS-FE: Traffic  
    click on "Filtered Data" button
    wait for the page 	 HSS-FE Filtered Data
    validate the page title as		HSS-FE Filtered Data
    click on Home button
    wait for the page 	 HOME
   	validate the page title as 	  HOME
    Capture page screenshot
    [Teardown]    Close Browser      