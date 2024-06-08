/datum/crafting_recipe/roguetown
	req_table = FALSE
	tools = list(/obj/item/reagent_containers/glass/mortar, /obj/item/pestle)
	verbage_simple = "mixes"
	skillcraft = /datum/skill/misc/alchemy

/datum/crafting_recipe/roguetown/alchemy/bbomb
	name = "Bottle bomb"
	result = list(/obj/item/bomb)
	reqs = list(/obj/item/reagent_containers/glass/bottle = 1, /obj/item/ash = 2, /obj/item/natural/rock/coal = 1, /obj/item/natural/cloth = 1)
	craftdiff = 2

/datum/crafting_recipe/roguetown/alchemy/manna_pot
	name = "Manna Potion"
	result = list(/obj/item/reagent_containers/glass/bottle/rogue/manapot)
	reqs = list(/obj/item/reagent_containers/glass/bottle = 1, /obj/item/ash = 1, /obj/item/reagent_containers/food/snacks/fish/eel = 1)
	craftdiff = 4

/datum/crafting_recipe/roguetown/alchemy/manna_pot_3x
	name = "3x Manna Potion"
	result = list(/datum/supply_pack/rogue/food/manapot)
	reqs = list(/obj/item/reagent_containers/glass/bottle = 3, /obj/item/ash = 3, /obj/item/reagent_containers/food/snacks/fish/eel = 2)
	craftdiff = 4

// /datum/crafting_recipe/roguetown/alchemy/swift_pot
// 	name = "Swiftness Potion"
// 	result = list(/obj/item/reagent_containers/glass/bottle/rogue/swiftpot)
// 	reqs = list(/obj/item/reagent_containers/glass/bottle = 1, /obj/item/ash = 1, /obj/item/natural/feather = 1, /obj/item/natural/dirtclod = 3, /obj/item/natural/worms/leech = 1)
// 	craftdiff = 5

/datum/crafting_recipe/roguetown/alchemy/health_pot
	name = "Health Potion"
	result = list(/obj/item/reagent_containers/glass/bottle/rogue/healthpot)
	reqs = list(/obj/item/reagent_containers/glass/bottle = 1, /obj/item/ash = 1, /obj/item/reagent_containers/food/snacks/grown/berries/rogue = 1, /obj/item/reagent_containers/food/snacks/fish/clownfish = 1)
	craftdiff = 5

/datum/crafting_recipe/roguetown/alchemy/health_pot_3x
	name = "3x Health Potion"
	result = list(/datum/supply_pack/rogue/food/healthpot)
	reqs = list(/obj/item/reagent_containers/glass/bottle = 3, /obj/item/ash = 3, /obj/item/reagent_containers/food/snacks/grown/berries/rogue = 4, /obj/item/reagent_containers/food/snacks/fish/clownfish = 1)
	craftdiff = 5

// /datum/crafting_recipe/roguetown/alchemy/strength_pot
// name = "Strength Potion"
// result = list(/obj/item/reagent_containers/glass/bottle/rogue/strengthpot)
// reqs = list(/obj/item/reagent_containers/glass/bottle = 1, /obj/item/ash = 1, /obj/item/reagent_containers/food/snacks/fish/carp = 1, /obj/item/reagent_containers/food/snacks/fat = 1, /obj/item/reagent_containers/food/snacks/rogue/meat/steak = 3, /obj/item/reagent_containers/powder/flour/salt = 1)
// craftdiff = 6
