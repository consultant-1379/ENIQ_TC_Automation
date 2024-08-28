*** Settings ***
Library           OperatingSystem

*** Variables ***

*** Test Cases ***
Checking if no passwords are visible during DBCC run or not
    [Tags]             		Password
    ${Content}=        		Get File                   DBCC.log
    Should Not Contain     	${Content}                 Dba@123
