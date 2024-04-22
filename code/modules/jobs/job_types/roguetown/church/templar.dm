//shield flail or longsword, tief can be this with red cross

/datum/job/roguetown/templar
	title = "Templar"
	department_flag = CHURCHMEN
	faction = "Station"
	tutorial = "Templars are warriors who have forsaken wealth and title in lieu of service to the church, due to either zealotry or a past shame. They serve the Church and their God, often taking on the most gruesome of tasks given to them by the priest. Within troubled dreams, they wonder if the blood they shed makes them holy or stained."
	allowed_sexes = list("male")
	allowed_races = list("Humen",
	"Tiefling",
	"Aasimar")
	outfit = /datum/outfit/job/roguetown/templar
	min_pq = 2
	total_positions = 2
	spawn_positions = 2
	spells = list(/obj/effect/proc_holder/spell/invoked/heal/lesser, /obj/effect/proc_holder/spell/targeted/churn, /obj/effect/proc_holder/spell/targeted/burialrite)
	display_order = JDO_TEMPLAR
	give_bank_account = TRUE

/datum/outfit/job/roguetown/templar/pre_equip(mob/living/carbon/human/H)
	..()
	neck = /obj/item/clothing/neck/roguetown/psicross/astrata
	armor = /obj/item/clothing/suit/roguetown/armor/chainmail/hauberk
	shirt = /obj/item/clothing/suit/roguetown/shirt/undershirt/black
	pants = /obj/item/clothing/under/roguetown/tights/black
	shoes = /obj/item/clothing/shoes/roguetown/boots
	head = /obj/item/clothing/head/roguetown/helmet/heavy/bucket
	backl = /obj/item/storage/backpack/rogue/satchel
	backr = /obj/item/rogueweapon/shield/tower/metal
	belt = /obj/item/storage/belt/rogue/leather/black
	beltl = /obj/item/storage/belt/rogue/pouch/coins/mid
	beltr = /obj/item/rogueweapon/sword/long
	id = /obj/item/clothing/ring/silver
	cloak = /obj/item/clothing/cloak/tabard/crusader/tief
	gloves = /obj/item/clothing/gloves/roguetown/chain
	wrists = /obj/item/clothing/wrists/roguetown/bracers
	backpack_contents = list(/obj/item/roguekey/church = 1, /obj/item/clothing/neck/roguetown/chaincoif = 1)
	if(H.mind) // Templar are more experienced in war and soldiering compared to Paladins. So they are stealthier, stronger and have better weapons training. 
		H.mind.adjust_skillrank(/datum/skill/combat/crossbows, pick(1,2,2,2,3), TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/polearms, pick(1,1,2), TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/axesmaces, pick(1,2,2,2,3), TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/bows, pick(1,2,2), TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/wrestling, pick(1,2,2,2,3), TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/unarmed, pick(2,3,3), TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/athletics, pick(2,3,3), TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/swords, pick(3,4,4,4), TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/knives, pick(1,2,2,2,3), TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/sneaking, pick(1,1,1,2), TRUE)
		H.mind.adjust_skillrank(/datum/skill/craft/crafting, pick(0,1,1,1,2), TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/swimming, pick(1,1,1,2), TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/climbing, pick(1,1,2), TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/riding, pick(2,2,2,2,3), TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/reading, pick(2,2,2,2,3), TRUE)
		H.mind.adjust_skillrank(/datum/skill/craft/cooking, pick(0,0,1), TRUE)
		H.mind.adjust_skillrank(/datum/skill/craft/traps, pick(0,1,1), TRUE)
		H.mind.adjust_skillrank(/datum/skill/magic/holy, pick(1,1,1,2), TRUE) 

		H.change_stat("intelligence", pick(1,1,2))
		H.change_stat("perception", pick(1,1,2)) // Templars are a generally tougher but slower version of the Paladin. By their lore they would be retired knights or soldiers which might explain poor speed.
		H.change_stat("strength", pick(1,2,2))
		H.change_stat("constitution", pick(1,1,2))
		H.change_stat("endurance", pick(2,2,2,3))
		H.change_stat("speed", pick(-2,-2,-1))
	ADD_TRAIT(H, RTRAIT_HEAVYARMOR, TRAIT_GENERIC)
	ADD_TRAIT(H, RTRAIT_MEDIUMARMOR, TRAIT_GENERIC)
	ADD_TRAIT(H, TRAIT_STEELHEARTED, TRAIT_GENERIC) // The church's sanctioned killer.
	if(H.dna?.species)
		if(H.dna.species.id == "human")
			H.dna.species.soundpack_m = new /datum/voicepack/male/knight()
	var/datum/devotion/cleric_holder/C = new /datum/devotion/cleric_holder(H, H.PATRON)
	//Max devotion limit - Templars are stronger but cannot pray to gain more abilities
	C.max_devotion = 200
	C.update_devotion(50, 50)
	C.holder_mob = H
	H.verbs += list(/mob/living/carbon/human/proc/devotionreport, /mob/living/carbon/human/proc/clericpray)
