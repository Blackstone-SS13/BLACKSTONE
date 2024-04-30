/datum/job/roguetown/lifter
	title = "Lifter"
	flag = LIFTER
	department_flag = SERFS
	faction = "Station"
	total_positions = 4
	spawn_positions = 4

	allowed_races = list("Humen",
	"Humen",
	"Elf",
	"Dwarf",
	"Tiefling",
	"Aasimar"
	)
	allowed_sexes = list(MALE)
	allowed_ages = list(AGE_ADULT, AGE_MIDDLEAGED)

	tutorial = "The Merchant has employed you to move things from one place to another, officially. The shophands should pick up the slack while you defend the merchant from beggars and rogues"

	outfit = /datum/outfit/job/roguetown/lifter
	display_order = JDO_LIFTER
	give_bank_account = TRUE

/datum/outfit/job/roguetown/lifter/pre_equip(mob/living/carbon/human/H)
	..()
	ADD_TRAIT(H, RTRAIT_SEEPRICES, type)
	if(H.gender == MALE)
		pants = /obj/item/clothing/under/roguetown/trou
		shirt = /obj/item/clothing/suit/roguetown/shirt/undershirt
		shoes = /obj/item/clothing/shoes/roguetown/simpleshoes
		belt = /obj/item/storage/belt/rogue/leather
		beltr = /obj/item/storage/belt/rogue/pouch/coins/poor
		beltl = /obj/item/keyring/merchant
		backr = /obj/item/storage/backpack/rogue/satchel
		if(H.mind)
			H.mind.adjust_skillrank(/datum/skill/misc/stealing, rand(2,5), TRUE)
			H.mind.adjust_skillrank(/datum/skill/misc/climbing, rand(1,2), TRUE)
			H.mind.adjust_skillrank(/datum/skill/combat/unarmed, rand(1,3), TRUE)
			H.change_stat("strength", 1)

