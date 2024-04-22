
/datum/advclass/vaquero
	name = "Vaquero"
	tutorial = "Vaquero are Tieberian swashbucklers who have their origins as skilled horse-tamers of Asturia. It's hard to find horses these days..."
	allowed_sexes = list("male", "female")
	allowed_races = list("Tiefling")
	outfit = /datum/outfit/job/roguetown/adventurer/vaquero
	horse = /mob/living/simple_animal/hostile/retaliate/rogue/saigabuck/tame/saddled

/datum/advclass/vaquero/equipme(mob/living/carbon/human/H)
	if(H.gender == FEMALE)
		horse = /mob/living/simple_animal/hostile/retaliate/rogue/saiga/tame/saddled
	return ..()

/datum/outfit/job/roguetown/adventurer/vaquero/pre_equip(mob/living/carbon/human/H)
	..() // Compared to Rogue or Bard -- it's a mix of both. The Vaquero isn't a better bard, assassin or thief. But they make up for it with their speed and duelist skillset.
	H.mind.adjust_skillrank(/datum/skill/combat/swords, pick(3,3,3,4), TRUE)
	H.mind.adjust_skillrank(/datum/skill/combat/axesmaces, pick(1,1,2), TRUE)
	H.mind.adjust_skillrank(/datum/skill/combat/crossbows, pick(1,2,2), TRUE)
	H.mind.adjust_skillrank(/datum/skill/combat/bows, pick(1,1,2), TRUE)
	H.mind.adjust_skillrank(/datum/skill/misc/athletics, pick(0,1,1,2), TRUE)
	H.mind.adjust_skillrank(/datum/skill/combat/wrestling, pick(1,2,2,2,2), TRUE)
	H.mind.adjust_skillrank(/datum/skill/combat/unarmed, pick(1,2,2,2,3), TRUE)
	H.mind.adjust_skillrank(/datum/skill/combat/knives, pick(1,2,2,2,3), TRUE)
	H.mind.adjust_skillrank(/datum/skill/combat/polearms, pick(0,1,1), TRUE)
	H.mind.adjust_skillrank(/datum/skill/misc/swimming, pick(1,2,2,2,3), TRUE)
	H.mind.adjust_skillrank(/datum/skill/misc/climbing, pick(2,3,3), TRUE)
	H.mind.adjust_skillrank(/datum/skill/craft/crafting, pick(1,1,1,2), TRUE)
	H.mind.adjust_skillrank(/datum/skill/misc/reading, pick(0,1,1), TRUE)
	H.mind.adjust_skillrank(/datum/skill/labor/fishing, pick(0,1,1,1,2), TRUE)
	H.mind.adjust_skillrank(/datum/skill/misc/sewing, pick(0,1,1,1,2), TRUE)
	H.mind.adjust_skillrank(/datum/skill/labor/butchering, pick(0,0,1), TRUE)
	H.mind.adjust_skillrank(/datum/skill/misc/medicine, pick(0,1,1,1,2), TRUE)
	H.mind.adjust_skillrank(/datum/skill/misc/sneaking, pick(1,1,1,2), TRUE)
	H.mind.adjust_skillrank(/datum/skill/misc/stealing, pick(1,1,1,2), TRUE)
	H.mind.adjust_skillrank(/datum/skill/misc/riding, pick(4,5,5), TRUE)
	H.mind.adjust_skillrank(/datum/skill/craft/cooking, pick(1,1,1,2), TRUE)
	H.mind.adjust_skillrank(/datum/skill/misc/music, rand(1,2), TRUE)
	head = /obj/item/clothing/head/roguetown/bardhat
	shoes = /obj/item/clothing/shoes/roguetown/boots
	pants = /obj/item/clothing/under/roguetown/tights/random
	shirt = /obj/item/clothing/suit/roguetown/shirt/undershirt
	belt = /obj/item/storage/belt/rogue/leather
	armor = /obj/item/clothing/suit/roguetown/armor/leather/vest
	cloak = /obj/item/clothing/cloak/half/red
	backl = /obj/item/storage/backpack/rogue/satchel
	beltl = /obj/item/rogueweapon/sword/rapier
	H.change_stat("intelligence", pick(0,0,1))
	H.change_stat("perception", pick(0,1,1,1,2))
	H.change_stat("strength", pick(-1,-1,0,0,0,1))
	H.change_stat("constitution", pick(0,0,0,0,0,1))
	H.change_stat("endurance", pick(0,0,0,0,0,1))
	H.change_stat("speed", pick(2,2,2,3,3)) // Same stat line as Rogue but a better Speed Curve -- since they don't get armor training and have worse rogue skills.
	ADD_TRAIT(H, TRAIT_STEELHEARTED, TRAIT_GENERIC)