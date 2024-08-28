*** Settings ***
Library    SSHLibrary
Resource    ../../Resources/Keywords/Engine.robot
Resource     ../../Resources/Keywords/Variables.robot
Resource     ../../Resources/Keywords/Cli.robot
Library     ../../Scripts/random_generating_password.py



*** Test Cases ***
Verify the root user change verification.
    Open connection as root user
    ${random_password_generated}=    random_generating_complaint_passwords
    Log To Console    ${random_password_generated}
    Execute the Command    passwd
    Execute the Command    ${random_password_generated}
    ${pass_01}=    Execute the Command    ${random_password_generated}
    Verify the msg    ${pass_01}    updated successfully
    #Reverting back to old password
    Execute the Command    passwd
    Execute the Command    ${root_pwd}
    ${reverting_02}=    Execute the Command    ${root_pwd}
    Verify the msg    ${reverting_02}    updated successfully

*** Keywords ***  
Test teardown
    Close Connection 




