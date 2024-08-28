*** Settings ***
Suite Setup      Open Connection and SSH Login
Suite Teardown    Close All Connections

Resource        ../../Resources/cTAF_resource.resource

Library            OperatingSystem
Library            SSHLibrary  10 seconds
Library            String

*** Test Cases ***
Test ensure user privileged cmd rules are configured properly or not
	${result}=       Execute Command       sudo find /etc/audit/rules.d/50-privileged.rules
	${audit_file_check}=        Get Lines Matching Regexp    ${result}      /etc/audit/rules.d/50-privileged.rules
    Should Be Equal     ${audit_file_check}       /etc/audit/rules.d/50-privileged.rules