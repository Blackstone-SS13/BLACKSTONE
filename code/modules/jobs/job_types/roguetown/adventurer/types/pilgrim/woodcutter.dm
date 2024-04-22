/datum/advclass/woodcutter
	name = "Woodcutter"
	allowed_sexes = list("male")
	allowed_races = list("Humen",
	"Humen",
	"Elf",
	"Dark Elf",
	"Half-Elf",
	"Tiefling",
	"Dwarf",
	"Dwarf",
	"Aasimar"
	)
	outfit = /datum/outfit/job/roguetown/adventurer/woodcutter
	isvillager = TRUE
	ispilgrim = TRUE

/datum/outfit/job/roguetown/adventurer/woodcutter/pre_equip(mob/living/carbon/human/H)
	..()
	H.mind.adjust_skillrank(/datum/skill/combat/swords, pick(0,0,0,1), TRUE)
	H.mind.adjust_skillrank(/datum/skill/combat/axesmaces, pick(2,2,3), TRUE) // AXE MEN! GIVE ME SPLINTERS!
	H.mind.adjust_skillrank(/datum/skill/combat/crossbows, pick(0,1,1), TRUE)
	H.mind.adjust_skillrank(/datum/skill/misc/athletics, pick(2,2,3), TRUE) 
	H.mind.adjust_skillrank(/datum/skill/combat/bows, pick(0,0,1), TRUE)
	H.mind.adjust_skillrank(/datum/skill/combat/wrestling, pick(1,2,2), TRUE)
	H.mind.adjust_skillrank(/datum/skill/combat/unarmed, pick(1,2,2,3), TRUE)
	H.mind.adjust_skillrank(/datum/skill/combat/knives, pick(2,2,3), TRUE)
	H.mind.adjust_skillrank(/datum/skill/combat/polearms, pick(1,1,2), TRUE) 
	H.mind.adjust_skillrank(/datum/skill/misc/swimming, pick(1,2,2), TRUE)
	H.mind.adjust_skillrank(/datum/skill/misc/climbing, pick(1,2,2), TRUE)
	H.mind.adjust_skillrank(/datum/skill/craft/crafting, pick(2,3,3), TRUE)
	H.mind.adjust_skillrank(/datum/skill/craft/carpentry, pick(4,5,5), TRUE)
	H.mind.adjust_skillrank(/datum/skill/craft/masonry, pick(2,2,3), TRUE)
	H.mind.adjust_skillrank(/datum/skill/craft/engineering, pick(0,1,1), TRUE)
	H.mind.adjust_skillrank(/datum/skill/misc/sewing, pick(1,1,2), TRUE)
	H.mind.adjust_skillrank(/datum/skill/labor/butchering, pick(0,0,1), TRUE)
	H.mind.adjust_skillrank(/datum/skill/craft/traps, pick(0,1,1), TRUE)
	H.mind.adjust_skillrank(/datum/skill/misc/medicine, pick(0,1,1), TRUE)
	H.mind.adjust_skillrank(/datum/skill/craft/cooking, pick(0,1,1), TRUE)

	belt = /obj/item/storage/belt/rogue/leather
	shirt = /obj/item/clothing/suit/roguetown/shirt/shortshirt/random
	pants = /obj/item/clothing/under/roguetown/trou
	head = /obj/item/clothing/head/roguetown/roguehood
	shoes = /obj/item/clothing/shoes/roguetown/boots/leather
	backr = /obj/item/storage/backpack/rogue/satchel
	neck = /obj/item/storage/belt/rogue/pouch/coins/poor
	wrists = /obj/item/clothing/wrists/roguetown/bracers/leather
	armor = /obj/item/clothing/suit/roguetown/armor/workervest
	beltr = /obj/item/rogueweapon/stoneaxe/woodcut
	H.change_stat("strength", pick(0,1,1))
	H.change_stat("endurance", pick(1,2,2))
	beltl = /obj/item/rogueweapon/huntingknife
	backpack_contents = list(/obj/item/flint = 1)