*** Keywords ***
Query Postgre database
    [Arguments]    ${sql_query}    ${reportNameFromClient}    
	Connect To Postgresql   netAnServer_pmdb 	netanserver	 Ericsson01	localhost	5432
    ${sql_query}=    Replace String    ${sql_query}    REPORT_NAME      \'${reportNameFromClient}\'
	${results}=	PostgreSQLDB.Execute Sql String    ${sql_query}
	${value}=    Get From List    ${results}     0
	${convertListToString}=   Evaluate             "".join(${value})
	[Return]    ${convertListToString}
	


Query Postgre database and return output
    [Arguments]    ${sql_query}  
    Connect To Postgresql   netAnServer_pmdb 	netanserver	 Ericsson01	localhost	5432
	${results}=	PostgreSQLDB.Execute Sql String    ${sql_query}
	[Return]    ${results}
	[Teardown]       Close All Postgresql Connections
