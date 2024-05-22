@ECHO OFF
REM Combat Engine Beta 7 loot logic. Version 2.0 (240213).

REM Check that this enemy has not been looted previously.
IF %enLooted% EQU 1 (
    REM This enemy has been looted, do not proceed.
    SET plrMessage=You have already looted this enemy.
    GOTO :EOF
) ELSE (
    REM This enemy has not been looted, proceed.
    SET enLooted=1
    GOTO :generic_loot
)

REM Generic loot table for any enemy.
:generic_loot
SET /A A=%RANDOM% %%10
IF %A% GTR 8 (
    REM Rare loot
    SET plrMessage=Found 600 coins!
    SET /A COINS=!COINS! +600
    GOTO :EOF
) ELSE IF %A% LSS 4 (
    REM Uncommon loot
    SET plrMessage=Found a Long Sword!
    SET /A longsword_q=!longsword_q! +1
    GOTO :EOF
) ELSE (
    REM Common loot
    SET plrMessage=Found a Short Sword and 25 coins!
    SET /A shortsword_q=!shortsword_q +1
    SET /A COINS=!COINS! +25
    GOTO :EOF
)