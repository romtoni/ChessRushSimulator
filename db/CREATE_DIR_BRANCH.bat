@ECHO off
SET arg1=%1
IF NOT EXIST version.txt (ECHO %arg1%&& ECHO DP v1.0)> version.txt
MKDIR %arg1%
CD %arg1%
MKDIR Script
CD Script
MKDIR Deployment
CD Deployment
MKDIR DML
MKDIR Sequences
MKDIR Triggers
MKDIR Indexes
MKDIR Jobs
MKDIR Constraints
MKDIR Functions
MKDIR Procedures
MKDIR Tables
MKDIR Types
MKDIR Views
CD ..
MKDIR EXEC
MKDIR Rollback
CD EXEC 
(ECHO --HANYA DIISI OLEH FILE-FILE YANG DIPERLUKAN PADA %arg1% && ECHO @C:\implementasi\deployment\%arg1%\Script\Deployment\Constraints\ && ECHO @C:\implementasi\deployment\%arg1%\Script\Deployment\DML\ && ECHO @C:\implementasi\deployment\%arg1%\Script\Deployment\Functions\ && ECHO @C:\implementasi\deployment\%arg1%\Script\Deployment\Indexes\ && ECHO @C:\implementasi\deployment\%arg1%\Script\Deployment\Jobs\ && ECHO @C:\implementasi\deployment\%arg1%\Script\Deployment\Procedures\ && ECHO @C:\implementasi\deployment\%arg1%\Script\Deployment\Sequences\ && ECHO @C:\implementasi\deployment\%arg1%\Script\Deployment\Tables\ && ECHO @C:\implementasi\deployment\%arg1%\Script\Deployment\Triggers\ && ECHO @C:\implementasi\deployment\%arg1%\Script\Deployment\Views\)> MAIN.sql
CD ..
CD Rollback
IF NOT EXIST Rollback.sql ECHO --ROLLBACK HERE > Rollback.sql
CD .. 
CD ..
CD ..