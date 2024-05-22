/obj/item/bodypart
	/// List of /datum/wound instances affecting this bodypart
	var/list/wounds
	/// Bandage
	var/obj/item/bandage

/// Adds a wound to this bodypart, applying any necessary effects
/obj/item/bodypart/proc/add_wound(datum/wound/wound)
	if(!wound || !owner || (owner.status_flags & GODMODE))
		return
	if(ispath(wound, /datum/wound))
		var/datum/wound/primordial_wound = GLOB.primordial_wounds[wound]
		if(!primordial_wound.can_apply_to_bodypart(src))
			return
		wound = new wound()
	else if(!istype(wound))
		return
	else if(!wound.can_apply_to_bodypart(src))
		qdel(wound)
		return
	if(!wound.apply_to_bodypart(src))
		qdel(wound)
		return
	return wound

/// Removes a wound from this bodypart, removing any associated effects
/obj/item/bodypart/proc/remove_wound(datum/wound/wound)
	if(ispath(wound))
		wound = has_wound(wound)
	if(!istype(wound))
		return FALSE
	. = wound.remove_from_bodypart()
	if(.)
		qdel(wound)

/// Check to see if we can apply a bleeding wound on this bodypart
/obj/item/bodypart/proc/can_bloody_wound()
	if(owner?.dna?.species)
		if(NOBLOOD in owner.dna.species.species_traits)
			return FALSE
	if(!is_organic_limb())
		return FALSE
	if(skeletonized)
		return FALSE
	return TRUE

/obj/item/bodypart/proc/temporary_crit_paralysis(duration = 60 SECONDS)
	if(HAS_TRAIT_FROM(src, TRAIT_PARALYSIS, CRIT_TRAIT))
		return FALSE
	ADD_TRAIT(src, TRAIT_PARALYSIS, CRIT_TRAIT)
	addtimer(CALLBACK(src, PROC_REF(remove_crit_paralysis)), duration)
	update_disabled()
	return TRUE

/obj/item/bodypart/proc/remove_crit_paralysis()
	REMOVE_TRAIT(src, TRAIT_PARALYSIS, CRIT_TRAIT)
	update_disabled()
	return TRUE

/// Behemoth of a proc used to apply a wound after a bodypart is damaged in an attack
/obj/item/bodypart/proc/try_crit(bclass, dam, mob/living/user, zone_precise)
	if(!dam)
		return
	if(user)
		if(user.goodluck(2))
			dam += 10
	if(bclass == BCLASS_TWIST)
		var/used = round((brute_dam / max_damage)*20 + (dam / 3), 1)
		if(user)
			if(istype(user.rmb_intent, /datum/rmb_intent/strong))
				used += 10
			if(owner == user)
				used = 0
		if(prob(used))
			if(HAS_TRAIT_FROM(src, TRAIT_PARALYSIS, CRIT_TRAIT))
				if(brute_dam < max_damage)
					return FALSE
				if(has_wound(/datum/wound/fracture))
					return FALSE
				var/list/phrases = list("The bone shatters!", "The bone is broken!", "The [src.name] is mauled!", "The bone snaps through the skin!")
				owner.next_attack_msg += " <span class='crit'><b>Critical hit!</b> [pick(phrases)]</span>"
				add_wound(/datum/wound/fracture)
				if(prob(3))
					playsound(owner, pick('sound/combat/tf2crit.ogg'), 100, FALSE)
				else
					playsound(owner, "wetbreak", 100, FALSE)
				owner.emote("paincrit", TRUE)
				owner.Slowdown(20)
				shake_camera(owner, 2, 2)
				update_disabled()
			else
				var/list/phrases = list("The [src] jolts painfully!", "The [src] is disabled!")
				owner.next_attack_msg += " <span class='crit'><b>Critical hit!</b> [pick(phrases)]</span>"
				owner.emote("paincrit", TRUE)
				owner.Slowdown(20)
				shake_camera(owner, 2, 2)
				temporary_crit_paralysis()
				playsound(owner, "drybreak", 100, FALSE)
		return FALSE
	if(bclass == BCLASS_BLUNT || bclass == BCLASS_SMASH || bclass == BCLASS_CHOP)
		var/used = round((brute_dam / max_damage)*20 + (dam / 3), 1)
		if(HAS_TRAIT_FROM(src, TRAIT_PARALYSIS, CRIT_TRAIT))
			dam += 20
		if(user)
			if(istype(user.rmb_intent, /datum/rmb_intent/strong))
				used += 10
		var/foundf = has_wound(/datum/wound/fracture)
		if(!foundf)
			if(prob(used))
				var/list/phrases = list("The bone shatters!", "The bone is broken!", "The [src.name] is mauled!", "The bone snaps through the skin!")
				owner.next_attack_msg += " <span class='crit'><b>Critical hit!</b> [pick(phrases)]</span>"
				add_wound(/datum/wound/fracture)
				if(prob(3))
					playsound(owner, pick('sound/combat/tf2crit.ogg'), 100, FALSE)
				else
					playsound(owner, "wetbreak", 100, FALSE)
				owner.emote("paincrit", TRUE)
				owner.Slowdown(20)
				shake_camera(owner, 2, 2)
				update_disabled()
				return FALSE
	if(bclass == BCLASS_CUT || bclass == BCLASS_CHOP || bclass == BCLASS_STAB || bclass == BCLASS_BITE)
		var/used = round((brute_dam / max_damage)*20 + (dam / 3), 1)
		if(!can_bloody_wound())
			return FALSE
		if(user)
			if(bclass == BCLASS_CHOP)
				if(istype(user.rmb_intent, /datum/rmb_intent/strong))
					used += 10
			else
				if(istype(user.rmb_intent, /datum/rmb_intent/aimed))
					used += 10
		if(prob(used))
			if(has_wound(/datum/wound/artery))
				if(bclass == BCLASS_STAB)
					return TRUE
				return FALSE
			playsound(owner, pick('sound/combat/crit.ogg'), 100, FALSE)
			owner.emote("paincrit")
			owner.next_attack_msg += " <span class='crit'><b>Critical hit!</b> Blood sprays from [owner]'s [src.name]!</span>"
			add_wound(/datum/wound/artery)
			temporary_crit_paralysis()
			owner.Slowdown(20)
			shake_camera(owner, 2, 2)
			if(bclass == BCLASS_STAB)
				return TRUE

/obj/item/bodypart/chest/try_crit(bclass,dam,mob/living/user,zone_precise)
	var/resistance = HAS_TRAIT(owner, RTRAIT_CRITICAL_RESISTANCE)
	if(user && dam)
		if(user.goodluck(2))
			dam += 10
	if(bclass == BCLASS_TWIST) //the ol dick twist
		if(dam >= 10)
			if(zone_precise == BODY_ZONE_PRECISE_GROIN)
				// TESTICULAR TORSION!
				if(prob(1) && !has_wound(/datum/wound/cbt))
					add_wound(/datum/wound/cbt)
				else
					owner.emote("groin", forced = TRUE)
					owner.Stun(10)
		return FALSE
	if(bclass == BCLASS_BLUNT || bclass == BCLASS_SMASH || bclass == BCLASS_CHOP)
		var/used = round((brute_dam / max_damage) * 20 + (dam / 3), 1)
		if(zone_precise == BODY_ZONE_PRECISE_GROIN)
			if(dam >= 10)
				owner.emote("groin")
				owner.Stun(5) //implement once targetting groin is harder
		if(HAS_TRAIT_FROM(src, TRAIT_PARALYSIS, CRIT_TRAIT))
			used += 20
		if(user)
			if(istype(user.rmb_intent, /datum/rmb_intent/strong))
				used += 10
		var/foundf = has_wound(/datum/wound/fracture)
		if(!foundf)
			if(prob(used))
				if(zone_precise == BODY_ZONE_PRECISE_GROIN)
					var/static/list/phrases = list(
						"The pelvis shatters in a magnificent way!", 
						"The pelvis is smashed!", 
						"The groin is mauled!", 
						"The pelvic floor caves in!",
					)
					var/static/funny_phrase = "The buck is broken!"
					var/phrase_chosen
					if(prob(1))
						phrase_chosen = funny_phrase
					else
						phrase_chosen = pick(phrases)
					owner.next_attack_msg += " <span class='crit'><b>Critical hit!</b> [phrase_chosen]</span>"
					add_wound(/datum/wound/fracture/groin)
					owner.emote("groin", TRUE)
					if((phrase_chosen == funny_phrase) || prob(3))
						playsound(owner, 'sound/combat/tf2crit.ogg', 100, FALSE)
					else
						playsound(owner, "wetbreak", 100, FALSE)
					update_disabled()
					owner.Slowdown(20)
					shake_camera(owner, 2, 2)
					if(bclass == BCLASS_CHOP)
						return TRUE
					return FALSE
				else if(zone_precise != BODY_ZONE_PRECISE_STOMACH)
					var/static/list/phrases = list(
						"The ribs shatter in a splendid way!", 
						"The ribs are smashed!", 
						"The chest is mauled!", 
						"The chest caves in!",
					)
					owner.next_attack_msg += " <span class='crit'><b>Critical hit!</b> [pick(phrases)]</span>"
					add_wound(/datum/wound/fracture)
					owner.emote("paincrit", TRUE)
					if(prob(3))
						playsound(owner, 'sound/combat/tf2crit.ogg', 100, FALSE)
					else
						playsound(owner, "wetbreak", 100, FALSE)
					update_disabled()
					owner.Slowdown(20)
					shake_camera(owner, 2, 2)
					if(bclass == BCLASS_CHOP)
						return TRUE
					return FALSE
	if(bclass == BCLASS_CUT || bclass == BCLASS_CHOP || bclass == BCLASS_STAB || bclass == BCLASS_BITE)
		var/used = round((brute_dam / max_damage)*20 + (dam / 4), 1)
		if(!can_bloody_wound())
			return FALSE
		if(user)
			if(bclass == BCLASS_CHOP)
				if(istype(user.rmb_intent, /datum/rmb_intent/strong))
					used += 10
			else
				if(istype(user.rmb_intent, /datum/rmb_intent/aimed))
					used += 10
		var/foundy = has_wound(/datum/wound/artery)
		if(zone_precise == BODY_ZONE_PRECISE_STOMACH)
			if (prob(used+10))
				if(!can_bloody_wound() || resistance)
					return FALSE
				var/organ_spilled = FALSE
				var/turf/T = get_turf(owner)
				owner.add_splatter_floor(T)
				playsound(owner, 'sound/combat/crit2.ogg', 100, FALSE, 5)
				owner.emote("paincrit", TRUE)
				. = list()
				var/static/list/spillable_slots = list(
					ORGAN_SLOT_STOMACH = 100,
					ORGAN_SLOT_LIVER = 50,
				)
				var/list/spilled_organs = list()
				for(var/obj/item/organ/organ as anything in owner.internal_organs)
					var/org_zone = check_zone(organ.zone)
					if(org_zone != BODY_ZONE_CHEST)
						continue
					if(!(organ.slot in spillable_slots))
						continue
					var/spill_prob = spillable_slots[organ.slot]
					if(prob(spill_prob))
						spilled_organs += organ
				for(var/obj/item/organ/spilled as anything in spilled_organs)
					spilled.Remove(owner)
					spilled.forceMove(T)
					spilled.add_mob_blood(owner)
					organ_spilled = TRUE
				if(cavity_item)
					cavity_item.forceMove(T)
					. += cavity_item
					cavity_item = null
					organ_spilled = TRUE
				if(organ_spilled)
					shake_camera(owner, 2, 2)
					owner.next_attack_msg += " <span class='crit'><b>Critical hit!</b> [owner] spills [owner.p_their()] organs!</span>"
					if(!foundy)
						add_wound(/datum/wound/artery)
						owner.emote("paincrit", TRUE)
						owner.Slowdown(20)
						shake_camera(owner, 2, 2)
				if(bclass == BCLASS_CHOP || bclass == BCLASS_STAB)
					return TRUE
				return FALSE
		if(prob(used))
			if(!foundy)
				if(prob(3))
					playsound(owner, 'sound/combat/tf2crit.ogg', 100, FALSE)
				else
					playsound(owner, pick('sound/combat/crit.ogg'), 100, FALSE)
				add_wound(/datum/wound/artery)
				owner.emote("paincrit", TRUE)
				owner.next_attack_msg += " <span class='crit'><b>Critical hit!</b> Blood sprays from [owner]'s [src.name]!</span>"
				owner.Slowdown(20)
				shake_camera(owner, 2, 2)
				if(bclass == BCLASS_CHOP || bclass == BCLASS_STAB)
					if(zone_precise == BODY_ZONE_CHEST)
						owner.vomit(blood = TRUE)
						if(!resistance)
							owner.death()
					return TRUE
			else
				if(bclass == BCLASS_CHOP || bclass == BCLASS_STAB)
					if(zone_precise == BODY_ZONE_CHEST)
						owner.vomit(blood = TRUE)
						owner.next_attack_msg += " <span class='crit'><b>Critical hit!</b> Blood sprays from [owner]'s [src.name]!</span>"
						if(!resistance)
							owner.death()
						return TRUE

/obj/item/bodypart/head/try_crit(bclass,dam,mob/living/user,zone_precise)
	var/static/list/eyestab_zones = list(BODY_ZONE_PRECISE_R_EYE, BODY_ZONE_PRECISE_L_EYE)
	var/static/list/tonguestab_zones = list(BODY_ZONE_PRECISE_MOUTH)
	var/static/list/do_nothing_zones = list(BODY_ZONE_PRECISE_NOSE)
	var/resistance = HAS_TRAIT(owner, RTRAIT_CRITICAL_RESISTANCE)
	if(user && dam)
		if(user.goodluck(2))
			dam += 10
	if(bclass == BCLASS_TWIST)
		if(zone_precise == BODY_ZONE_HEAD)
			if(brute_dam < max_damage)
				return FALSE
			if(has_wound(/datum/wound/fracture/neck))
				return FALSE
			var/used = round((brute_dam / max_damage)*20 + (dam / 3), 1)
			if(owner == user)
				used = 0
			if(prob(used))
				playsound(owner, "fracturedry", 100, FALSE)
				owner.next_attack_msg += " <span class='crit'><b>Critical hit!</b> The neck is broken!</span>"
				add_wound(/datum/wound/fracture/neck)
				shake_camera(owner, 2, 2)
				if(!resistance)
					owner.death()
		return FALSE
	if(bclass == BCLASS_BLUNT || bclass == BCLASS_PICK || bclass == BCLASS_SMASH || bclass == BCLASS_CHOP)
		if(dam < 5)
			return FALSE
		var/used = round((brute_dam / max_damage)*20 + (dam / 3), 1)
		if(HAS_TRAIT_FROM(src, TRAIT_PARALYSIS, CRIT_TRAIT))
			used += 20
		if(user)
			if(istype(user.rmb_intent, /datum/rmb_intent/strong))
				used += 10
		if(!owner.stat)
			var/from_behind = FALSE
			if(owner.dir == turn(get_dir(owner,user), 180))
				from_behind = TRUE
				used += 50
			if(can_bloody_wound())
				if(prob(used) && bclass != BCLASS_CHOP)
					owner.next_attack_msg += " <span class='crit'><b>Critical hit!</b> [owner] is knocked out[from_behind ? " FROM BEHIND" : ""]!</span>"
					owner.flash_fullscreen("whiteflash3")
					owner.Unconscious(5 SECONDS + (from_behind * 10 SECONDS))
					if(owner.client)
						winset(owner.client, "outputwindow.output", "max-lines=1")
						winset(owner.client, "outputwindow.output", "max-lines=100")
				return FALSE
		var/foundf = has_wound(/datum/wound/fracture)
		if(!foundf)
			if(prob(used) && (brute_dam / max_damage >= 0.9))
				var/list/phrases = list("The skull shatters in a gruesome way!", "The head is smashed!", "The skull is broken!", "The skull caves in!")
				owner.next_attack_msg += " <span class='crit'><b>Critical hit!</b> [pick(phrases)]</span>"
				add_wound(/datum/wound/fracture)
				if(prob(3))
					playsound(owner, 'sound/combat/tf2crit.ogg', 100, FALSE)
				else
					playsound(owner, "headcrush", 100, FALSE)
				update_disabled()
				shake_camera(owner, 2, 2)
				if(!resistance)
					owner.death()
					brainkill = TRUE
				if(bclass == BCLASS_CHOP)
					return TRUE
				return FALSE
	if(bclass == BCLASS_CUT || bclass == BCLASS_CHOP || bclass == BCLASS_STAB || bclass == BCLASS_BITE)
		var/used = round((brute_dam / max_damage)*20 + (dam / 3), 1)
		if(!can_bloody_wound())
			return FALSE
		if(zone_precise == BODY_ZONE_PRECISE_NECK)
			if(has_wound(/datum/wound/artery/throat))
				return FALSE
			if(user)
				if(bclass == BCLASS_CHOP)
					if(istype(user.rmb_intent, /datum/rmb_intent/strong))
						used += 10
				else
					if(istype(user.rmb_intent, /datum/rmb_intent/aimed))
						used += 10
			if(owner == user)
				used = 80
			if(prob(used))
				playsound(owner, pick('sound/combat/crit.ogg'), 100, FALSE)
				if(owner.stat != DEAD)
					playsound(owner, pick('sound/vo/throat.ogg','sound/vo/throat2.ogg','sound/vo/throat3.ogg'), 100, FALSE)
				owner.next_attack_msg += " <span class='crit'><b>Critical hit!</b> Blood sprays from [owner]'s throat!</span>"
				add_wound(/datum/wound/artery/throat)
				owner.Slowdown(20)
				shake_camera(owner, 2, 2)
				if(bclass == BCLASS_STAB)
					return TRUE
		else
			if(user)
				if(bclass == BCLASS_CHOP)
					if(istype(user.rmb_intent, /datum/rmb_intent/strong))
						used += 10
				else
					if(istype(user.rmb_intent, /datum/rmb_intent/aimed))
						used += 10
			if(prob(used))
				if(has_wound(/datum/wound/artery))
					if(bclass == BCLASS_STAB)
						if(resistance)
							return TRUE
						if(zone_precise in eyestab_zones)
							var/obj/item/organ/eyes/my_eyes = owner.getorganslot(ORGAN_SLOT_EYES)
							if(my_eyes)
								playsound(owner, pick('sound/combat/crit.ogg'), 100, FALSE)
								owner.Stun(5)
								owner.blind_eyes(5)
								if(zone_precise == BODY_ZONE_PRECISE_R_EYE)
									my_eyes.right_poked = TRUE
									if(!my_eyes.left_poked)
										owner.next_attack_msg += " <span class='crit'><b>Critical hit!</b> The right eye is poked out!</span>"
								else
									my_eyes.left_poked = TRUE
									if(!my_eyes.right_poked)
										owner.next_attack_msg += " <span class='crit'><b>Critical hit!</b> The left eye is poked out!</span>"
								if(my_eyes.right_poked && my_eyes.left_poked)
									owner.next_attack_msg += " <span class='crit'><b>Critical hit!</b> The eyes are gored!</span>"
									my_eyes.forceMove(get_turf(owner))
									my_eyes.Remove(owner)
							else
								if(!brainkill)
									playsound(owner, pick('sound/combat/crit.ogg'), 100, FALSE)
								owner.death()
								brainkill = TRUE
							owner.update_fov_angles()
						else if(zone_precise in tonguestab_zones)
							var/obj/item/organ/tongue/tongue_up_my_asshole = owner.getorganslot(ORGAN_SLOT_TONGUE)
							if(tongue_up_my_asshole)
								playsound(owner, pick('sound/combat/crit.ogg'), 100, FALSE)
								owner.next_attack_msg += " <span class='crit'><b>Critical hit!</b> The tongue flies off in an arc!</span>"
								owner.Stun(10)
								tongue_up_my_asshole.forceMove(get_turf(owner))
								tongue_up_my_asshole.Remove(owner)
						else if(!(zone_precise in do_nothing_zones))
							if(!brainkill)
								playsound(owner, pick('sound/combat/crit.ogg'), 100, FALSE)
							owner.death()
							brainkill = TRUE
						return TRUE
					return FALSE
				playsound(owner, pick('sound/combat/crit.ogg'), 100, FALSE)
				owner.emote("paincrit", TRUE)
				add_wound(/datum/wound/artery)
				owner.Slowdown(20)
				shake_camera(owner, 2, 2)
				if(bclass == BCLASS_STAB)
					if(resistance)
						return TRUE
					if(zone_precise in eyestab_zones)
						var/obj/item/organ/eyes/my_eyes = owner.getorganslot(ORGAN_SLOT_EYES)
						if(my_eyes)
							playsound(owner, pick('sound/combat/crit.ogg'), 100, FALSE)
							owner.Stun(5)
							owner.blind_eyes(5)
							if(zone_precise == BODY_ZONE_PRECISE_R_EYE)
								my_eyes.right_poked = TRUE
								if(!my_eyes.left_poked)
									owner.next_attack_msg += " <span class='crit'><b>Critical hit!</b> The right eye is poked out!</span>"
							else
								my_eyes.left_poked = TRUE
								if(!my_eyes.right_poked)
									owner.next_attack_msg += " <span class='crit'><b>Critical hit!</b> The left eye is poked out!</span>"
							if(my_eyes.right_poked && my_eyes.left_poked)
								owner.next_attack_msg += " <span class='crit'><b>Critical hit!</b> The eyes are gored!</span>"
								my_eyes.forceMove(get_turf(owner))
								my_eyes.Remove(owner)
							owner.update_fov_angles()
						else
							if(!brainkill)
								playsound(owner, pick('sound/combat/crit.ogg'), 100, FALSE)
							owner.death()
							brainkill = TRUE
					else if(zone_precise in tonguestab_zones)
						var/obj/item/organ/tongue/tongue_up_my_asshole = owner.getorganslot(ORGAN_SLOT_TONGUE)
						if(tongue_up_my_asshole)
							playsound(owner, pick('sound/combat/crit.ogg'), 100, FALSE)
							owner.next_attack_msg += " <span class='crit'><b>Critical hit!</b> The tongue flies off in an arc!</span>"
							owner.Stun(10)
							tongue_up_my_asshole.forceMove(get_turf(owner))
							tongue_up_my_asshole.Remove(owner)
					else if(!(zone_precise in do_nothing_zones))
						owner.next_attack_msg += " <span class='crit'><b>Critical hit!</b> Blood sprays from [owner]'s [src.name]!</span>"
						if(!brainkill)
							playsound(owner, pick('sound/combat/crit.ogg'), 100, FALSE)
						owner.death()
						brainkill = TRUE
					else
						owner.next_attack_msg += " <span class='crit'><b>Critical hit!</b> Blood sprays from [owner]'s [src.name]!</span>"
					return TRUE
				else
					owner.next_attack_msg += " <span class='crit'><b>Critical hit!</b> Blood sprays from [owner]'s [src.name]!</span>"
	if(bclass == BCLASS_PUNCH)
		if(!can_bloody_wound())
			return FALSE
		if(dam < 5)
			return FALSE
		var/used = round((brute_dam / max_damage)*20 + (dam / 3), 1)
		if(user)
			if(istype(user.rmb_intent, /datum/rmb_intent/strong))
				used += 10
		if(!owner.stat)
			var/from_behind = FALSE
			if(owner.dir == turn(get_dir(owner,user), 180))
				from_behind = TRUE
				used += 30
			if(prob(used))
				owner.next_attack_msg += " <span class='crit'><b>Critical hit!</b> [owner] is knocked out[from_behind ? " FROM BEHIND" : ""]!</span>"
				owner.flash_fullscreen("whiteflash3")
				owner.Unconscious(5 SECONDS + (from_behind * 10 SECONDS))
			return FALSE

/// Called after a bodypart is attacked so that wounds and critical effects can be applied
/obj/item/bodypart/proc/bodypart_attacked_by(bclass, dam, mob/living/user, zone_precise)
	if(!bclass || !dam || !owner || (owner.status_flags & GODMODE))
		return
	if(ishuman(owner))
		var/mob/living/carbon/human/H = owner
		if(H.checkcritarmor(zone_precise, bclass))
			return
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
	testing("WOUNDADD DAM [dam]")
	switch(bclass) //do stuff but only when we are a blade that adds wounds
		if(BCLASS_SMASH, BCLASS_BLUNT)
			switch(dam)
				if(1 to 10)
					return add_wound(/datum/wound/bruise/small)
				if(11 to 20)
					return add_wound(/datum/wound/bruise)
				if(21 to INFINITY)
					return add_wound(/datum/wound/bruise/large)
		if(BCLASS_CUT, BCLASS_CHOP)
			switch(dam)
				if(1 to 10)
					return add_wound(/datum/wound/slash/small)
				if(11 to 20)
					return add_wound(/datum/wound/slash)
				if(21 to INFINITY)
					return add_wound(/datum/wound/slash/large)
		if(BCLASS_STAB, BCLASS_PICK)
			switch(dam)
				if(1 to 10)
					return add_wound(/datum/wound/puncture/small)
				if(11 to 20)
					return add_wound(/datum/wound/puncture)
				if(21 to INFINITY)
					return add_wound(/datum/wound/puncture/large)
		if(BCLASS_BITE)
			if(dam > 8)
				return add_wound(/datum/wound/bite/bleeding)
			else
				return add_wound(/datum/wound/bite)

/obj/item/bodypart/proc/get_bleed_rate()
	var/bleed_rate = 0
	if(bandage)
		return 0
	for(var/datum/wound/wound as anything in wounds)
		bleed_rate += wound.bleed_rate
	//I hate that I have to do this shit
	listclearnulls(embedded_objects)
	for(var/obj/item/embedded as anything in embedded_objects)
		if(!embedded.embedding.embedded_bloodloss)
			continue
		bleed_rate += embedded.embedding.embedded_bloodloss
	for(var/obj/item/grabbing/grab in grabbedby)
		bleed_rate *= grab.bleed_suppressing
	bleed_rate = max(round(bleed_rate, 0.1), 0)
	return bleed_rate

/obj/item/bodypart/proc/heal_wounds(heal_amount, sleep_heal = FALSE) //wounds that are large always have large hp, but they can be sewn to bleed less/be healed
	if(!length(wounds))
		return FALSE
	var/healed_any = FALSE
	for(var/datum/wound/wound as anything in wounds)
		if((heal_amount <= 0) || (sleep_heal && !wound.sleep_healing))
			continue
		var/amount_healed = wound.heal_wound(heal_amount)
		heal_amount -= amount_healed
		healed_any = TRUE
	return healed_any

/obj/item/bodypart/proc/has_wound(path, specific = FALSE)
	if(!path)
		return
	for(var/datum/wound/wound as anything in wounds)
		if((specific && wound.type != path) || !istype(wound, path))
			continue
		return wound

/obj/item/bodypart/proc/try_bandage(obj/item/new_bandage)
	if(!new_bandage)
		return FALSE
	bandage = new_bandage
	new_bandage.forceMove(src)
	return TRUE

/obj/item/bodypart/proc/try_bandage_expire()
	if(!bandage)
		return FALSE
	var/bandage_effectiveness = 0.5
	if(istype(bandage, /obj/item/natural/cloth))
		var/obj/item/natural/cloth/cloth = bandage
		bandage_effectiveness = cloth.bandage_effectiveness
	var/highest_bleed_rate = 0
	for(var/datum/wound/wound as anything in wounds)
		if(wound.bleed_rate < highest_bleed_rate)
			continue
		highest_bleed_rate = wound.bleed_rate
	//I hate that I have to do this shit
	listclearnulls(embedded_objects)
	for(var/obj/item/embedded as anything in embedded_objects)
		if(!embedded.embedding.embedded_bloodloss)
			continue
		if(embedded.embedding.embedded_bloodloss < highest_bleed_rate)
			continue
		highest_bleed_rate = embedded.embedding.embedded_bloodloss
	highest_bleed_rate = round(highest_bleed_rate, 0.1)
	if(bandage_effectiveness < highest_bleed_rate)
		return bandage_expire()
	return FALSE

/obj/item/bodypart/proc/bandage_expire()
	testing("expire bandage")
	if(!owner)
		return FALSE
	if(!bandage)
		return FALSE
	if(owner.stat != DEAD)
		to_chat(owner, "<span class='warning'>Blood soaks through the bandage on my [name].</span>")
	return bandage.add_mob_blood(owner)

/obj/item/bodypart/proc/get_sewable_wounds()
	var/list/woundies = list()
	for(var/datum/wound/wound as anything in wounds)
		if(!wound.can_sew)
			continue
		woundies += wound
	return woundies
