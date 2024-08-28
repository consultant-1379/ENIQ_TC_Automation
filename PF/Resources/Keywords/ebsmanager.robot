*** Keywords ***
connect to winscp
    SCPLibrary.Open Connection    ${host_123}    ${port_for_vapp}    ${user_for_vapp}  ${pass_for_vapp}	Dcuser%12
    
Place the mom file in ebs folder
    SCPLibrary.Put File          ${EXECDIR}\\PF\\Other\\Files\\PM-MOM.5.xml      /eniq/data/pmdata/ebs/ebs_ebss/
    SCPLibrary.Close Connection

Verifying ebs upgrader status is Running
    Page Should Contain Element   //i[contains(text(),'Running...')]

click on EBS Upgrader link
    Click Element    //a[text()='EBS Upgrader']
    Set Selenium Speed    2s

click on upgrade now button
    Click Element    //input[contains(@value,"Upgrade now")]
    Set Selenium Speed    2s

click on Details button
    Click Element    //td[text()='PM_E_EBSS']/..//input[contains(@value,"Details")]
    Set Selenium Speed    2s
