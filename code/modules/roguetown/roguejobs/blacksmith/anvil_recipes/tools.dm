/datum/anvil_recipe/tools/torch
	name = "5x iron torches (+ coal)"
	req_bar = /obj/item/ingot/iron
	additional_items = list(/obj/item/rogueore/coal)
	created_item = list(/obj/item/flashlight/flare/torch/metal, /obj/item/flashlight/flare/torch/metal, /obj/item/flashlight/flare/torch/metal, /obj/item/flashlight/flare/torch/metal, /obj/item/flashlight/flare/torch/metal)
	i_type = "General"

/datum/anvil_recipe/tools/pan
	name = "Frypan"
	req_bar = /obj/item/ingot/iron
	created_item = /obj/item/cooking/pan
	i_type = "Tools"

/datum/anvil_recipe/tools/keyring
	name = "3x Keyrings"
	req_bar = /obj/item/ingot/iron
	created_item = list(/obj/item/keyring, /obj/item/keyring, /obj/item/keyring)
	i_type = "General"

/datum/anvil_recipe/tools/needle
	name = "5x Iron Sewing Needles"
	req_bar = /obj/item/ingot/iron
	created_item = list(/obj/item/needle, /obj/item/needle, /obj/item/needle, /obj/item/needle, /obj/item/needle)
	i_type = "General"

/datum/anvil_recipe/tools/shovel
	name = "shovel (+2 sticks)"
	req_bar = /obj/item/ingot/iron
	additional_items = list(/obj/item/grown/log/tree/stick,/obj/item/grown/log/tree/stick)
	created_item = /obj/item/rogueweapon/shovel
	i_type = "Tools"

/datum/anvil_recipe/tools/hammer
	name = "hammer (+ stick)"
	req_bar = /obj/item/ingot/iron
	additional_items = list(/obj/item/grown/log/tree/stick)
	created_item = /obj/item/rogueweapon/hammer
	i_type = "Tools"

/datum/anvil_recipe/tools/tongs
	name = "tongs"
	req_bar = /obj/item/ingot/iron
	created_item = /obj/item/rogueweapon/tongs
	i_type = "Tools"

/datum/anvil_recipe/tools/sickle
	name = "sickle (+ stick)"
	req_bar = /obj/item/ingot/iron
	additional_items = list(/obj/item/grown/log/tree/stick)
	created_item = /obj/item/rogueweapon/sickle
	i_type = "Tools"

/datum/anvil_recipe/tools/pick
	name = "pick (+ stick)"
	req_bar = /obj/item/ingot/iron
	additional_items = list(/obj/item/grown/log/tree/stick)
	created_item = /obj/item/rogueweapon/pick
	i_type = "Tools"


/datum/anvil_recipe/tools/hoe
	name = "hoe (+2 sticks)"
	req_bar = /obj/item/ingot/iron
	additional_items = list(/obj/item/grown/log/tree/stick,/obj/item/grown/log/tree/stick)
	created_item = /obj/item/rogueweapon/hoe
	i_type = "Tools"

/datum/anvil_recipe/tools/pitchfork
	name = "pitchfork (+2 sticks)"
	req_bar = /obj/item/ingot/iron
	additional_items = list(/obj/item/grown/log/tree/stick,/obj/item/grown/log/tree/stick)
	created_item = /obj/item/rogueweapon/pitchfork
	i_type = "Tools"

/datum/anvil_recipe/tools/lamptern
	name = "lamptern"
	req_bar = /obj/item/ingot/iron
	created_item = /obj/item/flashlight/flare/torch/lantern
	i_type = "General"

/datum/anvil_recipe/tools/cups
	name = "3x iron cups"
	req_bar = /obj/item/ingot/iron
	created_item = list(/obj/item/reagent_containers/glass/cup, /obj/item/reagent_containers/glass/cup, /obj/item/reagent_containers/glass/cup)
	i_type = "General"

/datum/anvil_recipe/tools/cogiron
	name = "3x cogs"
	req_bar = /obj/item/ingot/iron
	created_item = list(/obj/item/roguegear, /obj/item/roguegear, /obj/item/roguegear)
	i_type = "General"

/datum/anvil_recipe/tools/locks
	name = "5x locks"
	req_bar = /obj/item/ingot/iron
	created_item = list(/obj/item/customlock, /obj/item/customlock, /obj/item/customlock, /obj/item/customlock, /obj/item/customlock)
	i_type = "General"

/datum/anvil_recipe/tools/keys
	name = "5x keys"
	req_bar = /obj/item/ingot/iron
	created_item = list(/obj/item/customblank, /obj/item/customblank, /obj/item/customblank, /obj/item/customblank, /obj/item/customblank)
	i_type = "General"

/datum/anvil_recipe/tools/thresher
	name = "thresher (+stick)"
	req_bar = /obj/item/ingot/iron
	additional_items = list(/obj/item/grown/log/tree/stick)
	created_item = /obj/item/rogueweapon/thresher
	i_type = "Tools"

/datum/anvil_recipe/tools/pot
	name = "pot"
	req_bar = /obj/item/ingot/iron
	created_item = /obj/item/reagent_containers/glass/pot //weird how it's a child of glass but whatevs
	i_type = "Tools"

// --------- STEEL -----------

/datum/anvil_recipe/tools/steelpick
	name = "steel pick (+ stick)"
	req_bar = /obj/item/ingot/steel
	additional_items = list(/obj/item/grown/log/tree/stick)
	created_item = /obj/item/rogueweapon/pick/steel
	i_type = "Tools"

/datum/anvil_recipe/tools/cupssteel
	name = "3x steel goblets"
	req_bar = /obj/item/ingot/steel
	created_item = list(/obj/item/reagent_containers/glass/cup/steel, /obj/item/reagent_containers/glass/cup/steel, /obj/item/reagent_containers/glass/cup/steel)
	i_type = "General"


/datum/anvil_recipe/tools/cogstee
	name = "3x cogs"
	req_bar = /obj/item/ingot/steel
	created_item = list(/obj/item/roguegear, /obj/item/roguegear, /obj/item/roguegear)
	i_type = "General"


// --------- SILVER -----------

/datum/anvil_recipe/tools/cupssil
	name = "3x silver goblets"
	req_bar = /obj/item/ingot/silver
	created_item = list(/obj/item/reagent_containers/glass/cup/silver, /obj/item/reagent_containers/glass/cup/silver, /obj/item/reagent_containers/glass/cup/silver)
	i_type = "General"

// --------- GOLD -----------

/datum/anvil_recipe/tools/cupsgold
	name = "3x golden goblets"
	req_bar = /obj/item/ingot/gold
	created_item = list(/obj/item/reagent_containers/glass/cup/golden, /obj/item/reagent_containers/glass/cup/golden, /obj/item/reagent_containers/glass/cup/golden)
	i_type = "General"
