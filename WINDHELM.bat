if not defined in_subprocess (cmd /k set in_subprocess=y ^& %0 %*) & exit )
@ECHO OFF & SETLOCAL ENABLEDELAYEDEXPANSION
REM Windhelm Beta Version 2.1.0 [ 240525-B1.BE2.GU1 ]
REM For clarity: 240524 (Date) B1 (Build 1) BE2 (Beta 2) GU1 (General Update 1)
REM This version of Windhelm was made by Midnight Midriff (Original Author).
REM https://github.com/MidnightMidriff/windhelm
REM This software is licensed under GPL-3.0-or-later.

REM Defaults
SET winLoc=%~dp0

REM Read the settings file and apply the value to "setColor".
:settingsLoader
(
SET /P setColor=
)<"%winLoc%\data\settings.txt"
GOTO :setCheck

REM Change the "COLOR" to the saved value, and prevent "ECHO IS OFF" from displayMessage.
:setCheck
color %setColor%
SET displayMessage=...
GOTO :START

REM Main Menu. Access settings, Continue & New Game from here.
:START
TITLE (WINDHELM - Mysticism) Main Menu ^| Welcome to Windhelm.
MODE con: cols=120 lines=20
CLS
ECHO.
TYPE "%winLoc%\data\assets\ui\main.txt"
ECHO.
ECHO.
ECHO Beta Version 2.1.0 (240525-B1.BE2.GU1) "Mysticism"
ECHO Copyright (c) Midnight Midriff, 2024. GPL-3.0-or-later License. https://github.com/MidnightMidriff/windhelm
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

REM Load Player save data.
:LOAD_SAVE
REM Check if a save even exists.
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
TITLE (WINDHELM) Castle Gate ^| %player_name% the %player_class%
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
ECHO Exit without saving? You will lose your progress.
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