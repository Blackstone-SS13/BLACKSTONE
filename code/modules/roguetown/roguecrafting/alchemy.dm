/datum/crafting_recipe/roguetown
	req_table = FALSE
	structurecraft = /obj/structure/fluff/millstone
	verbage_simple = "mixes"
	skillcraft = /datum/skill/misc/alchemy

  /datum/crafting_recipe/roguetown/alchemy/bbomb
	name = "Bottle bomb"
	result = list(/obj/item/bomb)
	reqs = list(/obj/item/reagent_containers/glass/bowl = 1, /obj/item/ash = 2, /obj/item/natural/rock/coal = 1, /obj/item/natural/cloth = 1)
	craftdiff = 2

  /datum/crafting_recipe/roguetown/alchemy/manna_pot
	name = "Manna Potion"
	result = list(/obj/item/reagent_containers/glass/bottle/rogue/manapot)
	reqs = list(/obj/item/reagent_containers/glass/bowl = 1, /obj/item/ash = 1, /obj/item/reagent_containers/food/snacks/fish/eel = 1)
	craftdiff = 3

  /datum/crafting_recipe/roguetown/alchemy/manna_pot
	name = "3x Manna Potion"
	result = list(/datum/supply_pack/rogue/food/manapot)
	reqs = list(/obj/item/reagent_containers/glass/bowl = 3, /obj/item/ash = 3, /obj/item/reagent_containers/food/snacks/fish/eel = 2)
	craftdiff = 3

   /datum/crafting_recipe/roguetown/alchemy/health_pot
	name = "Health Potion"
	result = list(/obj/item/reagent_containers/glass/bottle/rogue/healthpot)
	reqs = list(/obj/item/reagent_containers/glass/bowl = 1, /obj/item/ash = 1, /obj/item/reagent_containers/food/snacks/grown/berries/rogue = 3)
	craftdiff = 4

     /datum/crafting_recipe/roguetown/alchemy/health_pot
	name = "3x Health Potion"
	result = list(/datum/supply_pack/rogue/food/healthpot)
	reqs = list(/obj/item/reagent_containers/glass/bowl = 3, /obj/item/ash = 3, /obj/item/reagent_containers/food/snacks/grown/berries/rogue = 6)
	craftdiff = 4
