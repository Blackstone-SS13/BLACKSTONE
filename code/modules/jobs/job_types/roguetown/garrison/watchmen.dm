/datum/job/roguetown/watchmen
	title = "Watchmen"
	flag = WATCHMAN
	department_flag = GARRISON
	faction = "Station"
	total_positions = 10
	spawn_positions = 10
	selection_color = JCOLOR_SOLDIER
	allowed_sexes = list(MALE)
	allowed_races = list(
		"Humen",
		"Elf",
		"Half-Elf",
		"Dwarf",
	)
	allowed_ages = list(AGE_ADULT, AGE_MIDDLEAGED)
	tutorial = "These walls are your life, this town is your duty, you've watched the moss grow and wither out from when you were a young boy, your masters are the King and the Sheriff, they don't know what it's like to be on the walls, but disobey them and you'll surely find yourself on the outside of them."
	display_order = JDO_WATCHMEN

	outfit = /datum/outfit/job/roguetown/watchmen
	give_bank_account = 10
	min_pq = 1

/datum/job/roguetown/watchmen/after_spawn(mob/living/L, mob/M, latejoin = TRUE)
	. = ..()
	if(ishuman(L))
		var/mob/living/carbon/human/H = L
		if(istype(H.cloak, /obj/item/clothing/cloak/stabard/guard))
			var/obj/item/clothing/S = H.cloak
			var/index = findtext(H.real_name, " ")
			if(index)
				index = copytext(H.real_name, 1,index)
			if(!index)
				index = H.real_name
			S.name = "guard's tabard ([index])"

/datum/outfit/job/roguetown/watchmen/pre_equip(mob/living/carbon/human/H)
	. = ..()
	head = /obj/item/clothing/head/roguetown/roguehood/red
	pants = /obj/item/clothing/under/roguetown/trou/leather
	cloak = /obj/item/clothing/cloak/stabard/guard
	shirt = /obj/item/clothing/suit/roguetown/shirt/shortshirt/merc
	armor = /obj/item/clothing/suit/roguetown/armor/chainmail
	neck = /obj/item/clothing/neck/roguetown/gorget
	shoes = /obj/item/clothing/shoes/roguetown/boots
	beltl = /obj/item/keyring/watchmen
	belt = /obj/item/storage/belt/rogue/leather
	beltr = /obj/item/rogueweapon/mace/cudgel
	wrists = /obj/item/clothing/wrists/roguetown/bracers/leather
	backr = /obj/item/storage/backpack/rogue/satchel
	backpack_contents = list(/obj/item/rogueweapon/huntingknife/idagger/steel/special = 1, /obj/item/rope/chain = 1)
	ADD_TRAIT(H, RTRAIT_MEDIUMARMOR, TRAIT_GENERIC)

/datum/outfit/job/roguetown/watchmen/proc/assign_skills(mob/living/carbon/human/watchmen)
	watchmen.mind.adjust_skillrank(/datum/skill/combat/axesmaces, 3, TRUE)
	watchmen.mind.adjust_skillrank(/datum/skill/combat/bows, pick(3,3,4), TRUE)
	watchmen.mind.adjust_skillrank(/datum/skill/combat/crossbows, pick(2,2,3), TRUE)
	watchmen.mind.adjust_skillrank(/datum/skill/combat/wrestling, pick(3,3,4), TRUE)
	watchmen.mind.adjust_skillrank(/datum/skill/combat/unarmed, pick(3,3,4), TRUE) 
	watchmen.mind.adjust_skillrank(/datum/skill/combat/swords, 3, TRUE)
	watchmen.mind.adjust_skillrank(/datum/skill/combat/polearms, pick(1,2), TRUE)
	watchmen.mind.adjust_skillrank(/datum/skill/combat/whipsflails, pick(1,2), TRUE)
	watchmen.mind.adjust_skillrank(/datum/skill/misc/sneaking, 3, TRUE) 
	watchmen.mind.adjust_skillrank(/datum/skill/combat/knives, 3, TRUE)
	watchmen.mind.adjust_skillrank(/datum/skill/misc/swimming, 2, TRUE)
	watchmen.mind.adjust_skillrank(/datum/skill/misc/climbing, 3, TRUE)
	watchmen.mind.adjust_skillrank(/datum/skill/misc/athletics, 3, TRUE)
	watchmen.mind.adjust_skillrank(/datum/skill/misc/reading, 1, TRUE)
	watchmen.mind.adjust_skillrank(/datum/skill/misc/medicine, 1, TRUE)
	watchmen.change_stat("strength", 1)
	watchmen.change_stat("perception", 3)
	watchmen.change_stat("constitution", 1)
	watchmen.change_stat("endurance", 2)
	watchmen.change_stat("speed", 2)

/mob/proc/haltyell()
	set name = "HALT!"
	set category = "Noises"
	emote("haltyell")
