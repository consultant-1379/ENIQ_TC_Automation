*** Settings ***
Suite Setup        Open Connection And Log In
Suite Teardown     Close All Connections
Library           SSHLibrary
Library           DateTime
Library           DependencyLibrary
Resource          ../Resources/Resource.resource


*** Test Cases ***
Checking for non-installed_feature file in Features source TC01
    [Documentation]               Checking for installed_feature.json file in /eniq/log/assureddc/installed_features directory
    [Tags]                        Installed_Features
    Check File Does Not Exists    /eniq/log/assureddc/installed_features/installed_feature.json

Checking for installed_feature file size in Features source TC02
    Depends on test               Checking for non-installed_feature file in Features source TC01
    [Documentation]               Checking for installed_feature.json file in /eniq/log/ddc_data/${hostname}/${date_dmy}/plugin_data/installed_features directory
    [Tags]                        Installed_Features
    Check File Exists             /eniq/log/ddc_data/${hostname}/${date_dmy}/plugin_data/installed_features/installed_feature.json

Checking for installed_feature file in Features destination TC03
    Depends on test               Checking for installed_feature file size in Features source TC02
    [Documentation]               Checking for non empty installed_feature.json file in /eniq/log/ddc_data/${hostname}/${date_dmy}/plugin_data/installed_features directory
    [Tags]                        Installed_Features
    Check File Size               /eniq/log/ddc_data/${hostname}/${date_dmy}/plugin_data/installed_features/installed_feature.json
