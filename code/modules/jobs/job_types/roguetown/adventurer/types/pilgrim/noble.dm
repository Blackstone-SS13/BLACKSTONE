/datum/advclass/noble
	name = "Noble"
	allowed_sexes = list("male", "female")
	allowed_races = list("Humen",
	"Humen",
	"Elf",
	"Half-Elf",
	"Aasimar"
	)
	outfit = /datum/outfit/job/roguetown/adventurer/noble
	isvillager = TRUE
	ispilgrim = TRUE


/datum/outfit/job/roguetown/adventurer/noble/pre_equip(mob/living/carbon/human/H)
	..()
	H.mind.adjust_skillrank(/datum/skill/combat/knives, 1, TRUE)
	H.mind.adjust_skillrank(/datum/skill/misc/reading, 1, TRUE)
	H.mind.adjust_skillrank(/datum/skill/misc/riding, 1, TRUE)
	H.change_stat("intelligence", 1)
	shoes = /obj/item/clothing/shoes/roguetown/nobleboot
	beltl = /obj/item/rogueweapon/huntingknife/idagger/steel
	beltr = /obj/item/flashlight/flare/torch/lantern
	backl = /obj/item/storage/backpack/rogue/satchel
	r_hand = /obj/item/clothing/ring/silver
	neck = /obj/item/storage/belt/rogue/pouch/coins/rich
	if(H.gender == FEMALE)
		H.mind.adjust_skillrank(/datum/skill/misc/sewing, 1, TRUE)
		H.mind.adjust_skillrank(/datum/skill/craft/crafting, 1, TRUE)
		H.mind.adjust_skillrank(/datum/skill/craft/cooking, 1, TRUE)
		H.change_stat("strength", -2)
		armor = /obj/item/clothing/suit/roguetown/shirt/dress/gen/purple
		head = /obj/item/clothing/head/roguetown/hatblu
	if(H.gender == MALE)
		H.change_stat("strength", -1)
		H.mind.adjust_skillrank(/datum/skill/combat/bows, 1, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/swords, 1, TRUE)
		pants = /obj/item/clothing/under/roguetown/tights/purple
		shirt = /obj/item/clothing/suit/roguetown/shirt/undershirt/purple
		cloak = /obj/item/clothing/cloak/half
		head = /obj/item/clothing/head/roguetown/fancyhat
	if(prob(23))
		beltl = /obj/item/rogueweapon/sickle
	else if(prob(23))
		backr = /obj/item/rogueweapon/thresher
	else if(prob(23))
		backr = /obj/item/rogueweapon/hoe
	else
		backr = /obj/item/rogueweapon/pitchfork



