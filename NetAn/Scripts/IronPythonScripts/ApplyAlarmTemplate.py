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

#global reportName
#reportName = ''

alarm_name = "ALARM_NAME_VALUE"+(datetime.now()).strftime("%d%b%H%M")
specific_problem = alarm_name +"-" +"SPECIFIC_PROBLEM"
measurelist = ""
M_1 = 'MEASURE_1'
M_2 = 'MEASURE_2'
M_3 = 'MEASURE_3'
M_4 = 'MEASURE_4'
		
C_1 = 'COUNTER_1'
if    len(M_1)> 0:
    measurelist = measurelist + M_1
if    len(M_2) > 0:
    measurelist = measurelist + ";" + M_2 
if    len(M_3) > 0:
    measurelist = measurelist + ";" + M_3
if    len(M_4) > 0:
    measurelist = measurelist + ";" + M_4
if    len(C_1) > 0:
    measurelist = measurelist + ";" +C_1
    
    
params_for_node_details = [[
 {
   "Name": "SystemArea",
   "Type": "String",
   "Value": "SYS_AREA"
 },
 {
   "Name": "NodeType",
   "Type": "String",
   "Value": "NODE_TYPE"
}
]]


params_for_node_details2 = [[
 {
   "Name": "SingleOrCollection",
   "Type": "String",
   "Value": "SINGLE_COLLECTION"
 },
 
 {
   "Name": "SingleNodeValue",
   "Type": "String",
   "Value": "NODE_USED"
 }
]]

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

params_for_alarm_information = [[
 {
   "Name": "Aggregation",
   "Type": "String",
   "Value": "AGGREGATION_VALUE"
 },
 {
   "Name": "ProbableCause",
   "Type": "String",
   "Value": "PROBABLE_CAUSE"
 },
 {
   "Name": "SpecificProblem",
   "Type": "String",
   "Value": specific_problem
 },
 {
   "Name": "AlarmName",
   "Type": "String",
   "Value": alarm_name
 },
 {
   "Name": "AlarmType",
   "Type": "String",
   "Value": "ALARM_TYPE"
 },
 {
   "Name": "Severity",
   "Type": "String",
   "Value": "ALARM_SEVERITY"
 },
 {
   "Name": "DataRangeVal",
   "Type": "String",
   "Value": "DATE_RANGE_VALUE"
 },
 {
   "Name": "DataRangeUnit",
   "Type": "String",
   "Value": "DATE_RANGE_UNIT"
 },
 {
   "Name": "LookbackVal",
   "Type": "String",
   "Value": "LOOK_BACK_PERIOD_VALUE"
 },
 {
   "Name": "LookBackUnit",
   "Type": "String",
   "Value": "LOOK_BACK_PERIOD_UNIT"
 },
 {
   "Name": "SelectedMeasureList",
   "Type": "String",
   "Value": measurelist
 },
 {
   "Name": "ENIQDataSourcesDropDown",
   "Type": "String",
   "Value": "ENIQ_DATASOURCE"
 }
 
 ]
]

params_for_add_measures = [[
    {
   "Name": "MeasureType",
   "Type": "String",
   "Value": "MEASURE_TYPE"
 }]]

params_for_add_counter = [[
    {
   "Name": "MeasureType",
   "Type": "String",
   "Value": "MEASURETYPE2"
 }]]

params_for_delete_alarm = [[
 {
   "Name": "AlarmName",
   "Type": "String",
   "Value": alarm_name
 }
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


class TestFetchNodesScript(unittest.TestCase):
    def test_fetch_nodes(self):
        time.sleep(3)
        set_test_case_from_json(params_for_node_details)   
        run_fetch_nodes()


    def tearDown(self):
        clean_environment()

        
class TestNavToNodeDetailsSelScript(unittest.TestCase):
    def test_navTo_measureSel(self):
        time.sleep(5)
                                                                    
        set_test_case_from_json(params_for_node_details2)  
        


    def tearDown(self):
        clean_environment()        

class TestNavigateToSaveScript(unittest.TestCase):
    def test_navTo_save(self):
        set_test_case_from_json(params_for_node_details)   
        run_navTo_save()


    def tearDown(self):
        clean_environment()  
      

class TestViewReportScript(unittest.TestCase):
    def test_navTo_save(self):
        set_test_case_from_json(params_for_node_details)   
        run_view_report()


    def tearDown(self):
        clean_environment()  

NODE = ["NODE_USED"]


class TestAddMeasuresScript2(unittest.TestCase):
    def test_add_measures(self):
        Document.Properties["MeasureType"]= "Counter"
        tableName = "Measure Mapping"
        columnName = "Measure Type" 
        markingName = "Measures"
 
        setMarking(tableName, columnName, markingName, dataToMark = M_1)
        setMarking(tableName, columnName, markingName, dataToMark = M_2)
        setMarking(tableName, columnName, markingName, dataToMark = M_3)
        setMarking(tableName, columnName, markingName, dataToMark = M_4)
        run_add_measures()


    def tearDown(self):
        clean_environment()
		  		

class TestAddMeasuresScript(unittest.TestCase):
    def test_add_measures(self):
        set_test_case_from_json(params_for_add_measures)
        tableName = "Measure Mapping"
        filterName = "AlarmRulesManagerFS"
        columnName = "Measure" 
        #variable
        if   len(M_1)>0:
            filterValues = [M_1]
            setListBoxFilter(tableName, columnName, filterName,  filterValues)
            run_add_measures()
            
        if   len(M_2)>0:
            filterValues = [M_2]
            setListBoxFilter(tableName, columnName, filterName,  filterValues)
            run_add_measures()
        
        if   len(M_3)>0:   
            filterValues = [M_3]
            setListBoxFilter(tableName, columnName, filterName,  filterValues)
            run_add_measures()
            
        if   len(M_4)>0:
            filterValues = [M_4]
            setListBoxFilter(tableName, columnName, filterName,  filterValues)
            run_add_measures()


    def tearDown(self):
        clean_environment()        

class TestAddCounterScript(unittest.TestCase):
    def test_add_measures(self):
        time.sleep(20)           					   
        set_test_case_from_json(params_for_add_counter)
        tableName = "Measure Mapping"
        filterName = "AlarmRulesManagerFS"
        columnName = "Measure" 
        #variable
        if   len(C_1)>0:
            filterValues = [C_1]
            setListBoxFilter(tableName, columnName, filterName,  filterValues)
            run_add_measures()
           
    def tearDown(self):
        clean_environment() 

class TestSelectNodesScript(unittest.TestCase):
    def test_select_nodes(self):
        #constant
        tableName = 'NodeList'
        filterName = "AlarmRulesManagerFS"
        columnName = "node"     
        #variable
        filterValues = NODE
        #setListBoxFilter(tableName, "SearchedNode", filterName,  filterValues)
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
        


class TestAlarmRulesManagerClickScript(unittest.TestCase):    
    def test_report_manager_click(self):  
        run_alarm_rules_manager_click()
        

    def tearDown(self):
        clean_environment()

class TestNetanConnectionScript(unittest.TestCase):
    def test_netan_connection(self):
        set_test_case_from_json(params_for_netan_connection)   
        run_netan_connection()


    def tearDown(self):
        clean_environment()

class TestCreateClickScript(unittest.TestCase):    
    def test_create_button_click(self):  
        run_create_button_click()
        

    def tearDown(self):
        clean_environment()        


class TestSelectAlarmInfoScript(unittest.TestCase):    
    def test_create_button_click(self): 
        set_test_case_from_json(params_for_alarm_information)
        fileloc = os.path.join("PROJ_LOC" ,"AlarmNameInput.txt")
        f = open(fileloc, 'w')
        f.truncate(0) 
        print("alrmnameInput")
        print(alarm_name)
        f.write(alarm_name)
        f.close	 																																				     
        run_validateAggregation_script()
        

    def tearDown(self):
        clean_environment()    

class TestApplyAlarmTemplateScript(unittest.TestCase):    
    def test_apply_alarm_template_click(self): 
        run_apply_alarm_template_button_click()
        time.sleep(30)					  
        run_read_alarmName()					
        

    def tearDown(self):
        clean_environment()
 
class TestDeleteScript(unittest.TestCase):    
    def test_delete_click(self):
        delete_alarm = 'DELETE_ALARM' 
        if    delete_alarm=='yes':
            set_test_case_from_json(params_for_delete_alarm)
            run_deactivate_button_click()							 
            run_delete_button_click()   

    def tearDown(self):
        clean_environment()
        
class TestReadValuesOfFetchDataScript(unittest.TestCase):    
    def test_select_row(self):
        time.sleep(50)  
        #run_read_values()
        run_select_columns_fetchData()							  
        time.sleep(10)        


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


def run_pm_info():
    """ Calls the FetchPMInformation script. Will run an use whatever doc props/measures selected using test files. """

    scriptDef = clr.Reference[ScriptDefinition]()
    Document.ScriptManager.TryGetScript("FetchPMInformation", scriptDef)
    paramDict = {} 

    params = Dictionary[str, object](paramDict)
    Document.ScriptManager.ExecuteScript(scriptDef.Value, params)



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
    paramDict = {} 

    params = Dictionary[str, object](paramDict)
    Document.ScriptManager.ExecuteScript(scriptDef.Value, params)

        
def run_navTo_nodeDetailsSel():
    """ Calls the Navigate to measure selection script. """

    scriptDef = clr.Reference[ScriptDefinition]()
    Document.ScriptManager.TryGetScript("ClearAlarmRulesEditor", scriptDef)
    paramDict = {} 

    params = Dictionary[str, object](paramDict)
    Document.ScriptManager.ExecuteScript(scriptDef.Value, params)    


def run_navTo_save():
    """ Calls the Navigate to measure selection script. """

    scriptDef = clr.Reference[ScriptDefinition]()
    Document.ScriptManager.TryGetScript("NavigateToSaveReport", scriptDef)
    paramDict = {} 

    params = Dictionary[str, object](paramDict)
    Document.ScriptManager.ExecuteScript(scriptDef.Value, params)

def run_save_report():
    """ Calls the Navigate to measure selection script. """

    scriptDef = clr.Reference[ScriptDefinition]()
    Document.ScriptManager.TryGetScript("ValidateReportName", scriptDef)
    paramDict = {} 

    params = Dictionary[str, object](paramDict)
    Document.ScriptManager.ExecuteScript(scriptDef.Value, params)
    
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

def run_create_button_click():
    """ Calls the sync with eniq script. """

    scriptDef = clr.Reference[ScriptDefinition]()
    Document.ScriptManager.TryGetScript("ClearAlarmRulesEditor", scriptDef)
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

						 
def run_read_alarmName():
    global alarmTitle
    alarmTitle = Document.Properties["AlarmName"]
    print("alarmTitle:")
    print(alarmTitle)
    fileloc = os.path.join("PROJ_LOC" ,"AlarmTitle.txt")
    f = open(fileloc, 'w')
    f.truncate(0) 
    time.sleep(2)    
    f.write(alarmTitle)
    time.sleep(2)    
    f.close	  		   

def run_select_columns_fetchData():
    fileloc = os.path.join("PROJ_LOC" ,"ColumnDetailsFromFetchData.txt")
    f = open(fileloc, 'w')
    f.truncate(0)
    table=Document.Data.Tables[alarmTitle] 
    for eColumn in table.Columns:
                colValue="\tColumn: " + eColumn.Name 
                print "\tColumn: " + eColumn.Name 
                f.write(colValue)
    f.close	        
	
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


def run_apply_alarm_template_button_click():
    """ Calls the Navigate to measure selection script. """
    
    scriptDef = clr.Reference[ScriptDefinition]()
    Document.ScriptManager.TryGetScript("ValidateInputs", scriptDef)
    paramDict = {} 

    params = Dictionary[str, object](paramDict)
    Document.ScriptManager.ExecuteScript(scriptDef.Value, params)
    
def run_validateAggregation_script() :
    scriptDef = clr.Reference[ScriptDefinition]()
    Document.ScriptManager.TryGetScript("ValidateAggregation", scriptDef)
    paramDict = {} 

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

    if testing_level == 'Full':
        test_suite.addTest(unittest.makeSuite(TestERBSCounters))
        test_suite.addTest(unittest.makeSuite(TestNRKpis))
    elif testing_level == 'Quick':
        test_suite.addTest(unittest.makeSuite(TestNetanConnectionScript))
        test_suite.addTest(unittest.makeSuite(TestEniqConnectionScript))
        test_suite.addTest(unittest.makeSuite(TestSyncWithEniqScript))
        test_suite.addTest(unittest.makeSuite(TestAlarmRulesManagerClickScript))
        test_suite.addTest(unittest.makeSuite(TestCreateClickScript))
        test_suite.addTest(unittest.makeSuite(TestNavToNodeDetailsSelScript))
        test_suite.addTest(unittest.makeSuite(TestFetchNodesScript))
        test_suite.addTest(unittest.makeSuite(TestSelectNodesScript))
        test_suite.addTest(unittest.makeSuite(TestAddMeasuresScript))
        test_suite.addTest(unittest.makeSuite(TestAddCounterScript))        
        test_suite.addTest(unittest.makeSuite(TestSelectAlarmInfoScript))
        test_suite.addTest(unittest.makeSuite(TestApplyAlarmTemplateScript))
        time.sleep(30)
        test_suite.addTest(unittest.makeSuite(TestReadValuesOfFetchDataScript))
	    #test_suite.addTest(unittest.makeSuite(TestDeleteScript))
																 
    else:
        pass

    return test_suite


runner = unittest.TextTestRunner(verbosity=2)
runner.run(pma_testing_suite())



#


