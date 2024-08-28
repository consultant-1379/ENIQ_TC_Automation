*** Settings ***
Documentation    Testing symboliclinkcreator
Library           SSHLibrary
Library        String
Library        Collections
Resource    ../../Resources/Keywords/Engine.robot
Resource    ../../Resources/Keywords/Variables.robot
Resource    ../../Resources/Keywords/Cli.robot
Test Teardown    Close All Connections

*** Variables ***
@{pass}    

*** Test Cases ***
Check for physical Symboliclinkcreator_eniq_oss common file is presence in the EINQ-S and Check for error or exception in Symboliclinkcreator common file
    Connect to server as a dcuser
    Execute the Command    cd ${symboliclinkcreator}
    ${latest}=    Get latest file from directory     symboliclinkcreator_eniq_oss_*.log
    ${latest}    Split String    ${latest}
    Log To Console    ${latest}
    ${Verify}    ${rc}    Execute Command    cd ${symboliclinkcreator} && cat ${latest}[0] | grep -iE "fail\|error\|exception\|could not\|not enabled\|disabled\|not found\|indir not found"    return_rc=true
      IF    ${rc}==0
        @{pass}    Split To Lines    ${Verify}  
        ${length}    Get Length    ${pass}
        FOR    ${element}    IN    @{pass}
            Log    ${element}
            Should Contain    ${element}    FileAlreadyExistsException
    
        END

    END 