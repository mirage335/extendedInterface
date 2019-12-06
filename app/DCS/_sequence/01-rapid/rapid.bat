
REM Depends:
REM 'mswadminpriv.bat' - 'nircmd elevate'

SET rapidAircraftType=FA18C

IF /I "%1" EQU "F5E" SET rapidAircraftType=FA18C
IF /I "%1" EQU "F5E" SET rapidAircraftType=F5E



REM Terminate - SteamVR (Ensure video parameter changes take effect.)
taskkill /IM vrmonitor.exe
timeout /NOBREAK 1
taskkill /IM vrmonitor.exe
taskkill /IM vrmonitor.exe
taskkill /IM vrmonitor.exe
timeout /NOBREAK 7
taskkill /F /IM vrmonitor.exe
timeout /NOBREAK 1


REM Terminate - VoiceAttack (Ensure correct microphone is available and used.)
CALL "C:\bin\mswadminpriv.bat" cmd.exe /C taskkill /IM VoiceAttack.exe
timeout /NOBREAK 1
CALL "C:\bin\mswadminpriv.bat" cmd.exe /C taskkill /IM VoiceAttack.exe
CALL "C:\bin\mswadminpriv.bat" cmd.exe /C taskkill /IM VoiceAttack.exe
CALL "C:\bin\mswadminpriv.bat" cmd.exe /C taskkill /IM VoiceAttack.exe
timeout /NOBREAK 7
CALL "C:\bin\mswadminpriv.bat" cmd.exe /C taskkill /F /IM VoiceAttack.exe
timeout /NOBREAK 1


REM 001-simpit
CALL "C:\core\infrastructure\extendedInterface\support\steamvr\SteamVR_UniManager\simpit.bat"


REM 005-EVGA Precision X1 (if installed)
cd "C:\Program Files\EVGA\Precision X1"
tasklist /nh /fi "imagename eq PrecisionX_x64.exe" | find /i "PrecisionX_x64.exe" > nul || (start /MIN "" "C:\Program Files\EVGA\Precision X1\PrecisionX_x64.exe" 0)

REM 008-tmux
REM taskkill /F /IM tmux.exe
tasklist /nh /fi "imagename eq tmux.exe" | find /i "tmux.exe" > nul || (start /MIN "" C:\cygwin64\bin\mintty.exe -i /Cygwin-Terminal.ico /bin/bash --login -i -c '/usr/bin/tmux')
REM timeout /NOBREAK 12
REM taskkill /IM mintty.exe


REM 008-Steam
REM https://forums.nexusmods.com/index.php?/topic/6387951-start-steam-silently-on-system-startup-simply-stated/

echo prepare - steam
@echo off
setlocal disableDelayedExpansion

:Variables
set InputFile=config\loginusers.vdf
set OutputFile=config\loginusers-temp.vdf
set "_strFind0=		"WantsOfflineMode"		"0""
set "_strReplace0=		"WantsOfflineMode"		"1""
set "_strFind1=		"SkipOfflineModeWarning"		"0""
set "_strReplace1=		"SkipOfflineModeWarning"		"1""

:Replace
>"%OutputFile%" (
  for /f "usebackq delims=" %%A in ("%InputFile%") do (
    if "%%A" equ "%_strFind0%" (echo %_strReplace0%) else if "%%A" equ "%_strFind1%" (echo %_strReplace1%) else (echo %%A)
  )
)

MOVE "%OutputFile%" "%InputFile%"
@echo on
REM start "" "C:\Program Files (x86)\Steam\Steam.exe" -silent
tasklist /nh /fi "imagename eq Steam.exe" | find /i "Steam.exe" > nul || (start "" "C:\Program Files (x86)\Steam\Steam.exe" -silent)

REM 008-Steam-SteamVR-OPTIONAL
REM taskkill /IM vrmonitor.exe
REM timeout /NOBREAK 1
REM taskkill /IM vrmonitor.exe
REM taskkill /IM vrmonitor.exe
REM taskkill /IM vrmonitor.exe
REM timeout /NOBREAK 7
REM taskkill /F /IM vrmonitor.exe
REM timeout /NOBREAK 1
REM start "" "steam://rungameid/250820"
tasklist /nh /fi "imagename eq vrmonitor.exe" | find /i "vrmonitor.exe" > nul || (start "" "steam://rungameid/250820")

REM 015-VoiceAttack - AS ADMIN - fa18c
cd "C:\Program Files (x86)\VoiceAttack"
CALL "C:\bin\mswadminpriv.bat" cmd.exe /C start /MIN /D "C:\Program Files (x86)\VoiceAttack" "" "C:\Program Files (x86)\VoiceAttack\VoiceAttack.exe" -profile "COVAS-DCS-%rapidAircraftType%"


REM 020- -JoystickGremlin-  - AS ADMIN - fa18c
CALL "C:\bin\mswadminpriv.bat" cmd.exe /C taskkill /IM joystick_gremlin.exe
CALL "C:\bin\mswadminpriv.bat" cmd.exe /C taskkill /F /IM joystick_gremlin.exe
timeout /NOBREAK 1
cd "C:\Program Files (x86)\H2ik\Joystick Gremlin"
CALL "C:\bin\mswadminpriv.bat" cmd.exe /C start /MIN /D "C:\Program Files (x86)\H2ik\Joystick Gremlin" "" "C:\Program Files (x86)\H2ik\Joystick Gremlin\joystick_gremlin.exe" --profile "C:\core\infrastructure\extendedInterface\support\joystickgremlin\Sim - DCS - %rapidAircraftType%.xml" --enable --start-minimized


REM 020-TARGET
REM cd "C:\Program Files (x86)\Thrustmaster\TARGET"
REM start /MIN "" "C:\Program Files (x86)\Thrustmaster\TARGET\x64\TARGETGUI.exe"


REM 200-Discord
taskkill /IM Discord.exe
cd "%USERPROFILE%\AppData\Local\Discord\"
start /MIN "" %USERPROFILE%\AppData\Local\Discord\Update.exe --processStart Discord.exe


REM 201-TeamSpeak
taskkill /IM ts3client_win64.exe
cd "C:\Program Files\TeamSpeak 3 Client"
start /MIN "" "C:\Program Files\TeamSpeak 3 Client\ts3client_win64.exe"


REM 202-SimpleRadioStandalone
CALL "C:\bin\mswadminpriv.bat" cmd.exe /C taskkill /IM SR-ClientRadio.exe
cd "C:\Program Files\DCS-SimpleRadio-Standalone"
start /MIN "" "C:\Program Files\DCS-SimpleRadio-Standalone\SR-ClientRadio.exe"

REM 550-DCS-Waypoint-Editor
taskkill /IM dcs_wp_editor.exe
cd "C:\core\installations\dcs_wp_editor"
start /MIN "" "C:\core\installations\dcs_wp_editor\dcs_wp_editor.exe"

REM 552-Google Earth Pro
taskkill /IM googleearth.exe
cd "C:\Program Files\Google\Google Earth Pro\client\"
start /MIN "" "C:\Program Files\Google\Google Earth Pro\client\googleearth.exe"

REM 590-Atom - Mission
taskkill /IM atom.exe
cd "%USERPROFILE%\AppData\Local\atom\app-1.36.1"
start /MIN "" "%USERPROFILE%\AppData\Local\atom\app-1.36.1\atom.exe" "C:\core\sequence\dcs\901-doc" "C:\core\sequence\dcs\930-mission"


timeout /NOBREAK 40

REM 690-VoiceAttack - AS ADMIN - fa18c - construct desk relaxed
CALL "C:\bin\mswadminpriv.bat" cmd.exe /C taskill /IM OVRdrop.exe
CALL "C:\bin\mswadminpriv.bat" cmd.exe /C taskill /F /IM OVRdrop.exe
cd "C:\Program Files (x86)\VoiceAttack"
CALL "C:\bin\mswadminpriv.bat" cmd.exe /C start /MIN /D "C:\Program Files (x86)\VoiceAttack" "" "C:\Program Files (x86)\VoiceAttack\VoiceAttack.exe" -profile "COVAS-DCS-%rapidAircraftType%" -command "construct desk relaxed"



timeout /NOBREAK 15

REM 798- -SimFFB-
REM taskkill /IM -simFFB-.exe
REM cd "C:\core\infrastructure\extendedInterface\app\DCS\_sequence\05-maintenance\_lib\simffb"
REM start /MIN "" "C:\core\infrastructure\extendedInterface\app\DCS\_sequence\05-maintenance\_lib\simffb\-SimFFB-.exe"

REM 799- OBS Studio
REM tasklist /nh /fi "imagename eq obs64.exe" | find /i "obs64.exe" > nul || (start "" "C:\Program Files (x86)\obs-studio\bin\64bit\obs64.exe")


REM 799-VoiceAttack - AS ADMIN - fa18c - arrange desk -OPTIONAL
cd "C:\Program Files (x86)\VoiceAttack"
CALL "C:\bin\mswadminpriv.bat" cmd.exe /C start /MIN /D "C:\Program Files (x86)\VoiceAttack" "" "C:\Program Files (x86)\VoiceAttack\VoiceAttack.exe" -profile "COVAS-DCS-%rapidAircraftType%" -command "arrange desk"

timeout 3
start "" cmd /c "echo ***** RAPID COMPLETE ***** &echo(&timeout 10"
