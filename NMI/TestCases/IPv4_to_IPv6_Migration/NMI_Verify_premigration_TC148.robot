*** Settings ***
Library           OperatingSystem
 
*** Test Cases ***
Checking if ipv6 premigration stage - get_user_input is entered successfully
   [Tags]                Ipv6 Premigration  SB/MB
   ${IPv6_premigration_log}=         Get File                  IPv6_premigration.log
   Set Global Variable   ${IPv6_premigration_log}
   Should Contain        ${IPv6_premigration_log}              Entering ENIQ IPV6 Migration stage - get_user_input

Checking if ipv6 premigration stage - pre_checks is entered successfully
   [Tags]                Ipv6 Premigration  SB/MB
   Should Contain        ${IPv6_premigration_log}              Entering ENIQ IPV6 Premigration stage - pre_checks
   
Checking if ipv6 premigration stage - create_snapshots is entered successfully
   [Tags]                Ipv6 Premigration  SB/MB
   Should Contain        ${IPv6_premigration_log}              Entering ENIQ IPV6 Premigration stage - create_snapshots
   
Checking if ipv6 premigration stage - stop_all_services is entered successfully
   [Tags]                Ipv6 Premigration  SB/MB
   Should Contain        ${IPv6_premigration_log}              Entering ENIQ IPV6 premigration stage - stop_all_services
   
Checking if ipv6 premigration stage - cleanup is entered successfully
   [Tags]                Ipv6 Premigration  SB/MB
   Should Contain        ${IPv6_premigration_log}              Entering ENIQ IPV6 premigration stage - cleanup
   
Checking if ipv6 premigration stage - get_user_input is completed successfully
   [Tags]                Ipv6 Premigration  SB/MB
   Should Contain        ${IPv6_premigration_log}              Successfully completed - get_user_input

Checking if ipv6 premigration stage - pre_checks is completed successfully
   [Tags]                Ipv6 Premigration  SB/MB
   Should Contain        ${IPv6_premigration_log}              Successfully completed - pre_checks
   
Checking if ipv6 premigration stage - create_snapshots is completed successfully
   [Tags]                Ipv6 Premigration  SB/MB
   Should Contain        ${IPv6_premigration_log}              Successfully completed - create_snapshots 
   
Checking if ipv6 premigration stage - stop_all_services is completed successfully
   [Tags]                Ipv6 Premigration  SB/MB
   Should Contain        ${IPv6_premigration_log}              Successfully completed - stop_all_services
   
Checking if ipv6 premigration stage - cleanup is completed successfully
   [Tags]                Ipv6 Premigration  SB/MB
   Should Contain        ${IPv6_premigration_log}              Successfully completed the cleanup
