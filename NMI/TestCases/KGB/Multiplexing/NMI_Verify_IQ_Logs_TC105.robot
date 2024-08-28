*** Settings ***
Suite Setup        Open Connection And Log In
Suite Teardown     Close All Connections
Library            SSHLibrary
Library            BuiltIn
Library            String
Resource           ../../Resources/resource.txt


*** Test Cases ***
Verify the IQ logs for any exceptions thrown in iqmsg logs in /eniq/local_logs/iq/
    [Tags]                      IQ_LOGS
    Set Client Configuration    timeout=25 seconds          prompt=#:
    ${output}=                  Execute Command             cat /eniq/local_logs/iq/dwhdb.iqmsg | grep "Exception Thrown" | grep -v -E "Exception Thrown from hqmlib|Exception Thrown from optlib|Exception Thrown from slib|Exception Thrown from /home|Exception Thrown from dblib|Exception Thrown from dflib|Exception Thrown from oslib|Exception Thrown from vplib"
    Should not Contain            ${output}                    Exception Thrown

Verify the IQ logs for any errors in iqmsg logs in /eniq/local_logs/iq/
    [Tags]                      IQ_LOGS
    Set Client Configuration    timeout=25 seconds          prompt=#:
    ${output}=                  Execute Command             cat /eniq/local_logs/iq/dwhdb.iqmsg | | grep -i error
    Should not Contain            ${output}                    Error

Verify the IQ logs for any traces in iqmsg logs in /eniq/local_logs/iq/
    [Tags]                      IQ_LOGS
    Set Client Configuration    timeout=25 seconds          prompt=#:
    ${output}=                  Execute Command             cat /eniq/local_logs/iq/dwhdb.iqmsg | | grep -i stktrc
    Should not Contain            ${output}                    stktrc

Verify the IQ logs for any pstack traces in iqmsg logs in /eniq/local_logs/iq/
    [Tags]                      IQ_LOGS
    Set Client Configuration    timeout=25 seconds          prompt=#:
    ${output}=                  Execute Command             cat /eniq/local_logs/iq/dwhdb.iqmsg | | grep -i pstack
    Should not Contain            ${output}                    pstack

Verify the IQ logs for any sqlerror in iqmsg logs in /eniq/local_logs/iq/
    [Tags]                      IQ_LOGS
    Set Client Configuration    timeout=25 seconds          prompt=#:
    ${output}=                  Execute Command             cat /eniq/local_logs/iq/dwhdb.iqmsg | | grep -i sqlerror
    Should not Contain            ${output}                    sqlerror

Verify the IQ logs for any sqlcode in iqmsg logs in /eniq/local_logs/iq/
    [Tags]                      IQ_LOGS
    Set Client Configuration    timeout=25 seconds          prompt=#:
    ${output}=                  Execute Command             cat /eniq/local_logs/iq/dwhdb.iqmsg | | grep -i sqlcode
    Should not Contain            ${output}                    sqlcode
