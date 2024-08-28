*** Settings ***
Suite Setup        Open Connection And Log In
Suite Teardown     Close All Connections
Library            SSHLibrary
Resource           ../../Resources/resource.txt

*** Test Cases ***
Checking whether Iqmsg is present or not
    [Tags]                      Iqmsg_Srvlog
    Set Client Configuration    timeout=25 seconds      prompt=#:
    ${output}=                  Execute Command         ls /eniq/local_logs/iq/ | grep "dwhdb.iqmsg"
    Should Contain              ${output}               dwhdb.iqmsg

Checking whether errors and exceptions are checked in Iqmsg or not
    [Tags]                      Iqmsg_Srvlog
    Set Client Configuration    timeout=25 seconds      prompt=#:
    ${output}=                  Execute Command         cat /eniq/local_logs/iq/dwhdb.iqmsg | grep "Exception Thrown" | grep -v -E "Exception Thrown from hqmlib|Exception Thrown from optlib|Exception Thrown from slib|Exception Thrown from /home|Exception Thrown from dblib|Exception Thrown from dflib|Exception Thrown from oslib|Exception Thrown from vplib"
    Should Not Contain          ${output}               Exception Thrown

Checking whether errors and exceptions are checked in Srvlog or not
    [Tags]                      Iqmsg_Srvlog
    Set Client Configuration    timeout=25 seconds      prompt=#:
    ${output}=                  Execute Command         ls /eniq/local_logs/iq/ | grep "srvlog"
    Should Contain              ${output}               srvlog
    ${output}=                  Execute Command         cat /eniq/local_logs/iq/${output}
    Should Not Contain          ${output}               Exception
