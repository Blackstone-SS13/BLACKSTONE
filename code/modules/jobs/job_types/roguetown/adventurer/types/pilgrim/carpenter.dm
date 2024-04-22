/datum/advclass/carpenter
	name = "Carpenter"
	allowed_sexes = list("male", "female")
	allowed_races = list("Humen",
	"Humen",
	"Dwarf",
	"Dwarf",
	"Half-Elf",
	"Tiefling",
	"Elf",
	"Aasimar"
	)
	outfit = /datum/outfit/job/roguetown/adventurer/carpenter
	isvillager = TRUE
	ispilgrim = TRUE

/datum/outfit/job/roguetown/adventurer/carpenter/pre_equip(mob/living/carbon/human/H)
	..()
	if(H.mind)
		H.mind.adjust_skillrank(/datum/skill/combat/swords, pick(0,0,0,1), TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/axesmaces, pick(1,2,2,2), TRUE) // They use hammers, sawes and axes all day.
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
		H.mind.adjust_skillrank(/datum/skill/craft/engineering, pick(2,2,3), TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/reading, pick(2,2,3), TRUE)
		H.mind.adjust_skillrank(/datum/skill/labor/butchering, pick(0,0,1), TRUE)
		H.mind.adjust_skillrank(/datum/skill/craft/traps, pick(0,0,1), TRUE)
		H.mind.adjust_skillrank(/datum/skill/labor/farming, pick(0,0,1), TRUE)

		H.change_stat("strength", pick(0,1,1))
		H.change_stat("endurance", pick(1,2,2))

	head = /obj/item/clothing/head/roguetown/hatfur
	if(prob(50))
		head = /obj/item/clothing/head/roguetown/hatblu
	armor = /obj/item/clothing/suit/roguetown/armor/workervest
	pants = /obj/item/clothing/under/roguetown/trou
	shirt = /obj/item/clothing/suit/roguetown/shirt/undershirt/random
	shoes = /obj/item/clothing/shoes/roguetown/boots/leather
	belt = /obj/item/storage/belt/rogue/leather
	beltr = /obj/item/storage/belt/rogue/pouch/coins/poor
	beltl = /obj/item/rogueweapon/hammer/claw
	backl = /obj/item/storage/backpack/rogue/backpack
	backpack_contents = list(/obj/item/flint = 1, /obj/item/rogueweapon/huntingknife = 1)
		
