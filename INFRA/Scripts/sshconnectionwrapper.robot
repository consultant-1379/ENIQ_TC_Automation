*** Settings ***
Library    SSHLibrary

*** Keywords ***
open terminal and login
    [Arguments]    ${hostname}    ${user}    ${password}          
    Open Connection    ${hostname}    port=22    alias=remote_login_1    prompt=#    width=250000    height=250000000
    Login    ${user}    ${password}    delay=1   
