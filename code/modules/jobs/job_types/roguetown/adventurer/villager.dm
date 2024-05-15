/datum/job/roguetown/villager
	title = "Towner"
	flag = ADVENTURER
	department_flag = PEASANTS
	faction = "Station"
	total_positions = 50
	spawn_positions = 50
	allowed_races = list(
		"Humen",
		"Elf",
		"Half-Elf",
		"Dwarf",
		"Tiefling",
		"Argonian",
		"Aasimar",
		"Dark Elf",
		"Half Orc"
	)
	tutorial = "You've lived in this shithole for effectively all your life. You are not an explorer, nor exactly a warrior in many cases. You're just some average poor bastard who thinks they'll be something someday."

	outfit = null
	outfit_female = null
	bypass_jobban = FALSE
	display_order = JDO_VILLAGER
	give_bank_account = TRUE
	min_pq = -15
	max_pq = null
	wanderer_examine = FALSE
	advjob_examine = TRUE

	free_slot_rolls_count = 20


/datum/job/roguetown/villager/after_spawn(mob/living/L, mob/M, latejoin = TRUE)
	..()
	if(L)
		var/mob/living/carbon/human/H = L
		H.advsetup = 1
		H.invisibility = INVISIBILITY_MAXIMUM
		H.become_blind("advsetup")

/*
/datum/job/roguetown/adventurer/villager/New()
	. = ..()
	for(var/X in GLOB.peasant_positions)
		peopleiknow += X
		peopleknowme += X
	for(var/X in GLOB.serf_positions)
		peopleiknow += X
	for(var/X in GLOB.church_positions)
		peopleiknow += X
	for(var/X in GLOB.garrison_positions)
		peopleiknow += X
	for(var/X in GLOB.noble_positions)
		peopleiknow += X*/
