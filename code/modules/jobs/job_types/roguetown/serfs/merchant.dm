/datum/job/roguetown/merchant
	title = "Merchant"
	flag = MERCHANT
	department_flag = SERFS
	faction = "Station"
	total_positions = 1
	spawn_positions = 1
	selection_color = JCOLOR_SERF
	allowed_races = list("Humen",
	"Humen",
	"Elf",
	"Dwarf",
	"Tiefling",
	"Aasimar"
	)
	tutorial = "A powerful merchant and defacto leader of the local Trade Guild, find yourself doing business in one of the most dangerous cities in the realm. Through the aid of business partners, some more skilled in magic then commerce -- you have built up an establishment that has become the envy of even The King himself."

	display_order = JDO_MERCHANT

	outfit = /datum/outfit/job/roguetown/merchant
	bypass_lastclass = TRUE
	give_bank_account = 22
	required = TRUE

/datum/outfit/job/roguetown/merchant/pre_equip(mob/living/carbon/human/H)
	..()
	if(H.mind)
		H.mind.adjust_skillrank(/datum/skill/combat/swords, pick(1,2,2,2,3), TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/axesmaces, pick(0,0,1), TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/crossbows, pick(0,0,1), TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/bows, pick(0,0,1,2), TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/wrestling, pick(0,0,1), TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/unarmed, pick(0,1,1,2), TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/knives, pick(2,2,3,4), TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/reading, pick(3,4,4,5,6), TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/sneaking, pick(1,1,1,2), TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/stealing, pick(2,2,3,4), TRUE)
		H.mind.adjust_skillrank(/datum/skill/labor/mathematics, pick(3,4,4,5), TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/medicine, pick(0,1,1), TRUE)
		H.mind.adjust_skillrank(/datum/skill/craft/cooking, pick(0,1,1), TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/riding, pick(1,1,2), TRUE)
	
	//20% chance to be raceswapped to Giza because slop lore
	if(ishumannorthern(H) && prob(20))
		var/list/skin_slop = H.dna.species.get_skin_list()
		H.skin_tone = skin_slop["Giza"]
		H.update_body()
	if(H.gender == MALE)
		shoes = /obj/item/clothing/shoes/roguetown/boots/leather
		beltr = /obj/item/storage/belt/rogue/pouch/coins/rich
		belt = /obj/item/storage/belt/rogue/leather/rope
		beltl = /obj/item/keyring/merchant
		shirt = /obj/item/clothing/suit/roguetown/shirt/undershirt/sailor
		pants = /obj/item/clothing/under/roguetown/tights/sailor
		neck = /obj/item/clothing/neck/roguetown/horus
		armor = /obj/item/clothing/suit/roguetown/shirt/robe/merchant
		head = /obj/item/clothing/head/roguetown/chaperon
		id = /obj/item/clothing/ring/gold
		H.change_stat("intelligence", pick(1,1,2))
		H.change_stat("perception", pick(0,1,1,2))
		H.change_stat("strength", pick(-1,0,0,1,1))
		H.change_stat("constitution", pick(-1,0,0,1,1))
		H.change_stat("endurance", pick(-1,0,0,1,1))
		H.change_stat("speed", pick(-1,0,0,1,1))
		if(H.dna?.species)
			if(H.dna.species.id == "human")
				H.dna.species.soundpack_m = new /datum/voicepack/male/wizard()
	else
		shoes = /obj/item/clothing/shoes/roguetown/gladiator
		beltr = /obj/item/storage/belt/rogue/pouch/coins/rich
		belt = /obj/item/storage/belt/rogue/leather/rope
		beltl = /obj/item/roguekey/merchant
		shirt = /obj/item/clothing/suit/roguetown/shirt/undershirt/sailor
		neck = /obj/item/clothing/neck/roguetown/horus
		armor = /obj/item/clothing/suit/roguetown/shirt/robe/merchant
		pants = /obj/item/clothing/under/roguetown/tights/sailor
		head = /obj/item/clothing/head/roguetown/chaperon
		id = /obj/item/clothing/ring/gold
		H.change_stat("intelligence", rand(1,2))
		H.change_stat("perception", rand(-1,2))
		H.change_stat("strength", rand(-2,0))
		H.change_stat("constitution", rand(-1,1))
		H.change_stat("endurance", rand(-1,1))
		H.change_stat("speed", rand(-1,1))
	ADD_TRAIT(H, RTRAIT_NOBLE, TRAIT_GENERIC)
	ADD_TRAIT(H, RTRAIT_NOSEGRAB, TRAIT_GENERIC)
	ADD_TRAIT(H, RTRAIT_SEEPRICES, type)
