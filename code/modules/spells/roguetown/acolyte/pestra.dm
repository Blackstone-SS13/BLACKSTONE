// Diagnose 
/obj/effect/proc_holder/spell/invoked/diagnose
	name = "Diagnose"
	overlay_state = "diagnose"
	releasedrain = 10
	chargedrain = 0
	chargetime = 0
	range = 2
	warnie = "sydwarning"
	movement_interrupt = FALSE
	sound = 'sound/magic/diagnose.ogg'
	invocation_type = "none"
	associated_skill = /datum/skill/magic/holy
	antimagic_allowed = TRUE
	charge_max = 5 SECONDS //very stupidly simple spell
	miracle = TRUE
	devotion_cost = 5 //come on, this is very basic

/obj/effect/proc_holder/spell/invoked/diagnose/cast(list/targets, mob/living/user)
	if(ishuman(targets[1]))
		var/mob/living/carbon/human/human_target = targets[1]
		human_target.check_for_injuries(user)
		return TRUE
	return FALSE

// Limb or organ attachment
/obj/effect/proc_holder/spell/invoked/attach_bodypart
	name = "Bodypart Miracle"
	overlay_state = "limb_attach"
	releasedrain = 30
	chargedrain = 0
	chargetime = 0
	req_items = list(/obj/item/clothing/neck/roguetown/psicross)
	range = 2
	warnie = "sydwarning"
	movement_interrupt = FALSE
	sound = 'sound/gore/flesh_eat_03.ogg'
	invocation_type = "none"
	associated_skill = /datum/skill/magic/holy
	antimagic_allowed = TRUE
	charge_max = 60 SECONDS //attaching a limb is pretty intense
	miracle = TRUE
	devotion_cost = 60

/obj/effect/proc_holder/spell/invoked/attach_bodypart/proc/get_organs(mob/living/target, mob/living/user)
	var/list/missing_organs = list(
		ORGAN_SLOT_EARS,
		ORGAN_SLOT_EYES,
		ORGAN_SLOT_TONGUE,
		ORGAN_SLOT_HEART,
		ORGAN_SLOT_LUNGS,
		ORGAN_SLOT_LIVER,
		ORGAN_SLOT_STOMACH,
		ORGAN_SLOT_APPENDIX,
	)
	for(var/missing_organ_slot in missing_organs)
		if(!target.getorganslot(missing_organ_slot))
			continue
		missing_organs -= missing_organ_slot
	if(!length(missing_organs))
		return
	var/list/organs = list()
	//try to get from user's hands first
	for(var/obj/item/organ/potential_organ in user?.held_items)
		if(potential_organ.owner || !(potential_organ.slot in missing_organs))
			continue
		organs += potential_organ
	//then target's hands
	for(var/obj/item/organ/dismembered in target.held_items)
		if(dismembered.owner || !(dismembered.slot in missing_organs))
			continue
		organs += dismembered
	//then finally, 1 tile range around target
	for(var/obj/item/organ/dismembered in range(1, target))
		if(dismembered.owner || !(dismembered.slot in missing_organs))
			continue
		organs += dismembered
	return organs

/obj/effect/proc_holder/spell/invoked/attach_bodypart/proc/get_limbs(mob/living/target, mob/living/user)
	var/list/missing_limbs = target.get_missing_limbs()
	if(!length(missing_limbs))
		return
	var/list/limbs = list()
	//try to get from user's hands first
	for(var/obj/item/bodypart/potential_limb in user?.held_items)
		if(potential_limb.owner || !(potential_limb.body_zone in missing_limbs))
			continue
		limbs += potential_limb
	//then target's hands
	for(var/obj/item/bodypart/dismembered in target.held_items)
		if(dismembered.owner || !(dismembered.body_zone in missing_limbs))
			continue
		limbs += dismembered
	//then finally, 1 tile range around target
	for(var/obj/item/bodypart/dismembered in range(1, target))
		if(dismembered.owner || !(dismembered.body_zone in missing_limbs))
			continue
		limbs += dismembered
	return limbs

// consider adding functionality to regrow one entire organ or limb per casting?
/obj/effect/proc_holder/spell/invoked/attach_bodypart/cast(list/targets, mob/living/user)
	if(ishuman(targets[1]))
		var/mob/living/carbon/human/human_target = targets[1]
		for(var/obj/item/bodypart/limb as anything in get_limbs(human_target, user))
			if(human_target.get_bodypart(limb.body_zone) || !limb.attach_limb(human_target))
				continue
			human_target.visible_message(span_info("\The [limb] attaches itself to [human_target]!"), \
								span_notice("\The [limb] attaches itself to me!"))
		for(var/obj/item/organ/organ as anything in get_organs(human_target, user))
			if(human_target.getorganslot(organ.slot) || !organ.Insert(human_target))
				continue
			human_target.visible_message(span_info("\The [organ] attaches itself to [human_target]!"), \
								span_notice("\The [organ] attaches itself to me!"))
		if(!(human_target.mob_biotypes & MOB_UNDEAD))
			for(var/obj/item/bodypart/limb as anything in human_target.bodyparts)
				limb.rotted = FALSE
				limb.skeletonized = FALSE
		human_target.update_body()
		return TRUE
	return FALSE

// Cure rot
/obj/effect/proc_holder/spell/invoked/cure_rot
	name = "Cure Rot"
	overlay_state = "cure_rot"
	releasedrain = 90
	chargedrain = 0
	chargetime = 50
	range = 1
	warnie = "sydwarning"
	no_early_release = TRUE
	movement_interrupt = TRUE
	chargedloop = /datum/looping_sound/invokeholy
	req_items = list(/obj/item/clothing/neck/roguetown/psicross)
	sound = 'sound/magic/revive.ogg'
	associated_skill = /datum/skill/magic/holy
	antimagic_allowed = TRUE
	charge_max = 2 MINUTES
	miracle = TRUE
	devotion_cost = 100
	/// Amount of PQ gained for curing zombos
	var/unzombification_pq = PQ_GAIN_UNZOMBIFY

/obj/effect/proc_holder/spell/invoked/cure_rot/cast(list/targets, mob/living/user)
	if(isliving(targets[1]))
		testing("curerot1")
		var/mob/living/target = targets[1]
		if(target == user)
			return FALSE
		var/datum/antagonist/zombie/was_zombie = target.mind?.has_antag_datum(/datum/antagonist/zombie)
		var/has_rot = was_zombie
		if(!has_rot && iscarbon(target))
			var/mob/living/carbon/stinky = target
			for(var/obj/item/bodypart/bodypart as anything in stinky.bodyparts)
				if(bodypart.rotted || bodypart.skeletonized)
					has_rot = TRUE
					break
		if(!has_rot)
			to_chat(user, span_warning("Nothing happens."))
			return FALSE
		if(GLOB.tod == "night")
			to_chat(user, span_warning("Let there be light."))
		for(var/obj/structure/fluff/psycross/S in oview(5, user))
			S.AOE_flash(user, range = 8)
		testing("curerot2")
		if(was_zombie)
			if(was_zombie.become_rotman && prob(5)) //5% chance to NOT become a rotman
				was_zombie.become_rotman = FALSE
			target.mind.remove_antag_datum(/datum/antagonist/zombie)
			target.Unconscious(20 SECONDS)
			target.emote("breathgasp")
			target.Jitter(100)
			if(unzombification_pq && !HAS_TRAIT(target, TRAIT_IWASUNZOMBIFIED) && user?.ckey)
				adjust_playerquality(unzombification_pq, user.ckey)
				ADD_TRAIT(target, TRAIT_IWASUNZOMBIFIED, "[type]")
		var/datum/component/rot/rot = target.GetComponent(/datum/component/rot)
		if(rot)
			rot.amount = 0
		if(iscarbon(target))
			var/mob/living/carbon/stinky = target
			for(var/obj/item/bodypart/rotty in stinky.bodyparts)
				rotty.rotted = FALSE
				rotty.skeletonized = FALSE
				rotty.update_limb()
				rotty.update_disabled()
		target.update_body()
		if(!HAS_TRAIT(target, TRAIT_ROTMAN))
			target.visible_message(span_notice("The rot leaves [target]'s body!"), span_green("I feel the rot leave my body!"))
		else
			target.visible_message(span_warning("The rot fails to leave [target]'s body!"), span_warning("I feel no different..."))
		return TRUE
	return FALSE

/obj/effect/proc_holder/spell/invoked/cure_rot/cast_check(skipcharge = 0,mob/user = usr)
	if(!..())
		return FALSE
	var/found = null
	for(var/obj/structure/fluff/psycross/S in oview(5, user))
		found = S
	if(!found)
		to_chat(user, span_warning("I need a holy cross."))
		return FALSE
	return TRUE
