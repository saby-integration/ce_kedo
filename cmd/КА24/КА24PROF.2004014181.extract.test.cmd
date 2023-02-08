SET PRODUCT=saby_ce_kedo
SET SUBSYSTEM=Š€24
SET DESCENT=2004014
SET PLATFORM=80316

cd ../..
v8unpack.exe -E bin\%PRODUCT%_%SUBSYSTEM%PROF_%DESCENT%.test.cfe src\%SUBSYSTEM%PROF --index cmd\%SUBSYSTEM%\index.json --descent %DESCENT%
pause