@ECHO OFF
REM Level Up Utility for Windhelm.
REM I'm sure there's some easier way to do this with a for loop or something but those things are still horrifying to me.
REM I have no idea how they work, and perhaps I'm just a bit slow in the brain department but I don't feel like any explanation is clear enough.
REM Best I can do is a thousand nested if statements.

:CHECK_LEVELS_ONE_THROUGH_TEN
IF %LEVEL% EQU 1 (
    IF %XP% GEQ 1000 (
        REM Remove required XP to level up and carry it over.
        SET /A XP=%XP% -1000
        SET XP_CARRY=%XP%
        SET XP=0
        SET /A XP=%XP% +%XP_CARRY%
        REM Level the Player up.
        SET /A LEVEL=%LEVEL% +1
        SET plrMessage=Level up, You have reached level 2^!
        REM If applicable, set variables to unlock items/locations here.
        SET ruins_unlocked=1
        GOTO :EOF
    ) ELSE (
        REM The Player does not have the required XP to level up.
        GOTO :EOF
    )
) ELSE IF %LEVEL% EQU 2(
    IF %XP% GEQ 1500 (
        SET /A XP=%XP% -1500
        SET XP_CARRY=%XP%
        SET XP=0
        SET /A XP=%XP% +%XP_CARRY%
        REM Level the Player up.
        SET /A LEVEL=%LEVEL% +1
        SET plrMessage=Level up, You have reached level 3^!
        REM If applicable, set variables to unlock items/locations here.
        GOTO :EOF
    ) ELSE (
        REM The Player does not have the required XP to level up.
        GOTO :EOF
    )
)