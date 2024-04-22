/datum/advclass/miner
	name = "Miner"
	allowed_sexes = list("male")
	allowed_races = list("Humen",
	"Humen",
	"Dark Elf",
	"Tiefling",
	"Half-Elf",
	"Dwarf",
	"Dwarf",
	"Aasimar"
	)
	outfit = /datum/outfit/job/roguetown/adventurer/miner
	isvillager = TRUE
	ispilgrim = TRUE

/datum/outfit/job/roguetown/adventurer/miner/pre_equip(mob/living/carbon/human/H)
	..()
	head = /obj/item/clothing/head/roguetown/armingcap
	pants = /obj/item/clothing/under/roguetown/trou
	armor = /obj/item/clothing/suit/roguetown/armor/workervest
	shirt = /obj/item/clothing/suit/roguetown/shirt/undershirt/random
	shoes = /obj/item/clothing/shoes/roguetown/boots/leather
	belt = /obj/item/storage/belt/rogue/leather
	neck = /obj/item/storage/belt/rogue/pouch/coins/poor
	beltl = /obj/item/rogueweapon/pick
	beltr = /obj/item/rogueweapon/huntingknife
	backl = /obj/item/storage/backpack/rogue/backpack
	if(H.mind) // Miners have basic understanding of weapons from their exploration of deep underground. Generally not skilled in survival-craft, but they might kno whow to cook or fish from peasant life.
		H.mind.adjust_skillrank(/datum/skill/combat/swords, pick(0,0,0,1), TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/axesmaces, pick(1,1,2), TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/crossbows, pick(0,0,1), TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/athletics, pick(3,3,4), TRUE) // Tough. Well fed. The strongest of the strong.
		H.mind.adjust_skillrank(/datum/skill/combat/bows, pick(0,1,1,2), TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/wrestling, pick(1,2,2), TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/unarmed, pick(2,2,3), TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/knives, pick(2,2,3), TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/polearms, pick(1,1,2), TRUE) 
		H.mind.adjust_skillrank(/datum/skill/misc/swimming, pick(2,2,2,3), TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/climbing, pick(2,2,2,3), TRUE)
		H.mind.adjust_skillrank(/datum/skill/craft/crafting, pick(2,3,3,3,4), TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/reading, pick(0,1,1), TRUE)
		H.mind.adjust_skillrank(/datum/skill/labor/fishing, pick(0,0,1), TRUE)
		H.mind.adjust_skillrank(/datum/skill/craft/traps, pick(1,1,2), TRUE)
		H.mind.adjust_skillrank(/datum/skill/craft/engineering, pick(1,1,2), TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/medicine, pick(0,0,1), TRUE)
		H.mind.adjust_skillrank(/datum/skill/craft/carpentry, pick(0,0,1), TRUE)
		H.change_stat("intelligence", pick(-2,-1,-1,0)) // Mines aren't good for your brain.
		H.change_stat("strength", pick(1,2,2))
		H.change_stat("endurance", pick(1,2,2,3))
	backpack_contents = list(/obj/item/flint = 1)

