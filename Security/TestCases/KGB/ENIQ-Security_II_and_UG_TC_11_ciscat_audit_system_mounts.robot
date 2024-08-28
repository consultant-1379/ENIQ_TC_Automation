*** Settings ***
Suite Setup      Open Connection and SSH Login
Suite Teardown    Close All Connections

Resource        ../../Resources/cTAF_resource.resource

Library            OperatingSystem
Library            SSHLibrary  10 seconds
Library            String

*** Test Cases ***
Test ensure system mounts audit rules are configured properly or not
	${result}=       Execute Command       find /etc/audit/rules.d/50-mounts.rules
	${audit_file_check}=        Get Lines Matching Regexp    ${result}      /etc/audit/rules.d/50-mounts.rules
    Should Be Equal     ${audit_file_check}       /etc/audit/rules.d/50-mounts.rules
    
Test ensure system mounts audit rules are configured in auditctl daemon
    ${auditctl_check}=        Execute Command       auditctl -l | grep mounts
    ${audit_rule_check1}=        Get Lines Matching Regexp    ${auditctl_check}     -a always,exit -F arch=b64 -S mount -F auid>=1000 -F auid!=-1 -F key=mounts
    ${audit_rule_check2}=        Get Lines Matching Regexp    ${auditctl_check}     -a always,exit -F arch=b32 -S mount -F auid>=1000 -F auid!=-1 -F key=mounts
    Should Be Equal     ${audit_rule_check1}       -a always,exit -F arch=b64 -S mount -F auid>=1000 -F auid!=-1 -F key=mounts
    Should Be Equal     ${audit_rule_check2}       -a always,exit -F arch=b32 -S mount -F auid>=1000 -F auid!=-1 -F key=mounts
