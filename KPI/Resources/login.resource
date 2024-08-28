*** Settings ***
Library           SSHLibrary
Library           RPA.Browser.Selenium
Library           String
Library           OperatingSystem
# Library           ../TestCases/TechPackFT/servertp.py
Library           ./keywords.py
*** Variables ***
${host}    atvts4095.athtem.eei.ericsson.se
${port}    2251
${uname}     dcuser
${pwd}       Dcuser%12
${root_user}    root
${root_pwd}    shroot12
${eniqServices}    eniq-engine eniq-dwhdb eniq-lwphelper eniq-repdb eniq-scheduler eniq-webserver
${password_db}      Dwhrep12#
${username}      dwhrep
${database}      repdb
${clearcase_url}            https://clearcase-eniq.seli.wh.rnd.internal.ericsson.com/eniqdel
${urlNexusConst}       https://arm1s11-eiffel013.eiffel.gic.ericsson.se:8443/nexus/content/repositories/releases/com/ericsson/eniq/stats/tp
${arg2}           _
${pkg}            DC_E_ERBS
${package}        '${pkg}'
${sql_query_fortopo}      select TECHPACKNAME from  TechPackDependency where VERSIONID LIKE '${pkg}:%'and TECHPACKNAME!='DWH_BASE' and TECHPACKNAME!='DWH_MONITOR';
${run}     go
${url_tp}            https://${host}:8443/adminui/servlet/TPInstallation
${index}
${pkgnamerbl}
*** Keywords ***
Open Connection And Log In
    ${index}    Open Connection    ${host}      port=${port}    timeout=10
    Set Global Variable    ${index}
    Login               ${uname}        ${pwd}

Open connection as root user
    Open Connection    ${host}      port=${port}    timeout=10
    Login    ${root_user}    ${root_pwd}
Open clearcasevobs
    Open Available Browser    ${clearcase_url}    
    Maximize Browser Window
    Click Link    //body//tr[last()-1]//td[2]//a
    Click Link    //body//tr[last()-1]//td[2]//a
    ${loc}    Get Location
    ${solarisLink}    Set Variable      ${loc}SOLARIS_baseline.html
    Set Global Variable    ${solarisLink}
    Go To    ${loc}SOLARIS_baseline.html
get the current user Environment
    ${user}     Get Environment Variable    username
    Set Global Variable      ${user}
getting the R-State of the mentioned package
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
    Go To    ${solarisLink}
    ${currentpkg}=    Get Element Attribute     xpath=//a[text()='${package}']    href
    Open Connection    atvts4051.athtem.eei.ericsson.se
    Login               root        shroot
    Write    rm -rf tppkg ; mkdir tppkg ; cd tppkg ; wget ${currentpkg} ; pwd
    Read    delay=10s

# checking eniq status
#     Write    systemctl status ${eniqServices} | grep active 
#     ${out}=    Read    delay=1s
#     Show Status Eniqs    ${out}    ${eniqServices}

login to the adminui
    Go To    https://${host}:8443/adminui/servlet/CommandLine    
    Click Button    //button[@id='details-button']     
    Click Link    //a[@id='proceed-link']     
    Input Text     //input[@name="userName"]     eniq
    Input Password     //input[@name="userPassword"]     TPKPIteam
    Click Button     //*[@id="submit"]
 
Installing TP
    [Arguments]    ${pkgtmp}
    Write    cd /eniq/sw/installer
    Write    ./tp_installer -p . -t ${pkgtmp}
    ${out}=    Read    delay=1s
    #Log To Console    ${out}
# Checking For Errors In Log Files
#     Checking Errors In Log File    ${pkg}
 
Checking r state of interface 
    Click Link    //a[contains(text(),'ETLC Set Scheduling')]

check the dependent topotp
    Write    echo -e "${sql_query_fortopo}\\n${run}\\n" | isql -P ${password_db} -U ${username} -S ${database} -b
    ${output}=    Read    delay=3s
    Log To Console    ${output}
    ${deptopopkg}     Filter Topotp name     ${output}
    Set Global Variable    ${deptopopkg}

downloading btft file on server
    [Arguments]    ${tmp}
    Open Connection    atvts4051.athtem.eei.ericsson.se
    Login               root        shroot
    Write    rm -rf tppkg ; mkdir tppkg ; cd tppkg ; wget ${tmp} ; pwd
    ${name}=    Fetch From Right    ${tmp}    /
    Read    delay=30s
    Switch Connection    ${index}  
    Put File    /root/tppkg/${name}     /eniq/home/dcuser

full package name
    Open Available Browser     https://clearcase-eniq.seli.wh.rnd.internal.ericsson.com/eniqdel    headless=true
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
    ${pkgnamerb}    Catenate     SEPARATOR=_    ${pkg}    ${rstate}    ${buildno}
    Set Global Variable      ${pkgnamerb}
    Close Browser