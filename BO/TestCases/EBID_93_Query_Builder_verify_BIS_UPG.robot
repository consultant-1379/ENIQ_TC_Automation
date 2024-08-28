****Settings****
Library              RPA.Browser.Selenium
Library             RPA.Robocorp.Process
Library    RPA.Dialogs

*** Variables ***
${hostname}
${pwd}
${Login_Qurybuilder}        https://${hostname}:8443/AdminTools/querybuilder/ie.jsp
${sample_query}    SELECT TOP 2000 SI_ID, SI_NAME FROM CI_INFOOBJECTS WHERE SI_KIND = 'Webi'

*** Test Cases ***
Query Builder Launch
    Open Available Browser     ${Login_Qurybuilder}
    Maximize Browser Window
    Click Button    //button[@id="details-button"]
    Click Link    //a[@id="proceed-link"]
    Sleep    3s
    RPA.Browser.Selenium.Input Text     //input[@name='aps']     ${hostname}
    RPA.Browser.Selenium.Input Text    //input[@name='usr']     Administrator
    Input Password    //input[@name='pwd']    ${pwd}
    Sleep    3s
    Click Button    //input[@type='submit']
    Sleep    3s
    Input Text    //textarea[@id='sqlStmt']    ${sample_query}
    Click Button    //input[@id='submit']
    Sleep    3s
    Wait Until Element Is Visible    //h2[.]
    Log To Console    Query Builder homepage dispalyed
    Sleep    3s
    Close Browser