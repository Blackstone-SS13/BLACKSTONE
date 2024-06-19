/datum/crafting_recipe/roguetown
	req_table = FALSE
	tools = list(/obj/item/reagent_containers/glass/mortar, /obj/item/pestle)
	verbage_simple = "mix"
	skillcraft = /datum/skill/misc/alchemy

/datum/crafting_recipe/roguetown/alchemy/bbomb
	name = "Bottle bomb"
	result = list(/obj/item/bomb)
	reqs = list(/obj/item/reagent_containers/glass/bottle = 1, /obj/item/ash = 2, /obj/item/rogueore/coal = 1, /obj/item/natural/cloth = 1)
	craftdiff = 2

/datum/crafting_recipe/roguetown/alchemy/bbomb
	name = "Bottle bomb m"
	result = list(/obj/item/bomb)
	reqs = list(/obj/item/reagent_containers/glass/bottle/rogue/manapot = 1, /obj/item/ash = 2, /obj/item/rogueore/coal = 1, /obj/item/natural/cloth = 1)
	craftdiff = 2

/datum/crafting_recipe/roguetown/alchemy/bbomb
	name = "Bottle bomb h"
	result = list(/obj/item/bomb)
	reqs = list(/obj/item/reagent_containers/glass/bottle/rogue/healthpot = 1, /obj/item/ash = 2, /obj/item/rogueore/coal = 1, /obj/item/natural/cloth = 1)
	craftdiff = 2

/datum/crafting_recipe/roguetown/alchemy/manna_pot
	name = "Manna Potion"
	result = list(/obj/item/reagent_containers/glass/bottle/rogue/manapot)
	reqs = list(/obj/item/reagent_containers/glass/bottle = 1, /obj/item/ash = 1, /obj/item/reagent_containers/food/snacks/fish/eel = 1)
	craftdiff = 4

/datum/crafting_recipe/roguetown/alchemy/manna_pot
	name = "Manna Potion m"
	result = list(/obj/item/reagent_containers/glass/bottle/rogue/manapot)
	reqs = list(/obj/item/reagent_containers/glass/bottle/rogue/manapot = 1, /obj/item/ash = 1, /obj/item/reagent_containers/food/snacks/fish/eel = 1)
	craftdiff = 4

/datum/crafting_recipe/roguetown/alchemy/manna_pot
	name = "Manna Potion h"
	result = list(/obj/item/reagent_containers/glass/bottle/rogue/manapot)
	reqs = list(/obj/item/reagent_containers/glass/bottle/rogue/healthpot = 1, /obj/item/ash = 1, /obj/item/reagent_containers/food/snacks/fish/eel = 1)
	craftdiff = 4

/datum/crafting_recipe/roguetown/alchemy/manna_pot_3x
	name = "3x Manna Potion"
	result = list(/datum/supply_pack/rogue/food/manapot)
	reqs = list(/obj/item/reagent_containers/glass/bottle = 3, /obj/item/ash = 3, /obj/item/reagent_containers/food/snacks/fish/eel = 2)
	craftdiff = 4

/datum/crafting_recipe/roguetown/alchemy/manna_pot_3x
	name = "3x Manna Potion m"
	result = list(/datum/supply_pack/rogue/food/manapot)
	reqs = list(/obj/item/reagent_containers/glass/bottle/rogue/manapot = 3, /obj/item/ash = 3, /obj/item/reagent_containers/food/snacks/fish/eel = 2)
	craftdiff = 4

/datum/crafting_recipe/roguetown/alchemy/manna_pot_3x
	name = "3x Manna Potion h"
	result = list(/datum/supply_pack/rogue/food/manapot)
	reqs = list(/obj/item/reagent_containers/glass/bottle/rogue/healthpot = 3, /obj/item/ash = 3, /obj/item/reagent_containers/food/snacks/fish/eel = 2)
	craftdiff = 4

/datum/crafting_recipe/roguetown/alchemy/health_pot
	name = "Health Potion"
	result = list(/obj/item/reagent_containers/glass/bottle/rogue/healthpot)
	reqs = list(/obj/item/reagent_containers/glass/bottle = 1, /obj/item/ash = 1, /obj/item/reagent_containers/food/snacks/grown/berries/rogue = 1, /obj/item/reagent_containers/food/snacks/fish/clownfish = 1)
	craftdiff = 5

/datum/crafting_recipe/roguetown/alchemy/health_pot
	name = "Health Potion m"
	result = list(/obj/item/reagent_containers/glass/bottle/rogue/healthpot)
	reqs = list(/obj/item/reagent_containers/glass/bottle/rogue/manapot = 1, /obj/item/ash = 1, /obj/item/reagent_containers/food/snacks/grown/berries/rogue = 1, /obj/item/reagent_containers/food/snacks/fish/clownfish = 1)
	craftdiff = 5


/datum/crafting_recipe/roguetown/alchemy/health_pot
	name = "Health Potion h"
	result = list(/obj/item/reagent_containers/glass/bottle/rogue/healthpot)
	reqs = list(/obj/item/reagent_containers/glass/bottle/rogue/healthpot = 1, /obj/item/ash = 1, /obj/item/reagent_containers/food/snacks/grown/berries/rogue = 1, /obj/item/reagent_containers/food/snacks/fish/clownfish = 1)
	craftdiff = 5

/datum/crafting_recipe/roguetown/alchemy/health_pot_3x
	name = "3x Health Potion"
	result = list(/datum/supply_pack/rogue/food/healthpot)
	reqs = list(/obj/item/reagent_containers/glass/bottle = 3, /obj/item/ash = 3, /obj/item/reagent_containers/food/snacks/grown/berries/rogue = 4, /obj/item/reagent_containers/food/snacks/fish/clownfish = 1)
	craftdiff = 5

/datum/crafting_recipe/roguetown/alchemy/health_pot_3x
	name = "3x Health Potion m"
	result = list(/datum/supply_pack/rogue/food/healthpot)
	reqs = list(/obj/item/reagent_containers/glass/bottle/rogue/manapot = 3, /obj/item/ash = 3, /obj/item/reagent_containers/food/snacks/grown/berries/rogue = 4, /obj/item/reagent_containers/food/snacks/fish/clownfish = 1)
	craftdiff = 5

/datum/crafting_recipe/roguetown/alchemy/health_pot_3x
	name = "3x Health Potion h"
	result = list(/datum/supply_pack/rogue/food/healthpot)
	reqs = list(/obj/item/reagent_containers/glass/bottle/rogue/healthpot = 3, /obj/item/ash = 3, /obj/item/reagent_containers/food/snacks/grown/berries/rogue = 4, /obj/item/reagent_containers/food/snacks/fish/clownfish = 1)
	craftdiff = 5
