*** Settings ***
Library             RPA.Browser.Selenium
Library             SSHLibrary
Library             String
Library             Collections
Resource            ../../../Resources/login.resource

Test Setup          Open Connection And Log In
Test Teardown       Close All Connections


*** Variables ***
${package}          DC_E_ERBS
${host}             atvts4130.athtem.eei.ericsson.se
${port}             2251
${uname}            dcuser
${pwd}              Dcuser%12
${clearcase}        https://clearcase-eniq.seli.wh.rnd.internal.ericsson.com/eniqdel
${password_db}      Dwhrep12#
${username}         dwhrep
${database}         repdb
${run}              go


*** Test Cases ***
# *** Keywords ***
Run the Combined view script for ERBSG2
    Skip If
    ...    '${package}'!='DC_E_ERBSG2'
    ...    Skipping the Execution since this testcase is not applicable for ${package}
    Set Client Configuration    prompt=eniqs[eniq_stats] {dcuser} #:    timeout=500
    Execute Command    cd /eniq/sw/installer; ./erbscombinedview.bsh >testlog.txt
    ${output}    Execute Command    grep -E 'error|warning' /eniq/sw/installer/testlog.txt
    IF    ${output}
        Fail    Error or Warning found in testlog.txt${\n}${output}
    ELSE
        Log    ${\n}Combined View Script executed successfully and no Error and Warnings are found.
    END

verify counters of erbsg2 in erbs
    Skip If
    ...    '${package}'!='DC_E_ERBSG2'
    ...    Skipping the execution since this testcase is not applicable for ${package}
    Open clearcasevobs
    ${buildno}    Get Element Attribute    //table//a[text()='DC_E_ERBS']    href
    ${buildno}    Fetch From Right    ${buildno}    _b
    ${buildno}    Split String From Right    ${buildno}    .
    ${buildnog2}    Get Element Attribute    //table//a[text()='DC_E_ERBSG2']    href
    ${buildnog2}    Fetch From Right    ${buildnog2}    _b
    ${buildnog2}    Split String From Right    ${buildnog2}    .
    Write    cd /eniq/home/dcuser
    Read    delay=2s
    Set Client Configuration    prompt=eniqs[eniq_stats] {dcuser} #:    timeout=500
    Write
    ...    echo -e "SELECT dataname FROM measurementcounter WHERE typeid like '%DC_E_ERBSG2:((${buildnog2}[0]))%' AND dataname NOT IN(SELECT dataname FROM measurementcounter WHERE typeid like '%DC_E_ERBS:((${buildno}[0]))%');\\n${run}\\n" | isql -P ${password_db} -U ${username} -S ${database} -b
    ${after_comparison}    Read Until Prompt
    ${after_comparison}    Split String    ${after_comparison}    \r\n
    ${length}    Get Length    ${after_comparison}
    IF    ${length} <= 3
        log    ${\n}All counters in ERBSG2 are present in ERBS
    ELSE
        ${total_counters}    Evaluate    ${length}-3
        log    ${\n}${total_counters} counters in ERBSG2 that are not present in ERBS are listed below-
        FOR    ${i}    IN RANGE    0    ${total_counters}
            Log    ${\n}${after_comparison}[${i}]
        END
        Fail    Hence, failing the Test case
    END
