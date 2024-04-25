/*
	Ghetto Dyn, although the current mode already tries to be a ghetto dyn
*/
/datum/game_mode/ghetto_dyn
	name = "slopmind"
	config_tag = "slopmind"
	report_type = "slopmind"
	false_report_weight = 0
	required_players = 0
	required_enemies = 0
	recommended_enemies = 0
	enemy_minimum_age = 0

	announce_span = "danger"
	announce_text = "The"

/datum/game_mode/ghetto_dyn/check_finished()
	return TRUE

/datum/game_mode/ghetto_dyn/pre_setup()

	return TRUE

/datum/game_mode/ghetto_dyn/post_setup()
	set waitfor = FALSE

	..()
	//We're not actually ready until all traitors are assigned.
	gamemode_ready = FALSE
	addtimer(VARSET_CALLBACK(src, gamemode_ready, TRUE), 101)
	return TRUE

/datum/game_mode/ghetto_dyn/make_antag_chance(mob/living/carbon/human/character) //klatejoin
	return

