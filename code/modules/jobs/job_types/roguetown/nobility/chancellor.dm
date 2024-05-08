/datum/job/roguetown/chancellor
	title = "Chancellor"
	flag = CHANCELLOR
	department_flag = NOBLEMEN
	faction = "Station"
	total_positions = 2
	spawn_positions = 2
	allowed_ages = list(AGE_ADULT, AGE_MIDDLEAGED, AGE_OLD)
	allowed_races = list(
		"Humen",
		"Elf",
		"Half-Elf",
		"Dwarf",
		"Aasimar",
	)
	allowed_sexes = list(MALE, FEMALE)
	display_order = JDO_CHANCELLOR
	tutorial = "You may have inherited this role, bought your way into it, or were appointed; whatever it was you now serve the court as assistant, planner, juror, tax collector - whatever functions don't require a sword. You answer directly to the Bailiff & Steward, and your main focus is to assist them. You act as a check & balance within the court."
	whitelist_req = FALSE
	outfit = /datum/outfit/job/roguetown/chancellor
	give_bank_account = 40
	min_pq = 1

/datum/outfit/job/roguetown/chancellor/pre_equip(mob/living/carbon/human/H)
	..()
	neck = /obj/item/storage/belt/rogue/pouch/coins/rich
	armor = /obj/item/clothing/suit/roguetown/armor/gambeson/councillor
	shirt = /obj/item/clothing/suit/roguetown/shirt/undershirt/random
	pants = /obj/item/clothing/under/roguetown/tights/random
	shoes = /obj/item/clothing/shoes/roguetown/boots
	head = /obj/item/clothing/head/roguetown/chaperon/councillor
	backl = /obj/item/storage/backpack/rogue/satchel
	belt = /obj/item/storage/belt/rogue/leather/plaquesilver
	beltl = /obj/item/keyring/guardcastle
	beltr = /obj/item/rogueweapon/huntingknife/idagger/steel
	cloak = /obj/item/clothing/cloak/stabard/surcoat/councillor
	backpack_contents = list(/obj/item/keyring/chancellor = 1)
	if(H.mind)
		H.mind.adjust_skillrank(/datum/skill/combat/wrestling, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/unarmed, 3, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/swimming, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/climbing, 1, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/athletics, 4, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/reading, 5, TRUE)
		H.change_stat("intelligence", 3)
		H.change_stat("constitution", 1)
		H.change_stat("fortune", 2)

