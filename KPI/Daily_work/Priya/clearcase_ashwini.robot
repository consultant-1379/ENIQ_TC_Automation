*** Settings ***
Library             RPA.Browser.Selenium
Library             Dialogs
Library             String
Library             OperatingSystem
Library             SSHLibrary
Library             ./tp.py

Test Setup          Open Connection And Log In
Test Teardown       Close All Connections


*** Variables ***
${clearcase}                    https://clearcase-eniq.seli.wh.rnd.internal.ericsson.com/eniqdel
${p}                            ERIC_SBG_Basic_Report_Package
${n}
${host}                         atvts4095.athtem.eei.ericsson.se
${port}                         2251
${uname}                        dcuser
${pwd}                          Dcuser%12
${nexus_link_for_reportpkg}     https://arm1s11-eiffel013.eiffel.gic.ericsson.se:8443/nexus/content/repositories/releases/com/ericsson/eniq/stats/tp/


*** Test Cases ***
Testcase 1
    Open Clearcase and Download latest package file

Testcase 2
    Open Connection And Log In
    Place the report package on server

Testcase 3:
     Extract the report package

# Testcase 4:
#    Verification of report extraction

Testcase 5 :
    License verification Open Clearcase and Download feature file


*** Keywords ***
Open Clearcase and Download latest package file
    ${user}    Get Environment Variable    username
    Set Download Directory    H:\\Downloads\\report_package
    Open Available Browser    ${clearcase}
    Maximize Browser Window
    Click Link    xpath=//body//tr[last()-1]//td[2]//a
    Click Link    xpath=//body//tr[last()-1]//td[2]//a
    ${loc}    Get Location
    Go To    ${loc}SOLARIS_baseline.html
    ${name}    Get Element Attribute    xpath=//a[text()='${p}']    href
    ${n}    Fetch From Right    ${name}    /
    Click Link    xpath=//a[text()='${p}']

    Wait Until Created    H:\\Downloads\\report_package\\${n}

Open Connection And Log In
    ${index}    Open Connection    ${host}    port=${port}    timeout=10
    Set Global Variable    ${index}
    Login    ${uname}    ${pwd}

Place the report package on server
    Put File    H://Downloads//report_package//${n}*    /eniq/sw/installer/BO

Extract the report package
   ${out}    Execute Command    cd /eniq/sw/installer && ./extract_report_packages.bsh BO boreports
   Log To Console    ${\n}${out}

# Verification of report extraction
#    ${output}    Execute Command    cd /eniq/sw/installer/boreports && ./extract_report_packages.bsh BO boreports | grep ${p}
#    ${extracted_output}    Fetch From Left    Report extraction starts at    -
#    #Report extraction starts at    partial_match = True    ${output}

License verification Open Clearcase and Download feature file
   ${user}    Get Environment Variable    username
   Set Download Directory    H:\\Downloads\\report_package
   Open Available Browser    ${clearcase}
   Maximize Browser Window
   ${rstate}    Get Text    //table//a[text()='${n}']/../following-sibling::td[3]
   Click Link    xpath=//a[text()='${n}']
   Go To    ${nexus_link_for_reportpkg}FeatureFile
   Click Link    //a[text()='feature_descriptions']

   OperatingSystem.Wait Until Created    H:\\Downloads\\report_package\\
   ${license_from_feature_file_description}    Execute Command
   ...    cd /eniq/sw/installer/boreports && cat feature_descriptions | grep ${n}
   ${license_checking}    Execute Command    cd /eniq/sw/installer/boreports && ls -d ${n}*.zip
   ${license_from_version_file}    Execute Command
   ...    cat /eniq/sw/installer/boreports/${license_checking}/install/version.properties | grep license
   Should Be Equal
   ...    ${license_from_feature_file_description}
   ...    ${license_from_version_file}
   ...    strip_spaces=True                                            
   ...    msg=License does not matched for ${license_checking}






