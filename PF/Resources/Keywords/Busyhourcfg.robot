*** Keywords ***

click on busy hour configuration link and navigate to busy hour configuration window
    click on busy hour configuration link    //a[text()='Busy Hour Configuration']
    navigate to busy hour configuration window
    Sleep    2s

click on busy hour configuration link
    [Arguments]    ${busy_hour_config_link}
    Click Element    ${busy_hour_config_link}

Verifying busy hour configuration page is opened
    Page Should Contain    Source Tech Pack:

navigate to busy hour configuration window
    Switch Window    locator=NEW

select the teckpacks from the dropdown
    Select From List By Index    //td//select[@id='select_techpacks']    1

click on show button
    Click Element    //input[@value='Show']

verify enabling and disabling of placeholders
    ${Is_start_button_enabled}=    check start button is enabled
    Skip If    ${Is_start_button_enabled} == False
    ${info_message}=    click on start or stop button with respect to buttons    ${Is_start_button_enabled}
    verify enabled or disabled message    ${Is_start_button_enabled}    ${info_message}
    Busyhourcfg.navigate to main page
    
click on source techpack link
    Click Element    //div[@id="busyhour"][1]

check start button is enabled
    ${Is_start_button_enabled}=    Run Keyword And Return Status    Page Should Contain Element    //img[@src='../img/start_task.png']
    [Return]    ${Is_start_button_enabled}

click on start or stop button with respect to buttons
    [Arguments]    ${Is_start_button_enabled}
    ${info_message}    Set Variable    
    IF    $Is_start_button_enabled == True
        click on start button
    ELSE
        click on stop button
    END
    Sleep    2s
    ${info_message}=    Get Text    //*[@class="info_message"]
    [Return]    ${info_message}

click on start button
    Click Element    //img[@src='../img/start_task.png']

click on stop button
    Click Element    //img[@src='../img/stop_task.png']

verify enabled or disabled message
    [Arguments]    ${Is_start_button_enabled}    ${info_message}
    IF    $Is_start_button_enabled == True
        Should Contain    ${info_message}    enabled
    ELSE
        Should Contain    ${info_message}    disabled
    END

navigate to main page
    Switch Window    locator=MAIN


