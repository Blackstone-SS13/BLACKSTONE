/datum/advclass/hunter
	name = "Hunter"
	allowed_sexes = list("male", "female")
	allowed_races = list("Humen",
	"Humen",
	"Elf",
	"Elf",
	"Half-Elf",
	"Tiefling",
	"Dark Elf",
	"Dwarf",
	"Aasimar"
	)
	outfit = /datum/outfit/job/roguetown/adventurer/hunter
	isvillager = TRUE
	ispilgrim = TRUE

/datum/outfit/job/roguetown/adventurer/hunter/pre_equip(mob/living/carbon/human/H)
	..()
	pants = /obj/item/clothing/under/roguetown/tights/random
	shirt = /obj/item/clothing/suit/roguetown/shirt/shortshirt/random
	shoes = /obj/item/clothing/shoes/roguetown/boots/leather
	neck = /obj/item/storage/belt/rogue/pouch/coins/poor
	cloak = /obj/item/clothing/cloak/raincloak/furcloak/brown
	backr = /obj/item/storage/backpack/rogue/satchel
	backl = /obj/item/gun/ballistic/revolver/grenadelauncher/bow
	belt = /obj/item/storage/belt/rogue/leather/rope
	beltr = /obj/item/quiver/arrows
	beltl = /obj/item/flashlight/flare/torch/lantern
	backpack_contents = list(/obj/item/flint = 1, /obj/item/bait = 1, /obj/item/rogueweapon/huntingknife = 1)
	gloves = /obj/item/clothing/gloves/roguetown/leather
	if(H.mind) // Jack of all trades. Skilled survival-craft, high exposure to life. Generally not expert in anything.
		H.mind.adjust_skillrank(/datum/skill/combat/swords, pick(0,0,1,2), TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/axesmaces, pick(0,0,1), TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/crossbows, pick(0,1,1), TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/bows, pick(2,2,3,3,3,4), TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/wrestling, pick(0,1,1,2), TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/unarmed, pick(0,1,1,2), TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/knives, pick(2,3,3,3), TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/polearms, pick(0,0,1,2), TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/swimming, pick(0,1,1,2), TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/climbing, pick(1,2,2,2), TRUE)
		H.mind.adjust_skillrank(/datum/skill/craft/crafting, pick(1,1,1,2), TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/reading, pick(0,0,0,0,1), TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/sneaking, pick(2,2,2,3,4), TRUE)
		H.mind.adjust_skillrank(/datum/skill/craft/tanning, pick(3,3,3,4), TRUE)
		H.mind.adjust_skillrank(/datum/skill/labor/fishing, pick(1,1,1,2), TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/sewing, pick(2,2,3), TRUE)
		H.mind.adjust_skillrank(/datum/skill/labor/butchering, pick(1,1,2,3), TRUE)
		H.mind.adjust_skillrank(/datum/skill/craft/traps, pick(1,1,1,2), TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/medicine, pick(1,1,2,2), TRUE)
		H.mind.adjust_skillrank(/datum/skill/craft/cooking, pick(1,1,2), TRUE)

		if(H.age == AGE_OLD)
			H.mind.adjust_skillrank(/datum/skill/combat/knives, 3, TRUE)
		H.change_stat("intelligence", pick(-1,0,0,1))
		H.change_stat("perception", pick(0,1,1,2,3))
		H.change_stat("strength", pick(-1,0,0,1))
		H.change_stat("constitution", pick(-1,0,0,1))
		H.change_stat("endurance", pick(-1,0,0,1))
		H.change_stat("speed", pick(0,0,1,2))
