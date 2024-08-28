*** Settings ***
Library             String
Library             SSHLibrary
Resource            ../../Resources/Keywords/Cli.robot
Resource            ../../Resources/Keywords/Variables.robot
Library    RPA.Browser.Selenium
Library    Collections

Suite Setup         Create connection
Suite Teardown      Close All Connections


*** Variables ***
${SERVER}           atvts4150
${host_123}         ${SERVER}.athtem.eei.ericsson.se
# ${port_for_vapp}    2251


*** Test Cases ***
TC 21 Verifying tomcat_user.xml and tomcat_users_history.properties files when the new user has been created
    ${new_user}    ${new_pass}    Generate Random username and password
    Set suite Variable    ${new_user}
    Set suite Variable    ${new_pass}
    Write
    ...    date +"%Y%m%d%H%M%S"; echo -e "${new_user}\\n${new_pass}\\n"| /eniq/sw/installer/manage_tomcat_user.bsh -A ADD_USER
    ${out}    Read Until Prompt    strip_prompt=True
    IF    'successfully' in '''${out}'''
        ${timestamp}    Get Regexp Matches    ${out}    \\d+
        ${decryp_pass}    Execute Command
        ...    cat /eniq/sw/runtime/apache-tomcat*/conf/tomcat-users.xml | grep -oP '<user username="${new_user}".*?/>' | grep -oP 'password="{ENCRYPTION}\\K[^"]+'
        ${history_file_verify}    ${rc}    Execute Command
        ...    cat /eniq/sw/runtime/tomcat/conf/tomcat_users_history.properties | grep -i "${new_user}" | grep -i ${timestamp}[0]
        ...    return_rc=True
        IF    '${rc}' == '0'
            Log To Console    History file verified and usename and timestamp is matching.
        ELSE
            Fail    Error, timestamp mismatch. Verify the files.
        END
    ELSE
        Fail    Error while creating new user, below is the output${\n}${decryp_pass}
    END

TC 01 Verify the password expiry section for displaying no. of days left for expiry of adminui user password under system status page
    Open Available Browser   https://${host_123}:8443/adminui/    options=set_capability("acceptInsecureCerts", True)
    Wait Until Page Contains Element    //*[@id="username"]    timeout=100s
    Input Text        //*[@id="username"]    ${new_user}
    Input Password    //*[@id="password"]    ${new_pass}
    Click Button      //*[@id="submit"]
    ${pass_msg}    Get Text    //*[contains(text(),'Password will expire')]
    ${days}    Get Regexp Matches    ${pass_msg}    \\d+
    IF    ${days}[0] > 14
        ${color}    Get Element Attribute    (//img)[last()]    alt
        IF    '${color}'== 'Green'
            Log    Green Color is present
        ELSE
            Fail    ${color} is present
        END 
    END        
    IF   ${days}[0] < 7 
         ${color}    Get Element Attribute    (//img)[last()]    alt
        IF    '${color}'== 'Red'
            Log    Red Color is present
        ELSE
            Fail    ${color} is present
        END       
    END
    IF   7 < ${days}[0] < 14 
         ${color}    Get Element Attribute    (//img)[last()]    alt
        IF    '${color}'== 'Yellow'
            Log    Yellow Color is present
        ELSE
            Fail    ${color} is present
        END       
    END
TC 05 Verify login failure details in adminuistatus.log when adminui user password is expired
    ${users}    Execute Command     cat /eniq/sw/runtime/apache-tomcat*/conf/tomcat-users.xml | grep -oP '<user username="\\K[^"]+'
    ${users}    Split String    ${users}
    ${expired_users}    Create List
    FOR    ${user}    IN    @{users}
        Write    echo -e "${user}\\n"| /eniq/sw/installer/manage_tomcat_user.bsh -A PASSWORD_EXPIRY
        ${out2}    Read Until Prompt    strip_prompt=True
        IF    'already expired' in '''${out2}'''
            Append To List    ${expired_users}    ${user}
        END
    END
    ${length}    Get Length    ${expired_users}
    IF    not ${length} == 0
        FOR    ${user}    IN    @{expired_users}
            ${encryp_pass}    Execute Command    cat /eniq/sw/runtime/apache-tomcat*/conf/tomcat-users.xml | grep -oP '<user username="${user}".*?/>' | grep -oP 'password="{ENCRYPTION}\\K[^"]+'
            ${decr_pwd}    Execute Command   bash /eniq/sw/platform/repository*/bin/EncryptDecryptUtility.sh -d ${encryp_pass}
            Open Available Browser    https://${host_123}:8443/adminui/    options=set_capability("acceptInsecureCerts", True)             
            Wait Until Page Contains Element    //*[@id="username"]    timeout=100s     
            Input Text     //*[@id="username"]    ${user}
            Input Password     //*[@id="password"]    ${decr_pwd}
            Click Button     //*[@id="submit"]
            Capture Page Screenshot    embed=True
            Close Browser
        END
    ELSE
        Log    No users password is expired. Passing the test-case
    END

TC 24 Verify by changing the new user password multiple times.
    FOR    ${i}    IN RANGE    0    4    
        ${temp_user}    ${temp_pass}    Generate Random username and password
        ${encryp_pass}    Execute Command    cat /eniq/sw/runtime/apache-tomcat*/conf/tomcat-users.xml | grep -oP '<user username="${new_user}".*?/>' | grep -oP 'password="{ENCRYPTION}\\K[^"]+'

        ${existing_pass}    Execute Command    bash /eniq/sw/platform/repository*/bin/EncryptDecryptUtility.sh -d ${encryp_pass}
        
        Write    echo -e "${new_user}\\n${existing_pass}\\n${temp_pass}\\n"| /eniq/sw/installer/manage_tomcat_user.bsh -A CHANGE_PASSWORD
        ${out2}    Read Until Prompt    strip_prompt=True
    END

    IF    'successfully' in '''${out2}'''
        ${output}    Execute Command    cat /eniq/sw/runtime/tomcat/conf/tomcat_users_history.properties| grep "${new_user} " | grep -i '${new_pass}'
        IF    not '''${output}'''=='${EMPTY}'
            Fail    First password is present in the history file, even after changing the password 4 times.
        ELSE
            Log    First password is not present in history.properties file.${\n}Hence passing the Test-case.
        END

    END


TC 26 Verify by changing the default user password multiple times.
    ${new_user}    ${new_pass}    Generate Random username and password

    ${def_encryp_pass}    Execute Command    cat /eniq/sw/runtime/apache-tomcat*/conf/tomcat-users.xml | grep -oP '<user username="eniq".*?/>' | grep -oP 'password="{ENCRYPTION}\\K[^"]+'

    ${def_pass}    Execute Command    cat /eniq/sw/runtime/tomcat/conf/tomcat_users_history.properties| grep "eniq "

    IF    '''${def_pass}''' =='${EMPTY}'
        Write    echo -e "eniq\\n${new_pass}\\n"| /eniq/sw/installer/manage_tomcat_user.bsh -A CHANGE_PASSWORD
        ${out}    Read Until Prompt    strip_prompt=True
    END

    FOR    ${i}    IN RANGE    0    5    
        ${new_user}    ${temp_pass}    Generate Random username and password
        ${encryp_pass}    Execute Command    cat /eniq/sw/runtime/apache-tomcat*/conf/tomcat-users.xml | grep -oP '<user username="eniq".*?/>' | grep -oP 'password="{ENCRYPTION}\\K[^"]+'

        ${existing_pass}    Execute Command    bash /eniq/sw/platform/repository*/bin/EncryptDecryptUtility.sh -d ${encryp_pass}
        
        Write    echo -e "eniq\\n${existing_pass}\\n${temp_pass}\\n"| /eniq/sw/installer/manage_tomcat_user.bsh -A CHANGE_PASSWORD
        ${out2}    Read Until Prompt    strip_prompt=True
    END

    IF    'successfully' in '''${out2}'''
        ${output}    Execute Command    cat /eniq/sw/runtime/tomcat/conf/tomcat_users_history.properties| grep "eniq " | grep -i '${def_encryp_pass}'
        IF    not '''${output}'''=='${EMPTY}'
            Fail    First password is present in the history file, even after changing the password 4 times.
        ELSE
            Log    First password is not present in history.properties file.${\n}Hence passing the Test-case.
        END

    END


*** Keywords ***
Create connection
    # Open Connection
    # ...    ${SERVER}.athtem.eei.ericsson.se
    # ...    port=2251
    # ...    timeout=100s
    # Login    dcuser    Dcuser%12
    # Set Client Configuration    30    prompt=REGEXP:${SERVER}\\[\\S+\\]\\s{\\w+}\\s#
    Connect to physical server
Generate Random username and password
    ${username}    Generate Random String    5    [LETTERS]
    ${password}    Generate Random String    8-15    [LETTERS][NUMBERS]
    # ${has_number}=    Run Keyword And Return Status    Should Contain Any    ${password}    0123456789
    # Run Keyword If    not ${has_number}    Generate Random username and password
    RETURN    ${username}    ${password}
