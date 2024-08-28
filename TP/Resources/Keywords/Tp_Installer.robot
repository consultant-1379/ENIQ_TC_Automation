*** Settings ***
Library           RPA.Browser.Selenium
*** Keywords ***
login to adminui
    [Arguments]    ${server}
    Open Available Browser    https://${server}.athtem.eei.ericsson.se:8443/adminui/servlet/LoaderStatusServlet     
    Click Button    //button[@id='details-button']     
    Click Link    //a[@id='proceed-link']     
    Input Text     //input[@name="userName"]     eniq
    Input Password     //input[@name="userPassword"]     eniq
    Click Element     id:submit