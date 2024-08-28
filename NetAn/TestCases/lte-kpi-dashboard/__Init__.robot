*** Settings ***

Documentation     LTE KPI Dashboard
Library           Selenium2Library
Library           OperatingSystem
Library           Selenium2Library
Library           Collections
Library           String
Library           SSHLibrary
Library           DateTime
Library           PostgreSQLDB
Resource          ${EXEC_DIR}/ENIQ_TC_Automation/NetAn/Resources/Keywords/${LTEKPIDashboardKeywordsFile}
Resource          ${EXEC_DIR}/ENIQ_TC_Automation/NetAn/Resources/Keywords/Variables.robot
Suite setup       Suite setup steps for LTE KPI Dashboard
Suite teardown    Suite teardown steps for LTE KPI Dashboard
Test teardown     Test teardown steps for LTE KPI Dashboard