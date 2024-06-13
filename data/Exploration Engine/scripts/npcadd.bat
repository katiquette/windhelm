@ECHO OFF

REM Check which NPC the Player is attempting to recruit.
IF %NE% == ClarkeBlackwell (
    REM Clarke Blackwell
    GOTO :CB
) ELSE IF %NE% == GaryMorcant (
    REM Gray Morcant
    GOTO :GM
) ELSE IF %NE% == GabrielAberdeen (
    REM Gabriel Aberdeen
    GOTO :GA
) ELSE (
    REM Error.
    GOTO :EOF
)

REM Clarke Blackwell menu selection.
:CB
MODE con: cols=126 lines=21
CLS
ECHO.
TYPE "%cd%\data\assets\npcs\clarkeblackwell.txt"
ECHO.
ECHO %displayMessage%
ECHO +----------------------------------------------------------------------------------------------------------------------------+
ECHO ^| HP: %player_health% ^| STM: %player_stamina% ^| ATK: %player_damage% ^| AMR: %player_armor% ^| MGK: %player_magicka% ^| LEVEL: %player_level% ^| XP: %player_xp% ^| COINS: %player_coins% ^| LUNIS: %player_lunis%
ECHO +--------------------------------------------------------------------------------------------------------------------------------+
ECHO ^| FOLLOWER: %follower_name% ^| HP: %follower_health% ^| ATK: %follower_attack% ^| STM: %follower_stamina% ^| MGK: %follower_magicka% ^| LVL: %follower_level%
ECHO +----------------------------------------------------------------------------------------------------------------------------+
ECHO + [1 / RECRUIT CLARKE BLACKWELL ] ^| [E / GO BACK ]                                                                           +
ECHO +----------------------------------------------------------------------------------------------------------------------------+
CHOICE /C 1E /N /M ">"
IF ERRORLEVEL 2 GOTO :EOF
IF ERRORLEVEL 1 GOTO :CB_SELECT_SLOT

REM Checks if this NPC has already been recruited.
:CHECK_CLARKE_REQUIREMENTS
IF %player_reputation% GEQ 10 (
    REM The Player's reputation is high enough to recruit this NPC.
    IF %speech_skill% GEQ 5 (
        IF %player_class% == Sorcerer (
            REM The Player class is an excluded class and cannot recruit this NPC.
            SET canRecruit=false
            SET recruitReason=class
            SET displayMessage=Cannot recruit this NPC, Class exclusion: Sorcerer.
            GOTO :CB
        ) ELSE (
            REM The Player class is not an excluded class and can recruit this NPC.
            SET canRecruit=true
            GOTO :CB_SELECT_SLOT
        )
    ) ELSE (
        REM The Player's speech skill is not high enough to recruit this NPC.
        SET canRecruit=false
        SET recruitReason=speech
        SET displayMessage=Cannot recruit this NPC, Speech skill: too low.
        GOTO :CB
    )
) ELSE (
    REM The Player's reputation is not high enough to recruit this NPC.
    SET canRecruit=false
    SET recruitReason=reputation
    SET displayMessage=Cannot recruit this NPC, Reputation: too low.
    GOTO :CB
)

REM Select the slot to place Clarke Blackwell.
:CB_SELECT_SLOT
MODE con: cols=126 lines=22
CLS
ECHO.
TYPE "%cd%\data\assets\ui\pm_ss.txt"
ECHO.
ECHO Select a slot for Clarke Blackwell.
ECHO %displayMessage%
ECHO +----------------------------------------------------------------------------------------------------------------------------+
ECHO ^| HP: %player_health% ^| STM: %player_stamina% ^| ATK: %player_damage% ^| AMR: %player_armor% ^| MGK: %player_magicka% ^| LEVEL: %player_level% ^| XP: %player_xp% ^| COINS: %player_coins% ^| LUNIS: %player_lunis%
ECHO +--------------------------------------------------------------------------------------------------------------------------------+
ECHO ^| FOLLOWER: %follower_name% ^| HP: %follower_health% ^| ATK: %follower_attack% ^| STM: %follower_stamina% ^| MGK: %follower_magicka% ^| LVL: %follower_level%
ECHO +----------------------------------------------------------------------------------------------------------------------------+
ECHO + [1 / SLOT 1 ] ^| [2 / SLOT 2 ] ^| [3 / SLOT 3 ] ^| [E / GO BACK ]                                                             +
ECHO +----------------------------------------------------------------------------------------------------------------------------+
CHOICE /C 123E /N /M ">"
IF ERRORLEVEL 4 GOTO :EOF
IF ERRORLEVEL 3 GOTO :CB_SLOT_3
IF ERRORLEVEL 2 GOTO :CB_SLOT_2
IF ERRORLEVEL 1 GOTO :CB_SLOT_1

REM Check that this slot is empty.
:CB_SLOT_1
IF NOT "%PM1name%" == "VACANT" (
    REM This slot is occupied.
    SET displayMessage=This slot is occupied.
    GOTO :CB_SELECT_SLOT
) ELSE (
    REM This slot is vacant.
    SET PM1name=Clarke Blackwell
    SET PM1HP=%CB_HEL%
    SET PM1ATK=%CB_DMG%
    SET PM1STM=%CB_STM%
    SET PM1MGK=%CB_MGK%
    SET clarke_blackwell_added_party=true
    SET displayMessage=Added Clarke Blackwell to Party Slot 1.
    GOTO :EOF
)

REM Check that this slot is empty.
:CB_SLOT_2
IF NOT "%PM2name%" == "VACANT" (
    REM This slot is occupied.
    SET displayMessage=This slot is occupied.
    GOTO :CB_SELECT_SLOT
) ELSE (
    REM This slot is vacant.
    SET PM2name=Clarke Blackwell
    SET PM2HP=%CB_HEL%
    SET PM2ATK=%CB_DMG%
    SET PM2STM=%CB_STM%
    SET PM2MGK=%CB_MGK%
    SET clarke_blackwell_added_party=true
    SET displayMessage=Added Clarke Blackwell to Party Slot 2.
    GOTO :EOF
)

REM Check that this slot is empty.
:CB_SLOT_3
IF NOT "%PM3name%" == "VACANT" (
    REM This slot is occupied.
    SET displayMessage=This slot is occupied.
    GOTO :CB_SELECT_SLOT
) ELSE (
    REM This slot is vacant.
    SET PM3name=Clarke Blackwell
    SET PM3HP=%CB_HEL%
    SET PM3ATK=%CB_DMG%
    SET PM3STM=%CB_STM%
    SET PM3MGK=%CB_MGK%
    SET clarke_blackwell_added_party=true
    SET displayMessage=Added Clarke Blackwell to Party Slot 3.
    GOTO :EOF
)

REM Gary Morcant menu selection.
:GM
MODE con: cols=117 lines=24
CLS
ECHO.
TYPE "%cd%\data\ascii\npcs\garymorcant.txt"
ECHO.
ECHO %displayMessage%
ECHO +-------------------------------------------------------------------------------------------------------------------+
ECHO ^| HP: %player_health% ^| STM: %player_stamina% ^| ATK: %player_damage% ^| AMR: %player_armor% ^| MGK: %player_magicka% ^| LEVEL: %player_level% ^| XP: %player_xp% ^| COINS: %player_coins% ^| LUNIS: %player_lunis%
ECHO +--------------------------------------------------------------------------------------------------------------------------------+
ECHO ^| FOLLOWER: %follower_name% ^| HP: %follower_health% ^| ATK: %follower_attack% ^| STM: %follower_stamina% ^| MGK: %follower_magicka% ^| LVL: %follower_level%
ECHO +-------------------------------------------------------------------------------------------------------------------+
ECHO + [1 / RECRUIT GARY MORCANT ] ^| [E / GO BACK ]                                                                      +
ECHO +-------------------------------------------------------------------------------------------------------------------+
CHOICE /C 1E /N /M ">"
IF ERRORLEVEL 2 GOTO :EOF
IF ERRORLEVEL 1 GOTO :GM_SELECT_SLOT

REM Checks if this NPC has already been recruited.
:CHECK_GARY_REQUIREMENTS
IF %player_reputation% GEQ 25 (
    REM The Player's reputation is high enough to recruit this NPC.
    IF %speech_skill% GEQ 4 (
        IF %player_class% == Druid (
            REM The Player class is an excluded class and cannot recruit this NPC.
            SET canRecruit=false
            SET recruitReason=class
            GOTO :GM
        ) ELSE (
            REM The Player class is not an excluded class and can recruit this NPC.
            SET canRecruit=true
            GOTO :GM_SELECT_SLOT
        )
    ) ELSE (
        REM The Player's speech skill is not high enough to recruit this NPC.
        SET canRecruit=false
        SET recruitReason=speech
        GOTO :GM
    )
) ELSE (
    REM The Player's reputation is not high enough to recruit this NPC.
    SET canRecruit=false
    SET recruitReason=reputation
    GOTO :GM
)

REM Select the slot to place Gary Morcant.
:GM_SELECT_SLOT
MODE con: cols=126 lines=22
CLS
ECHO.
TYPE "%cd%\data\assets\ui\pm_ss.txt"
ECHO.
ECHO Select a slot for Gary Morcant.
ECHO %displayMessage%
ECHO +----------------------------------------------------------------------------------------------------------------------------+
ECHO ^| HP: %player_health% ^| STM: %player_stamina% ^| ATK: %player_damage% ^| AMR: %player_armor% ^| MGK: %player_magicka% ^| LEVEL: %player_level% ^| XP: %player_xp% ^| COINS: %player_coins% ^| LUNIS: %player_lunis%
ECHO +--------------------------------------------------------------------------------------------------------------------------------+
ECHO ^| FOLLOWER: %follower_name% ^| HP: %follower_health% ^| ATK: %follower_attack% ^| STM: %follower_stamina% ^| MGK: %follower_magicka% ^| LVL: %follower_level%
ECHO +----------------------------------------------------------------------------------------------------------------------------+
ECHO + [1 / SLOT 1 ] ^| [2 / SLOT 2 ] ^| [3 / SLOT 3 ] ^| [E / GO BACK ]                                                             +
ECHO +----------------------------------------------------------------------------------------------------------------------------+
CHOICE /C 123E /N /M ">"
IF ERRORLEVEL 4 GOTO :EOF
IF ERRORLEVEL 3 GOTO :GM_SLOT_3
IF ERRORLEVEL 2 GOTO :GM_SLOT_2
IF ERRORLEVEL 1 GOTO :GM_SLOT_1

REM Check that this slot is empty.
:GM_SLOT_1
IF NOT "%PM1name%" == "VACANT" (
    REM This slot is occupied.
    SET displayMessage=This slot is occupied.
    GOTO :GM_SELECT_SLOT
) ELSE (
    REM This slot is vacant.
    SET PM1name=Gary Morcant
    SET PM1HP=%GM_HEL%
    SET PM1ATK=%GM_DMG%
    SET PM1STM=%GM_STM%
    SET PM1MGK=%GM_MGK%
    SET gary_morcant_added_party=true
    SET displayMessage=Added Gary Morcant to Party Slot 1.
    GOTO :EOF
)

REM Check that this slot is empty.
:GM_SLOT_2
IF NOT "%PM2name%" == "VACANT" (
    REM This slot is occupied.
    SET displayMessage=This slot is occupied.
    GOTO :GM_SELECT_SLOT
) ELSE (
    REM This slot is vacant.
    SET PM2name=Gary Morcant
    SET PM2HP=%GM_HEL%
    SET PM2ATK=%GM_DMG%
    SET PM2STM=%GM_STM%
    SET PM2MGK=%GM_MGK%
    SET gary_morcant_added_party=true
    SET displayMessage=Added Gary Morcant to Party Slot 2.
    GOTO :EOF
)

REM Check that this slot is empty.
:GM_SLOT_3
IF NOT "%PM3name%" == "VACANT" (
    REM This slot is occupied.
    SET displayMessage=This slot is occupied.
    GOTO :GM_SELECT_SLOT
) ELSE (
    REM This slot is vacant.
    SET PM3name=Gary Morcant
    SET PM3HP=%GM_HEL%
    SET PM3ATK=%GM_DMG%
    SET PM3STM=%GM_STM%
    SET PM3MGK=%GM_MGK%
    SET gary_morcant_added_party=true
    SET displayMessage=Added Gary Morcant to Party Slot 3.
    GOTO :EOF
)

REM Gabriel Aberdeen menu selection.
:GA
MODE con: cols=144 lines=21
CLS
ECHO.
TYPE "%cd%\data\ascii\npcs\gabrielaberdeen.txt"
ECHO.
ECHO %displayMessage%
ECHO +----------------------------------------------------------------------------------------------------------------------------------------------+
ECHO ^| HP: %player_health% ^| STM: %player_stamina% ^| ATK: %player_damage% ^| AMR: %player_armor% ^| MGK: %player_magicka% ^| LEVEL: %player_level% ^| XP: %player_xp% ^| COINS: %player_coins% ^| LUNIS: %player_lunis%
ECHO +--------------------------------------------------------------------------------------------------------------------------------+
ECHO ^| FOLLOWER: %follower_name% ^| HP: %follower_health% ^| ATK: %follower_attack% ^| STM: %follower_stamina% ^| MGK: %follower_magicka% ^| LVL: %follower_level%
ECHO +----------------------------------------------------------------------------------------------------------------------------------------------+
ECHO + [1 / RECRUIT GABRIEL ABERDEEN ] ^| [E / GO BACK ]                                                                                             +
ECHO +----------------------------------------------------------------------------------------------------------------------------------------------+
CHOICE /C 1E /N /M ">"
IF ERRORLEVEL 2 GOTO :EOF
IF ERRORLEVEL 1 GOTO :GA_SELECT_SLOT

REM Checks if this NPC has already been recruited.
:CHECK_GABRIEL_REQUIREMENTS
IF %player_reputation% GEQ 5 (
    REM The Player's reputation is high enough to recruit this NPC.
    IF %speech_skill% GEQ 2 (
        IF %player_class% == Warrior (
            REM The Player class is an excluded class and cannot recruit this NPC.
            SET canRecruit=false
            SET recruitReason=class
            GOTO :GA
        ) ELSE (
            REM The Player class is not an excluded class and can recruit this NPC.
            SET canRecruit=true
            GOTO :GA_SELECT_SLOT
        )
    ) ELSE (
        REM The Player's speech skill is not high enough to recruit this NPC.
        SET canRecruit=false
        SET recruitReason=speech
        GOTO :GA
    )
) ELSE (
    REM The Player's reputation is not high enough to recruit this NPC.
    SET canRecruit=false
    SET recruitReason=reputation
    GOTO :GA
)

REM Select the slot to place Gabriel Aberdeen.
:GA_SELECT_SLOT
MODE con: cols=126 lines=22
CLS
ECHO.
TYPE "%cd%\data\assets\ui\pm_ss.txt"
ECHO.
ECHO Select a slot for Gabriel  Aberdeen.
ECHO %displayMessage%
ECHO +----------------------------------------------------------------------------------------------------------------------------+
ECHO ^| HP: %player_health% ^| STM: %player_stamina% ^| ATK: %player_damage% ^| AMR: %player_armor% ^| MGK: %player_magicka% ^| LEVEL: %player_level% ^| XP: %player_xp% ^| COINS: %player_coins% ^| LUNIS: %player_lunis%
ECHO +--------------------------------------------------------------------------------------------------------------------------------+
ECHO ^| FOLLOWER: %follower_name% ^| HP: %follower_health% ^| ATK: %follower_attack% ^| STM: %follower_stamina% ^| MGK: %follower_magicka% ^| LVL: %follower_level%
ECHO +----------------------------------------------------------------------------------------------------------------------------+
ECHO + [1 / SLOT 1 ] ^| [2 / SLOT 2 ] ^| [3 / SLOT 3 ] ^| [E / GO BACK ]                                                             +
ECHO +----------------------------------------------------------------------------------------------------------------------------+
CHOICE /C 123E /N /M ">"
IF ERRORLEVEL 4 GOTO :EOF
IF ERRORLEVEL 3 GOTO :GA_SLOT_3
IF ERRORLEVEL 2 GOTO :GA_SLOT_2
IF ERRORLEVEL 1 GOTO :GA_SLOT_1

REM Check that this slot is empty.
:GA_SLOT_1
IF NOT "%PM1name%" == "VACANT" (
    REM This slot is occupied.
    SET displayMessage=This slot is occupied.
    GOTO :GA_SELECT_SLOT
) ELSE (
    REM This slot is vacant.
    SET PM1name=Gabriel Aberdeen
    SET PM1HP=%GA_HEL%
    SET PM1ATK=%GA_DMG%
    SET PM1STM=%GA_STM%
    SET PM1MGK=%GA_MGK%
    SET gabrial_aberdeen_added_party=true
    SET displayMessage=Added Gabriel Aberdeen to Party Slot 1.
    GOTO :EOF
)

REM Check that this slot is empty.
:GA_SLOT_2
IF NOT "%PM2name%" == "VACANT" (
    REM This slot is occupied.
    SET displayMessage=This slot is occupied.
    GOTO :GA_SELECT_SLOT
) ELSE (
    REM This slot is vacant.
    SET PM2name=Gabriel Aberdeen
    SET PM2HP=%GA_HEL%
    SET PM2ATK=%GA_DMG%
    SET PM2STM=%GA_STM%
    SET PM2MGK=%GA_MGK%
    SET gabrial_aberdeen_added_party=true
    SET displayMessage=Added Gabriel Aberdeen to Party Slot 2.
    GOTO :EOF
)

REM Check that this slot is empty.
:GA_SLOT_3
IF NOT "%PM3name%" == "VACANT" (
    REM This slot is occupied.
    SET displayMessage=This slot is occupied.
    GOTO :GA_SELECT_SLOT
) ELSE (
    REM This slot is vacant.
    SET PM3name=Gabriel Aberdeen
    SET PM3HP=%GA_HEL%
    SET PM3ATK=%GA_DMG%
    SET PM3STM=%GA_STM%
    SET PM3MGK=%GA_MGK%
    SET gabrial_aberdeen_added_party=true
    SET displayMessage=Added Gabriel Aberdeen to Party Slot 3.
    GOTO :EOF
)