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

class TestNetanConnectionScript(unittest.TestCase):
    def test_netan_connection(self):
        set_test_case_from_json(params_for_netan_connection)   
        run_netan_connection()


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

class TestSelectAlarmScript(unittest.TestCase):    
    def test_select_alarm(self):  
        run_select_alarm()
        
    def tearDown(self):
        clean_environment()

class TestClickExportButtonScript(unittest.TestCase):    
    def test_select_alarm(self):  
        run_click_export()
        
    def tearDown(self):
        clean_environment()	
		
class TestReadExportMessageScript(unittest.TestCase):    
    def test_select_alarm(self):  
        run_read_export_msg()
        
    def tearDown(self):
        clean_environment()			
		
# =====================
# Supporting functions
# =====================
def setCheckInCheckBox(tableName, columnName, filterScheme,value):
    FilterSelection = Document.Data.Filterings["filterScheme"]

# Define column filter
    filt = Document.FilteringSchemes[FilterSelection][Document.Data.Tables["tableName"]]["columnName"].As[filters.CheckBoxFilter]()
    filt.Check(value)

def set_test_case_from_json(params):
    for each_param in params:
        for config in each_param:
            if    len(config['Value'])>0:
                Document.Properties[config['Name']] =  config['Value']


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


def run_alarm_rules_manager_click():
    """ Calls the sync with eniq script. """

active_page=Document.ActivePageReference.Id
Document.Properties["Action"]=active_page.ToString()

for page in Document.Pages:
   if (page.Title == "Alarm Rules Manager"):
      Document.ActivePageReference=page

    
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


def run_sync_with_eniq():
    """ Calls the sync with eniq script. """

    scriptDef = clr.Reference[ScriptDefinition]()
    Document.ScriptManager.TryGetScript("MeasureMappingENIQ", scriptDef)
    paramDict = {} 

    params = Dictionary[str, object](paramDict)
    Document.ScriptManager.ExecuteScript(scriptDef.Value, params)

	
def run_eniqdb_connection():
    """ Calls the sync with eniq script. """

    scriptDef = clr.Reference[ScriptDefinition]()
    Document.ScriptManager.TryGetScript("TestConnection", scriptDef)
    paramDict = {}

    params = Dictionary[str, object](paramDict)
    Document.ScriptManager.ExecuteScript(scriptDef.Value, params)

def run_click_export():
    """ Calls the sync with eniq script. """

    scriptDef = clr.Reference[ScriptDefinition]()
    Document.ScriptManager.TryGetScript("ExportAlarmRules", scriptDef)
    paramDict = {}

    params = Dictionary[str, object](paramDict)
    Document.ScriptManager.ExecuteScript(scriptDef.Value, params)	

	
def run_read_export_msg():
    exportMsg = Document.Properties["ExportMessage"]
    print("exportMsg:")
    print(exportMsg)
    fileloc = os.path.join("C:\\Users\\Administrator2\\Shimmy_admin2\\PMA\\ENIQ_TC_Automation\\NetAn\\Other\\Files" ,"Message.txt")
    f = open(fileloc, 'w')
    f.truncate(0) 
    f.write(exportMsg)
    f.close	  		

def run_select_alarm(): 
    table=Document.Data.Tables['Alarm Definitions']
    cursor = DataValueCursor.CreateFormatted(table.Columns["AlarmName"])
    value=''
    for row in table.GetRows(cursor):
            value = cursor.CurrentValue
            rowIndexOfReport = row.Index
            break
    print("value")
    print(value)	
    setMarking('Alarm Definitions', 'AlarmName', 'Marking', dataToMark = value)
    rowCount = table.RowCount   
    rowsToMark = IndexSet(rowCount,False)
    rowsToMark.AddIndex(rowIndexOfReport)
    Document.ActiveMarkingSelectionReference.SetSelection(RowSelection(rowsToMark),table)   
		
def run_alarm_rules_manager_click():
    """ Calls the sync with eniq script. """

active_page=Document.ActivePageReference.Id
Document.Properties["Action"]=active_page.ToString()

for page in Document.Pages:
   if (page.Title == "Alarm Rules Manager"):
      Document.ActivePageReference=page


def pma_testing_suite():
    """Gather all the tests from this module in a test suite."""
    test_suite = unittest.TestSuite()

    # TODO: testing level value could be imported as a config file to say what tests we want to run for different scenarios
    testing_level = 'Quick'

    if testing_level == 'Quick':
        test_suite.addTest(unittest.makeSuite(TestNetanConnectionScript))
        test_suite.addTest(unittest.makeSuite(TestEniqConnectionScript))
        test_suite.addTest(unittest.makeSuite(TestAlarmRulesManagerClickScript))
        test_suite.addTest(unittest.makeSuite(TestSelectAlarmScript))
        test_suite.addTest(unittest.makeSuite(TestClickExportButtonScript))
        test_suite.addTest(unittest.makeSuite(TestReadExportMessageScript))
    else:
        pass

    return test_suite


runner = unittest.TextTestRunner(verbosity=2)
runner.run(pma_testing_suite())









#


