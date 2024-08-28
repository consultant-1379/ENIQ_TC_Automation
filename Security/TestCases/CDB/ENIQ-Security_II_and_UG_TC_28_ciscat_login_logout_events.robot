*** Settings ***
Suite Setup      Open Connection and SSH Login
Suite Teardown    Close All Connections

Resource        ../../Resources/cTAF_resource.resource

Library            OperatingSystem
Library            SSHLibrary  10 seconds
Library            String

*** Test Cases ***
Test ensure audit login logout events are captured
	${result}=       Execute Command       find /etc/audit/rules.d/50-logins.rules
	${audit_file_check}=        Get Lines Matching Regexp    ${result}      /etc/audit/rules.d/50-logins.rules
    Should Be Equal     ${audit_file_check}       /etc/audit/rules.d/50-logins.rules
    
Test ensure audit login logout events are configurred in auditctl daemon
    ${auditctl_check}=        Execute Command       auditctl -l | grep logins
    ${audit_rule_check1}=        Get Lines Matching Regexp    ${auditctl_check}     -w /var/log/lastlog -p wa -k logins
    ${audit_rule_check2}=        Get Lines Matching Regexp    ${auditctl_check}     -w /var/run/faillock -p wa -k logins
    ${audit_rule_check3}=        Get Lines Matching Regexp    ${auditctl_check}     -w /var/log/wtmp -p wa -k logins
    ${audit_rule_check4}=        Get Lines Matching Regexp    ${auditctl_check}     -w /var/log/btmp -p wa -k logins

    Should Be Equal     ${audit_rule_check1}       -w /var/log/lastlog -p wa -k logins
    Should Be Equal     ${audit_rule_check2}       -w /var/run/faillock -p wa -k logins
    Should Be Equal     ${audit_rule_check3}       -w /var/log/wtmp -p wa -k logins
    Should Be Equal     ${audit_rule_check4}       -w /var/log/btmp -p wa -k logins