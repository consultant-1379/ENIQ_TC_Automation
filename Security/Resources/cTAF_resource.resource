*** Settings ***
Library            SSHLibrary  10 seconds

*** Variables ***
${host}             ieatrcxb6083
${username}         root
${password}         Batman@1234
${port}             22
${user}             adminuser
${pwd}              Batman%1234

*** Comments ***
Do not edit  above variable unless you know the impacts.

*** Keywords ***
Open Connection and SSH Login
    Open Connection    ${host}    port=${port}
    Login    ${username}    ${password}    delay=1
Open Connection and SSH Login for root dependency
    Open Connection    ${host}    port=${port}
    Login    ${user}    ${pwd}    delay=1