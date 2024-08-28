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

enm_url="ENM_CONNECTIONURL"

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

params_for_enm_connection = [[
 {
   "Name": "ENMUrl",
   "Type": "String",
   "Value": enm_url
 },
 {
   "Name": "ENMUsername",
   "Type": "String",
   "Value": "Administrator"
 },
 {
   "Name": "ENMPassword",
   "Type": "String",
   "Value": "TestPassw0rd"
 },
 {
   "Name": "ENMOssId",
   "Type": "String",
   "Value": "eniq_oss_1"
 },
 {
   "Name": "ENIQDataSourcesDropDown",
   "Type": "String",
   "Value": "NetAn_ODBC"
 }]

]

params_for_eniq_connection = [[
 {
   "Name": "ENIQDB",
   "Type": "String",
   "Value": "NetAn_ODBC"
 }]
]



class TestERBSCounters(unittest.TestCase):

    def setUp(self):
        create_table_from_library_file('erbs_counters', MEASURES_TABLE)

    def test_erbs_props_first_config(self):
        create_table_from_library_file('erbs_first_config', PROPS_TABLE)
        set_test_case_props()
        run_pm_info()

    def test_erbs_props_second_config(self):
        create_table_from_library_file('erbs_second_config', PROPS_TABLE)
        set_test_case_props()
        run_pm_info()

    def tearDown(self):
        clean_environment()


class TestNRKpis(unittest.TestCase):

    def setUp(self):
        create_table_from_library_file('nr_kpis', MEASURES_TABLE)

    def test_NR_props_first_config(self):
        create_table_from_library_file('nr_first_config', PROPS_TABLE)
        set_test_case_props()
        run_pm_info()

    def tearDown(self):
        clean_environment()

 
class TestENMConnectionScript(unittest.TestCase):
    time.sleep(7)    
    def test_enm_connection(self):
        set_test_case_from_json(params_for_enm_connection)
        run_enm_connection()

    def tearDown(self):
        clean_environment() 

class TestEniqConnectionScript(unittest.TestCase):
    time.sleep(2)    
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
		
class TestSelectAnConnecedEnmScript(unittest.TestCase):
    def test_select_enmconnection(self):
        set_test_case_from_json(params_for_enm_connection)   
        run_select_enmconnection()

    def tearDown(self):
        clean_environment()	


class TestGetENMConnectionsScript(unittest.TestCase):
    def test_getenm_connection(self):
        get_enm_connections()

    def tearDown(self):
        clean_environment()

class TestDeleteENMConnectionScript(unittest.TestCase):
    def test_delete_enmconnection(self):
        Document.Properties["EnmToDelete"] = "ieatenm5300-9.athtem.eei.ericsson.se"	
        print(Document.Properties["EnmToDelete"])
        run_delete_enmconnection()

    def tearDown(self):
        clean_environment()	
		

class TestAdminPageClickScript(unittest.TestCase):    
    def test_admin_page_click(self):  
        run_admin_page_click()
        time.sleep(5)
        
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
        print("Not able to set Marking: " +markingName )

 


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


def create_table_from_library_file(file_name, table_name):
    """ Create table from SBDF file stored in library. These are the test configs/props etc."""

    manager = Application.GetService[LibraryManager]()
    libraryPath = """{file_path}{file_name}""".format(file_path=TEST_FILES_PATH, file_name=file_name)
    (found, item) = manager.TryGetItem(libraryPath, LibraryItemType.SbdfDataFile, LibraryItemRetrievalOption.IncludePath)

    if found:
        ds = SbdfLibraryDataSource(item)

        if Document.Data.Tables.Contains(table_name):
            Document.Data.Tables[table_name].ReplaceData(ds)
        else:
            Document.Data.Tables.Add(table_name, ds)


def set_test_case_props():
    """ For each doc prop name in props table, set the corresponding doc prop"""
    doc_prop_table = Document.Data.Tables[PROPS_TABLE]
    doc_prop_cursor = create_cursor(doc_prop_table)

    for row in doc_prop_table.GetRows(Array[DataValueCursor](doc_prop_cursor.values())):
        doc_prop_name = doc_prop_cursor["Name"].CurrentValue
        doc_prop_type = doc_prop_cursor["Type"].CurrentValue #! Not sure if needed, as i guess some of these doc props are integer/string
        doc_prop_value = doc_prop_cursor["Value"].CurrentValue
       
        Document.Properties[doc_prop_name] = doc_prop_value

        # The collection/node info is not a doc prop and needs to be set



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

def run_enm_connection():
    """ Calls the Netan connection script. """

    scriptDef = clr.Reference[ScriptDefinition]()
    time.sleep(5)
    Document.ScriptManager.TryGetScript("TestENMConnection", scriptDef)
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

def run_sync_with_eniq():
    """ Calls the sync with eniq script. """

    scriptDef = clr.Reference[ScriptDefinition]()
    Document.ScriptManager.TryGetScript("MeasureMappingENIQ", scriptDef)
    paramDict = {} 

    params = Dictionary[str, object](paramDict)
    Document.ScriptManager.ExecuteScript(scriptDef.Value, params)
	
def run_TriggerDeleteCheck():
    """ Calls the sync with eniq script. """

    scriptDef = clr.Reference[ScriptDefinition]()
    Document.ScriptManager.TryGetScript("TriggerDeleteCheck", scriptDef)
    paramDict = {} 

    params = Dictionary[str, object](paramDict)
    Document.ScriptManager.ExecuteScript(scriptDef.Value, params)	

	
def run_select_enmconnection():	
    #time.sleep(50)																		
    table=Document.Data.Tables['EniqEnmMapping']
    
    #place generic data cursor on alarmName specific column
    cursor = DataValueCursor.CreateFormatted(table.Columns["EnmUrl"])
    enmName ="ieatenm5300-9.athtem.eei.ericsson.se"
    
    #iterate through table column rows to retrieve the values
    for row in table.GetRows(cursor):
            value = cursor.CurrentValue
            rowIndexOfReport = row.Index
            if value == enmName:
				rowIndexOfReport = row.Index
				break
	
    setMarking('EniqEnmMapping', 'EnmUrl', 'Marking', dataToMark = enmName)
    rowCount = table.RowCount
	
    rowsToMark = IndexSet(rowCount,False)
    rowsToMark.AddIndex(rowIndexOfReport)
    Document.ActiveMarkingSelectionReference.SetSelection(RowSelection(rowsToMark),table)																																					   		  			  
    
def get_enm_connections():
    #time.sleep(20)
    table=Document.Data.Tables['EniqEnmMapping']
    
    #place generic data cursor on alarmName specific column
    cursor = DataValueCursor.CreateFormatted(table.Columns["EnmUrl"])
    enmName =enm_url
    
    fileloc = os.path.join("PROJ_LOC" ,"DataSourceList.txt")
    f = open(fileloc, 'w')
    f.truncate(0)
    for row in table.GetRows(cursor):
            value = cursor.CurrentValue
            rowIndexOfReport = row.Index
            colValue=value + "\t" 
            print colValue			 
            f.write(colValue) 	
			
def run_delete_enmconnection():
    scriptDef = clr.Reference[ScriptDefinition]()
    Document.ScriptManager.TryGetScript("deleteENMFromDb", scriptDef)
    paramDict = {} 

    params = Dictionary[str, object](paramDict)
    Document.ScriptManager.ExecuteScript(scriptDef.Value, params)			
	
def pma_testing_suite():
    """Gather all the tests from this module in a test suite."""
    test_suite = unittest.TestSuite()

    # TODO: testing level value could be imported as a config file to say what tests we want to run for different scenarios
    testing_level = 'Quick'

    if testing_level == 'Full':
        test_suite.addTest(unittest.makeSuite(TestERBSCounters))
        test_suite.addTest(unittest.makeSuite(TestNRKpis))
    elif testing_level == 'Quick':
        test_suite.addTest(unittest.makeSuite(TestAdminPageClickScript))
        test_suite.addTest(unittest.makeSuite(TestNetanConnectionScript))
        test_suite.addTest(unittest.makeSuite(TestEniqConnectionScript))
        test_suite.addTest(unittest.makeSuite(TestENMConnectionScript))
        test_suite.addTest(unittest.makeSuite(TestSelectAnConnecedEnmScript))
        #test_suite.addTest(unittest.makeSuite(TestNetanConnectionScript))
        test_suite.addTest(unittest.makeSuite(TestDeleteENMConnectionScript))
        test_suite.addTest(unittest.makeSuite(TestGetENMConnectionsScript))			
    else:
        pass

    return test_suite


runner = unittest.TextTestRunner(verbosity=2)
runner.run(pma_testing_suite())













#

