@ECHO OFF
TITLE (WINDHELM) EVIe - Intializing Combat Engine variables.
REM Enemy Variable Intializer Enhanced. Version 1.0.4 (240224) - For Windhelm Build 2 "Bottle o' Features"

:CEV
REM Below is a list of Variables, each list pertains to a specific enemy.
REM Global Variables
SET armorCalculated=0
SET plrStun=False
SET enLooted=0
SET heavyAttack=0
SET heavyAttackCommit=0

REM BANDIT VARIABLES
SET iBanditHP=80
SET iBanditAT_b=14
SET iBanditAT=14
SET iBanditWK=False
SET iBanditSTM=100

REM JESTER VARIABLES
SET iJesterHP=125
SET iJesterAT_b=22
SET iJesterAT=22
SET iJesterWK=False
SET iJesterSTM=100

REM GNOME VARIABLES
SET iGnomeHP=75
SET iGnomeAT_b=28
SET iGnomeAT=28
SET iGnomeWK=True
SET iGnomeSTM=100

REM JESTER COOLDOWNS
REM Jester "Joke" attack, dealing multiplied damage.
SET iJesterJK=6

REM HUNTER VARIABLES
SET iHunterHP=115
SET iHunterAT_b=20
SET iHunterAT=20
SET iHunterWK=False
SET iHunterSTM=100

REM GOBLIN VARIABLES
SET iGoblinHP=60
SET iGoblinAT_b=16
SET iGoblinAT=16
SET iGoblinWK=False
SET iGoblinSTM=100

REM GNOME COOLDOWNS
REM Gnome "Poke" Attack, dealing multiplied damage.
SET iGnomePA=4
REM Default Action points for debugging
SET pAP=10

REM GOLEM VARIABLES
SET iGolemHP=90
SET iGolemAT_b=20
SET iGolemAT=20
SET iGolemSTM=50
SET iGolemMGK=0
SET iGolemWK=False

REM Assigns the dynamic enemy variable with the values of specific enemies.
SET curEn=%currentEnemy%
SET en_effect_1=None
IF %curEn% == iBandit (
    SET enHP=%iBanditHP%
    SET enAT=%iBanditAT%
    SET enATb=%iBanditAT_b%
    SET enWK=%iBanditWK%
    SET enSTM=%iBanditSTM%
    SET curEn=Bandit
    GOTO :combat_engine
) ELSE IF %curEn% == iJester (
    SET enHP=%iJesterHP%
    SET enAT=%iJesterAT%
    SET enATb=%iJesterAT_b%
    SET enWK=%iJesterWK%
    SET enSTM=%iJesterSTM%
    SET curEn=Jester
    GOTO :combat_engine
) ELSE IF %curEn% == iGnome (
    SET enHP=%iGnomeHP%
    SET enAT=%iGnomeAT%
    SET enATb=%iGnomeAT_b%
    SET enWK=%iGnomeWK%
    SET enSTM=%iGnomeSTM%
    SET curEn=Gnome
    GOTO :combat_engine
) ELSE IF %curEn% == iHunter (
    SET enHP=%iHunterHP%
    SET enAT=%iHunterAT%
    SET enATb=%iHunterAT_b%
    SET enWK=%iHunterWK%
    SET enSTM=%iHunterSTM%
    SET curEn=Hunter
    GOTO :combat_engine
) ELSE IF %curEn% == iGoblin (
    SET enHP=%iGoblinHP%
    SET enAT=%iGoblinAT%
    SET enATb=%iGoblinAT_b%
    SET enWK=%iGoblinWK%
    SET enSTM=%iGoblinSTM%
    SET curEn=Goblin
    GOTO :combat_engine
) ELSE IF %curEn% == iGolem (
    SET enHP=%iGolemHP%
    SET enAT=%iGolemAT%
    SET enATb=%iGolemAT_b%
    SET enWK=%iGolemWK%
    SET enSTM=%iGolemSTM%
    SET enMGK=%iGolemMGK%
    GOTO :combat_engine
) ELSE (
    REM Error handling.
    ECHO Enemy type unavailable. >> EV-ERROR.log
    SET errorType=EnemyType
    CALL "%cd%\data\functions\Error Handler.bat"
    EXIT /B
)

REM Call Combat Engine
:combat_engine
CALL "%cd%\data\Combat Engine\Combat Engine.bat"
REM Reset Window size
MODE con: cols=120 lines=20
GOTO :EOF