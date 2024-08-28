*** Settings ***

Documentation       Router6k
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
Resource            ${EXEC_DIR}/ENIQ_TC_Automation/NetAn/Resources/Keywords/${Router6kFile}
Suite setup         Suite setup steps for Router6k
Suite teardown      Suite teardown steps for Router6k
Test teardown       Test teardown steps for Router6k
