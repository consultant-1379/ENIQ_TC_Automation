****Settings****
Library              RPA.Browser.Selenium
Library             RPA.Robocorp.Process

*** Variables ***
${hostname}    
${cms_pw}    
${login_to_BILP}        https://${hostname}:8443/BOE/BI/    

*** Test Cases ***
BILP launch and login check
    Open Available Browser     ${login_to_BILP}       
    Click Button    //button[@id="details-button"]
    Click Link    //a[@id="proceed-link"]
    Select Frame    servletBridgeIframe
    RPA.Browser.Selenium.Input Text     //*[@id="__input0-inner"]     ${hostname}:6400
    RPA.Browser.Selenium.Input Text    //*[@id="__input3-inner"]     Administrator
    Input password     //*[@id="__input4-inner"]    ${cms_pw}
    Click Element    id:__button1-inner
    Sleep    2s
    Click Element If Visible    //bdi[text()="Close"]
    Sleep    2s
    Click Element    //span[@id='avatar']
    Click Element When Visible    //span[@id='avatar']
    Click Element    //div[text()="Log out"]
    Close Browser