@ECHO OFF

REM Main Menu.
:MAIN
MODE con: cols=130 lines=26
CLS
ECHO.
TYPE "%cd%\data\assets\ui\pm.txt"
ECHO.
ECHO %displayMessage%
ECHO +--------------------------------------------------------------------------------------------------------------------------------+
ECHO ^| HP: %player_health% ^| STM: %player_stamina% ^| ATK: %player_damage% ^| AMR: %player_armor% ^| MGK: %player_magicka% ^| LEVEL: %player_level% ^| XP: %player_xp% ^| COINS: %player_coins% ^| LUNIS: %player_lunis%
ECHO +--------------------------------------------------------------------------------------------------------------------------------+
ECHO ^| FOLLOWER: %follower_name% ^| HP: %follower_health% ^| ATK: %follower_attack% ^| STM: %follower_stamina% ^| MGK: %follower_magicka% ^| LVL: %follower_level%
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
TYPE "%cd%\data\assets\ui\pm_ss.txt"
ECHO.
ECHO %displayMessage%
ECHO +-------------------------------------------------------------------------------------------------------+
ECHO ^| HP: %player_health% ^| STM: %player_stamina% ^| ATK: %player_damage% ^| AMR: %player_armor% ^| MGK: %player_magicka% ^| LEVEL: %player_level% ^| XP: %player_xp% ^| COINS: %player_coins% ^| LUNIS: %player_lunis%
ECHO +--------------------------------------------------------------------------------------------------------------------------------+
ECHO ^| FOLLOWER: %follower_name% ^| HP: %follower_health% ^| ATK: %follower_attack% ^| STM: %follower_stamina% ^| MGK: %follower_magicka% ^| LVL: %follower_level%
ECHO +-------------------------------------------------------------------------------------------------------+
ECHO + [1 / SLOT 2 ] ^| [2 / SLOT 3 ] ^| [E / CANCEL ]
ECHO +-------------------------------------------------------------------------------------------------------+
CHOICE /C 12E /N /M ">"
IF ERRORLEVEL 3 GOTO :MAIN
IF ERRORLEVEL 2 GOTO :PM_CHECK_SLOT3_FROM1
IF ERRORLEVEL 1 GOTO :PM_CHECK_SLOT2_FROM1

:PM_CHECK_SLOT2_FROM1
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

:PM_CHECK_SLOT3_FROM1
REM Checks if the selected slot is vacant.
IF NOT %PM3name% == VACANT (
    REM Slot is occuppied, store Slot 1 & 3 data in temp variables and swap them.
    SET PM1name_t=%PM1name%
    SET PM1ATK_t=%PM1ATK%
    SET PM1STM_t=%PM1STM%
    SET PM1MGK_t=%PM1MGK%
    SET PM1HP_t=%PM1HP%
    SET PM3name_t=%PM3name%
    SET PM3ATK_t=%PM3ATK%
    SET PM3STM_t=%PM3STM%
    SET PM3MGK_t=%PM3MGK%
    SET PM3HP_t=%PM3HP%
    REM Now swap them.
    SET PM3name=%PM1name_t%
    SET PM3ATK=%PM1ATK_t%
    SET PM3STM=%PM1STM_t%
    SET PM3MGK=%PM1MGK_t%
    SET PM3HP=%PM1HP_t%
    SET PM1name=%PM3name_t%
    SET PM1ATK=%PM3ATK_t%
    SET PM1STM=%PM3STM_t%
    SET PM1MGK=%PM3MGK_t%
    SET PM1HP=%PM3HP_t%
    SET displayMessage=Swapped Slot 1 and 3.
    GOTO :MAIN
) ELSE (
    REM Slot 3 was vacant, so just move slot 1 data over.
    SET PM3name=%PM1name%
    SET PM3ATK=%PM1ATK%
    SET PM3STM=%PM1STM%
    SET PM3MGK=%PM1MGK%
    SET PM3HP=%PM1HP%
    SET PM1name=VACANT
    SET PM1ATK=0
    SET PM1STM=0
    SET PM1MGK=0
    SET PM1HP=0
    SET displayMessage=Moved %PM3name% to slot 3.
    GOTO :MAIN
)

REM Asks the Player to select which slot to move Slot 2 to.
:PM_MOVE_SLOT2
IF %PM2name% == VACANT (
    REM This slot is empty...
    SET displayMessage=The selected slot is empty.
    GOTO :MAIN
)
MODE con: cols=105 lines=24
CLS
ECHO.
TYPE "%cd%\data\assets\ui\pm_ss.txt"
ECHO.
ECHO %displayMessage%
ECHO +-------------------------------------------------------------------------------------------------------+
ECHO ^| HP: %player_health% ^| STM: %player_stamina% ^| ATK: %player_damage% ^| AMR: %player_armor% ^| MGK: %player_magicka% ^| LEVEL: %player_level% ^| XP: %player_xp% ^| COINS: %player_coins% ^| LUNIS: %player_lunis%
ECHO +--------------------------------------------------------------------------------------------------------------------------------+
ECHO ^| FOLLOWER: %follower_name% ^| HP: %follower_health% ^| ATK: %follower_attack% ^| STM: %follower_stamina% ^| MGK: %follower_magicka% ^| LVL: %follower_level%
ECHO +-------------------------------------------------------------------------------------------------------+
ECHO + [1 / SLOT 1 ] ^| [2 / SLOT 3 ] ^| [E / CANCEL ]
ECHO +-------------------------------------------------------------------------------------------------------+
CHOICE /C 12E /N /M ">"
IF ERRORLEVEL 3 GOTO :MAIN
IF ERRORLEVEL 2 GOTO :PM_CHECK_SLOT3_FROM2
IF ERRORLEVEL 1 GOTO :PM_CHECK_SLOT1_FROM2

:PM_CHECK_SLOT1_FROM2
REM Checks if the selected slot is vacant.
IF NOT %PM2name% == VACANT (
    REM Slot is occuppied, store Slot 1 & 2 data in temp variables and swap them.
    SET PM2name_t=%PM2name%
    SET PM2ATK_t=%PM2ATK%
    SET PM2STM_t=%PM2STM%
    SET PM2MGK_t=%PM2MGK%
    SET PM2HP_t=%PM2HP%
    SET PM1name_t=%PM1name%
    SET PM1ATK_t=%PM1ATK%
    SET PM1STM_t=%PM1STM%
    SET PM1MGK_t=%PM1MGK%
    SET PM1HP_t=%PM1HP%
    REM Now swap them.
    SET PM1name=%PM2name_t%
    SET PM1ATK=%PM2ATK_t%
    SET PM1STM=%PM2STM_t%
    SET PM1MGK=%PM2MGK_t%
    SET PM1HP=%PM2HP_t%
    SET PM2name=%PM1name_t%
    SET PM2ATK=%PM1ATK_t%
    SET PM2STM=%PM1STM_t%
    SET PM2MGK=%PM1MGK_t%
    SET PM2HP=%PM1HP_t%
    SET displayMessage=Swapped Slot 1 and 2.
    GOTO :MAIN
) ELSE (
    REM Slot 2 was vacant, so just move slot 1 data over.
    SET PM1name=%PM2name%
    SET PM1ATK=%PM2ATK%
    SET PM1STM=%PM2STM%
    SET PM1MGK=%PM2MGK%
    SET PM1HP=%PM2HP%
    SET PM2name=VACANT
    SET PM2ATK=0
    SET PM2STM=0
    SET PM2MGK=0
    SET PM2HP=0
    SET displayMessage=Moved %PM1name% to slot 1.
    GOTO :MAIN
)