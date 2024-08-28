*** Settings ***
Documentation       Testing AdminUI web

Library             RPA.Browser.Selenium
Library             DateTime
Library             String
Library             SSHLibrary
Library             Collections
Resource            ../../Resources/Keywords/Cli.robot
Resource            ../../Resources/Keywords/Variables.robot
Resource            ../../Resources/Keywords/AdminUIWebUI.robot
Test Teardown       closing all connection


*** Variables ***
${url}             https://${host_123}:8443/adminui/conf

*** Test Cases ***
ENIQ GUI shouldn't allows the browser to access to the conf directory /eniq/sw/runtime/apache-tomcat-8.5.89/webapps/adminui/conf
    Open connection as root user
    ${files_under_conf_directory}    Execute Command    ls /eniq/sw/runtime/tomcat/webapps/adminui/conf/
    ${files_under_conf_directory_list}    Split String    ${files_under_conf_directory}
    FOR    ${element}    IN    @{files_under_conf_directory_list}
        Open Available Browser    ${url}/${element}    options=set_capability("acceptInsecureCerts", True)  
        Page Should Contain    Sorry you do not have access to AdminUI. Please contact the system administrator.    
        Close Browser
        
    END    


*** Keywords ***
closing all connection
    Close Connection
    Logout from Adminui if logged in
    Close All Browsers