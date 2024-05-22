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

/datum/wound/fracture/on_bodypart_gain(obj/item/bodypart/affected)
	. = ..()
	affected.update_disabled()

/datum/wound/fracture/on_bodypart_loss(obj/item/bodypart/affected)
	. = ..()
	affected.update_disabled()

/datum/wound/fracture/chest
	name = "rib fracture"
	whp = 50

/datum/wound/fracture/groin
	name = "pelvic fracture"
	whp = 50

/datum/wound/fracture/groin/New()
	. = ..()
	if(prob(1))
		name = "broken buck"
	
/datum/wound/fracture/groin/on_bodypart_gain(obj/item/bodypart/affected)
	. = ..()
	ADD_TRAIT(owner, TRAIT_PARALYSIS_R_LEG, "[type]")
	ADD_TRAIT(owner, TRAIT_PARALYSIS_L_LEG, "[type]")
	affected.owner?.update_disabled_bodyparts()

/datum/wound/fracture/groin/on_bodypart_loss(obj/item/bodypart/affected)
	. = ..()
	REMOVE_TRAIT(owner, TRAIT_PARALYSIS_R_LEG, "[type]")
	REMOVE_TRAIT(owner, TRAIT_PARALYSIS_L_LEG, "[type]")
	affected.owner?.update_disabled_bodyparts()

/datum/wound/fracture/neck
	name = "cervical fracture"
	whp = 100
	sleep_healing = 0

/datum/wound/fracture/neck/on_bodypart_gain(obj/item/bodypart/affected)
	. = ..()
	ADD_TRAIT(owner, TRAIT_PARALYSIS, "[type]")
	affected.owner.update_disabled_bodyparts()

/datum/wound/fracture/neck/on_bodypart_loss(obj/item/bodypart/affected)
	. = ..()
	REMOVE_TRAIT(owner, TRAIT_PARALYSIS, "[type]")
	affected.owner.update_disabled_bodyparts()

/datum/wound/fracture/head
	name = "cranial fracture"
	whp = 150
	sleep_healing = 0

/datum/wound/fracture/head/New()
	. = ..()
	if(prob(1))
		name = "dentbrain"

/datum/wound/fracture/head/on_bodypart_gain(obj/item/bodypart/affected)
	. = ..()
	ADD_TRAIT(owner, TRAIT_PARALYSIS, "[type]")
	affected.owner.update_disabled_bodyparts()

/datum/wound/fracture/head/on_bodypart_loss(obj/item/bodypart/affected)
	. = ..()
	REMOVE_TRAIT(owner, TRAIT_PARALYSIS, "[type]")
	affected.owner.update_disabled_bodyparts()

/datum/wound/fracture/head/on_life()
	. = ..()
	owner.slurring = max(owner.slurring, 5)

/datum/wound/fracture/mouth
	name = "mandibular fracture"
	whp = 100
	sleep_healing = 0

/datum/wound/fracture/mouth/on_bodypart_gain(obj/item/bodypart/affected)
	. = ..()
	ADD_TRAIT(owner, TRAIT_GARGLE_SPEECH, "[type]")

/datum/wound/fracture/mouth/on_bodypart_loss(obj/item/bodypart/affected)
	. = ..()
	REMOVE_TRAIT(owner, TRAIT_GARGLE_SPEECH, "[type]")
