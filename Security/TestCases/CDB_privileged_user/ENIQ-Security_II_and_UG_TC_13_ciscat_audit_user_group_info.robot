*** Settings ***
Suite Setup      Open Connection and SSH Login
Suite Teardown    Close All Connections

Resource        ../../Resources/cTAF_resource.resource

Library            OperatingSystem
Library            SSHLibrary  10 seconds
Library            String

*** Test Cases ***
Test ensure user group info audit rules are configured properly or not
	${result}=       Execute Command       sudo find /etc/audit/rules.d/50-identity.rules
	${audit_file_check}=        Get Lines Matching Regexp    ${result}      /etc/audit/rules.d/50-identity.rules
    Should Be Equal     ${audit_file_check}       /etc/audit/rules.d/50-identity.rules
    
Test ensure user group info audit rules rules are configured in auditctl daemon
    ${auditctl_check}=        Execute Command       sudo auditctl -l | grep identity
    ${audit_rule_check1}=        Get Lines Matching Regexp    ${auditctl_check}     -w /etc/group -p wa -k identity 
    ${audit_rule_check2}=        Get Lines Matching Regexp    ${auditctl_check}     -w /etc/passwd -p wa -k identity
    ${audit_rule_check3}=        Get Lines Matching Regexp    ${auditctl_check}     -w /etc/gshadow -p wa -k identity
    ${audit_rule_check4}=        Get Lines Matching Regexp    ${auditctl_check}     -w /etc/shadow -p wa -k identity
    ${audit_rule_check5}=        Get Lines Matching Regexp    ${auditctl_check}     -w /etc/security/opasswd -p wa -k identity

    Should Be Equal     ${audit_rule_check1}       -w /etc/group -p wa -k identity
    Should Be Equal     ${audit_rule_check2}       -w /etc/passwd -p wa -k identity
    Should Be Equal     ${audit_rule_check3}       -w /etc/gshadow -p wa -k identity
    Should Be Equal     ${audit_rule_check4}       -w /etc/shadow -p wa -k identity
    Should Be Equal     ${audit_rule_check5}       -w /etc/security/opasswd -p wa -k identity
