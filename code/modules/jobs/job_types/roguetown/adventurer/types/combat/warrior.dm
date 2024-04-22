//shield sword
/datum/advclass/sfighter
	name = "Warrior"
	tutorial = "Warriors are the heart of any party, hidden behind a large shield with the courage to take on any foe."
	allowed_sexes = list("male", "female")
	allowed_races = list("Humen",
	"Humen",
	"Elf",
	"Elf",
	"Half-Elf",
	"Dark Elf",
	"Tiefling")
	outfit = /datum/outfit/job/roguetown/adventurer/sfighter


/datum/outfit/job/roguetown/adventurer/sfighter/pre_equip(mob/living/carbon/human/H)
	..()
	H.mind.adjust_skillrank(/datum/skill/combat/crossbows, pick(1,1,1,2), TRUE)
	H.mind.adjust_skillrank(/datum/skill/combat/polearms, pick(2,2,2,3,3,3), TRUE)
	H.mind.adjust_skillrank(/datum/skill/combat/axesmaces, pick(2,2,3,3,3,3,4), TRUE)
	H.mind.adjust_skillrank(/datum/skill/combat/bows, pick(0,1,1), TRUE)
	H.mind.adjust_skillrank(/datum/skill/combat/wrestling, pick(1,2,2,2), TRUE)
	H.mind.adjust_skillrank(/datum/skill/combat/unarmed, pick(1,2,2,2,3), TRUE)
	H.mind.adjust_skillrank(/datum/skill/misc/athletics, pick(2,2,2,3), TRUE)
	H.mind.adjust_skillrank(/datum/skill/combat/swords, pick(2,3,3,3,3,3,4), TRUE)
	H.mind.adjust_skillrank(/datum/skill/combat/knives, pick(2,2,2,3), TRUE)
	H.mind.adjust_skillrank(/datum/skill/misc/sneaking, pick(0,1,1), TRUE)
	H.mind.adjust_skillrank(/datum/skill/craft/crafting, pick(0,1,1,1), TRUE)
	H.mind.adjust_skillrank(/datum/skill/misc/swimming, pick(0,1,1,1,2), TRUE)
	H.mind.adjust_skillrank(/datum/skill/misc/climbing, pick(1,1,2), TRUE)
	H.mind.adjust_skillrank(/datum/skill/misc/riding, pick(1,2,2,2,3,3), TRUE)
	H.mind.adjust_skillrank(/datum/skill/craft/cooking, pick(0,1,1), TRUE)
	H.mind.adjust_skillrank(/datum/skill/labor/butchering, pick(0,1,1), TRUE)
	H.mind.adjust_skillrank(/datum/skill/craft/traps, pick(0,0,1), TRUE)
	if(H.gender == MALE)
		pants = /obj/item/clothing/under/roguetown/tights/black
	else
		H.underwear = "Femleotard"
		H.underwear_color = CLOTHING_BLACK
		H.update_body()
		pants = /obj/item/clothing/under/roguetown/tights/black
	shoes = /obj/item/clothing/shoes/roguetown/boots
	gloves = /obj/item/clothing/gloves/roguetown/leather
	belt = /obj/item/storage/belt/rogue/leather
	neck = /obj/item/storage/belt/rogue/pouch/coins/poor
	shirt = /obj/item/clothing/suit/roguetown/shirt/undershirt/random
	armor = /obj/item/clothing/suit/roguetown/armor/chainmail
	backl = /obj/item/storage/backpack/rogue/satchel
	backr = /obj/item/rogueweapon/shield/wood
	beltl = /obj/item/rogueweapon/huntingknife
	if(H.gender == MALE)
		beltr = /obj/item/rogueweapon/sword/iron
	else
		beltr = /obj/item/rogueweapon/sword/sabre

	H.change_stat("intelligence", pick(0,0,0,1))
	H.change_stat("perception", pick(0,1,1,1,2))
	H.change_stat("strength", pick(0,0,1,1,1))
	H.change_stat("constitution", pick(0,0,1,1,1))
	H.change_stat("endurance", pick(0,0,1,1,1))
	H.change_stat("speed", pick(0,1,1,1,2))
	ADD_TRAIT(H, RTRAIT_HEAVYARMOR, TRAIT_GENERIC)
	ADD_TRAIT(H, RTRAIT_MEDIUMARMOR	, TRAIT_GENERIC)
	ADD_TRAIT(H, TRAIT_STEELHEARTED, TRAIT_GENERIC)