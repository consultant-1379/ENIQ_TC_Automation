*** Settings ***
Resource    ../../Resources/login.resource
Library    RPA.RobotLogListener
Test Setup        Open Connection And Log In
Test Teardown     Close All Connections  
Library    ../TestCases/server.py
*** Tasks ***
Dependent topology tp
   check the dependent topotp