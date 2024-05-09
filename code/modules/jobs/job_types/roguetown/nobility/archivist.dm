/datum/job/roguetown/archivist
	title = "Archivist"
	tutorial = " The Archivist meticulously preserves and organizes ancient scrolls and tomes, safeguarding the collective knowledge of the realm for generations to come. Nobles and Peasants alike often seek the Archivists expertise on matters of history and fact."
	flag = ARCHIVIST
	department_flag = SERFS
	faction = "Station"
	total_positions = 1
	spawn_positions = 1
	spells = list(/obj/effect/proc_holder/spell/invoked/projectile/fetch)
	allowed_patrons = list("Noc")
	allowed_ages = list(AGE_OLD, AGE_MIDDLEAGED)

	outfit = /datum/outfit/job/roguetown/archivist
	display_order = 19

/datum/outfit/job/roguetown/archivist/pre_equip(mob/living/carbon/human/H)
	..()
	if(H.gender == FEMALE)
		shirt = /obj/item/clothing/suit/roguetown/shirt/dress/gen/black
		pants = /obj/item/clothing/under/roguetown/tights/black
		head  = /obj/item/clothing/head/roguetown/roguehood/black
	else
		shirt = /obj/item/clothing/suit/roguetown/shirt/undershirt/puritan
		armor = /obj/item/clothing/suit/roguetown/armor/leather/vest/sailor/nightman
		pants = /obj/item/clothing/under/roguetown/tights/black
		head = /obj/item/clothing/head/roguetown/nightman
	shoes = /obj/item/clothing/shoes/roguetown/shortboots
	belt = /obj/item/storage/belt/rogue/leather/plaquesilver
	beltl = /obj/item/keyring/archivist
	beltr = /obj/item/storage/belt/rogue/pouch/coins/mid
	mask = /obj/item/clothing/mask/rogue/spectacles


	if(H.mind)
		H.mind.adjust_skillrank(/datum/skill/misc/reading, 6, TRUE)
		H.mind.adjust_skillrank(/datum/skill/labor/mathematics, 6, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/riding, 6, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/polearms, 6, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/axesmaces, 6, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/crossbows, 6, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/bows, 6, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/wrestling, 6, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/unarmed, 6, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/swords, 6, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/knives, 6, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/whipsflails, 6, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/swimming, 6, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/climbing, 6, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/athletics, 6, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/sneaking, 6, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/stealing, 6, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/music, 6, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/medicine, 6, TRUE)
		H.change_stat("strength", -6)
		H.change_stat("perception", -6)
		H.change_stat("intelligence", 666)
		H.change_stat("constitution", -6)
		H.change_stat("endurance", -6)
		H.change_stat("speed", -6)
		H.change_stat("fortune", 666)

		ADD_TRAIT(H, TRAIT_PACIFISM, TRAIT_GENERIC)
		ADD_TRAIT(H, RTRAIT_NOBLE, TRAIT_GENERIC)
		ADD_TRAIT(H, RTRAIT_NOSEGRAB, TRAIT_GENERIC)
		ADD_TRAIT(H, RTRAIT_SEEPRICES, type)
