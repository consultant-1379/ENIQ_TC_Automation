import pyodbc

ROBOT_LISTENER_API_VERSION = 3
ROBOT_LIBRARY_SCOPE = 'TEST SUITE'
def connect_To_Sybase_DB(dataSource,username,password,portNo):
    print(pyodbc.drivers())
    conn = pyodbc.connect(DSN=dataSource,DRIVER='Sybase IQ',UID=username,PWD=password,PORT=portNo)
    cur = conn.cursor()
    sql = "SELECT factor1.UTC_DATETIME_ID, factor1.CELL_FDN, 10*log10(numerator/denominator) AS avgIntPUSCHBrPrb FROM (SELECT UTC_DATETIME_ID, SN + ',' + MOID AS CELL_FDN, ((pmRadioRecInterferencePwrBrPrb1 + pmRadioRecInterferencePwrBrPrb2 + pmRadioRecInterferencePwrBrPrb3 + pmRadioRecInterferencePwrBrPrb4 + pmRadioRecInterferencePwrBrPrb5 + pmRadioRecInterferencePwrBrPrb6 + pmRadioRecInterferencePwrBrPrb7 + pmRadioRecInterferencePwrBrPrb8 + pmRadioRecInterferencePwrBrPrb9 + pmRadioRecInterferencePwrBrPrb10 + pmRadioRecInterferencePwrBrPrb11 + pmRadioRecInterferencePwrBrPrb12 + pmRadioRecInterferencePwrBrPrb13 + pmRadioRecInterferencePwrBrPrb14 + pmRadioRecInterferencePwrBrPrb15 + pmRadioRecInterferencePwrBrPrb16 + pmRadioRecInterferencePwrBrPrb17 + pmRadioRecInterferencePwrBrPrb18 + pmRadioRecInterferencePwrBrPrb19 + pmRadioRecInterferencePwrBrPrb20 + pmRadioRecInterferencePwrBrPrb21 + pmRadioRecInterferencePwrBrPrb22 + pmRadioRecInterferencePwrBrPrb23 + pmRadioRecInterferencePwrBrPrb24 + pmRadioRecInterferencePwrBrPrb25 + pmRadioRecInterferencePwrBrPrb26 + pmRadioRecInterferencePwrBrPrb27 + pmRadioRecInterferencePwrBrPrb28 + pmRadioRecInterferencePwrBrPrb29 + pmRadioRecInterferencePwrBrPrb30 + pmRadioRecInterferencePwrBrPrb31 + pmRadioRecInterferencePwrBrPrb32 + pmRadioRecInterferencePwrBrPrb33 + pmRadioRecInterferencePwrBrPrb34 + pmRadioRecInterferencePwrBrPrb35 + pmRadioRecInterferencePwrBrPrb36 + pmRadioRecInterferencePwrBrPrb37 + pmRadioRecInterferencePwrBrPrb38 + pmRadioRecInterferencePwrBrPrb39 + pmRadioRecInterferencePwrBrPrb40 + pmRadioRecInterferencePwrBrPrb41 + pmRadioRecInterferencePwrBrPrb42 + pmRadioRecInterferencePwrBrPrb43 + pmRadioRecInterferencePwrBrPrb44 + pmRadioRecInterferencePwrBrPrb45 + pmRadioRecInterferencePwrBrPrb46 + pmRadioRecInterferencePwrBrPrb47 + pmRadioRecInterferencePwrBrPrb48 + pmRadioRecInterferencePwrBrPrb49 + pmRadioRecInterferencePwrBrPrb50 + pmRadioRecInterferencePwrBrPrb51 + pmRadioRecInterferencePwrBrPrb52 + pmRadioRecInterferencePwrBrPrb53 + pmRadioRecInterferencePwrBrPrb54 + pmRadioRecInterferencePwrBrPrb55 + pmRadioRecInterferencePwrBrPrb56 + pmRadioRecInterferencePwrBrPrb57 + pmRadioRecInterferencePwrBrPrb58 + pmRadioRecInterferencePwrBrPrb59 + pmRadioRecInterferencePwrBrPrb60 + pmRadioRecInterferencePwrBrPrb61 + pmRadioRecInterferencePwrBrPrb62 + pmRadioRecInterferencePwrBrPrb63 + pmRadioRecInterferencePwrBrPrb64 + pmRadioRecInterferencePwrBrPrb65 + pmRadioRecInterferencePwrBrPrb66 + pmRadioRecInterferencePwrBrPrb67 + pmRadioRecInterferencePwrBrPrb68 + pmRadioRecInterferencePwrBrPrb69 + pmRadioRecInterferencePwrBrPrb70 + pmRadioRecInterferencePwrBrPrb71 + pmRadioRecInterferencePwrBrPrb72 + pmRadioRecInterferencePwrBrPrb73 + pmRadioRecInterferencePwrBrPrb74 + pmRadioRecInterferencePwrBrPrb75 + pmRadioRecInterferencePwrBrPrb76 + pmRadioRecInterferencePwrBrPrb77 + pmRadioRecInterferencePwrBrPrb78 + pmRadioRecInterferencePwrBrPrb79 + pmRadioRecInterferencePwrBrPrb80 + pmRadioRecInterferencePwrBrPrb81 + pmRadioRecInterferencePwrBrPrb82 + pmRadioRecInterferencePwrBrPrb83 + pmRadioRecInterferencePwrBrPrb84 + pmRadioRecInterferencePwrBrPrb85 + pmRadioRecInterferencePwrBrPrb86 + pmRadioRecInterferencePwrBrPrb87 + pmRadioRecInterferencePwrBrPrb88 + pmRadioRecInterferencePwrBrPrb89 + pmRadioRecInterferencePwrBrPrb90 + pmRadioRecInterferencePwrBrPrb91 + pmRadioRecInterferencePwrBrPrb92 + pmRadioRecInterferencePwrBrPrb93 + pmRadioRecInterferencePwrBrPrb94 + pmRadioRecInterferencePwrBrPrb95 + pmRadioRecInterferencePwrBrPrb96 + pmRadioRecInterferencePwrBrPrb97 + pmRadioRecInterferencePwrBrPrb98 + pmRadioRecInterferencePwrBrPrb99 + pmRadioRecInterferencePwrBrPrb100) * POWER(2,-44) * 40/900000 ) AS numerator FROM DC_E_ERBS_PMULINTERFERENCEREP_RAW ORDER BY UTC_DATETIME_ID, CELL_FDN) AS factor1, (SELECT UTC_DATETIME_ID, SN + ',' + MOID AS CELL_FDN, (IF(pmRadioRecInterferencePwrBrPrb1 IN (0, NULL)) THEN 0 ELSE 1 END IF + IF(pmRadioRecInterferencePwrBrPrb2 IN (0, NULL)) THEN 0 ELSE 1 END IF + IF(pmRadioRecInterferencePwrBrPrb3 IN (0, NULL)) THEN 0 ELSE 1 END IF + IF(pmRadioRecInterferencePwrBrPrb4 IN (0, NULL)) THEN 0 ELSE 1 END IF + IF(pmRadioRecInterferencePwrBrPrb5 IN (0, NULL)) THEN 0 ELSE 1 END IF + IF(pmRadioRecInterferencePwrBrPrb6 IN (0, NULL)) THEN 0 ELSE 1 END IF + IF(pmRadioRecInterferencePwrBrPrb7 IN (0, NULL)) THEN 0 ELSE 1 END IF + IF(pmRadioRecInterferencePwrBrPrb8 IN (0, NULL)) THEN 0 ELSE 1 END IF + IF(pmRadioRecInterferencePwrBrPrb9 IN (0, NULL)) THEN 0 ELSE 1 END IF + IF(pmRadioRecInterferencePwrBrPrb10 IN (0, NULL)) THEN 0 ELSE 1 END IF + IF(pmRadioRecInterferencePwrBrPrb11 IN (0, NULL)) THEN 0 ELSE 1 END IF + IF(pmRadioRecInterferencePwrBrPrb12 IN (0, NULL)) THEN 0 ELSE 1 END IF + IF(pmRadioRecInterferencePwrBrPrb13 IN (0, NULL)) THEN 0 ELSE 1 END IF + IF(pmRadioRecInterferencePwrBrPrb14 IN (0, NULL)) THEN 0 ELSE 1 END IF + IF(pmRadioRecInterferencePwrBrPrb15 IN (0, NULL)) THEN 0 ELSE 1 END IF + IF(pmRadioRecInterferencePwrBrPrb16 IN (0, NULL)) THEN 0 ELSE 1 END IF + IF(pmRadioRecInterferencePwrBrPrb17 IN (0, NULL)) THEN 0 ELSE 1 END IF + IF(pmRadioRecInterferencePwrBrPrb18 IN (0, NULL)) THEN 0 ELSE 1 END IF + IF(pmRadioRecInterferencePwrBrPrb19 IN (0, NULL)) THEN 0 ELSE 1 END IF + IF(pmRadioRecInterferencePwrBrPrb20 IN (0, NULL)) THEN 0 ELSE 1 END IF + IF(pmRadioRecInterferencePwrBrPrb21 IN (0, NULL)) THEN 0 ELSE 1 END IF + IF(pmRadioRecInterferencePwrBrPrb22 IN (0, NULL)) THEN 0 ELSE 1 END IF + IF(pmRadioRecInterferencePwrBrPrb23 IN (0, NULL)) THEN 0 ELSE 1 END IF + IF(pmRadioRecInterferencePwrBrPrb24 IN (0, NULL)) THEN 0 ELSE 1 END IF + IF(pmRadioRecInterferencePwrBrPrb25 IN (0, NULL)) THEN 0 ELSE 1 END IF + IF(pmRadioRecInterferencePwrBrPrb26 IN (0, NULL)) THEN 0 ELSE 1 END IF + IF(pmRadioRecInterferencePwrBrPrb27 IN (0, NULL)) THEN 0 ELSE 1 END IF + IF(pmRadioRecInterferencePwrBrPrb28 IN (0, NULL)) THEN 0 ELSE 1 END IF + IF(pmRadioRecInterferencePwrBrPrb29 IN (0, NULL)) THEN 0 ELSE 1 END IF + IF(pmRadioRecInterferencePwrBrPrb30 IN (0, NULL)) THEN 0 ELSE 1 END IF + IF(pmRadioRecInterferencePwrBrPrb31 IN (0, NULL)) THEN 0 ELSE 1 END IF + IF(pmRadioRecInterferencePwrBrPrb32 IN (0, NULL)) THEN 0 ELSE 1 END IF + IF(pmRadioRecInterferencePwrBrPrb33 IN (0, NULL)) THEN 0 ELSE 1 END IF + IF(pmRadioRecInterferencePwrBrPrb34 IN (0, NULL)) THEN 0 ELSE 1 END IF + IF(pmRadioRecInterferencePwrBrPrb35 IN (0, NULL)) THEN 0 ELSE 1 END IF + IF(pmRadioRecInterferencePwrBrPrb36 IN (0, NULL)) THEN 0 ELSE 1 END IF + IF(pmRadioRecInterferencePwrBrPrb37 IN (0, NULL)) THEN 0 ELSE 1 END IF + IF(pmRadioRecInterferencePwrBrPrb38 IN (0, NULL)) THEN 0 ELSE 1 END IF + IF(pmRadioRecInterferencePwrBrPrb39 IN (0, NULL)) THEN 0 ELSE 1 END IF + IF(pmRadioRecInterferencePwrBrPrb40 IN (0, NULL)) THEN 0 ELSE 1 END IF + IF(pmRadioRecInterferencePwrBrPrb41 IN (0, NULL)) THEN 0 ELSE 1 END IF + IF(pmRadioRecInterferencePwrBrPrb42 IN (0, NULL)) THEN 0 ELSE 1 END IF + IF(pmRadioRecInterferencePwrBrPrb43 IN (0, NULL)) THEN 0 ELSE 1 END IF + IF(pmRadioRecInterferencePwrBrPrb44 IN (0, NULL)) THEN 0 ELSE 1 END IF + IF(pmRadioRecInterferencePwrBrPrb45 IN (0, NULL)) THEN 0 ELSE 1 END IF + IF(pmRadioRecInterferencePwrBrPrb46 IN (0, NULL)) THEN 0 ELSE 1 END IF + IF(pmRadioRecInterferencePwrBrPrb47 IN (0, NULL)) THEN 0 ELSE 1 END IF + IF(pmRadioRecInterferencePwrBrPrb48 IN (0, NULL)) THEN 0 ELSE 1 END IF + IF(pmRadioRecInterferencePwrBrPrb49 IN (0, NULL)) THEN 0 ELSE 1 END IF + IF(pmRadioRecInterferencePwrBrPrb50 IN (0, NULL)) THEN 0 ELSE 1 END IF + IF(pmRadioRecInterferencePwrBrPrb51 IN (0, NULL)) THEN 0 ELSE 1 END IF + IF(pmRadioRecInterferencePwrBrPrb52 IN (0, NULL)) THEN 0 ELSE 1 END IF + IF(pmRadioRecInterferencePwrBrPrb53 IN (0, NULL)) THEN 0 ELSE 1 END IF + IF(pmRadioRecInterferencePwrBrPrb54 IN (0, NULL)) THEN 0 ELSE 1 END IF + IF(pmRadioRecInterferencePwrBrPrb55 IN (0, NULL)) THEN 0 ELSE 1 END IF + IF(pmRadioRecInterferencePwrBrPrb56 IN (0, NULL)) THEN 0 ELSE 1 END IF + IF(pmRadioRecInterferencePwrBrPrb57 IN (0, NULL)) THEN 0 ELSE 1 END IF + IF(pmRadioRecInterferencePwrBrPrb58 IN (0, NULL)) THEN 0 ELSE 1 END IF + IF(pmRadioRecInterferencePwrBrPrb59 IN (0, NULL)) THEN 0 ELSE 1 END IF + IF(pmRadioRecInterferencePwrBrPrb60 IN (0, NULL)) THEN 0 ELSE 1 END IF + IF(pmRadioRecInterferencePwrBrPrb61 IN (0, NULL)) THEN 0 ELSE 1 END IF + IF(pmRadioRecInterferencePwrBrPrb62 IN (0, NULL)) THEN 0 ELSE 1 END IF + IF(pmRadioRecInterferencePwrBrPrb63 IN (0, NULL)) THEN 0 ELSE 1 END IF + IF(pmRadioRecInterferencePwrBrPrb64 IN (0, NULL)) THEN 0 ELSE 1 END IF + IF(pmRadioRecInterferencePwrBrPrb65 IN (0, NULL)) THEN 0 ELSE 1 END IF + IF(pmRadioRecInterferencePwrBrPrb66 IN (0, NULL)) THEN 0 ELSE 1 END IF + IF(pmRadioRecInterferencePwrBrPrb67 IN (0, NULL)) THEN 0 ELSE 1 END IF + IF(pmRadioRecInterferencePwrBrPrb68 IN (0, NULL)) THEN 0 ELSE 1 END IF + IF(pmRadioRecInterferencePwrBrPrb69 IN (0, NULL)) THEN 0 ELSE 1 END IF + IF(pmRadioRecInterferencePwrBrPrb70 IN (0, NULL)) THEN 0 ELSE 1 END IF + IF(pmRadioRecInterferencePwrBrPrb71 IN (0, NULL)) THEN 0 ELSE 1 END IF + IF(pmRadioRecInterferencePwrBrPrb72 IN (0, NULL)) THEN 0 ELSE 1 END IF + IF(pmRadioRecInterferencePwrBrPrb73 IN (0, NULL)) THEN 0 ELSE 1 END IF + IF(pmRadioRecInterferencePwrBrPrb74 IN (0, NULL)) THEN 0 ELSE 1 END IF + IF(pmRadioRecInterferencePwrBrPrb75 IN (0, NULL)) THEN 0 ELSE 1 END IF + IF(pmRadioRecInterferencePwrBrPrb76 IN (0, NULL)) THEN 0 ELSE 1 END IF + IF(pmRadioRecInterferencePwrBrPrb77 IN (0, NULL)) THEN 0 ELSE 1 END IF + IF(pmRadioRecInterferencePwrBrPrb78 IN (0, NULL)) THEN 0 ELSE 1 END IF + IF(pmRadioRecInterferencePwrBrPrb79 IN (0, NULL)) THEN 0 ELSE 1 END IF + IF(pmRadioRecInterferencePwrBrPrb80 IN (0, NULL)) THEN 0 ELSE 1 END IF + IF(pmRadioRecInterferencePwrBrPrb81 IN (0, NULL)) THEN 0 ELSE 1 END IF + IF(pmRadioRecInterferencePwrBrPrb82 IN (0, NULL)) THEN 0 ELSE 1 END IF + IF(pmRadioRecInterferencePwrBrPrb83 IN (0, NULL)) THEN 0 ELSE 1 END IF + IF(pmRadioRecInterferencePwrBrPrb84 IN (0, NULL)) THEN 0 ELSE 1 END IF + IF(pmRadioRecInterferencePwrBrPrb85 IN (0, NULL)) THEN 0 ELSE 1 END IF + IF(pmRadioRecInterferencePwrBrPrb86 IN (0, NULL)) THEN 0 ELSE 1 END IF + IF(pmRadioRecInterferencePwrBrPrb87 IN (0, NULL)) THEN 0 ELSE 1 END IF + IF(pmRadioRecInterferencePwrBrPrb88 IN (0, NULL)) THEN 0 ELSE 1 END IF + IF(pmRadioRecInterferencePwrBrPrb89 IN (0, NULL)) THEN 0 ELSE 1 END IF + IF(pmRadioRecInterferencePwrBrPrb90 IN (0, NULL)) THEN 0 ELSE 1 END IF + IF(pmRadioRecInterferencePwrBrPrb91 IN (0, NULL)) THEN 0 ELSE 1 END IF + IF(pmRadioRecInterferencePwrBrPrb92 IN (0, NULL)) THEN 0 ELSE 1 END IF + IF(pmRadioRecInterferencePwrBrPrb93 IN (0, NULL)) THEN 0 ELSE 1 END IF + IF(pmRadioRecInterferencePwrBrPrb94 IN (0, NULL)) THEN 0 ELSE 1 END IF + IF(pmRadioRecInterferencePwrBrPrb95 IN (0, NULL)) THEN 0 ELSE 1 END IF + IF(pmRadioRecInterferencePwrBrPrb96 IN (0, NULL)) THEN 0 ELSE 1 END IF + IF(pmRadioRecInterferencePwrBrPrb97 IN (0, NULL)) THEN 0 ELSE 1 END IF + IF(pmRadioRecInterferencePwrBrPrb98 IN (0, NULL)) THEN 0 ELSE 1 END IF + IF(pmRadioRecInterferencePwrBrPrb99 IN (0, NULL)) THEN 0 ELSE 1 END IF + IF(pmRadioRecInterferencePwrBrPrb100 IN (0, NULL)) THEN 0 ELSE 1 END IF) AS denominator FROM DC_E_ERBS_PMULINTERFERENCEREP_RAW WHERE UTC_DATETIME_ID = '2022-05-31' AND OSS_ID != NULL) AS factor2 WHERE factor1.CELL_FDN = factor2.CELL_FDN AND factor1.UTC_DATETIME_ID = factor2.UTC_DATETIME_ID ORDER BY factor1.CELL_FDN"
    cur.execute(sql)
    result = cur.fetchall()
    for row in result:
        print(row)
    cur.close()
    del cur
    conn.close()

connect_To_Sybase_DB('3720','dc','Eniq@1234','2641')