/datum/wound/bite
	name = "bite"
	bleed_rate = 0
	sewn_bleed_rate = 0
	clotting_threshold = null
	sewn_clotting_threshold = null
	whp = 8
	woundpain = 5
	sew_threshold = 50
	can_sew = FALSE
	passive_healing = 1

/datum/wound/bite/bleeding
	name = "bleeding bite"
	whp = 30
	sewn_whp = 15
	bleed_rate = 0.4
	sewn_bleed_rate = 0.04
	woundpain = 10
	sewn_woundpain = 5
	can_sew = TRUE
	passive_healing = 0
