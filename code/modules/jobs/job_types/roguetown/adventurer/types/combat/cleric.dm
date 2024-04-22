//shield
/datum/advclass/cleric
	name = "Cleric"
	tutorial = "Granted a unique connection to the Gods and their realms, within your blood courses incredible power and a solemn duty to serve in this life -- and the next."
	allowed_sexes = list("male","female")
	allowed_races = list("Humen", "Elf", "Dwarf", "Aasimar", "Dark Elf",
	"Aasimar")
	allowed_patrons = list("Astrata", "Dendor", "Necra")
	ispilgrim = FALSE
	vampcompat = FALSE
	outfit = /datum/outfit/job/roguetown/adventurer/cleric

/datum/outfit/job/roguetown/adventurer/cleric/pre_equip(mob/living/carbon/human/H)
	..()
	var/allowed_patrons = list("Astrata", "Dendor", "Necra")

	var/datum/patrongods/ourpatron
	if(istype(H.PATRON, /datum/patrongods))
		ourpatron = H.PATRON

	if(!ourpatron || !(ourpatron.name in allowed_patrons))

		var/list/datum/patrongods/possiblegods = list()
		for(var/datum/patrongods/P in GLOB.patronlist)
			if(P.name in allowed_patrons)
				possiblegods |= P

		ourpatron = pick(possiblegods)
		H.PATRON = ourpatron
		to_chat(H, "<span class='warning'> My patron had not endorsed my practices in my younger years. I've since grown acustomed to [H.PATRON].")

	switch(ourpatron.name)
		if("Astrata")
			neck = /obj/item/clothing/neck/roguetown/psicross/astrata
		if("Dendor")
			neck = /obj/item/clothing/neck/roguetown/psicross/dendor
		if("Necra")
			neck = /obj/item/clothing/neck/roguetown/psicross/necra

	armor = /obj/item/clothing/suit/roguetown/armor/plate
	wrists = /obj/item/clothing/wrists/roguetown/bracers/leather
	pants = /obj/item/clothing/under/roguetown/trou/leather
	shoes = /obj/item/clothing/shoes/roguetown/boots/leather
	belt = /obj/item/storage/belt/rogue/leather
	beltr = /obj/item/rogueweapon/huntingknife
	beltl = /obj/item/storage/belt/rogue/pouch/coins/poor
	backr = /obj/item/rogueweapon/mace
	backl = /obj/item/storage/backpack/rogue/satchel
	if(H.mind) // Chances of Expert Crossbow, Swords, Knives and Reading. Their strongest skills are determined by Age. 
		H.mind.adjust_skillrank(/datum/skill/combat/crossbows, pick(1,1,2,2,2,2,3), TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/polearms, pick(0,1,1,1,2), TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/bows, pick(1,1,1,2), TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/wrestling, pick(1,1,2), TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/unarmed, pick(1,2,2,2,2), TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/swimming, pick(1,2,2), TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/climbing, pick(1,1,2), TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/athletics, pick(1,1,2), TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/swords, pick(1,1,1,2), TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/knives, pick(1,1,2,2,2,3), TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/reading, pick(1,2,2,2,3), TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/sewing, pick(1,1,1,2), TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/medicine, pick(1,1,2), TRUE)
		H.mind.adjust_skillrank(/datum/skill/craft/cooking, pick(0,1,1), TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/riding, pick(0,1,1), TRUE)
		if(H.age == AGE_OLD)
			H.mind.adjust_skillrank(/datum/skill/combat/axesmaces, pick(2,3,3,3,4), TRUE) // Older clerics have a chance of being Masters of their craft. 
			H.mind.adjust_skillrank(/datum/skill/magic/holy, pick(2,3,3,3,4), TRUE)
		else
			H.mind.adjust_skillrank(/datum/skill/combat/axesmaces, pick(2,3,3,3), TRUE)
			H.mind.adjust_skillrank(/datum/skill/magic/holy, pick(2,3,3,3), TRUE)

		H.change_stat("intelligence", pick(0,1,1,1,2))
		H.change_stat("perception", pick(-1,0,0,0,1))
		H.change_stat("strength", pick(-1,0,0,0,1))
		H.change_stat("constitution", pick(0,1,1,1,2))
		H.change_stat("endurance", pick(0,1,1,1,2)) // Mostly average stats compared to Warrior classes.
		H.change_stat("speed", pick(-1,0,0,0,1))
	ADD_TRAIT(H, RTRAIT_HEAVYARMOR, TRAIT_GENERIC)
	ADD_TRAIT(H, RTRAIT_MEDIUMARMOR, TRAIT_GENERIC)
	var/datum/devotion/cleric_holder/C = new /datum/devotion/cleric_holder(H, H.PATRON)
	C.holder_mob = H
	C.update_devotion(50, 50)
	C.grant_spells(H)
	H.verbs += list(/mob/living/carbon/human/proc/devotionreport, /mob/living/carbon/human/proc/clericpray)
