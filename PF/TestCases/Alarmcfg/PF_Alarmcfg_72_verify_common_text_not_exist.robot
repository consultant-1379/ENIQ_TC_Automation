*** Settings ***
Library    SSHLibrary
Resource    ../../Resources/Keywords/Engine.robot
Resource    ../../Resources/Keywords/Cli.robot
Resource    ../../Resources/Keywords/Variables.robot
Resource    ../../Resources/Keywords/Alarmcfg_keywords.robot
Test Teardown    Close All Connections


*** Test Cases ***
 Verify if common-text jar file exist
    Connect to server as a dcuser
    ${list_of_common_texts_jar_file_in_externalPath}    listing all files in path and search for common text jar    ${external_path}
    Verify if common text file exist in file path    ${list_of_common_texts_jar_file_in_externalPath}   
   
    ${list_of_common_texts_jar_file_in_libPath}    listing all files in path and search for common text jar    ${lib_path}
     Verify if common text file exist in file path    ${list_of_common_texts_jar_file_in_libPath}
