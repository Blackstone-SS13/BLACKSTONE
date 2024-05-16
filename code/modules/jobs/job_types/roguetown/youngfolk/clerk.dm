/datum/job/roguetown/clerk
	title = "Clerk"
	flag = CLERK
	department_flag = YOUNGFOLK
	faction = "Station"
	total_positions = 1
	spawn_positions = 1

	allowed_races = list(
		"Humen",
		"Elf",
		"Half-Elf",
		"Dwarf",
		"Aasimar"
	)
	allowed_sexes = list(MALE, FEMALE)
	allowed_ages = YOUNG_AGES_LIST

	tutorial = "You have been granted the privilege of serving as a clerk in the Steward's office. You help the Steward with anything they need, and learn how coin keeps the town moving and prosperous."

	outfit = /datum/outfit/job/roguetown/clerk
	display_order = JDO_CLERK
	give_bank_account = TRUE
	min_pq = -10

/datum/outfit/job/roguetown/clerk/pre_equip(mob/living/carbon/human/H)
	..()
	ADD_TRAIT(H, RTRAIT_SEEPRICES, type)

	if(H.mind)
		H.mind.adjust_skillrank(/datum/skill/misc/reading, 1, TRUE)
		H.change_stat("strength", -1)

	if(H.gender == MALE)
		armor = /obj/item/clothing/cloak/tabard/knight
		shirt = /obj/item/clothing/suit/roguetown/shirt/undershirt

	if(H.gender == FEMALE)
		armor = /obj/item/clothing/suit/roguetown/shirt/dress/gen/blue

	pants = /obj/item/clothing/under/roguetown/tights
	shoes = /obj/item/clothing/shoes/roguetown/simpleshoes
	belt = /obj/item/storage/belt/rogue/leather
	beltr = /obj/item/storage/belt/rogue/pouch/coins/poor
	beltl = /obj/item/keyring/clerk
	backr = /obj/item/storage/backpack/rogue/satchel
