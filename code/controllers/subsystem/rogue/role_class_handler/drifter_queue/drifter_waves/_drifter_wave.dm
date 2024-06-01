/*
	Data object dedicated to holding the relevant data for a drifter wave
*/
/datum/drifter_wave
	// Name of the wave to be shown where relevant
	var/wave_type_name = "ERROR"
	// Maximum playercount of wave
	var/maximum_playercount = 12
	// Tooltip when moused over on wave
	var/wave_type_tooltip = "ERROR: If you see this one report it"
	// Title of the job related to the job subsystem thats being made/equipped towards for the wave
	var/job_rank = "Drifter"

	// List of landmark types we can place the drifters at/around
	var/list/droppoint_landmark_types = list(
		/obj/effect/landmark/start/adventurerlate
	)
