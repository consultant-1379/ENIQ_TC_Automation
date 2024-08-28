*** Settings ***
Resource    ../../Resources/login.resource
Library    RPA.RobotLogListener
Test Setup        Open Connection And Log In
Test Teardown     Close All Connections  
Library    ../TestCases/server.py

*** Variables ***


*** Test Cases ***
Downloading TPI File
    Open clearcasevobs
    getting the R-State of the mentioned package
    verification of r-state of fd in nexus and vobs

*** Keywords ***
 verification of r-state of fd in nexus and vobs
    ${repo}    Fetch From Right  ${pkg}    _
    ${etl}    Convert To Lower Case  ${repo}
    ${etlnew}    Catenate     SEPARATOR=_      ${etl}      etl
    ${urlNexus}    Catenate    SEPARATOR=/    ${urlNexusConst}    ${repo}    ${etlnew}    FD    ${rstate}
    Go To    ${urlNexus}
    ${notValidation}    Does Page Contain    404
    IF    ${notValidation} == False
          Log To Console     This ${rstate} is present
    ELSE
          Log To Console     This ${rstate} is not present
          Downloading TP from vobs    ${pkg}
    END
 