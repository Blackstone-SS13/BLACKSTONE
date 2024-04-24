
/datum/advclass/cyclops
	name = "Cyclops"
	tutorial = "What makes me a good Cyclops? If I were a bad Cyclops, I wouldn't be sittin' here, describin' it to you now would I? 'm a drunk, bloody cyclops."
  allowed_sexes = list("male")
	allowed_races = list("Humen",
	"Dwarf",
	)

	allowed_flaws = list("Cyclops (R)", 
	"Cyclops (L)"
	)

	outfit = /datum/outfit/job/roguetown/adventurer/cyclops
	maxchosen = 3

/datum/outfit/job/roguetown/adventurer/cyclops/pre_equip(mob/living/carbon/human/H)
	..()
	pants = /obj/item/clothing/under/roguetown/trou/leather
	shoes = /obj/item/clothing/shoes/roguetown/boots
	belt = /obj/item/storage/belt/rogue/leather
	armor = /obj/item/clothing/suit/roguetown/armor/leather/studded
	backr = /obj/item/rogueweapon/shield/wood
	backl = /obj/item/storage/backpack/rogue/backpack
	backpack_contents = list(/obj/item/bomb = 3, /obj/item/flint = 1, /obj/item/reagent_containers/glass/bottle/rogue/wine = 2,)
	beltl = /obj/item/rogueweapon/sword/cutlass

	H.mind.adjust_skillrank(/datum/skill/combat/axesmaces, 3, TRUE)
	H.mind.adjust_skillrank(/datum/skill/combat/swords, 4, TRUE)
	H.mind.adjust_skillrank(/datum/skill/combat/unarmed, 2, TRUE)
	H.mind.adjust_skillrank(/datum/skill/combat/wrestling, 2, TRUE)
	H.mind.adjust_skillrank(/datum/skill/craft/crafting, 2, TRUE)
	H.mind.adjust_skillrank(/datum/skill/misc/climbing, 1, TRUE)
	H.mind.adjust_skillrank(/datum/skill/misc/sewing, -1, TRUE)
	H.mind.adjust_skillrank(/datum/skill/misc/athletics, 2, TRUE)
	H.change_stat("constitution", -1)
	H.change_stat("speed", 1)
	H.change_stat("strength", 3)
	H.change_stat("endurance", 2)
	H.change_stat("intelligence", -3)
	ADD_TRAIT(H, RTRAIT_HEAVYARMOR, TRAIT_GENERIC)
  
