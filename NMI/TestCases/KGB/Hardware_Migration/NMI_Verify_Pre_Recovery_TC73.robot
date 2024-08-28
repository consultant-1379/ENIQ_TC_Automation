*** Settings ***
Library           OperatingSystem

*** Variables ***

*** Test Cases ***

Checking if pre recovery started successfully
    [Tags]                    Blade Migration
    ${Pre_Recovery}=          Get File                        Pre-Recovery.log
    Set Global Variable       ${Pre_Recovery} 
    Should Contain            ${Pre_Recovery}                 Starting prerecovery activity on 
	
ENIQ services need to be stopped before recovery
    [Tags]             Blade Migration    
    Should Contain     ${Pre_Recovery}                 Stopping the ENIQ services on
	
Copying necessary storage and pool information
    [Tags]             Blade Migration    
    Should Contain     ${Pre_Recovery}                 Copying SAN device type in

Determining number of SAN connected
    [Tags]             Blade Migration    
    Should Contain     ${Pre_Recovery}                 Determining number of SAN connected
	
Exporting pool(s) during prerecovery
    [Tags]             Blade Migration    
    Should Contain     ${Pre_Recovery}                 Exporting following pools:

Checking if all pools have been exported
    [Tags]             Blade Migration    
    Should Contain     ${Pre_Recovery}                 All pools have been exported.
	
Disconnecting Storage
    [Tags]             Blade Migration    
    Should Contain     ${Pre_Recovery}                 Successfully disconnected SAN for

Checking if pre rollback is successfully completed
    [Tags]             Blade Migration    
    Should Contain     ${Pre_Recovery}                 Successfully completed Preparation phase
