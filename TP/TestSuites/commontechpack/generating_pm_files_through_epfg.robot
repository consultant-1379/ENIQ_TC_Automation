*** Settings ***
Resource          ../../Resources/login.resource
Library           ../../TestCases/server.py
Test Setup        Open Connection And Log In
Test Teardown     Close All Connections

*** Variables ***
${path}=    /root/CI/cicd/space/workspace/TP_ROBOT_Test/ENIQ_TC_Automation/TP/Resources/
*** Test Cases ***
generating pm files
    editing epfg properties files

*** Keywords ***
editing epfg properties files
   Put File    ${path}epfgdataGeneration.pl    /eniq/home/dcuser
   Put File    ${path}data.txt    /eniq/home/dcuser
   Put Directory    ${path}TopologyFiles    /eniq/home/dcuser    recursive=true
   Write    cd /eniq/home/dcuser ; perl epfgdataGeneration.pl
   ${output}=    Read    delay=10s
   get datefrom epfg output    ${output}
   Write    cd /eniq/home/dcuser/epfg ; ./start_epfg.sh
   Read    delay=10s