*** Settings ***
Library           OperatingSystem

*** Variables ***

*** Test Cases ***
Checking if Entering disable_logging      
    [Tags]                Counter-Tool
    ${Content}=           Get File                   Disable-Counter-Tool.log
    Set Global Variable   ${Content}
    Should Contain        ${Content}                 Entering disable_logging

Checking disabling of Request Level Logging       
    [Tags]             Counter-Tool
    Should Contain     ${Content}                 Disabling Request Level Logging

Checking if parameters are updated 
    [Tags]             Counter-Tool
    Should Contain     ${Content}                 Updated parameters in /eniq/database/dwh_reader/dwhdb.cfg

Checking if Request Level Logging is disabled    
    [Tags]             Counter-Tool
    Should Contain     ${Content}                 Successfully disabled Request Level Logging    

Checking if removal of master cron is successfully completed    
    [Tags]             Counter-Tool
    Should Contain     ${Content}                 master cron entry for counter statistics tool has been removed successfully from crontab

Checking if removal of RLL monitor cron is successfully completed    
    [Tags]             Counter-Tool
    Should Contain     ${Content}                 RLL monitor cron entry for counter statistics tool has been removed successfully from crontab

Checking if Logging is disabled      
    [Tags]             Counter-Tool
    Should Contain     ${Content}                 Successfully completed disable_logging
