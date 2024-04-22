
/datum/advclass/bard
	name = "Bard"
	tutorial = "A travelling musician on the road, you've seen more places then most and have learned to survive in both wilderness and civilized towns. You do what you have to get by, and it's better then most."
	allowed_sexes = list("male", "female")
	allowed_races = list("Humen",
	"Humen",
	"Half-Elf",
	"Elf",
	"Elf",
	"Dwarf",
	"Dwarf",
	"Tiefling",
	"Aasimar"
	)
	outfit = /datum/outfit/job/roguetown/adventurer/bard

/datum/outfit/job/roguetown/adventurer/bard/pre_equip(mob/living/carbon/human/H)
	..() // The entertaining jack of all trades, uniquely handy with crossbows and swords. They're incredibly well travelled, can sneak, steal and survive on their own. 
	H.mind.adjust_skillrank(/datum/skill/combat/crossbows, pick(1,2,2,2,3), TRUE)
	H.mind.adjust_skillrank(/datum/skill/combat/polearms, pick(0,1,1,1,2), TRUE)
	H.mind.adjust_skillrank(/datum/skill/combat/axesmaces, pick(1,2,2,2,2), TRUE)
	H.mind.adjust_skillrank(/datum/skill/combat/bows, pick(1,1,1,2), TRUE)
	H.mind.adjust_skillrank(/datum/skill/combat/wrestling, pick(1,2,2,2), TRUE)
	H.mind.adjust_skillrank(/datum/skill/combat/unarmed, pick(1,2,2,2,3), TRUE)
	H.mind.adjust_skillrank(/datum/skill/misc/swimming, pick(1,2,2), TRUE)
	H.mind.adjust_skillrank(/datum/skill/misc/climbing, pick(1,2,2), TRUE)
	H.mind.adjust_skillrank(/datum/skill/misc/athletics, pick(2,2,2,3), TRUE)
	H.mind.adjust_skillrank(/datum/skill/combat/swords, pick(1,2,2,2,3), TRUE)
	H.mind.adjust_skillrank(/datum/skill/combat/knives, pick(1,1,2,2,2,3), TRUE)
	H.mind.adjust_skillrank(/datum/skill/misc/reading, pick(1,2,2,2,3), TRUE)
	H.mind.adjust_skillrank(/datum/skill/misc/sewing, pick(1,1,1,2), TRUE)
	H.mind.adjust_skillrank(/datum/skill/misc/sneaking, pick(1,2,2), TRUE)
	H.mind.adjust_skillrank(/datum/skill/misc/stealing, pick(2,2,3), TRUE)
	H.mind.adjust_skillrank(/datum/skill/misc/medicine, pick(0,1,1), TRUE)
	H.mind.adjust_skillrank(/datum/skill/craft/cooking, pick(1,1,2), TRUE)
	H.mind.adjust_skillrank(/datum/skill/misc/riding, pick(1,1,2), TRUE)
	H.mind.adjust_skillrank(/datum/skill/misc/music, rand(3,5), TRUE)

	head = /obj/item/clothing/head/roguetown/bardhat
	shoes = /obj/item/clothing/shoes/roguetown/boots
	pants = /obj/item/clothing/under/roguetown/tights/random
	shirt = /obj/item/clothing/suit/roguetown/shirt/shortshirt
	gloves = /obj/item/clothing/gloves/roguetown/fingerless
	belt = /obj/item/storage/belt/rogue/leather
	armor = /obj/item/clothing/suit/roguetown/armor/leather/vest
	cloak = /obj/item/clothing/cloak/raincloak/blue
	if(prob(50))
		cloak = /obj/item/clothing/cloak/raincloak/red
	backl = /obj/item/storage/backpack/rogue/satchel
	beltr = /obj/item/rogueweapon/huntingknife/idagger/steel
	beltl = /obj/item/storage/belt/rogue/pouch/coins/poor
	if(H.dna?.species)
		if(H.dna.species.id == "human")
			backr = /obj/item/rogue/instrument/lute
		if(H.dna.species.id == "dwarf")
			backr = /obj/item/rogue/instrument/accord
		if(H.dna.species.id == "elf")
			backr = /obj/item/rogue/instrument/harp
		if(H.dna.species.id == "tiefling")
			backr = /obj/item/rogue/instrument/guitar
		else
			backr = /obj/item/rogue/instrument/lute
	ADD_TRAIT(H, RTRAIT_MEDIUMARMOR, TRAIT_GENERIC)
	ADD_TRAIT(H, RTRAIT_EMPATH, TRAIT_GENERIC)
	H.change_stat("intelligence", pick(1,2,2))
	H.change_stat("perception", pick(0,0,1))
	H.change_stat("strength", pick(-1,0,0,0,1))
	H.change_stat("constitution", pick(-1,0,0,0,1))
	H.change_stat("endurance", pick(-1,0,0,0,1))
	H.change_stat("speed", pick(1,2,2))
