/datum/job/roguetown/jester
	title = "Jester"
	flag = JESTER
	department_flag = PEASANTS
	faction = "Station"
	total_positions = 1
	spawn_positions = 1

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

	tutorial = "The Grenzelhofts were known for their Jesters, wisemen with a tongue just as sharp as their wit. You command a position of a fool, envious of the position your superiors have upon you. Your cheap tricks and illusions of intelligence will only work for so long, and someday youll find yourself at the end of something sharper than you."

	allowed_ages = ADULT_AGES_LIST
	spells = list(/obj/effect/proc_holder/spell/self/telljoke,/obj/effect/proc_holder/spell/self/telltragedy)
	outfit = /datum/outfit/job/roguetown/jester
	display_order = JDO_JESTER
	give_bank_account = TRUE
	min_pq = -4 //retard jesters are funny so low PQ requirement
	max_pq = null

/datum/outfit/job/roguetown/jester/pre_equip(mob/living/carbon/human/H)
	..()
	shoes = /obj/item/clothing/shoes/roguetown/jester
	pants = /obj/item/clothing/under/roguetown/tights
	armor = /obj/item/clothing/suit/roguetown/shirt/jester
	belt = /obj/item/storage/belt/rogue/leather
	beltr = /obj/item/keyring/servant
	beltl = /obj/item/storage/belt/rogue/pouch
	head = /obj/item/clothing/head/roguetown/jester
	neck = /obj/item/clothing/neck/roguetown/coif
	//Desc says grenzelhoft has great jesters so 50% change to raceswap because slop lore
	if(ishumannorthern(H) && prob(50))
		H.skin_tone = SKIN_COLOR_GRENZELHOFT
		H.update_body()
	if(H.mind)
		H.mind.adjust_skillrank(/datum/skill/combat/knives, 3, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/reading, 4, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/sneaking, 4, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/stealing, 5, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/climbing, 4, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/music, pick(1,2), TRUE)
		H.STASTR = rand(1, 20)
		H.STAINT = rand(1, 20)
		H.STALUC = rand(1, 20)
		H.cmode_music = 'sound/music/combat_jester.ogg'
/*
		if(H.gender == MALE)
			if(H.dna?.species)
				if(iself(H) || ishalfelf(H))
					H.dna.species.soundpack_m = new /datum/voicepack/male/elf/jester()
				if(ishumannothern(H))
					H.dna.species.soundpack_m = new /datum/voicepack/male/jester()
				if(isdwarf(H))
					H.dna.species.soundpack_m = new /datum/voicepack/male/dwarf/jester()
		H.hair_color = "cd65cb"
		H.facial_hair_color = "cd65cb"
		H.update_body_parts_head_only()
*/
	ADD_TRAIT(H, RTRAIT_EMPATH, TRAIT_GENERIC)
	H.verbs |= /mob/living/carbon/human/proc/tickle_victim
	H.verbs |= /mob/living/carbon/human/proc/tickle_test

/mob/living/carbon/human/proc/tickle_victim()
	set name = "Tickle Toes"
	set category = "Japes"

	var/obj/item/grabbing/I = get_active_held_item()
	var/mob/living/carbon/human/H
	if(!istype(I) || !ishuman(I.grabbed))
		return
	H = I.grabbed
	if(H == src)
		to_chat(src, "<span class='warning'>I am the tickler, not the ticklee!</span>")
		return
	if(H.add_stress(/datum/stressevent/tickled))
		if(!H.stat)
			var/static/list/toes_lines = list(
				"Hehehe!",
				"Oooh, you're a wriggler!",
				"Tickle tickle!",
				"Whoohohoho!",
				"Inky winky pinky doops!",
				"THE TICKLING HAS JUST BEGUN, CONFESS!",
			)
			say(pick(toes_lines), spans = list("tickle"))
			H.emote("giggle")
			H.confession_time("antag")
			return
	to_chat(src, "<span class='warning'>Not ready to spill yet!</span>")

/* Seperating this shit for my own sanity as a divider. I'm sorry it's slop.*/

/mob/living/carbon/human/proc/tickle_test()
	set name = "Tickle Soles"
	set category = "Japes"

	var/obj/item/grabbing/I = get_active_held_item()
	var/mob/living/carbon/human/H
	if(!istype(I) || !ishuman(I.grabbed))
		return
	H = I.grabbed
	if(H == src)
		to_chat(src, "<span class='warning'>I am the tickler, not the ticklee!</span>")
		return
	if(H.add_stress(/datum/stressevent/tickled))
		if(!H.stat)
			var/static/list/faith_lines = list(
				"Which God is the funniest!?",
				"I'll tickle you harder if you don't spill!",
				"The tickling doesn't stop until you pop!",
				"My favourite is Xylix, who's yours!?",
			)
			say(pick(faith_lines), spans = list("tickle"))
			H.emote("giggle")
			H.confession_time("patron")
			return
	to_chat(src, "<span class='warning'>Not ready to spill yet!</span>")

/mob/living/carbon/human/proc/ticklefession_time(confession_type = "antag")
	var/timerid = addtimer(CALLBACK(src, PROC_REF(confess_sins)), 6 SECONDS, TIMER_STOPPABLE)
	var/responsey = alert(src, "Resist tickling? (1 TRI)","Yes","No")
	if(!responsey)
		responsey = "No"
	if(SStimer.timer_id_dict[timerid])
		deltimer(timerid)
	else
		to_chat(src, "<span class='warning'>Too late...</span>")
		return
	if(responsey == "Yes")
		adjust_triumphs(-1)
		confess_sins(confession_type, resist = TRUE)
	else
		confess_sins(confession_type)

/mob/living/carbon/human/proc/tickled_sins(confession_type = "antag", resist)
	var/static/list/innocent_lines = list(
		"Hehehehehee!!!",
		"Ahahahahahaah!",
		"Wheeeeeeeze!",
		"Oh Gods, it tickles!!!",
		"Ehehehehehehe!",
		"The tickling!!!",
	)
	if(!resist)
		var/list/confessions = list()
		switch(confession_type)
			if("patron")
				if(length(patron?.confess_lines))
					confessions += patron.confess_lines
			if("antag")
				for(var/datum/antagonist/antag in mind?.antag_datums)
					if(!length(antag.confess_lines))
						continue
					confessions += antag.confess_lines
		if(length(confessions))
			say(pick(confessions), spans = list("torture"))
			return
	say(pick(innocent_lines), spans = list("torture"))

