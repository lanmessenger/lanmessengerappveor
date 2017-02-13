echo on

SET project_dir="%cd%"

echo Set up environment...
set PATH=%QT%\bin\;C:\Qt\Tools\QtCreator\bin\;C:\Qt\QtIFW2.0.1\bin\;%PATH%
::call "C:\Program Files (x86)\Microsoft Visual Studio 14.0\VC\vcvarsall.bat" %PLATFORM%
set PATH=C:\Qt\Tools\mingw492_32\bin;%PATH%

echo Building lmcapp...
cd ./lmcapp/src
::qmake lmcapp.pro -spec win32-msvc2013 CONFIG+=x86 CONFIG-=debug CONFIG+=release
::nmake
qmake lmcapp.pro -spec win32-mingw CONFIG+=x86 CONFIG-=debug CONFIG+=release
make

echo Building lmc...
cd ../../lmc/src
::qmake lmc.pro -spec win32-msvc2013 CONFIG+=x86 CONFIG-=debug CONFIG+=release
::nmake
qmake lmc.pro -spec win32-mingw CONFIG+=x86 CONFIG-=debug CONFIG+=release
make

::echo Running tests...

::echo Packaging...
::cd %project_dir%\build\windows\msvc\x86_64\release\
::windeployqt --qmldir ..\..\..\..\..\src\ YourApp\YourApp.exe

::rd /s /q YourApp\moc\
::rd /s /q YourApp\obj\
::rd /s /q YourApp\qrc\

::echo Copying project files for archival...
::copy "%project_dir%\README.md" "YourApp\README.md"
::copy "%project_dir%\LICENSE" "YourApp\LICENSE.txt"
::copy "%project_dir%\Qt License" "YourApp\Qt License.txt"

::echo Copying files for installer...
::mkdir "%project_dir%\installer\windows\x86_64\packages\com.yourappproject.yourapp\data\"
::robocopy YourApp\ "%project_dir%\installer\windows\x86_64\packages\com.yourappproject.yourapp\data" /E

::echo Packaging portable archive...
::7z a YourApp_%TAG_NAME%_windows_x86_64_portable.zip YourApp

::echo Creating installer...
::cd %project_dir%\installer\windows\x86_64\
::binarycreator.exe --offline-only -c config\config.xml -p packages YourApp_%TAG_NAME%_windows_x86_64_installer.exe