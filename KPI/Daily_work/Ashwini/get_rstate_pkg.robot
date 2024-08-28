*** Settings ***
Library           RPA.Browser.Selenium

*** Variables ***
${package}        'BO_E_RBS'
${url}            https://clearcase-eniq.seli.wh.rnd.internal.ericsson.com/eniqdel

*** Tasks ***
getting the R-State of the mentioned package
    Open Available Browser    ${url}    headless=True
    Maximize Browser Window
    Click Link    //body//tr[last()-1]//td[2]//a
    Click Link    //body//tr[last()-1]//td[2]//a
    ${loc}    Get Location
    Go To    ${loc}SOLARIS_baseline.html
    ${rstate}    Get Text    //table//a[text()=${package}]/../following-sibling::td[3]
    Log To Console    ${\n}R-State of ${Package} is = ${rstate}
    Log To Console    sdiwiudnw