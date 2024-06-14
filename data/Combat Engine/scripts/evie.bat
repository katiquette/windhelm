@ECHO OFF
TITLE (WINDHELM) - EVIe

REM Every enemy excluding iBandit are disabled for testing.

REM Resets the queue every time Combat Engine is called.
SET q_action_1=EMPTY
SET q_action_2=EMPTY
SET q_action_3=EMPTY
SET player_levelup_notif=.

:CEV
REM Below is a list of Variables, each list pertains to a specific enemy.
REM Global Variables
SET player_armor_calculated=0
SET enLooted=0

REM BANDIT VARIABLES
SET iBanditHP=80
SET iBanditAT_b=14
SET iBanditAT=14
SET iBanditWK=False
SET iBanditSTM=100
SET iBanditSTMC=5

REM JESTER VARIABLES
REM SET iJesterHP=125
REM SET iJesterAT_b=22
REM SET iJesterAT=22
REM SET iJesterWK=False
REM SET iJesterSTM=100
REM SET iJesterSTMC=20

REM GNOME VARIABLES
REM SET iGnomeHP=75
REM SET iGnomeAT_b=28
REM SET iGnomeAT=28
REM SET iGnomeWK=True
REM SET iGnomeSTM=100
REM SET iGnomeSTMC=20

REM JESTER COOLDOWNS
REM Jester "Joke" attack, dealing multiplied damage.
REM SET iJesterJK=6

REM HUNTER VARIABLES
REM SET iHunterHP=115
REM SET iHunterAT_b=20
REM SET iHunterAT=20
REM SET iHunterWK=False
REM SET iHunterSTM=100
REM SET iHunterSTMC=20

REM GOBLIN VARIABLES
REM SET iGoblinHP=60
REM SET iGoblinAT_b=16
REM SET iGoblinAT=16
REM SET iGoblinWK=False
REM SET iGoblinSTM=100
REM SET iGoblinSTMC=20

REM GNOME COOLDOWNS
REM Gnome "Poke" Attack, dealing multiplied damage.
REM SET iGnomePA=4
REM Default Action points for debugging
REM SET pAP=10

REM GOLEM VARIABLES
REM SET iGolemHP=90
REM SET iGolemAT_b=20
REM SET iGolemAT=20
REM SET iGolemSTM=50
REM SET iGolemSTMC=10
REM SET iGolemMGK=0
REM SET iGolemWK=False

REM Testing
SET curEn=%currentEnemy%
SET enemy_health=%iBanditHP%
SET enemy_attack=%iBanditAT%
SET enemy_attack_normal=%iBanditAT_b%
SET enemy_stamina=%iBanditSTM%
SET enemy_stamina_cost=%iBanditSTMC%
GOTO :combat_engine

REM Assigns the dynamic enemy variable with the values of specific enemies.
SET curEn=%currentEnemy%
SET en_effect_1=None
IF %curEn% == iBandit (
    SET enemy_health=%iBanditHP%
    SET enemy_attack=%iBanditAT%
    SET enemy_attackb=%iBanditAT_b%
    SET enemy_weaken_res=%iBanditWK%
    SET enemy_stamina=%iBanditSTM%
    SET enemy_stamina_cost=%iBanditSTMC%
    SET curEn=Bandit
    GOTO :combat_engine
) ELSE IF %curEn% == iJester (
    SET enemy_health=%iJesterHP%
    SET enemy_attack=%iJesterAT%
    SET enemy_attackb=%iJesterAT_b%
    SET enemy_weaken_res=%iJesterWK%
    SET enemy_stamina=%iJesterSTM%
    SET enemy_stamina_cost=%iJesterSTMC%
    SET curEn=Jester
    GOTO :combat_engine
) ELSE IF %curEn% == iGnome (
    SET enemy_health=%iGnomeHP%
    SET enemy_attack=%iGnomeAT%
    SET enemy_attackb=%iGnomeAT_b%
    SET enemy_weaken_res=%iGnomeWK%
    SET enemy_stamina=%iGnomeSTM%
    enemy_stamina_cost=%iGnomeSTMC%
    SET curEn=Gnome
    GOTO :combat_engine
) ELSE IF %curEn% == iHunter (
    SET enemy_health=%iHunterHP%
    SET enemy_attack=%iHunterAT%
    SET enemy_attackb=%iHunterAT_b%
    SET enemy_weaken_res=%iHunterWK%
    SET enemy_stamina=%iHunterSTM%
    SET enemy_stamina_cost=%iHunterSTMC%
    SET curEn=Hunter
    GOTO :combat_engine
) ELSE IF %curEn% == iGoblin (
    SET enemy_health=%iGoblinHP%
    SET enemy_attack=%iGoblinAT%
    SET enemy_attackb=%iGoblinAT_b%
    SET enemy_weaken_res=%iGoblinWK%
    SET enemy_stamina=%iGoblinSTM%
    SET enemy_stamina_cost=%iGoblinSTMC%
    SET curEn=Goblin
    GOTO :combat_engine
) ELSE IF %curEn% == iGolem (
    SET enemy_health=%iGolemHP%
    SET enemy_attack=%iGolemAT%
    SET enemy_attackb=%iGolemAT_b%
    SET enemy_weaken_res=%iGolemWK%
    SET enemy_stamina=%iGolemSTM%
    SET enemy_stamina_cost=%iGolemSTMC%
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