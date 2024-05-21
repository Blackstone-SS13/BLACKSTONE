
// TODO: Weight this thing so 90% of stuff is garbage
/obj/effect/spawner/lootdrop/roguetown/sewers
name = "sewer spawner"
	loot = list(


		// Materials
		/obj/item/natural/bundle/stick = 1,

		// Clothing
		/obj/item/clothing/shoes/roguetown/simpleshoes = 1,
		/obj/item/clothing/suit/roguetown/shirt/undershirt/random = 1,
		/obj/item/storage/belt/rogue/leather/cloth = 1,
		/obj/item/clothing/cloak/raincloak/mortus = 1,
		/obj/item/clothing/head/roguetown/armingcap = 1,
		/obj/item/clothing/cloak/apron/waist = 1,
		/obj/item/storage/belt/rogue/leather/roped = 1,
		/obj/item/clothing/under/roguetown/tights/vagrant = 1,

		// Money
		/obj/item/roguecoin/copper = 1,
		/obj/item/roguecoin/silver = 1,
		/obj/item/roguecoin/gold = 1,
		/obj/item/roguecoin/copper/pile = 1,
		/obj/item/roguecoin/silver/pile = 1,
		/obj/item/roguecoin/gold/pile = 1,

		// Garbage and Miscellanous
		/obj/item/candle/yellow = 1,
		/obj/item/flashlight/flare/torch = 1,
		/obj/item/reagent_containers/glass/cup = 1,
		/obj/item/reagent_containers/glass/cup/wooden = 1,
		/obj/item/reagent_containers/glass/cup/steel = 1,
		/obj/item/reagent_containers/glass/cup/silver = 1,
		/obj/item/reagent_containers/glass/cup/golden = 1,
		/obj/item/reagent_containers/glass/cup/skull = 1,
		/obj/item/reagent_containers/glass/bucket/wooden = 1,
		/obj/item/paper/scroll = 1,
		/obj/item/rope/chain = 1,
		/obj/item/storage/roguebag/crafted = 1,
		/obj/item/clothing/mask/cigarette/pipe = 1,
		/obj/item/paper/bsmith = 1,
		/obj/item/reagent_containers/glass/bowl = 1,
		/obj/item/storage/bag/tray = 1,

		//medical
		/obj/item/needle = 1,
		/obj/item/natural/cloth = 1,
		/obj/item/natural/bundle/cloth = 1,

		//weapons
		/obj/item/rogueweapon/stoneaxe = 1,
		/obj/item/rogueweapon/hammer = 1,

		//armor
		/obj/item/clothing/head/roguetown/helmet/kettle = 1,

		//food
	)
	lootcount = 4


///////////////////////
///    TOP-LEFT     ///
/// Size: X:26 Y:20 ///
///////////////////////

/obj/effect/landmark/map_load_mark/sewers_topleft
	name = "Sewers Top-Left Section"
	templates = list("sewers_topleft_2")

/// little prison with some cells and rats
/datum/map_template/sewers_topleft_1
	name = "Sewers Top-Left Variant 1"
	id = "sewers_topleft_1"
	mappath = "_maps/map_files/templates/sewers/sewers_topleft_1.dmm"

///  Abandoned warehouse with crates, barrels, skeletons, CLAUSTROPHOBIC
/datum/map_template/sewers_topleft_2
	name = "Sewers Top-Left Variant 2"
	id = "sewers_topleft_2"
	mappath = "_maps/map_files/templates/sewers/sewers_topleft_2.dmm"

/datum/map_template/sewers_topleft_3
	name = "Sewers Top-Left Variant 3"
	id = "sewers_topleft_3"
	mappath = "_maps/map_files/templates/sewers/sewers_topleft_3.dmm"

//////////////
///TOP-LEFT///
//////////////

