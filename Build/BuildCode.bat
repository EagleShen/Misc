
if "%1" == "" goto err_msg
if "%2" == "Release" set ExeDir=Exe2008
if "%2" == "Debug"   set ExeDir=ExeD2008

if "%3" == "" set BuildFlag=/Build
if "%3" == "Build" set BuildFlag=/Build
if "%3" == "Clean" set BuildFlag=/Clean
if "%3" == "Rebuild" set BuildFlag=/Rebuild

set LogFile="%APROOT%\_AutoBuild\Build_%2.log"
set Config= /Nologo %BuildFlag% %2

if "%4" == "EnableLog" set Config=%Config% /Out %LogFile%

set VC9Dir=C:\Program Files\Microsoft Visual Studio 9.0
set WSdkDir=C:\SDK\WindowsSDK\v6.1\
set WSdkDir2=C:\Program Files\Microsoft SDKs\Windows\v6.0A\
set WSdkDir3=C:\Program Files\Microsoft SDKs\Windows\v6.0\

set path=
call "%VC9Dir%\VC\vcvarsall.bat" x86
@echo on
set path=C:\WINDOWS;C:\WINDOWS\system32;C:\Program Files\Perforce\;C:\Program Files\Xoreax\IncrediBuild;%path%;%WSdkDir2%bin;%WSdkDir%bin

set IncDir1=%VCINSTALLDIR%\include
set IncDir2=%VCINSTALLDIR%\atlmfc\include
set IncDir3=%WSdkDir2%include
set IncDir4=%WSdkDir%include
set IncDir5=%WSdkDir3%include

set LibDir1=%VCINSTALLDIR%\lib
set LibDir2=%VCINSTALLDIR%\atlmfc\lib
set LibDir3=%WSdkDir%lib
REM set LibDir4=%VCINSTALLDIR%\atlmfc\lib\i386
REM set LibDir5=%FrameworkSDKDir%\lib
REM set LibDir6=%VCINSTALLDIR%

set INCLUDE=%IncDir1%;%IncDir2%;%IncDir3%;%IncDir4%;%IncDir5%;%IncDir6%;%IncDir9%;%IncDir10%;%IncDir11%;%IncDir12%;%IncDir13%;
set LIBPATH=%LibDir1%;%LibDir2%;%LibDir3%;%LibDir4%;%LibDir5%;%LibDir6%;%LibDir9%;%LibDir10%;%LibDir11%;%LibDir12%;%LibDir13%;
set Lib=%LIBPATH%


del %LogFile%

REM Build


devenv %APROOT%\App.sln /useenv %Config% 
if errorlevel 1 goto build_err

goto build_ok

:build_err
type %LogFile%
exit /b 1

:build_ok
exit /b 0