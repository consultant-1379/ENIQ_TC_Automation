::   comment1
@echo off
set count=0
for /f "tokens=*" %%x in (NetAn\TestSuites\KGB-network-analytics-pm-alarming.txt) do (
    set /a count+=1
    set var[!count!]=%%x
)
echo %var[1]%

