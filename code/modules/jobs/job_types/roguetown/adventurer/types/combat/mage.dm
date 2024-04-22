/datum/advclass/mage
	name = "Mage"
	tutorial = "Mages are usually grown-up apprentices of wizards. They are seeking adventure, using their arcyne knowledge to aid other adventurers."
	allowed_sexes = list("male")
	allowed_races = list("Humen",
	"Humen",
	 "Elf",
	 "Half-Elf",
	 "Elf",
	 "Dark Elf",
	 "Tiefling",
	"Aasimar")
	outfit = /datum/outfit/job/roguetown/adventurer/mage

/datum/outfit/job/roguetown/adventurer/mage/pre_equip(mob/living/carbon/human/H)
	..()
	head = /obj/item/clothing/head/roguetown/roguehood/mage
	shoes = /obj/item/clothing/shoes/roguetown/simpleshoes
	armor = /obj/item/clothing/suit/roguetown/shirt/robe/mage
	belt = /obj/item/storage/belt/rogue/leather/rope
	beltr = /obj/item/reagent_containers/glass/bottle/rogue/manapot
	neck = /obj/item/storage/belt/rogue/pouch/coins/poor
	beltl = /obj/item/rogueweapon/huntingknife
	backl = /obj/item/storage/backpack/rogue/satchel
	r_hand = /obj/item/rogueweapon/woodstaff
	if(H.mind) // Most skills Max at 1 or 2. They're well read about the world and there's only the smallest chance they have experience with a blade or mace.
		H.mind.adjust_skillrank(/datum/skill/combat/crossbows, pick(0,0,1), TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/polearms, pick(0,0,0,1), TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/bows, pick(0,0,0,1), TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/wrestling, pick(1,1,2), TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/unarmed, pick(1,2,2,2,2), TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/swimming, pick(1,2,2), TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/climbing, pick(1,1,2), TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/athletics, pick(1,1,2), TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/swords, pick(0,0,0,1), TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/knives, pick(0,1,1,2), TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/reading, pick(2,2,3,4), TRUE)
		H.mind.adjust_skillrank(/datum/skill/craft/crafting, pick(0,1,1,2), TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/medicine, pick(0,1,1,2), TRUE)
		H.mind.adjust_skillrank(/datum/skill/craft/cooking, pick(0,0,1), TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/riding, pick(0,0,1), TRUE)
		if(H.age == AGE_OLD)
			head = /obj/item/clothing/head/roguetown/wizhat/gen
			armor = /obj/item/clothing/suit/roguetown/shirt/robe
			H.change_stat("intelligence", pick(2,2,2,3,4))
			H.mind.adjust_skillrank(/datum/skill/magic/arcane, 4, TRUE)
		else
			H.change_stat("intelligence", pick(1,2,2,2,3))
			H.mind.adjust_skillrank(/datum/skill/magic/arcane, 3, TRUE)			
		H.change_stat("perception", pick(0,0,0,0,1))
		H.change_stat("strength", pick(-2,-1,0,0,0))
		H.change_stat("constitution", pick(-1,-1,0,0,0,0))
		H.change_stat("endurance", pick(-1,-1,0,0,0,0))
		H.change_stat("speed", pick(-1,0,0,0,0,1))
		H.mind.AddSpell(new /obj/effect/proc_holder/spell/invoked/projectile/fireball)
		H.mind.AddSpell(new /obj/effect/proc_holder/spell/invoked/projectile/lightningbolt)
		H.mind.AddSpell(new /obj/effect/proc_holder/spell/invoked/projectile/fetch)
