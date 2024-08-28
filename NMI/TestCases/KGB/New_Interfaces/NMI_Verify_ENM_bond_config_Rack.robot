*** Settings ***
Suite Setup        Open Connection And Log In
Suite Teardown     Close All Connections
Library            SSHLibrary
Library		   BuiltIn	
Library            String
Resource           ../../Resources/resource.txt

*** Variables ***
   
*** Test Cases ***

Checking ENM Storage Bond Configuration
	[Tags]                       Bond_Configure
        Set Client Configuration     timeout=25 seconds      prompt=#:				
	${bond_value}=		     Execute Command 	     cat /eniq/installation/config/ipmp.ini | grep ENM_Group_Intf | cut -d '=' -f2
	Write			     nmcli con show | awk '{print $4}'
	${output}=		     Read		     delay=5s
	Should Contain		     ${output}		     ${bond_value}
