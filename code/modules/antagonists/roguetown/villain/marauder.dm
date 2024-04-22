
/datum/antagonist/marauder
	name = "Marauder"
	roundend_category = "marauder"
	antagpanel_category = "Marauder"
	job_rank = ROLE_MARAUDER
	antag_hud_type = ANTAG_HUD_TRAITOR
	antag_hud_name = "Marauder"
	var/tri_amt
	var/contrib
	confess_lines = list("PILLAGE!!!", "TAKE ALL THEY HAVE!", "LOOT AND KILL!")

/datum/antagonist/marauder/examine_friendorfoe(datum/antagonist/examined_datum,mob/examiner,mob/examined)
	if(istype(examined_datum, /datum/antagonist/marauder))
		return "<span class='boldnotice'>Another marauder. My ally.</span>"

/datum/antagonist/marauder/on_gain()
	owner.special_role = "Marauder"
	owner.assigned_role = "Marauder"
	owner.current.job = null
	forge_objectives()
	. = ..()
	equip_marauder()
	move_to_spawnpoint()
	finalize_marauder()

/datum/antagonist/marauder/proc/finalize_marauder()
	owner.current.playsound_local(get_turf(owner.current), 'sound/music/traitor.ogg', 80, FALSE, pressure_affected = FALSE)
	var/mob/living/carbon/human/H = owner.current
	ADD_TRAIT(H, TRAIT_BANDITCAMP, TRAIT_GENERIC)
	ADD_TRAIT(H, RTRAIT_SEEPRICES, TRAIT_GENERIC)
	ADD_TRAIT(H, TRAIT_STEELHEARTED, TRAIT_GENERIC)

/datum/antagonist/marauder/greet()
	to_chat(owner.current, "<span class='alertsyndie'>I am a MARAUDER!</span>")
	to_chat(owner.current, "<span class='info'>Our group travels the land and takes as it pleases.</span>")
	owner.announce_objectives()
	..()

/datum/antagonist/marauder/proc/forge_objectives()
	return
/*
	if(!(locate(/datum/objective/marauder) in objectives))
		var/datum/objective/marauder/marauder_objective = new
		marauder_objective.owner = owner
		objectives += marauder_objective
	if(!(locate(/datum/objective/escape) in objectives))
		var/datum/objective/escape/boat/escape_objective = new
		escape_objective.owner = owner
		objectives += escape_objective*/

/datum/antagonist/marauder/proc/move_to_spawnpoint()
	owner.current.forceMove(pick(GLOB.bandit_starts))

/datum/antagonist/marauder/proc/equip_marauder()

	owner.unknow_all_people()
	for(var/datum/mind/MF in get_minds())
		owner.become_unknown_to(MF)
	for(var/datum/mind/MF in get_minds("Marauder"))
		owner.i_know_person(MF)
		owner.person_knows_me(MF)

	var/mob/living/carbon/human/H = owner.current
	if(H.mobid in GLOB.character_list)
		GLOB.character_list[H.mobid] = null
	GLOB.chosen_names -= H.real_name
	if((H.dna.species?.id != "human"))
		H.age = AGE_ADULT
		H.set_species(/datum/species/human/northern) //setspecies randomizes body
		H.after_creation()
//		H.real_name = H.client.prefs.pref_species.random_name(MALE,1) //set_species randomizes name
	H.cmode_music = 'sound/music/combatbandit.ogg'

	addtimer(CALLBACK(H, TYPE_PROC_REF(/mob/living/carbon/human, choose_name_popup), "MARAUDER"), 5 SECONDS)
//	H.job = "Marauder"
//	H.advjob = pick("Cheesemaker", "Mercenary", "Barbarian", "Ranger", "Rogue")
	H.equipOutfit(/datum/outfit/job/roguetown/marauder)

	return TRUE

/datum/outfit/job/roguetown/marauder/pre_equip(mob/living/carbon/human/H)
	..()
	H.mind.adjust_skillrank(/datum/skill/combat/polearms, 2, TRUE)
	H.mind.adjust_skillrank(/datum/skill/combat/axesmaces, 2, TRUE)
	H.mind.adjust_skillrank(/datum/skill/combat/wrestling, 1, TRUE)
	H.mind.adjust_skillrank(/datum/skill/combat/unarmed, 2, TRUE)
	H.mind.adjust_skillrank(/datum/skill/combat/swords, 2, TRUE)
	H.mind.adjust_skillrank(/datum/skill/combat/whipsflails, 1, TRUE)
	H.mind.adjust_skillrank(/datum/skill/combat/knives, 1, TRUE)
	H.mind.adjust_skillrank(/datum/skill/combat/bows, 1, TRUE)
	H.mind.adjust_skillrank(/datum/skill/combat/crossbows, 1, TRUE)
	H.mind.adjust_skillrank(/datum/skill/craft/crafting, 2, TRUE)
	H.mind.adjust_skillrank(/datum/skill/misc/reading, 1, TRUE)
	H.mind.adjust_skillrank(/datum/skill/misc/climbing, 2, TRUE)
	belt = /obj/item/storage/belt/rogue/leather
	pants = /obj/item/clothing/under/roguetown/trou/leather
	shirt = /obj/item/clothing/suit/roguetown/shirt/shortshirt/random
	shoes = /obj/item/clothing/shoes/roguetown/boots
	backl = /obj/item/storage/backpack/rogue/satchel
	if(prob(23))
		gloves = /obj/item/clothing/gloves/roguetown/leather
		armor = /obj/item/clothing/suit/roguetown/armor/gambeson
	else
		wrists = /obj/item/clothing/wrists/roguetown/bracers/leather
		armor = /obj/item/clothing/suit/roguetown/armor/leather
	var/loadoutm = rand(1,3)
	switch(loadoutm)
		if(1)
			beltr = /obj/item/rogueweapon/sword/iron
			H.mind.adjust_skillrank(/datum/skill/combat/swords, 3, TRUE)
			beltl = /obj/item/storage/belt/rogue/pouch
		if(2)
			beltr = /obj/item/rogueweapon/huntingknife/cleaver
			H.mind.adjust_skillrank(/datum/skill/combat/knives, 3, TRUE)
		if(3)
			beltr = /obj/item/rogueweapon/flail
			H.mind.adjust_skillrank(/datum/skill/combat/whipsflails, 3, TRUE)
	backl = /obj/item/gun/ballistic/revolver/grenadelauncher/crossbow
	beltl = /obj/item/quiver/bolts
	H.change_stat("strength", 2)
	H.change_stat("endurance", 2)
	H.change_stat("constitution", 1)
	H.change_stat("speed", 1)
	H.change_stat("intelligence", -2)
	var/obj/item/bodypart/B = H.get_bodypart("head")
	if(B)
		B.sellprice = rand(66, 123)

	H.ambushable = FALSE

/datum/antagonist/marauder/roundend_report()
	if(owner?.current)
		var/amt = tri_amt
		var/the_name = owner.name
		if(ishuman(owner.current))
			var/mob/living/carbon/human/H = owner.current
			the_name = H.real_name
		if(!amt)
			to_chat(world, "[the_name] was a marauder.")
		else
			to_chat(world, "[the_name] was a marauder. He stole [amt] triumphs worth of loot.")
	return

	var/traitorwin = TRUE

	var/count = 0
	if(objectives.len)//If the traitor had no objectives, don't need to process this.
		for(var/datum/objective/objective in objectives)
			objective.update_explanation_text()
			if(!objective.check_completion())
				traitorwin = FALSE
			count += objective.triumph_count

	if(!count)
		count = 1

	if(traitorwin)
		owner.adjust_triumphs(count)
		to_chat(owner.current, "<span class='greentext'>I've TRIUMPHED!</span>")
		if(owner.current)
			owner.current.playsound_local(get_turf(owner.current), 'sound/misc/triumph.ogg', 100, FALSE, pressure_affected = FALSE)
	else
		to_chat(owner.current, "<span class='redtext'>I've failed to satisfy my greed.</span>")
		if(owner.current)
			owner.current.playsound_local(get_turf(owner.current), 'sound/misc/fail.ogg', 100, FALSE, pressure_affected = FALSE)

