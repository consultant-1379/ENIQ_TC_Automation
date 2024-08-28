*** Settings ***
Documentation       Testing AdminUI web

Library             RPA.Browser.Selenium
Library             DateTime
Library             String
Library             SSHLibrary
Resource            ../../Resources/Keywords/Cli.robot
Resource            ../../Resources/Keywords/Variables.robot
Resource            ../../Resources/Keywords/AdminUIWebUI.robot

Suite Setup         Create connection
Suite Teardown      Close All Connections


*** Variables ***
${SERVER}    atvts4150
${Host_name}        ${SERVER}.athtem.eei.ericsson.se
${port_number}      2251
${user_name}        dcuser
${password}         Dcuser%12


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


Verify the password expiry section for displaying no. of days left for expiry of adminui user password under system status page
    Open connection    ${host_name}    port=${port_number}
    Login    ${user_name}    ${password}
    Open Available Browser   https://${Host_name}:8443/adminui/    options=set_capability("acceptInsecureCerts", True)
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
  
*** Keywords ***
Create connection
    Open Connection
    ...    ${SERVER}.athtem.eei.ericsson.se
    ...    port=2251
    ...    timeout=100s
    ...    prompt=eniqs[eniq_stats] {dcuser} #:
    Login    dcuser    Dcuser%12

Generate Random username and password
    ${username}    Generate Random String    5    [LETTERS]
    ${password}    Generate Random String    8-15    [LETTERS][NUMBERS]
    # ${has_number}=    Run Keyword And Return Status    Should Contain Any    ${password}    0123456789
    # Run Keyword If    not ${has_number}    Generate Random username and password
    RETURN    ${username}    ${password}
