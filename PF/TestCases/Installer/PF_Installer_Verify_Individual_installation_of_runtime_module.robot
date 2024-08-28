*** Settings ***
Force Tags    suite
Library    SSHLibrary
Library    String
Resource    ../../Resources/Keywords/Cli.robot
Resource    ../../Resources/Keywords/Variables.robot
Resource   ../../Resources/Keywords/Installer.robot

*** Test Cases *** 
Verify Individual installation of runtime module
    [Tags]    Installer
    Connect to server as a dcuser
    verification of Installation of runtime module

***keywords***
verification of Installation of runtime module
    ${Features}=    Execute Command    ${mws_path_list_of_features}
    ${mws_path}=    Execute Command    ${mws_path_list_of_modules}${Features}/eniq_base_sw/eniq_sw ; ls
    Execute the Command    ${copy_runtime_module}
    Go to the folder    ${installer_folder}
    switch user    ${su_root}
    Execute the Command    ${root_pwd}
    ${services_status_1}=    Execute the Command    ${checking_services_status}
    verifyng the services status    ${services_status_1}     loaded active running
    Go to the folder  ${bin_folder}
    Execute the Command    ${stop_all_services}
    Sleep    20s
    Grant permission    Yes
    ${stopped_services_status}=    Read    delay=220s
    verifyng the services status    ${stopped_services_status}    ENIQ services stopped correctly        
    switch user   ${dc_user}
    Go to the folder    ${installer_folder}
    Go to the folder    ${installer_temp_folder}
    Execute the Command    ${make_directory}
    Execute the Command    ${copy_module_into_installer_temp}
    Execute the Command    ${unzip}
    replacing the runtime folder
    Execute the Command    ${chmod_insatll_runtime}
    ${installation}=    Execute the Command    ${install_runtime}
    verifying installation status    ${installation}    installed
    switch user    ${su_root}
    Execute the Command    ${root_pwd}
    Go to the folder    ${bin_folder}
    Execute the Command      ${start_all_services}
    Sleep    20s
    Grant permission    Yes
    ${active_status}=    Read    delay=350s
    verifying services status    ${active_status}    ENIQ services started correctly
    [Teardown]    Test teardown

Test teardown
    Close Connection

    