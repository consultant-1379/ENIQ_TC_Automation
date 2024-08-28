*** Settings ***
Documentation     Testing UplinkInterference UI
Library           Selenium2Library
Library           OperatingSystem
Library           Selenium2Library
Library           SikuliLibrary
Library           Collections
Library           String
Resource          ./Resources/Keywords/UplinkInterferenceWebUI.robot
Suite setup        Set Screenshot Directory    ./Screenshots



*** Variables ***
${base_url}=       https://localhost/
${uplink_url}=        spotfire/wp/analysis?file=/Ericsson%20Library/Radio-Common/RAN%20Uplink%20Interference/Ericsson-RAN-Uplink-Interference/Analyses/RAN_Uplink_Interference&waid=O4Uc39FBck6ck084P38sW-170652061eI6Zm&wavid=0
{browser_name}=   chrome
${IMAGE_DIR}        ${EXECDIR}/Other/sikuli-images

*** Test Cases ***

Verify Navigation to PUCCH/PUSCH Analysis_TC01
	open uplink interference analysis
    Sleep 	5s
    click on the Reset button
    click on button     Health Check 
    wait for the page 	  Uplink Interference Health Check
    validate the page title as 	  Uplink Interference Health Check
    click on the button		PUCCH/PUSCH Analysis
    validate the page title as   PUCCH/PUSCH Analysis
    click on the button		PUCCH/PUSCH Detailed Analysis >> 
    validate the page title as 	 PUCCH/PUSCH: Detailed Analysis
    click on the button		Filtered Data >>
    validate the page title as 	 PUCCH/PUSCH Filtered Raw Data
    click on the button		<< PUSCH/PUCCH Detailed Analysis
    validate the page title as 	 PUCCH/PUSCH: Detailed Analysis
    click on the button		<< PUCCH/PUSCH Analysis
    validate the page title as 	 PUCCH/PUSCH Analysis
    click on the button		<< Uplink Interference Health Check 
    validate the page title as 	 Uplink Interference Health Check 
    click on Home button	
    Capture page screenshot
    [Teardown]    Close Browser
    
Verify Navigation to PRB Analysis_TC02
	open uplink interference analysis
    Sleep 	5s
    click on the Reset button
    click on button     Health Check 
    wait for the page 	  Uplink Interference Health Check
    validate the page title as 	  Uplink Interference Health Check
    click on the button		PRB Analysis
    validate the page title as   PRB Analysis
    click on the button		PRB Detailed Analysis >>
    validate the page title as 	 PRB: Detailed Analysis
    click on the button		Filtered Data >>
    validate the page title as 	 PRB Filtered Raw Data
    click on the button		<< PRB Detailed Analysis
    validate the page title as 	 PRB: Detailed Analysis
    click on the button		<< PRB Analysis
    validate the page title as 	 PRB Analysis
    click on the button		<< Uplink Interference Health Check 
    validate the page title as 	 Uplink Interference Health Check Cell
    click on Home button	
    Capture page screenshot
    [Teardown]    Close Browser

Verify Navigation to Antenna Analysis_TC03
	open uplink interference analysis
    Sleep 	5s
    click on the Reset button
    click on button     Health Check 
    wait for the page 	  Uplink Interference Health Check
    validate the page title as 	  Uplink Interference Health Check
    click on the button		Antenna Branch Analysis
    validate the page title as   Antenna Branch Analysis
    click on the button		Antenna Branch Detailed Analysis >>
    validate the page title as 	 Antenna Branch: Detailed Analysis
    click on the button		Filtered Data >>
    validate the page title as 	 Antenna Branch Filtered Raw Data
    click on the button		<< Antenna Branch Detailed Analysis
    validate the page title as 	 Antenna Branch: Detailed Analysis
    click on the button		<< Antenna Branch Analysis
    validate the page title as 	 Antenna Branch Analysis
    click on the button		<< Uplink Interference Health Check 
    validate the page title as 	 Uplink Interference Health Check Cell
    click on Home button	
    Capture page screenshot
    [Teardown]    Close Browser
 
Verify Reset Filters and Markings Icon_TC04
	open uplink interference analysis
    Sleep 	5s
    click on the Reset button
    click on button     Health Check 
    wait for the page 	  Uplink Interference Health Check
    validate the page title as 	  Uplink Interference Health Check
    select some area in the chart "PUSCH PRB"
    click on Home button
    click on the Reset button
    click on button     Health Check
    wait for the page 	  Uplink Interference Health Check
    validate the page title as 	  Uplink Interference Health Check
    verify the reset filters and markings as 0 marked in the bottom of page		0 marked
    Capture page screenshot
    [Teardown]    Close Browser         
    
Verify Navigation to Node TroubleShooting_TC05
	open uplink interference analysis
    Sleep 	5s
    click on the Reset button
    click on button	     Node Troubleshooting 
    validate the page title as 	  Node Troubleshooting
    click on the button		PUCCH/PUSCH Detailed Analysis 
    validate the page title with no white spaces   PUCCH/PUSCH:${SPACE*2}Detailed Analysis		
    click on the button		Filtered Data >>
    validate the page title with no white spaces 	 PUCCH/PUSCH Filtered${SPACE*2}Raw Data
    click on the button		<< PUSCH/PUCCH Detailed Analysis
    validate the page title with no white spaces 	 PUCCH/PUSCH:${SPACE*2}Detailed Analysis
    click on << Node Troubleshooting button
    validate the page title with no white spaces 	 Node Troubleshooting   
    click on the button		PRB Detailed Analysis
    validate the page title with no white spaces   PRB:${SPACE*2}Detailed Analysis  
    click on the button		Filtered Data >>
    validate the page title with no white spaces 	 PRB Filtered${SPACE*2}Raw Data   
    click on the button		<< PRB Detailed Analysis
    validate the page title with no white spaces 	 PRB:${SPACE*2}Detailed Analysis   
    click on << Node Troubleshooting button
    validate the page title with no white spaces 	 Node Troubleshooting   
    click on the button		Antenna Branch Detailed Analysis
    validate the page title with no white spaces 	 Antenna Branch:${SPACE*2}Detailed Analysis  
    click on the button		Filtered Data >> 
    validate the page title with no white spaces 	 Antenna Branch Filtered${SPACE*2}Raw Data
    click on the button		<< Antenna Branch Detailed Analysis 
    validate the page title with no white spaces	 Antenna Branch:${SPACE*1}Detailed Analysis
    click on << Node Troubleshooting button
    validate the page title with no white spaces 	 Node Troubleshooting 
    click on Home button	
    Capture page screenshot
    [Teardown]    Close Browser    
    
Verify Health Check labels and units_TC06
	open uplink interference analysis
    Sleep 	2s
    click on the Reset button
    click on button     Health Check 
    wait for the page 	  Uplink Interference Health Check
    validate the page title as 	  Uplink Interference Health Check
    select Interference measure and Aggregation as		 Interference Power 	Average
    validate the chart titles as  	Interference Power PUCCH Network Distribution   Interference Power PUSCH Network Distribution   Interference Power PUSCH PRB Network Distribution   Interference Power PUSCH Antenna Branch Network Distribution
    wait for page to load
    verify the y axis label of a chart contains 	Cells by Average PUCCH Interference Power 		3
    verify the y axis label of a chart contains 	Cells by Average PUSCH Interference Power		1
    verify the y axis label of a chart contains 	Cells by Average PUSCH PRB Interference Power	2  
    verify the y axis label of a chart contains 	Branches by Average PUSCH Interference Power	0
    select Interference measure and Aggregation as		Interference Power		Maximum
    validate the chart titles as  	Interference Power PUCCH Network Distribution   Interference Power PUSCH Network Distribution   Interference Power PUSCH PRB Network Distribution   Interference Power PUSCH Antenna Branch Network Distribution
    wait for page to load
    verify the x axis label of each of four chart when Interference measure is   Interference Power (dBm)
    verify the y axis label of a chart contains 	Cells by Maximum PUCCH Interference Power 		3
    verify the y axis label of a chart contains 	Cells by Maximum PUSCH Interference Power		1
    verify the y axis label of a chart contains 	Cells by Maximum PUSCH PRB Interference Power	2  
    verify the y axis label of a chart contains 	Branches by Maximum PUSCH Interference Power	0   
    select Interference measure and Aggregation as		Noise Rise	 Average
    validate the chart titles as  	Interference Power PUCCH Network Distribution   Interference Power PUSCH Network Distribution   Interference Power PUSCH PRB Network Distribution   Interference Power PUSCH Antenna Branch Network Distribution
    wait for page to load
    verify the y axis label of a chart contains 	Cells by Average PUCCH Noise Rise 		3
    verify the y axis label of a chart contains 	Cells by Average PUSCH Noise Rise		1
    verify the y axis label of a chart contains 	Cells by Average PUSCH PRB Noise Rise	2  
    verify the y axis label of a chart contains 	Branches by Average PUSCH Noise Rise	0   
    select Interference measure and Aggregation as		Noise Rise	 Maximum
    validate the chart titles as  	Interference Power PUCCH Network Distribution   Interference Power PUSCH Network Distribution   Interference Power PUSCH PRB Network Distribution   Interference Power PUSCH Antenna Branch Network Distribution
    wait for page to load
    verify the x axis label of each of four chart when Interference measure is   Noise Rise (dB) 
    verify the y axis label of a chart contains 	Cells by Maximum PUCCH Noise Rise 		3
    verify the y axis label of a chart contains 	Cells by Maximum PUSCH Noise Rise		1
    verify the y axis label of a chart contains 	Cells by Maximum PUSCH PRB Noise Rise	2  
    verify the y axis label of a chart contains 	Branches by Maximum PUSCH Noise Rise	0   
    Capture page screenshot
    [Teardown]    Close Browser       
    
Verify PUCCH/PUSCH Analysis labels and units_TC07
	open uplink interference analysis
    Sleep 	2s
    click on the Reset button
    click on button     Health Check 
    wait for the page 	  Uplink Interference Health Check
    validate the page title as 	  Uplink Interference Health Check
    click on the button		PUCCH/PUSCH Analysis
    validate the page title as   PUCCH/PUSCH Analysis
    select Interference measure and Aggregation as		 Interference Power 	Maximum
   	wait for page to load
    validate the chart titles as 	Interference Power (dBm) PUCCH per Selected Cell (Maximum Values)	Interference Power (dBm) PUSCH per Selected Cell (Maximum Values)
    verify the y axis label of a chart contains		PUCCH Cells by Interference Power (dBm) (Maximum Value) 	0
    verify the y axis label of a chart contains		PUSCH Cells by Interference Power (dBm) (Maximum Value) 	1
    select Interference measure and Aggregation as	 Interference Power 	Average
    wait for page to load
    validate the chart titles as 	Interference Power (dBm) PUCCH per Selected Cell (Average Values)	Interference Power (dBm) PUSCH per Selected Cell (Average Values)
    verify the y axis label of a chart contains		PUCCH Cells by Interference Power (dBm) (Average Value) 	0
    verify the y axis label of a chart contains		PUSCH Cells by Interference Power (dBm) (Average Value) 	1
    verify the x axis label of chart in PUCCH/PUSCH Analysis when Interference measure is   Interference Power (dBm)
    select Interference measure and Aggregation as		 Noise Rise 	Average
    wait for page to load
    validate the chart titles as 	Noise Rise (dB) PUCCH per Selected Cell (Average Values)	Noise Rise (dB) PUSCH per Selected Cell (Average Values)
    verify the y axis label of a chart contains		PUCCH Cells by Noise Rise (dB) (Average Value)  0
    verify the y axis label of a chart contains		PUSCH Cells by Noise Rise (dB) (Average Value)	1
    select Interference measure and Aggregation as		 Noise Rise 	Maximum
    wait for page to load
    validate the chart titles as 	Noise Rise (dB) PUCCH per Selected Cell (Maximum Values)	Noise Rise (dB) PUSCH per Selected Cell (Maximum Values)
    verify the y axis label of a chart contains		PUCCH Cells by Noise Rise (dB) (Maximum Value)  0
    verify the y axis label of a chart contains		PUSCH Cells by Noise Rise (dB) (Maximum Value)	1
    verify the x axis label of chart in PUCCH/PUSCH Analysis when Interference measure is   Noise Rise (dB) 
    click on the button		PUCCH/PUSCH Detailed Analysis >>
   	validate the page title as 	 PUCCH/PUSCH: Detailed Analysis
   	select channel as	PUSCH
   	validate the chart titles as	Interference Level in PUSCH per Date/Time	Interference Distribution of pmRadioRecInterferencePwr
   	select channel as	PUCCH
   	wait for page to load
   	validate the chart titles as	Interference Level in PUCCH per Date/Time	Interference Distribution of pmRadioRecInterferencePwrPucch  
    click on the button		Filtered Data >>
    validate the page title as 	 PUCCH/PUSCH Filtered Raw Data
    click on the button		<< PUSCH/PUCCH Detailed Analysis
    validate the page title as 	 PUCCH/PUSCH: Detailed Analysis
    click on the button		<< PUCCH/PUSCH Analysis
    validate the page title as 	 PUCCH/PUSCH Analysis
    click on the button		<< Uplink Interference Health Check 
    validate the page title as 	 Uplink Interference Health Check Cell
    click on Home button
    Capture page screenshot
    [Teardown]    Close Browser     
    
Verify PRB Analysis labels and units_TC08
	open uplink interference analysis
    Sleep 	2s
    click on the Reset button
    click on button     Health Check 
    wait for the page 	  Uplink Interference Health Check
    validate the page title as 	  Uplink Interference Health Check
    click on the button		PRB Analysis
    validate the page title as   PRB Analysis
    select Interference measure and Aggregation as		 Interference Power 	Average
    wait for page to load
    validate the chart titles as 	Interference Power By Date/Time 	Noise Rise By Date/Time  
    verify the y axis label of a chart contains		PUSCH PRB Cells by Interference Power (dBm) (Average Value)  	0
    select Interference measure and Aggregation as	 Interference Power 	Maximum
  	wait for page to load
    validate the chart titles as 	Interference Power By Date/Time 	Noise Rise By Date/Time
    verify the y axis label of a chart contains		PUSCH PRB Cells by Interference Power (dBm) (Maximum Value)  	0
    verify the x axis label of chart as    Interference Power (dBm)  1
    select Interference measure and Aggregation as		 Noise Rise 	Maximum
    wait for page to load 
    validate the chart titles as 	Interference Power By Date/Time 	Noise Rise By Date/Time
    verify the y axis label of a chart contains		PUSCH PRB Cells by Noise Rise (dB) (Maximum Value)   0
    select Interference measure and Aggregation as		 Noise Rise 	Average
    wait for page to load
    validate the chart titles as 	Interference Power By Date/Time 	Noise Rise By Date/Time
    verify the y axis label of a chart contains		PUSCH PRB Cells by Noise Rise (dB) (Average Value)   0
    verify the x axis label of chart as    Noise Rise (dB)  1
    click on the button		PRB Detailed Analysis >>
    validate the page title as 	 PRB: Detailed Analysis
    validate the chart titles as 	Received Uplink Interference Power per PRB (dBm)  
    click on the button		Filtered Data >>
    validate the page title as 	 PRB Filtered Raw Data
    click on the button		<< PRB Detailed Analysis
    validate the page title as 	 PRB: Detailed Analysis
    click on the button		<< PRB Analysis
    validate the page title as 	 PRB Analysis
    click on the button		<< Uplink Interference Health Check 
    validate the page title as 	 Uplink Interference Health Check Cell
    click on Home button	
    Capture page screenshot
    [Teardown]    Close Browser      
    
Verify Antenna Analysis labels and units_TC09
	open uplink interference analysis
    Sleep 	2s
    click on the Reset button
    click on button     Health Check 
    wait for the page 	  Uplink Interference Health Check
    validate the page title as 	  Uplink Interference Health Check
    click on the button		Antenna Branch Analysis
    validate the page title as   Antenna Branch Analysis
    select Interference measure and Aggregation as		 Interference Power 	Average
    wait for page to load 
    validate the chart titles as 	Average Interference Over Selected Branches per Day 	Difference in Absolute Received Power for Selected Antenna Branches  
    verify the y axis label of a chart contains		PUSCH Branches by Interference Power (Maximum Value) 	0
    select Interference measure and Aggregation as	 Interference Power 	Maximum
  	wait for page to load
    validate the chart titles as 	Maximum Interference Over Selected Branches per Day 	Difference in Absolute Received Power for Selected Antenna Branches  
    verify the y axis label of a chart contains		PUSCH Branches by Interference Power (Maximum Value)  	0
    verify the x axis label of chart as    Interference Power (dBm)  1
    select Interference measure and Aggregation as		 Noise Rise 	Maximum
    wait for page to load 
    validate the chart titles as 	Maximum Interference Over Selected Branches per Day 	Difference in Absolute Received Power for Selected Antenna Branches  
    verify the y axis label of a chart contains		PUSCH Branches by Noise Rise (Maximum Value)   0
    select Interference measure and Aggregation as		 Noise Rise 	Average
    wait for page to load
    validate the chart titles as 	Average Interference Over Selected Branches per Day 	Difference in Absolute Received Power for Selected Antenna Branches  
    verify the y axis label of a chart contains		PUSCH Branches by Noise Rise (Maximum Value)    0
    verify the x axis label of chart as    Noise Rise (dB)  1
    click on the button		Antenna Branch Detailed Analysis >>
    validate the page title as 	 Antenna Branch: Detailed Analysis     
    validate the chart titles as 	Received Uplink Interference Power per Antenna Branch  
	 click on the button		Filtered Data >>
    validate the page title as 	 Antenna Branch Filtered Raw Data
    click on the button		<< Antenna Branch Detailed Analysis
    validate the page title as 	 Antenna Branch: Detailed Analysis
    click on the button		<< Antenna Branch Analysis
    validate the page title as 	 Antenna Branch Analysis
    click on the button		<< Uplink Interference Health Check 
    validate the page title as 	 Uplink Interference Health Check Cell
    click on Home button
    Capture page screenshot
    [Teardown]    Close Browser	    
    
Verify Node TroubleShooting labels and units_TC10
	open uplink interference analysis
    Sleep 	2s
    click on the Reset button
    click on button	     Node Troubleshooting 
    validate the page title as 	  Node Troubleshooting
    select Interference measure and Aggregation as		 Interference Power 	Average
    wait for page to load 
    validate the chart titles as 	Interference Power (dBm) PUCCH Averaged Per Cell  Interference Power (dBm) PUSCH Averaged Per Cell  Interference Power (dBm) PUSCH PRB Averaged Per Cell  Interference Power (dBm) PUSCH Averaged Per Antenna Branch
    validate the chart titles as 	PUCCH Interference Power (dBm) per Cell  PUSCH Interference Power (dBm) per Cell  PUSCH PBR Interference Power (dBm) per Cell  PUSCH Interference Power (dBm) per Antenna Branch  
    select Interference measure and Aggregation as	 Interference Power 	Maximum
  	wait for page to load
    validate the chart titles as 	Interference Power (dBm) PUCCH Averaged Per Cell  Interference Power (dBm) PUSCH Averaged Per Cell  Interference Power (dBm) PUSCH PRB Averaged Per Cell  Interference Power (dBm) PUSCH Averaged Per Antenna Branch
    validate the chart titles as 	PUCCH Interference Power (dBm) per Cell  PUSCH Interference Power (dBm) per Cell  PUSCH PBR Interference Power (dBm) per Cell  PUSCH Interference Power (dBm) per Antenna Branch  
    verify the x axis label of chart for the indices as    Interference Power (dBm)   1  2  3  5
    select Interference measure and Aggregation as		 Noise Rise 	Maximum
    wait for page to load 
    validate the chart titles as	Noise Rise (dB) PUCCH Averaged Per Cell  Noise Rise (dB) PUSCH Averaged Per Cell  Noise Rise (dB) PUSCH PRB Averaged Per Cell  Noise Rise (dB) PUSCH Averaged Per Antenna Branch
    validate the chart titles as    PUCCH Noise Rise (dB) per Cell  PUSCH Noise Rise (dB) per Cell  PUSCH PBR Noise Rise (dB) per Cell  PUSCH Noise Rise (dB) per Antenna Branch
    wait for page to load 
    validate the chart titles as 	Noise Rise (dB) PUCCH Averaged Per Cell  Noise Rise (dB) PUSCH Averaged Per Cell  Noise Rise (dB) PUSCH PRB Averaged Per Cell  Noise Rise (dB) PUSCH Averaged Per Antenna Branch
    validate the chart titles as 	PUCCH Noise Rise (dB) per Cell   PUSCH Noise Rise (dB) per Cell   PUSCH PBR Noise Rise (dB) per Cell   PUSCH Noise Rise (dB) per Antenna Branch
    verify the x axis label of chart for the indices as    Noise Rise (dB)  1  2  3  5   
    click on Home button	
    Capture page screenshot
    [Teardown]    Close Browser   
    
Verify Filtered Data Page for Avg_int_PUSCH_TC11
	open uplink interference analysis
    Sleep 	2s
    click on the Reset button
    click on button     Health Check 
    validate the page title as 	  Uplink Interference Health Check
    click on the button		PUCCH/PUSCH Analysis
    validate the page title as   PUCCH/PUSCH Analysis
    click in chart PUSCH Cells
    click on the button		PUCCH/PUSCH Detailed Analysis >> 
    validate the page title as 	 PUCCH/PUSCH: Detailed Analysis
    click on the button		Filtered Data >>
    validate the page title as 	 PUCCH/PUSCH Filtered Raw Data
    validate the page opened without any data populated in table
    click on the button		<< PUSCH/PUCCH Detailed Analysis
    Sleep   5s
    validate the page title as 	 PUCCH/PUSCH: Detailed Analysis
    select channel as   PUSCH
    wait for page to load
    Sleep    10s
    fetch data
    wait for page to load
    select the ROPs DCVECTOR_INDEXs
    click on the button		Filtered Data >>
    validate the page title as 	 PUCCH/PUSCH Filtered Raw Data
    wait for page to load
    verify the selected data
    verify the DCVECTOR_INDEXs value
    Capture page screenshot
    [Teardown]    Close Browser  

Verify Filtered Data Page for Avg_int_PUCCH_TC12
	open uplink interference analysis
    Sleep 	2s
    click on the Reset button
    click on button     Health Check 
    validate the page title as 	  Uplink Interference Health Check
    click on the button		PUCCH/PUSCH Analysis
    validate the page title as   PUCCH/PUSCH Analysis
    click in chart PUCCH Cells
    click on the button		PUCCH/PUSCH Detailed Analysis >> 
    validate the page title as 	 PUCCH/PUSCH: Detailed Analysis
    click on the button		Filtered Data >>
    validate the page title as 	 PUCCH/PUSCH Filtered Raw Data
    validate the page opened without any data populated in table
    click on the button		<< PUSCH/PUCCH Detailed Analysis
    Sleep   5s
    validate the page title as 	 PUCCH/PUSCH: Detailed Analysis
    select channel as   PUCCH
    wait for page to load
    fetch data
    wait for page to load
    select the ROPs DCVECTOR_INDEXs
    click on the button		Filtered Data >>
    validate the page title as 	 PUCCH/PUSCH Filtered Raw Data
    wait for page to load
    verify the selected data
    verify the DCVECTOR_INDEXs value
    Capture page screenshot
    [Teardown]    Close Browser           
     
Verify PUCCH Network Distribution charts in Heath Check Page_TC13
	open uplink interference analysis
    Sleep 	2s
    click on the Reset button
    click on button     Health Check 
    validate the page title as 	  Uplink Interference Health Check
    validate the chart title as    Interference Power PUCCH Network Distribution	
    Capture page screenshot
    [Teardown]    Close Browser   
 
 
Verify PUSCH Network Distribution charts in Heath Check Page_TC14
 	open uplink interference analysis
    Sleep 	2s
    click on the Reset button
    click on button     Health Check 
    validate the page title as 	  Uplink Interference Health Check
    validate the chart title as    Interference Power PUSCH Network Distribution	
    Capture page screenshot
    [Teardown]    Close Browser 
    
Verify PUSCH PRB Network Distributions charts in Heath Check Page_TC15
 	open uplink interference analysis
    Sleep 	2s
    click on the Reset button
    click on button     Health Check 
    validate the page title as 	  Uplink Interference Health Check
    validate the chart title as    Interference Power PUSCH PRB Network Distribution
    Capture page screenshot
    [Teardown]    Close Browser     
 
Verify PUSCH Antenna Branch Network Distribution charts in Heath Check Pagee_TC16
 	open uplink interference analysis
    Sleep 	2s
    click on the Reset button
    click on button     Health Check 
    validate the page title as 	  Uplink Interference Health Check
    validate the chart title as    Interference Power PUSCH Antenna Branch Network Distribution
    Capture page screenshot
    [Teardown]    Close Browser  
    
Verify Settings Page_TC17
	open uplink interference analysis
    Sleep 	2s
    click on the Reset button
    click on Settings button 
    validate the page title as 	  Settings
    Click on scroll down button		21
    click on Home button
    Capture page screenshot
    [Teardown]    Close Browser   
    
Verify New feature added 2 dropdowns_TC18
	open uplink interference analysis
    Sleep 	2s
   	click on the Reset button
    click on button     Health Check 
    validate the page title as 	  Uplink Interference Health Check
    select Interference Power PUSCH - Rank By dropdown as   Antenna Branch
    select Interference Power PUSCH - Rank By dropdown as 	Cell
    Sleep  5s
    wait for page to load
    validate the chart title is  	Interference Power Difference PUSCH Cell Network Distribution
    select Interference Power PUSCH - Rank By dropdown as 	Antenna Branch
    wait for page to load
    validate the chart title is  	Interference Power PUSCH Antenna Branch Network Distribution
    Capture page screenshot
    [Teardown]    Close Browser
    
Verify 1st 4-Chart in Health Check page & Dropdown top right_TC19
	open uplink interference analysis
    Sleep 	2s
    click on the Reset button
    click on button     Health Check 
    validate the page title as 	  Uplink Interference Health Check
    verify the chart Interference Power PUCCH Network Distribution bar chart is visible
    verify the chart Interference Power PUSCH Network Distribution bar chart is visible
    verify the chart Interference Power PUSCH PRB Network Distribution bar chart is visible
    verify the chart Interference Power PUSCH Antenna Branch Network Distribution bar chart is visible
    verify the Interference Power PUSCH - Rank By drop down is present
    Capture page screenshot
    [Teardown]    Close Browser    
    
Verify PUSCH/PUCCH Detailed Analysis (Last 8 days) - Date chart tooltip_TC20
	open uplink interference analysis
    Sleep 	20s
    click on the Reset button
    click on button     Health Check 
    validate the page title as 	  Uplink Interference Health Check
    click on the button		PUCCH/PUSCH Analysis
    validate the page title as   PUCCH/PUSCH Analysis
    click in chart PUSCH Cells
    click on the button		PUCCH/PUSCH Detailed Analysis >> 
    validate the page title as 	 PUCCH/PUSCH: Detailed Analysis
    Sleep   2s
    wait for page to load
    select channel as   PUSCH
    wait for page to load
    fetch data
    wait for page to load
   	click on date time graph
    verify tooltip value is visible for DATE time chart		Interference_PDF_mapping
    Capture page screenshot
    [Teardown]    Close Browser          
  
Verify PUCCH/PUSCH Analysis (Last 8 days) - tooltip values for 2 charts (zigzag line)_TC21
	open uplink interference analysis
    Sleep 	5s
    click on the Reset button
    click on button     Health Check 
    validate the page title as 	  Uplink Interference Health Check
    click on the button		PUCCH/PUSCH Analysis
    validate the page title as   PUCCH/PUSCH Analysis
    click in chart PUCCH Cells
    Sleep  20s
    wait for page to load
    click in zigzag chart of 	Interference Power (dBm) PUCCH per Selected Cell 
    Sleep 		2s
    verify tooltip value is visible
    click in chart PUSCH Cells
    click in zigzag chart of 	Interference Power (dBm) PUSCH per Selected Cell 
    verify tooltip value is visible
    Capture page screenshot
    [Teardown]    Close Browser 
    
Verify Setting button Page - MSA Config_TC22
	open uplink interference analysis
    Sleep 	2s
    click on the Reset button
    click on Settings button 
    validate the page title as 	  Settings
    verify the title in setting page 	MSA Configuration
    verify the Configure MSA button
    Click on scroll down button		21
    click on Home button
    Capture page screenshot
    [Teardown]    Close Browser  
    Capture page screenshot
    [Teardown]    Close Browser     
             
Verify Node Troubleshooting for erbs_1111 - Data Loading_TC23
	open uplink interference analysis
    Sleep 	2s
    click on the Reset button
    click on button	     Node Troubleshooting 
    validate the page title as 	  Node Troubleshooting
    Sleep 	7s
    ${nodeSelected}=	select one node from node list
    Click on scroll down button of node selection	25	 4
    click on button   Fetch Data
    wait for page to load
    verify the selected node is updated in title  ${nodeSelected}
    Capture page screenshot
    [Teardown]    Close Browser      
    
Verify Filtered Data Page for Avg_int_PUSCH_Prb_TC24
	open uplink interference analysis
    Sleep 	2s
    click on the Reset button
    click on button     Health Check 
    validate the page title as 	  Uplink Interference Health Check
    click on the button		PRB Analysis
    validate the page title as   PRB Analysis
	wait for page to load
    click on chart
    verify the reset filters and markings not as 0 marked in the bottom of page		0 marked
    click on the button		PRB Detailed Analysis >>
    validate the page title as 	 PRB: Detailed Analysis
    click on the button		Filtered Data >>
    validate the page title as 	 PRB Filtered Raw Data
    click on the button		<< PRB Detailed Analysis
    validate the page title as 	 PRB: Detailed Analysis
   	fetch data of PRB for PRB analysis
   	wait for page to load 
   	click on the button		Filtered Data >>
    validate the page title as 	 PRB Filtered Raw Data 
    verify data for    ERBS Eutrancell
    Capture page screenshot
    [Teardown]    Close Browser       
    
Verify Filtered Data Page for Avg_int_PUSCH_BrPrb (Antenna Branch)_TC25
	open uplink interference analysis
    Sleep 	2s
    click on the Reset button
    click on button     Health Check 
    validate the page title as 	  Uplink Interference Health Check
    click on the button		Antenna Branch Analysis
    validate the page title as   Antenna Branch Analysis
    wait for page to load
    click on chart
    Sleep  5s
    wait for page to load
    verify the reset filters and markings not as 0 marked in the bottom of page		0 marked
    click on the button		Antenna Branch Detailed Analysis >>
    validate the page title as 	 Antenna Branch: Detailed Analysis
    click on the button		Filtered Data >>
    validate the page title as 	 Antenna Branch Filtered Raw Data
    click on the button		<< Antenna Branch Detailed Analysis
    validate the page title as 	 Antenna Branch: Detailed Analysis
    fetch data of PRB
    wait for page to load 
    click on the button		Filtered Data >>
    validate the page title as 	 Antenna Branch Filtered Raw Data
    verify title as 	ERBS PMUL Interference Raw
    verify data for    ERBS PMUL Interference Raw
    Capture page screenshot
    [Teardown]    Close Browser     