*** Settings ***
Documentation     Verifying MSA Page
Library           OperatingSystem
Library           Selenium2Library
Library           Collections
Library           String
Library           DateTime
Library           PostgreSQLDB
Library           DatabaseLibrary
Library			  Process
Resource          ${EXEC_DIR}/ENIQ_TC_Automation/NetAn/Resources/Keywords/Variables.robot
Resource          ${EXEC_DIR}/ENIQ_TC_Automation/NetAn/Resources/Keywords/${NRAppKeywords}
Resource          ${EXEC_DIR}/ENIQ_TC_Automation/NetAn/Resources/Keywords/SybaseDBConnection.robot
Library           ${EXEC_DIR}/ENIQ_TC_Automation/NetAn/Resources/Libraries/DynamicTestcases.py



*** Test Cases ***
Verifying MSA Page
	[Tags]    NR_AC_CDB    NR_AC_KGB   NetAn_UG_NRAC_16       
	replace the datasource in FeatureInstaller    C:\\Ericsson\\NetAnServer\\Modules\\FeatureInstaller\\FeatureInstaller.psm1    ieatrcxb4070    atvts4115
	${featureName}=    install feature     NR-App-Coverage
	replace the featureName in FeatureInstall file    ${featureName}
	replace the datasource in FeatureInstaller    C:\\Ericsson\\NetAnServer\\Modules\\FeatureInstaller\\FeatureInstaller.psm1    atvts4115    ieatrcxb4070
	open Library file
	Copy analysis and Information package files for 4115
	Close Browser
	${featureName}=    install feature     NR-App-Coverage
	replace the featureName in FeatureInstall file    ${featureName}
	open Library file
	Copy analysis and Information package files for 4070
	Close Browser
	Open primary data source Analysis
	Go to home page if not already at home
	click on the scroll down button    0    25
	click on the button    Settings
	Open MSA Configuration
	Enter secondary data source    1
	Enter name of data source    atvts4115
	Click on Configure MSA button
	Validate MSA message	
	[Teardown]    Test teardown