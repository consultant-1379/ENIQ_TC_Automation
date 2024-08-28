*** Settings ***
Resource    ../Resources/login.resource
Test Setup        Open Connection And Log In
Test Teardown     Close All Connections   
*** Tasks ***
Downloading and installing epfg 
    Open clearcasevobs
    ${epfgpkgtmp}=    Get Element Attribute    //a[contains(text(),'epfg_ft')]    href
    ${epfgpkg}=    Fetch From Right    ${epfgpkgtmp}    /
    ${epfgrstate}=    Fetch From Right    ${epfgpkg}    _
    ${epfgrstate}=    Catenate    SEPARATOR=    epfg_    ${epfgrstate}
    Log To Console    ${index}
    Open Connection    atvts4051.athtem.eei.ericsson.se
    Login               root        shroot
    Write    rm -rf tppkg ; mkdir tppkg ; cd tppkg ; wget ${epfgpkgtmp} ; pwd
    Read    delay=10s
    Switch Connection    ${index}  
    Put File    /root/tppkg/${epfgpkg}     /eniq/home/dcuser
    Write    cd /eniq/home/dcuser ; rm -r epfg ; unzip ${epfgpkg} ; unzip ${epfgrstate} ; cd epfg ; chmod -R 777 * .* ; ./epfg_preconfig_for_ft.sh 
    Read    delay=180 seconds


   