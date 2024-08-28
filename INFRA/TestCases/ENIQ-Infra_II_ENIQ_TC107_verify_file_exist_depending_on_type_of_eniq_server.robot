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
    IF    "${output}"=="Gen8"
        ${output1}=    Execute Command    cat /eniq/installation/config/SunOS.ini | grep -w "SAN_DEVICE"
        Log To Console    ${output1}
        IF    "${output1}"=="SAN_DEVICE=vnx"
            ${output2}=    Execute Command    ls -lrt /ericsson/storage/san/plugins/vnx/etc | grep 'clariion.conf'
            Should Be Empty    ${output2}
        
        ELSE IF    "${output1}"!="SAN_DEVICE="
            ${output3}=    Execute Command     ls -lrt /ericsson/storage/san/plugins/unity/etc/ | grep "unity.conf"
            Should Be Empty    ${output3}
        END
    ELSE 
        ${output4}=    Execute Command    cat /eniq/installation/config/SunOS.ini | grep -w "SAN_DEVICE"
        Log To Console    ${output4}
        IF    "${output4}"=="SAN_DEVICE=vnx"
            ${output5}=    Execute Command    ls -lrt /ericsson/storage/san/plugins/vnx/etc | grep 'clariion.conf'
            Should Not Be Empty    ${output5}

        ELSE IF    "${output4}"!="SAN_DEVICE="
            ${output6}=    Execute Command     ls -lrt /ericsson/storage/san/plugins/unity/etc/ | grep "unity.conf"
            Should Not Be Empty    ${output6}
        END


    END
