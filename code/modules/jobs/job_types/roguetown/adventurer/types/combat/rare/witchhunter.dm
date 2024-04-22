
/datum/advclass/puritan
	name = "Witch Hunter"
	tutorial = "Witch Hunters belong to a special type of occultic slayers dedicated to the destruction of dark sorcery, hereticism and evil. They often serve specific Temples and Churches in service to a great power which compels them to search out and destroy the corrupted."
	allowed_sexes = list("male")
	allowed_races = list("Humen")
	outfit = /datum/outfit/job/roguetown/adventurer/puritan
	maxchosen = 2
	pickprob = 11

/datum/outfit/job/roguetown/adventurer/puritan/pre_equip(mob/living/carbon/human/H)
	..()
	shirt = /obj/item/clothing/suit/roguetown/shirt/undershirt/puritan
	belt = /obj/item/storage/belt/rogue/leather
	neck = /obj/item/clothing/neck/roguetown/psicross/silver
	shoes = /obj/item/clothing/shoes/roguetown/boots
	pants = /obj/item/clothing/under/roguetown/tights/black
	cloak = /obj/item/clothing/cloak/cape/puritan
	beltr = /obj/item/storage/belt/rogue/pouch/coins/mid
	head = /obj/item/clothing/head/roguetown/puritan
	gloves = /obj/item/clothing/gloves/roguetown/leather
	beltl = /obj/item/rogueweapon/sword/rapier
	backl = /obj/item/storage/backpack/rogue/satchel
	backpack_contents = list(/obj/item/rogueweapon/huntingknife = 1)

	if(H.mind)
		H.mind.adjust_skillrank(/datum/skill/combat/swords, pick(3,3,3,3,4), TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/axesmaces, pick(1,2,2,2,3), TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/crossbows, pick(2,3,3), TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/bows, pick(0,1,1), TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/athletics, pick(0,1,1,2), TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/wrestling, pick(1,2,2,2,2), TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/unarmed, pick(1,2,2,2,3), TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/knives, pick(1,2,2,2,3), TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/polearms, pick(0,1,1), TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/swimming, pick(1,1,2), TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/climbing, pick(1,2,2), TRUE)
		H.mind.adjust_skillrank(/datum/skill/craft/crafting, pick(0,0,1), TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/reading, pick(2,3,3,4), TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/sewing, pick(2,2,3), TRUE)
		H.mind.adjust_skillrank(/datum/skill/labor/butchering, pick(0,1,1,1,2), TRUE)
		H.mind.adjust_skillrank(/datum/skill/craft/traps, pick(0,0,1), TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/medicine, pick(1,2,2,2), TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/sneaking, pick(1,1,1,2), TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/whipsflails, pick(3,3,4), TRUE)

		H.change_stat("intelligence", pick(2,2,2,3,3)) 
		H.change_stat("perception", pick(2,2,2,3,3)) 
		H.change_stat("strength", pick(1,1,1,2))
		H.change_stat("constitution", pick(-1,0,0,0,0,1))
		H.change_stat("endurance", pick(-1,0,0,0,0,1))
		H.change_stat("speed", pick(-1,0,0,0,0,1))
	H.verbs |= /mob/living/carbon/human/proc/torture_victim
	ADD_TRAIT(H, RTRAIT_MEDIUMARMOR, TRAIT_GENERIC)
	ADD_TRAIT(H, TRAIT_STEELHEARTED, TRAIT_GENERIC)
