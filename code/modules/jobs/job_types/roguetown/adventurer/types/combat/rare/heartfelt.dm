
/datum/advclass/heartfeltlord
	name = "Lord of Heartfelt"
	tutorial = "You are the proud lord of heartfelt \
	but why did you come to the isle of enigma?"
	allowed_sexes = list("male")
	allowed_races = list("Humen")
	outfit = /datum/outfit/job/roguetown/adventurer/heartfeltlord
	maxchosen = 1
	pickprob = 100

/datum/outfit/job/roguetown/adventurer/heartfeltlord/pre_equip(mob/living/carbon/human/H)
	..()
	shirt = /obj/item/clothing/suit/roguetown/shirt/undershirt
	belt = /obj/item/storage/belt/rogue/leather/black
	shoes = /obj/item/clothing/shoes/roguetown/nobleboot
	pants = /obj/item/clothing/under/roguetown/tights/black
	cloak = /obj/item/clothing/cloak/heartfelt
	armor = /obj/item/clothing/suit/roguetown/armor/heartfelt/lord
	neck = /obj/item/storage/belt/rogue/pouch/coins/rich
	beltl = /obj/item/rogueweapon/sword/long/marlin
	beltr = /obj/item/rogueweapon/huntingknife
	gloves = /obj/item/clothing/gloves/roguetown/leather/black
	backl = /obj/item/storage/backpack/rogue/satchel
	id = /obj/item/scomstone
	if(H.mind)
		H.mind.adjust_skillrank(/datum/skill/combat/crossbows, pick(2,2,2,2,3,3,4), TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/polearms, pick(1,2,2), TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/axesmaces, pick(1,2,2), TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/bows, pick(2,2,2,2,3,3,4), TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/wrestling, pick(1,1,1,2), TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/unarmed, pick(1,1,1,2), TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/swimming, pick(1,2,2), TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/climbing, pick(1,1,1,2), TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/athletics, pick(2,3,3,3,3,4), TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/swords, pick(3,3,3,4,4,5), TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/knives, pick(1,1,2,2,2,3), TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/reading, pick(3,4,4,4,4,5), TRUE)
		H.mind.adjust_skillrank(/datum/skill/craft/crafting, pick(0,0,0,0,1), TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/sneaking, pick(1,2,2), TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/medicine, pick(0,0,1), TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/riding, pick(2,3,3,3,4), TRUE)

		H.change_stat("intelligence", pick(1,2,2))
		H.change_stat("perception", pick(1,2,2))
		H.change_stat("strength", pick(0,0,1))
		H.change_stat("constitution", pick(-1,0,0,0,1))
		H.change_stat("endurance", pick(1,2,2))
		H.change_stat("speed", pick(0,0,1))
		H.change_stat("fortune", rand(3,5))

	ADD_TRAIT(H, RTRAIT_NOBLE, TRAIT_GENERIC)
	ADD_TRAIT(H, RTRAIT_MEDIUMARMOR, TRAIT_GENERIC)
	ADD_TRAIT(H, RTRAIT_NOSEGRAB, TRAIT_GENERIC)
	ADD_TRAIT(H, RTRAIT_HEAVYARMOR, TRAIT_GENERIC)
