*** Keywords ***

Open Custom KPI Manager Application
	AutoItLibrary.Run    C:\\Program Files (x86)\\TIBCO\\Spotfire\\11.4.2\\Spotfire.Dxp /server:"https://atvts4133.athtem.eei.ericsson.se/" /username:Administrator /password:Ericsson01 /file:${dxp_file_loc}/Custom_KPI_Manager_1.dxp
	Wait until screen contain     ${IMAGE_DIR}\\PMD_Home_Page.PNG    300
    Sleep    15
    Capture Screen    
	
Close Custom KPI Manager Application
    Capture page screenshot
    AutoItLibrary.ProcessClose      Custom_KPI_Manager_1.Dxp.exe
    AutoItLibrary.ProcessClose      Spotfire.Dxp.exe 
    OperatingSystem.Run    taskkill /f /im Spotfire.dxp.exe
    Sleep    5   
    
click on Custom KPI Manager button    
	sleep    5
    Wait until screen contain     ${IMAGE_DIR}\\PMD_Custom_KPI_Manager.PNG    300
    Click    ${IMAGE_DIR}\\PMD_Custom_KPI_Manager.PNG	
	
verify that the KPI List Page opened up
	sleep    5
	Screen should contain     ${IMAGE_DIR}\\PMD_KPI_List_Page.PNG
	
click on Generate KPI Template button
	sleep    5
	Wait until screen contain     ${IMAGE_DIR}\\PMD_Generate_KPI_Template_Button.PNG    300
	Click    ${IMAGE_DIR}\\PMD_Generate_KPI_Template_Button.PNG
	
verify that the Generate KPI Template button is working
	sleep    5
	Screen should contain     ${IMAGE_DIR}\\PMD_Generate_KPI_Template_Verification.PNG
	
click on Import KPIs button
	sleep    5
	Wait until screen contain     ${IMAGE_DIR}\\PMD_Import_KPIs.PNG    300
	Click    ${IMAGE_DIR}\\PMD_Import_KPIs.PNG
	
click on cancel button
	sleep    5
	Wait until screen contain     ${IMAGE_DIR}\\PMD_Cancel.PNG    300
	Click    ${IMAGE_DIR}\\PMD_Cancel.PNG
	
verify that 'No Files Selected' pop-up is visible
	sleep    5
	Screen should contain     ${IMAGE_DIR}\\PMD_Files_Not_Selected.PNG
	
go to the CSV file location
	sleep    5
	Paste text    ${IMAGE_DIR}\\PMD_CSV_Path.PNG    ${EXEC_DIR}\\ENIQ_TC_Automation\\NetAn\\Other\\CSV
	sleep    2
	key down    ENTER
	sleep    5
	
Select CSV file with KPI Details 
	sleep    3
	[Arguments]    ${file}
	IF    "${file}" == "1"
		Wait until screen contain     ${IMAGE_DIR}\\PMD_Testing_CSV_1.PNG    300
    	Click    ${IMAGE_DIR}\\PMD_Testing_CSV_1.PNG
    	sleep    2
    	Wait until screen contain     ${IMAGE_DIR}\\PMD_Open_Button.PNG    300
    	Click    ${IMAGE_DIR}\\PMD_Open_Button.PNG
    ELSE IF    "${file}" == "2"
		Wait until screen contain     ${IMAGE_DIR}\\PMD_Testing_CSV_2.PNG    300
    	Click    ${IMAGE_DIR}\\PMD_Testing_CSV_2.PNG
    	sleep    2
    	Wait until screen contain     ${IMAGE_DIR}\\PMD_Open_Button.PNG    300
    	Click    ${IMAGE_DIR}\\PMD_Open_Button.PNG
    ELSE IF    "${file}" == "3"
		Wait until screen contain     ${IMAGE_DIR}\\PMD_Wrong_Template.PNG    300
    	Click    ${IMAGE_DIR}\\PMD_Wrong_Template.PNG
    	sleep    2
    	Wait until screen contain     ${IMAGE_DIR}\\PMD_Open_Button.PNG    300
    	Click    ${IMAGE_DIR}\\PMD_Open_Button.PNG
    ELSE IF    "${file}" == "4"
		Wait until screen contain     ${IMAGE_DIR}\\PMD_Testing_CSV_3.PNG    300
    	Click    ${IMAGE_DIR}\\PMD_Testing_CSV_3.PNG
    	sleep    2
    	Wait until screen contain     ${IMAGE_DIR}\\PMD_Open_Button.PNG    300
    	Click    ${IMAGE_DIR}\\PMD_Open_Button.PNG
    ELSE IF    "${file}" == "5"
		Wait until screen contain     ${IMAGE_DIR}\\PMD_Deleting_CSV.PNG    300
    	Click    ${IMAGE_DIR}\\PMD_Deleting_CSV.PNG
    	sleep    2
    	Wait until screen contain     ${IMAGE_DIR}\\PMD_Open_Button.PNG    300
    	Click    ${IMAGE_DIR}\\PMD_Open_Button.PNG
    END
    sleep    3
    
verify that the KPI is added
	sleep    10   
    Screen should contain     ${IMAGE_DIR}\\PMD_KPIs_Added.PNG
    Wait until screen contain     ${IMAGE_DIR}\\PMD_KPI_OK.PNG    30
    Click    ${IMAGE_DIR}\\PMD_KPI_OK.PNG
    
verify that 'Duplication Of KPIs' pop-up is visible
	sleep    10
	Screen should contain     ${IMAGE_DIR}\\PMD_Duplicate_KPI.PNG
	
verify that an error message is visible	
	sleep    15
	Screen should contain     ${IMAGE_DIR}\\PMD_Wrong_Template_Error.PNG
	
verify that the KPI is present in Custom KPIs table	
	sleep    15
	Screen should contain     ${IMAGE_DIR}\\PMD_Added_Custom_KPI.PNG
	
verify that old and new KPIs are present	
	sleep    15
	Screen should contain     ${IMAGE_DIR}\\PMD_Old_New_KPIs.PNG
	
delete the KPI
	sleep    15
	Wait until screen contain     ${IMAGE_DIR}\\PMD_Delete_Button.PNG    30
	Click    ${IMAGE_DIR}\\PMD_Delete_Button.PNG
	sleep    10
	Wait until screen contain     ${IMAGE_DIR}\\PMD_Deletion_Confirmation.PNG    30
	Click    ${IMAGE_DIR}\\PMD_Deletion_Confirmation.PNG
	sleep    10
	Wait until screen contain     ${IMAGE_DIR}\\PMD_Deletion_Confirmation_OK.PNG    30
	Click    ${IMAGE_DIR}\\PMD_Deletion_Confirmation_OK.PNG
	sleep    10
	
verify that the KPI is not present in Custom KPIs table
	sleep    15
	Screen should not contain     ${IMAGE_DIR}\\PMD_Added_Custom_KPI.PNG
	
open the Custom Measure Mapping file
	Click    ${IMAGE_DIR}\\PMD_File_Button.PNG
	sleep    3     
	click    ${IMAGE_DIR}\\PMD_File_Open_Button.PNG
	sleep    3
	Click    ${IMAGE_DIR}\\PMD_Spotfire_Library_button.PNG
	sleep    3
	double click    ${IMAGE_DIR}\\PMD_Ericsson_Library.PNG
	sleep    3
	double click    ${IMAGE_DIR}\\PMD_General_Button.PNG
	sleep    3
	double click    ${IMAGE_DIR}\\PMD_PMData_Button.PNG
	sleep    3
	double click    ${IMAGE_DIR}\\PMD_PM-Data_Button.PNG
	sleep    3
	double click    ${IMAGE_DIR}\\PMD_Analysis_Button.PNG
	sleep    3
	double click    ${IMAGE_DIR}\\PMD_Custom_Measure_Mapping.PNG
	sleep    3
	Click    ${IMAGE_DIR}\\PMD_Add_as_Rows.PNG
	sleep    3
	Click    ${IMAGE_DIR}\\PMD_Add_as_New_Table.PNG
	sleep    3  
	Click    ${IMAGE_DIR}\\PMD_CMM_OK.PNG
	sleep    3  
	Click    ${IMAGE_DIR}\\PMD_Visualizations.PNG
	sleep    3  
	Click    ${IMAGE_DIR}\\PMD_Table_Visualization.PNG
	sleep    3  
	Click    ${IMAGE_DIR}\\PMD_Data_Table.PNG
	sleep    3  
	Click    ${IMAGE_DIR}\\PMD_CMM_(2).PNG
	sleep    5
	Screen should contain    ${IMAGE_DIR}\\PMD_CMM_(2)_Verification  
	
verify that the columns are present
    ${sql}=    set variable    SELECT COLUMN_NAME FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = 'tblSavedReports' ORDER BY ORDINAL_POSITION
    ${results}=    Query Postgre database and return output     ${sql}
    Log    ${results}
    ${results}=    convert to string    ${results}
    should contain    ${results}    MeasureType    MeasureName
    
verify that the columns have data
   	${sql}=    set variable    select "MeasureType" FROM "tblSavedReports"
    ${results}=    Query Postgre database and return output     ${sql}
    Log    ${results}
    should not be empty    ${results}
    ${sql1}=    set variable    select "MeasureName" FROM "tblSavedReports"
    ${results1}=    Query Postgre database and return output     ${sql1}
    Log    ${results1}
    should not be empty    ${results1}
	
open tblSavedReports in Information Links	
	Click    ${IMAGE_DIR}\\PMD_Data_Button.PNG
	sleep    3
	Click    ${IMAGE_DIR}\\PMD_Information_Designer.PNG
	sleep    5
	double click    ${IMAGE_DIR}\\PMD_Ericsson_Library_Folder.PNG
	sleep    5
	double click    ${IMAGE_DIR}\\PMD_General_Folder.PNG
	sleep    3
	double click    ${IMAGE_DIR}\\PMD_PMData_Folder.PNG
	sleep    3
	double click    ${IMAGE_DIR}\\PMD_PM-Data_Folder.PNG
	sleep    3
	double click    ${IMAGE_DIR}\\PMD_InformationPackage.PNG
	sleep    3
	double click    ${IMAGE_DIR}\\PMD_InformationLinks.PNG
	sleep    3
	double click    ${IMAGE_DIR}\\PMD_tblSavedReports.PNG
	sleep    5
	
	
verify that the columns are present in the Information Links
	sleep    5
	FOR    ${i}    IN RANGE    0    8
		Click    ${IMAGE_DIR}\\PMD_Move_Down_Button.PNG
    END
	sleep    5
	Screen should contain    ${IMAGE_DIR}\\PMD_Column_Verification.PNG	
	
#################### TR-IA11419 TCs ####################
	
Verify that the Custom KPI Manager button is visible
	sleep    5
	Screen should contain    ${IMAGE_DIR}\\PMD_Custom_KPI_Manager.PNG

validate that the Generate KPI Template button is visible
	sleep    5
	Screen should contain    ${IMAGE_DIR}\\PMD_Generate_KPI_Template_Button.PNG
	
validate that the Import KPIs button is visible
	sleep    5
	Screen should contain    ${IMAGE_DIR}\\PMD_Import_KPIs.PNG
	
validate that the Delete button is visible
	sleep    5
	Screen should contain    ${IMAGE_DIR}\\PMD_Delete_Button.PNG

Validate that Import KPIs window opened up
	sleep    5
	Screen should contain    ${IMAGE_DIR}\\PMD_Generate_KPI_Template_Verification.PNG

verify that the table Custom KPIs is visible
	sleep    5
	Screen should contain    ${IMAGE_DIR}\\PMD_Custom_KPIs_Table.PNG

verify that the table Error Log is visible
	sleep    5
	Screen should contain    ${IMAGE_DIR}\\PMD_Error_Log_Table.PNG

verify that the table Custom Measure Mapping table is present
	sleep    5
	Screen should contain    ${IMAGE_DIR}\\PMD_CMM_(2)_Verification.PNG

verify that the table Error Log (Custom-KPI Import) is visible
	sleep    5
	Screen should contain    ${IMAGE_DIR}\\PMD_Error_Log_Custom_KPI_Import.PNG

verify that the column FileName is present in Error Log table
	sleep    5
	Screen should contain    ${IMAGE_DIR}\\PMD_Error_Log_Custom_KPI_Import.PNG

Deselect the Custom KPIs
	Wait until screen contain     ${IMAGE_DIR}\\PMD_Custom_KPIs_Table.PNG    30
	Click    ${IMAGE_DIR}\\PMD_Custom_KPIs_Table.PNG    1600     150  

verify that the Delete button is disabled
	sleep    5
	Screen should not contain    ${IMAGE_DIR}\\PMD_Deletion_Confirmation.PNG

verify that the Delete button is enabled
	sleep    5
	Screen should contain    ${IMAGE_DIR}\\PMD_Deletion_Confirmation.PNG

click on the delete button
	sleep    5
	Wait until screen contain     ${IMAGE_DIR}\\PMD_Delete_Button.PNG    30
	Click    ${IMAGE_DIR}\\PMD_Delete_Button.PNG

verify that the KPI is present in DelMeasures
	sleep    5
	Click on the element    ${IMAGE_DIR}\\FileMenu.PNG      ${IMAGE_DIR}\\DocumentProperties.PNG     3
    Click    ${IMAGE_DIR}\\DocumentProperties.PNG      
    Click    ${IMAGE_DIR}\\PropertiesButton.PNG
    sleep    5
    Set ocr text read    True
    ${text}=    SikuliLibrary.Get text
    Log    ${text}
    [Return]    ${text}
    should contain    ${text}    DelMeasures DeleteKP

Click on the element
    [Arguments]    ${ele}    ${exp_ele}    ${retries}    ${sleep_time}=5
    Click    ${ele}
    FOR    ${i}    IN RANGE    0    ${retries} 
           Sleep    ${sleep_time}s
           ${is_exists}=    Exists    ${exp_ele}   2
           Exit For Loop If    ${is_exists} == True
           Click    ${ele}
    END

verify that the KPIs are present in pop-up
	sleep    5
	Screen should contain    ${IMAGE_DIR}\\PMD_KPI_Deletion_Confirmation.PNG
	sleep    2
	Screen should contain    ${IMAGE_DIR}\\PMD_KPI_Deletion_KPI_Name.PNG
    
write into the CSV file
	[Arguments]     ${fileName}    ${kpiType}    ${Formula}    ${Node}    ${Description}    ${Joins}    ${FlexFilterValues}    ${Index}
	Empty CSV File    ${EXEC_DIR}\\ENIQ_TC_Automation\\NetAn\\Other\\CSV\\${fileName}
	${list}=    Create List    KPI    Formula    Node Type    Description    Joins    FlexFilterValues    Index
    ${data}=    create list    ${list}
    ${currDate}=    Get current date
	${kpiName}=    set variable    ${kpiType}${currDate}
	${kpiMeasure}=    set variable    ${Formula}
	${kpiNode}=    set variable    ${Node}
	${kpiDescription}=    set variable    ${Description}
	${kpiJoins}=    set variable    ${Joins}
	${kpiFlex}=    set variable    ${FlexFilterValues}
	${kpiIndex}=    set variable    ${Index}
	${kpiInfoList}=    Create List    ${kpiName}    ${kpiMeasure}    ${kpiNode}    ${kpiDescription}    ${kpiJoins}    ${kpiFlex}    ${kpiIndex}
    ${kpiInfo}=    create list    ${kpiInfoList}
    Append To Csv File    ${EXEC_DIR}\\ENIQ_TC_Automation\\NetAn\\Other\\CSV\\${fileName}    ${data}
    Append To Csv File    ${EXEC_DIR}\\ENIQ_TC_Automation\\NetAn\\Other\\CSV\\${fileName}    ${kpiInfo}
    [Return]    ${kpiName}

open the KPI Template File
	sleep    3
	[Arguments]    ${file}
	IF    "${file}" == "1"
		Wait until screen contain     ${IMAGE_DIR}\\PMD_KPI_TemplateFile.PNG    300
    	Click    ${IMAGE_DIR}\\PMD_KPI_TemplateFile.PNG
    	sleep    2
    	Wait until screen contain     ${IMAGE_DIR}\\PMD_Open_Button.PNG    300
    	Click    ${IMAGE_DIR}\\PMD_Open_Button.PNG
    ELSE IF    "${file}" == "2"
		Wait until screen contain     ${IMAGE_DIR}\\PMD_DeleteFile.PNG    300
    	Click    ${IMAGE_DIR}\\PMD_DeleteFile.PNG
    	sleep    2
    	Wait until screen contain     ${IMAGE_DIR}\\PMD_Open_Button.PNG    300
    	Click    ${IMAGE_DIR}\\PMD_Open_Button.PNG
    END
	sleep    3

verify that deletion failed since KPIs are being used
	sleep    10
	Screen should contain    ${IMAGE_DIR}\\PMD_Delete_KPI_failure.PNG

verify that deletion failed since KPI is being used in PMEx
	sleep    10
	Screen should contain    ${IMAGE_DIR}\\PMD_Delete_KPI_failure.PNG

verify the Pup-up for unused KPI deletion
	sleep    5
	Screen should contain    ${IMAGE_DIR}\\PMD_KPI_Deletion_Confirmation.PNG

verify the pop-up if both used and un-used KPIs are selected
	sleep    5
	Screen should contain    ${IMAGE_DIR}\\PMD_KPI_Deletion_Affirmation.PNG
	sleep    2
	Screen should contain    ${IMAGE_DIR}\\PMD_Delete_KPI_failure.PNG

verify the pop-up message KPIs Deleted Successfully
	sleep    2
	Screen should contain    ${IMAGE_DIR}\\PMD_KPI_Deletion_Confirmation_Window.PNG
	
verify the data in tblReports table
	sleep    5
	Wait until screen contain     ${IMAGE_DIR}\\PMD_Visualizations.PNG    300
    Click    ${IMAGE_DIR}\\PMD_Visualizations.PNG
    sleep    5
    Wait until screen contain     ${IMAGE_DIR}\\PMD_Table_Visualization.PNG    300
    Click    ${IMAGE_DIR}\\PMD_Table_Visualization.PNG
    sleep    5
	Wait until screen contain     ${IMAGE_DIR}\\PMD_Data_Table.PNG    300
    Click    ${IMAGE_DIR}\\PMD_Data_Table.PNG
	sleep    5
	Wait until screen contain     ${IMAGE_DIR}\\PMD_CKM_tblSavedReports.PNG    300
    Click    ${IMAGE_DIR}\\PMD_CKM_tblSavedReports.PNG
	
connect to the ENIQ Database with incorrect credentials
	${status}=    Run keyword and return status    Connect To Postgresql   netAnServer_pmdb 	netanserver	 Ericsson	localhost	5432
	Log    ${status}
	[Return]    ${status}
	
Query Postgre database and return output when DB is not connected
	[Arguments]    ${sql_query}
	${results}=	   PostgreSQLDB.Execute Sql String    ${sql_query}
	[return]    ${results}

query the table tblSavedReports
	${sql}=    set variable    select * from "tblSavedReports"
    ${results}=    Run keyword and return status    Query Postgre database and return output when DB is not connected     ${sql}
    Log    ${results}
    
verify that the query did not yield an output
	[Arguments]    ${status}
	${status}=    convert to string    ${status}
	should be equal    ${status}    None	
	
#################### TR-IA11419 TCs END ####################	
	
#################### MR EQEV-106349 TestCases ####################

verify that we get an error for unsupported formulas
	sleep    10
	Screen should contain    ${IMAGE_DIR}\\PMD_Unsupported_Formula_Error.PNG	
	
#################### MR EQEV-106349 TestCases END ####################




#################### RPA Keywords ####################	
Open the Custom KPI Manager Application
    #Operatingsystem.run      "C:\Users\Public\Desktop\TIBCO Spotfire Analyst.lnk" /server:"https://localhost/" /username:Administrator /password:Ericsson01 
	AutoItLibrary.Run    C:\\Program Files (x86)\\TIBCO\\Spotfire\\11.4.2\\Spotfire.Dxp /server:"https://localhost/" /username:Administrator /password:Ericsson01 /file:${dxp_file_loc}/Custom_KPI_Manager.dxp
	Sleep     5s
	close the certificate prompt
	run keyword and ignore error    close the Missing Information Link window

close the certificate prompt
    sleep    10
	press keyboard button    '{TAB}'
	sleep    5
	press keyboard button    '{ENTER}'
	
open search prompt and search for
	[Arguments]    ${text}
	sleep    5    
    open search prompt
	enter text    ${text}
	sleep    4
	press keyboard button    '{ENTER}'
	sleep    5
	
go to document properties and run the script
	[Arguments]    ${script}	
	control window    Document Properties
	sleep    5
	RPA.Windows.Click   name:Properties
	control window    Document Properties
	sleep    4
	RPA.Windows.Click  id:scriptButton
	sleep    4
	control window    Script – Act on Property Change
	sleep    4
	RPA.Windows.Click  id:useScriptRadioButton
	sleep    5
	RPA.Windows.Click  id:newButton
	sleep    4
	control window    New Script
	RPA.Windows.Click  id:wrapInTransactionCheckbox
	sleep    4
	RPA.Windows.Click  id:nameTextBox
	click button multiple times    {TAB}    3
	paste the text    ${script}
    RPA.Desktop.Clear Clipboard
	sleep    4
	RPA.Windows.Click  id:runButton
	sleep    10
	
read an return the output
	sleep    10
	RPA.Windows.Click  id:outputTextBox
	sleep    4
	copy and paste output
	${spotfireOutput}=    OperatingSystem.get file    ${EXEC_DIR}\\SpotfireOutput.txt
	Log    ${spotfireOutput}
	[Return]    ${spotfireOutput}
	

	