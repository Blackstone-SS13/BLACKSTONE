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

/datum/wound/cbt/smite
	name = "testicular evisceration"
	whp = null

/datum/wound/cbt/smite/on_bodypart_gain(obj/item/bodypart/affected)
	. = ..()
	if(owner.gender != MALE)
		name = "ovarian evisceration"
	else
		name = "testicular evisceration"
