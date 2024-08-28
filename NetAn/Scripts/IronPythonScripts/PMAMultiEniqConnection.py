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
   "Value": "DATASOURCE"
 }]
]					
 
class TestEniqConnectionScript(unittest.TestCase):    
					 
    def test_eniq_connection(self):
        set_test_case_from_json(params_for_eniq_connection)
        run_eniq_connection()

    def tearDown(self):
        clean_environment()                	

class TestNetanConnectionScript(unittest.TestCase):
    def test_netan_connection(self):
        set_test_case_from_json(params_for_netan_connection)   
        run_netan_connection()

    def tearDown(self):
        clean_environment()


class TestGetDataSourceListScript(unittest.TestCase):
    def test_get_DataSourceList(self):   
        run_get_eniqDataSourceList()
								  

    def tearDown(self):
        clean_environment()


class TestAdminPageClickScript(unittest.TestCase):    
    def test_admin_page_click(self):  
        run_admin_page_click()
        time.sleep(5)
        
    def tearDown(self):
        clean_environment()
        
class TestDeleteEniqConnectionScript(unittest.TestCase):
    def test_get_DataSourceList(self): 
        Document.Properties["EniqToDelete"] = "NetAn_4140"	
        print(Document.Properties["EniqToDelete"])
        run_deleteEniqFromDb()

    def tearDown(self):
        clean_environment()

class TestSelectAnEniqConnectionScript(unittest.TestCase):
    def test_get_DataSourceList(self):   
        run_selectAnEniqConnection()
	
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

def run_admin_page_click():
    """ Calls the sync with eniq script. """
    active_page=Document.ActivePageReference.Id
    Document.Properties["Action"]=active_page.ToString()

    for page in Document.Pages:
        if (page.Title == "Administration"):
             Document.ActivePageReference=page
          
              
def run_get_eniqDataSourceList():																		  
    table=Document.Data.Tables['EniqEnmMapping']
    
    #place generic data cursor on alarmName specific column
    cursor = DataValueCursor.CreateFormatted(table.Columns["EniqDataSource"])     
    #iterate through table column rows to retrieve the values
    fileloc = os.path.join("PROJ_LOC" ,"DataSourceList.txt")															
    f = open(fileloc, 'w')
    f.truncate(0)
    for row in table.GetRows(cursor):
            value = cursor.CurrentValue							   
            colValue=value + "," 
            print colValue			 
            f.write(colValue)  
    
def run_deleteEniqFromDb():
    """ Calls the Netan connection script. """

    scriptDef = clr.Reference[ScriptDefinition]()
    Document.ScriptManager.TryGetScript("deleteEniqFromDb", scriptDef)
    paramDict = {} 

    params = Dictionary[str, object](paramDict)
    Document.ScriptManager.ExecuteScript(scriptDef.Value, params)
   
def run_selectAnEniqConnection():																		  								 
    table=Document.Data.Tables['ENIQDataSources']
    
    #place generic data cursor on alarmName specific column
    cursor1 = DataValueCursor.CreateFormatted(table.Columns["AvailableEniqDs"])  
	
    #iterate through table column rows to retrieve the values
    dataSourceName="NetAn_4140"
    print("dataSourceName")
    print dataSourceName
    for row in table.GetRows(cursor1):
            value1 = cursor1.CurrentValue
            if value1 == dataSourceName:
								
				rowIndexOfReport = row.Index
				print  rowIndexOfReport
				break
	
    setMarking('ENIQDataSources', 'AvailableEniqDs', 'Marking', dataToMark = dataSourceName)
    rowCount = table.RowCount
    print rowIndexOfReport
    rowsToMark = IndexSet(rowCount,False)
    rowsToMark.AddIndex(rowIndexOfReport)


    Document.ActiveMarkingSelectionReference.SetSelection(RowSelection(rowsToMark),table)
    state=table.Columns['AvailableEniqDs'].RowValues.GetFormattedValue(rowIndexOfReport)
    print("state")
    print state
  

def run_eniqdb_connection():
    """ Calls the sync with eniq script. """

    scriptDef = clr.Reference[ScriptDefinition]()
    Document.ScriptManager.TryGetScript("TestConnection", scriptDef)
    paramDict = {}

    params = Dictionary[str, object](paramDict)
    Document.ScriptManager.ExecuteScript(scriptDef.Value, params)


def pma_testing_suite():
    """Gather all the tests from this module in a test suite."""
    test_suite = unittest.TestSuite()

    # TODO: testing level value could be imported as a config file to say what tests we want to run for different scenarios
    testing_level = 'Quick'

    if testing_level == 'Quick':
        test_suite.addTest(unittest.makeSuite(TestAdminPageClickScript))    
        test_suite.addTest(unittest.makeSuite(TestNetanConnectionScript))
        test_suite.addTest(unittest.makeSuite(TestEniqConnectionScript))
        test_suite.addTest(unittest.makeSuite(TestGetDataSourceListScript))																 
        test_suite.addTest(unittest.makeSuite(TestSelectAnEniqConnectionScript))
        test_suite.addTest(unittest.makeSuite(TestDeleteEniqConnectionScript))
        																	 
																			  
    else:
        pass

    return test_suite


runner = unittest.TextTestRunner(verbosity=2)
runner.run(pma_testing_suite())













#

