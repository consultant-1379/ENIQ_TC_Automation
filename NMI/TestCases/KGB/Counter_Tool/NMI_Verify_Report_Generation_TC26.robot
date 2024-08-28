*** Settings ***
Library           OperatingSystem

*** Variables ***

*** Test Cases ***
Checking if Starting to generate Statistics      
    [Tags]                Reports
    ${Content}=           Get File                   Counter-Recommendation-Tool.log
    Set Global Variable   ${Content}
    Should Contain        ${Content}                 Starting to generate Statistics

Checking if Starting to fetch counter statistics       
    [Tags]             Reports
    Should Contain     ${Content}                 Starting to fetch counter statistics

Checking if Collecting Statistics for Accessed Counters 
    [Tags]             Reports
    Should Contain     ${Content}                 Collecting Statistics for Accessed Counters for

Checking if Collecting Statistics for Aggregated Accessed Counters     
    [Tags]             Reports
    Should Contain     ${Content}                 Collecting Statistics for Aggregated Accessed Counters for    

Checking if Filtering accesed counters based on the Feature input provided     
    [Tags]             Reports
    Should Contain     ${Content}                 Filtering accesed counters based on the Feature input provided

Checking if Getting Statistics for Unaccessed Counters      
    [Tags]             Reports
    Should Contain     ${Content}                 Getting Statistics for Unaccessed Counters

Checking Report Details      
    [Tags]             Reports
    Should Contain     ${Content}                 Report Details

Checking if Aggregated access count across the selected Time Range     
    [Tags]             Reports
    Should Contain     ${Content}                 Aggregated access count across the selected Time Range

Checking if Daywise statistics across the selected Time Range      
    [Tags]             Reports
    Should Contain     ${Content}                 Daywise statistics across the selected Time Range

Checking if Unaccessed counter data across the selected Time Range      
    [Tags]             Reports
    Should Contain     ${Content}                 Unaccessed counter data across the selected Time Range

Checking if Summary Report      
    [Tags]             Reports
    Should Contain     ${Content}                 Daywise statistics across the selected Time Range

Checking if Successfully completed Generating Reports      
    [Tags]             Reports
    Should Contain     ${Content}                 Successfully completed Generating Reports
