
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
		/obj/item/storage/belt/rogue/leather/rope = 1,
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
	lootcount = 5


///////////////////////
///    TOP-LEFT     ///
/// Size: X:26 Y:20 ///
///////////////////////

/obj/effect/landmark/map_load_mark/sewers_topleft
	name = "Sewers Top-Left Section"
	templates = list("sewers_topleft_1", "sewers_topleft_2", "sewers_topleft_3", "sewers_topleft_4")

/// Little prison
/datum/map_template/sewers_topleft_1
	name = "Sewers Top-Left Variant 1"
	id = "sewers_topleft_1"
	mappath = "_maps/map_files/templates/sewers/sewers_topleft_1.dmm"

///  Abandoned warehouse
/datum/map_template/sewers_topleft_2
	name = "Sewers Top-Left Variant 2"
	id = "sewers_topleft_2"
	mappath = "_maps/map_files/templates/sewers/sewers_topleft_2.dmm"

/// Beggar base
/datum/map_template/sewers_topleft_3
	name = "Sewers Top-Left Variant 3"
	id = "sewers_topleft_3"
	mappath = "_maps/map_files/templates/sewers/sewers_topleft_3.dmm"

/// More sewer tunnels
/datum/map_template/sewers_topleft_4
	name = "Sewers Top-Left Variant 4"
	id = "sewers_topleft_4"
	mappath = "_maps/map_files/templates/sewers/sewers_topleft_4.dmm"

///////////////////////
///   BOTTOM-LEFT   ///
/// Size: X:26 Y:18 ///
///////////////////////

/obj/effect/landmark/map_load_mark/sewers_bottomleft
	name = "Sewers Bottom-Left Section"
	templates = list("sewers_bottomleft_1", "sewers_bottomleft_2", "sewers_bottomleft_3")

/// Flooded large room
/datum/map_template/sewers_bottomleft_1
	name = "Sewers Bottom-Left Variant 1"
	id = "sewers_bottomleft_1"
	mappath = "_maps/map_files/templates/sewers/sewers_bottomleft_1.dmm"

///  Metalworking area
/datum/map_template/sewers_bottomleft_2
	name = "Sewers Bottom-Left Variant 2"
	id = "sewers_bottomleft_2"
	mappath = "_maps/map_files/templates/sewers/sewers_bottomleft_2.dmm"

/// More sewer tunnels
/datum/map_template/sewers_bottomleft_3
	name = "Sewers Bottom-Left Variant 3"
	id = "sewers_bottomleft_3"
	mappath = "_maps/map_files/templates/sewers/sewers_bottomleft_3.dmm"

///////////////////////
///     CENTRE      ///
/// Size: X:14 Y:21 ///
///////////////////////

/obj/effect/landmark/map_load_mark/sewers_centre
	name = "Sewers Centre Section"
	templates = list("sewers_centre_1", "sewers_centre_2")

/// More sewer tunnels
/datum/map_template/sewers_centre_1
	name = "Sewers Centre Variant 1"
	id = "sewers_centre_1"
	mappath = "_maps/map_files/templates/sewers/sewers_centre_1.dmm"

/// Small rooms
/datum/map_template/sewers_centre_2
	name = "Sewers Centre Variant 2"
	id = "sewers_centre_2"
	mappath = "_maps/map_files/templates/sewers/sewers_centre_2.dmm"


///////////////////////
///     BOTTOM      ///
/// Size: X:15 Y:5  ///
///////////////////////

/obj/effect/landmark/map_load_mark/sewers_bottom
	name = "Sewers Bottom Section"
	templates = list("sewers_bottom_1", "sewers_bottom_2")

/// Small hobo camp
/datum/map_template/sewers_bottom_1
	name = "Sewers Centre Variant 1"
	id = "sewers_bottom_1"
	mappath = "_maps/map_files/templates/sewers/sewers_bottom_1.dmm"

/// Small side ruin
/datum/map_template/sewers_bottom_2
	name = "Sewers Bottom Variant 2"
	id = "sewers_bottom_2"
	mappath = "_maps/map_files/templates/sewers/sewers_bottom_2.dmm"

///////////////////////
///   BOTTOM-RIGHT  ///
/// Size: X:19 Y:11 ///
///////////////////////

/obj/effect/landmark/map_load_mark/sewers_bottomright
	name = "Sewers Bottom-Right Section"
	templates = list("sewers_bottomright_1", "sewers_bottomright_2")

/// Cultist hideout
/datum/map_template/sewers_bottomright_1
	name = "Sewers Bottom-Right Variant 1"
	id = "sewers_bottomright_1"
	mappath = "_maps/map_files/templates/sewers/sewers_bottomright_1.dmm"

/// Mortuary
/datum/map_template/sewers_bottomright_2
	name = "Sewers Bottom-Right Variant 2"
	id = "sewers_bottomright_2"
	mappath = "_maps/map_files/templates/sewers/sewers_bottomright_2.dmm"


///////////////////////
///      RIGHT      ///
/// Size: X:5 Y:8   ///
///////////////////////

/obj/effect/landmark/map_load_mark/sewers_right
	name = "Sewers Right Section"
	templates = list("sewers_right_1", "sewers_right_2")

/// Small hobo camp
/datum/map_template/sewers_right_1
	name = "Sewers Right Variant 1"
	id = "sewers_right_1"
	mappath = "_maps/map_files/templates/sewers/sewers_right_1.dmm"

/// Skeleton closet
/datum/map_template/sewers_right_2
	name = "Sewers Right Variant 2"
	id = "sewers_right_2"
	mappath = "_maps/map_files/templates/sewers/sewers_right_2.dmm"


///////////////////////
///      TOP        ///
/// Size: X:13 Y:11 ///
///////////////////////

/obj/effect/landmark/map_load_mark/sewers_top
	name = "Sewers Top Section"
	templates = list("sewers_top_1", "sewers_top_2")

/// More tunnels
/datum/map_template/sewers_top_1
	name = "Sewers Top Variant 1"
	id = "sewers_top_1"
	mappath = "_maps/map_files/templates/sewers/sewers_top_1.dmm"

/// Pipe room
/datum/map_template/sewers_top_2
	name = "Sewers Top Variant 2"
	id = "sewers_top_2"
	mappath = "_maps/map_files/templates/sewers/sewers_top_2.dmm"
