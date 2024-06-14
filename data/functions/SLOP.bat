@ECHO OFF
TITLE (SLoP) - Intialization
REM A.K.A: Save, Load, order (and initialization) Program

REM Hard coded variables. These values either need to be reset often, or are values pertaining to an item.
:BASE_SET
SET cactusA_p=3
SET guardA_p=5
SET stoneA_p=7
SET steelA_p=9
SET scaledA_p=15
SET ironArmor_prot=8
SET leatherArmor_prot=4
SET silverArmor_prot=10
SET goldArmor_prot=12
SET longsword_d=8
SET shortsword_d=6
SET mace_d=12
SET greataxe_d=17
SET poison_damage=4
SET CE7CALL=0
REM NPC Data
SET CB_HEL=100
SET CB_DMG=8
SET CB_STM=100
SET CB_MGK=200
SET GM_HEL=120
SET GM_DMG=4
SET GM_STM=200
SET GM_MGK=100
SET GA_HEL=175
SET GA_DMG=13
SET GA_STM=145
SET GA_MGK=50

REM Default inventory grid.
SET player.inventory_slot_1=EMPTY
SET player.inventory_slot_2=EMPTY
SET player.inventory_slot_3=EMPTY
SET player.inventory_slot_4=EMPTY
SET player.inventory_slot_5=EMPTY
SET player.inventory_slot_6=EMPTY
SET player.inventory_slot_7=EMPTY
SET player.inventory_slot_8=EMPTY
SET player.inventory_slot_9=EMPTY
SET player.inventory_slot_10=EMPTY
SET player.inventory_slot_11=EMPTY
SET player.inventory_slot_12=EMPTY
SET player.inventory_slot_13=EMPTY
SET player.inventory_slot_14=EMPTY
SET player.inventory_slot_15=EMPTY
REM Default inventory item stack size.
SET player.inventory_slot_1_stack=0
SET player.inventory_slot_2_stack=0
SET player.inventory_slot_3_stack=0
SET player.inventory_slot_4_stack=0
SET player.inventory_slot_5_stack=0
SET player.inventory_slot_6_stack=0
SET player.inventory_slot_7_stack=0
SET player.inventory_slot_8_stack=0
SET player.inventory_slot_9_stack=0
SET player.inventory_slot_10_stack=0
SET player.inventory_slot_11_stack=0
SET player.inventory_slot_12_stack=0
SET player.inventory_slot_13_stack=0
SET player.inventory_slot_14_stack=0
SET player.inventory_slot_15_stack=0

REM Check SLoPr for the desired action.
:callCheck
IF %SLOPr% == SAVE (
    GOTO :saveData
) ELSE IF %SLOPr% == LOAD (
    GOTO :loadData
) ELSE IF %SLOPr% == INIT (
    GOTO :PLAYER_INIT_STATS
) ELSE (
    SET errorType=checkTime
    CALL "%cd%\data\functions\errorhandling.bat"
    EXIT /B
)

REM Saves Player & Merchant data.
:saveData
(
ECHO %player_name%
ECHO %player_health%
ECHO %player_stamina%
ECHO %player_magicka%
ECHO %player_damage%
ECHO %player_armor%
ECHO %player_class%
ECHO %player_coins%
ECHO %player_xp%
ECHO %player_lunis%
ECHO %player_level%
ECHO %player_class_ability%
ECHO %player_stamina_max%
ECHO %player_magicka_max%
ECHO %player_health_max%
ECHO %player_weapon_type%
ECHO %player_armor_equip%
ECHO %player_stamina_equip%
ECHO %player_damage_skill%
ECHO %player_stamina_skill%
ECHO %player_magicka_skill%
ECHO %player_speech_skill%
ECHO %player_reputation%
ECHO %player_ruins_unlocked%
ECHO %player_last_location%
ECHO %follower_name%
ECHO %follower_level%
ECHO %follower_health%
ECHO %follower_damage_skill%
ECHO %follower_stamina_skill%
ECHO %follower_magicka_skill%
ECHO %follower_attack%
ECHO %follower_stamina%
ECHO %follower_magicka%
ECHO %PARTY_SLOT_1%
ECHO %follower_occupation%
ECHO %gary_morcant_added_party%
ECHO %gabrial_aberdeen_added_party%
ECHO %clarke_blackwell_added_party%
ECHO %player_longSword_owned%
ECHO %player_shortSword_owned%
ECHO %player_greatAxe_owned%
ECHO %player_mace_owned%
ECHO %player_woodenBow_owned%
ECHO %player_cactusA_owned%
ECHO %player_stoneA_owned%
ECHO %player_steelA_owned%
ECHO %player_scaledA_owned%
ECHO %player_guardA_owned%
ECHO %player_ironA_owned%
ECHO %player_leatherA_owned%
ECHO %player_silverA_owned%
ECHO %player_goldA_owned%
ECHO %player_bRobes_owned%
ECHO %player_iRobes_owned%
ECHO %player_aRobes_owned%
ECHO %player_bronze_buckler_owned%
ECHO %player_kite_shield_owned%
ECHO %player_healingT_owned%
ECHO %player_staminaT_owned%
ECHO %player_magickaT_owned%
ECHO %player_stunT_owned%
ECHO %player_weapon_equipped%
ECHO %player_shield_equipped%
ECHO %player_armor_equipped%
ECHO %player_travelerJournal_owned%
ECHO %player_merchantGuide_owned%
ECHO %player_guide_to_blades_owned%
ECHO %player_travelerJournal_read%
ECHO %player_merchantGuide_read%
ECHO %player_guide_to_blades_read%
ECHO %blacksmith_longSword_price%
ECHO %blacksmith_shortSword_price%
ECHO %blacksmith_greatAxe_price%
ECHO %blacksmith_mace_price%
ECHO %blacksmith_woodenBow_price%
ECHO %blacksmith_longSword_price%
ECHO %blacksmith_shortSword_price%
ECHO %blacksmith_greatAxe_price%
ECHO %blacksmith_mace_price%
ECHO %blacksmith_woodenBow_price%
ECHO %blacksmith_longSword_stock%
ECHO %blacksmith_shortSword_stock%
ECHO %blacksmith_greatAxe_stock%
ECHO %blacksmith_mace_stock%
ECHO %blacksmith_woodenBow_stock%
ECHO %lorekeeper_travelerJournal_price%
ECHO %lorekeeper_merchantGuide_price%
ECHO %lorekeeper_guide_To_Blades_price%
ECHO %lorekeeper_ruinsmap_price%
ECHO %lorekeeper_travelerJournal_stock%
ECHO %lorekeeper_merchantGuide_stock%
ECHO %lorekeeper_guideToBlades_stock%
ECHO %lorekeeper_ruinsMap_stock%
ECHO %alchemist_healthTonic_price%
ECHO %alchemist_staminaTonic_price%
ECHO %alchemist_magickaTonic_price%
ECHO %alchemist_healthTonic_stock%
ECHO %alchemist_staminaTonic_stock%
ECHO %alchemist_magickaTonic_stock%
ECHO %wizard_basicRobes_price%
ECHO %wizard_intermediateRobes_price%
ECHO %wizard_advancedRobes_price%
ECHO %wizard_basicRobes_stock%
ECHO %wizard_intermediateRobes_stock%
ECHO %wizard_advancedRobes_stock%
ECHO %armorer_cactusArmor_price%
ECHO %armorer_stoneArmor_price%
ECHO %armorer_steelArmor_price%
ECHO %armorer_scaledArmor_price%
ECHO %armorer_ironArmor_price%
ECHO %armorer_leatherArmor_price%
ECHO %armorer_silverArmor_price%
ECHO %armorer_goldArmor_price%
ECHO %armorer_cactusArmor_stock%
ECHO %armorer_stoneArmor_stock%
ECHO %armorer_steelArmor_stock%
ECHO %armorer_scaledArmor_stock%
ECHO %armorer_ironArmor_stock%
ECHO %armorer_leatherArmor_stock%
ECHO %armorer_silverArmor_stock%
ECHO %armorer_goldArmor_stock%
)>"%cd%\data\player\savedata.txt"
GOTO :EOF

REM Loads Player stats.
:loadData
(
SET /P player_name=
SET /P player_health=
SET /P player_stamina=
SET /P player_magicka=
SET /P player_damage=
SET /P player_armor=
SET /P player_class=
SET /P player_coins=
SET /P player_xp=
SET /P player_lunis=
SET /P player_level=
SET /P player_class_ability=
SET /P player_stamina_max=
SET /P player_magicka_max=
SET /P player_health_max=
SET /P player_weapon_type=
SET /P player_armor_equip=
SET /P player_stamina_equip=
SET /P player_damage_skill=
SET /P player_stamina_skill=
SET /P player_magicka_skill=
SET /P player_speech_skill=
SET /P player_reputation=
SET /P player_ruins_unlocked=
SET /P player_last_location=
SET /P follower_name=
SET /P follower_level=
SET /P follower_health=
SET /P follower_damage_skill=
SET /P follower_stamina_skill=
SET /P follower_magicka_skill=
SET /P follower_attack=
SET /P follower_stamina=
SET /P follower_magicka=
SET /P PARTY_SLOT_1=
SET /P follower_occupation=
SET /P gary_morcant_added_party=
SET /P gabrial_aberdeen_added_party=
SET /P clarke_blackwell_added_party=
SET /P player_longSword_owned=
SET /P player_shortSword_owned=
SET /P player_greatAxe_owned=
SET /P player_mace_owned=
SET /P player_woodenBow_owned=
SET /P player_cactusA_owned=
SET /P player_stoneA_owned=
SET /P player_steelA_owned=
SET /P player_scaledA_owned=
SET /P player_guardA_owned=
SET /P player_ironA_owned=
SET /P player_leatherA_owned=
SET /P player_silverA_owned=
SET /P player_goldA_owned=
SET /P player_bRobes_owned=
SET /P player_iRobes_owned=
SET /P player_aRobes_owned=
SET /P player_bronze_buckler_owned=
SET /P player_kite_shield_owned=
SET /P player_healingT_owned=
SET /P player_staminaT_owned=
SET /P player_magickaT_owned=
SET /P player_stunT_owned=
SET /P player_weapon_equipped=
SET /P player_shield_equipped=
SET /P player_armor_equipped=
SET /P player_travelerJournal_owned=
SET /P player_merchantGuide_owned=
SET /P player_guide_to_blades_owned=
SET /P player_travelerJournal_read=
SET /P player_merchantGuide_read=
SET /P player_guide_to_blades_read=
SET /P blacksmith_longSword_price=
SET /P blacksmith_shortSword_price=
SET /P blacksmith_greatAxe_price=
SET /P blacksmith_mace_price=
SET /P blacksmith_woodenBow_price=
SET /P blacksmith_longSword_price=
SET /P blacksmith_shortSword_price=
SET /P blacksmith_greatAxe_price=
SET /P blacksmith_mace_price=
SET /P blacksmith_woodenBow_price=
SET /P blacksmith_longSword_stock=
SET /P blacksmith_shortSword_stock=
SET /P blacksmith_greatAxe_stock=
SET /P blacksmith_mace_stock=
SET /P blacksmith_woodenBow_stock=
SET /P lorekeeper_travelerJournal_price=
SET /P lorekeeper_merchantGuide_price=
SET /P lorekeeper_guide_To_Blades_price=
SET /P lorekeeper_ruinsmap_price=
SET /P lorekeeper_travelerJournal_stock=
SET /P lorekeeper_merchantGuide_stock=
SET /P lorekeeper_guideToBlades_stock=
SET /P lorekeeper_ruinsMap_stock=
SET /P alchemist_healthTonic_price=
SET /P alchemist_staminaTonic_price=
SET /P alchemist_magickaTonic_price=
SET /P alchemist_healthTonic_stock=
SET /P alchemist_staminaTonic_stock=
SET /P alchemist_magickaTonic_stock=
SET /P wizard_basicRobes_price=
SET /P wizard_intermediateRobes_price=
SET /P wizard_advancedRobes_price=
SET /P wizard_basicRobes_stock=
SET /P wizard_intermediateRobes_stock=
SET /P wizard_advancedRobes_stock=
SET /P armorer_cactusArmor_price=
SET /P armorer_stoneArmor_price=
SET /P armorer_steelArmor_price=
SET /P armorer_scaledArmor_price=
SET /P armorer_ironArmor_price=
SET /P armorer_leatherArmor_price=
SET /P armorer_silverArmor_price=
SET /P armorer_goldArmor_price=
SET /P armorer_cactusArmor_stock=
SET /P armorer_stoneArmor_stock=
SET /P armorer_steelArmor_stock=
SET /P armorer_scaledArmor_stock=
SET /P armorer_ironArmor_stock=
SET /P armorer_leatherArmor_stock=
SET /P armorer_silverArmor_stock=
SET /P armorer_goldArmor_stock=
)<"%cd%\data\player\savedata.txt"
GOTO :EOF

REM Runs when a new game is started to generate needed variables.
:PLAYER_INIT_STATS
SET player_health=100
SET player_stamina=100
SET player_magicka=100
SET player_damage=5
SET player_armor=0
SET player_class=None
SET player_coins=0
SET player_xp=0
SET player_lunis=0
SET player_level=1
SET player_class_ability=none
SET player_stamina_max=100
SET player_magicka_max=100
SET player_health_max=100
SET player_weapon_type=Melee
REM Functions exactly like the old EAV variable, it's just the armor value.
SET player_armor_equip=0
REM Functions like the armor variable, but for Stamina. When I have "equipped" items implemented better in the future, probably wont need this variable, but for now it is needed.
SET player_stamina_equip=0
REM Skills and other important "social" variables.
SET player_damage_skill=2
SET player_stamina_skill=2
SET player_magicka_skill=2
SET player_speech_skill=2
SET player_reputation=2
REM Location unlocks
SET player_ruins_unlocked=0
REM Player positions
SET player_last_location=WP
REM Set default Party information.
SET follower_name=VACANT
SET follower_level=0
SET follower_health=0
REM Party member skill XP, currently only supports damage, stamina and magicka.
SET follower_damage_skill=0
SET follower_stamina_skill=0
SET follower_magicka_skill=0
SET follower_attack=0
SET follower_stamina=0
SET follower_magicka=0
SET PARTY_SLOT_1=0
REM The associated party member's "occupation".
SET follower_occupation=NONE
REM Prevent the Player from encountering an NPC they have in their party.
SET gary_morcant_added_party=false
SET gabrial_aberdeen_added_party=false
SET clarke_blackwell_added_party=false
GOTO :PLAYER_INIT_INVENTORY

REM Creates empty inventory slots
:PLAYER_INIT_INVENTORY
REM Create weapons owned values.
SET player_longSword_owned=0
SET player_shortSword_owned=0
SET player_greatAxe_owned=0
SET player_mace_owned=0
SET player_woodenBow_owned=0
REM Create armor owned values.
SET player_cactusA_owned=0
SET player_stoneA_owned=0
SET player_steelA_owned=0
SET player_scaledA_owned=0
SET player_guardA_owned=0
SET player_ironA_owned=0
SET player_leatherA_owned=0
SET player_silverA_owned=0
SET player_goldA_owned=0
SET player_bRobes_owned=0
SET player_iRobes_owned=0
SET player_aRobes_owned=0
REM Create shields owned values.
SET player_bronze_buckler_owned=0
SET player_kite_shield_owned=0
REM Create Tonics owned values.
SET player_healingT_owned=0
SET player_staminaT_owned=0
SET player_magickaT_owned=0
SET player_stunT_owned=0
REM Equip slots
SET player_weapon_equipped=EMPTY
SET player_shield_equipped=EMPTY
SET player_armor_equipped=EMPTY
REM GENERAL INVENTORY ITEMS, SUCH AS BOOKS & SCROLLS.
SET player_travelerJournal_owned=0
SET player_merchantGuide_owned=0
SET player_guide_to_blades_owned=0
REM Has the skill scroll/book been read?
SET player_travelerJournal_read=0
SET player_merchantGuide_read=0
SET player_guide_to_blades_read=0
GOTO :INIT_MERCHANTS

REM Setup Merchant inventories & Prices
:INIT_MERCHANTS
REM Blacksmith Shop Base Prices.
SET blacksmith_longSword_price=220
SET blacksmith_shortSword_price=190
SET blacksmith_greatAxe_price=700
SET blacksmith_mace_price=283
SET blacksmith_woodenBow_price=122
REM Blacksmith Sellback Prices.
SET blacksmith_longSword_price=190
SET blacksmith_shortSword_price=140
SET blacksmith_greatAxe_price=500
SET blacksmith_mace_price=215
SET blacksmith_woodenBow_price=80
REM Blacksmith Shop Stock.
SET blacksmith_longSword_stock=6
SET blacksmith_shortSword_stock=4
SET blacksmith_greatAxe_stock=5
SET blacksmith_mace_stock=5
SET blacksmith_woodenBow_stock=2
REM Lorekeeper Shop Base Prices.
SET lorekeeper_travelerJournal_price=80
SET lorekeeper_merchantGuide_price=400
SET lorekeeper_guide_To_Blades_price=700
SET lorekeeper_ruinsmap_price=2000
REM Lorekeeper Shop Item Stock.
SET lorekeeper_travelerJournal_stock=1
SET lorekeeper_merchantGuide_stock=5
SET lorekeeper_guideToBlades_stock=2
SET lorekeeper_ruinsMap_stock=1
REM Alchemist Shop Base Prices.
SET alchemist_healthTonic_price=25
SET alchemist_staminaTonic_price=25
SET alchemist_magickaTonic_price=25
REM Alchemist Item Stock.
SET alchemist_healthTonic_stock=50
SET alchemist_staminaTonic_stock=50
SET alchemist_magickaTonic_stock=50
REM Wizard Shop Base Prices.
SET wizard_basicRobes_price=500
SET wizard_intermediateRobes_price=1200
SET wizard_advancedRobes_price=5000
REM Wizard Shop Item Stock.
SET wizard_basicRobes_stock=10
SET wizard_intermediateRobes_stock=5
SET wizard_advancedRobes_stock=1
REM Armorer Shop Base Prices.
SET armorer_cactusArmor_price=100
SET armorer_stoneArmor_price=200
SET armorer_steelArmor_price=500
SET armorer_scaledArmor_price=1200
SET armorer_ironArmor_price=250
SET armorer_leatherArmor_price=80
SET armorer_silverArmor_price=800
SET armorer_goldArmor_price=850
REM Armorer Shop Item Stock.
SET armorer_cactusArmor_stock=10
SET armorer_stoneArmor_stock=10
SET armorer_steelArmor_stock=10
SET armorer_scaledArmor_stock=4
SET armorer_ironArmor_stock=10
SET armorer_leatherArmor_stock=10
SET armorer_silverArmor_stock=5
SET armorer_goldArmor_stock=6
GOTO :saveData