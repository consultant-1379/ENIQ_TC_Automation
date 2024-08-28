*** Settings ***
Library           OperatingSystem

*** Variables ***

*** Test Cases ***
Checking if Entering into data_collection       
    [Tags]                Counter-Tool
    ${Content}=           Get File                   Enable-Counter-Tool.log
	Set Global Variable   ${Content}
    Should Contain        ${Content}                 Entering data_collection

Checking if Creating required log directories       
    [Tags]             Counter-Tool
    Should Contain     ${Content}                 Creating required log directories

Checking if log directories creation is success      
    [Tags]             Counter-Tool
    Should Contain     ${Content}                 successfully created required log directories

Checking if Creating required configuration files      
    [Tags]             Counter-Tool
    Should Contain     ${Content}                 Creating required configuration files    

Checking if configuration files is success      
    [Tags]             Counter-Tool
    Should Contain     ${Content}                 Successfully created required configuration files

Checking if Enabling Request Level Logging      
    [Tags]             Counter-Tool
    Should Contain     ${Content}                 Enabling Request Level Logging 

Checking if parameters are updated      
    [Tags]             Counter-Tool
    Should Contain     ${Content}                 Updated parameters in /eniq/database/dwh_reader/dwhdb.cfg file   

Checking if Successfully enabled Request Level Logging      
    [Tags]             Counter-Tool
    Should Contain     ${Content}                 Successfully enabled Request Level Logging

Checking if master cron entry for counter tool has been added successfully in crontab      
    [Tags]             Counter-Tool
    Should Contain     ${Content}                 master cron entry for counter tool has been added successfully in crontab


Checking if RLL monitor cron entry for counter tool has been added successfully in crontab     
    [Tags]             Counter-Tool
    Should Contain     ${Content}                 RLL monitor cron entry for counter tool has been added successfully in crontab

Checking if Successfully completed data_collection     
    [Tags]             Counter-Tool
    Should Contain     ${Content}                 Successfully completed data_collection
