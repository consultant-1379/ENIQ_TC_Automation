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

Verifying 'Historical Trend - Network Overview' Page for Downlink Performance
	open app coverage map analysis
	Go to home page if not already at home
	Click on the scroll down button    0    30
	click on button    Network Overview
	verify the page title    Network Overview
	click on button    Historical Trend >>
	verify the page title    Historical Trend - Network Overview
	Click on the scroll down button    3    2
	select throughput type    Downlink
	set the performance target    DL Throughput >=20.00 Mbps
	Click on the scroll down button    3    1
	Click on the scroll up button    3    1
	verify the chart title for Downlink
	verify that the charts are visible
	verify that the button is visible    Home
	validate that the button is visible    << Network Overview
	[Teardown]    Test teardown
 	
 	