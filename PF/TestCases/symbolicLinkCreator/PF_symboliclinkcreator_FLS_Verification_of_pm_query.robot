*** Settings ***
Force Tags    suite
Library    SSHLibrary
Library    String
Resource    ../../Resources/Keywords/Cli.robot
Resource    ../../Resources/Keywords/Variables.robot
Resource    ../../Resources/Keywords/symboliclinkcreator_FLS_keywords.robot
Library    DateTime
Library    RPA.Browser.Selenium
Library    RPA.Windows

*** Test Cases *** 
Verify pm query is happening for every 3 min for each node
    [Tags]    FLS
    Connect to server as a dcuser
    Checking pm query is happening for every each node

*** Keywords ***
Checking pm query is happening for every each node 
    symboliclinkcreator_FLS_keywords.Execute the Command   cd ${symboliclinkcreator}
    ${curr_date_Y_m_d}=    symboliclinkcreator_FLS_keywords.Get the previous Date
    #${file_content}=    symboliclinkcreator_FLS_keywords.Display the contents in the file    cat ${symlink4}-${curr_date_Y_m_d}.log | grep -i "PM response"
    ${file_content}=    symboliclinkcreator_FLS_keywords.Display the contents in the file    cat ${symlink4}-${curr_date_Y_m_d}.log | grep -i "DPM" | grep "MTAS"
    ${file_content_lines}=    Get the number of lines in log results    ${file_content}
    Skip If    ${file_content_lines}<3        Skipped No NodeType WithData
    verifying PM query is happening in every 3 min    ${file_content}
    [Teardown]    Test teardown

Test teardown
    Close Connection
    
    

      
