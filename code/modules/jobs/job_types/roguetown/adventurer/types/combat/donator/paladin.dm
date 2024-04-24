//shield flail or longsword, tief can be this with red cross

/datum/advclass/paladin
	name = "Paladin"
	tutorial = "Paladins are holy warriors who have taken sacred vows to uphold justice and righteousness. Often, they were promised redemption for past sins if they crusaded in the name of the gods."	
	allowed_sexes = list("male", "female")
	allowed_races = list("Humen",
	"Tiefling",
	"Aasimar")
	outfit = /datum/outfit/job/roguetown/adventurer/paladin
	allowed_patrons = list("Astrata", "Dendor", "Necra")

/datum/outfit/job/roguetown/adventurer/paladin/pre_equip(mob/living/carbon/human/H)
	..()
	var/allowed_patrons = list("Astrata", "Dendor", "Necra", "Pestra")
	
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
		if("Pestra")
			neck = /obj/item/clothing/neck/roguetown/psicross/pestra

	armor = /obj/item/clothing/suit/roguetown/armor/chainmail/hauberk
	pants = /obj/item/clothing/under/roguetown/chainlegs
	shoes = /obj/item/clothing/shoes/roguetown/boots/leather
	belt = /obj/item/storage/belt/rogue/leather/hand
	beltl = /obj/item/storage/belt/rogue/pouch/coins/poor
	beltr = /obj/item/rogueweapon/huntingknife
	id = /obj/item/clothing/ring/silver
	cloak = /obj/item/clothing/cloak/tabard/crusader
	backr = /obj/item/rogueweapon/sword
	backl = /obj/item/storage/backpack/rogue/satchel
	if(H.mind)
		H.mind.adjust_skillrank(/datum/skill/combat/crossbows, pick(0,1,1), TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/polearms, pick(1,2,2,2,3), TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/axesmaces, pick(2,2,2,2,3), TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/bows, pick(0,0,1), TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/wrestling, pick(1,2,2,2), TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/unarmed, pick(1,2,2,2,3), TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/athletics, pick(2,2,2,3), TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/reading, pick(2,2,2,2,3), TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/swords, pick(2,3,3,3,3,3,4), TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/knives, pick(1,2,2,2,3), TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/sneaking, pick(0,1,1), TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/swimming, pick(0,1,1,1,2), TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/climbing, pick(1,1,2), TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/riding, pick(1,2,2,2,3), TRUE)
		H.mind.adjust_skillrank(/datum/skill/craft/cooking, pick(0,0,1), TRUE)
		H.mind.adjust_skillrank(/datum/skill/craft/traps, pick(0,0,0,0,1), TRUE)
		H.mind.adjust_skillrank(/datum/skill/magic/holy, pick(1,1,2), TRUE)
		H.change_stat("intelligence", pick(0,0,1,1,1,2))
		H.change_stat("perception", pick(0,0,1,1,1))
		H.change_stat("strength", pick(1,1,2))
		H.change_stat("constitution", pick(1,1,2))
		H.change_stat("endurance", pick(0,0,1,1,1))
		H.change_stat("speed", pick(-1,-1,0,0,0))

	ADD_TRAIT(H, RTRAIT_HEAVYARMOR, TRAIT_GENERIC)
	ADD_TRAIT(H, RTRAIT_MEDIUMARMOR, TRAIT_GENERIC)
	if(H.dna?.species)
		if(H.dna.species.id == "human")
			H.dna.species.soundpack_m = new /datum/voicepack/male/knight()
		if(H.dna.species.id == "tiefling")
			cloak = /obj/item/clothing/cloak/tabard/crusader/tief
	var/datum/devotion/cleric_holder/C = new /datum/devotion/cleric_holder(H, H.PATRON)
	//Max devotion limit - Paladins are stronger but cannot pray to gain more abilities
	C.max_devotion = 200
	C.update_devotion(50, 50)
	C.holder_mob = H
	C.grant_spells(H)
	H.verbs += list(/mob/living/carbon/human/proc/devotionreport, /mob/living/carbon/human/proc/clericpray)
