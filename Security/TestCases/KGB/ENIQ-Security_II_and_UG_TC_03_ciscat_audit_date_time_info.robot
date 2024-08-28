*** Settings ***
Suite Setup      Open Connection and SSH Login
Suite Teardown    Close All Connections

Resource        ../../Resources/cTAF_resource.resource

Library            OperatingSystem
Library            SSHLibrary  10 seconds
Library            String

*** Test Cases ***
Test ensure date and time audit rules are configured properly or not
	${result}=       Execute Command       find /etc/audit/rules.d/50-time_change.rules
	${audit_file_check}=        Get Lines Matching Regexp    ${result}      /etc/audit/rules.d/50-time_change.rules
    Should Be Equal     ${audit_file_check}       /etc/audit/rules.d/50-time_change.rules
    
Test ensure date time info audit rules are configured in auditctl daemon
    ${auditctl_check}=        Execute Command       auditctl -l | grep time-change
    ${audit_rule_check1}=        Get Lines Matching Regexp    ${auditctl_check}     -a always,exit -F arch=b64 -S adjtimex,settimeofday -F key=time-change
    ${audit_rule_check2}=        Get Lines Matching Regexp    ${auditctl_check}     -a always,exit -F arch=b32 -S stime,settimeofday,adjtimex -F key=time-change
    ${audit_rule_check3}=        Get Lines Matching Regexp    ${auditctl_check}     -a always,exit -F arch=b64 -S clock_settime -F key=time-change
    ${audit_rule_check4}=        Get Lines Matching Regexp    ${auditctl_check}     -a always,exit -F arch=b32 -S clock_settime -F key=time-change
    ${audit_rule_check5}=        Get Lines Matching Regexp    ${auditctl_check}     -w /etc/localtime -p wa -k time-change
    

    Should Be Equal     ${audit_rule_check1}       -a always,exit -F arch=b64 -S adjtimex,settimeofday -F key=time-change
    Should Be Equal     ${audit_rule_check2}       -a always,exit -F arch=b32 -S stime,settimeofday,adjtimex -F key=time-change
    Should Be Equal     ${audit_rule_check3}       -a always,exit -F arch=b64 -S clock_settime -F key=time-change
    Should Be Equal     ${audit_rule_check4}       -a always,exit -F arch=b32 -S clock_settime -F key=time-change
    Should Be Equal     ${audit_rule_check5}       -w /etc/localtime -p wa -k time-change