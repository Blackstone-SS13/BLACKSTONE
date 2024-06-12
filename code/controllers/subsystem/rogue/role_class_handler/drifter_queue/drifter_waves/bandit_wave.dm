/datum/drifter_wave/bandits
	// Name of the wave to be shown where relevant
	wave_type_name = "Bandits"
	// Maximum playercount of wave
	maximum_playercount = 6
	// Tooltip when moused over on wave
	wave_type_tooltip = "One of many wandering tropes in service to the god Mathios."
	// Title of the job related to the job subsystem thats being made/equipped towards for the wave
	job_rank = "Drifter"

	drifter_wave_categories = list(DTAG_BANDITS, DTAG_ANTAGS)
	wave_delay_time = 2 MINUTES

	forced_class_additions = list(/datum/advclass/bandit)
	
	// BUILD THE LIST!
	drifter_dropzone_targets = list()

// Bandits have a special spawn
/datum/drifter_wave/bandits/build_dropzone()
	// This will be full of turfs
	drifter_dropzone_targets = GLOB.bandit_starts

// Idk might as well put them into the list
/datum/drifter_wave/bandits/post_character_handling(mob/living/character)
	var/datum/game_mode/chaosmode/C = SSticker.mode
	if(character && character.mind)
		C.bandits += character.mind

