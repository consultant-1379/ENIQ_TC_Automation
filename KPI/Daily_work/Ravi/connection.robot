*** Settings ***
Library    SSHLibrary
*** Variables ***
${host}    atvts4134.athtem.eei.ericsson.se
${port}    2251
${uname}     dcuser
${pwd}       Dcuser%12

*** Test Cases ***
Open Connection And Log In
    ${index}    Open Connection    ${host}      port=${port}    timeout=10
    Login    ${uname}        ${pwd}
    ${out}    Execute Command    hostname
    Log To Console    {\n}${out}