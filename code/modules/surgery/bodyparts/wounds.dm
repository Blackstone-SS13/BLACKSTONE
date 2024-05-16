/obj/item/bodypart
	var/list/wounds = list()
	var/obj/item/bandage

/obj/item/bodypart/proc/can_bloody_wound()
	if(iscarbon(src))
		var/mob/living/carbon/C = src
		if(C.dna && C.dna.species)
			if(NOBLOOD in C.dna.species.species_traits)
				return FALSE
	if(!is_organic_limb())
		return FALSE
	if(skeletonized)
		return FALSE
	return TRUE

/obj/item/bodypart/proc/add_wound(datum/wound/W, skipcheck = TRUE)
	if(!W || !owner || (owner.status_flags & GODMODE))
		return
/*	for(var/datum/wound/D in wounds)
		if(istype(D,W) || D.smaller_wound == W)
			if(prob(15) && D.bigger_wound) //small chance to 'upgrade' the existing wound instead of making a new one
				W = D.bigger_wound
				wounds -= D
				qdel(D)
				skipcheck = TRUE
				owner.next_attack_msg += " <span class='rose'>The wound gushes with blood!</span>"
				break*/
//	if(!wounds.len || (wounds.len < 5) || skipcheck)
	var/datum/wound/NW = new W(src)
	if(!can_bloody_wound())
		if(NW.bleed_rate)
			qdel(NW)
			return
	wounds += NW
	if(bandage)//a fresh wound ruins our current bandage
		bandage_expire()
	owner.update_damage_overlays()

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

/obj/item/bodypart/proc/try_crit(bclass,dam,mob/living/user,zone_precise)
	if(!dam)
		return
	if(user && dam)
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
				for(var/datum/wound/fracture/W in wounds)
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
		var/foundf 
		for(var/datum/wound/fracture/W in wounds)
			foundf= TRUE
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
			for(var/datum/wound/artery/A in wounds)
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
		if(dam)
			if(zone_precise == BODY_ZONE_PRECISE_GROIN)
				owner.emote("groin")
				owner.Stun(10)
		return FALSE
	if(bclass == BCLASS_BLUNT || bclass == BCLASS_SMASH || bclass == BCLASS_CHOP)
		var/used = round((brute_dam / max_damage)*20 + (dam / 3), 1)
		if(zone_precise == BODY_ZONE_PRECISE_GROIN)
			if(dam)
				owner.emote("groin")
				owner.Stun(5) //implement once targetting groin is harder
				return FALSE
		if(HAS_TRAIT_FROM(src, TRAIT_PARALYSIS, CRIT_TRAIT))
			used += 20
		if(user)
			if(istype(user.rmb_intent, /datum/rmb_intent/strong))
				used += 10
		var/foundf
		for(var/datum/wound/fracture/W in wounds)
			foundf= TRUE
		if(!foundf)
			if(prob(used) && zone_precise != BODY_ZONE_PRECISE_STOMACH)
				var/list/phrases = list("The ribs shatter in a splendid way!", "The ribs are smashed!", "The chest is mauled!", "The chest caves in!")
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
		var/foundy
		for(var/datum/wound/artery/A in wounds)
			foundy= TRUE
		if(zone_precise == BODY_ZONE_PRECISE_STOMACH)
			if (prob(used+10))
				if(!can_bloody_wound())
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
				if(owner.mind && owner.mind.has_antag_datum(/datum/antagonist/zombie))
					return FALSE
				if(bclass == BCLASS_CHOP || bclass == BCLASS_STAB)
					if(zone_precise == BODY_ZONE_CHEST)
						owner.vomit(blood = TRUE)
						if(!resistance)
							owner.death()
					return TRUE
			else
				if(owner.mind && owner.mind.has_antag_datum(/datum/antagonist/zombie))
					return FALSE
				if(bclass == BCLASS_CHOP || bclass == BCLASS_STAB)
					if(zone_precise == BODY_ZONE_CHEST)
						owner.vomit(blood = TRUE)
						owner.next_attack_msg += " <span class='crit'><b>Critical hit!</b> Blood sprays from [owner]'s [src.name]!</span>"
						if(!resistance)
							owner.death()
						return TRUE

/obj/item/bodypart/head/try_crit(bclass,dam,mob/living/user,zone_precise)
	var/resistance = HAS_TRAIT(owner, RTRAIT_CRITICAL_RESISTANCE)
	if(user && dam)
		if(user.goodluck(2))
			dam += 10
	if(bclass == BCLASS_TWIST)
		if(zone_precise == "head")
			if(brute_dam < max_damage)
				return FALSE
			for(var/datum/wound/necksnap/S in wounds)
				return FALSE
			var/used = round((brute_dam / max_damage)*20 + (dam / 3), 1)
			if(owner == user)
				used = 0
			if(prob(used))
				playsound(owner, "fracturedry", 100, FALSE)
				owner.next_attack_msg += " <span class='crit'><b>Critical hit!</b> The neck is broken!</span>"
				add_wound(/datum/wound/necksnap)
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
		var/foundf 
		for(var/datum/wound/fracture/W in wounds)
			foundf= TRUE
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
			for(var/datum/wound/artery/throat/A in wounds)
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
				for(var/datum/wound/artery/A in wounds)
					if(bclass == BCLASS_STAB)
						if(!resistance)
							owner.death()
						return TRUE
					return FALSE
				playsound(owner, pick('sound/combat/crit.ogg'), 100, FALSE)
				owner.emote("paincrit", TRUE)
				owner.next_attack_msg += " <span class='crit'><b>Critical hit!</b> Blood sprays from [owner]'s [src.name]!</span>"
				add_wound(/datum/wound/artery)
				owner.Slowdown(20)
				shake_camera(owner, 2, 2)
				if(bclass == BCLASS_STAB)
					if(!resistance)
						owner.death()
						brainkill = TRUE
					return TRUE
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

/obj/item/bodypart/attacked_by(bclass, dam, mob/living/user, zone_precise)
	if(!owner || (owner.status_flags & GODMODE))
		return
	if(!bclass)
		return
	if(!dam)
		return
	if(ishuman(owner))
		var/mob/living/carbon/human/H = owner
		if(H.checkcritarmor(zone_precise, bclass))
			return FALSE
	//try limbsmash here, return
	//try dismember here, return
	if(user)
		if(user.goodluck(2))
			dam += 10
		if(!istype(user.rmb_intent, /datum/rmb_intent/weak))
			if(try_crit(bclass, dam, user, zone_precise))
				return TRUE
	else
		if(try_crit(bclass, dam, user, zone_precise))
			return TRUE
	testing("WOUNDADD DAM [dam]")
	switch(bclass) //do stuff but only when we are a blade that adds wounds
		if(BCLASS_SMASH, BCLASS_BLUNT)
			switch(dam)
				if(1 to 10)
					add_wound(/datum/wound/bruise/small, skipcheck = FALSE)
				if(11 to 20)
					add_wound(/datum/wound/bruise, skipcheck = FALSE)
				if(21 to INFINITY)
					add_wound(/datum/wound/bruise/large, skipcheck = FALSE)
		if(BCLASS_CUT, BCLASS_CHOP)
			switch(dam)
				if(1 to 10)
					add_wound(/datum/wound/cut/small, skipcheck = FALSE)
				if(11 to 20)
					add_wound(/datum/wound/cut, skipcheck = FALSE)
				if(21 to INFINITY)
					add_wound(/datum/wound/cut/large, skipcheck = FALSE)
		if(BCLASS_STAB, BCLASS_PICK)
			switch(dam)
				if(1 to 10)
					add_wound(/datum/wound/stab/small, skipcheck = FALSE)
				if(11 to 20)
					add_wound(/datum/wound/stab, skipcheck = FALSE)
				if(21 to INFINITY)
					add_wound(/datum/wound/stab/large, skipcheck = FALSE)
		if(BCLASS_BITE)
			if(dam > 8)
				add_wound(/datum/wound/bite/bleeding, skipcheck = FALSE)
			else
				add_wound(/datum/wound/bite, skipcheck = FALSE)

/obj/item/bodypart/proc/get_bleedrate()
	var/BR = 0
	var/highest_BR = 0
	for(var/datum/wound/W in wounds)
		BR += W.bleed_rate
		if(W.bleed_rate > highest_BR)
			highest_BR = W.bleed_rate
	if(bandage)
		if(!HAS_BLOOD_DNA(bandage))
			if(highest_BR > 0.99)
				bandage_expire()
			else
				BR = 0
	for(var/obj/item/grabbing/G in grabbedby)
		if(BR > 0)
			BR = max(BR - G.bleed_suppressing,0.01)
	return BR

/obj/item/bodypart/proc/heal_wounds(amt, sleep_heal = FALSE) //wounds that are large always have large hp, but they can be sewn to bleed less/be healed
	if(!wounds.len)
		return TRUE
	for(var/datum/wound/wound in wounds)
		if(sleep_heal && !wound.sleep_heal)
			continue
		wound.whp = wound.whp - amt
		if(wound.whp <= 0)
			wounds -= wound
			qdel(wound)
	return TRUE

/obj/item/bodypart/proc/has_wound(path)
	if(!path)
		return
	for(var/datum/wound/W in wounds)
		if(istype(W,path))
			return W

/obj/item/bodypart/proc/try_bandage(obj/item/I)
	if(!I)
		return
	bandage = I
	I.forceMove(src)

/obj/item/bodypart/proc/bandage_expire()
	testing("expire bandage")
	if(!owner)
		return
	if(!bandage)
		return
	if(owner.stat != DEAD)
		to_chat(owner, "<span class='warning'>Blood soaks through the bandage on my [name].</span>")
	bandage.add_mob_blood(owner)
//	owner.update_damage_overlays()

/obj/item/bodypart/proc/get_sewable()
	var/list/woundies = list()
	for(var/X in wounds)
		var/datum/wound/W = X
		if(W.can_sew)
			woundies += W
	return woundies
