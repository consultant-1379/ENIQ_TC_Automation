*** Settings ***
Library    RPA.Browser.Selenium
Resource    ../Resources/login.resource
*** Variables ***
${url}            https://${host}:8443/adminui/servlet/TPInstallation
${arg2}           R10A_b11
*** Test Cases ***
test1
    Open Available Browser    ${url} 
    Capture Page Screenshot    
    Click Button    //button[@id='details-button']   
    Click Link    //a[@id='proceed-link']     
    Input Text     //*[@name="userName"]     eniq
    Input Password     //*[@name="userPassword"]     TPKPIteam
    Click Button     //*[@id="submit"]
    ${rstate}    Get Text    //table//tr//td[text()=${package}]/following-sibling::td[2]
    Log To Console    ${\n}${rstate}
    Click Link    //a[text()='Logout']
	