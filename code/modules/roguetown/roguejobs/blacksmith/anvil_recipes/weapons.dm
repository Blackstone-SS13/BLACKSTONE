/datum/anvil_recipe/weapons
	appro_skill = /datum/skill/craft/weaponsmithing  // inheritance yay !!
	craftdiff = 1

/// BASIC WEAPONS

/datum/anvil_recipe/weapons/isword
	name = "Sword"
	req_bar = /obj/item/ingot/iron
	created_item = /obj/item/rogueweapon/sword/iron
	i_type = "Weapons"

/datum/anvil_recipe/weapons/iswordshort
	name = "Short sword"
	req_bar = /obj/item/ingot/iron
	created_item = /obj/item/rogueweapon/sword/iron/short
	i_type = "Weapons"

/datum/anvil_recipe/weapons/imesser
	name = "Messer"
	req_bar = /obj/item/ingot/iron
	created_item = /obj/item/rogueweapon/sword/iron/messer
	i_type = "Weapons"

/datum/anvil_recipe/weapons/idagger
	name = "Dagger"
	req_bar = /obj/item/ingot/iron
	created_item = /obj/item/rogueweapon/huntingknife/idagger
	i_type = "Weapons"

/datum/anvil_recipe/weapons/sdagger
	name = "Dagger"
	req_bar = /obj/item/ingot/steel
	created_item = /obj/item/rogueweapon/huntingknife/idagger/steel
	i_type = "Weapons"

/datum/anvil_recipe/weapons/sidagger
	name = "Dagger"
	req_bar = /obj/item/ingot/silver
	created_item = /obj/item/rogueweapon/huntingknife/idagger/silver
	i_type = "Weapons"

/datum/anvil_recipe/weapons/iflail
	name = "Flail"
	req_bar = /obj/item/ingot/iron
	created_item = /obj/item/rogueweapon/flail
	i_type = "Weapons"

/datum/anvil_recipe/weapons/sflail
	name = "Flail"
	req_bar = /obj/item/ingot/steel
	created_item = /obj/item/rogueweapon/flail/sflail
	i_type = "Weapons"

/datum/anvil_recipe/weapons/ssword
	name = "Sword"
	req_bar = /obj/item/ingot/steel
	created_item = /obj/item/rogueweapon/sword
	i_type = "Weapons"

/datum/anvil_recipe/weapons/sswordshort
	name = "steel short sword"
	appro_skill = /datum/skill/craft/weaponsmithing
	req_bar = /obj/item/ingot/steel
	created_item = /obj/item/rogueweapon/sword/short

/datum/anvil_recipe/weapons/ssaber
	name = "Sabre"
	req_bar = /obj/item/ingot/steel
	created_item = /obj/item/rogueweapon/sword/sabre
	i_type = "Weapons"

/datum/anvil_recipe/weapons/srapier
	name = "Rapier"
	req_bar = /obj/item/ingot/steel
	created_item = /obj/item/rogueweapon/sword/rapier
	i_type = "Weapons"

/datum/anvil_recipe/weapons/scutlass
	name = "Cutlass"
	req_bar = /obj/item/ingot/steel
	created_item = /obj/item/rogueweapon/sword/cutlass
	i_type = "Weapons"

/datum/anvil_recipe/weapons/hknife
	name = "Hunting knife"
	req_bar = /obj/item/ingot/steel
	created_item = /obj/item/rogueweapon/huntingknife
	i_type = "Weapons"

/datum/anvil_recipe/weapons/cleaver
	name = "Cleaver"
	req_bar = /obj/item/ingot/steel
	created_item = /obj/item/rogueweapon/huntingknife/cleaver
	i_type = "Weapons"

/// ADVANCED WEAPONS

/datum/anvil_recipe/weapons/tsword
	name = "Bastard Sword (+1 Steel)"
	req_bar = /obj/item/ingot/steel
	additional_items = list(/obj/item/ingot/steel)
	created_item = /obj/item/rogueweapon/sword/long
	craftdiff = 2
	i_type = "Weapons"

/datum/anvil_recipe/weapons/baxe
	name = "Battle Axe (+1 Steel)"
	req_bar = /obj/item/ingot/steel
	additional_items = list(/obj/item/ingot/steel)
	created_item = /obj/item/rogueweapon/stoneaxe/battle
	craftdiff = 2
	i_type = "Weapons"

/datum/anvil_recipe/weapons/ccleaver
	name = "Hunting Knife (+1 Steel)"
	req_bar = /obj/item/ingot/steel
	additional_items = list(/obj/item/ingot/steel)
	created_item = /obj/item/rogueweapon/huntingknife/cleaver/combat
	craftdiff = 2
	i_type = "Weapons"

/datum/anvil_recipe/weapons/smace
	name = "Mace (+1 Steel)"
	req_bar = /obj/item/ingot/steel
	additional_items = list(/obj/item/ingot/steel)
	created_item = /obj/item/rogueweapon/mace/steel
	craftdiff = 2
	i_type = "Weapons"

/datum/anvil_recipe/weapons/zweihander
	name = "Zweihander (+2 Iron)"
	req_bar = /obj/item/ingot/iron
	additional_items = list(/obj/item/ingot/iron, /obj/item/ingot/iron)
	created_item = /obj/item/rogueweapon/greatsword/zwei
	craftdiff = 3
	i_type = "Weapons"

/datum/anvil_recipe/weapons/greatsword
	name = "Greatsword (+2 Steel)"
	req_bar = /obj/item/ingot/steel
	additional_items = list(/obj/item/ingot/steel, /obj/item/ingot/steel)
	created_item = /obj/item/rogueweapon/greatsword
	craftdiff = 3
	i_type = "Weapons"

/datum/anvil_recipe/weapons/buckler
	name = "Buckler (+1 Steel)"
	req_bar = /obj/item/ingot/steel
	additional_items = list(/obj/item/ingot/steel)
	created_item = /obj/item/rogueweapon/shield/buckler
	craftdiff = 2
	i_type = "Weapons"

/// UPGRADED WEAPONS

//GOLD
/datum/anvil_recipe/weapons/decsword
	name = "Decorated Sword (+1 Gold)"
	req_bar = /obj/item/ingot/steel
	additional_items = list(/obj/item/ingot/gold)
	created_item = /obj/item/rogueweapon/sword/decorated
	craftdiff = 2
	i_type = "Weapons"

/datum/anvil_recipe/weapons/decsword
	name = "Decorated Sword (+1 Steel Sword)"
	req_bar = /obj/item/ingot/gold
	additional_items = list(/obj/item/rogueweapon/sword)
	created_item = /obj/item/rogueweapon/sword/decorated
	craftdiff = 2
	i_type = "Weapons"

/datum/anvil_recipe/weapons/decsaber
	name = "Decorated Sabre (+1 Gold)"
	req_bar = /obj/item/ingot/steel
	additional_items = list(/obj/item/ingot/gold)
	created_item = /obj/item/rogueweapon/sword/sabre/dec
	craftdiff = 2
	i_type = "Weapons"

/datum/anvil_recipe/weapons/decsaber
	name = "Decorated Sabre (+1 Steel Sabre)"
	req_bar = /obj/item/ingot/gold
	additional_items = list(/obj/item/rogueweapon/sword/sabre)
	created_item = /obj/item/rogueweapon/sword/sabre/dec
	craftdiff = 2
	i_type = "Weapons"

/datum/anvil_recipe/weapons/decrapier
	name = "Decorated Rapier (+1 Gold)"
	req_bar = /obj/item/ingot/steel
	additional_items = list(/obj/item/ingot/gold)
	created_item = /obj/item/rogueweapon/sword/rapier/dec
	craftdiff = 2
	i_type = "Weapons"

/datum/anvil_recipe/weapons/decrapier
	name = "Decorated Rapier (+1 Steel Rapier)"
	req_bar = /obj/item/ingot/gold
	additional_items = list(/obj/item/rogueweapon/sword/rapier)
	created_item = /obj/item/rogueweapon/sword/rapier/dec
	craftdiff = 2
	i_type = "Weapons"

// SILVER
/datum/anvil_recipe/weapons/esaber
	name = "Elvish Saber"
	req_bar = /obj/item/ingot/silver
	additional_items = list(/obj/item/ingot/silver)
	created_item = /obj/item/rogueweapon/sword/sabre/elf
	craftdiff = 3
	i_type = "Weapons"

/datum/anvil_recipe/weapons/edagger
	name = "Elvish Dagger"
	req_bar = /obj/item/ingot/silver
	created_item = /obj/item/rogueweapon/huntingknife/elvish
	craftdiff = 3
	i_type = "Weapons"

///STICK HANDLE
/datum/anvil_recipe/weapons/saxe
	name = "Axe (+1 Stick)"
	req_bar = /obj/item/ingot/steel
	additional_items = list(/obj/item/grown/log/tree/stick)
	created_item = /obj/item/rogueweapon/stoneaxe/woodcut/steel
	i_type = "Weapons"

/datum/anvil_recipe/weapons/axe
	name = "Axe (+1 Stick)"
	req_bar = /obj/item/ingot/iron
	additional_items = list(/obj/item/grown/log/tree/stick)
	created_item = /obj/item/rogueweapon/stoneaxe/woodcut
	i_type = "Weapons"

/datum/anvil_recipe/weapons/mace
	name = "Mace (+1 Stick)"
	req_bar = /obj/item/ingot/iron
	additional_items = list(/obj/item/grown/log/tree/stick)
	created_item = /obj/item/rogueweapon/mace
	i_type = "Weapons"

// WOOD HANDLE

/datum/anvil_recipe/weapons/billhook
	name = "Billhook (+1 Small Log)"
	req_bar = /obj/item/ingot/steel
	additional_items = list(/obj/item/grown/log/tree/small)
	created_item = /obj/item/rogueweapon/spear/billhook
	i_type = "Weapons"

/datum/anvil_recipe/weapons/spear
	name = "Spear (+1 Small Log)"
	req_bar = /obj/item/ingot/iron
	additional_items = list(/obj/item/grown/log/tree/small)
	created_item = /obj/item/rogueweapon/spear
	i_type = "Weapons"

/datum/anvil_recipe/weapons/bardiche
	name = "Bardiche (+ iron) (+1 Small Log)"
	req_bar = /obj/item/ingot/iron
	additional_items = list(/obj/item/ingot/iron, /obj/item/grown/log/tree/small)
	created_item = /obj/item/rogueweapon/halberd/bardiche
	craftdiff = 2
	i_type = "Weapons"

/datum/anvil_recipe/weapons/halbert
	name = "Halberd (+1 Steel) (+1 Small Log)"
	req_bar = /obj/item/ingot/steel
	additional_items = list(/obj/item/ingot/steel, /obj/item/grown/log/tree/small)
	created_item = /obj/item/rogueweapon/halberd
	craftdiff = 2
	i_type = "Weapons"

/datum/anvil_recipe/weapons/lucerne
	name = "Lucerne (+ iron) (+1 Small Log)"
	req_bar = /obj/item/ingot/iron
	additional_items = list(/obj/item/ingot/iron, /obj/item/grown/log/tree/small)
	created_item = /obj/item/rogueweapon/eaglebeak/lucerne
	craftdiff = 2
	i_type = "Weapons"

/datum/anvil_recipe/weapons/eaglebeak
	name = "Eagle's Beak (+1 Steel) (+1 Small Log)"
	req_bar = /obj/item/ingot/steel
	additional_items = list(/obj/item/ingot/steel, /obj/item/grown/log/tree/small)
	created_item = /obj/item/rogueweapon/eaglebeak
	craftdiff = 2
	i_type = "Weapons"

/datum/anvil_recipe/weapons/polemace
	name = "Warclub (+1 Small Log)"
	req_bar = /obj/item/ingot/iron
	additional_items = list(/obj/item/grown/log/tree/small)
	created_item = /obj/item/rogueweapon/mace/goden
	i_type = "Weapons"

/datum/anvil_recipe/weapons/grandmace
	name = "Grand Mace (+1 Small Log)"
	req_bar = /obj/item/ingot/steel
	additional_items = list(/obj/item/grown/log/tree/small)
	created_item = /obj/item/rogueweapon/mace/goden/steel
	i_type = "Weapons"

/// SHIELDS
/datum/anvil_recipe/weapons/steelshield
	name = "Heraldic Shield (+1 Steel +1 Hide)"
	appro_skill = /datum/skill/craft/armorsmithing
	req_bar = /obj/item/ingot/steel
	additional_items = list(/obj/item/ingot/steel, /obj/item/natural/hide)
	created_item = /obj/item/rogueweapon/shield/tower/metal
	craftdiff = 2
	i_type = "Weapons"

/datum/anvil_recipe/weapons/ironshield
	name = "Tower Shield (+1 Small Log)"
	appro_skill = /datum/skill/craft/armorsmithing
	req_bar = /obj/item/ingot/iron
	additional_items = list(/obj/item/grown/log/tree/small)
	created_item = /obj/item/rogueweapon/shield/tower
	i_type = "Weapons"

/// CROSSBOWS
/datum/anvil_recipe/weapons/xbow
	name = "Crossbow (+1 Small Log) (+1 Fiber)"
	req_bar = /obj/item/ingot/steel
	additional_items = list(/obj/item/grown/log/tree/small, /obj/item/natural/fibers)
	created_item = /obj/item/gun/ballistic/revolver/grenadelauncher/crossbow
	i_type = "Weapons"

/datum/anvil_recipe/weapons/bolts
	name = "Crossbow Bolts 5x (+1 Stick)"
	req_bar = /obj/item/ingot/iron
	additional_items = list(/obj/item/grown/log/tree/stick)
	created_item = list(/obj/item/ammo_casing/caseless/rogue/bolt, /obj/item/ammo_casing/caseless/rogue/bolt, /obj/item/ammo_casing/caseless/rogue/bolt, /obj/item/ammo_casing/caseless/rogue/bolt, /obj/item/ammo_casing/caseless/rogue/bolt)
	i_type = "Ammo"

/// BOWS
/datum/anvil_recipe/weapons/arrows
	name = "Arrows 5x (+1 Stick)"
	req_bar = /obj/item/ingot/iron
	additional_items = list(/obj/item/grown/log/tree/stick)
	created_item = list(/obj/item/ammo_casing/caseless/rogue/arrow,/obj/item/ammo_casing/caseless/rogue/arrow,/obj/item/ammo_casing/caseless/rogue/arrow, /obj/item/ammo_casing/caseless/rogue/arrow, /obj/item/ammo_casing/caseless/rogue/arrow)
	i_type = "Ammo"

//Rarity
/datum/anvil_recipe/valuables/execution
	name = "Execution Sword (+ 1 Steel, + 1 Iron)"
	req_bar = /obj/item/ingot/steel
	additional_items = list(/obj/item/ingot/iron, /obj/item/ingot/steel)	
	created_item = /obj/item/rogueweapon/sword/long/exe
	i_type = "Weapons"

