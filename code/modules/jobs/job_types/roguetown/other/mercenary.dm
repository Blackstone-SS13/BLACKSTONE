/datum/job/roguetown/mercenary
	title = "Mercenary"
	flag = GRAVEDIGGER
	department_flag = PEASANTS
	faction = "Station"
	total_positions = 5
	spawn_positions = 5

	allowed_sexes = list("male", "female")
	allowed_races = list("Humen",
	"Humen",
	"Half-Elf",
	"Tiefling",
	"Dwarf",
	"Dark Elf",
	"Aasimar"
	)
	tutorial = "How much blood is on your hands? Do you even see it when they line your palms with golden treasures? You're a paid killer, the only redeemable fact is that your loyalty is something purchasable, but even a whore has dignity compared to the likes of you. Another day, another mammon, you'd say."
	outfit = /datum/outfit/job/roguetown/mercenary
	display_order = JDO_MERCENARY
	give_bank_account = 3
	min_pq = -9

/datum/outfit/job/roguetown/mercenary/pre_equip(mob/living/carbon/human/H)
	..()
	shoes = /obj/item/clothing/shoes/roguetown/shalal
	head = /obj/item/clothing/head/roguetown/roguehood/shalal
	gloves = /obj/item/clothing/gloves/roguetown/angle
	belt = /obj/item/storage/belt/rogue/leather/shalal
	armor = /obj/item/clothing/suit/roguetown/armor/plate/scale
	beltr = /obj/item/storage/belt/rogue/pouch/coins/poor
	beltl = /obj/item/rogueweapon/sword/long/rider
	shirt = /obj/item/clothing/suit/roguetown/shirt/undershirt/black
	pants = /obj/item/clothing/under/roguetown/tights/black
	neck = /obj/item/clothing/neck/roguetown/shalal
	if(H.gender == FEMALE)
		var/acceptable = list("Tomboy", "Bob", "Curly Short")
		if(!(H.hairstyle in acceptable))
			H.hairstyle = pick(acceptable)
			H.update_hair()
	backpack_contents = list(/obj/item/roguekey/mercenary)
	if(H.mind)
		H.mind.adjust_skillrank(/datum/skill/combat/crossbows, pick(1,2,2,3), TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/polearms, pick(2,2,2,3,3,3), TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/axesmaces, pick(2,2,3,3,3,3,4), TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/whipsflails, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/bows, pick(1,2,2), TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/wrestling, pick(1,2,2,2), TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/unarmed, pick(1,2,2,2,3), TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/athletics, pick(2,2,2,3), TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/swords, pick(2,3,3,3,3,3,4), TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/knives, pick(2,2,2,3), TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/sneaking, pick(0,1,1), TRUE)
		H.mind.adjust_skillrank(/datum/skill/craft/crafting, pick(0,1,1,1), TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/swimming, pick(2,2,3), TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/climbing, pick(2,2,3), TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/riding, pick(2,2,2,3,3), TRUE)
		H.mind.adjust_skillrank(/datum/skill/craft/cooking, pick(1,1,2), TRUE)
		H.mind.adjust_skillrank(/datum/skill/labor/butchering, pick(1,1,2), TRUE)
		H.mind.adjust_skillrank(/datum/skill/craft/traps, pick(0,0,1), TRUE)

		H.change_stat("strength", pick(0,0,1,1,1))
		H.change_stat("constitution", pick(0,0,1,1,1))
		H.change_stat("endurance", pick(0,0,1,1,1))
		H.change_stat("speed", pick(0,1,1,1,2))
	ADD_TRAIT(H, RTRAIT_MEDIUMARMOR, TRAIT_GENERIC)
	ADD_TRAIT(H, TRAIT_STEELHEARTED, TRAIT_GENERIC)
