/datum/job/roguetown/mercenary/grenzelhoft
	title = "Grenzelhof"
	flag = GRENZELHOFT
	tutorial = "A mercenary from the Grenzelhoft emperiate mercenary guild, only cares about coin."
	allowed_sexes = list("male", "female")
	allowed_races = list("Humen", "Aasimar", "Half-Elf", "Dwarf")
	outfit = /datum/outfit/job/roguetown/mercenary/grenzelhoft
	display_order = JDO_GRENZELHOFT

/datum/outfit/job/roguetown/mercenary/grenzelhoft/pre_equip(mob/living/carbon/human/H)
	..()
	shoes = /obj/item/clothing/shoes/roguetown/boots/leather
	wrists = /obj/item/clothing/wrists/roguetown/bracers
	belt = /obj/item/storage/belt/rogue/leather
	armor = /obj/item/clothing/suit/roguetown/armor/chainmail/hauberk
	beltr = /obj/item/storage/belt/rogue/pouch/coins/poor
	cloak = /obj/item/clothing/cloak/stabard/mercenary
	beltl = /obj/item/rogueweapon/sword
	shirt = /obj/item/clothing/suit/roguetown/shirt/shortshirt/merc
	pants = /obj/item/clothing/under/roguetown/trou/leather
	if(H.gender == FEMALE)
		var/acceptable = list("Tomboy", "Bob", "Curly Short")
		if(!(H.hairstyle in acceptable))
			H.hairstyle = pick(acceptable)
			H.update_hair()
	//Humie grenzelhofts are always set to be, well, grenzelhoft
	if(ishumannorthern(H))
		var/list/skin_slop = H.dna.species.get_skin_list()
		H.skin_tone = skin_slop["Grenzelhoft"]
		H.update_body()
	if(H.mind)
		H.mind.adjust_skillrank(/datum/skill/misc/swimming, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/climbing, 3, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/sneaking, 3, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/axesmaces, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/bows, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/crossbows, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/wrestling, 3, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/unarmed, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/swords, 3, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/polearms, 1, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/whipsflails, 1, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/knives, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/reading, 1, TRUE)
		H.change_stat("strength", 3)
		H.change_stat("endurance", 2)
		H.change_stat("constitution", 2)
		H.change_stat("perception", -2)
		H.change_stat("speed", -1)
	ADD_TRAIT(H, RTRAIT_MEDIUMARMOR, TRAIT_GENERIC)
