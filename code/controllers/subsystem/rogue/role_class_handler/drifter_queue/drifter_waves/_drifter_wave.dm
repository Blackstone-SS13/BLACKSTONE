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

	// How many of each class category type we will attempt to roll
	var/list/advclass_cat_rolls = list(CTAG_PILGRIM = 5, CTAG_ADVENTURER = 5)
	// Whether we bypass the requirements on the advclasses or not
	var/class_cat_alloc_bypass_reqs = FALSE
	// If we are going to plusboost classes
	var/list/class_cat_plusboost_attempts

	// If we are oging to just outright force certain classes into their selection
	var/list/forced_class_additions
	// If we are going to bypass the requirements on forced class additions
	var/forced_class_bypass_reqs = TRUE
	// How many times we are going to plusboost the forced classes
	var/forced_class_plusboost

	// List of landmark types we can place the drifters at/around
	var/list/droppoint_landmark_types = list(
		/obj/effect/landmark/start/adventurerlate
	)

/datum/drifter_wave/proc/pre_drifter_wave()
	var/datum/job/roguetown/target_job = SSjob.GetJob(job_rank)
	target_job.drifter_wave_attachment = src

/datum/drifter_wave/proc/post_drifter_wave()
	var/datum/job/roguetown/target_job = SSjob.GetJob(job_rank)
	target_job.drifter_wave_attachment = null
