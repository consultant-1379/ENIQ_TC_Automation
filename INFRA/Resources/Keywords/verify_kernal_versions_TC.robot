*** settings ***
Library    ../../Scripts/compare_kernal_version.py

*** Keywords ***
compare_kernal_version1
     [Arguments]    ${mwshost}    ${mwsuser}    ${mwspwd}    
    ${result}=    compare_kernal_version    ${mwshost}    ${mwsuser}    ${mwspwd}    
    [Return]    ${result}

         

