*** Settings ***
Documentation     Testing Monitoring
Library    RPA.Browser.Selenium   
Resource    ../../Resources/Keywords/AdminUIWebUI.robot
Resource    ../../Resources/Keywords/Variables.robot
Suite setup       Suite setup steps



*** Test Cases ***
Verify the data loading status using adminui
    Launch the AdminUI page in browser
    Login to Adminui
    Click on link    ETLC Set History
    Select the techpack and Loader in Adminui page
    Sleep    10s
    ${Success_msg}=    Get Text    //tr//td[contains(text(),"Load") and contains(text(),"table") and contains(text(),"returned.") and contains(text(),"1") and contains(text(),"rows") and contains(text(),"loaded.")]
    Log To Console    ${Success_msg}
    Click on link    Show Loadings
    Select the techpackname
    Verify the Loader page in adminui
    Logout from Adminui
    [Teardown]    Test teardown

*** Keywords ***
Suite setup steps
    Set Screenshot Directory    ./Screenshots  

Test teardown
    Capture Page Screenshot
    Close Browser