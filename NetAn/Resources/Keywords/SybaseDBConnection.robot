*** Keywords ***

Query Sybase database
    [Arguments]    ${sql_query}   
	DatabaseLibrary.Connect To Database Using Custom Params         pyodbc      DSN='NetAn_ODBC',DRIVER='Sybase IQ',UID='dc',PWD='Dc@123',PORT='2640'
	${DBOutput}=    Query    ${sql_query}
	Log    ${DBOutput}
    DatabaseLibrary.Disconnect from database
	[Return]      ${DBOutput}
	
Query ENIQ DB REPDB
	[Arguments]    ${sql_query}   
	DatabaseLibrary.Connect To Database Using Custom Params         pyodbc      DSN='NetAn_ODBCrepdb',DRIVER='Sybase IQ',UID='dwhrep',PWD='Dwhrep@123',PORT='2641'
	${DBOutput}=    Query    ${sql_query}
	Log    ${DBOutput}
    DatabaseLibrary.Disconnect from database
	[Return]      ${DBOutput}
	
Query ENIQ DB REPDB 3720
	[Arguments]    ${sql_query}   
	DatabaseLibrary.Connect To Database Using Custom Params         pyodbc      DSN='NetAn_ODBCrepdb',DRIVER='Sybase IQ',UID='dwhrep',PWD='Eniq@1234',PORT='2641'
	${DBOutput}=    Query    ${sql_query}
	Log    ${DBOutput}
    DatabaseLibrary.Disconnect from database
	[Return]      ${DBOutput}
	
#Connect to sybase DB
#    [Arguments]       ${db_name}    ${port}    ${username}    ${password}
#    Write               dbisql -c "UID=${username};PWD=${password}" -host ${db_name} -port ${port} -nogui
#    Sleep    30s
#    ${op1} =                        Read Until Regexp    dc
#    log    ${op1}
    
#Execute query and return output
#    [Arguments]    ${sql_query}
#    Write               ${sql_query}
#    Sleep    30s
#    ${op2} =                        Read      
#    log    ${op2} 
#    ${op}=     Convert to string     ${op2} 
#    Write 		exit
#    [return]    ${op} 
