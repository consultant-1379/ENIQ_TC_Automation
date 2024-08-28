*** Settings ***
Test Setup        Open Connection And Log In
Test Teardown     Close All Connections
Library           SSHLibrary
Library           DateTime
Library           DependencyLibrary
Resource          ../Resources/Resource.resource


*** Test Cases ***
Checking for radio_G1_G2_mixed_cell_count file in radioNode directory
    [Documentation]      Checking for radio_G1_G2_mixed_cell_count.txt log file in /eniq/log/ddc_data/${hostname}/${date_dmy}/plugin_data/radioNode directory
    [Tags]               System_Information
    Check File Exists    /eniq/log/ddc_data/${hostname}/${date_dmy}/plugin_data/radioNode/radio_G1_G2_mixed_cell_count.txt

Checking for radio_G1_G2_mixed_cell_count file size in radioNode directory
    Depends on test      Checking for radio_G1_G2_mixed_cell_count file in radioNode directory
    [Documentation]      Checking for non empty radio_G1_G2_mixed_cell_count.txt file in /eniq/log/ddc_data/${hostname}/${date_dmy}/plugin_data/radioNode directory
    [Tags]               System_Information
    Check File Size      /eniq/log/ddc_data/${hostname}/${date_dmy}/plugin_data/radioNode/radio_G1_G2_mixed_cell_count.txt

Checking for radio_G1_G2_mixed_node_count file in radioNode directory
    [Documentation]      Checking for radio_G1_G2_mixed_node_count.txt file in /eniq/log/ddc_data/${hostname}/${date_dmy}/plugin_data/radioNode directory
    [Tags]               System_Information
    Check File Exists    /eniq/log/ddc_data/${hostname}/${date_dmy}/plugin_data/radioNode/radio_G1_G2_mixed_node_count.txt

Checking for radio_G1_G2_mixed_node_count file size in radioNode directory
    Depends on test      Checking for radio_G1_G2_mixed_node_count file in radioNode directory
    [Documentation]      Checking for non empty radio_G1_G2_mixed_node_count.txt file in /eniq/log/ddc_data/${hostname}/${date_dmy}/plugin_data/radioNode directory
    [Tags]               System_Information
    Check File Size      /eniq/log/ddc_data/${hostname}/${date_dmy}/plugin_data/radioNode/radio_G1_G2_mixed_node_count.txt

Checking for radio_pico_rnc_cell_count file in radioNode directory
    [Documentation]      Checking for radio_pico_rnc_cell_count.txt log file in /eniq/log/ddc_data/${hostname}/${date_dmy}/plugin_data/radioNode directory
    [Tags]               System_Information
    Check File Exists    /eniq/log/ddc_data/${hostname}/${date_dmy}/plugin_data/radioNode/radio_pico_rnc_cell_count.txt

Checking for radio_pico_rnc_cell_count file size in radioNode directory
    Depends on test      Checking for radio_pico_rnc_cell_count file in radioNode directory
    [Documentation]      Checking for non empty radio_pico_rnc_cell_count.txt file in /eniq/log/ddc_data/${hostname}/${date_dmy}/plugin_data/radioNode directory
    [Tags]               System_Information
    Check File Size      /eniq/log/ddc_data/${hostname}/${date_dmy}/plugin_data/radioNode/radio_pico_rnc_cell_count.txt

Checking for radio_pico_rnc_node_count file in radioNode directory
    [Documentation]      Checking for radio_pico_rnc_node_count.txt file in /eniq/log/ddc_data/${hostname}/${date_dmy}/plugin_data/radioNode directory
    [Tags]               System_Information
    Check File Exists    /eniq/log/ddc_data/${hostname}/${date_dmy}/plugin_data/radioNode/radio_pico_rnc_node_count.txt

Checking for radio_pico_rnc_node_count file size in radioNode directory
    Depends on test      Checking for radio_pico_rnc_node_count file in radioNode directory
    [Documentation]      Checking for non empty radio_pico_rnc_node_count.txt file in /eniq/log/ddc_data/${hostname}/${date_dmy}/plugin_data/radioNode directory
    [Tags]               System_Information
    Check File Size      /eniq/log/ddc_data/${hostname}/${date_dmy}/plugin_data/radioNode/radio_pico_rnc_node_count.txt
