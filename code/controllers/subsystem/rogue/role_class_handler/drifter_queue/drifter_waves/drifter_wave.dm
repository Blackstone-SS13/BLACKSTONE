/datum/drifter_wave/drifters
	// Name of the wave to be shown where relevant
	wave_type_name = "Drifters"
	// Maximum playercount of wave
	maximum_playercount = 12
	// Tooltip when moused over on wave
	wave_type_tooltip = "A band of immigrants searching for fortune and fame."
	// Title of the job related to the job subsystem thats being made/equipped towards for the wave
	job_rank = "Drifter"

	wave_delay_time = 2 MINUTES

	// List of landmark types we can place the drifters at/around
	droppoint_landmark_types = list(
		/obj/effect/landmark/start/adventurerlate
	)
