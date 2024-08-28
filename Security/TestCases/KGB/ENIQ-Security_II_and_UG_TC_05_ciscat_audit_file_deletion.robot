*** Settings ***
Suite Setup      Open Connection and SSH Login
Suite Teardown    Close All Connections

Resource        ../../Resources/cTAF_resource.resource

Library            OperatingSystem
Library            SSHLibrary  10 seconds
Library            String

*** Test Cases ***
Test ensure file deletion audit rules are configured properly or not
	${result}=       Execute Command       find /etc/audit/rules.d/50-deletion.rules
	${audit_file_check}=        Get Lines Matching Regexp    ${result}      /etc/audit/rules.d/50-deletion.rules
    Should Be Equal     ${audit_file_check}       /etc/audit/rules.d/50-deletion.rules

Test ensure file deletion audit rules rules are configured in auditctl daemon
    ${auditctl_check}=        Execute Command       auditctl -l | grep delete
    ${audit_rule_check1}=        Get Lines Matching Regexp    ${auditctl_check}     -a always,exit -F arch=b64 -S rename,unlink,unlinkat,renameat -F auid>=1000 -F auid!=-1 -F key=delete
    ${audit_rule_check2}=        Get Lines Matching Regexp    ${auditctl_check}     -a always,exit -F arch=b32 -S unlink,rename,unlinkat,renameat -F auid>=1000 -F auid!=-1 -F key=delete
    Should Be Equal     ${audit_rule_check1}       -a always,exit -F arch=b64 -S rename,unlink,unlinkat,renameat -F auid>=1000 -F auid!=-1 -F key=delete
    Should Be Equal     ${audit_rule_check2}       -a always,exit -F arch=b32 -S unlink,rename,unlinkat,renameat -F auid>=1000 -F auid!=-1 -F key=delete
