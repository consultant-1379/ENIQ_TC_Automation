*** Settings ***
Library           OperatingSystem

*** Test Cases ***
Checking if ENM Storage is successfully Configured
	[Tags]				Bond_Configure
	${ENM_Configure}=		Get File				ENM_Configure_Rack.log
	Set Global Variable		${ENM_Configure}
	Should Contain			${ENM_Configure}			Successfully assigned the interface
