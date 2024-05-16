/datum/job/roguetown/veteran
	title = "Captain of the Guard"
	flag = GUARDSMAN
	department_flag = GARRISON
	faction = "Station"
	total_positions = 1
	spawn_positions = 1

	allowed_sexes = list(MALE) //same as town guard
	allowed_races = list(
		"Humen",
		"Elf",
		"Half-Elf",
		"Dwarf",
		"Aasimar",
		"Half Orc",
	) //same as town guard
	tutorial = "War has always been a constant of your life, and you always chose the side of defense and justice. You rose up through the ranks as a guardman and you're now the head above all of them. Lead and train your men to defend the kingdom and maintain the peace. Recruit those who feels able to aid the Kingdom against the offensives and push the tides to be yours..."
	allowed_ages = list(AGE_ADULT, AGE_MIDDLEAGED, AGE_OLD)
	display_order = JDO_VET
	whitelist_req = TRUE

	outfit = /datum/outfit/job/roguetown/veteran
	give_bank_account = 35
	min_pq = 4
	max_pq = null

/datum/job/roguetown/veteran/after_spawn(mob/living/L, mob/M, latejoin = TRUE)
	..()
	if(ishuman(L))
		var/mob/living/carbon/human/H = L
		var/prev_real_name = H.real_name
		var/prev_name = H.name
		H.real_name = "Captain [prev_real_name]"
		H.name = "Captain [prev_name]"

/datum/outfit/job/roguetown/veteran/pre_equip(mob/living/carbon/human/H)
	..()
	head = /obj/item/clothing/head/roguetown/helmet/sallet/visored
	pants = /obj/item/clothing/under/roguetown/chainlegs
	gloves = gloves = /obj/item/clothing/gloves/roguetown/plate
	wrists = /obj/item/clothing/wrists/roguetown/bracers
	cloak = /obj/item/clothing/cloak/half/vet
	shirt = /obj/item/clothing/suit/roguetown/armor/chainmail
	armor = /obj/item/clothing/suit/roguetown/armor/plate
	neck = /obj/item/clothing/neck/roguetown/bervor
	shoes = /obj/item/clothing/shoes/roguetown/boots/armor
	beltl = /obj/item/keyring/guardcastle
	beltr = /obj/item/rogueweapon/mace
	belt = /obj/item/storage/belt/rogue/leather/black
	backl = /obj/item/rogueweapon/shield/tower
	backr = /obj/item/storage/backpack/rogue/satchel/black
	backpack_contents = list(/obj/item/rogueweapon/huntingknife/idagger/steel/special = 1)
	if(H.mind)
		H.mind.AddSpell(new /obj/effect/proc_holder/spell/self/convertrole/guard)
		H.mind.adjust_skillrank(/datum/skill/combat/swords, 6, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/axesmaces, 6, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/wrestling, 5, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/unarmed, 4, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/polearms, 4, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/bows, 4, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/crossbows, 3, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/whipsflails, 3, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/knives, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/swimming, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/climbing, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/athletics, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/reading, 1, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/medicine, 3, TRUE)
		H.change_stat("strength", 2)
		H.change_stat("perception", 1)
		H.change_stat("intelligence", 3)
		H.change_stat("endurance", 1)
		H.change_stat("speed", 1)

	if(H.charflaw)
		if(H.charflaw.type != /datum/charflaw/noeyer)
			if(H.charflaw.type != /datum/charflaw/noeyel)
				var/obj/item/bodypart/O = H.get_bodypart(BODY_ZONE_R_ARM)
				if(O)
					O.drop_limb()
					qdel(O)
				O = H.get_bodypart(BODY_ZONE_L_ARM)
				if(O)
					O.drop_limb()
					qdel(O)
				H.regenerate_limb(BODY_ZONE_R_ARM)
				H.regenerate_limb(BODY_ZONE_L_ARM)
				H.charflaw = new /datum/charflaw/noeyer()
				if(!istype(H.wear_mask, /obj/item/clothing/mask/rogue/eyepatch))
					qdel(H.wear_mask)
					mask = /obj/item/clothing/mask/rogue/eyepatch

	H.verbs |= /mob/proc/haltyell
	ADD_TRAIT(H, RTRAIT_HEAVYARMOR, TRAIT_GENERIC)