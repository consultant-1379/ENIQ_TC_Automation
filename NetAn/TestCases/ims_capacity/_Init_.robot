*** Settings ***

Documentation   ims capacity analysis
Library           OperatingSystem
Library           Selenium2Library
Library           Collections
Library           String
Library           SSHLibrary
Library           DateTime
Library           PostgreSQLDB
Library           DatabaseLibrary
Resource          ${EXEC_DIR}/ENIQ_TC_Automation/NetAn/Resources/Keywords/Variables.robot
Resource          ${EXEC_DIR}/ENIQ_TC_Automation/NetAn/Resources/Keywords/${IMSCapacityKeywordsFile}
Suite setup       Suite setup steps for IMS Capacity Analysis
Suite teardown    Suite teardown steps for IMS Capacity Analysis
Test teardown     Test teardown steps for IMS Capacity Analysis
