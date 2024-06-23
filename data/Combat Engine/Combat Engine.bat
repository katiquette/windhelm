if not defined in_subprocess (cmd /k set in_subprocess=y ^& %0 %*) & exit )
@ECHO OFF
MODE con: cols=120 lines=29
REM Combat Engine Beta Version 8.0.0.
REM Extra Build Information: ce1-240619-B1.BE8.GU0
REM This software is licensed under GPL-3.0-or-later.

REM "Enemy Battle Screen". Player and Enemy information is displayed here.
:EBS
TITLE (WINDHELM) - COMBAT ENGINE ^| %player_name% the %player_class% vs %curEn% & SET enAT=%enATb%
CLS
REM Check enemy/player health to determine victory or defeat.
IF %enemy_health% LEQ 0 GOTO :VICTORY_REWARDS
IF %player_health% LEQ 0 GOTO :DEFEAT_SCREEN
REM Write the data from the text file to the CLI.
ECHO.
TYPE "%cd%\data\assets\enemies\Iridescent Forest\%curEn%.txt"
ECHO.
ECHO +---------------------------------------------------------------------------------------------------------------------+
ECHO ^|                             HP: %enemy_health% ^| ATK: %enemy_attack% ^| STM: %enemy_stamina%
ECHO ^| %displayMessage%
ECHO +---------------------------------------------------------------------------------------------------------------------+
ECHO ^| HP: %player_health% ^| STM: %player_stamina% ^| ATK: %player_damage% ^| AMR: %player_armor_equipped%, %player_armor% ^| MGK: %player_magicka%
ECHO +---------------------------------------------------------------------------------------------------------------------+
ECHO ^| FOLLOWER: %follower_name% ^| HP: %follower_health% ^| ATK: %follower_attack% ^| STM: %follower_stamina% ^| MGK: %follower_magicka% ^| LVL: %follower_level%
ECHO ^| ACTION 1: %q_action_1% ^| ACTION 2: %q_action_2% ^| ACTION 3: %q_action_3%
ECHO +---------------------------------------------------------------------------------------------------------------------+
ECHO ^| [I] ITEMS  ^| [E] END     ^| %player_message%
ECHO ^|            ^| [R] RECOVER ^| %player_info%
ECHO ^| [A] ATTACK ^|             ^| [F] FLEE                                                                                 +
ECHO +---------------------------------------------------------------------------------------------------------------------+
CHOICE /C IAERF /N /M ">"
IF ERRORLEVEL 5 GOTO :PLAYER_FLEE
IF ERRORLEVEL 4 GOTO :PLAYER_RECOVER
IF ERRORLEVEL 3 GOTO :PLAYER_END_TURN
IF ERRORLEVEL 2 GOTO :PLAYER_QUEUE_ATTACK
IF ERRORLEVEL 1 GOTO :PLAYER_INVENTORY

REM Adds an attack to the Player's action queue.
:PLAYER_QUEUE_ATTACK
IF NOT "%q_action_1%" == "EMPTY" (
    REM Action slot 1 is not empty, do not add anything.
    SET player_message=Action slot 1 is occupied.
    GOTO :PLAYER_QUEUE_ATTACK_2
) ELSE (
    REM Action slot 1 is empty, add the attack.
    SET q_action_1=normalAttack
    GOTO :EBS
)

REM Checks the second action slot and attemps to add an attack to it.
:PLAYER_QUEUE_ATTACK_2
IF NOT "%q_action_2%" == "EMPTY" (
    REM Action slot 2 is not empty, do not add anything.
    SET player_message=Action slot 2 is occupied.
    GOTO :PLAYER_QUEUE_ATTACK_3
) ELSE (
    REM Action slot 2 is empty, add the attack.
    SET q_action_2=normalAttack
    GOTO :EBS
)

:PLAYER_QUEUE_ATTACK_3
IF NOT "%q_action_3%" == "EMPTY" (
    REM Action slot 3 is not empty, do not add anything.
    SET player_message=Action slot 3 is occupied.
    GOTO :EBS
) ELSE (
    REM Action slot 3 is empty, add the attack.
    SET q_action_3=normalAttack
    GOTO :EBS
)

REM Checks if action slot 1 is empty.
:PLAYER_END_TURN
IF NOT "%q_action_1%" == "EMPTY" (
    REM Checks the action in the slot.
    IF "%q_action_1%" == "normalAttack" (
        REM Empty this slot and perform the action.
        SET q_action_1=EMPTY
        GOTO :PLAYER_STAMINA_CALCULATE
    ) ELSE (
        GOTO :EBS
    )
) ELSE (
    REM Action slot 1 is empty. Check the next slot.
    GOTO :PLAYER_END_TURN_2
)

:PLAYER_END_TURN_2
IF NOT "%q_action_2%" == "EMPTY" (
    REM Checks the action in the slot.
    IF "%q_action_2%" == "normalAttack" (
        REM Empty this slot and perform the action.
        SET q_action_2=EMPTY
        GOTO :PLAYER_STAMINA_CALCULATE
    ) ELSE (
        GOTO :EBS
    )
) ELSE (
    REM Action slot 2 is empty. Check the next slot.
    GOTO :PLAYER_END_TURN_3
)

:PLAYER_END_TURN_3
IF NOT "%q_action_3%" == "EMPTY" (
    REM Checks the action in the slot.
    IF "%q_action_3%" == "normalAttack" (
        REM Empty this slot and perform the action.
        SET q_action_3=EMPTY
        GOTO :PLAYER_STAMINA_CALCULATE
    ) ELSE (
        GOTO :EBS
    )
) ELSE (
    REM Action slot 3 is empty. Check the next slot.
    GOTO :EBS
)

REM Calculate the Player's stamina.
:PLAYER_STAMINA_CALCULATE
IF %player_stamina% LSS %player_stamina_equip% (
    REM Player does not have enough stamina to perform this attack.
    SET player_info=You try to raise your weapon, but your pathetic noodle arms give out.
    GOTO :PLAYER_ARMOR_CALCULATE
) ELSE (
    REM Player has enough stamina to perform the attack.
    GOTO :PLAYER_DAMAGE_CALCULATE
)

REM Calculate the Player's damage.
:PLAYER_DAMAGE_CALCULATE
SET /A PATK=%RANDOM% %%20
IF %PATK% LSS 7 (
    REM Player attack misses.
    SET player_info=You missed. idiot.
    GOTO :PLAYER_ARMOR_CALCULATE
) ELSE IF %PATK% GTR 16 (
    REM Random critical hit.
    SET /A enemy_health=!enemy_health! -%player_damage% *2
    SET player_info=Critical hit!
    GOTO :PLAYER_ARMOR_CALCULATE
) ELSE (
    REM Normal attack.
    SET /A enemy_health=!enemy_health! -%player_damage%
    SET player_info=You hit the enemy.
    GOTO :PLAYER_ARMOR_CALCULATE
)

REM Calculate the Player's armor.
:PLAYER_ARMOR_CALCULATE
IF %player_armor_calculated% EQU 1 (
    REM Already calculated.
    GOTO :ENEMY_STAMINA_CALCULATE
) ELSE (
    REM Apply armor debuff to enemy attacks.
    SET /A enemy_attack=!enemy_attack! -%player_armor_equip%
    SET player_armor_calculated=1
    GOTO :ENEMY_STAMINA_CALCULATE
)

REM Calculate the enemies stamina.
:ENEMY_STAMINA_CALCULATE
IF %enemy_stamina% LSS %enemy_stamina_cost% (
    REM Enemy stamina is too low.
    SET displayMessage=The enemy attempts to attack you but their weak legs give under the pressure.
    GOTO :PLAYER_END_TURN
) ELSE (
    SET /A enemy_stamina=!enemy_stamina! -%enemy_stamina_cost%
    GOTO :ENEMY_ATTACK_CALCULATE
)

REM Calculate the enemies damage.
:ENEMY_ATTACK_CALCULATE
SET /A EATK=%RANDOM% %%20
IF %EATK% LSS 7 (
    REM Player attack misses.
    SET displayMessage=enemy missed. idiots.
    GOTO :PLAYER_END_TURN
) ELSE IF %EATK% GTR 16 (
    REM Random critical hit.
    SET /A player_health=!player_health! -%enemy_attack%
    SET displayMessage=The enemy got a critical hit. Just kidding.
    GOTO :PLAYER_END_TURN
) ELSE (
    REM Normal attack.
    SET /A player_health=!player_health! -%enemy_attack%
    SET displayMessage=You were hit.
    GOTO :PLAYER_END_TURN
)

REM This should probably get reworked. I mean, obviously. The inventory is getting a big ol upgrade.
:PLAYER_INVENTORY
SET CE7CALL=1
CALL "%cd%\data\functions\Inventory Viewer.bat"
GOTO :EBS

REM Handles those pesky errors.
:ERROR_HANDLER
CALL "%cd%\data\functions\Error Handler.bat"
EXIT

REM Handles victory conditions. This should eventually scale with difficulty.
:VICTORY_REWARDS
CALL "%cd%\data\functions\leveler.bat"
SET player_health=%player_health_max%
SET player_stamina=%player_stamina_max%
SET player_magicka=%player_magicka_max%
SET /A RR=%RANDOM% %%20
IF %RR% GEQ 15 (
    SET goldGained=60
    SET xpGained=25
    GOTO :VICTORY_SCREEN
) ELSE IF %RR% LEQ 8 (
    SET goldGained=20
    SET xpGained=10
    GOTO :VICTORY_SCREEN
) ELSE (
    SET goldGained=10
    SET xpGained=5
    GOTO :VICTORY_SCREEN
)

:VICTORY_SCREEN
SET /A player_coins=!player_coins! +%goldGained%
SET /A player_xp=!player_xp! +%xpGained%
TITLE (WINDHELM) - COMBAT ENGINE ^| %player_name% the %player_class% is victorious!
CLS
ECHO.
TYPE "%cd%\data\assets\ui\victory.txt"
ECHO.
ECHO +----------------------------------------------------------------------------------------------------------------------+
ECHO ^| %lootFound% ^| %player_levelup_notif%
ECHO ^| You defeated the %curEn%, congratulations^! You've been rewarded with %goldGained% Gold and %xpGained% xp.
ECHO +----------------------------------------------------------------------------------------------------------------------+
ECHO ^| HP: %player_health% ^| STM: %player_stamina% ^| ATK: %player_damage% ^| AMR: %player_armor% ^| MGK: %player_magicka%
ECHO +----------------------------------------------------------------------------------------------------------------------+
ECHO ^| FOLLOWER: %follower_name% ^| HP: %follower_health% ^| ATK: %follower_attack% ^| STM: %follower_stamina% ^| MGK: %follower_magicka% ^| LVL: %follower_level%
ECHO ^| ACTION 1: %q_action_1% ^| ACTION 2: %q_action_2% ^| ACTION 3: %q_action_3%
ECHO +----------------------------------------------------------------------------------------------------------------------+
ECHO ^| [1 / LOOT %curEn% ] ^| [E / EXIT ]  ^| %player_message%                                                      +
ECHO +----------------------------------------------------------------------------------------------------------------------+
CHOICE /C 1E /N /M ">"
IF ERRORLEVEL 2 GOTO :EXIT
IF ERRORLEVEL 1 GOTO :LOOT

:LOOT
CALL "%cd%\data\Combat Engine\scripts\ceLoot.bat"
SET enLooted=1
GOTO :VICTORY_SCREEN

:DEFEAT_SCREEN
SET /A player_xp=!player_xp! +10
SET player_health=%player_health_max%
TITLE (WINDHELM) - COMBAT ENGINE ^| %player_name% the %player_class% is victorious!
CLS
ECHO.
TYPE "%cd%\data\assets\ui\defeat.txt"
ECHO.
ECHO +---------------------------------------------------------------------------------------------------------------------+
ECHO ^| %lootFound%
ECHO ^| You were defeated ny the %curEn%! You've been rewarded with 10 xp.
ECHO +---------------------------------------------------------------------------------------------------------------------+
ECHO ^| HP: %player_health% ^| STM: %player_stamina% ^| ATK: %player_damage% ^| AMR: %player_armor% ^| MGK: %player_magicka%
ECHO +---------------------------------------------------------------------------------------------------------------------+
ECHO ^| FOLLOWER: %follower_name% ^| HP: %follower_health% ^| ATK: %follower_attack% ^| STM: %follower_stamina% ^| MGK: %follower_magicka% ^| LVL: %follower_level%
ECHO ^| ACTION 1: %q_action_1% ^| ACTION 2: %q_action_2% ^| ACTION 3: %q_action_3%
ECHO +---------------------------------------------------------------------------------------------------------------------+
ECHO ^| [E / EXIT ]  ^| %player_message%                                                                            +
ECHO +---------------------------------------------------------------------------------------------------------------------+
CHOICE /C E /N /M ">"
IF ERRORLEVEL 1 GOTO :EXIT

REM Performs some cleanup and then exits.
:EXIT
SET player_armor_calculated=1
SET enemy_attack=%enemy_attack_normal%
GOTO :EOF