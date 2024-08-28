*** Settings ***
Suite Setup        Open Connection And Log In
Suite Teardown     Close All Connections
Library            SSHLibrary
Library            DateTime
Library            DependencyLibrary
Resource           ../Resources/Resource.resource


*** Test Cases ***
Checking for aggregated file in counterTool directory TC01
    [Documentation]          Checking for ${yesterday_date}_aggregated.log file in /eniq/log/ddc_data/${hostname}/${date_dmy}/plugin_data/counterTool directory
    [Tags]                   Accessed_Counter
    ${src_output_var}=       Run Keyword And Return Status     Check File Exists        /eniq/log/ddc_data/${hostname}/${date_dmy}/plugin_data/counterTool/${yesterday_date}_aggregated.log
    Set Global Variable      ${src_output_var}
    Run Keyword If           ${src_output_var} == False    Skip    aggregated log is not there in the source path

Checking for aggregated file size in counterTool directory TC02
    Skip If    ${src_output_var} == False
    Depends on test          Checking for aggregated file in counterTool directory TC01
    [Documentation]          Checking for non empty ${yesterday_date}_aggregated.log file in /eniq/log/ddc_data/${hostname}/${date_dmy}/plugin_data/counterTool directory
    [Tags]                   Accessed_Counter
    Check File Size          /eniq/log/ddc_data/${hostname}/${date_dmy}/plugin_data/counterTool/${yesterday_date}_aggregated.log
