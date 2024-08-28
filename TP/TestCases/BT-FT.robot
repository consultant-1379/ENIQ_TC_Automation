
*** Settings ***
Library           RPA.Browser.Selenium
Library           OperatingSystem
Library           ./server.py
Resource    ../Resources/login.resource

*** Variables ***
${url}            ${urlNexusConst}/TP_KPI_Script/
*** Test Cases ***
Test SSH Connection
    ${user}=    Get Environment Variable    UserProfile
    Set Download Directory    H:\\Downloads
    Open Available Browser    ${url}
    ${latestBt_Ft}    Get Text    //*[contains(text(),'BT_FT_')]
    Go To    ${url}${latestBt_Ft}
    server.Transfer To Server   ${latestBt_Ft}    ${host}    ${uname}    ${pwd}