****Settings****

Library             SikuliLibrary       mode=NEW

Suite Setup      Start Sikuli Process

# Test Setup           Open image location    

Suite Teardown        Stop Remote Server  

*** Variables ***

${image_dir}    

${Screenshots}    ${CURDIR}\\..\\Screenshots

*** Test Cases ***

Test case No 1

    Open image location

    Open Windows Search Option

Testcase No 2

    #Search for Remote Desktop Connection

Testcase No 3

    #Open RDC application



Testcase No 4

    #Open RDC application1

Add Image Path



Stop Remote server

*** Keywords ***

Open image location

    Add Image Path    ${Screenshots}



Open Windows Search Option

    Click    priya.png