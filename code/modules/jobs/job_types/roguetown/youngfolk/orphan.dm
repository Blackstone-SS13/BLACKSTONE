/datum/job/roguetown/orphan
	title = "Orphan"
	flag = ORPHAN
	department_flag = YOUNGFOLK
	faction = "Station"
	total_positions = 2
	spawn_positions = 2

	allowed_races = list(
		"Humen",
		"Elf",
		"Half-Elf",
		"Dwarf",
		"Tiefling",
		"Argonian",
		"Dark Elf",
		"Aasimar",
		"Half Orc",
	)
	allowed_ages = YOUNG_AGES_LIST

	tutorial = "Numerous homeless youth litter the streets of the kingdom of Psydonia. They sometimes make something of themselves but much more often found dead."

	outfit = /datum/outfit/job/roguetown/orphan
	display_order = JDO_ORPHAN
	show_in_credits = FALSE
	min_pq = -30
	max_pq = null

	cmode_music = 'sound/music/combat_bum.ogg'

/datum/job/roguetown/orphan/New()
	. = ..()
	peopleknowme = list()

/datum/outfit/job/roguetown/orphan/pre_equip(mob/living/carbon/human/H)
	..()
	if(H.gender == FEMALE)
		armor = /obj/item/clothing/suit/roguetown/shirt/rags
	else
		pants = /obj/item/clothing/under/roguetown/tights/vagrant
		if(prob(50))
			pants = /obj/item/clothing/under/roguetown/tights/vagrant/l
		shirt = /obj/item/clothing/suit/roguetown/shirt/undershirt/vagrant
		if(prob(50))
			shirt = /obj/item/clothing/suit/roguetown/shirt/undershirt/vagrant/l
	if(prob(33))
		cloak = /obj/item/clothing/cloak/half/brown
		gloves = /obj/item/clothing/gloves/roguetown/fingerless
	if(H.mind)
		H.mind.adjust_skillrank(/datum/skill/misc/sneaking, pick(1,2), TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/stealing, round(rand(2,4)), TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/climbing, round(rand(2,3)), TRUE)
		H.STALUC = rand(1, 20)
	if(prob(10))
		r_hand = /obj/item/rogue/instrument/flute
	H.change_stat("intelligence", 2)
	H.change_stat("constitution", -1)
	H.change_stat("endurance", -1)
	H.change_stat("strength", -1)
