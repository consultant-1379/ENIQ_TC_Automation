*** Settings ***
Library    RPA.Browser.Selenium
Library    ODBC.py

*** Variables ***
${server_name}     atvts4134.athtem.eei.ericsson.se
*** Test Cases ***
testcase on odbc Connection
    Odbc Start     ${server_name}