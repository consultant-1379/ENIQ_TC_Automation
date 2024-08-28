*** Settings ***
Suite Setup        Open Connection And Log In
Suite Teardown     Close All Connections
Library            SSHLibrary
Resource           ../../Resources/resource.txt

*** Variables ***

*** Test Cases ***
Checking sybase_iq version is same for ENIQ server and MWS server.
    [Tags]                         sybase_iq
    Open Connection                ${host}        port=${PORT}
    Login                          ${username}    ${password}    delay=1
    Log To Console                 Connected to server ${host}:${p}
    Set Client Configuration       timeout=25 seconds      prompt=#:
    ${mws_hostname}=                Execute Command         cat /eniq/installation/config/eniq_sw_locate | awk -F"@" '{print $1}'
    ${output1}=                     Execute Command         cat /eniq/sybase_iq/version/iq_version | grep "VERSION::"
    ${output2}=                     Execute Command         tar -xzof /net/${mws_hostname}/JUMP/ENIQ_STATS/ENIQ_STATS/${shipment}/eniq_base_sw/applications/sybase_iq/common/sw/x86_64/sybase_iq.tar.gz ; grep "VERSION::" version/iq_version
    Should Be Equal                ${output1}               ${output2}

Checking sybase_iq ESD package version is same for ENIQ server and MWS server.
    [Tags]                         sybase_iq
    Open Connection                ${host}        port=${PORT}
    Login                          ${username}    ${password}    delay=1
    Log To Console                 Connected to server ${host}:${p}
    Set Client Configuration       timeout=25 seconds      prompt=#:
    ${mws_hostname}=                Execute Command         cat /eniq/installation/config/eniq_sw_locate | awk -F"@" '{print $1}'
    ${output1}=                     Execute Command         cat /eniq/sybase_iq/version/iq_version | grep "ESD::"
    ${output2}=                     Execute Command         tar -xzof /net/${mws_hostname}/JUMP/ENIQ_STATS/ENIQ_STATS/${shipment}/eniq_base_sw/applications/sybase_iq/common/sw/x86_64/sybase_iq.tar.gz ; grep "ESD::" version/iq_version
    Should Be Equal                ${output1}               ${output2}

