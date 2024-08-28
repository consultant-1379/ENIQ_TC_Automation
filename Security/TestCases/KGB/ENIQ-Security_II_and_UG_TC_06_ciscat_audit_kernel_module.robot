*** Settings ***
Suite Setup      Open Connection and SSH Login
Suite Teardown    Close All Connections

Resource        ../../Resources/cTAF_resource.resource

Library            OperatingSystem
Library            SSHLibrary  10 seconds
Library            String

*** Test Cases ***
Test ensure kernel module audit rules are configured properly or not
	${result}=                  Execute Command       find /etc/audit/rules.d/50-kernel_modules.rules
	${audit_file_check}=        Get Lines Matching Regexp    ${result}      /etc/audit/rules.d/50-kernel_modules.rules
    Should Be Equal             ${audit_file_check}       /etc/audit/rules.d/50-kernel_modules.rules

Test ensure kernel module audit rules rules are configured in auditctl daemon
    ${auditctl_check}=           Execute Command              auditctl -l | grep kernel_modules
    ${audit_rule_check1}=        Get Lines Matching Regexp    ${auditctl_check}     -a always,exit -F arch=b64 -S create_module,init_module,delete_module,query_module,finit_module -F auid>=1000 -F auid!=-1 -F key=kernel_modules
    ${audit_rule_check2}=        Get Lines Matching Regexp    ${auditctl_check}     -a always,exit -S all -F path=/usr/bin/kmod -F perm=x -F auid>=1000 -F auid!=-1 -F key=kernel_modules

    Should Be Equal     ${audit_rule_check1}       -a always,exit -F arch=b64 -S create_module,init_module,delete_module,query_module,finit_module -F auid>=1000 -F auid!=-1 -F key=kernel_modules
    Should Be Equal     ${audit_rule_check2}       -a always,exit -S all -F path=/usr/bin/kmod -F perm=x -F auid>=1000 -F auid!=-1 -F key=kernel_modules