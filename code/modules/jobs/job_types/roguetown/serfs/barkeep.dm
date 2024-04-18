/datum/job/roguetown/barkeep
	title = "Barkeep"
	flag = BARKEEP
	department_flag = SERFS
	faction = "Station"
	total_positions = 1
	spawn_positions = 1

	allowed_races = list("Humen",
	"Humen",
	"Elf",
	"Elf",
	"Half-Elf",
	"Dwarf",
	"Tiefling",
	"Aasimar"
	)

	tutorial = "Liquor Lodging and Lavish Baths, youre the life of the party and a rich bastard because of it. Well before that pesky merchant came around and convinced people to take up the bottle instead of the tankred, you were the reason the hardworking men and women of this town could rest."

	outfit = /datum/outfit/job/roguetown/barkeep
	display_order = JDO_BARKEEP
	give_bank_account = 43

/datum/outfit/job/roguetown/barkeep/pre_equip(mob/living/carbon/human/H)
	..()
	if(H.mind)
		H.mind.adjust_skillrank(/datum/skill/combat/unarmed, 1, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/reading, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/craft/cooking, 1, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/medicine, 1, TRUE)
	shoes = /obj/item/clothing/shoes/roguetown/shortboots
	
	beltl = /obj/item/storage/belt/rogue/pouch/coins/mid
	neck = /obj/item/keyring/innkeep
	if(H.gender == MALE)
		pants = /obj/item/clothing/under/roguetown/tights/random
		shirt = /obj/item/clothing/suit/roguetown/shirt/shortshirt/random
		cloak = /obj/item/clothing/cloak/apron/waist
		belt = /obj/item/storage/belt/rogue/leather
		H.change_stat("strength", 1)
	else
		armor = /obj/item/clothing/suit/roguetown/shirt/dress
		belt = /obj/item/storage/belt/rogue/leather/rope
		H.change_stat("constitution", 1)
	H.change_stat("endurance", 1)
