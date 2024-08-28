*** Settings ***
Library    SSHLibrary
Library    RPA.Browser.Selenium
Library    DateTime
Library    String
Library    Collections
Resource    ../../Resources/Keywords/Cli.robot
Resource    ../../Resources/Keywords/Variables.robot
Suite Setup   Open connection as root user
Suite Teardown   Close All Connections





*** Test Cases ***
 Default logging level of alarmcfg to be changed from FINEST to INFO
    ${check_alarmcfg_log}=    Execute Command    ls /eniq/log/sw_log/alarmcfg | grep -i alarmcfg.*| tail -1  
    ${check_for_log_level}    Execute Command    cat /eniq/log/sw_log/alarmcfg/${check_alarmcfg_log} | cut -d " " -f3
    ${check_for_log_level_list}    Split String    ${check_for_log_level}
    ${status_of_log_level}    Run Keyword And Return Status    Should Not Contain Any    ${check_for_log_level_list}    FINER    FINEST   FINE
    IF    '${status_of_log_level}' == 'True'
        Pass Execution    All log level is INFO
    ELSE
        ${check_log_level_in_logging_file_1}    Execute Command    cat /eniq/sw/runtime/tomcat/webapps/alarmcfg/WEB-INF/classes/logging.properties | grep -i ".level" | tail -n +3
        Should Not Contain Any    ${check_log_level_in_logging_file_1}    FINER    FINEST   FINE
        # ${check_log_level_in_logging_file_2}    Execute Command    cat /eniq/sw/runtime/tomcat/webapps/alarmcfg/WEB-INF/classes/logging.properties | grep -i "com.ericsson.eniq.alarmcfg.level"
        # Should Not Contain Any    ${check_log_level_in_logging_file_2}    FINER    FINEST    FINE
        # ${check_log_level_in_logging_file_3}    Execute Command    cat /eniq/sw/runtime/tomcat/webapps/alarmcfg/WEB-INF/classes/logging.properties | grep -i "com.ericsson.eniq.alarmcfg.servlets.level" 
        # Should Not Contain Any    ${check_log_level_in_logging_file_3}    FINER    FINEST    FINE

    END
    
   