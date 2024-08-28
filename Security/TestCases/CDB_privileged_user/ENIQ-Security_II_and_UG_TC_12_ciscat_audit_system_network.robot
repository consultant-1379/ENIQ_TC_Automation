*** Settings ***
Suite Setup      Open Connection and SSH Login
Suite Teardown    Close All Connections

Resource        ../../Resources/cTAF_resource.resource

Library            OperatingSystem
Library            SSHLibrary  10 seconds
Library            String

*** Test Cases ***
Test ensure system network audit rules are configured properly or not
	${result}=       Execute Command       sudo find /etc/audit/rules.d/50-system_locale.rules
	${audit_file_check}=        Get Lines Matching Regexp    ${result}      /etc/audit/rules.d/50-system_locale.rules
    Should Be Equal     ${audit_file_check}       /etc/audit/rules.d/50-system_locale.rules
    
Test ensure system network audit rules rules are configured in auditctl daemon
    ${auditctl_check}=        Execute Command       sudo auditctl -l | grep system-locale
    ${audit_rule_check1}=        Get Lines Matching Regexp    ${auditctl_check}     -a always,exit -F arch=b64 -S sethostname,setdomainname -F key=system-locale
    ${audit_rule_check2}=        Get Lines Matching Regexp    ${auditctl_check}     -a always,exit -F arch=b32 -S sethostname,setdomainname -F key=system-locale
    ${audit_rule_check3}=        Get Lines Matching Regexp    ${auditctl_check}     -w /etc/issue -p wa -k system-locale
    ${audit_rule_check4}=        Get Lines Matching Regexp    ${auditctl_check}     -w /etc/issue.net -p wa -k system-locale
    ${audit_rule_check5}=        Get Lines Matching Regexp    ${auditctl_check}     -w /etc/hosts -p wa -k system-locale
    ${audit_rule_check6}=        Get Lines Matching Regexp    ${auditctl_check}     -w /etc/sysconfig/network -p wa -k system-locale
    ${audit_rule_check7}=        Get Lines Matching Regexp    ${auditctl_check}     -w /etc/sysconfig/network-scripts -p wa -k system-locale
    

    Should Be Equal     ${audit_rule_check1}       -a always,exit -F arch=b64 -S sethostname,setdomainname -F key=system-locale
    Should Be Equal     ${audit_rule_check2}       -a always,exit -F arch=b32 -S sethostname,setdomainname -F key=system-locale
    Should Be Equal     ${audit_rule_check3}       -w /etc/issue -p wa -k system-locale
    Should Be Equal     ${audit_rule_check4}       -w /etc/issue.net -p wa -k system-locale
    Should Be Equal     ${audit_rule_check5}       -w /etc/hosts -p wa -k system-locale
    Should Be Equal     ${audit_rule_check6}       -w /etc/sysconfig/network -p wa -k system-locale
    Should Be Equal     ${audit_rule_check7}       -w /etc/sysconfig/network-scripts -p wa -k system-locale