SET PRODUCT=saby_ce_kedo
SET SUBSYSTEM=Š€24
SET DESCENT=2004014
SET PLATFORM=80316

cd ../..
v8unpack.exe -I src\%SUBSYSTEM%PROF --index cmd\%SUBSYSTEM%\index.json  --core base --descent %DESCENT%
pause