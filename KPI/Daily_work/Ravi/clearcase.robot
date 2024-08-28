*** Settings ***
Library             RPA.Browser.Selenium
Library             Dialogs
Library             String
Library             OperatingSystem
Library             SSHLibrary
Library             ./tp.py
Library            Process
Library             importingfile.py
Test Setup          Open Connection And Log In
Test Teardown       Close All Connections
Library                licenseverification.py 
Library             SikuliLibrary

*** Variables ***
${clearcase}                    https://clearcase-eniq.seli.wh.rnd.internal.ericsson.com/eniqdel
${p}                            ERIC_SBG_Basic_Report_Package
${n}
${host}                         atvts4095.athtem.eei.ericsson.se
${port}                         2251
${uname}                        dcuser
${pwd}                          Dcuser%12
${nexus_link_for_reportpkg}     https://arm1s11-eiffel013.eiffel.gic.ericsson.se:8443/nexus/content/repositories/releases/com/ericsson/eniq/stats/tp/
${q}
${Unzip File}                   ENIQ_Feature_Files_R36B232.zip
${package}                      ERIC_ERBS_Basic_Report_Package 
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

Testcase 6 : 
    Unzip file

Testcase 7: 
    Verifying the license of report package
*** Keywords ***
Test
Open Clearcase and Download latest package file
    ${user}    Get Environment Variable    username
    Set Download Directory    H:\\Downloads\\report_package
    Open Available Browser    ${clearcase}
    Maximize Browser Window
    Click Link    xpath=//body//tr[last()-1]//td[2]//a
    Click Link    xpath=//body//tr[last()-1]//td[2]//a
    ${loc}    Get Location
    Go To    ${loc}SOLARIS_baseline.html

    ${rstate}    Get Text    //table//a[text()='${package}']/../following-sibling::td[3]
    ${name}    Get Element Attribute    xpath=//a[text()='${package}']    href
    ${n}    Fetch From Right    ${name}    /
    Click Link    xpath=//a[text()='${package}']

    Wait Until Created    H:\\Downloads\\report_package\\${n}

Open Connection And Log In
    ${index}    Open Connection    ${host}    port=${port}    timeout=10
    Set Global Variable    ${index}
    Login    ${uname}    ${pwd}

Place the report package on server
    Put File    H://Downloads//report_package//${package}*    /eniq/sw/installer/BO

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
    Click Link    xpath=//body//tr[last()-1]//td[2]//a
    Click Link    xpath=//body//tr[last()-1]//td[2]//a
    ${loc}    Get Location
    Go To    ${loc}SOLARIS_baseline.html
   ${n}    Get Text   xpath=//a[text()='ENIQ_Feature_Files']
    # # //table//a[text()='${n}']/../following-sibling::td[3]
   Click Link    xpath=//a[text()='${n}']
    OperatingSystem.Wait Until Created    H:\\Downloads\\report_package\\${n}*
    
    Put File    H://Downloads//report_package//${n}*    /eniq/sw/installer/boreports   
    
#    Trying in nexus todownload the feature file
#    Open Available Browser    ${nexus_link_for_reportpkg}
#     Maximize Browser Window
#     Go To    ${nexus_link_for_reportpkg}FeatureFile
#    Click Link    //a[text()='feature_descriptions']
#     ${repo}    Fetch From Right    ${p}    _
#     ${etl}    Convert To Lower Case    ${repo}
#    OperatingSystem.Wait Until Created    H:\\Downloads\\report_package\\${n}*

    
# Verifying the license of report package 
#    ${license_from_feature_file_description}    Execute Command
#    ...    cd /eniq/sw/installer/boreports && cat searchingalgorithm | grep ${n}    | cut -d ":" -f1
#    ${license_checking}    Execute Command    cd /eniq/sw/installer/boreports && ls -d ${n}*.zip | cut -d "." -f1
#     ${license_from_version_file}    Execute Command
#     ...    cat /eniq/sw/installer/boreports/${n}/install/version.properties | grep license | cut -d "=" -f2
   
    
    # Should Be Equal
    # ...    ${license_from_feature_file_description}
    # ...    ${license_from_version_file}
    # ...    strip_spaces=True
    # ...    msg=License does not matched for ${license_checking}

Unzip File
    extract_file        ${Unzip File} 
    Log To Console    ${\n}${Unzip File}
    
Verifying the license of report package 
    ${license_from_feature_file}    Execute Command
    ...    cd /eniq/sw/installer/boreports && cat feature_descriptions 
    Log To Console    ${license_from_feature_file}
    ${bo_folder}    Execute Command    cd /eniq/sw/installer/boreports && ls -d ${package}* 
     ${license_from_version_file}    Execute Command
     ...    cat /eniq/sw/installer/boreports/${package}*/install/version.properties | grep license | cut -d "=" -f2
    Log To Console    ${license_from_version_file}
    License_verification    ${license_from_feature_file}  ${license_from_version_file}
     
    # ...    cd /eniq/sw/installer/boreports && cat feature_descriptions 
    # Log To Console    ${license_from_feature_file}
    # Should Be Equal
    # ...    ${license_from_feature_file}
    # ...    ${license_from_version_file}
    # ...    strip_spaces=True
    # ...    msg=License does not matched for ${bo_folder}



        # print(b.readlines())