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
Check for Boot Mode
    ${output}=    Execute Command    dmidecode -t system | grep -w 'Product Name' | cut -d ':' -f2 | cut -d ' ' -f4,5
    Log To Console    ${output}
    IF    "${output}"=="Gen10 Plus"   
        ${output1}=    Execute Command    df -h|grep /var
        Should Not Be Empty    ${output1}

        ${output2}=    Execute Command    df -h|grep /boot
        Should Not Be Empty    ${output2}

        ${output3}=    Execute Command    df -h|grep /
        Should Not Be Empty    ${output3}

        ${output4}=    Execute Command    df -h|grep /JUMP
        Should Be Empty    ${output4}

        ${output5}=    Execute Command    df -h|grep /boot/efi
        Should Not Be Empty    ${output5}

        
    ELSE
        ${output1}=    Execute Command    df -h|grep /var
        Should Not Be Empty    ${output1}

        ${output2}=    Execute Command    df -h|grep /boot
        Should Not Be Empty    ${output2}

        ${output3}=    Execute Command    df -h|grep /
        Should Not Be Empty    ${output3}


    END

