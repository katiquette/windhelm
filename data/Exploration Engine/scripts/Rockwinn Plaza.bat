@ECHO OFF
TITLE (Rockwinn Plaza) - Rockwinn Plaza ^| %player_name% the %player_class%
REM Rockwinn Plaza Version 2.0 (240314) - for Windhelm build 2 "Bottle o' Features"

REM Main Menu.
:MAIN
MODE con: cols=127 lines=22
CLS
ECHO.
TYPE "%cd%\data\ascii\menus\rwp.txt"
ECHO.
ECHO You enter the bustling street, inspecting each vendors stall closely.
ECHO %displayMessage%
ECHO +-----------------------------------------------------------------------------------------------------------------------------+
ECHO ^| HP: %HP% ^| STM: %stamina% ^| ATK: %player_damage% ^| AMR: %armor_equip% ^| MGK: %magicka% ^| AP %player_action_p% ^| COINS: %COINS%
ECHO +-----------------------------------------------------------------------------------------------------------------------------+
ECHO ^| PARTY 1: %PM1name% ^| HP: %PM1HP% ^| ATK: %PM1ATK% ^| STM: %PM1STM% ^| MGK: %PM1MGK%
ECHO ^| PARTY 2: %PM2name% ^| HP: %PM2HP% ^| ATK: %PM2ATK% ^| STM: %PM2STM% ^| MGK: %PM2MGK%
ECHO ^| PARTY 3: %PM3name% ^| HP: %PM3HP% ^| ATK: %PM3ATK% ^| STM: %PM3STM% ^| MGK: %PM3MGK%
ECHO +-----------------------------------------------------------------------------------------------------------------------------+
ECHO + [1 / ALCHEMIST ] ^| [2 / ARMORER ] ^| [3 / BLACKSMITH ] ^| [4 / LOREKEEPER ] ^| [5 / WIZARD ] ^| [E / LEAVE ]                    +
ECHO +-----------------------------------------------------------------------------------------------------------------------------+
CHOICE /C 12345E /N /M ">"
IF ERRORLEVEL 6 GOTO :AUTOSAVE
IF ERRORLEVEL 5 GOTO :RWP_WIZARD
IF ERRORLEVEL 4 GOTO :RWP_LOREKEEPER
IF ERRORLEVEL 3 GOTO :RWP_BLACKSMITH
IF ERRORLEVEL 2 GOTO :RWP_ARMORER
IF ERRORLEVEL 1 GOTO :RWP_ALCHEMIST

REM Alchemist Vendor.
:RWP_ALCHEMIST
TITLE (Rockwinn Plaza) - Alchemist ^| %player_name% the %player_class%
MODE con: cols=100 lines=22
REM --
ECHO.
TYPE "%cd%\data\ascii\npcs\alchemist.txt"
ECHO.
ECHO.
ECHO What can I do for you, Shard?
ECHO %displayMessage%
ECHO +--------------------------------------------------------------------------------------------------+
ECHO ^| HP: %HP% ^| STM: %stamina% ^| ATK: %player_damage% ^| AMR: %armor_equip% ^| MGK: %magicka% ^| AP %player_action_p% ^| COINS: %COINS%
ECHO +--------------------------------------------------------------------------------------------------+
ECHO ^| HEALING TONIC: %hTonic_s%, PRICE: %hTonic_p%
ECHO ^| STAMINA TONIC: %sTonic_s%, PRICE: %sTonic_p%
ECHO ^| MAGICKA TONIC: %mTonic_s%, PRICE: %mTonic_p%
ECHO +--------------------------------------------------------------------------------------------------+
ECHO + [1 / HEALING TONIC ] ^| [2 / STAMINA TONIC ] ^| [3 / MAGICKA TONIC ] ^| [E / GO BACK ]              +
ECHO +--------------------------------------------------------------------------------------------------+
CHOICE /C 123E /N /M ">"
IF ERRORLEVEL 4 GOTO :MAIN
IF ERRORLEVEL 3 GOTO :ALCHEMIST_BUY_MGK_TONIC
IF ERRORLEVEL 2 GOTO :ALCHEMIST_BUY_STM_TONIC
IF ERRORLEVEL 1 GOTO :ALCHEMIST_BUY_HEL_TONIC

REM Attempt to purchase the healing Tonic.
:ALCHEMIST_BUY_HEL_TONIC
IF %coins% LSS %hTonic_p% (
    SET displayMessage=You can't afford this Tonic.
    GOTO :RWP_ALCHEMIST
) ELSE (
    SET /A COINS=!COINS! -%hTonic_p%
    SET /A healingT_q=!healingT_q! +1
    SET /A hTonic_s=!hTonic_s! -1
    SET displayMessage=Purchased 1 Healing Tonic for %hTonic_p% coins.
    GOTO :RWP_ALCHEMIST
)

REM Attempt to purchase the stamina Tonic.
:ALCHEMIST_BUY_STM_TONIC
IF %coins% LSS %sTonic_p% (
    SET displayMessage=You can't afford this Tonic.
    GOTO :RWP_ALCHEMIST
) ELSE (
    SET /A COINS=!COINS! -%sTonic_p%
    SET /A staminaT_q=!staminaT_q! +1
    SET /A sTonic_s=!sTonic_s! -1
    SET displayMessage=Purchased 1 stamina Tonic for %sTonic_p% coins.
    GOTO :RWP_ALCHEMIST
)

REM Attempt to purchase the magicka Tonic.
:ALCHEMIST_BUY_MGK_TONIC
IF %coins% LSS %mTonic_p% (
    SET displayMessage=You can't afford this Tonic.
    GOTO :RWP_ALCHEMIST
) ELSE (
    SET /A COINS=!COINS! -%mTonic_p%
    SET /A magickaT_q=!magickaT_q! +1
    SET /A mTonic_s=!mTonic_s! -1
    SET displayMessage=Purchased 1 magicka Tonic for %mTonic_p% coins.
    GOTO :RWP_ALCHEMIST
)

REM Armorer Vendor.
:RWP_ARMORER
TITLE (Rockwinn Plaza) - Armorer ^| %player_name% the %player_class%
MODE con: cols=107 lines=24
REM --
ECHO.
TYPE "%cd%\data\ascii\npcs\armorer.txt"
ECHO.
ECHO.
ECHO What can I do for you, Shard?
ECHO %displayMessage%
ECHO +---------------------------------------------------------------------------------------------------------+
ECHO ^| HP: %HP% ^| STM: %stamina% ^| ATK: %player_damage% ^| AMR: %armor_equip% ^| MGK: %magicka% ^| AP %player_action_p% ^| COINS: %COINS%
ECHO +---------------------------------------------------------------------------------------------------------+
ECHO ^| CACTUS ARMOR: %cactusArmor_s%, PRICE: %cactusArmor_p% ^| SCALED ARMOR: %scaledArmor_s%, PRICE: %scaledArmor_p% ^| SILVER ARMOR: %silverArmor_s%, PRICE: %silverArmor_p%
ECHO ^| STONE ARMOR: %stoneArmor_s%, PRICE: %stoneArmor_p%  ^| IRON ARMOR: %ironArmor_s%, PRICE: %ironArmor_p%     ^| GOLD ARMOR: %goldArmor_s%, PRICE: %goldArmor_p%
ECHO ^| STEEL ARMOR: %steelArmor_s%, PRICE: %steelArmor_p%  ^| LEATHER ARMOR: %leatherArmor_s%, PRICE: %leatherArmor_p% ^|
ECHO +---------------------------------------------------------------------------------------------------------+
ECHO + [1 / CACTUS ARMOR ]  ^| [2 / STONE ARMOR ]  ^| [3 / STEEL ARMOR ] ^| [4 / SCALED ARMOR ] ^| [5 / IRON ARMOR ]
ECHO +---------------------------------------------------------------------------------------------------------+
ECHO + [6 / LEATHER ARMOR ] ^| [7 / SILVER ARMOR ] ^| [8 / GOLD ARMOR ]  ^| [E / GO BACK ]                        +
ECHO +---------------------------------------------------------------------------------------------------------+
CHOICE /C 12345678E /N /M ">"
IF ERRORLEVEL 9 GOTO :MAIN
IF ERRORLEVEL 8 GOTO :ARMORER_BUY_GOLDARMOR
IF ERRORLEVEL 7 GOTO :ARMORER_BUY_SILVERARMOR
IF ERRORLEVEL 6 GOTO :ARMORER_BUY_LEATHERARMOR
IF ERRORLEVEL 5 GOTO :ARMORER_BUY_IRONARMOR
IF ERRORLEVEL 4 GOTO :ARMORER_BUY_SCALEDARMOR
IF ERRORLEVEL 3 GOTO :ARMORER_BUY_STEELARMOR
IF ERRORLEVEL 2 GOTO :ARMORER_BUY_STONEARMOR
IF ERRORLEVEL 1 GOTO :ARMORER_BUY_CACTUSARMOR

REM Attempt to purchase Cactus Armor.
:ARMORER_BUY_CACTUSARMOR
IF %coins% LSS %cactusA_p% (
    SET displayMessage=You can't afford this set.
    GOTO :RWP_ARMORER
) ELSE (
    SET /A COINS=!COINS! -%cactusA_p%
    SET /A cactusA_q=!cactusA_q! +1
    SET /A cactusArmor_s=!cactusArmor_s! -1
    SET displayMessage=Purchased 1 set of Cactus Armor for %cactusA_p% coins.
    GOTO :RWP_ARMORER
)

REM Attempt to purchase Stone Armor.
:ARMORER_BUY_STONEARMOR
IF %coins% LSS %stoneA_p% (
    SET displayMessage=You can't afford this set.
    GOTO :RWP_ARMORER
) ELSE (
    SET /A COINS=!COINS! -%stoneA_p%
    SET /A stoneA_q=!stoneA_q! +1
    SET /A stoneArmor_s=!stoneArmor_s! -1
    SET displayMessage=Purchased 1 set of Stone Armor for %stoneA_p% coins.
    GOTO :RWP_ARMORER
)

REM Attempt to purchase Steel Armor.
:ARMORER_BUY_STEELARMOR
IF %coins% LSS %steelA_p% (
    SET displayMessage=You can't afford this set.
    GOTO :RWP_ARMORER
) ELSE (
    SET /A COINS=!COINS! -%steelA_p%
    SET /A steelA_q=!steelA_q! +1
    SET /A steelArmor_s=!steelArmor_s! -1
    SET displayMessage=Purchased 1 set of Steel Armor for %steelA_p% coins.
    GOTO :RWP_ARMORER
)

REM Attempt to purchase Scaled Armor.
:ARMORER_BUY_SCALEDARMOR
IF %coins% LSS %scaledA_p% (
    SET displayMessage=You can't afford this set.
    GOTO :RWP_ARMORER
) ELSE (
    SET /A COINS=!COINS! -%scaledA_p%
    SET /A scaledA_q=!scaledA_q! +1
    SET /A scaledArmor_s=!scaledArmor_s! -1
    SET displayMessage=Purchased 1 set of Scaled Armor for %scaledA_p% coins.
    GOTO :RWP_ARMORER
)

REM Attempt to purchase Iron Armor.
:ARMORER_BUY_IRONARMOR
IF %coins% LSS %ironArmor_p% (
    SET displayMessage=You can't afford this set.
    GOTO :RWP_ARMORER
) ELSE (
    SET /A COINS=!COINS! -%ironArmor_p%
    SET /A ironA_q=!ironA_q! +1
    SET /A ironArmor_s=!ironArmor_s! -1
    SET displayMessage=Purchased 1 set of Iron Armor for %ironArmor_p% coins.
    GOTO :RWP_ARMORER
)

REM Attempt to purchase Leather Armor.
:ARMORER_BUY_LEATHERARMOR
IF %coins% LSS %leatherArmor_p% (
    SET displayMessage=You can't afford this set.
    GOTO :RWP_ARMORER
) ELSE (
    SET /A COINS=!COINS! -%leatherArmor_p%
    SET /A leatherA_q=!leatherA_q! +1
    SET /A leatherArmor_s=!leatherArmor_s! -1
    SET displayMessage=Purchased 1 set of Leather Armor for %leatherArmor_p% coins.
    GOTO :RWP_ARMORER
)

REM Attempt to purchase Silver Armor.
:ARMORER_BUY_SILVERARMOR
IF %coins% LSS %silverArmor_p% (
    SET displayMessage=You can't afford this set.
    GOTO :RWP_ARMORER
) ELSE (
    SET /A COINS=!COINS! -%silverArmor_p%
    SET /A silverA_q=!silverA_q! +1
    SET /A silverArmor_s=!silverArmor_s! -1
    SET displayMessage=Purchased 1 set of Silver Armor for %silverArmor_p% coins.
    GOTO :RWP_ARMORER
)

REM Attempt to purchase Gold Armor.
:ARMORER_BUY_GOLDARMOR
IF %coins% LSS %goldArmor_p% (
    SET displayMessage=You can't afford this set.
    GOTO :RWP_ARMORER
) ELSE (
    SET /A COINS=!COINS! -%goldArmor_p%
    SET /A goldA_q=!goldA_q! +1
    SET /A goldArmor_s=!goldArmor_s! -1
    SET displayMessage=Purchased 1 set of Gold Armor for %goldArmor_p% coins.
    GOTO :RWP_ARMORER
)

REM Blacksmith Vendor.
:RWP_BLACKSMITH
TITLE (Rockwinn Plaza) - Blacksmith ^| %player_name% the %player_class%
MODE con: cols=109 lines=22
REM --
ECHO.
TYPE "%cd%\data\ascii\npcs\blacksmith.txt"
ECHO.
ECHO.
ECHO What can I do for you, Shard?
ECHO %displayMessage%
ECHO +-----------------------------------------------------------------------------------------------------------+
ECHO ^| HP: %HP% ^| STM: %stamina% ^| ATK: %player_damage% ^| AMR: %armor_equip% ^| MGK: %magicka% ^| AP %player_action_p% ^| COINS: %COINS%
ECHO +-----------------------------------------------------------------------------------------------------------+
ECHO ^| SHORT SWORD: %sSword_s%, PRICE: %sSword_p% ^| MACE: %mace_s%, PRICE: %mace_p%
ECHO ^| LONG SWORD: %lSword_s%, PRICE: %lSword_p%  ^| WOODEN BOW: %wBow_s%, PRICE: %wBow_p%
ECHO ^| GREATAXE: %gAxe_s%, PRICE: %gAxe_p%
ECHO +-----------------------------------------------------------------------------------------------------------+
ECHO + [1 / SHORT SWORD ] ^| [2 / LONG SWORD ] ^| [3 / GREATAXE ] ^| [4 / MACE ] ^| [5 / WOODEN BOW ] ^| [E / GO BACK ]
ECHO +-----------------------------------------------------------------------------------------------------------+
CHOICE /C 12345E /N /M ">"
IF ERRORLEVEL 6 GOTO :MAIN
IF ERRORLEVEL 5 GOTO :BLACKSMITH_BUY_WOODENBOW
IF ERRORLEVEL 4 GOTO :BLACKSMITH_BUY_MACE
IF ERRORLEVEL 3 GOTO :BLACKSMITH_BUY_GREATAXE
IF ERRORLEVEL 2 GOTO :BLACKSMITH_BUY_LONGSWORD
IF ERRORLEVEL 1 GOTO :BLACKSMITH_BUY_SHORTSWORD 

REM Attempt to purchase the Short Sword.
:BLACKSMITH_BUY_SHORTSWORD
IF %coins% LSS %sSword_p% (
    SET displayMessage=You can't afford this sword.
    GOTO :RWP_BLACKSMITH
) ELSE (
    SET /A COINS=!COINS! -%sSword_p%
    SET /A shortsword_q=!shortsword_q! +1
    SET /A sSword_s=!sSword_s! -1
    SET displayMessage=Purchased 1 Short Sword for %sSword_p% coins.
    GOTO :RWP_BLACKSMITH
)

REM Attempt to purchase the Long Sword.
:BLACKSMITH_BUY_LONGSWORD
IF %coins% LSS %lSword_p% (
    SET displayMessage=You can't afford this set.
    GOTO :RWP_BLACKSMITH
) ELSE (
    SET /A COINS=!COINS! -%lSword_p%
    SET /A longsword_q=!longsword_q! +1
    SET /A lSword_s=!lSword_s! -1
    SET displayMessage=Purchased 1 Long Sword for %lSword_p% coins.
    GOTO :RWP_BLACKSMITH
)

REM Attempt to purchase the Greataxe.
:BLACKSMITH_BUY_GREATAXE
IF %coins% LSS %gAxe_p% (
    SET displayMessage=You can't afford this set.
    GOTO :RWP_BLACKSMITH
) ELSE (
    SET /A COINS=!COINS! -%gAxe_p%
    SET /A greataxe_q=!greataxe_q! +1
    SET /A gAxe_s=!gAxe_s! -1
    SET displayMessage=Purchased 1 Greataxe for %gAxe_p% coins.
    GOTO :RWP_BLACKSMITH
)

REM Attempt to purchase the Mace.
:BLACKSMITH_BUY_MACE
IF %coins% LSS %mace_p% (
    SET displayMessage=You can't afford this set.
    GOTO :RWP_BLACKSMITH
) ELSE (
    SET /A COINS=!COINS! -%mace_p%
    SET /A mace_q=!mace_q! +1
    SET /A mace_s=!mace_s! -1
    SET displayMessage=Purchased 1 Mace for %mace_p% coins.
    GOTO :RWP_BLACKSMITH
)

REM Attempt to purchase the Wooden Bow.
:BLACKSMITH_BUY_WOODENBOW
IF %coins% LSS %wBow_p% (
    SET displayMessage=You can't afford this set.
    GOTO :RWP_BLACKSMITH
) ELSE (
    SET /A COINS=!COINS! -%wBow_p%
    SET /A woodenb_q=!woodenb_q! +1
    SET /A wBow_s=!wBow_s! -1
    SET displayMessage=Purchased 1 Wooden Bow for %wBow_p% coins.
    GOTO :RWP_BLACKSMITH
)

REM Lorekeeper Vendor.
:RWP_LOREKEEPER
TITLE (Rockwinn Plaza) - Lorekeeper ^| %player_name% the %player_class%
MODE con: cols=99 lines=21
REM --
ECHO.
TYPE "%cd%\data\ascii\npcs\lorekeeper.txt"
ECHO.
ECHO.
ECHO What can I do for you, Shard?
ECHO %displayMessage%
ECHO +-------------------------------------------------------------------------------------------------+
ECHO ^| HP: %HP% ^| STM: %stamina% ^| ATK: %player_damage% ^| AMR: %armor_equip% ^| MGK: %magicka% ^| AP %player_action_p% ^| COINS: %COINS%
ECHO +-------------------------------------------------------------------------------------------------+
ECHO ^| TRAVELER'S JOURNAL: %tJournal_s%, PRICE: %tJournal_p%
ECHO ^| MERHCANT'S GUIDE: %mGuide_s%, PRICE: %mGuide_p%
ECHO +-------------------------------------------------------------------------------------------------+
ECHO + [1 / TRAVELER'S GUIDE ] ^| [2 / MERCHANT'S GUIDE ] ^| [3 / BROWSE MAPS ] ^| [E / GO BACK ]         +
ECHO +-------------------------------------------------------------------------------------------------+
CHOICE /C 123E /N /M ">"
IF ERRORLEVEL 4 GOTO :MAIN
IF ERRORLEVEL 3 GOTO :LOREKEEPER_BUY_MAPS
IF ERRORLEVEL 2 GOTO :LOREKEEPER_BUY_MERCHANTSGUIDE
IF ERRORLEVEL 1 GOTO :LOREKEEPER_BUY_TRAVELERSGUIDE

REM Attempt to purchase the Traveler's Journal.
:LOREKEEPER_BUY_TRAVELERSGUIDE
IF %coins% LSS %tJournal_p% (
    SET displayMessage=You can't afford this set.
    GOTO :RWP_LOREKEEPER
) ELSE (
    SET /A COINS=!COINS! -%tJournal_p%
    SET /A travelers_journalL_q=!travelers_journalL_q! +1
    SET /A tJournal_s=!tJournal_s! -1
    SET displayMessage=Purchased 1 Traveler's Journal for %tJournal_p% coins.
    GOTO :RWP_LOREKEEPER
)

REM Attempt to purchase the Merchant's Guide.
:LOREKEEPER_BUY_MERCHANTSGUIDE
IF %coins% LSS %mGuide_p% (
    SET displayMessage=You can't afford this set.
    GOTO :RWP_LOREKEEPER
) ELSE (
    SET /A COINS=!COINS! -%mGuide_p%
    SET /A merchants_guideL_q=!merchants_guideL_q! +1
    SET /A mGuide_s=!mGuide_s! -1
    SET displayMessage=Purchased 1 Merchant's Guide for %mGuide_p% coins.
    GOTO :RWP_LOREKEEPER
)

REM List of available maps to purchase. Used for unlocking new areas to explore.
:LOREKEEPER_BUY_MAPS
TITLE (Rockwinn Plaza) - Lorekeeper Maps ^| %player_name% the %player_class%
MODE con: cols=99 lines=20
REM --
ECHO.
TYPE "%cd%\data\ascii\npcs\lorekeeper.txt"
ECHO.
ECHO.
ECHO What can I do for you, Shard?
ECHO %displayMessage%
ECHO +-------------------------------------------------------------------------------------------------+
ECHO ^| HP: %HP% ^| STM: %stamina% ^| ATK: %player_damage% ^| AMR: %armor_equip% ^| MGK: %magicka% ^| AP %player_action_p% ^| COINS: %COINS%
ECHO +-------------------------------------------------------------------------------------------------+
ECHO ^| RUINS: %ruinsMap_s%, PRICE: %ruinsMap_p%
ECHO +-------------------------------------------------------------------------------------------------+
ECHO + [1 / RUINS MAP ] ^| [E / GO BACK ]                                                               +
ECHO +-------------------------------------------------------------------------------------------------+
CHOICE /C 1E /N /M ">"
IF ERRORLEVEL 2 GOTO :RWP_LOREKEEPER
IF ERRORLEVEL 1 GOTO :LOREKEEPER_BUY_RUINSMAP

REM Attempt to purchase the Ruins map.
:LOREKEEPER_BUY_RUINSMAP
IF %coins% LSS %ruinsMap_p% (
    SET displayMessage=You can't afford this set.
    GOTO :LOREKEEPER_BUY_MAPS
) ELSE (
    SET /A COINS=!COINS! -%ruinsMap_p%
    SET /A ruinsMap_s=!ruinsMap_s! -1
    SET ruins_unlocked=1
    SET displayMessage=Unlocked The Ruins for %ruinsMap_p% coins.
    REM Save the game.
    SET SLOPr=SAVE
    CALL "%cd%\data\functions\SLOP.bat"
    GOTO :LOREKEEPER_BUY_MAPS
)

REM Wizard Vendor.
:RWP_WIZARD
TITLE (Rockwinn Plaza) - Wizard ^| %player_name% the %player_class%
MODE con: cols=111 lines=23
REM --
ECHO.
TYPE "%cd%\data\ascii\npcs\wizard.txt"
ECHO.
ECHO.
ECHO What can I do for you, Shard?
ECHO %displayMessage%
ECHO +-------------------------------------------------------------------------------------------------------------+
ECHO ^| HP: %HP% ^| STM: %stamina% ^| ATK: %player_damage% ^| AMR: %armor_equip% ^| MGK: %magicka% ^| AP %player_action_p% ^| COINS: %COINS%
ECHO +-------------------------------------------------------------------------------------------------------------+
ECHO ^| BASIC ROBES: %bRobes_s%, PRICE: %bRobes_p%
ECHO ^| INTERMEDIATE ROBES: %iRobes_s%, PRICE: %iRobes_p%
ECHO ^| ADVANDED ROBES: %aRobes_s%, PRICE: %aRobes_p%
ECHO +-------------------------------------------------------------------------------------------------------------+
ECHO + [1 / BASIC ROBES ] ^| [2 / INTERMEDIATE ROBES ] ^| [3 / ADVANDED ROBES ] ^| [4 / SKILL POINTS ] ^| [E / GO BACK ]
ECHO +-------------------------------------------------------------------------------------------------------------+
CHOICE /C 1234E /N /M ">"
IF ERRORLEVEL 5 GOTO :MAIN
IF ERRORLEVEL 4 GOTO :WIZARD_VIEW_SKILLPOINTS
IF ERRORLEVEL 3 GOTO :WIZARD_BUY_ADVANCEDROBES
IF ERRORLEVEL 2 GOTO :WIZARD_BUY_INTERMEDIATEROBES
IF ERRORLEVEL 1 GOTO :WIZARD_BUY_BASICROBES

REM Attempt to purchase Basic Robes.
:WIZARD_BUY_BASICROBES
IF %coins% LSS %bRobes_p% (
    SET displayMessage=You can't afford these robes.
    GOTO :RWP_WIZARD
) ELSE (
    SET /A COINS=!COINS! -%bRobes_p%
    SET /A bRobes_q=!bRobes_q! +1
    SET /A bRobes_s=!bRobes_s! -1
    SET displayMessage=Purchased 1 Basic Robe for %bRobes_p% coins!
    GOTO :RWP_WIZARD
)

REM Attempt to purchase Intermediate Robes.
:WIZARD_BUY_INTERMEDIATEROBES
IF %coins% LSS %iRobes_p% (
    SET displayMessage=You can't afford these robes.
    GOTO :RWP_WIZARD
) ELSE (
    SET /A COINS=!COINS! -%iRobes_p%
    SET /A iRobes_q=!iRobes_q! +1
    SET /A iRobes_s=!iRobes_s! -1
    SET displayMessage=Purchased 1 Intermediate Robe for %iRobes_p% coins!
    GOTO :RWP_WIZARD
)

REM Attempt to purchase Advanced Robes.
:WIZARD_BUY_ADVANCEDROBES
IF %coins% LSS %aRobes_p% (
    SET displayMessage=You can't afford these robes.
    GOTO :RWP_WIZARD
) ELSE (
    SET /A COINS=!COINS! -%aRobes_p%
    SET /A aRobes_q=!aRobes_q! +1
    SET /A aRobes_s=!aRobes_s! -1
    SET displayMessage=Purchased 1 Advanced Robe for %aRobes_p% coins!
    GOTO :RWP_WIZARD
)

REM View or adjust skill points.
:WIZARD_VIEW_SKILLPOINTS
TITLE (Rockwinn Plaza) - Wizard ^| %player_name% the %player_class%
MODE con: cols=114 lines=23
REM --
ECHO.
TYPE "%cd%\data\ascii\npcs\wizard.txt"
ECHO.
ECHO.
ECHO Which skill would you like to improve?
ECHO %displayMessage%
ECHO +----------------------------------------------------------------------------------------------------------------+
ECHO ^| HP: %HP% ^| STM: %stamina% ^| ATK: %player_damage% ^| AMR: %armor_equip% ^| MGK: %magicka% ^| AP %player_action_p% ^| COINS: %COINS% ^| LEVELS: %LEVELS%
ECHO +----------------------------------------------------------------------------------------------------------------+
ECHO ^| DAMAGE:  %damage_skill%,  COST:  6 LEVELS
ECHO ^| SPEECH:  %speech_skill%,  COST:  9 LEVELS
ECHO ^| STAMINA: %stamina_skill%,  COST: 12 LEVELS
ECHO ^| MAGICKA: %magicka_skill%,  COST: 20 LEVELS
ECHO +----------------------------------------------------------------------------------------------------------------+
ECHO + [1 / IMPROVE DAMAGE ] ^| [2 / IMPROVE SPEECH ] ^| [3 / IMPROVE STAMINA ] ^| [4 / IMPROVE MAGICKA ] ^| [E / GO BACK ]
ECHO +----------------------------------------------------------------------------------------------------------------+
CHOICE /C 1234E /N /M ">"
IF ERRORLEVEL 5 GOTO :RWP_WIZARD
IF ERRORLEVEL 4 GOTO :WIZARD_IMPROVE_MAGICKA
IF ERRORLEVEL 3 GOTO :WIZARD_IMPROVE_STAMINA
IF ERRORLEVEL 2 GOTO :WIZARD_IMPROVE_SPEECH
IF ERRORLEVEL 1 GOTO :WIZARD_IMPROVE_DAMAGE

REM Attempt to improve the damage skill.
:WIZARD_IMPROVE_DAMAGE
IF %damage_skill% EQU 25 (
    REM Damage skill is that maximum level.
    SET displayMessage=Cannot improve this skill further.
    GOTO :WIZARD_VIEW_SKILLPOINTS
) ELSE (
    REM Check for skill conflicts.
    IF %magicka_skill% GEQ 12 (
        REM Magicka Skill conflict.
        SET displayMessage=Cannot improve this skill any further due to the Magicka level.
        GOTO :WIZARD_VIEW_SKILLPOINTS
    ) ELSE (
        IF %LEVELS% LSS 6 (
            REM Not enough levels.
            SET displayMessage=You can not afford this.
            GOTO :WIZARD_VIEW_SKILLPOINTS
        ) ELSE (
            REM Increase damage skill by 1.
            SET /A LEVELS=!LEVELS! -6
            SET /A damage_skill=!damage_skill! +1
            SET displayMessage=Improved damage skill by 1.
            GOTO :WIZARD_VIEW_SKILLPOINTS

        )
    )
)

REM Attempt to improve the speech skill.
:WIZARD_IMPROVE_SPEECH
IF %speech_skill% EQU 25 (
    REM Speech skill is that maximum level.
    SET displayMessage=Cannot improve this skill further.
    GOTO :WIZARD_VIEW_SKILLPOINTS
) ELSE (
    REM Check for skill conflicts.
    IF %magicka_skill% GEQ 12 (
        REM Magicka Skill conflict.
        SET displayMessage=Cannot improve this skill any further due to the Magicka level.
        GOTO :WIZARD_VIEW_SKILLPOINTS
    ) ELSE (
        IF %LEVELS% LSS 9 (
            REM Not enough levels.
            SET displayMessage=You can not afford this.
            GOTO :WIZARD_VIEW_SKILLPOINTS
        ) ELSE (
            REM Increase speech skill by 1.
            SET /A LEVELS=!LEVELS! -9
            SET /A speech_skill=!speech_skill! +1
            SET displayMessage=Improved speech skill by 1.
            GOTO :WIZARD_VIEW_SKILLPOINTS
        )
    )
)

REM Attempt to improve the stamina skill.
:WIZARD_IMPROVE_STAMINA
IF %stamina_skill% EQU 25 (
    REM Stamina skill is that maximum level.
    SET displayMessage=Cannot improve this skill further.
    GOTO :WIZARD_VIEW_SKILLPOINTS
) ELSE (
    REM Check for skill conflicts.
    IF %damage_skill% GEQ 12 (
        REM Damage Skill conflict.
        SET displayMessage=Cannot improve this skill any further due to the Damage level.
        GOTO :WIZARD_VIEW_SKILLPOINTS
    ) ELSE (
        IF %LEVELS% LSS 12 (
            REM Not enough levels.
            SET displayMessage=You can not afford this.
            GOTO :WIZARD_VIEW_SKILLPOINTS
        ) ELSE (
            REM Increase stamina skill by 1.
            SET /A LEVELS=!LEVELS! -12
            SET /A stamina_skill=!stamina_skill! +1
            SET displayMessage=Improved stamina skill by 1.
            GOTO :WIZARD_VIEW_SKILLPOINTS
        )
    )
)

REM Attempt to improve the magicka skill.
:WIZARD_IMPROVE_MAGICKA
IF %magicka_skill% EQU 25 (
    REM Maigicka skill is that maximum level.
    SET displayMessage=Cannot improve this skill further.
    GOTO :WIZARD_VIEW_SKILLPOINTS
) ELSE (
    REM Check for skill conflicts.
    IF %damage_skill% GEQ 12 (
        REM Magicka Skill conflict.
        SET displayMessage=Cannot improve this skill any further due to the Damage level.
        GOTO :WIZARD_VIEW_SKILLPOINTS
    ) ELSE (
        IF %LEVELS% LSS 20 (
            REM Not enough levels.
            SET displayMessage=You can not afford this.
            GOTO :WIZARD_VIEW_SKILLPOINTS
        ) ELSE (
            REM Increase magicka skill by 1.
            SET /A LEVELS=!LEVELS! -20
            SET /A magicka_skill=!magicka_skill! +1
            SET displayMessage=Improved magicka skill by 1.
            GOTO :WIZARD_VIEW_SKILLPOINTS
        )
    )
)

REM Saves Merchant data.
:AUTOSAVE
SET SLOPr=SAVE
CALL "%cd%\data\functions\SLOP.bat"
GOTO :EOF