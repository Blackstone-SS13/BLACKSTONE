/datum/advclass/heartfelthand
	name = "Hand of Heartfelt"
	tutorial = "You serve your lord as the royal hand, taking care of all diplomatic actions in your relm. \
	maybe one day you will become lord too."
	allowed_sexes = list("male")
	allowed_races = list("Humen")
	outfit = /datum/outfit/job/roguetown/adventurer/heartfelthand
	maxchosen = 1
	pickprob = 100
	traits_applied = list(RTRAIT_HEAVYARMOR, RTRAIT_SEEPRICES)

/datum/outfit/job/roguetown/adventurer/heartfelthand/pre_equip(mob/living/carbon/human/H)
	..()
	shirt = /obj/item/clothing/suit/roguetown/shirt/undershirt
	belt = /obj/item/storage/belt/rogue/leather/black
	shoes = /obj/item/clothing/shoes/roguetown/nobleboot
	pants = /obj/item/clothing/under/roguetown/tights/black
	armor = /obj/item/clothing/suit/roguetown/armor/heartfelt/hand
	neck = /obj/item/storage/belt/rogue/pouch/coins/rich
	gloves =/obj/item/clothing/gloves/roguetown/angle
	beltl = /obj/item/rogueweapon/sword/sabre/dec
	beltr = /obj/item/rogueweapon/huntingknife
	backr = /obj/item/storage/backpack/rogue/satchel/heartfelt
	mask = /obj/item/clothing/mask/rogue/spectacles/golden
	id = /obj/item/scomstone
	if(H.mind)
		H.mind.adjust_skillrank(/datum/skill/combat/axesmaces, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/medicine, 4, TRUE)
		H.mind.adjust_skillrank(/datum/skill/craft/cooking, 4, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/wrestling, 3, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/unarmed, 3, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/swords, 3, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/swimming, 3, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/climbing, 3, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/athletics, 3, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/reading, 4, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/riding, 2, TRUE)
		H.change_stat("strength", 2)
		H.change_stat("perception", 3)
		H.change_stat("intelligence", 3)
