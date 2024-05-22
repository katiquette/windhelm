@ECHO OFF
REM Party Manager. Version 1.0 (240221) - For Windhelm beta build 2 "Bottle o' Features".

REM Main Menu.
:MAIN
MODE con: cols=130 lines=26
CLS
ECHO.
TYPE "%cd%\data\ascii\menus\pm.txt"
ECHO.
ECHO %displayMessage%
ECHO +--------------------------------------------------------------------------------------------------------------------------------+
ECHO ^| HP: %HP% ^| STM: %stamina% ^| ATK: %player_damage% ^| AMR: %armor_equip% ^| MGK: %magicka% ^| AP %player_action_p% ^| COINS: %COINS%
ECHO +--------------------------------------------------------------------------------------------------------------------------------+
ECHO ^| PARTY 1: %PM1name% ^| HP: %PM1HP% ^| ATK: %PM1ATK% ^| STM: %PM1STM% ^| MGK: %PM1MGK%
ECHO ^| PARTY 2: %PM2name% ^| HP: %PM2HP% ^| ATK: %PM2ATK% ^| STM: %PM2STM% ^| MGK: %PM2MGK%
ECHO ^| PARTY 3: %PM3name% ^| HP: %PM3HP% ^| ATK: %PM3ATK% ^| STM: %PM3STM% ^| MGK: %PM3MGK%
ECHO +--------------------------------------------------------------------------------------------------------------------------------+
ECHO + [1 / MOVE SLOT 1 ] ^| [2 / MOVE SLOT 2 ] ^| [3 / MOVE SLOT 3 ] ^| [E / EXIT ]
ECHO +--------------------------------------------------------------------------------------------------------------------------------+
CHOICE /C 123E /N /M ">"
IF ERRORLEVEL 4 GOTO :EOF
IF ERRORLEVEL 3 GOTO :PM_MOVE_SLOT3
IF ERRORLEVEL 2 GOTO :PM_MOVE_SLOT2
IF ERRORLEVEL 1 GOTO :PM_MOVE_SLOT1

REM Asks the Player to select which slot to move Slot 1 to.
:PM_MOVE_SLOT1
IF %PM1name% == VACANT (
    REM This slot is empty...
    SET displayMessage=The selected slot is empty.
    GOTO :MAIN
)
MODE con: cols=105 lines=24
CLS
ECHO.
TYPE "%cd%\data\ascii\menus\pm_ss.txt"
ECHO.
ECHO %displayMessage%
ECHO +-------------------------------------------------------------------------------------------------------+
ECHO ^| HP: %HP% ^| STM: %stamina% ^| ATK: %player_damage% ^| AMR: %armor_equip% ^| MGK: %magicka% ^| AP %player_action_p% ^| COINS: %COINS%
ECHO +-------------------------------------------------------------------------------------------------------+
ECHO ^| PARTY 1: %PM1name% ^| HP: %PM1HP% ^| ATK: %PM1ATK% ^| STM: %PM1STM% ^| MGK: %PM1MGK%
ECHO ^| PARTY 2: %PM2name% ^| HP: %PM2HP% ^| ATK: %PM2ATK% ^| STM: %PM2STM% ^| MGK: %PM2MGK%
ECHO ^| PARTY 3: %PM3name% ^| HP: %PM3HP% ^| ATK: %PM3ATK% ^| STM: %PM3STM% ^| MGK: %PM3MGK%
ECHO +-------------------------------------------------------------------------------------------------------+
ECHO + [1 / SLOT 2 ] ^| [2 / SLOT 3 ] ^| [E / CANCEL ]
ECHO +-------------------------------------------------------------------------------------------------------+
CHOICE /C 12E /N /M ">"
IF ERRORLEVEL 3 GOTO :MAIN
IF ERRORLEVEL 2 GOTO :PM_CHECK_SLOT3
IF ERRORLEVEL 1 GOTO :PM_CHECK_SLOT2

:PM_CHECK_SLOT2
REM Checks if the selected slot is vacant.
IF NOT %PM2name% == VACANT (
    REM Slot is occuppied, store Slot 1 & 2 data in temp variables and swap them.
    SET PM1name_t=%PM1name%
    SET PM1ATK_t=%PM1ATK%
    SET PM1STM_t=%PM1STM%
    SET PM1MGK_t=%PM1MGK%
    SET PM1HP_t=%PM1HP%
    SET PM2name_t=%PM2name%
    SET PM2ATK_t=%PM2ATK%
    SET PM2STM_t=%PM2STM%
    SET PM2MGK_t=%PM2MGK%
    SET PM2HP_t=%PM2HP%
    REM Now swap them.
    SET PM2name=%PM1name_t%
    SET PM2ATK=%PM1ATK_t%
    SET PM2STM=%PM1STM_t%
    SET PM2MGK=%PM1MGK_t%
    SET PM2HP=%PM1HP_t%
    SET PM1name=%PM2name_t%
    SET PM1ATK=%PM2ATK_t%
    SET PM1STM=%PM2STM_t%
    SET PM1MGK=%PM2MGK_t%
    SET PM1HP=%PM2HP_t%
    SET displayMessage=Swapped Slot 1 and 2.
    GOTO :MAIN
) ELSE (
    REM Slot 2 was vacant, so just move slot 1 data over.
    SET PM2name=%PM1name%
    SET PM2ATK=%PM1ATK%
    SET PM2STM=%PM1STM%
    SET PM2MGK=%PM1MGK%
    SET PM2HP=%PM1HP%
    SET PM1name=VACANT
    SET PM1ATK=0
    SET PM1STM=0
    SET PM1MGK=0
    SET PM1HP=0
    SET displayMessage=Moved %PM2name% to slot 2.
    GOTO :MAIN
)