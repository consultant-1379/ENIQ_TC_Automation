import unittest
from System.Collections.Generic import Dictionary
import clr
from System import Array
import time

from Spotfire.Dxp.Application.Scripting import ScriptDefinition
from Spotfire.Dxp.Framework.Library import *
from Spotfire.Dxp.Data.Import import SbdfLibraryDataSource
from Spotfire.Dxp.Data import *
from Spotfire.Dxp.Application.Filters import *
from Spotfire.Dxp.Application.Visuals import VisualContent
from System import Guid


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

params_for_fetch_value = [[
 {
   "Name": "CollectionName",
   "Type": "String",
   "Value": "Collection_Name"
 },
 {
   "Name": "SystemArea",
   "Type": "String",
   "Value": "SYS_AREA"
 },
 {
   "Name": "ENIQDB",
   "Type": "String",
   "Value": "ENIQ_DB"
 },
 {
   "Name": "NodeType",
   "Type": "String",
   "Value": "NODE_TYPE"
 }]

]

params_for_eniq_connection = [[
 {
   "Name": "ENIQDB",
   "Type": "String",
   "Value": "NetAn_ODBC"
 }]
]



params_for_fetch_pm_information = [[
]]




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


        





class TestNetanConnectionScript(unittest.TestCase):
    def test_netan_connection(self):
        set_test_case_from_json(params_for_netan_connection)   
        run_netan_connection()


    # def tearDown(self):
    #     clean_environment()

class TestEniqConnectionScript(unittest.TestCase):
    time.sleep(5)    
    def test_eniq_connection(self):
        set_test_case_from_json(params_for_eniq_connection)
        run_netan2_connection()

    # def tearDown(self):
    #     clean_environment()
                   

class TestSyncWithEniqScript(unittest.TestCase):    
    def test_sync_with_eniq(self):  
        run_sync_with_eniq()
        

    def tearDown(self):
        clean_environment()

class ImportNodeFromFileScript(unittest.TestCase):    
    def test_import_node_from_file(self):
        set_test_case_from_json(params_for_fetch_value)
        run_import_node_from_file()
        

    def tearDown(self):
        clean_environment()
        
class TestCollectionManagerClickScript(unittest.TestCase):    
    def test_collection_manager_click(self):
        set_test_case_from_json(params_for_fetch_value)  
        run_collection_manager_click()
        

    def tearDown(self):
        clean_environment()


class TestLoadValueScript(unittest.TestCase):    
    def test_load_value(self):
        set_test_case_from_json(params_for_fetch_value) 
        run_load_value()
        

    def tearDown(self):
        clean_environment()



# =====================
# Supporting functions
# =====================



def set_test_case_from_json(params):
    for each_param in params:
        for config in each_param:
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
    Document.ScriptManager.TryGetScript("NetAnConnection", scriptDef)
    paramDict = {} 

    params = Dictionary[str, object](paramDict)
    Document.ScriptManager.ExecuteScript(scriptDef.Value, params)

def run_netan2_connection():
    """ Calls the Netan connection script. """

    scriptDef = clr.Reference[ScriptDefinition]()
    Document.ScriptManager.TryGetScript("TestConnection", scriptDef)
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

def run_import_node_from_file():
    """ Calls the sync with eniq script. """

    scriptDef = clr.Reference[ScriptDefinition]()
    Document.ScriptManager.TryGetScript("GetDataFromFile", scriptDef)
    paramDict = {} 

    params = Dictionary[str, object](paramDict)
    Document.ScriptManager.ExecuteScript(scriptDef.Value, params)

def run_collection_manager_click():
    """ Calls the sync with eniq script. """

active_page=Document.ActivePageReference.Id
Document.Properties["sourcePage"]=active_page.ToString()

for page in Document.Pages:
   if (page.Title == "Collection Manager"):
      Document.ActivePageReference=page

def run_load_value():
    """ Calls the Navigate to measure selection script. """

    scriptDef = clr.Reference[ScriptDefinition]()
    Document.ScriptManager.TryGetScript("NavToMeasureSel", scriptDef)
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


 
def pmex_testing_suite():
    """Gather all the tests from this module in a test suite."""
    test_suite = unittest.TestSuite()

    # TODO: testing level value could be imported as a config file to say what tests we want to run for different scenarios
    testing_level = 'Quick'

    if testing_level == 'Full':
        test_suite.addTest(unittest.makeSuite(TestERBSCounters))
        test_suite.addTest(unittest.makeSuite(TestNRKpis))
    elif testing_level == 'Quick':
        #test_suite.addTest(unittest.makeSuite(TestNetanConnectionScript))
        #test_suite.addTest(unittest.makeSuite(TestEniqConnectionScript))
        # test_suite.addTest(unittest.makeSuite(TestSyncWithEniqScript))
        #test_suite.addTest(unittest.makeSuite(TestCollectionManagerClickScript))
        test_suite.addTest(unittest.makeSuite(ImportNodeFromFileScript))
 
    else:
        pass

    return test_suite


runner = unittest.TextTestRunner(verbosity=2)
runner.run(pmex_testing_suite())













#


