/datum/advclass/monk
	name = "Monk"
	allowed_sexes = list("male", "female")
	tutorial = "A traveling monk of the God Ravox, unmatched in unarmed combat and with an unwavering devotion to Justice."
	allowed_races = list("Humen",
	"Humen",
	"Elf",
	"Elf",
	"Half-Elf",
	"Dwarf",
	"Aasimar"
	)
	outfit = /datum/outfit/job/roguetown/adventurer/monk
	isvillager = FALSE
	ispilgrim = FALSE
	vampcompat = FALSE


/datum/outfit/job/roguetown/adventurer/monk/pre_equip(mob/living/carbon/human/H)
	..()
	head = /obj/item/clothing/head/roguetown/roguehood
	neck = /obj/item/clothing/neck/roguetown/psicross
	shoes = /obj/item/clothing/shoes/roguetown/shortboots
	cloak = /obj/item/clothing/cloak/raincloak/furcloak/brown
	armor = /obj/item/clothing/suit/roguetown/shirt/robe
	belt = /obj/item/storage/belt/rogue/leather/rope
	beltl = /obj/item/storage/belt/rogue/pouch/coins/poor
	backl = /obj/item/storage/backpack/rogue/backpack
	r_hand = /obj/item/rogueweapon/woodstaff
	if(H.mind)
		H.mind.adjust_skillrank(/datum/skill/combat/swords, pick(0,0,0,1), TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/athletics, pick(2,2,3), TRUE) 
		H.mind.adjust_skillrank(/datum/skill/combat/bows, pick(0,0,1), TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/wrestling, pick(4,4,5), TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/unarmed, pick(4,5,5), TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/knives, pick(1,1,2), TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/polearms, pick(0,0,1), TRUE) 
		H.mind.adjust_skillrank(/datum/skill/misc/swimming, pick(0,1,1), TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/climbing, pick(2,3,3), TRUE)
		H.mind.adjust_skillrank(/datum/skill/craft/crafting, pick(0,1,1), TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/reading, pick(2,3,3), TRUE)
		H.mind.adjust_skillrank(/datum/skill/labor/butchering, pick(0,0,1), TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/medicine, pick(0,1,1), TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/sneaking, pick(1,2,2), TRUE)
		H.mind.adjust_skillrank(/datum/skill/craft/cooking, pick(0,1,1), TRUE)
		H.change_stat("intelligence", pick(0,1,1))
		H.change_stat("perception", pick(-1,-1,0))
		H.change_stat("strength", pick(2,3,3))
		H.change_stat("constitution", pick(0,0,1))
		H.change_stat("endurance", pick(0,1,1,2))
		H.change_stat("speed", pick(0,0,0,1))		

	if(H.PATRON != /datum/patrongods/ravox)
//		H.PATRON = GLOB.patronlist["Ravox"]
		H.PATRON = new /datum/patrongods/ravox
		to_chat(H, "<span class='warning'> My patron had not endorsed my practices in my younger years. I've since grown acustomed to [H.PATRON].")
