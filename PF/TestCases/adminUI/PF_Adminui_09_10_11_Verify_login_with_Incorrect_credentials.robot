*** Settings ***
Documentation     Testing AdminUI web
Library    RPA.Browser.Selenium
Library           OperatingSystem
Library           String
Resource    ../../Resources/Keywords/AdminUIWebUI.robot
Resource    ../../Resources/Keywords/Variables.robot
Library           ${EXEC_DIR}/PF/Resources/Libraries/DynamicTestcases.py
Suite setup       Suite setup steps




*** Test Cases ***
Verify Login to AdminUI with incorrect credentials
    [Tags]  adminui
    Log		${EXEC_DIR}
    ${json}=    OperatingSystem.get file    ${EXEC_DIR}/PF/Resources/Data/adminui/invalidCredentials.json
    &{object}=    Evaluate     json.loads('''${json}''')     json
    FOR   ${key}   IN  @{object.keys()}
        Add Test Case    ${key}   Validate Login To Adminui With wrong crdentials      ${object}[${key}]
    END

*** Keywords ***  
Validate Login To Adminui With wrong crdentials 
    [Arguments]      ${data}
    Launch the AdminUI page in browser
    ${user_name}=        Replace String     ${data}[Username]    @user    ${USERNAME}
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
    