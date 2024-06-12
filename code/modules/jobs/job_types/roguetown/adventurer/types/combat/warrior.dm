//shield sword
/datum/advclass/sfighter
	name = "Warrior"
	tutorial = "Warriors are well balanced fighters, skilled in blades and capable of most other weapons. \
	they are an important member to most parties for their combat prowess, but not for much more"
	allowed_sexes = list(MALE, FEMALE)
	allowed_races = list(
		"Humen",
		"Elf",
		"Half-Elf",
		"Dwarf",
		"Tiefling",
		"Argonian",
		"Dark Elf",
		"Aasimar",
		"Half Orc"
	)
	outfit = /datum/outfit/job/roguetown/adventurer/sfighter
	traits_applied = list(TRAIT_HEAVYARMOR)

	category_tags = list(CTAG_ADVENTURER)


/datum/outfit/job/roguetown/adventurer/sfighter/pre_equip(mob/living/carbon/human/H)
	..()
	H.adjust_blindness(-3)
	var/classes = list("Mighty Warrior","Swift Warrior",) // To Do - knight errant unique archetype(5 percent chance)
	var/classchoice = input("Choose your archetypes", "Available archetypes") as anything in classes

	switch(classchoice)
	
		if("Mighty Warrior")
			H.set_blindness(0)
			to_chat(H, "<span class='warning'>Strong and tough, Mighty Warriors are ready to crush their opponents under their mace while wearing heavy armor.</span>")
			H.mind.adjust_skillrank(/datum/skill/combat/crossbows, 2, TRUE)
			H.mind.adjust_skillrank(/datum/skill/combat/polearms, 2, TRUE)
			H.mind.adjust_skillrank(/datum/skill/combat/maces, 3, TRUE)
			H.mind.adjust_skillrank(/datum/skill/combat/axes, 3, TRUE)
			H.mind.adjust_skillrank(/datum/skill/combat/bows, 1, TRUE)
			H.mind.adjust_skillrank(/datum/skill/combat/wrestling, 3, TRUE)
			H.mind.adjust_skillrank(/datum/skill/combat/unarmed, 2, TRUE)
			H.mind.adjust_skillrank(/datum/skill/misc/athletics, 4, TRUE)
			H.mind.adjust_skillrank(/datum/skill/combat/swords, 2, TRUE)
			H.mind.adjust_skillrank(/datum/skill/combat/knives, rand(1,2), TRUE)
			H.mind.adjust_skillrank(/datum/skill/misc/swimming, 1, TRUE)
			H.mind.adjust_skillrank(/datum/skill/misc/climbing, 2, TRUE)
			H.mind.adjust_skillrank(/datum/skill/misc/riding, pick(2,3), TRUE)
			H.mind.adjust_skillrank(/datum/skill/misc/medicine, 1, TRUE)
			ADD_TRAIT(H, TRAIT_MEDIUMARMOR, TRAIT_GENERIC)
			ADD_TRAIT(H, TRAIT_HEAVYARMOR, TRAIT_GENERIC)
			H.change_stat("strength", 3)
			H.change_stat("endurance", 2) // 7 stat points total as a low-skill martial role without magic. Compared to Pally with 5 points.
			H.change_stat("constitution", 2)
			shoes = /obj/item/clothing/shoes/roguetown/boots
			gloves = /obj/item/clothing/gloves/roguetown/leather
			belt = /obj/item/storage/belt/rogue/leather
			neck = /obj/item/storage/belt/rogue/pouch/coins/poor
			shirt = /obj/item/clothing/suit/roguetown/shirt/undershirt/random
			if(prob(70))
				armor = /obj/item/clothing/suit/roguetown/armor/chainmail/hauberk
			else if(prob(50))
				armor = /obj/item/clothing/suit/roguetown/armor/plate/half/iron
			else
				armor = /obj/item/clothing/suit/roguetown/armor/plate/scale
			if(prob(20))
				head = /obj/item/clothing/head/roguetown/helmet/leather
			else if(prob(50))
				head = /obj/item/clothing/head/roguetown/helmet/skullcap
			else
				head = /obj/item/clothing/head/roguetown/helmet/kettle
			backl = /obj/item/storage/backpack/rogue/satchel
			backr = /obj/item/rogueweapon/shield/wood
			beltl = /obj/item/rogueweapon/huntingknife
			if(prob(50))
				beltr = /obj/item/rogueweapon/mace/
		if("Swift Warrior")
			H.set_blindness(0)
			to_chat(H, "<span class='warning'>Swift Warriors are able to evade their opponents while executing precise strikes, but only wear light armor.</span>")
			H.mind.adjust_skillrank(/datum/skill/combat/crossbows, 1, TRUE)
			H.mind.adjust_skillrank(/datum/skill/combat/bows, 3, TRUE)
			H.mind.adjust_skillrank(/datum/skill/combat/wrestling, 2, TRUE)
			H.mind.adjust_skillrank(/datum/skill/combat/unarmed, 2, TRUE)
			H.mind.adjust_skillrank(/datum/skill/misc/athletics, 3, TRUE)
			H.mind.adjust_skillrank(/datum/skill/combat/knives, 3, TRUE)
			H.mind.adjust_skillrank(/datum/skill/misc/sneaking, pick(2,2,3), TRUE)
			H.mind.adjust_skillrank(/datum/skill/misc/swimming, 2, TRUE)
			H.mind.adjust_skillrank(/datum/skill/misc/climbing, 2, TRUE)
			H.mind.adjust_skillrank(/datum/skill/misc/riding, pick(2,3), TRUE)
			H.mind.adjust_skillrank(/datum/skill/misc/medicine, 1, TRUE)
			H.mind.adjust_skillrank(/datum/skill/combat/swords, 3, TRUE)
			H.mind.adjust_skillrank(/datum/skill/combat/polearms, 2, TRUE)
			H.mind.adjust_skillrank(/datum/skill/combat/maces, 2, TRUE)
			H.change_stat("endurance", 2)
			H.change_stat("constitution", 2)
			H.change_stat("speed", 2)
			shoes = /obj/item/clothing/shoes/roguetown/boots
			gloves = /obj/item/clothing/gloves/roguetown/leather
			belt = /obj/item/storage/belt/rogue/leather
			neck = /obj/item/storage/belt/rogue/pouch/coins/poor
			shirt = /obj/item/clothing/suit/roguetown/shirt/undershirt/random
			backl = /obj/item/storage/backpack/rogue/satchel
			if(prob(33))
				head = /obj/item/clothing/head/roguetown/helmet/leather
				wrists = /obj/item/clothing/wrists/roguetown/bracers/leather
				armor = /obj/item/clothing/suit/roguetown/armor/leather/hide
				pants = /obj/item/clothing/under/roguetown/trou/leather
				beltr = /obj/item/rogueweapon/sword/sabre
				beltl = /obj/item/rogueweapon/huntingknife
			else if(prob(50))
				beltl = /obj/item/rogueweapon/huntingknife/idagger/steel				
				beltr = /obj/item/rogueweapon/huntingknife/idagger/steel
				armor = /obj/item/clothing/suit/roguetown/armor/leather/studded
				wrists = /obj/item/clothing/wrists/roguetown/bracers/leather
				pants = /obj/item/clothing/under/roguetown/trou/leather
			else
				beltr = /obj/item/rogueweapon/sword/sabre
				beltl = /obj/item/rogueweapon/huntingknife
				armor = /obj/item/clothing/suit/roguetown/armor/leather/studded
				wrists = /obj/item/clothing/wrists/roguetown/bracers/leather
				pants = /obj/item/clothing/under/roguetown/trou/leather

	if(H.gender == MALE)
		pants = /obj/item/clothing/under/roguetown/tights/black
	else
		H.underwear = "Femleotard"
		H.underwear_color = CLOTHING_BLACK
		H.update_body()
		pants = /obj/item/clothing/under/roguetown/tights/black
