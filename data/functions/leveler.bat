@ECHO OFF
REM Level Up Utility for Windhelm.
REM I'm sure there's some easier way to do this with a for loop or something but those things are still horrifying to me.
REM I have no idea how they work, and perhaps I'm just a bit slow in the brain department but I don't feel like any explanation is clear enough.
REM Best I can do is a thousand nested if statements.

:CHECK_LEVELS_ONE_THROUGH_TEN
IF %player_level% EQU 1 (
    IF %player_xp% GEQ 1000 (
        REM  Removed XP required to level up and carry whatever is left over.
        SET /A player_xp=!player_xp! -1000
        IF %player_xp% LSS 1 SET player_XP=0
        SET xp_carry=%player_xp%
        SET player_xp=0
        SET /A player_xp=!player_xp! +%xp_carry%
        SET /A player_level=!player_level! +1
        SET player_levelup_notif=Level up. You've reached level %player_level%.
        SET ruins_unlocked=1
        GOTO :EOF
    ) ELSE (
        REM Player does not have the required XP to level up.
        GOTO :EOF
    )
) ELSE IF %player_level% EQU 2 (
    IF %player_xp% GEQ 1500 (
        SET /A player_xp=!player_xp! -1500
        IF %player_xp% LSS 1 SET player_xp=0
        SET xp_carry=%player_xp%
        SET player_xp=0
        SET /A player_xp=!player_xp! +%xp_carry%
        SET /A player_level=!player_level! +1
        SET player_levelup_notif=Level up. You've reached level %player_level%.
        GOTO :EOF
    ) ELSE (
        GOTO :EOF
    )
) ELSE (
    rem No further content to be unlocked.
    SET player_levelup_notif=You have reached the current max level.
    GOTO :EOF
)