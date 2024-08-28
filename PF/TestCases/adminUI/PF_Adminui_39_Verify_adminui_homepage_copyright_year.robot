*** Settings ***
Documentation     Testing AdminUI web
Library    RPA.Browser.Selenium
Library    DateTime
Resource    ../../Resources/Keywords/AdminUIWebUI.robot
Resource    ../../Resources/Keywords/Variables.robot
Resource    ../../Resources/Keywords/Cli.robot
Suite setup       Suite setup steps
Suite Teardown    Close All Browsers    


*** Test Cases ***
Verify Adminui homepage copyright year
    Launch the AdminUI page in browser
    Login to Adminui
    Verify the Adminui Homepage is displayed    
    ${adminui_date}=	Get Current Date	result_format=%Y
    Log To Console    ${adminui_date}
    Page Should Contain Element    xpath://table[@class="footer"]//td/font[contains(text(),"Copyright by Ericsson © ${adminui_date}")]
    [Teardown]    Logout from Adminui
    
*** Keywords ***
Suite setup steps
    Set Screenshot Directory    ./Screenshots


