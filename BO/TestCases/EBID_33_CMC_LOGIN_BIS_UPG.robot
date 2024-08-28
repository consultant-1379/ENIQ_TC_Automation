****Settings****
Library              RPA.Browser.Selenium
Library             RPA.Robocorp.Process

*** Variables ***
${hostname}
${cms_pw}
${login_to_CMC}        https://${hostname}:8443/BOE/CMC/    

*** Test Cases ***
CMC launch and login check    
    Open Available Browser     ${login_to_CMC}       
    Click Button    //button[@id="details-button"]
    Click Link    //a[@id="proceed-link"]
    Select Frame    servletBridgeIframe
    RPA.Browser.Selenium.Input Text     //*[@name="_id2:logon:CMS"]     ${hostname}:6400
    RPA.Browser.Selenium.Input Text    //*[@name="_id2:logon:USERNAME"]     Administrator
    Input password     //*[@id="_id2:logon:PASSWORD"]    ${cms_pw}
    Click Button     //*[@id="_id2:logon:logonButton"]
    Click Link    javascript:logoffCMC();
    Close Browser