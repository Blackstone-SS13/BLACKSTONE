//shield
/datum/advclass/cleric
	name = "Cleric"
	tutorial = "Clerics are wandering warriors of the Gods, an asset to any party."
	allowed_sexes = list("male","female")
	allowed_races = list("Humen", "Elf", "Dwarf", "Aasimar", "Dark Elf",
	"Aasimar")
	allowed_patrons = list("Astrata", "Dendor", "Necra", "Pestra","Noc")
	ispilgrim = FALSE
	vampcompat = FALSE
	outfit = /datum/outfit/job/roguetown/adventurer/cleric
	traits_applied = list(RTRAIT_HEAVYARMOR)

/datum/outfit/job/roguetown/adventurer/cleric/pre_equip(mob/living/carbon/human/H)
	..()
	var/allowed_patrons = list("Astrata", "Dendor", "Necra", "Pestra","Noc")

	var/datum/patrongods/ourpatron
	if(istype(H.PATRON, /datum/patrongods))
		ourpatron = H.PATRON

	if(!ourpatron || !(ourpatron.name in allowed_patrons))
		var/list/datum/patrongods/possiblegods = list()
		for(var/god in GLOB.patronlist)
			var/datum/patrongods/patron = GLOB.patronlist[god]
			if(patron.name in allowed_patrons)
				possiblegods |= patron
		ourpatron = pick(possiblegods)
		H.PATRON = ourpatron
		to_chat(H, "<span class='warning'>My patron had not endorsed my practices in my younger years. I've since grown acustomed to [H.PATRON].")

	switch(ourpatron.name)
		if("Astrata")
			neck = /obj/item/clothing/neck/roguetown/psicross/astrata
		if("Dendor")
			neck = /obj/item/clothing/neck/roguetown/psicross/dendor
		if("Necra")
			neck = /obj/item/clothing/neck/roguetown/psicross/necra
		if("Pestra")
			neck = /obj/item/clothing/neck/roguetown/psicross/pestra
		if("Noc")
			neck = /obj/item/clothing/neck/roguetown/psicross/noc

	armor = /obj/item/clothing/suit/roguetown/armor/plate
	wrists = /obj/item/clothing/wrists/roguetown/bracers/leather
	pants = /obj/item/clothing/under/roguetown/trou/leather
	shoes = /obj/item/clothing/shoes/roguetown/boots/leather
	belt = /obj/item/storage/belt/rogue/leather
	beltr = /obj/item/rogueweapon/huntingknife
	beltl = /obj/item/storage/belt/rogue/pouch/coins/poor
	backr = /obj/item/rogueweapon/mace
	backl = /obj/item/storage/backpack/rogue/satchel
	if(H.mind)
		H.mind.adjust_skillrank(/datum/skill/combat/axesmaces, 4, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/crossbows, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/bows, 1, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/wrestling, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/unarmed, 3, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/climbing, 1, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/athletics, 3, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/reading, 3, TRUE)
		H.mind.adjust_skillrank(/datum/skill/magic/holy, 3, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/medicine, 1, TRUE)
		if(H.age == AGE_OLD)
			H.mind.adjust_skillrank(/datum/skill/combat/axesmaces, 1, TRUE)
			H.mind.adjust_skillrank(/datum/skill/magic/holy, 1, TRUE)
		H.change_stat("strength", 1)
		H.change_stat("perception", 1)
		H.change_stat("intelligence", 2)
		H.change_stat("constitution", 2)
		H.change_stat("endurance", 3)
		H.change_stat("speed", -1)
	var/datum/devotion/cleric_holder/C = new /datum/devotion/cleric_holder(H, H.PATRON)
	C.holder_mob = H
	C.update_devotion(50, 50)
	C.grant_spells(H)
	H.verbs += list(/mob/living/carbon/human/proc/devotionreport, /mob/living/carbon/human/proc/clericpray)
