*** Settings ***
Suite Setup        Open Connection and SSH Login
Suite Teardown     Close All Connections

Resource           ../../Resources/cTAF_resource.resource

Library            OperatingSystem
Library            SSHLibrary  10 seconds
Library            String

*** Test Cases ***
Test selinux context for all ifcfg files
    ${files}=    Execute Command      sudo ls /etc/sysconfig/network-scripts | grep -i "ifcfg-"
    @{files_Split}=       Split String       ${files}
    FOR    ${file}    IN    @{files_Split}
        ${output}=    Execute Command    sudo ls -lZ /etc/sysconfig/network-scripts/${file}
        Should Contain    ${output}    net_conf_t
    END