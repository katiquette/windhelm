@ECHO OFF
TITLE (Windhelm - %updateTitle%) ^| Settings

REM Main Menu
:main
CLS
ECHO.
TYPE "%cd%\data\assets\ui\settings.txt"
ECHO.
ECHO +--------------------------------------------------------------------------------------------------+
ECHO ^| [1 / CHANGE THEME ] ^| [E / EXIT ]                                                                +
ECHO +--------------------------------------------------------------------------------------------------+
CHOICE /C 1E /N /M ">"
IF ERRORLEVEL 2 GOTO :save_choice
IF ERRORLEVEL 1 GOTO :theme_select

REM CHANGE BACKGROUND & TEXT COLOR.
:theme_select
CLS
ECHO.
TYPE "%cd%\data\assets\ui\settings.txt"
ECHO.
ECHO %displayMessage%
ECHO +--------------------------------------------------------------------------------------------------+
ECHO ^| [1 / 0E DEFAULT ] ^| [2 / 1F HIGH VIS ] [3 / 09 ] ^| [4 / 0A ] ^| [5 / 0F ] ^| [C / CUSTOM ]       +
ECHO ^| [E / EXIT ]                                                                                       +
ECHO +--------------------------------------------------------------------------------------------------+
CHOICE /C 12345CE /N /M ">"
IF ERRORLEVEl 7 GOTO :main
IF ERRORLEVEL 6 GOTO :custom_color
IF ERRORLEVEL 5 GOTO :0F
IF ERRORLEVEL 4 GOTO :0A
IF ERRORLEVEL 3 GOTO :09
IF ERRORLEVEL 2 GOTO :1F
IF ERRORLEVEL 1 GOTO :0E

:custom_color
CLS
ECHO.
TYPE "%cd%\data\assets\ui\color.txt"
ECHO.
ECHO ENTER A VALID BATCH SCRIPT COLOR CODE. (SEE COLOR /?)
ECHO %displayMessage%
ECHO +--------------------------------------------------------------------------------------------------+
ECHO ^| [E / EXIT ]                                                                                       +
ECHO +--------------------------------------------------------------------------------------------------+
SET /P custom=^>
COLOR %custom%
SET setColor=%custom%
SET displayMessage=%custom% applied - exit this script to save.
IF /I "%custom%" == "E" GOTO :save_choice
GOTO :theme_select

:0E
set setColor=0E
color 0E
set displayMessage=Color 0E applied; exit to save this choice.
GOTO :theme_select

:0F
set setColor=0F
color 0F
set displayMessage=Color 0F applied; exit to save this choice.
GOTO :theme_select

:09
set setColor=09
color 09
set displayMessage=Color 09 applied; exit to save this choice.
GOTO :theme_select

:0A
set setColor=0A
color 0A
set displayMessage=Color 0A applied; exit to save this choice.
GOTO :theme_select

:1F
set setColor=1F
COLOR 1F
set displayMessage=Color 1F applied; exit to save this choice.
GOTO :theme_select

:save_choice
(
ECHO %setColor%
ECHO %introView%
)>"%winLoc%\data\settings.txt"
GOTO :EOF