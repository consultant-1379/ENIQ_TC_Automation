*** Settings ***
Library    RPA.Browser.Selenium    
Library    SSHLibrary
Library    String
Library    Collections    
Resource    ../../Resources/Keywords/Variables.robot
Resource    ../../Resources/Keywords/Cli.robot
Resource    ../../Resources/Keywords/Parser.robot
Test Setup    Connect to physical server
Test Teardown    Close All Connections
*** Variables ***
${module}    repository
${host_123}    ieatrcx8399.athtem.eei.ericsson.se
*** Test Cases ***
TC 01 Verify latest parser deployed in ENIQ Server
    #Open Available Browser    www.google.com
    Open clearcasevobs
    ${temp}=    Get Element Attribute    //table//a[text()='${module}']    href
    Set Global Variable    ${temp}
    ${repository_module}=    Fetch From Right    ${temp}    /
    ${repository_module}    Split String From Right    ${repository_module}    .    
    ${repository_module}    Replace String    ${repository_module}[0]    _R    -R
    ${rstate}    Get Text    //table//a[text()='${module}']/../following-sibling::td[3]
    Set Global Variable    ${rstate}
    ${product_number}    Get Text    //table//a[text()='${module}']/../following-sibling::td[2]
    ${prod_label}    Set Variable    ${product_number}-${rstate}
    ${version_prop}    ${rc}    Execute Command    cat /eniq/sw/platform/${repository_module}/install/version.properties | grep -i '${prod_label}'    return_rc=True
    set global Variable    $rc

TC 02 03 Downloading and Installing the parser.
    Skip If    $rc==0    ${\n}Skipping the downloading since latest ${module} is already present in the server.
    Execute Command    cd /eniq/sw/installer ; wget -nc ${temp}
    ${zip_name}    Split String From Right    ${temp}    /
    Execute Command    cd /eniq/sw/installer ; chmod u+x ${zip_name}[-1] 
    ${output}    Execute Command    cd /eniq/sw/installer ; ./platform_installer ${zip_name}[-1] 
    ${failed}    Evaluate    'failed' in '''${output}'''    
    IF    ${failed}
        Fail    *HTML* <span style="color:red"><b>${module} installation Failed.</b></span>${\n}${output}
    ELSE
        Log    <span style="color:green"><b>${module} installed Successfully.${\n}Proceeding with log verification.</b></span>    html=True
    END

TC 04 Verifying if latest ${module} module is present after installation.
    Skip If    $rc==0    ${\n}Skipping the Verification since latest ${module} is already present in the server.
    ${out}    Execute Command    cat /eniq/sw/installer/versiondb.properties | grep -i ${module}=
    ${latest}    Evaluate    '${rstate}' in '''${out}'''
    IF    ${latest}
        Log    <span style="color:green"><b>Latest ${module} rstate is present in versiondb.properties file.</b></span>    html=True
    ELSE
        Fail    *HTML* <span style="color:red"><b>${module} latest rstate not matching in versiondb.properties file.</b></span>${\n}${out}
    END

TC 05 Checking Log files
    ${zip_name}    Split String From Right    ${temp}    /
    ${out}    ${rc}    Execute Command   cd /eniq/log/sw_log/platform_installer; filename=$(ls -Art ${zip_name}[-1]*.log | tail -n 1); cat $filename | grep -i "warning\|exception\|severe\|not found\|error"    return_rc=True
    IF    ${rc} == 1
        Log    <span style="color:green"><b>No negative keywords are found in ${zip_name}[-1].log file.</b></span>    html=True
    ELSE
        Fail    *HTML* <span style="color:red"><b>Negative keywords found in ${zip_name}[-1].log file.</b></span>${\n}${out}
    END


