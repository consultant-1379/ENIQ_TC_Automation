***Settings ***
Library    String
Library    SSHLibrary
Resource    ../../Resources/Keywords/Cli.robot
Resource    ../../Resources/Keywords/Variables.robot
Library    Collections

*** Variables ***
${Host_name}    atvts4150.athtem.eei.ericsson.se
${port}    2251
${usernae}    dcuser
${paswrd}    Dcuser%12
${SERVER}    atvts4150


*** Test Cases ***
Update password history file after II and upgrade
    Open Connection    ${Host_name}    port=${port}    timeout=10      
    Login    ${usernae}    ${paswrd}
    Set Client Configuration    prompt=eniqs[eniq_stats] {dcuser} #:        timeout=100s 
    ${file_present}    ${output}    Execute Command    ls /eniq/sw/runtime/apache-tomcat-*/conf/ | grep -i tomcat_users_history.properties    return_rc=True   
    @{my_list}    Create List         
     IF    '${output}' == '0'
        ${properties_users}    Execute Command     cat /eniq/sw/runtime/tomcat/conf/tomcat_users_history.properties | cut -d " " -f1
        ${xml_users}    Execute Command    cd /eniq/sw/runtime/apache-tomcat-*/conf/ && cat tomcat-users.xml | tr -d '\\n'| grep -oP "(?<=username\\=\\")[^\\"]*"
        ${split_list}=    Split String    ${properties_users} 
        ${properties_users_list}=    Evaluate    sorted(${split_list})
        ${split_list1}=    Split String    ${xml_users}   
        ${xml_users_list}=    Evaluate    sorted(${split_list1}) 
        FOR    ${i}    IN    @{xml_users_list}
           IF    '${i}' not in @{properties_users_list}
             Append To List    ${my_list}    ${i} 
            END           
         END
        ${check_length}    Get Length    ${my_list}
        IF   ${check_length} > 0 
            Fail    users are not matching, below are the missing users ${\n} ${my_list}
        ELSE
            Log To Console    Users are matching 
        END
    ELSE
         Fail    tomcat_users_history.properties file is not present 
    END 

