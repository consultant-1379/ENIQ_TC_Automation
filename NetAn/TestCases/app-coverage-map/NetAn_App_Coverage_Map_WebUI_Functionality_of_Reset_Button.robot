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
Suite Setup       Suite setup steps
Suite Teardown    Suite teardown steps

*** Test Cases ***

Functionality of Reset Button
	open app coverage map analysis
	Go to home page if not already at home
	Click on the scroll down button    0    30
	click on the button    Reset All Filters and Markings
	click on button    Cell Performance
	verify the page title    Cell Performance
	Click on the scroll down button    3    2
	select throughput type    Downlink
	set the performance target    DL Throughput >=5.00 Mbps
	make a selection on the Worst Performing Cells chart
	read the marked value
	click on the button    Home
	verify the page title    Home
	Click on the scroll down button    0    30
	click on the button    Reset All Filters and Markings
	click on button    Cell Performance
	verify the page title    Cell Performance
	verify that the marked value is 0
	Capture page screenshot
	[Teardown]    Test teardown
 	
 	