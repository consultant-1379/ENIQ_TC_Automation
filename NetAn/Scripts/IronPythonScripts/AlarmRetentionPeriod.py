import unittest
from System.Collections.Generic import Dictionary
import clr
from System import Array
import time
from datetime import datetime
import os.path
			  

from Spotfire.Dxp.Application.Scripting import ScriptDefinition
from Spotfire.Dxp.Framework.Library import *
from Spotfire.Dxp.Data.Import import SbdfLibraryDataSource
from Spotfire.Dxp.Data import *
from Spotfire.Dxp.Application.Filters import *
from Spotfire.Dxp.Application.Visuals import VisualContent
from System import Guid
from System.Collections.Generic import List


TEST_FILES_PATH = """/Custom Library/ebkumki/PMEX_TEST/"""
MEASURES_TABLE = "Measure Mapping(Selected)"
PROPS_TABLE = "props_test_scenario"

# =====================
# Test case defintions
# =====================

deletionDate=""				
alarm_name= ""
DELETE_ALARM= "yes"

params_for_netan_connection = [[
 {
   "Name": "NetAnDB",
   "Type": "String",
   "Value": "localhost"
 },
 {
   "Name": "NetAnUserName",
   "Type": "String",
   "Value": "netanserver"
 },
 {
   "Name": "NetAnPassword",
   "Type": "String",
   "Value": "Ericsson01"
 }]

]

params_for_eniq_connection = [[
 {
   "Name": "ENIQDB",
   "Type": "String",
   "Value": "NetAn_ODBC"
 }]
]


params_for_activate_alarm = [[
 {
   "Name": "AlarmName",
   "Type": "String",
   "Value": alarm_name
 }
]]

params_for_delete_alarm = [[
 {
   "Name": "AlarmName",
   "Type": "String",
   "Value": alarm_name
 }
]]							
 
params_for_alarm_settings = [[
 {
   "Name": "RetentionLength",
   "Type": "String",
   "Value": "RETENTION_PERIOD"
 }
]]

class TestViewReportScript(unittest.TestCase):
    def test_navTo_save(self):
        set_test_case_from_json(params_for_node_details)   
        run_view_report()


    def tearDown(self):
        clean_environment()  

  
class TestEniqConnectionScript(unittest.TestCase):
    time.sleep(2)    
    def test_eniq_connection(self):
        set_test_case_from_json(params_for_eniq_connection)
        run_eniq_connection()

    def tearDown(self):
        clean_environment()
                   

class TestAlarmRulesManagerClickScript(unittest.TestCase):    
    def test_report_manager_click(self):  
        run_alarm_rules_manager_click()       

    def tearDown(self):
        clean_environment()


class TestSelectRowAndReadValuesOfReportScript(unittest.TestCase):    
    def test_select_row(self):  
        time.sleep(10)    	
        run_select_row()
        

    def tearDown(self):
        clean_environment()
		
class TestSelectAlarmAndReadValuesOfReportScript(unittest.TestCase):    
    def test_select_row(self):  
        run_select_inactiveAlarm()
        

    def tearDown(self):
        clean_environment()

class TestReadDeletionDateOfAlarmScript(unittest.TestCase):    
    def test_select_row(self):  
        run_read_deletionDate()
        

    def tearDown(self):
        clean_environment()		

class TestNetanConnectionScript(unittest.TestCase):
    def test_netan_connection(self):
        set_test_case_from_json(params_for_netan_connection)   
        run_netan_connection()


    def tearDown(self):
        clean_environment()

class TestAlarmRetensionPeriodScript(unittest.TestCase):    
    def test_create_button_click(self):  
        set_test_case_from_json(params_for_alarm_settings)
        
    def tearDown(self):
        clean_environment()        

        
class TestActivateScript(unittest.TestCase):    
    def test_activate_click(self): 
        set_test_case_from_json(params_for_activate_alarm)
        run_activate_button_click()
        

    def tearDown(self):
        clean_environment()
        
class TestDeleteScript(unittest.TestCase):    
    def test_delete_click(self):
        time.sleep(3)
        delete_alarm = DELETE_ALARM 
        if    delete_alarm=='yes':
            global alarm_name
            print alarm_name	
            set_test_case_from_json(params_for_delete_alarm)
            run_deactivate_button_click()							 
            run_delete_button_click()   

    def tearDown(self):
        clean_environment()
        

# =====================
# Supporting functions
# =====================



def setListBoxFilter(tableName, columnName, filterName, filterValues):
    """sets the given filterValues to the list box

    Arguments:
        tableName - name of the table
        filterName - name of the filtering Scheme 
        columnName - name of the column from the data table
        filterValues - list of values to be set in the list box filter
    Returns:
        None
    """


    try:
        dataTable = Document.Data.Tables[tableName]
        dataFilteringSelection = Document.Data.Filterings[filterName]
        filteringScheme = Document.FilteringSchemes[dataFilteringSelection]
        listBoxFilter = filteringScheme[dataTable][dataTable.Columns[columnName]].As[ListBoxFilter]()
        listBoxFilter.IncludeAllValues=False
        listBoxFilter.SetSelection(filterValues)
    except:
       print("Not able to set List box Filter: "+filterName )



def setMarking(tableName, columnName, markingName, dataToMark):

    """Marks the given dataToMark values for the given marking

    Arguments:
        tableName - name of the table
        columnName - name of the column from the data table
        markingName - name of the Marking
        dataToMark - list of values to be marked
    Returns:
        None
    """

    try:
        markingName = Document.Data.Markings[markingName]
        dataTable = Document.Data.Tables[tableName]
        rowCount=dataTable.RowCount
        rowsToInclude = IndexSet(rowCount, True)
        rowsToSelect = IndexSet(rowCount, False)
        cursor = DataValueCursor.CreateFormatted(dataTable.Columns[columnName])
        idx=0
        for row in dataTable.GetRows(rowsToInclude, cursor):
            found=False
            rowValue = cursor.CurrentValue
            if rowValue in dataToMark: 
                rowsToSelect[idx]=True
            idx=idx+1
        markingName.SetSelection(RowSelection(rowsToSelect), dataTable)
    except:
        print("Not able to set Marking: "+markingName )


def set_test_case_from_json(params):
    for each_param in params:
        for config in each_param:
            if    len(config['Value'])>0:
                Document.Properties[config['Name']] =  config['Value']

def create_cursor(table):
    """ Create a cursor dict for looping through specified columns in table """
    curs_list = []
    col_list = []
    for column in table.Columns:     
        curs_list.append(DataValueCursor.CreateFormatted(table.Columns[column.Name]))
        col_list.append(table.Columns[column.Name].ToString())
    cusrDict = dict(zip(col_list, curs_list))

    return cusrDict

def clean_environment():
    """ TODO: Should clean up the environment after every test (remove tables etc. imported)"""
    pass

    
def run_netan_connection():
    """ Calls the Netan connection script. """

    scriptDef = clr.Reference[ScriptDefinition]()
    Document.ScriptManager.TryGetScript("TestNetAnDb", scriptDef)
    paramDict = {} 

    params = Dictionary[str, object](paramDict)
    Document.ScriptManager.ExecuteScript(scriptDef.Value, params)

def run_eniq_connection():
    """ Calls the Netan connection script. """

    scriptDef = clr.Reference[ScriptDefinition]()
    Document.ScriptManager.TryGetScript("DatabaseConnection", scriptDef)
    paramDict = {} 

    params = Dictionary[str, object](paramDict)
    Document.ScriptManager.ExecuteScript(scriptDef.Value, params)

def run_alarm_rules_manager_click():
    """ Calls the sync with eniq script. """

active_page=Document.ActivePageReference.Id
Document.Properties["Action"]=active_page.ToString()

for page in Document.Pages:
   if (page.Title == "Alarm Rules Manager"):
      Document.ActivePageReference=page

   
def run_select_inactiveAlarm():																		  
    table=Document.Data.Tables['Alarm Definitions']
    
    #place generic data cursor on alarmName specific column
    cursor2 = DataValueCursor.CreateFormatted(table.Columns["AlarmState"])     
    #iterate through table column rows to retrieve the values
    for row in table.GetRows(cursor2):
            value = cursor2.CurrentValue
            rowIndexOfReport = row.Index
            if value == "Inactive":
                rowIndexOfReport = row.Index
                global deletionDate
                deletionDate = table.Columns["DeletionDate"].RowValues.GetFormattedValue(rowIndexOfReport)
                print deletionDate
                global alarm_name
                alarm_name = table.Columns["AlarmName"].RowValues.GetFormattedValue(rowIndexOfReport)
                break
    print deletionDate
    print alarm_name
		
    setMarking('Alarm Definitions', 'AlarmName', 'Marking', dataToMark = alarm_name)
    rowCount = table.RowCount
	
					  
					
    fileloc = os.path.join("PROJ_LOC" ,"AlarmDetails.txt")
    f = open(fileloc, 'w')
    f.truncate(0)
    time.sleep(3)
    f.write(alarm_name)
    time.sleep(3)		 
    f.close	
    rowsToMark = IndexSet(rowCount,False)
    rowsToMark.AddIndex(rowIndexOfReport)
    Document.ActiveMarkingSelectionReference.SetSelection(RowSelection(rowsToMark),table)																																					   		  			   
    						 						 
def run_read_deletionDate(): 													  
    table=Document.Data.Tables['Alarm Definitions']
    
    #place generic data cursor on alarmName specific column
    cursor = DataValueCursor.CreateFormatted(table.Columns["AlarmName"])
    global alarm_name
    global deletionDt
    alarm =alarm_name
    print alarm

    #iterate through table column rows to retrieve the values
    for row in table.GetRows(cursor):
            value = cursor.CurrentValue
            rowIndexOfReport = row.Index
            if value == alarm:
                rowIndexOfReport = row.Index
                global deletionDt
                deletionDt = table.Columns["DeletionDate"].RowValues.GetFormattedValue(rowIndexOfReport)
                break
	
    print deletionDt
    filelocn = os.path.join("PROJ_LOC" ,"AlarmDeleteDt.txt")
    f1 = open(filelocn, 'w')
    f1.truncate(0)																																			   					  			  													   
    time.sleep(3)															   
    f1.write(deletionDt)
    time.sleep(3)			 
    f1.close																				  
   

def run_eniqdb_connection():
    """ Calls the sync with eniq script. """

    scriptDef = clr.Reference[ScriptDefinition]()
    Document.ScriptManager.TryGetScript("TestConnection", scriptDef)
    paramDict = {}

    params = Dictionary[str, object](paramDict)
    Document.ScriptManager.ExecuteScript(scriptDef.Value, params)

def run_view_report():
    """ Calls the Navigate to measure selection script. """
    
    scriptDef = clr.Reference[ScriptDefinition]()
    Document.ScriptManager.TryGetScript("ApplyReportToWorkspace", scriptDef)
    paramDict = {} 

    params = Dictionary[str, object](paramDict)
    Document.ScriptManager.ExecuteScript(scriptDef.Value, params)

def run_activate_button_click():
    """ Calls the Navigate to measure selection script. """
    
    scriptDef = clr.Reference[ScriptDefinition]()
    Document.ScriptManager.TryGetScript("SuspendResumeMarkedAlarm", scriptDef)
    paramDict = {   "alarmState": "Active",
                    
                }              
    params = Dictionary[str, object](paramDict)
    Document.ScriptManager.ExecuteScript(scriptDef.Value, params)
							  
def run_deactivate_button_click():
    """ Calls the Navigate to measure selection script. """
    
    scriptDef = clr.Reference[ScriptDefinition]()
    Document.ScriptManager.TryGetScript("SuspendResumeMarkedAlarm", scriptDef)
    paramDict = {   "alarmState": "Deactive",
                    
                }
                
    params = Dictionary[str, object](paramDict)
    Document.ScriptManager.ExecuteScript(scriptDef.Value, params)

def run_delete_button_click():
    """ Calls the Navigate to measure selection script. """
    
    scriptDef = clr.Reference[ScriptDefinition]()
    Document.ScriptManager.TryGetScript("SuspendResumeMarkedAlarm", scriptDef)
    paramDict = {   "alarmState": "Deleted",
                    
                }
                
    params = Dictionary[str, object](paramDict)
    Document.ScriptManager.ExecuteScript(scriptDef.Value, params)
    

def pma_testing_suite():
    """Gather all the tests from this module in a test suite."""
    test_suite = unittest.TestSuite()

    # TODO: testing level value could be imported as a config file to say what tests we want to run for different scenarios
    testing_level = 'Quick'

    if testing_level == 'Quick':
        test_suite.addTest(unittest.makeSuite(TestNetanConnectionScript))
        test_suite.addTest(unittest.makeSuite(TestEniqConnectionScript))
        test_suite.addTest(unittest.makeSuite(TestAlarmRetensionPeriodScript))
        test_suite.addTest(unittest.makeSuite(TestAlarmRulesManagerClickScript))
        test_suite.addTest(unittest.makeSuite(TestSelectAlarmAndReadValuesOfReportScript))
        test_suite.addTest(unittest.makeSuite(TestDeleteScript))
        test_suite.addTest(unittest.makeSuite(TestReadDeletionDateOfAlarmScript))																 
    else:
        pass

    return test_suite


runner = unittest.TextTestRunner(verbosity=2)
runner.run(pma_testing_suite())


#

