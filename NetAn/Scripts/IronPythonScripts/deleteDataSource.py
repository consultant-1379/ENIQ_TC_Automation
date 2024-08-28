# ********************************************************************
# Ericsson Inc.                                                 SCRIPT
# ********************************************************************
#
#
# (c) Ericsson Inc. 2020 - All rights reserved.
#
# The copyright to the computer program(s) herein is the property
# of Ericsson Inc. The programs may be used and/or copied only with
# the written permission from Ericsson Inc. or in accordance with the
# terms and conditions stipulated in the agreement/contract under
# which the program(s) have been supplied.
#
# ********************************************************************
# Name    : DeleteEniqFromDb.py
# Date    : 04/03/2022
# Revision: 1.0
# Purpose : 
#
# Usage   : PM Explorer
#



import ast
import clr
clr.AddReference('System.Data')
from System.Text import UTF8Encoding
from System.IO import MemoryStream
from System import Environment, Threading, Array, Byte
from System.IO import StreamWriter, MemoryStream, SeekOrigin, FileStream, FileMode, File
from System.Security.Cryptography import RijndaelManaged, CryptoStream, CryptoStreamMode
from System.Data import DataSet
from System.Data.Odbc import OdbcConnection, OdbcCommand, OdbcDataAdapter
from Spotfire.Dxp.Framework.ApplicationModel import NotificationService
from Spotfire.Dxp.Data import DataType, DataValueCursor, IndexSet
from Spotfire.Dxp.Data.Import import DatabaseDataSource, DatabaseDataSourceSettings, DataTableDataSource, TextFileDataSource, TextDataReaderSettings
from datetime import date

username = Threading.Thread.CurrentPrincipal.Identity.Name

_key    = ast.literal_eval(Document.Properties['valArray'])
_vector = [0, 0, 0, 0, 0, 0, 0, 0,
           0, 0, 0, 0, 0, 0, 0, 0]

_key = Array[Byte](_key)
_vector = Array[Byte](_vector)

notify = Application.GetService[NotificationService]()

def _from_bytes(bts):
    return [ord(b) for b in bts]

def _from_hex_digest(digest):
    return [int(digest[x:x+2], 16) for x in xrange(0, len(digest), 2)]


def decrypt(data, digest=True):
    '''
    Performs decrypting of provided encrypted data. 
    If 'digest' is True data must be hex digest, otherwise data should be
    encrtypted bytes.
    
    This function is simetrical with encrypt function.
    '''
    try:
        data = Array[Byte](map(Byte, _from_hex_digest(data) if digest else _from_bytes(data)))
        
        rm = RijndaelManaged()
        dec_transform = rm.CreateDecryptor(_key, _vector)
    
        mem = MemoryStream()
        cs = CryptoStream(mem, dec_transform, CryptoStreamMode.Write)
        cs.Write(data, 0, data.Length)
        cs.FlushFinalBlock()
        
        mem.Position = 0
        decrypted = Array.CreateInstance(Byte, mem.Length)
        mem.Read(decrypted, 0, decrypted.Length)
        
        cs.Close()
        utfEncoder = UTF8Encoding()
        return utfEncoder.GetString(decrypted)

    except Exception as e:
        notify.AddWarningNotification("Exception","something went wrong",str(e))      

try:
    connString = Document.Properties['ConnStringNetAnDB'].replace("@NetAnPassword", decrypt(Document.Properties['NetAnPassword']))
except Exception as e:
        notify.AddWarningNotification("Exception","Error in DataBase Connection",str(e))

def deleteEniq(eniqName):
    sql = """DELETE FROM "tblEniqDS" WHERE "EniqName" = '{}';""".format(eniqName)
    return writeToDB(sql)

def writeToDB(sql):
    try:
        connection = OdbcConnection(connString)
        connection.Open()
        command = connection.CreateCommand()
        command.CommandText = sql
        command.ExecuteReader()
        connection.Close()
        return True
    except Exception as e:
        Document.Properties['ConnectionError'] = "** Error when saving collection"
        return False

def createCursor(eTable):
    """Create cursors for a given table, these are used to loop through columns"""
    customDateFormat='yyyy-MM-dd HH:mm:ss'
    formatter=DataType.DateTime.CreateLocalizedFormatter()
    formatter.FormatString = customDateFormat

def hasEniq(tableName, eniqName):
    '''checks if the given table contains the eniqName and in case of mapping table checks if the mapping exists'''
    
    QueryDict = {
        "tblSavedReports": 'SELECT string_agg(distinct "ENIQName", \',\') FROM "tblSavedReports" where "ENIQName" is not null and "ENIQName" != \'\'',
        "vwAlarmDefinitions": 'SELECT string_agg(DISTINCT "EniqName", \',\') FROM "vwAlarmDefinitions"',
        "vwEniqEnmMapping": 'SELECT string_agg(DISTINCT "EniqName", \',\') FROM "vwEniqEnmMapping" WHERE "EnmUrl" IS NOT NULL OR "EnmUrl" != \'\'',
        "vwNodeCollections": 'SELECT string_agg(DISTINCT "EniqName", \',\') FROM "vwNodeCollections" WHERE "EniqName" IS NOT NULL OR "EniqName" != \'\'',
    }

    checkQuery = QueryDict.get(tableName)
    netAn_conn_string = Document.Properties["ConnStringNetAnDB"]
    connection = OdbcConnection(netAn_conn_string)
    connection.Open()
    adaptor = OdbcDataAdapter(checkQuery, connection)
    dataSet = DataSet()
    adaptor.Fill(dataSet)
    connection.Close()
    
    savedEniq   = set(str(dataSet.Tables[0].Rows[0][0]).split(","))
    contains = True if eniqName in savedEniq else False
    return contains

def isValid():
    '''validates the condition to delete eniq'''
    valid = True
    if Document.Properties['EniqToDel'] == "" or Document.Properties['EniqToDel'] == "Please select one Eniq" or Document.Properties['EniqToDel'] == None: 
        valid = False
        return valid    
    else: 
        eniqName = Document.Properties["EniqToDel"]
        if hasEniq("vwEniqEnmMapping", eniqName):
            Document.Properties['DeleteLog'] = "One or more ENM is using the eniq: "+ eniqName
            valid = False
            return valid           
        elif hasEniq("tblSavedReports", eniqName):
            Document.Properties['DeleteLog'] = "One or more Reports is using the eniq: "+ eniqName
            valid = False
            return valid
        elif hasEniq("vwAlarmDefinitions", eniqName):
            Document.Properties['DeleteLog'] = "One or more Alarm Rule(s) is using the eniq: "+ eniqName
            valid = False
            return valid 
        elif hasEniq("vwNodeCollections", eniqName):
            Document.Properties['DeleteLog']= "Node Collections is using the eniq: "+ eniqName 
            valid = False
            return valid
    return valid 

def DataTabledelete(tablename, colname, eniqName):
    table=Document.Data.Tables[tablename]
    rowSelection=table.Select('%s = "%s"'%(colname, eniqName))
    table.RemoveRows(rowSelection)
    table.Refresh()

if isValid():
    try:
        if deleteEniq(Document.Properties['EniqToDel']):
            DataTabledelete("ENIQDataSources", "ENIQName", Document.Properties['EniqToDel'])
            DataTabledelete("Measure Mapping", "DataSourceName", Document.Properties['EniqToDel'])
            Document.Properties['DeleteLog'] = "{} Deleted Successfully".format(Document.Properties['EniqToDel'])
        else:
            notify.AddWarningNotification("Exception","cannot delete selection for", Document.Properties['EniqToDel'])
    except Exception as e:
        notify.AddWarningNotification("Exception","Error in DataBase Connection",str(e))