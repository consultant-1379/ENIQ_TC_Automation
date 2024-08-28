***Settings ***
Variables    ../Resources/Variables/Variables.py
Library    SSHLibrary
Test Setup    Login to eniq
Test Teardown    Close All Connections
*** Keywords ***
Login to eniq
    Open Connection    ${hostname}
    Login    ${username}    ${password}    delay=1
*** Test Cases ***
Check for partition
    ${output}=    Execute Command    dmidecode -t system | grep -w 'Product Name' | cut -d ':' -f2 | cut -d ' ' -f4,5
    Log To Console    ${output}
    IF    "${output}"=="Gen10 Plus"

        ${output1}=    Execute Command    df -h|grep /
        Should Not Be Empty    ${output1}





    ELSE
        ${output1}=    Execute Command    df -h|grep /
        Should Not Be Empty    ${output1}


    END

