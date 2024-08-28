*** Settings ***

Documentation       Network Evolution
Library             Selenium2Library
Library             OperatingSystem
Library             Selenium2Library
Library             Collections
Library             String
Library             SSHLibrary
Library             DateTime
Library             PostgreSQLDB
Library				DatabaseLibrary
Resource            ${EXEC_DIR}/ENIQ_TC_Automation/NetAn/Resources/Keywords/Variables.robot
Resource            ${EXEC_DIR}/ENIQ_TC_Automation/NetAn/Resources/Keywords/${PMDataKeywordFile}
Library             ${EXEC_DIR}/ENIQ_TC_Automation/NetAn/Resources/Libraries/DynamicTestcases.py
Resource            ${EXEC_DIR}/ENIQ_TC_Automation/NetAn/Resources/Keywords/PostgresDBConnection.robot
Resource            ${EXEC_DIR}/ENIQ_TC_Automation/NetAn/Resources/Keywords/SybaseDBConnection.robot
Suite setup         Suite setup steps for PMA and PMEX
Test Setup          Open Connection And Log In    ${puttyServer}    ${puttyPort}    ${puttyUserName}    ${puttyPassword}
Suite teardown      Suite teardown steps for PMA and PMEX
Test teardown       Test teardown steps for PMA and PMEX