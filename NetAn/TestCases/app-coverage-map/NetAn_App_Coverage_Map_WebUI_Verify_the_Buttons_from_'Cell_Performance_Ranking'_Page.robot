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

Verify the Buttons from 'Cell Performance Ranking' Page
	open app coverage map analysis
	Go to home page if not already at home
	Click on the scroll down button    0    30
	click on button    Cell Performance
	verify the page title    Cell Performance
	Click on the scroll down button    3    2
	select throughput type    Downlink
	set the performance target    DL Throughput >=1.00 Mbps
	verify that the button is visible    Home
	validate that the button is visible    Cell Site Location >>
	validate that the button is visible    Historical Trend >>
	click on button    Cell Site Location >>
	verify the page title    Cell Site Location
	click on button    << Cell Performance Ranking
	verify the page title    Cell Performance
	click on button    Historical Trend >>
	verify the page title    Historical Trend
	click on button    << Cell Performance Ranking
	verify the page title    Cell Performance
	click on the button    Home
	verify the page title    Home
	Capture page screenshot
	[Teardown]    Test teardown
 	
 	