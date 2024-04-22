/datum/advclass/fisher
	name = "Fisher"
	allowed_sexes = list("male", "female")
	allowed_races = list("Humen",
	"Humen",
	"Elf",
	"Elf",
	"Dark Elf",
	"Half-Elf",
	"Dwarf",
	"Dwarf",
	"Aasimar"
	)
	outfit = /datum/outfit/job/roguetown/adventurer/fisher
	isvillager = TRUE
	ispilgrim = TRUE

/datum/outfit/job/roguetown/adventurer/fisher/pre_equip(mob/living/carbon/human/H)
	..()
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
		if(H.mind)
			H.mind.adjust_skillrank(/datum/skill/combat/swords, pick(0,0,0,1), TRUE)
			H.mind.adjust_skillrank(/datum/skill/combat/axesmaces, pick(0,0,1), TRUE)
			H.mind.adjust_skillrank(/datum/skill/combat/crossbows, pick(0,0,1), TRUE)
			H.mind.adjust_skillrank(/datum/skill/misc/athletics, pick(2,2,3), TRUE) 
			H.mind.adjust_skillrank(/datum/skill/combat/bows, pick(1,2,2), TRUE)
			H.mind.adjust_skillrank(/datum/skill/combat/wrestling, pick(1,1,2), TRUE)
			H.mind.adjust_skillrank(/datum/skill/combat/unarmed, pick(1,2,2,3), TRUE)
			H.mind.adjust_skillrank(/datum/skill/combat/knives, pick(2,3,3), TRUE)
			H.mind.adjust_skillrank(/datum/skill/combat/polearms, pick(0,1,1), TRUE) 
			H.mind.adjust_skillrank(/datum/skill/misc/swimming, pick(3,4,4), TRUE)
			H.mind.adjust_skillrank(/datum/skill/misc/climbing, pick(2,2,3), TRUE)
			H.mind.adjust_skillrank(/datum/skill/craft/crafting, pick(1,2,2), TRUE)
			H.mind.adjust_skillrank(/datum/skill/misc/reading, pick(0,0,1), TRUE)
			H.mind.adjust_skillrank(/datum/skill/misc/sewing, pick(1,1,2), TRUE)
			H.mind.adjust_skillrank(/datum/skill/labor/butchering, pick(2,2,3), TRUE)
			H.mind.adjust_skillrank(/datum/skill/craft/traps, pick(1,1,2), TRUE)
			H.mind.adjust_skillrank(/datum/skill/misc/medicine, pick(0,1,1), TRUE)
			H.mind.adjust_skillrank(/datum/skill/misc/sneaking, pick(1,1,2), TRUE)
			H.mind.adjust_skillrank(/datum/skill/craft/cooking, pick(1,2,2,2,3), TRUE)

			if(H.age == AGE_OLD)
				H.mind.adjust_skillrank(/datum/skill/labor/fishing, pick(4,4,5), TRUE)
				H.change_stat("intelligence", pick(1,1,2))
				H.change_stat("perception", pick(2,2,3))
			else
				H.mind.adjust_skillrank(/datum/skill/labor/fishing, pick(3,4,4,5), TRUE)
				H.change_stat("intelligence", pick(0,0,1))
				H.change_stat("perception", pick(1,2,2,2,2,3))
				H.change_stat("strength", pick(0,0,0,1))
				H.change_stat("constitution", pick(1,2,2,2,2,3))
				H.change_stat("endurance", pick(0,0,0,1))
				H.change_stat("speed", pick(0,0,0,1))
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
		if(H.mind)
			H.mind.adjust_skillrank(/datum/skill/combat/knives, 1, TRUE)
			H.mind.adjust_skillrank(/datum/skill/misc/swimming, 3, TRUE)
			H.mind.adjust_skillrank(/datum/skill/craft/cooking, 2, TRUE)
			H.mind.adjust_skillrank(/datum/skill/craft/crafting, pick(1,2), TRUE)
			H.mind.adjust_skillrank(/datum/skill/labor/fishing, pick(4,5), TRUE)
			if(H.age == AGE_OLD)
				H.mind.adjust_skillrank(/datum/skill/labor/fishing, 2, TRUE)
				H.mind.adjust_skillrank(/datum/skill/combat/knives, 1, TRUE)
			H.change_stat("constitution", 1)
