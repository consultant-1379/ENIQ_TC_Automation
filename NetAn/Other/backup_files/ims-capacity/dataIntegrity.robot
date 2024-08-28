*** Settings ***
Documentation     PMA Dataintegrity testcase for Radio nodes

Library           SikuliLibrary
Library           OperatingSystem
Library           Selenium2Library
Library           Collections
Library           String
Library           SSHLibrary
Library           DateTime
Resource          ./Resources/Keywords/DataIntegrity_Keywords.robot
Resource	      ./Resources/Keywords/IMSCapacityWebUI.robot
Library           ./Resources/Libraries/DynamicTestcases.py
Test Setup        Open Connection And Log In     ${host}     ${username}    ${password}     ${PORT}
Test Teardown     Close All Connections
Suite setup       Set Screenshot Directory    ./Screenshots



*** Variables ***
${base_url}=        https://localhost/
${ims_url}=         spotfire/wp/analysis?file=/Ericsson%20Library/IMS/IMS-Analysis/Ericsson-IMS-Capacity-Analysis/Analyses/Ericsson-IMS-Capacity-Analysis&waid=drEgyEuDqk6BqwEI3oTnR-181911061eT_3E&wavid=0
${browser_name}=    chrome
${IMAGE_DIR}        ${EXECDIR}/Other/sikuli-images
${host}             localhost
${username}         Administrator
${password}         teamci@2017
${PORT}             2640


*** Test Cases ***
Test Case ID IMS 022
    open ims capacity analysis
    click on Reset button
	click on IMS Node Overview button
	validate page title as    IMS Node Overview
	click on link    CSCF: Traffic >>
	validate page title as    CSCF: Traffic
	Make Selection in Time Range
	Click on scroll down button on IMS Node Overview Page    10    2   
    In KPIs section select    Registered Users
    select nodes from 'Node KPI Performance' section
    make selection in the 'KPI Details' graph
    click on 'Filtered Data' button on the current page
    validate page title as    CSCF Filtered Data
    ${measureValue}    ${nodeName}    ${dateTime}=    record NodeName & DateTime of first raw from the UI for CSCF
    ${sql_query}=      get sql query from json file    ./Resources/Data/ims-capacity/dataIntegrity.json     cscf_Registered_Users
    ${DB_Value}=    query the eniq database for cscf    ${sql_query}    ${nodeName}    ${dateTime}
    Compare UI with DB value    ${measureValue}     ${DB_Value}
    Capture page screenshot
    [Teardown]    Close Browser
    
Test Case ID IMS 023
	open ims capacity analysis
    click on Reset button
	click on IMS Node Overview button
	validate page title as    IMS Node Overview
	click on link     MTAS: Traffic >>
	validate page title as    MTAS: Traffic
	Make Selection in Time Range
	Click on scroll down button on IMS Node Overview Page    12    2   
    In KPIs section select    Initial Registrations (per sec)
    select nodes from 'Node KPI Performance' section
    make selection in the 'KPI Details' graph
    click on 'Filtered Data' button on the current page
    validate page title as    MTAS Filtered Data
    ${measureValue}    ${nodeName}    ${dateTime}=    record NodeName & DateTime of first raw from the UI for MTAS
    ${sql_query}=      get sql query from json file    ./Resources/Data/ims-capacity/dataIntegrity.json     mtas_Initial_Registrations
    Log    ${sql_query}
    ${DB_Value}=    query the eniq database for    ${sql_query}    ${nodeName}    ${dateTime}
    Compare UI with DB value    ${measureValue}     ${DB_Value}
    Capture page screenshot
    [Teardown]    Close Browser
	
Test Case ID IMS 024
	open ims capacity analysis
    click on Reset button
	click on IMS Node Overview button
	validate page title as    IMS Node Overview
	click on link     MTAS: Traffic >>
	validate page title as    MTAS: Traffic
	Click on scroll down button on IMS Node Overview Page    12    2   
    In KPIs section select    Initial Registration Success (%)
    select nodes from 'Node KPI Performance' section
    make selection in the 'KPI Details' graph
    click on 'Filtered Data' button on the current page
    validate page title as    MTAS Filtered Data
    ${measureValue}    ${nodeName}    ${dateTime}=    record NodeName & DateTime of first raw from the UI for MTAS
    ${sql_query}=      get sql query from json file    ./Resources/Data/ims-capacity/dataIntegrity.json     mtas_Registration_Completion
    Log    ${sql_query}
    ${DB_Value}=    query the eniq database for    ${sql_query}    ${nodeName}    ${dateTime}
    Compare UI with DB value    ${measureValue}     ${DB_Value}
    Capture page screenshot
    [Teardown]    Close Browser
	
Test Case ID IMS 025
	open ims capacity analysis
    click on Reset button
	click on IMS Node Overview button
	validate page title as    IMS Node Overview
	click on link     MTAS: Platform and Capacity >>
	validate page title as    MTAS:Platform and Capacity
	Click on scroll down button on IMS Node Overview Page    12    2 
    In KPIs section select    Active Users
    select nodes from 'Node KPI Performance' section
    make selection in the 'KPI Details' graph
    click on 'Filtered Data' button on the current page
    validate page title as    MTAS Filtered Data
    ${measureValue}    ${nodeName}    ${dateTime}=    record NodeName & DateTime of first raw from the UI for SBG
    ${sql_query}=      get sql query from json file    ./Resources/Data/ims-capacity/dataIntegrity.json     mtas_Active_Users
    Log    ${sql_query}
    ${DB_Value}=    query the eniq database for    ${sql_query}    ${nodeName}    ${dateTime}
    Compare UI with DB value    ${measureValue}     ${DB_Value}
    Capture page screenshot
    [Teardown]    Close Browser
 
Test Case ID IMS 026
	open ims capacity analysis
    click on Reset button
	click on IMS Node Overview button
	validate page title as    IMS Node Overview
	click on link     SBG: Traffic >>
	validate page title as    SBG: Traffic
	Click on scroll down button on IMS Node Overview Page    12    2 
    In KPIs section select    Reregistration Success (%)
    select nodes from 'Node KPI Performance' section
    make selection in the 'KPI Details' graph
    click on 'Filtered Data' button on the current page
    validate page title as    SBG Filtered Data
    ${measureValue}    ${nodeName}    ${dateTime}=    record NodeName & DateTime of first raw from the UI for SBG
    ${sql_query}=      get sql query from json file    ./Resources/Data/ims-capacity/dataIntegrity.json     sbg_Reregistration_Success
    Log    ${sql_query}
    ${DB_Value}=    query the eniq database for    ${sql_query}    ${nodeName}    ${dateTime}
    Compare UI with DB value    ${measureValue}     ${DB_Value}
    Capture page screenshot
    [Teardown]    Close Browser
    
Test Case ID IMS 027
	open ims capacity analysis
    click on Reset button
	click on IMS Node Overview button
	validate page title as    IMS Node Overview
	click on link     SBG: Traffic >>
	validate page title as    SBG: Traffic
	Click on scroll down button on IMS Node Overview Page    12    2
    In KPIs section select    Initial Registration Success (%)
    select nodes from 'Node KPI Performance' section
    make selection in the 'KPI Details' graph
    click on 'Filtered Data' button on the current page
    validate page title as    SBG Filtered Data
    ${measureValue}    ${nodeName}    ${dateTime}=    record NodeName & DateTime of first raw from the UI for SBG
    ${sql_query}=      get sql query from json file    ./Resources/Data/ims-capacity/dataIntegrity.json     sbg_Initial_Registration_Success
    Log    ${sql_query}
    ${DB_Value}=    query the eniq database for    ${sql_query}    ${nodeName}    ${dateTime}
    Compare UI with DB value    ${measureValue}     ${DB_Value}
    Capture page screenshot
    [Teardown]    Close Browser
    
Test Case ID IMS 028
	open ims capacity analysis
    click on Reset button
	click on IMS Node Overview button
	validate page title as    IMS Node Overview
	click on link     SBG: Traffic >>
	Click on scroll down button on IMS Node Overview Page    12    2
	validate page title as    SBG: Traffic
    In KPIs section select    Deregistration Success (%)
    select nodes from 'Node KPI Performance' section
    make selection in the 'KPI Details' graph
    click on 'Filtered Data' button on the current page
    validate page title as    SBG Filtered Data
    ${measureValue}    ${nodeName}    ${dateTime}=    record NodeName & DateTime of first raw from the UI for SBG
    ${sql_query}=      get sql query from json file    ./Resources/Data/ims-capacity/dataIntegrity.json     sbg_Deregistration_Success
    Log    ${sql_query}
    ${DB_Value}=    query the eniq database for    ${sql_query}    ${nodeName}    ${dateTime}
    Compare UI with DB value    ${measureValue}     ${DB_Value}
    Capture page screenshot
    [Teardown]    Close Browser
    
Test Case ID IMS 029
	open ims capacity analysis
    click on Reset button
	click on IMS Node Overview button
	validate page title as    IMS Node Overview
	click on link     SBG: Traffic >>
	Click on scroll down button on IMS Node Overview Page    12    2
	validate page title as    SBG: Traffic
    In KPIs section select    Total Registered Users
    select nodes from 'Node KPI Performance' section
    make selection in the 'KPI Details' graph
    click on 'Filtered Data' button on the current page
    validate page title as    SBG Filtered Data
    ${measureValue}    ${nodeName}    ${dateTime}=    record NodeName & DateTime of first raw from the UI for SBG
    ${sql_query}=      get sql query from json file    ./Resources/Data/ims-capacity/dataIntegrity.json     sbg_Total_Registered_Users
    Log    ${sql_query}
    ${DB_Value}=    query the eniq database for    ${sql_query}    ${nodeName}    ${dateTime}
    Compare UI with DB value    ${measureValue}     ${DB_Value}
    Capture page screenshot
    [Teardown]    Close Browser
	
Test Case ID IMS 031
	open ims capacity analysis
    click on Reset button
	click on IMS Node Overview button
	validate page title as    IMS Node Overview
	click on link     CSCF: Platform and Capacity >>  
	validate page title as    CSCF: Platform and Capacity
	Make Selection in Time Range
	Click on scroll down button on IMS Node Overview Page    12    3
    In KPIs section select    Memory Usage (%)
    select nodes from 'Node KPI Performance' section
    make selection in the 'KPI Details' graph
    click on 'Filtered Data' button on the current page
    validate page title as    CSCF Filtered Data
    ${measureValue}    ${nodeName}    ${dateTime}=    record NodeName & DateTime of first raw from the UI for CSCF
    ${sql_query}=      get sql query from json file    ./Resources/Data/ims-capacity/dataIntegrity.json     cscf_Memory_Usage
    Log    ${sql_query}
    ${DB_Value}=    query the eniq database for    ${sql_query}    ${nodeName}    ${dateTime}
    Compare UI with DB value    ${measureValue}     ${DB_Value}
    Capture page screenshot
    [Teardown]    Close Browser

Test Case ID IMS 032
	open ims capacity analysis
    click on Reset button
	click on IMS Node Overview button
	validate page title as    IMS Node Overview
	click on link     MTAS: Platform and Capacity >>
	validate page title as    MTAS:Platform and Capacity
	Click on scroll down button on IMS Node Overview Page    12    2
    In KPIs section select    Memory Usage (%)
    select nodes from 'Node KPI Performance' section
    make selection in the 'KPI Details' graph
    click on 'Filtered Data' button on the current page
    validate page title as    MTAS Filtered Data
    ${measureValue}    ${nodeName}    ${dateTime}=    record NodeName & DateTime of first raw from the UI for MTAS
    ${sql_query}=      get sql query from json file    ./Resources/Data/ims-capacity/dataIntegrity.json     mtas_Memory_Usage
    Log    ${sql_query}
    ${DB_Value}=    query the eniq database for    ${sql_query}    ${nodeName}    ${dateTime}
    Compare UI with DB value    ${measureValue}     ${DB_Value}
    Capture page screenshot
    [Teardown]    Close Browser

Test Case ID IMS 033
	open ims capacity analysis
    click on Reset button
	click on IMS Node Overview button
	validate page title as     IMS Node Overview
	click on link     MTAS: Platform and Capacity >>
	validate page title as     MTAS:Platform and Capacity
	Click on scroll down button on IMS Node Overview Page    12    2
    In KPIs section select    CPU Load (%)
    select nodes from 'Node KPI Performance' section
    make selection in the 'KPI Details' graph
    click on 'Filtered Data' button on the current page
    validate page title as     MTAS Filtered Data
    ${measureValue}    ${nodeName}    ${dateTime}=    record NodeName & DateTime of first raw from the UI for MTAS
    ${sql_query}=      get sql query from json file    ./Resources/Data/ims-capacity/dataIntegrity.json     mtas_CPU_Load
    Log    ${sql_query}
    ${DB_Value}=    query the eniq database for    ${sql_query}    ${nodeName}    ${dateTime}
    Compare UI with DB value    ${measureValue}     ${DB_Value}
    Capture page screenshot
    [Teardown]    Close Browser
	
Test Case ID IMS 034
	open ims capacity analysis
    click on Reset button
	click on IMS Node Overview button
	validate page title as     IMS Node Overview
	click on link     MTAS: Platform and Capacity >>
	validate page title as     MTAS:Platform and Capacity
	Click on scroll down button on IMS Node Overview Page    12    2
    In KPIs section select    Simultaneous Sessions
    select nodes from 'Node KPI Performance' section
    make selection in the 'KPI Details' graph
    click on 'Filtered Data' button on the current page
    validate page title as     MTAS Filtered Data
    ${measureValue}    ${nodeName}    ${dateTime}=    record NodeName & DateTime of first raw from the UI for MTAS
    ${sql_query}=      get sql query from json file    ./Resources/Data/ims-capacity/dataIntegrity.json     mtas_Simultaneous_Sessions
    Log    ${sql_query}
    ${DB_Value}=    query the eniq database for    ${sql_query}    ${nodeName}    ${dateTime}
    Compare UI with DB value    ${measureValue}     ${DB_Value}
    Capture page screenshot
    [Teardown]    Close Browser
	
Test Case ID IMS 035
	open ims capacity analysis
    click on Reset button
	click on IMS Node Overview button
	validate page title as     IMS Node Overview
	click on link     MTAS: Platform and Capacity >>
	validate page title as     MTAS:Platform and Capacity
	Click on scroll down button on IMS Node Overview Page    12    2
	Click on horizontal scroll button    10    2
	Click on scroll down button on IMS Node Overview Page    12    1
    In KPIs section select    Mobile Service Sessions
    select nodes from 'Node KPI Performance' section
    make selection in the 'KPI Details' graph
    click on 'Filtered Data' button on the current page
    validate page title as     MTAS Filtered Data
    ${measureValue}    ${nodeName}    ${dateTime}=    record NodeName & DateTime of first raw from the UI for MTAS
    ${sql_query}=      get sql query from json file    ./Resources/Data/ims-capacity/dataIntegrity.json     mtas_Mobile_Service_Sessions
    Log    ${sql_query}
    ${DB_Value}=    query the eniq database for    ${sql_query}    ${nodeName}    ${dateTime}
    Compare UI with DB value    ${measureValue}     ${DB_Value}
    Capture page screenshot
    [Teardown]    Close Browser
	
Test Case ID IMS 036
	open ims capacity analysis
    click on Reset button
	click on IMS Node Overview button
	validate page title as     IMS Node Overview
	click on link     HSS: Traffic >>
	validate page title as     HSS: Traffic
	Click on scroll down button on IMS Node Overview Page    12    2
    In KPIs section select    Location Query Requests (per sec)
    select nodes from 'Node KPI Performance' section
    make selection in the 'KPI Details' graph
    click on 'Filtered Data' button on the current page
    validate page title as     HSS Filtered Data
    ${nodeName}    ${dateTime}=    record NodeName & DateTime of first raw from the UI for HSS
    ${sql_query}=      get sql query from json file    ./Resources/Data/ims-capacity/dataIntegrity.json     hss_Location_Query_Requests
    Log    ${sql_query}
    ${DB_Value}=    query the eniq database for    ${sql_query}    ${nodeName}    ${dateTime}
    Compare UI with DB value    ${measureValue}     ${DB_Value}
    Capture page screenshot
    [Teardown]    Close Browser

Test Case ID IMS 037
	open ims capacity analysis
    click on Reset button
	click on IMS Node Overview button
	validate page title as     IMS Node Overview
	click on link     HSS: Traffic >>
	validate page title as     HSS: Traffic
	Click on scroll down button on IMS Node Overview Page    12    2
    In KPIs section select    User Authorization Query Requests (per sec)
    select nodes from 'Node KPI Performance' section
    make selection in the 'KPI Details' graph
    click on 'Filtered Data' button on the current page
    validate page title as     HSS Filtered Data
    ${measureValue}    ${nodeName}    ${dateTime}=    record NodeName & DateTime of first raw from the UI for HSS
    ${sql_query}=      get sql query from json file    ./Resources/Data/ims-capacity/dataIntegrity.json     hss_User_Authorization_Query_Requests
    Log    ${sql_query}
    ${DB_Value}=    query the eniq database for    ${sql_query}    ${nodeName}    ${dateTime}
    Compare UI with DB value    ${measureValue}     ${DB_Value}
    Capture page screenshot
    [Teardown]    Close Browser
	
Test Case ID IMS 038
	open ims capacity analysis
    click on Reset button
	click on IMS Node Overview button
	validate page title as     IMS Node Overview
	click on link     HSS: Traffic >>
	validate page title as     HSS: Traffic
	Click on scroll down button on IMS Node Overview Page    12    2
    In KPIs section select    CSCF Registration Success (%)
    select nodes from 'Node KPI Performance' section
    make selection in the 'KPI Details' graph
    click on 'Filtered Data' button on the current page
    validate page title as     HSS Filtered Data
    ${measureValue}    ${nodeName}    ${dateTime}=    record NodeName & DateTime of first raw from the UI for HSS
    ${sql_query}=      get sql query from json file    ./Resources/Data/ims-capacity/dataIntegrity.json     hss_CSCF_Registration_Success
    Log    ${sql_query}
    ${DB_Value}=    query the eniq database for    ${sql_query}    ${nodeName}    ${dateTime}
    Compare UI with DB value    ${measureValue}     ${DB_Value}
    Capture page screenshot
    [Teardown]    Close Browser
	
Test Case ID IMS 039
	open ims capacity analysis
    click on Reset button
	click on IMS Node Overview button
	validate page title as     IMS Node Overview
	click on link     HSS: Traffic >>
	validate page title as     HSS: Traffic
	Click on scroll down button on IMS Node Overview Page    12    2
    In KPIs section select    User Location Success (%)
    select nodes from 'Node KPI Performance' section
    make selection in the 'KPI Details' graph
    click on 'Filtered Data' button on the current page
    validate page title as     HSS Filtered Data
    ${measureValue}    ${nodeName}    ${dateTime}=    record NodeName & DateTime of first raw from the UI for HSS
    ${sql_query}=      get sql query from json file    ./Resources/Data/ims-capacity/dataIntegrity.json     hss_User_Location_Success
    Log    ${sql_query}
    ${DB_Value}=    query the eniq database for    ${sql_query}    ${nodeName}    ${dateTime}
    Compare UI with DB value    ${measureValue}     ${DB_Value}
    Capture page screenshot
    [Teardown]    Close Browser
	
Test Case ID IMS 040
	open ims capacity analysis
    click on Reset button
	click on IMS Node Overview button
	validate page title as     IMS Node Overview
	click on link     HSS: Traffic >>
	validate page title as     HSS: Traffic
	Click on scroll down button on IMS Node Overview Page    12    2
    In KPIs section select    Authentication Success (%)
    select nodes from 'Node KPI Performance' section
    make selection in the 'KPI Details' graph
    click on 'Filtered Data' button on the current page
    validate page title as     HSS Filtered Data
    ${measureValue}    ${nodeName}    ${dateTime}=    record NodeName & DateTime of first raw from the UI for HSS
    ${sql_query}=      get sql query from json file    ./Resources/Data/ims-capacity/dataIntegrity.json     hss_Authentication_Success
    Log    ${sql_query}
    ${DB_Value}=    query the eniq database for    ${sql_query}    ${nodeName}    ${dateTime}
    Compare UI with DB value    ${measureValue}     ${DB_Value}
    Capture page screenshot
    [Teardown]    Close Browser
	
Test Case ID IMS 041
	open ims capacity analysis
    click on Reset button
	click on IMS Node Overview button
	validate page title as     IMS Node Overview
	click on link     HSS: Platform and Capacity >>
	validate page title as     HSS: Platform and Capacity
	Click on scroll down button on IMS Node Overview Page    12    2
    In KPIs section select    CPU Load (%)
    select nodes from 'Node KPI Performance' section
    make selection in the 'KPI Details' graph
    click on 'Filtered Data' button on the current page
    validate page title as     HSS Filtered Data
    ${measureValue}    ${nodeName}    ${dateTime}=    record NodeName & DateTime of first raw from the UI for HSS
    ${sql_query}=      get sql query from json file    ./Resources/Data/ims-capacity/dataIntegrity.json     hss_Platform_CPU_Load
    Log    ${sql_query}
    ${DB_Value}=    query the eniq database for    ${sql_query}    ${nodeName}    ${dateTime}
    Compare UI with DB value    ${measureValue}     ${DB_Value}
    Capture page screenshot
    [Teardown]    Close Browser
	
Test Case ID IMS 042
	open ims capacity analysis
    click on Reset button
	click on IMS Node Overview button
	validate page title as     IMS Node Overview
	click on link     HSS: Platform and Capacity >>
	validate page title as     HSS: Platform and Capacity
	Click on scroll down button on IMS Node Overview Page    12    2
    In KPIs section select    Memory Usage (%)
    select nodes from 'Node KPI Performance' section
    make selection in the 'KPI Details' graph
    click on 'Filtered Data' button on the current page
    validate page title as     HSS Filtered Data
    ${measureValue}    ${nodeName}    ${dateTime}=    record NodeName & DateTime of first raw from the UI for HSS
    ${sql_query}=      get sql query from json file    ./Resources/Data/ims-capacity/dataIntegrity.json     hss_Platform_Memory_Usage
    Log    ${sql_query}
    ${DB_Value}=    query the eniq database for    ${sql_query}    ${nodeName}    ${dateTime}
    Compare UI with DB value    ${measureValue}     ${DB_Value}
    Capture page screenshot
    [Teardown]    Close Browser
	
Test Case ID IMS 043
	open ims capacity analysis
    click on Reset button
	click on IMS Node Overview button
	validate page title as     IMS Node Overview
	click on link     HSS: Platform and Capacity >>
	validate page title as     HSS: Platform and Capacity
	Click on scroll down button on IMS Node Overview Page    12    2
    In KPIs section select    No. of Users
    select nodes from 'Node KPI Performance' section
    make selection in the 'KPI Details' graph
    click on 'Filtered Data' button on the current page
    validate page title as     HSS Filtered Data
    ${measureValue}    ${nodeName}    ${dateTime}=    record NodeName & DateTime of first raw from the UI for HSS
    ${sql_query}=      get sql query from json file    ./Resources/Data/ims-capacity/dataIntegrity.json     hss_No_of_Users
    Log    ${sql_query}
    ${DB_Value}=    query the eniq database for    ${sql_query}    ${nodeName}    ${dateTime}
    Compare UI with DB value    ${measureValue}     ${DB_Value}
    Capture page screenshot
    [Teardown]    Close Browser
    
Test Case ID IMS 044
	open ims capacity analysis
    click on Reset button
	click on IMS Node Overview button
	validate page title as     IMS Node Overview
	click on link    CSCF: Traffic >>
	validate page title as     CSCF: Traffic
	Click on scroll down button on IMS Node Overview Page    12    2
    In KPIs section select    Initial Registrations (per sec)
    select nodes from 'Node KPI Performance' section
    make selection in the 'KPI Details' graph
    click on 'Filtered Data' button on the current page
    validate page title as     CSCF Filtered Data
    ${measureValue}    ${nodeName}    ${dateTime}=    record NodeName & DateTime of first raw from the UI for CSCF
    ${sql_query}=      get sql query from json file    ./Resources/Data/ims-capacity/dataIntegrity.json     cscf_Initial_Registrations
    Log    ${sql_query}
    ${DB_Value}=    query the eniq database for cscf    ${sql_query}    ${nodeName}    ${dateTime}
    Compare UI with DB value    ${measureValue}     ${DB_Value}
    Capture page screenshot
    [Teardown]    Close Browser
	
Test Case ID IMS 045
	open ims capacity analysis
    click on Reset button
	click on IMS Node Overview button
	validate page title as     IMS Node Overview
	click on link    CSCF: Traffic >>
	validate page title as     CSCF: Traffic
	Click on scroll down button on IMS Node Overview Page    12    2
    In KPIs section select    Reregistration Success (%)
    select nodes from 'Node KPI Performance' section
    make selection in the 'KPI Details' graph
    click on 'Filtered Data' button on the current page
    validate page title as     CSCF Filtered Data
    ${measureValue}    ${nodeName}    ${dateTime}=    record NodeName & DateTime of first raw from the UI for CSCF
    ${sql_query}=      get sql query from json file    ./Resources/Data/ims-capacity/dataIntegrity.json     cscf_Reregistration_Success
    Log    ${sql_query}
    ${DB_Value}=    query the eniq database for cscf   ${sql_query}    ${nodeName}    ${dateTime}
    Compare UI with DB value    ${measureValue}     ${DB_Value}
    Capture page screenshot
    [Teardown]    Close Browser
	
Test Case ID IMS 046
	open ims capacity analysis
    click on Reset button
	click on IMS Node Overview button
	validate page title as     IMS Node Overview
	click on link    CSCF: Traffic >>
	validate page title as     CSCF: Traffic
	Make Selection in Time Range
	Click on scroll down button on IMS Node Overview Page    12    2
    In KPIs section select    Reregistration & Deregistration Success (%)
    select nodes from 'Node KPI Performance' section
    make selection in the 'KPI Details' graph
    click on 'Filtered Data' button on the current page
    validate page title as     CSCF Filtered Data
    ${measureValue}    ${nodeName}    ${dateTime}=    record NodeName & DateTime of first raw from the UI for CSCF
    ${sql_query}=      get sql query from json file    ./Resources/Data/ims-capacity/dataIntegrity.json     cscf_Reregistration_Deregistration_Success
    Log    ${sql_query}
    ${DB_Value}=    query the eniq database for cscf    ${sql_query}    ${nodeName}    ${dateTime}
    Compare UI with DB value    ${measureValue}     ${DB_Value}
    Capture page screenshot
    [Teardown]    Close Browser
	
Test Case ID IMS 047
	open ims capacity analysis
    click on Reset button
	click on IMS Node Overview button
	validate page title as     IMS Node Overview
	click on link    MRS: Platform >> 
	validate page title as     MRS: Platform
	Click on scroll down button on IMS Node Overview Page    12    0
    In KPIs section select    CPU Load (%)
    select nodes from 'Node KPI Performance' section
    make selection in the 'KPI Details' graph
    click on 'Filtered Data' button on the current page
    validate page title as     MRS Filtered Data
    ${measureValue}    ${nodeName}    ${dateTime}=    record NodeName & DateTime of first raw from the UI for MRS
    ${sql_query}=      get sql query from json file    ./Resources/Data/ims-capacity/dataIntegrity.json     mrs_Platform_CPU_Load
    Log    ${sql_query}
    ${DB_Value}=    query the eniq database for    ${sql_query}    ${nodeName}    ${dateTime}
    Compare UI with DB value    ${measureValue}     ${DB_Value}
    Capture page screenshot
    [Teardown]    Close Browser
	
Test Case ID IMS 048
	open ims capacity analysis
    click on Reset button
	click on IMS Node Overview button
	validate page title as     IMS Node Overview
	click on link    MRS: Platform >>
	validate page title as     MRS: Platform
	Click on scroll down button on IMS Node Overview Page    12    0
    In KPIs section select    Processor Core CPU (%)
    select nodes from 'Node KPI Performance' section
    make selection in the 'KPI Details' graph
    click on 'Filtered Data' button on the current page
    validate page title as     MRS Filtered Data
    ${measureValue}    ${nodeName}    ${dateTime}=    record NodeName & DateTime of first raw from the UI for MRS
    ${sql_query}=      get sql query from json file    ./Resources/Data/ims-capacity/dataIntegrity.json     mrs_Processor_Core_CPU
    Log    ${sql_query}
    ${DB_Value}=    query the eniq database for    ${sql_query}    ${nodeName}    ${dateTime}
    Compare UI with DB value    ${measureValue}     ${DB_Value}
    Capture page screenshot
    [Teardown]    Close Browser
	
Test Case ID IMS 049
	open ims capacity analysis
    click on Reset button
	click on IMS Node Overview button
	validate page title as     IMS Node Overview
	click on link    MRS: Traffic >>
	validate page title as     MRS: Traffic
	Click on scroll down button on IMS Node Overview Page    12    2
    In KPIs section select    Call Setup Rate (per sec)
    select nodes from 'Node KPI Performance' section
    make selection in the 'KPI Details' graph
    click on 'Filtered Data' button on the current page
    validate page title as     MRS Filtered Data
    ${measureValue}    ${nodeName}    ${dateTime}=    record NodeName & DateTime of first raw from the UI for MRS
    ${sql_query}=      get sql query from json file    ./Resources/Data/ims-capacity/dataIntegrity.json     mrs_Call_Setup_Rate
    Log    ${sql_query}
    ${DB_Value}=    query the eniq database for    ${sql_query}    ${nodeName}    ${dateTime}
    Compare UI with DB value    ${measureValue}     ${DB_Value}
    Capture page screenshot
    [Teardown]    Close Browser
	
Test Case ID IMS 050
	open ims capacity analysis
    click on Reset button
	click on IMS Node Overview button
	validate page title as     IMS Node Overview
	click on link    MRS: Traffic >>
	validate page title as     MRS: Traffic
	Click on scroll down button on IMS Node Overview Page    12    2
    In KPIs section select    Traffic Load (per sec)
    select nodes from 'Node KPI Performance' section
    make selection in the 'KPI Details' graph
    click on 'Filtered Data' button on the current page
    validate page title as     MRS Filtered Data
    ${measureValue}    ${nodeName}    ${dateTime}=    record NodeName & DateTime of first raw from the UI for MRS
    ${sql_query}=      get sql query from json file    ./Resources/Data/ims-capacity/dataIntegrity.json     mrs_Traffic_Load
    Log    ${sql_query}
    ${DB_Value}=    query the eniq database for    ${sql_query}    ${nodeName}    ${dateTime}
    Compare UI with DB value    ${measureValue}     ${DB_Value}
    Capture page screenshot
    [Teardown]    Close Browser
	
Test Case ID IMS 051
	open ims capacity analysis
    click on Reset button
	click on IMS Node Overview button
	validate page title as     IMS Node Overview
	click on link    SBG: Platform >> 
	validate page title as     SBG: Platform
	Click on scroll down button on IMS Node Overview Page    12    2
    In KPIs section select    CPU Load (%)
    select nodes from 'Node KPI Performance' section
    make selection in the 'KPI Details' graph
    click on 'Filtered Data' button on the current page
    validate page title as     SBG Filtered Data
    ${measureValue}    ${nodeName}    ${dateTime}=    record NodeName & DateTime of first raw from the UI for SBG
    ${sql_query}=      get sql query from json file    ./Resources/Data/ims-capacity/dataIntegrity.json     sbg_CPU_Load
    Log    ${sql_query}
    ${DB_Value}=    query the eniq database for    ${sql_query}    ${nodeName}    ${dateTime}
    Compare UI with DB value    ${measureValue}     ${DB_Value}
    Capture page screenshot
    [Teardown]    Close Browser
	
Test Case ID IMS 052
	open ims capacity analysis
    click on Reset button
	click on IMS Node Overview button
	validate page title as     IMS Node Overview
	click on link    SBG: Platform >> 
	validate page title as     SBG: Platform
	Click on scroll down button on IMS Node Overview Page    12    2
    In KPIs section select    Memory Usage (%)
    select nodes from 'Node KPI Performance' section
    make selection in the 'KPI Details' graph
    click on 'Filtered Data' button on the current page
    validate page title as     SBG Filtered Data
    ${measureValue}    ${nodeName}    ${dateTime}=    record NodeName & DateTime of first raw from the UI for SBG
    ${sql_query}=      get sql query from json file    ./Resources/Data/ims-capacity/dataIntegrity.json     sbg_Memory_Usage
    Log    ${sql_query}
    ${DB_Value}=    query the eniq database for    ${sql_query}    ${nodeName}    ${dateTime}
    Compare UI with DB value    ${measureValue}     ${DB_Value}
    Capture page screenshot
    [Teardown]    Close Browser

Test Case ID IMS 053
	open ims capacity analysis
    click on Reset button
	click on IMS Node Overview button
	validate page title as     IMS Node Overview
	click on link    HSS-FE: Traffic >> 
	validate page title as     HSS-FE: Traffic
	Make Selection in Time Range
	Click on scroll down button on IMS Node Overview Page    12    2
    In KPIs section select    Location Query Requests (per sec)
    select nodes from 'Node KPI Performance' section
    make selection in the 'KPI Details' graph
    click on 'Filtered Data' button on the current page
    validate page title as     HSS-FE Filtered Data
    ${measureValue}    ${nodeName}    ${dateTime}=    record NodeName & DateTime of first raw from the UI for HSS-FE
    ${sql_query}=      get sql query from json file    ./Resources/Data/ims-capacity/dataIntegrity.json     hssfe_Location_Query_Requests
    Log    ${sql_query}
    ${DB_Value}=    query the eniq database for    ${sql_query}    ${nodeName}    ${dateTime}
    Compare UI with DB value    ${measureValue}     ${DB_Value}
    Capture page screenshot
    [Teardown]    Close Browser
	
Test Case ID IMS 054
	open ims capacity analysis
    click on Reset button
	click on IMS Node Overview button
	validate page title as     IMS Node Overview
	click on link    HSS-FE: Traffic >> 
	validate page title as     HSS-FE: Traffic
	Click on scroll down button on IMS Node Overview Page    12    2
    In KPIs section select    Authentication Success (%)
    select nodes from 'Node KPI Performance' section
    make selection in the 'KPI Details' graph
    click on 'Filtered Data' button on the current page
    validate page title as     HSS-FE Filtered Data
    ${measureValue}    ${nodeName}    ${dateTime}=    record NodeName & DateTime of first raw from the UI for HSS-FE
    ${sql_query}=      get sql query from json file    ./Resources/Data/ims-capacity/dataIntegrity.json     hssfe_Authentication_Success
    Log    ${sql_query}
    ${DB_Value}=    query the eniq database for    ${sql_query}    ${nodeName}    ${dateTime}
    Compare UI with DB value    ${measureValue}     ${DB_Value}
    Capture page screenshot
    [Teardown]    Close Browser
	
Test Case ID IMS 055
	open ims capacity analysis
    click on Reset button
	click on IMS Node Overview button
	validate page title as     IMS Node Overview
	click on link    HSS-FE: Traffic >>
	validate page title as     HSS-FE: Traffic
	Click on scroll down button on IMS Node Overview Page    12    2
    In KPIs section select    User Authorization Query Requests (per sec)
    select nodes from 'Node KPI Performance' section
    make selection in the 'KPI Details' graph
    click on 'Filtered Data' button on the current page
    validate page title as     HSS-FE Filtered Data
    ${measureValue}    ${nodeName}    ${dateTime}=    record NodeName & DateTime of first raw from the UI for HSS-FE
    ${sql_query}=      get sql query from json file    ./Resources/Data/ims-capacity/dataIntegrity.json     hssfe_User_Authorization_Query_Requests
    Log    ${sql_query}
    ${DB_Value}=    query the eniq database for    ${sql_query}    ${nodeName}    ${dateTime}
    Compare UI with DB value    ${measureValue}     ${DB_Value}
    Capture page screenshot
    [Teardown]    Close Browser
	
Test Case ID IMS 056
	open ims capacity analysis
    click on Reset button
	click on IMS Node Overview button
	validate page title as     IMS Node Overview
	click on link    HSS-FE: Traffic >>
	validate page title as     HSS-FE: Traffic
	Click on scroll down button on IMS Node Overview Page    12    2
    In KPIs section select    CSCF Registration Success (%)
    select nodes from 'Node KPI Performance' section
    make selection in the 'KPI Details' graph
    click on 'Filtered Data' button on the current page
    validate page title as     HSS-FE Filtered Data
    ${measureValue}    ${nodeName}    ${dateTime}=    record NodeName & DateTime of first raw from the UI for HSS-FE
    ${sql_query}=      get sql query from json file    ./Resources/Data/ims-capacity/dataIntegrity.json     hssfe_cscf_Registration_Success
    Log    ${sql_query}
    ${DB_Value}=    query the eniq database for    ${sql_query}    ${nodeName}    ${dateTime}
    Compare UI with DB value    ${measureValue}     ${DB_Value}
    Capture page screenshot
    [Teardown]    Close Browser
	
Test Case ID IMS 057
	open ims capacity analysis
    click on Reset button
	click on IMS Node Overview button
	validate page title as     IMS Node Overview
	click on link    HSS-FE: Traffic >> 
	validate page title as     HSS-FE: Traffic
	Click on scroll down button on IMS Node Overview Page    12    2
    In KPIs section select    User Location Success (%)
    select nodes from 'Node KPI Performance' section
    make selection in the 'KPI Details' graph
    click on 'Filtered Data' button on the current page
    validate page title as     HSS-FE Filtered Data
    ${measureValue}    ${nodeName}    ${dateTime}=    record NodeName & DateTime of first raw from the UI for HSS-FE
    ${sql_query}=      get sql query from json file    ./Resources/Data/ims-capacity/dataIntegrity.json     hssfe_User_Location_Success
    Log    ${sql_query}
    ${DB_Value}=    query the eniq database for    ${sql_query}    ${nodeName}    ${dateTime}
    Compare UI with DB value    ${measureValue}     ${DB_Value}
    Capture page screenshot
    [Teardown]    Close Browser
	
Test Case ID IMS 058
	open ims capacity analysis
    click on Reset button
	click on IMS Node Overview button
	validate page title as     IMS Node Overview
	click on link    HSS-FE: Platform >> 
	validate page title as     HSS-FE: platform
	Click on scroll down button on IMS Node Overview Page    12    2
    In KPIs section select    CPU Load (%)
    select nodes from 'Node KPI Performance' section
    make selection in the 'KPI Details' graph
    click on 'Filtered Data' button on the current page
    validate page title as     HSS-FE Filtered Data
    ${measureValue}    ${nodeName}    ${dateTime}=    record NodeName & DateTime of first raw from the UI for HSS-FE
    ${sql_query}=      get sql query from json file    ./Resources/Data/ims-capacity/dataIntegrity.json     hssfe_CPU_Load
    Log    ${sql_query}
    ${DB_Value}=    query the eniq database for    ${sql_query}    ${nodeName}    ${dateTime}
    Compare UI with DB value    ${measureValue}     ${DB_Value}
    Capture page screenshot
    [Teardown]    Close Browser
	
Test Case ID IMS 059
	open ims capacity analysis
    click on Reset button
	click on IMS Node Overview button
	validate page title as     IMS Node Overview
	click on link    HSS-FE: Platform >> 
	validate page title as     HSS-FE: platform
	Click on scroll down button on IMS Node Overview Page    12    2
    In KPIs section select    Memory Usage (%)
    select nodes from 'Node KPI Performance' section
    make selection in the 'KPI Details' graph
    click on 'Filtered Data' button on the current page
    validate page title as     HSS-FE Filtered Data
    ${measureValue}    ${nodeName}    ${dateTime}=    record NodeName & DateTime of first raw from the UI for HSS-FE
    ${sql_query}=      get sql query from json file    ./Resources/Data/ims-capacity/dataIntegrity.json     hssfe_Memory_Usage
    Log    ${sql_query}
    ${DB_Value}=    query the eniq database for    ${sql_query}    ${nodeName}    ${dateTime}
    Compare UI with DB value    ${measureValue}     ${DB_Value}
    Capture page screenshot
    [Teardown]    Close Browser
	
Test Case ID IMS 060
	open ims capacity analysis
    click on Reset button
	click on IMS Node Overview button
	validate page title as     IMS Node Overview
	click on link    CSCF: Platform and Capacity >> 
	validate page title as     CSCF: Platform and Capacity
	Make Selection in Time Range
	Click on scroll down button on IMS Node Overview Page    12    0
    In KPIs section select    Memory Usage (%)
    select nodes from 'Node KPI Performance' section
    make selection in the 'KPI Details' graph
    click on 'Filtered Data' button on the current page
    validate page title as     CSCF Filtered Data
    ${measureValue}    ${nodeName}    ${dateTime}=    record NodeName & DateTime of first raw from the UI for CSCF
    ${sql_query}=      get sql query from json file    ./Resources/Data/ims-capacity/dataIntegrity.json     cscf_Memory_Usage
    Log    ${sql_query}
    ${DB_Value}=    query the eniq database for    ${sql_query}    ${nodeName}    ${dateTime}
    Compare UI with DB value    ${measureValue}     ${DB_Value}
    Capture page screenshot
    [Teardown]    Close Browser
	
Test Case ID IMS 061
	open ims capacity analysis
    click on Reset button
	click on IMS Node Overview button
	validate page title as     IMS Node Overview
	click on link    CSCF: Traffic >>     
	Click on scroll down button on IMS Node Overview Page    12    2
    In KPIs section select    Call Attempts
    select nodes from 'Node KPI Performance' section
    make selection in the 'KPI Details' graph
    click on 'Filtered Data' button on the current page
    validate page title as     CSCF Filtered Data
    ${measureValue}    ${nodeName}    ${dateTime}=    record NodeName & DateTime of first raw from the UI for CSCF
    ${sql_query}=      get sql query from json file    ./Resources/Data/ims-capacity/dataIntegrity.json     cscf_Call_Attempts
    Log    ${sql_query}
    ${DB_Value}=    query the eniq database for cscf    ${sql_query}    ${nodeName}    ${dateTime}
    Compare UI with DB value    ${measureValue}     ${DB_Value}
    Capture page screenshot
    [Teardown]    Close Browser
	
Test Case ID IMS 064
	open ims capacity analysis
    click on Reset button
	click on IMS Node Overview button
	validate page title as     IMS Node Overview
	click on link    MTAS: Traffic >> 
	validate page title as     MTAS: Traffic
	Click on scroll down button on IMS Node Overview Page    12    2
    In KPIs section select    Initial Registration Success (%)
    select nodes from 'Node KPI Performance' section
    make selection in the 'KPI Details' graph
    click on 'Filtered Data' button on the current page
    validate page title as     MTAS Filtered Data
    ${measureValue}    ${nodeName}    ${dateTime}=    record NodeName & DateTime of first raw from the UI for MTAS
    ${sql_query}=      get sql query from json file    ./Resources/Data/ims-capacity/dataIntegrity.json     mtas_Initial_Registrations_Success
    Log    ${sql_query}
    ${DB_Value}=    query the eniq database for    ${sql_query}    ${nodeName}    ${dateTime}
    Compare UI with DB value    ${measureValue}     ${DB_Value}
    Capture page screenshot
    [Teardown]    Close Browser
    
