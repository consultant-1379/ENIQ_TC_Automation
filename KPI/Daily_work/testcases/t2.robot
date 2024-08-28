*** Settings ***
Library             String
Library             RPA.Browser.Selenium
Library             SSHLibrary
Resource            ../../Resources/login.resource
Library             ./tp.py
Library             Collections
Library             RPA.Excel.Files

# Test Setup          Open Connection And Log In
Test Teardown       Close All Connections


*** Variables ***
${st}                       DC_E_CCRC:((20)):DC_E_CCRC_NRF_NNRF_PROV:3gpp32435
${intf_name}                Aggregator_DC_E_AFG_OPENID_CONN_DAY
${clearcase}                https://clearcase-eniq.seli.wh.rnd.internal.ericsson.com/eniqdel
${package}                  BO_E_CNAXE
${nexus_link_for_bopkg}
...    https://arm1s11-eiffel013.eiffel.gic.ericsson.se:8443/nexus/content/repositories/releases/com/ericsson/eniq/stats/tp/

${pkg_with_tpi}             DC_E_ERBSG2_R24A_b133.tpi
${datetime_id}
${key_name}
${node_name}


*** Tasks ***
BO package TestCases
    # Download BO package
    # Verifying the license of BO package
    # Verifying the CUID of package from old BO package
    # BTFT
    abcd

*** Keywords ***
abcd
    ${index}    Open Connection    host=atclvm769.athtem.eei.ericsson.se    port=5985   timeout=20
    Set Global Variable    ${index}
    Login               Administrator        shroot@12
    ${out}    Execute Command    ipconfig /all
BTFT
    Write    echo -e "select distinct substr(CONFIG,charindex('basetable',CONFIG)+10) test from Transformation where target like 'dc_release' and TRANSFORMERID like '${pkg}:%'\\n${run}\\n" | isql -P ${password_db} -U ${username} -S ${database} -b
    ${output1}    Read    delay=20s
    Log To Console    ${output1}
    ${topotable}    Filter Topotable Name    ${output1}
    Write
    ...    echo -e "select DATANAME from ReferenceColumn where typeid like '%${topotable}' and DATANAME like '%[_]name%'\\n${run}\\n" | isql -P ${password_db} -U ${username} -S ${database} -b
    ${output2}    Read    delay=30s
    Log To Console    ${output2}

Download BO package
    Set Download Directory    H:\\Downloads\\bo_pkgs
    Open Available Browser    ${clearcase}
    Click Link    xpath=//body//tr[last()-1]//td[2]//a
    Click Link    xpath=//body//tr[last()-1]//td[2]//a
    ${loc}    Get Location
    Go To    ${loc}SOLARIS_baseline.html
    ${rstate}    Get Text    //table//a[text()='${package}']/../following-sibling::td[3]
    Click Link    xpath=//a[text()='${package}']
    Go To    ${nexus_link_for_bopkg}FeatureFile
    Click Link    //a[text()='feature_report_packages']
    ${repo}    Fetch From Right    ${package}    _
    # ${etl}    Convert To Lower Case    ${repo}
    Go To    ${nexus_link_for_bopkg}${repo}
    Click Link    //tr//a[contains(text(),'_bo')]
    Click Link    //tr[last()]//a
    Click Link    //a[contains(text(),'${package}')]
    Click Element    //a[contains(text(),'tpi')]
    OperatingSystem.Wait Until Created    H:\\Downloads\\bo_pkgs\\${package}*.tpi
    Close All Browsers
    Put File    H:\\Downloads\\bo_pkgs\\*    /eniq/sw/installer/BO
    ${out}    Execute Command    cd /eniq/sw/installer && ./extract_report_packages.bsh BO BO
    Log To Console    ${\n}${out}
    Remove File    H:\\Downloads\\bo_pkgs\\*
    # Execute Command    cd /eniq/sw/installer/BO && rm *.tpi && rm *.zip

 Verifying the license of BO package
    ${license_from_feature_file}    Execute Command
    ...    cd /eniq/sw/installer/BO && cat feature_report_packages | grep ${package} | cut -d ":" -f1
    ${bo_folder}    Execute Command    cd /eniq/sw/installer/BO && ls -d ${package}*.zip | cut -d "." -f1
    ${license_from_version_file}    Execute Command
    ...    cat /eniq/sw/installer/BO/${bo_folder}/install/version.properties | grep license | cut -d "=" -f2
    # Should Be Equal
    # ...    ${license_from_feature_file}
    # ...    ${license_from_version_file}
    # ...    strip_spaces=True
    # ...    msg=License does not matched for ${bo_folder}
    # Log To Console    ${\n}License is correct in both version.properties and feature file.

Verifying the CUID of package from old BO package
    ${out}    Execute Command    cd /eniq/sw/installer/BO && ./CUID_extractor_new.sh | grep ${package} | cut -d "," -f3
    # ${ss}    Split To Lines    ${out}
    # Should Be Equal    ${ss}[0]    ${ss}[1]    msg=CUIDs are not equal in old and new BO package.
    # Log To Console    ${\n}CUIDs matched
    Log To Console    ${\n}${out}

    # write    engine -e startSet 'DC_E_AFG' 'Aggregator_DC_E_AFG_OPENID_CONN_DAY'
    # ${out}    Read    delay=7s
    # Should Contain    ${out}    Start set requested successfully    Failed Aggregation for ${intf_name}
    # echo -e "select ACTION_CONTENTS_01 from Meta_transfer_actions WHERE ACTION_CONTENTS_01 LIKE '%interfaceName=INTF_DC_E_ERBSP%'    and ACTION_TYPE LIKE 'parse'" | isql -P Etlrep12# -U etlrep -S repdb -b
