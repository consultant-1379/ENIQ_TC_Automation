*** Settings ***
Suite Setup      Open Connection and SSH Login
Suite Teardown    Close All Connections

Resource        ../../Resources/cTAF_resource.resource

Library            OperatingSystem
Library            SSHLibrary  10 seconds
Library            String

*** Test Cases ***
Test ensure audit session initiation information rules are captured
    ${result}=       Execute Command       sudo find /etc/audit/rules.d/50-session.rules
	${audit_file_check}=        Get Lines Matching Regexp    ${result}      /etc/audit/rules.d/50-session.rules
    Should Be Equal     ${audit_file_check}       /etc/audit/rules.d/50-session.rules

Test ensure audit session initiation information rules are configured in auditctl daemon
    ${auditctl_check}=        Execute Command       sudo auditctl -l | grep session
    ${audit_rule_check1}=        Get Lines Matching Regexp    ${auditctl_check}     -w /var/run/utmp -p wa -k session
 
    Should Be Equal     ${audit_rule_check1}      -w /var/run/utmp -p wa -k session
