/datum/wound/slash
	name = "slash"
	whp = 50
	sewn_whp = 10
	bleed_rate = 0.4
	sewn_bleed_rate = 0.02
	clotting_rate = 0.02
	sewn_clotting_rate = 0.02
	clotting_threshold = 0.2
	sewn_clotting_threshold = 0.1
	woundpain = 0
	sewn_woundpain = 0
	mob_overlay = "cut"
	can_sew = TRUE
	embeddable = TRUE

/datum/wound/slash/small
	name = "small slash"
	whp = 25
	sewn_whp = 5
	bleed_rate = 0.2
	sewn_bleed_rate = 0.01
	clotting_rate = 0.02
	sewn_clotting_rate = 0.02
	clotting_threshold = 0.1
	sewn_clotting_threshold = 0.05

/datum/wound/slash/large
	name = "gruesome slash"
	whp = 50
	sewn_whp = 10
	bleed_rate = 1
	sewn_bleed_rate = 0.05
	clotting_rate = 0.02
	sewn_clotting_rate = 0.02
	clotting_threshold = 0.4
	sewn_clotting_threshold = 0.1
