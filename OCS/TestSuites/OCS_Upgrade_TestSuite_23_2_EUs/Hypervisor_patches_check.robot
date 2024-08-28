*** Settings ***
Library    SSHLibrary
Test Setup    Open Connection    ${HypervisorFQHN}
Test Teardown    Close Connection


*** Variables ***
${HypervisorFQHN}
${HypervisorPassword}


*** Test Cases ***
Hypervisor Patch check
    Login to Citrix Hypervisor
    ${latest_patch}=    Execute Command     xe patch-list | grep name-label | awk '/name-label/ { print $4 }' | sort
    Should Contain      ${latest_patch}    CH82ECU1 
    Should Contain      ${latest_patch}    XS82ECU1001
    Should Contain      ${latest_patch}    XS82ECU1002
    Should Contain      ${latest_patch}    XS82ECU1003
    Should Contain      ${latest_patch}    XS82ECU1004
    Should Contain      ${latest_patch}    XS82ECU1005
    Should Contain      ${latest_patch}    XS82ECU1006
    Should Contain      ${latest_patch}    XS82ECU1007
    Should Contain      ${latest_patch}    XS82ECU1009
    Should Contain      ${latest_patch}    XS82ECU1010
    Should Contain      ${latest_patch}    XS82ECU1012
    Should Contain      ${latest_patch}    XS82ECU1014
	Should Contain      ${latest_patch}    XS82ECU1015
	Should Contain      ${latest_patch}    XS82ECU1016
	Should Contain      ${latest_patch}    XS82ECU1017
	Should Contain      ${latest_patch}    XS82ECU1018
	Should Contain      ${latest_patch}    XS82ECU1019
	Should Contain      ${latest_patch}    XS82ECU1020
	Should Contain      ${latest_patch}    XS82ECU1021
	Should Contain      ${latest_patch}    XS82ECU1022
	Should Contain      ${latest_patch}    XS82ECU1023
	Should Contain      ${latest_patch}    XS82ECU1024
	Should Contain      ${latest_patch}    XS82ECU1026
	Should Contain      ${latest_patch}    XS82ECU1027
	Should Contain      ${latest_patch}    XS82ECU1028
	Should Contain      ${latest_patch}    XS82ECU1029
	Should Contain      ${latest_patch}    XS82ECU1030
	Should Contain      ${latest_patch}    XS82ECU1031
	Should Contain      ${latest_patch}    XS82ECU1032
	Should Contain      ${latest_patch}    XS82ECU1033
	Should Contain      ${latest_patch}    XS82ECU1034
	Should Contain      ${latest_patch}    XS82ECU1036
	Should Contain      ${latest_patch}    XS82ECU1037
	Should Contain      ${latest_patch}    XS82ECU1038
	Should Contain      ${latest_patch}    XS82ECU1039
	Should Contain      ${latest_patch}    XS82ECU1040
	Should Contain      ${latest_patch}    XS82ECU1041
	Should Contain      ${latest_patch}    XS82ECU1042
	Should Contain      ${latest_patch}    XS82ECU1044
	Should Contain      ${latest_patch}    XS82ECU1045
	Should Contain      ${latest_patch}    XS82ECU1046
	Should Contain      ${latest_patch}    XS82ECU1047
	Should Contain      ${latest_patch}    XS82ECU1048
	Should Contain      ${latest_patch}    XS82ECU1049
	Should Contain      ${latest_patch}    XS82ECU1050
	Should Contain      ${latest_patch}    XS82ECU1051
	Should Contain      ${latest_patch}    XS82ECU1052
	Should Contain      ${latest_patch}    XS82ECU1053
	Should Contain      ${latest_patch}    XS82ECU1054
	Should Contain      ${latest_patch}    XS82ECU1055
	Should Contain      ${latest_patch}    XS82ECU1056
	Should Contain      ${latest_patch}    XS82ECU1057
	Should Contain      ${latest_patch}    XS82ECU1059
	Should Contain      ${latest_patch}    XS82ECU1060
	
    log                 ${latest_patch}



*** Keywords ***
Login to Citrix Hypervisor
    Login    root    ${HypervisorPassword}