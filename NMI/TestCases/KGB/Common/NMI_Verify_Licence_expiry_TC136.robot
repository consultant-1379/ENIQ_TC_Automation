*** Settings ***
Suite Setup        Open Connection And Log In
Suite Teardown     Close All Connections
Library            SSHLibrary
Library            BuiltIn
Library            String
Resource           ../../Resources/resource.txt

*** Variables ***

*** Test Cases ***
Checking if the licences are expiring within 7 days (This testcase checks if any licence is expiring within 7 days)
  [Tags]                      Licence
  Set Client Configuration    timeout=25 seconds      prompt=#:
  ${output}=                  Execute Command         bash /net/159.107.220.96/export/rootftp/osslic/ENIQ/Lic_2016/Stats/licence_validity.bsh
  Should not contain          ${output}               your licence
