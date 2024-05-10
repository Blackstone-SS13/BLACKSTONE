/datum/job/roguetown/lady
	title = "Queen Consort"
	flag = LADY
	department_flag = NOBLEMEN
	faction = "Station"
	total_positions = 1
	spawn_positions = 1

	allowed_sexes = list(FEMALE)
	allowed_races = list(
		"Humen",
		"Elf",
		"Half-Elf",
		"Dwarf",
		"Aasimar"
	) //Picked for political value, could be anything. Make something up, or execute your wife if you're chudmaxxing that round.
	tutorial = "Picked out of your political value rather than likely any form of love, you have become the King's most trusted confidant and likely friend throughout your marriage. Your loyalty and, perhaps, love; will be tested this day. For the daggers that threaten your beloved are as equally pointed at your own throat."

	outfit = /datum/outfit/job/roguetown/lady

	display_order = JDO_LADY
	give_bank_account = TRUE
	min_pq = 2

/datum/job/roguetown/exlady //just used to change the ladys title
	title = "Queen Dowager"
	flag = ADVENTURER
	department_flag = NOBLEMEN
	faction = "Station"
	total_positions = 0
	spawn_positions = 0
	display_order = JDO_LADY
	give_bank_account = TRUE

/datum/outfit/job/roguetown/lady/pre_equip(mob/living/carbon/human/H)
	. = ..()
	ADD_TRAIT(H, RTRAIT_SEEPRICES, TRAIT_GENERIC)
	ADD_TRAIT(H, RTRAIT_NOBLE, TRAIT_GENERIC)
	beltl = /obj/item/roguekey/manor
	neck = /obj/item/storage/belt/rogue/pouch/coins/rich
	belt = /obj/item/storage/belt/rogue/leather/cloth/lady
	if(!H.dna?.species || H.dna?.species.id == "dwarf")
		armor = /obj/item/clothing/suit/roguetown/shirt/dress
	else
		armor = /obj/item/clothing/suit/roguetown/armor/armordress
	head = /obj/item/clothing/head/roguetown/hennin
//		SSticker.rulermob = H
	if(prob(66))
		armor = /obj/item/clothing/suit/roguetown/armor/armordress/alt
	id = /obj/item/clothing/ring/silver
	shoes = /obj/item/clothing/shoes/roguetown/shortboots
	if(H.mind)
		H.mind.adjust_skillrank(/datum/skill/misc/reading, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/sneaking, 3, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/stealing, 4, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/riding, 1, TRUE)
