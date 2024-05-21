/datum/wound/cbt
	name = "testicular torsion"
	bleed_rate = 0
	whp = null
	woundpain = 100
	mob_overlay = ""
	sewn_overlay = ""
	can_sew = FALSE
	disabling = TRUE

/datum/wound/cbt/on_bodypart_gain(obj/item/bodypart/affected)
	. = ..()
	if(owner.gender != MALE)
		name = "ovarian torsion"
	else
		name = "testicular torsion"
	owner.emote("groin")
	to_chat(owner, "<span class='danger'>Something twists inside my groin!</span>")
