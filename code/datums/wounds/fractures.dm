/datum/wound/fracture
	name = "fracture"
	check_name = "<span class='bone'>FRACTURE</span>"
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

/datum/wound/fracture/head
	name = "cranial fracture"
	check_name = "<span class='bone'><B>SKULLCRACK</B></span>"
	whp = 150
	sleep_healing = 0
	/// Most head fractures are serious enough to cause paralysis
	var/paralysis = TRUE
	/// Some head fractures are so serious they cause instant death
	var/mortal = FALSE
	/// Funny easter egg
	var/dents_brain = TRUE

/datum/wound/fracture/head/New()
	. = ..()
	if(dents_brain && prob(1))
		name = "dentbrain"
		check_name = "<span class='bone'><B>DENTBRAIN</B></span>"

/datum/wound/fracture/head/on_mob_gain(mob/living/affected)
	. = ..()
	ADD_TRAIT(affected, TRAIT_DISFIGURED, "[type]")
	if(paralysis)
		ADD_TRAIT(affected, TRAIT_NO_BITE, "[type]")
		ADD_TRAIT(affected, TRAIT_PARALYSIS, "[type]")
		if(iscarbon(affected))
			var/mob/living/carbon/carbon_affected = affected
			carbon_affected.update_disabled_bodyparts()
	if(mortal || HAS_TRAIT(affected, RTRAIT_CRITICAL_WEAKNESS))
		affected.death()

/datum/wound/fracture/head/on_mob_loss(mob/living/affected)
	. = ..()
	REMOVE_TRAIT(affected, TRAIT_DISFIGURED, "[type]")
	if(paralysis)
		REMOVE_TRAIT(affected, TRAIT_NO_BITE, "[type]")
		REMOVE_TRAIT(affected, TRAIT_PARALYSIS, "[type]")
		if(iscarbon(affected))
			var/mob/living/carbon/carbon_affected = affected
			carbon_affected.update_disabled_bodyparts()

/datum/wound/fracture/head/on_life()
	. = ..()
	owner.slurring = max(owner.slurring, 5)

/datum/wound/fracture/head/brain
	name = "depressed cranial fracture"
	paralysis = TRUE
	mortal = FALSE
	dents_brain = TRUE

/datum/wound/fracture/head/eyes
	name = "orbital fracture"
	paralysis = TRUE
	mortal = TRUE
	dents_brain = FALSE

/datum/wound/fracture/head/ears
	name = "temporal fracture"
	paralysis = TRUE
	mortal = TRUE
	dents_brain = FALSE

/datum/wound/fracture/head/nose
	name = "nasal fracture"
	paralysis = FALSE
	mortal = FALSE
	dents_brain = FALSE

/datum/wound/fracture/mouth
	name = "mandibular fracture"
	check_name = "<span class='bone'>JAW FRACTURE</span>"
	whp = 100
	sleep_healing = 0

/datum/wound/fracture/mouth/on_mob_gain(mob/living/affected)
	. = ..()
	ADD_TRAIT(affected, TRAIT_NO_BITE, "[type]")
	ADD_TRAIT(affected, TRAIT_GARGLE_SPEECH, "[type]")

/datum/wound/fracture/mouth/on_mob_loss(mob/living/affected)
	. = ..()
	REMOVE_TRAIT(affected, TRAIT_NO_BITE, "[type]")
	REMOVE_TRAIT(affected, TRAIT_GARGLE_SPEECH, "[type]")

/datum/wound/fracture/neck
	name = "cervical fracture"
	check_name = "<span class='bone'><B>CERVICAL FRACTURE</B></span>"
	whp = 100
	sleep_healing = 0

/datum/wound/fracture/neck/on_mob_gain(mob/living/affected)
	. = ..()
	ADD_TRAIT(owner, TRAIT_PARALYSIS, "[type]")
	if(iscarbon(affected))
		var/mob/living/carbon/carbon_affected = affected
		carbon_affected.update_disabled_bodyparts()
	if(HAS_TRAIT(owner, RTRAIT_CRITICAL_WEAKNESS))
		owner.death()

/datum/wound/fracture/neck/on_mob_loss(mob/living/affected)
	. = ..()
	REMOVE_TRAIT(owner, TRAIT_PARALYSIS, "[type]")
	if(iscarbon(affected))
		var/mob/living/carbon/carbon_affected = affected
		carbon_affected.update_disabled_bodyparts()

/datum/wound/fracture/chest
	name = "rib fracture"
	check_name = "<span class='bone'>RIB FRACTURE</span>"
	whp = 50

/datum/wound/fracture/groin
	name = "pelvic fracture"
	check_name = "<span class='bone'>PELVIC FRACTURE</span>"
	whp = 50

/datum/wound/fracture/groin/New()
	. = ..()
	if(prob(1))
		name = "broken buck"
		check_name = "<span class='bone'>BUCKBROKEN</span>"
	
/datum/wound/fracture/groin/on_mob_gain(mob/living/affected)
	. = ..()
	ADD_TRAIT(affected, TRAIT_PARALYSIS_R_LEG, "[type]")
	ADD_TRAIT(affected, TRAIT_PARALYSIS_L_LEG, "[type]")
	if(iscarbon(affected))
		var/mob/living/carbon/carbon_affected = affected
		carbon_affected.update_disabled_bodyparts()

/datum/wound/fracture/groin/on_mob_loss(mob/living/affected)
	. = ..()
	REMOVE_TRAIT(affected, TRAIT_PARALYSIS_R_LEG, "[type]")
	REMOVE_TRAIT(affected, TRAIT_PARALYSIS_L_LEG, "[type]")
	if(iscarbon(affected))
		var/mob/living/carbon/carbon_affected = affected
		carbon_affected.update_disabled_bodyparts()
