
/datum/advclass/rogue
	name = "Rogue"
	tutorial = "Where is the gold?"
	allowed_sexes = list("male", "female")
	allowed_races = list("Humen",
	"Humen",
	"Elf",
	"Dark Elf",
	"Half-Elf",
	"Dwarf",
	"Tiefling",
	"Aasimar")
	outfit = /datum/outfit/job/roguetown/adventurer/rogue

/datum/outfit/job/roguetown/adventurer/rogue/pre_equip(mob/living/carbon/human/H)
	..() // Low weapon skills but high stealth and knives. Good utility class.
	H.mind.adjust_skillrank(/datum/skill/combat/swords, pick(1,1,2), TRUE)
	H.mind.adjust_skillrank(/datum/skill/combat/axesmaces, pick(1,1,2), TRUE)
	H.mind.adjust_skillrank(/datum/skill/combat/crossbows, pick(1,2,2), TRUE)
	H.mind.adjust_skillrank(/datum/skill/misc/athletics, pick(0,1,1,2), TRUE)
	H.mind.adjust_skillrank(/datum/skill/combat/bows, pick(1,1,1,2,2,3), TRUE)
	H.mind.adjust_skillrank(/datum/skill/combat/wrestling, pick(1,2,2,2,2), TRUE)
	H.mind.adjust_skillrank(/datum/skill/combat/unarmed, pick(2,2,2,2,3), TRUE)
	H.mind.adjust_skillrank(/datum/skill/combat/knives, pick(2,3,3,3,3,4), TRUE)
	H.mind.adjust_skillrank(/datum/skill/combat/polearms, pick(0,1,1), TRUE)
	H.mind.adjust_skillrank(/datum/skill/misc/swimming, pick(2,2,2,3), TRUE)
	H.mind.adjust_skillrank(/datum/skill/misc/climbing, pick(2,2,2,3), TRUE)
	H.mind.adjust_skillrank(/datum/skill/craft/crafting, pick(1,1,1,2), TRUE)
	H.mind.adjust_skillrank(/datum/skill/misc/reading, pick(0,1,1), TRUE)
	H.mind.adjust_skillrank(/datum/skill/labor/fishing, pick(0,1,1,1,2), TRUE)
	H.mind.adjust_skillrank(/datum/skill/misc/sewing, pick(0,1,1,1,2), TRUE)
	H.mind.adjust_skillrank(/datum/skill/labor/butchering, pick(0,1,1,1,2), TRUE)
	H.mind.adjust_skillrank(/datum/skill/craft/traps, pick(1,1,1,2), TRUE)
	H.mind.adjust_skillrank(/datum/skill/craft/engineering, pick(0,1,1), TRUE)
	H.mind.adjust_skillrank(/datum/skill/misc/medicine, pick(0,1,1,1,2), TRUE)
	H.mind.adjust_skillrank(/datum/skill/misc/sneaking, pick(3,4,4,4,5,5), TRUE)
	H.mind.adjust_skillrank(/datum/skill/misc/stealing, pick(3,4,4,4,5,5), TRUE)
	H.mind.adjust_skillrank(/datum/skill/misc/riding, pick(1,1,1,2), TRUE)
	H.mind.adjust_skillrank(/datum/skill/craft/cooking, pick(1,1,1,2), TRUE)

	shoes = /obj/item/clothing/shoes/roguetown/boots
	neck = /obj/item/storage/belt/rogue/pouch/coins/poor
	pants = /obj/item/clothing/under/roguetown/trou/leather
	shirt = /obj/item/clothing/suit/roguetown/shirt/undershirt
	gloves = /obj/item/clothing/gloves/roguetown/leather
	if(prob(30))
		gloves = /obj/item/clothing/gloves/roguetown/fingerless
	belt = /obj/item/storage/belt/rogue/leather
	armor = /obj/item/clothing/suit/roguetown/armor/leather
	cloak = /obj/item/clothing/cloak/raincloak/mortus
	backl = /obj/item/storage/backpack/rogue/satchel
	beltr = /obj/item/rogueweapon/huntingknife/idagger/steel
	backr = /obj/item/gun/ballistic/revolver/grenadelauncher/crossbow
	beltl = /obj/item/quiver/bolts
	ADD_TRAIT(H, RTRAIT_MEDIUMARMOR, TRAIT_GENERIC)
	H.change_stat("intelligence", pick(0,0,1))
	H.change_stat("perception", pick(0,1,1,1,2))
	H.change_stat("strength", pick(-1,-1,0,0,0,1))
	H.change_stat("constitution", pick(0,0,0,0,0,1))
	H.change_stat("endurance", pick(0,0,0,0,0,1))
	H.change_stat("speed", pick(1,2,2,2,2,3))
