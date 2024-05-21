/datum/antagonist/zombie
	name = "Zomble"
	antag_hud_type = ANTAG_HUD_TRAITOR
	antag_hud_name = "zombie"
	show_in_roundend = FALSE
	/// SET TO FALSE IF WE DON'T TURN INTO ROTMEN WHEN REMOVED
	var/become_rotman = TRUE
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
	var/skin_tone
	var/cmode_music
	var/list/base_intents
	/// Whether or not we have been turned
	var/has_turned = FALSE
	/// Last time we bit someone - Zombies will try to bite after 10 seconds of not biting
	var/last_bite
	/// Traits applied to the owner mob when we turn into a zombie
	var/static/list/traits_zombie = list(
		RTRAIT_NOFATSTAM,
		TRAIT_NOMOOD,
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
		TRAIT_ZOMBIE_IMMUNE,
		TRAIT_BLOODLOSS_IMMUNE,
	)
	/// Traits applied to the owner when we are cured and turn into just "rotmen"
	var/static/list/traits_rotman = list(
		TRAIT_ROTMAN,
		TRAIT_EASYDISMEMBER,
		TRAIT_NOBREATH,
		TRAIT_NOPAIN,
		TRAIT_TOXIMMUNE,
		TRAIT_LIMPDICK,
		TRAIT_ZOMBIE_IMMUNE,
	)

/datum/antagonist/zombie/examine_friendorfoe(datum/antagonist/examined_datum,mob/examiner,mob/examined)
	if(istype(examined_datum, /datum/antagonist/vampirelord))
		var/datum/antagonist/vampirelord/V = examined_datum
		if(!V.disguised)
			return "<span class='boldnotice'>Another deadite.</span>"
	if(istype(examined_datum, /datum/antagonist/zombie))
		var/datum/antagonist/zombie/fellow_zombie = examined_datum
		return "<span class='boldnotice'>Another deadite. [fellow_zombie.has_turned ? "My ally." : "<span class='warning'>Hasn't turned yet.</span>"]</span>"
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
	was_i_undead = zombie.mob_biotypes & MOB_UNDEAD
	special_role = zombie.mind?.special_role
	ambushable = zombie.ambushable
	if(zombie.dna?.species)
		soundpack_m = zombie.dna.species.soundpack_m
		soundpack_f = zombie.dna.species.soundpack_f
	base_intents = zombie.base_intents
	STASTR = zombie.STASTR
	STASPD = zombie.STASPD
	STAINT = zombie.STAINT
	skin_tone = zombie.skin_tone
	cmode_music = zombie.cmode_music
	return ..()

/datum/antagonist/zombie/on_removal()
	var/mob/living/carbon/human/zombie = owner?.current
	if(zombie)
		zombie.verbs -= /mob/living/carbon/human/proc/zombie_seek
		zombie.mind?.special_role = special_role
		zombie.ambushable = ambushable
		if(zombie.dna?.species)
			zombie.dna.species.soundpack_m = soundpack_m
			zombie.dna.species.soundpack_f = soundpack_f
		zombie.base_intents = base_intents
		zombie.update_a_intents()
		zombie.aggressive = FALSE
		zombie.mode = AI_OFF
		if(zombie.charflaw)
			zombie.charflaw.ephemeral = FALSE
		zombie.update_body()
		zombie.STASTR = STASTR
		zombie.STASPD = STASPD
		zombie.STAINT = STAINT
		zombie.cmode_music = cmode_music
		for(var/trait in traits_zombie)
			REMOVE_TRAIT(zombie, trait, "[type]")
		zombie.remove_client_colour(/datum/client_colour/monochrome)
		if(has_turned && become_rotman)
			zombie.STACON = max(zombie.STACON - 2, 1) //ur rotting bro
			zombie.STASPD = max(zombie.STASPD - 3, 1)
			zombie.STAINT = max(zombie.STAINT - 3, 1)
			for(var/trait in traits_rotman)
				ADD_TRAIT(zombie, trait, "[type]")
			to_chat(zombie, "<span class='green'>I no longer crave for flesh... <i>But I still feel ill.</i></span>")
		else
			if(!was_i_undead)
				zombie.mob_biotypes &= ~MOB_UNDEAD
			zombie.faction -= "undead"
			zombie.regenerate_organs()
			zombie.skin_tone = skin_tone
			to_chat(zombie, "<span class='green'>I no longer crave for flesh...</span>")
		for(var/obj/item/bodypart/zombie_part as anything in zombie.bodyparts)
			zombie_part.rotted = FALSE
			zombie_part.update_disabled()
			zombie_part.update_limb()
		zombie.update_body()
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
	for(var/trait_applied in traits_zombie)
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
	zombie.aggressive = TRUE
	zombie.mode = AI_IDLE
	zombie.handle_ai()

	var/obj/item/organ/eyes/eyes = new /obj/item/organ/eyes/night_vision/zombie
	eyes.Insert(zombie, drop_if_replaced = TRUE)
	ambushable = zombie.ambushable
	zombie.ambushable = FALSE

	if(zombie.charflaw)
		zombie.charflaw.ephemeral = TRUE
	zombie.mob_biotypes |= MOB_UNDEAD
	zombie.faction += "undead"
	zombie.verbs |= /mob/living/carbon/human/proc/zombie_seek
	for(var/obj/item/bodypart/zombie_part as anything in zombie.bodyparts)
		if(!zombie_part.rotted && !zombie_part.skeletonized)
			zombie_part.rotted = TRUE
		zombie_part.update_disabled()
	zombie.skin_tone = SKIN_COLOR_ROT
	zombie.update_body()


	// Now you get what you had in life + the debuff from rotting limbs aka -8
	// Outside of one 2% chance remaining for zombie era strength
	if(prob(2))
		zombie.STASTR = 18

	// This is the original first commit values for it, aka 5-7
	zombie.STASPD = rand(5,7)

	zombie.STAINT = 1
	last_bite = world.time
	has_turned = TRUE
	to_chat(zombie, "<span class='userdanger'>I am now a zombie! I crave for the flesh of the living...</span>")

/datum/antagonist/zombie/greet()
	to_chat(owner.current, "<span class='userdanger'>Death is not the end...</span>")
	return ..()

/datum/antagonist/zombie/on_life(mob/user)
	if(!user || user.stat >= DEAD || !has_turned)
		return
	var/mob/living/carbon/human/zombie = user
	if(world.time > next_idle_sound)
		zombie.emote("idle")
		next_idle_sound = world.time + rand(5 SECONDS, 10 SECONDS)
	//fuck friendly zombies - tries to bite humans in range
	if(world.time - last_bite < 10 SECONDS)
		return
	var/obj/item/grabbing/bite/bite = zombie.get_item_by_slot(SLOT_MOUTH)
	if(!bite || !get_location_accessible(src, BODY_ZONE_PRECISE_MOUTH, grabs="other"))
		for(var/mob/living/carbon/human in view(1, zombie))
			if((human.mob_biotypes & MOB_UNDEAD) || ("undead" in human.faction) || HAS_TRAIT(human, TRAIT_ZOMBIE_IMMUNE))
				continue
			human.onbite(zombie)
	else if(istype(bite))
		bite.bitelimb(zombie)

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
	if(istype(zombie.loc, /obj/structure/closet/dirthole) || istype(zombie.loc, /obj/structure/closet/crate/coffin))
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
	if(!prob(3)) // Since zombies are biting a lot now, we drop this down to 3% chance of a conversion
		return 
	var/datum/antagonist/zombie/zombie_antag = zombie_check()
	if(!zombie_antag)
		return
	if(stat >= DEAD) //do shit the natural way i guess
		return 
	to_chat(src, "<span class='danger'>I feel horrible... REALLY horrible after that...</span>")
	if(blood_volume)
		mob_timers["puke"] = world.time
		vomit(1, blood = TRUE, stun = FALSE)
	addtimer(CALLBACK(src, PROC_REF(wake_zombie)), 1 MINUTES)
	return zombie_antag

/mob/living/carbon/human/proc/wake_zombie()
	var/datum/antagonist/zombie/zombie_antag = mind?.has_antag_datum(/datum/antagonist/zombie)
	if(!zombie_antag)
		return FALSE
	flash_fullscreen("redflash3")
	to_chat(src, "<span class='danger'>It hurts... Is this really the end for me?</span>")
	emote("scream") // heres your warning to others bro
	Knockdown(1)
	zombie_antag.wake_zombie(TRUE)
	return TRUE
