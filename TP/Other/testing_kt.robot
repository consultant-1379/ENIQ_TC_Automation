*** Settings ***
Library           RPA.Browser.Selenium
Library           String
Resource          ../Resources/login.resource
Library           ../TestCases/server.py
Test Setup        Open Connection And Log In
Test Teardown     Close All Connections 
*** Variables ***
${url}            https://clearcase-eniq.seli.wh.rnd.internal.ericsson.com/eniqdel
${str}            Aug  1 2022  9:45:15.000000AM \r\nAug  1 2022  9:45:15.000000AM \r\n\n(2 rows affected)\neniqs[eniq_stats] {dcuser} #:
*** Tasks ***
getting the R-State of the mentioned package
   Write    cd eniq/home/dcuser