*** Settings ***

Documentation       CMCC
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
Resource            ${EXEC_DIR}/ENIQ_TC_Automation/NetAn/Resources/Keywords/${CMCCKeywordsFile}
Suite setup         Suite setup steps for CCMC
Suite teardown      Suite teardown steps for CCMC
Test teardown       Test teardown steps for CCMC