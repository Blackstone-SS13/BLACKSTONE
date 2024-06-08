/datum/drifter_wave/drifters
	// Name of the wave to be shown where relevant
	wave_type_name = "Drifters"
	// Maximum playercount of wave
	maximum_playercount = 6
	// Tooltip when moused over on wave
	wave_type_tooltip = "A band of immigrants searching for fame and fortune."
	// Title of the job related to the job subsystem thats being made/equipped towards for the wave
	job_rank = "Drifter"

	advclass_cat_rolls = list(CTAG_PILGRIM = 5, CTAG_ADVENTURER = 5)
	class_cat_plusboost_attempts = list(CTAG_PILGRIM = 3) // Here you go buddy, have a 3 on pilgrims

	wave_delay_time = 2 MINUTES

	// List of landmark types we can place the drifters at/around
	droppoint_landmark_types = list(
		/obj/effect/landmark/start/adventurerlate
	)
