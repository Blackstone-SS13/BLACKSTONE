/datum/antagonist/werewolf
	name = "Werewolf"
	roundend_category = "Werewolves"
	antagpanel_category = "Werewolf"
	job_rank = ROLE_WEREWOLF
	antag_hud_type = ANTAG_HUD_WEREWOLF
	antag_hud_name = "Werewolf"
	confess_lines = list(
		"THE BEAST INSIDE ME!", 
		"BEWARE THE BEAST!", 
		"MY LUPINE MARK!",
	)
	var/special_role = ROLE_WEREWOLF
	var/transformed
	var/transforming
	var/transform_cooldown
	var/wolfname = "Werevolf"
	var/pre_transform
	var/next_idle_sound
/datum/antagonist/werewolf/apply_innate_effects(mob/living/mob_override)
	var/mob/living/M = mob_override || owner.current
	add_antag_hud(antag_hud_type, antag_hud_name, M)

/datum/antagonist/werewolf/remove_innate_effects(mob/living/mob_override)
	var/mob/living/M = mob_override || owner.current
	remove_antag_hud(antag_hud_type, M)

/datum/antagonist/werewolf/lesser
	name = "Lesser Werewolf"
	increase_votepwr = FALSE

/datum/antagonist/werewolf/lesser/roundend_report()
	return

/datum/antagonist/werewolf/examine_friendorfoe(datum/antagonist/examined_datum,mob/examiner,mob/examined)
	if(istype(examined_datum, /datum/antagonist/werewolf/lesser))
		return "<span class='boldnotice'>A young lupine kin.</span>"
	if(istype(examined_datum, /datum/antagonist/werewolf))
		return "<span class='boldnotice'>An elder lupine kin.</span>"
	if(examiner.Adjacent(examined))
		if(istype(examined_datum, /datum/antagonist/vampirelord/lesser))
			if(transformed)
				return "<span class='boldwarning'>A lesser Vampire.</span>"
		if(istype(examined_datum, /datum/antagonist/vampirelord))
			if(transformed)
				return "<span class='boldwarning'>An Ancient Vampire. I must be careful!</span>"

/datum/antagonist/werewolf/on_gain()
	transform_cooldown = SSticker.round_start_time
	owner.special_role = name
	if(increase_votepwr)
		forge_werewolf_objectives()

	wolfname = "[pick(GLOB.wolf_prefixes)] [pick(GLOB.wolf_suffixes)]"

	// SPELL TESTING
	owner.AddSpell(new /obj/effect/proc_holder/spell/self/howl)

	return ..()

/datum/antagonist/werewolf/on_removal()
	if(!silent && owner.current)
		to_chat(owner.current,"<span class='danger'>I am no longer a [special_role]!</span>")
	owner.special_role = null
	return ..()

/datum/antagonist/werewolf/proc/add_objective(datum/objective/O)
	objectives += O

/datum/antagonist/werewolf/proc/remove_objective(datum/objective/O)
	objectives -= O

/datum/antagonist/werewolf/proc/forge_werewolf_objectives()
	if(!(locate(/datum/objective/escape) in objectives))
		var/datum/objective/werewolf/escape_objective = new
		escape_objective.owner = owner
		add_objective(escape_objective)
		return

/datum/antagonist/werewolf/greet()
	to_chat(owner.current, "<span class='userdanger'>Ever since that bite, I have been a [owner.special_role].</span>")
	owner.announce_objectives()
	..()
	
/datum/antagonist/werewolf/on_life(mob/user)

	if(!user) return
	var/mob/living/carbon/human/H = user
	if(H.stat == DEAD) return
	if(H.advsetup) return

	// Werewolf transforms at night AND under the sky
	if(!transformed && !transforming)
		if(GLOB.tod == "night")
			if(isturf(H.loc))
				var/turf/loc = H.loc
				if(loc.can_see_sky())
					to_chat(H, "<span class='userdanger'>The moonlight scorns me... It is too late.</span>")
					owner.current.playsound_local(get_turf(owner.current), 'sound/music/wolfintro.ogg', 80, FALSE, pressure_affected = FALSE)
					H.flash_fullscreen("redflash3")
					transforming = world.time // timer
	
	// Begin transformation
	else if(transforming)
		if (world.time >= transforming + 35 SECONDS) // Stage 3
			H.werewolf_transform()
			transforming = FALSE
			transformed = world.time // Timer
			
		else if (world.time >= transforming + 25 SECONDS) // Stage 2
			H.flash_fullscreen("redflash3")
			H.emote("agony", forced = TRUE)
			to_chat(H, "<span class='userdanger'>UNIMAGINABLE PAIN!</span>")
			H.Stun(30)
			H.Knockdown(30)

		else if (world.time >= transforming + 10 SECONDS) // Stage 1
			H.emote("")
			to_chat(H, "<span class='warning'>I can feel my muscles aching, it feels HORRIBLE...</span>")
		

	// Werewolf reverts to human form during the day
	else if(transformed)
		H.real_name = wolfname
		H.name = wolfname

		if(GLOB.tod != "night")
			if (world.time >= transformed + 25 SECONDS) // Untransform
				//H.emote("rage", forced = TRUE)
				H.werewolf_untransform()
				transformed = FALSE

			else if (world.time >= transformed + 10 SECONDS) // Alert player
				//H.flash_fullscreen("redflash1")
				to_chat(H, "<span class='warning'>Daylight shines around me... the curse begins to fade.</span>")

/mob/living/carbon/human/proc/werewolf_infect()
	if(!mind)
		return
	if(mind.has_antag_datum(/datum/antagonist/vampirelord))
		return
	if(mind.has_antag_datum(/datum/antagonist/zombie))
		return
	if(mind.has_antag_datum(/datum/antagonist/werewolf))
		return
	var/datum/antagonist/werewolf/new_antag = new /datum/antagonist/werewolf/lesser()
	mind.add_antag_datum(new_antag)
	//new_antag.transforming = world.time
	//src.playsound_local(get_turf(src), 'sound/music/horror.ogg', 80, FALSE, pressure_affected = FALSE)
	flash_fullscreen("redflash3")
