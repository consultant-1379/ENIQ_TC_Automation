*** Settings ***
Documentation     Testing AdminUI web
Library    OperatingSystem
Library    String
Library    SSHLibrary
Resource    ../../Resources/Keywords/Cli.robot
Library    RPA.Browser.Selenium   
Resource    ../../Resources/Keywords/AdminUIWebUI.robot
Resource    ../../Resources/Keywords/Variables.robot
Suite Setup    Open connection as root user
Suite Teardown    Close All Connections


*** Test Cases ***
TC_01_Verify launching of Adminui page
    Launch the AdminUI page in browser
    Verify the Adminui Login page is displayed
    # [Teardown]    Test teardown

    
TC_02_Verify the Adminui Homepage
    Connect to server as a dcuser
    Verify the tomcat user creation    ${USERNAME}    ${PASSWORD}
    Increasing the adminui sessions
    Launch the AdminUI page in browser
    Login to Adminui
    Verify the Adminui Homepage is displayed
    Click on scroll down button
    Click on scroll up button
    Verify the All Subcategories in Adminui Homepage is displayed
    Logout from Adminui
    # [Teardown]    Test teardown

    

TC_03_Verify the Adminui Homepage links in System Monitoring 
    Launch the AdminUI page in browser
    Login to Adminui
    Click Button    System Status
    Verify the System Status page displayed
    Click on link    ETLC Monitoring
    Verify the ETLC Monitoring page displayed
    Click on link    ETLC Set History
    Verify the ETLC Set History page displayed
    Click on link    ETLC Set Scheduling
    Verify the ETLC Set Scheduling page displayed
    Click on link    Monitoring Commands
    Verify the Monitoring Commands page displayed
    Click on link    TechPack Installation
    Verify the TechPack Installation page displayed
    Click on link    FM Alarm
    Verify the FM Alarm page displayed  
    Click on scroll down button
    Logout from Adminui
    # [Teardown]    Test teardown

    

TC_04_Verify the Adminui Homepage links in ENM Interworking 
    Launch the AdminUI page in browser
    Login to Adminui
    Click on link    Granularity Configuration
    Verify the Granularity Configuration page displayed
    Click on link    Custom Nodes
    Verify the Custom Nodes page displayed
    Click on link    Role Assignment Tool
    Verify the Role Assignment Tool page displayed
    Click on scroll down button
    Logout from Adminui 
    # [Teardown]    Test teardown

    

TC_05_Verify the Adminui Homepage links in Feature Version Manager
    Launch the AdminUI page in browser
    Login to Adminui
    Click on link    Pre Check
    Verify the Pre Check page displayed
    Click on link    Update Features
    Verify the Update Features page displayed
    Click on link    Install Features
    Verify the Install Features page displayed
    Click on link    Report Extraction
    Verify the Report Extraction page displayed
    Click on scroll down button
    Logout from Adminui
    # [Teardown]    Test teardown

    


TC_06_Verify the Adminui Homepage links in Data Flow Monitoring
    Launch the AdminUI page in browser
    Login to Adminui
    Click on link    Show Loadings
    Verify the Show Loadings page displayed
    Click on link    Show Aggregations
    Verify the Show Aggregations page displayed
    Click on link    Reaggregation
    Verify the Reaggregation page displayed
    Click on link    Session Logs
    Verify the Session Logs page displayed    
    Click on scroll down button
    Logout from Adminui
    # [Teardown]    Test teardown

    

TC_07_Verify the Adminui Homepage links in Data Verification
    Launch the AdminUI page in browser
    Login to Adminui
    Click on link    Data Row Info
    Verify the Data Row Info page displayed
    Click on link    Data Row Summary
    Verify the Data Row Summary page displayed
    Click on link    Show Reference Tables
    Verify the Show Reference Tables page displayed
    Click on link    Busy Hour Information
    Verify the Busy Hour Information page displayed
    Click on link    RANKBH Information
    Verify the RANKBH Information page displayed
    Click on scroll down button
    Logout from Adminui
    # [Teardown]    Test teardown

    

TC_08_Verify the Adminui Homepage links in Configuration 
    Launch the AdminUI page in browser
    Login to Adminui
    Click on scroll down button
    Click on link    Monitoring Rules
    Click on scroll down button
    Verify the Monitoring Rules page displayed
    Click on link    Monitored Types
    Click on scroll down button
    Verify the Monitored Types page displayed
    Click on scroll down button
    Click on link    Type Configuration
    Click on scroll down button
    Verify the Type Configuration page displayed
    Click on link    DWH Configuration
    Click on scroll down button
    Verify the DWH Configuration page displayed
    Click on link    Logging Configuration
    Click on scroll down button
    Verify the Logging Configuration page displayed
    Click on link    Polling Start Time
    Click on scroll down button
    Verify the Polling Start Time page displayed
    Click on link    EBS Upgrader
    Click on scroll down button
    Verify the EBS Upgrader page displayed
    Click on link    Busy Hour Configuration
    Switch window to new Busyhour tab
    Switch window to back to Adminui tab
    Verify the Busy Hour Configuration page displayed
    Logout from Adminui
    # [Teardown]    Test teardown

    
TC_09_10_11_Verify Login to AdminUI with incorrect credentials
    [Tags]  adminui
    Log		${EXEC_DIR}
    ${json}=    OperatingSystem.get file    ${EXEC_DIR}/PF/Resources/Data/adminui/invalidCredentials.json
    &{object}=    Evaluate     json.loads('''${json}''')     json
    FOR   ${key}   IN  @{object.keys()}
        Add Test Case    ${key}   Validate Login To Adminui With wrong crdentials      ${object}[${key}]
    END

    

TC_12_Verify Launch of adminui with server ip address with 8443 port
    Launch the Adminui Page in browser with IP Address and port number
    Verify the Adminui Login page is displayed
    # [Teardown]    Test teardown

     
TC_13_Verify login of adminui with all supported browsers
    #Default browser is chrome
    Launch the AdminUI page in browser
    Login to Adminui
    Verify the Adminui Homepage is displayed
    Click on scroll down button
    Click on scroll up button
    Verify the All Subcategories in Adminui Homepage is displayed
    Logout from Adminui
    Launch the AdminUI page in Firefox browser
    Login to Adminui
    Verify the Adminui Homepage is displayed
    Click on scroll down button
    Click on scroll up button
    Verify the All Subcategories in Adminui Homepage is displayed
    Logout from Adminui
    # [Teardown]    Test teardown

    

TC_14_Verify Launch of adminui multiple browsers with session limit for a single user
    [Tags]    Adminui 
    Connect to server as a dcuser
    Go to the folder    ${Installer_path}
    ${sessionCountDetails}=    Execute the command    ${Get_sessions_script}
    ${sessionCount}=    Get the session count    ${sessionCountDetails}
    Vaildate the number of Logon sessions    ${Logon_session_msg}
    ${Set session}=    Execute the command    ${Set_sessions_script}
    Execute the command    1
    Vaildate the number of Logon sessions updated    ${Logon_session_updated_msg}
    Vaildating webserver restart    Webserver restarted successfully    
    Launch the AdminUI page in browser
    Login to Adminui
    Sleep    5s
    Launch the AdminUI page in Firefox browser
    Login To Adminui in firefox
    Vaildating the AdminUI page    Maximum session limit
    Close Browser
    Switch Browser    1
    Click on scroll down button
    Logout from Adminui
    #Setting the sessions limit back to previous session limit
    Go to the folder    ${installer path}
    ${Set session}=    Execute the command    ${Set_sessions_script}    
    Execute the command    ${sessionCount}    
    Vaildate the number of Logon sessions updated    ${Logon_session_updated_msg}
    # [Teardown]    Test teardown

    

TC_15_20_Verify login of adminui with create_newuser change_password delete_newuser
    [Tags]    Adminui 
    Connect to server as a dcuser
    Go to the folder    ${installer path}
    Execute the command    ${tomcat_add user}
    Execute the command    ${newuser id}
    Verify the login of adminui with newly created user
    Go to the folder    ${installer path}
    Execute the command    ${tomcat change_password}

    Verify the adminui login page    ${password id}
    Verify the login of adminui with updated password
    Deleting the newly created user

    

TC_16_Verify the error message for password without a capital letter
    [Tags]    Adminui 
    Connect to server as a dcuser
    Go to the folder    ${installer path}
    Execute the command    ${tomcat_add user}
    Execute the command    ${newuser id}
    ${output}=    Enter the password    ${lower case password}
    Validating the password    ${output}    ${upper_case}
    # [Teardown]    Test teardown

    

TC_17_Verify the error msg for password with space
    [Tags]    Adminui 
    Connect to server as a dcuser
    Go to the folder    ${installer_path}
    Execute the command    ${tomcat_add user}
    Execute the command    ${newuser_id}
    ${output}=    Enter the password    ${password_with_space}        
    Validating the password   ${output}    ${space}
    # [Teardown]    Test teardown

    

TC_18_Verify the error msg for password without a small letter
    [Tags]    Adminui 
    Connect to server as a dcuser
    Go to the folder    ${installer_path}
    Execute the command    ${tomcat_add user}
    Execute the command    ${newuser_id}
    ${output}=    Enter the password    ${uppercase_password}    
    Validating the password   ${output}    ${lower_case}
    # [Teardown]    Test teardown

    

TC_19_Verify the error msg for password length less than 8 characters.
    [Tags]    Adminui 
    Connect to server as a dcuser
    Go to the folder    ${installer path}
    Execute the command    ${tomcat_add user}
    Execute the command    ${newuser_id}
    ${output}=    Enter the password   ${four_letters_character}
    Validating the password   ${output}    ${eight_character}
    # [Teardown]    Test teardown

    

TC_21_Verify the Launching of adminui with 8080 port
    Launch the Adminui page in browser with IP Address and wrong port number
    Vaildating the AdminUI page    This site can’t be reached    
    # [Teardown]    Test teardown

    
TC_22_Verify the adminui for GET_SESSIONS and SET_SESSIONS
    [Tags]    Adminui 
    Connect to server as a dcuser
    Go to the folder    ${installer path}
    ${sessionCountDetails}=    Execute the command    ${Get_sessions script}
    ${sessionCount}=    Get the session count    ${sessionCountDetails}
    Vaildate the number of Logon sessions    ${Logon_session_msg}
    ${Set_session}=    Execute the command    ${Set_sessions script}
    Execute the command    2
    Vaildate the number of Logon sessions updated    ${Logon_session_updated_msg}
    Launch the AdminUI page in browser
    Login to Adminui
    Verify the Adminui Homepage is displayed
    Launch the AdminUI page in Firefox browser
    Login to Adminui
    Verify the Adminui Homepage is displayed
    Logout from Adminui
    Close Browser
    Switch Browser    1
    Click on scroll down button
    Sleep    2s
    Logout from Adminui
    #Setting the sessions limit back to previous session limit
    Go to the folder    ${installer path}
    ${Set_session}=    Execute the command    ${Set_sessions script}
    Execute the command    ${sessionCount}
    Vaildate the number of Logon sessions updated    ${Logon_session_updated_msg}
    # [Teardown]    Test teardown

    

TC_23_Verify the adminui for GET_SESSIONS_Timeout and SET_SESSIONS_Timeout
    [Tags]    Adminui 
    Connect to server as a dcuser
    Go to the folder    ${installer path}
    ${session}=    Execute the command    ${Get_sessions_timeout}
    Vaildating the number session_timeout   ${User_session_timeout}
    ${session}=    Execute the command    ${Set_sessions_timeout}
    Execute the command    ${Session_timeout_min}
    Vaildate the user session timeout    ${User_session_timeout}
    Launch the AdminUI page in browser
    Login to Adminui
    Verify the Adminui Homepage is displayed
    Setting the time in adminui page    ${Session_timeout_min}
    Reload Page
    Verify the Adminui Login page is displayed
    #Verify the Adminui Log
    Go to the folder    ${sw_log}
    ${current_date}=    Get current date in dd.mm.yyyy result_format
    ${grepError_results}=    Grep message from file    error    user_management_${current_date}.log
    verify for no errors in logs    ${grepError_results}
    # Test teardown

    
TC_24_Verify check box in update features links in adminui page
    Launch the AdminUI page in browser
    Login to Adminui
    Verify the Adminui Homepage is displayed
    Click on link    Update Features
    Select the feature    ${DSC_PM_Tech_Pack}
    Click on scroll down
    Click on button    Continue    
    Enter root password    ${Eniqs_password_input_id}    ${root_pwd}
    Click on button    Update
    sleep    20min
    Vaildating the AdminUI page    Feature Update Overview - UPDATE SUCCESSFUL    
    Vaildating the AdminUI page    COMPLETED
    Enter root password    commitpassword   ${root_pwd}
    Click on button    ${Commit_button}    
    Vaildating the AdminUI page    Feature Commit Overview - FEATURE COMMIT IN PROGRESS
    Sleep    2min
    Vaildating the AdminUI page    This site can’t be reached
    Sleep    5min
    Reload Page
    Verify the Adminui Login page is displayed
    # [Teardown]    Test teardown

    


TC_25_Verify check box in update features links in adminui page for privileged user
    [Tags]    Adminui
    Connect to physical server as root user
    Execute the command    ${privileged_script}        
    Execute the command    ${Enable ENIQ Privileged User}
    Execute the command    1
    Execute the command    ${non_rootuser}
    Execute the command    ${non_rootpass}
    Sleep    10s
    Launch the AdminUI page in browser
    Login to Adminui
    Verify the Adminui Homepage is displayed
    Click on link    Update Features
    Select the feature    ${DSC PM Tech Pack}   
    Click on scroll down
    Click on button    Continue
    Enter username and password    ${non_rootuser}    ${non_rootpass}
    Click on button    Update
    sleep    20min
    Vaildating the AdminUI page    Feature Update Overview - UPDATE SUCCESSFUL
    Vaildating the AdminUI page    COMPLETED
    Enter commit username and password    ${non_rootuser}    ${non_rootpass}      
    Click on button    ${commit button}    
    Vaildating the AdminUI page    Feature Commit Overview - FEATURE COMMIT IN PROGRESS
    Sleep    2min
    Vaildating the AdminUI page    This site can’t be reached
    Sleep    5min
    Reload Page
    Verify the Adminui Login page is displayed
    Close Browser
    Sleep    10s
    Connect to physical server as non-root user
    Execute the command    su - root
    Execute the command    ${root_pwd}
    Execute the command    ${privileged_script}
    Execute the command    ${Rollback ENIQ Privileged User}
    ${Rollback_msg}=    Execute the command    y
    Verify the msg    ${Rollback_msg}    Successfully completed Rollback Admin group stage
    # [Teardown]    Test teardown

    


TC_26_Verify login with password changed from Adminui page
    [Tags]    Adminui 
    Change Password in AdminUI page    ${PASSWORD}    ${change_newPassword}
    Sleep    15s
    
    #Revert the password change
    Change Password in AdminUI page    ${change_newPassword}    ${PASSWORD}  
    
    Connect to server as a dcuser
    Go to the folder    ${sw_log}
    ${current_date}=    Get current date in dd.mm.yyyy result_format
    ${errorCount}=    Grep message from file    error    user_management_${current_date}.log
    verify for no errors in logs     ${errorCount}

    

TC_27_Verify login with removed user
    [Tags]    Adminui
    Connect to server as a dcuser
    Go to the folder    ${Installer_path}    
    Execute the command    ${Tomcat_add_user}
    Execute the command    ${Newuser_id}
    Create new user for Adminui login
    Launch the AdminUI page in browser
    Verify the adminui page in Login page section    ${Password_id}
    Click on scroll down button
    Logout from Adminui
    Go to the folder    ${Installer_path}
    Execute the command    ${Tomcat_remove_user}
    Execute the command    ${Newuser_id}
    Deleting the newly created user
    Launch the AdminUI page in browser
    Login To Adminui with credentials    ${Newuser_id}    ${password_id}
    Validate the update message    ${LoginFailedMsg}   

    Go to the folder    ${sw_log}
    ${current_date}=    Get current date in dd.mm.yyyy result_format
    ${grepError_results}=    Grep message from file    error    user_management_${current_date}.log
    verify for no errors in logs    ${grepError_results}
    # Test teardown

    

TC_28_Verify the error msg for password creation with any of the below the special characters
    Launch the AdminUI page in browser
    Login To Adminui
    Click on scroll down button
    Click on link    Change Password
    Enter Input    ${oldPasswordId}    ${PASSWORD}
    Enter Input    ${newPasswordId}    ${changePasswordSpecialCharacter}
    Enter Input    ${confirmNewPasswordId}    ${changePasswordSpecialCharacter}
    Select Show Password 
    Click On Submit Button
    Validate the update message    ${changePasswordErrorMsg}
    Logout from Adminui
    # [Teardown]    Test teardown

    

TC_29_Verify the edit functionality of Legal notice message in AdminUI as default user
    [Tags]    Adminui
    Launch the AdminUI page in browser
    ${Legal Notice Message}=	Get the Legal Notice msg	${Legal_message_xpath}
    Login to Adminui
    Click on scroll down button
    Click on link    Legal Notice Message
    Wait for Legal notice page input text box
    Editing the Legal notice msg    ${New_legal_notice}
    Sleep    2s
    Click Button    Save
    Validate the update message    ${Legal_sucessfully_msg}
    Verify the Adminui Legal Notice message    ${New_legal_notice}
    Logout from Adminui
    Connect to server as a dcuser
    Execute the command    cd ${Webapps_path}
    ${Update_msg}=    Execute the command    cat ${Message_properties}
    Validating the file    ${Update_msg}    ${New_legal_notice}
    Launch the AdminUI page in browser
    Validate the update message    ${New_legal_notice}
    #Reverting the legal notice message
    Launch the AdminUI page in browser
    Login to Adminui
    Click on scroll down button
    Click on link    Legal Notice Message
    Wait for Legal notice page input text box
    Editing the Legal notice msg    ${Legal Notice Message}
    Sleep    2s
    Click Button    Save
    Verify the Adminui Legal Notice message	${Legal Notice Message}    
    Logout from Adminui
    # [Teardown]    Test teardown

    


TC_30_Verify the edit functionality of Legal notice message in AdminUI as Tomcat user
    [Tags]    Adminui
    Connect to server as a dcuser
    Go to the folder    ${Installer_path}
    Execute the command    ${Tomcat_add_user}
    Execute the command    ${Newuser_id}
    Verify the login of adminui with newly created tomcat user
    Launch the AdminUI page in browser
    ${Legal Notice Message}=    Get the Legal Notice msg    ${Legal_message_xpath}
    Sleep    2s 
    Login To Adminui with New credentials    ${Newuser_id}    ${Password_id}
    Click on scroll down button
    Click on link    Legal Notice Message
    Wait for Legal notice page input text box 
    Editing the Legal notice msg    ${New_legal_notice}
    Click Button    Save
    Validate the update message    ${Legal_sucessfully_msg}
    Verify the Adminui Legal Notice message    ${New_legal_notice}
    Logout from Adminui
    Execute the command    cd ${Webapps_path}
    ${Legal_msg_cli}=    Execute the command    cat ${Message_properties}
    Validating the file    ${Legal_msg_cli}    ${New_legal_notice}
    Launch the AdminUI page in browser
    Validate the update message    ${New_legal_notice}
    Sleep    5s
    Launch the AdminUI page in browser
    Login To Adminui with New credentials    ${Newuser_id}    ${Password_id}
    Click on scroll down button
    Click on link    Legal Notice Message
    Wait for Legal notice page input text box
    Editing the Legal notice msg    ${Legal Notice Message}   
    Click Button    Save
    Validate the update message    ${Legal_sucessfully_msg}
    Verify the Adminui Legal Notice message    ${Legal Notice Message}
    Logout from Adminui
    Go to the folder    ${Installer_path}
    Execute the command    ${Tomcat_remove_user}
    Execute the command    ${Newuser_id}
    Deleting the newly created user
    Launch the AdminUI page in browser
    Login To Adminui with New credentials    ${Newuser_id}    ${Password_id}
    Validate the update message    ${LoginFailedMsg}
    # [Teardown]    Test teardown

TC_31_Verify that custom user details in the adminui page
    Connect to server as a dcuser
    Verify the tomcat user creation    ${custom user}    ${custom pwd}
    Launch the AdminUI page in browser
    Login To Adminui with New credentials    ${custom user}    ${custom pwd}
    Click on scroll down button
    Click on link    	Customized Database User Details
    Vaildate the user details page
    Logout from Adminui
    # [Teardown]    Test teardown

    
TC_32_Verify check box in install feature links in adminui page
    Launch the AdminUI page in browser
    Login to Adminui
    Verify the Adminui Homepage is displayed
    Click on link    Install Features
	${is_Feature_installation_required}=    Verify the Install features available
    Sleep    2s
	IF    ${is_Feature_installation_required} == True
	    Selecting the features
        Sleep    3s
        Click on scroll down
        Enter root password    ${Eniq-s password}   ${root password}
        Click on button    Install
        #Increase the sleep time as for feature selected
        Sleep    35min
        Vaildating the AdminUI page    Feature Installation Overview - INSTALLATION SUCCESSFUL
        Vaildating the AdminUI page    COMPLETED
        Enter root password    commitpassword       ${root password}    
        Click on button    ${commit button}    
        Vaildating the AdminUI page    Feature Commit Overview - FEATURE COMMIT IN PROGRESS
        Sleep    2min
        Vaildating the AdminUI page    This site can’t be reached
        Sleep    5min
        Reload Page
        Verify the Adminui Login page is displayed    
        Logout from Adminui
	END
	${is_features_already_installed}=    Verify the Install Features not available    
	Skip If    $is_features_already_installed    No Features to install.Test was skipped
	Logout from Adminui

    


TC_33_Verify check box install feature links in adminui page for privileged user
    [Tags]    Adminui
    Connect to physical server as root user
    Execute the command    ${privileged_script}    
    Execute the command    ${Enable ENIQ Privileged User}
    Execute the command    1
    Execute the command   ${non_rootuser}
    Enter the password    ${non_rootpass}
    Sleep    10s
    Launch the AdminUI page in browser
    Login to Adminui
    Verify the Adminui Homepage is displayed
    Click on link    Install Features
    Verify the checkbox install feature links and install the feature    ${non_rootuser}    ${non_rootpass}
    # [Teardown]    Test teardown

    
*** Test Cases ***
TC_34_Verify check box in update features links in adminui page for privileged user with use of normal root user
    [Tags]    Adminui
    Connect to physical server as root user
    Execute the command    ${privileged_script}    
    Execute the command    ${Enable ENIQ Privileged User}
    Execute the command    1
    Execute the command    manuser
    Execute the command    Ericsson@123
    Sleep    10s
    Launch the AdminUI page in browser
    Login to Adminui
    Verify the Adminui Homepage is displayed
    Click on link    Update Features
    Select the feature    ${DSC PM Tech Pack}   
    Click on scroll down
    Click on button    Continue
    Enter username and password    root    Plat@8399
    Click on button    Update
    sleep    25min
    Vaildating the AdminUI page    Feature Update Overview - UPDATE SUCCESSFUL
    Vaildating the AdminUI page    COMPLETED
    Enter commit username and password    root    Plat@8399      
    Click on button    ${commit button}    
    Vaildating the AdminUI page    Feature Commit Overview - FEATURE COMMIT IN PROGRESS
    Sleep    2min
    Vaildating the AdminUI page    This site can’t be reached
    Sleep    5min
    Reload Page
    Verify the Adminui Login page is displayed
    Close Browser
    Sleep    10s
    Connect to physical server as non-root user
    Execute the command    su - root
    Execute the command    ${root_pwd}
    Execute the command    ${privileged_script}
    Execute the command    ${Rollback ENIQ Privileged User}
    ${Rollback_msg}=    Execute the command    y
    Verify the msg    ${Rollback_msg}    Successfully completed Rollback Admin group stage
    # [Teardown]    Test teardown

    

TC_35_Verify check box install feature links in adminui page for privileged user with use of normal root user
    [Tags]    Adminui
    Connect to physical server as root user
    Execute the command    ${privileged_script}    
    Execute the command    ${Enable ENIQ Privileged User}
    Execute the command    1
    Execute the command   ${non_rootuser}
    Enter the password    ${non_rootpass}
    Sleep    10s
    Launch the AdminUI page in browser
    Login to Adminui
    Verify the Adminui Homepage is displayed
    Click on link    Install Features
    Verify the checkbox install feature links and install the feature    ${root_user}    ${root_pwd}  
    # [Teardown]    Test teardown

TC_36_Verify precheck link in adminui page by providing dcuser credentials 
    [Tags]    Adminui
    Connect to physical server as root user
    Execute the command    ${privileged_script}    
    Execute the command    ${Enable ENIQ Privileged User}
    Execute the command    1
    Execute the command   ${non_rootuser}
    Enter the password    ${non_rootpass}
    Sleep    10s
    Launch the AdminUI page in browser
    Login to Adminui
    Verify the Adminui Homepage is displayed
    Click on link    Pre Check
    Enter Precheck username and password    ${user_for_vapp}    ${pass_for_vapp}
    Click on button    Start
    Page Should Contain    Incorrect Username or password
    Logout from Adminui
    Execute the command    su - root
    Execute the command    ${root_pwd}
    Execute the command    ${privileged_script}
    Execute the command    ${Rollback ENIQ Privileged User}
    ${Rollback_msg}=    Execute the command    y
    Verify the msg    ${Rollback_msg}    Successfully completed Rollback Admin group stage
    # [Teardown]    Test teardown

    


TC_37_Verify check box install feature links in adminui page by providing dcuser credentials 
    [Tags]    Adminui
    Connect to physical server as root user
    Execute the command    ${privileged_script}    
    Execute the command    ${Enable ENIQ Privileged User}
    Execute the command    1
    Execute the command   ${non_rootuser}
    Enter the password    ${non_rootpass}
    Sleep    10s
    Launch the AdminUI page in browser
    Login to Adminui
    Verify the Adminui Homepage is displayed
    Click on link    Install Features
    ${is_features_already_installed}=    Verify the Install Features not available
    ${is_Feature_installation_required}=    Verify the Install features available
    Sleep    2s
	IF    ${is_Feature_installation_required} == True
        Selecting the features
        Sleep    3s
        Click on scroll down
        Enter Privileged commit username and password    ${user_for_vapp}    ${pass_for_vapp}
        Click on button    Install
        Execute JavaScript    window.scrollTo(0, document.body.scrollHeight)
        Page Should Contain    Incorrect Username or password
        Logout from Adminui
        Connect to physical server as non-root user
        Execute the command    su - root
        Execute the command    ${root_pwd}
        Execute the command    ${privileged_script}
        Execute the command    ${Rollback ENIQ Privileged User}
        ${Rollback_msg}=    Execute the command    y
        Verify the msg    ${Rollback_msg}    Successfully completed Rollback Admin group stage
    ELSE
        Page Should Contain    There are no features for installation    
		Logout from Adminui
        Execute the command    su - root
        Execute the command    ${root_pwd}
        Execute the command    ${privileged_script}
        Execute the command    ${Rollback ENIQ Privileged User}
        ${Rollback_msg}=    Execute the command    y
        Verify the msg    ${Rollback_msg}    Successfully completed Rollback Admin group stage
        Skip If    ${is_features_already_installed}    No Features to install.Test was skipped     
    END
    # [Teardown]    Test teardown

    

TC_38_Verify check box update feature and install feature links in adminui page give the dcuser credentials 
    [Tags]    Adminui
    Connect to physical server as root user
    Execute the command    ${privileged_script}    
    Execute the command    ${Enable ENIQ Privileged User}
    Execute the command    1
    Execute the command    ${non_rootuser}
    Enter the password    ${non_rootpass}
    Sleep    10s
    Launch the AdminUI page in browser
    Login to Adminui
    Verify the Adminui Homepage is displayed
    Click on link    Update Features
    Select the feature    ${DSC PM Tech Pack}   
    Click on scroll down
    Click on button    Continue
    Enter username and password    ${user_for_vapp}    ${pass_for_vapp}
    Click on button    Update
    Page Should Contain    Incorrect Username or password
    Logout from Adminui
    Execute the command    su - root
    Execute the command    ${root_pwd}
    Execute the command    ${privileged_script}
    Execute the command    ${Rollback ENIQ Privileged User}
    ${Rollback_msg}=    Execute the command    y
    Verify the msg    ${Rollback_msg}    Successfully completed Rollback Admin group stage
    # [Teardown]    Test teardown


    
*** Keywords ***
Suite setup steps
    Set Screenshot Directory    ./Screenshots  

Test teardown
    Capture Page Screenshot
    Close Browser

    
Validate Login To Adminui With wrong crdentials 
    [Arguments]      ${data}
    Launch the AdminUI page in browser
    ${user_name}=      Replace String     ${data}[Username]    @user    ${USERNAME}
    Log    ${user_name}
    ${password}=      Replace String     ${data}[Password]    @password    ${PASSWORD}
    Log    ${password}
    Input Username       ${user_name}
    Input Pass       ${password}
    Sleep    10s
    Click On Submit Button
    Sleep    5s
    Verify the Adminui page with invaild credentials
    Click on link    Login
    Login To Adminui
    [Teardown]    Test teardown    

Suite setup steps
    RPA.Browser.Selenium.Set Screenshot Directory   ./Screenshots

Test teardown
    RPA.Browser.Selenium.Capture page screenshot
    RPA.Browser.Selenium.Close Browser


Verify the login of adminui with updated password
    Verify the change password in command line    ${password id}
    Verify the adminui login page    ${New password}

Verify the change password in command line
    [Arguments]    ${change password}    
    Enter a Username for which password need to be changed    ${newuser id}
    ${output}=    Enter the password    ${change password}
    Validating the password   ${output}    ${existing matching password} 
    ${output}=    Enter the password    ${New password}
    Validating the password   ${output}    ${updated password}
    #Note : Vaildating webserver restart    $session input
    #Note : session input = 0. No argument passed (Default)
    Vaildating webserver restart    0
    Sleep    10s
    
Verify the adminui login page
    [Arguments]    ${Login password}
    Launch the AdminUI page in browser
    Login To Adminui with New credentials    ${newuser id}    ${Login password}
    Logout from Adminui
    [Teardown]    Test teardown

Deleting the newly created user
    Go to the folder    ${installer path}
    Execute the command    ${tomcat remove_user}
    Execute the command    ${newuser id}
    ${output}=    Enter the password    ${New password}
    ${output}=    Read    delay=5s
    Validating the password    ${output}    ${removeuser_password check}
    Vaildating webserver restart    0
    Sleep    10s
    Test teardown

      
    

Change Password in AdminUI Page
    [Arguments]    ${oldpwd}    ${newpwd}
    Launch the AdminUI page in browser
    Login To Adminui with credentials    ${USERNAME}    ${oldpwd}
    Click on scroll down button
    Click on link    Change Password
    Enter Input    ${oldPasswordId}    ${oldpwd}
    Enter Input    ${newPasswordId}    ${newpwd}
    Enter Input    ${confirmNewPasswordId}    ${newpwd}
    Select Show Password 
    Click On Submit Button
    Validate the update message    ${paswordChangeMsg}
    Sleep     100s
    Refresh Page Until launch page
    [Teardown]    Test teardown