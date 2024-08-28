*** Settings ***
Suite Setup      Open Connection and SSH Login
Suite Teardown    Close All Connections

Resource        ../../Resources/cTAF_resource.resource

Library            OperatingSystem
Library            SSHLibrary  10 seconds
Library            String

*** Test Cases ***
Test ensure system access audit rules are configured properly or not
	${result}=       Execute Command       find /etc/audit/rules.d/50-MAC_policy.rules
	${audit_file_check}=        Get Lines Matching Regexp    ${result}      /etc/audit/rules.d/50-MAC_policy.rules
    Should Be Equal     ${audit_file_check}       /etc/audit/rules.d/50-MAC_policy.rules
    
Test ensure system access rules are configured in auditctl daemon
    ${auditctl_check}=        Execute Command       auditctl -l | grep MAC
    ${audit_rule_check1}=        Get Lines Matching Regexp    ${auditctl_check}     -w /etc/selinux -p wa -k MAC-policy
    ${audit_rule_check2}=        Get Lines Matching Regexp    ${auditctl_check}     -w /usr/share/selinux -p wa -k MAC-policy
    Should Be Equal     ${audit_rule_check1}       -w /etc/selinux -p wa -k MAC-policy
    Should Be Equal     ${audit_rule_check2}       -w /usr/share/selinux -p wa -k MAC-policy