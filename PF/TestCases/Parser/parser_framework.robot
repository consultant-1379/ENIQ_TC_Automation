*** Settings ***
Library    RPA.Browser.Selenium  
Library    SSHLibrary
Library    String
Library    Collections 
Library    OperatingSystem   
Library    ../../Resources/Libraries/parserValidation.py
Resource    ../../Resources/Keywords/Variables.robot
Resource    ../../Resources/Keywords/Cli.robot
Resource    ../../Resources/Keywords/Parser.robot
Test Teardown    Close All Connections
*** Variables ***
${host_123}    atvts4071.athtem.eei.ericsson.se
${mismatchli}    not validated
${TescaseStatus}    True
${prmt}    eniqs[eniq_stats] {dcuser} #:
@{numberlist}    1    2    3    4    5    6    7
${pass_for_vapp}    Dcuser%12
*** Keywords ***
Check if passed
    [Arguments]    ${item}
    ${result}    Run Keyword And Return Status    Should Be True    ${item} == True
    Should Be True    ${result}
*** Test Cases ***    
Test1
    Open Connection    seliius26954.seli.gic.ericsson.se      
    Login    eniqdmt    EStAts(iDec$2()18 
    ${buildno}=    Execute Command     ls -ltd /proj/eiffel013_config_fem5s11/eiffel_home/FULL_PF_KGB_DATA/* | grep -E '/[0-9]+$' | head -n 1 | awk '{print $NF}'
    #${out}=    Read    delay=10s
    ${out}=    Execute Command    cd ${buildno} ; cat xid_comment_tech.txt
    ${del_pkg_list}=    Split String    ${out}
    Log To Console    ${del_pkg_list}
    Set Global Variable    ${del_pkg_list}
    ${mydict}=    Get Parser And Techpack
    FOR    ${key}    IN    @{my_dict.keys()}
        ${result}=    Set Variable    false
        FOR    ${element}    IN    @{del_pkg_list}
            ${is_present}=    Run Keyword And Return Status    Should Contain   ${element}    ${key}_
            Run Keyword If    ${is_present}    Set Global Variable    ${result}    true    
        END
        IF    '${result}' == 'false'
            Remove From Dictionary    ${mydict}    ${key}
        END
    END
    ${out}=    Execute Command     if grep -q "=parser_" ${buildno}/xid_comment_tech.txt ; then echo "true"; else echo "false"; fi
    ${out}    Set Variable    true
    IF    '${out}' == 'true'
        ${mydict}=    Get Parser And Techpack
    END
    Set Global Variable    ${mydict}
    Close Connection
Testing
    Open Connection    ${host_123}    port=${port_for_vapp}
    Login    ${user_for_vapp}   ${pass_for_vapp}
    Write    cd /eniq/home/dcuser
    Read    delay=20s
    ${temppath}=    Replace String    ${CURDIR}    \\    /
    ${relpath}=    Split String From Right    ${temppath}    separator=/    max_split=2
    Log To Console    ${relpath}
    ${server_name}=    Run Keyword And Return Status    Should Contain    ${host_123}    atvts
    IF    '${server_name}' == 'True'
        Set Client Configuration    prompt=${prmt}    timeout=3600
    ELSE
        ${prmtTmp}=    Split String    ${host_123}    separator=.
        ${prmt}=    Catenate    SEPARATOR=    ${prmtTmp}[0]    [eniq_stats] {dcuser} #:
        Set Client Configuration    prompt=${prmt}    timeout=3600
    END
    Put File    ${relpath}[0]/Scripts/topoFilesDb.sh    /eniq/home/dcuser
    Put File    ${relpath}[0]/Scripts/pmFilesDb.sh    /eniq/home/dcuser
    Put File    ${relpath}[0]/Scripts/changeFileDate.py    /eniq/home/dcuser
    ${dwhrep_pwd}=    Execute Command    ./test.bsh REP DWHREP | grep -i Password | cut -d ':' -f 2
    ${etlrep_pwd}=    Execute Command    ./test.bsh REP ETLREP | grep -i Password | cut -d ':' -f 2
    Write    cd /eniq/home/dcuser ; mkdir logofmismatch
    Read Until Prompt
    ${dwhdb_pwd}=    Execute Command    ./test.bsh DWH DC | grep -i Password | cut -d ':' -f 2
    FOR    ${key}    IN    @{my_dict.keys()}
        ${value}=    Get From Dictionary    ${mydict}    ${key}
        FOR    ${tp}    IN    @{value}
            ${TescaseStatus}=    Set Variable    True
            Log To Console    ${tp}
            ${tp}    Strip String    ${tp}
            ${tpTemp}=    Split String From Right    ${tp}    separator=_E_    max_split=1
            ${tpName}=    Set Variable    ${tpTemp}[-1]
            ${tpName}    Strip String    ${tpName}
            Log To Console    ${tpName}
            IF    '${tp}' == 'DC_E_BULK_CM' 
                Set Client Configuration    prompt=${prmt}    timeout=7200
            END
            IF    '${tp}' == 'DC_E_PCC' 
                Set Client Configuration    prompt=${prmt}    timeout=3600
            END
            IF    '${tp}' == 'DC_S_SMSF'
                ${tpName}=    Set Variable    SMSF
            END
            IF    '${tp}' == 'DC_C_CISCO'
                ${tpName}=    Set Variable    CISCO
            END
            IF    '${tp}' == 'DC_J_JUNOS'
                ${tpName}=    Set Variable    JUNOS
            END

# # moving files from repository to server
            Write    rm -rf /eniq/data/pmdata/eniq_oss_1/*
            Read Until Prompt
            Put Directory    ${relpath}[0]/Resources/MeasFiles/${tpName}topo    /eniq/home/dcuser    recursive=True
            Put Directory    ${relpath}[0]/Resources/MeasFiles/${tpName}    /eniq/home/dcuser    recursive=True
            Write    mv /eniq/home/dcuser/${tpName}topo/* /eniq/data/pmdata/eniq_oss_1
            Read Until Prompt 

# # Loading the data for tp
                
# # triggering adapter interface for topo
            Write    echo -e "select distinct TECHPACKNAME from TechPackDependency where VERSIONID LIKE '${tp}:%'and TECHPACKNAME like 'DIM_%'\\ngo\\n" | isql -P ${dwhrep_pwd} -U dwhrep -S repdb -b
            ${output}=    Read Until Prompt    strip_prompt=True
            ${DIM_list}    Split String    ${output}
            Remove From List    ${DIM_list}    -1
            Remove From List    ${DIM_list}    -1
            Remove From List    ${DIM_list}    -1
            FOR    ${element}    IN    @{DIM_list}
            ${element}    Strip String    ${element}
            Write    echo -e "select INTERFACENAME from InterfaceTechpacks where TECHPACKNAME like '${element}';\\ngo\\n" | isql -P ${dwhrep_pwd} -U dwhrep -S repdb -b
            ${output1}=    Read Until Prompt    strip_prompt=True
            ${intfDIM}    Split String    ${output1}
            Remove From List    ${intfDIM}    -1
            Remove From List    ${intfDIM}    -1
            Remove From List    ${intfDIM}    -1
            #Log To Console    ${intfDIM}
            IF    ${intfDIM} == []
                Log    no interfaces found in eniq 
                ${TescaseStatus}=    Set Variable    False
            END
            FOR    ${currintf}    IN    @{intfDIM}
                ${TescaseStatus}=    Set Variable    True
                Write    echo -e "select DATAFORMATTYPE from DataInterface where INTERFACENAME LIKE '${currintf}'\\ngo\\n" | isql -P ${dwhrep_pwd} -U dwhrep -S repdb -b
	            ${out}    Read Until Prompt    strip_prompt=True
                ${par}    Split String    ${out}
	            ${parser_name}    Set Variable   ${par}[0] 
                Write    engine -e startSet '${currintf}-eniq_oss_1' 'Adapter_${currintf}_${parser_name}'
                ${out}=    Read Until Prompt
	            #${output}=    Should Contain    ${out}    Start set requested successfully    Failed starting Adapter set for ${currintf}-eniq_oss_1
                ${contains}=    Run Keyword And Return Status    Should Contain    ${out}    Start set requested successfully
                IF    '${contains}' != 'True'
                    ${TescaseStatus}=    Set Variable    False
                END
	        END
            Log    ${\n}Adapter Set Successfully Started
            
                
            END
            

# # # # #

# run the validation for topo
            Write    echo -e "select distinct substr(CONFIG,charindex('basetable',CONFIG)+10) from Transformation where target like 'dc_release' and TRANSFORMERID like '${tp}:%'\\ngo\\n" | isql -P ${dwhrep_pwd} -U dwhrep -S repdb -b
            ${output}=    Read Until Prompt    strip_prompt=True
            ${topotableTemp}    Split String    ${output}
            Log To Console    ${topotableTemp}[0]
            
            IF    '${tp}' == 'DC_E_MGW'
                ${topoTable}=    Create List    DIM_E_CN_CN
            ELSE IF    '${tp}' == 'SGSN'
                ${topoTable}=    Create List    DIM_E_CN_SGSN
            ELSE IF    '${tp}' == 'DC_E_ADC'
                ${topoTable}=    Create List    DIM_E_SHARED_CNF_NE
            ELSE IF    '${tp}' == 'DC_E_cSBG'
                ${topoTable}=    Create List    DIM_E_SHARED_CNF_NE
            ELSE
               ${topoTable}=    Split String    ${topotableTemp}[0]    separator=, 
            END
            IF    '${topotableTemp}[0]' == '(0'
                Log To Console    table not found
                ${topoTable}=    Create List    
            END
            FOR    ${element}    IN    @{topoTable}
                Log    ${element}
                Write    cd /eniq/home/dcuser ; echo "${element}" | ./topoFilesDb.sh
                Read Until Prompt
                Log    Validation for TopoTable
                ${list_db}    list of data    OutputFiles/${topotableTemp}[0].txt    ${host_123}    ${port_for_vapp}    ${user_for_vapp}    ${pass_for_vapp}
                #Log To Console    ${list_db}
                ${list_text}=    List Of Text    ${relpath}[0]/Resources/LoaderFiles/${element}.txt
                #Log To Console    ${list_text}
                ${status}    ${mismatchli}    Validation    ${list_db}    ${list_text}    ''    ''
                #Log To Console    topo table status -> ${status} and mismatch is ${mismatchli}
                #${passed}=    Run Keyword And Return Status   Evaluate    type(${mismatchli}).__name__
                # IF   '${status}' == 'notvalidated' 
                #         ${TescaseStatus}=    Set Variable    False
                #     Write    echo -e '${list_db} --- ${list_text} --- ${mismatchli}' > /eniq/home/dcuser/logofmismatch/${topotableTemp}[0].txt
                #         Read Until Prompt
                # END
                # Write    rm -rf /eniq/home/dcuser/OutputFiles
                # Read Until Prompt
            END
            


####Looping over the tables for tp

            Write    cd /eniq/home/dcuser ; python changeFileDate.py ${tpName}
            Read Until Prompt
            Write    mv /eniq/home/dcuser/${tpName}/* /eniq/data/pmdata/eniq_oss_1
            Read Until Prompt
            Write    echo -e "select distinct interfacename from interfacemeasurement WHERE dataformatid like '${tp}:%' and dataformatid like '%${key}'\\ngo\\n" | isql -P ${dwhrep_pwd} -U dwhrep -S repdb -b
            ${output1}=    Read Until Prompt    strip_prompt=True
            ${intfDC}    Split String    ${output1}
            Remove From List    ${intfDC}    -1
            Remove From List    ${intfDC}    -1
            Remove From List    ${intfDC}    -1
            #Log To Console    ${intfDC}
            #Log To Console    ${intfDIM}
            IF    ${intfDC} == []
                Log    no interfaces found in eniq 
                ${TescaseStatus}=    Set Variable    False
            END
            FOR    ${currintf}    IN    @{intfDC}
                ${TescaseStatus}=    Set Variable    True
                Write    engine -e startSet '${currintf}-eniq_oss_1' 'Adapter_${currintf}_${key}'
                ${out}=    Read Until Prompt
	            #Should Contain    ${out}    Start set requested successfully    Failed starting Adapter set for ${currintf}-eniq_oss_1
	            ${contains}=    Run Keyword And Return Status    Should Contain    ${out}    Start set requested successfully
                IF    '${contains}' != 'True'
                    ${TescaseStatus}=    Set Variable    False
                END
            END
            

# run the validation for PM
            Write    echo -e "select versionid from versioning where techpack_name='${tp}'\\n${run}\\n" | isql -P ${dwhrep_pwd} -U dwhrep -S repdb -b
            ${versionid}    Read Until Prompt    strip_prompt=True
            ${versionid}    Split String    ${versionid}
            Write    echo -e "select distinct substr(dataformatid, charindex('):',dataformatid)+2,len(dataformatid)- len(':${key}')-len('${versionid}[0]:')) from interfacemeasurement WHERE dataformatid like '${tp}:%' and dataformatid like '%${key}'\\n${run}\\n" | isql -P ${dwhrep_pwd} -U dwhrep -S repdb -b
            ${table_names}    Read Until Prompt    strip_prompt=True
            ${table_names}    Split String    ${table_names}
            Remove From List    ${table_names}    -1
            Remove From List    ${table_names}    -1
            Remove From List    ${table_names}    -1
            #Log To Console    ${table_names}
            Write    echo -e "select versionid from versioning where techpack_name='${tp}'\\n${run}\\n" | isql -P ${dwhrep_pwd} -U dwhrep -S repdb -b
            ${versionid}    Read Until Prompt    strip_prompt=True
            ${versionid}    Split String    ${versionid}
            Write    echo -e "select typename from MeasurementType WHERE TYPEID like '${versionid}[0]%' and (description like '%Deprecated%' or followjohn='0')\\n${run}\\n" | isql -P ${dwhrep_pwd} -U dwhrep -S repdb -b
            ${deprecated_table_names}    Read Until Prompt    strip_prompt=True
            ${deprecated_table_names}    Split String    ${deprecated_table_names}
            Remove From List    ${deprecated_table_names}    -1
            Remove From List    ${deprecated_table_names}    -1
            Remove From List    ${deprecated_table_names}    -1
            FOR    ${element}    IN    @{deprecated_table_names}
                ${index}    Get Index From List    ${table_names}    ${element}
                IF    ${index} >= 0
                    Remove From List    ${table_names}    ${index}
                END
            END
            Write    cd /eniq/home/dcuser ; echo "${versionid}[0]" | ./pmFilesDb.sh
            Read Until Prompt
            FOR    ${element}    IN    @{table_names}
                    Log    Validation for PM Tables
                    ${list_db}    list of data    OutputFiles/${element}.txt    ${host_123}    ${port_for_vapp}    ${user_for_vapp}    ${pass_for_vapp}
                    #Log To Console    ${list_db}
                    #Log To Console    ${relpath}[0]
                    ${list_text}=    List Of Text    ${relpath}[0]/Resources/LoaderFiles/${element}.txt
                    #Log To Console    ${list_text}
                    Write     echo -e "select top 1 session_id from ${element}_RAW;\\ngo\\n" | isql -P Dc12# -U dc -S dwhdb -w 1 -b
                    ${output}    Read Until Prompt
                    ${session_id}    Split String    ${output}     
                    Write     echo -e "select top 1 batch_id from ${element}_RAW;\\ngo\\n" | isql -P Dc12# -U dc -S dwhdb -w 1 -b
                    ${output}    Read Until Prompt
                    ${batch_id}    Split String    ${output}
                    ${status}    ${mismatchli}    Validation    ${list_db}    ${list_text}    ${session_id}[0]    ${batch_id}[0]
                    #Log To Console     ${element} table status -> ${status} and mismatch is ${mismatchli}
                    #${passed}=    Run Keyword And Return Status   Evaluate    type(${mismatchli}).__name__
                    # IF    '${status}' == 'notvalidated' 
                    #     ${TescaseStatus}=    Set Variable    False
                    #     Write    echo -e '${list_db} --- ${list_text} --- ${mismatchli}' > /eniq/home/dcuser/logofmismatch/${element}.txt
                    #     Read Until Prompt
                    # END
                
            END
            # Write    rm -rf /eniq/home/dcuser/OutputFiles
            # Read Until Prompt
            FOR    ${element}    IN    @{table_names}
                FOR    ${number}    IN    @{numberlist}
                    Write    echo -e "delete from ${element}_raw_0${number} where oss_id = 'eniq_oss_1'\\n${run}\\n" | isql -P ${dwhdb_pwd} -U dc -S dwhdb -b
                    Read Until Prompt    
                END
            END
            FOR    ${element}    IN    @{topoTable}
                Write    echo -e "delete from ${element} where oss_id = 'eniq_oss_1'\\n${run}\\n" | isql -P ${dwhdb_pwd} -U dc -S dwhdb -b
                Read Until Prompt
            END
            Run Keyword And Continue On Failure    Check if passed    ${TescaseStatus}
        END
    END
    


    #Log To Console    ${CURDIR}
    # Write    rm /eniq/home/dcuser/test.txt
    # Read Until Prompt
    # Write     echo -e "select * from DC_E_ERBSG2_EUTRANCELLFDD_FLEX_RAW;\\ngo\\n" | isql -P Dc12# -U dc -S dwhdb -w 1 -b -o /eniq/home/dcuser/test.txt
    # ${output}    Read Until Prompt
    # ${list_db}    list of data    ${output}
    # #Log To Console    ${list_db}
    # ${temppath}=    Replace String    ${CURDIR}    \\    /
    # ${relpath}=    Split String From Right    ${temppath}    separator=/    max_split=2
    # #Log To Console    ${relpath}[0]
    # ${list_text}=    List Of Text    ${relpath}[0]/Resources/LoaderFiles/DC_E_ERBSG2_EUTRANCELLFDD_FLEX_RAW.txt
    # #Log To Console    ${list_text}
    # Write     echo -e "select top 1 session_id from DC_E_ERBSG2_EUTRANCELLFDD_FLEX_RAW;\\ngo\\n" | isql -P Dc12# -U dc -S dwhdb -w 1 -b
    # ${output}    Read Until Prompt
    # ${session_id}    Split String    ${output}     
    # Write     echo -e "select top 1 batch_id from DC_E_ERBSG2_EUTRANCELLFDD_FLEX_RAW;\\ngo\\n" | isql -P Dc12# -U dc -S dwhdb -w 1 -b
    # ${output}    Read Until Prompt
    # ${batch_id}    Split String    ${output}
    # ${mismatchli}    Validation    ${list_db}    ${list_text}    ${session_id}[0]    ${batch_id}[0]
    # Log To Console    ${mismatchli}
    # Write    rm /eniq/home/dcuser/test.txt
    # Read Until Prompt
### Validation
            
####

######
    # Write    cd /eniq/home/dcuser/LoaderFiles ; cat DC_E_NR_BEAM.txt
    # ${original_string}    Read Until Prompt
    # ${list_text}    List Of Text    ${original_string}