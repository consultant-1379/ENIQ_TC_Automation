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
import Spotfire.Dxp.Application.Filters as filters


TEST_FILES_PATH = """/Custom Library/ebkumki/PMEX_TEST/"""
MEASURES_TABLE = "Measure Mapping(Selected)"
PROPS_TABLE = "props_test_scenario"

# =====================
# Test case defintions
# =====================

				  
				

collection_name = "COLLECTION_NAME"+(datetime.now()).strftime("%d%b%H%M")
	 
				 
				 
				 
				 
				  
								   
				   
										  
				   
										 
				   
										 
	
params_for_node_details = [[
 {
   "Name": "CollectionName",
   "Type": "String",
   "Value": collection_name
 },
 {
   "Name": "SystemArea",
   "Type": "String",
   "Value": "SYS_AREA"
},
 {
   "Name": "NodeType",
   "Type": "String",
   "Value": "NODE_TYPE"
},
{
   "Name": "ENIQDB",
   "Type": "String",
   "Value": "NetAn_ODBC"
}

]]


params_for_node_details2 = [[
 {
   "Name": "SingleOrCollection",
   "Type": "String",
   "Value": "SINGLEORCOLLECTION"
 },
 
 {
   "Name": "NECollection",
   "Type": "String",
   "Value": collection_name
 }
]

]



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


class TestFetchNodesScript(unittest.TestCase):
    def test_fetch_nodes(self):
        time.sleep(3)
        set_test_case_from_json(params_for_node_details)   
        run_fetch_nodes()


    def tearDown(self):
        clean_environment()

        
class TestNodeDetailsSelScript(unittest.TestCase):
    def test_navTo_nodeSel(self):
        #time.sleep(5)                                                            
        set_test_case_from_json(params_for_node_details)  
        time.sleep(3)
        global coltnTitle
        coltnTitle = Document.Properties["CollectionName"]
        print("coltnTitle:")
        print(coltnTitle)
        fileloc = os.path.join("PROJ_LOC" ,"CollectionNameInput.txt")
        f = open(fileloc, 'w')
        time.sleep(3)					 
        f.truncate(0)
        time.sleep(7)
        f.write(coltnTitle)
        time.sleep(7)
     
    def tearDown(self):			   
        clean_environment()           
	  


NODE = ["NODE_USED"]


class TestAddNodesScript(unittest.TestCase):
    def test_add_measures(self):
														
        run_add_measures()

    def tearDown(self):
        clean_environment()        


class TestSelectNodesScript(unittest.TestCase):
    def test_select_nodes(self):
        #constant
        tableName = 'NodeList'
        filterName = "Filtering scheme"
        columnName = "node"     
        #variable
        filterValues = NODE
        setListBoxFilter(tableName, columnName, filterName,  filterValues)
	
    def tearDown(self):
        clean_environment()

class TestEniqConnectionScript(unittest.TestCase):
    time.sleep(2)    
    def test_eniq_connection(self):
        set_test_case_from_json(params_for_eniq_connection)
        run_eniq_connection()

    def tearDown(self):
        clean_environment()
                   

class TestSyncWithEniqScript(unittest.TestCase):    
    def test_sync_with_eniq(self):  
        run_sync_with_eniq()
 

    def tearDown(self):
        clean_environment()
        


class TestCollectionManagerClickScript(unittest.TestCase):    
    def test_node_collection_manager_click(self):  
        run_collection_manager_click()
        
    def tearDown(self):
        clean_environment()


class TestNetanConnectionScript(unittest.TestCase):
    def test_netan_connection(self):
        set_test_case_from_json(params_for_netan_connection)   
        run_netan_connection()


    def tearDown(self):
        clean_environment()

class TestCollectionSelectNodesScript(unittest.TestCase):
    def test_select_nodes(self):
        #constant
        tableName = 'NodeList'
        filterName = "Filtering scheme"
        columnName = "node"     
        #variable
        filterValues = ["NODE_1","NODE_2"]
        #setListBoxFilter(tableName, "SearchedNode", filterName,  filterValues)
        setListBoxFilter(tableName, columnName, filterName,  filterValues)
    def tearDown(self):
        clean_environment()

class TestCreateClickScript(unittest.TestCase):    
    def test_create_button_click(self):  
        run_create_button_click()
        

    def tearDown(self):
        clean_environment()        

class TestCollectionCreateClickScript(unittest.TestCase):    
    def test_create_button_click(self):  
        run_node_create_button_click()
        

    def tearDown(self):
        clean_environment()        
 


class TestNavToNodeDetailsSelScript(unittest.TestCase):
    def test_navTo_measureSel(self):
        time.sleep(5)                                                            
        set_test_case_from_json(params_for_node_details2)  
        

    def tearDown(self):
        clean_environment() 

class TestGetNodeCollectionListScript(unittest.TestCase):
    def test_get_collectionList(self):
        time.sleep(5)                                                            
        run_get_collectionList()  
        

    def tearDown(self):
        clean_environment()

class TestSaveButtonClickScript(unittest.TestCase):
    def test_save_buttonclick(self):
        time.sleep(5)                                                            
        run_save_button_click()  
        

    def tearDown(self):
        clean_environment()


class TestDeleteCollectionScript(unittest.TestCase):
    def test_delete_Collection(self):                                                           
        run_delete_collection() 
						
        

    def tearDown(self):
        clean_environment()
 
class TestSelectCollectionScript(unittest.TestCase):
    def test_select_Collection(self):                                                           
        run_select_collection() 
        

    def tearDown(self):
        clean_environment()
	
class TestEditCollectionScript(unittest.TestCase):
    def test_select_Collection(self):                                                           
        run_edit_collection() 
        
    def tearDown(self):
        clean_environment()	

class TestSaveCollectionScript(unittest.TestCase):
    def test_select_Collection(self):                                                           
        run_save_collection() 
        
    def tearDown(self):
        clean_environment()			


class TestGetNodeListScript(unittest.TestCase):
    def test_select_Collection(self):                                                           
        run_getNodes_collection() 
        
    def tearDown(self):
        clean_environment()	

class TestCollectionSelectMoreNodesScript(unittest.TestCase):
    def test_select_nodes(self):
        #constant
        tableName = 'NodeList'
        filterName = "Filtering scheme"
        columnName = "node"     
        #variable
        filterValues = ["NODE_EDIT"]
        #setListBoxFilter(tableName, "SearchedNode", filterName,  filterValues)
        setListBoxFilter(tableName, columnName, filterName,  filterValues)
					   
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


def run_fetch_nodes():
	
					  
    """ Calls the Fetchnodes script. Will run an use whatever doc props/measures selected using test files. """

    scriptDef = clr.Reference[ScriptDefinition]()
    Document.ScriptManager.TryGetScript("FetchNodes", scriptDef)
    paramDict = {} 

    params = Dictionary[str, object](paramDict)
    Document.ScriptManager.ExecuteScript(scriptDef.Value, params)


def run_add_measures():
    """ Calls the Fetchnodes script. Will run an use whatever doc props/measures selected using test files. """

    scriptDef = clr.Reference[ScriptDefinition]()
    Document.ScriptManager.TryGetScript("AddMeasures", scriptDef)
    params = Dictionary[str, object]()
    for vis in Application.Document.ActivePageReference.Visuals:
            if  vis.Title == "Generate Panel":  
                
                visualization = vis                
                print("if")                                                              
                break

    params['vis']= visualization
    Document.ScriptManager.ExecuteScript(scriptDef.Value, params)
        
def run_navTo_nodeDetailsSel():
    """ Calls the Navigate to measure selection script. """

    scriptDef = clr.Reference[ScriptDefinition]()
    Document.ScriptManager.TryGetScript("ClearAlarmRulesEditor", scriptDef)
    paramDict = {} 

    params = Dictionary[str, object](paramDict)
    Document.ScriptManager.ExecuteScript(scriptDef.Value, params)    


    
def run_netan_connection():
    """ Calls the Netan connection script. """

    scriptDef = clr.Reference[ScriptDefinition]()
    Document.ScriptManager.TryGetScript("NetAnConnection", scriptDef)
    paramDict = {} 

    params = Dictionary[str, object](paramDict)
    Document.ScriptManager.ExecuteScript(scriptDef.Value, params)


def run_eniq_connection():
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

def run_create_button_click():
    """ Calls the sync with eniq script. """

    scriptDef = clr.Reference[ScriptDefinition]()
    Document.ScriptManager.TryGetScript("ClearAlarmRulesEditor", scriptDef)
    paramDict = {} 

    params = Dictionary[str, object](paramDict)
    Document.ScriptManager.ExecuteScript(scriptDef.Value, params)


def run_node_create_button_click():
    """ Calls the sync with eniq script. """

    scriptDef = clr.Reference[ScriptDefinition]()
    Document.ScriptManager.TryGetScript("HideModify", scriptDef)
    paramDict = {} 

    params = Dictionary[str, object](paramDict)
    Document.ScriptManager.ExecuteScript(scriptDef.Value, params)


def run_save_button_click():
    """ Calls the sync with eniq script. """

    scriptDef = clr.Reference[ScriptDefinition]()
    Document.ScriptManager.TryGetScript("AddSelectedNodes", scriptDef)
    paramDict = {} 

    params = Dictionary[str, object](paramDict)
    Document.ScriptManager.ExecuteScript(scriptDef.Value, params)

def run_collection_manager_click():
    
    active_page=Document.ActivePageReference.Id
    Document.Properties["sourcePage"]=active_page.ToString()

    for page in Document.Pages:
        if (page.Title == "Collection Manager"):
            Document.ActivePageReference=page

						   
							   
def run_select_collection(): 
    table=Document.Data.Tables['NodeCollection']
    cursor = DataValueCursor.CreateFormatted(table.Columns["CollectionName"])
    coltnName =coltnTitle
    #coltnName = "StaticCollection22Aug1115"
    for row in table.GetRows(cursor):
            value = cursor.CurrentValue
            if value == coltnName:
                print("if")
                rowIndexOfReport = row.Index
                time.sleep(5)
                break
    setMarking('NodeCollection', 'CollectionName', 'Marking', dataToMark = coltnName)
    rowCount = table.RowCount   
    rowsToMark = IndexSet(rowCount,False)
    rowsToMark.AddIndex(rowIndexOfReport)
    Document.ActiveMarkingSelectionReference.SetSelection(RowSelection(rowsToMark),table)

	
def run_eniqdb_connection():
    """ Calls the sync with eniq script. """

    scriptDef = clr.Reference[ScriptDefinition]()
    Document.ScriptManager.TryGetScript("TestConnection", scriptDef)
    paramDict = {}

    params = Dictionary[str, object](paramDict)
    Document.ScriptManager.ExecuteScript(scriptDef.Value, params)


def run_delete_collection():
    table=Document.Data.Tables['NodeCollection']
			 
												
    cursor = DataValueCursor.CreateFormatted(table.Columns["CollectionName"])
    coltnName =coltnTitle
											
    for row in table.GetRows(cursor):
            value = cursor.CurrentValue
            if value == coltnTitle:
                rowIndexOfReport = row.Index
                time.sleep(5)
                break
    setMarking('NodeCollection', 'CollectionName', 'Marking', dataToMark = coltnName)
    rowCount = table.RowCount   
    rowsToMark = IndexSet(rowCount,False)
    rowsToMark.AddIndex(rowIndexOfReport)
    Document.ActiveMarkingSelectionReference.SetSelection(RowSelection(rowsToMark),table)
	
							
    scriptDef = clr.Reference[ScriptDefinition]()
    Document.ScriptManager.TryGetScript("DeleteCollection", scriptDef)
    paramDict = {}

    params = Dictionary[str, object](paramDict)
    Document.ScriptManager.ExecuteScript(scriptDef.Value, params)
    	
																		  
def run_getNodes_collection():
    table=Document.Data.Tables['NodeCollection']
    cursor = DataValueCursor.CreateFormatted(table.Columns["NodeNameORExpression"])
    cursor1 = DataValueCursor.CreateFormatted(table.Columns["CollectionName"])
    coltnName =coltnTitle
    fileloc = os.path.join("PROJ_LOC" ,"NodeList.txt")
    f1 = open(fileloc, 'w')
    f1.truncate(0)
    time.sleep(5)
    for row in table.GetRows(cursor1):
            value1 = cursor1.CurrentValue
            rowIndexOfReport = row.Index
            if value1 == coltnName:
                 node = table.Columns["NodeNameORExpression"].RowValues.GetFormattedValue(rowIndexOfReport)
                 print(node)
                 time.sleep(5)
                 f1.write(node)
                 time.sleep(5)
                 break
			
			 
    f1.close					   

def run_get_collectionList():
    table=Document.Data.Tables['NodeCollection']
    cursor = DataValueCursor.CreateFormatted(table.Columns["CollectionName"])
    coltnName =coltnTitle
    fileloc = os.path.join("PROJ_LOC" ,"CollectionName.txt")
    f1 = open(fileloc, 'w')
    f1.truncate(0)
    time.sleep(5)
    for row in table.GetRows(cursor):
            value = cursor.CurrentValue
            if value == coltnTitle:
                rowIndexOfReport = row.Index
                time.sleep(5)
                f1.write(value)
                break
			 
    f1.close		
																 
 
        
def run_save_collection():
    """ Calls the Navigate to measure selection script. """
    
    scriptDef = clr.Reference[ScriptDefinition]()
    Document.ScriptManager.TryGetScript("ModifySelectedCollection", scriptDef)
    paramDict = {} 

    params = Dictionary[str, object](paramDict)
    Document.ScriptManager.ExecuteScript(scriptDef.Value, params) 
	
def run_edit_collection():
    """ Calls the Navigate to measure selection script. """
    
    scriptDef = clr.Reference[ScriptDefinition]()
    Document.ScriptManager.TryGetScript("HideCreate", scriptDef)
    paramDict = {} 
									   
	
    params = Dictionary[str, object](paramDict)
    Document.ScriptManager.ExecuteScript(scriptDef.Value, params) 
	
	

def pmex_testing_suite():
    """Gather all the tests from this module in a test suite."""
    test_suite = unittest.TestSuite()

    # TODO: testing level value could be imported as a config file to say what tests we want to run for different scenarios
    testing_level = 'Quick'

    if testing_level ==  'Quick':
        test_suite.addTest(unittest.makeSuite(TestNetanConnectionScript))
        test_suite.addTest(unittest.makeSuite(TestEniqConnectionScript))																
        test_suite.addTest(unittest.makeSuite(TestCollectionManagerClickScript))
        test_suite.addTest(unittest.makeSuite(TestCollectionCreateClickScript))
        test_suite.addTest(unittest.makeSuite(TestNodeDetailsSelScript))
        test_suite.addTest(unittest.makeSuite(TestFetchNodesScript))
        test_suite.addTest(unittest.makeSuite(TestCollectionSelectNodesScript))
        test_suite.addTest(unittest.makeSuite(TestAddNodesScript))                               																						 
        test_suite.addTest(unittest.makeSuite(TestSaveButtonClickScript))
        test_suite.addTest(unittest.makeSuite(TestSelectCollectionScript))
        test_suite.addTest(unittest.makeSuite(TestEditCollectionScript))
        test_suite.addTest(unittest.makeSuite(TestFetchNodesScript))
        test_suite.addTest(unittest.makeSuite(TestCollectionSelectMoreNodesScript))
        test_suite.addTest(unittest.makeSuite(TestAddNodesScript))
        test_suite.addTest(unittest.makeSuite(TestSaveCollectionScript))
        test_suite.addTest(unittest.makeSuite(TestSelectCollectionScript))
        test_suite.addTest(unittest.makeSuite(TestGetNodeListScript))													  
        test_suite.addTest(unittest.makeSuite(TestDeleteCollectionScript))											 
																		  
																							 
    else:
        pass

    return test_suite


runner = unittest.TextTestRunner(verbosity=2)
runner.run(pmex_testing_suite())









#


 