/datum/advclass/cheesemaker
	name = "Cheesemaker"
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
	outfit = /datum/outfit/job/roguetown/adventurer/cheesemaker
	isvillager = TRUE
	ispilgrim = TRUE

/datum/outfit/job/roguetown/adventurer/cheesemaker/pre_equip(mob/living/carbon/human/H)
	..()
	H.mind.adjust_skillrank(/datum/skill/combat/swords, pick(0,0,0,1), TRUE)
	H.mind.adjust_skillrank(/datum/skill/combat/axesmaces, pick(0,0,1), TRUE)
	H.mind.adjust_skillrank(/datum/skill/combat/crossbows, pick(0,0,1), TRUE)
	H.mind.adjust_skillrank(/datum/skill/misc/athletics, pick(2,2,3), TRUE) 
	H.mind.adjust_skillrank(/datum/skill/combat/bows, pick(0,1,1), TRUE)
	H.mind.adjust_skillrank(/datum/skill/combat/wrestling, pick(0,1,1), TRUE)
	H.mind.adjust_skillrank(/datum/skill/combat/unarmed, pick(1,1,2), TRUE)
	H.mind.adjust_skillrank(/datum/skill/combat/knives, pick(2,2,3), TRUE)
	H.mind.adjust_skillrank(/datum/skill/combat/polearms, pick(0,1,1), TRUE) 
	H.mind.adjust_skillrank(/datum/skill/misc/swimming, pick(1,2,2), TRUE)
	H.mind.adjust_skillrank(/datum/skill/misc/climbing, pick(1,2,2), TRUE)
	H.mind.adjust_skillrank(/datum/skill/craft/crafting, pick(1,2,2), TRUE)
	H.mind.adjust_skillrank(/datum/skill/misc/reading, pick(2,3,3), TRUE)
	H.mind.adjust_skillrank(/datum/skill/misc/sewing, pick(1,1,2), TRUE)
	H.mind.adjust_skillrank(/datum/skill/labor/butchering, pick(2,2,3), TRUE)
	H.mind.adjust_skillrank(/datum/skill/craft/traps, pick(0,0,1), TRUE)
	H.mind.adjust_skillrank(/datum/skill/craft/cooking, pick(3,4,4,4), TRUE)
	H.mind.adjust_skillrank(/datum/skill/labor/farming, pick(1,1,2), TRUE)
	H.mind.adjust_skillrank(/datum/skill/craft/carpentry, pick(0,0,1), TRUE)

	mouth = /obj/item/rogueweapon/huntingknife
	belt = /obj/item/storage/belt/rogue/leather
	pants = /obj/item/clothing/under/roguetown/tights/random
	shirt = /obj/item/clothing/suit/roguetown/shirt/shortshirt/random
	cloak = /obj/item/clothing/cloak/apron
	shoes = /obj/item/clothing/shoes/roguetown/simpleshoes
	backl = /obj/item/storage/backpack/rogue/satchel
	neck = /obj/item/storage/belt/rogue/pouch/coins/poor
	wrists = /obj/item/clothing/wrists/roguetown/bracers/leather
	beltr = /obj/item/cooking/pan
	beltl = /obj/item/flint
	backpack_contents = list(/obj/item/reagent_containers/powder/flour/salt = 1,/obj/item/reagent_containers/food/snacks/rogue/cheese=1,/obj/item/reagent_containers/food/snacks/rogue/cheddar=1)
	H.change_stat("intelligence", pick(0,1,1))
	H.change_stat("constitution", pick(1,1,2)) // Cheese Constitution.
	H.change_stat("endurance", pick(1,1,2))
