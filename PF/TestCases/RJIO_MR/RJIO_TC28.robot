*** Settings ***
Library    SSHLibrary
Library    String
Resource    ../../Resources/Keywords/Cli.robot
Resource    ../../Resources/Keywords/Variables.robot
#Suite Setup    Connect to server as a dcuser
#Suite Teardown    Close All Connections
 
*** Variables ***
${Host_name}    atvts4108.athtem.eei.ericsson.se
${port_number}    2251  
${user_name}    dcuser  
${password}    Dcuser%12  
${adminui_user}    pf
 
*** Test Cases ***
Verify change password by giving existing passwords
    Open connection    ${Host_name}    port=${port_number}  
    Login    ${user_name}    ${password}  
    Set Client Configuration    prompt=eniqs[eniq_stats] {dcuser} #:     timeout=100s
    ${output}    Execute Command    cat /eniq/sw/runtime/tomcat/conf/tomcat_users_history.properties | grep -i ${adminui_user} | cut -d " " -f3
    Log   ${output}
    ${split_output}=    Split String    ${output}    ,
    FOR    ${element}    IN    @{split_output}
        Log    ${element}  
    ${encr_pwd}    Fetch From Right    ${element}    }
    Log    ${encr_pwd}
    ${repo_package}    Execute Command    ls /eniq/sw/platform | grep -i repository
    ${script}    Execute Command    ls /eniq/sw/platform/${repo_package}/bin/ | grep -i EncryptDecryptUtility.sh
    ${activating}    Execute Command    /eniq/sw/platform/${repo_package}/bin/${script}
    ${decr_pwd}    Execute Command    /eniq/sw/platform/${repo_package}/bin/EncryptDecryptUtility.sh -d ${encr_pwd}
    Log    ${decr_pwd}
    END
   
 
   
 
   
       
   
 
   
           
 
       
   
   
 
 
   