@ECHO OFF
TITLE (WINDHELM) Inventory Viewer ^| %player_name% the %player_class%

REM Access to submenus.
:MM
MODE con: cols=100 lines=22
CLS
ECHO.
TYPE "%cd%\data\assets\ui\inventory.txt"
ECHO.
ECHO %displayMessage%
ECHO +--------------------------------------------------------------------------------------------------+
ECHO ^| COINS: %player_coins% ^| XP: %player_xp% ^| HP: %player_health% ^| ARMOR: %player_armor_equipped% ^| SHIELD: %player_shield_equipped% ^| WEAPON: %player_weapon_equipped%
ECHO +--------------------------------------------------------------------------------------------------+
ECHO ^| PARTY 1: %follower_name% ^| HP: %follower_health% ^| ATK: %follower_attack% ^| STM: %follower_stamina% ^| MGK: %follower_magicka%
ECHO +--------------------------------------------------------------------------------------------------+
ECHO ^| [1 / WEAPONS ] ^| [2 / TONICS ] ^| [3 / ARMOR ] ^| [4 / SHIELDS ] ^| [5 / BOOKS AND SCROLLS ]        +
ECHO ^| [E / EXIT ]                                                                                      +
ECHO +--------------------------------------------------------------------------------------------------+
CHOICE /C 12345E /N /M ">"
IF ERRORLEVEL 6 GOTO :EOF
IF ERRORLEVEL 5 GOTO :BOOKS_AND_SCROLLS
IF ERRORLEVEL 4 GOTO :SHIELDS
IF ERRORLEVEL 3 GOTO :ARMOR
IF ERRORLEVEL 2 GOTO :tonics
IF ERRORLEVEL 1 GOTO :WEAPONS

REM Weapon selection submenu.
:WEAPONS
MODE con: cols=100 lines=18
SET curMenu=WEAPONS
CLS
ECHO.
TYPE "%cd%\data\assets\ui\weapons.txt"
ECHO.
ECHO %displayMessage%
ECHO +--------------------------------------------------------------------------------------------------+
ECHO ^| COINS: %player_coins% ^| XP: %player_xp% ^| HP: %player_health% ^| ARMOR: %player_armor_equipped% ^| SHIELD: %player_shield_equipped%
ECHO ^| WEAPON: %player_weapon_equipped%
ECHO +--------------------------------------------------------------------------------------------------+
ECHO ^| [1 / SWORDS ] ^| [2 / AXES ] ^| [3 / MACES ] ^| [E / EXIT ]                                       +
ECHO +--------------------------------------------------------------------------------------------------+
CHOICE /C 123E /N /M ">"
IF ERRORLEVEL 4 GOTO :MM
IF ERRORLEVEL 3 GOTO :MACES_INVENTORY
IF ERRORLEVEL 2 GOTO :AXES_INVENTORY
IF ERRORLEVEL 1 GOTO :SWORD_INVENTORY

REM View owned weapons of the Mace category.
:MACES_INVENTORY
MODE con: cols=100 lines=19
SET curMenu=MACES_INVENTORY
CLS
ECHO.
TYPE "%cd%\data\assets\ui\maces.txt"
ECHO.
ECHO %displayMessage%
ECHO +--------------------------------------------------------------------------------------------------+
ECHO ^| COINS: %player_coins% ^| XP: %player_xp% ^| HP: %player_health% ^| ARMOR: %player_armor_equipped% ^| SHIELD: %player_shield_equipped% ^| WEAPON: %player_weapon_equipped%
ECHO +--------------------------------------------------------------------------------------------------+
ECHO ^| MACE: %player_mace_owned%
ECHO +--------------------------------------------------------------------------------------------------+
ECHO ^| [1 / MACE ] ^| [E / EXIT ]                                                                        +
ECHO +--------------------------------------------------------------------------------------------------+
CHOICE /C 1UE /N /M ">"
IF ERRORLEVEL 3 GOTO :WEAPONS
IF ERRORLEVEL 2 GOTO :unequip_weapon
IF ERRORLEVEL 1 GOTO :EQUIP_MACE

REM Equip the Long Sword weapon to the primary weapon slot.
:EQUIP_MACE
IF %player_mace_owned% EQU 0 (
    REM The Player does not have this item in their inventory and cannot equip it.
    GOTO :no_item
) ELSE (
    IF NOT %player_weapon_equipped% == EMPTY (
        REM There is already an equipped weapon.
        SET displayMessage=%player_weapon_equipped% is currently equipped. Press U to unequip.
        GOTO :MACES_INVENTORY
    ) ELSE IF %player_weapon_equipped% == Mace (
        REM This weapon is already equipped.
        SET displayMessage=This weapon is already equipped.
        GOTO :MACES_INVENTORY
    ) ELSE (
        SET player_weapon_equipped=Mace
        SET player_damage=%mace_d%
        SET displayMessage=Equipped Mace.
        GOTO :MACES_INVENTORY
    )
)

REM View owned weapons of the Axe category.
:AXES_INVENTORY
MODE con: cols=100 lines=19
SET curMenu=AXES_INVENTORY
CLS
ECHO.
TYPE "%cd%\data\assets\ui\axes.txt"
ECHO.
ECHO %displayMessage%
ECHO +--------------------------------------------------------------------------------------------------+
ECHO ^| COINS: %player_coins% ^| XP: %player_xp% ^| HP: %player_health% ^| ARMOR: %player_armor_equipped% ^| SHIELD: %player_shield_equipped% ^| WEAPON: %player_weapon_equipped%
ECHO +--------------------------------------------------------------------------------------------------+
ECHO ^| GREAT AXE: %player_greatAxe_owned%
ECHO +--------------------------------------------------------------------------------------------------+
ECHO ^| [1 / GREAT AXE ] ^| [E / EXIT ]                                                                   +
ECHO +--------------------------------------------------------------------------------------------------+
CHOICE /C 1UE /N /M ">"
IF ERRORLEVEL 3 GOTO :WEAPONS
IF ERRORLEVEL 2 GOTO :unequip_weapon
IF ERRORLEVEL 1 GOTO :EQUIP_GAXE

REM Equip the Great Axe weapon to the primary weapon slot.
:EQUIP_GAXE
IF %player_greatAxe_owned% EQU 0 (
    REM The Player does not have this item in their inventory and cannot equip it.
    GOTO :no_item
) ELSE (
    IF NOT %player_weapon_equipped% == EMPTY (
        REM There is already an equipped weapon.
        SET displayMessage=%player_weapon_equipped% is currently equipped. Press U to unequip.
        GOTO :AXES_INVENTORY
    ) ELSE IF %player_weapon_equipped% == GreatAxe (
        REM This weapon is already equipped.
        SET displayMessage=This weapon is already equipped.
        GOTO :AXES_INVENTORY
    ) ELSE (
        SET player_weapon_equipped=GreatAxe
        SET player_damage=%greataxe_d%
        SET displayMessage=Equipped Great Axe.
        GOTO :AXES_INVENTORY
    )
)

REM View owned weapons of the Sword category.
:SWORD_INVENTORY
MODE con: cols=100 lines=19
SET curMenu=SWORD_INVENTORY
CLS
ECHO.
TYPE "%cd%\data\assets\ui\swords.txt"
ECHO.
ECHO %displayMessage%
ECHO +--------------------------------------------------------------------------------------------------+
ECHO ^| COINS: %player_coins% ^| XP: %player_xp% ^| HP: %player_health% ^| ARMOR: %player_armor_equipped% ^| SHIELD: %player_shield_equipped% ^| WEAPON: %player_weapon_equipped%
ECHO +--------------------------------------------------------------------------------------------------+
ECHO ^| Long Sword: %player_longSword_owned% ^| Short Sword: %player_shortSword_owned%
ECHO +--------------------------------------------------------------------------------------------------+
ECHO ^| [1 / LONG SWORD ] ^| [2 / SHORT SWORD ] ^| [E / EXIT ]                                             +
ECHO +--------------------------------------------------------------------------------------------------+
CHOICE /C 12UE /N /M ">"
IF ERRORLEVEL 4 GOTO :WEAPONS
IF ERRORLEVEL 3 GOTO :unequip_weapon
IF ERRORLEVEL 2 GOTO :EQUIP_SHORT_SWORD
IF ERRORLEVEL 1 GOTO :EQUIP_LONG_SWORD

REM Equip the Short Sword weapon to the primary weapon slot.
:EQUIP_SHORT_SWORD
IF %player_shortSword_owned% EQU 0 (
    REM The Player does not have this item in their inventory and cannot equip it.
    GOTO :no_item
) ELSE (
    IF NOT %player_weapon_equipped% == EMPTY (
        REM There is already an equipped weapon.
        SET displayMessage=%player_weapon_equipped% is currently equipped. Press U to unequip.
        GOTO :SWORD_INVENTORY
    ) ELSE IF %player_weapon_equipped% == ShortSword (
        REM This weapon is already equipped.
        SET displayMessage=This weapon is already equipped.
        GOTO :SWORD_INVENTORY
    ) ELSE (
        SET player_weapon_equipped=ShortSword
        SET player_damage=%shortsword_d%
        SET displayMessage=Equipped Short Sword.
        GOTO :SWORD_INVENTORY
    )
)

REM Equip the Long Sword weapon to the primary weapon slot.
:EQUIP_LONG_SWORD
IF %player_longSword_owned% EQU 0 (
    REM The Player does not have this item in their inventory and cannot equip it.
    GOTO :no_item
) ELSE (
    IF NOT %player_weapon_equipped% == EMPTY (
        REM There is already an equipped weapon.
        SET displayMessage=%player_weapon_equipped% is currently equipped. Press U to unequip.
        GOTO :SWORD_INVENTORY
    ) ELSE IF %player_weapon_equipped% == LongSword (
        REM This weapon is already equipped.
        SET displayMessage=This weapon is already equipped.
        GOTO :SWORD_INVENTORY
    ) ELSE (
        SET player_weapon_equipped=LongSword
        SET player_damage=%longsword_d%
        SET displayMessage=Equipped Long Sword.
        GOTO :SWORD_INVENTORY
    )
)

REM Tonics
:tonics
MODE con: cols=100 lines=19
SET curMenu=tonics
CLS
ECHO.
TYPE "%cd%\data\assets\ui\tonics.txt"
ECHO.
ECHO %displayMessage%
ECHO +--------------------------------------------------------------------------------------------------+
ECHO ^| COINS: %player_coins% ^| XP: %player_xp% ^| HP: %player_health% ^| ARMOR: %player_armor_equipped% ^| SHIELD: %player_shield_equipped% ^| WEAPON: %player_weapon_equipped%
ECHO +--------------------------------------------------------------------------------------------------+
ECHO ^| HEALING TONIC: %player_healingTonic_owned% ^| STAMINA TONIC: %player_staminaTonic_owned% ^| MAGICKA TONIC: %player_magickaTonic_owned%
ECHO +--------------------------------------------------------------------------------------------------+
ECHO ^| [1 / HEALING TONIC ] ^| [2 / STAMINA TONIC ] ^| [3 / MAGICKA TONIC ] ^| [E / EXIT ]                 +
ECHO +--------------------------------------------------------------------------------------------------+
CHOICE /C 123E /N /M ">"
IF ERRORLEVEL 4 GOTO :MM
IF ERRORLEVEL 3 GOTO :CONSUME_MAGICKA_TONIC
IF ERRORLEVEL 2 GOTO :CONSUME_STAMINA_TONIC
IF ERRORLEVEL 1 GOTO :CONSUME_HEALING_TONIC

REM CONSUME the healing tonic :)
:CONSUME_HEALING_TONIC
IF NOT %CE7CALL% EQU 1 (
    REM The script was NOT called from Combat Engine.
    SET displayMessage=Cannot consume tonics outside of combat.
    GOTO :tonics
) ELSE (
    REM Check if there is enough of this tonic to consume.
    IF %player_healingTonic_owned% EQU 0 (
        REM There is not enough of this tonic to consume.
        SET displayMessage=You're out of this item.
        GOTO :tonics
    ) ELSE (
        REM Consume the tonic.
        SET /A player_healingTonic_owned=!player_healingTonic_owned! -1
        SET /A player_health=!player_health! +20
        REM Check if the health exceeds the cap.
        IF %player_health% GTR %player_health_max% (
            REM Reset the HP value.
            SET player_health=%player_health_max%
            GOTO :tonics
        ) ELSE (
            GOTO :tonics
        )
    )
)

REM CONSUME the stamina tonic :)
:CONSUME_STAMINA_TONIC
IF NOT %CE7CALL% EQU 1 (
    REM The script was NOT called from Combat Engine.
    SET displayMessage=Cannot consume tonics outside of combat.
    GOTO :tonics
) ELSE (
    REM Check if there is enough of this tonic to consume.
    IF %player_staminaTonic_owned% EQU 0 (
        REM There is not enough of this tonic to consume.
        SET displayMessage=You're out of this item.
        GOTO :tonics
    ) ELSE (
        REM Consume the tonic.
        SET /A player_staminaTonic_owned=!player_staminaTonic_owned! -1
        SET /A stamina=!stamina! +15
        REM Check if the stamina exceeds the cap.
        IF %stamina% GTR %player_stamina_max% (
            REM Reset the stamina value.
            SET stamina=%player_stamina_max%
            GOTO :tonics
        ) ELSE (
            GOTO :tonics
        )
    )
)

REM CONSUME the magicka tonic.
:CONSUME_MAGICKA_TONIC
IF NOT %CE7CALL% EQU 1 (
    REM The script was NOT called from Combat Engine.
    SET displayMessage=Cannot consume tonics outside of combat.
    GOTO :tonics
) ELSE (
    REM Check if there is enough of this tonic to consume.
    IF %player_magickaTonic_owned% EQU 0 (
        REM There is not enough of this tonic to consume.
        SET displayMessage=You're out of this item.
        GOTO :tonics
    ) ELSE (
        REM Consume the tonic.
        SET /A player_magickaTonic_owned=!player_magickaTonic_owned! -1
        SET /A magicka=!magicka! +10
        REM Check if the magicka exceeds the cap.
        IF %magicka% GTR %player_magicka_max% (
            REM Reset the Magicka value.
            SET magicka=%player_magicka_max%
            GOTO :tonics
        ) ELSE (
            GOTO :tonics
        )
    )
)

REM Armor
:armor
MODE con: cols=100 lines=22
SET curMenu=armor
CLS
ECHO.
TYPE "%cd%\data\assets\ui\armor.txt"
ECHO.
ECHO %displayMessage%
ECHO +--------------------------------------------------------------------------------------------------+
ECHO ^| COINS: %player_coins% ^| XP: %player_xp% ^| HP: %player_health% ^| ARMOR: %player_armor_equipped% ^| SHIELD: %player_shield_equipped% ^| WEAPON: %player_weapon_equipped%
ECHO +--------------------------------------------------------------------------------------------------+
ECHO ^| CACTUS ARMOR: %cactusA_q% ^| STONE ARMOR: %stoneA_q% ^| STEEL ARMOR: %steelA_q% ^| SCALED ARMOR: %scaledA_q% ^| GOLD ARMOR: %goldA_q%
ECHO ^| GUARD ARMOR: %guardA_q% ^| IRON ARMOR: %ironA_q% ^| LEATHER ARMOR: %leatherA_q% ^| SILVER ARMOR: %silverA_q%
ECHO +--------------------------------------------------------------------------------------------------+
ECHO ^| [1 / CACTUS ARMOR ] ^| [2 / STONE ARMOR ] ^| [3 / STEEL ARMOR ]   ^| [4 / SCALED ARMOR ]            +
ECHO ^| [5 / GUARD ARMOR ]  ^| [6 / IRON ARMOR ]  ^| [7 / LEATHER ARMOR ] ^| [8 / SILVER ARMOR ]            +
ECHO ^| [9 / GOLD ARMOR ]   ^| [R / ROBES ] ^| [E / EXIT ]                                                 +
ECHO +--------------------------------------------------------------------------------------------------+
CHOICE /C 123456789RE /N /M ">"
IF ERRORLEVEL 11 GOTO :MM
IF ERRORLEVEL 10 GOTO :viewRobes
IF ERRORLEVEL 9 GOTO :equipGold
IF ERRORLEVEL 8 GOTO :equipSilver
IF ERRORLEVEL 7 GOTO :equipLeather
IF ERRORLEVEL 6 GOTO :equipIron
IF ERRORLEVEL 5 GOTO :equipGuard
IF ERRORLEVEL 4 GOTO :equipScaled
IF ERRORLEVEL 3 GOTO :equipSteel
IF ERRORLEVEL 2 GOTO :equipStone
IF ERRORLEVEL 1 GOTO :equipCactus

REM Equip Cactus armor, not exclusive with any shields.
:equipCactus
IF %cactusA_q% EQU 0 (
    GOTO :no_item
) ELSE (
    IF NOT %player_armor_equipped% == EMPTY (
        SET displayMessage=You are already wearing armor.
        GOTO :armor
    ) ELSE IF %player_armor_equipped% == CactusArmor (
        SET displayMessage=You are already wearing this set.
        GOTO :armor
    ) ELSE (
        SET player_armor_equipped=CactusArmor
        SET armor_equip=%cactusA_p%
        SET displayMessage=Equipped Cactus armor. Max stamina reduced to 92.
        SET maxStam=92
        SET stamina=maxStam
        GOTO :armor
    )
)

REM Equip stone armor, not exclusive with any shields.
:equipStone
IF %stoneA_q% EQU 0 (
    GOTO :no_item
) ELSE (
    IF NOT %player_armor_equipped% == EMPTY (
        SET displayMessage=You are already wearing armor.
        GOTO :armor
    ) ELSE IF %player_armor_equipped% == StoneArmor (
        SET displayMessage=You are already wearing this set.
        GOTO :armor
    ) ELSE (
        SET player_armor_equipped=StoneArmor
        SET armor_equip=%stoneA_p%
        SET displayMessage=Equipped Stone armor. Max stamina reduced to 88.
        SET maxStam=88
        SET stamina=maxStam
        GOTO :armor
    )
)

REM Equip steel armor, not exclusive with any shields.
:equipSteel
IF %steelA_q% EQU 0 (
    GOTO :no_item
) ELSE (
    IF NOT %player_armor_equipped% == EMPTY (
        SET displayMessage=You are already wearing armor.
        GOTO :armor
    ) ELSE IF %player_armor_equipped% == SteelArmor (
        SET displayMessage=You are already wearing this set.
        GOTO :armor
    ) ELSE (
        SET player_armor_equipped=SteelArmor
        SET armor_equip=%steelA_p%
        SET displayMessage=Equipped Steel armor. Max stamina reduced to 84.
        SET maxStam=84
        SET stamina=maxStam
        GOTO :armor
    )
)

REM Equip scaled armor, exclusive with the Bronze Buckler.
:equipScaled
IF %scaledA_q% EQU 0 (
    GOTO :no_item
) ELSE (
    IF NOT %player_armor_equipped% == EMPTY (
        SET displayMessage=You are already wearing armor.
        GOTO :armor
    ) ELSE IF %player_armor_equipped% == ScaledArmor (
        SET displayMessage=You are already wearing this set.
        GOTO :armor
    ) ELSE (
        IF %player_shield_equipped% == BronzeBuckler (
            SET displayMessage=Cannot equip Scaled Armor and Bronze Buckler at the same time.
            GOTO :armor
        ) ELSE (
            SET player_armor_equipped=ScaledArmor
            SET armor_equip=%scaledA_p%
            SET displayMessage=Equipped Scaled armor. Max stamina reduced to 72.
            SET maxStam=72
            SET stamina=maxStam
            GOTO :armor
        )
    )
)

REM Equip guard armor, exclusive with the Kite Shield.
:equipGuard
IF %guardA_q% EQU 0 (
    GOTO :no_item
) ELSE (
    IF NOT %player_armor_equipped% == EMPTY (
        SET displayMessage=You are already wearing armor.
        GOTO :armor
    ) ELSE IF %player_armor_equipped% == GuardArmor (
        SET displayMessage=You are already wearing this set.
        GOTO :armor
    ) ELSE (
        IF %player_shield_equipped% == KiteShield (
            SET displayMessage=Cannot equip Guard Armor and the Kite Shield at the same time.
            GOTO :armor
        ) ELSE (
            SET player_armor_equipped=GuardArmor
            SET armor_equip=%guardA_p%
            SET displayMessage=Equipped Guard armor. Max stamina reduced to 82.
            SET maxStam=82
            SET stamina=maxStam
            GOTO :armor
        )
    )
)

REM Equip Iron Armor.
:equipIron
IF %ironA_q% EQU 0 (
    GOTO :no_item
) ELSE (
    IF NOT %player_armor_equipped% == EMPTY (
        SET displayMessage=You are already wearing armor.
        GOTO :armor
    ) ELSE IF %player_armor_equipped% == IronArmor (
        SET displayMessage=You are already wearing this set.
        GOTO :armor
    ) ELSE (
        SET player_armor_equipped=IronArmor
        SET armor_equip=%ironArmor_prot%
        SET displayMessage=Iron Armor was equipped.
        SET maxStam=90
        SET stamina=%maxStam%
        GOTO :armor
    )
)

REM Equip Leather Armor.
:equipLeather
IF %leatherA_q% EQU 0 (
    GOTO :no_item
) ELSE (
    IF NOT %player_armor_equipped% == EMPTY (
        SET displayMessage=You are already wearing armor.
        GOTO :armor
    ) ELSE IF %player_armor_equipped% == LeatherArmor (
        SET displayMessage=You are already wearing this set.
        GOTO :armor
    ) ELSE (
        SET player_armor_equipped=LeatherArmor
        SET armor_equip=%leatherArmor_prot%
        SET displayMessage=Leather Armor was equipped.
        SET maxStam=100
        SET stamina=%maxStam%
        GOTO :armor
    )
)

REM Equip Silver Armor.
:equipSilver
IF %silverA_q% EQU 0 (
    GOTO :no_item
) ELSE (
    IF NOT %player_armor_equipped% == EMPTY (
        SET displayMessage=You are already wearing armor.
        GOTO :armor
    ) ELSE IF %player_armor_equipped% == SilverArmor (
        SET displayMessage=You are already wearing this set.
        GOTO :armor
    ) ELSE (
        SET player_armor_equipped=SilverArmor
        SET armor_equip=%silverArmor_prot%
        SET displayMessage=Silver Armor was equipped.
        SET maxStam=95
        SET stamina=%maxStam%
        GOTO :armor
    )
)

REM Equip Gold Armor.
:equipGold
IF %goldA_q% EQU 0 (
    GOTO :no_item
) ELSE (
    IF NOT %player_armor_equipped% == EMPTY (
        SET displayMessage=You are already wearing armor.
        GOTO :armor
    ) ELSE IF %player_armor_equipped% == GoldArmor (
        SET displayMessage=You are already wearing this set.
        GOTO :armor
    ) ELSE (
        SET player_armor_equipped=GoldArmor
        SET armor_equip=%goldArmor_prot%
        SET displayMessage=Gold Armor was equipped.
        SET maxStam=70
        SET stamina=%maxStam%
        GOTO :armor
    )
)

REM View owned robes.
:viewRobes
MODE con: cols=100 lines=20
SET curMenu=viewRobes
CLS
ECHO.
TYPE "%cd%\data\assets\ui\robes.txt"
ECHO.
ECHO %displayMessage%
ECHO +--------------------------------------------------------------------------------------------------+
ECHO ^| COINS: %player_coins% ^| XP: %player_xp% ^| HP: %player_health% ^| ARMOR: %player_armor_equipped% ^| SHIELD: %player_shield_equipped% ^| WEAPON: %player_weapon_equipped%
ECHO +--------------------------------------------------------------------------------------------------+
ECHO ^| BASIC ROBES: %bRobes_q% ^| INTERMEDIATE ROBES: %iRobes_q% ^| ADVANDED ROBES: %aRobes_q%
ECHO +--------------------------------------------------------------------------------------------------+
ECHO ^| [1 / BASIC ROBES ] ^| [2 / INTERMEDIATE ROBES ] ^| [3 / ADVANDED ROBES] ^| [E / EXIT ]               +
ECHO +--------------------------------------------------------------------------------------------------+
CHOICE /C 123E /N /M ">"
IF ERRORLEVEL 4 GOTO :armor
IF ERRORLEVEL 3 GOTO :equipARobes
IF ERRORLEVEL 2 GOTO :equipIRobes
IF ERRORLEVEL 1 GOTO :equipBRobes

REM Equp the Advanced Robes
:equipARobes
IF %aRobes_q% EQU 0 (
    REM Player does not own any of this Robe type.
    SET displayMessage=You do not own any of this item to equip.
    GOTO :viewRobes
) ELSE (
    IF NOT %player_armor_equipped% == VACANT (
        REM Player is already wearing an set of robes or armor.
        SET displayMessage=You are already wearing Robes or Armor.
        GOTO :viewRobes
    ) ELSE (
        REM Equip advanced robes
        SET player_armor_equipped=AdvancedRobes
        SET player_magicka_max=150
        SET player_stamina_max=150
        SET displayMessage=Equipped Advanced Robes.
        GOTO :viewRobes
    )
)

REM Equip the Intermediate Robes
:equipIRobes
IF %iRobes_q% EQU 0 (
    REM Player does not own any of this Robe type.
    SET displayMessage=You do not own any of this item to equip.
    GOTO :viewRobes
) ELSE (
    IF NOT %player_armor_equipped% == VACANT (
        REM Player is already wearing an set of robes or armor.
        SET displayMessage=You are already wearing Robes or Armor.
        GOTO :viewRobes
    ) ELSE (
        REM Equip intermediate robes
        SET player_armor_equipped=IntermediateRobes
        SET player_magicka_max=125
        SET player_stamina_max=125
        SET displayMessage=Equipped Intermediate Robes.
        GOTO :viewRobes
    )
)

REM Equip the Basic Robes
:equipBRobes
IF %bRobes_q% EQU 0 (
    REM Player does not own any of this Robe type.
    SET displayMessage=You do not own any of this item to equip.
    GOTO :viewRobes
) ELSE (
    IF NOT %player_armor_equipped% == VACANT (
        REM Player is already wearing an set of robes or armor.
        SET displayMessage=You are already wearing Robes or Armor.
        GOTO :viewRobes
    ) ELSE (
        REM Equip basic robes
        SET player_armor_equipped=BasicRobes
        SET player_magicka_max=110
        SET player_stamina_max=110
        SET displayMessage=Equipped Basic Robes.
        GOTO :viewRobes
    )
)

REM Shields submenu.
:shields
MODE con: cols=100 lines=19
SET curMenu=shields
CLS
ECHO.
TYPE "%cd%\data\assets\ui\shields.txt"
ECHO.
ECHO %displayMessage%
ECHO +--------------------------------------------------------------------------------------------------+
ECHO ^| COINS: %player_coins% ^| XP: %player_xp% ^| HP: %player_health% ^| ARMOR: %player_armor_equipped% ^| SHIELD: %player_shield_equipped% ^| WEAPON: %player_weapon_equipped%
ECHO +--------------------------------------------------------------------------------------------------+
ECHO ^| BRONZE BUCKLER: %bronze_buckler_q% ^| KITE SHIELD: %kite_shield_q%
ECHO +--------------------------------------------------------------------------------------------------+
ECHO ^| [1 / BRONZE BUCKLER ] ^| [2 / KITE SHIELD ] ^| [E / EXIT ]                                         +
ECHO +--------------------------------------------------------------------------------------------------+
CHOICE /C 12UE /N /M ">"
IF ERRORLEVEL 4 GOTO :MM
IF ERRORLEVEL 3 GOTO :unequip_shield
IF ERRORLEVEL 2 GOTO :equip_kite
IF ERRORLEVEL 1 GOTO :equip_bronze_buckler

REM Equip bronze buckler shield.
:equip_bronze_buckler
IF %bronze_buckler_q% EQU 0 (
    GOTO :no_item
) ELSE (
    IF NOT %player_shield_equipped% == EMPTY (
        SET displayMessage=You are already wearing a different shield.
        GOTO :shields
    ) ELSE IF %player_shield_equipped% == BronzeBuckler (
        SET displayMessage=You are already wearing this shield.
        GOTO :shields
    ) ELSE (
        IF %player_armor_equipped% == ScaledArmor (
            SET displayMessage=Cannot equip Bronze Buckler and Scaled Armor at the same time.
            GOTO :shields
        ) ELSE (
            SET displayMessage=Equipped the Bronze Buckler.
            SET player_shield_equipped=BronzeBuckler
            GOTO :shields
        )
    )
)

REM Equip kite shield.
:equip_kite
IF %kite_shield_q% EQU 0 (
    REM Player does not have any of this item.
    GOTO :no_item
) ELSE (
    IF NOT %player_shield_equipped% == EMPTY (
        REM Player already has a different shield equipped.
        SET displayMessage=Already wearing a shield.
        GOTO :shields
    ) ELSE (
        IF %player_armor_equipped% == GuardArmor (
            REM Player is wear an exlcuded armor set.
            SET displayMessage=Can not wear this shield with the Guard Armor.
            GOTO :shields
        ) ELSE (
            REM Equip this shield.
            SET player_shield_equipped=KiteShield
            SET displayMessage=Equipped the Kite Shield.
            GOTO :shields
        )
    )
)

REM Books & Scrolls submenu.
:BOOKS_AND_SCROLLS
MODE con: cols=141 lines=19
SET curMenu=BOOKS_AND_SCROLLS
CLS
ECHO.
TYPE "%cd%\data\assets\ui\books.txt"
ECHO.
ECHO %displayMessage%
ECHO +-------------------------------------------------------------------------------------------------------------------------------------------+
ECHO ^| COINS: %player_coins% ^| XP: %player_xp% ^| HP: %player_health% ^| ARMOR: %player_armor_equipped% ^| SHIELD: %player_shield_equipped% ^| WEAPON: %player_weapon_equipped%
ECHO +-------------------------------------------------------------------------------------------------------------------------------------------+
ECHO ^| TRAVELER'S JOURNAL: %travelers_journal_q% ^| MERCHANT'S GUIDE: %merchants_guide_q%
ECHO +-------------------------------------------------------------------------------------------------------------------------------------------+
ECHO ^| [1 / TRAVELER'S JOURNAL ] ^| [2 / GUIDE TO BLADES ] ^| [3 / MERCHANT'S GUIDE ] ^| [E / EXIT ]                                                +
ECHO +-------------------------------------------------------------------------------------------------------------------------------------------+
CHOICE /C 123E /N /M ">"
IF ERRORLEVEL 4 GOTO :MM
IF ERRORLEVEL 3 GOTO :readMG
IF ERRORLEVEL 2 GOTO :readGTB
IF ERRORLEVEL 1 GOTO :readTJ

REM Read the Merchant's Guide book.
:readMG
IF %merchants_guide_q% EQU 0 (
    REM The Player does not have this item in their inventory and cannot read it.
    GOTO :no_bs
) ELSE (
    IF %merchants_guide_r% EQU 1 (
        REM The Player has read this book/sroll already and cannot gain another skill point/level from it.
        GOTO :read_already
    ) ELSE (
        REM The Player has not read this book before and can gain the skill point/level from it.
        SET /A speech_skill=!speech_skill! +1
        SET displayMessage=You have read the Merchant's Guide book and gained 1 Speech Skill level.
        SET merchants_guide_r=1
        GOTO :BOOKS_AND_SCROLLS
    )
)

REM Read the Guide to Blades book.
:readGTB
IF %guide_to_blades_q% EQU 0 (
    REM The Player does not have this item in their inventory and cannot read it.
    GOTO :no_bs
) ELSE (
    IF %guide_to_blades_r% EQU 1 (
        REM The Player has read this book/sroll already and cannot gain another skill point/level from it.
        GOTO :read_already
    ) ELSE (
        REM The Player has not read this book before and can gain the skill point/level from it.
        SET /A damage_skill=!damage_skill! +1
        SET displayMessage=You have read the Guide to Blades book and gained 1 Damage Skill level.
        SET guide_to_blades_r=1
        GOTO :BOOKS_AND_SCROLLS
    )
)

REM Read the Traveler's Journal.
:readTJ
IF %travelers_journal_q% EQU 0 (
    REM The Player does not have this item in their inventory and cannot read it.
    GOTO :no_bs
) ELSE (
    IF %travelers_journal_r% EQU 1 (
        REM The Player has read this book/sroll already and cannot gain another skill point/level from it.
        GOTO :read_already
    ) ELSE (
        REM The Player has not read this book before and can gain the skill point/level from it.
        SET /A stamina_skill=!stamina_skill! +1
        SET displayMessage=You have read the Traveler's Journal and gained 1 Stamina Skill level.
        SET travelers_journal_r=1
        GOTO :BOOKS_AND_SCROLLS
    )
)

REM Unequips the currently equipped weapon.
:unequip_weapon
SET player_weapon_equipped=EMPTY
SET player_damage=5
SET displayMessage=Unequipped.
GOTO :%curMenu%

REM Unequips the currently equipped armor set.
:unequip_armor
SET player_armor_equipped=EMPTY
SET armor_equip=0
SET displayMessage=Unequipped.
GOTO :%curMenu%

REM Unequips the currently equipped shield.
:unequip_shield
SET player_weapon_equipped=EMPTY
SET displayMessage=Unequipped.
GOTO :%curMenu%

REM Already have this item equipped.
:already_equipped
SET displayMessage=You already have this item equipped.
GOTO :%curMenu%

REM Does not own this item.
:no_item
SET displayMessage=You cannot equip an item you do not own.
GOTO :%curMenu%

REM You don't own / this item doesn't exist.
:no_bs
SET displayMessage=You don't own this scroll / book.
GOTO :%curMenu%

REM Already read this book and gained  the skill point.
:read_already
SET displayMessage=You've already read this scroll / book.
GOTO :%curMenu%

:shield_conflict
SET displayMessage=A shield is already equipped! Unequip it before trying to equip this shield.
GOTO :shields

:shield_armor_conflict
SET displayMessage=You cannot equip both armor and a shield!
GOTO :shields