*** Settings ***
Resource    ../Resources/login.resource
Library    ../TestCases/server.py
Test Setup        Open Connection And Log In
Test Teardown     Close All Connections   

*** Variables ***
${pkg}    DC_E_BULK_CM

*** Tasks ***
verifying id format bulkcm specific   
    IF    '${pkg}' == 'DC_E_BULK_CM'
        Open clearcasevobs
        ${rstate}    Get Text    //table//a[text()='DC_E_BULK_CM']/../following-sibling::td[3]
        Go To    https://arm1s11-eiffel013.eiffel.gic.ericsson.se:8443/nexus/content/repositories/releases/com/ericsson/eniq/stats/tp/BULK_CM/bulk_cm_etl/FD/${rstate}
        Click Element    //a[contains(text(),'${pkg}')]
        ${modeltlink}=    Get Element Attribute    //tr[3]//a    href
        ${modeltname}=    Fetch From Right    ${modeltlink}    /
        Open Connection    atvts4051.athtem.eei.ericsson.se
        Login               root        shroot
        Write    rm -rf bulkcm
        Write    mkdir bulkcm && cd bulkcm && wget ${modeltlink} && wget https://arm1s11-eiffel013.eiffel.gic.ericsson.se:8443/nexus/content/repositories/releases/com/ericsson/eniq/stats/tp/TP_KPI_Script/bulkcm_script.zip && unzip bulkcm_script.zip
        Write    source /root/CI/cicd/bin/activate && cd /root/bulkcm && echo -e "${modeltname}\\n2\\n4" | python bulkcm_script.py 
        ${output}=    Read    delay=30s
        Write    cd /root && rm -rf /root/bulkcm
        Read    delay=10s
        Switch Connection    ${index}
        ${temp}=    Get Lines Containing String    ${output}    in row
        IF    '${temp}' == 'Id counter: scxTimeReferenceId in row ${SPACE}44341'
            Log To Console    no 
        ELSE
            Fail
        END
    END
    


    