*** Settings ***
Suite Setup      Open Connection and SSH Login
Suite Teardown    Close All Connections

Resource        ../../Resources/cTAF_resource.resource

Library            OperatingSystem
Library            SSHLibrary  10 seconds
Library            String

*** Test Cases ***
Test ensure capturing actions of another user configured properly or not
	${result}=       Execute Command       find /etc/audit/rules.d/50-user_emulation.rules
	${audit_file_check}=        Get Lines Matching Regexp    ${result}      /etc/audit/rules.d/50-user_emulation.rules
    Should Be Equal     ${audit_file_check}       /etc/audit/rules.d/50-user_emulation.rules

Test ensure capturing actions of another user configured is running in auditctl daemon
    ${auditctl_check}=        Execute Command       auditctl -l | grep user_emulation
    ${audit_rule_check1}=        Get Lines Matching Regexp    ${auditctl_check}     -a always,exit -F arch=b64 -S execve -C uid!=euid -F auid!=-1 -F key=user_emulation
    ${audit_rule_check2}=        Get Lines Matching Regexp    ${auditctl_check}     -a always,exit -F arch=b32 -S execve -C uid!=euid -F auid!=-1 -F key=user_emulation
 
    Should Be Equal     ${audit_rule_check1}       -a always,exit -F arch=b64 -S execve -C uid!=euid -F auid!=-1 -F key=user_emulation
    Should Be Equal     ${audit_rule_check2}       -a always,exit -F arch=b32 -S execve -C uid!=euid -F auid!=-1 -F key=user_emulation