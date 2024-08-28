*** Settings ***
Library    RPA.Browser.Selenium    
Library    SSHLibrary
Library    String
Library    Collections    
Resource    ../../Resources/Keywords/Parser.robot
Resource    ../../Resources/Keywords/Cli.robot
Resource    ../../Resources/Keywords/Variables.robot
Test Setup    Connect to physical server
Test Teardown    Close All Connections
*** Variables ***
${module}    installer
#${host_123}    ieatrcxb6080.athtem.eei.ericsson.se

*** Test Cases ***
TC 01 Verify latest installer deployed in ENIQ Server
    Open clearcasevobs
    ${installer_module}=    Get Element Attribute    //table//a[text()='${module}']    href
    Set Global Variable    ${installer_module}
    ${installer_name}=    Fetch From Right    ${installer_module}    /
    ${installer_name}    Split String From Right    ${installer_name}    .    
    Set Global Variable    ${installer_name}
    ${clearcase_rstate_bulidno}    Split String From Right     ${installer_name}[0]    _
    ${clearcase_rstate_bulidno}    Set Variable   ${clearcase_rstate_bulidno}[-1]
    Set Global Variable    ${clearcase_rstate_bulidno}
    ${version_prop}    ${rc}    Execute Command    cat /eniq/sw/installer/versiondb.properties | grep -i 'installer'   return_rc=True
    Set Global Variable    ${rc}
    ${rstatebuildno}    Split String From Right    ${version_prop}    =
    ${rstatebuildno}    Set Variable    ${rstatebuildno}[-1]
    Set Global Variable    ${rstatebuildno}

TC 02 03 Downloading and Installing the installer.
    Skip If    '${rstatebuildno}' == '${clearcase_rstate_bulidno}'   ${\n}Skipping the downloading since latest ${module} is already present in the server.
    Execute Command    cd /eniq/sw/installer && rm -rf /eniq/sw/installer/temp && mkdir temp 
    ${zip_name}    Split String From Right    ${installer_module}    /
    ${output}    Execute Command    cd /eniq/sw/installer/temp ; wget ${installer_module} ; chmod u+x ${zip_name}[-1]  
    ${output}    Execute Command    cd /eniq/sw/installer/temp ; unzip ${zip_name}[-1] ; chmod u+x install_installer.sh ; ./install_installer.sh -v
    ${failed}    Evaluate    'failed' in '''${output}'''  
    IF    ${failed}
        Fail    *HTML* <span style="color:red"><b>${module} installation Failed.</b></span>${\n}${output}
    ELSE
        Log    <span style="color:green"><b>${module} installed Successfully.${\n}Proceeding with log verification.</b></span>    html=True
     END


