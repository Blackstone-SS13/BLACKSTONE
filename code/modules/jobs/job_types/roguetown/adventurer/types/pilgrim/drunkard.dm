/datum/advclass/drunkard
	name = "Drunkard"
	tutorial = "You are a scumbag. Everyone in your life has given up on you, and your remaining liver has tried to jump ship a few times. All you have left to your name are some cards, dice and whatever is in this bottle. At least you're still in Eora's good graces, whether you reciprocate such feelings or not..."
	allowed_sexes = list(MALE, FEMALE)
	allowed_races = list(
		"Humen",
		"Elf",
		"Half-Elf",
		"Dwarf",
		"Tiefling",
		"Argonian",
		"Dark Elf",
		"Aasimar",
		"Half Orc"
	)
	outfit = /datum/outfit/job/roguetown/adventurer/drunkard
	category_tags = list(CTAG_PILGRIM)

/datum/outfit/job/roguetown/adventurer/drunkard
	allowed_patrons = list(/datum/patron/inhumen/eora, /datum/patron/divine/xylix)

/datum/outfit/job/roguetown/adventurer/drunkard/pre_equip(mob/living/carbon/human/H)
	..()
	if(H.mind)
		pants = /obj/item/clothing/under/roguetown/tights/vagrant
		gloves = /obj/item/clothing/gloves/roguetown/fingerless
		shirt = /obj/item/clothing/suit/roguetown/shirt/shortshirt/random
		shoes = /obj/item/clothing/shoes/roguetown/boots/leather
		neck = /obj/item/storage/belt/rogue/pouch/coins/poor
		armor = /obj/item/clothing/suit/roguetown/shirt/rags
		backl = /obj/item/storage/backpack/rogue/satchel
		belt = /obj/item/storage/belt/rogue/leather
		beltr = /obj/item/clothing/mask/cigarette/rollie/cannabis
		beltl = /obj/item/flint
		backpack_contents = list(/obj/item/storage/pill_bottle/dice = 1, /obj/item/toy/cards/deck = 1, /obj/item/reagent_containers/glass/bottle/rogue/wine = 1)	
		H.mind.adjust_skillrank(/datum/skill/misc/stealing, 3, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/sneaking, 3, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/wrestling, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/unarmed, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/knives, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/craft/alchemy, 1, TRUE) //They know what substances is and things.
		H.mind.adjust_skillrank(/datum/skill/misc/lockpicking, 1, TRUE) //Breaking into the houses of anyone who ever loved them.
		H.mind.adjust_skillrank(/datum/skill/misc/climbing, 1, TRUE) //Climbing into windows to steal drugs or booze.
		H.change_stat("intelligence", -2)
		H.change_stat("constitution", 1)
		H.change_stat("strength", 1)
		H.change_stat("fortune", 2)
		ADD_TRAIT(H, TRAIT_NOSTINK, TRAIT_GENERIC)
		ADD_TRAIT(H, TRAIT_LIMPDICK, TRAIT_GENERIC)
		if(H.patron.type == /datum/patron/divine/xylix)
			ADD_TRAIT(H, TRAIT_CRACKHEAD, TRAIT_GENERIC)
