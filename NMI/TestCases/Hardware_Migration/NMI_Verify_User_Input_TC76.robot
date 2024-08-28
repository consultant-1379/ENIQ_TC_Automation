*** Settings ***
Library           OperatingSystem

*** Variables ***

*** Test Cases ***

Checking if Migration config file already created.
    [Tags]             Blade  Migration
    ${Pre_Blade_Migration}=    Get File                       Pre-Migration.log
    Set Global Variable        ${Pre_Blade_Migration} 
    Should Contain     ${Pre_Blade_Migration}                 Migration config file already created.

Displaying Migration Config Details.
    [Tags]             Blade  Migration    
    Should Contain     ${Pre_Blade_Migration}                 Migration Config Details	

Checking if IMPORTANT information for Migration backup server IP address is successfully displayed
    [Tags]             Blade  Migration    
    Should Contain     ${Pre_Blade_Migration}                 Migration backup server IP address
	
Checking if IMPORTANT information for Directory path of Migration backup is successfully displayed
    [Tags]             Blade  Migration    
    Should Contain     ${Pre_Blade_Migration}                 Directory path of Migration backup
