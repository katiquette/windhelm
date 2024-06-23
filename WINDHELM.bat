@ECHO OFF & SETLOCAL ENABLEDELAYEDEXPANSION
REM Windhelm Beta Version 2.1.0.
REM Extra Build Information: 240623-B1.BE2.GU1
REM https://github.com/katiquette/windhelm
REM This software is licensed under GPL-3.0-or-later.

REM Some things
SET winLoc=%~dp0
SET updateTitle=Mysticism

REM Reads the settings.txt file.
:settingsLoader
(
SET /P setColor=
)<"%winLoc%\data\settings.txt"
GOTO :setCheck

REM Applies the settings from settings.txt and prevents "ECHO IS OFF..." messages.
:setCheck
color %setColor%
SET displayMessage=...
GOTO :START

REM Main Menu, previously called the "Splashscreen". Used to access New Games, Existing Games or the Settings.
:START
TITLE (Windhelm - %updateTitle%) ^| Welcome to Windhelm.
MODE con: cols=120 lines=20
CLS
ECHO.
TYPE "%winLoc%\data\assets\ui\main.txt"
ECHO.
ECHO.
ECHO Beta Version 2.1.0 (240623-B1.BE2.GU1) "Mysticism"
ECHO Copyright (c) Katiquette, 2020-2024. GPL-3.0-or-later License.
ECHO ========================================================================================================================
ECHO                           [1 / CONTINUE ] ^| [2 / NEW GAME ] ^| [3 / SETTINGS ] ^| [E / EXIT ]
ECHO.
CHOICE /C 123E /N /M ">"
IF ERRORLEVEL 4 GOTO :EOF
IF ERRORLEVEL 3 GOTO :settings
IF ERRORLEVEL 2 GOTO :NEW_GAME
IF ERRORLEVEL 1 GOTO :LOAD_SAVE

REM Launch the settings menu.
:settings
CALL "%winLoc%\data\functions\Settings.bat"
GOTO :START

REM Launch player creator - creates stats and inventory.
:NEW_GAME
CALL "%winLoc%\data\functions\Character Creator.bat"
GOTO :dashboard
IF %OSQ% EQU 1 (
    GOTO :START
) ELSE (
    GOTO :dashboard
)

REM Check if a save exists, and if it does, load it. Otherwise, prompt the Player to create a new save.
:LOAD_SAVE
SET SLOPr=LOAD
IF NOT EXIST "%winLoc%\data\player\savedata.txt" (
    ECHO Player data not found - please make a new save.
    PAUSE
    GOTO :START
) ELSE (
    REM If the above check passes, call SLOP to load data.
    CALL "%winLoc%\data\functions\SLOP.bat"
    GOTO :dashboard
)

:dashboard
TITLE (Windhelm - Mysticism) Castle Gate ^| %player_name% the %player_class%
MODE con: cols=101 lines=22
IF %player_xp% LSS 0 SET player_xp=0
IF %player_health% LSS 0 set player_health=0
CLS
REM Write the data from the text file to the CLI.
ECHO.
TYPE "%winLoc%\data\assets\ui\windhelm.txt"
ECHO.
ECHO.
ECHO %displayMessage%
ECHO +--------------------------------------------------------------------------------------------------+
ECHO ^| HP: %player_health% ^| STM: %player_stamina% ^| ATK: %player_damage% ^| AMR: %player_armor% ^| MGK: %player_magicka% ^| LEVEL: %player_level% ^| XP: %player_xp% ^| COINS: %player_coins% ^| LUNIS: %player_lunis%
ECHO +--------------------------------------------------------------------------------------------------+
ECHO ^| FOLLOWER: %follower_name% ^| HP: %follower_health% ^| ATK: %follower_attack% ^| STM: %follower_stamina% ^| MGK: %follower_stamina%
ECHO +--------------------------------------------------------------------------------------------------+
ECHO ^| [1 / EXPLORE ] ^| [2 / INVENTORY ] ^| [S / SAVE ] ^| [E / EXIT ]                                    +
ECHO +--------------------------------------------------------------------------------------------------+
CHOICE /C 12SE /N /M ">"
IF ERRORLEVEL 4 GOTO :Exit_Without_Saving
IF ERRORLEVEL 3 GOTO :Save_Game
IF ERRORLEVEL 2 GOTO :view_inventory
IF ERRORLEVEL 1 GOTO :EE

REM Call the "Achievements Viewer" script.
:Achievements_Viewer
CALL "%winLoc%\data\functions\Achievements Viewer.bat"
GOTO :dashboard

REM "Exit without saving" screen.
:Exit_Without_Saving
ECHO Exit now? All unsaved progress will be lost.
CHOICE /C YN
IF ERRORLEVEL 2 GOTO :dashboard
IF ERRORLEVEL 1 GOTO :START

REM Call SLOP with a "SLOPr" of "SAVE".
:Save_Game
SET SLOPr=SAVE
CALL "%winLoc%\data\functions\SLOP.bat"
SET displayMessage=Your game was saved.
GOTO :dashboard

REM Call the Inventory Viewer script.
:view_inventory
CALL "%winLoc%\data\functions\Inventory Viewer.bat"
GOTO :dashboard

REM Call the Exploration Engine.
:EE
CALL "%winLoc%\data\Exploration Engine\Exploration Engine.bat"
GOTO :dashboard