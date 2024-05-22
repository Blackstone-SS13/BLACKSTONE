/// List of "primordial" wounds so that we don't have to create new wound datums when running checks to see if a wound should be applied
GLOBAL_LIST_INIT(primordial_wounds, init_primordial_wounds())

/proc/init_primordial_wounds()
	var/list/primordial_wounds = list()
	for(var/wound_type in typesof(/datum/wound))
		primordial_wounds[wound_type] = new wound_type()
	return primordial_wounds

/datum/wound
	/// Name of the wound, visible to players when inspecting a limb and such
	var/name = "wound"
	/// Bodypart that owns this wound, in case it is not a simple one
	var/obj/item/bodypart/bodypart_owner
	/// Mob that owns this wound
	var/mob/living/owner
	/// How many "health points" this wound has, AKA how hard it is to heal
	var/whp = 60
	/// How many "health points" this wound gets after being sewn
	var/sewn_whp = 30
	/// How much this wound bleeds
	var/bleed_rate
	/// Bleed rate when sewn
	var/sewn_bleed_rate = 0.01
	/// Some wounds clot over time, reducing bleeding - This is the rate at which they do so
	var/clotting_rate = 0.01
	/// Clotting rate when sewn
	var/sewn_clotting_rate = 0.02
	/// Clotting will not go below this amount of bleed_rate
	var/clotting_threshold
	/// Clotting will not go below this amount of bleed_rate when sewn
	var/sewn_clotting_threshold = 0
	/// How much pain this wound causes while on a mob
	var/woundpain = 0
	/// Pain this wound causes after being sewn
	var/sewn_woundpain = 0
	/// Sewing progress, because sewing wounds is snowflakey
	var/sew_progress = 0
	/// When sew_progress reaches this, the wound is sewn
	var/sew_threshold = 100
	/// Overlay to use when this wound is applied to a carbon mob
	var/mob_overlay = "w1"
	/// Overlay to use when this wound is sewn, and is on a carbon mob
	var/sewn_overlay = ""
	/// If TRUE, this wound can be sewn
	var/can_sew = TRUE
	/// If TRUE, this disables limbs
	var/disabling = FALSE
	/// Amount we heal passively while sleeping
	var/sleep_healing = 1
	/// Amount we heal passively, always
	var/passive_healing = 0
	/// Embed chance if this wound allows embedding
	var/embed_chance = 0

/datum/wound/Destroy(force)
	. = ..()
	if(bodypart_owner)
		remove_from_bodypart()
	else if(owner)
		remove_from_mob()
	bodypart_owner = null
	owner = null

/// Description of this wound returned to the player when a bodypart is examined and such
/datum/wound/proc/get_visible_name()
	var/visible_name = name
	if(!isnull(clotting_threshold) && clotting_rate && (bleed_rate <= clotting_threshold))
		visible_name += " <span class='danger'>(clotted)</span>"
	if(sew_progress >= sew_threshold)
		visible_name += " <span class='green'>(sewn)</span>"
	return visible_name

/// Returns whether or not this wound can be applied to a given bodypart
/datum/wound/proc/can_apply_to_bodypart(obj/item/bodypart/affected)
	if(bodypart_owner || owner || QDELETED(affected) || QDELETED(affected.owner))
		return FALSE
	if(!affected.can_bloody_wound() && !isnull(bleed_rate))
		return FALSE
	for(var/datum/wound/other_wound as anything in affected.wounds)
		if(!can_stack_with(other_wound))
			return FALSE
	return TRUE

/// Returns whether or not this wound can be applied while this other wound is present
/datum/wound/proc/can_stack_with(datum/wound/other)
	return TRUE

/// Adds this wound to a given bodypart
/datum/wound/proc/apply_to_bodypart(obj/item/bodypart/affected)
	if(QDELETED(affected))
		return FALSE
	if(bodypart_owner)
		remove_from_bodypart()
	else if(owner)
		remove_from_mob()
	LAZYADD(affected.wounds, src)
	bodypart_owner = affected
	owner = bodypart_owner.owner
	on_bodypart_gain(affected)
	owner?.update_damage_overlays()
	return TRUE

/// Effects when a wound is gained on a bodypart
/datum/wound/proc/on_bodypart_gain(obj/item/bodypart/affected)
	if(bleed_rate && affected.bandage)
		affected.try_bandage_expire()

/// Removes this wound from a given bodypart
/datum/wound/proc/remove_from_bodypart()
	if(!bodypart_owner)
		return FALSE
	var/mob/living/was_owner = owner
	on_bodypart_loss(bodypart_owner)
	LAZYREMOVE(bodypart_owner.wounds, src)
	bodypart_owner = null
	owner = null
	was_owner?.update_damage_overlays()
	return TRUE

/// Effects when a wound is lost on a bodypart
/datum/wound/proc/on_bodypart_loss(obj/item/bodypart/affected)
	return

/// Returns whether or not this wound can be applied to a given mob
/datum/wound/proc/can_apply_to_mob(mob/living/affected)
	if(bodypart_owner || owner || QDELETED(affected) || !HAS_TRAIT(affected, TRAIT_SIMPLE_WOUNDS))
		return FALSE
	return TRUE

/// Adds this wound to a given mob, simpler than adding to a bodypart - No extra effects
/datum/wound/proc/apply_to_mob(mob/living/affected)
	if(QDELETED(affected) || !HAS_TRAIT(affected, TRAIT_SIMPLE_WOUNDS))
		return
	if(bodypart_owner)
		remove_from_bodypart()
	else if(owner)
		remove_from_mob()
	LAZYADD(affected.simple_wounds, src)
	owner = affected
	return TRUE

/// Removes this wound from a given, simpler than adding to a bodypart - No extra effects
/datum/wound/proc/remove_from_mob()
	if(!owner)
		return FALSE
	LAZYREMOVE(owner.simple_wounds, src)
	owner = null
	return TRUE

/// Called on handle_wounds(), on the life() proc
/datum/wound/proc/on_life()
	if(!isnull(clotting_threshold) && clotting_rate && (bleed_rate > clotting_threshold))
		bleed_rate = max(clotting_threshold, bleed_rate - clotting_rate)
	if(passive_healing)
		heal_wound(1)

/// Heals this wound by the given amount, and deletes it if it's healed completely
/datum/wound/proc/heal_wound(heal_amount)
	// Wound cannot be healed normally, whp is null
	if(isnull(whp))
		return 0
	var/amount_healed = min(whp, heal_amount)
	whp -= amount_healed
	if(whp <= 0)
		if(bodypart_owner)
			remove_from_bodypart(src)
		else if(owner)
			remove_from_mob(src)
		else
			qdel(src)
	return amount_healed

/// Sews the wound up, changing its properties to the sewn ones
/datum/wound/proc/sew_wound()
	if(!can_sew)
		return FALSE
	mob_overlay = sewn_overlay
	bleed_rate = sewn_bleed_rate
	clotting_rate = sewn_clotting_rate
	clotting_threshold = sewn_clotting_threshold
	woundpain = sewn_woundpain
	whp = min(whp, sewn_whp)
	can_sew = FALSE
	sleep_healing = max(sleep_healing, 1)
	passive_healing = max(passive_healing, 1)
	return TRUE

/proc/should_embed_weapon(datum/wound/wound_or_boolean)
	if(!istype(wound_or_boolean))
		return wound_or_boolean
	return prob(wound_or_boolean.embed_chance)
