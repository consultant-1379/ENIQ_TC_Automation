*** Keywords ***

Wait For Elements
    RPA.Browser.Selenium.Wait Until Element Is Visible    xpath://*[@id='username'] 
    RPA.Browser.Selenium.Wait Until Element Is Visible    xpath://*[@id='password'] 
    RPA.Browser.Selenium.Wait Until Element Is Visible    xpath://*[@type='submit']
    
Launch the AdminUI page in browser
    # ${chrome_options}=    Evaluate    sys.modules['selenium.webdriver'].ChromeOptions()    sys
    # Call Method    ${chrome_options}    add_argument    --ignore-certificate-errors
    # Log    ${EXEC_DIR}
    # RPA.Browser.Selenium.Create Webdriver    Chrome    executable_path=${EXEC_DIR}/PF/Resources/Drivers/chromedriver.exe    chrome_options=${chrome_options}
    # RPA.Browser.Selenium.Go To    ${Login_AdminUI_URL}
    Open Available Browser    ${Login_AdminUI_URL}    options=set_capability("acceptInsecureCerts", True)
    RPA.Browser.Selenium.Maximize Browser Window
    RPA.Browser.Selenium.Set Selenium Speed    ${DELAY}
    # RPA.Browser.Selenium.Click Button  id:details-button
    # RPA.Browser.Selenium.Click Link    id:proceed-link
    Sleep    5s
    RPA.Browser.Selenium.Maximize Browser Window
    Wait For Elements

Launch the AdminUI page in browser for ${URL}
    Open Available Browser    ${URL}    
    RPA.Browser.Selenium.Maximize Browser Window
    RPA.Browser.Selenium.Set Selenium Speed    ${DELAY}
    RPA.Browser.Selenium.Click Button  id:details-button
    RPA.Browser.Selenium.Click Link    id:proceed-link
    Sleep    5s
	AdminUIWebUI.Wait For Elements
        
Login to Adminui as a Tomcat user
    Wait For Elements
    Input Username    ${username_01}
    Input Pass    ${password_02}    
    Click On Submit Button
    
Launch the AdminUI page in Firefox browser
    # ${firefox_options}=    Evaluate    sys.modules['selenium.webdriver'].FirefoxOptions()      sys
	# Call Method    ${firefox_options}    add_argument    --ignore-certificate-errors
	# Log    ${EXEC_DIR}
	# RPA.Browser.Selenium.Create Webdriver    Firefox    executable_path=${EXEC_DIR}/PF/Resources/Drivers/geckodriver.exe     
    #${index}=	Open Available Browser	${Login_AdminUI_URL}	browser_selection=Mozilla
    Open Available Browser    ${Login_AdminUI_URL}    options=set_capability("acceptInsecureCerts", True)    browser_selection=Firefox,Chrome
    Sleep    5
    RPA.Browser.Selenium.Maximize Browser Window
    Sleep    5
    RPA.Browser.Selenium.capture page screenshot

	
	
Login To Adminui
    AdminUIWebUI.Wait For Elements
    AdminUIWebUI.Input Username    ${USERNAME}
    AdminUIWebUI.Input Pass    ${PASSWORD}
    Click On Submit Button
	Sleep    5s
    ${IsElementVisible}=    Run Keyword And Return Status     alert should be present    Alert Text: Engine is set to NoLoads
    Run Keyword If    ${IsElementVisible}    handle alert    accept
    RPA.Browser.Selenium.Wait Until Page Contains    HARDWARE
	
Login To Adminui for Physical server
    Wait For Elements
    Input Username    ${USERNAME_8399}
    Input Pass    ${PASSWORD_8399}
    Click On Submit Button
	
Login To Adminui in firefox
    Wait For Elements
    Input Username    ${USERNAME}
    Input Pass    ${PASSWORD}
    Click On Submit Button
    Sleep    10s
    RPA.Browser.Selenium.Wait Until Page Contains    Maximum session limit
	
Login To Adminui with credentials
    [Arguments]    ${USERNAME}    ${oldpwd}
    Wait For Elements
    Input Username    ${USERNAME}      
    Input pass    ${oldpwd}    
    Sleep    2s
    Click On Submit Button
    
verifying adminui page is displayed
    RPA.Browser.Selenium.Page Should Contain    Host Information
    
Verify the adminui page in Login page section
    [Arguments]    ${Login password}
    Login To Adminui with credentials    ${newuser id}    ${Login password}

Deleting the newly created user
    ${output}=    Enter the password    ${password id}
    ${output}=    Read    delay=5s
    Validating the password    ${output}    ${removeuser_password check}
    Vaildating webserver restart    0
    Sleep    10s

Verify the login of adminui with newly created tomcat user
    ${output}=    Enter the password    ${password id}
    Vaildating webserver restart    0
    Sleep    10s

Create new user for Adminui login
    ${output}=    Enter the password    ${password id}
    Vaildating webserver restart    0
    Sleep    10s
    
Verify the login of adminui with newly created user
    ${output}=    Enter the password    ${password id}
    Vaildating webserver restart    0
    Sleep    10s
    
Login To Adminui with New credentials
    [Arguments]    ${user id}    ${pwd}
    Wait For Elements
    Input Username    ${user id}   
    Input pass    ${pwd}
    Sleep    2s
    Click On Submit Button

Click on scroll down button
    Execute Javascript    window.scrollTo(0,2000)
    Sleep    2s
    
Click on scroll up button
    Execute Javascript    window.scrollTo(0,0)
    Sleep    2s

Launch the Adminui Page in browser with IP Address and port number 
    Open Available Browser    ${LOGIN URL WITH IP}
    RPA.Browser.Selenium.Maximize Browser Window
    Set Selenium Speed    ${DELAY}
    Click Button  id:details-button
    Click Link    id:proceed-link
    Sleep    2
    # ${chrome_options}=    Evaluate    sys.modules['selenium.webdriver'].ChromeOptions()    sys
    # Call Method    ${chrome_options}    add_argument    --ignore-certificate-errors
    # Log    ${EXEC_DIR}
    # RPA.Browser.Selenium.Create Webdriver    Chrome    executable_path=${EXEC_DIR}/PF/Resources/Drivers/chromedriver.exe    chrome_options=${chrome_options}
    # RPA.Browser.Selenium.Go To    ${LOGIN URL WITH IP}
    # Sleep    5s
    RPA.Browser.Selenium.Maximize Browser Window
    Wait For Elements
	
Launch the Adminui page in browser with IP Address and wrong port number
    # ${chrome_options}=    Evaluate    sys.modules['selenium.webdriver'].ChromeOptions()    sys
    # Call Method    ${chrome_options}    add_argument    --ignore-certificate-errors
    # Log    ${EXEC_DIR}
    # RPA.Browser.Selenium.Create Webdriver    Chrome    executable_path=${EXEC_DIR}/PF/Resources/Drivers/chromedriver.exe    chrome_options=${chrome_options}
    Open Available Browser    ${LOGIN URL WITH IP}
    RPA.Browser.Selenium.Maximize Browser Window
    ${status}    Run Keyword And Return Status    RPA.Browser.Selenium.Go To    ${LOGIN URL WITH WRONG PORT}       
    IF    ${status}
        Log    ${\n}URL is opening
        Fail
    ELSE
        Log    ${\n}URL is not opening
    END
	
Launch in Chrome
    RPA.Browser.Selenium.Open Browser    ${Login_AdminUI_URL}    ${CHROME BROWSER}
    RPA.Browser.Selenium.Maximize Browser Window
    RPA.Browser.Selenium.Set Selenium Speed    ${DELAY}
    RPA.Browser.Selenium.Click Button  id:details-button
    RPA.Browser.Selenium.Click Link    id:proceed-link
    Wait For Elements
    
Input Username
    [Arguments]    ${USERNAME}
    RPA.Browser.Selenium.Input Text    id:username    ${USERNAME}

Input Pass
    [Arguments]    ${PASSWORD}
    RPA.Browser.Selenium.Input Text    id:password    ${PASSWORD}
	
Click On Submit Button
    RPA.Browser.Selenium.Click Button    xpath://*[@type='submit']

Verify Login Page of AdminUI is Displayed
     RPA.Browser.Selenium.Title Should Be    Ericsson Network IQ

Verify Home Page Is Displayed
    RPA.Browser.Selenium.Page Should Contain    You are logged in as:
 
Verify Maximun session Limit error message is displayed
    Page Should Contain    Maximum session limit for eniq has exceeded

Logout from Adminui
    RPA.Browser.Selenium.Click Link    link:Logout
    RPA.Browser.Selenium.Page Should Contain    You have logged out.
    RPA.Browser.Selenium.Capture page screenshot

Verify the Adminui Login page is displayed
    Page Should Contain    Management Interface - Login
    RPA.Browser.Selenium.Capture page screenshot
    
Verify the Adminui Homepage is displayed
    Page Should Contain    HARDWARE
    RPA.Browser.Selenium.Capture page screenshot
    
Verify the All Subcategories in Adminui Homepage is displayed 
    Page Should Contain    System Monitoring
    Page Should Contain    System Status
    Page Should Contain    ETLC Monitoring
    Page Should Contain    ETLC Set History
    Page Should Contain    ETLC Set Scheduling
    Page Should Contain    Monitoring Commands
    Page Should Contain    Eniq Monitoring Services
    Page Should Contain    TechPack Installation
    Page Should Contain    FM Alarm

    Page Should Contain    ENM Interworking
    Page Should Contain    Granularity Configuration
    Page Should Contain    Role Assignment Tool

    Page Should Contain    Feature Version Manager
    Page Should Contain    Pre Check
    Page Should Contain    Update Features
    Page Should Contain    Install Features
    Page Should Contain    Report Extraction

    Page Should Contain    Data Flow Monitoring
    Page Should Contain    Show Loadings
    Page Should Contain    Show Aggregations
    Page Should Contain    Reaggregation
    Page Should Contain    Session Logs

    Page Should Contain    Data Verification
    Page Should Contain    Data Row Info
    Page Should Contain    Data Row Summary
    Page Should Contain    Show Reference Tables
    Page Should Contain    Busy Hour Information
    Page Should Contain    RANKBH Information

    Page Should Contain    Configuration
    Page Should Contain    Monitoring Rules
    Page Should Contain    Monitored Types
    Page Should Contain    Type Configuration
    Page Should Contain    DWH Configuration
    Page Should Contain    Logging Configuration
    Page Should Contain    Polling Start Time
    Page Should Contain    EBS Upgrader
    Page Should Contain    Busy Hour Configuration

Click on link
    [Arguments]    ${link_name}
    Click Link    ${link_name}
    Sleep    3s

Verify the System Status page displayed
    Page Should Contain    DATABASE
    
    
Verify the ETLC Monitoring page displayed
    Page Should Contain    Running ETL Sets
    
Verify the ETLC Set History page displayed
    Page Should Contain    ETLC Set History
    
Verify the ETLC Set Scheduling page displayed
    Page Should Contain    ETLC Set Scheduling
    
Verify the Monitoring Commands page displayed
    Page Should Contain    Select command from list
    
Verify the TechPack Installation page displayed
    ${No_techpack_installtion}=    Run Keyword And Return Status        Page Should Contain    No Tech Pack Installation In Progress
    IF    ${No_techpack_installtion} == True
        Log    No Tech Pack Installation In Progress
    ELSE
        Page Should Contain    Pre-install Processes and Checks Running
    END
    
Verify the FM Alarm page displayed
    Page Should Contain    FM Alarm
    
Verify the Granularity Configuration page displayed
    Page Should Contain     Default Granularity
    
Verify the Custom Nodes page displayed
    Page Should Contain    No Custom node Configuration found.
    
Verify the Role Assignment Tool page displayed
    Page Should Contain    Role Assignment Tool
    
Verify the Pre Check page displayed
    Page Should Contain    Pre Check 
    
Verify the Update Features page displayed
    Page Should Contain    Feature Software Path
    
Verify the Install Features page displayed
    ${install_Feature}=    Run Keyword And Return Status        Page Should Contain    Feature Availability Summary for Install of Teckpack Features
    IF    ${install_Feature} == True
        Log    Feature Availability Summary for Install of Teckpack Features
    ELSE
        Page Should Contain    There are no features for installation
    END
    
Verify the Report Extraction page displayed
    Page Should Contain    Feature Software Path
    
Verify the Show Loadings page displayed
    Page Should Contain    Color symbols
    
Verify the Show Aggregations page displayed
    Page Should Contain    Tech Pack
    
Verify the Reaggregation page displayed
    Page Should Contain    Time level
    
Verify the Session Logs page displayed 
    Page Should Contain    Select date from which you wish to fetch session logs
    
Verify the Data Row Info page displayed
    Page Should Contain    Tech Pack
    
Verify the Data Row Summary page displayed
    Page Should Contain    Tech Pack
    
Verify the Show Reference Tables page displayed
    Page Should Contain    Select table
    
Verify the Busy Hour Information page displayed
    Page Should Contain    Available BH Tables
    
Verify the RANKBH Information page displayed
    Page Should Contain    RANKBH Tables
    
Verify the Monitoring Rules page displayed
    Page Should Contain    Tech Pack
    
Verify the Monitored Types page displayed
    Page Should Contain    Tech Pack
    
Verify the Type Configuration page displayed
    Page Should Contain    Tablelevel
    
Verify the DWH Configuration page displayed
    Page Should Contain    Time Based Partition
    
Verify the Logging Configuration page displayed
    Page Should Contain    Default logging
    
Verify the Polling Start Time page displayed
    Page Should Contain    Interface Name
    
Verify the EBS Upgrader page displayed
    Page Should Contain    Configured EBS Upgrades
    
Verify the Busy Hour Configuration page displayed
    Page Should Contain    Busy Hour Configuration
    
Switch window to new Busyhour tab
    Switch Window    new
    
Switch window to back to Adminui tab
    Switch Window    main
    
Verify the Adminui page with invaild credentials
    Page Should Contain    Login failed, please check your username and password                       

Go to the folder
    [Arguments]    ${command}
    Write    ${command}
    ${output}=    Read    delay=2s
    Log     ${output}
    [Return]    ${output}
   
Execute the command
    [Arguments]    ${command}
    Write    ${command}
    ${output}=    Read    delay=2s
    Log     ${output}
    [Return]    ${output}
    
Enter the password
   [Arguments]    ${command}
    ${output}=    Write    ${command}
    [Return]    ${output}
    
Verify the output
    [Arguments]    ${output}    ${value_to_search}
    Log    ${output}
    Should Contain    ${output}    ${value_to_search}

Validating the password
    [Arguments]    ${output}    ${password check}    
    Log    ${output}
    Should Contain    ${output}    ${password check}

Verify the error message in browser
    RPA.Browser.Selenium.Page Should Contain    This site can’t be reached
    
Vaildating the Adminui page session
    [Arguments]    ${output}    ${session}
    Log    ${output}
    Should Contain    ${output}    ${session}
    
Vaildating webserver restart
    [Arguments]    ${session input}
    Write    ${session input} ${\n}
    ${output}=    Read    delay=10 min
    Should Contain    ${output}    Webserver restarted successfully
    
Vaildate the number of Logon sessions
    [Arguments]    ${session}
    Log    ${session}
    Should Contain    ${session}    ${Logon_session_msg}
    
Vaildate the number of Logon sessions updated
    [Arguments]    ${session}
    Log    ${session}
    Should Contain    ${session}    ${Logon_session_updated_msg}

Vaildate the user session timeout
    [Arguments]    ${session}
    Log    ${session}
    Should Contain    ${session}    ${User_session_timeout}      
     
Refresh Page until page contains the element
    Reload Page
    
click on Legal Notice Message
    Click on link  
    
Enter a Username for which password need to be changed
    [Arguments]    ${command}
    Write    ${command}
    ${output}=    Read    delay=2s
    Log     ${output}
    [Return]    ${output}
    
Vaildating the number session_timeout
    [Arguments]    ${command}
    Write    ${command}
    ${output}=    Read    delay=2s
    Log     ${output}
    [Return]    ${output}
           
Enter Input
    [Arguments]    ${page_input_text_id}    ${page_input_text_name}
    RPA.Browser.Selenium.Input Text    id:${page_input_text_id}    ${page_input_text_name}
	
Select Show Password 
    Click Element    //input[@type="checkbox"]
    Sleep    1s 

Validate the update message
    [Arguments]    ${updatemsg}
    Page Should Contain    ${updatemsg}
    RPA.Browser.Selenium.Capture page screenshot    EMBED

Click on scroll down
    Execute Javascript    window.scrollTo(0,3500)
    Sleep    2s

Select the feature
    [Arguments]    ${Update_feature}
    Click Element    ${Update_feature}
    Sleep    2s
	
Click on button
    [Arguments]    ${continue_name}
    RPA.BROWSER.Selenium.Click button    ${continue_name}
    Sleep    2s

Vaildate the Feature updated
    [Arguments]    ${Feature update}
    Page Should Contain    ${Feature update overview}

Validating the file
    [Arguments]    ${file content}    ${updated file content}
    Should Contain    ${file content}    ${updated file content}

Select from dropdown
    [Arguments]    ${time level}
    Select From List By Value    //select[@value='${time level}']    ${time level}
    
Click on aggregation
    Click Element    //input[@name='checkall']
    Sleep    2s
    Click Element    //input[@name='aggregate']
    
Vaildate the user details page
    Page Should Contain    Never Expires
    Page Should Contain    ${custom user}
    
Vaildating the AdminUI page 
    [Arguments]    ${text message}
    Page Should Contain    ${text message}

Get current date in dd.mm.yyyy result_format
    ${currentdatefmt} =    Get Current Date    result_format=%d.%m.%Y
    Log    ${currentdatefmt}
    [Return]    ${currentdatefmt}   

Grep message from file
    [Arguments]   ${msg_to_grep}    ${user_file}    
    ${msg_count}=    Write    grep -irc '${msg_to_grep}' ${user_file}
    Log    ${msg_count}
    ${output}=    Read    delay=1s
    Log    ${output}
    [Return]     ${output}
    
verify for no errors in logs 
    [Arguments]   ${output}
    Should Contain    ${output}    0
    #Just to make sure it shouldnot contain any timestamp format in output
    Should Not Contain    ${output}    0.
    #Should Not Contain    ${output}    .0
    Should Not Contain    ${output}    :0
    Should Not Contain    ${output}    0:
    

Get latest file 
    [Arguments]    ${latestfile}
    Write    ls -Art ${latestfile} | tail -n 1
    ${output}=    Read    delay=2s
    Log    ${output}
    [Return]    ${output}										 


Verifying services status in pre check link
   
    FOR    ${element}    IN    @{list_of_ALL_services}
        ${precheck_text}    Get Text    //pre[contains(text(),'${element}')]//font
        Should Contain Any    ${precheck_text}    SUCCESS    FAILURE    WARNING    NO RUN
    END

Click on pre check link under feature vision manager
    Click Element    //a[text()='Pre Check']
    
Click on user manual link
    Click Element    //a[text()='User Manual'] 
    Sleep    5s
    
Navigate to usemanual page
    Switch Window    locator=NEW
    Set Selenium Speed    2s

Navigate to main page
    Switch Window    locator=MAIN
    Set Selenium Speed    2s

Verifying user manual page is opened
    Page Should Contain     SYSTEM ADMINISTRATOR GUIDE
 
Setting the time in adminui page
    [Arguments]    ${time}
    ${str1}=    Catenate    ${session_timeout_min}    m
    Log    ${str1}

Selecting the features
    FOR    ${element}    IN    @{install_feature}
        ${present}=    Run Keyword And Return Status    Element Should Be Visible    id=${element}   
        
        IF    $present == True
            Click Element    id=${element}
            Exit For Loop
        END
        
    END

Verify the msg
    [Arguments]    ${cmd_output}    ${msg}
    Log    ${cmd_output}
    Should Contain    ${cmd_output}    ${msg}

Verify the Install features available
    ${installed_status_01}=    Run Keyword And Return Status    Page Should Contain    Feature Software Path
    ${installed_status_01}=    Convert To String    ${installed_status_01}
    [Return]    ${installed_status_01}

Verify the Install Features not available
    ${installed_status}=    Run Keyword And Return Status    Page Should Contain    There are no features for installation
    ${installed_status}=    Convert To String    ${installed_status}
    [Return]    ${installed_status}                          

Get the session count     
    [Arguments]    ${sessionDetails}  
    Log    ${sessionDetails}  
    ${words}=    Split String    ${sessionDetails}    :    1
    Log    ${words}
    ${word2}=    Get From List     ${words}    1
    ${words_2}=    Split String    ${word2}    eniqs    
    Log    ${words_2}
    ${word1}=    Get From List     ${words_2}    0
    Log    ${word1}
    ${count}=    Strip String    ${word1}
    [Return]    ${count}
    
Verify the Adminui Legal Notice message
    [Arguments]    ${legal_message}
    Page Should Contain   ${legal_message}

   
Enter username and password
    [Arguments]    ${user}    ${pass}
    RPA.Browser.Selenium.Input Text    id:username    ${user}          
    RPA.Browser.Selenium.Input Text    id:updatepassword    ${pass}

Editing the Legal notice msg
    [Arguments]    ${Legal_msg_input_text_name}
    RPA.Browser.Selenium.Input Text    id:lwmsg    ${Legal_msg_input_text_name}

Enter root password
    [Arguments]    ${Root_password_input_text_id}    ${Root_password_input_text_name}
    RPA.Browser.Selenium.Input Text    id:${Root_password_input_text_id}    ${Root_password_input_text_name}

Enter commit username and password
    [Arguments]    ${user_01}   ${commit_pwd}
    RPA.Browser.Selenium.Input Text    id:username    ${user_01}          
    RPA.Browser.Selenium.Input Text    id:commitpassword    ${commit_pwd}
    
Enter Privileged commit username and password
    [Arguments]    ${page-input-text-id}    ${page-input-text-name}
    RPA.Browser.Selenium.Input Text    id:username    ${page-input-text-id}          
    RPA.Browser.Selenium.Input Text    id:installcompletepwd    ${page-input-text-name}
   
Get the Legal Notice msg
    [Arguments]    ${latest_msg}
    ${output}=    Get text    ${latest_msg}
    [Return]    ${output} 
  
Verify the checkbox install feature links and install the feature
    [Arguments]    ${user_name}    ${pass_word}      
    ${is_features_already_installed}=    Verify the Install Features not available
    ${is_Feature_installation_required}=    Verify the Install features available
    Sleep    2s
	IF    ${is_Feature_installation_required} == True
        Selecting the features
        Sleep    3s
        Click on scroll down
        Enter username and password    ${user_name}    ${pass_word}
        Click on button    Install
        #Increase the sleep time as for feature selected
        Sleep    50min
        Vaildating the AdminUI page    Feature Installation Overview - INSTALLATION SUCCESSFUL
        Vaildating the AdminUI page    COMPLETED
        Enter Privileged commit username and password    ${user_name}    ${pass_word}      
        Click on button    ${commit button} 
        Vaildating the AdminUI page    Feature Commit Overview - FEATURE COMMIT IN PROGRESS
        Sleep    2min
        Vaildating the AdminUI page    This site can’t be reached
        Sleep    5min
        Reload Page
        Verify the Adminui Login page is displayed
        Sleep    2s
        Run keyword and Ignore Error    Connect to physical server as root user
        Run keyword and Ignore Error    Connect to server as a dcuser    
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

Enter Precheck username and password
    [Arguments]    ${user_name}    ${pass_word}
    RPA.Browser.Selenium.Input Text    id:username    ${user_name}         
    RPA.Browser.Selenium.Input Text    id:precheckpassword    ${pass_word}

Wait for Legal notice page input text box
    Wait Until Page Contains Element    id:lwmsg    timeout=50s

Refresh Page Until launch page
    ${Reload}=  Run Keyword And Return Status  RPA.Browser.Selenium.Page Should Contain    Management Interface - Login
    WHILE    ${Reload} != ${TRUE}
        Reload Page
        ${Reload}=  Run Keyword And Return Status  RPA.Browser.Selenium.Page Should Contain    Management Interface - Login
    END   
    RPA.Browser.Selenium.Capture page screenshot

Verify the Report Extraction error
    Page Should Contain    Reports Extracted to /eniq/sw/installer/boreports.
    RPA.Browser.Selenium.Capture page screenshot
    
Verify the Precheck Summary page
    Page Should Contain    PreCheck Summary Report
    RPA.Browser.Selenium.Capture page screenshot
    
Wait Until Precheck Summary Report is displayed
    Sleep    5s
    Wait Until Element Contains    //*[@id="precheck_mainForm"]/font[1]/b    PreCheck Summary Report    timeout=40s 
    Sleep    5s

Verify the counter volume information in Adminui
    Page Should Contain    Counter Volume  

Verify the tomcat user creation
    [Arguments]    ${USERNAME}    ${PASSWORD}
    Write    /eniq/sw/installer/manage_tomcat_user.bsh -A ADD_USER
    ${output}=    Read    delay=2s
    Log To Console    ${output}
    Write    ${USERNAME}
    ${output}=    Read    delay=2s
    Log To Console    ${output}
    ${user_already_exists}=    Run Keyword And Return Status    Should Contain    ${output}    please provide a new user to add
    Log To Console    ${user_already_exists}    
    IF    ${user_already_exists} == True
        Log To Console    User already exists
    ELSE
        Write    ${PASSWORD}
        ${output}=    Read    delay=200s
        Log To Console    ${output}
        Should Contain    ${output}    Webserver restarted successfully
    END

Select the set type and package name
    Select From List By Value    name:settype    Maintenance
    Select From List By Value    name:packageSets    DWH_MONITOR
    Click Element    //*[@id="ttable"]/tbody/tr[10]/td[5]/font/a
    Sleep    10s 

Verify the DWH_MONITOR page is displayed
    Page Should Contain    DWH_MONITOR

Select the techpack and Loader in Adminui page 
    Select From List By Label    name:selectedpack    DC_E_ERBSG2
    Select From List By Label    name:selectedsettype    Loader
    Click on button    Search
    Click Element    //table[2]/tbody/tr[3]/td[1]

Select the techpackname 
    Select From List By Label    name:techPackName    DC_E_ERBSG2
    Click on button    //input[@name="getInfoButton"]
    Sleep    10s
    Click Element    //table[3]//tbody/tr[2]
    Sleep    5s 

Verify the Loader page in adminui
    Sleep    10s
    Page Should Contain    Loaded

Increasing the adminui sessions
    Write    /eniq/sw/installer/adminui_sessions.bsh -A SET_SESSIONS
    ${output}=    Read    delay=2s
    Write    10
    ${output_1}=    Read    delay=200s
    Should Contain    ${output_1}    Webserver restarted successfully      

Set webpage selenium speed
    Set Selenium Speed    0.5s

Logout from Adminui if logged in
    # ${check_adminuilogout_link}=    Run Keyword And Return Status    Page Should contain element    //a[text()="Logout"]
    # IF    ${check_adminuilogout_link} == True
    #     RPA.Browser.Selenium.Click Link    link:Logout
    #     RPA.Browser.Selenium.Page Should Contain    You have logged out.
    #     RPA.Browser.Selenium.Capture page screenshot      
    # END
    ${check_adminuilogout_link}=    Run Keyword And Return Status    Page Should contain element    //a[text()="Logout"]
    IF    ${check_adminuilogout_link} == True
        RPA.Browser.Selenium.Click Link    link:Logout
        RPA.Browser.Selenium.Wait Until Page Contains    logged out   timeout=40s     
    END

Login To Adminui with invalid password
    AdminUIWebUI.Wait For Elements
    AdminUIWebUI.Input Username    platform
    AdminUIWebUI.Input Pass    platform1234
    Click On Submit Button
	Sleep    5s
    click link    Login

Login To Adminui with invalid passwords
    AdminUIWebUI.Wait For Elements
    AdminUIWebUI.Input Username    platform
    AdminUIWebUI.Input Pass    platform1234
    Click On Submit Button
	Sleep    5s

# Login to Adminui with default adminui user and password
#     AdminUIWebUI.Wait For Elements
#     AdminUIWebUI.Input Username    ${default_adminui_username}
#     AdminUIWebUI.Input Pass    ${default_adminui_password}
#     Click On Submit Button
# 	# Sleep    5s
#     ${IsElementVisible}=    Run Keyword And Return Status     alert should be present    Alert Text: Engine is set to NoLoads
#     Run Keyword If    ${IsElementVisible}    handle alert    accept
#     Wait Until Page Contains    change    timeout=20s

# Verify Adminui page contain change default password
#     Page Should Contain    change the password    

# Launch the AdminUI page for default user and password
#     # Open Available Browser    ${Login_AdminUI_URL}    options=set_capability("acceptInsecureCerts", True);add_argument("--incognito")
#     Open Available Browser    ${Login_AdminUI_URL}    options=set_capability("acceptInsecureCerts", True);add_argument("--guest")
#     RPA.Browser.Selenium.Maximize Browser Window
#     RPA.Browser.Selenium.Set Selenium Speed    ${DELAY}
#     Sleep    5s
#     RPA.Browser.Selenium.Maximize Browser Window
#     Wait For Elements

   
    
Login to Adminui with default adminui user and password
    Set webpage selenium speed
    Input Username    ${default_adminui_username}
    Input Pass    ${default_adminui_password}
    Click On Submit Button
    Sleep    2s
    ${IsElementVisible}=    Run Keyword And Return Status     alert should be present    Alert Text: Engine is set to NoLoads
    Run Keyword If    ${IsElementVisible}    handle alert    accept
    Capture Page Screenshot
        

Verify Adminui page contain change default password
    ${check_text}=    Run Keyword And Return Status    Page Should Contain Element    //font[contains(text(),'change the password')]
    IF    ${check_text} == True
        Pass Execution    Adminui change password showing for default creds
    ELSE
        ${check_correct_creds}=    Run Keyword And Return Status    Page Should Contain Element    //font[contains(text(),'Login failed') or contains(text(),'locked') or contains(text(),'exceeded')]
        IF    ${check_correct_creds} == True
            Skip 
        ELSE
            Wait Until Page Contains Element    //button[text()='System Status']    timeout=40s
            Fail    Adminui not showing change password for default creds 
        END
        
    END

Launch Adminui webpage with default creds   
    Set webpage selenium speed
    # Open Available Browser    ${Login_AdminUI_URL}    options=set_capability("acceptInsecureCerts", True)    headless=True
    Open Available Browser    ${Login_AdminUI_URL}    options=set_capability("acceptInsecureCerts", True)    browser_selection=Firefox,chrome
    RPA.Browser.Selenium.Maximize Browser Window
    Sleep    2s
    Wait For Elements

Logout from Adminui default webpage if logged in
    Set webpage selenium speed
    ${check_adminuilogout_link}=    Run Keyword And Return Status    Page Should contain element    //a[text()="Logout"]
    IF    ${check_adminuilogout_link} == True
        RPA.Browser.Selenium.Click Link    link:Logout
        Sleep    2s
        RPA.Browser.Selenium.Wait Until Page Contains    logged out    timeout=10s
        RPA.Browser.Selenium.Capture page screenshot      
    END