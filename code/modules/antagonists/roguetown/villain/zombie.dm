/datum/antagonist/zombie
	name = "Zombie"
	antag_hud_type = ANTAG_HUD_TRAITOR
	antag_hud_name = "zombie"
	show_in_roundend = FALSE
	var/zombie_start
	var/revived = FALSE
	var/next_idle_sound
	// CACHE VARIABLES SO ZOMBIFICATION CAN BE CURED
	var/was_i_undead = FALSE
	var/special_role
	var/ambushable = TRUE
	var/soundpack_m
	var/soundpack_f
	var/STASTR
	var/STASPD
	var/STAINT
	var/list/base_intents
	/// Traits applied to the owner mob
	var/static/list/traits_applied = list(
		TRAIT_NOMOOD,
		TRAIT_NOFATSTAM,
		TRAIT_NOLIMBDISABLE,
		TRAIT_NOHUNGER,
		TRAIT_EASYDISMEMBER,
		TRAIT_NOBREATH,
		TRAIT_NOPAIN,
		TRAIT_TOXIMMUNE,
		TRAIT_CHUNKYFINGERS,
		TRAIT_NOSLEEP,
		TRAIT_BASHDOORS,
		TRAIT_LIMPDICK,
		TRAIT_SHOCKIMMUNE,
		TRAIT_SPELLCOCKBLOCK,
		TRAIT_ZOMBIE_SPEECH,
		TRAIT_LANGUAGE_BARRIER,
	)

/datum/antagonist/zombie/examine_friendorfoe(datum/antagonist/examined_datum,mob/examiner,mob/examined)
	if(istype(examined_datum, /datum/antagonist/vampirelord))
		var/datum/antagonist/vampirelord/V = examined_datum
		if(!V.disguised)
			return "<span class='boldnotice'>Another deadite.</span>"
	if(istype(examined_datum, /datum/antagonist/zombie))
		return "<span class='boldnotice'>Another deadite. My ally.</span>"
	if(istype(examined_datum, /datum/antagonist/skeleton))
		return "<span class='boldnotice'>Another deadite.</span>"

/datum/antagonist/zombie/on_gain()
	var/mob/living/carbon/human/zombie = owner?.current
	if(zombie)
		var/obj/item/bodypart/head = zombie.get_bodypart(BODY_ZONE_HEAD)
		if(!head)
			qdel(src)
			return
	zombie_start = world.time
	return ..()

/datum/antagonist/zombie/on_removal()
	var/mob/living/carbon/human/zombie = owner?.current
	if(zombie)
		if(!was_i_undead)
			zombie.mob_biotypes &= ~MOB_UNDEAD
		zombie.faction -= "undead"
		zombie.verbs -= /mob/living/carbon/human/proc/zombie_seek
		zombie.mind?.special_role = special_role
		zombie.ambushable = ambushable
		if(zombie.dna?.species)
			zombie.dna.species.soundpack_m = soundpack_m
			zombie.dna.species.soundpack_f = soundpack_f
		zombie.base_intents = base_intents
		zombie.update_a_intents()
		zombie.aggressive = 0
		zombie.mode = AI_OFF
		if(zombie.charflaw)
			zombie.charflaw.ephemeral = FALSE
		zombie.regenerate_organs()
		for(var/obj/item/bodypart/zombie_part as anything in zombie.bodyparts)
			zombie_part.update_disabled()
		zombie.update_body()
		zombie.STASTR = STASTR
		zombie.STASPD = STASPD
		zombie.STAINT = STAINT
		zombie.remove_client_colour(/datum/client_colour/monochrome)
	return ..()

/datum/antagonist/zombie/proc/transform_zombie()
	if(owner)
		owner.skill_experience = list()
	var/mob/living/carbon/human/zombie = owner.current
	if(!zombie)
		qdel(src)
		return
	var/obj/item/bodypart/head = zombie.get_bodypart(BODY_ZONE_HEAD)
	if(!head)
		qdel(src)
		return
	for(var/trait_applied in traits_applied)
		ADD_TRAIT(zombie, trait_applied, "[type]")
	if(zombie.mind)
		special_role = zombie.mind.special_role
		zombie.mind.special_role = name
	if(zombie.dna?.species)
		soundpack_m = zombie.dna.species.soundpack_m
		soundpack_f = zombie.dna.species.soundpack_f
		zombie.dna.species.soundpack_m = new /datum/voicepack/zombie/m()
		zombie.dna.species.soundpack_f = new /datum/voicepack/zombie/f()
	base_intents = zombie.base_intents
	zombie.base_intents = list(INTENT_HELP, INTENT_DISARM, INTENT_GRAB, /datum/intent/unarmed/claw)
	zombie.update_a_intents()
	zombie.setToxLoss(0, 0)
	zombie.aggressive = 1
	zombie.mode = AI_IDLE

	var/obj/item/organ/eyes/eyes = new /obj/item/organ/eyes/night_vision/zombie
	eyes.Insert(zombie, drop_if_replaced = TRUE)
	ambushable = zombie.ambushable
	zombie.ambushable = FALSE

	if(zombie.charflaw)
		zombie.charflaw.ephemeral = TRUE
	if(zombie.mob_biotypes & MOB_UNDEAD)
		was_i_undead = TRUE
	zombie.mob_biotypes |= MOB_UNDEAD
	zombie.faction += "undead"
	zombie.verbs |= /mob/living/carbon/human/proc/zombie_seek
	for(var/obj/item/bodypart/zombie_part as anything in zombie.bodyparts)
		if(!zombie_part.rotted && !zombie_part.skeletonized)
			zombie_part.rotted = TRUE
		zombie_part.update_disabled()
	zombie.update_body()

	if(prob(8))
		zombie.STASTR = 18
	else
		zombie.STASTR = rand(12,14)

	if(prob(8))
		zombie.STASPD = 7
	else
		zombie.STASPD = rand(2,4)

	zombie.STAINT = 1

/datum/antagonist/zombie/greet()
	to_chat(owner.current, "<span class='userdanger'>Death is not the end...</span>")
	return ..()

/datum/antagonist/zombie/on_life(mob/user)
	if(!user)
		return
	if(user.stat == DEAD)
		return
	var/mob/living/carbon/human/zombie = user
	zombie.blood_volume = BLOOD_VOLUME_MAXIMUM
	if(world.time > next_idle_sound)
		zombie.emote("idle")
		next_idle_sound = world.time + rand(5 SECONDS, 10 SECONDS)

//Infected wake param is just a transition from living to zombie, via zombie_infect()
//Previously you just died without warning in 3 minutes, now you just become an antag
/datum/antagonist/zombie/proc/wake_zombie(infected_wake = FALSE)
	testing("WAKEZOMBIE")
	if(!owner.current)
		return
	var/mob/living/carbon/human/zombie = owner.current
	if(!zombie || !istype(zombie))
		return
	var/obj/item/bodypart/head = zombie.get_bodypart(BODY_ZONE_HEAD)
	if(!head)
		qdel(src)
		return
	if(zombie.stat != DEAD && !infected_wake)
		qdel(src)
		return
	if(istype(zombie.loc, /obj/structure/closet/dirthole))
		qdel(src)
		return

	zombie.stat = null //the mob starts unconscious,
	zombie.blood_volume = BLOOD_VOLUME_MAXIMUM
	zombie.updatehealth() //then we check if the mob should wake up.
	zombie.update_mobility()
	zombie.update_sight()
	zombie.clear_alert("not_enough_oxy")
	zombie.reload_fullscreen()
	zombie.add_client_colour(/datum/client_colour/monochrome)
	revived = TRUE //so we can die for real later
	transform_zombie()
	if(zombie.stat >= DEAD)
		//could not revive
		qdel(src)

/mob/living/carbon/human/proc/zombie_seek()
	set name = "Seek Brains"
	set category = "ZOMBIE"

	if(!mind.has_antag_datum(/datum/antagonist/zombie))
		return FALSE
	if(stat >= UNCONSCIOUS)
		return FALSE
	var/closest_dist
	var/the_dir
	for(var/mob/living/carbon/human/humie as anything in GLOB.human_list)
		if(humie == src)
			continue
		if(humie.mob_biotypes & MOB_UNDEAD)
			continue
		if(humie.stat >= DEAD)
			continue
		var/total_distance = get_dist(src, humie)
		if(!closest_dist)
			closest_dist = total_distance
			the_dir = get_dir(src, humie)
		else
			if(total_distance < closest_dist)
				closest_dist = total_distance
				the_dir = get_dir(src, humie)
	if(!closest_dist)
		to_chat(src, "<span class='warning'>I failed to smell anything...</span>")
		return FALSE
	to_chat(src, "<span class='warning'>[closest_dist] meters away, [dir2text(the_dir)]...</span>")
	return TRUE

/**
 * This occurs when one zombie infects a living human, going into instadeath from here is kind of shit and confusing
 * We instead just transform at the end
 */
/mob/living/carbon/human/proc/zombie_infect_attempt()
	if(!prob(7))
		return FALSE
	if(!mind)
		return FALSE
	if(mind.has_antag_datum(/datum/antagonist/vampirelord))
		return FALSE
	if(mind.has_antag_datum(/datum/antagonist/zombie))
		return FALSE
	if(mind.has_antag_datum(/datum/antagonist/werewolf))
		return FALSE
	var/datum/antagonist/zombie/new_antag = new /datum/antagonist/zombie()
	mind.add_antag_datum(new_antag)
	if(stat >= DEAD) //do shit the natural way i guess
		return FALSE
	to_chat(src, "<span class='danger'>I feel horrible... REALLY horrible after that...</span>")
	if(getToxLoss() >= 75 && blood_volume)
		mob_timers["puke"] = world.time
		vomit(1, blood = TRUE)
	sleep(1 MINUTES) //you get a minute
	flash_fullscreen("redflash3")
	to_chat(src, "<span class='danger'>It hurts... Is this really the end for me...</span>")
	emote("scream") // heres your warning to others bro
	Knockdown(1)
	new_antag.wake_zombie(TRUE)
	return TRUE
