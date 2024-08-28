*** Settings ***
Library            .\\Scripts\\Audit_CMS_connection_check.py

*** Test Cases ***
Verification of Audit_DNS & CMS_DNS ODBC Connection
    ${out}    Odbc_Start 
    IF    ${out}==2
    Log To Console    ${\n}Both connections are working.
    ELSE
    Log To Console    ${\n}Connection Failed
    Fail
    END   
