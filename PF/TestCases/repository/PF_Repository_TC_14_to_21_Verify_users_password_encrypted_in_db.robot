*** Settings ***
Library    RPA.Browser.Selenium    
Library    SSHLibrary
Library    String
Library    Collections    
Resource    ../../Resources/Keywords/Variables.robot
Resource    ../../Resources/Keywords/Cli.robot
Resource    ../../Resources/Keywords/Parser.robot
Suite Setup   Suite Setup Steps
Suite Teardown    Close All Connections


*** Test Cases ***
Check etlrep password is encrypted in DB
    Write    echo -e "select TOP 1 ENCRYPTION_FLAG from META_DATABASES where username='etlrep'\\n${run}\\n" | isql -P ${etlrep_pwd} -U ETLREP -S repdb -b
    ${cmd_output}=    Read Until Prompt    strip_prompt=True
    Log    ${cmd_output}
    Should Match Regexp    ${cmd_output}    \\b(YY)\\b
    
Check dwhrep password is encrypted in DB
    Write    echo -e "select TOP 1 ENCRYPTION_FLAG from META_DATABASES where username='dwhrep'\\n${run}\\n" | isql -P ${etlrep_pwd} -U ETLREP -S repdb -b
    ${cmd_output}=    Read Until Prompt    strip_prompt=True
    Log    ${cmd_output}
    Should Match Regexp    ${cmd_output}    \\b(YY)\\b

Check dcuser password is encrypted in DB
    Write    echo -e "select TOP 1 ENCRYPTION_FLAG from META_DATABASES where username='dcuser'\\n${run}\\n" | isql -P ${etlrep_pwd} -U ETLREP -S repdb -b
    ${cmd_output}=    Read Until Prompt    strip_prompt=True
    Log    ${cmd_output}
    Should Match Regexp    ${cmd_output}    \\b(YY)\\b

Check dc password is encrypted in DB
    Write    echo -e "select TOP 1 ENCRYPTION_FLAG from META_DATABASES where username='dc'\\n${run}\\n" | isql -P ${etlrep_pwd} -U ETLREP -S repdb -b
    ${cmd_output}=    Read Until Prompt    strip_prompt=True
    Log    ${cmd_output}
    Should Match Regexp    ${cmd_output}    \\b(YY)\\b

Check dcbo password is encrypted in DB
    Write    echo -e "select TOP 1 ENCRYPTION_FLAG from META_DATABASES where username='dcbo'\\n${run}\\n" | isql -P ${etlrep_pwd} -U ETLREP -S repdb -b
    ${cmd_output}=    Read Until Prompt    strip_prompt=True
    Log    ${cmd_output}
    Should Match Regexp    ${cmd_output}    \\b(YY)\\b

Check dba password is encrypted in DB
    Write    echo -e "select TOP 1 ENCRYPTION_FLAG from META_DATABASES where username='dba'\\n${run}\\n" | isql -P ${etlrep_pwd} -U ETLREP -S repdb -b
    ${cmd_output}=    Read Until Prompt    strip_prompt=True
    Log    ${cmd_output}
    Should Match Regexp    ${cmd_output}    \\b(YY)\\b

Check dcpublic password is encrypted in DB
    Write    echo -e "select TOP 1 ENCRYPTION_FLAG from META_DATABASES where username='dcpublic'\\n${run}\\n" | isql -P ${etlrep_pwd} -U ETLREP -S repdb -b
    ${cmd_output}=    Read Until Prompt    strip_prompt=True
    Log    ${cmd_output}
    Should Match Regexp    ${cmd_output}    \\b(YY)\\b

Check admin password is encrypted in DB
    Write    echo -e "select TOP 1 ENCRYPTION_FLAG from META_DATABASES where username='admin'\\n${run}\\n" | isql -P ${etlrep_pwd} -U ETLREP -S repdb -b
    ${cmd_output}=    Read Until Prompt    strip_prompt=True
    Log    ${cmd_output}
    Should Match Regexp    ${cmd_output}    \\b(YY)\\b

*** Keywords ***
Suite Setup Steps   
    Open connection as root user
    Get etrep creds from database

Get etrep creds from database
    Write    su - dcuser
    ${etlrep_pwd}=    Execute Command    /eniq/sw/installer/getPassword.bsh -u ETLREP | awk '{print $NF}'
    ${etlrep_pwd_status}=    Run Keyword And Return Status    Should Not Be Empty    ${etlrep_pwd}
    Skip If    ${etlrep_pwd_status}==False
    Set Global Variable    ${etlrep_pwd}
    Set Client Configuration    prompt=REGEXP:${SERVER}\\[[^\\]]+\\]\\s\\{dcuser\\}\\s#:
    ${cmd_output}=    Read Until Prompt    strip_prompt=True
    
    



   



