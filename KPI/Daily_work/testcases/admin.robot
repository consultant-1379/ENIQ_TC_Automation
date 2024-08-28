*** Settings ***
Library    RPA.Browser.Selenium
*** Test Cases ***
test1
    Open Available Browser    https://atvts4112.athtem.eei.ericsson.se:8443/adminui/servlet/LoaderStatusServlet     
    Click Button    //button[@id='details-button']     
    Click Link    //a[@id='proceed-link']     
    Input Text     //input[@name="userName"]     eniq
    Input Password     //input[@name="userPassword"]     eniq
    Click Element     id:submit
    # FOR    ${counter}    IN RANGE    1    8       
    #     Click Element    (//img[@alt='On' and @src='../img/green_bulp.gif'])[${counter}]
        
    # END