/datum/wound/cbt
	name = "testicular torsion"
	bleed_rate = 0
	whp = 50
	woundpain = 100
	mob_overlay = ""
	sewn_overlay = ""
	can_sew = FALSE
	disabling = TRUE

/datum/wound/cbt/can_stack_with(datum/wound/other)
	if(istype(other, /datum/wound/cbt))
		return FALSE
	return TRUE

/datum/wound/cbt/on_bodypart_gain(obj/item/bodypart/affected)
	. = ..()
	owner.emote("groin", forced = TRUE)
	owner.Stun(20)
	to_chat(owner, "<span class='userdanger'>Something twists inside my groin!</span>")
	if(owner.gender != MALE)
		name = "ovarian torsion"
	else
		name = "testicular torsion"
	if(HAS_TRAIT(owner, RTRAIT_CRITICAL_WEAKNESS))
		owner.death()

/datum/wound/cbt/on_life()
	. = ..()
	if(!iscarbon(owner))
		return
	var/mob/living/carbon/carbon_owner = owner
	if(!carbon_owner.stat && prob(7))
		carbon_owner.vomit(1, blood = TRUE)

/datum/wound/cbt/smite
	name = "testicular evisceration"
	whp = null

/datum/wound/cbt/smite/on_bodypart_gain(obj/item/bodypart/affected)
	. = ..()
	if(owner.gender != MALE)
		name = "ovarian evisceration"
	else
		name = "testicular evisceration"

/datum/wound/nose
	name = "rhinotomy"
	bleed_rate = 0
	whp = null
	woundpain = 20
	mob_overlay = "cut"
	can_sew = FALSE

/datum/wound/nose/on_bodypart_gain(obj/item/bodypart/affected)
	. = ..()
	ADD_TRAIT(owner, TRAIT_MISSING_NOSE, "[type]")
	ADD_TRAIT(owner, TRAIT_DISFIGURED, "[type]")
	if(HAS_TRAIT(owner, RTRAIT_CRITICAL_WEAKNESS))
		owner.death()

/datum/wound/nose/on_bodypart_loss(obj/item/bodypart/affected)
	. = ..()
	REMOVE_TRAIT(owner, TRAIT_MISSING_NOSE, "[type]")
	REMOVE_TRAIT(owner, TRAIT_DISFIGURED, "[type]")
