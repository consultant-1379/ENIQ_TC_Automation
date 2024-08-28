*** Settings ***
Suite Setup        Open Connection And Log In
Suite Teardown     Close All Connections
Library            SSHLibrary
Resource           ../../Resources/resource.txt

*** Variables ***

*** Test Cases ***
Checking whether proper fbx64.efi file is present in OM_Linux path of MWS server
       [Tags]                         fbx64
       Set Client Configuration       timeout=25 seconds      prompt=#:
       ${output}=                     Execute Command         ls -lrt /net/$(cat /eniq/installation/config/om_sw_locate | sed 's/@//')/om_linux/omtools/bmr/ | grep fbx64.efi | awk '{print $5}'
       Should Be Equal                ${output}               88112

Checking whether Coordinator (ENIQ Gen 10+) server has proper fbx64.efi file after II or Upgrade
    [Tags]                         fbx64
	Open Connection                ${host}        port=${PORT}
    Login                          ${username}    ${password}    delay=1
    Log To Console                 Connected to server ${host}:${p}
    Set Client Configuration       timeout=25 seconds      prompt=#:
    ${output}=                     Execute Command         ls -lrt /boot/efi/EFI/BOOT/ | grep fbx64.efi | awk '{print $5}'
    Should Be Equal                ${output}               88112

Checking whether Engine (ENIQ Gen 10+) server has proper fbx64.efi file after II or Upgrade
    [Tags]                         fbx64
	Open Connection                ${host1}        port=${PORT1}
    Login                          ${username1}    ${password1}    delay=1
    Log To Console                 Connected to server ${host1}:${p1}
    Set Client Configuration       timeout=25 seconds      prompt=#:
    ${output}=                     Execute Command         ls -lrt /boot/efi/EFI/BOOT/ | grep fbx64.efi | awk '{print $5}'
    Should Be Equal                ${output}               88112

Checking whether Reader1 (ENIQ Gen 10+) server has proper fbx64.efi file after II or Upgrade
    [Tags]                         II-Reader1
    Open Connection                ${host2}        port=${PORT2}
    Login                          ${username2}    ${password2}    delay=1
    Log To Console                 Connected to server ${host2}:${p2}
    Set Client Configuration       timeout=25 seconds      prompt=#:
    ${output}=                     Execute Command         ls -lrt /boot/efi/EFI/BOOT/ | grep fbx64.efi | awk '{print $5}'
    Should Be Equal                ${output}               88112

Checking whether Reader2 (ENIQ Gen 10+) server has proper fbx64.efi file after II or Upgrade
    [Tags]                         II-Reader2
    Open Connection                ${host3}        port=${PORT3}
    Login                          ${username3}    ${password3}    delay=1
    Log To Console                 Connected to server ${host3}:${p3}
    Set Client Configuration       timeout=25 seconds      prompt=#:
    ${output}=                     Execute Command         ls -lrt /boot/efi/EFI/BOOT/ | grep fbx64.efi | awk '{print $5}'
    Should Be Equal                ${output}               88112

