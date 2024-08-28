*** Settings ***
Library    RPA.Database
*** Variables ***
${host}    atvts4078.athtem.eei.ericsson.se
${port}    2640
${dbname}    dwhdb
${user}    dc
${pwd}    Dc12#
*** Tasks ***
Connecting to the Databases
    Connect To Database    pymysql    ${dbname}    ${user}    ${pwd}    ${host}    ${port}
    ${res}    Query    select * from DIM_E_CN
    Disconnect From Database
*** Keywords ***
# Execute Query and return output
#     [Arguments]     ${query}
#     Set Client Configuration	  prompt=dc)>
#     Write               dbisql -c "UID=dc;PWD=Eniq@1234" -host ieatrcxb3720.athtem.eei.ericsson.se -port 2640 -nogui
#     Sleep    30s
#     ${op1} =                        Read Until Regexp    dc
#     log    ${op1}
#     Write               ${query}
#     Sleep    60s
#     ${op2} =                        Read 
#     log    ${op2}  
#     [return]      ${op2}