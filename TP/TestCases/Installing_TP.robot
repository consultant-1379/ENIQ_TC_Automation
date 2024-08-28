*** Settings ***
Resource    ../Resources/login.resource
Test Setup        Open Connection And Log In
Test Teardown     Close All Connections  

*** Tasks ***
Installing the TP
  Installing TP    ${pkg}