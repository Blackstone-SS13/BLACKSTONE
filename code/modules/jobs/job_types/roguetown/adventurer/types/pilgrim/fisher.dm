/datum/advclass/fisher
	name = "Fisher"
	allowed_sexes = list("male", "female")
	allowed_races = list(
		"Humen",
		"Elf",
		"Half-Elf",
		"Dwarf",
		"Tiefling",
		"Argonian",
		"Dark Elf",
		"Aasimar"
	)
	outfit = /datum/outfit/job/roguetown/adventurer/fisher
	isvillager = TRUE
	ispilgrim = TRUE

/datum/outfit/job/roguetown/adventurer/fisher/pre_equip(mob/living/carbon/human/H)
	..()
	if(H.mind)
		H.mind.adjust_skillrank(/datum/skill/combat/swords, pick(0,0,1), TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/axesmaces, pick(0,1,1), TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/crossbows, pick(0,1,1), TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/athletics, pick(2,2,3), TRUE) 
		H.mind.adjust_skillrank(/datum/skill/combat/bows, pick(1,1,2), TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/wrestling, pick(1,1,2), TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/unarmed, pick(1,2,2,3), TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/knives, pick(3,3,4), TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/polearms, 1, TRUE) 
		H.mind.adjust_skillrank(/datum/skill/misc/swimming, 4, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/climbing, 3, TRUE)
		H.mind.adjust_skillrank(/datum/skill/craft/crafting, 1, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/reading, pick(0,0,1), TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/sewing, 1, TRUE)
		H.mind.adjust_skillrank(/datum/skill/labor/butchering, 3, TRUE)
		H.mind.adjust_skillrank(/datum/skill/craft/traps, 1, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/medicine, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/sneaking, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/craft/cooking, 2, TRUE)

		H.change_stat("intelligence", 1)
		H.change_stat("perception", 2)
		H.change_stat("constitution", 1)
		H.change_stat("speed", 1)
		if(H.age == AGE_OLD)
			H.mind.adjust_skillrank(/datum/skill/labor/fishing, 5, TRUE)
		else
			H.mind.adjust_skillrank(/datum/skill/labor/fishing, 4, TRUE)
	if(H.gender == MALE)
		pants = /obj/item/clothing/under/roguetown/tights/random
		shirt = /obj/item/clothing/suit/roguetown/shirt/shortshirt/random
		shoes = /obj/item/clothing/shoes/roguetown/boots/leather
		neck = /obj/item/storage/belt/rogue/pouch/coins/poor
		head = /obj/item/clothing/head/roguetown/fisherhat
		mouth = /obj/item/rogueweapon/huntingknife
		armor = /obj/item/clothing/suit/roguetown/armor/workervest
		backl = /obj/item/storage/backpack/rogue/satchel
		belt = /obj/item/storage/belt/rogue/leather
		backr = /obj/item/fishingrod
		beltr = /obj/item/cooking/pan
		beltl = /obj/item/flint
		backpack_contents = list(/obj/item/natural/worms = 2,/obj/item/rogueweapon/shovel/small=1)			
	else
		armor = /obj/item/clothing/suit/roguetown/shirt/dress/gen/random
		shoes = /obj/item/clothing/shoes/roguetown/boots/leather
		neck = /obj/item/storage/belt/rogue/pouch
		head = /obj/item/clothing/head/roguetown/fisherhat
		backr = /obj/item/storage/backpack/rogue/satchel
		belt = /obj/item/storage/belt/rogue/leather/rope
		beltr = /obj/item/fishingrod
		beltl = /obj/item/rogueweapon/huntingknife
		backpack_contents = list(/obj/item/natural/worms = 2,/obj/item/rogueweapon/shovel/small=1)
