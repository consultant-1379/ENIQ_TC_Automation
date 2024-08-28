****Settings****
Library             SikuliLibrary       mode=NEW
Suite Setup      Start Sikuli Process
# Test Setup           Open image location    
Suite Teardown        Stop Remote Server  
*** Variables ***
${image_dir}    
${Screenshots}    H:\\ENIQ_TC_Automation\\KPI\\Daily_work\\Ashwini\\Screenshots
*** Test Cases ***
Test case No 1
    Open Windows Search Option
Testcase No 2
    Search for Remote Desktop Connection
Testcase No 3
    Open RDC application

Testcase No 4
    Open RDC application1


Stop Remote server
*** Keywords ***
Add Needed Image Path
    Add Image Path    ${Screenshots}

Open Windows Search Option
    Click    ${Screenshots}\\Capture.JPG
Search for Remote Desktop Connection
    Input Text    remote desktop connection
    Click    ${Screenshots}\\remotedesktopconnection.PNG

Open RDC application
    Click       ${Screenshots}\\clickonrdcoption.PNG
Open RDC application1
    # input    atclvm1368.athtem.eei.ericsson.se
    Click    ${Screenshots}\\openrdc.PNG
    