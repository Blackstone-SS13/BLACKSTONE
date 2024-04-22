/datum/advclass/ranger
	name = "Ranger"
	tutorial = "Humen and elf rangers often live among each other, as these bow-wielding \
	adventurers are often scouting the lands for the same purpose."
	allowed_sexes = list("male", "female")
	allowed_races = list("Humen",
	"Humen",
	 "Elf",
	 "Half-Elf",
	 "Elf",
	 "Dark Elf",
	 "Tiefling",
	"Aasimar")
	outfit = /datum/outfit/job/roguetown/adventurer/ranger

/datum/outfit/job/roguetown/adventurer/ranger/pre_equip(mob/living/carbon/human/H)
	..() // Similar to Hunter for obvious reasons. Worse skill curve for hunting/survival skills. Better combat curve. Showcasing the differences between a Ranger and a Hunter.
	H.mind.adjust_skillrank(/datum/skill/combat/swords, pick(1,2,2,2,2), TRUE)
	H.mind.adjust_skillrank(/datum/skill/combat/axesmaces, pick(1,2,2,2,2), TRUE)
	H.mind.adjust_skillrank(/datum/skill/combat/crossbows, pick(3,3,3,3,4), TRUE)
	H.mind.adjust_skillrank(/datum/skill/misc/athletics, pick(0,1,1,2), TRUE)
	H.mind.adjust_skillrank(/datum/skill/combat/bows, pick(4,4,4,4,5), TRUE)
	H.mind.adjust_skillrank(/datum/skill/combat/wrestling, pick(1,2,2,2,2), TRUE)
	H.mind.adjust_skillrank(/datum/skill/combat/unarmed, pick(1,2,2,2,2), TRUE)
	H.mind.adjust_skillrank(/datum/skill/combat/knives, pick(1,2,2,3), TRUE)
	H.mind.adjust_skillrank(/datum/skill/combat/polearms, pick(0,0,1,2), TRUE)
	H.mind.adjust_skillrank(/datum/skill/misc/swimming, pick(2,2,2,3), TRUE)
	H.mind.adjust_skillrank(/datum/skill/misc/climbing, pick(2,2,2,3), TRUE)
	H.mind.adjust_skillrank(/datum/skill/craft/crafting, pick(1,1,1,2), TRUE)
	H.mind.adjust_skillrank(/datum/skill/misc/reading, pick(0,0,1,1,1), TRUE)
	H.mind.adjust_skillrank(/datum/skill/misc/sneaking, pick(2,2,2,3,4), TRUE)
	H.mind.adjust_skillrank(/datum/skill/craft/tanning, pick(1,1,2), TRUE)
	H.mind.adjust_skillrank(/datum/skill/labor/fishing, pick(1,1,2), TRUE)
	H.mind.adjust_skillrank(/datum/skill/misc/sewing, pick(1,1,2), TRUE)
	H.mind.adjust_skillrank(/datum/skill/labor/butchering, pick(1,1,2), TRUE)
	H.mind.adjust_skillrank(/datum/skill/craft/traps, pick(1,2,2,2,2), TRUE)
	H.mind.adjust_skillrank(/datum/skill/misc/medicine, pick(1,2,2,2), TRUE)
	H.mind.adjust_skillrank(/datum/skill/craft/cooking, pick(1,1,2), TRUE)
	H.mind.adjust_skillrank(/datum/skill/misc/riding, pick(1,1,2), TRUE)

	shoes = /obj/item/clothing/shoes/roguetown/boots/leather
	if(H.gender == MALE)
		pants = /obj/item/clothing/under/roguetown/trou/leather
		shirt = /obj/item/clothing/suit/roguetown/shirt/undershirt
	else
		pants = /obj/item/clothing/under/roguetown/tights
		if(prob(50))
			pants = /obj/item/clothing/under/roguetown/tights/black
		shirt = /obj/item/clothing/suit/roguetown/shirt/undershirt
	if(prob(23))
		gloves = /obj/item/clothing/gloves/roguetown/leather
	else
		gloves = /obj/item/clothing/gloves/roguetown/fingerless
	wrists = /obj/item/clothing/wrists/roguetown/bracers/leather
	belt = /obj/item/storage/belt/rogue/leather
	armor = /obj/item/clothing/suit/roguetown/armor/leather/hide
	cloak = /obj/item/clothing/cloak/raincloak/brown
	if(prob(33))
		cloak = /obj/item/clothing/cloak/raincloak/green
	backr = /obj/item/gun/ballistic/revolver/grenadelauncher/bow
	backl = /obj/item/storage/backpack/rogue/satchel
	beltr = /obj/item/flashlight/flare/torch/lantern
	backpack_contents = list(/obj/item/bait = 1, /obj/item/rogueweapon/huntingknife = 1)
	beltl = /obj/item/quiver/arrows
	H.change_stat("intelligence", pick(0,0,0,1)) // Compared to Hunter quite similar stat wise. But their stat-curve has no penalties and stronger positive bias.
	H.change_stat("perception", pick(0,1,1,2,3))
	H.change_stat("strength", pick(0,0,0,1))
	H.change_stat("constitution", pick(0,0,0,1))
	H.change_stat("endurance", pick(0,0,0,1))
	H.change_stat("speed", pick(0,1,1,1,2))
	ADD_TRAIT(H, RTRAIT_MEDIUMARMOR, TRAIT_GENERIC)
	if(prob(23))
		if(!H.has_language(/datum/language/elvish))
			H.grant_language(/datum/language/elvish)
			to_chat(H, "<span class='info'>I can speak Elfish with ,e before my speech.</span>")
