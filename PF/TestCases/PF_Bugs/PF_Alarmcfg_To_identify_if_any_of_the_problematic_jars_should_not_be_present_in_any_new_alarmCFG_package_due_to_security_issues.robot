*** Settings ***
Library    SSHLibrary
Resource    ../../Resources/Keywords/Cli.robot
Resource    ../../Resources/Keywords/Variables.robot
Suite Setup   Open connection as root user
Suite Teardown   Close All Connections


*** Test Cases ***
Testcase_1
    ${check_context_log_1}    ${stderr}=    Execute Command    ls /eniq/sw/runtime/tomcat/webapps/alarmcfg/WEB-INF/lib/external/ | grep -i "log4j.jar"    return_stderr=True
    Should Be Empty    ${stderr}
    Should Be Empty    ${check_context_log_1}

Testcase_2
     ${check_context_log_2}    ${stderr}=    Execute Command    ls /eniq/sw/runtime/tomcat/webapps/alarmcfg/WEB-INF/lib/external/ | grep -i "log4j-api.jar"    return_stderr=True
    Should Be Empty    ${stderr}
    Should Be Empty    ${check_context_log_2}

Testcase_3
     ${check_context_log}    ${stderr}=    Execute Command    ls /eniq/sw/runtime/tomcat/webapps/alarmcfg/WEB-INF/lib/external/ | grep -i "log4j-core.jar"    return_stderr=True
    Should Be Empty    ${stderr}
    Should Be Empty    ${check_context_log}

Testcase_4
     ${check_context_log}    ${stderr}=    Execute Command    ls /eniq/sw/runtime/tomcat/webapps/alarmcfg/WEB-INF/lib/external/axis2/1.7.9/ | grep -i "log4j.jar"    return_stderr=True
    Should Be Empty    ${stderr}
    Should Be Empty    ${check_context_log}

Testcase_5
     ${check_context_log}    ${stderr}=    Execute Command    ls /eniq/sw/runtime/tomcat/webapps/alarmcfg/WEB-INF/lib/external/axis2/1.7.9/ | grep -i "log4j-api.jar"    return_stderr=True
    Should Be Empty    ${stderr}
    Should Be Empty    ${check_context_log}

Testcase_6
     ${check_context_log}    ${stderr}=    Execute Command    ls /eniq/sw/runtime/tomcat/webapps/alarmcfg/WEB-INF/lib/external/axis2/1.7.9/| grep -i "log4j-core.jar"    return_stderr=True
    Should Be Empty    ${stderr}
    Should Be Empty    ${check_context_log}

Testcase_7
     ${check_context_log}    ${stderr}=    Execute Command    ls /eniq/sw/runtime/tomcat/webapps/alarmcfg/WEB-INF/lib/external/license/ | grep -i "slf4j-api-LICENSE.txt"    return_stderr=True
    Should Be Empty    ${stderr}
    Should Be Empty    ${check_context_log}

Testcase_8
     ${check_context_log}    ${stderr}=    Execute Command    ls /eniq/sw/runtime/tomcat/webapps/alarmcfg/WEB-INF/lib/external/license/ | grep -i "slf4j-jcl-LICENSE.txt"    return_stderr=True
    Should Be Empty    ${stderr}
    Should Be Empty    ${check_context_log}

Testcase_9
     ${check_context_log}    ${stderr}=    Execute Command    ls /eniq/sw/runtime/tomcat/webapps/alarmcfg/WEB-INF/lib/external/license/axis2-1.7.9/ | grep -i "log4j.txt"    return_stderr=True
    Should Be Empty    ${stderr}
    Should Be Empty    ${check_context_log}

Testcase_10
     ${check_context_log}    ${stderr}=    Execute Command    ls /eniq/sw/runtime/tomcat/webapps/alarmcfg/WEB-INF/lib/external/license/axis2-1.7.9/ | grep -i "log4j-LICENSE.tx"    return_stderr=True
    Should Be Empty    ${stderr}
    Should Be Empty    ${check_context_log}

Testcase_11
     ${check_context_log}    ${stderr}=    Execute Command    ls /eniq/sw/runtime/tomcat/webapps/alarmcfg/WEB-INF/lib/bundles/ | grep -i "com.businessobjects.log4j.jar"    return_stderr=True
    Should Be Empty    ${stderr}
    Should Be Empty    ${check_context_log}

Testcase_12
     ${check_context_log}    ${stderr}=    Execute Command    ls /eniq/sw/runtime/tomcat/webapps/alarmcfg/WEB-INF/lib/external | grep -i "commons-text-1.6.jar"    return_stderr=True
    Should Be Empty    ${stderr}
    Should Be Empty    ${check_context_log}

Testcase_13
     ${check_context_log}    ${stderr}=    Execute Command    ls /eniq/sw/runtime/tomcat/webapps/alarmcfg/WEB-INF/lib/ | grep -i "commons-text-1.6.jar"    return_stderr=True
    Should Be Empty    ${stderr}
    Should Be Empty    ${check_context_log}

Testcase_14
    ${_problamatic_jar}    Execute Command    ls /eniq/sw/runtime/tomcat/webapps/alarmcfg/WEB-INF/lib/external/ | grep -i cxf-core-
    Should Be Empty   ${_problamatic_jar} 




