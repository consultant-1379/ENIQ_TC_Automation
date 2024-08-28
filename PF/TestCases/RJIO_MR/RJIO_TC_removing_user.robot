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
Verify if we are removing a user, then is it getting removed or not from history.properties file
     ${new_user}    ${new_pass}    Generate Random username and password
    Set suite Variable    ${new_user}
    Set suite Variable    ${new_pass}
    ${USER}    Set Local Variable    ${new_user}   
    Write     echo -e "${new_user}\\n${new_pass}\\n"| /eniq/sw/installer/manage_tomcat_user.bsh -A ADD_USER
    ${out}    Read Until Prompt    strip_prompt=True
    Write    echo -e "${new_user}\\n${new_pass}\\n"| /eniq/sw/installer/manage_tomcat_user.bsh -A REMOVE_USER
    ${out1}    Read Until Prompt    strip_prompt=True
    ${history_file_verify}    ${rc}    Execute Command
        ...    cat /eniq/sw/runtime/tomcat/conf/tomcat_users_history.properties | grep -i "${new_user}" 
        ...    return_rc=True
        IF    '${rc}' == '0'
             Fail  user was not removed from tomcat_users_history.properties file  
        
        ELSE
            Log    Removed the user successfully from tomcat_users_history.properties  ..
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
   
    RETURN    ${username}    ${password}    