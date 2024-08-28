*** Keywords ***
Get the element of dwhmanager attribute from clearcase
    Open Available Browser    ${clearcase_url}     headless=false
    Maximize Browser Window
    click link    //body//tr[last()-2]//td[2]//a
    ${dwhmanager_file}=    Get Element Attribute    //a[contains(text(),'dwhmanager')]    href
    Go To    ${dwhmanager_file}
    RETURN    ${dwhmanager_file}

Get dwhmanager Rstate from clearcase
    [Arguments]    ${dwhmanager_file}
    ${dwhmanager_zip_file}=    Fetch From Right    ${dwhmanager_file}    r_
    ${dwhmanager_rstate_buildno_clearcase}=    Fetch From Left    ${dwhmanager_zip_file}    .
    RETURN    ${dwhmanager_rstate_buildno_clearcase}

Get dwhmanager version from server
    ${rstate_8399}    Execute Command    cd /eniq/sw/installer && cat versiondb.properties | grep -i dwhmanager
    ${dwhmanager_rstate}    Split String    ${rstate_8399}    dwhmanager=
    ${dwhmanager_rstate_buildno_server}=    Get From List    ${dwhmanager_rstate}    -1
    ${output}    Remove String Using Regexp    ${dwhmanager_rstate_buildno_server}    .*dwhmanager\\S
    RETURN    ${output}

Verify the latest dwhmanager version is updated in versiondb.properties file
    [Arguments]    ${rstate_clearcase}    ${dwhmanager_rstate_8399}
    IF    '${rstate_clearcase}' == '${dwhmanager_rstate_8399}'
        RETURN    True
    ELSE
        RETURN    False
    END

Install latest dwhmanager package
    [Arguments]    ${dwhmanager_file}
    Execute Command     cd /eniq/sw/installer/ && rm -rf dwhmanager_*
    ${dwhmanager_zip_file}=    Fetch from Right    ${dwhmanager_file}    /
    Execute Command    cd /eniq/sw/installer/ && wget ${dwhmanager_file}
    Execute Command    cd /eniq/sw/installer/ && chmod u+x ${dwhmanager_zip_file}
    Write    cd /eniq/sw/installer/ ; ./platform_installer ${dwhmanager_zip_file}
    ${staus_dwhmanager}=    Read Until Prompt
    RETURN    ${staus_dwhmanager}

Verify Successfully installation of dwhmanager package
    [Arguments]    ${staus_dwhmanager}
    Should Contain    ${staus_dwhmanager}    Successfully installed
    
Verify the installation of latest dwhmanager package
    IF    '${rstate_status}' == 'True'
        Skip   dwhmanager version from clearcase and server is same hence skipping the installation of scheduler package of TC-1
    ELSE
        ${dwhmanager_file}    Get the element of dwhmanager attribute from clearcase
        ${staus_dwhmanager}    Install latest dwhmanager package     ${dwhmanager_file}
        Verify Successfully installation of dwhmanager package    ${staus_dwhmanager}
    END

Click on Show status details in ENIQ DWH
    Click Element    //font[contains(text(),'ENIQ DWH')]/parent::td/following-sibling::td//a[contains(text(),'Show status')]

Click on type configuration
    Click Element    //a[text()='Type Configuration']

Select Techpack
    Select From List By Index    //select[@name="type"]    3

Select Techlevel
    Select From List By Label    name:level    DAY

Click on DWH configuration
    Click Element    //a[text()='DWH Configuration']

Click on Show connection status details in ENIQ DWH
    Click Element    //font[contains(text(),'ENIQ DWH')]/parent::td/following-sibling::td//a[contains(text(),'connection status')]

navigate to IQ Connection status details window
    Switch Window    locator=NEW

Go to system monitoring and select installed modules
    Click Element    //a[text()='Monitoring Commands']
    Select From List By Label    name:command    Installed modules
    Click Button    //input[@type='submit']

# Click on System status
#     Click Element    //*[@id='system']

Verify Status is displayed
    [Arguments]    ${module_status_args}
    Page Should Contain Element    ${module_status_args}

navigate to database status detils window
    Switch Window    locator=NEW

Click on Show status details in ENIQ REP
    Click Element    //font[contains(text(),'ENIQ REP')]/parent::td/following-sibling::td//a[contains(text(),'Show status')]
    
Validate the output
    [Arguments]    ${output}    ${validate_msg}    
    Log    ${output}
    Should Contain    ${output}   ${validate_msg}

Click on Show connection status details in ENIQ REP
    Click Element    //font[contains(text(),'ENIQ REP')]/parent::td/following-sibling::td//a[contains(text(),'connection status')]

navigate to DWHREP IQ connection status details window
    Switch Window    locator=NEW

Click on IQ Multiplex status details in ENIQ DWH
    Click Element    //font[contains(text(),'ENIQ DWH')]/parent::td/following-sibling::td//a[contains(text(),'IQ Multiplex status Details')]
	
navigate to IQ Multiplex status details window
    Switch Window    locator=NEW
Click on System status
    Click Element    //*[@id='system']
Selecting the techpack
    Select From List By Label    //select[@name="type"]    DC_E_MTAS

Selecting the Techlevel
    Select From List By Label    name:level    RAW

Inactivate and activate the selected type
    Select Checkbox    //table[@border='1']//tr[3]//input
    Sleep    2s
    Click Button    //input[@name='inActivateSelected']
    Select Checkbox    //table[@border='1']//tr[3]//input
    Click Button    //input[@name='activateSelected']

Activate the selected type
    Select Checkbox    //table[@border='1']//tr[3]//input
    Sleep    2s
    Click Button    //input[@name='activateSelected']

Click on etlc set history and verify msg
    Click Link    //a[text()='ETLC Set History']
    Select From List By Label    //select[@name="selectedpack"]    DC_E_MTAS
    Select From List By Value    //select[@name="selectedsettype"]    Loader
    Click Button    //input[@value='Search']
    
Click on ETLC Set scheduling
    Click Element    //a[text()='ETLC Set Scheduling']

Verify the Dwh_manager status in adminui
    ${No_techpack_installtion}=    Run Keyword And Return Status    Verify Status is displayed    xpath://font[contains(text(),"ENIQ DWH")]/parent::td/preceding-sibling::td/img[@alt="Green"]
    IF    ${No_techpack_installtion} == True
        Log    Yellow colour status
    ELSE
        Verify Status is displayed    xpath://font[contains(text(),"ENIQ DWH")]/parent::td/preceding-sibling::td/img[@alt="Yellow"]
    END

Click on dwh configuration with pwd
    Click Element    //a[text()='DWH Configuration']
    Wait Until Page Contains Element    //input[@value="Login"]    timeout=20s
    Input Text    name:rootPassword    ${root_pwd}
    # Input Text    name:rootPassword    shroot12
    Click Button    Login
    Wait Until Page Contains Element    //b[contains(text(),'Partition plan')]/following::a[1]    timeout=20s    

Click partition plan column link and update url 
    Click Link    //b[contains(text(),'Partition plan')]/following::a[1]
    Wait Until Page Contains Element    //input[@value='Save']    timeout=20s
    ${get_partion_plan_url}    Get Location
    # Log To Console    ${get_partion_plan_url}
    Go To    ${get_partion_plan_url}@
    Wait Until Page Contains    You have logged out    timeout=20s

Click partition plan column link and update storage time
    Click Link    //b[contains(text(),'Partition plan')]/following::a[1]
    Wait Until Page Contains Element    //input[@value='Save']    timeout=20s
    Input Text    //input[@id='defaultStorageTime']    ab
    Click Element    //input[@value='Save']
    Alert Should Be Present    Storage time value is not numeric.
    Sleep    2s

   
Click on dwh configuration for privileged user
    [Arguments]    ${inputuser_args}    ${inputpwd_args}
    Click Element    //a[text()='DWH Configuration']
    Wait Until Page Contains Element    //input[@value="Login"]    timeout=20s
    Input Text    //input[@id="username"]    ${inputuser_args}
    Input Text    name:rootPassword    ${inputpwd_args}
    # Input Text    name:rootPassword    shroot12
    Click Button    Login
    Wait Until Page Contains Element    //b[contains(text(),'Partition plan')]/following::a[1]    timeout=20s   