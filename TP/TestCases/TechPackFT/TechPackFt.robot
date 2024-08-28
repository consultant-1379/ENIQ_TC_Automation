*** Settings ***
Library           RPA.Browser.Selenium
Library           String
Library           OperatingSystem
Library           ./servertp.py
Library           SSHLibrary
Resource          H:/ENIQ_TC_Automation/TP/Resources/Keywords/Tp_Installer.robot
Resource          ../../Resources/login.resource
Test Setup        Open Connection And Log In
Test Teardown     Close All Connections

*** Variables ***
${package}        'DC_E_NR'
${pkg}            DC_E_NR
${url}            https://clearcase-eniq.seli.wh.rnd.internal.ericsson.com/eniqdel
${urlNexusConst}       https://arm1s11-eiffel013.eiffel.gic.ericsson.se:8443/nexus/content/repositories/releases/com/ericsson/eniq/stats/tp
${arg2}           _
${server}         atvts4043


*** Test Cases ***
Tasks to be performed
  Open Available Browser    ${url}
  getting the R-State of the mentioned package
  verification of r-state of fd in nexus and vobs

    
    



*** Keywords ***
 getting the R-State of the mentioned package
    ${user}     Get Environment Variable    username
    Set Global Variable      ${user}
    Open Available Browser    ${url}    
    Maximize Browser Window
    Click Link    //body//tr[last()-1]//td[2]//a
    Click Link    //body//tr[last()-1]//td[2]//a
    ${loc}    Get Location
    Set Global Variable      ${loc}
    Go To    ${loc}SOLARIS_baseline.html
    ${buildno}    Get Element Attribute    //table//a[text()=${package}]    href
    ${buildno}    Fetch From Right  ${buildno}  _
    Set Global Variable      ${buildno}
    ${rstate}    Get Text    //table//a[text()=${package}]/../following-sibling::td[3]
    Set Global Variable      ${rstate}
    ${pkgname}    Catenate     SEPARATOR=_    ${pkg}    ${rstate}    ${buildno}
    Set Global Variable      ${pkgname}
    Log To Console    ${\n}R-State of ${Package} is = ${rstate}
 
 verification of r-state of fd in nexus and vobs
    ${repo}    Fetch From Right  ${pkg}    -
    ${etl}    Convert To Lower Case  ${repo}
    ${etlnew}    Catenate     SEPARATOR=_      ${etl}      etl
    ${urlNexus}    Catenate    SEPARATOR=/    ${urlNexusConst}    ${repo}    ${etlnew}    FD    ${rstate}
    Go To    ${urlNexus}
    ${notValidation}    Does Page Contain    404
    IF    ${notValidation} == False
          Log To Console     This ${rstate} is present
    ELSE
          Log To Console     This ${rstate} is not present
    END
 
 Downloading TP from vobs
    [Arguments]    ${package}
    Go To    ${loc}SOLARIS_baseline.html
    Click Link    xpath=//a[text()=${package}]

 checking eniq status
    Write    systemctl status ${eniqServices} | grep active 
    ${out}=    Read    delay=1s
    Show Status Eniqs    ${out}    ${eniqServices}

 login to the adminui
    Go To    https://${server}.athtem.eei.ericsson.se:8443/adminui/servlet/CommandLine    
    Click Button    //button[@id='details-button']     
    Click Link    //a[@id='proceed-link']     
    Input Text     //input[@name="userName"]     eniq
    Input Password     //input[@name="userPassword"]     TPKPIteam
    Click Element     id:submit
 
 
 Installing TP
    Write    cd /eniq/sw/installer
    Write    ./tp_installer -p . -t ${pkg}
    ${out}=    Read    delay=1s
    #Log To Console    ${out}
 Checking For Errors In Log Files
    Checking Errors In Log File    ${pkg}
 
 Checking r state of interface 
    Click Link    //a[contains(text(),'ETLC Set Scheduling')]