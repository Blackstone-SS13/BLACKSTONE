/datum/job/roguetown/alchemist 
	title = "Alchemist"
	flag = ALCHEMIST
	department_flag = YEOMEN
	faction = "Station"
	total_positions = 0
	spawn_positions = 0

	allowed_races = list(
		"Humen",
		"Elf",
		"Half-Elf",
		"Dwarf",
		"Tiefling",
		"Argonian",
		"Dark Elf"
	)

	tutorial = "You came to rockhill after hearing that there is a lack of potion-makers outside of the nobility. Stir up potions with your alchemy expertise, of health or death"

	outfit = /datum/outfit/job/roguetown/alchemist
	display_order = 6
	give_bank_account = 12
	min_pq = -6
	max_pq = null

/datum/outfit/job/roguetown/alchemist
	name = "Alchemist"
	jobtype = /datum/job/roguetown/alchemist

/datum/outfit/job/roguetown/alchemist/pre_equip(mob/living/carbon/human/H)
	..()
	if(H.mind)
		H.mind.adjust_skillrank(/datum/skill/craft/crafting, 3, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/alchemy, pick(3,4,5), TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/reading, 2, TRUE)
		if(H.age == AGE_OLD)
			H.mind.adjust_skillrank(/datum/skill/misc/alchemy, pick(5,6), TRUE)
//Requires a lot of sprites, so this is just a placeholder
	if(H.gender == MALE)
		pants = /obj/item/clothing/under/roguetown/trou
		shoes = /obj/item/clothing/shoes/roguetown/boots/leather
		shirt = /obj/item/clothing/suit/roguetown/shirt/shortshirt
		belt = /obj/item/storage/belt/rogue/leather
		beltl = /obj/item/storage/belt/rogue/pouch/coins/poor
		cloak = /obj/item/clothing/cloak/apron/brown
		H.change_stat("intelligence", 3)
		H.change_stat("speed", -1)
	else
		pants = /obj/item/clothing/under/roguetown/trou
		shoes = /obj/item/clothing/shoes/roguetown/boots/leather
		shirt = /obj/item/clothing/suit/roguetown/shirt/shortshirt
		belt = /obj/item/storage/belt/rogue/leather
		beltl = /obj/item/storage/belt/rogue/pouch/coins/poor
		cloak = /obj/item/clothing/cloak/apron/brown
		H.change_stat("intelligence", 2)
		H.change_stat("speed", -2)
