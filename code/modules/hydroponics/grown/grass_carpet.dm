// Grass
/obj/item/seeds/grass
	name = "pack of grass seeds"
	desc = ""
	icon_state = "seed"
	species = "grass"
	plantname = "Grass"
	product = /obj/item/reagent_containers/food/snacks/grown/grass
	lifespan = 40
	endurance = 40
	maturation = 2
	production = 5
	yield = 5
	growthstages = 2
	icon_grow = "grass-grow"
	icon_dead = "grass-dead"
	genes = list(/datum/plant_gene/trait/repeated_harvest)
	mutatelist = list(/obj/item/seeds/grass/carpet, /obj/item/seeds/grass/fairy)
	reagents_add = list(/datum/reagent/consumable/nutriment = 0.02, /datum/reagent/hydrogen = 0.05)

/obj/item/reagent_containers/food/snacks/grown/grass
	seed = /obj/item/seeds/grass
	name = "grass"
	desc = ""
	icon_state = "grassclump"
	filling_color = "#32CD32"
	bitesize_mod = 2
	var/stacktype = /obj/item/stack/tile/grass
	var/tile_coefficient = 0.02 // 1/50
	wine_power = 15

/obj/item/reagent_containers/food/snacks/grown/grass/attack_self(mob/user)
	to_chat(user, span_notice("I prepare the astroturf."))
	var/grassAmt = 1 + round(seed.potency * tile_coefficient) // The grass we're holding
	for(var/obj/item/reagent_containers/food/snacks/grown/grass/G in user.loc) // The grass on the floor
		if(G.type != type)
			continue
		grassAmt += 1 + round(G.seed.potency * tile_coefficient)
		qdel(G)
	new stacktype(user.drop_location(), grassAmt)
	qdel(src)

//Fairygrass
/obj/item/seeds/grass/fairy
	name = "pack of fairygrass seeds"
	desc = ""
	icon_state = "seed"
	species = "fairygrass"
	plantname = "Fairygrass"
	product = /obj/item/reagent_containers/food/snacks/grown/grass/fairy
	icon_grow = "fairygrass-grow"
	icon_dead = "fairygrass-dead"
	genes = list(/datum/plant_gene/trait/repeated_harvest, /datum/plant_gene/trait/glow/blue)
	reagents_add = list(/datum/reagent/consumable/nutriment = 0.02, /datum/reagent/hydrogen = 0.05, /datum/reagent/drug/space_drugs = 0.15)

/obj/item/reagent_containers/food/snacks/grown/grass/fairy
	seed = /obj/item/seeds/grass/fairy
	name = "fairygrass"
	desc = ""
	icon_state = "fairygrassclump"
	filling_color = "#3399ff"
	stacktype = /obj/item/stack/tile/fairygrass

// Carpet
/obj/item/seeds/grass/carpet
	name = "pack of carpet seeds"
	desc = ""
	icon_state = "seed"
	species = /datum/reagent/carpet
	plantname = "Carpet"
	product = /obj/item/reagent_containers/food/snacks/grown/grass/carpet
	mutatelist = list()
	rarity = 10

/obj/item/reagent_containers/food/snacks/grown/grass/carpet
	seed = /obj/item/seeds/grass/carpet
	name = "carpet"
	desc = ""
	icon_state = "carpetclump"
	stacktype = /obj/item/stack/tile/carpet
	can_distill = FALSE
