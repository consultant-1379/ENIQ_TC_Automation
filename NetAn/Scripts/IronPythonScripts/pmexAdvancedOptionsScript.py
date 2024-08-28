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
interval_name = "INTERVAL2"
#interval_name = "INTERVAL"+(datetime.now()).strftime("%d%b%H%M")                           

# =====================
# Test case defintions
# =====================

report_desc = "REPORT_DESCRIPTION"+(datetime.now()).strftime("%d%b%H%M")
params_for_fetch_nodes = [[
 {
   "Name": "NodeTypeTopology",
   "Type": "String",
   "Value": "NODE_TYPE"
 },
 {
   "Name": "SystemAreaTopology",
   "Type": "String",
   "Value": "SYS_AREA"
 },
 {
   "Name": "ENIQDB",
   "Type": "String",
   "Value": "NetAn_ODBC"
 },
 {
   "Name": "NodeOrCollection",
   "Type": "String",
   "Value": "NODE_COLLECTION"
 },
 {
   "Name": "ObjectAggregation",
   "Type": "String",
   "Value": "OBJECT_AGGREGATION"
 },
 { 
   "Name": "MeasureSearch",
   "Type": "String",
   "Value": "KPI_USED"
     }]

]


params_for_save_report_library = [[
 {
   "Name": "ReportName",
   "Type": "String",
   #"Value": "Test2022Feb"
   "Value": "test"+(datetime.now()).strftime("%d%b%H%M")
 },
 {
   "Name": "ReportAccessType",
   "Type": "String",
   "Value": "REPORT_ACCESSTYPE"
 },
 {
   "Name": "ReportDescription",
   "Type": "String",
   "Value": report_desc
 }]

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
   "Value": "ENIQ_DATASOURCE"
 }]
]



params_for_fetch_pm_information = [[
]]


params_for_time_selection = [[
 {
   "Name": "precedingPeriods",
   "Type": "Integer",
   "Value": "PRECEDINGPERIODS"
 },
 {
   "Name": "precedingPeriodsUnits",
   "Type": "String",
   "Value": "PRECEDING_PERIODS_UNITS"
 },
 {
   "Name": "AggregationSelection",
   "Type": "String",
   "Value": "AGGREGATION_SELECTION"
 },
 {
   "Name": "timeSelector",
   "Type": "String",
   "Value": "TIME_SELECTOR"
},
 {
   "Name": "startDate",
   "Type": "String",
   "Value": "START_DATE"
},
 {
   "Name": "startTime",
   "Type": "String",
   "Value": "START_TIME"
},
 {
   "Name": "endDate",
   "Type": "String",
   "Value": "END_DATE"
},
 {
   "Name": "endTime",
   "Type": "String",
   "Value": "END_TIME"
},
{
   "Name": "IntervalName",
   "Type": "String",
   "Value": interval_name
}]
]

params_for_time_selection2 = [[
 
 {
   "Name": "timeSelector",
   "Type": "String",
   "Value": "TIMESELECTOR2"
}
 ]
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


class TestFetchNodesScript(unittest.TestCase):
    def test_fetch_nodes(self):
        set_test_case_from_json(params_for_fetch_nodes)   
        run_fetch_nodes()


    def tearDown(self):
        clean_environment()


                
class TestNavToMeasureSelScript(unittest.TestCase):
    def test_navTo_measureSel(self):
        set_test_case_from_json(params_for_fetch_nodes)   
        run_navTo_measureSel()


    def tearDown(self):
        clean_environment()        

class TestNavigateToSaveScript(unittest.TestCase):
    def test_navTo_save(self):
        time.sleep(30)              
        set_test_case_from_json(params_for_fetch_nodes)   
        run_navTo_save()
        time.sleep(10)              


    def tearDown(self):
        clean_environment()        


class TestSaveReportToLibraryScript(unittest.TestCase):
    def test_save_report(self):
        set_test_case_from_json(params_for_save_report_library)   
        #fileloc = os.path.join("PROJ_LOC" ,"title.txt")
        #f1 = open(fileloc, 'w')
        #f1.truncate(0)                                                                                                                                          
        global reportName
        reportName=Document.Properties["ReportName"]                                                               
        print("title")  
        print(reportName)   
        #time.sleep(30)
        #f1.write(reportName)
        #time.sleep(10)
        #f1.close                                
        global reportDesc
        reportDesc=Document.Properties["ReportDescription"]                                                                    
        run_save_report()


    def tearDown(self):
        clean_environment()


KPI = ['KPI_USED']



class TestRemoveMeasuresScript(unittest.TestCase):
    def test_add_measures(self):
        tableName = "Measure Mapping (Selected)"
        columnName = "Measure"
        markingName = "MeasuresSelected"
        setMarking(tableName, columnName, markingName, dataToMark = KPI)
        run_remove_measures()


    def tearDown(self):
        clean_environment()
        
class TestAddMeasuresScript(unittest.TestCase):
    def test_add_measures(self):
        tableName = 'NodeListMeasure'
        filterName = "MeasureManagerNodeFetch"
        columnName = "node"     
        #variable
        filterValues = ["NODE_USED"]
        setListBoxFilter(tableName, "SearchedNode", filterName,  filterValues)
        setListBoxFilter(tableName, columnName, filterName,  filterValues)
        
        tableName = "Measure Mapping"
        columnName = "Measure"
        markingName = "Measures"
        setMarking(tableName, columnName, markingName, dataToMark = KPI)
        run_add_measures()


    def tearDown(self):
        clean_environment()

class TestFetchPMInformationScript(unittest.TestCase):
    def test_fetch_pm_information(self):
        #constant
        
        run_pm_info()
        time.sleep(50)
    def tearDown(self):
        clean_environment()

class TestEniqConnectionScript(unittest.TestCase):
    time.sleep(5)    
    def test_eniq_connection(self):
        set_test_case_from_json(params_for_eniq_connection)
        run_netan2_connection()

    def tearDown(self):
        clean_environment()
                   

class TestSyncWithEniqScript(unittest.TestCase):    
    def test_sync_with_eniq(self):  
        run_sync_with_eniq()
        

    def tearDown(self):
        clean_environment()
        


class TestReportManagerClickScript(unittest.TestCase):    
    def test_report_manager_click(self):  
        run_report_manager_click()
        

    def tearDown(self):
        clean_environment()


class TestNetanConnectionScript(unittest.TestCase):
    def test_netan_connection(self):
        set_test_case_from_json(params_for_netan_connection)   
        run_netan_connection()


    def tearDown(self):
        clean_environment()
        
class TestSelectRowOfReportScript(unittest.TestCase):    
    def test_select_row(self):  
        run_select_row()
        time.sleep(30)
        

    def tearDown(self):
        clean_environment()                                                                         
   
class TestNavToTimeSelScript(unittest.TestCase):
    def test_time_selection(self):
    
        set_test_case_from_json(params_for_time_selection) 
        days = [WEEK_DAYS] 
        FilterSelection = Document.Data.Filterings["Filtering scheme"]
        daysOfWeek = Document.FilteringSchemes[FilterSelection][Document.Data.Tables["DayOFWeek"]]["Day"].As[filters.CheckBoxFilter]()
        for dayCheckBox in daysOfWeek.Values:
                if days.Contains(dayCheckBox):
                        daysOfWeek.Uncheck(dayCheckBox)
                        daysOfWeek.Check(dayCheckBox)
                
                else :
                        daysOfWeek.Uncheck(dayCheckBox)                    
        
    def tearDown(self):
        clean_environment()        

class TestSelectMeasureTypeScript(unittest.TestCase):
    def test_select_measures(self):
        
        #filterValues = ["Counter","RI"]
        values = ["MEASURE_TYPE"]        
        FilterSelection = Document.Data.Filterings["Filtering scheme"]
        measureType = Document.FilteringSchemes[FilterSelection][Document.Data.Tables["Measure Mapping"]]["Measure Type – Sub Category"].As[filters.CheckBoxFilter]()
        for CheckBoxValue in measureType.Values:
                #if CheckBoxValue == "Counter":
                if values.Contains(CheckBoxValue):                                                      
                        measureType.Uncheck(CheckBoxValue)
                        measureType.Check(CheckBoxValue)
                #elif CheckBoxValue == "Ericsson KPI":    
                       # measureType.Uncheck(CheckBoxValue)
                        #measureType.Check(CheckBoxValue)
                else :
                        measureType.Uncheck(CheckBoxValue)
                     
    def tearDown(self):
        clean_environment() 


class TestSelectReportWithReportNameScript(unittest.TestCase):    
    def test_select_row(self):  
        run_select_reportname()
        

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
    Document.ScriptManager.TryGetScript("FetchNodesMeasure", scriptDef)
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
    
def run_add_interval():
    scriptDef = clr.Reference[ScriptDefinition]()
    Document.ScriptManager.TryGetScript("AddToIntervalDefinitionsTable", scriptDef)
    paramDict = {} 

    params = Dictionary[str, object](paramDict)
    Document.ScriptManager.ExecuteScript(scriptDef.Value, params) 
 
def run_remove_measures():
    """ Calls the Fetchnodes script. Will run an use whatever doc props/measures selected using test files. """

    scriptDef = clr.Reference[ScriptDefinition]()
    Document.ScriptManager.TryGetScript("RemoveMeasures", scriptDef)
    paramDict = {} 

    params = Dictionary[str, object](paramDict)
    Document.ScriptManager.ExecuteScript(scriptDef.Value, params)
       
def run_navTo_measureSel():
    """ Calls the Navigate to measure selection script. """

    scriptDef = clr.Reference[ScriptDefinition]()
    Document.ScriptManager.TryGetScript("NavToMeasureSel", scriptDef)
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

def run_report_manager_click():
    """ Calls the sync with eniq script. """

active_page=Document.ActivePageReference.Id
Document.Properties["sourcePage"]=active_page.ToString()

for page in Document.Pages:
   if (page.Title == "Report Manager"):
      Document.ActivePageReference=page

def run_select_row():
    global tblName
    tblName = Document.Properties["ActivePageName"]
    print("tablName")
    print(tblName)
    table=Document.Data.Tables[tblName]
    fileloc = os.path.join("PROJ_LOC" ,"title.txt")
    f = open(fileloc, 'w')
    f.truncate(0) 
    f.write(tblName)
    f.close

def run_eniqdb_connection():
    """ Calls the sync with eniq script. """

    scriptDef = clr.Reference[ScriptDefinition]()
    Document.ScriptManager.TryGetScript("TestConnection", scriptDef)
    paramDict = {}

    params = Dictionary[str, object](paramDict)
    Document.ScriptManager.ExecuteScript(scriptDef.Value, params)
    
def run_select_datetime_interval_definitions():
    table=Document.Data.Tables["Datetime Interval Definitions"]
    cursor = DataValueCursor.CreateFormatted(table.Columns["Interval Name"])
    valData1=''
    rowIndexOfReport = ''
    for row in table.GetRows(cursor):
            value = cursor.CurrentValue
            if value == interval_name:
                rowIndexOfReport = row.Index
                valData1=value
                break
    selectedValue=Document.Properties["selectedInterval"]
    rowCount = table.RowCount

    #empty indexset
    rowsToMark = IndexSet(rowCount,False)
    rowsToMark.AddIndex(rowIndexOfReport)
    Document.ActiveMarkingSelectionReference.SetSelection(RowSelection(rowsToMark),table)                
               
                     
def run_select_reportname():                   
 #get the data table
    table=Document.Data.Tables["tblSavedReports"]

    #place generic data cursor on a specific column
    cursor = DataValueCursor.CreateFormatted(table.Columns["ReportName"])

    #list object to store retrieved values
    valData = []
    valData1 =''
    rowIndexOfReport =''
    print("ReportName:")
    print(reportName)
    fileloc = os.path.join("PROJ_LOC" ,"reportnameDesc.txt")
    f = open(fileloc, 'w')
    f.truncate(0)
    f.write(reportName)
    f.write('\t')
    f.write(reportDesc)
    f.close
    #iterate through table column rows to retrieve the values
    for row in table.GetRows(cursor):
            value = cursor.CurrentValue
            if value == reportName:
                rowIndexOfReport = row.Index
                valData1=value
                break                                                  
                       
                      
                 
                                    
    selectedValue=Document.Properties["SelectedReport"]
    rowCount = table.RowCount

    #empty indexset
    rowsToMark = IndexSet(rowCount,False)
    rowsToMark.AddIndex(rowIndexOfReport)
    Document.ActiveMarkingSelectionReference.SetSelection(RowSelection(rowsToMark),table)
    
    fileloc = os.path.join("PROJ_LOC" ,"reportDetails.txt")
    f = open(fileloc, 'w')
    f.truncate(0)     
    for eColumn in table.Columns:
                colValue="\tColumn: " + eColumn.Name + "\tValue: " +table.Columns[eColumn.Name].RowValues.GetFormattedValue(rowIndexOfReport)
                print "\tColumn: " + eColumn.Name + "\tValue: " +table.Columns[eColumn.Name].RowValues.GetFormattedValue(rowIndexOfReport)
                f.write(colValue)
    f.close
                                                                                  

def pmex_testing_suite():
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
        test_suite.addTest(unittest.makeSuite(TestReportManagerClickScript))
        test_suite.addTest(unittest.makeSuite(TestNavToMeasureSelScript))
        test_suite.addTest(unittest.makeSuite(TestFetchNodesScript))
        test_suite.addTest(unittest.makeSuite(TestSelectMeasureTypeScript))        
        test_suite.addTest(unittest.makeSuite(TestAddMeasuresScript))
        test_suite.addTest(unittest.makeSuite(TestNavToTimeSelScript))
        test_suite.addTest(unittest.makeSuite(TestFetchPMInformationScript))
        test_suite.addTest(unittest.makeSuite(TestSelectRowOfReportScript))
        time.sleep(30)
        test_suite.addTest(unittest.makeSuite(TestNavigateToSaveScript))
        test_suite.addTest(unittest.makeSuite(TestSaveReportToLibraryScript))
        time.sleep(30)
        test_suite.addTest(unittest.makeSuite(TestSelectReportWithReportNameScript))                                                                            
    else:
        pass

    return test_suite


runner = unittest.TextTestRunner(verbosity=2)
runner.run(pmex_testing_suite())



#