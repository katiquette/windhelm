if not defined in_subprocess (cmd /k set in_subprocess=y ^& %0 %*) & exit )
@ECHO OFF
MODE con: cols=120 lines=29
REM Combat Engine beta version 1.0.0 [ ce7.1-240525-B2.BE1.GU0 ]
REM For clarity: 250524 (Date) B2 (Build 2) BE1 (Beta 1) GU0 (General Update 0)
REM This version of Windhelm was made by Midnight Midriff (Original Author).
REM https://github.com/MidnightMidriff/combat-engine
REM This software is licensed under GPL-3.0-or-later.
setlocal enabledelayedexpansion

REM old vars
REM ...
REM old vars

REM "Enemy Battle Screen". Player and Enemy information is displayed here.
:EBS
TITLE (WINDHELM) - COMBAT ENGINE ^| %player_name% the %player_class% vs %curEn% & SET enAT=%enATb%
CLS
REM Check enemy/player health to determine victory or defeat.
IF %enemy_health% LEQ 0 GOTO :VICTORY_REWARDS
IF %player_health% LEQ 0 GOTO :defeat
SET TURN_LOOP=0
REM Write the data from the text file to the CLI.
ECHO.
TYPE "%cd%\data\assets\enemies\Iridescent Forest\%curEn%.txt"
ECHO.
ECHO +---------------------------------------------------------------------------------------------------------------------+
ECHO ^|                             HP: %enemy_health% ^| ATK: %enemy_attack% ^| STM: %enemy_stamina%
ECHO ^| %displayMessage%
ECHO +---------------------------------------------------------------------------------------------------------------------+
ECHO ^| HP: %player_health% ^| STM: %player_stamina% ^| ATK: %player_damage% ^| AMR: %player_armor% ^| MGK: %player_magicka%
ECHO +---------------------------------------------------------------------------------------------------------------------+
ECHO ^| FOLLOWER: %follower_name% ^| HP: %follower_health% ^| ATK: %follower_attack% ^| STM: %follower_stamina% ^| MGK: %follower_magicka% ^| LVL: %follower_level%
ECHO ^| ACTION 1: %q_action_1% ^| ACTION 2: %q_action_3% ^| ACTION 3: %q_action_3%
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

REM Adds the specified attack to the Player's attack queue.
:PLAYER_QUEUE_ATTACK
IF NOT "%q_action_1%" == "EMPTY" (
    REM If this queue slot is NOT empty, check the 2nd slot.
    IF NOT %q_action_2% == "EMPTY" (
        REM If this queue slot is NOT empty, check the 3rd slot.
        IF NOT "%q_action_3%" == "EMPTY" (
            REM All Player action queue slots are occupied, do nothing.
            SET player_message=Your action queue is full!
            GOTO :EBS
        ) ELSE (
            REM This action queue slot is not occupied, queue the desired action in this position.
            SET q_action_3=normalAttack
            GOTO :EBS
        )
    ) ELSE (
        REM This action queue slot is not occupied, queue the desired action in this position.
        SET q_action_2=normalAttack
        GOTO :EBS
    )
) ELSE (
    REM This action queue slot is not occupied, queue the desired action in this position.
    SET q_action_1=normalAttack
    GOTO :EBS
)

REM Ends the Player's current turn.
:PLAYER_END_TURN
REM Checks if Queue_Action_1 is empty.
IF "%q_action_1%" == "EMPTY" (
    REM Increments the TURN_LOOP variable by one, which is used to end this loop when all action slots are empty.
    SET /A TURN_LOOP=!TURN_LOOP! +1
    REM Checks if the maximum amount of loops has been reached (3).
    IF %TURN_LOOP% GEQ 3 (
        REM TURN_LOOP has reached the maximum of 3, terminate this loop.
        SET TURN_LOOP=0
        GOTO :EBS
    ) ELSE (
        REM TURN_LOOP has not reached the maximum of 3, continue this loop.
        ECHO %TURN_LOOP%, q_action_1 has determined the loop to have not reached the limit. >> CombatEngine-log.txt
        ECHO %TURN_LOOP%
        PAUSE
        IF "%q_action_2%" == "EMPTY" (
            REM Increments the TURN_LOOP variable by one, which is used to end this loop when all action slots are empty.
            SET /A TURN_LOOP=!TURN_LOOP! +1
            REM Checks if the maximum amount of loops has been reached (3).
            IF %TURN_LOOP% GEQ 3 (
                REM TURN_LOOP has reached the maximum of 3, terminate this loop.
                SET TURN_LOOP=0
                GOTO :EBS
            ) ELSE (
                REM TURN_LOOP has not reached the maximum of 3, continue this loop.
                ECHO %TURN_LOOP%, q_action_2 has determined the loop to have not reached the limit. >> CombatEngine-log.txt
                ECHO %TURN_LOOP%
                PAUSE
                IF "%q_action_3%" == "EMPTY" (
                    REM Increments the TURN_LOOP variable by one, which is used to end this loop when all action slots are empty.
                    SET /A TURN_LOOP=!TURN_LOOP +1
                    REM Checks if the maximum amount of loops has been reached (3).
                    IF %TURN_LOOP% GEQ 3 (
                        REM TURN_LOOP has reached the maximum of 3, terminate this loop.
                        SET TURN_LOOP=0
                        GOTO :EBS
                    ) ELSE (
                        REM TURN_LOOP has not reached the maximum of 3, continue this loop.
                        ECHO %TURN_LOOP%
                        ECHO %TURN_LOOP%, q_action_3 has determined the loop to have not reached the limit. >> CombatEngine-log.txt
                        PAUSE
                    )

                ) ELSE (
                    REM q_action_3 is not empty, determine the action.
                    IF "%q_action_3%" == "normalAttack" (
                        REM Increments the TURN_LOOP variable by 1.
                        SET /A TURN_LOOP=!TURN_LOOP! +1
                        REM Normal player attack in queue position, perform the attack.
                        SET q_action_3=EMPTY
                        GOTO :PLAYER_STAMINA_CALCULATE
                    ) ELSE (
                        REM Invalid String error.
                        ECHO Uh oh. Combat Error encountered an issue. %q_action_1% does not contain a valid string. Sending Player to Error Handler. >> CombatEngine-Log.txt
                        SET errorType=invalidString
                        GOTO :ERROR_HANDLER
                    )
                )
            )
        ) ELSE (
            REM q_action_2 is not empty, determine the action.
            IF "%q_action_2%" == "normalAttack" (
                REM Normal player attack in queue position, perform the attack.
                REM Increments the TURN_LOOP variable by 1.
                SET /A TURN_LOOP=!TURN_LOOP! +1
                SET q_action_2=EMPTY
                GOTO :PLAYER_STAMINA_CALCULATE
            ) ELSE (
                REM Invalid String error.
                ECHO Uh oh. Combat Error encountered an issue. %q_action_1% does not contain a valid string. Sending Player to Error Handler. >> CombatEngine-Log.txt
                SET errorType=invalidString
                GOTO :ERROR_HANDLER
            )
        )
    )
) ELSE (
    REM q_action_1 is not empty, determine the action.
    IF "%q_action_1%" == "normalAttack" (
        REM Increments the TURN_LOOP variable by 1.
        SET /A TURN_LOOP=!TURN_LOOP! +1
        REM Normal player attack in queue position, perform the attack.
        SET q_action_1=EMPTY
        GOTO :PLAYER_STAMINA_CALCULATE
    ) ELSE (
        REM Invalid String error.
        ECHO Uh oh. Combat Error encountered an issue. %q_action_1% does not contain a valid string. Sending Player to Error Handler. >> CombatEngine-Log.txt
        SET errorType=invalidString
        GOTO :ERROR_HANDLER
    )
)

REM Calculate the Player's stamina.
:PLAYER_STAMINA_CALCULATE
IF %player_stamina% LSS %player_stamina_equip% (
    REM Player does not have enough stamina to perform this attack.
    SET player_message=You try to raise your weapon, but your pathetic noodle arms give out.
    GOTO :PLAYER_ARMOR_CALCULATE
) ELSE (
    REM Player has enough stamina to perform the attack.
    GOTO :PLAYER_DAMAGE_CALCULATE
)

REM Calculate the Player's damage.
:PLAYER_DAMAGE_CALCULATE
SET /A PAR=%RANDOM% %%20
SET /A PCC=%RANDOM% %%50
IF %PAR% LSS 7 (
    REM Player attack misses.
    SET player_message=The %curEn% moves out of the way of your attack just in time.
    GOTO :PLAYER_ARMOR_CALCULATE
) ELSE IF %PAR% GTR 16 (
    REM Roll for random crit
    IF %PCC% GTR 40 (
        REM Player is granted a critical hit.
        SET /A enemy_health=-!player_damage! *2
        GOTO :PLAYER_ARMOR_CALCULATE
    ) ELSE (
        REM Player is not granted a critical hit.
        SET /A enemy_health=-!player_damage!
        GOTO :PLAYER_ARMOR_CALCULATE
    )
) ELSE (
    REM Normal attack.
    SET /A enemy_health=-!player_damage!
    GOTO :PLAYER_ARMOR_CALCULATE
)

REM Calculate the Player's armor.
:PLAYER_ARMOR_CALCULATE
IF %player_armor_calculated% EQU 1 (
    REM Player armor has already been calculated.
    GOTO :ENEMY_STAMINA_CALCULATE
) ELSE (
    REM Lowers enemy damage based on the Player's armor value.
    SET /A enemy_attack=-!player_armor_equip!
    SET player_armor_calculated=1
    GOTO :ENEMY_STAMINA_CALCULATE
)

REM Recovers Player stats.
GOTO :EBS

REM Calculate the enemies stamina.
:ENEMY_STAMINA_CALCULATE
IF %enemy_stamina% LSS %enemy_stamina_cost% (
    REM Enemy stamina is too low.
    SET displayMessage=The enemy attempts to attack you but their weak legs give under the pressure.
    GOTO :PLAYER_END_TURN
) ELSE (
    SET /A enemy_stamina=-!enemy_stamina_cost!
    GOTO :ENEMY_ATTACK_CALCULATE
)

REM Calculate the enemies damage.
:ENEMY_ATTACK_CALCULATE
SET /A EAR=%RANDOM% %%20
SET /A ECC=%RANDOM %%50
IF %EAR% LEQ 8 (
    REM Enemy attack misses.
    SET displayMessage=You easily dodge the obvious attack.
    GOTO :PLAYER_END_TURN
) ELSE IF %EAR% GTR 16 (
    REM Roll for critical hit.
    IF %ECC% GTR 40 (
        REM Enemy is granted a critical hit.
        SET /A player_health=-!enemy_attack! *2
        SET displayMessage=The enemy is granted a critical hit.
        GOTO :PLAYER_END_TURN
    ) ELSE (
        REM Critical hit not granted.
        SET /A player_health=-!enemy_attack!
        GOTO :PLAYER_END_TURN
    )
) ELSE (
    REM Normal attack.
    SET /A player_health=-!enemy_attack!
    GOTO :PLAYER_END_TURN
)

REM Opens the Player's inventory. CECALL tells Inventory Viewer which script called it, and where to return when the Player exits.
:PLAYER_INVENTORY
SET CE7CALL=1
CALL "%cd%\data\functions\Inventory Viewer.bat"
GOTO :EBS

REM Handles those pesky errors.
:ERROR_HANDLER
CALL "%cd%\data\functions\Error Handler.bat"
EXIT

REM Performs some cleanup
:EXIT
SET player_armor_calculated=1
SET enemy_attack=%enemy_attack_normal%
GOTO :EOF