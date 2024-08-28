*** Settings ***
Library            .\\Scripts\\create_odbc.py

*** Variables ***
${eniq_FQDN}    
${odbc_conn}    
${conn_user}    
${conn_pass}    

*** Test Cases ***
ODBC Connection creation & verification
    ${out}    Odbc_Start    ${eniq_FQDN}    ${odbc_conn}    ${conn_user}    ${conn_pass}
    IF    ${out}>=1
    Log To Console    ${\n}New ODBC connections is working.
    ELSE
    Log To Console    ${\n}Connection Failed
    Fail
    END