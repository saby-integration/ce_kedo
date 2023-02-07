SET PRODUCT=saby_ce_kedo
SET SUBSYSTEM=ERP25
SET DESCENT=2005006
SET PLATFORM=80316

cd ../..
v8unpack.exe -B src\%SUBSYSTEM%PROF bin\%PRODUCT%_%SUBSYSTEM%PROF_%DESCENT%.test.cfe --index cmd\%SUBSYSTEM%\index.json --version %PLATFORM% --descent %DESCENT%
pause