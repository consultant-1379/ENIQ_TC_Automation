*** Settings ***
Library           RPA.Browser.Selenium
Library           String
Resource          ../Resources/login.resource

*** Tasks ***
getting the R-State of the mentioned package
    Open clearcasevobs
    ${rstate}    Get Text    //table//a[text()=${package}]/../following-sibling::td[3]
    #Log To Console    ${\n}R-State of ${Package} is = ${rstate}
    
 