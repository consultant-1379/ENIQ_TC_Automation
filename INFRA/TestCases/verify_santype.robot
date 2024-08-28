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
Check for packages
    ${output}=    Execute Command    cat /eniq/installation/config/SunOS.ini | grep -w "SAN_DEVICE" | awk -F"=" '{print $2}'
    Log To Console    ${output}
    IF    "${output}"=="unity"
        
        
        ${output1}=    Execute Command    rpm -qa|grep HostAgent
        Log To Console    ${output1}
        Should Not Be Empty    ${output1}

      
        ${output2}=    Execute Command    rpm -qa|grep NaviCLI
        Log To Console    ${output2}
        Should Not Be Empty    ${output2}

        
        ${output3}=    Execute Command    rpm -qa|grep InitTool
        Log To Console    ${output3}
        Should Be Empty    ${output3}

    ELSE
        
        
        ${output4}=    Execute Command    rpm -qa|grep UnisphereCLI
        Should Not Be Empty    ${output4}
    END
