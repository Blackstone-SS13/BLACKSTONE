/datum/advclass/ranger
	name = "Ranger"
	tutorial = "Rangers are a mix of hunters and rogues, staying in the shadows, but often being more friendly to others than a rogue, much more in touch with nature and more skilled in the arts of survival"
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
	outfit = /datum/outfit/job/roguetown/adventurer/ranger
	traits_applied = list(RTRAIT_MEDIUMARMOR)
	
	given_skills = list(
		"ranger" = list(
			/datum/skill/combat/swords = 2,
			/datum/skill/combat/polearms = 1,
			/datum/skill/combat/axesmaces = 2,
			/datum/skill/combat/crossbows = 3,
			/datum/skill/misc/athletics = 3,
			/datum/skill/combat/bows = list(4, 5, 5, 6),
			/datum/skill/combat/wrestling = 2,
			/datum/skill/combat/unarmed = 2,
			/datum/skill/combat/knives = 2,
			/datum/skill/misc/swimming = 4,
			/datum/skill/misc/climbing = 4,
			/datum/skill/craft/crafting = 2,
			/datum/skill/misc/reading = 1,
			/datum/skill/misc/sneaking = 3,
			/datum/skill/craft/tanning = 1,
			/datum/skill/labor/fishing = 1,
			/datum/skill/misc/sewing = 1,
			/datum/skill/labor/butchering = 1,
			/datum/skill/craft/traps = 1,
			/datum/skill/misc/medicine = 2,
			/datum/skill/craft/cooking = 1,
			/datum/skill/misc/riding = list(1, 2)
		),
		"gloom stalker" = list(
			/datum/skill/combat/swords = 3,
			/datum/skill/combat/polearms = 2,
			/datum/skill/combat/axesmaces = 3,
			/datum/skill/combat/crossbows = 2,
			/datum/skill/misc/athletics = 3,
			/datum/skill/combat/bows = 4,
			/datum/skill/combat/wrestling = 2,
			/datum/skill/combat/unarmed = 2,
			/datum/skill/combat/knives = 3,
			/datum/skill/misc/swimming = 3,
			/datum/skill/misc/climbing = 4,
			/datum/skill/craft/crafting = 1,
			/datum/skill/misc/reading = 2,
			/datum/skill/misc/sneaking = 4,
			/datum/skill/craft/traps = 1,
			/datum/skill/misc/medicine = 1,
			/datum/skill/craft/cooking = 1,
			/datum/skill/misc/riding = list(1, 2)
		)
	)

	stat_changes = list(
		"ranger" = list(
			"perception" = 4,
			"endurance" = 2,
			"speed" = 2
		),
		"gloom stalker" = list(
			"perception" = 2,
			"endurance" = 1,
			"speed" = 3
		)
	)

/datum/outfit/job/roguetown/adventurer/ranger/pre_equip(mob/living/carbon/human/H)
	..()
	H.adjust_blindness(-3)
	var/classes = list("Ranger","Gloom Stalker",) // Ranger Knight is the unique subclass. Gives you steel breastplate and a sword.
	var/classchoice = input("Choose your archetypes", "Available archetypes") as anything in classes
	H.mind.assign_experiences(/datum/advclass/ranger::given_skills, TRUE, "skills", lowertext(classchoice))
	H.mind.assign_experiences(/datum/advclass/ranger::stat_changes, TRUE, "stats", lowertext(classchoice))
	switch(classchoice)
	
		if("Ranger")
			H.set_blindness(0)
			to_chat(H, "<span class='warning'>Rangers are masters of nature, often hired as pathfinders, bodyguards and mercenaries in areas of wilderness untraversable to common soldiery.</span>")
			shoes = /obj/item/clothing/shoes/roguetown/boots/leather
			shirt = /obj/item/clothing/suit/roguetown/shirt/undershirt
			neck = /obj/item/storage/belt/rogue/pouch/coins/poor
			gloves = /obj/item/clothing/gloves/roguetown/leather
			wrists = /obj/item/clothing/wrists/roguetown/bracers/leather
			belt = /obj/item/storage/belt/rogue/leather
			armor = /obj/item/clothing/suit/roguetown/armor/leather/hide
			cloak = /obj/item/clothing/cloak/raincloak/brown
			cloak = /obj/item/clothing/cloak/raincloak/green
			backr = /obj/item/gun/ballistic/revolver/grenadelauncher/bow/recurve
			backl = /obj/item/storage/backpack/rogue/satchel
			beltr = /obj/item/flashlight/flare/torch/lantern
			backpack_contents = list(/obj/item/bait = 1, /obj/item/rogueweapon/huntingknife = 1)
			beltl = /obj/item/quiver/arrows

		if("Gloom Stalker")
			H.set_blindness(0)
			to_chat(H, "<span class='warning'>Rangers are masters of nature, often hired as pathfinders, bodyguards and mercenaries in areas of wilderness untraversable to common soldiery.</span>")
			shoes = /obj/item/clothing/shoes/roguetown/boots/leather
			shirt = /obj/item/clothing/suit/roguetown/shirt/undershirt
			neck = /obj/item/storage/belt/rogue/pouch/coins/poor
			gloves = /obj/item/clothing/gloves/roguetown/leather
			wrists = /obj/item/clothing/wrists/roguetown/bracers/leather
			belt = /obj/item/storage/belt/rogue/leather
			armor = /obj/item/clothing/suit/roguetown/armor/leather/studded
			cloak = /obj/item/clothing/cloak/cape/rogue
			backr = /obj/item/gun/ballistic/revolver/grenadelauncher/bow/recurve
			backl = /obj/item/storage/backpack/rogue/satchel
			beltr = /obj/item/flashlight/flare/torch/lantern
			backpack_contents = list(/obj/item/rogueweapon/huntingknife/idagger/steel/special = 1)
			beltl = /obj/item/quiver/arrows
		
	if(H.gender == MALE)
		pants = /obj/item/clothing/under/roguetown/trou/leather
		shirt = /obj/item/clothing/suit/roguetown/shirt/undershirt
	else
		pants = /obj/item/clothing/under/roguetown/tights
		if(prob(50))
			pants = /obj/item/clothing/under/roguetown/tights/black
			gloves = /obj/item/clothing/gloves/roguetown/fingerless
	
	ADD_TRAIT(H, RTRAIT_MEDIUMARMOR, TRAIT_GENERIC)
	if(prob(23))
		if(!H.has_language(/datum/language/elvish))
			H.grant_language(/datum/language/elvish)
			to_chat(H, "<span class='info'>I can speak Elfish with ,e before my speech.</span>")
