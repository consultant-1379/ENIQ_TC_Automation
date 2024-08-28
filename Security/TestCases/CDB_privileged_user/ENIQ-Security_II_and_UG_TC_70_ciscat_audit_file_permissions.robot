*** Settings ***
Suite Setup      Open Connection and SSH Login
Suite Teardown    Close All Connections

Resource        ../../Resources/cTAF_resource.resource

Library            OperatingSystem
Library            SSHLibrary  10 seconds
Library            String

*** Test Cases ***
Test ensure audit file permissions are 640
	${result}=          Execute Command            sudo find /etc/audit/ -type f \( -name '*.conf' -o -name '*.rules' \) -exec stat -Lc "%n %a" {} + | grep -Pv -- '^\h*\H+\h*([0,2,4,6][0,4]0)\h*$'
    Should Be Empty     ${result}