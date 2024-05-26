/mob/living
	/// Simple wounds with no associated bodyparts
	var/list/simple_wounds

/// Returns every wound we have, simple or not
/mob/living/proc/get_wounds()
	var/list/all_wounds = list()
	if(length(simple_wounds))
		all_wounds += simple_wounds
	return all_wounds

/// Gets all sewable wounds in a mob
/mob/living/proc/get_sewable_wounds()
	var/list/woundies = list()
	for(var/datum/wound/wound as anything in get_wounds())
		if(!wound.can_sew)
			continue
		woundies += wound
	return woundies
	
/// Loops through our list of wounds and returns the first wound that is of the type specified by the path
/mob/living/proc/has_wound(path, specific = FALSE)
	if(!path)
		return
	for(var/datum/wound/wound as anything in get_wounds())
		if((specific && wound.type != path) || !istype(wound, path))
			continue
		return wound

/// Simple version for adding a wound - DO NOT CALL THIS ON CARBON MOBS!
/mob/living/proc/simple_add_wound(datum/wound/wound, silent = FALSE, crit_message = FALSE)
	if(!wound || (status_flags & GODMODE) || !HAS_TRAIT(src, TRAIT_SIMPLE_WOUNDS))
		return FALSE
	if(ispath(wound, /datum/wound))
		var/datum/wound/primordial_wound = GLOB.primordial_wounds[wound]
		if(!primordial_wound.can_apply_to_mob(src))
			return
		wound = new wound()
	else if(!istype(wound))
		return
	else if(!wound.can_apply_to_mob(src))
		qdel(wound)
		return
	if(!wound.apply_to_mob(src, silent, crit_message))
		qdel(wound)
		return
	return wound

/// Simple version for removing a wound - DO NOT CALL THIS ON CARBON MOBS!
/mob/living/proc/simple_remove_wound(datum/wound/wound)
	if(!wound || !HAS_TRAIT(src, TRAIT_SIMPLE_WOUNDS))
		return FALSE
	if(ispath(wound))
		wound = has_wound(wound)
	if(!istype(wound))
		return FALSE
	. = wound.remove_from_mob()
	if(.)
		qdel(wound)

/// Loops through our list of wounds and returns the first wound that is of the type specified by the path
/mob/living/proc/heal_wounds(heal_amount)
	var/healed_any = FALSE
	for(var/datum/wound/wound as anything in get_wounds())
		if(heal_amount <= 0)
			continue
		var/amount_healed = wound.heal_wound(heal_amount)
		if(amount_healed)
			heal_amount -= amount_healed
			healed_any = TRUE
	return healed_any

/mob/living/proc/simple_woundcritroll(bclass, dam, mob/living/user, zone_precise, silent = FALSE, crit_message = FALSE)
	if(!bclass || !dam || (status_flags & GODMODE) || !HAS_TRAIT(src, TRAIT_SIMPLE_WOUNDS))
		return FALSE
	var/do_crit = TRUE
	if(user)
		if(user.goodluck(2))
			dam += 10
		if(istype(user.rmb_intent, /datum/rmb_intent/weak))
			do_crit = FALSE
	testing("simple_woundcritroll() dam [dam]")
	var/added_wound
	switch(bclass) //do stuff but only when we are a blade that adds wounds
		if(BCLASS_SMASH, BCLASS_BLUNT)
			switch(dam)
				if(20 to INFINITY)
					added_wound = /datum/wound/bruise/large
				if(10 to 20)
					added_wound = /datum/wound/bruise
				if(1 to 10)
					added_wound = /datum/wound/bruise/small
		if(BCLASS_CUT, BCLASS_CHOP)
			switch(dam)
				if(20 to INFINITY)
					added_wound = /datum/wound/slash/large
				if(10 to 20)
					added_wound = /datum/wound/slash
				if(1 to 10)
					added_wound = /datum/wound/slash/small
		if(BCLASS_STAB, BCLASS_PICK)
			switch(dam)
				if(20 to INFINITY)
					added_wound = /datum/wound/puncture/large
				if(10 to 20)
					added_wound = /datum/wound/puncture
				if(1 to 10)
					added_wound = /datum/wound/puncture/small
		if(BCLASS_BITE)
			switch(dam)
				if(20 to INFINITY)
					added_wound = /datum/wound/bite/large
				if(10 to 20)
					added_wound = /datum/wound/bite
				if(1 to 10)
					added_wound = /datum/wound/bite/small
	if(added_wound)
		added_wound = simple_add_wound(added_wound, silent, crit_message)
	if(do_crit)
		var/crit_attempt = simple_try_crit(bclass, dam, user, zone_precise, silent, crit_message)
		if(crit_attempt)
			return crit_attempt
	return added_wound

/// Tries to do a critical hit on a mob that uses simple wounds - DO NOT CALL THIS ON CARBON MOBS, THEY HAVE BODYPARTS!
/mob/living/proc/simple_try_crit(bclass, dam, mob/living/user, zone_precise, silent = FALSE, crit_message = FALSE)
	if(!bclass || !dam || (status_flags & GODMODE) || !HAS_TRAIT(src, TRAIT_SIMPLE_WOUNDS))
		return FALSE
	var/list/attempted_wounds = list()
	var/used
	if(user)
		if(user.goodluck(2))
			dam += 10
	if(bclass in GLOB.fracture_bclasses)
		var/fracture_type = /datum/wound/fracture/chest
		if(check_zone(zone_precise) == BODY_ZONE_HEAD)
			fracture_type = /datum/wound/fracture/head
		used = round((health / maxHealth) * 20 + (dam / 3), 1)
		if(user && istype(user.rmb_intent, /datum/rmb_intent/strong))
			used += 10
		if(prob(used))
			attempted_wounds += fracture_type
	if(bclass in GLOB.artery_bclasses)
		if(user)
			if((bclass in GLOB.artery_strong_bclasses) && istype(user.rmb_intent, /datum/rmb_intent/strong))
				dam += 30
			else if(istype(user.rmb_intent, /datum/rmb_intent/aimed))
				dam += 30
		used = round(max(dam / 3, 1), 1)
		if(prob(used))
			attempted_wounds += /datum/wound/artery/chest
		
	for(var/wound_type in shuffle(attempted_wounds))
		var/datum/wound/applied = simple_add_wound(wound_type, silent, crit_message)
		if(applied)
			return applied
	return FALSE
