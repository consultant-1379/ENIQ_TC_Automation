*** Settings ***
Library    SSHLibrary
Resource    ../../Resources/Keywords/Cli.robot
Suite Setup   Open connection as root user
Suite Teardown   Close All Connections


*** Test Cases ***
Verify whether JRMP exception occured in server	    
    ${pf_current_date}=    Execute Command    date +"%Y_%m_%d"
    ${ct_engfile}=    Execute Command    ls /eniq/log/sw_log/engine/ | grep -i "\\bengine-${pf_current_date}.log\\b"
    # ${ct_engfile}=    Execute Command    ls /eniq/log/sw_log/engine/ | grep -i "\\bdemo_engine_file.log\\b"
    ${file_status}=    Run Keyword And Return Status    Should Not Be Empty    ${ct_engfile}
    IF    ${file_status} == True
        ${check_engine_logs}    ${stderr}=    Execute Command    cat /eniq/log/sw_log/engine/${ct_engfile} | grep -i "\\bJRMP connection establishment\\b"    return_stderr=True
        Should Be Empty    ${stderr}
        Should Be Empty    ${check_engine_logs}
    ELSE
        Skip   Engine file not present for date-${pf_current_date}
    END


Verify whether the Truststore and malformed exception is occurred in the server	    
    ${pf_current_date}=    Execute Command    date +"%Y_%m_%d"
    ${ct_engfile}=    Execute Command    ls /eniq/log/sw_log/engine/ | grep -i "\\bengine-${pf_current_date}.log\\b"
    ${file_status}=    Run Keyword And Return Status    Should Not Be Empty    ${ct_engfile}
    IF    ${file_status} == True
        ${check_engine_logs}    ${stderr}=    Execute Command    cat /eniq/log/sw_log/engine/${ct_engfile} | grep -i "\\bMalformedURLException\\b"    return_stderr=True
        Should Be Empty    ${stderr}
        Should Be Empty    ${check_engine_logs}
    ELSE
        Skip   Engine file not present for date-${pf_current_date}
    END

