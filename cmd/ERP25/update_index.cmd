SET PRODUCT=saby_ce_kedo
SET SUBSYSTEM=ERP25
SET DESCENT=2005006
SET PLATFORM=80314

cd ../..
v8unpack.exe -I src\%SUBSYSTEM%PROF --index cmd\%SUBSYSTEM%\index.json  --core base --descent %DESCENT%
pause