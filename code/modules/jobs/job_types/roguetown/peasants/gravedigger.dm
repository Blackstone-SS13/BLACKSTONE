/datum/job/roguetown/undertaker
	title = "Gravedigger"
	flag = GRAVEDIGGER
	department_flag = CHURCHMEN
	faction = "Station"
	total_positions = 2
	spawn_positions = 3
	allowed_patrons = list(/datum/patron/divine/necra)

	allowed_races = list(
		"Humen",
		"Elf",
		"Half-Elf",
		"Dwarf",
		"Aasimar"
	)
	tutorial = "The dead should stay dead, and they will under your watch. A life of devotion is rarely one of riches, but you turn a coin by plying your trade to the fallen. Your job isnt considered highly, but without you, who else will maintain the sanctity of death?"

	outfit = /datum/outfit/job/roguetown/undertaker
	display_order = JDO_GRAVEMAN
	give_bank_account = TRUE
	min_pq = -10

/datum/outfit/job/roguetown/undertaker/pre_equip(mob/living/carbon/human/H)
	..()
	pants = /obj/item/clothing/under/roguetown/tights/black
	cloak = /obj/item/clothing/cloak/raincloak/mortus
	shoes = /obj/item/clothing/shoes/roguetown/boots
	belt = /obj/item/storage/belt/rogue/leather
	beltl = /obj/item/roguekey/graveyard
	beltr = /obj/item/storage/belt/rogue/pouch/coins/poor
	backr = /obj/item/rogueweapon/shovel
	neck = /obj/item/clothing/neck/roguetown/psicross/necra
	if(H.gender == FEMALE)
		pants = null
		shirt = /obj/item/clothing/suit/roguetown/shirt/dress/gen/black
	else
		armor = /obj/item/clothing/suit/roguetown/armor/leather/vest/black
	if(H.mind)
		H.mind.adjust_skillrank(/datum/skill/combat/wrestling, 3, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/unarmed, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/craft/crafting, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/reading, 1, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/swimming, 3, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/climbing, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/magic/holy, 3, TRUE)
		H.change_stat("strength", 1)
		H.change_stat("intelligence", -2)
		H.change_stat("speed", 1)
	ADD_TRAIT(H, RTRAIT_NOSTINK, TRAIT_GENERIC)

	var/datum/devotion/cleric_holder/C = new /datum/devotion/cleric_holder(H, H.patron)
	C.holder_mob = H
	C.update_devotion(50, 50)
	C.grant_spells(H)
	H.verbs += list(/mob/living/carbon/human/proc/devotionreport, /mob/living/carbon/human/proc/clericpray)
