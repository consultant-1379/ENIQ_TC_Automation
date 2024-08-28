*** Settings ***

Documentation     NR App Coverage 
Library           Selenium2Library
Library           OperatingSystem
Library           Selenium2Library
Library           Collections
Library           String
Library           SSHLibrary
Library           DateTime
Library           PostgreSQLDB
Resource          ${EXEC_DIR}/ENIQ_TC_Automation/NetAn/Resources/Keywords/Variables.robot
Resource          ${EXEC_DIR}/ENIQ_TC_Automation/NetAn/Resources/Keywords/${NRAppKeywords}
Suite setup       Suite setup steps for NR App Coverage
Suite teardown    Suite teardown steps for NR App Coverage