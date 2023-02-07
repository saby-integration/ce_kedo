SET PRODUCT=saby_ce_kedo
SET SUBSYSTEM=БУХ3
SET DESCENT=3000112
SET PLATFORM=80314

cd ../..
v8unpack.exe -B src\%SUBSYSTEM%БитФинанс bin\%PRODUCT%_БитФинанс_%DESCENT%.cfe --index cmd\%SUBSYSTEM%\index.json --version %PLATFORM% --descent %DESCENT%
pause