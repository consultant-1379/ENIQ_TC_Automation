*** Settings ***
Force Tags    suite
Library    SSHLibrary
Library    String
Resource    ../../Resources/Keywords/Cli.robot
Resource    ../../Resources/Keywords/Variables.robot
Resource    ../../Resources/Keywords/symboliclinkcreator_FLS_keywords.robot

*** Test Cases *** 
Check that when disable_OSS file exists , FLS to be on HOLD for a particular oss alias
    [Tags]    FLS
    Connect to server as a dcuser
    Verification of FLS status when disable_OSS file Exists
    


*** Keywords ***
Verification of FLS status when disable_OSS file Exists
    symboliclinkcreator_FLS_keywords.Go to the folder   cd ${mount}
    ${output}=    symboliclinkcreator_FLS_keywords.List the files in the folder    ${ls}
    Verifying of FLS status to be ONHold when disable_OSS file Exists    ${output}
    [Teardown]    Test teardown

    
Test teardown
    Close Connection  


    
    