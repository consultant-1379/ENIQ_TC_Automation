*** Settings ***
Resource    ../../Resources/login.resource
Library    RPA.RobotLogListener
Test Setup        Open Connection And Log In
Test Teardown     Close All Connections  
Library    ../TestCases/server.py
*** Tasks ***
getting the R-State of the mentioned package
    Open clearcasevobs
    ${rstate}    Get Text    //table//a[text()=${package}]/../following-sibling::td[3]
    #Log To Console    ${\n}R-State of ${Package} is = ${rstate}
    ${repo}    Fetch From Right  ${pkg}  ${arg2}
    ${etl}    Convert To Lower Case  ${repo}
    ${etlnew}    Catenate     SEPARATOR=_      ${etl}      etl
    ${urlNexus}    Catenate    SEPARATOR=/    ${urlNexusConst}    ${repo}    ${etlnew}    FD    ${rstate}
    Go To    ${urlNexus}
    ${notValidation}    Does Page Contain    404
    IF    ${notValidation} == False
          Log To Console     This ${rstate} is present
    ELSE
          Log To Console     This ${rstate} is not present
    END