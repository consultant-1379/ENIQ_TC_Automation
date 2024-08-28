*** Settings ***
Library             String
Library             SSHLibrary
Resource            ../../Resources/Keywords/Cli.robot
Resource            ../../Resources/Keywords/Variables.robot
Resource    ../../Resources/Keywords/AdminUIWebUI.robot
Library    RPA.Browser.Selenium
Library    Collections

Suite Setup         Create connection
Suite Teardown      Close All Connections


*** Variables ***
${SERVER}           atvts4150
${host_123}         ${SERVER}.athtem.eei.ericsson.se
# ${port_for_vapp}    2251

*** Test Cases ***
PF TC 05 Password History: Update password history file after II and upgrade
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

PF TC 22 Password History: Verifying tomcat_user.xml and tomcat_users_history.properties files when the new user has been created
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


PF TC 25, 27 Password History: Verify by changing the new user password multiple times.
    FOR    ${i}    IN RANGE    0    5    
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


PF TC 26, 28 Password History: Verify by changing the default user password multiple times.
    ${new_user}    ${new_pass}    Generate Random username and password
    ${def_encryp_pass}    Execute Command    cat /eniq/sw/runtime/apache-tomcat*/conf/tomcat-users.xml | grep -oP '<user username="eniq".*?/>' | grep -oP 'password="{ENCRYPTION}\\K[^"]+'

    # ${def_pass}    Execute Command    cat /eniq/sw/runtime/tomcat/conf/tomcat_users_history.properties| grep "eniq "
    ${existing_pass}    Execute Command    bash /eniq/sw/platform/repository*/bin/EncryptDecryptUtility.sh -d ${def_encryp_pass}

    IF    '''${existing_pass}''' =='eniq'
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
    RETURN    ${username}    ${password}

Suite teardown steps
    Close All Connections
