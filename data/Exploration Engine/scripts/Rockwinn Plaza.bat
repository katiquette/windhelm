@ECHO OFF
TITLE (Rockwinn Plaza) - Rockwinn Plaza ^| %player_name% the %player_class%

SET refunded=false
SET refundPrice=0

REM Main Menu.
:MAIN
MODE con: cols=127 lines=22
CLS
ECHO.
TYPE "%cd%\data\assets\ui\rwp.txt"
ECHO.
ECHO You enter the bustling street, inspecting each vendors stall closely.
ECHO %displayMessage%
ECHO +-----------------------------------------------------------------------------------------------------------------------------+
ECHO ^| HP: %player_health% ^| STM: %player_stamina% ^| ATK: %player_damage% ^| AMR: %player_armor% ^| MGK: %player_magicka% ^| COINS: %player_coins% ^| XP: %player_xp% ^| LUNIS: %player_lunis%
ECHO +-----------------------------------------------------------------------------------------------------------------------------+
ECHO ^| PARTY 1: %follower_name% ^| HP: %follower_health% ^| ATK: %follower_attack% ^| STM: %follower_stamina% ^| MGK: %follower_magicka%
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
ECHO ^| HP: %player_health% ^| STM: %player_stamina% ^| ATK: %player_damage% ^| AMR: %player_armor% ^| MGK: %player_magicka% ^| COINS: %player_coins% ^| XP: %player_xp% ^| LUNIS: %player_lunis%
ECHO +--------------------------------------------------------------------------------------------------+
ECHO ^| HEALING TONIC: %alchemist_healthTonic_stock%, PRICE: %alchemist_healthTonic_price%
ECHO ^| STAMINA TONIC: %alchemist_staminaTonic_stock%, PRICE: %alchemist_staminaTonic_price%
ECHO ^| MAGICKA TONIC: %alchemist_magickaTonic_stock%, PRICE: %alchemist_magickaTonic_price%
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
IF %player_coins% LSS %alchemist_healthTonic_price% (
    SET displayMessage=You can't afford this Tonic.
    GOTO :RWP_ALCHEMIST
) ELSE (
    SET /A player_coins=!player_coins! -%alchemist_healthTonic_price%
    SET item.to_add=Healing Tonic
    SET item.to_add_type=consumable
    SET item.to_add_stack_max=64
    SET item.to_add_attribute=NONE
    SET item.to_add_enchant=FALSE
    SET item.to_add_damage=0
    SET iAdd=purchasedItem
    CALL "%cd%\data\functions\itemadder.bat"
    IF %refunded% == "true" (
         SET /A armorer_cactusArmor_stock=!armorer_cactusArmor_stock! +1
         SET displayMessage=Out of space, item refunded.
         GOTO :RWP_ALCHEMIST
    ) ELSE (
        SET displayMessage=Purchased 1 set of Cactus Armor for %armorer_cactusArmor_price% coins.
        GOTO :RWP_ALCHEMIST
    )
    SET /A alchemist_healthTonic_stock=!alchemist_healthTonic_stock! -1
    SET displayMessage=Purchased 1 Healing Tonic for %alchemist_healthTonic_price% coins.
    GOTO :RWP_ALCHEMIST
)

REM Attempt to purchase the stamina Tonic.
:ALCHEMIST_BUY_STM_TONIC
IF %player_coins% LSS %sTonic_p% (
    SET displayMessage=You can't afford this Tonic.
    GOTO :RWP_ALCHEMIST
) ELSE (
    SET /A player_coins=!player_coins! -%alchemist_staminaTonic_price%
    SET item.to_add=Stamina Tonic
    SET item.to_add_type=consumable
    SET item.to_add_stack_max=64
    SET item.to_add_attribute=NONE
    SET item.to_add_enchant=FALSE
    SET item.to_add_damage=0
    SET iAdd=purchasedItem
    CALL "%cd%\data\functions\itemadder.bat"
    IF "%refunded%" == "true" (
         SET /A armorer_cactusArmor_stock=!armorer_cactusArmor_stock! +1
         SET displayMessage=Out of space, item refunded.
         GOTO :RWP_ALCHEMIST
    ) ELSE (
        SET displayMessage=Purchased 1 set of Cactus Armor for %armorer_cactusArmor_price% coins.
        GOTO :RWP_ALCHEMIST
    )
    SET /A alchemist_staminaTonic_stock=!alchemist_staminaTonic_stock! -1
    SET displayMessage=Purchased 1 stamina Tonic for %alchemist_staminaTonic_price% coins.
    GOTO :RWP_ALCHEMIST
)

REM Attempt to purchase the magicka Tonic.
:ALCHEMIST_BUY_MGK_TONIC
IF %player_coins% LSS %alchemist_magickaTonic_price% (
    SET displayMessage=You can't afford this Tonic.
    GOTO :RWP_ALCHEMIST
) ELSE (
    SET /A player_coins=!player_coins! -%alchemist_magickaTonic_price%
    SET item.to_add=Magicka Tonic
    SET item.to_add_type=consumable
    SET item.to_add_stack_max=64
    SET item.to_add_attribute=NONE
    SET item.to_add_enchant=FALSE
    SET item.to_add_damage=0
    SET iAdd=purchasedItem
    CALL "%cd%\data\functions\itemadder.bat"
    IF %refunded% == "true" (
         SET /A armorer_cactusArmor_stock=!armorer_cactusArmor_stock! +1
         SET displayMessage=Out of space, item refunded.
         GOTO :RWP_ALCHEMIST
    ) ELSE (
        SET displayMessage=Purchased 1 set of Cactus Armor for %armorer_cactusArmor_price% coins.
        GOTO :RWP_ALCHEMIST
    )
    SET /A alchemist_magickaTonic_stock=!alchemist_magickaTonic_stock! -1
    SET displayMessage=Purchased 1 magicka Tonic for %alchemist_magickaTonic_price% coins.
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
ECHO ^| HP: %player_health% ^| STM: %player_stamina% ^| ATK: %player_damage% ^| AMR: %player_armor% ^| MGK: %player_magicka% ^| COINS: %player_coins% ^| XP: %player_xp% ^| LUNIS: %player_lunis%
ECHO +---------------------------------------------------------------------------------------------------------+
ECHO ^| CACTUS ARMOR: %armorer_cactusArmor_stock%, PRICE: %armorer_cactusArmor_price% ^| SCALED ARMOR: %armorer_scaledArmor_stock%, PRICE: %armorer_scaledArmor_price% ^| SILVER ARMOR: %armorer_silverArmor_stock%, PRICE: %armorer_silverArmor_price%
ECHO ^| STONE ARMOR: %armorer_stoneArmor_stock%, PRICE: %armorer_stoneArmor_price%  ^| IRON ARMOR: %armorer_ironArmor_stock%, PRICE: %armorer_ironArmor_price%     ^| GOLD ARMOR: %armorer_goldArmor_stock%, PRICE: %armorer_goldArmor_price%
ECHO ^| STEEL ARMOR: %armorer_steelArmor_stock%, PRICE: %armorer_steelArmor_price%  ^| LEATHER ARMOR: %armorer_leatherArmor_stock%, PRICE: %armorer_leatherArmor_price% ^|
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
IF %player_coins% LSS %armorer_cactusArmor_price% (
    SET displayMessage=You can't afford this set.
    GOTO :RWP_ARMORER
) ELSE (
    SET /A player_coins=!player_coins! -%armorer_cactusArmor_price%
    SET item.to_add=Cactus Armor
    SET item.to_add_type=armor
    SET item.to_add_stack_max=1
    SET item.to_add_attribute=NONE
    SET item.to_add_enchant=FALSE
    SET item.to_add_damage=0
    SET iAdd=purchasedItem
    SET refundPrice=%armorer_cactusArmor_price%
    CALL "%cd%\data\functions\itemadder.bat"
    SET /A armorer_cactusArmor_stock=!armorer_cactusArmor_stock! -1
    IF %refunded% == "true" (
         SET /A armorer_cactusArmor_stock=!armorer_cactusArmor_stock! +1
         SET displayMessage=Out of space, item refunded.
         GOTO :RWP_ARMORER
    ) ELSE (
        SET displayMessage=Purchased 1 set of Cactus Armor for %armorer_cactusArmor_price% coins.
        GOTO :RWP_ARMORER
    )
)

REM Attempt to purchase Stone Armor.
:ARMORER_BUY_STONEARMOR
IF %player_coins% LSS %armorer_stoneArmor_price% (
    SET displayMessage=You can't afford this set.
    GOTO :RWP_ARMORER
) ELSE (
    SET /A player_coins=!player_coins! -%armorer_stoneArmor_price%
    SET item.to_add=Stone Armor
    SET item.to_add_type=armor
    SET item.to_add_stack_max=1
    SET item.to_add_attribute=NONE
    SET item.to_add_enchant=FALSE
    SET item.to_add_damage=0
    SET iAdd=purchasedItem
    SET refundPrice=%armorer_stoneArmor_price%
    CALL "%cd%\data\functions\itemadder.bat"
    SET /A armorer_stoneArmor_stock=!armorer_stoneArmor_stock! -1
    IF %refunded% == "true" (
         SET /A armorer_stoneArmor_stock=!armorer_stoneArmor_stock! +1
         SET displayMessage=Out of space, item refunded.
         GOTO :RWP_ARMORER
    ) ELSE (
        SET displayMessage=Purchased 1 set of Stone Armor for %armorer_stoneArmor_price% coins.
        GOTO :RWP_ARMORER
    )
)

REM Attempt to purchase Steel Armor.
:ARMORER_BUY_STEELARMOR
IF %player_coins% LSS %armorer_steelArmor_price% (
    SET displayMessage=You can't afford this set.
    GOTO :RWP_ARMORER
) ELSE (
    SET /A player_coins=!player_coins! -%armorer_steelArmor_price%
    SET item.to_add=Steel Armor
    SET item.to_add_type=armor
    SET item.to_add_stack_max=1
    SET item.to_add_attribute=NONE
    SET item.to_add_enchant=FALSE
    SET item.to_add_damage=0
    SET iAdd=purchasedItem
    SET refundPrice=%armorer_steelArmor_price%
    CALL "%cd%\data\functions\itemadder.bat"
    SET /A armorer_steelArmor_stock=!armorer_steelArmor_stock! -1
    IF %refunded% == "true" (
         SET /A armorer_steelArmor_stock=!armorer_steelArmor_stock! +1
         SET displayMessage=Out of space, item refunded.
         GOTO :RWP_ARMORER
    ) ELSE (
        SET displayMessage=Purchased 1 set of Steel Armor for %armorer_steelArmor_price% coins.
        GOTO :RWP_ARMORER
    )
)

REM Attempt to purchase Scaled Armor.
:ARMORER_BUY_SCALEDARMOR
IF %player_coins% LSS %armorer_scaledArmor_price% (
    SET displayMessage=You can't afford this set.
    GOTO :RWP_ARMORER
) ELSE (
    SET /A player_coins=!player_coins! -%armorer_scaledArmor_price%
    SET item.to_add=Scaled Armor
    SET item.to_add_type=armor
    SET item.to_add_stack_max=1
    SET item.to_add_attribute=NONE
    SET item.to_add_enchant=FALSE
    SET item.to_add_damage=0
    SET iAdd=purchasedItem
    SET refundPrice=%armorer_scaledArmor_price%
    CALL "%cd%\data\functions\itemadder.bat"
    SET /A armorer_scaledArmor_stock=!armorer_scaledArmor_stock! -1
    IF %refunded% == "true" (
         SET /A armorer_scaledArmor_stock=!armorer_scaledArmor_stock! +1
         SET displayMessage=Out of space, item refunded.
         GOTO :RWP_ARMORER
    ) ELSE (
        SET displayMessage=Purchased 1 set of Scaled Armor for %armorer_scaledArmor_price% coins.
        GOTO :RWP_ARMORER
    )
)

REM Attempt to purchase Iron Armor.
:ARMORER_BUY_IRONARMOR
IF %player_coins% LSS %armorer_ironArmor_price% (
    SET displayMessage=You can't afford this set.
    GOTO :RWP_ARMORER
) ELSE (
    SET /A player_coins=!player_coins! -%armorer_ironArmor_price%
    SET item.to_add=Iron Armor
    SET item.to_add_type=armor
    SET item.to_add_stack_max=1
    SET item.to_add_attribute=NONE
    SET item.to_add_enchant=FALSE
    SET item.to_add_damage=0
    SET iAdd=purchasedItem
    SET refundPrice=%armorer_ironArmor_price%
    CALL "%cd%\data\functions\itemadder.bat"
    SET /A armorer_ironArmor_stock=!armorer_ironArmor_stock! -1
    IF %refunded% == "true" (
         SET /A armorer_ironArmor_stock=!armorer_ironArmor_stock! +1
         SET displayMessage=Out of space, item refunded.
         GOTO :RWP_ARMORER
    ) ELSE (
        SET displayMessage=Purchased 1 set of Iron Armor for %armorer_ironArmor_price% coins.
        GOTO :RWP_ARMORER
    )
)

REM Attempt to purchase Leather Armor.
:ARMORER_BUY_LEATHERARMOR
IF %player_coins% LSS %armorer_leatherArmor_price% (
    SET displayMessage=You can't afford this set.
    GOTO :RWP_ARMORER
) ELSE (
    SET /A player_coins=!player_coins! -%armorer_leatherArmor_price%
    SET item.to_add=Leather Armor
    SET item.to_add_type=armor
    SET item.to_add_stack_max=1
    SET item.to_add_attribute=NONE
    SET item.to_add_enchant=FALSE
    SET item.to_add_damage=0
    SET iAdd=purchasedItem
    SET refundPrice=%armorer_leatherArmor_price%
    CALL "%cd%\data\functions\itemadder.bat"
    SET /A armorer_leatherArmor_stock=!armorer_leatherArmor_stock! -1
    IF %refunded% == "true" (
         SET /A armorer_leatherArmor_stock=!armorer_leatherArmor_stock! +1
         SET displayMessage=Out of space, item refunded.
         GOTO :RWP_ARMORER
    ) ELSE (
        SET displayMessage=Purchased 1 set of Leather Armor for %armorer_leatherArmor_price% coins.
        GOTO :RWP_ARMORER
    )
)

REM Attempt to purchase Silver Armor.
:ARMORER_BUY_SILVERARMOR
IF %player_coins% LSS %armorer_silverArmor_price% (
    SET displayMessage=You can't afford this set.
    GOTO :RWP_ARMORER
) ELSE (
    SET /A player_coins=!player_coins! -%armorer_silverArmor_price%
    SET item.to_add=Silver Armor
    SET item.to_add_type=armor
    SET item.to_add_stack_max=1
    SET item.to_add_attribute=NONE
    SET item.to_add_enchant=FALSE
    SET item.to_add_damage=0
    SET iAdd=purchasedItem
    SET refundPrice=%armorer_silverArmor_price%
    CALL "%cd%\data\functions\itemadder.bat"
    SET /A armorer_silverArmor_stock=!armorer_silverArmor_stock! -1
    IF %refunded% == "true" (
         SET /A armorer_silverArmor_stock=!armorer_silverArmor_stock! +1
         SET displayMessage=Out of space, item refunded.
         GOTO :RWP_ARMORER
    ) ELSE (
        SET displayMessage=Purchased 1 set of Silver Armor for %armorer_silverArmor_price% coins.
        GOTO :RWP_ARMORER
    )
)

REM Attempt to purchase Gold Armor.
:ARMORER_BUY_GOLDARMOR
IF %player_coins% LSS %armorer_goldArmor_price% (
    SET displayMessage=You can't afford this set.
    GOTO :RWP_ARMORER
) ELSE (
    SET /A player_coins=!player_coins! -%armorer_goldArmor_price%
    SET item.to_add=Gold Armor
    SET item.to_add_type=armor
    SET item.to_add_stack_max=1
    SET item.to_add_attribute=NONE
    SET item.to_add_enchant=FALSE
    SET item.to_add_damage=0
    SET iAdd=purchasedItem
    SET refundPrice=%armorer_goldArmor_price%
    CALL "%cd%\data\functions\itemadder.bat"
    SET /A armorer_goldArmor_stock=!armorer_goldArmor_stock! -1
    IF %refunded% == "true" (
         SET /A armorer_goldArmor_stock=!armorer_goldArmor_stock! +1
         SET displayMessage=Out of space, item refunded.
         GOTO :RWP_ARMORER
    ) ELSE (
        SET displayMessage=Purchased 1 set of Gold Armor for %armorer_goldArmor_price% coins.
        GOTO :RWP_ARMORER
    )
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
ECHO ^| HP: %player_health% ^| STM: %player_stamina% ^| ATK: %player_damage% ^| AMR: %player_armor% ^| MGK: %player_magicka% ^| COINS: %player_coins% ^| XP: %player_xp% ^| LUNIS: %player_lunis%
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
IF %player_coins% LSS %blacksmith_shortSword_price% (
    SET displayMessage=You can't afford this sword.
    GOTO :RWP_BLACKSMITH
) ELSE (
    SET /A player_coins=!player_coins! -%blacksmith_shortSword_price%
    SET item.to_add=Shortsword
    SET item.to_add_type=weapon
    SET item.to_add_stack_max=6
    SET item.to_add_attribute=NONE
    SET item.to_add_enchant=FALSE
    SET item.to_add_damage=%shortsword_d%
    SET iAdd=purchasedItem
    SET refundPrice=%blacksmith_shortSword_price%
    CALL "%cd%\data\functions\itemadder.bat"
    SET /A blacksmith_shortSword_stock=!blacksmith_shortSword_stock! -1
    IF %refunded% == "true" (
         SET /A blacksmith_shortSword_stock=!blacksmith_shortSword_stock! +1
         SET displayMessage=Out of space, item refunded.
         GOTO :RWP_ARMORER
    ) ELSE (
        SET displayMessage=Purchased 1 Shortsword for %blacksmith_shortSword_price% coins.
        GOTO :RWP_ARMORER
    )
)

REM Attempt to purchase the Long Sword.
:BLACKSMITH_BUY_LONGSWORD
IF %player_coins% LSS %blacksmith_longSword_price% (
    SET displayMessage=You can't afford this set.
    GOTO :RWP_BLACKSMITH
) ELSE (
    SET /A player_coins=!player_coins! -%blacksmith_longSword_price%
    SET item.to_add=Longsword
    SET item.to_add_type=weapon
    SET item.to_add_stack_max=6
    SET item.to_add_attribute=NONE
    SET item.to_add_enchant=FALSE
    SET item.to_add_damage=%longsword_d%
    SET iAdd=purchasedItem
    SET refundPrice=%blacksmith_longSword_price
    CALL "%cd%\data\functions\itemadder.bat"
    SET /A blacksmith_longSword_stock=!blacksmith_longSword_stock! -1
    IF %refunded% == "true" (
         SET /A blacksmith_longSword_stock=!blacksmith_longSword_stock! +1
         SET displayMessage=Out of space, item refunded.
         GOTO :RWP_ARMORER
    ) ELSE (
        SET displayMessage=Purchased 1 Longsword for %blacksmith_longSword_price% coins.
        GOTO :RWP_ARMORER
    )
)

REM Attempt to purchase the Greataxe.
:BLACKSMITH_BUY_GREATAXE
IF %player_coins% LSS %blacksmith_greatAxe_price% (
    SET displayMessage=You can't afford this set.
    GOTO :RWP_BLACKSMITH
) ELSE (
    SET /A player_coins=!player_coins! -%blacksmith_greatAxe_price%
    SET item.to_add=Greataxe
    SET item.to_add_type=weapon
    SET item.to_add_stack_max=6
    SET item.to_add_attribute=NONE
    SET item.to_add_enchant=FALSE
    SET item.to_add_damage=%greataxe_d%
    SET iAdd=purchasedItem
    SET refundPrice=%blacksmith_greatAxe_price%
    CALL "%cd%\data\functions\itemadder.bat"
    SET /A blacksmith_greatAxe_stock=!blacksmith_greatAxe_stock! -1
    IF %refunded% == "true" (
         SET /A blacksmith_greatAxe_stock=!blacksmith_greatAxe_stock! +1
         SET displayMessage=Out of space, item refunded.
         GOTO :RWP_ARMORER
    ) ELSE (
        SET displayMessage=Purchased 1 Greataxe for %blacksmith_greatAxe_price% coins.
        GOTO :RWP_ARMORER
    )
)

REM Attempt to purchase the Mace.
:BLACKSMITH_BUY_MACE
IF %player_coins% LSS %blacksmith_mace_price% (
    SET displayMessage=You can't afford this set.
    GOTO :RWP_BLACKSMITH
) ELSE (
    SET /A player_coins=!player_coins! -%blacksmith_mace_price%
    SET item.to_add=Mace
    SET item.to_add_type=weapon
    SET item.to_add_stack_max=6
    SET item.to_add_attribute=NONE
    SET item.to_add_enchant=FALSE
    SET item.to_add_damage=%mace_d%
    SET iAdd=purchasedItem
    SET refundPrice=%blacksmith_mace_price%
    CALL "%cd%\data\functions\itemadder.bat"
    SET /A blacksmith_mace_stock=!blacksmith_mace_stock! -1
    IF %refunded% == "true" (
         SET /A blacksmith_mace_stock=!blacksmith_mace_stock! +1
         SET displayMessage=Out of space, item refunded.
         GOTO :RWP_ARMORER
    ) ELSE (
        SET displayMessage=Purchased 1 Mace for %blacksmith_mace_price% coins.
        GOTO :RWP_ARMORER
    )
)

REM Attempt to purchase the Wooden Bow.
:BLACKSMITH_BUY_WOODENBOW
IF %player_coins% LSS %blacksmith_woodenBow_price% (
    SET displayMessage=You can't afford this set.
    GOTO :RWP_BLACKSMITH
) ELSE (
    SET /A player_coins=!player_coins! -%blacksmith_woodenBow_price%
    SET item.to_add=Wooden Bow
    SET item.to_add_type=weapon
    SET item.to_add_stack_max=2
    SET item.to_add_attribute=NONE
    SET item.to_add_enchant=FALSE
    SET item.to_add_damage=%weapon.woodenBow_damage%
    SET iAdd=purchasedItem
    SET refundPrice=%blacksmith_woodenBow_price%
    CALL "%cd%\data\functions\itemadder.bat"
    SET /A blacksmith_woodenBow_stock=!blacksmith_woodenBow_stock! -1
    IF %refunded% == "true" (
         SET /A blacksmith_woodenBow_stock=!blacksmith_woodenBow_stock! +1
         SET displayMessage=Out of space, item refunded.
         GOTO :RWP_ARMORER
    ) ELSE (
        SET displayMessage=Purchased 1 Wooden Bow for %blacksmith_woodenBow_price% coins.
        GOTO :RWP_ARMORER
    )
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
ECHO ^| HP: %player_health% ^| STM: %player_stamina% ^| ATK: %player_damage% ^| AMR: %player_armor% ^| MGK: %player_magicka% ^| COINS: %player_coins% ^| XP: %player_xp% ^| LUNIS: %player_lunis%
ECHO +-------------------------------------------------------------------------------------------------+
ECHO ^| TRAVELER'S JOURNAL: %tJournal_s%, PRICE: %tJournal_p%
ECHO ^| MERHCANT'S GUIDE: %mGuide_s%, PRICE: %mGuide_p%
ECHO +-------------------------------------------------------------------------------------------------+
ECHO + [1 / TRAVELER'S GUIDE ] ^| [2 / MERCHANT'S GUIDE ] ^| [E / GO BACK ]         +
ECHO +-------------------------------------------------------------------------------------------------+
CHOICE /C 12E /N /M ">"
IF ERRORLEVEL 3 GOTO :MAIN
IF ERRORLEVEL 2 GOTO :LOREKEEPER_BUY_MERCHANTSGUIDE
IF ERRORLEVEL 1 GOTO :LOREKEEPER_BUY_TRAVELERSGUIDE

REM Attempt to purchase the Traveler's Journal.
:LOREKEEPER_BUY_TRAVELERSGUIDE
IF %player_coins% LSS %tJournal_p% (
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
IF %player_coins% LSS %mGuide_p% (
    SET displayMessage=You can't afford this set.
    GOTO :RWP_LOREKEEPER
) ELSE (
    SET /A COINS=!COINS! -%mGuide_p%
    SET /A merchants_guideL_q=!merchants_guideL_q! +1
    SET /A mGuide_s=!mGuide_s! -1
    SET displayMessage=Purchased 1 Merchant's Guide for %mGuide_p% coins.
    GOTO :RWP_LOREKEEPER
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
ECHO ^| HP: %player_health% ^| STM: %player_stamina% ^| ATK: %player_damage% ^| AMR: %player_armor% ^| MGK: %player_magicka% ^| COINS: %player_coins% ^| XP: %player_xp% ^| LUNIS: %player_lunis%
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
IF %player_coins% LSS %bRobes_p% (
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
IF %player_coins% LSS %iRobes_p% (
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
IF %player_coins% LSS %aRobes_p% (
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
ECHO ^| HP: %player_health% ^| STM: %player_stamina% ^| ATK: %player_damage% ^| AMR: %player_armor% ^| MGK: %player_magicka% ^| COINS: %player_coins% ^| XP: %player_xp% ^| LUNIS: %player_lunis%
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