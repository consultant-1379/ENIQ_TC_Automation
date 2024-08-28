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
	   
Checking whether Simplex Rack (ENIQ Gen 10+) server has proper fbx64.efi file after II or Upgrade
       [Tags]                         fbx64
       Set Client Configuration       timeout=25 seconds      prompt=#:
       ${output}=                     Execute Command         ls -lrt /boot/efi/EFI/BOOT/ | grep fbx64.efi | awk '{print $5}'
       Should Be Equal                ${output}               88112
