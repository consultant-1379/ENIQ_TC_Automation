*** Settings ***
Suite Setup      Open Connection and SSH Login
Suite Teardown    Close All Connections

Resource        ../../Resources/cTAF_resource.resource

Library            OperatingSystem
Library            SSHLibrary  10 seconds
Library            String

*** Test Cases ***
Test ensure file access control permission file_check rules are configured properly or not
    ${result}=       Execute Command       find /etc/audit/rules.d/50-perm_mod.rules
	${access_control_perm_file_check}=        Get Lines Matching Regexp    ${result}      /etc/audit/rules.d/50-perm_mod.rules
    Should Be Equal     ${access_control_perm_file_check}       /etc/audit/rules.d/50-perm_mod.rules

Test ensure file that discretionary access control permission modification
    ${perm_mod_rule_check}=        Execute Command       auditctl -l | grep perm_mod
    ${perm_mod_rule_check1}=        Get Lines Matching Regexp    ${perm_mod_rule_check}    -a always,exit -F arch=b64 -S chmod,fchmod,fchmodat -F auid>=1000 -F auid!=-1 -F key=perm_mod
    ${perm_mod_rule_check2}=        Get Lines Matching Regexp    ${perm_mod_rule_check}    -a always,exit -F arch=b32 -S chmod,fchmod,fchmodat -F auid>=1000 -F auid!=-1 -F key=perm_mod
    ${perm_mod_rule_check3}=        Get Lines Matching Regexp    ${perm_mod_rule_check}    -a always,exit -F arch=b64 -S chown,fchown,lchown,fchownat -F auid>=1000 -F auid!=-1 -F key=perm_mod
    ${perm_mod_rule_check4}=        Get Lines Matching Regexp    ${perm_mod_rule_check}    -a always,exit -F arch=b32 -S lchown,fchown,chown,fchownat -F auid>=1000 -F auid!=-1 -F key=perm_mod  
    ${perm_mod_rule_check5}=        Get Lines Matching Regexp    ${perm_mod_rule_check}    -a always,exit -F arch=b64 -S setxattr,lsetxattr,fsetxattr,removexattr,lremovexattr,fremovexattr -F auid>=1000 -F auid!=-1 -F key=perm_mod
    
    ${perm_mod_rule_check6}=        Get Lines Matching Regexp    ${perm_mod_rule_check}    -a always,exit -F arch=b32 -S setxattr,lsetxattr,fsetxattr,removexattr,lremovexattr,fremovexattr -F auid>=1000 -F auid!=-1 -F key=perm_mod


    Should Be Equal     ${perm_mod_rule_check1}    -a always,exit -F arch=b64 -S chmod,fchmod,fchmodat -F auid>=1000 -F auid!=-1 -F key=perm_mod
    Should Be Equal     ${perm_mod_rule_check2}    -a always,exit -F arch=b32 -S chmod,fchmod,fchmodat -F auid>=1000 -F auid!=-1 -F key=perm_mod
    Should Be Equal     ${perm_mod_rule_check3}    -a always,exit -F arch=b64 -S chown,fchown,lchown,fchownat -F auid>=1000 -F auid!=-1 -F key=perm_mod
    Should Be Equal     ${perm_mod_rule_check4}    -a always,exit -F arch=b32 -S lchown,fchown,chown,fchownat -F auid>=1000 -F auid!=-1 -F key=perm_mod
    Should Be Equal     ${perm_mod_rule_check5}    -a always,exit -F arch=b64 -S setxattr,lsetxattr,fsetxattr,removexattr,lremovexattr,fremovexattr -F auid>=1000 -F auid!=-1 -F key=perm_mod
    Should Be Equal     ${perm_mod_rule_check6}    -a always,exit -F arch=b32 -S setxattr,lsetxattr,fsetxattr,removexattr,lremovexattr,fremovexattr -F auid>=1000 -F auid!=-1 -F key=perm_mod
