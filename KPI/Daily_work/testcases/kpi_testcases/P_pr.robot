*** Settings ***
Library    RPA.Browser.Selenium
*** Variables ***
${url}=     https://clearcase-eniq.seli.wh.rnd.internal.ericsson.com/eniqdel
${xpath}=   xpath=//body//tr[last()-1]//td[2]//a
${package}=     ERIC_MSC_S_BC_Load_Statistics_Report_Package_R9A01
*** Test Cases ***
Verifying if Delivered Report Package is present or not
    Open Available Browser   ${url}
    Maximize Browser Window        
    Click Link    //body//tr[last()-1]//td[2]//a  
    Click Link    ${xpath}
    ${loc}=    Get Location
    Go To    ${loc}SOLARIS_baseline.html   
    ${ver}    Does Page Contain Link    locator=//a[contains(@href,'${package}.zip')]   
    IF    ${ver} == True
        Log To Console    message=${\n}Yes, ${package} is present${\n}
    ELSE
        Log To Console    message=${\n}No, ${package} is not present${\n}
    END
    