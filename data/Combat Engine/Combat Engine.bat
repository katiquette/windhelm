@ECHO OFF
MODE con: cols=120 lines=29
REM Combat Engine Beta Version 7.0 (240228) - for Windhelm Build 2 "Bottle o' Features"

REM "Enemy Battle Screen", where Player and Enemy information is displayed. Used for all enemies.
:EBS
TITLE (COMBAT ENGINE 7) %bl% ^| %player_name% the %player_class% vs %curEn% 
REM Reset the attack value after armor calculation to prevent negative damage values.
SET enAT=%enATb%
REM Win/Lose check.
IF %enHP% LEQ 0 GOTO :check_achievement 
IF %HP% LEQ 0 GOTO :defeat
REM Clear the screen.
CLS
REM Write the data from the text file to the CLI.
ECHO.
TYPE "%cd%\data\ascii\enemies\%curEn%.txt"
ECHO.
ECHO +---------------------------------------------------------------------------------------------------------------------+
ECHO ^|                             HP: %enHP% ^| ATK: %enAT% ^| STM: %enSTM%
ECHO ^| %displayMessage%
ECHO +---------------------------------------------------------------------------------------------------------------------+
ECHO ^| HP: %HP% ^| STM: %stamina% ^| ATK: %player_damage% ^| AMR: %armor_equip% ^| MGK: %magicka% ^| AP %player_action_p%
ECHO +---------------------------------------------------------------------------------------------------------------------+
ECHO ^| PARTY 1: %PM1name% ^| HP: %PM1HP% ^| ATK: %PM1ATK% ^| STM: %PM1STM% ^| MGK: %PM1MGK%
ECHO ^| PARTY 2: %PM2name% ^| HP: %PM2HP% ^| ATK: %PM2ATK% ^| STM: %PM2STM% ^| MGK: %PM2MGK%
ECHO ^| PARTY 3: %PM3name% ^| HP: %PM3HP% ^| ATK: %PM3ATK% ^| STM: %PM3STM% ^| MGK: %PM3MGK%
ECHO +---------------------------------------------------------------------------------------------------------------------+
ECHO ^| [I] ITEMS  ^| [E] SKIP    ^| %plrMessage%
ECHO ^|            ^|             ^| %pInfo%
ECHO ^| [A] ATTACK ^| [H] HVY ATK ^| [F] FLEE                                                                                 +
ECHO +---------------------------------------------------------------------------------------------------------------------+   
CHOICE /C IASHF /N /M ">"
IF ERRORLEVEL 5 GOTO :PLAYER_FLEE
IF ERRORLEVEL 4 GOTO :PLAYER_HA_ACTION_POINT_CHECK
IF ERRORLEVEL 3 GOTO :PLAYER_SKIP_ATTACK
IF ERRORLEVEL 2 GOTO :PLAYER_LA_ACTION_POINT_CHECK
IF ERRORLEVEL 1 GOTO :PLAYER_INVENTORY

REM Combat Engine 7 codename "Stinger" combat logic.

REM Check Action Points before performing a normal attack.
:PLAYER_LA_ACTION_POINT_CHECK
IF %player_action_p% LSS 5 (
    REM The Player does not have enough action points to perform this attack.
    SET plrMessage=You do not have enough Action Points.
    GOTO :EBS
) ELSE (
    REM The Player has enough action points to perform this attack.
    SET heavyAttack=0
    SET /A player_action_p=!player_action_p! -4
    GOTO :PLAYER_ATTACK_LOGIC
)

REM Check Action Points before performing a heavy attack.
:PLAYER_HA_ACTION_POINT_CHECK
IF %player_action_p% LSS 15 (
    REM The Player does not have enough action points to perform this attack.
    SET plrMessage=You do not have enough action points.
    GOTO :EBS
) ELSE (
    REM The Player has enough action points to perform this attack.
    SET heavyAttack=1
    SET /A player_action_p=!player_action_p! -15
    GOTO :PLAYER_ATTACK_LOGIC
)

REM Checks the Player's stamina and action points before performing attack logic.
:PLAYER_ATTACK_LOGIC
IF %heavyAttack% EQU 1 (
    REM The attack type was heavy, add 12 stamina to required.
    SET /A stamina_equip=!stamina_equip! +12
    REM Check the Player's stamina.
    IF %stamina% LSS %stamina_equip% (
        REM The Player's stamina is too low to perform this attack.
        SET plrMessage=Your stamina is too low to perform this attack.
        REM Reset the stamina_equip variable.
        SET /A stamina_equip=!stamina_equip! -12
        GOTO :EBS
    ) ELSE (
        REM The Player has enough stamina to perform this attack.
        SET heavyAttackCommit=1
        GOTO :PLAYER_ATTACK_COMMIT
    )
) ELSE (
    REM The attack type was normal.
    IF %stamina% LSS %stamina_equip% (
        REM The Player's stamina is too low to perform this attack.
        SET plrMessage=Your stamina is too low to perform this attack.
        GOTO :EBS
    ) ELSE (
        REM The Player has enough stamina to perform this attack.
        SET heavyAttackCommit=0
        GOTO :PLAYER_ATTACK_COMMIT
    )
)

REM Perform attack logic.
:PLAYER_ATTACK_COMMIT
IF %heavyAttackCommit% EQU 1 (
    SET heavyAttackCommit=0
    SET heavyAttack=0
    GOTO :PLAYER_HEAVY_ATTACK_COMMIT
) ELSE (
    GOTO :PLAYER_NORMAL_ATTACK_COMMIT
)

REM Heavy attack type logic.
:PLAYER_HEAVY_ATTACK_COMMIT
SET /A HA=%RANDOM% %%8
IF %HA% LEQ 3 (
    REM Heavy attack missed.
    SET plrMessage=The %curEn% dodged your attack!
    GOTO :PARTY_SLOT_1_CHECK
) ELSE (
    REM Heavy attack hit.
    SET plrMessage=Hit the %curEn%!
    SET /A enHP=!enHP! -%player_damage%*%damage_skill%*4
    GOTO :PARTY_SLOT_1_CHECK
)

REM Normal attack type logic.
:PLAYER_NORMAL_ATTACK_COMMIT
SET /A NA=%RANDOM% %%10
IF %NA% LEQ 4 (
    REM Normal attack missed.
    SET plrMessage=The %curEn% dodged your attack!
    GOTO :PARTY_SLOT_1_CHECK
) ELSE IF %NA% GEQ 8 (
    REM Normal attack critical.
    SET plrMessage=Critical hit on the %curEn%!
    SET /A enHP=!enHP! -%player_damage%*%damage_skill%*2
    GOTO :PARTY_SLOT_1_CHECK
) ELSE (
    REM Normal attack hit.
    SET plrMessage=You hit the %curEn%!
    SET /A enHP=!enHP! -%player_damage%*%damage_skill%
    GOTO :PARTY_SLOT_1_CHECK
)

REM Skips the Player's current attack in cases of low Action Points or Stamina.
:PLAYER_SKIP_ATTACK
SET turnSkipRegen=1
GOTO :PARTY_SLOT_1_CHECK

REM Checks Party Slot 1 for a member. Disables the slot if it is vacant.
:PARTY_SLOT_1_CHECK
IF %PM1name% == VACANT (
    REM This slot is vacant, disable it.
    SET PM1_ATTACK=0
    GOTO :PARTY_SLOT_2_CHECK
) ELSE (
    REM This slot is occupied, enable it.
    SET PM1_ATTACK=1
    GOTO :PARTY_SLOT_2_CHECK
)

REM Checks Party Slot 2 for a member. Disables the slot if it is vacant.
:PARTY_SLOT_2_CHECK
IF %PM2name% == VACANT (
    REM This slot is vacant, disable it.
    SET PM2_ATTACK=0
    GOTO :PARTY_SLOT_3_CHECK
) ELSE (
    REM This slot is occupied, enable it.
    SET PM2_ATTACK=1
    GOTO :PARTY_SLOT_3_CHECK
)

REM Checks Party Slot 3 for a member. Disables the slot if it is vacant.
:PARTY_SLOT_3_CHECK
IF %PM3name% == VACANT (
    REM This slot is vacant, disable it.
    SET PM3_ATTACK=0
    GOTO :PARTY_SLOT_1_COMMIT
) ELSE (
    REM This slot is occupied, enable it.
    SET PM3_ATTACK=1
    GOTO :PARTY_SLOT_1_COMMIT
)

REM Checks this member's health and stamina then performs attack logic.
:PARTY_SLOT_1_COMMIT
IF %PM1_ATTACK% EQU 1 (
    REM This slot is enabled, check health.
    IF %PM1HP% LEQ 0 (
        REM This member's health is too low.
        SET pInfo=%PM1name%'s health is too low.
        GOTO :PARTY_SLOT_2_COMMIT
    ) ELSE (
        REM Check this member's stamina.
        IF %PM1STM% LSS 12 (
            REM This member's stamina is too low.
            SET pInfo=%PM1name%'s stamina is too low.
            GOTO :PARTY_SLOT_2_COMMIT
        ) ELSE (
            REM This member has enough health and stamina to perform an attack.
            REM Perform attack logic.
            SET /A enHP=!enHP! -%PM1ATK%
            GOTO :PARTY_SLOT_2_COMMIT
        )
    )
) ELSE (
    REM This slot is disabled.
    GOTO :PARTY_SLOT_2_COMMIT
)

REM Checks this member's health and stamina then performs attack logic.
:PARTY_SLOT_2_COMMIT
IF %PM2_ATTACK% EQU 1 (
    REM This slot is enabled, check health.
    IF %PM2HP% LEQ 0 (
        REM This member's health is too low.
        SET pInfo=%PM2name%'s health is too low.
        GOTO :PARTY_SLOT_3_COMMIT
    ) ELSE (
        REM Check this member's stamina.
        IF %PM2STM% LSS 12 (
            REM This member's stamina is too low.
            SET pInfo=%PM2name%'s stamina is too low.
            GOTO :PARTY_SLOT_3_COMMIT
        ) ELSE (
            REM This member has enough health and stamina to perform an attack.
            REM Perform attack logic.
            SET /A enHP=!enHP! -%PM2ATK%
            GOTO :PARTY_SLOT_3_COMMIT
        )
    )
) ELSE (
    REM This slot is disabled.
    GOTO :PARTY_SLOT_3_COMMIT
)

:PARTY_SLOT_3_COMMIT
IF %PM3_ATTACK% EQU 1 (
    REM This slot is enabled, check health.
    IF %PM3HP% LEQ 0 (
        REM This member's health is too low.
        SET pInfo=%PM3name%'s health is too low.
        GOTO :PARTY_SLOT_3_COMMIT
    ) ELSE (
        REM Check this member's stamina.
        IF %PM3STM% LSS 12 (
            REM This member's stamina is too low.
            SET pInfo=%PM3name%'s stamina is too low.
            GOTO :PARTY_SLOT_3_COMMIT
        ) ELSE (
            REM This member has enough health and stamina to perform an attack.
            REM Perform attack logic.
            SET /A enHP=!enHP! -%PM3ATK%
            GOTO :armor_calculation
        )
    )
) ELSE (
    REM This slot is disabled.
    GOTO :armor_calculation
)

:armor_calculation
IF %weapon_type% == Ranged (
    SET attack_type=Ranged
) ELSE (
    set attack_type=Melee
)
IF %armorCalculated% GTR 0 (
    GOTO :enemy_attack_calculation
) ELSE (
    IF %armor_equip% GTR 0 (
        SET /A enAT=!enAT! -%armor_equip%
        SET armorCalculated=1
        GOTO :enemy_attack_calculation
    ) ELSE (
        GOTO :enemy_attack_calculation
    )
)

:enemy_attack_calculation
SET /A enAT=!enAT! +%armor_equip%
SET /A AAT=%RANDOM% %%20
IF %attack_type% == Ranged (
    SET /A AAT=!AAT! -3
)
IF %AAT% GTR 17 (
    SET /A hp=!hp! -%enAT%*2
    SET displayMessage=The %curEn% got a crit!
    GOTO :APR
) ELSE IF %AAT% LSS 5 (
    SET displayMessage=The %curEn% narrowly missed!
    GOTO :APR
) ELSE (
    SET /A hp=!hp! -%enAT%
    SET displayMessage=The %curEn% hit you!
    GOTO :APR
)

REM "Action Point Regeneration"
:APR
IF %stamina_skill% EQU 6 (
    SET /A player_action_p=!player_action_p! +20
    GOTO :EBS
) ELSE IF %stamina_skill% EQU 5 (
    SET /A player_action_p=!player_action_p! +17
    GOTO :EBS
) ELSE IF %stamina_skill% EQU 4 (
    SET /A player_action_p=!player_action_p! +14
    GOTO :EBS
) ELSE IF %stamina_skill% EQU 3 (
    SET /A player_action_p=!player_action_p! +11
    GOTO :EBS
) ELSE IF %stamina_skill% EQU 2 (
    SET /A player_action_p=!player_action_p! +8
    GOTO :EBS
)

REM Calculate chance to flee based on Player HP.
:PLAYER_FLEE
SET /A FC=%RANDOM% %%5
IF %FC% EQU 5 (
    IF %hp% GTR 70 (
        REM Check success!
        GOTO :EOF
    ) ELSE (
        REM Check failure!
        SET plrMessage=Your attempt to escape failed!
        GOTO :%curEn%
    )
) ELSE IF %FC% EQU 4 (
    IF %hp% GTR 50 (
        REM Check success!
        GOTO :EOF
    ) ELSE (
        REM Check failure!
        SET plrMessage=Your attempt to escape failed!
        GOTO :%curEn%
    )
) ELSE IF %FC% EQU 3 (
    IF %hp% GTR 30 (
        REM Check success!
        GOTO :EOF
    ) ELSE (
        REM Check failure!
        SET plrMessage=Your attempt to escape failed!
        GOTO :%curEn%
    )
) ELSE IF %FC% EQU 2 (
    IF %hp% GTR 10 (
        REM Check success!
        GOTO :EOF
    ) ELSE (
        REM Check failure!
        SET plrMessage=Your attempt to escape failed!
        GOTO :%curEn%
    )
) ELSE (
    REM General failure!
    SET plrMessage=Your attempt to escape failed!
    GOTO :%curEn%
)

REM Calls the inventory script with a sepcial variable set to allow the consumption of tonics.
:PLAYER_INVENTORY
SET CE7CALL=1
CALL "%cd%\data\functions\Inventory Viewer.bat"
GOTO :EBS

REM Check if the player has the "Defeat the(a)" enemy achievement.
:check_achievement
IF %defeat_bandit_achievement% EQU 0 (
    SET defeat_bandit_achievement=1
    SET plrMessage=Achievement Get. Get Back Here! - Defeat a Bandit.
    GOTO :victory
) ELSE (
    GOTO :victory
)

:ijac
IF %defeat_jester_achievement% EQU 0 (
    SET defeat_jester_achievement=1
    SET plrMessage=Achievement Get. Not so funny! - Defeat a Jester.
    GOTO :victory
) ELSE (
    GOTO :victory
)

:igac
IF %defeat_gnome_achievement% EQU 0 (
    SET defeat_gnome_achievement=1
    SET plrMessage=Achievement Get. Handle with care! - Defeat a Gnome.
    GOTO :victory
) ELSE (
    GOTO :victory
)

:ihac
IF %defeat_hunter_achievement% EQU 0 (
    SET defeat_hunter_achievement=1
    SET plrMessage=Achievement Get. Mutton, chopped! - Defeat a Hunter.
    GOTO :victory
) ELSE (
    GOTO :victory
)

REM GLOBAL VICTORY / DEFEAT MENUS
:victory
REM Reset Health & Stamina, set displayMessage.
SET hp=100
SET stamina=100
SET displayMessage=Defeated a: %curEn%. Replenished HP and Stamina.
CLS
ECHO.
TYPE "%cd%\data\ascii\menus\victory.txt"
ECHO.
ECHO %displayMessage%
ECHO +--------------------------------------------------------------------------------------------------+
ECHO ^| HP: %hp% ^| ATK %player_damage% ^| STM %stamina% ^| ARM: %armor_equip%
ECHO ^| %plrMessage%
ECHO ====================================================================================================
ECHO [1] Loot %curEn% ^| [E] EXIT
CHOICE /C 1E /N /M ">"
IF ERRORLEVEL 2 GOTO :RESET_LOOT
IF ERRORLEVEL 1 GOTO :LOOTING

REM Calls the looting script.
:LOOTING
CALL "%cd%\data\Combat Engine\scripts\ceLoot.bat"
GOTO :victory

:defeat
REM Reset Health & Stamina, set displayMessage.
SET displayMessage=Defeated by: %curEn%, HP and Stamina not replenished.
IF %hp% LSS 0 (
    REM Prevent negative HP values.
    SET hp=0
)
CLS
ECHO.
TYPE "%cd%\data\ascii\menus\defeat.txt"
ECHO.
ECHO %displayMessage%
ECHO +--------------------------------------------------------------------------------------------------+
ECHO + HP: %hp% ^| ATK %player_damage% ^| STM %stamina% ^| ARM: %armor_equip%
ECHO + %plrMessage%
ECHO +--------------------------------------------------------------------------------------------------+
ECHO [E] EXIT
CHOICE /C E /N /M ">"
IF ERRORLEVEL 1 GOTO :EOF

REM Resets the Enemy Looted variable.
:RESET_LOOT
SET enLooted=0
GOTO :EOF