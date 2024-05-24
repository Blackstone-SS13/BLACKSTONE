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

/// Loops through our list of wounds and returns the first wound that is of the type specified by the path
/mob/living/proc/heal_wounds(heal_amount, sleep_heal = FALSE)
	var/healed_any = FALSE
	for(var/datum/wound/wound as anything in get_wounds())
		if((heal_amount <= 0) || (sleep_heal && !wound.sleep_healing))
			continue
		var/amount_healed = wound.heal_wound(heal_amount)
		heal_amount -= amount_healed
		healed_any = TRUE
	return healed_any

/// Tries to do a critical hit on a mob that uses simple wounds - DO NOT CALL THIS ON CARBON MOBS, THEY HAVE BODYPARTS!
/mob/living/proc/try_crit(bclass, dam, mob/living/user, zone_precise)
	if(!dam || (status_flags & GODMODE) || !HAS_TRAIT(src, TRAIT_SIMPLE_WOUNDS))
		return FALSE
	if(check_zone(zone_precise) == BODY_ZONE_HEAD)
		if(bclass == BCLASS_BLUNT || bclass == BCLASS_SMASH || bclass == BCLASS_PICK)
			var/used = round((health / maxHealth) * 20 + (dam / 3), 1)
			if(user)
				if(istype(user.rmb_intent, /datum/rmb_intent/strong))
					used += 10
			if(prob(used))
				if(has_wound(/datum/wound/fracture/head))
					return FALSE
				var/static/list/phrases = list(
					"The skull shatters in a gruesome way!", 
					"The head is smashed!", 
					"The skull is broken!", 
					"The skull caves in!",
				)
				src.next_attack_msg += " <span class='crit'><b>Critical hit!</b> [pick(phrases)]</span>"
				if(prob(3))
					playsound(src, 'sound/combat/tf2crit.ogg', 100, FALSE)
				else
					playsound(src, "headcrush", 100, FALSE)
				return simple_add_wound(/datum/wound/fracture/head)
	if(bclass == BCLASS_STAB || bclass == BCLASS_PICK || bclass == BCLASS_CUT || bclass == BCLASS_CHOP || bclass == BCLASS_BITE)
		if(bclass == BCLASS_CHOP || bclass == BCLASS_PICK)
			if(user)
				if(istype(user.rmb_intent, /datum/rmb_intent/strong))
					dam += 30
		else
			if(user)
				if(istype(user.rmb_intent, /datum/rmb_intent/aimed))
					dam += 30
		if(prob(round(max(dam / 3, 1), 1)))
			if(has_wound(/datum/wound/artery))
//				if(bclass == BCLASS_STAB || bclass == BCLASS_PICK)
//					death()
//					return TRUE
				return FALSE
			if(prob(3))
				playsound(src, 'sound/combat/tf2crit.ogg', 100, FALSE)
			else
				playsound(src, pick('sound/combat/crit.ogg'), 100, FALSE)
			src.emote("death", forced =TRUE)
			src.next_attack_msg += " <span class='crit'><b>Critical hit!</b> Blood sprays from [src]!</span>"
			return simple_add_wound(/datum/wound/artery)
//			if(bclass == BCLASS_STAB || bclass == BCLASS_PICK)
//				death()
//				return TRUE

/mob/living/proc/simple_woundcritroll(bclass, dam, mob/living/user, zone_precise)
	if(!bclass || !dam || (status_flags & GODMODE) || !HAS_TRAIT(src, TRAIT_SIMPLE_WOUNDS))
		return FALSE
	if(user)
		if(user.goodluck(2))
			dam += 10
		if(!istype(user.rmb_intent, /datum/rmb_intent/weak))
			var/crit_attempt = try_crit(bclass, dam, user, zone_precise)
			if(crit_attempt)
				return crit_attempt
	else
		var/crit_attempt = try_crit(bclass, dam, user, zone_precise)
		if(crit_attempt)
			return crit_attempt
	switch(bclass) //do stuff but only when we are a blade that adds wounds
		if(BCLASS_SMASH, BCLASS_BLUNT)
			switch(dam)
				if(1 to 10)
					return simple_add_wound(/datum/wound/bruise/small)
				if(11 to 20)
					return simple_add_wound(/datum/wound/bruise)
				if(21 to INFINITY)
					return simple_add_wound(/datum/wound/bruise/large)
		if(BCLASS_CUT, BCLASS_CHOP)
			switch(dam)
				if(1 to 10)
					return simple_add_wound(/datum/wound/slash/small)
				if(11 to 20)
					return simple_add_wound(/datum/wound/slash)
				if(21 to INFINITY)
					return simple_add_wound(/datum/wound/slash/large)
		if(BCLASS_STAB, BCLASS_PICK)
			switch(dam)
				if(1 to 10)
					return simple_add_wound(/datum/wound/puncture/small)
				if(11 to 20)
					return simple_add_wound(/datum/wound/puncture)
				if(21 to INFINITY)
					return simple_add_wound(/datum/wound/puncture/large)
		if(BCLASS_BITE)
			if(dam > 8)
				return simple_add_wound(/datum/wound/bite/bleeding)
			return simple_add_wound(/datum/wound/bite)

/// Simple version for adding a wound - DO NOT CALL THIS ON CARBON MOBS!
/mob/living/proc/simple_add_wound(datum/wound/wound)
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
	if(!wound.apply_to_mob(src))
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
