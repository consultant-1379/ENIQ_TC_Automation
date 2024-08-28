*** Settings ***
Documentation     Testing DWH_Manager web
Library    RPA.Browser.Selenium
Resource    ../../Resources/Keywords/AdminUIWebUI.robot
Resource    ../../Resources/Keywords/Variables.robot
Resource    ../../Resources/Keywords/Dwhmanager.robot
Resource    ../../Resources/Keywords/Cli.robot
Library    SSHLibrary
Library    String

*** Test Cases ***
Verifying the Adjusting storage time of partition plan using adminui
    Connect to server as a dcuser
    ${Partition_plan}=    Execute Command    cat /eniq/installation/config/extra_params/deployment
    Launch the AdminUI page in browser
    Login To Adminui
    Verify Home Page Is Displayed
    Click on DWH configuration
    ${Partition_size}=    Get Text    //a[text()="${Partition_plan}_raw"]/following::td[2]
    @{value}=    Get Regexp Matches    ${Partition_size}    \\d+
    ${Partition_size_value}    Convert To Integer    ${value}[0]
    Log To Console    ${Partition_size_value}
    Click Element When Clickable    //a[text()='${Partition_plan}_raw']
    ${Max_storage_text}=    Get Text    //strong[contains(text(),"Maximum storage")]/following::td[1]
    @{Split_max_storage}=    Get Regexp Matches    ${Max_storage_text}    \\d+
    ${Max_storage_value}    Convert To Integer    ${Split_max_storage}[0]
    Log To Console    ${Max_storage_value}
    ${Storage_Value}=    Get Value    //input[@name="defaultStorageTime"]
    Log To Console    ${Storage_Value}
    ${New_value}    Evaluate    ${Storage_Value} - ${change}
    Log To Console    ${New_value}
    Click Element When Clickable    //input[@name="defaultStorageTime"]
    Clear Element Text    //input[@name="defaultStorageTime"]
    Sleep    3s
    Input Text    //input[@name="defaultStorageTime"]    ${New_value}
    Click Button    //input[@name="submitButton"]
    Sleep    2s
    Page Should Contain    Partition plan ${Partition_plan}_raw saved succesfully. 
    Click Link    //a[text()='${Partition_plan}_raw']
    ${Techpack_name}    Get Text    //font/b[text()="Tech Pack name"]/following::tr[1]/td[1]/font
    Click on type configuration
    Select From List By Label    //select[@name="type"]    ${Techpack_name}
    Select From List By Label    name:level    RAW
    Table Should Contain    //table[5]    ${New_value}
    Click on ETLC Set scheduling
    Select From List By Label    //select[@name="settype"]   Techpack
    Select From List By Label    name:packageSets    ${Techpack_name}
    Click Element    //font[text()="DWHM_StorageTimeUpdate_${Techpack_name}"]/following::td[4]
    Sleep    10s
    Click on type configuration
    Select From List By Label    //select[@name="type"]    ${Techpack_name}
    Select From List By Label    name:level    RAW
    Click Element When Clickable    //td[text()="${New_value}"]/preceding::td[3]
    ${Row_count}    Get Element Count    //strong[text()="Tablename"]/ancestor::tr[1]/following-sibling::tr
    ${a}=    Evaluate    (${New_value}/(${Partition_size_value}/24))+1
    ${result} =    Convert To Number    ${a}    0 
    ${result1}=    Convert To Integer    ${result}     
    Log To Console    ${result1}
    Should Be Equal    ${Row_count}    ${result1}
    Logout from Adminui

***Keywords***
Suite setup steps
    Set Screenshot Directory    ./Screenshots 
Test teardown
    Capture Page Screenshot
    Close Browser
