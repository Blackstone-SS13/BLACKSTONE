//!View bog_shack_small.dm for documentation

/obj/effect/landmark/map_load_mark/smalldungeon
	name = "Small Dungeon"
	templates = list( "smalldungeon1" )

/datum/map_template/smalldungeon1
	name = "Small Dungeon Varient 1"
	id = "smalldungeon1"
	mappath = "_maps/map_files/templates/smalldungeons/smalldungeon1.dmm"

/obj/effect/spawner/lootdrop/roguetown/dungeon
	name = "dungeon spawner"
	loot = list(
		// Materials
		/obj/item/natural/bundle/stick = 2,
		/obj/item/natural/fibers = 4,
		/obj/item/natural/stone = 4,
		/obj/item/rogueore/coal	= 4,
		/obj/item/ingot/iron = 1,
		/obj/item/ingot/steel = 1,
		/obj/item/rogueore/iron = 3,
		/obj/item/natural/bundle/fibers = 2,

		// Clothing
		/obj/item/clothing/cloak/stabard = 3,
		/obj/item/storage/backpack/rogue/satchel = 3,
		/obj/item/clothing/shoes/roguetown/simpleshoes = 4,
		/obj/item/clothing/suit/roguetown/shirt/undershirt/random = 5,
		/obj/item/storage/belt/rogue/leather/cloth = 4,
		/obj/item/clothing/cloak/raincloak/mortus = 3,
		/obj/item/clothing/head/roguetown/armingcap = 4,
		/obj/item/clothing/cloak/apron/waist = 3,
		/obj/item/storage/belt/rogue/leather/rope = 3,
		/obj/item/clothing/under/roguetown/tights/vagrant = 4,
		/obj/item/clothing/gloves/roguetown/leather = 4,
		/obj/item/clothing/shoes/roguetown/boots = 4,
		/obj/item/clothing/shoes/roguetown/boots/leather = 4,

		// Money
		/obj/item/roguecoin/copper = 5,
		/obj/item/roguecoin/silver = 5,
		/obj/item/roguecoin/gold = 5,
		/obj/item/roguecoin/copper/pile = 3,
		/obj/item/roguecoin/silver/pile = 2,
		/obj/item/roguecoin/gold/pile = 1,

		// Garbage and Miscellanous
		/obj/item/rogue/instrument/flute = 3,
		/obj/item/ash = 5,
		/obj/item/shard = 5,
		/obj/item/candle/yellow = 3,
		/obj/item/flashlight/flare/torch = 3,
		/obj/item/reagent_containers/glass/bowl = 4,
		/obj/item/reagent_containers/glass/cup = 4,
		/obj/item/reagent_containers/glass/cup/wooden = 4,
		/obj/item/reagent_containers/glass/cup/steel = 3,
		/obj/item/reagent_containers/glass/cup/golden = 1,
		/obj/item/reagent_containers/glass/cup/skull = 1,
		/obj/item/reagent_containers/glass/bucket/wooden = 3,
		/obj/item/natural/feather = 4,
		/obj/item/paper/scroll = 3,
		/obj/item/rope = 3,
		/obj/item/rope/chain = 3,
		/obj/item/storage/roguebag/crafted = 3,
		/obj/item/clothing/mask/cigarette/pipe = 3,
		/obj/item/paper = 3,
		/obj/item/reagent_containers/glass/bowl = 3,
		/obj/item/storage/bag/tray = 3,

		//medical
		/obj/item/needle = 4,
		/obj/item/natural/cloth = 5,
		/obj/item/natural/bundle/cloth = 3,

		//weapons
		/obj/item/rogueweapon/mace = 2,
		/obj/item/rogueweapon/huntingknife/idagger/steel = 3,
		/obj/item/gun/ballistic/revolver/grenadelauncher/bow = 2,
		/obj/item/gun/ballistic/revolver/grenadelauncher/crossbow = 2,
		/obj/item/ammo_casing/caseless/rogue/arrow = 4,
		/obj/item/ammo_casing/caseless/rogue/bolt = 4,
		/obj/item/rogueweapon/mace/woodclub/crafted = 3,
		/obj/item/rogueweapon/mace/cudgel = 2,
		/obj/item/rogueweapon/mace/wsword = 3,
		/obj/item/rogueweapon/huntingknife = 3,
		/obj/item/rogueweapon/huntingknife/stoneknife = 3,
		/obj/item/rogueweapon/halberd = 1,
		/obj/item/rogueweapon/woodstaff = 3,
		/obj/item/rogueweapon/spear = 1,

		// tools
		/obj/item/rogueweapon/shovel = 3,
		/obj/item/rogueweapon/thresher = 3,
		/obj/item/flint = 4,
		/obj/item/rogueweapon/stoneaxe/woodcut = 3,
		/obj/item/rogueweapon/stoneaxe = 3,
		/obj/item/rogueweapon/hammer = 3,
		/obj/item/rogueweapon/tongs = 3,
		/obj/item/rogueweapon/pick = 3,

		//armor
		/obj/item/clothing/suit/roguetown/armor/leather/studded = 2,
		/obj/item/clothing/suit/roguetown/armor/gambeson = 2,
		/obj/item/clothing/under/roguetown/chainlegs = 2,
		/obj/item/clothing/gloves/roguetown/chain = 2,
		/obj/item/clothing/suit/roguetown/armor/chainmail = 1,
		/obj/item/clothing/suit/roguetown/armor/chainmail/iron = 2,
		/obj/item/clothing/neck/roguetown/gorget = 1,
		/obj/item/clothing/suit/roguetown/armor/plate/half/iron = 1,
		/obj/item/clothing/head/roguetown/helmet/kettle = 1,
		/obj/item/clothing/head/roguetown/helmet/leather = 2,
		/obj/item/clothing/head/roguetown/helmet/horned = 1,
		/obj/item/clothing/head/roguetown/helmet/skullcap = 1,
		/obj/item/clothing/head/roguetown/helmet/winged = 1,


		//food
		/obj/item/reagent_containers/food/snacks/rogue/crackers = 3,
		/obj/item/reagent_containers/food/snacks/butterslice = 3,
		/obj/item/reagent_containers/powder/flour/salt = 3,
		/obj/item/reagent_containers/food/snacks/egg = 3,

	)
	lootcount = 1

/obj/effect/spawner/lootdrop/roguetown/dungeon/materials
	loot = list(
		// Materials
		/obj/item/natural/bundle/stick = 2,
		/obj/item/natural/fibers = 4,
		/obj/item/natural/stone = 4,
		/obj/item/rogueore/coal	= 4,
		/obj/item/ingot/iron = 1,
		/obj/item/ingot/steel = 1,
		/obj/item/rogueore/iron = 3,
		/obj/item/natural/bundle/fibers = 2
		)
	lootcount = 2

/obj/effect/spawner/lootdrop/roguetown/dungeon/clothing
	loot = list(
		// Clothing
		/obj/item/clothing/cloak/stabard = 3,
		/obj/item/storage/backpack/rogue/satchel = 3,
		/obj/item/clothing/shoes/roguetown/simpleshoes = 4,
		/obj/item/clothing/suit/roguetown/shirt/undershirt/random = 5,
		/obj/item/storage/belt/rogue/leather/cloth = 4,
		/obj/item/clothing/cloak/raincloak/mortus = 3,
		/obj/item/clothing/head/roguetown/armingcap = 4,
		/obj/item/clothing/cloak/apron/waist = 3,
		/obj/item/storage/belt/rogue/leather/rope = 3,
		/obj/item/clothing/under/roguetown/tights/vagrant = 4,
		/obj/item/clothing/gloves/roguetown/leather = 4,
		/obj/item/clothing/shoes/roguetown/boots = 4,
		/obj/item/clothing/shoes/roguetown/boots/leather = 4
	)
	lootcount = 1

/obj/effect/spawner/lootdrop/roguetown/dungeon/money
	loot = list(
		// Money
		/obj/item/roguecoin/copper = 5,
		/obj/item/roguecoin/silver = 5,
		/obj/item/roguecoin/gold = 5,
		/obj/item/roguecoin/copper/pile = 3,
		/obj/item/roguecoin/silver/pile = 2,
		/obj/item/roguecoin/gold/pile = 1
	)
	lootcount = 2

/obj/effect/spawner/lootdrop/roguetown/dungeon/misc
	loot = list(
		// Garbage and Miscellanous
		/obj/item/rogue/instrument/flute = 3,
		/obj/item/ash = 5,
		/obj/item/shard = 5,
		/obj/item/candle/yellow = 3,
		/obj/item/flashlight/flare/torch = 3,
		/obj/item/reagent_containers/glass/bowl = 4,
		/obj/item/reagent_containers/glass/cup = 4,
		/obj/item/reagent_containers/glass/cup/wooden = 4,
		/obj/item/reagent_containers/glass/cup/steel = 3,
		/obj/item/reagent_containers/glass/cup/golden = 1,
		/obj/item/reagent_containers/glass/cup/skull = 1,
		/obj/item/reagent_containers/glass/bucket/wooden = 3,
		/obj/item/natural/feather = 4,
		/obj/item/paper/scroll = 3,
		/obj/item/rope = 3,
		/obj/item/rope/chain = 3,
		/obj/item/storage/roguebag/crafted = 3,
		/obj/item/clothing/mask/cigarette/pipe = 3,
		/obj/item/paper = 3,
		/obj/item/reagent_containers/glass/bowl = 3,
		/obj/item/storage/bag/tray = 3
	)
	lootcount = 1

/obj/effect/spawner/lootdrop/roguetown/dungeon/medical
	loot = list(
		//medical
		/obj/item/needle = 4,
		/obj/item/natural/cloth = 5,
		/obj/item/natural/bundle/cloth = 3
	)
	lootcount = 2

/obj/effect/spawner/lootdrop/roguetown/dungeon/weapons
	loot = list(
		//weapons
		/obj/item/rogueweapon/mace = 2,
		/obj/item/rogueweapon/huntingknife/idagger/steel = 3,
		/obj/item/gun/ballistic/revolver/grenadelauncher/bow = 2,
		/obj/item/gun/ballistic/revolver/grenadelauncher/crossbow = 2,
		/obj/item/ammo_casing/caseless/rogue/arrow = 4,
		/obj/item/ammo_casing/caseless/rogue/bolt = 4,
		/obj/item/rogueweapon/mace/woodclub/crafted = 3,
		/obj/item/rogueweapon/mace/cudgel = 2,
		/obj/item/rogueweapon/mace/wsword = 3,
		/obj/item/rogueweapon/huntingknife = 3,
		/obj/item/rogueweapon/huntingknife/stoneknife = 3,
		/obj/item/rogueweapon/halberd = 1,
		/obj/item/rogueweapon/woodstaff = 3,
		/obj/item/rogueweapon/spear = 1
	)
	lootcount = 1

/obj/effect/spawner/lootdrop/roguetown/dungeon/tools
	loot = list(
		// tools
		/obj/item/rogueweapon/shovel = 3,
		/obj/item/rogueweapon/thresher = 3,
		/obj/item/flint = 4,
		/obj/item/rogueweapon/stoneaxe/woodcut = 3,
		/obj/item/rogueweapon/stoneaxe = 3,
		/obj/item/rogueweapon/hammer = 3,
		/obj/item/rogueweapon/tongs = 3,
		/obj/item/rogueweapon/pick = 3
	)
	lootcount = 1

/obj/effect/spawner/lootdrop/roguetown/dungeon/armor
	loot = list(
		//armor
		/obj/item/clothing/suit/roguetown/armor/leather/studded = 2,
		/obj/item/clothing/suit/roguetown/armor/gambeson = 2,
		/obj/item/clothing/under/roguetown/chainlegs = 2,
		/obj/item/clothing/gloves/roguetown/chain = 2,
		/obj/item/clothing/suit/roguetown/armor/chainmail = 1,
		/obj/item/clothing/suit/roguetown/armor/chainmail/iron = 2,
		/obj/item/clothing/neck/roguetown/gorget = 1,
		/obj/item/clothing/suit/roguetown/armor/plate/half/iron = 1,
		/obj/item/clothing/head/roguetown/helmet/kettle = 1,
		/obj/item/clothing/head/roguetown/helmet/leather = 2,
		/obj/item/clothing/head/roguetown/helmet/horned = 1,
		/obj/item/clothing/head/roguetown/helmet/skullcap = 1,
		/obj/item/clothing/head/roguetown/helmet/winged = 1
	)
	lootcount = 1

/obj/effect/spawner/lootdrop/roguetown/dungeon/food
	loot = list(
		//food
		/obj/item/reagent_containers/food/snacks/rogue/crackers = 3,
		/obj/item/reagent_containers/food/snacks/butterslice = 3,
		/obj/item/reagent_containers/powder/flour/salt = 3,
		/obj/item/reagent_containers/food/snacks/egg = 3
	)
	lootcount = 2

/obj/effect/spawner/lootdrop/roguetown/dungeon/spells
	loot = list(
		//spells
		/obj/item/book/granter/spell/blackstone/fireball = 3,
		/obj/item/book/granter/spell/blackstone/greaterfireball = 2,
		/obj/item/book/granter/spell/blackstone/lightning = 3,
		/obj/item/book/granter/spell/blackstone/fetch = 4,
		/obj/item/book/granter/spell/blackstone/blindness = 1,
		/obj/item/book/granter/spell/blackstone/invisibility = 3,
		/obj/item/book/granter/spell/blackstone/sicknessray = 2,
		/obj/item/book/granter/spell/blackstone/bonechill = 2
	)
	lootcount = 1
