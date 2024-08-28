*** Settings ***
Library    ..\\tp.py
Library    RPA.Browser.Selenium    auto_close=${FALSE}
Library    String
Library    Collections
*** Variables ***
${package} =     BO_E_AFG
# ${package} =     ERIC_MTAS_Basic_Report_Package_R20A03
${server} =     4134
${username}    Administrator
${password}    Shroot12
${server_name}    ATCLVM887:6400
*** Tasks ***
Common BO Testcases
    Importing the LCMBIAR File
    ${package_is_report}    Evaluate    'Report_Package' in '${package}'
    IF  ${package_is_report}   
        Log To Console    ${\n}Input package is Report Package, Running Report TC
    Refreshing the Reports
    ELSE
        Log To Console    ${\n}Input package is BO Package, Running BO TC
        Check the Universe after Promotion
    END
*** Keywords ***
Importing the LCMBIAR File
    ${pkg_name_last}    Split String From Right    ${package}    _
    ${lcmbiar_file_path}    Lcmbiar File Transfer To Local    ${package}    ${server}  
    ${aa}    Split String From Right    ${lcmbiar_file_path}    /
    ${lcm_file_name}    Split String From Right    ${aa}[-1]    .
    Set Global Variable    ${lcm_file_name}
    Open Available Browser    https://atclvm887:8443/BOE/CMC      
    Maximize Browser Window
    Click Button    //button[@id="details-button"]
    Click Link    //a[@id="proceed-link"]
    Select Frame    //iframe[@name="servletBridgeIframe"]
    Input Text    //input[@id="_id2:logon:USERNAME"]     ${username}
    Input Password    //input[@id="_id2:logon:PASSWORD"]    ${password}
    Click Button    //input[@type='submit']
    Unselect Frame
    Select Frame    //iframe[@id="contentFrame"]
    Select Frame    //frame[@name="innerContent"]
    Click Link    //a[text()='Promotion Management']
    Unselect Frame
    Select Frame    //iframe[@id="contentFrame"]
    Select Frame    //frame[@name="innerContent"]
    Select Frame    //iframe[@id="homeFrame"]
    Click Element    //div[text()='Import']
    click Element    //span[@title="Import file"]
    Unselect Frame
    Select Frame    //iframe[@name="dlgContainer0"]
    Wait Until Page Contains Element    //input[@id="uploadedFile"]
    Choose File    //input[@id="uploadedFile"]    ${lcmbiar_file_path}
    Click Element    //input[@name='ok']
    Unselect Frame
    Select Frame    //iframe[@id="contentFrame"]
    Select Frame    //frame[@name="innerContent"]
    Select Frame    //iframe[@id="sdkframe"]
    Select Frame    //iframe[@name="JobViewFrame"]
    Sleep    5
    Scroll Element Into View    //button[@name="Create"]
    ${confirmation0}    Does Page Contain Element    //a[@id="destinationCMSLogin" and text()='Log Off']
    IF    ${confirmation0}
        Run Keyword Until Success    Click Element    //button[@name="Create"]
    ELSE
        Select From List By Value    //select[@name="destinationSystem"]    changeCMS
        Unselect Frame
        Select Frame    //iframe[@name="dlgContainer0"]
        Input Text    //input[@name='cmsName']    ${server_name}
        Input Text    //input[@name="userName"]    ${username}
        Input Password    //input[@name="password"]    ${password}
        Click Element    //input[@id="Login"]
        Sleep    2
        Unselect Frame
        Select Frame    //iframe[@id="contentFrame"]
        Select Frame    //frame[@name="innerContent"]
        Select Frame    //iframe[@id="sdkframe"]
        Select Frame    //iframe[@name="JobViewFrame"]
        Run Keyword Until Success    Click Element    //button[@name="Create"]
    END
    Sleep    5
    ${confirmation}    Does Page Contain Element    //button[text()='Yes']
    IF    ${confirmation}
        Click Element    //button[text()='Yes']
    END

############ Manage Dependency check ############
    Unselect Frame
    Select Frame    //iframe[@id="contentFrame"]
    Select Frame    //frame[@name="innerContent"]
    Select Frame    //iframe[@id="sdkframe"]
    Wait Until Page Contains Element    //span[text()='Manage Dependencies']   20
    Run Keyword Until Success    Click Element    //span[text()='Manage Dependencies']
    Unselect Frame
    Select Frame    //iframe[@name="dlgContainer0"]
    ${package_is_report}    Evaluate    'Report_Package' in '${package}'
    ${wid_file_names}    Create List
    IF  ${package_is_report}   
        Wait Until Page Contains Element    (//span[@title="Web Intelligence"]/../following-sibling::td[4])[1]    10
        ${count_wid}    Get Element Count    //span[@title="Web Intelligence"]/../following-sibling::td[4]
        FOR    ${i}    IN RANGE    1    ${count_wid}+1    
            ${txt}    Get Text    (//span[@title="Web Intelligence"]/../following-sibling::td[4])[${i}]
            ${wid_name}    Get Text    (//span[@title="Web Intelligence"]/../following-sibling::td[1]/span)[${i}]
            ${desc}    Evaluate    'Description' in '${wid_name}'
            IF    not ${desc}  
                Append To List    ${wid_file_names}    ${wid_name}  
            END
            IF   not '${txt}'=='No Dependents'
                Log To Console    ${\n}Something is Dependent in Manage Dependencies, Check the Screenshot in Report
                Fail
            END
        END
        # Log To Console    ${\n}${wid_file_names}
        Set Global Variable    ${wid_file_names}
    ELSE
        Wait Until Page Contains Element    (//span[@title="Universes"]/../following-sibling::td[4])[1]    10
        ${count_wid}    Get Element Count    //span[@title="Universes"]/../following-sibling::td[4]
        FOR    ${i}    IN RANGE    1    ${count_wid}+1    
            ${txt}    Get Text    (//span[@title="Universes"]/../following-sibling::td[4])[${i}]
            IF   not '${txt}'=='No Dependents'
                Log To Console    ${\n}There is some Dependency in Manage Dependencies tab, Check the Screenshot in Report
                Fail
            END
        END
    END
    Unselect Frame
    Wait Until Page Contains Element    //iframe[@name="dlgContainer0"]   20
    Select Frame    //iframe[@name="dlgContainer0"]
    Wait Until Page Contains Element    //span[contains(text(),'${lcmbiar_file_path}[-1]')]/../following-sibling::td[@class='lineatside']   20
    ${dependency}    Get Text    //span[contains(text(),'${lcmbiar_file_path}[-1]')]/../following-sibling::td[@class='lineatside']
    Click Element    //input[@value="Close"]
    Unselect frame

########## Promoting the lcmbiar file ###########
    Select Frame    //iframe[@id="contentFrame"]
    Select Frame    //frame[@name="innerContent"]
    Select Frame    //iframe[@id="sdkframe"]
    Click Element    //span[text()='Promote']
    Unselect Frame
    Wait Until Page Contains Element    //iframe[@name="dlgContainer0"]   20
    Select Frame    //iframe[@name="dlgContainer0"]
    Click Element    //input[@value='Promote']
    Unselect Frame
    Select Frame    //iframe[@id="contentFrame"]
    Select Frame    //frame[@name="innerContent"]
    Select Frame    //iframe[@id="homeFrame"]
    Sleep    3
    Wait Until Page Contains Element    (//div[text()='${lcm_file_name}[0]'])[1]/../following-sibling::td[1]/div
    ${status}    Get Text    (//div[text()='${lcm_file_name}[0]'])[1]/../following-sibling::td[1]/div
    Set Global Variable    ${status}

########### Refreshing the Page for Status ###########
    FOR    ${i}    IN RANGE    1000
        IF    ('${status}' == 'Created') or ('${status}' == 'Running')
            Unselect Frame
            Select Frame    //iframe[@id="contentFrame"]
            Select Frame    //frame[@name="innerContent"]
            Select Frame    //iframe[@id="homeFrame"]
            Click Element    //div[@id="IconImg_UniversalRepositoryExplorer_toolbarItem1_13"]
            Unselect Frame
            Select Frame    //iframe[@id="contentFrame"]
            Select Frame    //frame[@name="innerContent"]
            Select Frame    //iframe[@id="homeFrame"]
            ${status}    Get Text    (//div[text()='${lcm_file_name}[0]'])[1]/../following-sibling::td[1]/div    
            Sleep    1
        END
        IF    ('${status}' != 'Created') and ('${status}' != 'Running')    BREAK
    END
    IF    '${status}' == 'Success'
        Log To Console    ${\n}File=> *${aa}[1]* Promoted Successfully
    ELSE
        Fail    ${\n}File=> *${aa}[1]* NOT Promoted and status message is=> ${status}
    END
    ${date_of_unv_prom}    Get Text    (//div[text()='${lcm_file_name}[0]'])[1]/../following-sibling::td[3]/div    
    Set Global Variable    ${date_of_unv_prom}


Check the Universe after Promotion
    Unselect Frame
    Select From List By Label    //select[@id='navSelect']   Universes
    Select Frame    //iframe[@id="contentFrame"]
    Select Frame    //frame[@name="innerContent"]
    ${only_lcm_name}    Split String    ${lcm_file_name}[0]    _R
    ${pm}    Evaluate    'PM' in '${lcm_file_name}[0]'    
    IF    ${pm}
        ${date_of_unv_prom_after}    Get Text    //div[text()='${only_lcm_name}[0]']/../following-sibling::td[3]/div    
        Double Click Element    //div[text()='${only_lcm_name}[0]']/../following-sibling::td[3]/div
    ELSE
        ${date_of_unv_prom_after}    Get Text    //div[text()='${only_lcm_name}[0] PM']/../following-sibling::td[3]/div    
        Double Click Element    //div[text()='${only_lcm_name}[0] PM']/../following-sibling::td[3]/div
    END
    ${promoted}    Evaluate   '${date_of_unv_prom}'=='${date_of_unv_prom_after}'
    IF    ${promoted}
        Log To Console    ${\n}Dates are Matching, latest universe is present 	
    ELSE
        Fail    ${\n}Dates are Not Matching from promotion Management and Universes Page for the package-> ${only_lcm_name}[0]
    END
    Unselect Frame
    Select Frame    //iframe[@id="dlgNav0"]
    Click Element    //a[text()='Connections']
    Unselect Frame
    Select Frame    //iframe[@name="dlgContainer0"]
    Select Frame    //iframe[@name="frame1"]
    ${connection_name}    Get Text    //form[@action="univproperties.faces"]
    ${var1}    Evaluate    '${connection_name}' == ''
    IF    ${var1}    
        Log To Console    ${\n}Connection Field is Empty, All good
    ELSE
        Fail    ${\n}${connection_name} is showing up in Connection for package-> ${only_lcm_name}[0]
    END
    Unselect Frame
    Select Frame    //iframe[@name="dlgContainer0"]
    Click Element    //input[@value="Cancel"]

Refreshing the Reports
    # Attach Chrome Browser    3222
    # Switch Window    Central Management Console
    FOR    ${i}    IN    @{wid_file_names}
        Unselect Frame
        Select From List By Label    //select[@id='navSelect']   Universes
        Select From List By Label    //select[@id='navSelect']   Folders
        Select Frame    //iframe[@id="contentFrame"]
        Select Frame    //frame[@name="innerContent"]
        Input Text    //input[@type="text" and @maxlength="256"]    ${i}
        Click Element   	IconImg_UniversalRepositoryExplorer_toolbarItem0_4_searchButton
        Wait Until Page Contains Element    //div[text()='Web Intelligence']/../following-sibling::td[3]
        ${date_of_wid_files}    Get Text    //div[text()='Web Intelligence']/../following-sibling::td[3]
        ${date_equal}    Evaluate    '${date_of_unv_prom}'=='${date_of_wid_files}'
        IF   not ${date_equal}
            Fail    ${\n}Dates are not equal, check the Report.
        END
        Open Context Menu    //div[text()='Web Intelligence']/../preceding-sibling::td[1]
        Wait Until Page Contains Element    //a[@role="menuitem" and text()='View']
        Click Element    //a[@role="menuitem" and text()='View']
        Switch Window    NEW
        Maximize Browser Window
        Unselect Frame
        Select Frame    //iframe[@name="pingerFrame"]
        Wait Until Page Contains Element    //span[@id="__button61-img"]    10
        Run Keyword Until Success    Click Element    //span[@id="__button61-img"]
        Sleep    2
        ${err}    Does Page Contain Element    //span[text()='Error']
        IF    ${err}
            Fail    ${\n}Connection is not made, try making connection first.${\n}Check Screenshot
            Close Window
        END
        Wait Until Page Contains Element    //span[text()='First Date:']    20
        Run Keyword Until Success    Click Element    //span[text()='First Date:']
        Input Text    //input[@title="mm/dd/yyyy hh:mm:ss am/pm"]    9/4/2022
        Click Element    //button[@title="Add"]
        Click Element    //span[text()='Last Date:']
        Wait Until Page Contains Element    //bdi[text()='Last Date:']
        Input Text    //input[@title="mm/dd/yyyy hh:mm:ss am/pm"]    1/30/2023
        Click Element    //button[@title="Add"]
        ${raw}    Evaluate    'Raw' in '${i}'
        IF    ${raw}
            Click Element   	//span[text()='Please select at least one value']
            Wait Until Page Contains Element    //span[text()='Raw data']
            Click Element   	//span[text()='Raw data']
        END
        Click Element    //bdi[text()='Run']
        BREAK
        Run Keyword Until Success    click Element   //button[@title="More"]    
        Close Window
        Switch Window    Central Management Console
        # ${tab_name}    Get Title
        # Unselect Frame
        # Select Frame    //iframe[@id="contentFrame"]
        # Select Frame    //frame[@name="innerContent"]
    END
 
Run Keyword Until Success
    [Arguments]    ${keyword_name}    @{keyword_arguments}
    Wait Until Keyword Succeeds    50    1    ${keyword_name}    @{keyword_arguments}