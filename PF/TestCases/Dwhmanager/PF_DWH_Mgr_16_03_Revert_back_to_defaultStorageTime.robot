*** Settings ***
Documentation     Testing DWHManager web
Library    RPA.Browser.Selenium
Resource    ../../Resources/Keywords/AdminUIWebUI.robot
Resource    ../../Resources/Keywords/Variables.robot
Resource    ../../Resources/Keywords/Dwhmanager.robot
Resource    ../../Resources/Keywords/Cli.robot
Library    SSHLibrary
Library    String

*** Test Cases ***
Revert back to the default storagetime partition plan using adminui
    Connect to server as a dcuser
    ${Partition_plan}=    Execute Command    cat /eniq/installation/config/extra_params/deployment
    Launch the AdminUI page in browser
    Login To Adminui
    Click on DWH configuration
    Click Element When Clickable    //a[text()='${Partition_plan}_raw']
    ${Max_storage_text}=    Get Text    //strong[contains(text(),"Maximum storage")]/following::td[1]
    @{Split_max_storage}=    Get Regexp Matches    ${Max_storage_text}    \\d+
    ${Max_storage_value}    Convert To Integer    ${Split_max_storage}[0]
    Log To Console    ${Max_storage_value}  
    Click Element When Clickable    //input[@name="defaultStorageTime"]
    Clear Element Text    //input[@name="defaultStorageTime"]
    Sleep    3s
    Input Text    //input[@name="defaultStorageTime"]    ${Max_storage_value}
    Click Button    //input[@name="submitButton"]
    Sleep    2s
    Page Should Contain    Partition plan ${Partition_plan}_raw saved succesfully. 
    Click Link    //a[text()='${Partition_plan}_raw']
    ${Techpack_name}    Get Text    //font/b[text()="Tech Pack name"]/following::tr[1]/td[1]/font
    Click on ETLC Set scheduling
    Select From List By Label    //select[@name="settype"]   Techpack
    Select From List By Label    name:packageSets    ${Techpack_name}
    Click Element    //font[text()="DWHM_StorageTimeUpdate_${Techpack_name}"]/following::td[4]
    Sleep    10s
    Logout from Adminui
    
***Keywords***
Suite setup steps
    Set Screenshot Directory    ./Screenshots 
Test teardown
    Capture Page Screenshot
    Close Browser