*** Settings ***
Force Tags    suite
Library    SSHLibrary
Library    String
Library    DateTime
Resource    ../../Resources/Keywords/Cli.robot
Resource    ../../Resources/Keywords/Variables.robot
Resource    ../../Resources/Keywords/symboliclinkcreator_FLS_keywords.robot
Library    RPA.Browser.Selenium

*** Test Cases *** 
Verify the topology query is happening in following path
    [Tags]    FLS
    Connect to server as a dcuser
    Verify the topology query is happening for every 15min

*** Keywords ***
Verify the topology query is happening for every 15min
    symboliclinkcreator_FLS_keywords.Execute the Command    cd ${symboliclinkcreator}
    ${curr_date_Y_m_d}=    symboliclinkcreator_FLS_keywords.Get the previous Date
    ${file_content}=    symboliclinkcreator_FLS_keywords.Display the contents in the file  cat ${symlink4}-${curr_date_Y_m_d}.log | grep -i "TOPOLOGY QUERY"
    ${file_content_lines}=    Get the number of lines in log results    ${file_content}
    Skip If    ${file_content_lines}<4        TestCase Skipped NoData
    verifying topology query is happening every 15 min    ${file_content}
    [Teardown]    Test teardown

Test teardown
    Close Connection
  
    



