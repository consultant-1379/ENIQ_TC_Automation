*** Settings ***
Documentation     WCDMA
Library           Selenium2Library
Library           OperatingSystem
Library           Selenium2Library
Library           Collections
Library           String
Library           SSHLibrary
Library           DateTime
Library           PostgreSQLDB
Resource          ${EXEC_DIR}/ENIQ_TC_Automation/NetAn/Resources/Keywords/Variables.robot
Resource          ${EXEC_DIR}/ENIQ_TC_Automation/NetAn/Resources/Keywords/${WCDMAKeywordFile}

Suite setup       Suite setup steps for wcdma
Suite teardown    Suite teardown steps for wcdma
Test teardown     Test teardown steps for wcdma