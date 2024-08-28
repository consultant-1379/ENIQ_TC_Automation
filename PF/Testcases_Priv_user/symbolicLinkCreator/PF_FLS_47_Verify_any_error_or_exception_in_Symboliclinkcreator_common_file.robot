*** Settings ***
Documentation    Testing symboliclinkcreator
Library           SSHLibrary
Library        String
Library        Collections
Resource    ../../Resources/Keywords/Engine.robot
Resource    ../../Resources/Keywords/Variables.robot
Resource    ../../Resources/Keywords/Cli.robot
Test Teardown    Close All Connections

*** Test Cases ***
Check for physical Symboliclinkcreator common file is presence in the EINQ-S and Check for error or exception in Symboliclinkcreator common file
    Open connection as root user
    Write    sudo su - dcuser
    Read    delay=1s
    Write    ssh engine
    Read    delay=1s
    Execute the Command    cd ${symboliclinkcreator}
    ${latest}=    Get latest file from directory     symboliclinkcreator-*.log
    ${latest}    Split String    ${latest}
    Log To Console    ${latest}
    ${Verify}    ${rc}    Execute Command   cd ${symboliclinkcreator} && cat ${latest}[0] | grep -iE "fail\|err\|exception\|could not\|not enabled\|disable\|not found"    return_rc=true
    IF    ${rc}==0
        Fail    Failing the testcase, since log has "fail/error/exception/not found etc" negative word in log file
    ELSE
        Log    Passing the testcase, since there is no "fail/error/exception/not found etc" negative words in log file
    END  