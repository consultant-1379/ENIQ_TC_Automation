*** Settings ***
Library             RPA.Browser.Selenium
Library             SSHLibrary
Library             String
Library             Collections
Resource            ../Resources/Keywords/Parser.robot
Resource            ../Resources/Keywords/Cli.robot
Resource            ../Resources/Keywords/Variables.robot

Test Setup          Connect to physical server
Test Teardown       Close All Connections


*** Variables ***
# ${modules}    parser    3GPP32435    3GPP32435DYN    eascii    kpiparser
${SERVER}       ieatrcx8398
${host_123}     ieatrcx8398.athtem.eei.ericsson.se
# ${user_for_vapp}    root
# ${pass_for_vapp}    Eniq%1234


*** Test Cases ***
Verification of Core and Parser Module's.
    @{core_mod_and_parsers}    Create List
    ...    libs
    ...    repository
    ...    common
    ...    licensing
    ...    engine
    ...    scheduler
    ...    monitoring
    ...    export
    ...    dwhmanager
    ...    alarm
    ...    diskmanager
    ...    ebsmanager
    ...    helpset_stats
    ...    mediation
    ...    statlibs
    ...    symboliclinkcreator
    ...    uncompress
    ...    3GPP32435BCS
    ...    3GPP32435DYN
    ...    3GPP32435
    ...    HXMLCsIptnms
    ...    HXMLPsIptnms
    ...    MDC_CCN
    ...    MDC_DYN
    ...    MDC_PC
    ...    MDC
    ...    TCIMParser
    ...    ascii
    ...    asn1
    ...    bcd
    ...    csexport
    ...    ct
    ...    eascii
    ...    ebs
    ...    information_store_parser
    ...    json
    ...    kpiparser
    ...    minilink
    ...    mlxml
    ...    mrr
    ...    nossdb
    ...    parser
    ...    redback
    ...    sasn
    ...    stfiop
    ...    twampm
    ...    twamppt
    ...    twampst
    ...    volte
    ...    xml   
    @{failed_modules}    Create List
    FOR    ${module}    IN    @{core_mod_and_parsers}
        TRY
            TC 01 Verify latest ${module} deployed in ENIQ Server.
            TC 02 Verifying if latest ${module} module is present after installation.
            TC 03 Checking Log files for ${module}.
        EXCEPT
            append to list    ${failed_modules}    ${module}
            CONTINUE
        END
    END
    ${m}    Get Length    ${failed_modules}
    IF    ${m} != 0
        Fail
        ...    *HTML* <span style="color:red"><b>Below module's verification has failed.${\n}${failed_modules}</b></span>
    ELSE
        Log    <span style="color:green"><b>All modules verified.</b></span>    html=true
    END

Verification of Exceptional Modules.
    @{exception_modules}     Create List    runtime    installer    adminui    busyhour    alarmcfg
    @{failed_modules}    Create List
    FOR    ${module}    IN    @{exception_modules}
        TRY
            TC 01 Verify latest ${module} deployed in ENIQ Server.
            TC 03 Checking Log files for ${module}.
        EXCEPT
            append to list    ${failed_modules}    ${module}
            CONTINUE
        END
    END
    ${m}    Get Length    ${failed_modules}
    IF    ${m} != 0
        Fail
        ...    *HTML* <span style="color:red"><b>Below module's verification has failed.${\n}${failed_modules}</b></span>
    ELSE
        Log    <span style="color:green"><b>All modules verified.</b></span>    html=true
    END

*** Keywords ***
TC 01 Verify latest ${module} deployed in ENIQ Server.
    Open clearcasevobs
    ${temp}    Get Element Attribute    //table//a[text()='${module}']    href
    Set Global Variable    ${temp}
    ${parser_name}    Fetch From Right    ${temp}    /
    ${parser_name}    Split String From Right    ${parser_name}    .
    ${parser_name}    Replace String    ${parser_name}[0]    _R    -R
    ${rstate}    Get Text    //table//a[text()='${module}']/../following-sibling::td[3]
    Set Global Variable    ${rstate}
    ${product_number}    Get Text    //table//a[text()='${module}']/../following-sibling::td[2]
    ${prod_label}    Set Variable    ${product_number}-${rstate}
    ${version_prop}    ${rc}    Execute Command
    ...    cat /eniq/sw/platform/${parser_name}/install/version.properties | grep -i '${prod_label}'
    ...    return_rc=True
    set global Variable    $rc

TC 02 Verifying if latest ${module} module is present after installation.
    # IF    $rc==0
    #    fail    ${\n}Skipping the Verification since latest ${module} is already present in the server.
    # END
    ${out}    Execute Command    cat /eniq/sw/installer/versiondb.properties | grep -i ${module}=
    ${latest}    Evaluate    '${rstate}' in '''${out}'''
    IF    ${latest}
        Log
        ...    <span style="color:green"><b>Latest ${module} rstate is present in versiondb.properties file.</b></span>
        ...    html=True
    ELSE
        Fail
        ...    *HTML* <span style="color:red"><b>${module} latest rstate not matching in versiondb.properties file.</b></span>${\n}${out}
    END

TC 03 Checking Log files for ${module}.
    IF    ${rc} == 1    Fail    R-state is not same in server and clearcase.
    ${zip_name}    Split String From Right    ${temp}    /
    ${out}    ${rc}    Execute Command
    ...    cd /eniq/log/sw_log/platform_installer; filename=$(ls -Art ${zip_name}[-1]*.log | tail -n 1); cat $filename | grep -i "warning\|exception\|severe\|not found\|error"
    ...    return_rc=True
    IF    ${rc} == 1
        Log
        ...    <span style="color:green"><b>No negative keywords are found in ${zip_name}[-1].log file.</b></span>
        ...    html=True
    ELSE
        Fail
        ...    *HTML* <span style="color:red"><b>Negative keywords found in ${zip_name}[-1].log file.</b></span>${\n}${out}
    END
