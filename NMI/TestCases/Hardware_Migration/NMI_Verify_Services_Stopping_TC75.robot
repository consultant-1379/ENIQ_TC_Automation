*** Settings ***
Library           OperatingSystem

*** Test Cases ***
All ENIQ service state should be disabled after pre-migration
    [Tags]             Migration
    ${Content}=        Get File                   Pre-Migration.log
    Should Contain     ${Content}                 ENIQ services stopped correctly
