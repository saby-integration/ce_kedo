SET PRODUCT=saby_ce_kedo
SET SUBSYSTEM=áìè3
SET DESCENT=301019
SET PLATFORM=80314

cd ../..
v8unpack.exe -E bin\%PRODUCT%_%SUBSYSTEM%PROF_%DESCENT%.cfe src\%SUBSYSTEM%PROF --index cmd\%SUBSYSTEM%\index.json --descent %DESCENT%
pause