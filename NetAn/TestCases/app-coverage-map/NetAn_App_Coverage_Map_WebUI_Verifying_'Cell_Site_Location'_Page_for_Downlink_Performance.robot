*** Settings ***
Library           OperatingSystem
Library           Selenium2Library
Library           Collections
Library           String
Library           SSHLibrary
Library           DateTime
Library           PostgreSQLDB
Library           SikuliLibrary
Library           DatabaseLibrary
Resource          ${EXEC_DIR}/ENIQ_TC_Automation/NetAn/Resources/Keywords/${LTEAppCoverageMapKeywordsFile}
Resource          ${EXEC_DIR}/ENIQ_TC_Automation/NetAn/Resources/Keywords/Variables.robot
Suite setup       Suite setup steps
Suite teardown    Suite teardown steps

*** Test Cases ***

Verify 'Cell Site Location' Page for Downlink Performance
	open app coverage map analysis
	Go to home page if not already at home
	Click on the scroll down button    0    30
	click on button    Cell Performance
	verify the page title    Cell Performance
	Click on the scroll down button    3    2
	select throughput type    Downlink
	set the performance target    DL Throughput >=5.00 Mbps
	click on button    Cell Site Location >>
	verify the page title    Cell Site Location
	click on button    << Cell Performance Ranking
	Click on the scroll down button    3    2
	set the performance target    DL Throughput >=1.00 Mbps
	click on button    Cell Site Location >>
	verify the page title    Cell Site Location
	verify that the graph title is visible    ERBS Site Location for selected Cells
	verify that the graph title is visible    Failure Rate per Cell (DL Throughput >=1.00 Mbps)
	verify that the map and graph are visible
	verify that the button is visible    Home
	validate that the button is visible    << Cell Performance Ranking
	Capture page screenshot
	[Teardown]    Test teardown
 	
 	