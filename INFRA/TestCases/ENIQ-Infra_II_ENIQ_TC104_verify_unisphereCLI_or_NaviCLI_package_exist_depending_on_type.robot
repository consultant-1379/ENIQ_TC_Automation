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
    ${output1}=    Execute Command    cat /eniq/installation/config/SunOS.ini | grep -w "SAN_DEVICE"

    Log To Console    ${output}
    IF    "${output}"=="Gen8"
        Log To Console    ${output1}
        IF    "${output1}"=="SAN_DEVICE=vnx"
            ${output2}=    Execute Command    rpm -qa|grep NaviCLI-Linux-64
            Should Be Empty    ${output2}


        ELSE IF    "${output1}"!="SAN_DEVICE="
            ${output4}=    Execute Command     rpm -qa|grep UnisphereCLI
            Should Be Empty    ${output4}
        END


    ELSE
        IF    "${output1}"=="SAN_DEVICE=vnx"
            ${output5}=    Execute Command    rpm -qa|grep NaviCLI-Linux-64
            Should Not Be Empty    ${output5}


        ELSE IF    "${output1}"!="SAN_DEVICE="
            ${output6}=    Execute Command     rpm -qa|grep UnisphereCLI
            Should Not Be Empty    ${output6}
        END



    END
