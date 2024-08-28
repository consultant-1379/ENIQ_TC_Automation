*** Settings ***
Force Tags    suite
Library    RPA.Browser.Selenium    
Library    SSHLibrary
Library    String
Library    Collections 
Resource    ../../Resources/Keywords/Parser.robot
Resource    ../../Resources/Keywords/Cli.robot
Resource    ../../Resources/Keywords/Variables.robot
Test Setup    Connect to physical server
Test Teardown    Close All Connections
Resource    ../../Resources/Keywords/AdminUIWebUI.robot 
Resource    ../../Resources/Keywords/Dwhmanager.robot
Resource    ../../Resources/Keywords/Engine.robot
Resource    ../../Resources/Keywords/Installer.robot
# Test Setup    Connect to server as a dcuser
Library     ../../Scripts/random_generating_password.py

*** Variables ***
${module}    installer
${host_123}    ieatrcxb6080.athtem.eei.ericsson.se

*** Test Cases ***
TC_01 Verify latest installer deployed in ENIQ Server
    Open clearcasevobs
    ${installer_module}=    Get Element Attribute    //table//a[text()='${module}']    href
    Set Global Variable    ${installer_module}
    ${installer_name}=    Fetch From Right    ${installer_module}    /
    ${installer_name}    Split String From Right    ${installer_name}    .    
    Set Global Variable    ${installer_name}
    ${clearcase_rstate_bulidno}    Split String From Right     ${installer_name}[0]    _
    ${clearcase_rstate_bulidno}    Set Variable   ${clearcase_rstate_bulidno}[-1]
    Set Global Variable    ${clearcase_rstate_bulidno}
    ${version_prop}    ${rc}    Execute Command    cat /eniq/sw/installer/versiondb.properties | grep -i 'installer'   return_rc=True
    Set Global Variable    ${rc}
    ${rstatebuildno}    Split String From Right    ${version_prop}    =
    ${rstatebuildno}    Set Variable    ${rstatebuildno}[-1]
    Set Global Variable    ${rstatebuildno}

TC_02_03 Downloading and Installing the installer.
    Skip If    '${rstatebuildno}' == '${clearcase_rstate_bulidno}'   ${\n}Skipping the downloading since latest ${module} is already present in the server.
    Execute Command    cd /eniq/sw/installer && rm -rf /eniq/sw/installer/temp && mkdir temp 
    ${zip_name}    Split String From Right    ${installer_module}    /
    ${output}    Execute Command    cd /eniq/sw/installer/temp ; wget ${installer_module} ; chmod u+x ${zip_name}[-1]  
    ${output}    Execute Command    cd /eniq/sw/installer/temp ; unzip ${zip_name}[-1] ; chmod u+x install_installer.sh ; ./install_installer.sh -v
    ${failed}    Evaluate    'failed' in '''${output}'''  
    IF    ${failed}
        Fail    *HTML* <span style="color:red"><b>${module} installation Failed.</b></span>${\n}${output}
    ELSE
        Log    <span style="color:green"><b>${module} installed Successfully.${\n}Proceeding with log verification.</b></span>    html=True
     END

TC_04 Verify latest module in CLI
    ${installer_file}    Get the element of installer attribute from clearcase
    ${installer_rstate_buildno_clearcase}    Get installer Rstate from clearcase    ${installer_file}
    Connect to server as a dcuser
    ${installer_rstate_buildno_server}    Get installer version from server
    Should be equal    ${installer_rstate_buildno_clearcase}    ${installer_rstate_buildno_server}

TC_05 Verify latest module in AdminUI
    ${Installer_file}    Get the element of installer attribute from clearcase
    ${Installer_rstate_buildno_clearcase}    Get Installer Rstate from clearcase    ${Installer_file}
    Connect to server as a dcuser
    ${rstate_buildno_server}    Execute Command    cd /eniq/sw/installer && cat versiondb.properties | grep -i installer
    ${output}    Remove String Using Regexp    ${rstate_buildno_server}    .*installer\\S
    #Should Be Equal    ${Installer_rstate_buildno_clearcase}    ${output}
    AdminUIWebUI.Launch the AdminUI page in browser
    AdminUIWebUI.Login To Adminui
    Go to system monitoring and select installed modules
    Page Should Contain    module.installer=${output}
    AdminUIWebUI. Logout from Adminui
TC_06 Verify the installation logs for no errors
    Connect to server as a dcuser
    Engine.Execute the Command    ${platform_installer}
    ${latest}=    Engine.Get latest file from directory    installer*.log
    ${latest}    Split String    ${latest}
    ${Verify}    ${rc}    Execute Command    ${platform_installer} && cat ${latest}[0] | grep -iE "warning\|exception\|severe\|not found\|error"    return_rc=true
    IF    ${rc}==0
        Fail    Failing the testcase, since log has some warning/error/exception/not found
    ELSE
        Log    Passing the testcase, since there is no warning/error/exception
    END
TC_07 Restart all services and verify all the services up and running
    Open connection as root user
    Installer.Execute the Command    ${bin}
    ${output}    Write     bash /eniq/admin/bin/manage_deployment_services.bsh -a restart -s ALL
    ${out}    Read    delay=5s
    Write    Yes
    ${Final_output}    Read    delay=400s
    Should Contain    ${Final_output}    ENIQ services started correctly

TC_08 Restart all services and verify all the services up and running
    Open connection as root user
    Installer.Execute the Command    ${bin}
    ${STATE}    Execute Command    bash /eniq/admin/bin/manage_deployment_services.bsh -a list -s ALL | awk '/SERVICE/ { flag=1; next } /LOGFILE/ { flag=0 } flag && NF { print $2}'
    @{STATE_VALUE}    Split To Lines    ${STATE}
    FOR    ${element}    IN    @{STATE_VALUE}
        Log To Console    ${element}
        Should Match Regexp    ${element}    \\bactive\\b
    END
    ${out}    Execute Command    bash /eniq/admin/bin/manage_deployment_services.bsh -a list -s ALL | awk '/SERVICE/ { flag=1; next } /LOGFILE/ { flag=0 } flag && NF { print $2}'
    @{out1}    Split To Lines    ${out}
    FOR    ${element}    IN    @{out1}
        Log To Console    ${element}
        Should Match Regexp    ${element}    \\bactive\\b
    END

TC_09 Verify Individual installation of runtime module
    [Tags]    Installer
    Connect to server as a dcuser
    verification of Installation of runtime module

TC_10 verify node hardening to the server
    [Tags]    Installer
    Open connection as root user
    verifying node hardening to the server
    #It will work only in Vapp servers 

TC_11 Verify Restarting all the services status
    [Tags]    Installer
    Open connection as root user 
    verification of Restarting all services

TC_12 Verification of Installation of the techpack using tp_installer script
    [Tags]    Installer
    Cli.Connect to server as a dcuser
    verify Techpack Installation using tp_installer script

TC_13 Verify activation of interfaces for multiple eniq aliases
    [Tags]    Installer
    Connect to physical server
    Verify interface activation for eniq_oss_n

TC_14 Verify the All installer Module scripts present in server
    Removing Automation_bin text file
    Adding bin script files in server
    ${flag}    Set Variable    True
    @{lst}=    Create List
    ${content}=    Execute Command    cat ${bin_path_for_scripts}Automation_bin_scripts.txt
    Should Not Be Empty    ${content}
    @{files}    Split To Lines    ${content}
    FOR    ${Scripts_name}    IN    @{files}
        ${checking_file}    Execute Command    ${List_of_files_bin} ${Scripts_name}
        IF    '${checking_file}'!='${EMPTY}'
            Log To Console    ${bin_path_for_scripts}${Scripts_name} file is there
        ELSE
            Append To List    ${lst}    ${bin_path_for_scripts}${Scripts_name}    
            Log To Console    ${bin_path_for_scripts}${Scripts_name} file is not there
            ${flag}    Set Variable    False
        END
    END
    IF    '${flag}' == 'True'
        Pass Execution    All files are present
    ELSE
        Fail    Some files are not present:${lst}
    END
TC_15 Verify the All installer Module scripts present in server
      Removing Automation_installer text file
       Adding Installer script files in SERVER
    ${flag}    Set Variable    True
    @{lst}=    Create List
    ${content}=    Execute Command    cat ${insatller_path_for_scripts}Automation_installer_scripts.txt
    Should Not Be Empty    ${content}
    @{files}    Split To Lines    ${content}
    FOR    ${Scripts_name}    IN    @{files}
        ${checking_file}    Execute Command    ${List_of_files} ${Scripts_name}
        IF    '${checking_file}'!='${EMPTY}'
            Log To Console    ${insatller_path_for_scripts}${Scripts_name} file is there
        ELSE
            Append To List    ${lst}    ${insatller_path_for_scripts}${Scripts_name}    
            Log To Console    ${insatller_path_for_scripts}${Scripts_name} file is not there
            ${flag}    Set Variable    False
        END
    END
    IF    '${flag}' == 'True'
        Pass Execution    All files are present
    ELSE
        Fail    Some files are not present:${lst}
    END

        


TC_16 Verify the Change the keystore password and check the four files and verify the passwords in Keystore passwords
    Connect to server as a dcuser
    ${random_password_generated}=    random_generating_complaint_passwords
    Log To Console    ${random_password_generated}
    ${Date}=    Get current date in yyyy.mm.dd result_format
    Log To Console    ${Date}
    Engine.Execute the Command    cp /eniq/sw/runtime/tomcat/conf/server.xml /eniq/sw/runtime/tomcat/conf/server.xml_backup_${Date}
    Engine.Execute the Command    su - ${root_user}
    Engine.Execute the Command   ${root_pwd}
    Engine.Execute the Command    /eniq/sw/installer/configure_newkeystore.sh
    Engine.Execute the Command    ${random_password_generated}
    ${pwd_success_msg}=   Engine. Execute the Command    ${random_password_generated}
    Sleep    150s
    Engine.Verify the msg    ${pwd_success_msg}    Service stopping eniq-webserver
    
    Engine.Execute the Command    ${dc_user}
    ${keystore_pwd}=    Execute Command    /eniq/sw/installer/getPassword.bsh -u keystore | cut -d ':' -f2 | cut -d ' ' -f2
    ${tomcat_keystore}=    Execute Command    cat /eniq/sw/runtime/tomcat/conf/server.xml | grep -i keystorePass= | cut -d "=" -f 2-
    ${tomcat_keystore_output}=    Get Regexp Matches    ${tomcat_keystore}    \\d+
    ${tomcat_keystore_output}=    Get Regexp Matches    ${tomcat_keystore}    \\d+
    ${tomcat_pwd}=    Evaluate    ''.join(chr(int(code)) for code in ${tomcat_keystore_output})
    ${grep_keystore_pwd}=    Execute Command    cat /eniq/sw/conf/niq.ini | grep -i keyStorePassValue= | cut -d "=" -f 2-
    ${decrpting_pwd}=   Execute Command    echo -e "${grep_keystore_pwd}" | base64 -d
    Should Be Equal    ${keystore_pwd}    ${decrpting_pwd}
    Should Be Equal    ${tomcat_pwd}    ${keystore_pwd}    
    ${security_dir}=    Execute Command    /eniq/sw/runtime/jdk/bin/keytool -list -keystore /eniq/sw/runtime/jdk/jre/lib/security/truststore.ts -storepass ${keystore_pwd}
   Engine. Verify the msg    ${security_dir}    Keystore type: JKS
    ${store_pass}=    Execute Command    /eniq/sw/runtime/jdk/bin/keytool -list -v -keystore /eniq/sw/runtime/tomcat/ssl/keystore.jks -storepass ${keystore_pwd}
    Engine. Verify the msg    ${store_pass}    Signature algorithm name

    #reverting back old_password
    Engine.Execute the Command    su - ${root_user}
    Engine.Execute the Command   ${root_pwd}
    Engine.Execute the Command    /eniq/sw/installer/configure_newkeystore.sh
    Engine.Execute the Command    ${random_password_generated}
    Engine.Execute the Command    EniqOnSSL
    ${pwd_success_msg_01}=    Engine.Execute the Command    EniqOnSSL
    Sleep    150s
    Engine.Verify the msg    ${pwd_success_msg_01}    Service stopping eniq-webserver
TC_17 Verify the root user change verification.
    Open connection as root user
    ${random_password_generated}=    random_generating_complaint_passwords
    Log To Console    ${random_password_generated}
    Engine.Execute the Command    passwd
    Engine.Execute the Command    ${random_password_generated}
    ${pass_01}=   Engine. Execute the Command    ${random_password_generated}
    Engine.Verify the msg    ${pass_01}    updated successfully
    #Reverting back to old password
    Engine.Execute the Command    passwd
   Engine. Execute the Command    ${root_pwd}
    ${reverting_02}=   Engine. Execute the Command    ${root_pwd}
    Engine.Verify the msg    ${reverting_02}    updated successfully

*** Keywords ***
Get the element of installer attribute from clearcase
    Open Available Browser    ${clearcase_url}     headless=false
    Maximize Browser Window
    click link    //body//tr[last()-2]//td[2]//a
    ${installer_file}=    Get Element Attribute    //a[contains(text(),'installer')]    href
    Go To    ${installer_file}
    RETURN    ${installer_file}

Get installer Rstate from clearcase
    [Arguments]    ${installer_file}
    ${installer_zip_file}=    Fetch From Right    ${installer_file}    r_
    ${installer_rstate_buildno_clearcase}=    Fetch From Left    ${installer_zip_file}    .
    RETURN    ${installer_rstate_buildno_clearcase}

Get installer version from server
    ${rstate_8399}    Execute Command    cd /eniq/sw/installer && cat versiondb.properties | grep -i installer
    ${installer_rstate}    Split String    ${rstate_8399}    installer=
    ${installer_rstate_buildno_server}=    Get From List    ${installer_rstate}    -1
    ${output}    Remove String Using Regexp    ${installer_rstate_buildno_server}    .*installer\\S
    RETURN    ${output}

    



verification of Installation of runtime module
    ${Features}=    Execute Command    ${mws_path_list_of_features}
    ${mws_path}=    Execute Command    ${mws_path_list_of_modules}${Features}/eniq_base_sw/eniq_sw ; ls
    Installer.Execute the Command    ${copy_runtime_module}
    Installer.Go to the folder    ${installer_folder}
    switch user    ${su_root}
   Installer. Execute the Command    ${root_pwd}
    ${services_status_1}=    Installer.Execute the Command    ${checking_services_status}
    verifyng the services status    ${services_status_1}     loaded active running
    Installer.Go to the folder  ${bin_folder}
    Installer.Execute the Command    ${stop_all_services}
    Sleep    20s
    Installer.Grant permission    Yes
    ${stopped_services_status}=    Read    delay=220s
    verifyng the services status    ${stopped_services_status}    ENIQ services stopped correctly        
    switch user   ${dc_user}
    Installer.Go to the folder    ${installer_folder}
    Installer.Go to the folder    ${installer_temp_folder}
     Installer.Execute the Command    ${make_directory}
    Installer.Execute the Command    ${copy_module_into_installer_temp}
    Installer.Execute the Command    ${unzip}
    replacing the runtime folder
    Installer.Execute the Command    ${chmod_insatll_runtime}
    ${installation}=    Installer.Execute the Command    ${install_runtime}
    verifying installation status    ${installation}    installed
    switch user    ${su_root}
    Installer.Execute the Command    ${root_pwd}
   Installer. Go to the folder    ${bin_folder}
    Installer.Execute the Command      ${start_all_services}
    Sleep    20s
    Installer.Grant permission    Yes
    ${active_status}=    Read    delay=350s
    verifying services status    ${active_status}    ENIQ services started correctly
    [Teardown]    Test teardown

verifying node hardening to the server 
    ${Features}=    Execute Command    ${Linux_media_folder}
    ${mws_path}=    Execute Command    ${Linux_media_folder_02}${Features};ls -Art | grep -i 22.2 | tail -1
    Installer.Execute the command    cd /${mws_path}/om_linux/security/ERICnodehardening-R9D02.rpm
    Installer.Execute the Command    ${grep_node_hardening}
    Installer.Execute the command    ${node_hardening}
    Installer.Grant permission    y
    ${node_hardening_status}=    Read    delay=200s
    verifying node hardening status    ${node_hardening_status}     The server will reboot now   
    [Teardown]    Test teardown
Verification of Restarting all services
    Installer.Go to the folder    ${bin_folder}
    Installer.Execute the Command   ${Restart_command}
    Installer.Grant permission    Yes
    ${services_status}=    Read    delay=400s
    Verifying stop all services    ${services_status}    ENIQ services stopped correctly 
    Verifying start all services   ${services_status}    ENIQ services started correctly
    ${service_output}=    Installer.Execute the Command    ${system_services}
    verifying the output has value eniq    ${service_output}    eniq
    [Teardown]    Test teardown
Verify Techpack Installation using tp_installer script
    ${Features}=    Execute Command    ${mws_path_list_of_features}
    ${mws_path}=    Execute Command    ${mws_path_list_of_modules}${Features}/eniq_techpacks/ ; ls
    @{interface}=    Split To Lines    ${mws_path}
    ${Techpack_list}=    Get From List    ${interface}    5
    Installer.Go to the folder    ${installer_folder}
    ${installation_status_of_techpack}=    Installer.Execute the Command    ${install_techpack_command}${Techpack_list}
    Verify the Techpack installation    ${installation_status_of_techpack}    Techpack Installation Complete    Already stage file available
    [Teardown]    Test teardown
Verify interface activation for eniq_oss_n
    ${Features}=    Execute Command    ${mws_path_list_of_features}
    ${mws_path}=    Execute Command    ${mws_path_list_of_modules}${Features}/eniq_techpacks/ ; ls
    @{interface}=    Split To Lines    ${mws_path}
    ${Techpack_list}=    Get From List    ${interface}    5
    Installer.Go to the folder    ${installer_folder}
    Installer.Remove log file
    ${activation_status_of_techpack}=   Installer. Executing the command    ./activate_interface -o eniq_oss_1 -i${Techpack_list}
    verify activation status of techpack    ${activation_status_of_techpack}    Change profile requested successfully        
    ${interface_status}=    Installer.Execute the Command    ${grep_eniq_oss_*}
    verify the interface activation with eniq_oss_n   ${interface_status}    eniq_oss_
    [Teardown]    Test teardown

Test Teardown
    Close All Connections

  

