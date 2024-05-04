//challenge class, spawns with no items at all
/datum/advclass/nudist
	name = "Nudist"
	tutorial = "You have come to this land wholly unprepared!\nSurvival will be a true TRIUMPH."
	allowed_sexes = list("male", "female")
	allowed_races = list("Humen",
	"Elf",
	"Dark Elf",
	"Half-Elf",
	"Tiefling",
	"Dwarf",
	"Dwarf",
	"Aasimar"
	)
	outfit = /datum/outfit/job/roguetown/adventurer/nudist
	traits_applied = list(RTRAIT_NUDIST)
	isvillager = FALSE
	ispilgrim = TRUE

/datum/outfit/job/roguetown/adventurer/nudist/pre_equip(mob/living/carbon/human/H)
	..()
	if(H.mind)
		H.mind.adjust_skillrank(/datum/skill/combat/wrestling, 5, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/unarmed, 6, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/knives, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/craft/crafting, 1, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/swimming, 3, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/climbing, 3, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/medicine, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/reading, 3, TRUE)
	H.change_stat("strength", 3)
	H.change_stat("endurance", 4)
	H.change_stat("constitution", 3)
	H.change_stat("intelligence", -3)
