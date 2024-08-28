*** Settings ***
Library    CryptoLibrary    variable_decryption=True
Library    SSHLibrary
Variables    ../Resources/Variables/Variables.py
Library    ../Scripts/check_blade_rack_type.py
Library    ../Scripts/verify_new_mount_parameters_enabled_on_ENIQ_server.py
Library    ../Scripts/verify_sprint_value.py
Test Setup    Login to ENIQ
Test Teardown    Close All Connections
*** Keywords ***
Login to ENIQ
    Open Connection    ${hostname}
    Login    ${username}    ${password}    delay=1
*** Test Cases ***
Verify if /home, /var/tmp, /tmp and /var log parameters are created
    ${output}=    check_blade_rack_type    ${hostname}    ${username}    ${password}
    Log To Console    ${output}
    ${output1}=    Execute Command    cat /eniq/installation/config/$(hostname)_installation_param_details | grep 'om_sw_locate'
    ${output2}=    check_sprint_value    ${output1}
    Log To Console    ${output2}
    IF    "${output2}"=="gt"
        IF    "${output}"=="BL"
	    ${op1}=    Execute Command     df -h
            Should Contain    ${op1}     /home
            Should Contain    ${op1}     /tmp
            Should Contain    ${op1}     /var/tmp
            Should Contain    ${op1}     /var/log
            ${op2}=    check_mount_parameters_enabled    ${hostname}    ${username}    ${password}
            Should Contain    ${op2}    True
	ELSE      
	    ${op}=    check_mount_parameters_enabled    ${hostname}    ${username}    ${password}
	    Should Contain    ${op}    True
        END
    ELSE    
    	IF    "${output}"=="BL"       
	    ${op1}=    Execute Command     df -h | grep '/home'
            ${op2}=    Execute Command     df -h | grep '/tmp'
            ${op3}=    Execute Command     df -h | grep '/var/tmp'
            ${op4}=    Execute Command     df -h | grep '/var/log'
            Should Be Empty    ${op1}
            Should Be Empty    ${op2}
            Should Be Empty    ${op3}
            Should Be Empty    ${op4}
        END
    END
