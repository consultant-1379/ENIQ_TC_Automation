*** Settings ***
Library    RPA.Browser.Selenium
Library    Dialogs
Library    String
Library    OperatingSystem
*** Variables ***
${clearcase}    https://clearcase-eniq.seli.wh.rnd.internal.ericsson.com/eniqdel 
${p}    DC_E_CCRC      

*** Test Cases ***
Open Clearcase and Download latest package file
    ${user}     Get Environment Variable    username
    Set Download Directory    C:\\Users\\${user}\\Downloads
    Open Available Browser    ${clearcase}    
    Maximize Browser Window        
    Click Link    xpath=//body//tr[last()-1]//td[2]//a   
    Click Link    xpath=//body//tr[last()-1]//td[2]//a   
    ${loc}    Get Location
    Go To    ${loc}SOLARIS_baseline.html 
    Click Link    xpath=//a[text()='${p}'] 
    Wait Until Created    C:\\Users\\${user}\\Downloads\\${p}*.tpi    


     
       