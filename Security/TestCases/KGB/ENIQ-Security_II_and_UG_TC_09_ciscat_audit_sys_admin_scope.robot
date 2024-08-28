*** Settings ***
Suite Setup      Open Connection and SSH Login
Suite Teardown    Close All Connections

Resource        ../../Resources/cTAF_resource.resource

Library            OperatingSystem
Library            SSHLibrary  10 seconds
Library            String

*** Test Cases ***
Test ensure system admin scope audit rules are configured properly or not
	${result}=       Execute Command       find /etc/audit/rules.d/50-scope.rules
	${audit_file_check}=        Get Lines Matching Regexp    ${result}      /etc/audit/rules.d/50-scope.rules
    Should Be Equal     ${audit_file_check}       /etc/audit/rules.d/50-scope.rules
 
Test ensure system admin scope rules are configured in auditctl daemon
    ${auditctl_check}=        Execute Command       auditctl -l | grep scope
    ${audit_rule_check1}=        Get Lines Matching Regexp    ${auditctl_check}     -w /etc/sudoers -p wa -k scope
    ${audit_rule_check2}=        Get Lines Matching Regexp    ${auditctl_check}     -w /etc/sudoers.d -p wa -k scope
    Should Be Equal     ${audit_rule_check1}       -w /etc/sudoers -p wa -k scope
    Should Be Equal     ${audit_rule_check2}       -w /etc/sudoers.d -p wa -k scope
