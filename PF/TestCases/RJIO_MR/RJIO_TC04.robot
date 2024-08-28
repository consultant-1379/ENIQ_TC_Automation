*** Settings ***
Library    RPA.Browser.Selenium
Library    DateTime
Library    String
Library    SSHLibrary
Library    Collections
Resource    ../../Resources/Keywords/Cli.robot
Resource    ../../Resources/Keywords/Variables.robot
Resource    ../../Resources/Keywords/AdminUIWebUI.robot
 
# Test Setup    Connect to server as a dcuser
# Test Teardown    Close All Connections
#Suite Teardown    Suite teardown steps
 
*** Variables ***
${SERVER}           atvts4150
#${Host_name}        ${SERVER}.athtem.eei.ericsson.se
#${port_number}      2251
#${user_name}        dcuser
#${password}         Dcuser%12
 
 
 
   
 
*** Test Cases ***
TC 04 Verify the no. of days left for password to be expired using CLI
   
    Create connection
 
    ${users1}    Execute Command     cat /eniq/sw/runtime/apache-tomcat*/conf/tomcat-users.xml | grep -oP '<user username="\\K[^"]+'
    ${users}    Split String    ${users1}
    ${expired_users}    Create List
    FOR    ${user}    IN    @{users}
        Write    echo -e "${user}\\n"| /eniq/sw/installer/manage_tomcat_user.bsh -A PASSWORD_EXPIRY
        ${out2}    Read Until Prompt    strip_prompt=True
        IF    'already expired' in '''${out2}'''
            Append To List    ${expired_users}    ${user}
            Log    ${expired_users}
 
        END
    END
 
 
   
 
     ${expiry_list}    Run Keyword And Return Status    Should Be Empty    ${expired_users}
    IF    "${expiry_list}"=="False"
         Log     ${expired_users}
         Fail    "Above Username's Password has already expired"
    ELSE
        Log    No users password is expired. Passing the test-case
    END    
 
 
*** Keywords ***
Create connection
    Open Connection
    ...    ${SERVER}.athtem.eei.ericsson.se
    ...    port=2251
    ...    timeout=100s
    ...    prompt=eniqs[eniq_stats] {dcuser} #:
    Login    dcuser    Dcuser%12
has context menu
Compose