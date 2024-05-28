
/datum/advclass/bard
	name = "Bard"
	tutorial = "Bards make up one of the largest populations of \
	registered adventurers in Enigma, mostly because they are \
	the last ones in a party to die. Their wish is to experience \
	the greatest adventures of the age and write amazing songs about them."
	allowed_sexes = list("male", "female")
	allowed_races = list(
		"Humen",
		"Elf",
		"Half-Elf",
		"Dwarf",
		"Tiefling",
		"Argonian",
		"Dark Elf",
		"Aasimar"
	)
	outfit = /datum/outfit/job/roguetown/adventurer/bard
	traits_applied = list(RTRAIT_MEDIUMARMOR)
	given_skills = list(
        "bard" = list(
            /datum/skill/combat/crossbows = 3, 
            /datum/skill/combat/polearms = 1, 
            /datum/skill/combat/axesmaces = 2, 
            /datum/skill/combat/bows = 3, 
            /datum/skill/combat/wrestling = 2, 
            /datum/skill/combat/unarmed = 3, 
            /datum/skill/misc/swimming = 2, 
            /datum/skill/misc/climbing = 3, 
            /datum/skill/misc/athletics = 2, 
            /datum/skill/combat/swords = 2, 
            /datum/skill/combat/knives = 3, 
            /datum/skill/misc/reading = 3, 
            /datum/skill/misc/sewing = 1, 
            /datum/skill/misc/sneaking = 2, 
            /datum/skill/misc/stealing = 2, 
            /datum/skill/misc/medicine = list(0,1), 
            /datum/skill/craft/cooking = 1, 
            /datum/skill/misc/riding = 1, 
            /datum/skill/misc/music = list(4,5)
        ),
        "skald" = list(
            /datum/skill/combat/crossbows = 2, 
            /datum/skill/combat/polearms = 2, 
            /datum/skill/combat/axesmaces = 3, 
            /datum/skill/combat/bows = 2, 
            /datum/skill/combat/wrestling = 2, 
            /datum/skill/combat/unarmed = 3, 
            /datum/skill/misc/swimming = 2, 
            /datum/skill/misc/climbing = 2, 
            /datum/skill/misc/athletics = 3, 
            /datum/skill/combat/swords = 3, 
            /datum/skill/combat/knives = 3, 
            /datum/skill/misc/reading = 3, 
            /datum/skill/misc/sewing = 1, 
            /datum/skill/misc/sneaking = 2, 
            /datum/skill/misc/stealing = 2, 
            /datum/skill/misc/medicine = list(0,1), 
            /datum/skill/craft/cooking = 1, 
            /datum/skill/misc/riding = 1, 
            /datum/skill/misc/music = list(3,5)
        )
	)
	stat_changes = list(
        "bard" = list(
            "intelligence" = 1, 
            "perception" = 2, 
            "endurance" = 1, 
            "speed" = 2
        ),
        "skald" = list(
            "constitution" = 2, 
            "strength" = 1, 
            "speed" = 1
        )
	)

	traits_applied = list(RTRAIT_MEDIUMARMOR, RTRAIT_DODGEEXPERT)


/datum/outfit/job/roguetown/adventurer/bard/pre_equip(mob/living/carbon/human/H)
	..() // The entertaining jack of all trades, uniquely handy with crossbows and swords. They're incredibly well travelled, can sneak, steal and survive on their own. 
	H.adjust_blindness(-3)
	var/classes = list("Bard","Skald",)
	var/classchoice = input("Choose your archetypes", "Available archetypes") as anything in classes
	H.mind.assign_experiences(/datum/advclass/bard::given_skills, TRUE, "skills", lowertext(classchoice))
	H.mind.assign_experiences(/datum/advclass/bard::stat_changes, TRUE, "stats", lowertext(classchoice))
	switch(classchoice)
		
		if("Bard")
			H.set_blindness(0)
			to_chat(H, "<span class='warning'>Bards make their fortunes in brothels, flop houses and taverns -- gaining fame for their songs and legends. If there is any truth to them, that is.</span>")
			head = /obj/item/clothing/head/roguetown/bardhat
			shoes = /obj/item/clothing/shoes/roguetown/boots
			pants = /obj/item/clothing/under/roguetown/tights/random
			shirt = /obj/item/clothing/suit/roguetown/shirt/shortshirt
			gloves = /obj/item/clothing/gloves/roguetown/fingerless
			belt = /obj/item/storage/belt/rogue/leather
			armor = /obj/item/clothing/suit/roguetown/armor/leather/vest
			cloak = /obj/item/clothing/cloak/raincloak/blue
			if(prob(50))
				cloak = /obj/item/clothing/cloak/raincloak/red
			backl = /obj/item/storage/backpack/rogue/satchel
			beltl = /obj/item/storage/belt/rogue/pouch/coins/poor
			beltr = /obj/item/rogueweapon/huntingknife/idagger/steel

		if("Skald")
			H.set_blindness(0)
			to_chat(H, "<span class='warning'>Skalds are wandering storytellers, and for many villages they are local historians keeping the tales of great legends and heroes alive.</span>")
			head = /obj/item/clothing/head/roguetown/bardhat
			shoes = /obj/item/clothing/shoes/roguetown/boots
			pants = /obj/item/clothing/under/roguetown/tights/random
			shirt = /obj/item/clothing/suit/roguetown/shirt/shortshirt
			gloves = /obj/item/clothing/gloves/roguetown/fingerless
			belt = /obj/item/storage/belt/rogue/leather
			armor = /obj/item/clothing/suit/roguetown/armor/leather/vest
			cloak = /obj/item/clothing/cloak/raincloak/blue
			if(prob(50))
				cloak = /obj/item/clothing/cloak/raincloak/red
			backl = /obj/item/storage/backpack/rogue/satchel
			l_hand = /obj/item/rogueweapon/huntingknife/idagger/steel
			beltl = /obj/item/storage/belt/rogue/pouch/coins/mid
			l_hand = /obj/item/rogueweapon/sword/iron


	if(H.dna?.species)
		if(iself(H) || ishalfelf(H))
			backr = /obj/item/rogue/instrument/harp
		else if(ishumannorthern(H))
			backr = /obj/item/rogue/instrument/lute
		else if(isdwarf(H))
			backr = /obj/item/rogue/instrument/accord
		else if(istiefling(H) || isargonian(H))
			backr = /obj/item/rogue/instrument/guitar
	ADD_TRAIT(H, RTRAIT_MEDIUMARMOR, TRAIT_GENERIC)
	ADD_TRAIT(H, RTRAIT_EMPATH, TRAIT_GENERIC)
	ADD_TRAIT(H, RTRAIT_DODGEEXPERT, TRAIT_GENERIC)
