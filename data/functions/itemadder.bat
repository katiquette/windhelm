@ECHO OFF

:REASONER
IF "%iAdd%" == "purchasedItem" (
    SET refundItem=false
    GOTO :SELECT_SLOT
) ELSE (
    GOTO :EOF
)

REM Prompts the Player to select a slot to store their newly purchased item.
:SELECT_SLOT
CLS
ECHO.
TYPE "%cd%\data\assets\ui\additem.txt"
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
IF ERRORLEVEL 11 GOTO :CHECK_REFUND
IF ERRORLEVEL 10 GOTO :ATTEMPT_STORE_MENU
IF ERRORLEVEL 9 GOTO :ATTEMPT_STORE_9
IF ERRORLEVEL 8 GOTO :ATTEMPT_STORE_8
IF ERRORLEVEL 7 GOTO :ATTEMPT_STORE_7
IF ERRORLEVEL 6 GOTO :ATTEMPT_STORE_6
IF ERRORLEVEL 5 GOTO :ATTEMPT_STORE_5
IF ERRORLEVEL 4 GOTO :ATTEMPT_STORE_4
IF ERRORLEVEL 3 GOTO :ATTEMPT_STORE_3
IF ERRORLEVEL 2 GOTO :ATTEMPT_STORE_2
IF ERRORLEVEL 1 GOTO :ATTEMPT_STORE_1

:ATTEMPT_STORE_MENU
CLS
ECHO.
TYPE "%cd%\data\assets\ui\additem.txt"
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
IF ERRORLEVEL 7 GOTO :SELECT_SLOT
IF ERRORLEVEL 6 GOTO :ATTEMPT_STORE_15
IF ERRORLEVEL 5 GOTO :ATTEMPT_STORE_14
IF ERRORLEVEL 4 GOTO :ATTEMPT_STORE_13
IF ERRORLEVEL 3 GOTO :ATTEMPT_STORE_12
IF ERRORLEVEL 2 GOTO :ATTEMPT_STORE_11
IF ERRORLEVEL 1 GOTO :ATTEMPT_STORE_10

:ATTEMPT_STORE_1
REM Check if this slot is empty
IF NOT "%player.inventory_slot_1%" == "EMPTY" (
    REM Check if the item the Player is adding is already present in this slot.
    IF "%item.to_add%" == "%player.inventory_slot_1%" (
        REM Add another of this item to the stack of existing items in this slot.
        SET /A player.inventory_slot_1_stack=!player.inventory_slot_1_stack! +1
        IF %player.inventory_slot_1_stack% GTR %player.inventory_slot_1_stack_max% (
            SET /A player.inventory_slot_1_stack=!player.inventory_slot_1_stack! -1
            SET displayMessage=Adding this item to this slot would exceed the stack limit, choose a different slot.
            SET refundItem=true
            GOTO :ATTEMPT_STORE_MENU
        ) ELSE (
            GOTO :EOF
        )
    ) ELSE (
        REM This slot is occupied by a different item.
        SET displayMessage=This slot is already occupied by a different item.
        GOTO :SELECT_SLOT
    )
) ELSE (
    REM Adds the item to the Player's inventory.
    SET player.inventory_slot_1=%item.to_add%
    SET player.inventory_slot_1_type=%item.to_add_type%
    SET player.inventory_slot_1_stack=1
    SET player.inventory_slot_1_stack_max=%item.to_add_stack_max%
    SET player.inventory_slot_1_attribute=%item.to_add_attribute%
    SET player.inventory_slot_1_avail_enchant=%item.to_add_enchant%
    SET player.inventory_slot_1_damage=%item.to_add_damage%
    GOTO :EOF
)

:ATTEMPT_STORE_2
REM Check if this slot is empty
IF NOT "%player.inventory_slot_2%" == "EMPTY" (
    REM Check if the item the Player is adding is already present in this slot.
    IF "%item.to_add%" == "%player.inventory_slot_2%" (
        REM Add another of this item to the stack of existing items in this slot.
        SET /A player.inventory_slot_2_stack=!player.inventory_slot_2_stack! +1
        IF %player.inventory_slot_2_stack% GTR %player.inventory_slot_2_stack_max% (
            SET /A player.inventory_slot_2_stack=!player.inventory_slot_2_stack! -1
            SET displayMessage=Adding this item to this slot would exceed the stack limit, choose a different slot.
            SET refundItem=true
            GOTO :ATTEMPT_STORE_MENU
        ) ELSE (
            GOTO :EOF
        )
    ) ELSE (
        REM This slot is occupied by a different item.
        SET displayMessage=This slot is already occupied by a different item.
        GOTO :SELECT_SLOT
    )
) ELSE (
    REM Adds the item to the Player's inventory.
    SET player.inventory_slot_2=%item.to_add%
    SET player.inventory_slot_2_type=%item.to_add_type%
    SET player.inventory_slot_2_stack=1
    SET player.inventory_slot_2_stack_max=%item.to_add_stack_max%
    SET player.inventory_slot_2_attribute=%item.to_add_attribute%
    SET player.inventory_slot_2_avail_enchant=%item.to_add_enchant%
    SET player.inventory_slot_2_damage=%item.to_add_damage%
    GOTO :EOF
)

:ATTEMPT_STORE_3
REM Check if this slot is empty
IF NOT "%player.inventory_slot_3%" == "EMPTY" (
    REM Check if the item the Player is adding is already present in this slot.
    IF "%item.to_add%" == "%player.inventory_slot_3%" (
        REM Add another of this item to the stack of existing items in this slot.
        SET /A player.inventory_slot_3_stack=!player.inventory_slot_3_stack! +1
        IF %player.inventory_slot_3_stack% GTR %player.inventory_slot_3_stack_max% (
            SET /A player.inventory_slot_3_stack=!player.inventory_slot_3_stack! -1
            SET displayMessage=Adding this item to this slot would exceed the stack limit, choose a different slot.
            SET refundItem=true
            GOTO :ATTEMPT_STORE_MENU
        ) ELSE (
            GOTO :EOF
        )
        GOTO :EOF
    ) ELSE (
        REM This slot is occupied by a different item.
        SET displayMessage=This slot is already occupied by a different item.
        GOTO :SELECT_SLOT
    )
) ELSE (
    REM Adds the item to the Player's inventory.
    SET player.inventory_slot_3=%item.to_add%
    SET player.inventory_slot_3_type=%item.to_add_type%
    SET player.inventory_slot_3_stack=1
    SET player.inventory_slot_3_stack_max=%item.to_add_stack_max%
    SET player.inventory_slot_3_attribute=%item.to_add_attribute%
    SET player.inventory_slot_3_avail_enchant=%item.to_add_enchant%
    SET player.inventory_slot_3_damage=%item.to_add_damage%
    GOTO :EOF
)

:ATTEMPT_STORE_4
REM Check if this slot is empty
IF NOT "%player.inventory_slot_4%" == "EMPTY" (
    REM Check if the item the Player is adding is already present in this slot.
    IF "%item.to_add%" == "%player.inventory_slot_4%" (
        REM Add another of this item to the stack of existing items in this slot.
        SET /A player.inventory_slot_4_stack=!player.inventory_slot_4_stack! +1
        IF %player.inventory_slot_4_stack% GTR %player.inventory_slot_4_stack_max% (
            SET /A player.inventory_slot_4_stack=!player.inventory_slot_4_stack! -1
            SET displayMessage=Adding this item to this slot would exceed the stack limit, choose a different slot.
            SET refundItem=true
            GOTO :ATTEMPT_STORE_MENU
        ) ELSE (
            GOTO :EOF
        )
        GOTO :EOF
    ) ELSE (
        REM This slot is occupied by a different item.
        SET displayMessage=This slot is already occupied by a different item.
        GOTO :SELECT_SLOT
    )
) ELSE (
    REM Adds the item to the Player's inventory.
    SET player.inventory_slot_4=%item.to_add%
    SET player.inventory_slot_4_type=%item.to_add_type%
    SET player.inventory_slot_4_stack=1
    SET player.inventory_slot_4_stack_max=%item.to_add_stack_max%
    SET player.inventory_slot_4_attribute=%item.to_add_attribute%
    SET player.inventory_slot_4_avail_enchant=%item.to_add_enchant%
    SET player.inventory_slot_4_damage=%item.to_add_damage%
    GOTO :EOF
)

:ATTEMPT_STORE_5
REM Check if this slot is empty
IF NOT "%player.inventory_slot_5%" == "EMPTY" (
    REM Check if the item the Player is adding is already present in this slot.
    IF "%item.to_add%" == "%player.inventory_slot_5%" (
        REM Add another of this item to the stack of existing items in this slot.
        SET /A player.inventory_slot_5_stack=!player.inventory_slot_5_stack! +1
        IF %player.inventory_slot_5_stack% GTR %player.inventory_slot_5_stack_max% (
            SET /A player.inventory_slot_5_stack=!player.inventory_slot_5_stack! -1
            SET displayMessage=Adding this item to this slot would exceed the stack limit, choose a different slot.
            SET refundItem=true
            GOTO :ATTEMPT_STORE_MENU
        ) ELSE (
            GOTO :EOF
        )
        GOTO :EOF
    ) ELSE (
        REM This slot is occupied by a different item.
        SET displayMessage=This slot is already occupied by a different item.
        GOTO :SELECT_SLOT
    )
) ELSE (
    REM Adds the item to the Player's inventory.
    SET player.inventory_slot_5=%item.to_add%
    SET player.inventory_slot_5_type=%item.to_add_type%
    SET player.inventory_slot_5_stack=1
    SET player.inventory_slot_5_stack_max=%item.to_add_stack_max%
    SET player.inventory_slot_5_attribute=%item.to_add_attribute%
    SET player.inventory_slot_5_avail_enchant=%item.to_add_enchant%
    SET player.inventory_slot_5_damage=%item.to_add_damage%
    GOTO :EOF
)

:ATTEMPT_STORE_6
REM Check if this slot is empty
IF NOT "%player.inventory_slot_6%" == "EMPTY" (
    REM Check if the item the Player is adding is already present in this slot.
    IF "%item.to_add%" == "%player.inventory_slot_6%" (
        REM Add another of this item to the stack of existing items in this slot.
        SET /A player.inventory_slot_6_stack=!player.inventory_slot_6_stack! +1
        IF %player.inventory_slot_6_stack% GTR %player.inventory_slot_6_stack_max% (
            SET /A player.inventory_slot_6_stack=!player.inventory_slot_6_stack! -1
            SET displayMessage=Adding this item to this slot would exceed the stack limit, choose a different slot.
            SET refundItem=true
            GOTO :ATTEMPT_STORE_MENU
        ) ELSE (
            GOTO :EOF
        )
        GOTO :EOF
    ) ELSE (
        REM This slot is occupied by a different item.
        SET displayMessage=This slot is already occupied by a different item.
        GOTO :SELECT_SLOT
    )
) ELSE (
    REM Adds the item to the Player's inventory.
    SET player.inventory_slot_6=%item.to_add%
    SET player.inventory_slot_6_type=%item.to_add_type%
    SET player.inventory_slot_6_stack=1
    SET player.inventory_slot_6_stack_max=%item.to_add_stack_max%
    SET player.inventory_slot_6_attribute=%item.to_add_attribute%
    SET player.inventory_slot_6_avail_enchant=%item.to_add_enchant%
    SET player.inventory_slot_6_damage=%item.to_add_damage%
    GOTO :EOF
)

:ATTEMPT_STORE_7
REM Check if this slot is empty
IF NOT "%player.inventory_slot_7%" == "EMPTY" (
    REM Check if the item the Player is adding is already present in this slot.
    IF "%item.to_add%" == "%player.inventory_slot_7%" (
        REM Add another of this item to the stack of existing items in this slot.
        SET /A player.inventory_slot_7_stack=!player.inventory_slot_7_stack! +1
        IF %player.inventory_slot_7_stack% GTR %player.inventory_slot_7_stack_max% (
            SET /A player.inventory_slot_7_stack=!player.inventory_slot_7_stack! -1
            SET displayMessage=Adding this item to this slot would exceed the stack limit, choose a different slot.
            SET refundItem=true
            GOTO :ATTEMPT_STORE_MENU
        ) ELSE (
            GOTO :EOF
        )
        GOTO :EOF
    ) ELSE (
        REM This slot is occupied by a different item.
        SET displayMessage=This slot is already occupied by a different item.
        GOTO :SELECT_SLOT
    )
) ELSE (
    REM Adds the item to the Player's inventory.
    SET player.inventory_slot_7=%item.to_add%
    SET player.inventory_slot_7_type=%item.to_add_type%
    SET player.inventory_slot_7_stack=1
    SET player.inventory_slot_7_stack_max=%item.to_add_stack_max%
    SET player.inventory_slot_7_attribute=%item.to_add_attribute%
    SET player.inventory_slot_7_avail_enchant=%item.to_add_enchant%
    SET player.inventory_slot_7_damage=%item.to_add_damage%
    GOTO :EOF
)

:ATTEMPT_STORE_8
REM Check if this slot is empty
IF NOT "%player.inventory_slot_8%" == "EMPTY" (
    REM Check if the item the Player is adding is already present in this slot.
    IF "%item.to_add%" == "%player.inventory_slot_8%" (
        REM Add another of this item to the stack of existing items in this slot.
        SET /A player.inventory_slot_8_stack=!player.inventory_slot_8_stack! +1
        IF %player.inventory_slot_8_stack% GTR %player.inventory_slot_8_stack_max% (
            SET /A player.inventory_slot_8_stack=!player.inventory_slot_8_stack! -1
            SET displayMessage=Adding this item to this slot would exceed the stack limit, choose a different slot.
            SET refundItem=true
            GOTO :ATTEMPT_STORE_MENU
        ) ELSE (
            GOTO :EOF
        )
        GOTO :EOF
    ) ELSE (
        REM This slot is occupied by a different item.
        SET displayMessage=This slot is already occupied by a different item.
        GOTO :SELECT_SLOT
    )
) ELSE (
    REM Adds the item to the Player's inventory.
    SET player.inventory_slot_8=%item.to_add%
    SET player.inventory_slot_8_type=%item.to_add_type%
    SET player.inventory_slot_8_stack=1
    SET player.inventory_slot_8_stack_max=%item.to_add_stack_max%
    SET player.inventory_slot_8_attribute=%item.to_add_attribute%
    SET player.inventory_slot_8_avail_enchant=%item.to_add_enchant%
    SET player.inventory_slot_8_damage=%item.to_add_damage%
    GOTO :EOF
)

:ATTEMPT_STORE_9
REM Check if this slot is empty
IF NOT "%player.inventory_slot_9%" == "EMPTY" (
    REM Check if the item the Player is adding is already present in this slot.
    IF "%item.to_add%" == "%player.inventory_slot_9%" (
        REM Add another of this item to the stack of existing items in this slot.
        SET /A player.inventory_slot_9_stack=!player.inventory_slot_9_stack! +1
        IF %player.inventory_slot_9_stack% GTR %player.inventory_slot_9_stack_max% (
            SET /A player.inventory_slot_9_stack=!player.inventory_slot_9_stack! -1
            SET displayMessage=Adding this item to this slot would exceed the stack limit, choose a different slot.
            SET refundItem=true
            GOTO :ATTEMPT_STORE_MENU
        ) ELSE (
            GOTO :EOF
        )
        GOTO :EOF
    ) ELSE (
        REM This slot is occupied by a different item.
        SET displayMessage=This slot is already occupied by a different item.
        GOTO :SELECT_SLOT
    )
) ELSE (
    REM Adds the item to the Player's inventory.
    SET player.inventory_slot_9=%item.to_add%
    SET player.inventory_slot_9_type=%item.to_add_type%
    SET player.inventory_slot_9_stack=1
    SET player.inventory_slot_9_stack_max=%item.to_add_stack_max%
    SET player.inventory_slot_9_attribute=%item.to_add_attribute%
    SET player.inventory_slot_9_avail_enchant=%item.to_add_enchant%
    SET player.inventory_slot_9_damage=%item.to_add_damage%
    GOTO :EOF
)

:ATTEMPT_STORE_10
REM Check if this slot is empty
IF NOT "%player.inventory_slot_10%" == "EMPTY" (
    REM Check if the item the Player is adding is already present in this slot.
    IF "%item.to_add%" == "%player.inventory_slot_10%" (
        REM Add another of this item to the stack of existing items in this slot.
        SET /A player.inventory_slot_10_stack=!player.inventory_slot_10_stack! +1
        IF %player.inventory_slot_10_stack% GTR %player.inventory_slot_10_stack_max% (
            SET /A player.inventory_slot_10_stack=!player.inventory_slot_10_stack! -1
            SET displayMessage=Adding this item to this slot would exceed the stack limit, choose a different slot.
            SET refundItem=true
            GOTO :ATTEMPT_STORE_MENU
        ) ELSE (
            GOTO :EOF
        )
        GOTO :EOF
    ) ELSE (
        REM This slot is occupied by a different item.
        SET displayMessage=This slot is already occupied by a different item.
        GOTO :SELECT_SLOT
    )
) ELSE (
    REM Adds the item to the Player's inventory.
    SET player.inventory_slot_10=%item.to_add%
    SET player.inventory_slot_10_type=%item.to_add_type%
    SET player.inventory_slot_10_stack=1
    SET player.inventory_slot_10_stack_max=%item.to_add_stack_max%
    SET player.inventory_slot_10_attribute=%item.to_add_attribute%
    SET player.inventory_slot_10_avail_enchant=%item.to_add_enchant%
    SET player.inventory_slot_10_damage=%item.to_add_damage%
    GOTO :EOF
)

:ATTEMPT_STORE_11
REM Check if this slot is empty
IF NOT "%player.inventory_slot_11%" == "EMPTY" (
    REM Check if the item the Player is adding is already present in this slot.
    IF "%item.to_add%" == "%player.inventory_slot_11%" (
        REM Add another of this item to the stack of existing items in this slot.
        SET /A player.inventory_slot_11_stack=!player.inventory_slot_11_stack! +1
        IF %player.inventory_slot_11_stack% GTR %player.inventory_slot_11_stack_max% (
            SET /A player.inventory_slot_11_stack=!player.inventory_slot_11_stack! -1
            SET displayMessage=Adding this item to this slot would exceed the stack limit, choose a different slot.
            SET refundItem=true
            GOTO :ATTEMPT_STORE_MENU
        ) ELSE (
            GOTO :EOF
        )
        GOTO :EOF
    ) ELSE (
        REM This slot is occupied by a different item.
        SET displayMessage=This slot is already occupied by a different item.
        GOTO :SELECT_SLOT
    )
) ELSE (
    REM Adds the item to the Player's inventory.
    SET player.inventory_slot_11=%item.to_add%
    SET player.inventory_slot_11_type=%item.to_add_type%
    SET player.inventory_slot_11_stack=1
    SET player.inventory_slot_11_stack_max=%item.to_add_stack_max%
    SET player.inventory_slot_11_attribute=%item.to_add_attribute%
    SET player.inventory_slot_11_avail_enchant=%item.to_add_enchant%
    SET player.inventory_slot_11_damage=%item.to_add_damage%
    GOTO :EOF
)

:ATTEMPT_STORE_12
REM Check if this slot is empty
IF NOT "%player.inventory_slot_12%" == "EMPTY" (
    REM Check if the item the Player is adding is already present in this slot.
    IF "%item.to_add%" == "%player.inventory_slot_12%" (
        REM Add another of this item to the stack of existing items in this slot.
        SET /A player.inventory_slot_12_stack=!player.inventory_slot_12_stack! +1
        IF %player.inventory_slot_12_stack% GTR %player.inventory_slot_12_stack_max% (
            SET /A player.inventory_slot_12_stack=!player.inventory_slot_12_stack! -1
            SET displayMessage=Adding this item to this slot would exceed the stack limit, choose a different slot.
            SET refundItem=true
            GOTO :ATTEMPT_STORE_MENU
        ) ELSE (
            GOTO :EOF
        )
        GOTO :EOF
    ) ELSE (
        REM This slot is occupied by a different item.
        SET displayMessage=This slot is already occupied by a different item.
        GOTO :SELECT_SLOT
    )
) ELSE (
    REM Adds the item to the Player's inventory.
    SET player.inventory_slot_12=%item.to_add%
    SET player.inventory_slot_12_type=%item.to_add_type%
    SET player.inventory_slot_12_stack=1
    SET player.inventory_slot_12_stack_max=%item.to_add_stack_max%
    SET player.inventory_slot_12_attribute=%item.to_add_attribute%
    SET player.inventory_slot_12_avail_enchant=%item.to_add_enchant%
    SET player.inventory_slot_12_damage=%item.to_add_damage%
    GOTO :EOF
)

:ATTEMPT_STORE_13
REM Check if this slot is empty
IF NOT "%player.inventory_slot_13%" == "EMPTY" (
    REM Check if the item the Player is adding is already present in this slot.
    IF "%item.to_add%" == "%player.inventory_slot_13%" (
        REM Add another of this item to the stack of existing items in this slot.
        SET /A player.inventory_slot_13_stack=!player.inventory_slot_13_stack! +1
        IF %player.inventory_slot_13_stack% GTR %player.inventory_slot_13_stack_max% (
            SET /A player.inventory_slot_13_stack=!player.inventory_slot_13_stack! -1
            SET displayMessage=Adding this item to this slot would exceed the stack limit, choose a different slot.
            SET refundItem=true
            GOTO :ATTEMPT_STORE_MENU
        ) ELSE (
            GOTO :EOF
        )
        GOTO :EOF
    ) ELSE (
        REM This slot is occupied by a different item.
        SET displayMessage=This slot is already occupied by a different item.
        GOTO :SELECT_SLOT
    )
) ELSE (
    REM Adds the item to the Player's inventory.
    SET player.inventory_slot_13=%item.to_add%
    SET player.inventory_slot_13_type=%item.to_add_type%
    SET player.inventory_slot_13_stack=1
    SET player.inventory_slot_13_stack_max=%item.to_add_stack_max%
    SET player.inventory_slot_13_attribute=%item.to_add_attribute%
    SET player.inventory_slot_13_avail_enchant=%item.to_add_enchant%
    SET player.inventory_slot_13_damage=%item.to_add_damage%
    GOTO :EOF
)

:ATTEMPT_STORE_14
REM Check if this slot is empty
IF NOT "%player.inventory_slot_14%" == "EMPTY" (
    REM Check if the item the Player is adding is already present in this slot.
    IF "%item.to_add%" == "%player.inventory_slot_14%" (
        REM Add another of this item to the stack of existing items in this slot.
        SET /A player.inventory_slot_14_stack=!player.inventory_slot_14_stack! +1
        IF %player.inventory_slot_14_stack% GTR %player.inventory_slot_14_stack_max% (
            SET /A player.inventory_slot_14_stack=!player.inventory_slot_14_stack! -1
            SET displayMessage=Adding this item to this slot would exceed the stack limit, choose a different slot.
            SET refundItem=true
            GOTO :ATTEMPT_STORE_MENU
        ) ELSE (
            GOTO :EOF
        )
        GOTO :EOF
    ) ELSE (
        REM This slot is occupied by a different item.
        SET displayMessage=This slot is already occupied by a different item.
        GOTO :SELECT_SLOT
    )
) ELSE (
    REM Adds the item to the Player's inventory.
    SET player.inventory_slot_14=%item.to_add%
    SET player.inventory_slot_14_type=%item.to_add_type%
    SET player.inventory_slot_14_stack=1
    SET player.inventory_slot_14_stack_max=%item.to_add_stack_max%
    SET player.inventory_slot_14_attribute=%item.to_add_attribute%
    SET player.inventory_slot_14_avail_enchant=%item.to_add_enchant%
    SET player.inventory_slot_14_damage=%item.to_add_damage%
    GOTO :EOF
)

:ATTEMPT_STORE_15
REM Check if this slot is empty
IF NOT "%player.inventory_slot_15%" == "EMPTY" (
    REM Check if the item the Player is adding is already present in this slot.
    IF "%item.to_add%" == "%player.inventory_slot_15%" (
        REM Add another of this item to the stack of existing items in this slot.
        SET /A player.inventory_slot_15_stack=!player.inventory_slot_15_stack! +1
        IF %player.inventory_slot_15_stack% GTR %player.inventory_slot_15_stack_max% (
            SET /A player.inventory_slot_15_stack=!player.inventory_slot_15_stack! -1
            SET displayMessage=Adding this item to this slot would exceed the stack limit, choose a different slot.
            SET refundItem=true
            GOTO :ATTEMPT_STORE_MENU
        ) ELSE (
            GOTO :EOF
        )
        GOTO :EOF
    ) ELSE (
        REM This slot is occupied by a different item.
        SET displayMessage=This slot is already occupied by a different item.
        GOTO :SELECT_SLOT
    )
) ELSE (
    REM Adds the item to the Player's inventory.
    SET player.inventory_slot_15=%item.to_add%
    SET player.inventory_slot_15_type=%item.to_add_type%
    SET player.inventory_slot_15_stack=1
    SET player.inventory_slot_15_stack_max=%item.to_add_stack_max%
    SET player.inventory_slot_15_attribute=%item.to_add_attribute%
    SET player.inventory_slot_15_avail_enchant=%item.to_add_enchant%
    SET player.inventory_slot_15_damage=%item.to_add_damage%
    GOTO :EOF
)

REM Prevents the Player from wasting money if their inventory is full.
:CHECK_REFUND
IF %refundItem% == "true" (
    SET /A player_coins=!player_coins! +%refundPrice%
    SET refunded=true
    GOTO :EOF
) ELSE (
    REM Prevents the player from wasting all of their money by "buying" an item, entering itemadder and then leaving.
    IF "%itemStored%" == "false" (
        SET /A player_coins=!player_coins! +%refundPrice%
        SET refunded=true
        GOTO :EOF
    ) ELSE (
        GOTO :EOF
    )
)