//shield flail or longsword, tief can be this with red cross

/datum/job/roguetown/templar
	title = "Templar"	
	department_flag = CHURCHMEN
	faction = "Station"
	tutorial = "Templars are warriors who have forsaken wealth and title in lieu of service to the church, due to either zealotry or a past shame. They guard the church and its priest, while keeping a watchful eye against heresy and nite-creechers. Within troubled dreams, they wonder if the blood they shed makes them holy or stained."
	allowed_sexes = list("male")
	allowed_races = list("Humen",
	"Tiefling",
	"Aasimar")
	outfit = /datum/outfit/job/roguetown/templar
	min_pq = 5
	total_positions = 2
	spawn_positions = 2
	spells = list(/obj/effect/proc_holder/spell/invoked/heal/lesser, /obj/effect/proc_holder/spell/targeted/churn, /obj/effect/proc_holder/spell/targeted/burialrite)	
	display_order = JDO_TEMPLAR
	give_bank_account = TRUE

/datum/outfit/job/roguetown/templar/pre_equip(mob/living/carbon/human/H)
	..()
	wrists = /obj/item/clothing/neck/roguetown/psicross/astrata
	armor = /obj/item/clothing/suit/roguetown/armor/chainmail/hauberk
	pants = /obj/item/clothing/under/roguetown/chainlegs
	shoes = /obj/item/clothing/shoes/roguetown/boots/leather
	head = /obj/item/clothing/head/roguetown/helmet/heavy/bucket
	belt = /obj/item/storage/belt/rogue/leather/hand
	beltl = /obj/item/storage/belt/rogue/pouch/coins/mid
	id = /obj/item/clothing/ring/silver
	cloak = /obj/item/clothing/cloak/tabard/crusader
	if(H.mind)
		H.mind.adjust_skillrank(/datum/skill/combat/axesmaces, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/crossbows, 3, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/bows, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/wrestling, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/unarmed, 3, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/swords, 4, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/climbing, 1, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/athletics, 3, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/reading, 3, TRUE)
		H.mind.adjust_skillrank(/datum/skill/magic/holy, 2, TRUE)
		backl = /obj/item/rogueweapon/sword/long
		H.change_stat("strength", 2)
		H.change_stat("perception", 2)
		H.change_stat("intelligence", 2)
		H.change_stat("constitution", 2)
		H.change_stat("endurance", 3)
		H.change_stat("speed", -2)
	ADD_TRAIT(H, RTRAIT_HEAVYARMOR, TRAIT_GENERIC)
	if(H.dna?.species)
		if(H.dna.species.id == "human")
			H.dna.species.soundpack_m = new /datum/voicepack/male/knight()
		if(H.dna.species.id == "tiefling")
			cloak = /obj/item/clothing/cloak/tabard/crusader/tief
	var/datum/devotion/cleric_holder/C = new /datum/devotion/cleric_holder(H, H.PATRON)
	C.update_devotion(80)
	C.holder_mob = H
	H.verbs += list(/mob/living/carbon/human/proc/devotionreport)
