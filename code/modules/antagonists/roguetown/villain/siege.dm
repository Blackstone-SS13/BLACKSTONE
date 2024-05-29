/datum/antagonist/siege
	name = "Baron's Soldier"
	roundend_category = "siege"
	antagpanel_category = "Siege"
	job_rank = ROLE_SIEGE
	antag_hud_type = ANTAG_HUD_OPS
	antag_hud_name = "baron's men"
	var/datum/team/siege/siege_team
	var/is_baron = FALSE
	confess_lines = list("FOR THE BARON!!", "I WILL NOT SERVE THE KING!", "I WILL NOT FOLLOW YOUR LAWS!")

/datum/antagonist/siege/on_gain()
	owner.special_role = "Siege"
	owner.assigned_role = "Siege"
	if(owner.current)
		owner.current.job = null
	forge_objectives()
	. = ..()
	if(is_baron)
		equip_baron()
	else
		equip_soldier()
	move_to_spawnpoint()
	finalize_siege()

/datum/antagonist/siege/greet()
	to_chat(owner, "<span class='alertsyndie'>I am a BARON'S SOLDIER!</span>")
	to_chat(owner, "<span class='info'>I joined the army of the Baron, helping him mobilize troops throughout the land. Now we will take Rockhill and reap the rewards!</span>")
	owner.announce_objectives()

/datum/antagonist/siege/proc/forge_objectives()
	if(siege_team)
		objectives |= siege_team.objectives

/datum/antagonist/siege/apply_innate_effects(mob/living/mob_override)
	var/mob/living/M = mob_override || owner.current
	add_antag_hud(antag_hud_type, antag_hud_name, M)

/datum/antagonist/siege/remove_innate_effects(mob/living/mob_override)
	var/mob/living/M = mob_override || owner.current
	remove_antag_hud(antag_hud_type, M)

/datum/antagonist/siege/on_gain()
	. = ..()
	create_objectives()

/datum/antagonist/siege/on_removal()
	remove_objectives()
	. = ..()

/datum/antagonist/siege/create_team(datum/team/siege/new_team)
	if(!new_team)
		//For now only one siege at a time
		for(var/datum/antagonist/siege/H in GLOB.antagonists)
			if(!H.owner)
				continue
			if(H.siege_team)
				siege_team = H.siege_team
				return
		siege_team = new /datum/team/siege()
		siege_team.update_objectives()
		return
	if(!istype(new_team))
		stack_trace("Wrong team type passed to [type] initialization.")
	siege_team = new_team

/datum/antagonist/siege/get_team()
	return siege_team

/datum/antagonist/siege/proc/create_objectives()
	if(get_team())
		objectives |= siege_team.objectives

/datum/antagonist/siege/proc/remove_objectives()
	if(get_team())
		objectives -= siege_team.objectives

/datum/antagonist/siege/proc/finalize_siege()
	if(owner.current)
		owner.current.playsound_local(get_turf(owner.current), 'sound/music/traitor.ogg', 80, FALSE, pressure_affected = FALSE)
		var/mob/living/carbon/human/H = owner.current
		ADD_TRAIT(H, TRAIT_BANDITCAMP, TRAIT_GENERIC)
		ADD_TRAIT(H, TRAIT_STEELHEARTED, TRAIT_GENERIC)
		ADD_TRAIT(H, RTRAIT_MEDIUMARMOR, TRAIT_GENERIC)
		
/datum/antagonist/siege/proc/move_to_spawnpoint()
	if(owner.current && length(GLOB.soldier_starts))
		owner.current.forceMove(pick(GLOB.soldier_starts))
	else if(owner.current && length(GLOB.bandit_starts))
		owner.current.forceMove(pick(GLOB.bandit_starts))

/datum/antagonist/siege/proc/equip_soldier()
	var/mob/living/carbon/human/H = owner.current
	if(H.mobid in GLOB.character_list)
		GLOB.character_list[H.mobid] = null
	GLOB.chosen_names -= H.real_name
	if((H.dna.species?.id != "human"))
		H.age = AGE_ADULT
		H.set_species(/datum/species/human/northern) //setspecies randomizes body
		H.after_creation()
	if(H)
		addtimer(CALLBACK(H, TYPE_PROC_REF(/mob/living/carbon/human, choose_name_popup), "SOLDIER"), 5 SECONDS)
		H.equipOutfit(/datum/outfit/job/roguetown/soldier)
		H.cmode_music = 'sound/music/combat_bandit.ogg'

/datum/outfit/job/roguetown/soldier/pre_equip(mob/living/carbon/human/H)
	..()
	head = /obj/item/clothing/head/roguetown/helmet
	pants = /obj/item/clothing/under/roguetown/chainlegs
	neck = /obj/item/clothing/neck/roguetown/chaincoif/iron
	shirt = /obj/item/clothing/suit/roguetown/shirt/shortshirt/merc
	armor = /obj/item/clothing/suit/roguetown/armor/leather/studded
	gloves = /obj/item/clothing/gloves/roguetown/chain
	shoes = /obj/item/clothing/shoes/roguetown/boots
	belt = /obj/item/storage/belt/rogue/leather
	beltr = /obj/item/rogueweapon/sword
	backr = /obj/item/storage/backpack/rogue/satchel
	backpack_contents = list(/obj/item/rope/chain = 1)
	if(H.mind)
		H.mind.adjust_skillrank(/datum/skill/combat/axesmaces, pick(3,4), TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/bows, 3, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/crossbows, pick(3,4), TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/wrestling, 4, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/unarmed, 3, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/swords, pick(4,4,5), TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/polearms, pick(3,4), TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/whipsflails, pick(3,4), TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/sneaking, 1, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/knives, 3, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/swimming, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/climbing, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/athletics, 3, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/reading, 1, TRUE)
		H.change_stat("strength", 2)
		H.change_stat("perception", 2)
		H.change_stat("constitution", 1)
		H.change_stat("endurance", 1)
		H.change_stat("speed", 1)
	if(H.gender == FEMALE)
		var/acceptable = list("Tomboy", "Bob", "Curly Short")
		if(!(H.hairstyle in acceptable))
			H.hairstyle = pick(acceptable)
			H.update_hair()
	ADD_TRAIT(H, RTRAIT_HEAVYARMOR, TRAIT_GENERIC)
	ADD_TRAIT(H, RTRAIT_MEDIUMARMOR, TRAIT_GENERIC)


/datum/objective/usurp
	name = "Usurp Crown"
	explanation_text = "Put the Baron on the throne with the crown."
	team_explanation_text = "Put the Baron on the throne with the crown."

/datum/objective/usurp/check_completion()
	var/list/datum/mind/owners = get_owners()
	for(var/datum/mind/M in owners)
		if(M.assigned_role == "King" && M.current.job == "King")
			return TRUE
	return FALSE

/datum/team/siege
	name = "Baron's Men"

/datum/team/siege/proc/update_objectives(initial = FALSE)
	if(!(locate(/datum/objective/usurp) in objectives))
		var/datum/objective/usurp/usurp = new
		usurp.team = src
		objectives += usurp
	for(var/datum/mind/M in members)
		var/datum/antagonist/siege/R = M.has_antag_datum(/datum/antagonist/siege)
		if(!R)
			R = M.has_antag_datum(/datum/antagonist/siege/baron)
		R.objectives |= objectives

/datum/team/siege/roundend_report()
	to_chat(world, "<span class='header'> * [name] * </span>")
	to_chat(world, "[printplayerlist(members)]")

	if(objectives.len)
		var/win = TRUE
		var/objective_count = 1
		for(var/datum/objective/objective in objectives)
			if(objective.check_completion())
				to_chat(world, "<B>Goal #[objective_count]</B>: [objective.explanation_text] <span class='greentext'>TRIUMPH!</span>")
			else
				to_chat(world, "<B>Goal #[objective_count]</B>: [objective.explanation_text] <span class='redtext'>FAIL.</span>")
				win = FALSE
			objective_count++
		if(win)
			for(var/datum/mind/M in members)
				if(considered_alive(M))
					M.adjust_triumphs(5)
			to_chat(world, "<span class='greentext'>The Baron's Siege has triumphed!</span>")
		else
			to_chat(world, "<span class='redtext'>The Baron's Siege has FAILED!</span>")

/datum/antagonist/siege/get_team()
	return siege_team

/datum/antagonist/siege/baron
	name = "The Baron"
	confess_lines = list("THE CROWN BELONGS TO THE STRONG!", "I WILL NOT BE WEAK!")
	is_baron = TRUE

/datum/antagonist/siege/baron/greet()
	to_chat(owner, "<span class='alertsyndie'>I am the BARON!</span>")
	to_chat(owner, "<span class='info'>The King of Rockhill is weak, and a weakling has no right to be King. I will show them my strength and take the crown for my own!</span>")
	owner.announce_objectives()

/datum/antagonist/siege/proc/equip_baron()
	var/mob/living/carbon/human/H = owner.current
	if(H.mobid in GLOB.character_list)
		GLOB.character_list[H.mobid] = null
	GLOB.chosen_names -= H.real_name
	if((H.dna.species?.id != "human"))
		H.age = AGE_ADULT
		H.set_species(/datum/species/human/northern) //setspecies randomizes body
		H.after_creation()
	H.cmode_music = 'sound/music/combat_bandit.ogg'
	addtimer(CALLBACK(H, TYPE_PROC_REF(/mob/living/carbon/human, choose_name_popup), "BARON"), 5 SECONDS)
	if(H)
		H.equipOutfit(/datum/outfit/job/roguetown/baron)

/datum/outfit/job/roguetown/baron/pre_equip(mob/living/carbon/human/H)
	..()
	gloves = /obj/item/clothing/gloves/roguetown/plate
	pants = /obj/item/clothing/under/roguetown/platelegs
	cloak = /obj/item/clothing/cloak/tabard/knight/guard
	neck = /obj/item/clothing/neck/roguetown/gorget
	shirt = /obj/item/clothing/suit/roguetown/shirt/shortshirt/merc
	armor = /obj/item/clothing/suit/roguetown/armor/plate/full
	shoes = /obj/item/clothing/shoes/roguetown/boots/armor
	belt = /obj/item/storage/belt/rogue/leather/hand
	backr = /obj/item/storage/backpack/rogue/satchel
	if(H.mind)
		H.mind.adjust_skillrank(/datum/skill/combat/axesmaces, 4, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/crossbows, 3, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/polearms, 4, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/whipsflails, 4, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/bows, 3, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/wrestling, 3, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/unarmed, 3, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/swords, 5, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/climbing, 1, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/athletics, 3, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/reading, 3, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/riding, 4, TRUE)
		backl = /obj/item/rogueweapon/sword/long
		H.change_stat("strength", 4)
		H.change_stat("perception", 1)
		H.change_stat("intelligence", 2)
		H.change_stat("constitution", 3)
		H.change_stat("endurance", 2)
		H.change_stat("speed", -1)
		if(H.dna?.species)
			if(H.dna.species.id == "human")
				H.dna.species.soundpack_m = new /datum/voicepack/male/knight()

	ADD_TRAIT(H, RTRAIT_NOBLE, TRAIT_GENERIC)
	ADD_TRAIT(H, RTRAIT_NOSEGRAB, TRAIT_GENERIC)
	ADD_TRAIT(H, RTRAIT_HEAVYARMOR, TRAIT_GENERIC)
	ADD_TRAIT(H, TRAIT_STEELHEARTED, TRAIT_GENERIC)
	ADD_TRAIT(H, RTRAIT_MEDIUMARMOR, TRAIT_GENERIC)
