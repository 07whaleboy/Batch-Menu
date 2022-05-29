 @echo off
title Batch system menu
if EXIST fart.exe goto next
if NOT EXIST fart.exe goto dnloadfart
:next
if EXIST menu.conf goto exist
if NOT EXIST menu.conf goto create
:dnloadfart
cls
echo Sorry, FART (Find And Replace Text) is not on this computer!
echo Download it from the link below and extract it to the same folder as this batch file is in.
echo https://tiny.one/fartdnld
echo Press any key to exit...
pause>nul
exit /b
:exist
findstr /m "version=0.1b" menu.conf >Nul
if %errorlevel%==0 (
goto start
)
if %errorlevel%==1 (
goto incompat
)
:incompat
cls
echo Wait a second... the configuration file that exists doesn't seem to be compatable with this version!
echo Press any key to make a new one...
pause>nul
cls
echo Backing up old config file...
attrib menu.conf -s -h
ren menu.conf menuconf.old
attrib menuconf.old +s +h
echo Done!
echo Making a new config file...
echo version=0.1b >> menu.conf
attrib menu.conf +s +h
echo All done!
echo Press any key to start setup...
pause>nul
goto setup
:create
echo version=0.1b >> menu.conf
echo setupdone=false >> menu.conf
attrib menu.conf +s +h
:start
set ver=0.1b
echo Loading version %ver%...
choice /c lu /n /t 3 /d l /m ""
if %errorlevel% == 1 goto launch
if %errorlevel% == 2 goto update
:launch
findstr /m "setupdone=ture" menu.conf >Nul
if %errorlevel%==0 (
goto menu
)
if %errorlevel%==1 (
goto setup
)
:menu
cls
echo Welcome to the batch system menu, %name%!
echo What would you like to do?
echo 1) Log out of Windows
echo 2) Shut down Windows
echo 3) Quit the program
echo 4) Advanced options
choice /c 1234 /n /m "Pick an option..."
if %errorlevel% == 1 shutdown -l
if %errorlevel% == 2 shutdown -s -f -t 0
if %errorlevel% == 3 exit /b
if %errorlevel% == 4 goto advanced
:advanced
cls
echo Advanced menu
echo 1) Remake configuration file
echo 2) Delete old configuration file
echo 3) Restore old configuration file
echo 4) Menu
choice /c 1234 /n /m "Pick an option..."
if %errorlevel% == 1 goto remakeconfig
if %errorlevel% == 2 goto deloldconfig
if %errorlevel% == 3 goto restconfig
if %errorlevel% == 4 goto menu
:remakeconfig
cls
echo Are you sure you want to do this? This will revert this program to factory settings.
echo This is reversable if you change your mind.
choice /n /m "Y or N"
if %errorlevel% == 1 goto makeconfig
if %errorlevel% == 2 goto advanced
:makeconfig
cls
echo Backing up old config file...
attrib menu.conf -s -h
ren menu.conf menuconf.old
attrib menuconf.old +s +h
echo Done!
echo Making a new config file...
echo version=0.1b >> menu.conf
echo setupdone=false >> menu.conf
attrib menu.conf +s +h
echo All done!
echo Press any key to start setup...
pause>nul
goto setup
:deloldconfig
cls
echo ARE YOU SURE YOU WANT TO DO THIS? THIS ACTION IS NOT REVERSABLE!
choice /n /m "Y OR N"
if %errorlevel% == 1 goto deleteconfig
if %errorlevel% == 2 goto advanced
:deleteconfig
echo Deleting...
del menuconf.old
echo Done!
echo Press any key to go back tot the main menu...
pause>nul
goto advanced
:restconfig
cls
echo
:setup
cls
echo Hey there! Welcome to the setup for the batch menu!
echo This setup is not finished, so don't expect much.
pause
cls
echo I need a name to call you throuhout the program, so please enter one.
set /p name=
echo Perfect! I will now call you %name%.
echo Press any key to go to the menu...
pause>nul
fart menu.conf setupdone=false setupdone=true>nul
goto menu
:update
cls
if EXIST update goto updater
if NOT EXIST update goto noupdate
:noupdate
echo Sorry, there is no update detected. Make sure that the folder is named "update" and it's in the same location as this batch file.
echo Press any key to exit...
puase>nul
exit /b
:updater
echo Do you wish to install the version found?
echo Note: This may be risky, and you might install the wrong thing.
choice /n /m "Y or N"
if %errorlevel% == 1 goto install
if %errorlevel% == 2 exit /b
:install
cd update
ren menu.bat updated.bat
copy updated.bat ..
ren updated.bat menu.bat
cd..
ren updated.bat menu1.bat
@echo off >> final.bat
ren menu.bat menubat.old >> final.bat
attrib +s +h menubat.old >> final.bat
ren menu1.bat menu.bat >> final.bat
echo Done! >> final.bat
echo Press any key to exit... >final.bat
echo pause>nul >> final.bat
echo exit /b >> final.bat
final.bat