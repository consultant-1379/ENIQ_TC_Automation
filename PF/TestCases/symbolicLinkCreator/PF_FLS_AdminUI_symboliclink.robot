*** Settings ***
Documentation       Testing Symboliclinkcreator

Library             RPA.Browser.Selenium
Library             SSHLibrary
Library             String
Library             Collections
Resource            ../../Resources/Keywords/FLS_keywords.robot
Resource            ../../Resources/Keywords/Cli.robot
Resource            ../../Resources/Keywords/Variables.robot
Resource            ../../Resources/Keywords/AdminUIWebUI.robot

Test Setup          Connect to server as a dcuser
Test Teardown       Close All Connections


*** Test Cases ***
TC 05 verifying if fls latest module is present on adminUI page
    AdminUIWebUI.Launch the AdminUI page in browser
    AdminUIWebUI.Login To Adminui
    Click Link    Monitoring Commands
    Verifying if latest fls module is present on adminUI page.

TC 24 Verify status of fls in AdminUI Webpage
    AdminUIWebUI.Launch the AdminUI page in browser
    Verify the Adminui Login page is displayed
    AdminUIWebUI.Login To Adminui
    Click Link    Certificate Expiry Details
    Verify validity of fls license in adminUI Webpage

Checking Granularity configuration
    [Tags]    fls
    Launch the AdminUI page in browser for ${Login_AdminUI_URL_6082}
    AdminUIWebUI.Login To Adminui
    Change Granularity and verifyng the querying of data
    [Teardown]    Test teardown


*** Keywords ***
Suite setup steps
    Set Screenshot Directory    ./Screenshots

Test teardown
    Capture Page Screenshot
    Close Browser

clicking the Granularity configuration from menu bar
    RPA.Browser.Selenium.Click Element    //a[text()='Granularity Configuration' and @class='menulink']
    RPA.Browser.Selenium.Wait Until Page Contains Element    //form//a[text()='Granularity Configuration']
    ${minute_value}=    RPA.Browser.Selenium.Get Value
    ...    //td[contains(text(),'CCDM')]/following-sibling::td//select//option[@selected]
    IF    "${minute_value}" == "${one_minute}"
        RPA.Browser.Selenium.Select From List By Value
        ...    //td[contains(text(),'CCDM')]/following-sibling::td//select
        ...    5MIN
    ELSE
        RPA.Browser.Selenium.Select From List By Value
        ...    //td[contains(text(),'CCDM')]/following-sibling::td//select
        ...    1MIN
    END
    RPA.Browser.Selenium.Click Element    //input[@value='Continue']
    RPA.Browser.Selenium.Wait Until Page Contains Element    //input[@value='Submit']
    RPA.Browser.Selenium.Click Element    //input[@value='Submit']
    RPA.Browser.Selenium.Wait Until Page Contains Element
    ...    //h3[text()='Granularity configuration changed successfully.']

Change Granularity and verifyng the querying of data
    clicking the Granularity configuration from menu bar
    AdminUIWebUI.Logout From Adminui




