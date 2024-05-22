if not defined in_subprocess (cmd /k set in_subprocess=y ^& %0 %*) & exit )
@ECHO OFF 
SETLOCAL ENABLEDELAYEDEXPANSION
REM Windhelm Beta Version 2.0.0, 240418
REM This version of Windhelm was made by merelymae (Original Author).

REM Read the settings file and apply the value to "setColor".
:settingsLoader
(
SET /P setColor=
SET /P initSt=
)<data\settings.txt
GOTO :setCheck

REM Change the "COLOR" to the saved value, and prevent "ECHO IS OFF" from displayMessage.
:setCheck
COLOR %setColor%
SET displayMessage=...
IF %initSt% EQU 0 (
    GOTO :INTRO
) ELSE (
    GOTO :START
)

REM A small intro describing the journey of the Player's character.
:INTRO
CALL "%cd%\data\functions\intro.bat"
GOTO :START

REM Main Menu. Access settings, Continue & New Game from here.
:START
TITLE (WINDHELM) Main Menu ^| Welcome to Windhelm.
MODE con: cols=120 lines=20
CLS
ECHO.
TYPE "%cd%\data\ascii\menus\main.txt"
ECHO.
ECHO.
ECHO Beta Build 2 (v2.0, 240418) "Bottle o' Features"
ECHO Copyright (c) merelymae, 2024.
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
CALL "%cd%\data\functions\Settings.bat"
GOTO :START

REM Launch player creator - creates stats and inventory.
:NEW_GAME
CALL "%cd%\data\functions\Character Creator.bat"
IF %OSQ% EQU 1 (
    GOTO :START
) ELSE (
    GOTO :dashboard
)

REM Load Player save data.
:LOAD_SAVE
REM Check if a save even exists.
SET SLOPr=LOAD
IF NOT EXIST "%cd%\data\player\Player Stats.txt" (
    ECHO Player data not found - please make a new save.
    PAUSE
    GOTO :START
) ELSE (
    REM If the above check passes, call SLOP to load data.
    CALL "%cd%\data\functions\SLOP.bat"
    GOTO :dashboard
)

:dashboard
TITLE (WINDHELM) Castle Gate ^| %player_name% the %player_class%
MODE con: cols=101 lines=22
IF %LEVELS% LSS 0 SET LEVELS=0
IF %HP% LSS 0 set HP=0
CLS
REM Write the data from the text file to the CLI.
ECHO.
TYPE "%cd%\data\ascii\menus\windhelm.txt"
ECHO.
ECHO.
ECHO %displayMessage%
ECHO +--------------------------------------------------------------------------------------------------+
ECHO ^| HP: %HP% ^| STM: %stamina% ^| ATK: %player_damage% ^| AMR: %armor_equip% ^| MGK: %magicka% ^| AP %player_action_p% ^| COINS: %COINS%
ECHO +--------------------------------------------------------------------------------------------------+
ECHO ^| PARTY 1: %PM1name% ^| HP: %PM1HP% ^| ATK: %PM1ATK% ^| STM: %PM1STM% ^| MGK: %PM1MGK%
ECHO ^| PARTY 2: %PM2name% ^| HP: %PM2HP% ^| ATK: %PM2ATK% ^| STM: %PM2STM% ^| MGK: %PM2MGK%
ECHO ^| PARTY 3: %PM3name% ^| HP: %PM3HP% ^| ATK: %PM3ATK% ^| STM: %PM3STM% ^| MGK: %PM3MGK%
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
CALL "%cd%\data\functions\Achievements Viewer.bat"
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
CALL "%cd%\data\functions\SLOP.bat"
SET displayMessage=Your game was saved.
GOTO :dashboard

REM Call the Inventory Viewer script.
:view_inventory
CALL "%cd%\data\functions\Inventory Viewer.bat"
GOTO :dashboard

REM Call the Exploration Engine.
:EE
CALL "%cd%\data\Exploration Engine\Exploration Engine.bat"
GOTO :dashboard