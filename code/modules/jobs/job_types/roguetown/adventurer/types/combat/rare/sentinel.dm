//elf ranger

/datum/advclass/sentinal
	name = "Sentinal"
	tutorial = "Humen and elf rangers often live among each other, as these bow-wielding \
	adventurers are often scouting the lands for the same purpose."
	allowed_sexes = list("male", "female")
	allowed_races = list("Elf",
	 "Half-Elf",
	 "Elf",
	 "Dark Elf")
	outfit = /datum/outfit/job/roguetown/adventurer/sentinal

/datum/outfit/job/roguetown/adventurer/sentinal/pre_equip(mob/living/carbon/human/H)
	..()
	shoes = /obj/item/clothing/shoes/roguetown/boots/leather
	H.mind.adjust_skillrank(/datum/skill/combat/knives, 3, TRUE)
	H.mind.adjust_skillrank(/datum/skill/combat/swords, 4, TRUE)
	H.mind.adjust_skillrank(/datum/skill/combat/polearms, 1, TRUE)
	H.mind.adjust_skillrank(/datum/skill/combat/bows, 6, TRUE)
	H.mind.adjust_skillrank(/datum/skill/craft/tanning, 1, TRUE)
	H.mind.adjust_skillrank(/datum/skill/combat/unarmed, 1, TRUE)
	H.mind.adjust_skillrank(/datum/skill/craft/crafting, 1, TRUE)
	H.mind.adjust_skillrank(/datum/skill/misc/swimming, 2, TRUE)
	H.mind.adjust_skillrank(/datum/skill/misc/climbing, 2, TRUE)
	H.mind.adjust_skillrank(/datum/skill/misc/riding, 3, TRUE)
	H.mind.adjust_skillrank(/datum/skill/misc/sewing, 3, TRUE)
	H.mind.adjust_skillrank(/datum/skill/misc/medicine, 2, TRUE)
	if(H.gender == MALE)
		pants = /obj/item/clothing/under/roguetown/trou/leather
		shirt = /obj/item/clothing/suit/roguetown/shirt/undershirt
	else
		pants = /obj/item/clothing/under/roguetown/tights/black
		shirt = /obj/item/clothing/suit/roguetown/shirt/undershirt
	gloves = /obj/item/clothing/gloves/roguetown/leather
	wrists = /obj/item/clothing/wrists/roguetown/bracers/leather
	belt = /obj/item/storage/belt/rogue/leather
	armor = /obj/item/clothing/suit/roguetown/armor/leather/hide
	cloak = /obj/item/clothing/cloak/raincloak/green
	backr = /obj/item/gun/ballistic/revolver/grenadelauncher/bow
	backl = /obj/item/storage/backpack/rogue/satchel
	beltr = /obj/item/flashlight/flare/torch/lantern
	backpack_contents = list(/obj/item/bait = 1, /obj/item/rogueweapon/huntingknife = 1)
	beltl = /obj/item/quiver/arrows
	H.change_stat("perception", 3)
	H.change_stat("endurance", 1)
	ADD_TRAIT(H, RTRAIT_MEDIUMARMOR, TRAIT_GENERIC)
	if(prob(23))
		if(!H.has_language(/datum/language/elvish))
			H.grant_language(/datum/language/elvish)
			to_chat(H, "<span class='info'>I can speak Elfish with ,e before my speech.</span>")
