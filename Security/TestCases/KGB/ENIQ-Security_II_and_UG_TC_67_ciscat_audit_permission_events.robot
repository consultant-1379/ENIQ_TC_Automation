*** Settings ***
Suite Setup      Open Connection and SSH Login
Suite Teardown    Close All Connections

Resource        ../../Resources/cTAF_resource.resource

Library            OperatingSystem
Library            SSHLibrary  10 seconds
Library            String

*** Test Cases ***
Test ensure user permission command events are configured properly or not
	${result}=       Execute Command       find /etc/audit/rules.d/50-perm_chng.rules
	${audit_file_check}=        Get Lines Matching Regexp    ${result}      /etc/audit/rules.d/50-perm_chng.rules
    Should Be Equal     ${audit_file_check}       /etc/audit/rules.d/50-perm_chng.rules

Test ensure user permission command events are configured in auditctl daemon
    ${auditctl_check}=        Execute Command       auditctl -l | grep perm_chng
    ${audit_rule_check1}=        Get Lines Matching Regexp    ${auditctl_check}     -a always,exit -S all -F path=/usr/bin/chcon -F perm=x -F auid>=1000 -F auid!=-1 -F key=perm_chng
    ${audit_rule_check2}=        Get Lines Matching Regexp    ${auditctl_check}     -a always,exit -S all -F path=/usr/bin/setfacl -F perm=x -F auid>=1000 -F auid!=-1 -F key=perm_chng
    ${audit_rule_check3}=        Get Lines Matching Regexp    ${auditctl_check}     -a always,exit -S all -F path=/usr/bin/chacl -F perm=x -F auid>=1000 -F auid!=-1 -F key=perm_chng

    Should Be Equal     ${audit_rule_check1}       -a always,exit -S all -F path=/usr/bin/chcon -F perm=x -F auid>=1000 -F auid!=-1 -F key=perm_chng
    Should Be Equal     ${audit_rule_check2}       -a always,exit -S all -F path=/usr/bin/setfacl -F perm=x -F auid>=1000 -F auid!=-1 -F key=perm_chng
    Should Be Equal     ${audit_rule_check3}       -a always,exit -S all -F path=/usr/bin/chacl -F perm=x -F auid>=1000 -F auid!=-1 -F key=perm_chng