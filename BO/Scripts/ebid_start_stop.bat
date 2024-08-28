@ECHO OFF

REM ***********************************************************************************
REM 	Ericsson Radio Systems AB                                     SCRIPT
REM ***********************************************************************************
REM 
REM   	(c) Ericsson Radio Systems AB 2015 - All rights reserved.
REM   	The copyright to the computer program(s) herein is the property
REM 	of Ericsson Radio Systems AB, Sweden. The programs may be used
REM 	and/or copied only with the written permission from Ericsson Radio
REM 	Systems AB or in accordance with the terms and conditions stipulated
REM 	in the agreement/contract under which the program(s) have been
REM 	supplied.
REM
REM ***********************************************************************************
REM		Name		:	ebid_start_stop.bat
REM		Date		:	21/09/2015
REM		Revision	:	A.1
REM		Purpose		:	This batch file is used to start or stop the BI 
REM					platform services depending on the command line 
REM					argument.
REM				
REM		Usage		:	ebid_start_stop.bat start | stop
REM
REM ***********************************************************************************

set RESULT=0


REM ------------------------------------------------------------------------
REM 
REM  Set working directory and create log file and directory if needed
REM 
REM ------------------------------------------------------------------------

set DRIVE=%CD:~0,3%
set LOGDIR="%DRIVE%"\ebid\start_stop\log


if exist %LOGDIR% goto CREATELOG
MD %LOGDIR%
goto CREATELOG


:CREATELOG
set th=%time:~0,2%
set tm=%time:~3,2%
set ts=%time:~6,2%
if "%time:~0,1%"==" " set th=0%th:~1,1%
set mytime=%th%%tm%%ts%

set f=%date:/=%%time::=%


REM ------------------------------------------------------------------------
REM check date format
REM ------------------------------------------------------------------------
if "%date:~3,1%"==" " GOTO DATE1
GOTO DATE2

REM ------------------------------------------------------------------------
REM if date format is Thu ddmmyyyy
REM ------------------------------------------------------------------------
:DATE1
set dd=%date:~4,2%
set dm=%date:~7,2%
set dy=%date:~12,2%
set mydate=%dd%%dm%%dy%
set filename=%LOGDIR%\bi4_"%1"_%mydate%_%mytime%.log
GOTO START

REM ------------------------------------------------------------------------
REM if date format is ddmmyyyy
REM ------------------------------------------------------------------------
:DATE2
set dd=%date:~0,2%
set dm=%date:~3,2%
set dy=%date:~8,2%
set mydate=%dd%%dm%%dy%
set filename=%LOGDIR%\bi4_"%1"_%mydate%_%mytime%.log
GOTO START

REM ------------------------------------------------------------------------
REM 
REM  Usage: ebid_start_stop.bat start | stop
REM 
REM ------------------------------------------------------------------------
:START
IF "%1"=="start" GOTO SQLAW_START
IF "%1"=="stop" GOTO TOMCAT_STOP
GOTO INCORRECT



REM ------------------------------------------------------------------------
REM 
REM  SIA, TOMCAT, SQL Anywhere and LCM Service net start commands
REM 
REM ------------------------------------------------------------------------

:SQLAW_START
net start "SQL Anywhere for SAP Business Intelligence" >>%filename% 2>&1
goto SIA_START

:SIA_START
net start "Server Intelligence Agent ("%computername%")" >>%filename% 2>&1
goto TOMCAT_START

:TOMCAT_START
net start "Apache Tomcat for BI 4" >>%filename% 2>&1
goto LCM_START

:LCM_START
net start "LCMSubversion" >>%filename% 2>&1
goto CHECK_STARTED

REM ------------------------------------------------------------------------
REM 
REM  SIA, TOMCAT, SQL Anywhere and LCM Service net stop commands
REM 
REM ------------------------------------------------------------------------

:TOMCAT_STOP
net stop "Apache Tomcat for BI 4" >>%filename% 2>&1
goto SIA_STOP

:SIA_STOP
set /a number_of_checks=0
net stop "Server Intelligence Agent ("%computername%")" >>%filename% 2>&1
goto SIA_STOP_CHECK

:SIA_DELAY
ping -n 5 localhost >NUL
set /a number_of_checks=%number_of_checks%+1
echo Waiting for SIA to stop... >>%filename% 2>&1
goto SIA_STOP_CHECK

:SIA_STOP_CHECK
sc query BOEXI40SIA"%computername%" | FIND "STATE" | FIND "STOPPED" >>%filename% 2>&1
if errorlevel 1 (
if %number_of_checks% LSS 180 (
goto SIA_DELAY ) else (
ECHO The Server Intelligence Agent ^("%computername%"^) could not be stopped. >>%filename% 2>&1
goto LCM_STOP ) )
goto SQLAW_STOP

:SQLAW_STOP
net stop "SQL Anywhere for SAP Business Intelligence" >>%filename% 2>&1
goto LCM_STOP

:LCM_STOP
net stop "LCMSubversion" >>%filename% 2>&1
goto CHECK_STOPPED

REM ------------------------------------------------------------------------
REM 
REM  SIA, TOMCAT, SQL Anywhere and LCM Error handling for net start commands
REM 
REM ------------------------------------------------------------------------
:CHECK_STARTED

net start | find "LCMSubversion" >>%filename% 2>&1
if errorlevel 1 set RESULT=1
net start | find "SQL Anywhere for SAP Business Intelligence" >>%filename% 2>&1
if errorlevel 1 set RESULT=1 
net start | find "Apache Tomcat for BI 4" >>%filename% 2>&1
if errorlevel 1 set RESULT=1 
net start | find "Server Intelligence Agent" >>%filename% 2>&1
if errorlevel 1 set RESULT=1 
goto STARTED


REM ------------------------------------------------------------------------
REM 
REM  SIA, TOMCAT, SQL Anywhere and LCM Error handling for net stop commands
REM 
REM ------------------------------------------------------------------------
:CHECK_STOPPED

set RESULT=0
net start | find "LCMSubversion" >>%filename% 2>&1
if not errorlevel 1 set RESULT=1
net start | find "SQL Anywhere for SAP Business Intelligence" >>%filename% 2>&1
if not errorlevel 1 set RESULT=1
net start | find "Apache Tomcat for BI 4" >>%filename% 2>&1
if not errorlevel 1 set RESULT=1
net start | find "Server Intelligence Agent" >>%filename% 2>&1
if not errorlevel 1 set RESULT=1
goto STOPPED


REM ------------------------------------------------------------------------
REM 
REM  General Error handling commands
REM 
REM ------------------------------------------------------------------------
:STOPPED
IF %RESULT%==1 ECHO.Some of the services have not stopped correctly>>%filename%
IF %RESULT%==0 ECHO.All of the services have stopped correctly>>%filename%
goto END


:STARTED
IF %RESULT%==1 ECHO.Some of the services have not started correctly>>%filename%
IF %RESULT%==0 ECHO.All of the services have started correctly>>%filename%
goto END

:INCORRECT
ECHO Incorrect Syntax
ECHO "ebid_start_stop.bat start | stop"
goto END


:END
EXIT /b %RESULT%

