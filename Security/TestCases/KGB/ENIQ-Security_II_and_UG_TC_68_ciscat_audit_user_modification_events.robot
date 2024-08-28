*** Settings ***
Suite Setup      Open Connection and SSH Login
Suite Teardown    Close All Connections

Resource        ../../Resources/cTAF_resource.resource

Library            OperatingSystem
Library            SSHLibrary  10 seconds
Library            String

*** Test Cases ***
Test ensure kernel usermod command events audit is configured properly or not
	${result}=       Execute Command       find /etc/audit/rules.d/50-usermod.rules
	${audit_file_check}=        Get Lines Matching Regexp    ${result}      /etc/audit/rules.d/50-usermod.rules
    Should Be Equal     ${audit_file_check}       /etc/audit/rules.d/50-usermod.rules

Test ensure kernel usermod command events audit is configured in auditctl daemon
    ${auditctl_check}=        Execute Command              auditctl -l | grep usermod
    ${audit_rule_check1}=     Get Lines Matching Regexp    ${auditctl_check}     -a always,exit -S all -F path=/usr/sbin/usermod -F perm=x -F auid>=1000 -F auid!=-1 -F key=usermod
    Should Be Equal           ${audit_rule_check1}         -a always,exit -S all -F path=/usr/sbin/usermod -F perm=x -F auid>=1000 -F auid!=-1 -F key=usermod