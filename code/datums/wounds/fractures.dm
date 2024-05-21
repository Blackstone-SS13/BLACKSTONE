/datum/wound/fracture
	name = "fracture"
	bleed_rate = 0
	whp = 40
	woundpain = 100
	mob_overlay = "frac"
	can_sew = FALSE
	disabling = TRUE

/datum/wound/fracture/can_stack_with(datum/wound/other)
	if(istype(other, /datum/wound/fracture) && (type == other.type))
		return FALSE
	return TRUE
/datum/wound/fracture/groin
	name = "pelvic fracture"

/datum/wound/fracture/groin/on_bodypart_gain(obj/item/bodypart/affected)
	. = ..()
	ADD_TRAIT(owner, TRAIT_PARALYSIS_R_LEG, "[type]")
	ADD_TRAIT(owner, TRAIT_PARALYSIS_L_LEG, "[type]")

/datum/wound/fracture/groin/on_bodypart_loss(obj/item/bodypart/old_bodypart)
	. = ..()
	REMOVE_TRAIT(owner, TRAIT_PARALYSIS_R_LEG, "[type]")
	REMOVE_TRAIT(owner, TRAIT_PARALYSIS_L_LEG, "[type]")
	
/datum/wound/fracture/necksnap
	name = "cervical fracture"
	whp = 100
	sleep_heal = FALSE

/datum/wound/fracture/necksnap/on_bodypart_gain(obj/item/bodypart/affected)
	. = ..()
	ADD_TRAIT(owner, TRAIT_PARALYSIS, "[type]")

/datum/wound/fracture/necksnap/on_bodypart_loss(obj/item/bodypart/old_bodypart)
	. = ..()
	REMOVE_TRAIT(owner, TRAIT_PARALYSIS, "[type]")
