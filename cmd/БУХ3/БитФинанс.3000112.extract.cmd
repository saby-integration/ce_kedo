SET PRODUCT=saby_ce_kedo
SET SUBSYSTEM=БУХ3
SET DESCENT=3000112
SET PLATFORM=80314

cd ../..
v8unpack.exe -E bin\%PRODUCT%_БитФинанс_%DESCENT%.cfe src\%SUBSYSTEM%БитФинанс --index cmd\%SUBSYSTEM%\index.json --descent %DESCENT%
pause