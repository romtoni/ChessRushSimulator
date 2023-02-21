@ECHO OFF
SET arg1=%1
SET arg2=%2

CALL CREATE_DIR_BRANCH.bat %arg1% >nul 2>NUL

IF EXIST %arg1%\Script\EXEC\MAIN.sql DEL %arg1%\Script\EXEC\MAIN.sql
IF EXIST %arg1%\Script\Deployment\RECOMPILE.sql DEL %arg1%\Script\Deployment\RECOMPILE.sql

:TABLES
CD %arg1%\Script\Deployment\Tables
DIR /s /b *.sql > TABLES.txt 2>NUL
CD ..\..\..\..
TYPE %arg1%\Script\Deployment\Tables\TABLES.txt >> %arg1%\Script\Deployment\MAIN.txt
IF EXIST %arg1%\Script\Deployment\Tables\TABLES.txt DEL %arg1%\Script\Deployment\Tables\TABLES.txt
GOTO AFTER_TABLES

:SEQUENCES
CD %arg1%\Script\Deployment\Sequences
DIR /s /b *.sql > SEQUENCES.txt 2>NUL
CD ..\..\..\..
TYPE %arg1%\Script\Deployment\Sequences\SEQUENCES.txt >> %arg1%\Script\Deployment\MAIN.txt
IF EXIST %arg1%\Script\Deployment\Sequences\SEQUENCES.txt DEL %arg1%\Script\Deployment\Sequences\SEQUENCES.txt
GOTO AFTER_SEQUENCES

:TRIGGERS
CD %arg1%\Script\Deployment\Triggers
DIR /s /b *.sql > TRIGGERS.txt 2>NUL
CD ..\..\..\..
TYPE %arg1%\Script\Deployment\Triggers\TRIGGERS.txt >> %arg1%\Script\Deployment\MAIN.txt
IF EXIST %arg1%\Script\Deployment\Triggers\TRIGGERS.txt DEL %arg1%\Script\Deployment\Triggers\TRIGGERS.txt
GOTO AFTER_TRIGGERS

:CONSTRAINTS
CD %arg1%\Script\Deployment\Constraints
DIR /s /b *.sql > CONSTRAINTS.txt 2>NUL
CD ..\..\..\..
TYPE %arg1%\Script\Deployment\Constraints\CONSTRAINTS.txt >> %arg1%\Script\Deployment\MAIN.txt
IF EXIST %arg1%\Script\Deployment\Constraints\CONSTRAINTS.txt DEL %arg1%\Script\Deployment\Constraints\CONSTRAINTS.txt
GOTO AFTER_CONSTRAINTS

:INDEXES
CD %arg1%\Script\Deployment\Indexes
DIR /s /b *.sql > INDEXES.txt 2>NUL
CD ..\..\..\..
TYPE %arg1%\Script\Deployment\Indexes\INDEXES.txt >> %arg1%\Script\Deployment\MAIN.txt
IF EXIST %arg1%\Script\Deployment\Indexes\INDEXES.txt DEL %arg1%\Script\Deployment\Indexes\INDEXES.txt
GOTO AFTER_INDEXES

:FUNCTIONS
CD %arg1%\Script\Deployment\Functions
DIR /s /b *.sql > FUNCTIONS.txt 2>NUL
CD ..\..\..\..
TYPE %arg1%\Script\Deployment\Functions\FUNCTIONS.txt >> %arg1%\Script\Deployment\MAIN.txt
TYPE %arg1%\Script\Deployment\Functions\FUNCTIONS.txt >> %arg1%\Script\Deployment\RECOMPILE.txt
IF EXIST %arg1%\Script\Deployment\Functions\FUNCTIONS.txt DEL %arg1%\Script\Deployment\Functions\FUNCTIONS.txt
GOTO AFTER_FUNCTIONS

:VIEWS
CD %arg1%\Script\Deployment\Views
DIR /s /b *.sql > VIEWS.txt 2>NUL
CD ..\..\..\..
TYPE %arg1%\Script\Deployment\Views\VIEWS.txt >> %arg1%\Script\Deployment\MAIN.txt
TYPE %arg1%\Script\Deployment\Views\VIEWS.txt >> %arg1%\Script\Deployment\RECOMPILE.txt
IF EXIST %arg1%\Script\Deployment\Views\VIEWS.txt DEL %arg1%\Script\Deployment\Views\VIEWS.txt
GOTO AFTER_VIEWS

:PROCEDURES
CD %arg1%\Script\Deployment\Procedures
DIR /s /b *.sql > PROCEDURES.txt 2>NUL
CD ..\..\..\..
TYPE %arg1%\Script\Deployment\Procedures\PROCEDURES.txt >> %arg1%\Script\Deployment\MAIN.txt
TYPE %arg1%\Script\Deployment\Procedures\PROCEDURES.txt >> %arg1%\Script\Deployment\RECOMPILE.txt
IF EXIST %arg1%\Script\Deployment\Procedures\PROCEDURES.txt DEL %arg1%\Script\Deployment\Procedures\PROCEDURES.txt
GOTO AFTER_PROCEDURES

:JOBS
CD %arg1%\Script\Deployment\Jobs
DIR /s /b *.sql > JOBS.txt 2>NUL
CD ..\..\..\..
TYPE %arg1%\Script\Deployment\Jobs\JOBS.txt >> %arg1%\Script\Deployment\MAIN.txt
IF EXIST %arg1%\Script\Deployment\Jobs\JOBS.txt DEL %arg1%\Script\Deployment\Jobs\JOBS.txt
GOTO AFTER_JOBS

:TYPES
CD %arg1%\Script\Deployment\TYPES
DIR /s /b *.sql > TYPES.txt 2>NUL
CD ..\..\..\..
TYPE %arg1%\Script\Deployment\TYPES\TYPES.txt >> %arg1%\Script\Deployment\MAIN.txt
IF EXIST %arg1%\Script\Deployment\TYPES\TYPES.txt DEL %arg1%\Script\Deployment\TYPES\TYPES.txt
GOTO AFTER_TYPES

:DML
CD %arg1%\Script\Deployment\DML
DIR /s /b *.sql > DML.txt 2>NUL
CD ..\..\..\..
TYPE %arg1%\Script\Deployment\DML\DML.txt >> %arg1%\Script\Deployment\MAIN.txt
IF EXIST %arg1%\Script\Deployment\DML\DML.txt DEL %arg1%\Script\Deployment\DML\DML.txt
GOTO AFTER_DML

IF EXIST %arg1%\Script\Deployment\Tables GOTO TABLES
:AFTER_TABLES

IF EXIST %arg1%\Script\Deployment\Sequences GOTO SEQUENCES
:AFTER_SEQUENCES

IF EXIST %arg1%\Script\Deployment\Triggers GOTO TRIGGERS
:AFTER_TRIGGERS

IF EXIST %arg1%\Script\Deployment\Constraints GOTO CONSTRAINTS
:AFTER_CONSTRAINTS

IF EXIST %arg1%\Script\Deployment\Indexes GOTO INDEXES
:AFTER_INDEXES

IF EXIST %arg1%\Script\Deployment\Types GOTO TYPES
:AFTER_TYPES

IF EXIST %arg1%\Script\Deployment\Functions GOTO FUNCTIONS
:AFTER_FUNCTIONS

IF EXIST %arg1%\Script\Deployment\Views GOTO VIEWS
:AFTER_VIEWS

IF EXIST %arg1%\Script\Deployment\Procedures GOTO PROCEDURES
:AFTER_PROCEDURES

IF EXIST %arg1%\Script\Deployment\Jobs GOTO Jobs
:AFTER_JOBS

IF EXIST %arg1%\Script\Deployment\DML GOTO DML
:AFTER_DML

CD %arg1%\Script\Deployment\

@echo off
setlocal enabledelayedexpansion
set INTEXTFILE=RECOMPILE.txt
set OUTTEXTFILE=RECOMPILE_mod.txt
set SEARCHTEXT=%cd%
set REPLACETEXT=ALTER
set SEARCHTEXT_2=\
set REPLACETEXT_2= 
set SEARCHTEXT_3=.sql
set REPLACETEXT_3= COMPILE;
set SEARCHTEXT_4=PROCEDURES 
set REPLACETEXT_4=PROCEDURE %arg2%.
set SEARCHTEXT_5=FUNCTIONS 
set REPLACETEXT_5=FUNCTION %arg2%.
set SEARCHTEXT_6=VIEWS 
set REPLACETEXT_6=VIEW %arg2%.
set OUTPUTLINE=

for /f "tokens=1,* delims=¶" %%A in ( '"findstr /n ^^ %INTEXTFILE%"') do (
   SET string=%%A
   for /f "delims=: tokens=1,*" %%a in ("!string!") do set "string=%%b"
   if  "!string!" == "" (
       echo.>>%OUTTEXTFILE%
   ) else (
      SET modified=!string:%SEARCHTEXT%=%REPLACETEXT%!
      SET modified=!modified:%SEARCHTEXT_2%=%REPLACETEXT_2%!
      SET modified=!modified:%SEARCHTEXT_3%=%REPLACETEXT_3%!
      SET modified=!modified:%SEARCHTEXT_4%=%REPLACETEXT_4%!
      SET modified=!modified:%SEARCHTEXT_5%=%REPLACETEXT_5%!
      SET modified=!modified:%SEARCHTEXT_6%=%REPLACETEXT_6%!
      echo !modified! >> %OUTTEXTFILE%
  )
)
del %INTEXTFILE%
copy %OUTTEXTFILE% %INTEXTFILE% >nul
del %OUTTEXTFILE%
endlocal

CD ..\..\..

COPY %arg1%\Script\Deployment\RECOMPILE.txt %arg1%\Script\Deployment\RECOMPILE.sql >NUL
ECHO %cd%\%arg1%\Script\Deployment\RECOMPILE.sql >> %arg1%\Script\Deployment\MAIN.txt
IF EXIST %arg1%\Script\Deployment\RECOMPILE.txt DEL %arg1%\Script\Deployment\RECOMPILE.txt

COPY %arg1%\Script\Deployment\MAIN.txt %arg1%\Script\EXEC\MAIN.sql >NUL
IF EXIST %arg1%\Script\Deployment\MAIN.txt DEL %arg1%\Script\Deployment\MAIN.txt


@echo off
setlocal enabledelayedexpansion
set INTEXTFILE=%arg1%\Script\EXEC\MAIN.sql
set OUTTEXTFILE=%arg1%\Script\EXEC\MAIN_mod.sql
set SEARCHTEXT=%cd%
set REPLACETEXT=@C:\implementasi\deployment
set OUTPUTLINE=

for /f "tokens=1,* delims=¶" %%A in ( '"findstr /n ^^ %INTEXTFILE%"') do (
   SET string=%%A
   for /f "delims=: tokens=1,*" %%a in ("!string!") do set "string=%%b"
   if  "!string!" == "" (
       echo.>>%OUTTEXTFILE%
   ) else (
      SET modified=!string:%SEARCHTEXT%=%REPLACETEXT%!
      echo !modified! >> %OUTTEXTFILE%
  )
)
del %INTEXTFILE%
copy %OUTTEXTFILE% %INTEXTFILE% >nul
del %OUTTEXTFILE%
endlocal

for /f "delims=" %%i in ('dir %arg1% /s /b /ad ^| sort /r') do rd "%%i" >nul 2>NUL