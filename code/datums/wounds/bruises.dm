/datum/wound/bruise
	name = "hematoma"
	whp = 40
	bleed_rate = 0
	clotting_threshold = null
	sewn_clotting_threshold = null
	woundpain = 10
	can_sew = FALSE

/datum/wound/bruise/small
	name = "bruise"
	bleed_rate = 0
	woundpain = 5

/datum/wound/bruise/large
	name = "massive hematoma"
	bleed_rate = 0.9
	clotting_rate = 0.02
	clotting_threshold = 0.3
	woundpain = 25
