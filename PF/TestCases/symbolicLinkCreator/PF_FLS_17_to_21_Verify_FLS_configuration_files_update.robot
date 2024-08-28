*** Settings ***
Documentation     Testing Symboliclinkcreator
Library    SSHLibrary
Library    String
Resource    ../../Resources/Keywords/Cli.robot
Resource    ../../Resources/Keywords/Variables.robot
Resource    ../../Resources/Keywords/FLS_keywords.robot
Suite Setup    Connect to server as a dcuser
Suite Teardown    Close All Connections

*** Test Cases ***

Verify FLS configuration file fls_conf update
    ${fls_conf_data}=    Execute Command    cat /eniq/installation/config/fls_conf
    @{alias_names}=    Split To Lines    ${fls_conf_data}
    Set Global Variable    ${alias_names}
    Log To Console    fls conf data: ${alias_names}
    FOR    ${fls_alias_name}    IN    @{alias_names}
        Validate output regex    ${fls_alias_name}    ^eniq_oss_[0-9]+$
    END  

Verify TC_18_To_21 FLS configuration files update
    Log To Console    \nfls conf data: ${alias_names}
    FOR    ${fls_alias_name}    IN    @{alias_names}
        ${oss_ref_file_output}=    Execute Command    cat /eniq/sw/conf/.oss_ref_name_file | grep -i ${fls_alias_name}
        Log To Console     oss ref name file data: ${oss_ref_file_output}
        Validate command output    ${oss_ref_file_output}    ${fls_alias_name}
        ${nas_ip_ref_file}=    Execute Command    cat /eniq/sw/conf/.oss_ref_name_file | grep -i ${fls_alias_name} | awk '{print $2}'
        Vaildate variable contain data and set global    ${nas_ip_ref_file}


        ${service_names_file_output}=    Execute Command    cat /eniq/sw/conf/service_names | grep -i ${fls_alias_name}
        Log To Console    service names file data: ${service_names_file_output}
        # Validating nas ip and fls alias name
        Validate output regex   ${service_names_file_output}    ${nas_ip_ref_file}::${fls_alias_name}::${fls_alias_name}


        ${enmserverdetail_file_output}=    Execute Command    cat /eniq/sw/conf/enmserverdetail
        Validate command output    ${enmserverdetail_file_output}    ${nas_ip_ref_file}
        ${fls_enm_hostname}=    Execute Command    cat /eniq/sw/conf/enmserverdetail | grep -i ${nas_ip_ref_file} | awk '{print $2}'
        Vaildate variable contain data and set global    ${fls_enm_hostname}
        ${fls_enm_hostname_ip}=    Execute Command    ping -c 1 ${fls_enm_hostname} | grep -oE '[0-9]+\.[0-9]+\.[0-9]+\.[0-9]+' | awk 'NR==1'        
        Vaildate variable contain data and set global    ${fls_enm_hostname_ip}


        ${hosts_file_output}=    Execute Command    cat /etc/hosts | grep -i ${fls_alias_name}
        Log To Console    hosts file fls alias data: ${hosts_file_output}
        # Validating nas ip and fls alias name
        Validate output regex    ${hosts_file_output}    ${nas_ip_ref_file}\\s+${fls_alias_name}\\s+${fls_alias_name}
        ${hosts_file_output}=    Execute Command    cat /etc/hosts | grep -i ${fls_enm_hostname}
        Log To Console    hosts file enm data: ${hosts_file_output}
        # Validating enm hostname and enm hostname ip
        Validate output regex     ${hosts_file_output}    ${fls_enm_hostname_ip}\\s+${fls_enm_hostname} 
    END


