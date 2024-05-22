@ECHO OFF
REM Exploration Engine Beta Version 1.0 (240228) for Windhelm Build 2 "Bottle o' Features"

REM Main Menu. Access to hubs/shops and locations to explore.
:MAIN
TITLE (WINDHELM) Exploration Engine ^| %player_name% the %player_class%
MODE con: cols=105 lines=23
CLS
ECHO.
TYPE "%cd%\data\ascii\menus\exp.txt"
ECHO.
ECHO %displayMessage%
ECHO +-------------------------------------------------------------------------------------------------------+
ECHO ^| HP: %HP% ^| STM: %stamina% ^| ATK: %player_damage% ^| AMR: %armor_equip% ^| MGK: %magicka% ^| AP %player_action_p% ^| COINS: %COINS%
ECHO +-------------------------------------------------------------------------------------------------------+
ECHO ^| PARTY 1: %PM1name% ^| HP: %PM1HP% ^| ATK: %PM1ATK% ^| STM: %PM1STM% ^| MGK: %PM1MGK%
ECHO ^| PARTY 2: %PM2name% ^| HP: %PM2HP% ^| ATK: %PM2ATK% ^| STM: %PM2STM% ^| MGK: %PM2MGK%
ECHO ^| PARTY 3: %PM3name% ^| HP: %PM3HP% ^| ATK: %PM3ATK% ^| STM: %PM3STM% ^| MGK: %PM3MGK%
ECHO +-------------------------------------------------------------------------------------------------------+
ECHO + [1 / IRIDESCENT FOREST ] ^| [2 / RUINS ] ^| [3 / ROCKWINN PLAZA ] ^| [P / PARTY MANAGER ] ^| [E / GO BACK ]
ECHO +-------------------------------------------------------------------------------------------------------+
CHOICE /C 123PE /N /M ">"
IF ERRORLEVEL 5 GOTO :AUTOSAVE
IF ERRORLEVEL 4 GOTO :PARTY_MANAGER
IF ERRORLEVEL 3 GOTO :ROCKWINN_PLAZA
IF ERRORLEVEL 2 GOTO :CHECK_RUINS_UNLOCKED
IF ERRORLEVEL 1 GOTO :EXPLORE_IRIDESCENT_FOREST

REM Attempts to encounter an enemy or NPC. Low level enemies can be found here.
:EXPLORE_IRIDESCENT_FOREST
SET bl=Iridescent Forest
SET /A A=%RANDOM% %%20
IF %A% GTR 15 (
    REM Clarke Blackwell encounter.
    IF %clarke_blackwell_added_party% == true (
        SET displayMessage=You didn't find anything.
        GOTO :MAIN
    ) ELSE (
        SET NE=ClarkeBlackwell
        CALL "%cd%\data\Exploration Engine\scripts\npcadd.bat"
        GOTO :MAIN
    )
) ELSE IF %A% LSS 3 (
    REM Nothing found.
    SET displayMessage=You didn't find anything.
    GOTO :MAIN
) ELSE IF %A% EQU 4 (
    REM Found 25 coins.
    SET /A COINS=!COINS! +25
    SET displayMessage=Found 25 coins!
    GOTO :MAIN
) ELSE IF %A% EQU 5 (
    REM Bandit encounter.
    set currentEnemy=iBandit
    CALL "%cd%\data\Combat Engine\scripts\evie.bat"
    GOTO :MAIN
) ELSE IF %A% EQU 6 (
    REM Jester encounter.
    SET currentEnemy=iJester
    CALL "%cd%\data\Combat Engine\scripts\evie.bat"
    GOTO :MAIN
) ELSE IF %A% EQU 7 (
    REM Gnome encounter.
    SET currentEnemy=iGnome
    CALL "%cd%\data\Combat Engine\scripts\evie.bat"
    GOTO :MAIN
) ELSE IF %A% EQU 8 (
    REM Hunter encounter.
    SET currentEnemy=iHunter
    CALL "%cd%\data\Combat Engine\scripts\evie.bat"
    GOTO :MAIN
) ELSE IF %A% EQU 9 (
    REM Goblin encounter.
    SET currentEnemy=iGoblin
    CALL "%cd%\data\Combat Engine\scripts\evie.bat"
    GOTO :MAIN
) ELSE IF %A% EQU 10 (
    REM Found 100 coins.
    SET /A COINS=!COINS! +100
    SET displayMessage=Found 100 coins!
    GOTO :MAIN
) ELSE IF %A% EQU 11 (
    REM Found nothing.
    SET displayMessage=You didn't find anything.
    GOTO :MAIN
) ELSE IF %A% EQU 12 (
    REM Gabriel Aberdeen encounter.
    IF %gabrial_aberdeen_added_party% == true (
        SET displayMessage=You didn't find anything.
        GOTO :MAIN
    ) ELSE (
        SET NE=GabrielAberdeen
        CALL "%cd%\data\Exploration Engine\scripts\npcadd.bat"
        GOTO :MAIN
    )
    GOTO :MAIN
) ELSE IF %A% EQU 13 (
    REM Found nothing.
    SET displayMessage=You didn't find anything.
    GOTO :MAIN
) ELSE IF %A% EQU 14 (
    REM Found nothing.
    SET displayMessage=You didn't find anything.
    GOTO :MAIN
) ELSE IF %A% EQU 15 (
    REM Gary Morcant encounter.
    IF %gary_morcant_added_party% == true (
        SET displayMessage=You didn't find anything.
        GOTO :MAIN
    ) ELSE (
        SET NE=GaryMorcant
        CALL "%cd%\data\Exploration Engine\scripts\npcadd.bat"
        GOTO :MAIN
    )
) ELSE (
    REM Found nothing.
    SET displayMessage=You didn't find anything.
    GOTO :MAIN
)

REM Checks if the Player has unlocked this location.
:CHECK_RUINS_UNLOCKED
IF %ruins_unlocked% EQU 1 (
    REM Ruins have been unlocked.
    GOTO :EXPLORE_RUINS
) ELSE (
    REM Ruins have not been unlocked.
    SET displayMessage=You can't explore here yet! Unlock this location at the Wizard.
    GOTO :MAIN
)

REM Unfinished. Need more enemies.
:EXPLORE_RUINS
SET bl=Ruins
SET /A A=%RANDOM% %%5
IF %A% GTR 3 (
    REM Golem Encounter.
    SET currentEnemy=iGolem
    CALL "%cd%\data\Combat Engine\scripts\evie.bat"
    GOTO :MAIN
) ELSE (
    REM Found nothing.
    SET displayMessage=You didn't find anything.
    GOTO :MAIN
)

REM Enters the Rockwinn Plaza.
:ROCKWINN_PLAZA
CALL "%cd%\data\Exploration Engine\scripts\Rockwinn Plaza.bat"
GOTO :MAIN

REM Launches the Party Manager.
:PARTY_MANAGER
CALL "%cd%\data\Exploration Engine\scripts\pm.bat"
GOTO :MAIN

REM Saves the game before returning to WINDHELM.
:AUTOSAVE
SET SLOPr=SAVE
CALL "%cd%\data\functions\SLOP.bat"
GOTO :EOF