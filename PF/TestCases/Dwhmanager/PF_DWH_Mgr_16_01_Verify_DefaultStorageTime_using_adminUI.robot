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
    Click Element When Clickable    //input[@name="defaultStorageTime"]
    ${storage_value}    Get Element Attribute    //input[@name='defaultStorageTime']    value
    Log To Console    ${storage_value}
    ${Techpack_name}    Get Text    //font/b[text()="Tech Pack name"]/following::tr[1]/td[1]/font
    Click on type configuration
    Select From List By Label    //select[@name="type"]    ${Techpack_name}
    Select From List By Label    name:level    RAW
    Click Element When Clickable    //table[@border='1'][1]//tr[4]/td[2]
    ${Row_count}    Get Element Count    //strong[text()="Tablename"]/ancestor::tr[1]/following-sibling::tr
    ${a}=    Evaluate    (${storage_value}/(${Partition_size_value}/24))+1
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

