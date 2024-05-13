/datum/job/roguetown/goblincook
	title = "Goblin Cook"
	flag = GOBLINCOOK
	department_flag = GOBLIN
	faction = "Station"
	total_positions = 2
	spawn_positions = 2

	allowed_races = list("Goblin")
	tutorial = "Working closely with the barkeep who owns Skull Crack Inn, the cook should focus on cooking food for all the hungry mouths of Roguetown."

	outfit = /datum/outfit/job/roguetown/cook
	display_order = JDO_GOBLINCOOK
	min_pq = -10

/datum/outfit/job/roguetown/cook/pre_equip(mob/living/carbon/human/H)
	..()
	if(H.mind)
		H.mind.adjust_skillrank(/datum/skill/combat/knives, 1, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/reading, 1, TRUE)
		H.mind.adjust_skillrank(/datum/skill/craft/cooking, 4, TRUE)
		H.mind.adjust_skillrank(/datum/skill/craft/crafting, 1, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/sewing, 1, TRUE)
		H.mind.adjust_skillrank(/datum/skill/labor/butchering, 2, TRUE)
	belt = /obj/item/storage/belt/rogue/leather/rope
	beltl = /obj/item/roguekey/tavern
	cloak = /obj/item/clothing/cloak/apron/cook
	head = /obj/item/clothing/head/roguetown/cookhat
	neck = /obj/item/storage/belt/rogue/pouch/coins/poor
	H.change_stat("constitution", 2)
