*** Settings ***
Library    SSHLibrary
Library    String
Library    Collections
Resource    ../../Resources/Keywords/Cli.robot
Resource    ../../Resources/Keywords/Installer.robot
Resource    ../../Resources/Keywords/Variables.robot

*** Variables ***
${SERVER}           atvts4150
${host_123}         ${SERVER}.athtem.eei.ericsson.se
# ${port_for_vapp}    2251

*** Test Cases *** 
Node Granularity check.
    Create connection
    ${dwhrep_pass}    execute command     /eniq/sw/installer/getPassword.bsh -u dwhrep |grep -i Password | cut -d ':' -f 2
    Write    echo -e "SELECT Technology, COUNT(*) as count FROM NodeTypeGranularity GROUP BY Technology, Node_Type HAVING COUNT(*) > 1;\\ngo\\n" | isql -P ${dwhrep_pass} -U dwhrep -S repdb -b
    ${result}    Read Until Prompt    strip_prompt=True
    ${val}    Split String    ${result}    \r\n
    ${val}    Remove From List    ${val}    -1
    ${len}    Get Length    ${val}
    IF    ${len} > 0
        Fail    Multiple node type is available under single technology, below is the output of the SQL command ${\n}${val}
    ELSE
        Log    No duplicated node_types found.
    END



*** Keywords ***
Create connection
    Connect to physical server