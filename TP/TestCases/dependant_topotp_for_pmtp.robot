*** Settings ***
Library    SSHLibrary
Library    String
Resource    ../Resources/login.resource
Library     ./server.py
Library    RPA.Browser.Selenium
Library    String
Test Setup        Open Connection And Log In
Test Teardown     Close All Connections  


*** Test Cases ***
Tasks to be perform
    Check topotp for pmtp

*** Keywords ***
Check topotp for pmtp
    check the dependent topotp
    FOR    ${pkg}    IN    ${deptopopkg}
        Write    echo -e "select TECHPACK_VERSION from Versioning where TECHPACK_NAME='${pkg}[0]'\\n${run}\\n" | isql -P ${password_db} -U ${username} -S ${database} -b
        ${output1}=    Read    delay=3s
        Log To Console    ${output1}
        ${rstate_adminui}=    Filter Name    ${output1}
        Open clearcasevobs
        ${rstate_vobs}    Get Text    //table//a[text()='${pkg}[0]']/../following-sibling::td[3]
        Log To Console    ${\n}R-State of ${pkg} is = ${rstate_vobs}
        IF    '${rstate_vobs}' != '${rstate_adminui}'
            Log To Console    not equal
            Downloading TP from vobs    ${pkg}[0]
            Installing TP    ${pkg}[0]
        ELSE
           Log To Console    equal
        END
        Close All Browsers
        Write    cd /eniq/sw/installer ; ./activate_interface -o eniq_oss_1 -t ${pkg}[0]
        Read       delay=300s
    END