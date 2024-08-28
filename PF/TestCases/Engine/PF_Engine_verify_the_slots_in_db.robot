*** Settings ***
Documentation     Testing AdminUI web
Library    SSHLibrary
Library    String
Library    Collections
Library    DateTime
Library    OperatingSystem
Resource    ../../Resources/Keywords/Variables.robot
Resource    ../../Resources/Keywords/Cli.robot
#Suite Setup    Connect to server as a dcuser
Suite Teardown    Close All Connections
 
*** Variables ***
@{eniq_stats_raw}    0.9    0.1    0.05
@{eniq_stats_fs}    0.9    0.2    0.05
@{stats_coordinator}    1.8    0.35    0.125
@{eniq_coordinator}    0.25    0.375    0.125    0.125    0.125    0.5        
${n}    0
${cpu_core_value}    0
${final_result}    0
 
*** Test Cases ***
verifying the slots with db
    Open connection as root user
    Set Client Configuration    prompt=REGEXP:${SERVER}\\[[^\\]]+\\]\\s\\{dcuser\\}\\s#:
    Write    su - dcuser  
    ${dcuser}    Read Until Prompt    strip_prompt=True
    ${etlrep_pwd}=    Execute Command    /eniq/sw/installer/getPassword.bsh -u ETLREP | awk '{print $NF}'
    ${etlrep_pwd_status}=    Run Keyword And Return Status    Should Not Be Empty    ${etlrep_pwd}
    Skip If    ${etlrep_pwd_status}==False
    Set Global Variable    ${etlrep_pwd}
    Write    echo -e "select count(*) from META_EXECUTION_SLOT;\\ngo\\n" | isql -P ${etlrep_pwd} -U etlrep -S repdb -b
    ${cmd_output}=    Read Until Prompt    strip_prompt=True
    ${db_output}    Strip String    ${cmd_output}
    ${cpu_core_value1}    Execute Command    cat /proc/cpuinfo | grep -i 'core id' | wc -l
    ${Storage_type}    Execute Command      cat /eniq/installation/config/san_details | grep STORAGE_TYPE | awk -F"=" '{print $2}'
    ${Server_type}    Execute Command     cd /eniq/sw/conf && cat server_types
    ${condition_eniq_stats_raw}     Run Keyword And Return Status   Should Contain    ${Storage_type}    raw
    ${condition_eniq_stats_fs}     Run Keyword And Return Status   Should Contain    ${Storage_type}    fs
    ${condition_2}     Run Keyword And Return Status   Should Contain    ${Server_type}    eniq_coordinator
    ${condition_3}     Run Keyword And Return Status   Should Contain    ${Server_type}    stats_coordinator
    ${condition_1}    Run Keyword And Return Status   Should Contain    ${Server_type}    eniq_stats
    #condition for gen10 plus server
    ${hardware}    Execute Command    dmidecode | grep -i Gen
    ${gen10+_check}      Run Keyword And Return Status    Should Contain    ${hardware}    Gen10 Plus
      IF    '${gen10+_check}' == 'True'
     ${deploy}    Execute Command     cat /eniq/installation/config/extra_params/deployment
    ${chassisTypeCommand}    Execute Command    sudo dmidecode -s chassis-type
    ${chassisTypeCommand_check}      Run Keyword And Return Status    Should Contain    ${chassisTypeCommand}    Rack
    ${text}    Execute Command     grep -iR MainDB count is 50 /eniq/log/sw_log/adminui
    ${checkmaindb}    Run Keyword And Return Status     Should Contain    ${text}     MainDB count is 50
	${deployment}    Run Keyword And Return Status    Should Match Regexp    ${deploy}     extralarge
            
              IF     '${chassisTypeCommand_check}'== 'True' and '${deployment}' == 'True'
               
            ${cpu_core_value}=    Evaluate    ${cpu_core_value1}/1.75 * 1.5
        ELSE
            ${cpu_core_value}=    Evaluate    ${cpu_core_value1}/1.75
        END   
          
    ELSE
         ${cpu_core_value}=      Evaluate    ${cpu_core_value1}
     END
   
    Run Keyword If    '${condition_2}' == 'True'    eniq_coordinator     ${cpu_core_value}       ${db_output}          
    Run Keyword If    '${condition_3}' == 'True'     stats_coordinator    ${cpu_core_value}       ${db_output}
    Run Keyword If  '${condition_1}' == 'True' and '${condition_eniq_stats_raw}' == 'True'  eniq_stats_raw  ${cpu_core_value}  ${db_output}
    Run Keyword If  '${condition_1}' == 'True' and '${condition_eniq_stats_fs}' == 'True'  eniq_stats_fs  ${cpu_core_value}  ${db_output}
     
*** Keywords ***
eniq_stats_raw
    [Arguments]    ${n}    ${dboutput}
    ${final_result}    Calculate Product With Core    ${n}    @{eniq_stats_raw}
    Log    keyword eniq_stats
    Log    final result :${final_result}  
    Log    db output: ${dboutput}          
    ${my_str}=    Convert To String    ${final_result}
    ${my_str1}=    Convert To String    ${dboutput}
    Should Match Regexp    ${my_str1}+'''     ${my_str}        
eniq_stats_fs
    [Arguments]    ${n}    ${dboutput}
    ${final_result}    Calculate Product With Core    ${n}    @{eniq_stats_fs}
    Log    keyword eniq_stats
    ${my_str}=    Convert To String    ${final_result}
    ${my_str1}=    Convert To String    ${dboutput}
    Should Match Regexp    ${my_str1}+'''     ${my_str}
 
stats_coordinator
    [Arguments]    ${n}    ${dboutput}
    ${final_result}    Calculate Product With Core    ${n}    @{stats_coordinator}      
    ${my_str}=    Convert To String    ${final_result}
    ${my_str1}=    Convert To String    ${dboutput}
    Should Match Regexp    ${my_str1}+'''     ${my_str}
 
 
eniq_coordinator
    [Arguments]    ${n}    ${dboutput}
    ${final_result}    Calculate Product With Core    ${n}    @{eniq_coordinator}        
    ${my_str}=    Convert To String    ${final_result}
    ${my_str1}=    Convert To String    ${dboutput}
    Should Match Regexp    ${my_str1}+'''     ${my_str}
Calculate Product With Core
    [Arguments]    ${n}    @{numbers}
    ${result}    Set Variable    0
    FOR    ${number}    IN    @{numbers}
        ${product_with_core}    Evaluate    ${n} * ${number}
        ${product_with_core_output}    Evaluate    int(math.ceil(${product_with_core}))
        ${result}    Evaluate    ${result} + ${product_with_core_output}
        ${final_result}    Evaluate    ${result} + 6
    END
    [Return]    ${final_result}