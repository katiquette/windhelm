@ECHO OFF
TITLE (WINDHELM) Inventory Viewer ^| %player_name% the %player_class%
REM Somehow more of a nightmare than SLoP!

REM Access to submenus.
:MM
MODE con: cols=100 lines=25
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
ECHO 1 ^| %player.inventory_slot_1% / %player.inventory_slot_1_stack% ^| 6 ^| %player.inventory_slot_6% / %player.inventory_slot_6_stack% ^| 11 ^| %player.inventory_slot_11% / %player.inventory_slot_11_stack%
ECHO 2 ^| %player.inventory_slot_2% / %player.inventory_slot_2_stack% ^| 7 ^| %player.inventory_slot_7% / %player.inventory_slot_7_stack% ^| 12 ^| %player.inventory_slot_12% / %player.inventory_slot_12_stack%
ECHO 3 ^| %player.inventory_slot_3% / %player.inventory_slot_3_stack% ^| 8 ^| %player.inventory_slot_8% / %player.inventory_slot_8_stack% ^| 13 ^| %player.inventory_slot_13% / %player.inventory_slot_13_stack%
ECHO 4 ^| %player.inventory_slot_4% / %player.inventory_slot_4_stack% ^| 9 ^| %player.inventory_slot_9% / %player.inventory_slot_9_stack% ^| 14 ^| %player.inventory_slot_14% / %player.inventory_slot_14_stack%
ECHO 5 ^| %player.inventory_slot_5% / %player.inventory_slot_5_stack% ^| 10 ^| %player.inventory_slot_10% / %player.inventory_slot_10_stack% ^| 15 ^| %player.inventory_slot_15% / %player.inventory_slot_15_stack%
ECHO +--------------------------------------------------------------------------------------------------+
ECHO ^| [1 / EQUIP ITEM ] ^| [2 / USE ITEM ] ^| [3 / INSPECT ITEM ] ^| [4 / DISCARD ITEM ] ^| [E / EXIT ]
ECHO +--------------------------------------------------------------------------------------------------+
CHOICE /C 1234E /N /M ">"
IF ERRORLEVEL 5 GOTO :EOF
IF ERRORLEVEL 4 GOTO :DISCARD_ITEM
IF ERRORLEVEL 3 GOTO :INSPECT_ITEM
IF ERRORLEVEL 2 GOTO :USE_ITEM
IF ERRORLEVEL 1 GOTO :EQUIP_ITEM

REM Attemps to equip an item from a specificed slot.
:EQUIP_ITEM
CLS
ECHO.
TYPE "%cd%\data\assets\ui\inventory.txt"
ECHO.
ECHO %displayMessage%
ECHO Select an item to equip.
ECHO +--------------------------------------------------------------------------------------------------+
ECHO 1 ^| %player.inventory_slot_1% / %player.inventory_slot_1_stack% ^| 6 ^| %player.inventory_slot_6% / %player.inventory_slot_6_stack% ^| 11 ^| %player.inventory_slot_11% / %player.inventory_slot_11_stack%
ECHO 2 ^| %player.inventory_slot_2% / %player.inventory_slot_2_stack% ^| 7 ^| %player.inventory_slot_7% / %player.inventory_slot_7_stack% ^| 12 ^| %player.inventory_slot_12% / %player.inventory_slot_12_stack%
ECHO 3 ^| %player.inventory_slot_3% / %player.inventory_slot_3_stack% ^| 8 ^| %player.inventory_slot_8% / %player.inventory_slot_8_stack% ^| 13 ^| %player.inventory_slot_13% / %player.inventory_slot_13_stack%
ECHO 4 ^| %player.inventory_slot_4% / %player.inventory_slot_4_stack% ^| 9 ^| %player.inventory_slot_9% / %player.inventory_slot_9_stack% ^| 14 ^| %player.inventory_slot_14% / %player.inventory_slot_14_stack%
ECHO 5 ^| %player.inventory_slot_5% / %player.inventory_slot_5_stack% ^| 10 ^| %player.inventory_slot_10% / %player.inventory_slot_10_stack% ^| 15 ^| %player.inventory_slot_15% / %player.inventory_slot_15_stack%
ECHO +--------------------------------------------------------------------------------------------------+
ECHO ^| [1 / SLOT 1 ] ^| [2 / SLOT 2 ] ^| [3 / SLOT 3 ] ^| [4 / SLOT 4 ] ^| [5 / SLOT 5 ]
ECHO ^| [6 / SLOT 6 ] ^| [7 / SLOT 7 ] ^| [8 / SLOT 8 ] ^| [9 / SLOT 9 ] ^| [N / NEXT PAGE ] ^| [E / EXIT ]
ECHO +--------------------------------------------------------------------------------------------------+
CHOICE /C 123456789NE /N /M ">"
IF ERRORLEVEL 11 GOTO :MM
IF ERRORLEVEL 10 GOTO :EQUIP_ITEM_PAGE_2
IF ERRORLEVEL 9 GOTO :ATTEMPT_EQUIP_9
IF ERRORLEVEL 8 GOTO :ATTEMPT_EQUIP_8
IF ERRORLEVEL 7 GOTO :ATTEMPT_EQUIP_7
IF ERRORLEVEL 6 GOTO :ATTEMPT_EQUIP_6
IF ERRORLEVEL 5 GOTO :ATTEMPT_EQUIP_5
IF ERRORLEVEL 4 GOTO :ATTEMPT_EQUIP_4
IF ERRORLEVEL 3 GOTO :ATTEMPT_EQUIP_3
IF ERRORLEVEL 2 GOTO :ATTEMPT_EQUIP_2
IF ERRORLEVEL 1 GOTO :ATTEMPT_EQUIP_1

:EQUIP_ITEM_PAGE_2
CLS
ECHO.
TYPE "%cd%\data\assets\ui\inventory.txt"
ECHO.
ECHO %displayMessage%
ECHO Select an item to equip.
ECHO +--------------------------------------------------------------------------------------------------+
ECHO 1 ^| %player.inventory_slot_1% / %player.inventory_slot_1_stack% ^| 6 ^| %player.inventory_slot_6% / %player.inventory_slot_6_stack% ^| 11 ^| %player.inventory_slot_11% / %player.inventory_slot_11_stack%
ECHO 2 ^| %player.inventory_slot_2% / %player.inventory_slot_2_stack% ^| 7 ^| %player.inventory_slot_7% / %player.inventory_slot_7_stack% ^| 12 ^| %player.inventory_slot_12% / %player.inventory_slot_12_stack%
ECHO 3 ^| %player.inventory_slot_3% / %player.inventory_slot_3_stack% ^| 8 ^| %player.inventory_slot_8% / %player.inventory_slot_8_stack% ^| 13 ^| %player.inventory_slot_13% / %player.inventory_slot_13_stack%
ECHO 4 ^| %player.inventory_slot_4% / %player.inventory_slot_4_stack% ^| 9 ^| %player.inventory_slot_9% / %player.inventory_slot_9_stack% ^| 14 ^| %player.inventory_slot_14% / %player.inventory_slot_14_stack%
ECHO 5 ^| %player.inventory_slot_5% / %player.inventory_slot_5_stack% ^| 10 ^| %player.inventory_slot_10% / %player.inventory_slot_10_stack% ^| 15 ^| %player.inventory_slot_15% / %player.inventory_slot_15_stack%
ECHO +--------------------------------------------------------------------------------------------------+
ECHO ^| [1 / SLOT 10 ] ^| [2 / SLOT 11 ] ^| [3 / SLOT 12 ] ^| [4 / SLOT 13 ] ^| [5 / SLOT 14 ]
ECHO ^| [6 / SLOT 15 ] ^| [N / LAST PAGE ] ^| [E / EXIT ]
ECHO +--------------------------------------------------------------------------------------------------+
CHOICE /C 123456NE /N /M ">"
IF ERRORLEVEL 7 GOTO :MM
IF ERRORLEVEL 7 GOTO :EQUIP_ITEM
IF ERRORLEVEL 6 GOTO :ATTEMPT_EQUIP_15
IF ERRORLEVEL 5 GOTO :ATTEMPT_EQUIP_14
IF ERRORLEVEL 4 GOTO :ATTEMPT_EQUIP_13
IF ERRORLEVEL 3 GOTO :ATTEMPT_EQUIP_12
IF ERRORLEVEL 2 GOTO :ATTEMPT_EQUIP_11
IF ERRORLEVEL 1 GOTO :ATTEMPT_EQUIP_10

REM Attemps to equip an item from a specificed slot.
:INSPECT_ITEM
CLS
ECHO.
TYPE "%cd%\data\assets\ui\inventory.txt"
ECHO.
ECHO %displayMessage%
ECHO Please type the slot you wish to inspect manually.
ECHO +--------------------------------------------------------------------------------------------------+
ECHO 1 ^| %player.inventory_slot_1% / %player.inventory_slot_1_stack% ^| 6 ^| %player.inventory_slot_6% / %player.inventory_slot_6_stack% ^| 11 ^| %player.inventory_slot_11% / %player.inventory_slot_11_stack%
ECHO 2 ^| %player.inventory_slot_2% / %player.inventory_slot_2_stack% ^| 7 ^| %player.inventory_slot_7% / %player.inventory_slot_7_stack% ^| 12 ^| %player.inventory_slot_12% / %player.inventory_slot_12_stack%
ECHO 3 ^| %player.inventory_slot_3% / %player.inventory_slot_3_stack% ^| 8 ^| %player.inventory_slot_8% / %player.inventory_slot_8_stack% ^| 13 ^| %player.inventory_slot_13% / %player.inventory_slot_13_stack%
ECHO 4 ^| %player.inventory_slot_4% / %player.inventory_slot_4_stack% ^| 9 ^| %player.inventory_slot_9% / %player.inventory_slot_9_stack% ^| 14 ^| %player.inventory_slot_14% / %player.inventory_slot_14_stack%
ECHO 5 ^| %player.inventory_slot_5% / %player.inventory_slot_5_stack% ^| 10 ^| %player.inventory_slot_10% / %player.inventory_slot_10_stack% ^| 15 ^| %player.inventory_slot_15% / %player.inventory_slot_15_stack%
ECHO +--------------------------------------------------------------------------------------------------+
ECHO ^| [1 / SLOT 1 ] ^| [2 / SLOT 2 ] ^| [3 / SLOT 3 ] ^| [4 / SLOT 4 ] ^| [5 / SLOT 5 ]
ECHO ^| [6 / SLOT 6 ] ^| [7 / SLOT 7 ] ^| [8 / SLOT 8 ] ^| [9 / SLOT 9 ] ^| [N / NEXT PAGE ] ^| [E / EXIT ]
ECHO +--------------------------------------------------------------------------------------------------+
CHOICE /C 123456789NE /N /M ">"
IF ERRORLEVEL 11 GOTO :MM
IF ERRORLEVEL 10 GOTO :INSPECT_ITEM_PAGE_2
IF ERRORLEVEL 9 GOTO :ATTEMPT_INSPECT_9
IF ERRORLEVEL 8 GOTO :ATTEMPT_INSPECT_8
IF ERRORLEVEL 7 GOTO :ATTEMPT_INSPECT_7
IF ERRORLEVEL 6 GOTO :ATTMEPT_INSPECT_6
IF ERRORLEVEL 5 GOTO :ATTEMPT_INSPECT_5
IF ERRORLEVEL 4 GOTO :ATTEMPT_INSPECT_4
IF ERRORLEVEL 3 GOTO :ATTEMPT_INSPECT_3
IF ERRORLEVEL 2 GOTO :ATTEMPT_INSPECT_2
IF ERRORLEVEL 1 GOTO :ATTEMPT_INSPECT_1

:INSPECT_ITEM_PAGE_2
CLS
ECHO.
TYPE "%cd%\data\assets\ui\inventory.txt"
ECHO.
ECHO %displayMessage%
ECHO Select an item to equip.
ECHO +--------------------------------------------------------------------------------------------------+
ECHO 1 ^| %player.inventory_slot_1% / %player.inventory_slot_1_stack% ^| 6 ^| %player.inventory_slot_6% / %player.inventory_slot_6_stack% ^| 11 ^| %player.inventory_slot_11% / %player.inventory_slot_11_stack%
ECHO 2 ^| %player.inventory_slot_2% / %player.inventory_slot_2_stack% ^| 7 ^| %player.inventory_slot_7% / %player.inventory_slot_7_stack% ^| 12 ^| %player.inventory_slot_12% / %player.inventory_slot_12_stack%
ECHO 3 ^| %player.inventory_slot_3% / %player.inventory_slot_3_stack% ^| 8 ^| %player.inventory_slot_8% / %player.inventory_slot_8_stack% ^| 13 ^| %player.inventory_slot_13% / %player.inventory_slot_13_stack%
ECHO 4 ^| %player.inventory_slot_4% / %player.inventory_slot_4_stack% ^| 9 ^| %player.inventory_slot_9% / %player.inventory_slot_9_stack% ^| 14 ^| %player.inventory_slot_14% / %player.inventory_slot_14_stack%
ECHO 5 ^| %player.inventory_slot_5% / %player.inventory_slot_5_stack% ^| 10 ^| %player.inventory_slot_10% / %player.inventory_slot_10_stack% ^| 15 ^| %player.inventory_slot_15% / %player.inventory_slot_15_stack%
ECHO +--------------------------------------------------------------------------------------------------+
ECHO ^| [1 / SLOT 10 ] ^| [2 / SLOT 11 ] ^| [3 / SLOT 12 ] ^| [4 / SLOT 13 ] ^| [5 / SLOT 14 ]
ECHO ^| [6 / SLOT 15 ] ^| [N / LAST PAGE ] ^| [E / EXIT ]
ECHO +--------------------------------------------------------------------------------------------------+
CHOICE /C 123456NE /N /M ">"
IF ERRORLEVEL 7 GOTO :MM
IF ERRORLEVEL 7 GOTO :INSPECT_ITEM
IF ERRORLEVEL 6 GOTO :ATTEMPT_INSPECT_15
IF ERRORLEVEL 5 GOTO :ATTEMPT_INSPECT_14
IF ERRORLEVEL 4 GOTO :ATTEMPT_INSPECT_13
IF ERRORLEVEL 3 GOTO :ATTEMPT_INSPECT_12
IF ERRORLEVEL 2 GOTO :ATTEMPT_INSPECT_11
IF ERRORLEVEL 1 GOTO :ATTEMPT_INSPECT_10

REM Displays item information.
:ATTEMPT_INSPECT_1
TITLE (WINDHELM) - Inventory Viewer ^| Viewing item %player.inventory_slot_1%
CLS
ECHO Known item elements listed below.
ECHO +--------------------------------------------------------------------------------------------------+
ECHO + Item Type: %player.inventory_slot_1_type%
ECHO + Item Stack: %player.inventory_slot_1_stack%
ECHO + Item Stack Max: %player.inventory_slot_1_stack_max%
ECHO + Item Attribute: %player.inventory_slot_1_attribute%
ECHO + Item Enchanted?: %player.inventory_slot_1_avail_enchant%
ECHO + Item Damage: %player.inventory_slot_1_damage%
ECHO +--------------------------------------------------------------------------------------------------+
ECHO ^| [E / EXIT ]
ECHO +--------------------------------------------------------------------------------------------------+
CHOICE /C E /N /M ">"
GOTO :INSPECT_ITEM

:ATTEMPT_INSPECT_2
TITLE (WINDHELM) - Inventory Viewer ^| Viewing item %player.inventory_slot_2%
CLS
ECHO Known item elements listed below.
ECHO +--------------------------------------------------------------------------------------------------+
ECHO + Item Type: %player.inventory_slot_2_type%
ECHO + Item Stack: %player.inventory_slot_2_stack%
ECHO + Item Stack Max: %player.inventory_slot_2_stack_max%
ECHO + Item Attribute: %player.inventory_slot_2_attribute%
ECHO + Item Enchanted?: %player.inventory_slot_2_avail_enchant%
ECHO + Item Damage: %player.inventory_slot_2_damage%
ECHO +--------------------------------------------------------------------------------------------------+
ECHO ^| [E / EXIT ]
ECHO +--------------------------------------------------------------------------------------------------+
CHOICE /C E /N /M ">"
GOTO :INSPECT_ITEM

:ATTEMPT_INSPECT_3
TITLE (WINDHELM) - Inventory Viewer ^| Viewing item %player.inventory_slot_3%
CLS
ECHO Known item elements listed below.
ECHO +--------------------------------------------------------------------------------------------------+
ECHO + Item Type: %player.inventory_slot_3_type%
ECHO + Item Stack: %player.inventory_slot_3_stack%
ECHO + Item Stack Max: %player.inventory_slot_3_stack_max%
ECHO + Item Attribute: %player.inventory_slot_3_attribute%
ECHO + Item Enchanted?: %player.inventory_slot_3_avail_enchant%
ECHO + Item Damage: %player.inventory_slot_3_damage%
ECHO +--------------------------------------------------------------------------------------------------+
ECHO ^| [E / EXIT ]
ECHO +--------------------------------------------------------------------------------------------------+
CHOICE /C E /N /M ">"
GOTO :INSPECT_ITEM

:ATTEMPT_INSPECT_4
TITLE (WINDHELM) - Inventory Viewer ^| Viewing item %player.inventory_slot_4%
CLS
ECHO Known item elements listed below.
ECHO +--------------------------------------------------------------------------------------------------+
ECHO + Item Type: %player.inventory_slot_4_type%
ECHO + Item Stack: %player.inventory_slot_4_stack%
ECHO + Item Stack Max: %player.inventory_slot_4_stack_max%
ECHO + Item Attribute: %player.inventory_slot_4_attribute%
ECHO + Item Enchanted?: %player.inventory_slot_4_avail_enchant%
ECHO + Item Damage: %player.inventory_slot_4_damage%
ECHO +--------------------------------------------------------------------------------------------------+
ECHO ^| [E / EXIT ]
ECHO +--------------------------------------------------------------------------------------------------+
CHOICE /C E /N /M ">"
GOTO :INSPECT_ITEM

:ATTEMPT_INSPECT_5
TITLE (WINDHELM) - Inventory Viewer ^| Viewing item %player.inventory_slot_5%
CLS
ECHO Known item elements listed below.
ECHO +--------------------------------------------------------------------------------------------------+
ECHO + Item Type: %player.inventory_slot_5_type%
ECHO + Item Stack: %player.inventory_slot_5_stack%
ECHO + Item Stack Max: %player.inventory_slot_5_stack_max%
ECHO + Item Attribute: %player.inventory_slot_5_attribute%
ECHO + Item Enchanted?: %player.inventory_slot_5_avail_enchant%
ECHO + Item Damage: %player.inventory_slot_5_damage%
ECHO +--------------------------------------------------------------------------------------------------+
ECHO ^| [E / EXIT ]
ECHO +--------------------------------------------------------------------------------------------------+
CHOICE /C E /N /M ">"
GOTO :INSPECT_ITEM

:ATTEMPT_INSPECT_6
TITLE (WINDHELM) - Inventory Viewer ^| Viewing item %player.inventory_slot_6%
CLS
ECHO Known item elements listed below.
ECHO +--------------------------------------------------------------------------------------------------+
ECHO + Item Type: %player.inventory_slot_6_type%
ECHO + Item Stack: %player.inventory_slot_6_stack%
ECHO + Item Stack Max: %player.inventory_slot_6_stack_max%
ECHO + Item Attribute: %player.inventory_slot_6_attribute%
ECHO + Item Enchanted?: %player.inventory_slot_6_avail_enchant%
ECHO + Item Damage: %player.inventory_slot_6_damage%
ECHO +--------------------------------------------------------------------------------------------------+
ECHO ^| [E / EXIT ]
ECHO +--------------------------------------------------------------------------------------------------+
CHOICE /C E /N /M ">"
GOTO :INSPECT_ITEM

:ATTEMPT_INSPECT_7
TITLE (WINDHELM) - Inventory Viewer ^| Viewing item %player.inventory_slot_7%
CLS
ECHO Known item elements listed below.
ECHO +--------------------------------------------------------------------------------------------------+
ECHO + Item Type: %player.inventory_slot_7_type%
ECHO + Item Stack: %player.inventory_slot_7_stack%
ECHO + Item Stack Max: %player.inventory_slot_7_stack_max%
ECHO + Item Attribute: %player.inventory_slot_7_attribute%
ECHO + Item Enchanted?: %player.inventory_slot_7_avail_enchant%
ECHO + Item Damage: %player.inventory_slot_7_damage%
ECHO +--------------------------------------------------------------------------------------------------+
ECHO ^| [E / EXIT ]
ECHO +--------------------------------------------------------------------------------------------------+
CHOICE /C E /N /M ">"
GOTO :INSPECT_ITEM

:ATTEMPT_INSPECT_8
TITLE (WINDHELM) - Inventory Viewer ^| Viewing item %player.inventory_slot_8%
CLS
ECHO Known item elements listed below.
ECHO +--------------------------------------------------------------------------------------------------+
ECHO + Item Type: %player.inventory_slot_8_type%
ECHO + Item Stack: %player.inventory_slot_8_stack%
ECHO + Item Stack Max: %player.inventory_slot_8_stack_max%
ECHO + Item Attribute: %player.inventory_slot_8_attribute%
ECHO + Item Enchanted?: %player.inventory_slot_8_avail_enchant%
ECHO + Item Damage: %player.inventory_slot_8_damage%
ECHO +--------------------------------------------------------------------------------------------------+
ECHO ^| [E / EXIT ]
ECHO +--------------------------------------------------------------------------------------------------+
CHOICE /C E /N /M ">"
GOTO :INSPECT_ITEM

:ATTEMPT_INSPECT_9
TITLE (WINDHELM) - Inventory Viewer ^| Viewing item %player.inventory_slot_9%
CLS
ECHO Known item elements listed below.
ECHO +--------------------------------------------------------------------------------------------------+
ECHO + Item Type: %player.inventory_slot_9_type%
ECHO + Item Stack: %player.inventory_slot_9_stack%
ECHO + Item Stack Max: %player.inventory_slot_9_stack_max%
ECHO + Item Attribute: %player.inventory_slot_9_attribute%
ECHO + Item Enchanted?: %player.inventory_slot_9_avail_enchant%
ECHO + Item Damage: %player.inventory_slot_9_damage%
ECHO +--------------------------------------------------------------------------------------------------+
ECHO ^| [E / EXIT ]
ECHO +--------------------------------------------------------------------------------------------------+
CHOICE /C E /N /M ">"
GOTO :INSPECT_ITEM

:ATTEMPT_INSPECT_10
TITLE (WINDHELM) - Inventory Viewer ^| Viewing item %player.inventory_slot_10%
CLS
ECHO Known item elements listed below.
ECHO +--------------------------------------------------------------------------------------------------+
ECHO + Item Type: %player.inventory_slot_10_type%
ECHO + Item Stack: %player.inventory_slot_10_stack%
ECHO + Item Stack Max: %player.inventory_slot_10_stack_max%
ECHO + Item Attribute: %player.inventory_slot_10_attribute%
ECHO + Item Enchanted?: %player.inventory_slot_10_avail_enchant%
ECHO + Item Damage: %player.inventory_slot_10_damage%
ECHO +--------------------------------------------------------------------------------------------------+
ECHO ^| [E / EXIT ]
ECHO +--------------------------------------------------------------------------------------------------+
CHOICE /C E /N /M ">"
GOTO :INSPECT_ITEM

:ATTEMPT_INSPECT_11
TITLE (WINDHELM) - Inventory Viewer ^| Viewing item %player.inventory_slot_11%
CLS
ECHO Known item elements listed below.
ECHO +--------------------------------------------------------------------------------------------------+
ECHO + Item Type: %player.inventory_slot_11_type%
ECHO + Item Stack: %player.inventory_slot_11_stack%
ECHO + Item Stack Max: %player.inventory_slot_11_stack_max%
ECHO + Item Attribute: %player.inventory_slot_11_attribute%
ECHO + Item Enchanted?: %player.inventory_slot_11_avail_enchant%
ECHO + Item Damage: %player.inventory_slot_11_damage%
ECHO +--------------------------------------------------------------------------------------------------+
ECHO ^| [E / EXIT ]
ECHO +--------------------------------------------------------------------------------------------------+
CHOICE /C E /N /M ">"
GOTO :INSPECT_ITEM

:ATTEMPT_INSPECT_12
TITLE (WINDHELM) - Inventory Viewer ^| Viewing item %player.inventory_slot_12%
CLS
ECHO Known item elements listed below.
ECHO +--------------------------------------------------------------------------------------------------+
ECHO + Item Type: %player.inventory_slot_12_type%
ECHO + Item Stack: %player.inventory_slot_12_stack%
ECHO + Item Stack Max: %player.inventory_slot_12_stack_max%
ECHO + Item Attribute: %player.inventory_slot_12_attribute%
ECHO + Item Enchanted?: %player.inventory_slot_12_avail_enchant%
ECHO + Item Damage: %player.inventory_slot_12_damage%
ECHO +--------------------------------------------------------------------------------------------------+
ECHO ^| [E / EXIT ]
ECHO +--------------------------------------------------------------------------------------------------+
CHOICE /C E /N /M ">"
GOTO :INSPECT_ITEM

:ATTEMPT_INSPECT_13
TITLE (WINDHELM) - Inventory Viewer ^| Viewing item %player.inventory_slot_13%
CLS
ECHO Known item elements listed below.
ECHO +--------------------------------------------------------------------------------------------------+
ECHO + Item Type: %player.inventory_slot_13_type%
ECHO + Item Stack: %player.inventory_slot_13_stack%
ECHO + Item Stack Max: %player.inventory_slot_13_stack_max%
ECHO + Item Attribute: %player.inventory_slot_13_attribute%
ECHO + Item Enchanted?: %player.inventory_slot_13_avail_enchant%
ECHO + Item Damage: %player.inventory_slot_13_damage%
ECHO +--------------------------------------------------------------------------------------------------+
ECHO ^| [E / EXIT ]
ECHO +--------------------------------------------------------------------------------------------------+
CHOICE /C E /N /M ">"
GOTO :INSPECT_ITEM

:ATTEMPT_INSPECT_14
TITLE (WINDHELM) - Inventory Viewer ^| Viewing item %player.inventory_slot_14%
CLS
ECHO Known item elements listed below.
ECHO +--------------------------------------------------------------------------------------------------+
ECHO + Item Type: %player.inventory_slot_14_type%
ECHO + Item Stack: %player.inventory_slot_14_stack%
ECHO + Item Stack Max: %player.inventory_slot_14_stack_max%
ECHO + Item Attribute: %player.inventory_slot_14_attribute%
ECHO + Item Enchanted?: %player.inventory_slot_14_avail_enchant%
ECHO + Item Damage: %player.inventory_slot_14_damage%
ECHO +--------------------------------------------------------------------------------------------------+
ECHO ^| [E / EXIT ]
ECHO +--------------------------------------------------------------------------------------------------+
CHOICE /C E /N /M ">"
GOTO :INSPECT_ITEM

:ATTEMPT_INSPECT_15
TITLE (WINDHELM) - Inventory Viewer ^| Viewing item %player.inventory_slot_15%
CLS
ECHO Known item elements listed below.
ECHO +--------------------------------------------------------------------------------------------------+
ECHO + Item Type: %player.inventory_slot_15_type%
ECHO + Item Stack: %player.inventory_slot_15_stack%
ECHO + Item Stack Max: %player.inventory_slot_15_stack_max%
ECHO + Item Attribute: %player.inventory_slot_15_attribute%
ECHO + Item Enchanted?: %player.inventory_slot_15_avail_enchant%
ECHO + Item Damage: %player.inventory_slot_15_damage%
ECHO +--------------------------------------------------------------------------------------------------+
ECHO ^| [E / EXIT ]
ECHO +--------------------------------------------------------------------------------------------------+
CHOICE /C E /N /M ">"
GOTO :INSPECT_ITEM

REM Attempts to equip the item in the number 1 slot.
:ATTEMPT_EQUIP_1
IF "%player.inventory_slot_1_type%" == "weapon" (
    REM Now check if the Player has a weapon equipped already.
    IF NOT "%player_weapon_equipped%" == "EMPTY" (
        REM This slot is occupied.
        SET displayMessage=This slot is already occupied by the item: %player_weapon_equipped%.
        GOTO :EQUIP_ITEM
    ) ELSE (
        REM Slot is empty, equip this weapon.
        REM Remove this item from the stack.
        SET /A player.inventory_slot_1_stack=!player.inventory_slot_1_stack! -1
        SET player_weapon_equipped=%player.inventory_slot_1%
        SET item.weapon.return_to_slot=player.inventory_slot_1
        GOTO :CHECK_DAMAGE
    )
) ELSE IF "%player.inventory_slot_1_type%" == "armor" (
    REM Now check if the player has armor equipped already.
    IF NOT "%player_armor_equipped%" == "EMPTY" (
        REM This slot is occupied.
        SET displayMessage=This slot is already occupied by the item: %player_armor_equipped%.
        GOTO :EQUIP_ITEM
    ) ELSE (
        REM Slot is empty, equip this armor set.
        REM Remove this item from the stack.
        SET /A player.inventory_slot_1_stack=!player.inventory_slot_1_stack! -1
        SET player_armor_equipped=%player.inventory_slot_1%
        SET item.armor.return_to_slot=player.inventory_slot_1
        GOTO :EQUIP_ITEM
    )
) ELSE IF "%player.inventory_slot_1_type%" == "NONE" (
    REM Cannot equip this item type, or unknown type.
    SET displayMessage=This slot is empty.
    GOTO :EQUIP_ITEM
) ELSE (
    REM Unknown type.
    SET displayMessage=Cannot parse item type.
    GOTO :EQUIP_ITEM
)

REM Attempts to equip the item in the number 2 slot.
:ATTEMPT_EQUIP_2
IF "%player.inventory_slot_2_type%" == "weapon" (
    REM Now check if the Player has a weapon equipped already.
    IF NOT "%player_weapon_equipped%" == "EMPTY" (
        REM This slot is occupied.
        SET displayMessage=This slot is already occupied by the item: %player_weapon_equipped%.
        GOTO :EQUIP_ITEM
    ) ELSE (
        REM Slot is empty, equip this weapon.
        REM Remove this item from the stack.
        SET /A player.inventory_slot_2_stack=!player.inventory_slot_2_stack! -1
        SET player_weapon_equipped=%player.inventory_slot_2%
        SET item.weapon.return_to_slot=player.inventory_slot_2
        GOTO :CHECK_DAMAGE
    )
) ELSE IF "%player.inventory_slot_2_type%" == "armor" (
    REM Now check if the player has armor equipped already.
    IF NOT "%player_armor_equipped%" == "EMPTY" (
        REM This slot is occupied.
        SET displayMessage=This slot is already occupied by the item: %player_armor_equipped%.
        GOTO :EQUIP_ITEM
    ) ELSE (
        REM Slot is empty, equip this armor set.
        REM Remove this item from the stack.
        SET /A player.inventory_slot_2_stack=!player.inventory_slot_2_stack! -1
        SET player_armor_equipped=%player.inventory_slot_2%
        SET item.armor.return_to_slot=player.inventory_slot_2
        GOTO :EQUIP_ITEM
    )
) ELSE IF "%player.inventory_slot_2_type%" == "NONE" (
    REM Cannot equip this item type, or unknown type.
    SET displayMessage=This slot is empty.
    GOTO :EQUIP_ITEM
) ELSE (
    REM Unknown type.
    SET displayMessage=Cannot parse item type.
    GOTO :EQUIP_ITEM
)

REM Attempts to equip the item in the number 3 slot.
:ATTEMPT_EQUIP_3
IF "%player.inventory_slot_3_type%" == "weapon" (
    REM Now check if the Player has a weapon equipped already.
    IF NOT "%player_weapon_equipped%" == "EMPTY" (
        REM This slot is occupied.
        SET displayMessage=This slot is already occupied by the item: %player_weapon_equipped%.
        GOTO :EQUIP_ITEM
    ) ELSE (
        REM Slot is empty, equip this weapon.
        REM Remove this item from the stack.
        SET /A player.inventory_slot_3_stack=!player.inventory_slot_3_stack! -1
        SET player_weapon_equipped=%player.inventory_slot_3%
        SET item.weapon.return_to_slot=player.inventory_slot_3
        GOTO :CHECK_DAMAGE
    )
) ELSE IF "%player.inventory_slot_3_type%" == "armor" (
    REM Now check if the player has armor equipped already.
    IF NOT "%player_armor_equipped%" == "EMPTY" (
        REM This slot is occupied.
        SET displayMessage=This slot is already occupied by the item: %player_armor_equipped%.
        GOTO :EQUIP_ITEM
    ) ELSE (
        REM Slot is empty, equip this armor set.
        REM Remove this item from the stack.
        SET /A player.inventory_slot_3_stack=!player.inventory_slot_3_stack! -1
        SET player_armor_equipped=%player.inventory_slot_3%
        SET item.armor.return_to_slot=player.inventory_slot_3
        GOTO :EQUIP_ITEM
    )
) ELSE IF "%player.inventory_slot_3_type%" == "NONE" (
    REM Cannot equip this item type, or unknown type.
    SET displayMessage=This slot is empty.
    GOTO :EQUIP_ITEM
) ELSE (
    REM Unknown type.
    SET displayMessage=Cannot parse item type.
    GOTO :EQUIP_ITEM
)

REM Attempts to equip the item in the number 4 slot.
:ATTEMPT_EQUIP_4
IF "%player.inventory_slot_4_type%" == "weapon" (
    REM Now check if the Player has a weapon equipped already.
    IF NOT "%player_weapon_equipped%" == "EMPTY" (
        REM This slot is occupied.
        SET displayMessage=This slot is already occupied by the item: %player_weapon_equipped%.
        GOTO :EQUIP_ITEM
    ) ELSE (
        REM Slot is empty, equip this weapon.
        REM Remove this item from the stack.
        SET /A player.inventory_slot_4_stack=!player.inventory_slot_4_stack! -1
        SET player_weapon_equipped=%player.inventory_slot_4%
        SET item.weapon.return_to_slot=player.inventory_slot_4
        GOTO :CHECK_DAMAGE
    )
) ELSE IF "%player.inventory_slot_4_type%" == "armor" (
    REM Now check if the player has armor equipped already.
    IF NOT "%player_armor_equipped%" == "EMPTY" (
        REM This slot is occupied.
        SET displayMessage=This slot is already occupied by the item: %player_armor_equipped%.
        GOTO :EQUIP_ITEM
    ) ELSE (
        REM Slot is empty, equip this armor set.
        REM Remove this item from the stack.
        SET /A player.inventory_slot_4_stack=!player.inventory_slot_4_stack! -1
        SET player_armor_equipped=%player.inventory_slot_4%
        SET item.armor.return_to_slot=player.inventory_slot_4
        GOTO :EQUIP_ITEM
    )
) ELSE IF "%player.inventory_slot_4_type%" == "NONE" (
    REM Cannot equip this item type, or unknown type.
    SET displayMessage=This slot is empty.
    GOTO :EQUIP_ITEM
) ELSE (
    REM Unknown type.
    SET displayMessage=Cannot parse item type.
    GOTO :EQUIP_ITEM
)

REM Attempts to equip the item in the number 5 slot.
:ATTEMPT_EQUIP_5
IF "%player.inventory_slot_5_type%" == "weapon" (
    REM Now check if the Player has a weapon equipped already.
    IF NOT "%player_weapon_equipped%" == "EMPTY" (
        REM This slot is occupied.
        SET displayMessage=This slot is already occupied by the item: %player_weapon_equipped%.
        GOTO :EQUIP_ITEM
    ) ELSE (
        REM Slot is empty, equip this weapon.
        REM Remove this item from the stack.
        SET /A player.inventory_slot_5_stack=!player.inventory_slot_5_stack! -1
        SET player_weapon_equipped=%player.inventory_slot_5%
        SET item.weapon.return_to_slot=player.inventory_slot_5
        GOTO :CHECK_DAMAGE
    )
) ELSE IF "%player.inventory_slot_5_type%" == "armor" (
    REM Now check if the player has armor equipped already.
    IF NOT "%player_armor_equipped%" == "EMPTY" (
        REM This slot is occupied.
        SET displayMessage=This slot is already occupied by the item: %player_armor_equipped%.
        GOTO :EQUIP_ITEM
    ) ELSE (
        REM Slot is empty, equip this armor set.
        REM Remove this item from the stack.
        SET /A player.inventory_slot_5_stack=!player.inventory_slot_5_stack! -1
        SET player_armor_equipped=%player.inventory_slot_5%
        SET item.armor.return_to_slot=player.inventory_slot_5
        GOTO :EQUIP_ITEM
    )
) ELSE IF "%player.inventory_slot_5_type%" == "NONE" (
    REM Cannot equip this item type, or unknown type.
    SET displayMessage=This slot is empty.
    GOTO :EQUIP_ITEM
) ELSE (
    REM Unknown type.
    SET displayMessage=Cannot parse item type.
    GOTO :EQUIP_ITEM
)

REM Attempts to equip the item in the number 6 slot.
:ATTEMPT_EQUIP_6
IF "%player.inventory_slot_6_type%" == "weapon" (
    REM Now check if the Player has a weapon equipped already.
    IF NOT "%player_weapon_equipped%" == "EMPTY" (
        REM This slot is occupied.
        SET displayMessage=This slot is already occupied by the item: %player_weapon_equipped%.
        GOTO :EQUIP_ITEM
    ) ELSE (
        REM Slot is empty, equip this weapon.
        REM Remove this item from the stack.
        SET /A player.inventory_slot_6_stack=!player.inventory_slot_6_stack! -1
        SET player_weapon_equipped=%player.inventory_slot_6%
        SET item.weapon.return_to_slot=player.inventory_slot_6
        GOTO :CHECK_DAMAGE
    )
) ELSE IF "%player.inventory_slot_6_type%" == "armor" (
    REM Now check if the player has armor equipped already.
    IF NOT "%player_armor_equipped%" == "EMPTY" (
        REM This slot is occupied.
        SET displayMessage=This slot is already occupied by the item: %player_armor_equipped%.
        GOTO :EQUIP_ITEM
    ) ELSE (
        REM Slot is empty, equip this armor set.
        REM Remove this item from the stack.
        SET /A player.inventory_slot_6_stack=!player.inventory_slot_6_stack! -1
        SET player_armor_equipped=%player.inventory_slot_6%
        SET item.armor.return_to_slot=player.inventory_slot_6
        GOTO :EQUIP_ITEM
    )
) ELSE IF "%player.inventory_slot_6_type%" == "NONE" (
    REM Cannot equip this item type, or unknown type.
    SET displayMessage=This slot is empty.
    GOTO :EQUIP_ITEM
) ELSE (
    REM Unknown type.
    SET displayMessage=Cannot parse item type.
    GOTO :EQUIP_ITEM
)

REM Attempts to equip the item in the number 7 slot.
:ATTEMPT_EQUIP_7
IF "%player.inventory_slot_7_type%" == "weapon" (
    REM Now check if the Player has a weapon equipped already.
    IF NOT "%player_weapon_equipped%" == "EMPTY" (
        REM This slot is occupied.
        SET displayMessage=This slot is already occupied by the item: %player_weapon_equipped%.
        GOTO :EQUIP_ITEM
    ) ELSE (
        REM Slot is empty, equip this weapon.
        REM Remove this item from the stack.
        SET /A player.inventory_slot_7_stack=!player.inventory_slot_7_stack! -1
        SET player_weapon_equipped=%player.inventory_slot_7%
        SET item.weapon.return_to_slot=player.inventory_slot_7
        GOTO :CHECK_DAMAGE
    )
) ELSE IF "%player.inventory_slot_7_type%" == "armor" (
    REM Now check if the player has armor equipped already.
    IF NOT "%player_armor_equipped%" == "EMPTY" (
        REM This slot is occupied.
        SET displayMessage=This slot is already occupied by the item: %player_armor_equipped%.
        GOTO :EQUIP_ITEM
    ) ELSE (
        REM Slot is empty, equip this armor set.
        REM Remove this item from the stack.
        SET /A player.inventory_slot_7_stack=!player.inventory_slot_7_stack! -1
        SET player_armor_equipped=%player.inventory_slot_7%
        SET item.armor.return_to_slot=player.inventory_slot_7
        GOTO :EQUIP_ITEM
    )
) ELSE IF "%player.inventory_slot_7_type%" == "NONE" (
    REM Cannot equip this item type, or unknown type.
    SET displayMessage=This slot is empty.
    GOTO :EQUIP_ITEM
) ELSE (
    REM Unknown type.
    SET displayMessage=Cannot parse item type.
    GOTO :EQUIP_ITEM
)

REM Attempts to equip the item in the number 8 slot.
:ATTEMPT_EQUIP_8
IF "%player.inventory_slot_8_type%" == "weapon" (
    REM Now check if the Player has a weapon equipped already.
    IF NOT "%player_weapon_equipped%" == "EMPTY" (
        REM This slot is occupied.
        SET displayMessage=This slot is already occupied by the item: %player_weapon_equipped%.
        GOTO :EQUIP_ITEM
    ) ELSE (
        REM Slot is empty, equip this weapon.
        REM Remove this item from the stack.
        SET /A player.inventory_slot_8_stack=!player.inventory_slot_8_stack! -1
        SET player_weapon_equipped=%player.inventory_slot_8%
        SET item.weapon.return_to_slot=player.inventory_slot_8
        GOTO :CHECK_DAMAGE
    )
) ELSE IF "%player.inventory_slot_8_type%" == "armor" (
    REM Now check if the player has armor equipped already.
    IF NOT "%player_armor_equipped%" == "EMPTY" (
        REM This slot is occupied.
        SET displayMessage=This slot is already occupied by the item: %player_armor_equipped%.
        GOTO :EQUIP_ITEM
    ) ELSE (
        REM Slot is empty, equip this armor set.
        REM Remove this item from the stack.
        SET /A player.inventory_slot_8_stack=!player.inventory_slot_8_stack! -1
        SET player_armor_equipped=%player.inventory_slot_8%
        SET item.armor.return_to_slot=player.inventory_slot_8
        GOTO :EQUIP_ITEM
    )
) ELSE IF "%player.inventory_slot_8_type%" == "NONE" (
    REM Cannot equip this item type, or unknown type.
    SET displayMessage=This slot is empty.
    GOTO :EQUIP_ITEM
) ELSE (
    REM Unknown type.
    SET displayMessage=Cannot parse item type.
    GOTO :EQUIP_ITEM
)

REM Attempts to equip the item in the number 9 slot.
:ATTEMPT_EQUIP_9
IF "%player.inventory_slot_9_type%" == "weapon" (
    REM Now check if the Player has a weapon equipped already.
    IF NOT "%player_weapon_equipped%" == "EMPTY" (
        REM This slot is occupied.
        SET displayMessage=This slot is already occupied by the item: %player_weapon_equipped%.
        GOTO :EQUIP_ITEM
    ) ELSE (
        REM Slot is empty, equip this weapon.
        REM Remove this item from the stack.
        SET /A player.inventory_slot_9_stack=!player.inventory_slot_9_stack! -1
        SET player_weapon_equipped=%player.inventory_slot_9%
        SET item.weapon.return_to_slot=player.inventory_slot_9
        GOTO :CHECK_DAMAGE
    )
) ELSE IF "%player.inventory_slot_9_type%" == "armor" (
    REM Now check if the player has armor equipped already.
    IF NOT "%player_armor_equipped%" == "EMPTY" (
        REM This slot is occupied.
        SET displayMessage=This slot is already occupied by the item: %player_armor_equipped%.
        GOTO :EQUIP_ITEM
    ) ELSE (
        REM Slot is empty, equip this armor set.
        REM Remove this item from the stack.
        SET /A player.inventory_slot_9_stack=!player.inventory_slot_9_stack! -1
        SET player_armor_equipped=%player.inventory_slot_9%
        SET item.armor.return_to_slot=player.inventory_slot_9
        GOTO :EQUIP_ITEM
    )
) ELSE IF "%player.inventory_slot_9_type%" == "NONE" (
    REM Cannot equip this item type, or unknown type.
    SET displayMessage=This slot is empty.
    GOTO :EQUIP_ITEM
) ELSE (
    REM Unknown type.
    SET displayMessage=Cannot parse item type.
    GOTO :EQUIP_ITEM
)

REM Attempts to equip the item in the number 10 slot.
:ATTEMPT_EQUIP_10
IF "%player.inventory_slot_10_type%" == "weapon" (
    REM Now check if the Player has a weapon equipped already.
    IF NOT "%player_weapon_equipped%" == "EMPTY" (
        REM This slot is occupied.
        SET displayMessage=This slot is already occupied by the item: %player_weapon_equipped%.
        GOTO :EQUIP_ITEM
    ) ELSE (
        REM Slot is empty, equip this weapon.
        REM Remove this item from the stack.
        SET /A player.inventory_slot_10_stack=!player.inventory_slot_10_stack! -1
        SET player_weapon_equipped=%player.inventory_slot_10%
        SET item.weapon.return_to_slot=player.inventory_slot_10
        GOTO :CHECK_DAMAGE
    )
) ELSE IF "%player.inventory_slot_10_type%" == "armor" (
    REM Now check if the player has armor equipped already.
    IF NOT "%player_armor_equipped%" == "EMPTY" (
        REM This slot is occupied.
        SET displayMessage=This slot is already occupied by the item: %player_armor_equipped%.
        GOTO :EQUIP_ITEM
    ) ELSE (
        REM Slot is empty, equip this armor set.
        REM Remove this item from the stack.
        SET /A player.inventory_slot_10_stack=!player.inventory_slot_10_stack! -1
        SET player_armor_equipped=%player.inventory_slot_10%
        SET item.armor.return_to_slot=player.inventory_slot_10
        GOTO :EQUIP_ITEM
    )
) ELSE IF "%player.inventory_slot_10_type%" == "NONE" (
    REM Cannot equip this item type, or unknown type.
    SET displayMessage=This slot is empty.
    GOTO :EQUIP_ITEM
) ELSE (
    REM Unknown type.
    SET displayMessage=Cannot parse item type.
    GOTO :EQUIP_ITEM
)

REM Attempts to equip the item in the number 11 slot.
:ATTEMPT_EQUIP_11
IF "%player.inventory_slot_11_type%" == "weapon" (
    REM Now check if the Player has a weapon equipped already.
    IF NOT "%player_weapon_equipped%" == "EMPTY" (
        REM This slot is occupied.
        SET displayMessage=This slot is already occupied by the item: %player_weapon_equipped%.
        GOTO :EQUIP_ITEM
    ) ELSE (
        REM Slot is empty, equip this weapon.
        REM Remove this item from the stack.
        SET /A player.inventory_slot_11_stack=!player.inventory_slot_11_stack! -1
        SET player_weapon_equipped=%player.inventory_slot_11%
        SET item.weapon.return_to_slot=player.inventory_slot_11
        GOTO :CHECK_DAMAGE
    )
) ELSE IF "%player.inventory_slot_11_type%" == "armor" (
    REM Now check if the player has armor equipped already.
    IF NOT "%player_armor_equipped%" == "EMPTY" (
        REM This slot is occupied.
        SET displayMessage=This slot is already occupied by the item: %player_armor_equipped%.
        GOTO :EQUIP_ITEM
    ) ELSE (
        REM Slot is empty, equip this armor set.
        REM Remove this item from the stack.
        SET /A player.inventory_slot_11_stack=!player.inventory_slot_11_stack! -1
        SET player_armor_equipped=%player.inventory_slot_11%
        SET item.armor.return_to_slot=player.inventory_slot_11
        GOTO :EQUIP_ITEM
    )
) ELSE IF "%player.inventory_slot_11_type%" == "NONE" (
    REM Cannot equip this item type, or unknown type.
    SET displayMessage=This slot is empty.
    GOTO :EQUIP_ITEM
) ELSE (
    REM Unknown type.
    SET displayMessage=Cannot parse item type.
    GOTO :EQUIP_ITEM
)

REM Attempts to equip the item in the number 12 slot.
:ATTEMPT_EQUIP_12
IF "%player.inventory_slot_12_type%" == "weapon" (
    REM Now check if the Player has a weapon equipped already.
    IF NOT "%player_weapon_equipped%" == "EMPTY" (
        REM This slot is occupied.
        SET displayMessage=This slot is already occupied by the item: %player_weapon_equipped%.
        GOTO :EQUIP_ITEM
    ) ELSE (
        REM Slot is empty, equip this weapon.
        REM Remove this item from the stack.
        SET /A player.inventory_slot_12_stack=!player.inventory_slot_12_stack! -1
        SET player_weapon_equipped=%player.inventory_slot_12%
        SET item.weapon.return_to_slot=player.inventory_slot_12
        GOTO :CHECK_DAMAGE
    )
) ELSE IF "%player.inventory_slot_12_type%" == "armor" (
    REM Now check if the player has armor equipped already.
    IF NOT "%player_armor_equipped%" == "EMPTY" (
        REM This slot is occupied.
        SET displayMessage=This slot is already occupied by the item: %player_armor_equipped%.
        GOTO :EQUIP_ITEM
    ) ELSE (
        REM Slot is empty, equip this armor set.
        REM Remove this item from the stack.
        SET /A player.inventory_slot_12_stack=!player.inventory_slot_12_stack! -1
        SET player_armor_equipped=%player.inventory_slot_12%
        SET item.armor.return_to_slot=player.inventory_slot_12
        GOTO :EQUIP_ITEM
    )
) ELSE IF "%player.inventory_slot_12_type%" == "NONE" (
    REM Cannot equip this item type, or unknown type.
    SET displayMessage=This slot is empty.
    GOTO :EQUIP_ITEM
) ELSE (
    REM Unknown type.
    SET displayMessage=Cannot parse item type.
    GOTO :EQUIP_ITEM
)

REM Attempts to equip the item in the number 13 slot.
:ATTEMPT_EQUIP_13
IF "%player.inventory_slot_13_type%" == "weapon" (
    REM Now check if the Player has a weapon equipped already.
    IF NOT "%player_weapon_equipped%" == "EMPTY" (
        REM This slot is occupied.
        SET displayMessage=This slot is already occupied by the item: %player_weapon_equipped%.
        GOTO :EQUIP_ITEM
    ) ELSE (
        REM Slot is empty, equip this weapon.
        REM Remove this item from the stack.
        SET /A player.inventory_slot_13_stack=!player.inventory_slot_13_stack! -1
        SET player_weapon_equipped=%player.inventory_slot_13%
        SET item.weapon.return_to_slot=player.inventory_slot_13
        GOTO :CHECK_DAMAGE
    )
) ELSE IF "%player.inventory_slot_13_type%" == "armor" (
    REM Now check if the player has armor equipped already.
    IF NOT "%player_armor_equipped%" == "EMPTY" (
        REM This slot is occupied.
        SET displayMessage=This slot is already occupied by the item: %player_armor_equipped%.
        GOTO :EQUIP_ITEM
    ) ELSE (
        REM Slot is empty, equip this armor set.
        REM Remove this item from the stack.
        SET /A player.inventory_slot_13_stack=!player.inventory_slot_13_stack! -1
        SET player_armor_equipped=%player.inventory_slot_13%
        SET item.armor.return_to_slot=player.inventory_slot_13
        GOTO :EQUIP_ITEM
    )
) ELSE IF "%player.inventory_slot_13_type%" == "NONE" (
    REM Cannot equip this item type, or unknown type.
    SET displayMessage=This slot is empty.
    GOTO :EQUIP_ITEM
) ELSE (
    REM Unknown type.
    SET displayMessage=Cannot parse item type.
    GOTO :EQUIP_ITEM
)

REM Attempts to equip the item in the number 14 slot.
:ATTEMPT_EQUIP_14
IF "%player.inventory_slot_14_type%" == "weapon" (
    REM Now check if the Player has a weapon equipped already.
    IF NOT "%player_weapon_equipped%" == "EMPTY" (
        REM This slot is occupied.
        SET displayMessage=This slot is already occupied by the item: %player_weapon_equipped%.
        GOTO :EQUIP_ITEM
    ) ELSE (
        REM Slot is empty, equip this weapon.
        REM Remove this item from the stack.
        SET /A player.inventory_slot_14_stack=!player.inventory_slot_14_stack! -1
        SET player_weapon_equipped=%player.inventory_slot_14%
        SET item.weapon.return_to_slot=player.inventory_slot_14
        GOTO :CHECK_DAMAGE
    )
) ELSE IF "%player.inventory_slot_14_type%" == "armor" (
    REM Now check if the player has armor equipped already.
    IF NOT "%player_armor_equipped%" == "EMPTY" (
        REM This slot is occupied.
        SET displayMessage=This slot is already occupied by the item: %player_armor_equipped%.
        GOTO :EQUIP_ITEM
    ) ELSE (
        REM Slot is empty, equip this armor set.
        REM Remove this item from the stack.
        SET /A player.inventory_slot_14_stack=!player.inventory_slot_14_stack! -1
        SET player_armor_equipped=%player.inventory_slot_14%
        SET item.armor.return_to_slot=player.inventory_slot_14
        GOTO :EQUIP_ITEM
    )
) ELSE IF "%player.inventory_slot_14_type%" == "NONE" (
    REM Cannot equip this item type, or unknown type.
    SET displayMessage=This slot is empty.
    GOTO :EQUIP_ITEM
) ELSE (
    REM Unknown type.
    SET displayMessage=Cannot parse item type.
    GOTO :EQUIP_ITEM
)

REM Attempts to equip the item in the number 15 slot.
:ATTEMPT_EQUIP_15
IF "%player.inventory_slot_15_type%" == "weapon" (
    REM Now check if the Player has a weapon equipped already.
    IF NOT "%player_weapon_equipped%" == "EMPTY" (
        REM This slot is occupied.
        SET displayMessage=This slot is already occupied by the item: %player_weapon_equipped%.
        GOTO :EQUIP_ITEM
    ) ELSE (
        REM Slot is empty, equip this weapon.
        REM Remove this item from the stack.
        SET /A player.inventory_slot_15_stack=!player.inventory_slot_15_stack! -1
        SET player_weapon_equipped=%player.inventory_slot_15%
        SET item.weapon.return_to_slot=player.inventory_slot_15
        GOTO :CHECK_DAMAGE
    )
) ELSE IF "%player.inventory_slot_15_type%" == "armor" (
    REM Now check if the player has armor equipped already.
    IF NOT "%player_armor_equipped%" == "EMPTY" (
        REM This slot is occupied.
        SET displayMessage=This slot is already occupied by the item: %player_armor_equipped%.
        GOTO :EQUIP_ITEM
    ) ELSE (
        REM Slot is empty, equip this armor set.
        REM Remove this item from the stack.
        SET /A player.inventory_slot_15_stack=!player.inventory_slot_15_stack! -1
        SET player_armor_equipped=%player.inventory_slot_15%
        SET item.armor.return_to_slot=player.inventory_slot_15
        GOTO :EQUIP_ITEM
    )
) ELSE IF "%player.inventory_slot_15_type%" == "NONE" (
    REM Cannot equip this item type, or unknown type.
    SET displayMessage=This slot is empty.
    GOTO :EQUIP_ITEM
) ELSE (
    REM Unknown type.
    SET displayMessage=Cannot parse item type.
    GOTO :EQUIP_ITEM
)

REM Checks for the weapon in the slot and then applies it to the Player's damage.
:CHECK_DAMAGE
IF "%player_weapon_equipped%" == "Shortsword" (
    SET player_damage=%shortsword_d%
    GOTO :EQUIP_ITEM
) ELSE IF "%player_weapon_equipped%" == "Longsword" (
    SET player_damage=%longsword_d%
    GOTO :EQUIP_ITEM
) ELSE IF "%player_weapon_equipped%" == "Greataxe" (
    SET player_damage=%greataxe_d%
    GOTO :EQUIP_ITEM
) ELSE IF "%player_weapon_equipped%" == "Mace" (
    SET player_damage=%mace_d%
    GOTO :EQUIP_ITEM
) ELSE IF "%player_weapon_equipped%" == "woodenBow" (
    SET player_damage=%weapon.woodenBow_damage%
    GOTO :EQUIP_ITEM
) ELSE (
    REM Unknown weapon / generic error
    ECHO Error equipping weapon, unknown weapon.
    PAUSE
    GOTO :EQUIP_ITEM
)

REM Checks for the armor in the slot and then applies it to the Player's armor rating.
:CHECK_ARMOR
IF "%player_armor_equipped%" == "Cactus Armor" (
    SET player_armor=%cactusA_p%
    GOTO :EQUIP_ITEM
) ELSE IF "%player_armor_equipped%" == "Stone Armor" (
    SET player_armor=%stoneA_p%
    GOTO :EQUIP_ITEM
) ELSE IF "%player_armor_equipped%" == "Steel Armor" (
    SET player_armor=%steelA_p%
    GOTO :EQUIP_ITEM
) ELSE IF "%player_armor_equipped%" == "Scaled Armor" (
    SET player_armor=%scaledA_p%
    GOTO :EQUIP_ITEM
) ELSE IF "%player_armor_equipped%" == "Iron Armor" (
    SET player_armor=%ironArmor_prot%
    GOTO :EQUIP_ITEM
) ELSE IF "%player_armor_equipped%" == "Leather Armor" (
    SET player_armor=%leatherArmor_prot%
    GOTO :EQUIP_ITEM
) ELSE IF "%player_armor_equipped%" == "Silver Armor" (
    SET player_armor=%silverArmor_prot%
    GOTO :EQUIP_ITEM
) ELSE IF "%player_armor_equipped%" == "Gold Armor" (
    SET player_armor=%goldArmor_prot%
    GOTO :EQUIP_ITEM
) ELSE (
    REM Unknown armor / generic error
    ECHO Error equipping armor, unknown armor.
    PAUSE
    GOTO :EQUIP_ITEM
)