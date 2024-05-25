/datum/wound/artery
	name = "severed artery"
	check_name = "<span class='artery'><B>ARTERY</B></span>"
	whp = 50
	sewn_whp = 20
	bleed_rate = 25
	sewn_bleed_rate = 0.15
	clotting_threshold = null
	sewn_clotting_threshold = null
	woundpain = 100
	sewn_woundpain = 30
	mob_overlay = "s1"
	sewn_overlay = "cut"
	can_sew = TRUE
	sleep_healing = 0
	embed_chance = 75

/datum/wound/artery/throat
	name = "severed carotid"
	check_name = "<span class='artery'><B>CAROTID</B></span>"
	whp = 100
	sewn_whp = 20
	bleed_rate = 50
	sewn_bleed_rate = 0.3
	mob_overlay = "s1_throat"

/datum/wound/artery/throat/on_mob_gain(mob/living/affected)
	. = ..()
	ADD_TRAIT(affected, TRAIT_GARGLE_SPEECH, "[type]")

/datum/wound/artery/throat/on_mob_gain(mob/living/affected)
	. = ..()
	REMOVE_TRAIT(affected, TRAIT_GARGLE_SPEECH, "[type]")

