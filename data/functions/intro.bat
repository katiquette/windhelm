@ECHO OFF & TITLE (WINDHELM) - INTRO
REM Intro Version 1.0.0 240323 - For Windhelm Beta Version 2.0.0 "Bottle o' Features"
MODE con: cols=34 lines=14

REM An introductory poem.
:introduction-poem
CLS
ECHO.
ECHO A failed connection.
ping localhost -n 2 -w 2 > NUL
ECHO A universal mistake,
ping localhost -n 2 -w 2 > NUL
ECHO which must be corrected,
ping localhost -n 2 -w 2 > NUL
ECHO yet I remain fearful,
ping localhost -n 2 -w 2 > NUL
ECHO unable to act,
ping localhost -n 2 -w 2 > NUL
ECHO cursing my brain,
ping localhost -n 2 -w 2 > NUL
ECHO and the God which cast it upon me.
ping localhost -n 2 -w 2 > NUL
ECHO Begging for it to change,
ping localhost -n 2 -w 2 > NUL
ECHO wondering what could've been,
ping localhost -n 2 -w 2 > NUL
ECHO alas it feels fruitless.
ping localhost -n 2 -w 2 > NUL
ECHO Perhaps I'll sleep.
PAUSE
GOTO :CONTENT_WARNING

REM Content warning for Windhelm.
:CONTENT_WARNING
MODE con: cols=115 lines=14
CLS
COLOR 4F
ECHO.
ECHO Welcome to Windhelm.
ECHO Windhelm is a story focused RPG game built with Batch Script for the Windows Command Line.
ECHO If you are uncomfortable with topics regarding self-harm, depression and suicide please consider playing another game.
ECHO Thank you for choosing Windhelm.
PAUSE
GOTO :SAVE

REM Resets the color from the content warning screen and starts the game.
:SAVE
SET initSt=1
COLOR 0E
(
ECHO %setColor%
ECHO %initSt%
)>"%cd%\data\settings.txt"


GOTO :EOF