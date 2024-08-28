*** Settings ***
Resource    ../Resources/login.resource
Library    ../TestCases/server.py
Test Setup        Open Connection And Log In
Test Teardown     Close All Connections   
*** Tasks ***
Downloading and installing DAY Aggrigation Validator 
    Open nexus tpkpiscript
    ${scriptlink}=    Get Element Attribute    //a[contains(text(),'DAY_Aggregation_Validator')]    href
    ${scriptname}=    Fetch From Right    ${scriptlink}    /
    Open Connection    atvts4051.athtem.eei.ericsson.se
    Login               root        shroot
    Write    rm -rf tppkg ; mkdir tppkg ; cd tppkg ; wget ${scriptlink} ; pwd
    sleep    10
    Read    delay=10s
    Switch Connection    ${index}
    Put File    /root/tppkg/${scriptname}     /eniq/home/dcuser/dayaggregation
    ${repo}    Fetch From Right  ${pkg}     _
    ${etl}    Convert To Lower Case  ${repo}
    Open clearcasevobs
    ${rstate}    Get Text    //table//a[text()=${package}]/../following-sibling::td[3]
    Go To    https://arm1s11-eiffel013.eiffel.gic.ericsson.se:8443/nexus/content/repositories/releases/com/ericsson/eniq/stats/tp/${repo}/${etl}_etl/FD/${rstate}
    Click Element    //a[contains(text(),'${pkg}')]
    ${modeltlink}=    Get Element Attribute    //tr[3]//a    href
    ${modeltname}=    Fetch From Right    ${modeltlink}    /
    Open Connection    atvts4051.athtem.eei.ericsson.se
    Login               root        shroot
    Write    rm -rf tppkg ; mkdir tppkg ; cd tppkg ; wget ${modeltlink} ; pwd
    sleep    10
    Switch Connection    ${index}
    Put File    /root/tppkg/${modeltname}     /eniq/home/dcuser/dayaggregation
    Write    cd /eniq/home/dcuser ; perl epfgdataGeneration.pl
    ${output}=    Read    delay=10s
    ${filegentime}=    filter date from epfg    ${output}
    update automation file    ${scriptname}    ${filegentime}    ${pkg}_%_RAW    ${modeltname}    ${host}    ${port}    ${uname}    ${pwd}
    Write    cd /eniq/home/dcuser/dayaggregation ; java -jar DAY_Aggregation_Validator.jar automation.properties
    
    