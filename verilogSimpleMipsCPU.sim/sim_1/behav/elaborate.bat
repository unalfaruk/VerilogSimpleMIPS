@echo off
set xv_path=D:\\Viv\\Vivado\\2016.3\\bin
call %xv_path%/xelab  -wto 5aac03c6822e4c2baeab5c39e9c6f373 -m64 --debug typical --relax --mt 2 -L xil_defaultlib -L unisims_ver -L unimacro_ver -L secureip --snapshot simpleMipsCPU_tb_behav xil_defaultlib.simpleMipsCPU_tb xil_defaultlib.glbl -log elaborate.log
if "%errorlevel%"=="0" goto SUCCESS
if "%errorlevel%"=="1" goto END
:END
exit 1
:SUCCESS
exit 0
