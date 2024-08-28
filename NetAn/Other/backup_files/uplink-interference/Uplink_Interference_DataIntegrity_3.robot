*** Settings ***
Documentation     PMA Dataintegrity testcase for Radio nodes

Library           SikuliLibrary
Library           OperatingSystem
Library           Selenium2Library
Library           Collections
Library           String
Library           SSHLibrary
Library           DateTime
Library           SwingLibrary
Resource          ./Resources/Keywords/DataIntegrity_Keywords.robot
Resource	      ./Resources/Keywords/UplinkInterferenceWebUI.robot
Library           ./Resources/Libraries/DynamicTestcases.py
Test Setup        Open Connection And Log In     ${host}     ${username}    ${password}     ${PORT}
Test Teardown     Close All Connections
Suite setup       Set Screenshot Directory    ./Screenshots



*** Variables ***
${base_url}=        https://localhost/
${uplink_url}=      spotfire/wp/analysis?file=/Ericsson%20Library/Radio-Common/RAN%20Uplink%20Interference/Ericsson-RAN-Uplink-Interference/Analyses/RAN_Uplink_Interference&waid=fXeGjGW6CEyHAqOPjYvbN-180446061e1ht_&wavid=0 
${browser_name}=    chrome
${IMAGE_DIR}        ${EXECDIR}/Other/sikuli-images
${host}             localhost
${username}         Administrator
${password}         teamci@2017
${PORT}             2640

***Test Cases***

Test Case: Verify that 4 Uplink Interference KPIs are populated in table DIM_CV_MEASURE
	Make DB Connection
	${sql_query}=      get sql query from json file    ./Resources/Data/uplink-interference/Uplink-Interference-dataIntegrity-SQLs.json    dim_cv_measure_name
	Query ENIQ database Uplink Interference for the table    DIM_CV_MEASURE    ${sql_query}
	${sql_query}=      get sql query from json file    ./Resources/Data/uplink-interference/Uplink-Interference-dataIntegrity-SQLs.json    dim_cv_measure_id
	Query ENIQ database Uplink Interference for the table    DIM_CV_MEASURE    ${sql_query}
	${sql_query}=      get sql query from json file    ./Resources/Data/uplink-interference/Uplink-Interference-dataIntegrity-SQLs.json    dim_cv_measure_metric_type
	Query ENIQ database Uplink Interference for the table    DIM_CV_MEASURE    ${sql_query}
	${sql_query}=      get sql query from json file    ./Resources/Data/uplink-interference/Uplink-Interference-dataIntegrity-SQLs.json    dim_cv_measure_unit_type
	Query ENIQ database Uplink Interference for the table    DIM_CV_MEASURE    ${sql_query}

Test Case: Verify that 4 Uplink Interference KPIs are populated in table DIM_CV_MEASURE_LIMITS
	Make DB Connection
	${sql_query}=    get sql query from json file    ./Resources/Data/uplink-interference/Uplink-Interference-dataIntegrity-SQLs.json    dim_cv_measure_limits_id
	Query ENIQ database Uplink Interference for the table    DIM_CV_MEASURE_LIMITS    ${sql_query}
	${sql_query}=    get sql query from json file    ./Resources/Data/uplink-interference/Uplink-Interference-dataIntegrity-SQLs.json    dim_cv_measure_limits_error_threshold
	Query ENIQ database Uplink Interference for the table    DIM_CV_MEASURE_LIMITS    ${sql_query}
	${sql_query}=    get sql query from json file    ./Resources/Data/uplink-interference/Uplink-Interference-dataIntegrity-SQLs.json    dim_cv_measure_limits_warning
	Query ENIQ database Uplink Interference for the table    DIM_CV_MEASURE_LIMITS    ${sql_query}

Test Case: Verify that 4 Uplink Interference KPIs are populated in table DIM_CV_MEASURE_CONTROL
	Make DB Connection
	${sql_query}=    get sql query from json file    ./Resources/Data/uplink-interference/Uplink-Interference-dataIntegrity-SQLs.json    dim_cv_control_id
	Query ENIQ database Uplink Interference for the table    DIM_CV_MEASURE_CONTROL    ${sql_query}
	${sql_query}=    get sql query from json file    ./Resources/Data/uplink-interference/Uplink-Interference-dataIntegrity-SQLs.json    dim_cv_measure_status
	Query ENIQ database Uplink Interference for the table    DIM_CV_MEASURE_CONTROL    ${sql_query}
	${sql_query}=    get sql query from json file    ./Resources/Data/uplink-interference/Uplink-Interference-dataIntegrity-SQLs.json    dim_cv_processing_operation
	Query ENIQ database Uplink Interference for the table    DIM_CV_MEASURE_CONTROL    ${sql_query}
	${sql_query}=    get sql query from json file    ./Resources/Data/uplink-interference/Uplink-Interference-dataIntegrity-SQLs.json    dim_cv_control_node
	Query ENIQ database Uplink Interference for the table    DIM_CV_MEASURE_CONTROL    ${sql_query}
	${sql_query}=    get sql query from json file    ./Resources/Data/uplink-interference/Uplink-Interference-dataIntegrity-SQLs.json    dim_cv_control_source
	Query ENIQ database Uplink Interference for the table    DIM_CV_MEASURE_CONTROL    ${sql_query}
	${sql_query}=    get sql query from json file    ./Resources/Data/uplink-interference/Uplink-Interference-dataIntegrity-SQLs.json    dim_cv_control_target
	Query ENIQ database Uplink Interference for the table    DIM_CV_MEASURE_CONTROL    ${sql_query}
	
Test Case: Verify that calculated data from source tables for Avg_Int_PUSCH_Prb KPI matches data in target table
	Make DB Connection
	${date}=    getYesterdaysDate	
	${sql_query}=    get sql query from json file    ./Resources/Data/uplink-interference/Uplink-Interference-dataIntegrity-SQLs.json    Avg_Int_PUSCH_Prb1
	${DB1}=    Query the ENIQ database Uplink Interference for source and target table of    Avg_Int_PUSCH_Prb1    ${sql_query}    ${date}
	${sql_query}=    get sql query from json file    ./Resources/Data/uplink-interference/Uplink-Interference-dataIntegrity-SQLs.json    Avg_Int_PUSCH_Prb2	
	${DB2}=    Query the ENIQ database Uplink Interference for source and target table of    Avg_Int_PUSCH_Prb2    ${sql_query}    ${date}
	Compare the two outputs    ${DB1}    ${DB2}
	
Test Case: Verify that calculated data from source tables for Avg_Int_PUCCH KPI matches data in target table
	Make DB Connection
	${date}=    getYesterdaysDate	
	${sql_query}=    get sql query from json file    ./Resources/Data/uplink-interference/Uplink-Interference-dataIntegrity-SQLs.json    Avg_Int_PUCCH1
	${DB1}=    Query the ENIQ database Uplink Interference for source and target table of    Avg_Int_PUCCH1    ${sql_query}    ${date}
	${sql_query}=    get sql query from json file    ./Resources/Data/uplink-interference/Uplink-Interference-dataIntegrity-SQLs.json    Avg_Int_PUCCH2	
	${DB2}=    Query the ENIQ database Uplink Interference for source and target table of    Avg_Int_PUCCH2    ${sql_query}    ${date}
	Compare the two outputs    ${DB1}    ${DB2}
	
Test Case: Verify that calculated data from source tables for Avg_Int_PUSCH_BrPrb KPI matches data in target table
	Make DB Connection
	${date}=    getYesterdaysDate	
	${sql_query}=    get sql query from json file    ./Resources/Data/uplink-interference/Uplink-Interference-dataIntegrity-SQLs.json    Avg_Int_PUSCH_BrPrb1
	${DB1}=    Query the ENIQ database Uplink Interference for source and target table of    Avg_Int_PUSCH_BrPrb1    ${sql_query}   ${date}
	${sql_query}=    get sql query from json file    ./Resources/Data/uplink-interference/Uplink-Interference-dataIntegrity-SQLs.json    Avg_Int_PUSCH_BrPrb2	
	${DB2}=    Query the ENIQ database Uplink Interference for source and target table of    Avg_Int_PUSCH_BrPrb2    ${sql_query}   ${date}
	Compare the two outputs    ${DB1}    ${DB2}
	
Test Case: Verify that calculated data from source tables for Avg_Int_PUCCH KPI matches data in target table
	Make DB Connection
	${date}=    getYesterdaysDate	
	${sql_query}=    get sql query from json file    ./Resources/Data/uplink-interference/Uplink-Interference-dataIntegrity-SQLs.json    Avg_Int_PUCCH2	
	${DB2}=    Query the ENIQ database Uplink Interference for source and target table of    Avg_Int_PUCCH2    ${sql_query}    ${date}
	${sql_query}=    get sql query from json file    ./Resources/Data/uplink-interference/Uplink-Interference-dataIntegrity-SQLs.json    Avg_Int_PUCCH1
	${DB1}=    Query the ENIQ database Uplink Interference for source and target table of    Avg_Int_PUCCH1    ${sql_query}    ${date}
	Compare the two outputs    ${DB1}    ${DB2}