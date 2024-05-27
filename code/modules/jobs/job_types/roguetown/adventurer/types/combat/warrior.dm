//shield sword
/datum/advclass/sfighter
	name = "Warrior"
	tutorial = "Warriors are well balanced fighters, skilled in blades and capable of most other weapons. \
	they are an important member to most parties for their combat prowess, but not for much more"
	allowed_sexes = list("male", "female")
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
	traits_applied = list(RTRAIT_HEAVYARMOR)


	given_skills = list(
		"warrior" =list(
			/datum/skill/misc/sneaking = list(1,1,2), \
			/datum/skill/combat/crossbows = list(1,2), \
			/datum/skill/combat/polearms = 2, \
			/datum/skill/combat/axesmaces = 2, \
			/datum/skill/combat/bows = list(1,2), \
			/datum/skill/combat/wrestling = 2, \
			/datum/skill/combat/unarmed = 2, \
			/datum/skill/misc/athletics = 4, \
			/datum/skill/combat/swords = 3, \
			/datum/skill/misc/swimming = 1, \
			/datum/skill/misc/climbing = 2, \
			/datum/skill/misc/riding = list(2,3), \
			/datum/skill/misc/medicine = 1, \
			/datum/skill/combat/knives = list(1,3)
		),
		"monster hunter" = list(
			/datum/skill/combat/crossbows = list(1, 2),
			/datum/skill/combat/bows = list(1, 2),
			/datum/skill/combat/wrestling = 2,
			/datum/skill/combat/unarmed = 2,
			/datum/skill/misc/athletics = 4,
			/datum/skill/combat/knives = list(1, 2, 3),
			/datum/skill/misc/sneaking = list(1, 1, 2),
			/datum/skill/misc/swimming = 1,
			/datum/skill/misc/climbing = 2,
			/datum/skill/misc/riding = list(2, 3),
			/datum/skill/misc/medicine = 1
		)
	) 

	stat_changes = list(
		"warrior" =list(
			"strength" = 2,
			"endurance" = 2,
			"constitution" = 2,
			"speed" = 1
		),
		"monster hunter"= list(
			"strength" = 2,
			"endurance" = 1,
			"constitution" = 2,
			"intelligence" = 1,
			"speed" = 1
		)

	)

/datum/outfit/job/roguetown/adventurer/sfighter/pre_equip(mob/living/carbon/human/H)
	..()
	H.adjust_blindness(-3)
	var/classes = list("Warrior","Monster Hunter") // To Do - knight errant unique archetype(5 percent chance)
	var/classchoice = input("Choose your archetypes", "Available archetypes") as anything in classes
	H.mind.assign_experiences(/datum/advclass/sfighter::given_skills, TRUE, "skills", lowertext(classchoice))
	H.mind.assign_experiences(/datum/advclass/sfighter::stat_changes, TRUE, "stats", lowertext(classchoice))
	switch(classchoice)
	
		if("Warrior")
			H.set_blindness(0)
			to_chat(H, "<span class='warning'>Warriors are well rounded fighters, experienced often in many theaters of warfare and battle they are capable of rising to any challenge that might greet them on the path.</span>")
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
				mask = /obj/item/clothing/mask/rogue/facemask
			else if(prob(60))
				head = /obj/item/clothing/head/roguetown/helmet/leather
			else if(prob(20))
				head = /obj/item/clothing/head/roguetown/helmet/skullcap
			else
				head = /obj/item/clothing/head/roguetown/helmet/kettle
			backl = /obj/item/storage/backpack/rogue/satchel
			backr = /obj/item/rogueweapon/shield/wood
			beltl = /obj/item/rogueweapon/huntingknife
			if(prob(50))
				beltr = /obj/item/rogueweapon/sword/iron
			else
				beltr = /obj/item/rogueweapon/sword/sabre
		if("Monster Hunter")
			H.set_blindness(0)
			to_chat(H, "<span class='warning'>Monsters Hunters are typically contracted champions of the common folk dedicated to the slaying of both lesser vermin and greater beasts of the wilds.</span>")
			shoes = /obj/item/clothing/shoes/roguetown/boots
			gloves = /obj/item/clothing/gloves/roguetown/leather
			belt = /obj/item/storage/belt/rogue/leather
			neck = /obj/item/storage/belt/rogue/pouch/coins/poor
			shirt = /obj/item/clothing/suit/roguetown/shirt/undershirt/random
			if(prob(40))
				armor = /obj/item/clothing/suit/roguetown/armor/chainmail/hauberk
				H.mind.adjust_skillrank(/datum/skill/combat/swords, 3, TRUE)
				H.mind.adjust_skillrank(/datum/skill/combat/polearms, 2, TRUE)
				H.mind.adjust_skillrank(/datum/skill/combat/axesmaces, 2, TRUE)
				backr = /obj/item/rogueweapon/sword/long
			else if(prob(60))
				armor = /obj/item/clothing/suit/roguetown/armor/plate/half/iron
				H.mind.adjust_skillrank(/datum/skill/combat/swords, 2, TRUE)
				H.mind.adjust_skillrank(/datum/skill/combat/polearms, 3, TRUE)
				H.mind.adjust_skillrank(/datum/skill/combat/axesmaces, 2, TRUE)
				r_hand = /obj/item/rogueweapon/spear/billhook
			else
				armor = /obj/item/clothing/suit/roguetown/armor/plate/scale // No helms for monster hunters.
				H.mind.adjust_skillrank(/datum/skill/combat/swords, 2, TRUE)
				H.mind.adjust_skillrank(/datum/skill/combat/polearms, 2, TRUE)
				H.mind.adjust_skillrank(/datum/skill/combat/axesmaces, 3, TRUE)
				backr = /obj/item/rogueweapon/stoneaxe/battle
			backl = /obj/item/storage/backpack/rogue/satchel
			beltl = /obj/item/rogueweapon/huntingknife
	if(H.gender == MALE)
		pants = /obj/item/clothing/under/roguetown/tights/black
	else
		H.underwear = "Femleotard"
		H.underwear_color = CLOTHING_BLACK
		H.update_body()
		pants = /obj/item/clothing/under/roguetown/tights/black

	ADD_TRAIT(H, RTRAIT_HEAVYARMOR, TRAIT_GENERIC)
	ADD_TRAIT(H, RTRAIT_MEDIUMARMOR, TRAIT_GENERIC)
