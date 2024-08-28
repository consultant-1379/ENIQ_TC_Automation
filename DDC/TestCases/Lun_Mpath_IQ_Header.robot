*** Settings ***
Suite Setup        Open Connection And Log In
Suite Teardown     Close All Connections
Library            SSHLibrary
Library            DateTime
Library            DependencyLibrary
Resource           ../Resources/Resource.resource


*** Test Cases ***
Checking for Lun file and size in Lun Mpath Mapping source TC01
    [Documentation]      Checking for mpath_iq_value_${hostname}.log file and size in /var/tmp/mpath_iq_value_${hostname}.log directory
    [Tags]               Lun_Mpath_IQ_Header
    ${src_mpath_iq}=      Run Keyword And Return Status    Check File Exists    /var/tmp/mpath_iq_value_${hostname}.log
    Set Global Variable    ${src_mpath_iq}
    Log To Console    ${src_mpath_iq}
    IF    ${src_mpath_iq} == True
    ${src_mpath_iq_size}=    Check File Size New      /var/tmp/mpath_iq_value_${hostname}.log
    Set Global Variable      ${src_mpath_iq_size}
    Run Keyword If   ${src_mpath_iq_size}==0   Fail    Size is zero.
    ELSE
        Skip   /var/tmp/mpath_iq_value_${hostname}.log log and size are not there in the source path /var/tmp
    END

Checking for Lun file and size in Lun Mpath Mapping destination TC02
    Skip If    ${src_mpath_iq} == False
    Depends on test      Checking for Lun file and size in Lun Mpath Mapping source TC01
    [Documentation]      Checking for lun_mpath_mapping*.json  in /eniq/log/ddc_data/${hostname}/${date_dmy}/plugin_data/lun_mpath_iq_header_mapping directory
    [Tags]               Lun_Mpath_IQ_Header
    ${des_output_variable}=     Execute Command    ls -lrth /eniq/log/ddc_data/${hostname}/${date_dmy}/plugin_data/lun_mpath_iq_header_mapping | awk '/lun_mpath_mapping/ {print $9}' | tail -1
    ${des_mpath_iq}=     Run Keyword And Return Status     Check File Exists    /eniq/log/ddc_data/${hostname}/${date_dmy}/plugin_data/lun_mpath_iq_header_mapping/${des_output_variable}
    Set Global Variable    ${des_mpath_iq}
    Log To Console    ${des_mpath_iq}
    IF    ${des_mpath_iq} == True
    ${des_mpath_iq_size}=    Check File Size New      /eniq/log/ddc_data/${hostname}/${date_dmy}/plugin_data/lun_mpath_iq_header_mapping/${des_output_variable}
    Set Global Variable    ${des_mpath_iq_size}
    Run Keyword If   ${des_mpath_iq_size}==0   Fail    Size is zero.
    ELSE
        Fail   ${des_output_variable} log and size are not available in the destination path
    END

Checking for mpath flag file and size in Lun Mpath Mapping source TC03
    [Documentation]      Checking for mpath_not_correct_${hostname}.txt file and size in /var/tmp/mpath_not_correct_${hostname}.txt directory
    [Tags]               Lun_Mpath_IQ_Header
    ${src_mpath_flag}=      Run Keyword And Return Status    Check File Exists    /var/tmp/mpath_not_correct_${hostname}.txt
    Set Global Variable    ${src_mpath_flag}
    Log To Console    ${src_mpath_flag}
    IF    ${src_mpath_flag} == True
    ${src_mpath_flag_size}=    Check File Size New      /var/tmp/mpath_not_correct_${hostname}.txt
    Set Global Variable      ${src_mpath_flag_size}
    Run Keyword If   ${src_mpath_flag_size}==0   Fail    Size is zero.
    ELSE
        Skip   /var/tmp/mpath_not_correct_${hostname}.txt log and size is not there in the source path /var/tmp
    END

Checking for mpath flag file and size in Lun Mpath Mapping destination TC04
    Skip If    ${src_mpath_flag} == False
    Depends on test      Checking for mpath flag file and size in Lun Mpath Mapping source TC03
    [Documentation]      Checking for lun_mpath_mapping*.json  in /eniq/log/ddc_data/${hostname}/${date_dmy}/plugin_data/lun_mpath_iq_header_mapping directory
    [Tags]               Lun_Mpath_IQ_Header
    ${des_output_variable}=     Execute Command    ls -lrth /eniq/log/ddc_data/${hostname}/${date_dmy}/plugin_data/lun_mpath_iq_header_mapping | awk '/mpath_not_correct/ {print $9}' | tail -1
    ${des_mpath_iq}=     Run Keyword And Return Status     Check File Exists    /eniq/log/ddc_data/${hostname}/${date_dmy}/plugin_data/lun_mpath_iq_header_mapping/${des_output_variable}
    Set Global Variable    ${des_mpath_iq}
    Log To Console    ${des_mpath_iq}
    IF    ${des_mpath_iq} == True
    ${des_mpath_iq_size}=    Check File Size New      /eniq/log/ddc_data/${hostname}/${date_dmy}/plugin_data/lun_mpath_iq_header_mapping/${des_output_variable}
    Set Global Variable    ${des_mpath_iq_size}
    Run Keyword If   ${des_mpath_iq_size}==0   Fail    Size is zero.
    ELSE
        Fail   ${des_output_variable} log and size are not available in the destination path
    END

Checking for IQ header flag file and size in Lun Mpath Mapping source TC05
    [Documentation]      Checking for IQ_header_not_correct_${hostname}.txt file and size in /var/tmp/IQ_header_not_correct_${hostname}.txt directory
    [Tags]               Lun_Mpath_IQ_Header
    ${src_iq_header_flag}=      Run Keyword And Return Status    Check File Exists    /var/tmp/IQ_header_not_correct_${hostname}.txt
    Set Global Variable    ${src_iq_header_flag}
    Log To Console    ${src_iq_header_flag}
    IF    ${src_iq_header_flag} == True
    ${src_iq_header_flag_size}=    Check File Size New      /var/tmp/IQ_header_not_correct_${hostname}.txt
    Set Global Variable      ${src_iq_header_flag_size}
    Run Keyword If   ${src_iq_header_flag_size}==0   Fail    Size is zero.
    ELSE
        Skip   /var/tmp/IQ_header_not_correct_${hostname}.txt log and size is not there in the source path /var/tmp
    END

Checking for IQ header flag file and size in Lun Mpath Mapping destination TC06
    Skip If    ${src_iq_header_flag} == False
    Depends on test      Checking for IQ header flag file and size in Lun Mpath Mapping source TC05
    [Documentation]      Checking for lun_mpath_mapping*.json  in /eniq/log/ddc_data/${hostname}/${date_dmy}/plugin_data/lun_mpath_iq_header_mapping directory
    [Tags]               Lun_Mpath_IQ_Header
    ${des_output_variable}=     Execute Command    ls -lrth /eniq/log/ddc_data/${hostname}/${date_dmy}/plugin_data/lun_mpath_iq_header_mapping | awk '/IQ_header_not_correct/ {print $9}' | tail -1
    ${des_iq_header}=     Run Keyword And Return Status     Check File Exists    /eniq/log/ddc_data/${hostname}/${date_dmy}/plugin_data/lun_mpath_iq_header_mapping/${des_output_variable}
    Set Global Variable    ${des_iq_header}
    Log To Console    ${des_iq_header}
    IF    ${des_iq_header} == True
    ${des_iq_header_size}=    Check File Size New      /eniq/log/ddc_data/${hostname}/${date_dmy}/plugin_data/lun_mpath_iq_header_mapping/${des_output_variable}
    Set Global Variable    ${des_iq_header_size}
    Run Keyword If   ${des_iq_header_size}==0   Fail    Size is zero.
    ELSE
        Fail   ${des_output_variable} log and size is not available in the destination path
    END
